// ======================================================
// Copyright (c) 2017-2025 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include "..\engine.hpp"
#include "..\oop.hpp"
#include "..\struct.hpp"
#include "..\text.hpp"
#include "..\..\client\WidgetSystem\widgets.hpp"

#include "singleplayer_camera.sqf"
#include "singleplayer_view.sqf"
#include "singleplayer_ai.sqf"
#include "singleplayer_scenarioFramework.sqf"
#include "singleplayer_gameControl.sqf"

sp_initMainModule = {
	call sp_initGUI;
	if (isNull(gm_currentMode) || isNullReference(gm_currentMode)) then {
		call sp_preloadScenarioEnvironment;
	};
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

call sp_initMainModule;

