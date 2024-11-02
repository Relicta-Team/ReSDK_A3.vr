// ======================================================
// Copyright (c) 2017-2024 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include "..\..\host\engine.hpp"

interact_internal_onscreenObjs = [];

interact_addOnScreenCapturedObject = {
	params ["_wobj"];
	if isNullReference(_wobj) exitWith {false};
	interact_internal_onscreenObjs pushBackUnique _wobj;
};

interact_removeOnScreenCapturedObject = {
	params ["_wobj"];
	if isNullReference(_wobj) exitWith {false};
	[interact_internal_onscreenObjs,_wobj] call arrayDeleteItem;	
};

interact_getOnSceenCapturedObject = {
    params [["_isMouseMode",false],["_getRealPtr",true],"_refOutWorldObj"];
    private _ret = null;

	//remove nulls if exists
	private _curObjList = interact_internal_onscreenObjs;
	if array_exists(_curObjList,objNull) then {
		_curObjList = _curObjList - [objNull];
		interact_internal_onscreenObjs = _curObjList;
	};
	
    // Получаем позицию мыши на экране
    private _mousePos = ifcheck(_isMouseMode,getMousePosition,vec2(0.5,0.5));
	private _cpos = positionCameraToWorld[0,0,0];
	
	//sorts near to far
	private _curObjListSorted = [_curObjList,{
		_cpos distance (getposatl _x)
	}] call sortBy;
	//traceformat("sorted %1",_curObjListSorted)

	// Проверка, находится ли точка в квадрате, образованном четырьмя точками
	private _crossProduct = {
		params ["_a", "_b", "_c"];
		((_b select 0) - (_a select 0)) * ((_c select 1) - (_a select 1)) - ((_c select 0) - (_a select 0)) * ((_b select 1) - (_a select 1));
	};
	// Проверка, находится ли мышь в пределах плоскости
	private _isPointInQuadrilateral = {
		params ["_p1", "_p2", "_p3", "_p4"];
		// Вычисляем знаки перекрестных произведений
		private _sign1 = [_p1, _p2, _mousePos] call _crossProduct;
		private _sign2 = [_p2, _p4, _mousePos] call _crossProduct;
		private _sign3 = [_p4, _p3, _mousePos] call _crossProduct;
		private _sign4 = [_p3, _p1, _mousePos] call _crossProduct;

		// Проверка на одну и ту же сторону
		(_sign1 >= 0 && _sign2 >= 0 && _sign3 >= 0 && _sign4 >= 0) || (_sign1 <= 0 && _sign2 <= 0 && _sign3 <= 0 && _sign4 <= 0);
	};

    {
		private _obj = _x;
		(boundingBoxReal _obj) params ["_min", "_max"];

		// Получаем 8 вершин "коробки" объекта
		private _localPoints = [
			[_min select 0, _min select 1, _min select 2], // (xmin, ymin, zmin)
			[_max select 0, _min select 1, _min select 2], // (xmax, ymin, zmin)
			[_min select 0, _max select 1, _min select 2], // (xmin, ymax, zmin)
			[_max select 0, _max select 1, _min select 2], // (xmax, ymax, zmin)
			[_min select 0, _min select 1, _max select 2], // (xmin, ymin, zmax)
			[_max select 0, _min select 1, _max select 2], // (xmax, ymin, zmax)
			[_min select 0, _max select 1, _max select 2], // (xmin, ymax, zmax)
			[_max select 0, _max select 1, _max select 2]  // (xmax, ymax, zmax)
		];

		// Проецируем каждую точку на экран
		private _screenPoints = [];
		private _probScreenPos = null;
		private _checkInside = false;
		{
			_probScreenPos = worldToScreen (_obj modelToWorldVisual _x);
			if (count _probScreenPos == 0) exitWith {_checkInside = true};
			_screenPoints pushBack _probScreenPos;
		} foreach _localPoints;
		
		if (_checkInside) then {
			if ([_cpos,_obj] call model_isPosInsideBBX) then {
				_ret = _obj;
				break;
			} else {
				continue; //object is offscreen
			};
		};

		//traceformat("Screen points: %1", _screenPoints);

		// Проверяем каждую плоскость, образованную четырьмя точками
		if ([_screenPoints select 0, _screenPoints select 1, _screenPoints select 2, _screenPoints select 3] call _isPointInQuadrilateral ||
            [_screenPoints select 4, _screenPoints select 5, _screenPoints select 6, _screenPoints select 7] call _isPointInQuadrilateral ||
            // Левые и правые плоскости
            [_screenPoints select 0, _screenPoints select 1, _screenPoints select 4, _screenPoints select 5] call _isPointInQuadrilateral ||
            [_screenPoints select 2, _screenPoints select 3, _screenPoints select 6, _screenPoints select 7] call _isPointInQuadrilateral ||
			//передние и задние
			[_screenPoints select 0, _screenPoints select 2, _screenPoints select 4, _screenPoints select 6] call _isPointInQuadrilateral ||
			[_screenPoints select 1, _screenPoints select 3, _screenPoints select 5, _screenPoints select 7] call _isPointInQuadrilateral ||

            // Верхние и нижние плоскости
            [_screenPoints select 0, _screenPoints select 2, _screenPoints select 6, _screenPoints select 4] call _isPointInQuadrilateral ||
            [_screenPoints select 1, _screenPoints select 3, _screenPoints select 7, _screenPoints select 5] call _isPointInQuadrilateral)
		exitWith {
			_ret = _obj; // Устанавливаем объект, если мышь внутри плоскости
			// Для отладки
			//traceformat("Found object: %1", _ret);
		};

	} foreach _curObjListSorted;

	if (_getRealPtr && {!isNullVar(_ret)}) then {
		_ret = [_ret,_refOutWorldObj] call noe_client_getPtrInfoNGOSkip;
	};

    _ret
};
