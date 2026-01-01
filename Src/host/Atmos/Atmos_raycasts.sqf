// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

//for use check object vars and getters
#include "..\oop.hpp"

//режим отладочного отображения сфер
//#define ATMOS_DEBUG_DRAW_INTERSECT_INFO

//#define ATMOS_DEBUG_DRAW_COLLECT_CHUNKS

// генератор лучей для отлова объектов в границах чанка
atmos_getVectorsChunkInfo = {
	private _vectors = [];
	// Центр чанка
	private _center = vec3(ATMOS_SIZE_HALF, ATMOS_SIZE_HALF, ATMOS_SIZE_HALF);
	// Размеры куба
	private _size = ATMOS_SIZE;
    private _halfSize = _size / 2;
    private _points = [
		
		[[0,0,0],[0,_size,0]]
		,[[0,0,0],[0,0,_size]]
		,[[0,_size,_size],[0,_size,0]]
		,[[0,_size,_size],[0,0,_size]]
		//+ in center
		,[[0,_halfSize,0],[0,_halfSize,_size]]
		,[[0,0,_halfSize],[0,_size,_halfSize]]

		//X in center
		,[[0,0,0],[0,_size,_size]]
		,[[0,_size,0],[0,0,_size]]

		//romb
		,[[0,_halfSize,0],[0,_size,_halfSize]]
		,[[0,_size,_halfSize],[0,_halfSize,_size]]
		,[[0,_halfSize,_size],[0,0,_halfSize]]
		,[[0,0,_halfSize],[0,_halfSize,0]]

		//not used
		// ,[[0, 0, 0], [0, _halfSize, _size]]
		// ,[[0,0,0],[0,_size,_halfSize]]
		
	];

	_origPoints = +_points;
	_points append (_origPoints apply {
		[
			[_x select 0,90,2] call BIS_fnc_rotateVector3D,
			[_x select 1,90,2] call BIS_fnc_rotateVector3D
		]
	});

	_points append (_origPoints apply {
		[
			[_x select 1,-90,1] call BIS_fnc_rotateVector3D,
			[_x select 0,-90,1] call BIS_fnc_rotateVector3D
		]
	});

	// /// other side
	_points append (_origPoints apply {
		[
			[(_x select 0) vectordiff [_size,0,0],90,2] call BIS_fnc_rotateVector3D,
			[(_x select 1) vectordiff [_size,0,0],90,2] call BIS_fnc_rotateVector3D
		]
	});

	_points append (_origPoints apply {
		[
			(_x select 0) vectoradd [_size,0,0],
			(_x select 1) vectoradd [_size,0,0]
		]
	});
	
	_points append (_origPoints apply {
		[
			([(_x select 1),-90,1] call BIS_fnc_rotateVector3D)vectoradd [0,0,_size],
			([(_x select 0),-90,1] call BIS_fnc_rotateVector3D)vectoradd [0,0,_size]
		]
	});

	
    _points
};

atmos_const_lineVectors = call atmos_getVectorsChunkInfo;

// получает все объекты, находящиеся в чанке (объекты находящиеся частично в чанке так же будут получены)
atmos_chunkGetNearObjects = {
	params ["_fromCh","_fromChObj"];
	private _baseFromCh = _fromCh;
	_fromCh = _fromCh call atmos_chunkIdToPos; //now chunk is position
	private _collectReal = [];
	
	private _objList = ["IDestructible",_fromCh,
			#ifdef ATMOS_DEBUG_DRAW_NEAROBJECTS
			ATMOS_SIZE*4
			#else
			ATMOS_SIZE*2
			#endif
		,true,true] call getGameObjectOnPosition;

	private _mPos = null;
	{
		if callFunc(_x,isFlying) then {continue};
		if callFunc(_x,isInWorld) then {
			_mPos = callFunc(_x,getModelPosition);
			if ATMOS_POS_INSIDE_CHUNK(_mPos,_fromCh) then {
				_collectReal pushBack _x;
				getVar(_x,__atm_ownerChunks) set [_baseFromCh,_fromChObj];
			};
		};
	} forEach(_objList);

	//тут точно объекты с моделями (isinworld и не летящие т.к. у них нет геометрии)
	{
		if isTypeOf(_x,BasicMob) then {continue};

		_collectReal pushBackUnique _x;
		getVar(_x,__atm_ownerChunks) set [_baseFromCh,_fromChObj];
	} foreach ([_baseFromCh] call atmos_getObjectsInChunk);

	_collectReal
};

