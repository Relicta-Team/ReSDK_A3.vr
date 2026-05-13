// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\host\lang.hpp>

namespace(NOEngine.Client.NetAtmos,noe_client_nat_)

#include "NOEngineClient_NetAtmos.hpp"
#include "..\..\host\struct.hpp"

//#define NOE_NETATMOS_ENABLE_DEBUG_ADD_ONMOUSE
macro_const(noe_client_nat_update_delay)
#define NOE_NETATMOS_UPDATE_DELAY 1

decl(bool())
noe_client_nat_isEnabled = {noe_client_nat_handleUpdate != -1};
decl(int)
noe_client_nat_handleUpdate = -1;
/*
	key-AreaId
	value-AtmosAreaClient
*/
decl(map<string;struct_t.AtmosAreaClient>)
noe_client_nat_areas = createHashMap;
decl(NULL|vector3)
noe_client_nat_prevArea = null;

decl(bool)
noe_client_nat_ltCfg_initialized = false;
//генерируемые ссылки с айди конфигов света для клиентских структур
decl(int[])
noe_client_nat_ltCfg_fire = [];
decl(int[])
noe_client_nat_ltCfg_smoke = [];
#ifdef NOE_CLIENT_NAT_ENABLE_COARSE_VISUALS
decl(int)
noe_client_nat_coarseVisualHandleUpdate = -1;
decl(int)
noe_client_nat_coarseOcclusionHandleUpdate = -1;
decl(int)
noe_client_nat_coarseOcclusionCount = 0;
decl(float)
noe_client_nat_coarseOcclusionPrevCallTime = 0;
decl(map<string;struct_t.AtmosAreaClient>)
noe_client_nat_coarseVisualDirtyAreas = createHashMap;
#endif

decl(void())
noe_client_nat_initializeLtCfg = {
	{
		noe_client_nat_ltCfg_fire set [_foreachIndex,_x call lightSys_getConfigIdByName];
	} foreach ["SLIGHT_ATMOS_FIRE_1","SLIGHT_ATMOS_FIRE_2","SLIGHT_ATMOS_FIRE_3"];

	{
		noe_client_nat_ltCfg_smoke set [_foreachIndex,_x call lightSys_getConfigIdByName];
	} foreach ["SLIGHT_ATMOS_SMOKE_1","SLIGHT_ATMOS_SMOKE_2","SLIGHT_ATMOS_SMOKE_3"];
};

#ifdef NOE_CLIENT_NAT_ENABLE_COARSE_VISUALS
decl(void())
noe_client_nat_processCoarseVisualQueue = {
	private _opsLeft = (floor (missionNamespace getVariable ["noe_client_nat_coarseVisualOpsPerFrame",NOE_CLIENT_NAT_COARSE_VISUAL_OPS_PER_FRAME])) max 0;
	private _dropAreas = [];
	{
		if ((_opsLeft > 0) && {_y callv(isLoaded)}) then {
			_opsLeft = _opsLeft - (_y callp(processCoarseVisualQueue,_opsLeft));
		};
		if (!(_y callv(isLoaded)) || {!(_y callv(hasPendingCoarseVisualOps))}) then {
			_dropAreas pushBack _x;
		};
	} foreach noe_client_nat_coarseVisualDirtyAreas;

	{
		noe_client_nat_coarseVisualDirtyAreas deleteAt _x;
	} foreach _dropAreas;
};

