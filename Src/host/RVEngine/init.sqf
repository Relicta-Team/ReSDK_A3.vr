// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================
/*
	This is intercept extensionbase initializator

	based on https://github.com/intercept/intercept
*/

#if __has_include("..\engine.hpp")
	#include "..\engine.hpp"
#endif

rve_const_libs = [
	"rv_client"
];

#include "libmanager.sqf"
#include "native_func.sqf"

rve_loaded = false;

rve_log = {
	params ["_message"];
	#ifdef log
	log(_message);
	#endif
	diag_log text format["RVEngine: %1", _message];
};

rve_getVersion = {
	"intercept" callExtension "version";
};

rve_hasHostDll = {
	private _version = call rve_getVersion;
	_version != ""
};

/*
	This is the event handler for the intercept extension.
	params:
	0: event name
	1: event parameters
*/
rve_event = {};

/*
	This is the signal handler for the intercept extension.
	params:
	0: extension name
	1: signal name
	2: signal parameters
	output: bool
*/
rve_signal = {};

rve_signalRet = {
	rve_sigret = nil;
	_this call rve_signal;
	rve_sigret
};

rve_invoker_ok = false;

rve_exportOpList = {
    private _version = format["%1 %2.%3 - %4", (productVersion select 0), (productVersion select 2), (productVersion select 3), (productVersion select 4)];
    "intercept" callExtension ("export_ptr_list:" + _version);
};

rve_callWrapper = {
    scopeName "main";
    params ["_args", "_code"];
    private _res = [_x] apply {_args call _code} select 0;
    missionNamespace setVariable ["INTERCEPT_CALL_RETURN", _res];
};

rve_isNilWrapper = {
    (missionNamespace getVariable "INTERCEPT_CALL_ARGS") params ["_args", "_code"];
    missionNamespace setVariable ["INTERCEPT_CALL_RETURN", if (isNil "_args") then {call _code} else {_args call _code}];
};

if (!call (uiNamespace getVariable ["INTERCEPT_BOOT_DONE",{false}])) then {
	if (!call rve_hasHostDll) exitWith {
		["RVEngine could not be loaded: host dll not found or cannot be loaded"] call rve_log;
	};

	#include "boot.sqf"
	#include "invoker.sqf"

    uiNamespace setVariable ['INTERCEPT_BOOT_DONE', compile 'true'];
};

rve_loaded = (call (uiNamespace getVariable ["INTERCEPT_BOOT_DONE",{false}]));

if (rve_loaded) then {
	
	rve_event = uiNamespace getVariable ["intercept_fnc_event",rve_event];
	rve_signal = uiNamespace getVariable ["intercept_fnc_signal",rve_signal];
	rve_invoker_ok = true;
	["RVEngine READY"] call rve_log;

	{
		if ([_x] call rve_loadlib) then {
			[format["RVEngine: loaded library %1",_x]] call rve_log;
		} else {
			[format["RVEngine: failed to load library %1",_x]] call rve_log;
		};
	} foreach rve_const_libs;
};
