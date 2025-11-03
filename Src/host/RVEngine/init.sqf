// ======================================================
// Copyright (c) 2017-2025 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include "..\engine.hpp"

/*
	This is intercept extensionbase initializator

	based on https://github.com/intercept/intercept
*/

#include "libmanager.sqf"

rve_loaded = false; 

rve_log = {
	params ["_message"];
	log(_message);
	diag_log text format["RVEngine: %1", _message];
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
	
	#include "boot.sqf"
	#include "invoker.sqf"

    uiNamespace setVariable ['INTERCEPT_BOOT_DONE', compile 'true'];
};

rve_loaded = (call (uiNamespace getVariable ["INTERCEPT_BOOT_DONE",{false}]));

if (rve_loaded) then {
	rve_event = uiNamespace getVariable ["intercept_fnc_event",rve_event];
	rve_signal = uiNamespace getVariable ["intercept_fnc_signal",rve_signal];
	["RVEngine READY"] call rve_log;
};
