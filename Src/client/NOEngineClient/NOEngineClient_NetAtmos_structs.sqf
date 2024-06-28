// ======================================================
// Copyright (c) 2017-2024 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================
#include "..\..\host\struct.hpp"
#include "NOEngineClient_NetAtmos.hpp"
/*
	Структура зоны атмоса
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
		private _vobj = self callp(_createVisual,_pos arg _basePos);
		private _lightObj = self callp(_loadLight,_light arg _vobj);
		
		//saving data
		_cDat set [NAT_CHUNKDAT_OBJECT,_vobj];
	}

	//вызывает обновление чанка при загруженной зоне
	def(onUpdateChunk)
	{
		params ["_locid"];
		private _cDat = self getv(chunks) get _locid;
		if isNullVar(_cDat) exitWith {};
		private _obj = _cDat select NAT_CHUNKDAT_OBJECT;
		if isNullReference(_obj) then {
			//create new object
			self callp(loadChunkInternal,_locid);
		} else {
			//update or create light 
			private _light = _cDat select NAT_CHUNKDAT_CFG;
			self callp(_loadLight,_light arg _obj);
		};
	}

	def(unloadChunkInternal)
	{
		params ["_locid"];
		private _cDat = self getv(chunks) get _locid;
		
		if isNullVar(_cDat) exitWith {};
		private _obj = _cDat select NAT_CHUNKDAT_OBJECT;
		if isNullReference(_obj) exitWith {};
		self callp(_deleteVisual,_obj);
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
		params ["_pos","_basePos"];
		private _vobj = "Sign_Arrow_F" createVehicleLocal [0,0,0];
		_vobj setvariable ["_basePos",_basePos];
		_vobj setposatl _pos;
		_vobj
	}

	def(_deleteVisual)
	{
		params ["_obj"];
		[_obj] call le_unloadLight;
		deleteVehicle _obj;
	}

	//load or recreate light
	def(_loadLight)
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
endstruct