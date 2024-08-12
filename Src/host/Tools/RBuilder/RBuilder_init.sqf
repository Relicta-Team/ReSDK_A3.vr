// ======================================================
// Copyright (c) 2017-2024 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include "..\..\engine.hpp"

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


//noexit on auto-reload
if (RBuilder_autoReload) exitWith {};

log("No RBuilder work found. Exiting...");
["RBuilder","exit",[0]] call rescript_callCommandVoid;