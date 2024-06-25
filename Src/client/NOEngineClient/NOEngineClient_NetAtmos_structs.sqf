// ======================================================
// Copyright (c) 2017-2024 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================
#include "..\..\host\struct.hpp"

struct(AtmosAreaClient)
	def(areaId) null;
	def(lastUpd) 0;
	def(lastDel) 0;

	def(chunks) null;

	def(init)
	{
		params ["_aId"];
		self setv(areaId,_aId);
		self setv(chunks,createHashMap); 
	}

	def(loadChunkEffect)
	{
		params ["_locChId","_light"];
		private _pos = [self getv(areaId),_locChId] call atmos_localChunkIdToGlobal;
		private _locid = _locChid call atmos_encodeChId;
		if (_locid in (self getv(chunks))) then {
			self callp(unloadChunk,_locid);
		};
		//todo - setv pos as center of chunk with bias
		self callp(loadChunk,_locid arg _pos arg _light);
	}

	def(loadChunk)
	{
		params ["_locid","_pos","_light"];
		private _vobj = self callp(createVisualObject,_pos);
		private _lt = [_light,_vobj] call le_loadLight;
		self getv(chunks) SET [_locid,[_vobj,_lt]];
	}

	def(unloadChunk)
	{
		params ["_locid"];
		private _chDat = self getv(chunks) GET _locid;
		if !isNullVar(_chDat) then {
			[_chDat select 0] call le_unloadLight;
			deletevehicle (_chDat select 0);
		};
	}

	def(createVisualObject)
	{
		params ["_pos"];
		private _vobj = "Sign_Arrow_F" createVehicleLocal [0,0,0];
		_vobj setposatl _pos;
		_vobj
	}

	def(str)
	{
		format["Area%1",self getv(areaId)]
	}
endstruct