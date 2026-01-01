// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================


#include <..\..\engine.hpp>


sdk_isFirstLoad = isNull(sdk_firstLoadFlag);

//init only if sdk_isFirstLoad
if (sdk_isFirstLoad) then {

	sdk_list_systemFlags = null;
	sdk_map_SDKProps = null;
};

sdk_init = {

	if isNull(sdk_list_systemFlags) then {
		//constant path
		(getMissionPath "src\Editor\EditorSDKConfig.txt") call sdk_internal_loadSDKConfig;
	};

	if isNull(sdk_list_systemFlags) exitwith {
		error("Cannot initialize SDK info");
		appExit(APPEXIT_REASON_CRITICAL);
	};


	if (sdk_isFirstLoad) then {
		sdk_firstLoadFlag = true;
	};
};

sdk_internal_loadSDKConfig = {
	private _pathFull = _this;

	if ((["FileManager","Exists",[_pathFull],true] call rescript_callCommand)!="true") exitwith {
		sdk_list_systemFlags = [];
		sdk_map_SDKProps = createHashMap;
	};

	
	private _dat = ["FileManager","Read",[_pathFull,""],true] call rescript_callCommand;
	assert_str(not_equals(_dat,"$BUFFER_OVERFLOW$"),"Cannot read sdk config file - buffer overflow");

	_dat = call compile (_dat regexReplace ["/g",""""]);
	sdk_list_systemFlags = _dat select 0;
	sdk_map_SDKProps = _dat select 1;
};

// system flags is simple flaglist for bool check
sdk_getSystemFlags = {
	sdk_list_systemFlags
};

sdk_hasSystemFlag = {
	_this in (call sdk_getSystemFlags)
};

//sdk property list is simple getter some values from editor
sdk_getSDKPropertyMap = {
	sdk_map_SDKProps
};

sdk_getPropertyValue = {
	params ["_key","_def"];
	private _map = (call sdk_getSDKPropertyMap);
	if isNullVar(_def) then {
		_map get _key
	} else {
		_map getOrDefault [_key,_def]
	};
};



call sdk_init;