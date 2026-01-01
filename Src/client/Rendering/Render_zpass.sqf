// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\host\lang.hpp>

namespace(Rendering.Occlusion,render_)

//#define RENDER_ZPASS_ENABLE_ADDITIONAL_BBX

//возвращает коллекцию информации объектов. 
// list<vec3(distancetocam,list<screenproj>,metaObject)>
decl(any[](vector3;mesh[]))
render_zpass_getObjBBX = {
	params ["_cameraPos","_objlist"];
	private _sortedObjects = [];
	// Проходим по каждому объекту, чтобы вычислить центр, расстояние и проекцию
	{
		private _obj = _x;
		private _bbx = boundingBox _obj;

		// Преобразуем центр в глобальные координаты
		private _globalCenter = _obj modelToWorld [0,0,0];

		// Расстояние до камеры
		private _distanceToCamera = _cameraPos distance _globalCenter;

		_bbx params ["_bmin","_bmax"];
		// Проецируем bounding box на экран (для всех вершин)
		private _screenProjection = [];
		{
			private _worldPos = _obj modelToWorld _x;
			private _screenPos = worldToScreen _worldPos;
			if !(_screenPos isEqualTo []) then {
				_screenProjection pushBack _screenPos;
			};
		} foreach [
			_bmin, // min corner
			[_bmin select 0, _bmax select 1, _bmin select 2], // mixed corners
			[_bmax select 0, _bmin select 1, _bmax select 2], // etc.
			_bmax // max corner
		];

		_sortedObjects pushBack [_distanceToCamera, _screenProjection, _obj];
	} forEach _objlist;

	_sortedObjects
};

decl(vector2[](vector3;vector3;vector3))
render_zpass_getBBXInfoVirtual = {
	params ["_psCenter","_bmin","_bmax"];
	private _screenProj = [];
	private _wpos = null;
	private _sp = null;
	{
		_wpos = _psCenter vectorAdd _x;
		_sp = worldToScreen _wpos;
		if !(_sp isEqualTo []) then {
			_screenProj pushBack _sp;
		};
	} foreach [
		_bmin,
		[_bmin select 0, _bmax select 1, _bmin select 2],
		[_bmax select 0, _bmin select 1, _bmax select 2],
		
		#ifdef RENDER_ZPASS_ENABLE_ADDITIONAL_BBX
		[_bmax select 0, _bmax select 1, _bmin select 2],
		[_bmin select 0, _bmax select 1, _bmax select 2],

		[_bmin select 0, _bmin select 1, _bmax select 2],
		[_bmax select 0, _bmin select 1, _bmin select 2],
		#endif

		_bmax
	];
	_screenProj
};

decl(NULL|vector2[](vector3;vector3;vector3))
render_zpass_getBBXInfoVirtual_gbuffCheck = {
	params ["_psCenter","_bmin","_bmax"];
	private _screenProj = [];
	private _wpos = null;
	private _sp = null;
	private _sideIterCount = 0;
	{
		_wpos = _psCenter vectorAdd _x;
		if (([_wpos] call interact_getIntersectionCount) > 0) then {
			INC(_sideIterCount);
		};
		_sp = worldToScreen _wpos;
		if !(_sp isEqualTo []) then {
			_screenProj pushBack _sp;
		};
	} foreach [
		_bmin,
		[_bmin select 0, _bmax select 1, _bmin select 2],
		[_bmax select 0, _bmin select 1, _bmax select 2],
		
		#ifdef RENDER_ZPASS_ENABLE_ADDITIONAL_BBX
		[_bmax select 0, _bmax select 1, _bmin select 2],
		[_bmin select 0, _bmax select 1, _bmax select 2],

		[_bmin select 0, _bmin select 1, _bmax select 2],
		[_bmax select 0, _bmin select 1, _bmin select 2],
		#endif

		_bmax
	];
	if (_sideIterCount >= 
		#ifdef RENDER_ZPASS_ENABLE_ADDITIONAL_BBX
		6
		#else
		3
		#endif
	) exitWith {null};
	_screenProj
};

//функция возвращает процентное значение видимости бокса
decl(bool(vector3;vector3;vector3;int))
render_gbuffCheck_photonVisPrc = {
	params ["_psCenter","_bmin","_bmax",["_lbIC",0]];
	private _wpos = null;
	private _sp = null;
	private _baseVecs = [
		_psCenter,
		
		_bmin,
		[_bmin select 0, _bmax select 1, _bmin select 2],
		[_bmax select 0, _bmin select 1, _bmax select 2],
		
		//#ifdef RENDER_ZPASS_ENABLE_ADDITIONAL_BBX
		[_bmax select 0, _bmax select 1, _bmin select 2],
		[_bmin select 0, _bmax select 1, _bmax select 2],

		[_bmin select 0, _bmin select 1, _bmax select 2],
		[_bmax select 0, _bmin select 1, _bmin select 2],
		//#endif

		_bmax
	];

	private _canSee = false;
	private _maxCnt = count _baseVecs;
	private _curIts = 0;
	private _cps = positionCameraToWorld[0,0,0];
	private _posesDist = [];
	{
		_wpos = _psCenter vectorAdd _x;
		if (([_wpos] call interact_getIntersectionCount) <= _lbIC) exitWith {
			_canSee = true;
		};
		_posesDist pushBack [_wpos distance _cps,_wpos,_x];
	} foreach _baseVecs;
	
	_canSee
};