// собирает объекты попавшие в границы чанка. бросает (count atmos_const_lineVectors) на каждой грани для поиска объектов
atmos_getObjectsInChunk = {
	params ["_fromCh"];
	_fromCh = _fromCh call atmos_chunkIdToPos; //now chunk is center position

	private _startPosReal = _fromCh vectorDiff vec3(ATMOS_SIZE_HALF,ATMOS_SIZE_HALF,ATMOS_SIZE_HALF);
	private _objMap = createHashMap;
	private _tList = [];

	private _vectors = atmos_const_lineVectors; //call atmos_getVectorsChunkInfo;
	private _startPos = null; private _endPos = null;
	{
		_x params ["_vs","_ve"];
		_startPos = _startPosReal vectorAdd _vs;
		_endPos = _startPosReal vectorAdd _ve;
		_tList = [_startPos,_endPos,objNull,objNull,2,null,true] call si_getIntersectObjects;
		{
			if !isNullReference(_x) then {
				_objMap set [getVar(_x,pointer),_x];
			};
		false}count _tList;

	} foreach _vectors;

	values _objMap
};


// расширенное количество отбрасываемых лучей
#define ATMOS_EXTENDED_INTERSECTION_COUNT

// возвращает точки входа и конца пересечений. данная функция используется для запроса пересечений
atmos_getIntersectPosList = {
	params ["_chId","_side",["_fromPos",true]];
	if (_fromPos) then {
		_chId = _chId call atmos_chunkPosToId;
	};

	//center pos of current chunk
	private _pos = _chId call atmos_chunkIdToPos;
	_pos params ["_pX","_pY","_pZ"];
	_side params ["_ofsX","_ofsY","_ofsZ"];
	//edge center startpos
	private _p1S = [_pX+(_ofsX*ATMOS_SIZE_HALF),_pY+(_ofsY*ATMOS_SIZE_HALF),_pZ+(_ofsZ*ATMOS_SIZE_HALF)];
	_p1S params ["_p1X","_p1Y","_p1Z"];

	private ["_p2S","_p3S","_p4S","_p5S"];
	private _halfSize = ATMOS_SIZE_HALF-ATMOS_SIZE_HALF_OFFSET; //небольшой оффсет для решения возможной проблемы миссов чанка
	
	#ifdef ATMOS_EXTENDED_INTERSECTION_COUNT
		private _half2Size = ATMOS_SIZE_HALF/2-ATMOS_SIZE_HALF_OFFSET;
		private ["_p6E","_p7E","_p8E","_p9E"];
	#endif

	if (_ofsX != 0) then {
		_p2S = [_p1X, _p1Y + _halfSize, _p1Z + _halfSize];
		_p3S = [_p1X, _p1Y - _halfSize, _p1Z + _halfSize];
		_p4S = [_p1X, _p1Y + _halfSize, _p1Z - _halfSize];
		_p5S = [_p1X, _p1Y - _halfSize, _p1Z - _halfSize];
		
		#ifdef ATMOS_EXTENDED_INTERSECTION_COUNT
		_p6E = [_p1X+(_ofsX*ATMOS_SIZE), _p1Y + _half2Size+(_ofsY*ATMOS_SIZE), _p1Z + _half2Size+(_ofsZ*ATMOS_SIZE)];
		_p7E = [_p1X+(_ofsX*ATMOS_SIZE), _p1Y - _half2Size+(_ofsY*ATMOS_SIZE), _p1Z + _half2Size+(_ofsZ*ATMOS_SIZE)];
		_p8E = [_p1X+(_ofsX*ATMOS_SIZE), _p1Y + _half2Size+(_ofsY*ATMOS_SIZE), _p1Z - _half2Size+(_ofsZ*ATMOS_SIZE)];
		_p9E = [_p1X+(_ofsX*ATMOS_SIZE), _p1Y - _half2Size+(_ofsY*ATMOS_SIZE), _p1Z - _half2Size+(_ofsZ*ATMOS_SIZE)];
		#endif
	} else {
		if (_ofsY != 0) then {
			_p2S = [_p1X + _halfSize, _p1Y, _p1Z + _halfSize];
			_p3S = [_p1X - _halfSize, _p1Y, _p1Z + _halfSize];
			_p4S = [_p1X + _halfSize, _p1Y, _p1Z - _halfSize];
			_p5S = [_p1X - _halfSize, _p1Y, _p1Z - _halfSize];
			
			#ifdef ATMOS_EXTENDED_INTERSECTION_COUNT
			_p6E = [_p1X + _half2Size+(_ofsX*ATMOS_SIZE), _p1Y+(_ofsY*ATMOS_SIZE), _p1Z + _half2Size+(_ofsZ*ATMOS_SIZE)];
			_p7E = [_p1X + _half2Size+(_ofsX*ATMOS_SIZE), _p1Y+(_ofsY*ATMOS_SIZE), _p1Z - _half2Size+(_ofsZ*ATMOS_SIZE)];
			_p8E = [_p1X - _half2Size+(_ofsX*ATMOS_SIZE), _p1Y+(_ofsY*ATMOS_SIZE), _p1Z + _half2Size+(_ofsZ*ATMOS_SIZE)];
			_p9E = [_p1X - _half2Size+(_ofsX*ATMOS_SIZE), _p1Y+(_ofsY*ATMOS_SIZE), _p1Z - _half2Size+(_ofsZ*ATMOS_SIZE)];
			#endif
		} else {
			if (_ofsZ != 0) then {
				
				_p2S = [_p1X + _halfSize, _p1Y + _halfSize, _p1Z];
				_p3S = [_p1X - _halfSize, _p1Y + _halfSize, _p1Z];
				_p4S = [_p1X + _halfSize, _p1Y - _halfSize, _p1Z];
				_p5S = [_p1X - _halfSize, _p1Y - _halfSize, _p1Z];

				#ifdef ATMOS_EXTENDED_INTERSECTION_COUNT
				_p6E = [_p1X + _half2Size+(_ofsX*ATMOS_SIZE), _p1Y + _half2Size+(_ofsY*ATMOS_SIZE), _p1Z+(_ofsZ*ATMOS_SIZE)];
				_p7E = [_p1X + _half2Size+(_ofsX*ATMOS_SIZE), _p1Y - _half2Size+(_ofsY*ATMOS_SIZE), _p1Z+(_ofsZ*ATMOS_SIZE)];
				_p8E = [_p1X - _half2Size+(_ofsX*ATMOS_SIZE), _p1Y + _half2Size+(_ofsY*ATMOS_SIZE), _p1Z+(_ofsZ*ATMOS_SIZE)];
				_p9E = [_p1X - _half2Size+(_ofsX*ATMOS_SIZE), _p1Y - _half2Size+(_ofsY*ATMOS_SIZE), _p1Z+(_ofsZ*ATMOS_SIZE)];
				#endif
			};
		};
	};

	private _p1E = [_p1X+(_ofsX*ATMOS_SIZE),_p1Y+(_ofsY*ATMOS_SIZE),_p1Z+(_ofsZ*ATMOS_SIZE)];
	private _p2E = [(_p2S select 0) +(_ofsX*ATMOS_SIZE),(_p2S select 1)+(_ofsY*ATMOS_SIZE),(_p2S select 2)+(_ofsZ*ATMOS_SIZE)];
	private _p3E = [(_p3S select 0) +(_ofsX*ATMOS_SIZE),(_p3S select 1)+(_ofsY*ATMOS_SIZE),(_p3S select 2)+(_ofsZ*ATMOS_SIZE)];
	private _p4E = [(_p4S select 0) +(_ofsX*ATMOS_SIZE),(_p4S select 1)+(_ofsY*ATMOS_SIZE),(_p4S select 2)+(_ofsZ*ATMOS_SIZE)];
	private _p5E = [(_p5S select 0) +(_ofsX*ATMOS_SIZE),(_p5S select 1)+(_ofsY*ATMOS_SIZE),(_p5S select 2)+(_ofsZ*ATMOS_SIZE)];

	[[_p1S,_p2S,_p3S,_p4S,_p5S
		#ifdef ATMOS_EXTENDED_INTERSECTION_COUNT
		,_p2S,_p3S,_p4S,_p5S //additional
		,_p1S,_p1S,_p1S,_p1S
		#endif
	],[_p1E,_p5E,_p4E,_p3E,_p2E //я инверснул конечные точки с 2 по 4 чтобы был захват большей площади
		#ifdef ATMOS_EXTENDED_INTERSECTION_COUNT
		,_p2E,_p3E,_p4E,_p5E //additional
		,_p6E,_p7E,_p8E,_p9E
		#endif
	]];
};


