// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

/*
	BlastFX - компонент для проигрывания кратковременных визуальных эффектов
	Например: взрыв, эффект попадания, выстрел и т.д.
*/

#include <..\..\host\engine.hpp>
#include <..\..\host\struct.hpp>
#include "BlastFX_structs.sqf"

namespace(BlastFX,bfx_)

decl(map<string;string>)
bfx_map_configTable = createHashMap; //key: configName, value: struct typename
decl(bool)
bfx_isInitialized = false;

//initialize assoc table
decl(void())
bfx_initialize = {
	private _types = ["BFXBase"] call struct_getAllTypesOf;
	if (count _types == 0) exitWith {
		setLastError("BFX: Not found any BFXs");
	};
	{
		private _cfgName = [_x,"name"] call struct_reflect_getTypeValue;
		if (_cfgName != "") then {
			bfx_map_configTable set [_cfgName,_x];
		};
	} foreach _types;
	bfx_isInitialized = true;
};

//call effect by name
decl((struct_t.AbstractLightData|NULL)(string;mesh;any[]))
bfx_doShot = {
	params ["_type","_src",["_ctxParams",[]]];
	//traceformat("BFX::doShot(%1) on %2 with %3",_type arg _src arg _ctxParams);
	if (!bfx_isInitialized) then {
		call bfx_initialize;
	};

	if !array_exists(bfx_map_configTable,_type) exitWith {
		errorformat("BFX::doShot() - Undefined key: %1",_type);
		null
	};
	
	private _obj = [bfx_map_configTable get _type,[_src]] call struct_alloc;
	if isNullVar(_obj) exitWith {
		errorformat("BFX::doShot() - Failed to create object: %1",bfx_map_configTable get _type);
		null
	};
	_obj callp(activate,_ctxParams);
	_obj callv(postActivate);
	
	_obj
};	

//check if config valid
decl(bool(string))
bfx_containConfig = {
	params ["_type"];
	if (!bfx_isInitialized) then {
		call bfx_initialize;
	};
	array_exists(bfx_map_configTable,_type)
};