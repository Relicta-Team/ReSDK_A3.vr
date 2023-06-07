# UnitTest.h

## unit_test_enabled

Type: constant
Description: 


Replaced value:
```sqf

```
File: [host\UnitTests\UnitTest.h at line 8](../../../Src/host/UnitTests/UnitTest.h#L8)
## assertion_errors

Type: constant
Description: #define unit_test_enabled


Replaced value:
```sqf
_as_err
```
File: [host\UnitTests\UnitTest.h at line 11](../../../Src/host/UnitTests/UnitTest.h#L11)
## test_errors

Type: constant
Description: 


Replaced value:
```sqf
_ts_err
```
File: [host\UnitTests\UnitTest.h at line 12](../../../Src/host/UnitTests/UnitTest.h#L12)
## setTestName(name)

Type: constant
Description: 
- Param: name

Replaced value:
```sqf
private _unitName = name;
```
File: [host\UnitTests\UnitTest.h at line 14](../../../Src/host/UnitTests/UnitTest.h#L14)
## predefTestName

Type: constant
Description: 


Replaced value:
```sqf
_unitName = if (isNil"_unitName") then {"UNDEFINED"} else {_unitName}
```
File: [host\UnitTests\UnitTest.h at line 16](../../../Src/host/UnitTests/UnitTest.h#L16)
## __internal_log_red(message,fmt)

Type: constant
Description: 
- Param: message
- Param: fmt

Replaced value:
```sqf
predefTestName; "debug_console" callExtension (format[message,fmt] + "#1001")
```
File: [host\UnitTests\UnitTest.h at line 18](../../../Src/host/UnitTests/UnitTest.h#L18)
## __internal_log_green(message,fmt)

Type: constant
Description: 
- Param: message
- Param: fmt

Replaced value:
```sqf
predefTestName; "debug_console" callExtension (format[message,fmt] + "#0101")
```
File: [host\UnitTests\UnitTest.h at line 19](../../../Src/host/UnitTests/UnitTest.h#L19)
## __internal_log_common(message,fmt)

Type: constant
Description: 
- Param: message
- Param: fmt

Replaced value:
```sqf
predefTestName; "debug_console" callExtension (format[message,fmt] + "#1101")
```
File: [host\UnitTests\UnitTest.h at line 20](../../../Src/host/UnitTests/UnitTest.h#L20)
## assert_error(mes)

Type: constant
Description: 
- Param: mes

Replaced value:
```sqf
__internal_log_red("<Assert>	["+_unitName+"]: - %1",mes); INC(assertion_errors)
```
File: [host\UnitTests\UnitTest.h at line 22](../../../Src/host/UnitTests/UnitTest.h#L22)
## test_ok(mes)

Type: constant
Description: 
- Param: mes

Replaced value:
```sqf
__internal_log_green("<Test>	["+_unitName+"]: - Test OK. %1",mes)
```
File: [host\UnitTests\UnitTest.h at line 24](../../../Src/host/UnitTests/UnitTest.h#L24)
## test_fail(mes)

Type: constant
Description: 
- Param: mes

Replaced value:
```sqf
__internal_log_red("<Test>	["+_unitName+"]: - Test Fail! %1",mes); INC(test_errors)
```
File: [host\UnitTests\UnitTest.h at line 25](../../../Src/host/UnitTests/UnitTest.h#L25)
## test_flags(flags)

Type: constant
Description: 
- Param: flags

Replaced value:
```sqf
flags
```
File: [host\UnitTests\UnitTest.h at line 27](../../../Src/host/UnitTests/UnitTest.h#L27)
## onlyMultiplayer

Type: constant
Description: 


Replaced value:
```sqf
if (!isMultiplayer) exitWith {};
```
File: [host\UnitTests\UnitTest.h at line 28](../../../Src/host/UnitTests/UnitTest.h#L28)
## newTest(name)

Type: constant
> Exists if **unit_test_enabled** defined
Description: 
- Param: name

Replaced value:
```sqf
call { \
		setTestName('name') \
		private assertion_errors = 0;  private test_errors = 0;
```
File: [host\UnitTests\UnitTest.h at line 31](../../../Src/host/UnitTests/UnitTest.h#L31)
## newTest(name)

Type: constant
> Exists if **unit_test_enabled** not defined
Description: 
- Param: name

Replaced value:
```sqf
{
```
File: [host\UnitTests\UnitTest.h at line 35](../../../Src/host/UnitTests/UnitTest.h#L35)
## endTest

Type: constant
Description: 


Replaced value:
```sqf
__hasFail = false; \
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
```
File: [host\UnitTests\UnitTest.h at line 39](../../../Src/host/UnitTests/UnitTest.h#L39)
## assert_true(cond,mes)

Type: constant
Description: 
- Param: cond
- Param: mes

Replaced value:
```sqf
if (!(cond)) then { \
	assert_error('Assertion (cond) failed! ' + mes) \
}
```
File: [host\UnitTests\UnitTest.h at line 55](../../../Src/host/UnitTests/UnitTest.h#L55)
## assert_false(cond,mes)

Type: constant
Description: 
- Param: cond
- Param: mes

Replaced value:
```sqf
if (cond) then { \
	assert_error('Assertion (NOT cond) failed! ' + mes) \
}
```
File: [host\UnitTests\UnitTest.h at line 59](../../../Src/host/UnitTests/UnitTest.h#L59)
## assert_op(a,op,b,mes)

Type: constant
Description: 
- Param: a
- Param: op
- Param: b
- Param: mes

Replaced value:
```sqf
if (!(a op b)) then { \
	assert_error('Assertion (a op b) failed!' + mes) \
}
```
File: [host\UnitTests\UnitTest.h at line 63](../../../Src/host/UnitTests/UnitTest.h#L63)
## assert_def(var,mes)

Type: constant
Description: 
- Param: var
- Param: mes

Replaced value:
```sqf
if (isNil {var}) then { \
	assert_error('Assertion (var is defined) failed!' + mes) \
}
```
File: [host\UnitTests\UnitTest.h at line 67](../../../Src/host/UnitTests/UnitTest.h#L67)
## test_true(CONDITION, MESSAGE)

Type: constant
Description: 
- Param: CONDITION
- Param: MESSAGE

Replaced value:
```sqf
\
    if (CONDITION) then \
    { \
        test_ok('(CONDITION)'); \
    } \
    else \
    { \
        test_fail('(CONDITION) ' + (MESSAGE)); \
    }
```
File: [host\UnitTests\UnitTest.h at line 71](../../../Src/host/UnitTests/UnitTest.h#L71)
## test_false(CONDITION, MESSAGE)

Type: constant
Description: 
- Param: CONDITION
- Param: MESSAGE

Replaced value:
```sqf
\
    if (not (CONDITION)) then \
    { \
        test_ok('(not (CONDITION))'); \
    } \
    else \
    { \
        test_fail('(not (CONDITION)) ' + (MESSAGE)); \
    }
```
File: [host\UnitTests\UnitTest.h at line 81](../../../Src/host/UnitTests/UnitTest.h#L81)
## test_op(A,OPERATOR,B,MESSAGE)

Type: constant
Description: 
- Param: A
- Param: OPERATOR
- Param: B
- Param: MESSAGE

Replaced value:
```sqf
\
    if ((A) OPERATOR (B)) then \
    { \
        test_ok('(A OPERATOR B)') \
    } \
    else \
    { \
        test_fail('(A OPERATOR B)') \
    }
```
File: [host\UnitTests\UnitTest.h at line 91](../../../Src/host/UnitTests/UnitTest.h#L91)
## TEST_DEFINED(VARIABLE,MESSAGE)

Type: constant
Description: 
- Param: VARIABLE
- Param: MESSAGE

Replaced value:
```sqf
\
    if (not isNil {VARIABLE}) then \
    { \
        test_ok('(' + VARIABLE + ' is defined)'); \
    } \
    else \
    { \
        test_fail('(' + VARIABLE + ' is not defined)' + (MESSAGE)); \
    }
```
File: [host\UnitTests\UnitTest.h at line 101](../../../Src/host/UnitTests/UnitTest.h#L101)
# UnitTest.sqf

## wToPrec(val)

Type: constant
Description: 
- Param: val

Replaced value:
```sqf
_w * (val) / 100
```
File: [host\UnitTests\UnitTest.sqf at line 29](../../../Src/host/UnitTests/UnitTest.sqf#L29)
## dllExec(var)

Type: constant
Description: 
- Param: var

Replaced value:
```sqf
(parseSimpleArray ("RelictaNC" callExtension (var)))
```
File: [host\UnitTests\UnitTest.sqf at line 39](../../../Src/host/UnitTests/UnitTest.sqf#L39)