/* 
	Возвращает информацию по пересечениям в соседнем чанке
	Доступные режимы запросов (_searchMode)
		ATMOS_SEARCH_MODE_GET_COUNT - получение количества пересечений объектов
		ATMOS_SEARCH_MODE_FIRST_INTERSECT - поиск наличия хотя бы одного пересечения
		ATMOS_SEARCH_MODE_NO_INTERSECT - поиск отсутствия пересечений
		ATMOS_SEARCH_MODE_GET_VOBJECTS - получение пересечений в виде массива виртуальных объектов
*/
atmos_getIntersectInfo = {
	params ["_fromCh","_side",["_searchMode",ATMOS_SEARCH_MODE_GET_COUNT],"_refOutPos"];

	private _posQuery = [_fromCh,_side,false] call atmos_getIntersectPosList;
	private _srcPosList = _posQuery select 0;
	private _destPosList = _posQuery select 1;
	
	private _canSetRefOut = !isNullVar(_refOutPos);
	private _rayResult = null;

	#ifdef ATMOS_DEBUG_DRAW_INTERSECT_INFO
		if !isNull(atmos_debug_list_giiSpheres) then {
			{deleteVehicle _x} foreach atmos_debug_list_giiSpheres;
		};
		atmos_debug_list_giiSpheres = [];
		private _valueSetupGet = false;

		#define ATMOS_DEBUG_DRAW_INTERSECT_SPHERE _qResult = ([_x arg _destPosList select _foreachIndex] call si_getIntersectData); \
		if !isNullReference(_qResult select 0) then { \
			__ATMOS_DEBUG_SPHERE_INIT(1,0,0) \
		} else { \
			__ATMOS_DEBUG_SPHERE_INIT(0,1,0) \
		};

		#define __ATMOS_DEBUG_SPHERE_INIT(r,g,b) private _s = ATMOS_DEBUG_CREATE_SPHERE(r,g,ifcheck(_foreachIndex==0,1,b)); atmos_debug_list_giiSpheres pushBack _s; \
			_s setposatl _x; _s setvariable ["__index",_foreachIndex]; \
			_s = ATMOS_DEBUG_CREATE_SPHERE(r,g,b); atmos_debug_list_giiSpheres pushBack _s; \
			_s setposatl ifcheck((_qResult select 1)isequalto vec3(0,0,0),_destPosList select _foreachIndex,_qResult select 1); \
			_s setvariable ["__index",_foreachIndex];

		#define exitMethod then
		#define setupValue(v) if (!_valueSetupGet) then {v}
		
	#else
		#define ATMOS_DEBUG_DRAW_INTERSECT_SPHERE
		#define exitMethod exitWith
		#define setupValue(v) v
	#endif

	//==========================================================
	// ================== Query process ========================
	//==========================================================
	if (_searchMode==ATMOS_SEARCH_MODE_GET_VOBJECTS) exitWith {
		private _listRet = [];
		{
			ATMOS_DEBUG_DRAW_INTERSECT_SPHERE
			_rayResult = [_x, _destPosList select _foreachIndex] call si_getIntersectData;
			if !isNullReference(_rayResult select 0) then {
				_listRet pushBack ([_rayResult select 0]call si_handleObjectReturnCheckVirtual);
			};
		} foreach _srcPosList;
		_listRet
	};

	if (_searchMode == ATMOS_SEARCH_MODE_GET_COUNT) then {
		private _retCount = 0;
		private _outvar = ifcheck(_canSetRefOut,[],null);
		{
			ATMOS_DEBUG_DRAW_INTERSECT_SPHERE
			_rayResult = [_x, _destPosList select _foreachIndex] call si_getIntersectData;
			if !isNullReference(_rayResult select 0) then {
				INC(_retCount);
				if (_canSetRefOut) then {_outvar pushBack (_rayResult select vec2(0,2))}
			};
		} foreach _srcPosList;
		if (_canSetRefOut) then {refset(_refOutPos,_outvar)};
		_retCount;
	} else {
		if (_searchMode == ATMOS_SEARCH_MODE_FIRST_INTERSECT) then {
			private _bRet = false;
			{
				ATMOS_DEBUG_DRAW_INTERSECT_SPHERE
				_rayResult = [_x, _destPosList select _foreachIndex] call si_getIntersectData;
				if !isNullReference(_rayResult select 0) exitMethod {setupValue(_bRet = true; if (_canSetRefOut) then {refset(_refOutPos,_rayResult select vec2(0,2))})};
			} foreach _srcPosList;
			_bRet
		} else {
			assert_str(_searchMode==ATMOS_SEARCH_MODE_NO_INTERSECT,format vec2("Unkown search mode enum %1",_searchMode));

			private _bRet = false;
			{
				ATMOS_DEBUG_DRAW_INTERSECT_SPHERE
				_rayResult = [_x, _destPosList select _foreachIndex] call si_getIntersectData;
				if isNullReference(_rayResult select 0) exitMethod {
					setupValue(_bRet = true; if (_canSetRefOut) then {refset(_refOutPos,_rayResult select vec2(0,2))});
				};
			} foreach _srcPosList;

			_bRet
		};
	};
};

