// ======================================================
// Copyright (c) 2017-2024 the ReSDK_A3 project
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

model_convertPithBankYawToVec = { 
	/*"_object","_rotations",*/
	private ["_aroundX","_aroundY","_aroundZ","_dirX","_dirY","_dirZ","_upX","_upY","_upZ","_dir","_up","_dirXTemp","_upXTemp"];
/*	_object = _this select 0;
	_rotations = _this select 1;*/
	_aroundX = _this select 0;
	_aroundY = _this select 1;
	_aroundZ = (360 - (_this select 2)) - 360;
	_dirX = 0;
	_dirY = 1;
	_dirZ = 0;
	_upX = 0;
	_upY = 0;
	_upZ = 1;
	if (_aroundX != 0) then { 
		_dirY = cos _aroundX;
		_dirZ = sin _aroundX;
		_upY = -sin _aroundX;
		_upZ = cos _aroundX;
	};
	if (_aroundY != 0) then { 
		_dirX = _dirZ * sin _aroundY;
		_dirZ = _dirZ * cos _aroundY;
		_upX = _upZ * sin _aroundY;
		_upZ = _upZ * cos _aroundY;
	};
	if (_aroundZ != 0) then { 
		_dirXTemp = _dirX;
		_dirX = (_dirXTemp* cos _aroundZ) - (_dirY * sin _aroundZ);
		_dirY = (_dirY * cos _aroundZ) + (_dirXTemp * sin _aroundZ);
		_upXTemp = _upX;
		_upX = (_upXTemp * cos _aroundZ) - (_upY * sin _aroundZ);
		_upY = (_upY * cos _aroundZ) + (_upXTemp * sin _aroundZ);
	};
	/*_dir = [_dirX,_dirY,_dirZ];
	_up = [_upX,_upY,_upZ];*/
	[[_dirX,_dirY,_dirZ],[_upX,_upY,_upZ]];
};

model_SetPitchBankYaw = {
	params ["_object","_data"];
	(_data call model_convertPithBankYawToVec) params ["_dir","_up"];
	_object setVectorDirAndUp [_dir,_up];
};

model_getPitchBankYaw = {
	params ["_vehicle"];
	(_vehicle call BIS_fnc_getPitchBank) + [getDir _vehicle]
};

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


