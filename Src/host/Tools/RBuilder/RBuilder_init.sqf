// ======================================================
// Copyright (c) 2017-2024 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include "..\..\engine.hpp"

#include "..\EditorDebug\EditorDebug_io.sqf"
#include "..\..\Tools\EditorWorkspaceDebug\InternalImpl.sqf"

private _hasTests = false;
{
	private _t = tolower _x;
	if (count _t > 5 && {_t select [0,5] == "test_"}) exitWith {
		_hasTests = true;
	};
} foreach RBuilder_map_defines;

if (_hasTests) then {
	["Starting tests..."] call cprint;
	loadFile("src\host\UnitTests\init.sqf");
	if isNull(test_run) exitWith {
		[-470,"Test runner function not found"] call RBuilder_exit;
	};
	call test_run;
};

if ("GENERATE_RENODE_BINDINGS" in RBuilder_map_defines) then {
	private _r = [null] call nodegen_generateLib;
	["ReNode binding generation result - %1",_r] call cprint;
	if (!_r) then {
		[-600,"ReNode binding generation failed"] call RBuilder_exit;
	};
};

//noexit on auto-reload
if (RBuilder_autoReload) exitWith {};

log("No RBuilder work found. Exiting...");
["RBuilder","exit",[0]] call rescript_callCommandVoid;