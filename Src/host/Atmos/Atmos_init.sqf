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
#include "Atmos.h"

atmos_map_chunks = createHashMap; //key:str(chunkloc) -> value(object:AtmosChunk)
atmos_handle_update = -1;
//debug draw atmos
//#define ATMOS_DEBUG_DRAW
//#define ATMOS_DEBUG_DRAW_INTERSECT_POS
//#define ATMOS_DEBUG_DRAW_INTERSECT_INFO

#define ATMOS_DEBUG_CREATE_SPHERE(_r,_g,_b) call {private _s = "Sign_Sphere10cm_F" createVehicleLocal [0,0,0]; \
_s setObjectTexture [0,format(["#(rgb,8,8,3)color(%1,%2,%3,1)",_r,_g,_b])]; _s}

#ifdef ATMOS_DEBUG_DRAW
	if !isNull(atmos_debug_handleDebugDraw) then {
		stopUpdate(atmos_debug_handleDebugDraw);
	};
	atmos_debug_handleDebugDraw = -1;

	if !isNull(atmos_debug_list_chintto) then {{deleteVehicle _x} foreach atmos_debug_list_chintto;};
	if !isNull(atmos_debug_list_giiSpheres) then {{deleteVehicle _x} foreach atmos_debug_list_giiSpheres;};
#endif

