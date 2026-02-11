// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

private _res = "intercept" callExtension "init_invoker:";
[format["RVEngine Invoker initialization part 1/3: %1", _res]] call rve_log;

//Check if invoker is working
private _res = "intercept" callExtension "test_invoker:";
if(_res == profileNameSteam) then {
	rve_invoker_ok = true;
};
[format["RVEngine Invoker initialization part 2/3: %1", _res]] call rve_log;


if(rve_invoker_ok) then {
	private _intercept_fnc_signal = compile ("params ['_extensionName', '_signalName', '_parameters']; "
		+"if !(rve_invoker_ok) exitWith {false};"
		+"[_extensionName,_signalName] interceptSignal _parameters;");
	uiNamespace setVariable ["intercept_fnc_signal", _intercept_fnc_signal];

	addMissionEventHandler ["EachFrame", "interceptOnFrame"]; //Register our PFH

	[format["RVEngine Invoker initialization part 3/3"]] call rve_log;
	
	["pre_pre_init",[]] call (uiNamespace getVariable "intercept_fnc_event");
	[format["RVEngine Invoker initialization Completed"]] call rve_log;
} else {
	["RVEngine Invoker initialization failed"] call rve_log;
	private _intercept_fnc_signal =  compile "";
	uiNamespace setVariable ["intercept_fnc_signal", _intercept_fnc_signal];

	if ((uiNamespace getVariable ["intercept_fnc_event", scriptNull]) isEqualType scriptNull) then {
		uiNamespace setVariable ["intercept_fnc_event", compile ""];
	};
};