// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================


#include "..\engine.hpp"
#include "..\struct.hpp"
#include "..\profiling.hpp"
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
		{[_y] call struct_eraseFull} foreach (values atmos_map_chunks);
	};
	if !isNull(atmos_handle_update) then {stopUpdate(atmos_handle_update)};
#endif

//chunks references used for effector
atmos_map_chunks = createHashMap; //key:str(chunkloc) -> value(struct:AtmosChunk)

//area used for sync data
atmos_map_chunkAreas = createHashMap; //key: str chunkArea, value (list<AtmosChunks>)
atmos_handle_update = -1;
atmos_chunks_uniqIdx = 0;

atmos_chunks = 0;
atmos_areas = 0;

atmos_areaPtrRefPool = ["AtmosAreaRefPool"] call SafeReference_CreatePool;

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
		_chObj set ["areaSR",["SafeReference",[_aDat,atmos_areaPtrRefPool]] call struct_alloc];
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

	private _cObj = _cli call cm_findClientById;
	if !isNullReference(_cObj) then {
		getVar(_cObj,loadedAreas) set [_ar,null];
	};
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
	#ifdef ATMOS_USE_UPDATE_BUFFER

	private _aDat = _chObj get "areaSR" call ["getValue"];
	private _lupd = tickTime;
	_aDat set [ATMOS_AREA_INDEX_LASTUPDATE,_lupd];
	_chObj set ["lastUpd",_lupd];
	private _mapBuffer = _aDat select ATMOS_AREA_INDEX_UPDATE_BUFFER;
	_mapBuffer set [_chObj get "chNum",_chObj call ["getPacket"]];

	#else

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

	#endif
};

#ifdef ATMOS_USE_UPDATE_BUFFER
atmos_transferBuffer = {
	params ["_aDat"];
	private _t = tickTime;
	private _ubuff = _aDat select ATMOS_AREA_INDEX_UPDATE_BUFFER;
	//no updates
	if (count _ubuff == 0) exitWith {
		_aDat set [ATMOS_AREA_INDEX_LASTSEND_BUFFER,_t + ATMOS_SEND_DELAY_BUFFER];
	};

	private _packBuff = array_copy(_aDat select ATMOS_AREA_INDEX_AREAID);
	_packBuff pushBack (-_t);
	{
		_packBuff append _x;
	} count (values(_ubuff));

	{
		rpcSendToClient(_x,ATMOS_RPC_CLIENT_UPDATE_CHUNK,_packBuff);
	} foreach (_aDat select ATMOS_AREA_INDEX_CLIENTS);
	//cleanup buffer and update timestamp
	_aDat set [ATMOS_AREA_INDEX_UPDATE_BUFFER,createHashMap];
	_aDat set [ATMOS_AREA_INDEX_LASTSEND_BUFFER,_t + ATMOS_SEND_DELAY_BUFFER];
};
#endif

atmos_onUnsubscribeClientListening = {
	params ["_cli","_aId"];
	private _aDat = [_aId] call atmos_getAreaAtAid;
	private _cList = (_aDat select ATMOS_AREA_INDEX_CLIENTS);
	private _idxDel = _cList find _cli;
	if (_idxDel!=-1) then {
		_cList deleteAt _idxDel;
	};

	private _cObj = _cli call cm_findClientById;
	if !isNullReference(_cObj) then {
		getVar(_cObj,loadedAreas) deleteAt _aId;
	};
};
rpcAdd(ATMOS_RPC_CLIENT_UNSUBSCRIBE_LISTEN_CHUNK,atmos_onUnsubscribeClientListening);

atmos_unsubscribeClientListeningSrv = {
	params ["_cli"];
	private _aDat = null;
	private _cList = null;
	private _id = getVar(_cli,id);
	{
		_aDat = [_x] call atmos_getAreaAtAid;
		_cList = (_aDat select ATMOS_AREA_INDEX_CLIENTS);
		array_remove(_cList,_id);
	} foreach getVar(_cli,loadedAreas);
};

