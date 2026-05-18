// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\host\lang.hpp>

#include "..\..\host\struct.hpp"
#include "NOEngineClient_NetAtmos.hpp"
/*
	Структура зоны атмоса

	Процесс оптимизации происходит следующим образом:
	При обновлении зоны запускается полная валидация
	происходит проход по уровням.
		процесс сортировки:
		массив уровней собирает айди чанков:
		[
			[1,0,0],[1,0,1],[1,2,5] //level 1
			[2,0,0],[2,0,1],[2,2,5] //level 2
			null // no chunks at level 3
			etc...
		]

		процесс проверки:
		последовательно создаем зависимости

	Оптимизатор:

	Оптимизация основана на объединении (батчинге) блоков в регионы с упрощённой отрисовкой.

	При загрузке зоны:
		загружаем единичные и включаем батчинг
	При выгрузке: высвобождаем ресурсы

	При добавлении блока:
		если регионов нет
			optimizeSingle
			выполняем поиск смежных блоков на соответствие.
			достаточно одного соседнего блока для образования региона.
			после создания проверяем мержинг
		если регионы есть
			находим ближайший и проверяем возможность расширения
			после обновления проверяем мержинг

	При удалении блока:
		если в регионе
			удаляем блок с помощью onDecreaseRegion
			производим мерж новых зон при наличии
		иначе
			удаляем блок

	При изменении блока:
		если в регионе
			блок соответсвует типу региона
				обновляем конфиг и ничего не делаем
			иначе
				удаляем блок с помощью onDecreaseRegion
				производим мерж новых зон при наличии
		иначе
			обновляем блок
			находим ближайший и проверяем возможность расширения
			после обновления проверяем мержинг
*/


//отладочные линии
//#define ENABLE_DRAW_DEBUG_LINES_VIRTUALCHUNKS
//#define ENABLE_DRAW_DEBUG_LINES_REGIONS

//рандомные цвета для зон
macro_def(noe_client_nat_enable_randomization_color)
#define ENABLE_RANDOMIZATION_COLOR

//experimental visual budget. Runtime-tunable from debug console.
#ifdef NOE_CLIENT_NAT_ENABLE_VISUAL_BUDGET
decl(int) noe_client_nat_budgetMaxBatchRegionsPerZ = 3;
decl(int) noe_client_nat_budgetMaxBatchRegionsTotal = 5;
decl(int) noe_client_nat_budgetMaxSmokeBatchRegionsTotal = 5;
decl(int) noe_client_nat_budgetMaxSingleLightsPerZ = 8;
decl(int) noe_client_nat_budgetMaxSingleLightsTotal = 20;
decl(int) noe_client_nat_budgetMaxFireLights = 3;
#endif
#ifdef NOE_CLIENT_NAT_ENABLE_COARSE_VISUALS
decl(int) noe_client_nat_coarseBudgetMaxFireRegions = 8;
decl(int) noe_client_nat_coarseBudgetMaxSmokeRegions = 16;
decl(int) noe_client_nat_coarseBudgetMaxRegionsTotal = 24;
decl(int) noe_client_nat_coarseVisualOpsPerFrame = NOE_CLIENT_NAT_COARSE_VISUAL_OPS_PER_FRAME;
decl(float) noe_client_nat_coarseVisualTtl = NOE_CLIENT_NAT_COARSE_VISUAL_TTL;
decl(bool) noe_client_nat_coarseOcclusionEnabled = true;
decl(bool) noe_client_nat_coarseOcclusionFireOccludesSmoke = true;
decl(float) noe_client_nat_coarseOcclusionOverlap = NOE_CLIENT_NAT_COARSE_OCCLUSION_OVERLAP;
decl(float) noe_client_nat_coarseOcclusionDepth = NOE_CLIENT_NAT_COARSE_OCCLUSION_DEPTH;
#endif

#ifndef EDITOR
	#undef ENABLE_DRAW_DEBUG_LINES_VIRTUALCHUNKS
	#undef ENABLE_DRAW_DEBUG_LINES_REGIONS
	//!temporary
	#undef ENABLE_RANDOMIZATION_COLOR
#endif

