// ======================================================
// Copyright (c) 2017-2025 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include "..\engine.hpp"
#include "..\oop.hpp"
#include "..\struct.hpp"
#include "..\text.hpp"
#include "..\thread.hpp"
#include "..\..\client\WidgetSystem\widgets.hpp"

#include "singleplayer_camera.sqf"
#include "singleplayer_view.sqf"
#include "singleplayer_ai.sqf"
#include "singleplayer_scenarioFramework.sqf"
#include "singleplayer_gameControl.sqf"

sp_internal_reloadScenario = {
	private _oldscn = sp_loadedScenarios;
	
	{
		if not_equals(_x,threadNull) then {
			threadStop(_x);
		}
	} foreach sp_internal_threads;

	sp_map_scenario = createHashMap;
	sp_loadedScenarios = [];

	{
		[_x] call sp_loadScenario;
	} foreach _oldscn;

	[sp_lastStartedScene] call sp_startScene;
};

//список триггеров
if (!isNull(sp_gc_map_triggers)) then {
	sp_gc_map_triggersExport = sp_gc_map_triggers;
};
sp_gc_map_triggers = createHashMap;

sp_initMainModule = {
	call sp_initGUI;
	if (isNull(gm_currentMode) || isNullReference(gm_currentMode)) then {
		call sp_preloadScenarioEnvironment;
	};
	sp_gc_map_triggers merge sp_gc_map_triggersExport;
};

//get actor
sp_getActor = { player getvariable "link" };

/*
	create conditional trigger with cancellation token:

	[{
		getposatl player distance (_this select 0) > 10
	},{
		["called on player move"] call chatprint
	},[getposatl player]] call sp_createTrigger
*/
sp_createTrigger = {
	params ["_cond",["_succ",{}],["_params",[]]];
	private _ctok = refcreate(false);
	startAsyncInvoke
	{
		params ["_trgpar","_ctok"];
		if refget(_ctok) exitWith {true};
		(_trgpar select 2) call (_trgpar select 0)
	},
	{
		params ["_trgpar","_ctok"];
		if refget(_ctok) exitWith {};
		(_trgpar select 2) call (_trgpar select 1)
	},
	[_params,_ctok]
	endAsyncInvoke

	_ctok
};

if !isNull(sp_internal_threads) then {
	{
		if not_equals(_x,threadNull) then {
			threadStop(_x);
		}
	} foreach sp_internal_threads;
};
sp_internal_threads = [];

sp_threadStart = {
	params ["_thdCode"];
	
	sp_internal_threads = sp_internal_threads - [threadNull];

	private _handl = threadStart(threadNew(_thdCode));
	sp_internal_threads pushback _handl;
	_handl
};

sp_threadPause = {
	params ["_time"];
	threadSleep(_time);
};

sp_threadWait = {
	waitUntil _this;
};

call sp_initMainModule;

