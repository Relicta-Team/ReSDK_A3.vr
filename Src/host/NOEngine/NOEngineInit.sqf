// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\engine.hpp>
#include <..\oop.hpp>
#include <..\ServerRpc\serverRpc.hpp>
#include <..\PointerSystem\pointers.hpp>

#include <NOEngine.h>
#include <NOEngine.hpp>
//общие компоненты
#include "NOEngine_Shared.sqf"
//объявления чанк-модели
#include "NOEngine_ChunkModel.sqf"
//управление объектами: создание, удаление
#include "NOEngine_ObjectManager.sqf"

//низкоуровневые функции для управления объектами
#include "NOEngine_ObjectRegisterModel.sqf"
//инициализаторы для карты
#include "NOEngine_initializers.sqf"
// Для объектов без геометрии на сервере тоже должны создаваться рефы
#include "NOEngine_NGOServer.sqf"






//инициализирует менеджер карты
noe_init = {
	params ["_mob"];
	//startUpdateParams(noe_onMainThread,mainThreadUpdateDelay + (mainThreadUpdateMultiplier * 3),[_mob arg chunkType_decor]);
	//startUpdateParams(noe_onMainThread,mainThreadUpdateDelay + (mainThreadUpdateMultiplier * 2),[_mob arg chunkType_structure]);
	//startUpdateParams(noe_onMainThread,mainThreadUpdateDelay,[_mob arg chunkType_item]);

};

noe_onMainThread = {
	(_this select 0) params ["_mob","_chunkType"];

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

	log(str _chunksToLoad);

	if (true) exitWith {};

	//cm_allInGameMobs
	private _chunk = 0;
	//private _distDecor = getChunkSizeByType(_chunkType);
	private _chunkInfo = 0;

	private _chunksToLoad = [];
	private _chunksToUnload = [];

	private _prevChunk = 0;
	{

		_chunk = [getPosATL _x,_chunkType] call noe_posToChunk;
		_prevChunk = _x getVariable ["prevChunk" + str _chunkType,_chunk];

		[_chunksToLoad,_chunk,_chunkType] call noe_collectAroundChunks;
		[_chunksToUnload,_prevChunk,_chunkType] call noe_collectAroundChunks;

		_x setvariable ["prevChunk" + str _chunkType,_chunk];
	} foreach cm_allInGameMobs;

	//отбраковываем лишние чанки
	{
		if ((_x in _chunksToUnload)) then {
			_chunksToUnload deleteAt (_chunksToUnload find _x);
		};
	} foreach _chunksToLoad;
};

noe_internal_loadTrigger = {
	params ["_obj"];
	private _posObj = getPosATL getVar(_obj,loc);
	private _chPos = [_posObj,callFunc(_obj,getChunkType)] call noe_posToChunk;
	{
		if equals(_x getVariable vec2("s_lcp",vec2(0,0)),_chPos) then {
			callFuncParams(_obj,onEnterArea,_x getVariable 'link');
		};	
		
		true;
	} count cm_allInGameMobs;
	
};	

_noe_onUpdateArea = {

	{
		_cps = [getposatl _x,CHUNK_TYPE_STRUCTURE] call noe_posToChunk;
		_prev_cps = _x getVariable vec2("s_lcp",vec2(0,0));
		if not_equals(_prev_cps,_cps) then {
			_x setVariable ["s_lcp",_cps];
			_usr = (_x getVariable 'link');
			_pch = [_prev_cps,CHUNK_TYPE_STRUCTURE] call noe_getChunkObject;
			{
				callFuncParams(pointerList get _x,onLeaveArea,_usr);
			} count (keys chunk_getObjectsData(_pch));

			_cch = [_cps,CHUNK_TYPE_STRUCTURE] call noe_getChunkObject;
			{
				callFuncParams(pointerList get _x,onEnterArea,_usr);
			} count (keys chunk_getObjectsData(_cch));
		};

		true;
	} count cm_allInGameMobs;

}; startUpdate(_noe_onUpdateArea,0.05);

#ifdef EDITOR
noe_onUpdateArea = _noe_onUpdateArea;
#endif

noe_getChunk = {
	params ["_pos_vec2","_chunkType"];

	private _posCh = [_pos_vec2,_chunkType] call noe_posToChunk;

	private _chunk = noe_chunkTypes get _chunkType;

	_posCh
};

//ридонли свойства
noe_getChunkSizeDecor = {chunkSize_decor};
noe_getChunkSizeStructure = {chunkSize_structure};
noe_getChunkSizeItem = {chunkSize_item};