decl(map<vector3;struct_t.AutoModelPtr>)
render_zpass_cachePositions = createhashMap;

decl(vector2[](vector3;vector3;vector3))
render_zpass_getBBXInfoVirtual_DEBUG = {
	params ["_psCenter","_bmin","_bmax"];
	traceformat("ps:%1; bmin:%2; bmax:%3",_psCenter arg _bmin arg _bmax)
	if isNull(render_zpass_cachePositions) then {
		render_zpass_cachePositions = createHashMap;
	};
	private _screenProj = [];
	private _wpos = null;
	private _sp = null;
	{
		_wpos = _psCenter vectorAdd _x;
		if !(_wpos in render_zpass_cachePositions) then {
			private _s = "Sign_Sphere10cm_F" createVehicleLocal [0,0,0];
			_s setObjectTexture [0,"#(rgb,8,8,3)color(1,0,0,1)"];
			_s setposatl _wpos;
			render_zpass_cachePositions set [_wpos,struct_newp(AutoModelPtr,_s)];
		};	
		_sp = worldToScreen _wpos;
		if !(_sp isEqualTo []) then {
			_screenProj pushBack _sp;
		};
	} foreach [
		_bmin,
		[_bmin select 0, _bmax select 1, _bmin select 2],
		[_bmax select 0, _bmin select 1, _bmax select 2],
		
		#ifdef RENDER_ZPASS_ENABLE_ADDITIONAL_BBX
		[_bmax select 0, _bmax select 1, _bmin select 2],
		[_bmin select 0, _bmax select 1, _bmax select 2],

		[_bmin select 0, _bmin select 1, _bmax select 2],
		[_bmax select 0, _bmin select 1, _bmin select 2],
		#endif

		_bmax
	];
	_screenProj
};

// Главная функция для сортировки и проверки видимости объектов
decl(void(vector3;any[];any))
render_processZPass = {
	params ["_cameraPos", "_sortedObjects","_pipelineFnc"];

	// Массив для хранения объектов с их центрами и проекциями на экран
	//! эта функция должна вызываться снаружи для предоставления потока данных с projinfo
	//private _sortedObjects = [_cameraPos,_objects] call render_zpass_getObjBBX;

	// Сортировка объектов по расстоянию до камеры
	_sortedObjects sort true;

	// Массив для отслеживания видимых объектов (проекции на экране)
	private _visibleObjects = [];

	// Проверка наложений и скрытия объектов
	{
		private _dist = _x select 0;
		private _screenProjectionA = _x select 1;
		private _objA = _x select 2;
		private _isVisible = true;

		// Проверка перекрытия текущего объекта уже видимыми объектами
		{
			private _screenProjectionB = _x select 1;

			// Проверка на пересечение проекций bounding box
			if ([_screenProjectionA, _screenProjectionB] call render_zpass_checkFullOverlap) then {
				_isVisible = false;
				break;
			};
		} forEach _visibleObjects;

		// Установка видимости и добавление в массив видимых объектов
		//_objA callp(setCull, !_isVisible);
		//_objA hideObject (!_isVisible);
		[_objA,_isVisible] call _pipelineFnc;
		if (_isVisible) then {
			_visibleObjects pushBack _x;
		};
	} forEach _sortedObjects;
};

// Функция для проверки перекрытия двух проекций на экране
decl(bool(vector2;vector2))
render_zpass_checkOverlapWithZone = {
	params ["_screenBoxA", "_screenBoxB"];
	if (_screenBoxA isEqualTo []) exitWith {true};
	if (_screenBoxB isEqualTo []) exitWith {true};
	//OBSOLETE(render::zpass::checkOverlapWithZone);

	private _minXA = selectMin(_screenBoxA apply { _x select 0 });
	private _maxXA = selectMax(_screenBoxA apply { _x select 0 });
	private _minYA = selectMin(_screenBoxA apply { _x select 1 });
	private _maxYA = selectMax(_screenBoxA apply { _x select 1 });

	private _minXB = selectMin(_screenBoxB apply { _x select 0 });
	private _maxXB = selectMax(_screenBoxB apply { _x select 0 });
	private _minYB = selectMin(_screenBoxB apply { _x select 1 });
	private _maxYB = selectMax(_screenBoxB apply { _x select 1 });

	// Проверка на пересечение: возвращает true, если экраны перекрываются
	!((_maxXA < _minXB) || (_minXA > _maxXB) || (_maxYA < _minYB) || (_minYA > _maxYB));
};

decl(bool(vector2;vector2))
render_zpass_checkFullOverlap = {
	params ["_screenBoxA", "_screenBoxB"];
	if (_screenBoxB isEqualTo []) exitWith {true};

	private _minXB = selectMin(_screenBoxB apply { _x select 0 });
	private _maxXB = selectMax(_screenBoxB apply { _x select 0 });
	private _minYB = selectMin(_screenBoxB apply { _x select 1 });
	private _maxYB = selectMax(_screenBoxB apply { _x select 1 });

	// Проверяем, находятся ли все точки из _screenBoxA внутри _screenBoxB
	private _isFullyContained = true;
	{
		_x params ["_xA","_yA"];

		// Если хотя бы одна точка не внутри _screenBoxB, объект не полностью скрыт
		if (!((_xA >= _minXB) && (_xA <= _maxXB) && (_yA >= _minYB) && (_yA <= _maxYB))) then {
			_isFullyContained = false;
			break;
		};
	} forEach _screenBoxA;

	_isFullyContained;
};