// ======================================================
// Copyright (c) 2017-2024 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================


#include "..\engine.hpp"
#include "..\ServerRpc\serverRpc.hpp"
#include "..\GameObjects\GameConstants.hpp"
#include "Atmos.hpp"
#include "Atmos.h"
#include "Atmos_raycasts.sqf"
#include "Atmos_shared.sqf"
#include "Atmos_spreading.sqf"

#ifdef EDITOR
	loadFile("src\host\Atmos\Atmos_debug.sqf");

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
	assert(equalTypes(_chId,[]));
	private _strKey = str _chId;
	if !(_strKey in atmos_map_chunks) then {
		private _chObj = ["AtmosChunk",[_chId]] call struct_alloc; //newParams(AtmosChunk,[_chId]);
		atmos_map_chunks set [_strKey,_chObj];

		//checking area and register in area
		private _aDat = [_chId call atmos_chunkIdToAreaId] call atmos_getAreaAtAid;
		(_aDat select ATMOS_AREA_INDEX_CHUNKS) pushBack _chObj;
		_chObj set ["areaSR",["SafeRef",[_aDat]] call struct_alloc];
	};
	atmos_map_chunks get _strKey
};

//returns chunk by id
atmos_getChunkAtChIdUnsafe = {
	params ["_chId"];
	assert(equalTypes(_chId,[]));
	private _strKey = str _chId;
	atmos_map_chunks get _strKey //can return null
};

//returns area by id
atmos_getAreaAtAid = {
	params ["_aid"];
	assert(equalTypes(_aid,[]));
	private _strkey = str _aid;
	if !(_strkey in atmos_map_chunkAreas) then {
		atmos_map_chunkAreas set [_strkey,ATMOS_AREA_NEW];
	};
	atmos_map_chunkAreas get _strkey
};

//обработка запроса зоны от клиента
atmos_rpc_requestGetArea = {
	params ["_cli","_ar","_lastUpd"];
	
	private _aDat = [_ar] call atmos_getAreaAtAid;
	private _packet = [_ar select 0,_ar select 1,_ar select 2];

	_packet pushBack (_aDat select ATMOS_AREA_INDEX_LASTUPDATE);
	_packet pushBack (_aDat select ATMOS_AREA_INDEX_LASTDELETE);
	
	//генерируем пакет
	[_packet,_aDat select ATMOS_AREA_INDEX_CHUNKS,_lastUpd] call atmos_internal_generatePacket;

	rpcSendToClient(_cli,ATMOS_RPC_CLIENT_UPDATE_CHUNK,_packet);

	//добавляем netid клиента к владельцам
	(_aDat select ATMOS_AREA_INDEX_CLIENTS) pushBack _cli;
};
rpcAdd(ATMOS_RPC_SERVER_REQUEST_AREA,atmos_rpc_requestGetArea);

atmos_internal_generatePacket = {
	params ["_packet","_chObjList","_lastUpd"];
	{
		if ((_x get "lastUpd")>_lastUpd) then {
			_packet append (_x call ["getPacket"])
		};
	} foreach _chObjList;
};

atmos_rpc_validateExpiredChunks = {
	params ["_cli","_ar","_listIds"];
	private _aDat = [_ar] call atmos_getAreaAtAid;
	private _idListActual = (_aDat select ATMOS_AREA_INDEX_CHUNKS) apply {_x get "chNum"};
	private _packet = [
		_ar select 0,
		_ar select 1,
		_ar select 2,
		-(_aDat select ATMOS_AREA_INDEX_LASTUPDATE) //нам не нужна отметка последнего удаления
	];
	private _baseCount = count _packet;
	{
		_packet append [_x,-1];
	} count (_listIds - _idListActual);
	
	if (count _packet > _baseCount) then {
		rpcSendToClient(_cli,ATMOS_RPC_CLIENT_UPDATE_CHUNK,_packet);	
	};
	
};
rpcAdd(ATMOS_RPC_SERVER_DELETE_EXPIRED_CHUNKS,atmos_rpc_validateExpiredChunks);

atmos_onUpdateAreaByChunk = {
	params ["_chObj"];
	private _aDat = _chObj get "areaSR" call ["getValue"];
	private _lupd = tickTime;
	_aDat set [ATMOS_AREA_INDEX_LASTUPDATE,_lupd];
	_chObj set ["lastUpd",_lupd];
	private _aid = _chObj call ["getChunkAreaId"];
	private _packetS = _aid;

	_packetS pushBack (-_lupd);//это обновление. не загрузка
	//_packetS pushBack (_aDat select ATMOS_AREA_INDEX_LASTDELETE);
	
	assert(count _packetS == 4);

	_packetS append (_chObj call ["getPacket"]);

	{
		rpcSendToClient(_x,ATMOS_RPC_CLIENT_UPDATE_CHUNK,_packetS);
	} foreach (_aDat select ATMOS_AREA_INDEX_CLIENTS);
};

atmos_onUnsubscribeClientListening = {
	params ["_cli","_aId"];
	private _aDat = [_aId] call atmos_getAreaAtAid;
	private _cList = (_aDat select ATMOS_AREA_INDEX_CLIENTS);
	private _idxDel = _cList find _cli;
	if (_idxDel!=-1) then {
		_cList deleteAt _idxDel;
	};
};
rpcAdd(ATMOS_RPC_CLIENT_UNSUBSCRIBE_LISTEN_CHUNK,atmos_onUnsubscribeClientListening);

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
		//private _at = [_procType,"_chId"] call struct_alloc;
		//_m = _at;
		_m = _atmCh call ["registerArea",[_procType,_fNameStore,_aObjOffset]];
		//TODO push packet in next call
	};

	_m
};

atmos_imap_process_t = createHashMapFromArray [
	["AtmosAreaFire",	["aFire",0]],
	["AtmosAreaGas",	["aGas",1]],
	["AtmosAreaWater",	["aWater",2]]
];

//----- main update handle -------

atmos_internal_handleUpdate = -1;

//small optimizations
atmos_cv_ca = ["canActivity"];
atmos_cv_goch = ["getObjectsInChunk"];
atmos_cv_oa = ["onActivity"];

atmos_internal_onUpdate = {
	private _chObj = null;
	private _aObj = null;
	private _objInside = null;
	{
		_chObj = _y;
		_objInside = null;
		
		{
			_aObj = _x;
			if !isNullVar(_aObj) then {
				if !(_aObj call atmos_cv_ca) then {continue};
				
				if isNullVar(_objInside) then {
					_objInside = _chObj call atmos_cv_goch;
				};
				
				_aObj call atmos_cv_oa;

				{
					_aObj call ["onObjectContact",_x];
					false
				} count _objInside;
			};
			false;
		} count (_chObj get "atmosList");
		false;
	} foreach atmos_map_chunks;
};

atmos_internal_handleUpdate = startUpdate(atmos_internal_onUpdate,ATMOS_MAIN_THREAD_UPDATE_DELAY);

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
