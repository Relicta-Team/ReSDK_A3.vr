// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include "..\..\host\engine.hpp"

namespace(InteractOnScreen,interact_)

decl(any[])
interact_internal_onscreenObjs = [];

decl(void(mesh|actor))
interact_addOnScreenCapturedObject = {
	params ["_wobj"];
	if isNullReference(_wobj) exitWith {false};
	interact_internal_onscreenObjs pushBackUnique _wobj;
};

decl(void(mesh|actor))
interact_removeOnScreenCapturedObject = {
	params ["_wobj"];
	if isNullReference(_wobj) exitWith {false};
	[interact_internal_onscreenObjs,_wobj] call arrayDeleteItem;	
};

decl(any(bool;bool;any))
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

decl(bool(vector3;vector3;vector3;float))
interact_isInSphere = {
	/* --------------------------------------------------------------------------------------------------------------------
		Author:	 	Cre8or
		Description:
			Tests if a ray intersects with the specified sphere.
			If it does, returns an array containing the crossed distance through the sphere, aswell as the distance
			from the ray origin to the surface of the sphere.
			Otherwise, returns [-1, -1].
		Arguments:
			0:	<ARRAY>		The ray's origin
			1:	<ARRAY>		The ray's direction
			2:	<ARRAY>		The sphere's origin
			3:	<NUMBER>	The sphere's radius
		Returns:
			0:	<NUMBER>	The crossed distance through the sphere
			1:	<NUMBER>	The ray origin's distance to the sphere's surface
	-------------------------------------------------------------------------------------------------------------------- */

	//original source: https://github.com/Cre8or/Conquest/blob/64ee50681ced267fcee104c3961801257ecdf3be/scripts/math/fn_math_raySphereIntersection.sqf

	params [["_startPos", []],["_rayDir", []],["_sphPos", []],["_sphereRadius", -1]];

	if (_startPos isEqualTo [] or {_rayDir isEqualTo []} or {_sphPos isEqualTo []} or {_sphereRadius <= 0}) exitWith {[-1, -1]};

	// Define some macros
	macro_const(interact_floatMax)
	#define FLOAT_MAX 3.40282346639e+38 // Using 32-bit floats

	// Set up some variables
	private _offset = _startPos vectorDiff _sphPos;

	private _a = vectorMagnitudeSqr _rayDir;
	private _b = 2 * (_offset vectorDotProduct _rayDir);
	private _c = (vectorMagnitudeSqr _offset) - _sphereRadius ^ 2;
	private _d = _b ^ 2 - (4 * _a * _c);

	// Number of intersections:
	// * 0 when d < 0;
	// * 1 when d = 0 (boundary);
	// * 2 when d > 0;
	// Here we only care about the 2-intersections case
	if (_d <= 0) exitWith {[-1, -1]};

	private _s = sqrt _d;
	private _distToOut = FLOAT_MAX min (-_b + _s) / (2 * _a);

	// If _distToOut is negative, the exit intersection is behind the ray's origin.
	// We treat this case as "no intersection".
	if (_distToOut < 0) exitWith {[-1, -1]};

	private _distToIn = -FLOAT_MAX max ((-_b - _s) / (2 * _a));

	[_distToOut - _distToIn, _distToIn];
};

decl(bool(vector3;float;vector3))
interact_isPointInSphere = {
	params ["_spherePos", "_sphereRadius", "_point"];

	// Проверяем расстояние между точкой и центром сферы
	private _distance = vectorMagnitude (_point vectorDiff _spherePos);

	// Если расстояние меньше или равно радиусу сферы, точка находится внутри
	_distance <= _sphereRadius
};

decl(bool(vector3;vector3;float;vector3))
interact_isPointInCone = {
	params ["_coneStartPos", "_coneEndPos", "_outerAngle", "_point"];

	// Направление и длина конуса
	private _coneDirection = _coneEndPos vectorDiff _coneStartPos;
	private _coneLength = vectorMagnitude _coneDirection;
	private _normConeDirection = vectorNormalized _coneDirection;

	// Вектор от начала конуса до проверяемой точки
	private _pointVector = _point vectorDiff _coneStartPos;
	private _distanceToPoint = vectorMagnitude _pointVector;

	// Проверяем, находится ли точка в пределах длины конуса
	if (_distanceToPoint > _coneLength) exitWith {false};

	// Нормализуем вектор до точки
	private _pointDir = vectorNormalized _pointVector;

	// Угол между направлением конуса и направлением на точку
	private _cosAngle = _normConeDirection vectorDotProduct _pointDir;
	private _cosOuterAngle = cos _outerAngle;

	// Если угол между направлением конуса и точкой меньше внешнего угла, точка в конусе
	_cosAngle >= _cosOuterAngle
};