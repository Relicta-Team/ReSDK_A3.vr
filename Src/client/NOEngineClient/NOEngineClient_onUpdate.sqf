// ======================================================
// Copyright (c) 2017-2025 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

// function noe_client_onUpdate

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