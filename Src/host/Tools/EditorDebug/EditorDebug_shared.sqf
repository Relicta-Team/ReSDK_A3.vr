// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\oop.hpp>

editorDebug_serializePlayerSettings = {
	if (is3DEN) exitwith {};
	
	//do not save data in lobby
	if !(call client_isInGame) exitwith {};

	private _map = createHashMap;
	_map set ["pos",getposatl player];
	_map set ["dir",getdir player];
	private _gamemode = if !isNullReference(gm_currentMode) then {
		callFunc(gm_currentMode,getClassName)
	} else {
		""
	};
	_map set ["gamemode",_gamemode];
	private _mob = player getvariable ["link",nullPtr];
	private _mobRole = _mob getvariable ["basicRole",nullPtr];
	private _role = if (
		!isNullReference(_mob)
		&& {!isNullReference(_mobRole)}
	) then {
		if isTypeOf(_mob,Mob) then {
			callFunc(_mobRole,getClassName)
		} else {
			""
		}
	} else {
		""
	};
	_map set ["role",_role];

	profileNamespace setvariable ["resdk_cache_playerSettings",_map];
	saveprofilenamespace;
};

editorDebug_getPlayerSettings = {
	profileNamespace getvariable ["resdk_cache_playerSettings",createHashMap]
};

//only for 3den
editorDebug_updatePosAndDirInCache = {
	params ["_pos",["_dir",0]];
	if (!is3DEN) exitwith {};
	private _cache = call editorDebug_getPlayerSettings;

	_cache set ["pos",_pos];
	_cache set ["dir",_dir];

	profileNamespace setvariable ["resdk_cache_playerSettings",_cache];
	saveprofilenamespace;
};

editorDebug_internal_validateValuesCanStart = {
	params ["_cache"];
	#define checkdata(cachevalue) if !(cachevalue in _cache) exitwith {cachevalue}
	#define checkempty(cachevalue) if (_cache get cachevalue == "") exitwith {cachevalue}
	
	checkdata("pos");
	checkdata("dir");
	checkdata("gamemode");
	checkdata("role");

	checkempty("gamemode");
	checkempty("role");
	
	#undef checkdata
	#undef checkempty

	""
};