struct(AtmosAreaClient)
	decl(string) def(areaId) null;
	decl(float) def(lastUpd) 0;
	decl(float) def(lastDel) 0;

	decl(int) def(state) NAT_LOADING_STATE_NOT_LOADED;
	decl(bool()) def(isLoaded) {(self getv(state)) == NAT_LOADING_STATE_LOADED}

	decl(map<int;any[]>) def(chunks) null; //key:localid,value vec2(cfg,obj)

	//хранящиеся регионы
	decl(any[]) def(_regions) null //list[9] -> list<AtmosClientBatchRegion

	decl(int[]) def(toUpdateLevels) null
	#ifdef NOE_CLIENT_NAT_ENABLE_COARSE_VISUALS
	decl(map<string;any>) def(coarseVisuals) null
	decl(int) def(debugCoarseFire) 0
	decl(int) def(debugCoarseSmoke) 0
	decl(int) def(debugCoarsePending) 0
	decl(int) def(debugCoarseOccluded) 0
	#endif
	#ifdef NOE_CLIENT_NAT_ENABLE_VISUAL_BUDGET
	decl(int) def(debugActiveFireLights) 0
	decl(int) def(debugActiveBatchRegions) 0
	decl(int) def(debugActiveSmokeBatchRegions) 0
	decl(int) def(debugActiveSingles) 0
	#endif

	decl(void(string)) def(init)
	{
		params ["_aId"];
		self setv(areaId,_aId);
		self setv(chunks,createHashMap);
		private _lst = [];
		_lst resize ATMOS_AREA_SIZE;

		self setv(_regions,_lst apply {[]});

		self setv(toUpdateLevels,[]);
		#ifdef NOE_CLIENT_NAT_ENABLE_COARSE_VISUALS
		self setv(coarseVisuals,createHashMap);
		#endif
	}

	//регистрация|перерегистрация эффектов в зоне
	decl(void(int;int)) def(registerEffects)
	{
		params ["_locid","_light"];
		private _isExist = _locid in (self getv(chunks));
		if (_isExist) then {
			self getv(chunks) get _locid set [NAT_CHUNKDAT_CFG,_light];
		} else {
			self getv(chunks) set [_locid,NAT_CHUNKDAT_NEW(_light)];
		};

		if (self callv(isLoaded)) then {
			#ifndef NOE_CLIENT_NAT_ENABLE_COARSE_VISUALS
			self callp(onUpdateChunk,_locid);

			// private _lt = self getv(chunks) get _locid select NAT_CHUNKDAT_OBJECT;
			// self callp(optimizeSingle,_lt);
			if (_isExist) then {
				[self, self getv(chunks) get _locid select NAT_CHUNKDAT_OBJECT] call noe_client_nat_procUpdEff;
			} else {
				[self, self getv(chunks) get _locid select NAT_CHUNKDAT_OBJECT] call noe_client_nat_procAddEff;
			};
			#endif
		};
	}

	//снятие регистрации эффектов чанка. удаляет визуальный объект и выписывает чанк из хранилища
	decl(void(int)) def(unregisterEffects)
	{
		params ["_locid"];
		private _chDat = self getv(chunks) GET _locid;
		if !isNullVar(_chDat) then {
			self getv(chunks) deleteAt _locid;

			#ifndef NOE_CLIENT_NAT_ENABLE_COARSE_VISUALS
			private _ltObj = _chDat select NAT_CHUNKDAT_OBJECT;
			[self,_ltObj] call noe_client_nat_procDelEff;
			#endif

			// if (_ltObj callv(isInsideRegion)) then {
			// 	private _rpinf = _ltObj getv(regionPosInfo);
			// 	private _regions = self getv(_regions) select ((_coord select 2)-1);
			// 	private _foundRegion = null;
			// 	{
			// 		if (_x callp(isEqualPosInfo,_rpinf select 0 arg _rpinf select 1)) exitWith {
			// 			_foundRegion = _x;
			// 		};
			// 		false
			// 	} count _regions;
			// 	//!temporary code
			// 	if !isNullVar(_foundRegion) then {
			// 		traceformat("founded region for unloading: %1",_foundRegion);
			// 		self callp(onDecreaseRegion,_regions arg _foundRegion arg _ltObj);
			// 	};
			// };
		};
	}

	//загружает визуал зоны
	decl(void()) def(loadArea)
	{
		#ifndef NOE_CLIENT_NAT_ENABLE_COARSE_VISUALS
		{
			self callp(onUpdateChunk,_x);
		} foreach (self callv(getChunkIdList));
		#endif

		// {
		// 	{
		// 		_x callp(setRenderMode,true);
		// 		false
		// 	} count _x;
		// 	false
		// } count (self getv(_regions));

		//full load area
		//trace("------------ load area ------------")
		//self callp(optimizeProcess, null);
	}

	decl(void()) def(unloadArea)
	{
		#ifdef NOE_CLIENT_NAT_ENABLE_COARSE_VISUALS
		self callv(unloadCoarseVisuals);
		#else
		{
			private _levelRegions = _x;
			{
				private _region = _x;
				_region callv(unloadBatchEmitter);
				{
					_x setv(regionPosInfo,null);
				} foreach (_region getv(virtLights));
			} foreach _levelRegions;
			_levelRegions resize 0;
		} foreach (self getv(_regions));
		self setv(toUpdateLevels,[]);

		{
			private _ltObj = _y select NAT_CHUNKDAT_OBJECT;
			if !isNullVar(_ltObj) then {
				_ltObj setv(regionPosInfo,null);
			};
		} foreach (self getv(chunks));

		{
			self callp(unloadChunkInternal,_x);
		} foreach (self callv(getChunkIdList));
		#endif

		//unload regions
		// {
		// 	{
		// 		_x callv(unloadBatchEmitter);
		// 		false
		// 	} count _x;
		// 	false
		// } count (self getv(_regions));

		//full unload area
		//self callp(optimizeProcess, null);
	}

	decl(void(int)) def(loadChunkInternal)
	{
		params ["_locid"];
		//setup vars
		private _locChId = _locid call atmos_decodeChId;
		private _chid = [self getv(areaId),_locChId] call atmos_localChunkIdToGlobal;
		private _pos = (_chid call atmos_chunkIdToPos);

		private _cDat = self getv(chunks) get _locid;
		if isNullVar(_cDat) exitWith {
			errorformat("Error loading locid %1 in %2",_locid arg self);
		};
		private _light = _cDat select NAT_CHUNKDAT_CFG;

		private _basePos = _pos;
		//random offset position
		_pos = _pos vectorAdd [ATMOS_ADDITIONAL_RANGE_XY,ATMOS_ADDITIONAL_RANGE_XY,ATMOS_ADDITIONAL_RANGE_Z];

		//creating visuals
		private _ltObj = self callp(_createVisual,_light arg _pos arg _basePos arg _locChId);

		//saving data
		_cDat set [NAT_CHUNKDAT_OBJECT,_ltObj];
	}

	//вызывает обновление чанка при загруженной зоне
	decl(void(int)) def(onUpdateChunk)
	{
		params ["_locid"];
		private _cDat = self getv(chunks) get _locid;
		if isNullVar(_cDat) exitWith {};
		private _ltObj = _cDat select NAT_CHUNKDAT_OBJECT;
		if isNullVar(_ltObj) then {
			//create new object
			self callp(loadChunkInternal,_locid);
		} else {
			//update or create light
			private _ltCfg = _cDat select NAT_CHUNKDAT_CFG;
			_ltObj callp(updateLight,_ltCfg);
		};
	}

	decl(void(int)) def(unloadChunkInternal)
	{
		params ["_locid"];
		private _cDat = self getv(chunks) get _locid;

		if isNullVar(_cDat) exitWith {};
		private _ltObj = _cDat select NAT_CHUNKDAT_OBJECT;
		if isNullVar(_ltObj) exitWith {};
		self callp(_deleteVisual,_ltObj);

		//так как выгрузка чанка это не unregisterEffects то просто удаляем эмиттеры
		_ltObj callv(deleteEmitters);

		//_cDat set [NAT_CHUNKDAT_OBJECT,null];
	}

	decl(void(int)) def(deleteChunk)
	{
		params ["_locid"];
		private _needUpdate = false;
		if (_locid in (self getv(chunks))) then {
			#ifndef NOE_CLIENT_NAT_ENABLE_COARSE_VISUALS
			self callp(unloadChunkInternal,_locid);
			#endif
			_needUpdate = true;
		};
		self callp(unregisterEffects,_locid);

		//temporary region cleanup
		// private _locChId = _locid call atmos_decodeChId;
		// private _rlst = (self getv(_regions)) select ((_locChId select 2) - 1);
		// _rlst resize 0;

		//single level update
		if (_needUpdate) then {
			//self callp(optimizeProcess, _locid call atmos_decodeChId);
		};
	}

	#ifdef NOE_CLIENT_NAT_ENABLE_COARSE_VISUALS
	decl(void()) def(unloadCoarseVisuals)
	{
		{
			_y callv(deleteVisual);
		} foreach (self getv(coarseVisuals));
		self setv(coarseVisuals,createHashMap);
		self setv(debugCoarseFire,0);
		self setv(debugCoarseSmoke,0);
		self setv(debugCoarsePending,0);
		self setv(debugCoarseOccluded,0);
		noe_client_nat_coarseVisualDirtyAreas deleteAt (str (self getv(areaId)));
	}

	decl(int()) def(countPendingCoarseVisualOps)
	{
		private _pending = 0;
		{
			if (((_y getv(deleteAfter)) >= 0) || {(_y getv(visualDirty))}) then {
				INC(_pending);
			};
		} foreach (self getv(coarseVisuals));
		_pending
	}

	decl(bool()) def(hasPendingCoarseVisualOps)
	{
		(self callv(countPendingCoarseVisualOps)) > 0
	}

	decl(int(int)) def(processCoarseVisualQueue)
	{
		params ["_opsMax"];
		private _opsDone = 0;
		private _visuals = self getv(coarseVisuals);
		private _keysToDelete = [];
		private _now = tickTime;

		{
			if (_opsDone >= _opsMax) exitWith {};
			if (_y callp(isDeleteExpired,_now)) then {
				if (_y getv(batchIsLoaded)) then {
					_y callv(deleteVisual);
					INC(_opsDone);
				};
				_keysToDelete pushBack _x;
			};
		} foreach _visuals;

		{
			_visuals deleteAt _x;
		} foreach _keysToDelete;

		if (_opsDone < _opsMax) then {
			{
				if (_opsDone >= _opsMax) exitWith {};
				if (_y callv(applyPendingVisual)) then {
					INC(_opsDone);
				};
			} foreach _visuals;
		};

		self setv(debugCoarsePending,self callv(countPendingCoarseVisualOps));
		_opsDone
	}

	decl(void()) def(rebuildCoarseVisuals)
	{
		private _chunks = self getv(chunks);
		private _stats = createHashMap;
		private _visuals = self getv(coarseVisuals);
		private _fireCfgs = noe_client_nat_ltCfg_fire;
		private _smokeCfgs = noe_client_nat_ltCfg_smoke;

		{
			private _cfg = _y select NAT_CHUNKDAT_CFG;
			private _fireIdx = _fireCfgs find _cfg;
			private _smokeIdx = _smokeCfgs find _cfg;
			private _effType = -1;
			private _level = 0;
			if (_fireIdx != -1) then {
				_effType = NAT_ATMOS_EFFTYPE_FIRE;
				_level = _fireIdx + 1;
			} else {
				if (_smokeIdx != -1) then {
					_effType = NAT_ATMOS_EFFTYPE_SMOKE;
					_level = _smokeIdx + 1;
				};
			};
			if (_effType == -1) then {continue};

			private _loc = _x call atmos_decodeChId;
			private _gx = floor ((((_loc select 0) - 1) * NOE_CLIENT_NAT_COARSE_DIVS_XY) / ATMOS_AREA_SIZE);
			private _gy = floor ((((_loc select 1) - 1) * NOE_CLIENT_NAT_COARSE_DIVS_XY) / ATMOS_AREA_SIZE);
			private _gz = floor ((((_loc select 2) - 1) * NOE_CLIENT_NAT_COARSE_DIVS_Z) / ATMOS_AREA_SIZE);
			private _key = format["%1:%2:%3:%4",_effType,_gx,_gy,_gz];
			private _stat = _stats get _key;
			if isNullVar(_stat) then {
				_stat = [
					_effType,
					_gx,
					_gy,
					_gz,
					0,
					0,
					[ATMOS_AREA_SIZE + 1,ATMOS_AREA_SIZE + 1,ATMOS_AREA_SIZE + 1],
					[0,0,0],
					[0,0,0]
				];
				_stats set [_key,_stat];
			};

			_stat set [4,(_stat select 4) + _level];
			_stat set [5,(_stat select 5) + 1];

			private _mins = _stat select 6;
			private _maxs = _stat select 7;
			private _weighted = _stat select 8;
			for "_i" from 0 to 2 do {
				_mins set [_i,(_mins select _i) min (_loc select _i)];
				_maxs set [_i,(_maxs select _i) max (_loc select _i)];
				_weighted set [_i,(_weighted select _i) + ((_loc select _i) * _level)];
			};
		} foreach _chunks;

		private _getAxisBounds = {
			params ["_idx","_divs"];
			[
				(ceil ((_idx * ATMOS_AREA_SIZE) / _divs)) + 1,
				ceil (((_idx + 1) * ATMOS_AREA_SIZE) / _divs)
			]
		};

		private _selectLevel = {
			params ["_score","_oldLevel"];
			if (_oldLevel <= 0) exitWith {
				ifcheck(_score >= 0.66,3,ifcheck(_score >= 0.33,2,1))
			};
			private _newLevel = _oldLevel;
			if (_oldLevel <= 1) then {
				if (_score >= 0.72) then {
					_newLevel = 3;
				} else {
					if (_score >= 0.38) then {
						_newLevel = 2;
					};
				};
			} else {
				if (_oldLevel == 2) then {
					if (_score < 0.28) then {
						_newLevel = 1;
					} else {
						if (_score >= 0.72) then {
							_newLevel = 3;
						};
					};
				} else {
					if (_score < 0.28) then {
						_newLevel = 1;
					} else {
						if (_score < 0.58) then {
							_newLevel = 2;
						};
					};
				};
			};
			_newLevel
		};

		private _desired = createHashMap;
		{
			_y params ["_effType","_gx","_gy","_gz","_sumPower","_activeCount","_mins","_maxs","_weighted"];
			private _xb = [_gx,NOE_CLIENT_NAT_COARSE_DIVS_XY] call _getAxisBounds;
			private _yb = [_gy,NOE_CLIENT_NAT_COARSE_DIVS_XY] call _getAxisBounds;
			private _zb = [_gz,NOE_CLIENT_NAT_COARSE_DIVS_Z] call _getAxisBounds;
			private _groupVol = ((((_xb select 1) - (_xb select 0) + 1) max 1)
				* (((_yb select 1) - (_yb select 0) + 1) max 1)
				* (((_zb select 1) - (_zb select 0) + 1) max 1)) max 1;
			private _bboxVol = ((((_maxs select 0) - (_mins select 0) + 1) max 1)
				* (((_maxs select 1) - (_mins select 1) + 1) max 1)
				* (((_maxs select 2) - (_mins select 2) + 1) max 1)) max 1;

			private _densityScore = (_sumPower / (3 * _bboxVol)) min 1;
			private _massScore = sqrt ((_sumPower / (3 * _groupVol)) min 1);
			private _score = ((_densityScore * 0.85) + (_massScore * 0.15)) min 1;
			private _visual = _visuals get _x;
			private _oldLevel = ifcheck(isNullVar(_visual),0,_visual getv(cfgLevel));
			private _cfgLevel = [_score,_oldLevel] call _selectLevel;

			private _cfgList = if (_effType == NAT_ATMOS_EFFTYPE_FIRE) then {_fireCfgs} else {_smokeCfgs};
			private _cfg = _cfgList select (_cfgLevel - 1);
			private _startPos = [_xb select 0,_yb select 0,_zb select 0];
			private _sizes = [(_xb select 1) - (_xb select 0),(_yb select 1) - (_yb select 0)];
			private _zSize = (_zb select 1) - (_zb select 0);
			_desired set [_x,[_cfg,_cfgLevel,_effType,_startPos,_sizes,_zSize,_score,_activeCount]];
		} foreach _stats;

		private _readBudget = {
			params ["_var","_def"];
			private _value = missionNamespace getVariable [_var,_def];
			if (_value < 0) exitWith {1000000};
			(floor _value) max 0
		};
		private _maxFireRegions = ["noe_client_nat_coarseBudgetMaxFireRegions",8] call _readBudget;
		private _maxSmokeRegions = ["noe_client_nat_coarseBudgetMaxSmokeRegions",16] call _readBudget;
		private _maxRegionsTotal = ["noe_client_nat_coarseBudgetMaxRegionsTotal",24] call _readBudget;

		private _budgetItems = [];
		{
			_y params ["_cfg","_cfgLevel","_effType","_startPos","_sizes","_zSize","_score","_activeCount"];
			private _priority = (_score * 100000) + (_cfgLevel * 1000) + _activeCount;
			_budgetItems pushBack [_priority,_x,_effType];
		} foreach _desired;
		_budgetItems sort false;

		private _keep = createHashMap;
		private _fireKept = 0;
		private _smokeKept = 0;
		private _totalKept = 0;
		{
			_x params ["_priority","_key","_effType"];
			private _typeLimit = if (_effType == NAT_ATMOS_EFFTYPE_FIRE) then {_maxFireRegions} else {_maxSmokeRegions};
			private _typeKept = if (_effType == NAT_ATMOS_EFFTYPE_FIRE) then {_fireKept} else {_smokeKept};
			if ((_totalKept < _maxRegionsTotal) && {_typeKept < _typeLimit}) then {
				_keep set [_key,true];
				INC(_totalKept);
				if (_effType == NAT_ATMOS_EFFTYPE_FIRE) then {
					INC(_fireKept);
				} else {
					INC(_smokeKept);
				};
			};
		} foreach _budgetItems;

		{
			if !(_x in _keep) then {
				_desired deleteAt _x;
			};
		} foreach (keys _desired);

		private _now = tickTime;
		private _ttl = (missionNamespace getVariable ["noe_client_nat_coarseVisualTtl",NOE_CLIENT_NAT_COARSE_VISUAL_TTL]) max 0;
		{
			if !(_x in _desired) then {
				(_visuals get _x) callp(markInactive,_now + _ttl);
			};
		} foreach (keys _visuals);

		private _debugFire = 0;
		private _debugSmoke = 0;
		{
			_y params ["_cfg","_cfgLevel","_effType","_startPos","_sizes","_zSize","_score","_activeCount"];
			private _visual = _visuals get _x;
			if isNullVar(_visual) then {
				_visual = struct_newp(AtmosClientCoarseVisual,self arg _x arg _cfg arg _cfgLevel arg _effType arg _startPos arg _sizes arg _zSize arg _score arg _activeCount);
				_visuals set [_x,_visual];
			} else {
				_visual callp(updateVisual,_cfg arg _cfgLevel arg _effType arg _startPos arg _sizes arg _zSize arg _score arg _activeCount);
			};

			if (_effType == NAT_ATMOS_EFFTYPE_FIRE) then {
				INC(_debugFire);
			} else {
				INC(_debugSmoke);
			};
		} foreach _desired;

		self setv(debugCoarseFire,_debugFire);
		self setv(debugCoarseSmoke,_debugSmoke);
		self setv(debugCoarsePending,self callv(countPendingCoarseVisualOps));
		if (self callv(hasPendingCoarseVisualOps)) then {
			noe_client_nat_coarseVisualDirtyAreas set [str (self getv(areaId)),self];
		};
	}
	#endif


	decl(mesh(int;vector3;vector3;vector3)) def(_createVisual)
	{
		params ["_light","_pos","_basePos","_chid"];
		#ifdef NAT_DEBUG_ENABLE_VISUAL_HELPER
		private _vobj = "Sign_Arrow_F" createVehicleLocal [0,0,0];
		_vobj setvariable ["_basePos",_basePos];
		_vobj setposatl _pos;
		self set ["__debug_visual",_vobj];
		setLastError("this can be undefined behaviour because self is atmosareaclient. use atmosvirtualstruct to store __debug_visual");
		#endif

		private _obj = struct_newp(AtmosVirtualLight,_light arg _pos arg _chid arg _basePos);

		#ifdef ENABLE_DRAW_DEBUG_LINES_VIRTUALCHUNKS
		private _renderTask = [_basePos,[1,0,1,1],10,[vec3(-ATMOS_SIZE_HALF,-ATMOS_SIZE_HALF,-ATMOS_SIZE_HALF),vec3(ATMOS_SIZE_HALF,ATMOS_SIZE_HALF,ATMOS_SIZE_HALF)]] call debug_addRenderPos;
		_obj set ["_renderTask_ENABLE_DRAW_DEBUG_LINES",_renderTask];
		#endif

		_obj
	}

	decl(void(mesh)) def(_deleteVisual)
	{
		params ["_obj"];

		#ifdef NAT_DEBUG_ENABLE_VISUAL_HELPER
		deleteVehicle (self get "__debug_visual");
		#endif
		#ifdef ENABLE_DRAW_DEBUG_LINES_VIRTUALCHUNKS
		(_obj get "_renderTask_ENABLE_DRAW_DEBUG_LINES") callv(stopLoop);
		_obj set ["_renderTask_ENABLE_DRAW_DEBUG_LINES",null];
		#endif
	}

	//load or recreate light
	// def(_loadLight_depr)
	// {
	// 	params ["_light","_obj"];
	// 	private _lightObj = [_light,_obj] call le_loadLight;
	// 	_obj setvariable ["_atmos_light",_lightObj];

	// 	//! это пока работает плоховато...
	// 	// private _basePos = _obj getvariable "_basePos";
	// 	// if (self callp(hasSnapToDownCfg,_light)) then {
	// 	// 	private _itDat = [_basePos,_basePos vectorAdd [0,0,ATMOS_SIZE_HALF],_obj] call interact_getRayCastData;
	// 	// 	if !isNullReference(_itDat select 0) then {
	// 	// 		_obj setposatl ((_itDat select 1) vectoradd [ATMOS_ADDITIONAL_RANGE_XY,ATMOS_ADDITIONAL_RANGE_XY,0]);
	// 	// 	};
	// 	// };

	// 	_lightObj
	// }

	decl(bool(int)) def(hasSnapToDownCfg)
	{
		params ["_cfg"];
		_cfg in ["SLIGHT_ATMOS_FIRE_1" call lightSys_getConfigIdByName,"SLIGHT_ATMOS_FIRE_2" call lightSys_getConfigIdByName,"SLIGHT_ATMOS_FIRE_3" call lightSys_getConfigIdByName]
	}

	decl(int[]()) def(getChunkIdList)
	{
		keys (self getv(chunks))
	}

	decl(NULL|mesh(vector3)) def(getLightByPos)
	{
		params ["_ps"];
		private _chId = _ps call atmos_encodeChId;
		private _o = (self getv(chunks)) get _chId;
		if isNullVar(_o) exitWith {null};
		_o select NAT_CHUNKDAT_OBJECT
	}

	decl(string()) def(str)
	{
		format["Area%1",self getv(areaId)]
	}

	//полная оптимизация по уровням
	// def(optimizeProcess)
	// {
	// 	#ifndef ENABLE_OPTIMIZATION
	// 	if (true) exitWith {};
	// 	#endif
	// 	//_level list<Z-level>
	// 	params ["_levels"]; //Если параметр _level не равен null то это полная перегрузка зоны
	// 	traceformat("Start optimization of level %1",ifcheck(isNullVar(_levels),"ALL",_levels))
	// 	/*
	// 		1. группируем зоны по z
	// 		2. проходим все z уровни

	// 		TODO доп оптимизация. валидируем только уровень на который добавлен чанк

	// 		инфо:
	// 		мы можем делать доп оптимизацию по z
	// 		если в регионе сверху есть регион такого же уровня
	// 	*/
	// 	//collect zposes
	// 	private _chMap = self getv(chunks);

	// 	private _alist = [];
	// 	_alist resize (ATMOS_AREA_SIZE);
	// 	_alist = _alist apply {[]};
	// 	private _curZ = null;
	// 	private _obj = null;
	// 	private _mapAssoc = createhashMap;
	// 	if isNullVar(_levels) then {
	// 		private _chs = (self callv(getChunkIdList)) apply {[_x call atmos_decodeChId,_x]};
	// 		traceformat("  --- all objects count: %1",count _chs)

	// 		//full load
	// 		{
	// 			_x params ["_locPos","_chidloc"];
	// 			_curZ = (_locpos select 2);

	// 			(_alist select (_curZ-1)) pushBack _locPos;
	// 			_obj = _chMap get _chidloc select NAT_CHUNKDAT_OBJECT;
	// 			_mapAssoc set [_locPos,_obj];
	// 		} foreach _chs;
	// 	} else {
	// 		{
	// 			private _lvlList = self getv(_blockCoords) select (_x -1);
	// 			_lvllist sort true;
	// 			_alist set [_x-1,_lvllist];
	// 			{
	// 				_obj = _chMap get (_x call atmos_encodeChId) select NAT_CHUNKDAT_OBJECT;
	// 				_mapAssoc set [_x,_obj];
	// 				;false
	// 			} count _lvllist;
	// 		} foreach _levels;
	// 	};


	// 	private _obj = null;

	// 	// Функция для поиска максимального региона с текущей позиции
	// 	private _findMaxZone = {
	// 		params ["_pos", "_activeChunks","_curObj"];
	// 		_pos params ["_x","_y","_z"];

	// 		private _sizeX = 0;
	// 		private _sizeY = 0;

	// 		// Максимальное расширение по X
	// 		for "_i" from 1 to ATMOS_AREA_SIZE do {
	// 			private _pX = [_x + _i, _y, _z];

	// 			if (_pX in _processed) exitWith {};

	// 			// Проверяем, можем ли расшириться по X
	// 			if ((_pX in _activeChunks) && (_curObj callp(isSameCfgType, _mapAssoc get _pX))) then {
	// 				_sizeX = _i;
	// 			} else {
	// 				break;
	// 			};
	// 		};

	// 		// Максимальное расширение по Y при зафиксированной ширине _sizeX
	// 		for "_j" from 1 to ATMOS_AREA_SIZE do {
	// 			private _canExpandY = true;

	// 			for "_dx" from 0 to _sizeX do {
	// 				private _pY = [_x + _dx, _y + _j, _z];

	// 				if (_pY in _processed) exitWith {_canExpandY = false};

	// 				// Проверяем, можем ли расшириться по Y
	// 				if (!(_pY in _activeChunks) || !(_curObj callp(isSameCfgType, _mapAssoc get _pY))) then {
	// 					_canExpandY = false;
	// 					break;
	// 				};
	// 			};

	// 			if (_canExpandY) then {
	// 				_sizeY = _j;
	// 			} else {
	// 				break;
	// 			};
	// 		};

	// 		[_sizeX, _sizeY]
	// 	};

	// 	private _processZOpt = {
	// 		params ["_z","_activeChunks"];
	// 		private _optList = []; //сюда записываются объекты оптимизации

	// 		private _processed = []; // Отслеживание обработанных чанков для уровня

	// 		self getv(_regions) select (_z - 1) resize 0;

	// 		// Поиск регионов
	// 		{
	// 			private _pos = _x;

	// 			// Пропускаем уже обработанные чанки
	// 			if (_pos in _processed) then {
	// 				//traceformat("pos in processed; exit pos: %1",_pos);
	// 				continue;
	// 			};
	// 			//traceformat("process pos %1",_pos)

	// 			// Находим максимальный квадратный регион от этой позиции
	// 			private _curObj = _mapAssoc get _pos;
	// 			private _sizes = [_pos, _activeChunks,_curObj] call _findMaxZone;
	// 			traceformat("  Max size for pos %1 is %2", _pos arg _sizes)

	// 			//ограничение зоны по квадратам. Прим.: 5x5 - ok; 6x6 -> lower to 5
	// 			//_size = _size - (_size%2);

	// 			if equals(_sizes,vec2(0,0)) then {
	// 				//test hide
	// 				_optList pushBack (_mapAssoc get (_pos));
	// 				continue;
	// 			};


	// 			// Помечаем все чанки внутри найденного региона как обработанные
	// 			private _lproc = [];
	// 			private _curVlt = null;
	// 			for "_i" from 0 to (_sizes select 0) do {
	// 				for "_j" from 0 to (_sizes select 1) do {
	// 					private _chunkPos = _pos vectorAdd [_i,_j,0];
	// 					_processed pushBack _chunkPos;
	// 					_curVlt = _mapAssoc get _chunkPos;
	// 					_lproc pushBack _curVlt;
	// 					//_curVlt callp(setHidden,true);
	// 					//traceformat("  hide pos %1 exists %2",_chunkPos arg _chunkPos in _mapAssoc)
	// 				};
	// 			};

	// 			// Определяем центральную позицию для "огня"
	// 			private _centerPos = [
	// 				(_pos select 0) + floor((_sizes select 0) / 2),
	// 				(_pos select 1) + floor((_sizes select 1) / 2),
	// 				_z
	// 			];
	// 			traceformat("  unhide pos %1 exists %2",_centerPos arg _centerPos in _mapAssoc)
	// 			private _centerObj = _mapAssoc get _centerPos;
	// 			_centerObj callp(setHidden,false); //for debug
	// 			//_centerObj setv(renderZone,_sizes);
	// 			//смещение на следующую зону
	// 			// if (_size%2==1) then {
	// 			// 	_centerObj setv(useOffsetMid,true);
	// 			// };
	// 			//_centerObj callv(reloadLight);
	// 			private _curRegionList = self getv(_regions) select (_z - 1);
	// 			private _region = null;

	// 			// {
	// 			// 	if (_x callp(isEqualPosInfo,_pos arg _sizes)) exitWith {
	// 			// 		_region = _x;
	// 			// 	};
	// 			// 	false
	// 			// } count _curRegionList;
	// 			if isNullVar(_region) then {
	// 				_region = struct_newp(AtmosClientBatchRegion,self arg _sizes arg _pos arg _lproc);
	// 				_curRegionList pushBack _region;
	// 				_region callp(setRenderMode,true);
	// 			} else {
	// 				_region setv(virtLights,_lproc);
	// 				_region callp(setRenderMode,true);
	// 			};

	// 		} foreach _activeChunks;

	// 		//second optimization layer
	// 		private _ctrend = count _optList;
	// 		if (_ctrend > 0) then {
	// 			// {
	// 			// 	_x setv(decZoneRend,_ctrend);
	// 			// 	_x callv(reloadLight);
	// 			// 	false
	// 			// } count _optList;
	// 		};
	// 	};

	// 	{
	// 		private _z = _foreachIndex + 1;
	// 		if (count _x > 0) then {
	// 			traceformat(" ----- process zlevel: %1; count %2",_z arg count _x)
	// 			if isNullVar(_levels) then {
	// 				_x sort true; //by near to far
	// 			};
	// 			[_z,_x] call _processZOpt;
	// 		};
	// 	} foreach _alist;
	// }

	//оптимизация при доабвлении нового блока
	decl(void(struct_t.AtmosVirtualLight)) def(optimizeSingle)
	{
		params ["_vlight"];

		private _pos = _vlight getv(localChId);
		private _z = _pos select 2;
		private _regions = self getv(_regions) select (_z - 1);

		// Функция для поиска соседних регионов рядом с новым блоком
		private _findNeighborRegions = {
			private _neighborRegions = [];

			{
				private _startPos = _x getv(startPos);
				private _endPos = _x getv(endPos);
				(_x getv(sizes))params ["_sX","_sY"];
				_startPos params ["_pX","_pY"];
				private _center = [_pX+(_sX/2),_pY+(_sY/2)];

				if (_pos inArea [_center,_sX/2 + 1.5,_sY/2 + 1.5,0,true]) then {
					_neighborRegions pushBack _x;
				};

				// Проверка, находится ли регион рядом с добавляемым блоком
				// if (
				// 	((_pos select 0) >= (_startPos select 0) - 1 && {(_pos select 0) <= (_endPos select 0) + 1}) &&
				// 	{((_pos select 1) >= (_startPos select 1) - 1 && {(_pos select 1) <= (_endPos select 1) + 1})}
				// ) then {
				// 	_neighborRegions pushBack _x;
				// };
			} forEach _regions;

			_neighborRegions
		};

		private _nearRegions = call _findNeighborRegions;
		traceformat("NEAR REGIONS FOR POS %2: %1",_nearRegions arg _pos)

		private _singleOptimize = {
			traceformat("--- single check for make region %1",_vlight)

			private _tlocid = null;
			private _id = null;
			private _chmap = self getv(chunks);
			private _sizes = null;
			private _startPos = null;
			private _lproc = null;
			{
				_tlocid = _pos vectorAdd _x;
				_id = _tlocid call atmos_encodeChId;
				if (_id in _chmap) then {
					private _ob = _chmap get _id select NAT_CHUNKDAT_OBJECT;
					if (
						_vlight callp(isSameCfgType,_ob)
						&& {!(_ob callv(isInsideRegion))}
					) then {
						_lproc = [_vlight,_ob];
						_sizes = _x;
						_startPos = _pos;
						//negative
						if (_foreachIndex >= 2) then {
							_startPos = _pos vectorAdd _x;
							_sizes = _sizes vectorMultiply -1;
						};
						break;
					};
				};
			} foreach [
				[0,1],
				[1,0],
				[0,-1],
				[-1,0]
			];

			if !isNullVar(_lproc) then {
				_region = struct_newp(AtmosClientBatchRegion,self arg _sizes arg _startPos arg _lproc);
				_regions pushBack _region;
				#ifdef NOE_CLIENT_NAT_ENABLE_VISUAL_BUDGET
				_region callv(disableBudgetRender);
				#else
				_region callp(setRenderMode,true);
				#endif
			};
		};

		if (count _nearRegions == 0) exitWith {
			call _singleOptimize;
		};

		private _usedNear = false;
        {
            private _startPos = _x getv(startPos);
            private _endPos = _x getv(endPos);

			private _expandableRegion = null;
			private _expandAxis = -1; // Ось расширения: 0 — по X, 1 — по Y
			private _expandDirection = 0; // Направление: -1 для уменьшения, 1 для увеличения

			// Определяем, можно ли расширить по оси X или Y
			if ((_pos select 0) == (_endPos select 0) + 1) then {
				_expandAxis = 0;
				_expandDirection = 1; // Расширение по оси X в сторону увеличения
				_expandableRegion = _x;
			} else {
				if ((_pos select 0) == (_startPos select 0) - 1) then {
					_expandAxis = 0;
					_expandDirection = -1; // Расширение по оси X в сторону уменьшения
					_expandableRegion = _x;
				};
			};

			if (isNullVar(_expandableRegion)) then {
				if ((_pos select 1) == (_endPos select 1) + 1) then {
					_expandAxis = 1;
					_expandDirection = 1; // Расширение по оси Y в сторону увеличения
					_expandableRegion = _x;
				} else {
					if ((_pos select 1) == (_startPos select 1) - 1) then {
						_expandAxis = 1;
						_expandDirection = -1; // Расширение по оси Y в сторону уменьшения
						_expandableRegion = _x;
					};
				};
			};

			// Если нашли расширяемый регион, проверяем возможность расширения
			if (!isNullVar(_expandableRegion)) then {
				private _canExtend = true;
				traceformat("    extend check for %1 [dir: %2; idx: %3]",_expandableRegion arg _expandDirection arg _expandAxis)
				// Определяем координаты, по которым будет проходить проверка вдоль линии
				private _constCoord = _pos select _expandAxis; // Координата вдоль оси расширения
				private _otherAxis = if (_expandAxis == 0) then {1} else {0}; // Другая ось (перпендикулярная)

				// Проверка всех позиций вдоль линии расширения
				private _lts = [];
				private _bp = _startPos;
				private _ep = _endPos;
				if (_expandDirection < 0) then {
					swap_lvars(_bp,_ep);
				};
				traceformat("    validate from %1 to %2: [ct:%3; expDir:%4; expIdx:%5]",_bp arg _ep arg _constCoord arg _expandDirection arg _expandAxis)
				for "_i" from (_bp select _otherAxis) to (_ep select _otherAxis) step _expandDirection do {
					private _checkPos = [_i, _i, _pos select 2]; // Проверка позиции на уровне Z
					traceformat("      Check pos preblt: %1",_checkPos)
					_checkPos set [_expandAxis, _constCoord]; // Устанавливаем координату на линии расширения
					traceformat("      Check pos %1 (i:%2; expIdx:%3)",_checkPos arg _i arg _expandAxis)
					if !(self callp(_isValidCombPos,_checkPos arg _lts arg _expandableRegion)) then {
						_canExtend = false;
						break; // Если позиция занята, останавливаем проверку
					};

				};

				traceformat("    Expand condition: %1 for %2",_canExtend arg _expandableRegion)
				// Если можно расширить, выходим из цикла
				if (_canExtend) then {
					traceformat("    lts:%1",_lts)
					traceformat("    dir: %1; axI: %2; otaxI: %3; ccrd: %4",_expandDirection arg _expandAxis arg _otherAxis arg _constCoord)
					_expandableRegion callp(registerVL,_lts);
					if (_expandDirection > 0) then {
						private _szs = _expandableRegion getv(sizes);
						_szs set [_expandAxis, (_szs select _expandAxis) + 1];
					} else {
						private _sp = _expandableRegion getv(startPos);
						_sp set [_expandAxis, (_sp select _expandAxis) - 1];

						private _szs = _expandableRegion getv(sizes);
						_szs set [_expandAxis, (_szs select _expandAxis) + 1];
					};
					_expandableRegion callv(rebuildData);
					traceformat("UPDATED REGION: %1",_expandableRegion)
					#ifdef NOE_CLIENT_NAT_ENABLE_VISUAL_BUDGET
					_expandableRegion callv(disableBudgetRender);
					#else
					_expandableRegion callp(setRenderMode,true);
					#endif
					_usedNear = true;
					break;
				};
			};

       	} forEach _nearRegions;

		if (!_usedNear) then {
			call _singleOptimize;
		};

		self getv(toUpdateLevels) pushBackUnique _z;
		//self callp(mergeRegions,_regions arg _z);
	}

	//задане объединения регионов
	decl(void(struct_t.AtmosClientBatchRegion[];int)) def(mergeRegions)
	{
		params ["_regions","_z"];


		// Функция для проверки, можно ли объединить два региона
		private _canMerge = {
			params ["_regionA", "_regionB"];

			// Разные типы батчей
			if not_equals(_regionA getv(batchCfg),_regionB getv(batchCfg)) exitWith {false};

			//!performance
			//if (((_regionA getv(sizes)) findAny (_regionB getv(sizes)))==-1)exitWith{false};

			//!performance
			// if ([0,0]vectordistance(_regionA getv(sizes)) <= 4) exitWith {false};
			// if ([0,0]vectordistance(_regionB getv(sizes)) <= 4) exitWith {false};

			private _startA = _regionA getv(startPos);
			private _endA = _regionA getv(endPos);
			private _startB = _regionB getv(startPos);
			private _endB = _regionB getv(endPos);

			// Проверяем, находятся ли регионы на одном уровне по Z
			//if ((_startA select 2) != (_startB select 2)) exitWith {false};

			// Проверка по осям X и Y: регионы должны быть рядом
			private _adjacentX = ((_endA select 0) + 1 == (_startB select 0)) || {((_endB select 0) + 1 == (_startA select 0))};
			private _adjacentY = ((_endA select 1) + 1 == (_startB select 1)) || {((_endB select 1) + 1 == (_startA select 1))};

			// Считаем, что регионы можно объединить, если они прилегают по одной из осей
			(_adjacentX && {(_startA select 1 == _startB select 1)} && {(_endA select 1 == _endB select 1)}) ||
			{(_adjacentY && {(_startA select 0 == _startB select 0)} && {(_endA select 0 == _endB select 0)})}

		};

		// Процесс слияния двух регионов в новый
		private _merge = {
			params ["_regionA", "_regionB"];

			private _startA = _regionA getv(startPos);
			private _endA = _regionA getv(endPos);
			private _startB = _regionB getv(startPos);
			private _endB = _regionB getv(endPos);

			private _newStartPos = [
				(_startA select 0)min(_startB select 0),
				(_startA select 1)min(_startB select 1),
				_startA select 2
			];
			private _newEndPos = [
				(_endA select 0)max(_endB select 0),
				(_endA select 1)max(_endB select 1),
				_endA select 2
			];
			private _size = _newEndPos vectorDiff _newStartPos;
			private _sizes = _size select [0,2];

			private _lproc = [];
			_lproc append (_regionA getv(virtLights));
			_lproc append (_regionB getv(virtLights));

			_region = struct_newp(AtmosClientBatchRegion,self arg _sizes arg _newStartPos arg _lproc);
			// _regionA setv(sizes,_size select [0,2]);
			// _regionA setv(startPos,_newStartPos);
			// _regionA callv(rebuildData);

			_region
		};

		private _continueMerge = true;
		private _mergedRegions = _regions;
		traceformat("+++ region combine: curcount: %1",count _regions)
		// while {_continueMerge} do {
		// 	_continueMerge = false;

		// 	private _newRegions = [];
		// 	private _usedRegions = [];

		// 	for "_i" from 0 to (count _mergedRegions - 1) do {
		// 		private _regionA = _mergedRegions select _i;
		// 		//if (_regionA in _usedRegions) then {continue};

		// 		private _mergedRegion = _regionA;
		// 		private _mergedThisCycle = false;

		// 		for "_j" from (_i + 1) to (count _mergedRegions - 1) do {
		// 			private _regionB = _mergedRegions select _j;
		// 			//if (_regionB in _usedRegions) then {continue};

		// 			// Проверяем, можно ли объединить регионы
		// 			if ([_mergedRegion, _regionB] call _canMerge) then {
		// 				_mergedRegion = [_mergedRegion, _regionB] call _merge;
		// 				traceformat("+++created new region: %1",_mergedRegion)
		// 				_usedRegions pushBack _regionA;
		// 				_usedRegions pushBack _regionB;
		// 				_mergedThisCycle = true;
		// 				_continueMerge = true; // Повторить цикл после добавления объединенного региона
		// 				break;
		// 			};
		// 		};

		// 		_newRegions pushBack _mergedRegion;
		// 	};

		// 	_mergedRegions = _newRegions;
		// };
		private _iterCount = count _mergedRegions;
		private _anyMerge = false;
		while {_continueMerge} do {
			/*
				1 элемент вырезаем
					сверяем с оставшимися
						если можно объединить
							добавляем в конец новый регион
				если не добавлено
					возвращаем первый в конец
			*/
			_continueMerge = false;
			private _freq = _mergedRegions deleteAt 0;
			private _msz = _freq getv(sizes);
			//errorformat("  COMPARE REGION: %1",_freq);
			{
				//errorformat("  MERGE CHECK %1 to %2 => %3",_freq arg _x arg vec2(_freq,_x) call _canMerge);
				if ([_freq,_x] call _canMerge) then {
					_mergedRegion = [_freq,_x] call _merge;
					_freq callv(unloadBatchEmitter);
					_x callv(unloadBatchEmitter);
					array_remove(_mergedRegions,_x);
					_mergedRegions pushBack _mergedRegion;
					_continueMerge = true;
					_anyMerge = true;
					break;
				};
			} foreach _mergedRegions;
			DEC(_iterCount);
			if (!_continueMerge) then {_mergedRegions pushBack _freq};
			if (_iterCount>0)then{_continueMerge = true};
		};

		if (_anyMerge) then {
			#ifndef NOE_CLIENT_NAT_ENABLE_VISUAL_BUDGET
			{
				_x callp(setRenderMode,true);
			} foreach _mergedRegions;
			#endif
			traceformat("output regions: %1",_mergedRegions)
			self getv(_regions) set [(_z - 1),_mergedRegions];
		};
	}

	#ifdef NOE_CLIENT_NAT_ENABLE_VISUAL_BUDGET
	decl(void(int[])) def(applyRenderBudget)
	{
		params [["_levels",[]]];

		private _levelsToApply = [];
		for "_i" from 1 to ATMOS_AREA_SIZE do {
			_levelsToApply pushBack _i;
		};

		private _regionLevels = self getv(_regions);
		private _chunks = self getv(chunks);
		private _maxBatchRegionsPerZ = (floor (missionNamespace getVariable ["noe_client_nat_budgetMaxBatchRegionsPerZ",3])) max 0;
		private _maxBatchRegionsTotal = (floor (missionNamespace getVariable ["noe_client_nat_budgetMaxBatchRegionsTotal",5])) max 0;
		private _maxSmokeBatchRegionsTotal = (floor (missionNamespace getVariable ["noe_client_nat_budgetMaxSmokeBatchRegionsTotal",2])) max 0;
		private _maxSingleLightsPerZ = (floor (missionNamespace getVariable ["noe_client_nat_budgetMaxSingleLightsPerZ",1])) max 0;
		private _maxSingleLightsTotal = (floor (missionNamespace getVariable ["noe_client_nat_budgetMaxSingleLightsTotal",30])) max 0;
		private _maxFireLights = (floor (missionNamespace getVariable ["noe_client_nat_budgetMaxFireLights",3])) max 0;
		private _batchRegionScores = [];
		private _fireRegionScores = [];

		{
			private _z = _x;
			private _regions = _regionLevels select (_z - 1);
			private _regionScores = [];
			{
				_regionScores pushBack [-(count (_x getv(virtLights))),_foreachIndex,_x];
			} foreach _regions;
			_regionScores sort true;

			private _activeRegions = [];
			{
				if (count _activeRegions < _maxBatchRegionsPerZ) then {
					private _region = _x select 2;
					_activeRegions pushBack _region;
					_batchRegionScores pushBack [_x select 0,_z,_foreachIndex,_region];
				};
			} foreach _regionScores;
		} foreach _levelsToApply;

		_batchRegionScores sort true;
		private _activeBatchRegions = [];
		private _activeSmokeBatchRegions = 0;
		{
			if (count _activeBatchRegions >= _maxBatchRegionsTotal) then {continue};
			private _region = _x select 3;
			private _effType = _region getv(effType);
			if (_effType == NAT_ATMOS_EFFTYPE_SMOKE) then {
				if (_activeSmokeBatchRegions >= _maxSmokeBatchRegionsTotal) then {continue};
				INC(_activeSmokeBatchRegions);
			};
			_activeBatchRegions pushBack _region;
			if (_effType == NAT_ATMOS_EFFTYPE_FIRE) then {
				_fireRegionScores pushBack _x;
			};
		} foreach _batchRegionScores;

		_fireRegionScores sort true;
		private _fireLightRegions = [];
		{
			if (count _fireLightRegions < _maxFireLights) then {
				_fireLightRegions pushBack (_x select 3);
			};
		} foreach _fireRegionScores;

		private _activeFireLights = count _fireLightRegions;
		private _debugActiveBatchRegions = 0;
		private _debugActiveSingles = 0;
		private _activeSinglesTotal = 0;

		{
			private _z = _x;
			if (_z < 1 || {_z > ATMOS_AREA_SIZE}) then {continue};

			private _regions = _regionLevels select (_z - 1);
			{
				if (_x in _activeBatchRegions) then {
					if ((_x getv(effType)) == NAT_ATMOS_EFFTYPE_FIRE) then {
						_x setv(fireLightEnabled,_x in _fireLightRegions);
					} else {
						_x setv(fireLightEnabled,true);
					};
					_x callv(enableBudgetRender);
					INC(_debugActiveBatchRegions);
				} else {
					_x setv(fireLightEnabled,false);
					_x callv(disableBudgetRender);
				};
			} foreach _regions;

			private _singleScores = [];
			{
				private _ltObj = _y select NAT_CHUNKDAT_OBJECT;
				if !isNullVar(_ltObj) then {
					if (!(_ltObj callv(isInsideRegion)) && {((_ltObj getv(localChId)) select 2) == _z}) then {
						_singleScores pushBack [_x,_ltObj];
					};
				};
			} foreach _chunks;
			_singleScores sort true;

			private _activeSingles = 0;
			{
				private _ltObj = _x select 1;
				private _isFire = _ltObj callv(isFireType);
				if (_isFire) then {
					if (_activeFireLights >= _maxFireLights) then {
						_ltObj callv(disableSingleRender);
						continue;
					};
				};
				if (_activeSingles < _maxSingleLightsPerZ && {_activeSinglesTotal < _maxSingleLightsTotal}) then {
					_ltObj callv(enableSingleRender);
					INC(_activeSingles);
					INC(_activeSinglesTotal);
					INC(_debugActiveSingles);
					if (_isFire) then {
						INC(_activeFireLights);
					};
				} else {
					_ltObj callv(disableSingleRender);
				};
			} foreach _singleScores;
		} foreach _levelsToApply;

		self setv(debugActiveFireLights,_activeFireLights);
		self setv(debugActiveBatchRegions,_debugActiveBatchRegions);
		self setv(debugActiveSmokeBatchRegions,_activeSmokeBatchRegions);
		self setv(debugActiveSingles,_debugActiveSingles);
	}
	#endif

	decl(bool(vector3;mesh[];struct_t.AtmosClientBatchRegion)) def_ret(_isValidCombPos)
	{
		params ["_pos","_lts","_region"];

		private _id = _pos call atmos_encodeChId;
		private _chs = self getv(chunks);
		if !(_id in _chs) exitWith {false};
		private _obj = _chs get _id select NAT_CHUNKDAT_OBJECT;
		if (_obj callv(isInsideRegion)) exitWith {false};

		//check type of config
		if !(_region callp(isSameCfgType,_obj)) exitWith {false};

		_lts pushBack _obj;
		true
	}

	//событие при удалении блока с региона
	decl(void(struct_t.AtmosClientBatchRegion[];struct_t.AtmosClientBatchRegion;mesh)) def(onDecreaseRegion)
	{
		params ["_regionList","_region","_ltObj"];

		[_region getv(virtLights),_ltObj] call arrayDeleteItem;
		_ltObj setv(regionPosInfo,null);
		_ltObj callv(reloadLight);

		private _pos = _ltObj getv(localChId);

		private _startPos = _region getv(startPos);
		private _endPos = _region getv(endPos);

		//removing region from list
		[_regionList,_region] call arrayDeleteItem;
		_region callv(unloadBatchEmitter);

		if ((_region getv(zSize)) > 0) exitWith {
			{
				_x setv(regionPosInfo,null);
				_x callv(reloadLight);
				self getv(toUpdateLevels) pushBackUnique ((_x getv(localChId)) select 2);
			} foreach (_region getv(virtLights));
		};

		// Если блок внутри региона, нужно разбить на несколько подрегионов
		private _newRegions = [];
		private _splitX = _pos select 0;
		private _splitY = _pos select 1;

		// Подрегион верхний (если есть)
		if (_splitY > (_startPos select 1)) then {
			private _upperRegion = [
				[_startPos select 0, _startPos select 1, _startPos select 2],
				[_endPos select 0, _splitY - 1, _endPos select 2]
			];
			_newRegions pushBack _upperRegion;
		};

		// Подрегион нижний (если есть)
		if (_splitY < (_endPos select 1)) then {
			private _lowerRegion = [
				[_startPos select 0, _splitY + 1, _startPos select 2],
				[_endPos select 0, _endPos select 1, _endPos select 2]
			];
			_newRegions pushBack _lowerRegion;
		};

		// Подрегион левый (если есть)
		if (_splitX > (_startPos select 0)) then {
			private _leftRegion = [
				[_startPos select 0, _splitY, _startPos select 2],
				[_splitX - 1, _splitY, _endPos select 2]
			];
			_newRegions pushBack _leftRegion;
		};

		// Подрегион правый (если есть)
		if (_splitX < (_endPos select 0)) then {
			private _rightRegion = [
				[_splitX + 1, _splitY, _startPos select 2],
				[_endPos select 0, _splitY, _endPos select 2]
			];
			_newRegions pushBack _rightRegion;
		};

		private _vligts = _region getv(virtLights);
		{
			_x params ["_sp","_ep"];
			private _sizes = _ep vectorDiff _sp select [0,2];
			//traceformat("...split before: %1->%2",_sp arg _sizes)
			//empty zone, skip
			if equals(_sizes,vec2(0,0)) then {continue};

			private _lproc = _vligts select {
				private _ps = _x getv(localChId);
				inRange(_ps select 0,_sp select 0,_ep select 0)
				&& {inRange(_ps select 1,_sp select 1,_ep select 1)}
			};

			//skip region with only one lproc
			if (count _lproc <= 1) then {continue};

			//remove lights
			_vligts = _vligts - _lproc;

			//traceformat("spliting: %1->%2 cnt: %3",_sp arg _sizes arg count _lproc)
			private _r = struct_newp(AtmosClientBatchRegion,self arg _sizes arg _sp arg _lproc);
			_regionList pushBack _r;
			#ifdef NOE_CLIENT_NAT_ENABLE_VISUAL_BUDGET
			_r callv(disableBudgetRender);
			#else
			_r callp(setRenderMode,true);
			#endif
		} foreach _newRegions;

		//enable left lights
		{
			_x setv(regionPosInfo,null); //remove region info
			_x callv(reloadLight);
		} foreach _vligts;
		//traceformat("LEFT VLIGHTS: %1",_vligts apply {_x getv(localChId)})

		private _z = (_pos select 2);
		self getv(toUpdateLevels) pushBackUnique _z;
		//self callp(mergeRegions,_regionList arg _z);
	}

	//возвращает данные региона объекта света. первый элемент - объект региона, второй массив z-уровня региона
	decl(any[](any)) def(getRegionDatForVLight)
	{
		params ["_ltob"];
		private _rpinf = _ltob getv(regionPosInfo);
		private _coord = _ltob getv(localChId);
		private _regionLevels = self getv(_regions);
		private _regions = _regionLevels select ((_coord select 2)-1);
		private _foundRegion = null;

		{
			if (_ltob in (_x getv(virtLights))) exitWith {
				_foundRegion = _x;
			};
		} foreach _regions;

		if isNullVar(_foundRegion) then {
			{
				private _levelRegions = _x;
				{
					if (_ltob in (_x getv(virtLights))) exitWith {
						_foundRegion = _x;
						_regions = _levelRegions;
					};
				} foreach _levelRegions;
				if !isNullVar(_foundRegion) exitWith {};
			} foreach _regionLevels;
		};

		if !isNullVar(_foundRegion) exitWith {
			_ltob setv(regionPosInfo,vec2(_foundRegion getv(startPos),_foundRegion getv(sizes)));
			[_foundRegion,_regions]
		};

		if isNullVar(_rpinf) exitWith {[_foundRegion,_regions]};

		{
			if (_x callp(isEqualPosInfo,_rpinf select 0 arg _rpinf select 1)) exitWith {
				_foundRegion = _x;
			};
		} foreach _regions;

		if isNullVar(_foundRegion) then {
			{
				private _levelRegions = _x;
				{
					if (_x callp(isEqualPosInfo,_rpinf select 0 arg _rpinf select 1)) exitWith {
						_foundRegion = _x;
						_regions = _levelRegions;
					};
				} foreach _levelRegions;
				if !isNullVar(_foundRegion) exitWith {};
			} foreach _regionLevels;
		};
		if !isNullVar(_foundRegion) then {
			_ltob setv(regionPosInfo,vec2(_foundRegion getv(startPos),_foundRegion getv(sizes)));
		};
		[_foundRegion,_regions]
	}