//create new process inside chunk
atmos_createProcess = {
	params ["_pos","_procType",["_manualCreate",false],["_paramsInit",null]];

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
		_m call ["onInitialized",_paramsInit];
	};

	if (_manualCreate) then {
		_m call ["onManualCreated",_paramsInit];
	};

	_m
};

atmos_imap_process_t = createHashMapFromArray [
	["AtmosAreaFire",	["aFire",ATMOS_TYPEID_FIRE]],
	["AtmosAreaGas",	["aGas",ATMOS_TYPEID_GAS]],
	["AtmosAreaWater",	["aWater",ATMOS_TYPEID_WATER]]
];

//----- main update handle -------

atmos_internal_handleUpdate = -1;

//small optimizations
atmos_cv_ca = ["canActivity"];
atmos_cv_goch = ["getObjectsInChunk"];
atmos_cv_oa = ["onActivity"];
atmos_cv_tupd = ["onTemperatureUpdate"];

#define ASP_USE_NAMED_REGION

#ifdef ASP_USE_NAMED_REGION
	#define ASP_REGION_NAMED(t,x) ASP_REGION(t + (str _x))
#else
	#define ASP_REGION_NAMED(t,x) ASP_REGION(t)
#endif

atmos_internal_onUpdate = {
	#ifdef SP_MODE
		sp_checkWSim("atmos");
	#endif
	
	_chunkList = null;
	_atmosDat = null;
	_chObj = null;
	_aObj = null;
	_objInside = null;
	_objContactCtx = null;
	ASP_REGION("Atmos update")
	
	{
		_atmosDat = _y;
		ASP_REGION_NAMED("Atmos area process: ",_x)

		_chunkList = _y select ATMOS_AREA_INDEX_CHUNKS;

		{
			_chObj = _x;
			ASP_REGION_NAMED("Chunk process",(_chObj))
			_objInside = null;

			//temperature update
			if (tickTime >= (_chObj getv(nextTempUpdate))) then {
				_chObj call atmos_cv_tupd;
			};
			
			_aFire = null;

			{
				if !isNullVar(_x) then {
					ASP_REGION_NAMED("Object process ",_x)
					_aObj = _x;
					if !(_aObj call atmos_cv_ca) then {continue};
					if isinstance(_aObj,AtmosAreaFire) then {
						_aFire = _aObj;	
					};
					// if isNullVar(_objInside) then {
					// 	_objInside = _chObj call atmos_cv_goch;
					// };
					ASP_MESSAGE("Start activity")
					_aObj call atmos_cv_oa;
					ASP_MESSAGE("End activity")

					// {
					// 	_aObj call ["onObjectContact",_x];
					// 	false
					// } count _objInside;
				};
				false;
			} count (_chObj get "atmosList");

			//handle fire
			ASP_MESSAGE("Start fire obj check")
			if !isNullVar(_aFire) then {
				ASP_REGION_NAMED("Fire process ",(_aFire))
				if isNullVar(_objInside) then {
					_objInside = _chObj call atmos_cv_goch;
				};
				_objContactCtx = refcreate(0);
				{_aFire call ["onObjectContact",[_x,_objContactCtx]];false;} count _objInside;
				_aFire call ["postObjectsContact",[_objContactCtx]];
			};
			ASP_MESSAGE("End fire obj check")

			false;
		} count (_chunkList);

		#ifdef ATMOS_USE_UPDATE_BUFFER
		if (count (_atmosDat select ATMOS_AREA_INDEX_CLIENTS) > 0) then {
			if (tickTime > (_atmosDat select ATMOS_AREA_INDEX_LASTSEND_BUFFER)) then {
				[_atmosDat] call atmos_transferBuffer;
			};
		};
		#endif

		
	} foreach atmos_map_chunkAreas;

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