decl(void())
noe_client_nat_processCoarseOcclusion = {
	private _tmStart = tickTime;
	private _enabled = missionNamespace getVariable ["noe_client_nat_coarseOcclusionEnabled",true];
	private _items = [];

	{
		if (_y callv(isLoaded)) then {
			private _area = _y;
			private _occludedInArea = 0;
			{
				private _visual = _y;
				if ((_visual getv(batchIsLoaded)) && {(_visual getv(deleteAfter)) < 0}) then {
					_items pushBack _visual;
					if (_visual getv(isOccluded)) then {
						INC(_occludedInArea);
					};
				};
			} foreach (_area getv(coarseVisuals));
			_area setv(debugCoarseOccluded,_occludedInArea);
		};
	} foreach noe_client_nat_areas;

	if (!_enabled) exitWith {
		{
			_x callp(setOcclusionHidden,false);
		} foreach _items;
		{
			if (_y callv(isLoaded)) then {
				_y setv(debugCoarseOccluded,0);
			};
		} foreach noe_client_nat_areas;
		noe_client_nat_coarseOcclusionCount = 0;
		noe_client_nat_coarseOcclusionPrevCallTime = tickTime - _tmStart;
	};

	private _screenData = [];
	{
		private _data = _x callv(getOcclusionScreenData);
		if !isNullVar(_data) then {
			_data set [1,_foreachIndex];
			_screenData pushBack _data;
		};
	} foreach _items;

	private _allowFireOccludeSmoke = missionNamespace getVariable ["noe_client_nat_coarseOcclusionFireOccludesSmoke",true];
	private _overlapLimit = missionNamespace getVariable ["noe_client_nat_coarseOcclusionOverlap",NOE_CLIENT_NAT_COARSE_OCCLUSION_OVERLAP];
	private _depthLimit = missionNamespace getVariable ["noe_client_nat_coarseOcclusionDepth",NOE_CLIENT_NAT_COARSE_OCCLUSION_DEPTH];
	_overlapLimit = (_overlapLimit max 0) min 1;
	_depthLimit = _depthLimit max 0;

	_screenData sort true;
	private _accepted = [];
	private _hiddenItems = [];
	private _occludedTotal = 0;
	{
		_x params ["_dist","_sortId","_minX","_minY","_maxX","_maxY","_effType","_visual"];
		private _areaA = (((_maxX - _minX) max 0.001) * ((_maxY - _minY) max 0.001)) max 0.001;
		private _isOccluded = false;
		{
			_x params ["_distB","_sortIdB","_minXB","_minYB","_maxXB","_maxYB","_effTypeB","_visualB"];
			if ((_dist - _distB) < _depthLimit) then {continue};
			private _canOcclude = (_effType == _effTypeB)
				|| {_allowFireOccludeSmoke && {_effTypeB == NAT_ATMOS_EFFTYPE_FIRE && {_effType == NAT_ATMOS_EFFTYPE_SMOKE}}};
			if (!_canOcclude) then {continue};
			private _iw = ((_maxX min _maxXB) - (_minX max _minXB)) max 0;
			private _ih = ((_maxY min _maxYB) - (_minY max _minYB)) max 0;
			if (((_iw * _ih) / _areaA) >= _overlapLimit) then {
				_isOccluded = true;
				break;
			};
		} foreach _accepted;

		if (_isOccluded) then {
			_hiddenItems pushBack _visual;
			INC(_occludedTotal);
		} else {
			_accepted pushBack _x;
		};
	} foreach _screenData;

	{
		_x callp(setOcclusionHidden,_x in _hiddenItems);
	} foreach _items;

	{
		if (_y callv(isLoaded)) then {
			private _area = _y;
			private _occludedInArea = 0;
			{
				private _visual = _y;
				if ((_visual getv(batchIsLoaded)) && {(_visual getv(deleteAfter)) < 0 && {_visual getv(isOccluded)}}) then {
					INC(_occludedInArea);
				};
			} foreach (_area getv(coarseVisuals));
			_area setv(debugCoarseOccluded,_occludedInArea);
		};
	} foreach noe_client_nat_areas;

	noe_client_nat_coarseOcclusionCount = _occludedTotal;
	noe_client_nat_coarseOcclusionPrevCallTime = tickTime - _tmStart;
};

decl(void())
noe_client_nat_applyCoarseVisualBudgetAll = {
	{
		if (_y callv(isLoaded)) then {
			_y callv(rebuildCoarseVisuals);
		};
	} foreach noe_client_nat_areas;
};
#endif

#ifndef EDITOR
	#undef NOE_NETATMOS_ENABLE_DEBUG_ADD_ONMOUSE
