// ======================================================
// Copyright (c) 2017-2024 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

/*
	Atmos system for area effects


	TODO:
		- регистрация атмосферного чанка по мировой позиции
		- позиционирование чанка
			- получить позиции граней чанка
			- отладочные сферы для визуализации
			- математическая функция получения позиций текущего и соседнего чанка

	howto:
		Чанки обрабатываются каждый цикл симуляции
		типы эффектов могут распространяться по соседним чанкам
		типы распространения:
			- объектный (прим. огонь) - распространение производится по объектам в соседних чанках
			- атмосферный (прим. дым) - распространение производится по соседним чанкам если на пересечении нет объектов

		для распространения для обеих типов используется следующий алгоритм:
			из исходной клайней плоскости чанка (5 точек) кидаются перпендикулярные лучи в дальнюю плоскость соседнего чанка
			количество лучей дошедших до конечной точки является результатом может ли распространиться эффект

		при распространении на соседний чанк добавляется эффект с пониженной силой.
		эффект огня подпитывает сгорание объектов в этом чанке

*/

#include "..\engine.hpp"
#include "..\oop.hpp"
#include "..\GameObjects\GameConstants.hpp"
#include "Atmos.h"
#include "Atmos.hpp"
#include "Atmos_debug.sqf"
#include "Atmos_ChunkStruct.sqf"

#ifdef EDITOR
	if !isNull(atmos_map_chunks) then {
		{delete(_x)} foreach (values atmos_map_chunks);
	};
	if !isNull(atmos_handle_update) then {stopUpdate(atmos_handle_update)};
#endif

atmos_map_chunks = createHashMap; //key:str(chunkloc) -> value(object:AtmosChunk)
atmos_handle_update = -1;

//получает все объекты, находящиеся в чанке
atmos_chunkGetNearObjects = {
	params ["_fromCh"];
	private _baseFromCh = _fromCh;
	_fromCh = _fromCh call atmos_chunkIdToPos; //now chunk is position
	private _collectReal = [];
	
	#ifdef ATMOS_DEBUG_DRAW_NEAROBJECTS
		if !isNull(atmos_debug_list_chgno) then {
			{deleteVehicle _x} foreach atmos_debug_list_chgno;
		};
		private _olist = [];
		atmos_debug_list_chgno = _olist;
	#endif
	
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
		#ifdef ATMOS_MODE_SIMPLE_VISUALIZATION
			if isTypeOf(_x,AtmosChunk) then {continue};
		#else
			if isTypeOf(_x,AtmosAreaBase) then {continue};//no affect to area
		#endif
		if callFunc(_x,isInWorld) then {
			_mPos = callFunc(_x,getModelPosition);
			if ATMOS_POS_INSIDE_CHUNK(_mPos,_fromCh) then {
				_collectReal pushBack _x;
			};

			#ifdef ATMOS_DEBUG_DRAW_NEAROBJECTS
				_inarea = ATMOS_POS_INSIDE_CHUNK(_mPos,_fromCh);
				_osphere = ifcheck(_inarea, ATMOS_DEBUG_CREATE_SPHERE(0,1,0), ATMOS_DEBUG_CREATE_SPHERE(1,0,0));
				_osphere setvariable ["__objectRef",_x];
				_osphere setvariable ["__inArea",_inarea];
				_osphere setvariable ["__distance",_mPos distance _fromCh]; 
				_olist pushBack _osphere;
				_osphere setposatl _mPos;
				
			#endif
		};
	}forEach(_objList);

	//тут точно объекты с моделями (isinworld и не летящие т.к. у них нет геометрии)
	{
		if isTypeOf(_x,BasicMob) then {continue};

		_collectReal pushBackUnique _x;
	} foreach ([_baseFromCh] call atmos_getObjectsInChunk);

	_collectReal
};

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

	//?!fuck sqfvm...
	#ifndef _SQFVM
	_points append (_origPoints apply {
		[
			([(_x select 1),-90,1] call BIS_fnc_rotateVector3D)vectoradd [0,0,_size],
			([(_x select 0),-90,1] call BIS_fnc_rotateVector3D)vectoradd [0,0,_size]
		]
	});
	#endif

	
    _points
};

