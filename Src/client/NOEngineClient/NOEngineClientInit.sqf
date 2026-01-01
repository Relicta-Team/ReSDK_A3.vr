// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\host\engine.hpp>
#include <..\..\host\struct.hpp>
#include <..\..\host\thread.hpp>
#include <..\..\host\NOEngine\NOEngine.hpp>
#include "..\..\host\NOEngine\NOEngine_Shared.sqf"
#include <..\..\host\NOEngine\NOEngine_SharedTransportLevel.hpp>
#include <..\..\host\Atmos\Atmos.hpp>
#include <..\..\host\Atmos\Atmos_shared.sqf>
#include <..\ClientRpc\clientRpc.hpp>
#include "..\Interactions\interact_component_shared.hpp"
#include "..\..\host\ServerVoice\ReVoicer.hpp"

namespace(NOEngine.Client,noe_client_)

#include <NOEngineClient.h>

#include "NOEngineClient_NOGEOM_ext.sqf"

#include "NOEngineClient_Components.sqf"

#include "NOEngineClient_TransportLevel.sqf"

#include "NOEngineClient_ObjectManager.sqf"

//#include "NOEngineClient_localAtmos.sqf"
//this should be loaded only before netatmos.sqf
#include "NOEngineClient_AtmosOptimizer.sqf"

//perblock optimization
#include "NOEngineClient_NetAtmosPerBlockOptimize.sqf"

#include "NOEngineClient_Interpolation.sqf"

#include "NOEngineClient_NetAtmos.sqf"

//#include "NOEngineClient_Rendering.sqf"


#include "NOEngineClient_chunkDebug.sqf"

decl(NULL|thread_handle[])
noe_debug_allthreads = null;

#ifdef NOE_CLIENT_THREAD_DEBUG
noe_debug_allthreads = [];
#endif

decl(map<int;any>)
noe_client_cs = createHashMap;
decl(int[])
noe_client_allChunkTypes = [CHUNK_TYPE_ITEM,CHUNK_TYPE_STRUCTURE,CHUNK_TYPE_DECOR];

//генерирует контейнеры хранения данных под чанки
decl(void())
noe_client_generateStorage = {
	{
		_ch = createHashMap;
		noe_client_cs set [_x,_ch];
	} forEach noe_client_allChunkTypes;
};
call noe_client_generateStorage; //первый обязательный вызов

decl(int)
noe_client_packetId = 0;
decl(any[])
noe_client_packets = [];
decl(map<string;string>)
noe_client_packetsChunks = createHashMap;

decl(map<string;mesh>)
noe_client_allPointers = createHashMap;

decl(map<string;mesh>)
noe_client_set_lockedPropUpdates = createHashMap; //список блокировки обновления визуального состояния объекта

decl(int[])
noe_client_handlers = [];

//Запускает потоки карты
decl(void())
noe_client_startListening = {
	private _mob = player;

	noe_client_handlers pushBack (startUpdateParams(noe_client_onUpdate,mainThreadUpdateDelay,[_mob arg chunkType_decor]));
	noe_client_handlers pushBack (startUpdateParams(noe_client_onUpdate,mainThreadUpdateDelay,[_mob arg chunkType_structure]));
	noe_client_handlers pushBack (startUpdateParams(noe_client_onUpdate,mainThreadUpdateDelay,[_mob arg chunkType_item]));
};

decl(bool())
noe_client_isEnabled = {count noe_client_handlers > 0};

decl(bool(actor))
noe_client_stopListening = {
	params ["_mob"];
	
	if !(call noe_client_isEnabled) exitWith {false};

	{
		stopUpdate(_x)
	} foreach noe_client_handlers;

	noe_client_handlers = [];
	
	//stop loading
	[_mob] call noe_client_unloadAllChunks;

	{
		noe_client_set_lockedPropUpdates deleteAt _x;
	} foreach (noe_client_set_lockedPropUpdates);
	
	true
};

