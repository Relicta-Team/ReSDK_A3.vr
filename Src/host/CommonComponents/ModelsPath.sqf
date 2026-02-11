// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\engine.hpp>

model_getAssoc = {
	params ["_value"];
	
	private _hashmap = if equalTypes(_value,"") then {_value = tolower _value;core_assoc_model2id} else {core_assoc_id2model};
	
	private _dat = _hashmap get _value;
	if isNullVar(_dat) exitWith {
		warningformat("model::getAssoc() - cant find assoc %1 by type %2",_value arg toLower typeName _value);
		_value;
	};
	
	_dat
};

call compile preprocessFileLineNumbers "src\M2C.sqf";

#include <ModelTransform.hpp>

#ifdef DEBUG
model_debug_dumpAllModels = {
	model_debug_output_dump = [];
	model_debug_map_all = createHashMap;
	for "_i" from 0 to count configFile do {
		_cfgRoot = configFile select _i;
		if !isCLASS(_cfgRoot) then {continue};
		for "_j" from 0 to count _cfgRoot do {
			_cfg = _cfgRoot select _j;
			if !isCLASS(_cfg) then {continue};
			_mdl = tolower gettext(_cfg >> "model");
			if (_mdl in model_debug_map_all) then {
				continue;
			} else {
				if (_mdl != "") then {
					model_debug_output_dump pushBack _mdl;
					model_debug_map_all set [_mdl,0];
				};
			};
			
		};
	};
	
	copyToClipboarD ( (model_debug_output_dump joinString endl));
};
#endif
/*
	models:
	\a3\weapons_f_orange\ammo\bombcluster_02_sub_f - гравицапа какая-то
	\a3\weapons_f\ammo\mag_univ.p3d - маг в коробке (арма)
	
*/