#endif
decl(bool(bool))
noe_client_nat_setEnabled = {
	params ["_mode"];
	if equals(_mode,call noe_client_nat_isEnabled) exitWith {false};

	if (_mode) then {

		if (!noe_client_nat_ltCfg_initialized) then {
			noe_client_nat_ltCfg_initialized = true;
			call noe_client_nat_initializeLtCfg;
		};

		noe_client_nat_handleUpdate = startUpdate(noe_client_nat_onUpdate,NOE_NETATMOS_UPDATE_DELAY);
		#ifdef NOE_CLIENT_NAT_ENABLE_COARSE_VISUALS
		if (noe_client_nat_coarseVisualHandleUpdate == -1) then {
			noe_client_nat_coarseVisualHandleUpdate = startUpdate(noe_client_nat_processCoarseVisualQueue,NOE_CLIENT_NAT_COARSE_VISUAL_QUEUE_DELAY);
		};
		if (noe_client_nat_coarseOcclusionHandleUpdate == -1) then {
			noe_client_nat_coarseOcclusionHandleUpdate = startUpdate(noe_client_nat_processCoarseOcclusion,NOE_CLIENT_NAT_COARSE_OCCLUSION_DELAY);
		};
		#endif

		#ifdef NOE_NETATMOS_ENABLE_DEBUG_ADD_ONMOUSE
		[{
			params ["_button","_shift","_ctrl"];
			_pos = call interact_getCursorIntersectPos;
			if equals(_pos,vec3(0,0,0)) exitWith {};
			if (!_alt) then {_pos = _pos vectoradd [0,0,1]};
			private _aId = _pos call atmos_getAreaIdByPos;
			private _aObj = [_aid] call noe_client_nat_getArea;

			private _local = _pos call atmos_chunkPosToId call atmos_getLocalChunkIdInArea;
			private _id = _local call atmos_encodeChId;
			if (_button == 0) then {
				[_aObj,[[_id,ifcheck(_ctrl,2127,2125)]],true] call noe_client_nat_loadArea
			} else {
				[_aObj,[_id]]call noe_client_nat_deleteChunks;
			};
			_z = _local select 2;
			_aObj call ["mergeRegions",[_aObj get "_regions" select (_z-1),_z]];
			_aObj set ["toUpdateLevels",[]];

			
			true
		}] call inputDebug_addMouseEvent;
		#endif

	} else {
		stopUpdate(noe_client_nat_handleUpdate);
		noe_client_nat_handleUpdate = -1;
		#ifdef NOE_CLIENT_NAT_ENABLE_COARSE_VISUALS
		if (noe_client_nat_coarseVisualHandleUpdate != -1) then {
			stopUpdate(noe_client_nat_coarseVisualHandleUpdate);
			noe_client_nat_coarseVisualHandleUpdate = -1;
		};
		if (noe_client_nat_coarseOcclusionHandleUpdate != -1) then {
			stopUpdate(noe_client_nat_coarseOcclusionHandleUpdate);
			noe_client_nat_coarseOcclusionHandleUpdate = -1;
		};
		noe_client_nat_coarseOcclusionCount = 0;
		noe_client_nat_coarseVisualDirtyAreas = createHashMap;
		#endif
	};
	true;
};

//основной цикл обработки областей
decl(void())
noe_client_nat_onUpdate = {
	_mob = player;
	_arCenter = (getposatl _mob) call atmos_getAreaIdByPos;
	if isNull(noe_client_nat_prevArea) then {
		noe_client_nat_prevArea = _arCenter;
	};
	_prevCenter = noe_client_nat_prevArea;
	
	//update last area
	noe_client_nat_prevArea = _arCenter;
	
	_toLoad = [_arCenter] call atmos_getAroundAreas;
	_toUnload = [_prevCenter] call atmos_getAroundAreas;

	//отбраковка
	_idx = -1;
	{
		_idx = _toUnload find _x;
		if (_idx!=-1) then {
			_toUnload deleteAt _idx;
		};
	} foreach _toLoad;

	//выгрузка старых
	_aObj = null; //oftype AtmosAreaClient
	{
		_aObj = [_x] call noe_client_nat_getArea;
		if (_aObj getv(state) == NAT_LOADING_STATE_LOADED) then {
			[_aObj] call noe_client_nat_unloadArea;
		};
	} foreach _toUnload;

	//загружаем новые
	{
		_aObj = [_x] call noe_client_nat_getArea;
		if (_aObj getv(state) <= NAT_LOADING_STATE_NOT_LOADED) then {
			[_aObj] call noe_client_nat_requestLoad;
		};
	} foreach _toLoad;
};
//получение области. если область не создана - генерирует новую
decl(struct_t.AtmosAreaClient(vector3))
noe_client_nat_getArea = {
	params ["_areaId"];
	private _key = str _areaId;
	if isNull(noe_client_nat_areas get _key) then {
		noe_client_nat_areas set [_key,["AtmosAreaClient",[_areaId]] call struct_alloc];
	};
	noe_client_nat_areas get _key
};

