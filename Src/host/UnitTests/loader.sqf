// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include "UTEST.h"

test_collections = [];
testLoadingErrors = 0;
testFormatterPath = "src\host\UnitTests\TestsCollection\%1.sqf";

test_errors = [];
test_hasAnyErrors = false;
test_hasErrors = { count test_errors > 0 };

test_map_config = createHashMapFromArray [
	["duration","UNIT_TEST_OPT_DURATION"],
	["failfast","UNIT_TEST_OPT_FAILFAST"]
];

if isNull(sys_int_evalassert) exitWith {
	[-410,"sys::int::evalassert is not defined. Required loaded assertion module"] call RBuilder_exit;
};

// TEST_ASSERT
test_onfail = {
	params ["_eval","_file","_line",["_mes",""]];

	if (_mes!="") then {

	} else {

	};
};

// TEST_EXPECT() - nothrow error
test_warnUnexpected = {
	params ["_eval","_file","_line",["_mes",""]];
};

loadTest = {
	params ["_testname"];
	["Attempt loading test %1",_testname] call cprint;
	private _testPath = format vec2(testFormatterPath,_testname);
	if !(fileExists(_testPath)) then {
		INC(testLoadingErrors);
		["Test %1 not found",_testPath] call cprintErr;
	} else {
		test_collections pushBack [_testName,(compile preprocessFileLineNumbers _testPath)];
		["Test %1 loaded",_testPath] call cprint;
	};
};

runTest = {
	params ["_module"];
	_module params ["_name","_code"];
	["Running testsuite ""%1""",_name] call cprint;
	private _dur = tickTime;
	
	DEFINE_NEW_TEST;  //predefine vars
	call _code; //prep test code
	CALL_TEST; //run tests

	_dur = (tickTime - _dur)/1000;
	if (call test_hasErrors) then {
		["Testsuite '%1' failed, errors %2 (%3 ms total)",_name,count test_errors,_dur] call cprintErr;
		test_hasAnyErrors = true;
		false
	} else {
		["Testsuite '%1' passed (%3 ms total)",_name,_dur] call cprint;
		true
	};
};

{
	private _t = tolower _x;
	if (count _t > 5 && {_t select [0,5] == "test_"}) then {
		[_t select [5,count _t]] call loadTest;
	};
} foreach RBuilder_map_defines;

if (testLoadingErrors > 0) exitWith {
	[-400,"Some tests are not found; Errors: " + (str (testLoadingErrors))] call RBuilder_exit;
};

["All tests done. Running..."] call cprint;

{
	private _r = [_x] call runTest;
	if (!_r && {test_opt_isFailfast()}) exitWith {};
} foreach test_collections;

if (test_hasAnyErrors) then {
	[-401,"Tests failed"] call RBuilder_exit;
} else {
	[0,"All tests passed"] call RBuilder_exit;
};