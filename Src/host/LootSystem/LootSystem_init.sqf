// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\engine.hpp>
#include <..\oop.hpp>
#include <..\struct.hpp>

loot_mapConfigs = createHashMap; //all crafts map
loot_mapTemplates = createHashMap; //template map (tagged)
loot_list_loader = [];// список файлов для загрузки

#ifdef EDITOR
loot_internal_catchedError = false;
#endif

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

loot_prepareAll = {
	private _skipLoad = false;
	
	#ifdef SP_MODE
	if(true)exitWith{};
	#endif

	#ifdef TEST_IO
	_skipLoad = true;
	#endif
	
	if (_skipLoad) exitWith {};
	
	private _fileList = ["src\host\LootSystem\Collections",".yml",true] call fso_getFiles;
	if (count _fileList == 0) exitWith {
		setLastError("loot::prepareAll() - no loot templates was found");
	};
	{
		[_x] call loot_addConfig;
	} foreach _fileList;

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
		private _cfg = struct_newp(LootTemplate,_cfgType arg _path arg _cfgData);
		if (_cfg getv(__hasErrorOnCreate)) exitWith {
			_error = true;
		};
		loot_mapConfigs set [_cfgType,_cfg];
	} foreach _d;

	if (_error) exitWith {false};

	private _its = (keys loot_mapConfigs) arrayIntersect (keys loot_mapTemplates);
	if (count _its > 0) then {
		setLastError(vec2("Loot configs and tags collision: %1",_its joinString endl));
		false
	};

	//!inheritance disabled
	/*
		BaseLoot <- TestLoot <- TestLootExtended
		lookbehind:
	*/
	// {
	// 	private _cur = _y;
	// 	private _base = _cur getv(inherit);
		
	// 	private _defItems = count (_cur getv(items)) > 0;
	// 	private _defMaps = count (_cur getv(allowMaps)) > 0;
	// 	private _defModes = count (_cur getv(allowModes)) > 0;

	// 	while {!isNullVar(_base)} do {
	// 		private _baseObj = loot_mapConfigs get _base;
	// 		if isNullVar(_baseObj) exitWith {
	// 			errorformat("loot::loadConfig() - Unknown config '%1' in '%2'",_base arg _cur getv(path));
	// 			_error = true;
	// 		};
	// 		if (!_defItems && {count (_baseObj getv(items)) > 0}) then {
	// 			_defItems = true;
	// 			_cur setv(items,_baseObj getv(items));
	// 		};
	// 		if (!_defMaps && {count (_baseObj getv(allowMaps)) > 0}) then {
	// 			_defMaps = true;
	// 			_cur setv(allowMaps,_baseObj getv(allowMaps));
	// 		};
	// 		if (!_defModes && {count (_baseObj getv(allowModes)) > 0}) then {
	// 			_defModes = true;
	// 			_cur setv(allowModes,_baseObj getv(allowModes));
	// 		};

	// 		if all_of([_defItems arg _defMaps arg _defModes]) exitWith {};
	// 		_base = _baseObj getv(inherit);
	// 	};
	// } foreach loot_mapConfigs;
	
	true
};

loot_processObject = {
	params ["_type","_obj"];
	
	private _curmode = gm_currentMode;
	assert(!isNullReference(_curmode));

	private _isCollection = "." in _type;
	private _cfg = ifcheck(_isCollection,loot_mapTemplates,loot_mapConfigs) get _type;
	if isNullVar(_cfg) exitWith {
		errorformat("loot::processObject() - Unknown config or tag '%1'",_type);
	};
	if (_isCollection) then {
		//exclude restrictions
		_cfg = _cfg select {_x callp(checkLootSpawnRestriction,_modeClass)};
		//select random item
		_cfg = pick _cfg;
	} else {
		private _modeClass = callFunc(_curmode,getClassName);
		if !(_cfg callp(checkLootSpawnRestriction,_modeClass)) exitWith {};
	};	

	_cfg callp(processSpawnLoot,_obj);
};

#ifdef EDITOR
	loot_internal_editor_reloadLooting = {
		//cleanup all
		loot_mapConfigs = createHashMap;
		loot_mapTemplates = createHashMap;
		loot_list_loader = [];
		//load
		call loot_prepareAll;
	};

	loot_editor_isLoadedLib = {
		!isNull(loot_list_loader) && {count loot_mapConfigs > 0}
	};

	loot_editor_getTemplateByInput = {
		params ["_input"];
		private _isCollection = "." in _input;
		private _r = ifcheck(_isCollection,loot_mapTemplates,loot_mapConfigs) get _input;
		if (!isNullVar(_r) && {_isCollection}) then {
			_r = pick _r;
		};
		_r
	};

	loot_internal_editor_previewBuffer = [];

	
#endif