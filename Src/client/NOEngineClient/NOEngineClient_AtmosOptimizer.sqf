// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\host\lang.hpp>

#include "..\..\host\Atmos\Atmos.hpp"
#include "NOEngineClient_NetAtmos.hpp"

namespace(NOEngine.Client.AtmosOptimizer,aopt_cli_)

decl(bool)
aopt_cli_enableSystem = !false;

decl(int)
aopt_cli_handler = -1;
decl(thread_handle)
aopt_cli_thd = threadNull;
decl(float)
aopt_cli_lastUpd = 0;
decl(float)
aopt_cli_prevCallTime =0;

decl(int)
aopt_cli_culledCnt = 0; //отсеченные по видимости на буфере глубины
decl(int)
aopt_cli_gbuffCull = 0; //отсеченные по видимости на буфере геометрии

decl(void())
aopt_cli_process = {
	if !(aopt_cli_enableSystem) exitwith {};

	_dt = tickTime-aopt_cli_lastUpd;
	if (_dt > 0) then {
		aopt_cli_prevCallTime = _dt;
	};
	aopt_cli_lastUpd = tickTime;

	_cnt = 0;
	_gbcnt = 0;

	private _obj = null;
	private _pos = null;
	private _usrPos = asltoatl eyepos player;
	private _usrDir = getCameraViewDirection player;
	private _dist = null;
	_arCenter = (getposatl player) call atmos_getAreaIdByPos;
	_areas = [_arCenter] call atmos_getAroundAreas;
	_buff = [];
	{
		if isNullVar(_x) then {continue};

		private _rg = _x getv(_regions);
		if isNullVar(_rg) then {continue};

		
		{
			{
				_bps = _x getv(batchPos); //centerpos
				//_r = _bps vectorDiff (_x getv(startPos));
				// _ssMin = (_x getv(sizes)) vectorMultiply 0.5 vectorAdd [1,1];
				// _ssMax = _ssMin vectorMultiply -1;
				// _min = [0,0,-0.5] vectorAdd _ssMin;
				// _max = [0,0,0.5] vectorAdd _ssMax;
				(_x getv(sizes)) params ["_sm","_sy"];
				_min = [_sm/2 + 0.5,_sy/2 + 0.5,-0.5];
				_max = [-_sm/2 - 0.5,-_sy/2 - 0.5,0.5];

				_bbd = [_bps,_min,_max] call 
						#ifdef NET_ATMOS_OPTIMIZATION_RENDER_DEBUG
						render_zpass_getBBXInfoVirtual_DEBUG
						#else
						render_zpass_getBBXInfoVirtual_gbuffCheck
						#endif
						;
				if isNullVar(_bbd) then {
					_x callp(setCull,true);
					INC(_gbcnt);
					continue;
				};
				_buff pushBack [_bps distance _usrPos,_bbd,_x];
				
			} foreach _x;
		} foreach (_rg);
	} foreach (_areas apply {[_x] call noe_client_nat_getAreaUnsafe});

	//critical section here no add optimize
	//criticalSectionStart
	[_usrPos,_buff,{
		params ["_reg","_vis"];
		//if !(_reg getv(canUseCullOpt)) exitWith {};
		if (!_vis) then {
			_cnt = _cnt + 1;
		};
		criticalSectionStart
		_reg callp(setCull, !_vis);
		criticalSectionEnd
	}] call render_processZPass;
	//criticalSectionEnd

	aopt_cli_culledCnt = _cnt;
	aopt_cli_gbuffCull = _gbcnt;
	
	#ifdef NET_ATMOS_OPTIMIZATION_RENDER_DEBUG
	uisleep 0.3;
	#endif
};


/*
	! DEBUG !
	! aopt_cli_processZPass is debug function
	! DEBUG !
*/

// Главная функция для сортировки и проверки видимости объектов
decl(void(vector3;vector3;mesh[]))
aopt_cli_processZPass = {
    params ["_cameraPos", "_cameraDir", "_objects"];

	// Функция для вычисления центральной точки bounding box
	private _getCenter = {
		params ["_box"];
		private _minCorner = _box select 0;
		private _maxCorner = _box select 1;
		[
			((_minCorner select 0) + (_maxCorner select 0)) / 2,
			((_minCorner select 1) + (_maxCorner select 1)) / 2,
			((_minCorner select 2) + (_maxCorner select 2)) / 2
		]
	};


    // Массив для хранения объектов с их центрами и проекциями на экран
    private _sortedObjects = [];

    // Проходим по каждому объекту, чтобы вычислить центр, расстояние и проекцию
    {
        private _obj = _x;
        private _bbx = boundingBox _obj;
        private _center = [_bbx] call _getCenter;

        // Преобразуем центр в глобальные координаты
        private _globalCenter = _obj modelToWorld _center;

        // Расстояние до камеры
        private _distanceToCamera = _cameraPos distance _globalCenter;

        // Проецируем bounding box на экран (для всех вершин)
        private _screenProjection = [];
        {
            private _worldPos = _obj modelToWorld _x;
            private _screenPos = worldToScreen _worldPos;
            if !(_screenPos isEqualTo []) then {
                _screenProjection pushBack _screenPos;
            };
        } foreach [
            _bbx select 0, // min corner
            [_bbx select 0 select 0, _bbx select 1 select 1, _bbx select 0 select 2], // mixed corners
            [_bbx select 1 select 0, _bbx select 0 select 1, _bbx select 1 select 2], // etc.
            _bbx select 1 // max corner
        ];

        _sortedObjects pushBack [_distanceToCamera, _screenProjection, _obj];
    } forEach _objects;

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
            if ([_screenProjectionA, _screenProjectionB] call aopt_cli_checkFullOverlap) then {
                _isVisible = false;
                break;
            };
        } forEach _visibleObjects;

        // Установка видимости и добавление в массив видимых объектов
        //_objA callp(setCull, !_isVisible);
		_objA hideObject (!_isVisible);
        if (_isVisible) then {
            _visibleObjects pushBack _x;
        };
    } forEach _sortedObjects;
};