decl(NULL|struct_t.AtmosAreaClient(vector3))
noe_client_nat_getAreaUnsafe = {
	params ["_areaId"];
	private _key = str _areaId;
	noe_client_nat_areas get _key
};

//запрос зоны на загрузку
decl(void(struct_t.AtmosAreaClient))
noe_client_nat_requestLoad = {
	params ["_areaObj"];
	_areaObj setv(state,NAT_LOADING_STATE_AWAIT_RESPONE);
	private _packet = [
		clientOwner,
		_areaObj get "areaId",
		_areaObj get "lastUpd"
	];
	rpcSendToServer(ATMOS_RPC_SERVER_REQUEST_AREA,_packet);
};

decl(void(struct_t.AtmosAreaClient;float))
noe_client_nat_requestDelExpired = {
	params ["_areaObj","_newTick"];
	_areaObj setv(lastDel,_newTick);
	private _idList = _areaObj callv(getChunkIdList);
	private _packet = [
		clientOwner,
		_areaObj get "areaId",
		_idList
	];
	rpcSendToServer(ATMOS_RPC_SERVER_DELETE_EXPIRED_CHUNKS,_packet);
};

//ответ от сервера
decl(void(...any[]))
noe_client_nat_onLoadArea = {
	private _packet = _this;
	assert(count _packet > 3);
	_aid = _packet select [0,3];
	_packet deleteRange [0,3];
	_upd = _packet deleteAt 0;
	_del = 0;
	_isUpdate = false;

	//правила кодирования подразумеваю что если z зоны меньше нуля 
	// то следующий после отметки времени элемент отметка удаления
	if (_upd >= 0) then {
		_del = _packet deleteAt 0;
	} else {
		//так же если это отрицательное число то это обновление
		_upd = abs _upd;
		_isUpdate = true;
	};

	assert_str((count _packet) % 2 == 0,"Packet must be even items count");

	_aObj = [_aid] call noe_client_nat_getArea;
	
	assert_str(_isUpdate == (_aObj callv(isLoaded)),"Internal update atmos area logic error; State was " + (str (_aObj getv(state))));
	
	if (!_isUpdate) then {
		_aObj setv(state,NAT_LOADING_STATE_LOADING);
	};

	_addList = [];
	_remList = [];
	if ([_packet,_addList,_remList] call noe_client_nat_decodePacket) then {
		[_aObj,_addList,_isUpdate] call noe_client_nat_loadArea;
		[_aObj,_remList] call noe_client_nat_deleteChunks;
		
		//_aObj callp(optimizeProcess, null);
		#ifdef NOE_CLIENT_NAT_ENABLE_COARSE_VISUALS
		_aObj callv(rebuildCoarseVisuals);
		#else
		#ifdef ENABLE_OPTIMIZATION
		if (count (_aObj getv(toUpdateLevels))>0)then{
			private _lvls = _aObj getv(toUpdateLevels);
			_aObj setv(toUpdateLevels,[]);
			private _regions = _aObj getv(_regions);
			{
				_aObj callp(mergeRegions,_regions select (_x-1) arg _x)
			} foreach _lvls;
			#ifdef NOE_CLIENT_NAT_ENABLE_VISUAL_BUDGET
			_aObj callp(applyRenderBudget,_lvls);
			#endif
		};
		#endif
		#endif

		if (_isUpdate) exitWith {};

		// Store delta marker only for full load responses; negative packets can be partial updates.
		_aObj setv(lastUpd,_upd);
		_aObj setv(state,NAT_LOADING_STATE_LOADED);

		if (_del > 0 && {_del != (_aObj getv(lastDel))}) then {
			[_aObj,_del] call noe_client_nat_requestDelExpired;
		};
	} else {
		errorformat("Error on unpack atmos area: %1", (str _aObj));
		
		if (_isUpdate) exitWith {};

		_aObj setv(state,NAT_LOADING_STATE_ERROR);
	};
};
rpcAdd(ATMOS_RPC_CLIENT_UPDATE_CHUNK,noe_client_nat_onLoadArea);

