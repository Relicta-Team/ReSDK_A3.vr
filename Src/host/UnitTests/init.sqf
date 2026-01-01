// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include "TestFramework.h"

test_collections = [];
test_loadErrCount = 0;
test_const_pathFormatter = "src\host\UnitTests\TestsCollection\%1.sqf";
test_fixtureStageMap = null;

test_isExcludedName = {
	("_all_" in (tolower _this)) || ("_all" in (tolower _this))
};

if isNull(sys_int_evalassert) exitWith {
	[-410,"sys::int::evalassert is not defined. Required loaded assertion module"] call RBuilder_exit;
};

test_expectMessage = {
	params ["_expr","_f","_l",["_mes",""]];
	["Unexpected value of '%1' in %2(%3):%4; %5",_expr,_f,_l,__RUT_TESTNAME,_mes] call cprintErr;
};

test_assertFail = {
	params ["_expr","_f","_l",["_mes",""]];
	["Assertion failed '%1' in %2(%3):%4; %5",_expr,_f,_l,__RUT_TESTNAME,_mes] call cprintErr;
};

test_getAllTestMacroNames = {
	private _macroList = [];

	{
		private _t = tolower _x;
		if (count _t > 5 && {_t select [0,5] == "test_"}) then {
			_testName = _t select [5,count _t];
			if !(_t call test_isExcludedName) then {
				_macroList pushBack _testName;
			};
		};
	} foreach RBuilder_map_defines;
	_macroList;
};

test_loadModule = {
	params ["_name",["_showError",true]];
	traceformat("check module %1",_name)
	private _fullpath = format[test_const_pathFormatter,_name];
	traceformat("fullpath %1 -> %2",_fullpath arg FileExists(_fullpath))
	if (!FileExists(_fullpath)) then {
		if (_showError) then {
			["Test module ""%1"" not found",_name] call cprintErr;
		};
		false
	} else {
		test_collections pushBack [_name,(compile preprocessFileLineNumbers _fullpath)];
		true
	};
};

test_internal_buildCurrentModuleTests = {
	params ["_module"];
	/*
		_fixtureStates - hashmap of hashmap -> state of fixtures (setup/teardown)
		_testList - list of tests functions
		_testFixturesList - list of fixtures functions
	*/
	//initialize standard tests
	{
		private _f = [__RUT_FUNCTION_PREFIX,format["scriptName ""%1"";",_module],toString (_x select __RUT_DATACASE_INDEX_CODE),toString{;__RUT_STOPTEST(0)}] joinString endl;
		_testList select _forEachIndex set [__RUT_DATACASE_INDEX_CODE,compile _f];
	} foreach _testList;
	private _fixtStatgeMap = createHashMap;

	//initialize fixtures
	{
		_x params ["_listRef","_idxSet"];
		
		{
			private _curFixtName = _x select __RUT_DATACASE_INDEX_NAME;
			if !(_curFixtName in _fixtStatgeMap) then {
				_fixtStatgeMap set [_curFixtName,__RUT_FIXT_NEW_STAGE()];
			};
			private _f = [__RUT_FUNCTION_PREFIX,format["scriptName ""%1"";",_module],toString (_x select __RUT_DATACASE_INDEX_CODE),toString{;__RUT_STOPTEST(0)}] joinString endl;
			
			_fixtStatgeMap get _curFixtName set [_idxSet,compile _f];
		} foreach _listRef;

	} foreach [
		[_fixtureStatesBegin,__RUT_FIXT_INDEX_STAGE_SETUP],
		[_fixtureStatesEnd,__RUT_FIXT_INDEX_STAGE_TEARDOWN]
	];
	
	{
		private _f = [__RUT_FUNCTION_PREFIX,format["scriptName ""%1"";",_module],toString (_x select __RUT_DATACASE_INDEX_CODE),toString{;__RUT_STOPTEST(0)}] joinString endl;
		_testFixturesList select _forEachIndex set [__RUT_DATACASE_INDEX_CODE,compile _f];
	} foreach _testFixturesList;

	test_fixtureStageMap = _fixtStatgeMap;
};

test_internal_runAllTestCases = {
	{
		_x params ['__RUT_TESTNAME',"_testCode"];
		logformat("Start test %1",__RUT_TESTNAME);
		private _localErrorCount = 0;
		private _t = tickTime;
		private _r = 0 call _testCode;
		_t = (tickTime - _t)*1000;
		private _tReal = _t toFixed 8;
		private _isSuccess = isNullVar(_r) || {equals(_r,0)};
		_isSuccess = _isSuccess && (_localErrorCount == 0);
		if (_isSuccess) then {
			logformat("     [OK] %1 (%2 ms)",__RUT_TESTNAME arg _tReal);
		} else {
			logformat("     [ERR] %1 with %3 errors (%2 ms)",__RUT_TESTNAME arg _tReal arg _localErrorCount);
		};
	} foreach _testList;

	{
		_x params ['__RUT_TESTNAME',"_testCode"];
		private _fixtName = (__RUT_TESTNAME splitString ":") select 0;
		private _fixtStageData = test_fixtureStageMap get _fixtName;

		logformat("Start fixture %1",__RUT_TESTNAME);
		
		0 call (_fixtStageData select __RUT_FIXT_INDEX_STAGE_SETUP);
		private _localErrorCount = 0;
		private _t = tickTime;
		private _r = 0 call _testCode;
		_t = (tickTime - _t)*1000;
		private _tReal = _t toFixed 8;
		0 call (_fixtStageData select __RUT_FIXT_INDEX_STAGE_TEARDOWN);

		private _isSuccess = isNullVar(_r) || {equals(_r,0)};
		_isSuccess = _isSuccess && (_localErrorCount == 0);
		if (_isSuccess) then {
			logformat("     [OK] %1 (%2 ms)",__RUT_TESTNAME arg _tReal);
		} else {
			logformat("     [ERR] %1 with %3 errors (%2 ms)",__RUT_TESTNAME arg _tReal arg _localErrorCount);
		};
	} foreach _testFixturesList;
};

test_run = {
	private _macroList = call test_getAllTestMacroNames;
	logformat("Founded %1 test modules",count _macroList);
	{
		logformat("  - Loading module ""%1""",_x);
		private _r = ([_x,true] call test_loadModule);
		logformat("            %1",ifcheck(_r,"Loaded","NOT LOADED"));
	} foreach _macroList;
	
	private _modulesError = 0;

	logformat("Test modules: %1",count test_collections);
	{
		_x params ["_testModule","_testCode"];
		logformat("---- Prep %1 ----",_testModule);
		
		__RUT_ALLOC_MODULE(_testModule);
		call _testCode;
		[_testModule] call test_internal_buildCurrentModuleTests;
		call test_internal_runAllTestCases;
		private _errCntInMdl = _errorCountAll;
		__RUT_FREE_MODULE();

		if (_errCntInMdl == 0) then {
			logformat("[SUCCESS] - %1",_testModule);
		} else {
			errorformat("[FAILED] - %1; Errors: %2",_testModule arg _errCntInMdl);
			INC(_modulesError);
		};

	} foreach test_collections;

	[ifcheck(_modulesError==0,0,-500)] call RBuilder_exit;
};