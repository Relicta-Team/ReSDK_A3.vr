// ======================================================
// Copyright (c) 2017-2025 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

/*
	Atmos Client subsystem
*/

#include "..\..\host\Atmos\Atmos.hpp"
#include "..\LightEngine\ScriptedEffects.hpp"


#define ACLI_TYPE_FIRE [SLIGHT_ATMOS_FIRE_1,SLIGHT_ATMOS_FIRE_2,SLIGHT_ATMOS_FIRE_3]

#define ACLI_DATA_OBJECTS 0
#define ACLI_DATA_METAINFO 1
#define ACLI_DATA_CHUNK_ID 2

#define __ACLI_NEW_BUFFER_OBJECTS [objNull,objNull]
#define __ACLI_NEW_BUFFER_METAINFO 0
#define __ACLI_NEW_DATA [__ACLI_NEW_BUFFER_OBJECTS,__ACLI_NEW_BUFFER_METAINFO,_chid]
#define ACLI_NEW_CHUNK __ACLI_NEW_DATA

acli_map_chunks = createHashMap;
acli_bool_requestUpdate = false;
acli_bool_enableSystem = false; //turn off is won't work

acli_handleAddObj = {
	params ["_obj","_cfgId"];
	private _chPos = (getPosATL _obj) call acli_chunkPosToId;
	private _chBuff = [_chPos] call acli_getChunk;

	private _buffOffset = ACLI_OBJ_BUFFER_INDEX_ATMOS;
	if (_cfgId in ACLI_TYPE_FIRE) then {
		_buffOffset = ACLI_OBJ_BUFFER_INDEX_FIRE;
	};
	_chBuff select ACLI_DATA_OBJECTS set [_buffOffset,_obj];
	acli_bool_requestUpdate = true;
};

// #define RIGHT 0x1
// #define FRONT 0x2
// #define LEFT  0x4
// #define BACK  0x8

// acli_bitmask_def = [
// 	[0x0,[]],
// 	[0x1,[[1,0,0]]],
// 	[0x2,[[0,1,0]]],
// 	[0x4,[[-1,0,0]]],
// 	[0x8,[[0,-1,0]]],
// 	//2 groups
// 	[0x1+0x2,[[1,0,0],[0,1,0]]],
// 	[0x1+0x4,[[1,0,0],[-1,0,0]]],
// 	[0x1+0x8,[[1,0,0],[0,-1,0]]],
// 	[0x2+0x4,[[0,1,0],[-1,0,0]]],
// 	[0x2+0x8,[[0,1,0],[0,-1,0]]],
// 	[0x4+0x8,[[0,-1,0],[-1,0,0]]],
// 	//3 groups
// 	[0x1+0x2+0x4,[[1,0,0],[0,1,0],[-1,0,0]]],
// 	[0x1+0x2+0x8,[[1,0,0],[0,1,0],[0,-1,0]]],
// 	[0x1+0x4+0x8,[[1,0,0],[-1,0,0],[0,-1,0]]],
// 	[0x2+0x4+0x8,[[0,1,0],[-1,0,0],[0,-1,0]]],
// 	//4 groups
// 	[0x1+0x2+0x4+0x8,[[1,0,0],[0,1,0],[-1,0,0],[0,-1,0]]]
// ];

// acli_bitmask_dir = createHashMap [
// 	[[1,0,0],RIGHT],
// 	[[0,1,0],FRONT],
// 	[[-1,0,0],LEFT],
// 	[[0,-1,0],BACK]
// ];

// acli_bitmask_getByOfs = {

// };

acli_getChunk = {
	params ["_chid"];
	private _chidS = str _chid;
	if !(_chidS in acli_map_chunks) then {
		acli_map_chunks set [_chidS,
			ACLI_NEW_CHUNK
		];
	};
	acli_getChunk get _chidS
};

acli_getChunkUnsafe = {
	params ["_chid"];
	_chid = str _chid;
	acli_getChunk get _chid
};

/*
	Local client optimizer.
	Rules:
		1. non-empty chunks around this object no rendering
		-------
		| |x| |
		|x|v|x|  <-- v is source - no render
		| |x| |
		-------
		Solution:
			On create collecting around chunks and make connections
		
*/

acli_lazyCheck = {
	if (!acli_bool_requestUpdate) exitWith {};

	private _arounded = createHashMap;//map is faster than array is this case with searching edges
	private _aroundChid = null;
	private _lenAr = 0;
	private _carr = null;

	{
		_y params ["_chData"];
		
		//уже установлено предыдущим шагом. Сокрытие не произойдёт.
		if (_x in _arounded) then {continue};

		_aroundChid = (_chData select ACLI_DATA_CHUNK_ID) call acli_getAroundChIDList;
		_srcLen = {!isNullReference(_x)} count (_chData select ACLI_DATA_OBJECTS);
		if (_srcLen == 0) then {continue}; //all objects inside this chunks are null

		_lenAr = 0;
		{
			_carr = _x call acli_getChunkUnsafe;
			if isNullVar(_carr) exitWith {};
			if ((str _x) in _arounded) exitWith {};//already marked as hidden

			_defiedLen = {!isNullReference(_x)} count (_carr select ACLI_DATA_OBJECTS);
			
			//isnide this chunk has any of atmos effect (fire, smoke...)
			if (_defiedLen > 0) then {
				INC(_lenAr);
			};
		} foreach _aroundChid;

		if (_lenAr >= 4) then {
			_arounded set [_x,_y];
			//do HIDE now (no need second iteration, perf+)
			{
				if !isNullReference(_x) exitWith {
					private _o = attachedTo _x;
					if !isNullReference(_o) then {
						_o setPosAtl (getPosAtl _o vectorAdd [-500,-500,-500]);
					};
				};
			} foreach (_chData select ACLI_DATA_OBJECTS);
		};
	} foreach acli_map_chunks;

	acli_bool_requestUpdate = false;
};

acli_internal_onUpdate_handle = ifcheck(acli_bool_enableSystem,startUpdate(acli_lazyCheck,1),-1);

acli_getAroundChIDList = {
	params ["_chid"];
	//constarr faster... or not?
	[
		_chid vectorAdd [1,0,0],
		_chid vectorAdd [-1,0,0],
		_chid vectorAdd [0,1,0],
		_chid vectorAdd [0,-1,0]
	]
};


acli_chunkPosToId = {
	params ["_x","_y","_z"];

	[
		floor(_x / ATMOS_SIZE) + ATMOS_START_INDEX,
		floor(_y / ATMOS_SIZE) + ATMOS_START_INDEX,
		floor(_z / ATMOS_SIZE) + ATMOS_START_INDEX
	]
};

//returns center atl pos of chunk
acli_chunkIdToPos = {
	params ["_iX","_iY","_iZ"];

	[
		(_iX - ATMOS_START_INDEX) * ATMOS_SIZE,
		(_iY - ATMOS_START_INDEX) * ATMOS_SIZE,
		(_iZ - ATMOS_START_INDEX) * ATMOS_SIZE
	] vectorAdd vec3(ATMOS_SIZE_HALF,ATMOS_SIZE_HALF,ATMOS_SIZE_HALF)
};