atmos_const_lineVectors = call atmos_getVectorsChunkInfo;



atmos_getObjectsInChunk = {
	params ["_fromCh"];
	/*
		1. get line
	*/
	_fromCh = _fromCh call atmos_chunkIdToPos; //now chunk is center position
	#ifdef ATMOS_DEBUG_DRAW_CHUNKOBJECTS
	
	{deleteVehicle _x} foreach atmos_debug_list_goic;
	atmos_debug_list_goic = [];
	atmos_debug_list_goicSposes = [];
	#endif

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
			if !isNullReference(_x) then { //TODO detect why some objects was nullPtr
				_objMap set [getVar(_x,pointer),_x];
			};
		false}count _tList;

		#ifdef ATMOS_DEBUG_DRAW_CHUNKOBJECTS
		_s = ATMOS_DEBUG_CREATE_SPHERE(0,1,1);
		_s setposatl _startPos; _s setvariable ["_vec",_vs];
		atmos_debug_list_goic pushBack _s;
		_s = ATMOS_DEBUG_CREATE_SPHERE(0,1,0);
		_s setposatl _endPos; _s setvariable ["_vec",_ve];
		atmos_debug_list_goic pushBack _s;

		atmos_debug_list_goicSposes pushBack [_startPos,_endPos];
		#endif
	} foreach _vectors;

	values _objMap
};

//возвращает информацию по пересечениям в соседнем чанке
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

#define ATMOS_EXTENDED_INTERSECTION_COUNT

//возвращает точки входа и конца пересечений
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

	#ifdef ATMOS_DEBUG_DRAW_INTERSECT_POS
		private _psList = [_p1S,_p2S,_p3S,_p4S,_p5S];
		private _ps2List = [_p1E,_p2E,_p3E,_p4E,_p5E,
			_p6E,_p7E,_p8E,_p9E
		];
		if !isNull(atmos_debug_list_chintto) then {
			{deleteVehicle _x} foreach atmos_debug_list_chintto;
		};
		private _alist = [];
		atmos_debug_list_chintto = _alist;
		{
			if isNullVar(_x) then {continue};

			private _s = ATMOS_DEBUG_CREATE_SPHERE(0,1,0);
			_alist pushBack _s;
			_s setposatl _x;
		} foreach _psList;
		{
			if isNullVar(_x) then {continue};
			private _s = ATMOS_DEBUG_CREATE_SPHERE(1,0,0);
			_alist pushBack _s;
			_s setposatl _x;
		} forEach _ps2List;

	#endif

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


atmos_onUpdate = {
	private _chObj = nullPtr;
	private _chId = null;
	private _aList = null;
	private _aObj = nullPtr;
	private _sides = null;
	private _fdel = false;
	{
		_chObj = _y;
		_fdel = false;

		/*
			Алгоритм распространения:
			1. берем окружающие чанки
		*/
		_aList = getVar(_chObj,aObj);
		_chId = getVar(_chObj,chId);
		
		{
			_aObj = _x;

			#ifndef ATMOS_MANAGED_ACTIVITY
			if !callFunc(_aObj,canActivity) then {continue};
			#endif
			
			callFunc(_aObj,preActivity);

			if isNullReference(_aObj) then {
				_fdel = true;
				continue;
			};

			callFunc(_aObj,onActivity);

			if callFunc(_aObj,canContactOnObjects) then {
				{
					callFuncParams(_aObj,onObjectContact,_x);
				} foreach callFunc(_chObj,getObjectsInChunk);
			};
		} foreach _aList;

		if (_fdel) then {
			setVar(_chObj,aObj,_aList - [nullPtr]);
		};

		
	} foreach atmos_map_chunks;
};

