// ======================================================
// Copyright (c) 2017-2024 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================
#include "..\..\host\struct.hpp"
#include "..\LightEngine\ScriptedEffects.hpp"
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
*/

#define ENABLE_OPTIMIZATION

//отладочные линии
#define ENABLE_DRAW_DEBUG_LINES_VIRTUALCHUNKS
#define ENABLE_DRAW_DEBUG_LINES_REGIONS

//рандомные цвета для зон
#define ENABLE_RANDOMIZATION_COLOR

#ifndef EDITOR
	#undef ENABLE_DRAW_DEBUG_LINES_VIRTUALCHUNKS
	#undef ENABLE_DRAW_DEBUG_LINES_REGIONS
	#undef ENABLE_RANDOMIZATION_COLOR
#endif

struct(AtmosAreaClient)
	def(areaId) null;
	def(lastUpd) 0;
	def(lastDel) 0;

	def(state) NAT_LOADING_STATE_NOT_LOADED;
	def(isLoaded) {(self getv(state)) == NAT_LOADING_STATE_LOADED}

	def(chunks) null; //key:localid,value vec2(cfg,obj)

	def(_optimizeDirty) null
	def(_blockCoords) null //локальные координаты блоков по z осям
	
	//хранящиеся регионы
	def(_regions) null //list[9] -> list<AtmosClientBatchRegion

	def(init)
	{
		params ["_aId"];
		self setv(areaId,_aId);
		self setv(chunks,createHashMap); 
		private _lst = [];
		_lst resize ATMOS_AREA_SIZE;
		self setv(_blockCoords,_lst apply {[]});

		self setv(_regions,_lst apply {[]});

		self setv(_optimizeDirty,_lst apply {true});
	}

	//регистрация|перерегистрация эффектов в зоне
	def(registerEffects)
	{
		params ["_locid","_light"];

		if (_locid in (self getv(chunks))) then {
			self getv(chunks) get _locid set [NAT_CHUNKDAT_CFG,_light];
		} else {
			self getv(chunks) set [_locid,NAT_CHUNKDAT_NEW(_light)];
			private _coord = _locid call atmos_decodeChId;
			(self getv(_blockCoords) select ((_coord select 2)-1)) pushBack _coord;

			self getv(_optimizeDirty) set [(_coord select 2)-1,true];
		};

		if (self callv(isLoaded)) then {
			self callp(onUpdateChunk,_locid);

			private _lt = self getv(chunks) get _locid select NAT_CHUNKDAT_OBJECT;
			self callp(optimizeSingle,_lt);
		};
	}

	//снятие регистрации эффектов чанка. удаляет визуальный объект и выписывает чанк из хранилища
	def(unregisterEffects)
	{
		params ["_locid"];
		private _chDat = self getv(chunks) GET _locid;
		if !isNullVar(_chDat) then {
			self getv(chunks) deleteAt _locid;
			private _coord = _locid call atmos_decodeChId;
			[(self getv(_blockCoords) select ((_coord select 2)-1)),_coord] call arrayDeleteItem;

			self getv(_optimizeDirty) set [(_coord select 2)-1,true];

			private _ltObj = _chDat select NAT_CHUNKDAT_OBJECT;
			
			if (_ltObj callv(isInsideRegion)) then {
				private _rpinf = _ltObj getv(regionPosInfo);
				private _regions = self getv(_regions) select ((_coord select 2)-1);
				private _foundRegion = null;
				{
					if (_x callp(isEqualPosInfo,_rpinf select 0 arg _rpinf select 1)) exitWith {
						_foundRegion = _x;
					};
					false
				} count _regions;
				//!temporary code
				if !isNullVar(_foundRegion) then {
					traceformat("founded region for unloading: %1",_foundRegion);
					self callp(onDecreaseRegion,_regions arg _foundRegion arg _ltObj);
				};
			};
		};
	}

	//загружает визуал зоны
	def(loadArea)
	{		
		{
			self callp(onUpdateChunk,_x);
			false
		} count (self callv(getChunkIdList));
		
		{
			{
				_x callp(setRenderMode,true);
				false
			} count _x;
			false
		} count (self getv(_regions));

		//full load area
		//trace("------------ load area ------------")
		//self callp(optimizeProcess, null);
	}

	def(unloadArea)
	{
		{
			self callp(unloadChunkInternal,_x);
			false
		} count (self callv(getChunkIdList));

		//unload regions
		{
			{
				_x callv(unloadBatchEmitter);
				false
			} count _x;
			false
		} count (self getv(_regions));
		
		//full unload area
		//self callp(optimizeProcess, null);
	}

	def(loadChunkInternal)
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
	def(onUpdateChunk)
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

	def(unloadChunkInternal)
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

	def(deleteChunk)
	{
		params ["_locid"];
		private _needUpdate = false;
		if (_locid in (self getv(chunks))) then {
			self callp(unloadChunkInternal,_locid);
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


	def(_createVisual)
	{
		params ["_light","_pos","_basePos","_chid"];
		#ifdef NAT_DEBUG_ENABLE_VISUAL_HELPER
		private _vobj = "Sign_Arrow_F" createVehicleLocal [0,0,0];
		_vobj setvariable ["_basePos",_basePos];
		_vobj setposatl _pos;
		self set ["__debug_visual",_vobj];
		setLastError("this can be undefined behaviour because self is atmosareaclient. use atmosvirtualstruct to store __debug_visual");
		#endif
		
		private _obj = struct_newp(AtmosVirtualLight,_light arg _pos arg _chid);

		#ifdef ENABLE_DRAW_DEBUG_LINES_VIRTUALCHUNKS
		private _renderTask = [_basePos,[1,0,1,1],10,[vec3(-ATMOS_SIZE_HALF,-ATMOS_SIZE_HALF,-ATMOS_SIZE_HALF),vec3(ATMOS_SIZE_HALF,ATMOS_SIZE_HALF,ATMOS_SIZE_HALF)]] call debug_addRenderPos;
		_obj set ["_renderTask_ENABLE_DRAW_DEBUG_LINES",_renderTask];
		#endif

		_obj
	}

	def(_deleteVisual)
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
	def(_loadLight_depr)
	{
		params ["_light","_obj"];
		private _lightObj = [_light,_obj] call le_loadLight;
		_obj setvariable ["_atmos_light",_lightObj];
		
		//! это пока работает плоховато...
		// private _basePos = _obj getvariable "_basePos";
		// if (self callp(hasSnapToDownCfg,_light)) then {
		// 	private _itDat = [_basePos,_basePos vectorAdd [0,0,ATMOS_SIZE_HALF],_obj] call interact_getRayCastData;
		// 	if !isNullReference(_itDat select 0) then {
		// 		_obj setposatl ((_itDat select 1) vectoradd [ATMOS_ADDITIONAL_RANGE_XY,ATMOS_ADDITIONAL_RANGE_XY,0]);
		// 	};
		// };
		
		_lightObj
	}

	def(hasSnapToDownCfg)
	{
		params ["_cfg"];
		_cfg in [SLIGHT_ATMOS_FIRE_1,SLIGHT_ATMOS_FIRE_2,SLIGHT_ATMOS_FIRE_3]
	}

	def(getChunkIdList)
	{
		keys (self getv(chunks))
	}

	def(str)
	{
		format["Area%1",self getv(areaId)]
	}

	//полная оптимизация по уровням
	def(optimizeProcess)
	{
		#ifndef ENABLE_OPTIMIZATION
		if (true) exitWith {};
		#endif
		//_level list<Z-level>
		params ["_levels"]; //Если параметр _level не равен null то это полная перегрузка зоны
		traceformat("Start optimization of level %1",ifcheck(isNullVar(_levels),"ALL",_levels))
		/*
			1. группируем зоны по z
			2. проходим все z уровни

			TODO доп оптимизация. валидируем только уровень на который добавлен чанк

			инфо: 
			мы можем делать доп оптимизацию по z
			если в регионе сверху есть регион такого же уровня
		*/
		//collect zposes
		private _chMap = self getv(chunks);
		
		private _alist = [];
		_alist resize (ATMOS_AREA_SIZE);
		_alist = _alist apply {[]};
		private _curZ = null;
		private _obj = null;
		private _mapAssoc = createhashMap;
		if isNullVar(_levels) then {
			private _chs = (self callv(getChunkIdList)) apply {[_x call atmos_decodeChId,_x]};
			traceformat("  --- all objects count: %1",count _chs)

			//full load
			{
				_x params ["_locPos","_chidloc"];
				_curZ = (_locpos select 2);
				
				(_alist select (_curZ-1)) pushBack _locPos;
				_obj = _chMap get _chidloc select NAT_CHUNKDAT_OBJECT;
				_mapAssoc set [_locPos,_obj];
			} foreach _chs;
		} else {
			{
				private _lvlList = self getv(_blockCoords) select (_x -1);
				_lvllist sort true;
				_alist set [_x-1,_lvllist];
				{
					_obj = _chMap get (_x call atmos_encodeChId) select NAT_CHUNKDAT_OBJECT;
					_mapAssoc set [_x,_obj];
					;false
				} count _lvllist;
			} foreach _levels;
		};
		
		
		private _obj = null;

		// Функция для поиска максимального региона с текущей позиции
		private _findMaxZone = {
			params ["_pos", "_activeChunks","_curObj"];
			_pos params ["_x","_y","_z"];
			
			private _sizeX = 0;
			private _sizeY = 0;

			// Максимальное расширение по X
			for "_i" from 1 to ATMOS_AREA_SIZE do {
				private _pX = [_x + _i, _y, _z];
				
				if (_pX in _processed) exitWith {};

				// Проверяем, можем ли расшириться по X
				if ((_pX in _activeChunks) && (_curObj callp(isSameCfgType, _mapAssoc get _pX))) then {
					_sizeX = _i;
				} else {
					break;
				};
			};

			// Максимальное расширение по Y при зафиксированной ширине _sizeX
			for "_j" from 1 to ATMOS_AREA_SIZE do {
				private _canExpandY = true;
				
				for "_dx" from 0 to _sizeX do {
					private _pY = [_x + _dx, _y + _j, _z];

					if (_pY in _processed) exitWith {_canExpandY = false};
					
					// Проверяем, можем ли расшириться по Y
					if (!(_pY in _activeChunks) || !(_curObj callp(isSameCfgType, _mapAssoc get _pY))) then {
						_canExpandY = false;
						break;
					};
				};

				if (_canExpandY) then {
					_sizeY = _j;
				} else {
					break;
				};
			};

			[_sizeX, _sizeY]
		};

		private _processZOpt = {
			params ["_z","_activeChunks"];
			private _optList = []; //сюда записываются объекты оптимизации
			
			private _processed = []; // Отслеживание обработанных чанков для уровня

			self getv(_regions) select (_z - 1) resize 0;

			// Поиск регионов
			{
				private _pos = _x;

				// Пропускаем уже обработанные чанки
				if (_pos in _processed) then {
					//traceformat("pos in processed; exit pos: %1",_pos);
					continue;
				};
				//traceformat("process pos %1",_pos)

				// Находим максимальный квадратный регион от этой позиции
				private _curObj = _mapAssoc get _pos;
				private _sizes = [_pos, _activeChunks,_curObj] call _findMaxZone;
				traceformat("  Max size for pos %1 is %2", _pos arg _sizes)
				
				//ограничение зоны по квадратам. Прим.: 5x5 - ok; 6x6 -> lower to 5
				//_size = _size - (_size%2);

				if equals(_sizes,vec2(0,0)) then {
					//test hide
					_optList pushBack (_mapAssoc get (_pos));
					continue;
				};


				// Помечаем все чанки внутри найденного региона как обработанные
				private _lproc = [];
				private _curVlt = null;
				for "_i" from 0 to (_sizes select 0) do {
					for "_j" from 0 to (_sizes select 1) do {
						private _chunkPos = _pos vectorAdd [_i,_j,0];
						_processed pushBack _chunkPos;
						_curVlt = _mapAssoc get _chunkPos;
						_lproc pushBack _curVlt;
						//_curVlt callp(setHidden,true);
						//traceformat("  hide pos %1 exists %2",_chunkPos arg _chunkPos in _mapAssoc)
					};
				};

				// Определяем центральную позицию для "огня"
				private _centerPos = [
					(_pos select 0) + floor((_sizes select 0) / 2),
					(_pos select 1) + floor((_sizes select 1) / 2),
					_z
				];
				traceformat("  unhide pos %1 exists %2",_centerPos arg _centerPos in _mapAssoc)
				private _centerObj = _mapAssoc get _centerPos;
				_centerObj callp(setHidden,false); //for debug
				//_centerObj setv(renderZone,_sizes);
				//смещение на следующую зону
				// if (_size%2==1) then {
				// 	_centerObj setv(useOffsetMid,true);
				// };
				//_centerObj callv(reloadLight);
				private _curRegionList = self getv(_regions) select (_z - 1);
				private _region = null;

				// {
				// 	if (_x callp(isEqualPosInfo,_pos arg _sizes)) exitWith {
				// 		_region = _x;
				// 	};
				// 	false
				// } count _curRegionList;
				if isNullVar(_region) then {
					_region = struct_newp(AtmosClientBatchRegion,self arg _sizes arg _pos arg _lproc);
					_curRegionList pushBack _region;
					_region callp(setRenderMode,true);
				} else {
					_region setv(virtLights,_lproc);
					_region callp(setRenderMode,true);
				};
				
			} foreach _activeChunks;

			//second optimization layer
			private _ctrend = count _optList;
			if (_ctrend > 0) then {
				// {
				// 	_x setv(decZoneRend,_ctrend);
				// 	_x callv(reloadLight);
				// 	false
				// } count _optList;
			};
		};

		{
			private _z = _foreachIndex + 1;
			if (count _x > 0) then {
				traceformat(" ----- process zlevel: %1; count %2",_z arg count _x)
				if isNullVar(_levels) then {
					_x sort true; //by near to far
				};
				[_z,_x] call _processZOpt;
			};
		} foreach _alist;
	}

	//оптимизация при доабвлении нового блока
	def(optimizeSingle)
	{
		params ["_vlight"];
		private _pos = _vlight getv(localChId);
		private _z = _pos select 2;
		private _regions = self getv(_regions) select (_z - 1);

		if (count _regions == 0) then {
			self callp(optimizeProcess,[_z]);
		};
		
		// Функция для поиска соседних регионов рядом с новым блоком
		private _findNeighborRegions = {
			private _neighborRegions = [];

			{
				private _startPos = _x getv(startPos);
				private _endPos = _x getv(endPos);

				// Проверка, находится ли регион рядом с добавляемым блоком
				if (
					((_pos select 0) >= (_startPos select 0) - 1 && (_pos select 0) <= (_endPos select 0) + 1) &&
					((_pos select 1) >= (_startPos select 1) - 1 && (_pos select 1) <= (_endPos select 1) + 1)
				) then {
					_neighborRegions pushBack _x;
				};
			} forEach _regions;

			_neighborRegions
		};

		private _nearRegions = call _findNeighborRegions;
		traceformat("NEAR REGIONS FOR POS %2: %1",_nearRegions arg _pos)

		

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
					_expandableRegion callp(setRenderMode,true);
					break;
				};
			};

       	} forEach _nearRegions;
		
		self callp(mergeRegions,_regions arg _z);
	}

	//задане объединения регионов
	def(mergeRegions)
	{
		params ["_regions","_z"];
		// Функция для проверки, можно ли объединить два региона
		private _canMerge = {
			params ["_regionA", "_regionB"];
			
			// Разные типы батчей
			if not_equals(_regionA getv(batchCfg),_regionB getv(batchCfg)) exitWith {false};

			private _startA = _regionA getv(startPos);
			private _endA = _regionA getv(endPos);
			private _startB = _regionB getv(startPos);
			private _endB = _regionB getv(endPos);

			// Проверяем, находятся ли регионы на одном уровне по Z
			if ((_startA select 2) != (_startB select 2)) exitWith {false};

			// Проверка по осям X и Y: регионы должны быть рядом
			private _adjacentX = ((_endA select 0) + 1 == (_startB select 0)) || ((_endB select 0) + 1 == (_startA select 0));
			private _adjacentY = ((_endA select 1) + 1 == (_startB select 1)) || ((_endB select 1) + 1 == (_startA select 1));

			// Считаем, что регионы можно объединить, если они прилегают по одной из осей
			(_adjacentX && (_startA select 1 == _startB select 1) && (_endA select 1 == _endB select 1)) ||
			(_adjacentY && (_startA select 0 == _startB select 0) && (_endA select 0 == _endB select 0))
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
		while {_continueMerge} do {
			_continueMerge = false;
			
			private _newRegions = [];
			private _usedRegions = [];

			for "_i" from 0 to (count _mergedRegions - 1) do {
				private _regionA = _mergedRegions select _i;
				if (_regionA in _usedRegions) then {continue};
				
				private _mergedRegion = _regionA;
				private _mergedThisCycle = false;

				for "_j" from (_i + 1) to (count _mergedRegions - 1) do {
					private _regionB = _mergedRegions select _j;
					if (_regionB in _usedRegions) then {continue};
					
					// Проверяем, можно ли объединить регионы
					if ([_mergedRegion, _regionB] call _canMerge) then {
						_mergedRegion = [_mergedRegion, _regionB] call _merge;
						traceformat("+++created new region: %1",_mergedRegion)
						_usedRegions pushBack _regionA;
						_usedRegions pushBack _regionB;
						_mergedThisCycle = true;
						_continueMerge = true; // Повторить цикл после добавления объединенного региона
						break;
					};
				};

				_newRegions pushBack _mergedRegion;
			};

			_mergedRegions = _newRegions;
		};

		{
			_x callp(setRenderMode,true);
			false
		} count _mergedRegions;
		traceformat("output regions: %1",_mergedRegions)
		self getv(_regions) set [(_z - 1),_mergedRegions]
	}

	//внутренняя функция проверки при расширении
	def_ret(_isValidCombPos)
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
	def(onDecreaseRegion)
	{
		params ["_regionList","_region","_ltObj"];
		
		[_region getv(virtLights),_ltObj] call arrayDeleteItem;
		
		//debug restore lights
		// {
		// 	_x callv(reloadLight);
		// 	false
		// } foreach (_region getv(virtLights));
		
		private _pos = _ltObj getv(localChId);

		private _startPos = _region getv(startPos);
		private _endPos = _region getv(endPos);
		
		//removing region from list
		[_regionList,_region] call arrayDeleteItem;

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
			//remove lights
			_vligts = _vligts - _lproc;
			
			//traceformat("spliting: %1->%2 cnt: %3",_sp arg _sizes arg count _lproc)
			private _r = struct_newp(AtmosClientBatchRegion,self arg _sizes arg _sp arg _lproc);
			_regionList pushBack _r;
			_r callp(setRenderMode,true);
		} foreach _newRegions;

		//enable left lights
		{
			_x callv(reloadLight);
			false
		} count _vligts;
		//traceformat("LEFT VLIGHTS: %1",_vligts apply {_x getv(localChId)})
		
		private _z = (_pos select 2);

		self callp(mergeRegions,_regionList arg _z);
	}

