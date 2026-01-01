// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================


function(mm_virt_build)
{
	params ["_mapname","_options"];
};


function(mm_virt_internal_loadMapConfig)
{
	params ["_mapName"];

	private _cfgPath = core_path_maps + "\"+_mapName+core_path_binarizedMapFileExt;
	
	_cfgPath = [_cfgPath,"\//",'\'] call regex_replace;

	["Attempt load config %1",_cfgPath] call printTrace;

	private _cfg = loadConfig _cfgPath;
	private _cfgMap = _cfg call mm_virt_internal_cfgConvertClass;
	["loaded %1 keys",count keys _cfgMap] call printTrace;
}


//used from https://community.bistudio.com/wiki/loadConfig
function(mm_virt_internal_cfgConvertClass)
{
	params ["_cfgClass"];

	private _result = createHashMap;
	private _props = configProperties [_cfgClass, "true", true];
	// note: Hashmaps are case-sensitive so configName cases have to be consistent (e.g. all lowercase)
	{
		if (isNumber _x)	then { _result set [toLowerANSI configName _x, getNumber _x];	continue; };
		if (isText _x)		then { _result set [toLowerANSI configName _x, getText _x];		continue; };
		if (isArray _x)		then { _result set [toLowerANSI configName _x, getArray _x];	continue; };
	} forEach _props;

	private _classes = "true" configClasses _cfgClass;
	{
		_result set [toLowerANSI configName _x, _x call mm_virt_internal_cfgConvertClass];
	} forEach _classes;

	_result;
};