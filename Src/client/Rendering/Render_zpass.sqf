// ======================================================
// Copyright (c) 2017-2024 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

//возвращает коллекцию информации объектов. 
// list<vec3(distancetocam,list<screenproj>,metaObject)>
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
		_bmax
	];
	_screenProj
};

// Главная функция для сортировки и проверки видимости объектов
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
			if ([_screenProjectionA, _screenProjectionB] call render_zpass_checkOverlapWithZone) then {
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