/* 
	получение чанков/позиций чанков, которыми владеет этот объект
	! Внимание - для больших объектов процедура может занять некоторе время
*/
atmos_getObjectOwnedChunks = {
	params ["_obj",["_retChObj",false],["_retOnlyExists",false]];
	private _visObj = callFunc(_obj,getBasicLoc);
	private _bbx = boundingBoxReal [_visObj,"Geometry"];
	private _posMin = (_visObj modelToWorldVisual (_bbx select 0));
	private _posMax = (_visObj modelToWorldVisual (_bbx select 1));

	/*
		1. получаем 2 позиции modeltoworldvisal от bbx смещения
		2. строим 2 вектора - минимальный и максимальный
		3. конвертим векторы в позиции чанков
		3. стандартный перебор по трехмерному вектору
	*/

	private _coordList = [];
	#define NORMALIZE_VEC(l,r,i) ifcheck((l select i)>(r select i),vec2(r select i call atmos_coordToId,l select i call atmos_coordToId),vec2(l select i call atmos_coordToId,r select i call atmos_coordToId))
	
	NORMALIZE_VEC(_posMin,_posMax,0) params ["_sX","_eX"];
	NORMALIZE_VEC(_posMin,_posMax,1) params ["_sY","_eY"];
	NORMALIZE_VEC(_posMin,_posMax,2) params ["_sZ","_eZ"];
	#undef NORMALIZE_VEC
	private _chid = null;
	private _algGet = if (_retChObj) then {
		if (_retOnlyExists) then {
			{
				_chid = [[_x,_y,_z]] call atmos_getChunkAtChIdUnsafe;
				if !isNullVar(_chid) then {
					_coordList pushBack _chid;
				};
			}
		} else {
			{
				_coordList pushBack ([[_x,_y,_z]] call atmos_getChunkAtChId);
			}
		};
		
	} else {
		{_coordList pushBack [_x,_y,_z]}
	};

	for "_x" from _sX to _eX step ATMOS_SIZE do {
		for "_y" from _sY to _eY step ATMOS_SIZE do {
			for "_z" from _sZ to _eZ step ATMOS_SIZE do _algGet;
		};
	};
	

	#ifdef ATMOS_DEBUG_DRAW_COLLECT_CHUNKS
	if !isNull(atmos_debug_getobjownch_list_arrows) then {
		{deletevehicle _x} foreach atmos_debug_getobjownch_list_arrows;
	};
	atmos_debug_getobjownch_list_arrows = [];
	if (!_retChObj) then {
		{
			private _pObj = _x ;//call atmos_chunkIdToPos;
			_o = [1,ifcheck(_foreachIndex in [0 arg count _coordList-1],0,1),0] call atmos_debug_createSphere;
			_o setposatl (_pObj call atmos_chunkIdToPos);
			atmos_debug_getobjownch_list_arrows pushBack _o;
		} foreach _coordList;
	};

	#endif

	_coordList;
};