endstruct

#ifdef NOE_CLIENT_NAT_ENABLE_VISUAL_BUDGET
decl(void())
noe_client_nat_applyRenderBudgetAll = {
	{
		if (_y callv(isLoaded)) then {
			_y callp(applyRenderBudget,[]);
		};
	} foreach noe_client_nat_areas;
};
#endif

struct(AtmosVirtualLight)
	decl(mesh[]) def(effects) null;
	decl(int) def(id) -1; //config id
	decl(vector3) def(localChId) null; //local chunk id from [1,1,1] to [10,10,10]
	decl(int) def(localId) null //id from 1 to 1000

	decl(any[]) def(regionPosInfo) null; //vec2<Pos3d,Pos2d>
	decl(bool()) def(isInsideRegion) {!isNull(self getv(regionPosInfo))};

	//do not change this constval
	decl(int[]) def(_fireTypes) noe_client_nat_ltCfg_fire;
	decl(int[]) def(_smokeTypes) noe_client_nat_ltCfg_smoke;
	//check if atmos if firetype
	decl(bool()) def(isFireType) {(self getv(id)) in (self getv(_fireTypes))}
	decl(bool()) def(isSmokeType) {(self getv(id)) in (self getv(_smokeTypes))}

	decl(int) def(effType) -1; //NAT_ATMOS_EFFTYPE_
	#ifdef NOE_CLIENT_NAT_ENABLE_VISUAL_BUDGET
	#ifdef ENABLE_OPTIMIZATION
	decl(bool) def(renderEnabled) false
	#else
	decl(bool) def(renderEnabled) true
	#endif
	#endif

	decl(void(int;vector3;vector3;vector3)) def(init)
	{
		params ["_cfg","_pos","_lcid","_ctrPos"];
		self setv(localChId,_lcid);
		self setv(localId,_lcid call atmos_encodeChId);
		self callp(loadEmitters,_cfg arg _pos);

		self setv(centerPos,_ctrPos);
	}

	decl(void(int;vector3)) def(loadEmitters)
	{
		params ["_cfg","_pos"];

		self setv(id,_cfg);
		self setv(_pos,_pos);

		if (self callv(isFireType)) then {
			self setv(effType,NAT_ATMOS_EFFTYPE_FIRE);
		};
		if (self callv(isSmokeType)) then {
			self setv(effType,NAT_ATMOS_EFFTYPE_SMOKE);
		};

		#ifdef NOE_CLIENT_NAT_ENABLE_VISUAL_BUDGET
		if ((self getv(renderEnabled)) && {!(self callv(isInsideRegion))}) then {
			self setv(effects,[_cfg arg _pos] call le_se_createUnmanagedEmitter);
		} else {
			self setv(effects,[]);
		};
		#else
		//can load only outside region
		if !(self callv(isInsideRegion)) then {
			self setv(effects,[_cfg arg _pos] call le_se_createUnmanagedEmitter);
		};
		#endif
	}

	decl(void()) def(deleteEmitters)
	{
		private _effects = self getv(effects);
		if isNullVar(_effects) exitWith {
			self setv(effects,[]);
		};
		{
			deleteVehicle _x;
		} foreach _effects;
		[0] call lesc_onLightRemove;
		self setv(effects,[]);
	}

	#ifdef NOE_CLIENT_NAT_ENABLE_VISUAL_BUDGET
		decl(void()) def(enableSingleRender)
		{
			self setv(renderEnabled,true);
			private _effects = self getv(effects);
			if (isNullVar(_effects) || {count _effects == 0}) then {
				self callv(reloadLight);
			};
		}

		decl(void()) def(disableSingleRender)
		{
			self setv(renderEnabled,false);
			self callv(deleteEmitters);
		}
	#endif

	decl(vector3) def(_pos) [0,0,0];

	decl(vector3()) def(getEmitterPos)
	{
		self getv(_pos)
	}

	decl(vector3()) def(getEmitterRealPos)
	{
		private _p = self getv(_unhide_pos);
		if !isNullVar(_p) then {
			_p
		} else {
			self getv(_pos)
		};
	}

	decl(void(vector3)) def(setEmitterPos)
	{
		params ["_pos"];
		private _eff = self getv(effects);
		if isNullVar(_eff) exitWith {};
		if (count _eff == 0) exitWith {};
		private _baseObj = _eff select 0;
		private _basePos = getPosAtl _baseObj;
		self setv(_pos,_pos);
		_baseObj setPosAtl _pos;
		private _offList = [];
		{
			_curOffset = _x worldToModelVisual _basePos;
			_x setPosAtl (_pos vectorAdd _curOffset);
		} foreach (_eff select [1,count _eff]);
	}

	decl(NULL|vector3) def(_unhide_pos) null;
	decl(bool()) def(isHidden) {!isNull(self getv(_unhide_pos))}
	decl(bool(bool)) def(setHidden)
	{
		params ["_mode"];
		if equals(_mode,self callv(isHidden)) exitWith {false};

		if (_mode) then {
			private _curPos = self callv(getEmitterPos);
			self setv(_unhide_pos,_curPos);

			#ifdef NAT_DEBUG_ENABLE_VISUAL_HELPER
			_s = "Sign_Sphere10cm_F" createVehicleLocal [0,0,0];
			_s setObjectTexture [0,"#(rgb,8,8,3)color(1,0,0,1)"];
			_s setposatl (self callv(getEmitterPos));
			self setv(__sphereDebugHidden,_s);
			#endif

			self callp(setEmitterPos,_curPos vectorAdd vec3(0,0,-1000));
		} else {

			#ifdef NAT_DEBUG_ENABLE_VISUAL_HELPER
			deleteVehicle (self getv(__sphereDebugHidden));
			#endif

			self callp(setEmitterPos,(self getv(_unhide_pos)) );
			self setv(_unhide_pos,null);
		};

		true
	}

	decl(void()) def(del)
	{
		self callv(deleteEmitters);
	}

	decl(void(int)) def(updateLight)
	{
		params ["_cfg"];
		private _pos = self callv(getEmitterRealPos);
		if equals(_pos,vec3(0,0,0)) exitWith {
			private _dta = [self arg self getv(effects) arg count (self getv(effects)) arg _pos];
			if (count (self getv(effects)) > 0) then {
				_dta pushBack ["effposes:",(self getv(effects))apply {getposatl _x}];
			};
			setLastError("Invalid emitter position; ctx: "+str _dta);
		};
		self callv(deleteEmitters);
		self callp(loadEmitters,_cfg arg _pos);
	}

	//simple reload light by config
	decl(void()) def(reloadLight)
	{
		self callp(updateLight,self getv(id));
	}

	decl(bool(struct_t.AtmosVirtualLight)) def(isSameCfgType)
	{
		params ["_check"];
		//(_check getv(id)) == (self getv(id))
		private _equal = false;
		call {
			if ((self callv(isFireType)) && {_check callv(isFireType)}) exitWith {_equal = true};
			if ((self callv(isSmokeType)) && {_check callv(isSmokeType)}) exitWith {_equal = true};
		};
		_equal
	}

	decl(string()) def(str)
	{
		format["%1%3(%2)",struct_typename(self),self getv(id),self getv(localChId)]
	}
