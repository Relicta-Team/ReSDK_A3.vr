// ======================================================
// Copyright (c) 2017-2024 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\engine.hpp>

//#define unit_test_enabled


#define assertion_errors _as_err
#define test_errors _ts_err

#define setTestName(name) private _unitName = name;

#define predefTestName _unitName = if (isNil"_unitName") then {"UNDEFINED"} else {_unitName}

#define __internal_log_red(message,fmt) predefTestName; "debug_console" callExtension (format[message,fmt] + "#1001")
#define __internal_log_green(message,fmt) predefTestName; "debug_console" callExtension (format[message,fmt] + "#0101")
#define __internal_log_common(message,fmt) predefTestName; "debug_console" callExtension (format[message,fmt] + "#1101")

#define assert_error(mes) __internal_log_red("<Assert>	["+_unitName+"]: - %1",mes); INC(assertion_errors)

#define test_ok(mes) __internal_log_green("<Test>	["+_unitName+"]: - Test OK. %1",mes)
#define test_fail(mes) __internal_log_red("<Test>	["+_unitName+"]: - Test Fail! %1",mes); INC(test_errors)

#define test_flags(flags) flags
#define onlyMultiplayer if (!isMultiplayer) exitWith {};

#ifdef unit_test_enabled
	#define newTest(name) call { \
		setTestName('name') \
		private assertion_errors = 0;  private test_errors = 0;
#else
	#define newTest(name) {
#endif


#define endTest __hasFail = false; \
if (assertion_errors > 0) then { \
	__internal_log_red("		ASSERTION FAILED %1 TIMES",assertion_errors); \
	__hasFail = true; \
}; \
if (test_errors > 0) then { \
	__internal_log_red("		TESTS FAILED %1 TIMES",test_errors); \
	__hasFail = true; \
}; \
if (__hasFail) then { \
	__internal_log_red("====== Tests <%1> FAILED ======",_unitName) \
} else { \
	__internal_log_green("====== Tests <%1> SUCCESS ======",_unitName) \
}; \
};

#define assert_true(cond,mes) if (!(cond)) then { \
	assert_error('Assertion (cond) failed! ' + mes) \
}

#define assert_false(cond,mes) if (cond) then { \
	assert_error('Assertion (NOT cond) failed! ' + mes) \
}

#define assert_op(a,op,b,mes) if (!(a op b)) then { \
	assert_error('Assertion (a op b) failed!' + mes) \
}

#define assert_def(var,mes) if (isNil {var}) then { \
	assert_error('Assertion (var is defined) failed!' + mes) \
}

#define test_true(CONDITION, MESSAGE) \
    if (CONDITION) then \
    { \
        test_ok('(CONDITION)'); \
    } \
    else \
    { \
        test_fail('(CONDITION) ' + (MESSAGE)); \
    }

#define test_false(CONDITION, MESSAGE) \
    if (not (CONDITION)) then \
    { \
        test_ok('(not (CONDITION))'); \
    } \
    else \
    { \
        test_fail('(not (CONDITION)) ' + (MESSAGE)); \
    }

#define test_op(A,OPERATOR,B,MESSAGE) \
    if ((A) OPERATOR (B)) then \
    { \
        test_ok('(A OPERATOR B)') \
    } \
    else \
    { \
        test_fail('(A OPERATOR B)') \
    }

#define TEST_DEFINED(VARIABLE,MESSAGE) \
    if (not isNil {VARIABLE}) then \
    { \
        test_ok('(' + VARIABLE + ' is defined)'); \
    } \
    else \
    { \
        test_fail('(' + VARIABLE + ' is not defined)' + (MESSAGE)); \
    }