atmos_getIntersectInfo = {
	params ["_fromCh","_side",["_searchMode",ATMOS_SEARCH_MODE_GET_COUNT]];

	private _posQuery = [_fromCh,_side,false] call atmos_getIntersectPosList;
	private _srcPosList = _posQuery select 0;
	private _destPosList = _posQuery select 1;

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
			_s setposatl _x; \
			_s = ATMOS_DEBUG_CREATE_SPHERE(r,g,b); atmos_debug_list_giiSpheres pushBack _s; \
			_s setposatl ifcheck((_qResult select 1)isequalto vec3(0,0,0),_destPosList select _foreachIndex,_qResult select 1);
		
		#define exitMethod then
		#define setupValue(v) if (!_valueSetupGet) then {v}
		
	#else
		#define ATMOS_DEBUG_DRAW_INTERSECT_SPHERE
		#define exitMethod exitWith
		#define setupValue(v) v
	#endif

	if (_searchMode == ATMOS_SEARCH_MODE_GET_COUNT) then {
		private _retCount = 0;
		{
			ATMOS_DEBUG_DRAW_INTERSECT_SPHERE
			if !isNullReference(([_x arg _destPosList select _foreachIndex] call si_getIntersectData) select 0) then {
				INC(_retCount);
			};
		} foreach _srcPosList;
		_retCount;
	} else {
		if (_searchMode == ATMOS_SEARCH_MODE_FIRST_INTERSECT) then {
			private _bRet = false;
			{
				ATMOS_DEBUG_DRAW_INTERSECT_SPHERE
				if !isNullReference(([_x arg _destPosList select _foreachIndex] call si_getIntersectData) select 0) exitMethod {setupValue(_bRet = true)};
			} foreach _srcPosList;
			_bRet
		} else {
			assert_str(_searchMode==ATMOS_SEARCH_MODE_NO_INTERSECT,format vec2("Unkown search mode enum %1",_searchMode));

			private _bRet = false;
			{
				ATMOS_DEBUG_DRAW_INTERSECT_SPHERE
				if isNullReference(([_x arg _destPosList select _foreachIndex] call si_getIntersectData) select 0) exitMethod {
					setupValue(_bRet = true);
				};
			} foreach _srcPosList;

			_bRet
		};
	};
};

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
	private _halfSize = ATMOS_SIZE_HALF-0.1; //небольшой оффсет для решения возможной проблемы миссов чанка
	if (_ofsX != 0) then {
		_p2S = [_p1X, _p1Y + _halfSize, _p1Z + _halfSize];
		_p3S = [_p1X, _p1Y - _halfSize, _p1Z + _halfSize];
		_p4S = [_p1X, _p1Y + _halfSize, _p1Z - _halfSize];
		_p5S = [_p1X, _p1Y - _halfSize, _p1Z - _halfSize];
	} else {
		if (_ofsY != 0) then {
			_p2S = [_p1X + _halfSize, _p1Y, _p1Z + _halfSize];
			_p3S = [_p1X - _halfSize, _p1Y, _p1Z + _halfSize];
			_p4S = [_p1X + _halfSize, _p1Y, _p1Z - _halfSize];
			_p5S = [_p1X - _halfSize, _p1Y, _p1Z - _halfSize];
		} else {
			if (_ofsZ != 0) then {
				_p2S = [_p1X + _halfSize, _p1Y + _halfSize, _p1Z];
				_p3S = [_p1X - _halfSize, _p1Y + _halfSize, _p1Z];
				_p4S = [_p1X + _halfSize, _p1Y - _halfSize, _p1Z];
				_p5S = [_p1X - _halfSize, _p1Y - _halfSize, _p1Z];
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
		private _ps2List = [_p1E,_p2E,_p3E,_p4E,_p5E];
		if !isNull(atmos_debug_list_chintto) then {
			{deleteVehicle _x} foreach atmos_debug_list_chintto;
		};
		private _alist = [];
		atmos_debug_list_chintto = _alist;
		{
			if isNullVar(_x) then {continue};

			private _s = ATMOS_DEBUG_CREATE_SPHERE(1,0,0);
			_alist pushBack _s;
			_s setposatl _x;
		} foreach _psList;
		{
			if isNullVar(_x) then {continue};
			private _s = ATMOS_DEBUG_CREATE_SPHERE(0,1,0);
			_alist pushBack _s;
			_s setposatl _x;
		} forEach _ps2List;

	#endif

	[[_p1S,_p2S,_p3S,_p4S,_p5S],[_p1E,_p2E,_p3E,_p4E,_p5E]];
};

atmos_debug_drawCurrentZone = {
	if !isNull(atmos_debug_handleDebugDraw) then {
		stopUpdate(atmos_debug_handleDebugDraw);
	};
	if !isNull(atmos_debug_map_spheres) then {
		{deleteVehicle _y} foreach atmos_debug_map_spheres;
	};

	showHUD true; //for use drawicon3d
	atmos_debug_cntDrwArndHlf = 2;
	atmos_debug_basicPos = getposatl player;

	atmos_debug_map_spheres = createHashMap;

	private _drawFunc = {
		if !isNullReference(findDisplay 49) exitWith {};
		_myPos = atmos_debug_basicPos call atmos_chunkPosToId;
		private _newPosHalf = 0;
		private _newPosBase = 0;

		for "_x" from -atmos_debug_cntDrwArndHlf to atmos_debug_cntDrwArndHlf do {
			for "_y" from -atmos_debug_cntDrwArndHlf to atmos_debug_cntDrwArndHlf do {
				for "_z" from -atmos_debug_cntDrwArndHlf to atmos_debug_cntDrwArndHlf do {
					_mpsChid = (_myPos vectoradd [_x,_y,_z]);
					_newPosHalf = _mpsChid call atmos_chunkIdToPos;
					_newPosBase = _newPosHalf vectordiff [ATMOS_SIZE_HALF,ATMOS_SIZE_HALF,ATMOS_SIZE_HALF];
					_mhlf = atmos_debug_cntDrwArndHlf;
					_color = [
						linearConversion[-_mhlf,_mhlf,_x,0,1,true],
						linearConversion[-_mhlf,_mhlf,_y,0,1,true],
						linearConversion[-_mhlf,_mhlf,_z,0,1,true],
						1
					];
					drawIcon3D ["", _color, _newPosHalf vectoradd [0,0,0.07], 0, 0, 0, format[
						"CH:{%1,%2,%3} ofs:(%4,%5,%6)",
						_mpsChid select 0,_mpsChid select 1,_mpsChid select 2,_x,_y,_z
					], 1, linearConversion [ATMOS_SIZE_HALF,ATMOS_SIZE_HALF*(atmos_debug_cntDrwArndHlf*2),(asltoatl eyepos player) distance (_newPosHalf),0.04,0.02,true], "TahomaB"];

					_keyCh = str _mpsChid;
					if !(_keyCh in atmos_debug_map_spheres) then {
						_sphere = ATMOS_DEBUG_CREATE_SPHERE(_color select 0,_color select 1,_color select 2);
						atmos_debug_map_spheres set [_keyCh,_sphere];
						_sphere setposatl _newPosHalf;
					};


					_sp = _newPosBase;
					_size = ATMOS_SIZE;
					drawLine3D [_sp,_sp vectorAdd [_size,0,0],_color];
					drawLine3D [_sp,_sp vectorAdd [0,_size,0],_color];
					drawLine3D [_sp vectorAdd [_size,_size,0],_sp vectorAdd [_size,0,0],_color];
					drawLine3D [_sp vectorAdd [_size,_size,0],_sp vectorAdd [0,_size,0],_color];
					//to up

					drawLine3D [_sp vectorAdd [0,0,0],_sp vectorAdd [0,0,_size],_color];
					drawLine3D [_sp vectorAdd [_size,0,0],_sp vectorAdd [_size,0,_size],_color];
					drawLine3D [_sp vectorAdd [0,_size,0],_sp vectorAdd [0,_size,_size],_color];
					drawLine3D [_sp vectorAdd [_size,_size,0],_sp vectorAdd [_size,_size,_size],_color];

				};
			}
		}
	};
	atmos_debug_handleDebugDraw = startUpdate(_drawFunc,0);
};

atmos_onUpdate = {

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


//run thread updater
atmos_init = {
	//atmos_handle_update = startUpdate(atmos_onUpdate,ATMOS_MAIN_THREAD_UPDATE_DELAY);
};