endstruct

//структура региона
#ifdef NOE_CLIENT_NAT_ENABLE_COARSE_VISUALS
struct(AtmosClientCoarseVisual)
	decl(string) def(key) ""
	decl(vector3) def(areaId) null
	decl(vector3) def(startPos) [0,0,0]
	decl(vector2) def(sizes) [0,0]
	decl(int) def(zSize) 0
	decl(int) def(batchCfg) -1
	decl(int) def(cfgLevel) 0
	decl(int) def(effType) -1
	decl(vector3) def(batchPos) [0,0,0]
	decl(bool) def(batchIsLoaded) false
	decl(mesh[]) def(emitter) null
	decl(float) def(score) 0
	decl(int) def(activeCount) 0
	decl(bool) def(visualDirty) false
	decl(float) def(deleteAfter) -1
	decl(bool) def(isOccluded) false
	decl(any[]) def(_occlusion_cache) null
	decl(int) def(_fireLightIdx) -1
	decl(float) def(_fireLightIntensity) 0

	decl(void(struct_t.AtmosAreaClient;string;int;int;int;vector3;vector2;int;float;int)) def(init)
	{
		params ["_area","_key","_cfg","_cfgLevel","_effType","_startPos","_sizes","_zSize","_score","_activeCount"];
		self setv(areaId,_area getv(areaId));
		self setv(key,_key);
		self callp(updateData,_cfg arg _cfgLevel arg _effType arg _startPos arg _sizes arg _zSize arg _score arg _activeCount);
		self setv(visualDirty,true);
	}

	decl(void(int;int;int;vector3;vector2;int;float;int)) def(updateData)
	{
		params ["_cfg","_cfgLevel","_effType","_startPos","_sizes","_zSize","_score","_activeCount"];
		self setv(batchCfg,_cfg);
		self setv(cfgLevel,_cfgLevel);
		self setv(effType,_effType);
		self setv(startPos,_startPos);
		self setv(sizes,_sizes);
		self setv(zSize,_zSize);
		self setv(score,_score);
		self setv(activeCount,_activeCount);
		self callv(rebuildData);
	}

	decl(void(int;int;int;vector3;vector2;int;float;int)) def(updateVisual)
	{
		params ["_cfg","_cfgLevel","_effType","_startPos","_sizes","_zSize","_score","_activeCount"];
		private _needReload = !equals(_cfg,self getv(batchCfg))
			|| {!equals(_cfgLevel,self getv(cfgLevel))}
			|| {!equals(_effType,self getv(effType))}
			|| {!equals(_startPos,self getv(startPos))}
			|| {!equals(_sizes,self getv(sizes))}
			|| {!equals(_zSize,self getv(zSize))};
		self callp(updateData,_cfg arg _cfgLevel arg _effType arg _startPos arg _sizes arg _zSize arg _score arg _activeCount);
		if (_needReload) then {
			self setv(visualDirty,true);
		};
		self setv(deleteAfter,-1);
	}

	decl(void()) def(rebuildData)
	{
		private _sizes = self getv(sizes);
		private _zSize = self getv(zSize);
		private _chid = [self getv(areaId),self getv(startPos)] call atmos_localChunkIdToGlobal;
		private _pos = _chid call atmos_chunkIdToPos;
		self setv(batchPos,_pos vectorAdd vec3((_sizes select 0) / 2,(_sizes select 1) / 2,_zSize / 2));
	}

	decl(void(float)) def(markInactive)
	{
		params ["_deleteAfter"];
		if ((self getv(deleteAfter)) < 0) then {
			self setv(deleteAfter,_deleteAfter);
		};
		self setv(visualDirty,false);
	}

	decl(bool(float)) def(isDeleteExpired)
	{
		params ["_now"];
		private _deleteAfter = self getv(deleteAfter);
		(_deleteAfter >= 0) && {_now >= _deleteAfter}
	}

	decl(NULL|any()) def(getOcclusionScreenData)
	{
		private _pos = self getv(batchPos);
		private _sizes = self getv(sizes);
		private _hx = ((_sizes select 0) / 2) + ATMOS_SIZE_HALF;
		private _hy = ((_sizes select 1) / 2) + ATMOS_SIZE_HALF;
		private _hz = ((self getv(zSize)) / 2) + ATMOS_SIZE_HALF;

		private _camPos = asltoatl eyepos player;
		private _dist = _camPos distance _pos;
		private _delta = _camPos vectorDiff _pos;
		if (((abs (_delta select 0)) <= (_hx + 1)) && {((abs (_delta select 1)) <= (_hy + 1)) && {((abs (_delta select 2)) <= (_hz + 2))}}) exitWith {
			[_dist,0,0,0,1,1,self getv(effType),self]
		};

		private _hasProjection = false;
		private _minX = 999999;
		private _minY = 999999;
		private _maxX = -999999;
		private _maxY = -999999;
		private _sp = [];
		{
			_sp = worldToScreen (_pos vectorAdd _x);
			if !(_sp isEqualTo []) then {
				_hasProjection = true;
				private _sx = _sp select 0;
				private _sy = _sp select 1;
				_minX = _minX min _sx;
				_minY = _minY min _sy;
				_maxX = _maxX max _sx;
				_maxY = _maxY max _sy;
			};
		} foreach [
			[0,0,0],
			[-_hx,-_hy,-_hz],
			[_hx,-_hy,-_hz],
			[-_hx,_hy,-_hz],
			[_hx,_hy,-_hz],
			[-_hx,-_hy,_hz],
			[_hx,-_hy,_hz],
			[-_hx,_hy,_hz],
			[_hx,_hy,_hz]
		];
		if (!_hasProjection) exitWith {null};
		if ((_maxX < 0) || {_minX > 1 || {_maxY < 0 || {_minY > 1}}}) exitWith {null};

		_minX = (_minX max 0) min 1;
		_minY = (_minY max 0) min 1;
		_maxX = (_maxX max 0) min 1;
		_maxY = (_maxY max 0) min 1;
		if (((_maxX - _minX) <= 0.001) || {((_maxY - _minY) <= 0.001)}) exitWith {null};

		[_dist,0,_minX,_minY,_maxX,_maxY,self getv(effType),self]
	}

	decl(void(bool)) def(setOcclusionHidden)
	{
		params ["_hide"];
		if !(self getv(batchIsLoaded)) exitWith {
			self setv(isOccluded,false);
			self setv(_occlusion_cache,[]);
		};

		private _emitters = self getv(emitter);
		if isNullVar(_emitters) exitWith {};

		private _sameState = equals(_hide,self getv(isOccluded));
		private _fireLightIdx = self getv(_fireLightIdx);

		if (_hide) then {
			if (!_sameState) then {
				self setv(isOccluded,true);
				private _cache = [];
				{
					if isNullReference(_x) then {continue};
					_cache set [_foreachIndex,getposatl _x];
					_x setposatl [0,0,0];
				} foreach _emitters;
				self setv(_occlusion_cache,_cache);
			};
			if ((_fireLightIdx >= 0) && {_fireLightIdx < count _emitters}) then {
				private _fireLight = _emitters select _fireLightIdx;
				if !isNullReference(_fireLight) then {
					_fireLight setLightIntensity 0;
				};
			};
		} else {
			if (_sameState) exitWith {};
			self setv(isOccluded,false);
			private _cache = self getv(_occlusion_cache);
			if isNullVar(_cache) then {_cache = []};
			{
				if isNullReference(_x) then {continue};
				if (_foreachIndex < count _cache) then {
					private _oldPos = _cache select _foreachIndex;
					if !isNullVar(_oldPos) then {
						_x setposatl _oldPos;
					};
				};
			} foreach _emitters;
			self setv(_occlusion_cache,[]);
			if ((_fireLightIdx >= 0) && {_fireLightIdx < count _emitters}) then {
				private _fireLight = _emitters select _fireLightIdx;
				if !isNullReference(_fireLight) then {
					_fireLight setLightIntensity ((self getv(_fireLightIntensity)) max 0);
				};
			};
		};
	}

	decl(bool()) def(applyPendingVisual)
	{
		if ((self getv(deleteAfter)) >= 0) exitWith {false};
		if !(self getv(visualDirty)) exitWith {false};

		if (self getv(batchIsLoaded)) then {
			self callv(reloadVisual);
		} else {
			self callv(loadVisual);
		};
		self setv(visualDirty,false);
		true
	}

	decl(void()) def(reloadVisual)
	{
		self callv(deleteVisual);
		self callv(loadVisual);
	}

	decl(void()) def(loadVisual)
	{
		if (self getv(batchIsLoaded)) exitWith {};

		self setv(isOccluded,false);
		self setv(_occlusion_cache,[]);
		self setv(_fireLightIdx,-1);
		self setv(_fireLightIntensity,0);

		private _renderZone = self getv(sizes);
		private _renderDepth = self getv(zSize);
		private _funcHandle = {
			params ["_o","_p","_v","_alias"];

			if (_p == "setLightIntensity") then {
				self setv(_fireLightIdx,call le_se_getCurrentEmitterIndex);
				self setv(_fireLightIntensity,_v);
			};

			if !isNullVar(_renderZone) then {
				_renderZone params ["_szX","_szY"];
				private _szZ = _renderDepth;

				if (_alias == "Пламя") then {
					if (_p == "setParticleRandom") then {
						private _old = [_p,"positionVar",_v] call le_se_getParticleOption;
						_old set [0,_szX / 2 + ATMOS_SIZE_HALF];
						_old set [1,_szY / 2 + ATMOS_SIZE_HALF];
						if (_szZ > 0) then {
							_old set [2,_szZ / 2 + ATMOS_SIZE_HALF];
						};
						[_p,"positionVar",_v,_old] call le_se_setParticleOption;
					};
					if (_p == "setParticleParams") then {
						private _size = [_p,"size",_v] call le_se_getParticleOption;
						private _scale = (((_szX + _szY) / 2) / 2) max 1;
						[_p,"size",_v,_size apply {_x * _scale}] call le_se_setParticleOption;
					};
				};

				if (_alias == "Искры") then {
					if (_p == "setDropInterval") then {
						[_p,"interval",_v,1000] call le_se_setParticleOption;
					};
				};

				if (_alias == "Преломление") then {
					if (_p == "setDropInterval") then {
						[_p,"interval",_v,1000] call le_se_setParticleOption;
					};
				};

				if (_alias == "Частицы 1") then {
					if (_p == "setParticleParams") then {
						private _size = [_p,"size",_v] call le_se_getParticleOption;
						private _scale = (((_szX + _szY) / 2) / 5) max 1;
						[_p,"size",_v,_size apply {_x * _scale}] call le_se_setParticleOption;
					};
					if (_p == "setParticleRandom") then {
						private _old = [_p,"positionVar",_v] call le_se_getParticleOption;
						_old set [0,_szX / 2 + ATMOS_SIZE_HALF];
						_old set [1,_szY / 2 + ATMOS_SIZE_HALF];
						if (_szZ > 0) then {
							_old set [2,_szZ / 2 + ATMOS_SIZE_HALF];
						};
						[_p,"positionVar",_v,_old] call le_se_setParticleOption;
					};
					if (_p == "setDropInterval") then {
						private _dropInterval = [_p,"interval",_v] call le_se_getParticleOption;
						private _cval = (_szX + _szY) / 2;
						private _newdrop = linearconversion [0,10,_cval,_dropInterval,_dropInterval / 50,true];
						[_p,"interval",_v,_newdrop] call le_se_setParticleOption;
					};
				};
			};
		};

		self setv(emitter,[self getv(batchCfg) arg self getv(batchPos) arg _funcHandle] call le_se_createUnmanagedEmitter);
		self setv(batchIsLoaded,true);
	}

	decl(void()) def(deleteVisual)
	{
		if (self getv(batchIsLoaded)) then {
			self setv(batchIsLoaded,false);
			self setv(isOccluded,false);
			self setv(_occlusion_cache,[]);
			deleteVehicle (self getv(emitter));
			[0] call lesc_onLightRemove;
			self setv(emitter,null);
			self setv(_fireLightIdx,-1);
			self setv(_fireLightIntensity,0);
		};
	}

	decl(void()) def(del)
	{
		self callv(deleteVisual);
	}

	decl(string()) def(str)
	{
		format["ACV:%1 cfg:%2 lvl:%3 cnt:%4 score:%5",self getv(key),self getv(batchCfg),self getv(cfgLevel),self getv(activeCount),self getv(score)]
	}
