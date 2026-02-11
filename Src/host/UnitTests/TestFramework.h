// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\engine.hpp>
#include <..\oop.hpp>
#include <..\text.hpp>
#include <..\struct.hpp>
#include <..\profiling.hpp>

/*
	
	Unit Test Framework

	Ключевые определения:
		- module - модуль теста. Называется именем файла и содержит группу тестов
		- testCase - тест.
		- fixture - фикстура теста. Фикстура позволяет настраивать общие свойства для нескольких тестов

	Основные макросы

	FIXTURE_SETUP(fixtname) {}
	FIXTURE_TEARDOWN(fixtname) {}
	TEST_F(fixtname, testname) {}

	TEST_SUITE(test_suite_name)
	TEST(testname) {}
*/

// **** internal ****
// get function prefix for working __RUT_STOPTEST
#define __RUT_FUNCTION_PREFIX (tostring{FHEADER;})
// immediately stop test case
#define __RUT_STOPTEST(val) RETURN(val)
// validate expression. checking provided by assertion checker - sys::int::evalassert
#define __RUT_ASSERTVAL(expr) ([expr] call sys_int_evalassert)
// generate params for message (assertion, equals, message, etc...)
#define __RUT_EXPR_MESSAGE(expr,f,l,msg) [toString {expr},f,l,msg]

/* 
	definition of module - local variables 
	_fixtureStates - state of fixtures (setup/teardown)
	_testList - list of tests functions
	_testFixturesList - list of fixtures functions
*/
#define __RUT_ALLOC_MODULE(module) \
	private _fixtureStatesBegin = []; \
	private _fixtureStatesEnd = []; \
	private _testList = []; \
	private _testFixturesList = []; \
	private _errorCountAll = 0;

// dispose all module data and 
#define __RUT_FREE_MODULE() test_fixtureStageMap = null; _fixtureStatesBegin = null; _fixtureStatesEnd = null; _testList = null; _testFixturesList = null;

#define __RUT_DATACASE_INDEX_NAME 0
#define __RUT_DATACASE_INDEX_CODE 1

#define __RUT_FIXT_INDEX_STAGE_SETUP 0
#define __RUT_FIXT_INDEX_STAGE_TEARDOWN 1

#define __RUT_FIXT_NEW_STAGE() [{0},{0}]

#define __RUT_TESTNAME _testName

#define __RUT_ONERROR INC(_errorCountAll); INC(_localErrorCount);

// **** public ****

// declaration for fixture - called before test fixture started
#define FIXTURE_SETUP(fixtname) ;_fRef = [ #fixtname ]; _fixtureStatesBegin pushback _fRef; _fRef pushback 
// declaration for fixture - called after test fixture finished (successed or not)
#define FIXTURE_TEARDOWN(fixtname) ;_fRef = [ #fixtname ]; _fixtureStatesEnd pushback _fRef; _fRef pushback 
// declaration for test case
#define TEST_F(fixtname,testname) ;_fRef = [format["%1::%2", #fixtname , #testname ]]; _testFixturesList pushback _fRef; _fRef pushback 
#define TEST(testname) ;_fRef = [ #testname ]; _testList pushback _fRef; _fRef pushback 

#define EXPECT_EQ(expr,expect) if !(equals(expr,expect)) then {__RUT_ONERROR; __RUT_EXPR_MESSAGE(expr,__FILE__,__LINE__,format vec3("Expected '%2'; got '%1'",expr,expect)) call test_expectMessage;};
#define EXPECT_NE(expr,expect) if !(not_equals(expr,expect)) then {__RUT_ONERROR; __RUT_EXPR_MESSAGE(expr,__FILE__,__LINE__,format vec3("Not expected '%1'",expr,expect)) call test_expectMessage;}

#define ASSERT_EQ(expr,expect) if !(equals(expr,expect)) then {__RUT_ONERROR; __RUT_EXPR_MESSAGE(expr,__FILE__,__LINE__,format vec3("Expected '%2'; got '%1'",expr,expect)) call test_assertFail; __RUT_STOPTEST(-1)};
#define ASSERT_NE(expr,expect) if !(not_equals(expr,expect)) then {__RUT_ONERROR; __RUT_EXPR_MESSAGE(expr,__FILE__,__LINE__,format vec3("Not expected '%1'",expr,expect)) call test_assertFail; __RUT_STOPTEST(-1)};

#define ASSERT(expr) if !(__RUT_ASSERTVAL(expr)) then {__RUT_ONERROR; __RUT_EXPR_MESSAGE(expr,__FILE__,__LINE__,"") call test_assertFail; __RUT_STOPTEST(-1)}
#define ASSERT_STR(expr,message) if !(__RUT_ASSERTVAL(expr)) then {__RUT_ONERROR; __RUT_EXPR_MESSAGE(expr,__FILE__,__LINE__,message) call test_assertFail; __RUT_STOPTEST(-1)}
#define EXPECT(expr) if !(__RUT_ASSERTVAL(expr)) then {__RUT_ONERROR; __RUT_EXPR_MESSAGE(expr,__FILE__,__LINE__,"") call test_expectMessage;}
#define EXPECT_STR(expr,message) if !(__RUT_ASSERTVAL(expr)) then {__RUT_ONERROR; __RUT_EXPR_MESSAGE(expr,__FILE__,__LINE__,message) call test_expectMessage;}