//декодирование пакета в массивы запросов
decl(bool(any[];any[];any[]))
noe_client_nat_decodePacket = {
	params ["_buff","_addList","_remList"];
	private _buffLen = count _buff;
	if (_buffLen%2!=0) exitWith {
		errorformat("Error on decoding packet, size %1",_buffLen);
		false;
	};
	private _chIdLoc = -1;
	private _cmd = null;
	for "_i" from 0 to _buffLen-1 step 2 do {
		_chIdLoc = _buff select _i;
		_cmd = _buff select (_i+1);
		if (_cmd==-1) then {
			_remList pushBack _chIdLoc;
		} else {
			_addList pushBack [_chIdLoc,_cmd];
		};
	};

	true
};

//обновление и загрузка зоны
decl(void(struct_t.AtmosAreaClient;any[];bool))
noe_client_nat_loadArea = {
	params ["_aObj",["_arrChDat",[]],["_isUpdateFlag",false]];//_arrChDat<locid,cmd_t>
	{
		_aObj call ["registerEffects",_x];
	} foreach _arrChDat;

	if (!_isUpdateFlag) then {
		_aObj call ["loadArea"];
		#ifndef NOE_CLIENT_NAT_ENABLE_COARSE_VISUALS
		[_aObj] call noe_client_nat_procLoad;
		#endif
	};
};

//процессор оптимизатора при загруке
decl(void(struct_t.AtmosAreaClient))
noe_client_nat_procLoad = {
	#ifdef ENABLE_OPTIMIZATION
	#ifndef NOE_CLIENT_NAT_ENABLE_COARSE_VISUALS
	params ["_aObj"];
	traceformat("============================== PROC[LOAD]: %1",_aObj)
	{
		private _ltObj = _y select NAT_CHUNKDAT_OBJECT;
		if !isNullVar(_ltObj) then {
			if !(_ltObj callv(isInsideRegion)) then {
				_aObj callp(optimizeSingle,_ltObj);
			};
		};
	} foreach (_aObj getv(chunks));

	private _lvls = _aObj getv(toUpdateLevels);
	_aObj setv(toUpdateLevels,[]);
	private _regions = _aObj getv(_regions);
	{
		_aObj callp(mergeRegions,_regions select (_x-1) arg _x)
	} foreach _lvls;
	#ifdef NOE_CLIENT_NAT_ENABLE_VISUAL_BUDGET
	_aObj callp(applyRenderBudget,_lvls);
	#endif
	#endif
	#endif
};

//процессор оптимизатора при выгрузке
decl(void(struct_t.AtmosAreaClient))
noe_client_nat_procUnload = {
	#ifdef ENABLE_OPTIMIZATION
	#ifndef NOE_CLIENT_NAT_ENABLE_COARSE_VISUALS
	params ["_aObj"];
	traceformat("============================== PROC[UNLOAD]: %1",_aObj)
	{
		{
			_x callv(unloadBatchEmitter);
		} foreach _x;
	} foreach (_aObj getv(_regions));
	#endif
	#endif
};

//добавление эффекторв (оптимизатор)
decl(void(struct_t.AtmosAreaClient;mesh))
noe_client_nat_procAddEff = {
	#ifdef ENABLE_OPTIMIZATION
	#ifndef NOE_CLIENT_NAT_ENABLE_COARSE_VISUALS
	params ["_aObj","_ltob"];
	traceformat("============================== PROC[ADD]: %1",_ltob)
	_aObj callp(optimizeSingle,_ltob);
	#endif
	#endif
};

//удаление эффекторв (оптимизатор)
decl(void(struct_t.AtmosAreaClient;mesh))
noe_client_nat_procDelEff = {
	#ifdef ENABLE_OPTIMIZATION
	#ifndef NOE_CLIENT_NAT_ENABLE_COARSE_VISUALS
	params ["_aObj","_ltob"];
	traceformat("============================== PROC[DELETE]: %1",_ltob)
	// private _ltObj = _chDat select NAT_CHUNKDAT_OBJECT;
			
	if (_ltob callv(isInsideRegion)) then {
		(_aObj callp(getRegionDatForVLight,_ltob)) params ["_foundRegion","_regions"];
		//!temporary code
		if !isNullVar(_foundRegion) then {
			//traceformat("founded region for unloading: %1",_foundRegion);
			_aObj callp(onDecreaseRegion,_regions arg _foundRegion arg _ltob);
		} else {
			_ltob setv(regionPosInfo,null);
		};
	};
	#endif
	#endif
};

