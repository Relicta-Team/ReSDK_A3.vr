// ======================================================
// Copyright (c) 2017-2025 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include "..\TestFramework.h"

TEST(BaseTest)
{
	log("Base test called")
}

TEST(BaseTest2)
{
	log("Base test 2 called");
	EXPECT(true);
	ASSERT(true);
	private _val = 1;
	ASSERT_EQ(_val,1);
	ASSERT_NE(_val,0);
}

//!check work error
// TEST(BaseTest_FailExpect)
// {
// 	EXPECT(false);
// 	private _v = 100;
// 	EXPECT_EQ(_v,5);
// 	EXPECT_NE(_v,100);
// }

FIXTURE_SETUP(BaseFixture)
{
	if isNull(globalVar) then {globalVar = 0};
	INC(globalVar);
	log("Called fixture setup")
}

FIXTURE_TEARDOWN(BaseFixture)
{
	DEC(globalVar);
	log("Called fixture teardown");
}

TEST_F(BaseFixture,check_variable_exists)
{
	ASSERT(globalVar); //not null and not zero
}

TEST_F(BaseFixture,check_variable_value)
{
	ASSERT_EQ(globalVar,1);
}

//------------------------------------------------------------
// JSRuntime tests
//------------------------------------------------------------

FIXTURE_SETUP(JSRuntimeTests)
{
	test_jsruntime_testvar = 0;
}

FIXTURE_TEARDOWN(JSRuntimeTests)
{
	test_jsruntime_testvar = null;
}

TEST_F(JSRuntimeTests,FullLifecycle)
{
	log("JSRuntimeTests: FullLifecycle started");

	log("JSRuntimeTests: Initializing runtime");
	private _initialized = ["test_runtime"] call jsr_initRuntime;
	ASSERT(_initialized);

	logformat("JSRuntime: displays: %1; runtimes: %2",allDisplays arg jsr_runtimes);

	log("JSRuntimeTests: Registering signal handler");
	private _handle = ["test_runtime",{
		params ["_message"];
		test_jsruntime_testvar = parseNumber _message;
	}] call jsr_registerRuntimeSignal;
	ASSERT_EQ(_handle,0); //first handle is 0

	log("JSRuntimeTests: Adding invalid signal to runtime");
	private _invalid = ["not_test_runtime",{}] call jsr_registerRuntimeSignal;
	ASSERT(!_invalid);

	log("JSRuntimeTests: Sending signal to runtime");
	["test_runtime","JSRuntimeCallback(321123);"] call jsr_sendToRuntime;
	
	//wait 5 seconds for signal
	for "_i" from 1 to 5 do {
		["RBuilder","wait",[1000]] call rescript_callCommandVoid;
	};

	log("JSRuntimeTests: Checking value from signal");
	ASSERT_EQ(test_jsruntime_testvar,321123);

	log("JSRuntimeTests: Delete invalid handle");
	private _deleted = ["test_runtime",1] call jsr_unregisterRuntimeSignal;
	ASSERT(!_deleted);

	log("JSRuntimeTests: Unregistering signal handler");
	private _unregistered = ["test_runtime",_handle] call jsr_unregisterRuntimeSignal;
	ASSERT(_unregistered);

	log("JSRuntimeTests: Delete invalid runtime");
	private _deleted = ["not_test_runtime"] call jsr_deleteRuntime;
	ASSERT(!_deleted);

	log("JSRuntimeTests: Shutting down runtime");
	private _shutdown = ["test_runtime"] call jsr_deleteRuntime;
	ASSERT(_shutdown);

	
	log("JSRuntimeTests: FullLifecycle finished");
}