endstruct
#endif

struct(AtmosClientBatchRegion)
	//локальные точки начала и конца зоны
	decl(vector3) def(startPos) [0,0,0]
	decl(vector3) def(endPos) [0,0,0]
	decl(vector2) def(sizes) [0,0] //размер зоны
	decl(int) def(zSize) 0

	decl(vector3) def(areaId) null //айди зоны

	decl(bool(vector3;vector2)) def(isEqualPosInfo)
	{
		params ["_start","_sizes"];
		equals(_start,self getv(startPos))
		&& {equals(_sizes,self getv(sizes))}
	}

	decl(bool(struct_t.AtmosClientBatchRegion)) def(isSameCfgType)
	{
		params ["_otherVL"];
		equals(self getv(effType),_otherVL getv(effType))
	}
	decl(int) def(effType) -1; //NAT_ATMOS_EFFTYPE_

	//размер зоны оптимизации vec2
	decl(vector2) def(renderZone) null
	//уменьшение дропа частиц
	decl(float) def(decZoneRend) null

	//references to AtmosVirtualLight
	decl(AtmosVirtualLight[]) def(virtLights) null //list<AtmosVirtualLight>

	decl(void(struct_t.AtmosVirtualLight[]|struct_t.AtmosVirtualLight)) def(registerVL)
	{
		params ["_vlORvlList"];
		private _rpi = vec2(self getv(startPos),self getv(sizes));
		if equalTypes(_vlORvlList,[]) then {
			(self getv(virtLights)) append _vlORvlList;
			{
				_x setv(regionPosInfo,_rpi);
			} foreach _vlORvlList;
		} else {
			(self getv(virtLights)) pushBack _vlORvlList;
			_vlORvlList setv(regionPosInfo,_rpi);
		};
	}

	decl(void()) def(rebuildData)
	{
		private _sizes = self getv(sizes);
		private _zSize = self getv(zSize);

		self setv(endPos,(self getv(startPos)) vectorAdd vec3(_sizes select 0,_sizes select 1,_zSize));

		//define batchpos
		private _chid = [self getv(areaId),self getv(startPos)] call atmos_localChunkIdToGlobal;
		//pos of first chunk in area
		private _pos = (_chid call atmos_chunkIdToPos);
		private _midPos = _pos vectorAdd [
			(_sizes select 0)/2,
			(_sizes select 1)/2,
			_zSize/2
		];
		self setv(batchPos,_midPos);
	}

	decl(void(struct_t.AtmosAreaClient;vector2;vector3;struct_t.AtmosVirtualLight[])) def(init)
	{
		params ["_area","_sizes","_startPos",["_virtLights",[]]];
		self setv(startPos,_startPos);
		self setv(zSize,0);
		private _endPos = _startPos vectorAdd [_sizes select 0,_sizes select 1,self getv(zSize)];
		self setv(endPos,_endPos);
		self setv(sizes,_sizes);
		self setv(virtLights,_virtLights);

		self setv(areaId,_area getv(areaId));

		{
			_x setv(regionPosInfo,vec2(_startPos,_sizes));
		} foreach _virtLights;

		private _cfg = "SLIGHT_ATMOS_FIRE_3" call lightSys_getConfigIdByName;
		private _femit = _virtLights select 0;
		if (_femit callv(isFireType)) then {
			_cfg = "SLIGHT_ATMOS_FIRE_3" call lightSys_getConfigIdByName;
			self setv(effType,NAT_ATMOS_EFFTYPE_FIRE);
		};
		if (_femit callv(isSmokeType)) then {
			_cfg = "SLIGHT_ATMOS_SMOKE_3" call lightSys_getConfigIdByName;
			self setv(effType,NAT_ATMOS_EFFTYPE_SMOKE);
		};
		self setv(batchCfg,_cfg);

		self callv(handleCfgCanCulled);

		traceformat("registered batchzone: from %1 to %2 ascfg %3 (lt:%4)",_startPos arg _endPos arg _cfg arg count _virtLights)

		//define batchpos
		private _chid = [self getv(areaId),_startPos] call atmos_localChunkIdToGlobal;
		//pos of first chunk in area
		private _pos = (_chid call atmos_chunkIdToPos);
		private _midPos = _pos vectorAdd [
			(_sizes select 0)/2,
			(_sizes select 1)/2,
			(self getv(zSize))/2
		];
		self setv(batchPos,_midPos);
	}

	decl(string()) def(str)
	{
		format["ABR:%1=>%2(%3)",self getv(startPos),self getv(endPos),self getv(sizes)];
	}

	decl(void()) def(del)
	{
		self callv(unloadBatchEmitter);
	}

	//выполняет задание по ближайшим блокам зоны.
	// в параметры qtask отдается объект AtmosVirtualLight (при наличии) и позиция
	decl(void(any)) def(nearBlocksQuery)
	{
		params [["_qtask",{}]];
		private _startPos = self getv(startPos) vectorAdd [-1,-1];
		private _endPos = self getv(endPos) vectorAdd [1,1];

		private _pos = null;
		private _aObj = [self getv(areaId)] call noe_client_nat_getAreaUnsafe;
		if isNullVar(_aObj) exitWith {};

		_startPos params ["_sX","_sY","_sZ"];
		_endPos params ["_eX","_eY","_eZ"];

		// Проход по верхней и нижней границам
		for "_x" from (_sX) to (_eX) do {
			// Верхняя граница
			_pos = [_x, (_sY), _sZ];
			[_aObj callp(getLightByPos,_pos),_pos] call _qtask; // Выполняем задание для блока на верхней границе

			// Нижняя граница
			_pos = [_x, (_eY), _sZ];
			[_aObj callp(getLightByPos,_pos),_pos] call _qtask; // Выполняем задание для блока на нижней границе
		};

		// Проход по левой и правой границам (исключая углы, чтобы не дублировать их)
		for "_y" from ((_sY) + 1) to ((_eY) - 1) do {
			// Левая граница
			_pos = [_sX, _y, _sZ];
			[_aObj callp(getLightByPos,_pos),_pos] call _qtask; // Выполняем задание для блока на левой границе

			// Правая граница
			_pos = [_eX, _y, _sZ];
			[_aObj callp(getLightByPos,_pos),_pos] call _qtask; // Выполняем задание для блока на правой границе
		};

	}

	//включает или отключает режим рендера зоны. true - включение
	decl(void(bool)) def(setRenderMode)
	{
		params ["_mode"];
		if (_mode) then {
			#ifdef NOE_CLIENT_NAT_ENABLE_VISUAL_BUDGET
			self setv(fireLightEnabled,true);
			{
				_x callv(disableSingleRender);
			} foreach (self getv(virtLights));
			#else
			{
				_x callv(deleteEmitters);
			} foreach (self getv(virtLights));
			#endif
			self callv(reloadBatchEmitter);
		} else {
			#ifdef NOE_CLIENT_NAT_ENABLE_VISUAL_BUDGET
			{
				_x callv(enableSingleRender);
			} foreach (self getv(virtLights));
			#else
			{
				_x callv(reloadLight);
			} foreach (self getv(virtLights));
			#endif
			self callv(unloadBatchEmitter);
		};
	}

	#ifdef NOE_CLIENT_NAT_ENABLE_VISUAL_BUDGET
	decl(void()) def(enableBudgetRender)
	{
		{
			_x callv(disableSingleRender);
		} foreach (self getv(virtLights));
		if ((self getv(batchIsLoaded)) && {not_equals(self getv(_fireLightLoaded),self getv(fireLightEnabled))}) exitWith {
			self callv(reloadBatchEmitter);
		};
		if !(self getv(batchIsLoaded)) then {
			self callv(loadBatchEmitter);
		};
	}

	decl(void()) def(disableBudgetRender)
	{
		self callv(unloadBatchEmitter);
		{
			_x callv(disableSingleRender);
		} foreach (self getv(virtLights));
	}
	#endif

	decl(void(bool)) def(setCull)
	{
		params ["_hide"];
		if equals(_hide,self getv(isCulled)) exitWith{};
		self setv(isCulled,_hide);
		private _ncuIdx = self getv(_nocullLight);
		if (_hide) then {
			private _cull_cache = self getv(_cull_cache);
			//traceformat("CULLING BATCH",_cull_cache);
			{
				if equals(_ncuIdx,_foreachIndex) then {continue};

				private _cp = (getposatl _x);
				_cull_cache set [_foreachIndex,_cp];
				_x setposatl [0,0,0];
			} foreach (self getv(emitter));
		} else {
			private _cull_cache = self getv(_cull_cache);
			//traceformat("SHOWING BATCH; cull %1",_cull_cache);
			{
				if equals(_ncuIdx,_foreachIndex) then {continue};

				_x setposatl (_cull_cache select _foreachIndex);
			} foreach (self getv(emitter));
			self setv(_cull_cache,[]);
		};
	};
	decl(bool) def(isCulled) false
	decl(any) def(_cull_cache) null

	decl(int) def(batchCfg) -1 //конфиг батч эмиттера
	decl(vector3) def(batchPos) [0,0,0] //глобальная позиция батч эмиттера
	decl(bool) def(batchIsLoaded) false //загружен ли визуал
	#ifdef NOE_CLIENT_NAT_ENABLE_VISUAL_BUDGET
	decl(bool) def(fireLightEnabled) true
	decl(bool) def(_fireLightLoaded) false
	#endif
	decl(mesh[]) def(emitter) null //массив на world эмиттеры

	decl(bool) def(canUseCullOpt) false
	decl(int) def(_nocullLight) -1
	decl(void()) def(handleCfgCanCulled)
	{
		if ((self getv(batchCfg)) in ["SLIGHT_ATMOS_SMOKE_1" call lightSys_getConfigIdByName,"SLIGHT_ATMOS_SMOKE_2" call lightSys_getConfigIdByName,"SLIGHT_ATMOS_SMOKE_3" call lightSys_getConfigIdByName]) then {
			self setv(canUseCullOpt,true);
		};
	}

	//обновляет батч
	decl(void()) def(reloadBatchEmitter)
	{
		if (self getv(batchIsLoaded)) then {
			self callv(unloadBatchEmitter);
		};
		self callv(loadBatchEmitter);
	}

	//загрузка батч эмиттера
	decl(void()) def(loadBatchEmitter)
	{
		if (self getv(batchIsLoaded)) exitWith {};

		self setv(isCulled,false);
		self setv(_cull_cache,[]);
		self setv(_nocullLight,-1);

		private _renderZone = self getv(sizes);
		private _renderDepth = self getv(zSize);
		private _decZoneRend = self getv(decZoneRend);
		#ifdef NOE_CLIENT_NAT_ENABLE_VISUAL_BUDGET
		private _fireLightEnabled = self getv(fireLightEnabled);
		private _fireLightScale = linearconversion [1,16,count (self getv(virtLights)),1,3,true];
		#endif
		private _funcHandle = {
			params ["_o","_p","_v","_alias"];
			//use le_se_getParticleOption, le_se_setParticleOption for change object options

			if !isNullVar(_decZoneRend) then {
				if (_p == "setDropInterval") then {
					private _dint = [_p,"interval",_v] call le_se_getParticleOption;
					[_p,"interval",_v,
						_dint * (_decZoneRend*1.2)
					] call le_se_setParticleOption
				};
			};

			//оптимизация батченной зоны
			if !isNullVar(_renderZone) then {
				_renderZone params ["_szX","_szY"];
				private _szZ = _renderDepth;
				if (_alias == "Свет огня") then {
					self setv(_nocullLight,call le_se_getCurrentEmitterIndex);
				};
				if (_alias == "Пламя") then {
					if (_p == "setParticleRandom") then {

						//update position
						private _old = [_p,"positionVar",_v] call le_se_getParticleOption;
						_old set [0,_szX/2 + ATMOS_SIZE_HALF];
						_old set [1,_szY/2 + ATMOS_SIZE_HALF];
						if (_szZ > 0) then {
							_old set [2,_szZ/2 + ATMOS_SIZE_HALF];
						};
						[_p,"positionVar",_v,_old] call le_se_setParticleOption;


					};
					//update drop
					if (_p == "setDropInterval") then {
						// private _dropInterval = [_p,"interval",_v] call le_se_getParticleOption;
						// [_p,"interval",_v,_dropInterval
						// // /_renderZone
						// ] call le_se_setParticleOption;
					};
					//update size
					if (_p == "setParticleParams") then {
						private _size = [_p,"size",_v] call le_se_getParticleOption;
						//for fire minimum is 0.42
						//["DEFSIZE: %1",_size] call cprint;
						[_p,"size",_v,_size apply {
							private _svr = _x*(((_szX+_szY)/2)/2);
							_svr max _x
						}] call le_se_setParticleOption;

						#ifdef ENABLE_RANDOMIZATION_COLOR
						//random color
						private _colorArr = [_p,"color",_v] call le_se_getParticleOption;
						//["clr %1",_colorArr] call cprint;
						private _rndClr = [rand(0,1),rand(0,1),rand(0,1),1];
						_colorArr = _colorArr apply {
							_rndClr
							//[_rndClr select 0,_rndClr select 1,_rndClr select 2,_x select 3]
						};
						[_p,"color",_v,_colorArr] call le_se_setParticleOption;
						#endif
					};
				};
				//disable sparks
				if (_alias == "Искры") then {
					if (_p == "setDropInterval") then {
						[_p,"interval",_v,1000] call le_se_setParticleOption;
					};
				};
				//disable refract
				if (_alias == "Преломление") then {
					if (_p == "setDropInterval") then {
						[_p,"interval",_v,1000] call le_se_setParticleOption;
					};
				};
				//smoke
				if (_alias == "Частицы 1") then {
					if (_p == "setParticleParams") then {
						private _size = [_p,"size",_v] call le_se_getParticleOption;
						//["DEFSIZE: %1",_size] call cprint;
						[_p,"size",_v,_size apply {
							private _svr = _x*(((_szX+_szY)/2)/5);
							_svr max _x
						}] call le_se_setParticleOption;

						private _old = [_p,"lifeTime",_v] call le_se_getParticleOption;

						private _cval = (_szX+_szY)/2;
						private _newdrop = linearconversion [0,10,_cval,_old,_old*5,true];

						[_p,"lifeTime",_v,_old] call le_se_setParticleOption;

						#ifdef ENABLE_RANDOMIZATION_COLOR
						//random color
						private _colorArr = [_p,"color",_v] call le_se_getParticleOption;
						private _rndClr = [rand(0,1),rand(0,1),rand(0,1),1];
						_colorArr = _colorArr apply {_rndClr};
						[_p,"color",_v,_colorArr] call le_se_setParticleOption;
						#endif
					};
					if (_p == "setParticleRandom") then {
						//update position
						private _old = [_p,"positionVar",_v] call le_se_getParticleOption;
						_old set [0,_szX/2 + ATMOS_SIZE_HALF];
						_old set [1,_szY/2 + ATMOS_SIZE_HALF];
						if (_szZ > 0) then {
							_old set [2,_szZ/2 + ATMOS_SIZE_HALF];
						};
						[_p,"positionVar",_v,_old] call le_se_setParticleOption;
					};
					if (_p == "setDropInterval") then {
						private _dropInterval = [_p,"interval",_v] call le_se_getParticleOption;
						//[_p,"interval",_v,_dropInterval/((_szX+_szY)/2)] call le_se_setParticleOption;
						private _cval = (_szX+_szY)/2;
						private _newdrop = linearconversion [0,10,_cval,_dropInterval,_dropInterval/50,true];
						[_p,"interval",_v,_newdrop] call le_se_setParticleOption;
					};
				};
			};



		};

		private _emitters = [self getv(batchCfg) arg self getv(batchPos) arg _funcHandle] call le_se_createUnmanagedEmitter;
		#ifdef NOE_CLIENT_NAT_ENABLE_VISUAL_BUDGET
		if ((self getv(effType)) == NAT_ATMOS_EFFTYPE_FIRE) then {
			private _fireLightIdx = self getv(_nocullLight);
			if (_fireLightIdx >= 0 && {_fireLightIdx < count _emitters}) then {
				private _fireLight = _emitters select _fireLightIdx;
				if (!_fireLightEnabled) then {
					deleteVehicle _fireLight;
					_emitters deleteAt _fireLightIdx;
					self setv(_nocullLight,-1);
					[0] call lesc_onLightRemove;
				} else {
					private _baseIntensity = 6754.07;
					private _rndIntensity = [-1000,-500];
					_fireLight setLightIntensity ((_baseIntensity + rand(_rndIntensity select 0,_rndIntensity select 1)) * _fireLightScale) min 18000;
					startAsyncInvoke
					{
						params ["_t","_light","_base","_rng","_scale"];
						if isNullReference(_light) exitWith {true};
						if (tickTime < _t) exitWith {false};
						_this set [0,tickTime + rand(0.03,0.05)];
						_light setLightIntensity ((_base + rand(_rng select 0,_rng select 1)) * _scale) min 18000;
						false
					},
					{},
					[tickTime,_fireLight,_baseIntensity,_rndIntensity,_fireLightScale]
					endAsyncInvoke
				};
			};
		};
		#endif

		self setv(emitter,_emitters);
		self setv(batchIsLoaded,true);
		#ifdef NOE_CLIENT_NAT_ENABLE_VISUAL_BUDGET
		self setv(_fireLightLoaded,_fireLightEnabled && {(self getv(_nocullLight)) >= 0});
		#endif

		#ifdef ENABLE_DRAW_DEBUG_LINES_REGIONS
		self getv(sizes) params ["_ddlX","_ddlY"];
		private _clrTp = [0,1,rand(0,0.3),1];
		if (self getv(batchCfg) == ("SLIGHT_ATMOS_FIRE_3" call lightSys_getConfigIdByName)) then {
			_clrTp = [1,rand(0,0.3),0,1];
		};
		modvar(_ddlX) - 0.1;
		modvar(_ddlY) - 0.1;
		private _renderTask = [self getv(batchPos),_clrTp,
			#ifdef ENABLE_DRAW_DEBUG_LINES_VIRTUALCHUNKS
			50
			#else
			15
			#endif
			,
			[
				vec3(-_ddlX/2,-_ddlY/2,-0) vectorDiff vec3(ATMOS_SIZE_HALF,ATMOS_SIZE_HALF,ATMOS_SIZE_HALF),
				vec3(_ddlX/2,_ddlY/2,0) vectorAdd vec3(ATMOS_SIZE_HALF,ATMOS_SIZE_HALF,ATMOS_SIZE_HALF)
			]
		] call debug_addRenderPos;
		self set ["_renderTask_BatchRegion",_renderTask];
		#endif
	}

	decl(void()) def(unloadBatchEmitter)
	{
		if (self getv(batchIsLoaded)) then {
			self setv(batchIsLoaded,false);
			#ifdef NOE_CLIENT_NAT_ENABLE_VISUAL_BUDGET
			self setv(_fireLightLoaded,false);
			#endif
			deleteVehicle (self getv(emitter));
			[0] call lesc_onLightRemove;
			self setv(emitter,null);

			#ifdef ENABLE_DRAW_DEBUG_LINES_REGIONS
			(self get "_renderTask_BatchRegion") callv(stopLoop);
			self set ["_renderTask_BatchRegion",null];
			#endif

		};
	}