//обновление эффекторв (оптимизатор)
decl(void(struct_t.AtmosAreaClient;mesh))
noe_client_nat_procUpdEff = {
	#ifdef ENABLE_OPTIMIZATION
	#ifndef NOE_CLIENT_NAT_ENABLE_COARSE_VISUALS
	params ["_aObj","_ltob"];
	traceformat("============================== PROC[UPDATE]: %1",_ltob)
	if (_ltob callv(isInsideRegion)) then {
		(_aObj callp(getRegionDatForVLight,_ltob)) params ["_region","_rgList"];
		if isNullVar(_region) exitWith {
			traceformat("Region not found for updated atmos light; rebuilding as single: %1 rpi %2",_ltob arg _ltob getv(regionPosInfo))
			_ltob setv(regionPosInfo,null);
			_ltob callv(reloadLight);
			_aObj callp(optimizeSingle,_ltob);
		};
		if (_region callp(isSameCfgType,_ltob)) then {
			//?what we need here?
		} else {
			_aObj callp(onDecreaseRegion,_rgList arg _region arg _ltob);
		};
	} else {
		_aObj callp(optimizeSingle,_ltob);
	};
	#endif
	#endif
};

decl(void(struct_t.AtmosAreaClient;int[]))
noe_client_nat_deleteChunks = {
	params ["_aObj","_arrChIds"];//_arrChIds<locid>
	{
		_aObj callp(deleteChunk,_x);
	} foreach _arrChIds;
};

//выгрузка зоны. обращаю внимание, что проверка состояния загруженности должна производиться снаружи функции
decl(void(struct_t.AtmosAreaClient))
noe_client_nat_unloadArea = {
	params ["_areaObj"];
	_areaObj setv(state,NAT_LOADING_STATE_NOT_LOADED);
	_areaObj call ["unloadArea"];
	[_areaObj] call noe_client_nat_procUnload;
	[_areaObj] call noe_client_nat_unsubscribeArea;
	//traceformat("Unloading area %1",_areaObj)
};

//снятие клиента с прослушки зоны
decl(void(struct_t.AtmosAreaClient))
noe_client_nat_unsubscribeArea = {
	params ["_areaObj"];
	private _aid = _areaObj getv(areaId);
	private _upacket = [clientOwner,_aid];
	rpcSendToServer(ATMOS_RPC_CLIENT_UNSUBSCRIBE_LISTEN_CHUNK,_upacket)
};

decl(int[])
noe_client_nat_const_nearList = [
	100,
	10,
	1
];

//находит соседний айди [0,0,0] - no offset; [-1,0,0] - x left
decl(int(int;vector3))
noe_client_nat_nearId = {
	params ["_id","_xyz"];
	private _baseId = _id;
	_xyz params ["_xp","_yp","_zp"];
	private _cnlst = noe_client_nat_const_nearList;
	modvar(_id) + (_xp * (_cnlst select 0));
	if (abs(_baseId - _id) >= 100) exitWith {null}; //out of bounds
	modvar(_id) + (_yp * (_cnlst select 1));
	if (abs(_baseId - _id) >= 10) exitWith {null}; //out of bounds
	modvar(_id) + (_zp * (_cnlst select 2));

	_id
};

//получает объект AtmosVirtualLight на указанной позиции
decl(mesh(vector3))
noe_client_getAtmosVirtualLight = {
	params ["_pos"];
	private _aId = _pos call atmos_getAreaIdByPos;
	private _aObj = [_aId] call noe_client_nat_getAreaUnsafe;
	if isNullVar(_aObj) exitWith {null};
	private _local = _pos call atmos_chunkPosToId call atmos_getLocalChunkIdInArea;
	private _id = _local call atmos_encodeChId;
	private _data = _aObj getv(chunks) get _id;
	if isNullVar(_data) exitWith {null};
	_data select NAT_CHUNKDAT_OBJECT
};

decl(NULL|struct_t.AtmosAreaClient(vector3))
noe_client_getAtmosArea = {
	params ["_pos"];
	private _aId = _pos call atmos_getAreaIdByPos;
	private _aObj = [_aId] call noe_client_nat_getAreaUnsafe;
	if isNullVar(_aObj) exitWith {null};
	_aObj
};

//-------------------------------------------
// atmos client extension 
//-------------------------------------------
#include "..\..\host\Atmos\Atmos_shared.sqf"
