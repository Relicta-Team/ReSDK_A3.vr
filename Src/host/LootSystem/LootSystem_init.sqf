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

loot_loadConfig = {
	params ["_path"];
	private _d = [_path] call io_praseYaml;
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

	true
};