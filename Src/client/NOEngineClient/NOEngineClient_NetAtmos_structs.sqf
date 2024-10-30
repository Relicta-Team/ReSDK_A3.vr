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

//рандомные цвета для зон
#define ENABLE_RANDOMIZATION_COLOR

#ifndef EDITOR
	#undef ENABLE_RANDOMIZATION_COLOR
#endif

struct(AtmosAreaClient)
	def(areaId) null;
	def(lastUpd) 0;
	def(lastDel) 0;

	def(state) NAT_LOADING_STATE_NOT_LOADED;
	def(isLoaded) {(self getv(state)) == NAT_LOADING_STATE_LOADED}

	def(chunks) null; //key:localid,value vec2(cfg,obj)

	def(init)
	{
		params ["_aId"];
		self setv(areaId,_aId);
		self setv(chunks,createHashMap); 
	}

	//регистрация|перерегистрация эффектов в зоне
	def(registerEffects)
	{
		params ["_locid","_light"];

		if (_locid in (self getv(chunks))) then {
			self getv(chunks) get _locid set [NAT_CHUNKDAT_CFG,_light];
		} else {
			self getv(chunks) set [_locid,NAT_CHUNKDAT_NEW(_light)];
		};

		if (self callv(isLoaded)) then {
			self callp(onUpdateChunk,_locid);
		};
	}

	//снятие регистрации эффектов чанка. удаляет визуальный объект и выписывает чанк из хранилища
	def(unregisterEffects)
	{
		params ["_locid"];
		private _chDat = self getv(chunks) GET _locid;

		self getv(chunks) deleteAt _locid;
	}

	//загружает визуал зоны
	def(loadArea)
	{		
		{
			self callp(loadChunkInternal,_x);
			false
		} count (self callv(getChunkIdList));
		
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

		self callp(onChangedAreaInfo,_locid arg true);
	}

	def(unloadChunkInternal)
	{
		params ["_locid"];
		private _cDat = self getv(chunks) get _locid;
		
		if isNullVar(_cDat) exitWith {};
		private _ltObj = _cDat select NAT_CHUNKDAT_OBJECT;
		if isNullVar(_ltObj) exitWith {};
		self callp(_deleteVisual,_ltObj);
		_cDat set [NAT_CHUNKDAT_OBJECT,null];

		self callp(onChangedAreaInfo,_locid arg false);
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
		#endif

		struct_newp(AtmosVirtualLight,_light arg _pos arg _chid);
	}

	def(_deleteVisual)
	{
		params ["_obj"];
		
		#ifdef NAT_DEBUG_ENABLE_VISUAL_HELPER
		deleteVehicle (self get "__debug_visual");
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

	//! Это нигде не используется
	def(onChangedAreaInfo)
	{
		params ["_chid","_isCreateOrUpdate"];
		if (true) exitWith {};
		#ifndef ENABLE_OPTIMIZATION
		#endif
		
		private _locPos = _chid call atmos_decodeChId;
		//traceformat("change area chid: %1; lpos %2",_chid arg _locPos)
		private _chidconn = null;
		private _chMap = self getv(chunks);
		private _curLt = _chMap get _chid select NAT_CHUNKDAT_OBJECT;
		{
			_chidconn = _x call atmos_encodeChId;
			if (_chidconn in _chMap) then {
				private _ltObj = _chMap get _chidconn select NAT_CHUNKDAT_OBJECT;
				//traceformat("  mod offs; before %1",(_curLt getv(aroundCtr)) arg _ltObj)
				if (_isCreateOrUpdate) then {
					_curLt modv(aroundCtr, + 1);
					_ltObj modv(aroundCtr, + 1);
				} else {
					_curLt modv(aroundCtr, - 1);
					_ltObj modv(aroundCtr, - 1);
				};
				//traceformat("  mod offs; after %1",(_curLt getv(aroundCtr)) arg _ltObj)
			};
		} foreach [
			_locPos vectorAdd [0,1,0],
			_locPos vectorAdd [0,-1,0],
			_locPos vectorAdd [1,0,0],
			_locPos vectorAdd [-1,0,0],
			
			_locPos vectorAdd [-1,1,0],
			_locPos vectorAdd [1,1,0],
			_locPos vectorAdd [-1,-1,0],
			_locPos vectorAdd [1,-1,0]
		];
	}

	def(optimizeProcess)
	{
		#ifndef ENABLE_OPTIMIZATION
		if (true) exitWith {};
		#endif
		//_level vec3
		params ["_level"]; //Если параметр _level не равен null то это полная перегрузка зоны
		traceformat("Start optimization of level %1",ifcheck(isNullVar(_level),"ALL",_level))
		/*
			1. группируем зоны по z
			2. проходим все z уровни

			TODO доп оптимизация. валидируем только уровень на который добавлен чанк

			инфо: 
			мы можем делать доп оптимизацию по z
			если в регионе сверху есть регион такого же уровня
		*/
		private _chs = (self callv(getChunkIdList)) apply {[_x call atmos_decodeChId,_x]};
		traceformat("  --- all objects count: %1",count _chs)
		private _alist = [];
		_alist resize (ATMOS_AREA_SIZE);
		_alist = _alist apply {[]};
		private _curZ = null;
		//collect zposes
		private _chMap = self getv(chunks);
		private _mapAssoc = createhashMap;
		private _obj = null;
		{
			_x params ["_locPos","_chidloc"];
			_curZ = (_locpos select 2)-1;
			(_alist select _curZ) pushBack _locPos;
			_obj = _chMap get _chidloc select NAT_CHUNKDAT_OBJECT;
			_obj callv(resetVars);
			_mapAssoc set [_locPos,_obj];
		} foreach _chs;
		
		private _obj = null;

		// Функция для поиска максимального квадратного региона с текущей позиции
		private _findMaxSquare = {
			params ["_pos", "_activeChunks"];
			private _x = _pos select 0;
			private _y = _pos select 1;
			private _z = _pos select 2;
			private _size = 0;
			for "_i" from 1 to (ATMOS_AREA_SIZE) do {
				if (!([_x + _i, _y + _size, _z] in _activeChunks)) exitWith {};
				if (!([_x + _size, _y + _i, _z] in _activeChunks)) exitWith {};
				modvar(_size) + 1;
			};
			// while {true} do {
			// 	private _isSquare = true;

			// 	// Проверяем, что квадрат _size x _size заполнен огнями
			// 	for "_i" from 0 to _size - 1 do {
			// 		if (!([_x + _i, _y + _size, _z] in _activeChunks)) exitWith {_isSquare = false};
			// 		if (!([_x + _size, _y + _i, _z] in _activeChunks)) exitWith {_isSquare = false};
			// 	};

			// 	// Увеличиваем размер квадрата, если он полностью заполнен огнем
			// 	if (_isSquare 
			// 	//&& (_x + _size <= 10) && (_y + _size <= 10)
			// 	) then {
			// 		_size = _size + 1;
			// 	} else {
			// 		break;
			// 	};
			// };
			
			// Итоговый размер квадрата
			_size
		};

		private _processZOpt = {
			params ["_z","_activeChunks"];
			private _optList = []; //сюда записываются объекты оптимизации
			
			private _processed = []; // Отслеживание обработанных чанков для уровня
			
			// Поиск квадратных регионов
			{
				private _locPos = _x; //call atmos_decodeChId;
				private _pos = _locPos;//[_locPos select 0, _locPos select 1];

				// Пропускаем уже обработанные чанки
				if (_pos in _processed) then {
					//traceformat("pos in processed; exit pos: %1",_pos);
					continue;
				};
				//traceformat("process pos %1",_pos)

				// Находим максимальный квадратный регион от этой позиции
				private _size = [_pos, _activeChunks] call _findMaxSquare;
				traceformat("  Max size for pos %1 is %2", _pos arg _size)
				
				//ограничение зоны по квадратам. Прим.: 5x5 - ok; 6x6 -> lower to 5
				//_size = _size - (_size%2);

				if (_size == 0) then {
					//test hide
					_optList pushBack (_mapAssoc get (_pos));
					continue;
				};


				// Помечаем все чанки внутри найденного региона как обработанные
				for "_i" from 0 to _size do {
					for "_j" from 0 to _size do {
						private _chunkPos = _locPos vectorAdd [_i,_j,0];
						_processed pushBack _chunkPos;
						_mapAssoc get (_chunkPos ) callp(setHidden,true);
						//traceformat("  hide pos %1 exists %2",_chunkPos arg _chunkPos in _mapAssoc)
					};
				};

				// Определяем центральную позицию для "огня"
				private _centerPos = [
					(_pos select 0) + floor(_size / 2),
					(_pos select 1) + floor(_size / 2),
					_z
				];
				traceformat("  unhide pos %1 exists %2",_centerPos arg _centerPos in _mapAssoc)
				private _centerObj = _mapAssoc get _centerPos;
				_centerObj callp(setHidden,false);
				_centerObj setv(renderZone,_size);
				//смещение на следующую зону
				if (_size%2==1) then {
					_centerObj setv(useOffsetMid,true);
				};
				_centerObj callv(reloadLight);

				// Создаём "центральный огонь" для региона, с размером _size
				
			} foreach _activeChunks;

			private _ctrend = count _optList;
			if (_ctrend > 0) then {
				{
					_x setv(decZoneRend,_ctrend);
					_x callv(reloadLight);
					false
				} count _optList;
			};
		};

		{
			private _z = _foreachIndex + 1;
			//traceformat(" ----- process zlevel: %1; count %2",_z arg count _x)
			if (count _x > 0) then {
				_x sort true; //by near to far
				[_z,_x] call _processZOpt;
			};
		} foreach _alist;
	}

endstruct


struct(AtmosVirtualLight)
	def(effects) null;
	def(id) -1; //config id
	def(localChId) null; //local chunk id from [1,1,1] to [10,10,10]

	def(aroundCtr) 0
	
	//размер зоны оптимизации
	def(renderZone) null
	//уменьшение дропа частиц
	def(decZoneRend) null 
	//при включении блок создается со смещением 0.5
	def(useOffsetMid) false

	def(resetVars)
	{
		self setv(renderZone,null);
		self setv(decZoneRend,null);
		self setv(useOffsetMid,false);
	}

	//do not change this constval
	def(_fireTypes) [SLIGHT_ATMOS_FIRE_1,SLIGHT_ATMOS_FIRE_2,SLIGHT_ATMOS_FIRE_3];
	//check if atmos if firetype
	def(isFireType) {(self getv(id)) in (self getv(_fireTypes))}

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
		private _renderZone = self getv(renderZone);
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
				if (_alias == "Пламя") then {
					
					if (_p == "setparticlerandom") then {
						
						//update position
						private _old = [_p,"positionVar",_v] call le_se_getParticleOption;
						_old set [0,_renderZone/2];
						_old set [1,_renderZone/2];
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
						[_p,"size",_v,_size apply {_x*(_renderZone/2)}] call le_se_setParticleOption;

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
						_old set [0,_renderZone/2];
						_old set [1,_renderZone/2];
						[_p,"positionVar",_v,_old] call le_se_setParticleOption;
					};
					if (_p == "setdropinterval") then {
						private _dropInterval = [_p,"interval",_v] call le_se_getParticleOption;
						[_p,"interval",_v,_dropInterval/_renderZone] call le_se_setParticleOption;
					};
				};
			};
			
			

		};
		private _placePos = _pos;
		if (self getv(useOffsetMid)) then {
			_placePos = _placePos vectorAdd [ATMOS_SIZE_HALF,ATMOS_SIZE_HALF,0];
		};
		self setv(effects,[_cfg arg _placePos arg _funcHandle] call le_se_createUnmanagedEmitter);
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
		// private _eff = self getv(effects);
		// private _vec3Zero = [0,0,0];
		// if isNullVar(_eff) exitWith {_vec3Zero};
		// if (count _eff == 0) exitWith {_vec3Zero};
		// private _ppos = null;
		// {
		// 	_ppos = getposatl _x;
		// 	if not_equals(_ppos,_vec3Zero) exitWith {
		// 		_vec3Zero = _ppos; //update and return
		// 	};
		// } count _eff;
		// _vec3Zero
		//getPosAtl (_eff select 0)
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

	def(str)
	{
		format["%1-%2",struct_typename(self),self getv(id)]
	}
endstruct