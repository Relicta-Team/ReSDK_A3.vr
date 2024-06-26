// ======================================================
// Copyright (c) 2017-2024 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================


#include "..\engine.hpp"
#include "..\GameObjects\GameConstants.hpp"
#include "Atmos.hpp"
#include "Atmos.h"

#ifndef rpcSendToClient
	#define rpcSendToClient(a,b,c) 
	#define rpcAdd(a,b) 
#endif

#include "Atmos_shared.sqf"

#ifdef EDITOR
	if !isNull(atmos_map_chunks) then {
		//{delete(_x)} foreach (values atmos_map_chunks);
	};
	if !isNull(atmos_handle_update) then {stopUpdate(atmos_handle_update)};
#endif

//chunks references used for effector
atmos_map_chunks = createHashMap; //key:str(chunkloc) -> value(struct:AtmosChunk)

//area used for sync data
atmos_map_chunkAreas = createHashMap; //key: str chunkArea, value (list<AtmosChunks>)
atmos_handle_update = -1;
atmos_chunks_uniqIdx = 0;

//returns chunk by id, creates new if not exists
atmos_getChunkAtChId = {
	params ["_chId"];
	private _strKey = str _chId;
	if !(_strKey in atmos_map_chunks) then {
		private _chObj = ["AtmosChunk",[_chId]] call struct_alloc; //newParams(AtmosChunk,[_chId]);
		atmos_map_chunks set [_strKey,_chObj];

		//checking area and register in area
		private _aDat = [_chId call atmos_chunkIdToAreaId] call atmos_getAreaAtAid;
		(_aDat select ATMOS_AREA_INDEX_CHUNKS) pushBack _chObj;
		_chObj set ["area",["SafeRef",[_aDat]] call struct_alloc];
	};
	atmos_map_chunks get _strKey
};

//returns chunk by id
atmos_getChunkAtChIdUnsafe = {
	params ["_chId"];
	private _strKey = str _chId;
	atmos_map_chunks get _strKey //can return null
};

//returns area by id
atmos_getAreaAtAid = {
	params ["_aid"];
	private _strkey = str _aid;
	if !(_strkey in atmos_map_chunkAreas) then {
		atmos_map_chunkAreas set [_strkey,ATMOS_AREA_NEW];
	};
	atmos_map_chunkAreas get _strkey
};


atmos_rpc_requestGetArea = {
	params ["_cli","_ar","_lastUpd"];
	
	private _aO = _ar call atmos_getAreaAtAid;
	private _packet = [_ar select 0,_ar select 1,_ar select 2];

	_packet pushBack (_aO select ATMOS_AREA_INDEX_LASTUPDATE);
	
	//генерируем пакет
	[_packet,_aO select ATMOS_AREA_INDEX_CHUNKS,_lastUpd] call atmos_internal_generatePacket;

	rpcSendToClient(_cli,"cuar",_packet);

	//добавляем netid клиента к владельцам
	(_aO select ATMOS_AREA_INDEX_CLIENTS) pushBackUnique _cli;
};
rpcAdd("salr",atmos_rpc_requestGetArea);

atmos_internal_generatePacket = {
	params ["_packet","_chObjList","_lastUpd"];
	{
		if ((_x get "lastUpd")>_lastUpd) then {
			_packet append (_x call ["getPacket"])
		};
	} foreach _chObjList;
};

atmos_onUpdateAreaByChunk = {
	params ["_chObj"];
	private _aDat = _chObj get "area";
	private _lupd = tickTime;
	_aDat set [ATMOS_AREA_INDEX_LASTUPDATE,_lupd];
	_chObj set ["lastUpd",_lupd];
	private _aid = _chObj call ["getChunkAreaId"];
	private _packet = _aid;

	_packet pushBack _lupd;

	_packet append (_chObj call ["getPacket"]);

	{
		rpcSendToClient(_x,"cuar",_packet);
	} foreach (_aDat select ATMOS_AREA_INDEX_CLIENTS);
};

//create new process inside chunk
atmos_createProcess = {
	params ["_pos","_procType"];

	private _chId = _pos call atmos_chunkPosToId;
	private _atmCh = [_chId] call atmos_getChunkAtChId;
	private _mapper = atmos_imap_process_t get _procType;
	assert(!isNullVar(_mapper));

	_mapper params ["_fNameStore","_aObjOffset"];

	private _m = _atmCh get _fNameStore;
	if isNullVar(_m) then {
		private _at = [_procType] call struct_alloc;
		_at set ["chunk",_atmCh];
		_atmCh set [_fNameStore,_at];
		(_atmCh get "aObj") set [_aObjOffset,_at];
		[_atmCh] call atmos_onUpdateAreaByChunk;
		//private _areaDat = (_atmCh get "area");
		//TODO push packet in next call
	};
};

atmos_imap_process_t = createHashMapFromArray [
	["AtmosAreaFire",	["aFire",0]],
	["AtmosAreaGas",	["aGas",1]],
	["AtmosAreaWater",	["aWater",2]]
];


//!================================== WIP ==================================!

//what this?..
atmos_internal_generateChunkGetCode = {
	private _code = [
		"private _bch = _this;"
	];
	private _chidInt = 1;
	for "_x" from 1 to ATMOS_AREA_SIZE do {
		for "_y" from 1 to ATMOS_AREA_SIZE do {
			for "_z" from 1 to ATMOS_AREA_SIZE do {
				_f =  (_x - 1) * 100 + (_y - 1) * 10 + (_z-1) + 1;
				_code pushBack (format["_bch pushBack [%1,%2,%3];",_x,_y,_z]);
				INC(_chidInt);
			};
		};
	};
	_code pushBack "_bch";
	compile (_code joinString endl);
};
