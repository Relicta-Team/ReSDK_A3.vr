// ======================================================
// Copyright (c) 2017-2024 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================
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
*/

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

		self callv(optimizeRegion);
	}

	def(unloadArea)
	{
		{
			self callp(unloadChunkInternal,_x);
			false
		} count (self callv(getChunkIdList));
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
		private _ltObj = self callp(_createVisual,_light arg _pos arg _basePos);
		
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

		self callv(optimizeRegion);
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
	}

	def(deleteChunk)
	{
		params ["_locid"];
		
		if (_locid in (self getv(chunks))) then {
			self callp(unloadChunkInternal,_locid);
		};
		self callp(unregisterEffects,_locid);
	}


	def(_createVisual)
	{
		params ["_light","_pos","_basePos"];
		#ifdef NAT_DEBUG_ENABLE_VISUAL_HELPER
		private _vobj = "Sign_Arrow_F" createVehicleLocal [0,0,0];
		_vobj setvariable ["_basePos",_basePos];
		_vobj setposatl _pos;
		self set ["__debug_visual",_vobj];
		#endif

		struct_newp(AtmosVirtualLight,_light arg _pos);
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

	def(optimizeRegion)
	{
		if (true) exitWith {}; //not optimized...

		//fill leveling
		private _levels = [];
		_levels resize (ATMOS_AREA_SIZE+1);//because locid started at 1
		_levels = _levels apply {[]};

		private _chunks = self getv(chunks);
		{
			_chIdLoc = [_x] call atmos_decodeChId;
			_chIdLevel = _chIdLoc select 0;
			if isNull(_y select NAT_CHUNKDAT_OBJECT) then {continue};

			_levels select _chIdLevel pushBack [_x,(_y select NAT_CHUNKDAT_OBJECT)];
			(_y select NAT_CHUNKDAT_OBJECT) callp(setHidden,false);
		} foreach _chunks;

		_aroundMapper = [+100,-100,+10,-10];
		_countMapper = count _aroundMapper;
		_probId = null;
		{
			{
				_x params ["_locid","_ltObj"];
				if ({
					_probId = _locid+_x;
					_probId in _chunks
					&& {!(_chunks get _probId select NAT_CHUNKDAT_OBJECT callv(isHidden))}
				} count _aroundMapper == _countMapper) then {
					{
						_probId = _locid+_x;
						_chunks get _probId select NAT_CHUNKDAT_OBJECT callp(setHidden,true);
					} foreach _aroundMapper;
				};
			} foreach _x;
		} foreach _levels;
	}

endstruct


struct(AtmosVirtualLight)
	def(effects) null;
	def(id) -1;

	def(init)
	{
		params ["_cfg","_pos"];
		
		self callp(loadEmitters,_cfg arg _pos);
	}

	def(loadEmitters)
	{
		params ["_cfg","_pos"];
		private _funcHandle = {
			params ["_o","_p","_v","_i"];

			//use le_se_getParticleOption, le_se_setParticleOption for change object options
		};
		self setv(effects,[_cfg arg _pos arg _funcHandle] call le_se_createUnmanagedEmitter);
		self setv(id,_cfg);
	}

	def(deleteEmitters)
	{
		{
			deleteVehicle _x;
		} foreach (self getv(effects));
	}

	def(getEmitterPos)
	{
		private _eff = self getv(effects);
		private _vec3Zero = [0,0,0];
		if isNullVar(_eff) exitWith {_vec3Zero};
		if (count _eff == 0) exitWith {_vec3Zero};
		getPosAtl (_eff select 0)
	}

	def(setEmitterPos)
	{
		params ["_pos"];
		private _eff = self getv(effects);
		if isNullVar(_eff) exitWith {};
		if (count _eff == 0) exitWith {};
		private _baseObj = _eff select 0;
		private _basePos = getPosAtl _baseObj;
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

			self callp(setEmitterPos,(self getv(_unhide_pos)) vectorAdd vec3(0,0,1000));
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
		private _pos = self callv(getEmitterPos);
		if equals(_pos,vec3(0,0,0)) exitWith {
			setLastError("Invalid emitter position; ctx: "+str [self arg self getv(effects) arg count (self getv(effects)) arg _pos]);
		};
		self callv(deleteEmitters);
		self callp(loadEmitters,_cfg arg _pos);
	}

	def(str)
	{
		format["%1-%2",struct_typename(self),self getv(id)]
	}
endstruct