//convert world postion to virtual chunk id
atmos_chunkPosToId = {
	params ["_x","_y","_z"];

	[
		floor(_x / ATMOS_SIZE) + ATMOS_START_INDEX,
		floor(_y / ATMOS_SIZE) + ATMOS_START_INDEX,
		floor(_z / ATMOS_SIZE) + ATMOS_START_INDEX
	]
};

//returns center atl pos of chunk
atmos_chunkIdToPos = {
	params ["_iX","_iY","_iZ"];

	[
		(_iX - ATMOS_START_INDEX) * ATMOS_SIZE,
		(_iY - ATMOS_START_INDEX) * ATMOS_SIZE,
		(_iZ - ATMOS_START_INDEX) * ATMOS_SIZE
	] vectorAdd vec3(ATMOS_SIZE_HALF,ATMOS_SIZE_HALF,ATMOS_SIZE_HALF)
};

/*
	get list of chunks around

	z+1:
		-------
		| | | |
		| |x| |
		| | | |
		-------
	z:
		-------
		| |x| |
		|x|v|x| <- "v" is optional
		| |x| |
		-------
	z-1:
		-------
		| | | |
		| |x| |
		| | | |
		-------
*/
atmos_chunkIdGetAround = {
	params ["_chunk",["_addCurrent",false]];
	private _loadList = [];
	if (_addCurrent) then {

		 _loadList pushBack _chunk;
	};
	//5*3 => 15 - 1(current)
	 //no iteration - faster

	//upper z
	_loadList pushBack (_chunk vectorAdd [0,0,1]);
	//down z
	_loadList pushBack (_chunk vectorAdd [0,0,-1]);
	//middle z
	_loadList pushBack (_chunk vectorAdd [1,0,0]);
	_loadList pushBack (_chunk vectorAdd [-1,0,0]);
	_loadList pushBack (_chunk vectorAdd [0,1,0]);
	_loadList pushBack (_chunk vectorAdd [0,-1,0]);

	_loadList
};

atmos_const_aroundChunks = [
	[0,0,1],
	[0,0,-1],
	[1,0,0],
	[-1,0,0],
	[0,1,0],
	[0,-1,0]
];

atmos_list_getAroundChunksManaged = {
	//this always must be a copy of atmos_const_aroundChunks
	[
		[0,0,1],
		[0,0,-1],
		[1,0,0],
		[-1,0,0],
		[0,1,0],
		[0,-1,0]
	]
};

atmos_list_getAroundXYChunksManaged = {
	[
		[0,0,1],
		[0,0,-1],
		[1,0,0],
		[-1,0,0],
		[0,1,0],
		[0,-1,0],
		[1,1,0],
		[1,-1,0],
		[-1,-1,0],
		[-1,1,0]
	]
};

atmos_list_getAroundNoZChunksManaged = {
	[
		[1,0,0],
		[-1,0,0],
		[0,1,0],
		[0,-1,0]
	]
};

atmos_const_list_ptrFuncsGetChunks = [
	atmos_list_getAroundChunksManaged,
	atmos_list_getAroundXYChunksManaged,
	atmos_list_getAroundNoZChunksManaged
];

//возвращает случайные стороны
atmos_getNextRandAroundChunks = {
	params [["_count",1],["_colType",ATMOS_SPREAD_MODE_NORMAL]];
	

	private _copyArr = call (atmos_const_list_ptrFuncsGetChunks select _colType);
	
	assert_str(inRange(_count,1,count _copyArr),"Unexpected count '"+(str _count) + "' for mode " + (str _colType));

	private _tArr = [];
	for "_i" from 0 to _count-1 do {
		_tArr pushBack (_copyArr deleteAt (randInt(0,count _copyArr-1)));
	};
	_tArr
};


//run thread updater
atmos_init = {
	#ifdef ATMOS_MANAGED_ACTIVITY
	if (true) exitWith {};
	#endif
	atmos_handle_update = startUpdate(atmos_onUpdate,ATMOS_MAIN_THREAD_UPDATE_DELAY);
};