//Выгружает и отписывает клиента от всех чанков которые он загрузил
decl(void(actor))
noe_client_unloadAllChunks = {
	params ["_mob"];
	
	private _chunkList = null;
	private _chunk = null;
	private _chunkType = null;
	private _chunkVec2Pos = null;
	private _chunkObject = null;
	//TODO выгружаем вообще все чанки, которые загрузил клиент
	{
		_chunkList = [];
		_chunkType = _x;
		_chunk = [getPosATL _mob,_chunkType] call noe_posToChunk;
		[_chunkList,_chunk,_chunkType] call noe_collectAroundChunks;
		
		//выгружаем
		{
			_chunkVec2Pos = _x;
			_chunkObject = _chunkVec2Pos call noe_client_getPosChunkToData;
			_loadState = chunk_getLoadingState(_chunkObject);
			if (_loadState == CHUNK_STATE_LOADED) then {
				[_chunkVec2Pos select 0,_chunkVec2Pos select 1,_chunkObject] call noe_client_despawnObjectsInChunk;
			} else {
				warningformat("noe::client::unloadAllChunks() - Chunk state not loaded -> %1",_loadState);
			};
		} foreach _chunkList;
		
	} foreach noe_client_allChunkTypes;
	
	//Выписка из прослушивания
	rpcSendToServer("onStopListenNOE",[clientOwner]);
	
	//очистка данных
	call noe_client_generateStorage; //сборщик мусора сам вычистит всю память
	
};	

decl(void(...any[]))
noe_client_onUpdate = {
	
	(_this select 0) params ["_mob","_chunkType"];

	//Обновляем игрока
	if not_equals(_mob,player) then {
		_mob = player;
		(_this select 0) set [0,_mob];
	};

	//_t = tickTime;
	#define variable_name_prevchunk "pch"

	private _chunksToLoad = [];
	private _chunksToUnload = [];

	_chunk = [getPosATL _mob,_chunkType] call noe_posToChunk;
	_prevChunk = _mob getVariable [variable_name_prevchunk + str _chunkType,_chunk];

	[_chunksToLoad,_chunk,_chunkType] call noe_collectAroundChunks;
	[_chunksToUnload,_prevChunk,_chunkType] call noe_collectAroundChunks;

	_mob setvariable [variable_name_prevchunk + str _chunkType,_chunk];

	//отбраковываем лишние чанки
	{
		if ((_x in _chunksToUnload)) then {
			_chunksToUnload deleteAt (_chunksToUnload find _x);
		};	
	} foreach _chunksToLoad;

	//выгружаем старые
	{
		_chunkObject = _x call noe_client_getPosChunkToData;
		_loadState = chunk_getLoadingState(_chunkObject);
		if (_loadState == CHUNK_STATE_LOADED) then {
			[_x select 0,_x select 1,_chunkObject] call noe_client_despawnObjectsInChunk;
		};
	} foreach _chunksToUnload;



	//после полного сбора загружаем чанки
	{
		_chunkObject = _x call noe_client_getPosChunkToData;
		_loadState = chunk_getLoadingState(_chunkObject);
		if (_loadState == CHUNK_STATE_NOT_LOADED) then {
			[_x select 0,_x select 1,_chunkObject] call noe_client_requestLoadChunk;
		};
	} foreach _chunksToLoad;

	#ifdef NOE_CLIENT_THREAD_DEBUG
	___dispose = false;
	{
		if (isNullReference(_x) || {scriptDone _x}) then {
			noe_debug_allthreads set [_forEachIndex,objnull];
			___dispose = true;
		}
	} foreach +noe_debug_allthreads;
	if (___dispose) then {noe_debug_allthreads = noe_debug_allthreads - [objnull]};
	#endif
};

//structures only defined after main module inialized
#include "NOEngineClient_NetAtmos_structs.sqf"

log("NOEngine: client module loaded!");