endstruct

struct(AtmosVirtualLight)
	def(effects) null;
	def(id) -1; //config id
	def(localChId) null; //local chunk id from [1,1,1] to [10,10,10]

	def(regionPosInfo) null; //vec2<Pos3d,Pos2d>
	def(isInsideRegion) {!isNull(self getv(regionPosInfo))};

	//do not change this constval
	def(_fireTypes) [SLIGHT_ATMOS_FIRE_1,SLIGHT_ATMOS_FIRE_2,SLIGHT_ATMOS_FIRE_3];
	def(_smokeTypes) [SLIGHT_ATMOS_SMOKE_1,SLIGHT_ATMOS_SMOKE_2,SLIGHT_ATMOS_SMOKE_3];
	//check if atmos if firetype
	def(isFireType) {(self getv(id)) in (self getv(_fireTypes))}
	def(isSmokeType) {(self getv(id)) in (self getv(_smokeTypes))}

	def(init)
	{
		params ["_cfg","_pos","_lcid"];
		self setv(localChId,_lcid);
		self setv(localId,_lcid call atmos_encodeChId);
		self callp(loadEmitters,_cfg arg _pos);
	}

	def(loadEmitters)
	{
		params ["_cfg","_pos"];
		
		self setv(effects,[_cfg arg _pos] call le_se_createUnmanagedEmitter);
		self setv(id,_cfg);
		self setv(_pos,_pos);
	}

	def(deleteEmitters)
	{
		{
			deleteVehicle _x;
		} foreach (self getv(effects));
	}

	def(_pos) [0,0,0];

	def(getEmitterPos)
	{
		self getv(_pos)
	}
	def(getEmitterRealPos)
	{
		private _p = self getv(_unhide_pos);
		if !isNullVar(_p) then {
			_p
		} else {
			self getv(_pos)
		};
	}

	def(setEmitterPos)
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

	def(_unhide_pos) null;
	def(isHidden) {!isNull(self getv(_unhide_pos))}
	def(setHidden)
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

	def(del)
	{
		self callv(deleteEmitters);
	}
	
	def(updateLight)
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
	def(reloadLight)
	{
		self callp(updateLight,self getv(id));
	}

	def(isSameCfgType)
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

	def(str)
	{
		format["%1-%2",struct_typename(self),self getv(id)]
	}
