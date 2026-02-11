// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
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