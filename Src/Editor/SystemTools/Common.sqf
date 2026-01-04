// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================



function(systools_checkClassPathes)
{
	if (!goasm_isbuilded) exitWith {
		["Game object assembly not builded..."] call printLog;
	};
	
	_errored = [];
	{
		(missionNameSpace getVariable ("pt_"+_x) getVariable "__decl_info__")params ["_f","_l"];
		["%1 - %2 at line %3",_x,_f,_l] call printlog;
		
		if !("\" in _f) then {
			_errored pushBack [_x,_f,_l];
		};
	} foreach (["object",true] call oop_getinhlist);
	
	for "_i" from 1 to 5 do {
		[""] call printLog;
	};
	
	if (count _errored > 0) then {
		{
			["%1			%2 at %3",_x select 0,_x select 1,_x select 2] call printError;
		} foreach _errored;
		["---------------------------------------------------------"] call printError;
		["FINDED %1 ERRORED PATHES",count _errored] call printError;
	} else {
		["Operation done - all pathes is ok!"] call printLog;
	};
}


init_function(systools_internal_clientLibInfo_init)
{
	systools_internal_libs = [
		"debug_console",
		"DiscordRichPresence",
		"task_force_radio_pipe",
		//currently not used but signed also
		"url_fetch",
		"real_date",
		"revoicer"
	];
}

function(systools_generateLibInfo)
{
	private _required = systools_internal_libs;
	private _exList = allextensions;
	["Required: %1",count _required] call printlog;
	["Current loaded: %1",count _exList] call printlog;

	{
		_x callExtension "";
	} foreach _required;
	private _headerPart = format["// Generated from systools::generateLibInfo (ReEditor %1)",Core_version_name];
	_headerPart = [_headerPart];
	_hashesInfo = [];
	{
		["Check library %1",_x get "name"] call printlog;

		if ((_x get "name") in _required) then {
			_ind = _required find (_x get "name");
			if (_ind == -1) exitWith {
				setLastError("Logic error on finding required extension: " + (_x get "name"));
			};
			_hashesInfo pushBack (format["	[""%1"", ""%2""]",_x get "name",_x get "hash"]);
		} else {
			["Skipped extension %1",_x get "name"] call printlog;
		};
	} foreach _exList;
	["Libs %1",count _hashesInfo] call printlog;
	private _h = _hashesInfo joinString (", \"+endl);
	_headerPart pushBack "#define CLIENTSIDE_LIST_ALLOWED_EXTENSIONS [ \";
	_headerPart pushBack (_h + " \");
	_headerPart pushBack " ]";

	private _out = _headerPart joinString endl;
	["Output: "] call printLog;
	[_out] call printLog;

	copytoclipboard _out;
	["===== Copyied to clipboard ====="] call printLog;
	["Place it in 'src\client\ClientInit\_allowed_extensions.h'"] call printLog;
	["Pasted in clipboard"] call showInfo;
}



function(revoicer_rebuild)
{
	call compile preprocessFileLineNumbers "src\Editor\SystemTools\revoicer_loader.sqf";
	["revoice rebuild done"] call printLog;
}