endstruct

//структура региона
struct(AtmosClientBatchRegion)
	//локальные точки начала и конца зоны
	def(startPos) [0,0,0]
	def(endPos) [0,0,0]
	def(sizes) [0,0] //размер зоны

	def(areaId) null //айди зоны

	def(isEqualPosInfo)
	{
		params ["_start","_sizes"];
		equals(_start,self getv(startPos))
		&& {equals(_sizes,self getv(sizes))}
	}

	def(isSameCfgType)
	{
		params ["_otherVL"];
		self getv(virtLights) select 0 callp(isSameCfgType,_otherVL)
	}

	//получает дистанцию
	def(getDistanceTo)
	{
		params ["_posWorld"];
		//todo
		//(self getv(batchPos)) distance2d _posWorld;
	}

	//размер зоны оптимизации vec2
	def(renderZone) null
	//уменьшение дропа частиц
	def(decZoneRend) null 

	//references to AtmosVirtualLight
	def(virtLights) null //list<AtmosVirtualLight>

	def(registerVL)
	{
		params ["_vlORvlList"];
		private _rpi = vec2(self getv(startPos),self getv(sizes));
		if equalTypes(_vlORvlList,[]) then {
			(self getv(virtLights)) append _vlORvlList;
			{
				_x setv(regionPosInfo,_rpi);
				false
			} count _vlORvlList;
		} else {
			(self getv(virtLights)) pushBack _vlORvlList;
			_vlORvlList setv(regionPosInfo,_rpi);
		};
	}

	def(rebuildData)
	{
		private _sizes = self getv(sizes);

		self setv(endPos,(self getv(startPos)) vectorAdd _sizes);

		//define batchpos
		private _chid = [self getv(areaId),self getv(startPos)] call atmos_localChunkIdToGlobal;
		//pos of first chunk in area
		private _pos = (_chid call atmos_chunkIdToPos);
		private _midPos = _pos vectorAdd [
			(_sizes select 0)/2,
			(_sizes select 1)/2,
			0
		];
		self setv(batchPos,_midPos);
	}

	def(init)
	{
		params ["_area","_sizes","_startPos",["_virtLights",[]]];
		self setv(startPos,_startPos);
		private _endPos = _startPos vectorAdd _sizes;
		self setv(endPos,_endPos);
		self setv(sizes,_sizes);
		self setv(virtLights,_virtLights);
		
		self setv(areaId,_area getv(areaId));

		{
			_x setv(regionPosInfo,vec2(_startPos,_sizes));
			false
		} count _virtLights;

		private _cfg = SLIGHT_ATMOS_FIRE_3;
		private _femit = _virtLights select 0;
		if (_femit callv(isFireType)) then {
			_cfg = SLIGHT_ATMOS_FIRE_3;
		};
		if (_femit callv(isSmokeType)) then {
			_cfg = SLIGHT_ATMOS_SMOKE_3;
		};
		self setv(batchCfg,_cfg);

		traceformat("registered batchzone: from %1 to %2 ascfg %3 (lt:%4)",_startPos arg _endPos arg _cfg arg count _virtLights)

		//define batchpos
		private _chid = [self getv(areaId),_startPos] call atmos_localChunkIdToGlobal;
		//pos of first chunk in area
		private _pos = (_chid call atmos_chunkIdToPos);
		private _midPos = _pos vectorAdd [
			(_sizes select 0)/2,
			(_sizes select 1)/2,
			0
		];
		self setv(batchPos,_midPos);
	}

	def(str)
	{
		format["ABR:%1=>%2(%3)",self getv(startPos),self getv(endPos),self getv(sizes)];
	}

	def(del)
	{
		self callv(unloadBatchEmitter);
	}

	//включает или отключает режим рендера зоны. true - включение
	def(setRenderMode)
	{
		params ["_mode"];
		if (_mode) then {
			{
				_x callv(deleteEmitters);
				false
			} count (self getv(virtLights));
			self callv(reloadBatchEmitter);
		} else {
			{
				_x callv(reloadLight);
				false
			} count (self getv(virtLights));
			self callv(unloadBatchEmitter);
		};
	}

	def(batchCfg) -1 //конфиг батч эмиттера
	def(batchPos) [0,0,0] //глобальная позиция батч эмиттера
	def(batchIsLoaded) false //загружен ли визуал
	def(emitter) null //массив на world эмиттеры

	//обновляет батч
	def(reloadBatchEmitter)
	{
		if (self getv(batchIsLoaded)) then {
			self callv(unloadBatchEmitter);
		};
		self callv(loadBatchEmitter);
	}

	//загрузка батч эмиттера
	def(loadBatchEmitter)
	{
		if (self getv(batchIsLoaded)) exitWith {};

		private _renderZone = self getv(sizes);
		private _decZoneRend = self getv(decZoneRend);
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
				if (_alias == "Пламя") then {
					
					if (_p == "setparticlerandom") then {
						
						//update position
						private _old = [_p,"positionVar",_v] call le_se_getParticleOption;
						_old set [0,_szX/2 + ATMOS_SIZE_HALF];
						_old set [1,_szY/2 + ATMOS_SIZE_HALF];
						[_p,"positionVar",_v,_old] call le_se_setParticleOption;

						
					};
					//update drop
					if (_p == "setdropinterval") then {
						private _dropInterval = [_p,"interval",_v] call le_se_getParticleOption;
						[_p,"interval",_v,_dropInterval
						// /_renderZone
						] call le_se_setParticleOption;
					};
					//update size
					if (_p == "setParticleParams") then {
						private _size = [_p,"size",_v] call le_se_getParticleOption;
						[_p,"size",_v,_size apply {_x*(((_szX+_szY)/2)/2)}] call le_se_setParticleOption;

						#ifdef ENABLE_RANDOMIZATION_COLOR
						//random color
						private _colorArr = [_p,"color",_v] call le_se_getParticleOption;
						["clr %1",_colorArr] call cprint;
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
					if (_p == "setdropinterval") then {
						[_p,"interval",_v,1000] call le_se_setParticleOption;
					};
				};
				//disable refract
				if (_alias == "Преломление") then {
					if (_p == "setdropinterval") then {
						[_p,"interval",_v,1000] call le_se_setParticleOption;
					};
				};
				//smoke
				if (_alias == "Частицы 1") then {
					if (_p == "setparticlerandom") then {
						//update position
						private _old = [_p,"positionVar",_v] call le_se_getParticleOption;
						_old set [0,_szX/2 + ATMOS_SIZE_HALF];
						_old set [1,_szY/2 + ATMOS_SIZE_HALF];
						[_p,"positionVar",_v,_old] call le_se_setParticleOption;

						//_old = [_p,"lifeTimeVar",_v] call le_se_getParticleOption;
						//todo increase lifetime of smoke
					};
					if (_p == "setdropinterval") then {
						private _dropInterval = [_p,"interval",_v] call le_se_getParticleOption;
						//[_p,"interval",_v,_dropInterval/((_szX+_szY)/2)] call le_se_setParticleOption;
						private _cval = (_szX+_szY)/2;
						private _newdrop = linearconversion [0,10,_cval,_dropInterval,_dropInterval/100,true];
						[_p,"interval",_v,_newdrop] call le_se_setParticleOption;
					};
				};
			};
			
			

		};
		
		self setv(emitter,[self getv(batchCfg) arg self getv(batchPos) arg _funcHandle] call le_se_createUnmanagedEmitter);
		self setv(batchIsLoaded,true);

		#ifdef ENABLE_DRAW_DEBUG_LINES_REGIONS
		self getv(sizes) params ["_ddlX","_ddlY"];
		private _clrTp = [0,1,rand(0,0.3),1];
		if (self getv(batchCfg) == SLIGHT_ATMOS_FIRE_3) then {
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

	def(unloadBatchEmitter)
	{
		if (self getv(batchIsLoaded)) then {
			self setv(batchIsLoaded,false);
			deleteVehicle (self getv(emitter));
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