// Функция для проверки перекрытия двух проекций на экране
decl(bool(vector2;vector2))
aopt_cli_checkOverlapWithZone = {
    params ["_screenBoxA", "_screenBoxB"];

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
aopt_cli_checkFullOverlap = {
    params ["_screenBoxA", "_screenBoxB"];
	if (_screenBoxB isEqualTo []) exitWith {true};

    private _minXB = selectMin(_screenBoxB apply { _x select 0 });
    private _maxXB = selectMax(_screenBoxB apply { _x select 0 });
    private _minYB = selectMin(_screenBoxB apply { _x select 1 });
    private _maxYB = selectMax(_screenBoxB apply { _x select 1 });

    // Проверяем, находятся ли все точки из _screenBoxA внутри _screenBoxB
    private _isFullyContained = true;
    {
        private _xA = _x select 0;
        private _yA = _x select 1;

        // Если хотя бы одна точка не внутри _screenBoxB, объект не полностью скрыт
        if (!((_xA >= _minXB) && (_xA <= _maxXB) && (_yA >= _minYB) && (_yA <= _maxYB))) then {
            _isFullyContained = false;
            break;
        };
    } forEach _screenBoxA;

    _isFullyContained;
};

decl(mesh[])
aopt_cli_debug_listobs = [];
decl(thread_handle)
aopt_cli_debug_thread = threadNull;

decl(void())
aopt_cli_testItsc = {
	threadStop(aopt_cli_debug_thread);
	deleteVehicle aopt_cli_debug_listobs;
	private _l = [];
	aopt_cli_debug_listobs = _l;
	_mob = player;
	for "_i" from 1 to 100 do {
		_o = "block_dirt" createVehicleLocal [0,0,0];
		_o setposatl (getposatl _mob vectoradd [rand(-20,20),2 + rand(1,40),7]);
		_o setobjectscale 0.15;
		_o setObjectMaterial [0,"A3\Structures_F\Data\Windows\window_set.rvmat"];
		_l pushback _o;
	};

	{[_x,[1,0,0,1],10] call debug_addRenderObject}foreach _l;

	aopt_cli_debug_lastupd = 0;
	aopt_cli_debug_calltime = 0;
	_td = {
		while{true}do{
			_dt = tickTime-aopt_cli_debug_lastupd;
			if (_dt > 0) then {
				aopt_cli_debug_calltime = _dt;
			};
			aopt_cli_debug_lastupd = tickTime;

			_lst = aopt_cli_debug_listobs;
			_campos = asltoatl eyepos player;
			_camdir = getCameraViewDirection player;
			[_campos,_camdir,_lst] call aopt_cli_processZPass;
		};
	};
	aopt_cli_debug_thread = threadStart(threadNew(_td));
};

// aopt_cli_getNearFar = {
// 	private _usrPos = positionCameraToWorld [0, 0, 0];//asltoatl eyepos player;
// 	private _fov = call aopt_cli_getFOV;
// 	private _scrW = getResolution select 0;
// 	private _scrH = getResolution select 1;
// 	#define radians(x) (x * pi /180)
// 	private _near = (_usrPos select 2) - (_scrH/2)/ (tan(radians(_fov/2)));
// 	_near = _near max 0.1;
// 	private _far = (_usrPos select 2) + (_scrH/2)/ (tan(radians(_fov/2)));
// 	_far = _far max 1000;

// 	[_near,_far]
// };

// aopt_cli_getFOV = {
// 	([0.5, 0.5] distance2D worldToScreen positionCameraToWorld [0, 3, 4]) * (getResolution select 5) / 2
// };


#ifdef NET_ATMOS_OPTIMIZATION_RENDER
_looped = {while {true}do{call aopt_cli_process}};
//aopt_cli_handler = startUpdate(aopt_cli_process,0.1);
aopt_cli_thd = threadStart(threadNew(_looped));
#endif