# init.sqf

## test_collections

Type: Variable

Description: 


Initial value:
```sqf
[]
```
File: [host\UnitTests\init.sqf at line 8](../../../Src/host/UnitTests/init.sqf#L8)
## test_loadErrCount

Type: Variable

Description: 


Initial value:
```sqf
0
```
File: [host\UnitTests\init.sqf at line 9](../../../Src/host/UnitTests/init.sqf#L9)
## test_const_pathFormatter

Type: Variable

Description: 


Initial value:
```sqf
"src\host\UnitTests\TestsCollection\%1.sqf"
```
File: [host\UnitTests\init.sqf at line 10](../../../Src/host/UnitTests/init.sqf#L10)
## test_fixtureStageMap

Type: Variable

Description: 


Initial value:
```sqf
null
```
File: [host\UnitTests\init.sqf at line 11](../../../Src/host/UnitTests/init.sqf#L11)
## test_isExcludedName

Type: function

Description: 


File: [host\UnitTests\init.sqf at line 13](../../../Src/host/UnitTests/init.sqf#L13)
## test_expectMessage

Type: function

Description: 
- Param: _expr
- Param: _f
- Param: _l
- Param: _mes (optional, default "")

File: [host\UnitTests\init.sqf at line 21](../../../Src/host/UnitTests/init.sqf#L21)
## test_assertFail

Type: function

Description: 
- Param: _expr
- Param: _f
- Param: _l
- Param: _mes (optional, default "")

File: [host\UnitTests\init.sqf at line 26](../../../Src/host/UnitTests/init.sqf#L26)
## test_getAllTestMacroNames

Type: function

Description: 


File: [host\UnitTests\init.sqf at line 31](../../../Src/host/UnitTests/init.sqf#L31)
## test_loadModule

Type: function

Description: 
- Param: _name
- Param: _showError (optional, default true)

File: [host\UnitTests\init.sqf at line 46](../../../Src/host/UnitTests/init.sqf#L46)
## test_internal_buildCurrentModuleTests

Type: function

Description: 
- Param: _module

File: [host\UnitTests\init.sqf at line 62](../../../Src/host/UnitTests/init.sqf#L62)
## test_internal_runAllTestCases

Type: function

Description: 
- Param: __RUT_TESTNAME
- Param: _testCode

File: [host\UnitTests\init.sqf at line 103](../../../Src/host/UnitTests/init.sqf#L103)
## test_run

Type: function

Description: 


File: [host\UnitTests\init.sqf at line 146](../../../Src/host/UnitTests/init.sqf#L146)
# loader.sqf

## test_collections

Type: Variable

Description: 


Initial value:
```sqf
[]
```
File: [host\UnitTests\loader.sqf at line 8](../../../Src/host/UnitTests/loader.sqf#L8)
## testLoadingErrors

Type: Variable

Description: 


Initial value:
```sqf
0
```
File: [host\UnitTests\loader.sqf at line 9](../../../Src/host/UnitTests/loader.sqf#L9)
## testFormatterPath

Type: Variable

Description: 


Initial value:
```sqf
"src\host\UnitTests\TestsCollection\%1.sqf"
```
File: [host\UnitTests\loader.sqf at line 10](../../../Src/host/UnitTests/loader.sqf#L10)
## test_errors

Type: Variable

Description: 


Initial value:
```sqf
[]
```
File: [host\UnitTests\loader.sqf at line 12](../../../Src/host/UnitTests/loader.sqf#L12)
## test_hasAnyErrors

Type: Variable

Description: 


Initial value:
```sqf
false
```
File: [host\UnitTests\loader.sqf at line 13](../../../Src/host/UnitTests/loader.sqf#L13)
## test_map_config

Type: Variable

Description: 


Initial value:
```sqf
createHashMapFromArray [...
```
File: [host\UnitTests\loader.sqf at line 16](../../../Src/host/UnitTests/loader.sqf#L16)
## test_hasErrors

Type: function

Description: 


File: [host\UnitTests\loader.sqf at line 14](../../../Src/host/UnitTests/loader.sqf#L14)
## test_onfail

Type: function

Description: TEST_ASSERT
- Param: _eval
- Param: _file
- Param: _line
- Param: _mes (optional, default "")

File: [host\UnitTests\loader.sqf at line 26](../../../Src/host/UnitTests/loader.sqf#L26)
## test_warnUnexpected

Type: function

Description: TEST_EXPECT() - nothrow error
- Param: _eval
- Param: _file
- Param: _line
- Param: _mes (optional, default "")

File: [host\UnitTests\loader.sqf at line 37](../../../Src/host/UnitTests/loader.sqf#L37)
## loadTest

Type: function

Description: 
- Param: _testname

File: [host\UnitTests\loader.sqf at line 41](../../../Src/host/UnitTests/loader.sqf#L41)
## runTest

Type: function

Description: 
- Param: _module

File: [host\UnitTests\loader.sqf at line 54](../../../Src/host/UnitTests/loader.sqf#L54)
# TestFramework.h

## __RUT_FUNCTION_PREFIX

Type: constant

Description: get function prefix for working __RUT_STOPTEST


Replaced value:
```sqf
(tostring{FHEADER;})
```
File: [host\UnitTests\TestFramework.h at line 33](../../../Src/host/UnitTests/TestFramework.h#L33)
## __RUT_STOPTEST(val)

Type: constant

Description: immediately stop test case
- Param: val

Replaced value:
```sqf
RETURN(val)
```
File: [host\UnitTests\TestFramework.h at line 35](../../../Src/host/UnitTests/TestFramework.h#L35)
## __RUT_ASSERTVAL(expr)

Type: constant

Description: validate expression. checking provided by assertion checker - sys::int::evalassert
- Param: expr

Replaced value:
```sqf
([expr] call sys_int_evalassert)
```
File: [host\UnitTests\TestFramework.h at line 37](../../../Src/host/UnitTests/TestFramework.h#L37)
## __RUT_EXPR_MESSAGE(expr,f,l,msg)

Type: constant

Description: generate params for message (assertion, equals, message, etc...)
- Param: expr
- Param: f
- Param: l
- Param: msg

Replaced value:
```sqf
[toString {expr},f,l,msg]
```
File: [host\UnitTests\TestFramework.h at line 39](../../../Src/host/UnitTests/TestFramework.h#L39)
## __RUT_ALLOC_MODULE(module)

Type: constant

Description: 
- Param: module

Replaced value:
```sqf
\
	private _fixtureStatesBegin = []; \
	private _fixtureStatesEnd = []; \
	private _testList = []; \
	private _testFixturesList = []; \
	private _errorCountAll = 0;
```
File: [host\UnitTests\TestFramework.h at line 47](../../../Src/host/UnitTests/TestFramework.h#L47)
## __RUT_FREE_MODULE()

Type: constant

Description: dispose all module data and
- Param: 

Replaced value:
```sqf
test_fixtureStageMap = null; _fixtureStatesBegin = null; _fixtureStatesEnd = null; _testList = null; _testFixturesList = null;
```
File: [host\UnitTests\TestFramework.h at line 55](../../../Src/host/UnitTests/TestFramework.h#L55)
## __RUT_DATACASE_INDEX_NAME

Type: constant

Description: 


Replaced value:
```sqf
0
```
File: [host\UnitTests\TestFramework.h at line 57](../../../Src/host/UnitTests/TestFramework.h#L57)
## __RUT_DATACASE_INDEX_CODE

Type: constant

Description: 


Replaced value:
```sqf
1
```
File: [host\UnitTests\TestFramework.h at line 58](../../../Src/host/UnitTests/TestFramework.h#L58)
## __RUT_FIXT_INDEX_STAGE_SETUP

Type: constant

Description: 


Replaced value:
```sqf
0
```
File: [host\UnitTests\TestFramework.h at line 60](../../../Src/host/UnitTests/TestFramework.h#L60)
## __RUT_FIXT_INDEX_STAGE_TEARDOWN

Type: constant

Description: 


Replaced value:
```sqf
1
```
File: [host\UnitTests\TestFramework.h at line 61](../../../Src/host/UnitTests/TestFramework.h#L61)
## __RUT_FIXT_NEW_STAGE()

Type: constant

Description: 
- Param: 

Replaced value:
```sqf
[{0},{0}]
```
File: [host\UnitTests\TestFramework.h at line 63](../../../Src/host/UnitTests/TestFramework.h#L63)
## __RUT_TESTNAME

Type: constant

Description: 


Replaced value:
```sqf
_testName
```
File: [host\UnitTests\TestFramework.h at line 65](../../../Src/host/UnitTests/TestFramework.h#L65)
## __RUT_ONERROR

Type: constant

Description: 


Replaced value:
```sqf
INC(_errorCountAll); INC(_localErrorCount);
```
File: [host\UnitTests\TestFramework.h at line 67](../../../Src/host/UnitTests/TestFramework.h#L67)
## FIXTURE_SETUP(fixtname)

Type: constant

Description: declaration for fixture - called before test fixture started
- Param: fixtname

Replaced value:
```sqf
;_fRef = [ #fixtname ]; _fixtureStatesBegin pushback _fRef; _fRef pushback 
```
File: [host\UnitTests\TestFramework.h at line 72](../../../Src/host/UnitTests/TestFramework.h#L72)
## FIXTURE_TEARDOWN(fixtname)

Type: constant

Description: declaration for fixture - called after test fixture finished (successed or not)
- Param: fixtname

Replaced value:
```sqf
;_fRef = [ #fixtname ]; _fixtureStatesEnd pushback _fRef; _fRef pushback 
```
File: [host\UnitTests\TestFramework.h at line 74](../../../Src/host/UnitTests/TestFramework.h#L74)
## TEST_F(fixtname,testname)

Type: constant

Description: declaration for test case
- Param: fixtname
- Param: testname

Replaced value:
```sqf
;_fRef = [format["%1::%2", #fixtname , #testname ]]; _testFixturesList pushback _fRef; _fRef pushback 
```
File: [host\UnitTests\TestFramework.h at line 76](../../../Src/host/UnitTests/TestFramework.h#L76)
## TEST(testname)

Type: constant

Description: declaration for test case
- Param: testname

Replaced value:
```sqf
;_fRef = [ #testname ]; _testList pushback _fRef; _fRef pushback 
```
File: [host\UnitTests\TestFramework.h at line 76](../../../Src/host/UnitTests/TestFramework.h#L76)
## EXPECT_EQ(expr,expect)

Type: constant

Description: 
- Param: expr
- Param: expect

Replaced value:
```sqf
if !(equals(expr,expect)) then {__RUT_ONERROR; __RUT_EXPR_MESSAGE(expr,__FILE__,__LINE__,format vec3("Expected '%2'; got '%1'",expr,expect)) call test_expectMessage;};
```
File: [host\UnitTests\TestFramework.h at line 79](../../../Src/host/UnitTests/TestFramework.h#L79)
## EXPECT_NE(expr,expect)

Type: constant

Description: 
- Param: expr
- Param: expect

Replaced value:
```sqf
if !(not_equals(expr,expect)) then {__RUT_ONERROR; __RUT_EXPR_MESSAGE(expr,__FILE__,__LINE__,format vec3("Not expected '%1'",expr,expect)) call test_expectMessage;}
```
File: [host\UnitTests\TestFramework.h at line 80](../../../Src/host/UnitTests/TestFramework.h#L80)
## ASSERT_EQ(expr,expect)

Type: constant

Description: 
- Param: expr
- Param: expect

Replaced value:
```sqf
if !(equals(expr,expect)) then {__RUT_ONERROR; __RUT_EXPR_MESSAGE(expr,__FILE__,__LINE__,format vec3("Expected '%2'; got '%1'",expr,expect)) call test_assertFail; __RUT_STOPTEST(-1)};
```
File: [host\UnitTests\TestFramework.h at line 82](../../../Src/host/UnitTests/TestFramework.h#L82)
## ASSERT_NE(expr,expect)

Type: constant

Description: 
- Param: expr
- Param: expect

Replaced value:
```sqf
if !(not_equals(expr,expect)) then {__RUT_ONERROR; __RUT_EXPR_MESSAGE(expr,__FILE__,__LINE__,format vec3("Not expected '%1'",expr,expect)) call test_assertFail; __RUT_STOPTEST(-1)};
```
File: [host\UnitTests\TestFramework.h at line 83](../../../Src/host/UnitTests/TestFramework.h#L83)
## ASSERT(expr)

Type: constant

Description: 
- Param: expr

Replaced value:
```sqf
if !(__RUT_ASSERTVAL(expr)) then {__RUT_ONERROR; __RUT_EXPR_MESSAGE(expr,__FILE__,__LINE__,"") call test_assertFail; __RUT_STOPTEST(-1)}
```
File: [host\UnitTests\TestFramework.h at line 82](../../../Src/host/UnitTests/TestFramework.h#L82)
## ASSERT_STR(expr,message)

Type: constant

Description: 
- Param: expr
- Param: message

Replaced value:
```sqf
if !(__RUT_ASSERTVAL(expr)) then {__RUT_ONERROR; __RUT_EXPR_MESSAGE(expr,__FILE__,__LINE__,message) call test_assertFail; __RUT_STOPTEST(-1)}
```
File: [host\UnitTests\TestFramework.h at line 86](../../../Src/host/UnitTests/TestFramework.h#L86)
## EXPECT(expr)

Type: constant

Description: 
- Param: expr

Replaced value:
```sqf
if !(__RUT_ASSERTVAL(expr)) then {__RUT_ONERROR; __RUT_EXPR_MESSAGE(expr,__FILE__,__LINE__,"") call test_expectMessage;}
```
File: [host\UnitTests\TestFramework.h at line 79](../../../Src/host/UnitTests/TestFramework.h#L79)
## EXPECT_STR(expr,message)

Type: constant

Description: 
- Param: expr
- Param: message

Replaced value:
```sqf
if !(__RUT_ASSERTVAL(expr)) then {__RUT_ONERROR; __RUT_EXPR_MESSAGE(expr,__FILE__,__LINE__,message) call test_expectMessage;}
```
File: [host\UnitTests\TestFramework.h at line 88](../../../Src/host/UnitTests/TestFramework.h#L88)
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
# io.sqf

## PREPROCESS_DATA

Type: constant

Description: 


Replaced value:
```sqf
" in _content);
```
File: [host\UnitTests\TestsCollection\io.sqf at line 209](../../../Src/host/UnitTests/TestsCollection/io.sqf#L209)
## oop_getFieldBaseValue

Type: function

Description: 


File: [host\UnitTests\TestsCollection\io.sqf at line 135](../../../Src/host/UnitTests/TestsCollection/io.sqf#L135)
# math.sqf

## pow(x,y)

Type: constant

> Exists if **CMD__ENABLE_CONVERSION_GAUSS_TO_LINEAR** defined

Description: 
- Param: x
- Param: y

Replaced value:
```sqf
(x^y)
```
File: [host\UnitTests\TestsCollection\math.sqf at line 235](../../../Src/host/UnitTests/TestsCollection/math.sqf#L235)
## prob_old_to_new(val)

Type: constant

> Exists if **CMD__ENABLE_CONVERSION_GAUSS_TO_LINEAR** defined

Description: 
- Param: val

Replaced value:
```sqf
([val] call convf)
```
File: [host\UnitTests\TestsCollection\math.sqf at line 236](../../../Src/host/UnitTests/TestsCollection/math.sqf#L236)
## convertionTable

Type: Variable

> Exists if **CMD__ENABLE_CONVERSION_GAUSS_TO_LINEAR** defined

Description: 


Initial value:
```sqf
null
```
File: [host\UnitTests\TestsCollection\math.sqf at line 250](../../../Src/host/UnitTests/TestsCollection/math.sqf#L250)
## convf

Type: function

> Exists if **CMD__ENABLE_CONVERSION_GAUSS_TO_LINEAR** defined

Description: 
- Param: _val

File: [host\UnitTests\TestsCollection\math.sqf at line 238](../../../Src/host/UnitTests/TestsCollection/math.sqf#L238)
## createConvTable

Type: function

> Exists if **CMD__ENABLE_CONVERSION_GAUSS_TO_LINEAR** defined

Description: 


File: [host\UnitTests\TestsCollection\math.sqf at line 251](../../../Src/host/UnitTests/TestsCollection/math.sqf#L251)
# structs.sqf

## scripted_profile_test_function_example

Type: function

> Exists if **USE_SCRIPTED_PROFILING** defined

Description: 


File: [host\UnitTests\TestsCollection\structs.sqf at line 515](../../../Src/host/UnitTests/TestsCollection/structs.sqf#L515)
# header_test.h

## MACRO_TEST

Type: constant

Description: 


Replaced value:
```sqf
1
```
File: [host\UnitTests\utility\header_test.h at line 12](../../../Src/host/UnitTests/utility/header_test.h#L12)
## MACRO_TEST_INTERNAL

Type: constant

Description: 


Replaced value:
```sqf
2
```
File: [host\UnitTests\utility\header_test.h at line 13](../../../Src/host/UnitTests/utility/header_test.h#L13)
## MACRO_TEST_INTERNAL2

Type: constant

Description: 


Replaced value:
```sqf
3
```
File: [host\UnitTests\utility\header_test.h at line 14](../../../Src/host/UnitTests/utility/header_test.h#L14)
## output(_varname,_val)

Type: constant

Description: 
- Param: _varname
- Param: _val

Replaced value:
```sqf
_varname = _val;
```
File: [host\UnitTests\utility\header_test.h at line 15](../../../Src/host/UnitTests/utility/header_test.h#L15)
## comment(text)

Type: constant

Description: 
- Param: text

Replaced value:
```sqf
; text ;
```
File: [host\UnitTests\utility\header_test.h at line 16](../../../Src/host/UnitTests/utility/header_test.h#L16)
## version

Type: constant

Description: 


Replaced value:
```sqf
1
```
File: [host\UnitTests\utility\header_test.h at line 39](../../../Src/host/UnitTests/utility/header_test.h#L39)
## _ONE

Type: constant

Description: 


Replaced value:
```sqf
1
```
File: [host\UnitTests\utility\header_test.h at line 40](../../../Src/host/UnitTests/utility/header_test.h#L40)
## included_macro

Type: constant

Description: 


Replaced value:
```sqf
"not_connected"
```
File: [host\UnitTests\utility\header_test.h at line 51](../../../Src/host/UnitTests/utility/header_test.h#L51)
## REDEFINE_TEST_HEADER

Type: constant

Description: 


Replaced value:
```sqf

```
File: [host\UnitTests\utility\header_test.h at line 59](../../../Src/host/UnitTests/utility/header_test.h#L59)
## min_

Type: constant

Description: second checks multilevel


Replaced value:
```sqf
1
```
File: [host\UnitTests\utility\header_test.h at line 70](../../../Src/host/UnitTests/utility/header_test.h#L70)
## maj_

Type: constant

Description: 


Replaced value:
```sqf
2
```
File: [host\UnitTests\utility\header_test.h at line 71](../../../Src/host/UnitTests/utility/header_test.h#L71)
## bld_

Type: constant

Description: 


Replaced value:
```sqf
3
```
File: [host\UnitTests\utility\header_test.h at line 72](../../../Src/host/UnitTests/utility/header_test.h#L72)
## _simpleOne

Type: constant

Description: 


Replaced value:
```sqf
234
```
File: [host\UnitTests\utility\header_test.h at line 207](../../../Src/host/UnitTests/utility/header_test.h#L207)
## __endmacro

Type: constant

> Exists if **MACRO_TEST_INTERNAL** defined

Description: post including define and set


Replaced value:
```sqf

```
File: [host\UnitTests\utility\header_test.h at line 214](../../../Src/host/UnitTests/utility/header_test.h#L214)
# included_header_test.h

## included_macro

Type: constant

> Exists if **REDEFINE_TEST_HEADER** defined

Description: 


Replaced value:
```sqf
"connected"
```
File: [host\UnitTests\utility\included_header_test.h at line 7](../../../Src/host/UnitTests/utility/included_header_test.h#L7)
