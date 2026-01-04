// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

["Initializing RVEngine extension..."] call rve_log;
private _r = "intercept" callExtension "init:";
[format["RVEngine initialization part 1/5: %1", _r]] call rve_log;

_res = "intercept" callExtension format["init_patch:%1", (productVersion select 3)]; // find a patch
[format["RVEngine initialization part 2/5: %1", _res]] call rve_log;

_res = "intercept" callExtension "invoker_begin_register:";
[format["RVEngine initialization part 3/5: %1", _res]] call rve_log;

private _registerTypesResult = (call compile "interceptRegisterTypes parsingNamespace") param [0, false];
[format["RVEngine initialization part 4/5: %1", _registerTypesResult]] call rve_log;

if (_registerTypesResult) then {
	uiNamespace setVariable ["intercept_fnc_event", compile "(_this select 0) interceptEvent (_this select 1);nil"];
} else {
	uiNamespace setVariable ["intercept_fnc_event", compile ""];
};

//! здесь должны быть загружены плагины, которые регистрируют новые синтаксические комманды

["pre_start",[]] call (uiNamespace getVariable "intercept_fnc_event");

_res = "intercept" callExtension "invoker_end_register:";
[format["RVEngine initialization part 5/5: %1", _res]] call rve_log;