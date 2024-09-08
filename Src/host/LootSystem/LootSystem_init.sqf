// ======================================================
// Copyright (c) 2017-2024 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\engine.hpp>
#include <..\struct.hpp>

loot_mapConfigs = createHashMap;
loot_list_loader = [];// список файлов для загрузки
loot_init = {
	{
		if !([_x] call loot_loadConfig) exitWith {
			setLastError("Loot system build failed. See console for more details");
		};
	} foreach loot_list_loader;
};

loot_addConfig = {
	params ["_cfgPath"];
	
	loot_list_loader pushBack _cfgPath;
};

loot_internal_resolvePath = {
	params ["_p"];
	private _patterns = [
		"Collections\%1.yml",
		"Collections\%1",
		"%1",
		"%1.yml"
	];
	private _prefix = "src\host\LootSystem\";
	private _founded = _p splitString "/\" joinString "\";
	{
		private _patternPrep = format [_x,_p];
		if (fileExists(_patternPrep)) exitWith {
			_founded = format [_x,_p];
		};
		if (fileExists(_prefix+_patternPrep)) exitWith {
			_founded = _prefix + _patternPrep;
		};
	} foreach _patterns;
	_founded
};

loot_prepareAll = {
	
	#ifdef RBUILDER
	if (true) exitWith {};
	#endif
	#ifdef __VM_VALIDATE
	if (true) exitWith {};
	#endif

	private _pathLoader = "src\host\LootSystem\loader.sqf";
	private _content = (loadfile _pathLoader) splitString endl;
	if (count _content == 0) exitWith {
		setLastError("loot::prepareAll() - no loot templates was found in " + _pathLoader);
	};
	{
		[[_x] call loot_internal_resolvePath] call loot_addConfig;
	} foreach _content;

	call loot_init;
};

loot_loadConfig = {
	params ["_path"];
	private _d = [_path] call yaml_loadFile;
	if isNullVar(_d) exitWith {
		errorformat("loot::loadConfig() - Cannot load %1",_path);
		false
	};

	private _error = false;
	{
		[_x,_y] params ["_cfgType","_cfgData"];
		if (_cfgType in loot_mapConfigs) exitWith {
			private _cfg = loot_mapConfigs get _cfgType;
			errorformat("loot::loadConfig() - Duplicate config '%1'; First defined in '%2'",_cfgType arg _cfg getv(path));
			_error = true;
		};
		private _cfg = struct_newp(LootTempate,_cfgType arg _path arg _cfgData);
		if (_cfg getv(__hasErrorOnCreate)) exitWith {
			_error = true;
		};
		loot_mapConfigs set [_cfgType,_cfg];
	} foreach _d;

	if (_error) exitWith {false};

	//inherit
	/*
		BaseLoot <- TestLoot <- TestLootExtended
		lookbehind:
	*/
	{
		private _cur = _y;
		private _base = _cur getv(inherit);
		
		private _defItems = count (_cur getv(items)) > 0;
		private _defMaps = count (_cur getv(allowMaps)) > 0;
		private _defModes = count (_cur getv(allowModes)) > 0;

		while {!isNullVar(_base)} do {
			private _baseObj = loot_mapConfigs get _base;
			if isNullVar(_baseObj) exitWith {
				errorformat("loot::loadConfig() - Unknown config '%1' in '%2'",_base arg _cur getv(path));
				_error = true;
			};
			if (!_defItems && {count (_baseObj getv(items)) > 0}) then {
				_defItems = true;
				_cur setv(items,_baseObj getv(items));
			};
			if (!_defMaps && {count (_baseObj getv(allowMaps)) > 0}) then {
				_defMaps = true;
				_cur setv(allowMaps,_baseObj getv(allowMaps));
			};
			if (!_defModes && {count (_baseObj getv(allowModes)) > 0}) then {
				_defModes = true;
				_cur setv(allowModes,_baseObj getv(allowModes));
			};

			if all_of([_defItems arg _defMaps arg _defModes]) exitWith {};
			_base = _baseObj getv(inherit);
		};
	} foreach loot_mapConfigs;
	
	true
};

loot_processObject = {
	params ["_type","_obj"];

	private _cfg = loot_mapConfigs get _type;
	if isNullVar(_cfg) exitWith {
		errorformat("loot::processObject() - Unknown config '%1'",_type);
	};
	if (_cfg getv(isInterface)) exitWith {
		errorformat("loot::processObject() - Cannot spawn interface '%1'",_type);
	};
	_cfg callp(processSpawnLoot,_obj);
};