endstruct

/*
for test append chunk

_mob = player;
_aid = (getposatl _mob) call atmos_getAreaIdByPos;


_aobj = [_aid] call noe_client_nat_getArea;
_ch = _aobj get "chunks";
_addList = [];_erg = 0;
for"_i" from 1 to 1000 do {[_aobj,[_i]]call noe_client_nat_deleteChunks};
_area = noe_client_nat_areas get "[404,400,2]";
for "_z" from 5 to 5 do {
for "_x" from 1 to 10 step 1 do {
for "_y" from 1 to 10 step 1 do {
if (_x in [-5])then{continue};
if (_x==1&&_y==1)then{_erg=[_x,_y,_z];continue};
_id = [_x,_y,_z] call atmos_encodeChid;
_addList pushBackUnique [_id,if(_x<=2&&_y<=2)then{2128}else{2125}];

}
};
};


[_aObj,_addList,true] call noe_client_nat_loadArea;
//"debug_console" callExtension "C";
_t = diag_tickTime;
_aobj call ["optimizeProcess"];

//addnew
_idj = _erg call atmos_encodeChid;
[_aObj,[[_idj,2127]],true] call noe_client_nat_loadArea;
_av = (_ch get _idj select 1);
_t = diag_tickTime;
_aobj call ["optimizeSingle",[_av]];


diag_tickTime - _t;

*/
