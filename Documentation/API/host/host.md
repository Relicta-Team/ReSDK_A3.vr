# bitflags.hpp

## b_set(a,b)

Type: constant

Description: установить флаги
- Param: a
- Param: b

Replaced value:
```sqf
([a,b] call bit_set)
```
File: [host\bitflags.hpp at line 8](../../../Src/host/bitflags.hpp#L8)
## b_def(bits)

Type: constant

Description: определить фгали
- Param: bits

Replaced value:
```sqf
[0,bits] call bit_set
```
File: [host\bitflags.hpp at line 11](../../../Src/host/bitflags.hpp#L11)
## b_check(a,b)

Type: constant

Description: проверить есть ли флаг
- Param: a
- Param: b

Replaced value:
```sqf
([a,b] call bit_check)
```
File: [host\bitflags.hpp at line 14](../../../Src/host/bitflags.hpp#L14)
## b_toArray(bits)

Type: constant

Description: все флаги в массив
- Param: bits

Replaced value:
```sqf
((bits) call bit_toArray)
```
File: [host\bitflags.hpp at line 17](../../../Src/host/bitflags.hpp#L17)
## b_not(bin)

Type: constant

Description: 				00110101
- Param: bin

Replaced value:
```sqf
((bin) call bitwise_not)
```
File: [host\bitflags.hpp at line 24](../../../Src/host/bitflags.hpp#L24)
## b_and(a,b)

Type: constant

Description: 
- Param: a
- Param: b

Replaced value:
```sqf
([a,b] call bitwise_and)
```
File: [host\bitflags.hpp at line 35](../../../Src/host/bitflags.hpp#L35)
## b_or(a,b)

Type: constant

Description: 
- Param: a
- Param: b

Replaced value:
```sqf
([a,b] call bitwise_or)
```
File: [host\bitflags.hpp at line 47](../../../Src/host/bitflags.hpp#L47)
## b_xor(a,b)

Type: constant

Description: 
- Param: a
- Param: b

Replaced value:
```sqf
([a,b] call bitwise_xor)
```
File: [host\bitflags.hpp at line 60](../../../Src/host/bitflags.hpp#L60)
## b_0

Type: constant

Description: Макси


Replaced value:
```sqf
1
```
File: [host\bitflags.hpp at line 66](../../../Src/host/bitflags.hpp#L66)
## b_1

Type: constant

Description: 524286 при всех флагах. Дальше значения за 1кк


Replaced value:
```sqf
2
```
File: [host\bitflags.hpp at line 67](../../../Src/host/bitflags.hpp#L67)
## b_2

Type: constant

Description: Точность потеряна


Replaced value:
```sqf
4
```
File: [host\bitflags.hpp at line 68](../../../Src/host/bitflags.hpp#L68)
## b_3

Type: constant

Description: 


Replaced value:
```sqf
8
```
File: [host\bitflags.hpp at line 69](../../../Src/host/bitflags.hpp#L69)
## b_4

Type: constant

Description: 


Replaced value:
```sqf
16
```
File: [host\bitflags.hpp at line 70](../../../Src/host/bitflags.hpp#L70)
## b_5

Type: constant

Description: 


Replaced value:
```sqf
32
```
File: [host\bitflags.hpp at line 71](../../../Src/host/bitflags.hpp#L71)
## b_6

Type: constant

Description: 


Replaced value:
```sqf
64
```
File: [host\bitflags.hpp at line 72](../../../Src/host/bitflags.hpp#L72)
## b_7

Type: constant

Description: 


Replaced value:
```sqf
128
```
File: [host\bitflags.hpp at line 73](../../../Src/host/bitflags.hpp#L73)
## b_8

Type: constant

Description: 


Replaced value:
```sqf
256
```
File: [host\bitflags.hpp at line 74](../../../Src/host/bitflags.hpp#L74)
## b_9

Type: constant

Description: 


Replaced value:
```sqf
512
```
File: [host\bitflags.hpp at line 75](../../../Src/host/bitflags.hpp#L75)
## b_10

Type: constant

Description: 


Replaced value:
```sqf
1024
```
File: [host\bitflags.hpp at line 76](../../../Src/host/bitflags.hpp#L76)
## b_11

Type: constant

Description: 


Replaced value:
```sqf
2048
```
File: [host\bitflags.hpp at line 77](../../../Src/host/bitflags.hpp#L77)
## b_12

Type: constant

Description: 


Replaced value:
```sqf
4096
```
File: [host\bitflags.hpp at line 78](../../../Src/host/bitflags.hpp#L78)
## b_13

Type: constant

Description: 


Replaced value:
```sqf
8192
```
File: [host\bitflags.hpp at line 79](../../../Src/host/bitflags.hpp#L79)
## b_14

Type: constant

Description: 


Replaced value:
```sqf
16384
```
File: [host\bitflags.hpp at line 80](../../../Src/host/bitflags.hpp#L80)
## b_15

Type: constant

Description: 


Replaced value:
```sqf
32768
```
File: [host\bitflags.hpp at line 81](../../../Src/host/bitflags.hpp#L81)
## b_16

Type: constant

Description: 


Replaced value:
```sqf
65536
```
File: [host\bitflags.hpp at line 82](../../../Src/host/bitflags.hpp#L82)
## b_17

Type: constant

Description: 


Replaced value:
```sqf
131072
```
File: [host\bitflags.hpp at line 83](../../../Src/host/bitflags.hpp#L83)
## b_18

Type: constant

Description: 524286 при всех флагах. Дальше значения за 1кк


Replaced value:
```sqf
262144
```
File: [host\bitflags.hpp at line 85](../../../Src/host/bitflags.hpp#L85)
## b_19

Type: constant

Description: 


Replaced value:
```sqf
524288
```
File: [host\bitflags.hpp at line 86](../../../Src/host/bitflags.hpp#L86)
## b_20

Type: constant

Description: Точность потеряна


Replaced value:
```sqf
1.04858e+006
```
File: [host\bitflags.hpp at line 88](../../../Src/host/bitflags.hpp#L88)
## b_21

Type: constant

Description: 


Replaced value:
```sqf
2.09715e+006
```
File: [host\bitflags.hpp at line 89](../../../Src/host/bitflags.hpp#L89)
## b_22

Type: constant

Description: 


Replaced value:
```sqf
4.1943e+006
```
File: [host\bitflags.hpp at line 90](../../../Src/host/bitflags.hpp#L90)
## b_23

Type: constant

Description: 


Replaced value:
```sqf
8.38861e+006
```
File: [host\bitflags.hpp at line 91](../../../Src/host/bitflags.hpp#L91)
## b_24

Type: constant

Description: 


Replaced value:
```sqf
1.67772e+007
```
File: [host\bitflags.hpp at line 92](../../../Src/host/bitflags.hpp#L92)
# engine.hpp

## PLATFORM_VERSION

Type: constant

Description: ! dont use on client, because compiled client (CONTENT-file) used vm-compiler. Only server and editor allowed


Replaced value:
```sqf
'__GAME_VER__'
```
File: [host\engine.hpp at line 13](../../../Src/host/engine.hpp#L13)
## PLATFORM_VERSION_MAJ

Type: constant

Description: 


Replaced value:
```sqf
__GAME_VER_MAJ__
```
File: [host\engine.hpp at line 14](../../../Src/host/engine.hpp#L14)
## PLATFORM_VERSION_MIN

Type: constant

Description: 


Replaced value:
```sqf
__GAME_VER_MIN__
```
File: [host\engine.hpp at line 15](../../../Src/host/engine.hpp#L15)
## PLATFORM_VERSION_BUILD

Type: constant

Description: 


Replaced value:
```sqf
__GAME_BUILD__
```
File: [host\engine.hpp at line 16](../../../Src/host/engine.hpp#L16)
## ENABLE_LINE_IN_FILES

Type: constant

Description: 


Replaced value:
```sqf

```
File: [host\engine.hpp at line 25](../../../Src/host/engine.hpp#L25)
## __pragma_preprocess

Type: constant

> Exists if **ENABLE_LINE_IN_FILES** defined

Description: 


Replaced value:
```sqf
preprocessFileLineNumbers
```
File: [host\engine.hpp at line 28](../../../Src/host/engine.hpp#L28)
## __pragma_preprocess

Type: constant

> Exists if **ENABLE_LINE_IN_FILES** not defined

Description: 


Replaced value:
```sqf
preprocessFile
```
File: [host\engine.hpp at line 30](../../../Src/host/engine.hpp#L30)
## __pragma_prep_cli

Type: constant

Description: 


Replaced value:
```sqf
preprocessFile
```
File: [host\engine.hpp at line 33](../../../Src/host/engine.hpp#L33)
## region(name)

Type: constant

Description: simple implementation of regions
- Param: name

Replaced value:
```sqf

```
File: [host\engine.hpp at line 36](../../../Src/host/engine.hpp#L36)
## endregion

Type: constant

Description: 


Replaced value:
```sqf

```
File: [host\engine.hpp at line 37](../../../Src/host/engine.hpp#L37)
## arg

Type: constant

Description: logger


Replaced value:
```sqf
,
```
File: [host\engine.hpp at line 40](../../../Src/host/engine.hpp#L40)
## args1(a)

Type: constant

Description: args struct
- Param: a

Replaced value:
```sqf
a
```
File: [host\engine.hpp at line 43](../../../Src/host/engine.hpp#L43)
## args2(a,b)

Type: constant

Description: 
- Param: a
- Param: b

Replaced value:
```sqf
a,b
```
File: [host\engine.hpp at line 44](../../../Src/host/engine.hpp#L44)
## args3(a,b,c)

Type: constant

Description: 
- Param: a
- Param: b
- Param: c

Replaced value:
```sqf
a,b,c
```
File: [host\engine.hpp at line 45](../../../Src/host/engine.hpp#L45)
## args4(a,b,c,d)

Type: constant

Description: 
- Param: a
- Param: b
- Param: c
- Param: d

Replaced value:
```sqf
a,b,c,d
```
File: [host\engine.hpp at line 46](../../../Src/host/engine.hpp#L46)
## args5(a,b,c,d,e)

Type: constant

Description: 
- Param: a
- Param: b
- Param: c
- Param: d
- Param: e

Replaced value:
```sqf
a,b,c,d,e
```
File: [host\engine.hpp at line 47](../../../Src/host/engine.hpp#L47)
## args6(a,b,c,d,e,f)

Type: constant

Description: 
- Param: a
- Param: b
- Param: c
- Param: d
- Param: e
- Param: f

Replaced value:
```sqf
a,b,c,d,e,f
```
File: [host\engine.hpp at line 48](../../../Src/host/engine.hpp#L48)
## conDllCall

Type: constant

Description: 


Replaced value:
```sqf
"debug_console" callExtension
```
File: [host\engine.hpp at line 50](../../../Src/host/engine.hpp#L50)
## log(message)

Type: constant

Description: 
- Param: message

Replaced value:
```sqf
[message] call cprint
```
File: [host\engine.hpp at line 52](../../../Src/host/engine.hpp#L52)
## logformat(provider,formatText)

Type: constant

Description: 
- Param: provider
- Param: formatText

Replaced value:
```sqf
[provider,formatText] call cprint
```
File: [host\engine.hpp at line 53](../../../Src/host/engine.hpp#L53)
## errorformat(message,fmt)

Type: constant

Description: 
- Param: message
- Param: fmt

Replaced value:
```sqf
[message,fmt] call cprintErr
```
File: [host\engine.hpp at line 65](../../../Src/host/engine.hpp#L65)
## trace(message)

Type: constant

> Exists if **__TRACE__ENABLED** defined

Description: 
- Param: message

Replaced value:
```sqf

```
File: [host\engine.hpp at line 71](../../../Src/host/engine.hpp#L71)
## traceformat(message,fmt)

Type: constant

> Exists if **__TRACE__ENABLED** defined

Description: 
- Param: message
- Param: fmt

Replaced value:
```sqf
"debug_console" callExtension (format ["TRACE: " + message + "#1011",fmt]);
```
File: [host\engine.hpp at line 71](../../../Src/host/engine.hpp#L71)
## breakpoint_setfile(x)

Type: constant

> Exists if **__TRACE__ENABLED** defined

Description: breakpoints
- Param: x

Replaced value:
```sqf
__bp__file__ = x;
```
File: [host\engine.hpp at line 74](../../../Src/host/engine.hpp#L74)
## breakpoint(data)

Type: constant

> Exists if **__TRACE__ENABLED** defined

Description: breakpoints
- Param: data

Replaced value:
```sqf

```
File: [host\engine.hpp at line 75](../../../Src/host/engine.hpp#L75)
## traceformat(message,fmt)

Type: constant

> Exists if **__TRACE__ENABLED** not defined

Description: 
- Param: message
- Param: fmt

Replaced value:
```sqf

```
File: [host\engine.hpp at line 80](../../../Src/host/engine.hpp#L80)
## breakpoint_setfile(x)

Type: constant

> Exists if **__TRACE__ENABLED** not defined

Description: breakpoints
- Param: x

Replaced value:
```sqf

```
File: [host\engine.hpp at line 82](../../../Src/host/engine.hpp#L82)
## OBSOLETE(funcname)

Type: constant

Description: 
- Param: funcname

Replaced value:
```sqf
private _dt = format ["[OBSOLETE] => %1(): This function will be removed in the future and should not be used." + "#1101", #funcname]; "debug_console" callExtension _dt; [_dt] call discWarning;
```
File: [host\engine.hpp at line 89](../../../Src/host/engine.hpp#L89)
## NOTIMPLEMENTED(funcname)

Type: constant

Description: 
- Param: funcname

Replaced value:
```sqf
private _dt = format ["[NOT_IMPLEMENTED] => %1(): This function not implemented." + "#1101", #funcname]; "debug_console" callExtension _dt; [_dt] call discWarning;
```
File: [host\engine.hpp at line 91](../../../Src/host/engine.hpp#L91)
## ___appexitstr(value)

Type: constant

Description: закрытие потока программы
- Param: value

Replaced value:
```sqf
#value
```
File: [host\engine.hpp at line 94](../../../Src/host/engine.hpp#L94)
## appExit(exitCode)

Type: constant

Description: 
- Param: exitCode

Replaced value:
```sqf
logformat("Application exited. Reason: %1 (%2)",exitCode arg __appexit_listreasons select exitCode); if (!isMultiplayer) then {client_isLocked = true; server_isLocked = true; endMission "END1";} else {if (isServer) then {server_isLocked = true} else {client_isLocked = true}}
```
File: [host\engine.hpp at line 95](../../../Src/host/engine.hpp#L95)
## __appexit_listreasons

Type: constant

Description: 


Replaced value:
```sqf
["APPEXIT_REASON_EXIT" \
	,"APPEXIT_REASON_CRITICAL" \
	,"APPEXIT_REASON_DOUBLEDEF" \
	,"APPEXIT_REASON_UNDEFINEDMODULE" \
	,"APPEXIT_REASON_COMPILATIOEXCEPTION" \
	,"APPEXIT_REASON_RUNTIMEERROR" \
	,"APPEXIT_REASON_ASSERTION_FAIL" \
	,"APPEXIT_REASON_EXTENSION_ERROR" \
	]
```
File: [host\engine.hpp at line 96](../../../Src/host/engine.hpp#L96)
## APPEXIT_REASON_EXIT

Type: constant

Description: 


Replaced value:
```sqf
0
```
File: [host\engine.hpp at line 106](../../../Src/host/engine.hpp#L106)
## APPEXIT_REASON_CRITICAL

Type: constant

Description: 


Replaced value:
```sqf
1
```
File: [host\engine.hpp at line 107](../../../Src/host/engine.hpp#L107)
## APPEXIT_REASON_DOUBLEDEF

Type: constant

Description: 


Replaced value:
```sqf
2
```
File: [host\engine.hpp at line 108](../../../Src/host/engine.hpp#L108)
## APPEXIT_REASON_UNDEFINEDMODULE

Type: constant

Description: 


Replaced value:
```sqf
3
```
File: [host\engine.hpp at line 109](../../../Src/host/engine.hpp#L109)
## APPEXIT_REASON_COMPILATIOEXCEPTION

Type: constant

Description: 


Replaced value:
```sqf
4
```
File: [host\engine.hpp at line 110](../../../Src/host/engine.hpp#L110)
## APPEXIT_REASON_RUNTIMEERROR

Type: constant

Description: 


Replaced value:
```sqf
5
```
File: [host\engine.hpp at line 111](../../../Src/host/engine.hpp#L111)
## APPEXIT_REASON_ASSERTION_FAIL

Type: constant

Description: 


Replaced value:
```sqf
6
```
File: [host\engine.hpp at line 112](../../../Src/host/engine.hpp#L112)
## APPEXIT_REASON_EXTENSION_ERROR

Type: constant

Description: 


Replaced value:
```sqf
7
```
File: [host\engine.hpp at line 113](../../../Src/host/engine.hpp#L113)
## DISABLE_REGEX_ON_FILE

Type: constant

> Exists if **_SQFVM** defined

Description: 


Replaced value:
```sqf

```
File: [host\engine.hpp at line 119](../../../Src/host/engine.hpp#L119)
## loadFile(path)

Type: constant

> Exists if **DISABLE_REGEX_ON_FILE** defined

Description: 
- Param: path

Replaced value:
```sqf
if (server_isLocked) exitWith {error("Compile process aborted - server.isLocked == true")}; logformat("Start loading file %1",path); ["Load file - '%1'",path] call logInfo;  call compile __pragma_preprocess (path)
```
File: [host\engine.hpp at line 125](../../../Src/host/engine.hpp#L125)
## importClient(path)

Type: constant

> Exists if **DISABLE_REGEX_ON_FILE** defined

Description: 
- Param: path

Replaced value:
```sqf
if (isNil {allClientContents}) then {allClientContents = [];}; if (client_isLocked) exitWith {error("Compile process aborted - client.isLocked == true")}; \
	private _ctx = compile __pragma_prep_cli (path); if (_canCallClientCode) then {call _ctx}; allClientContents pushback _ctx;
```
File: [host\engine.hpp at line 127](../../../Src/host/engine.hpp#L127)
## importCommon(path)

Type: constant

> Exists if **DISABLE_REGEX_ON_FILE** defined

Description: 
- Param: path

Replaced value:
```sqf
if (isNil {allClientContents}) then {allClientContents = [];}; \
	private _ctx = compile __pragma_prep_cli ("src\host\CommonComponents\" + path); \
	if (_canCallClientCode) then {call _ctx}; allClientContents pushback _ctx;
```
File: [host\engine.hpp at line 130](../../../Src/host/engine.hpp#L130)
## loadFile(path)

Type: constant

> Exists if **DISABLE_REGEX_ON_FILE** not defined

Description: 
- Param: path

Replaced value:
```sqf
if (server_isLocked) exitWith {error("Compile process aborted - server.isLocked == true")}; logformat("Start loading file %1",path); ["Load file - '%1'",path] call logInfo; call compile __pragma_preprocess (path)
```
File: [host\engine.hpp at line 134](../../../Src/host/engine.hpp#L134)
## importClient(path)

Type: constant

> Exists if **DISABLE_REGEX_ON_FILE** not defined

Description: 
- Param: path

Replaced value:
```sqf
if (isNil {allClientContents}) then {allClientContents = [];}; if (client_isLocked) exitWith {error("Compile process aborted - client.isLocked == true")}; \
	_macro_module = path regexFind ["\w+(?=\.)",0] select 0 select 0 select 0; \
	private _ctx = compile ((__pragma_prep_cli (path))regexReplace ["__THIS_MODULE_REPLACE__",""""+ _macro_module+""""]); if (_canCallClientCode) then {call _ctx}; allClientContents pushback _ctx;
```
File: [host\engine.hpp at line 136](../../../Src/host/engine.hpp#L136)
## importCommon(path)

Type: constant

> Exists if **DISABLE_REGEX_ON_FILE** not defined

Description: 
- Param: path

Replaced value:
```sqf
if (isNil {allClientContents}) then {allClientContents = [];}; \
	_macro_file = """shared" +"\" + path + """"; _macro_module = path regexFind ["\w+(?=\.)",0] select 0 select 0 select 0; \
	__prep = ((__pragma_prep_cli ("src\host\CommonComponents\" + path)) regexReplace ["__THIS_FILE_REPLACE__",(_macro_file regexReplace ["\\","\\\\"])]) regexReplace ["__THIS_MODULE_REPLACE__",""""+ _macro_module+""""]; \
	private _ctx = compile __prep; \
	if (_canCallClientCode) then {call _ctx}; allClientContents pushback _ctx;
```
File: [host\engine.hpp at line 140](../../../Src/host/engine.hpp#L140)
## __vm_log(text)

Type: constant

> Exists if **_SQFVM** defined

Description: 
- Param: text

Replaced value:
```sqf
"debug_console" callExtension ((text)+"#1110")
```
File: [host\engine.hpp at line 148](../../../Src/host/engine.hpp#L148)
## loadFile(path)

Type: constant

> Exists if **_SQFVM** defined

Description: 
- Param: path

Replaced value:
```sqf
\
	__vm_log("Load file: " + path); \
	call compile preprocessFile (path);
```
File: [host\engine.hpp at line 150](../../../Src/host/engine.hpp#L150)
## __vm_warning(data)

Type: constant

> Exists if **_SQFVM** defined

Description: 
- Param: data

Replaced value:
```sqf
diag_log format["[VM_WARN]: %1",data];
```
File: [host\engine.hpp at line 154](../../../Src/host/engine.hpp#L154)
## locationnull

Type: constant

> Exists if **_SQFVM** defined

Description: 


Replaced value:
```sqf
0
```
File: [host\engine.hpp at line 157](../../../Src/host/engine.hpp#L157)
## is3DEN

Type: constant

> Exists if **_SQFVM** defined

Description: 


Replaced value:
```sqf
true
```
File: [host\engine.hpp at line 158](../../../Src/host/engine.hpp#L158)
## addMissionEventHandler

Type: constant

> Exists if **_SQFVM** defined

Description: 


Replaced value:
```sqf
["addMissionEventHandler"] pushBack 
```
File: [host\engine.hpp at line 160](../../../Src/host/engine.hpp#L160)
## toString

Type: constant

> Exists if **_SQFVM** defined

Description: 


Replaced value:
```sqf
str
```
File: [host\engine.hpp at line 162](../../../Src/host/engine.hpp#L162)
## linearConversion

Type: constant

> Exists if **_SQFVM** defined

Description: 


Replaced value:
```sqf
["linearConversion"] pushBack 
```
File: [host\engine.hpp at line 163](../../../Src/host/engine.hpp#L163)
## parseSimpleArray

Type: constant

> Exists if **_SQFVM** defined

Description: 


Replaced value:
```sqf
["parseSimpleArray"] pushBack 
```
File: [host\engine.hpp at line 164](../../../Src/host/engine.hpp#L164)
## endMission

Type: constant

> Exists if **_SQFVM** defined

Description: 


Replaced value:
```sqf
["endMission"] pushBack 
```
File: [host\engine.hpp at line 165](../../../Src/host/engine.hpp#L165)
## FLOOR

Type: constant

> Exists if **_SQFVM** defined

Description: for randInt


Replaced value:
```sqf

```
File: [host\engine.hpp at line 167](../../../Src/host/engine.hpp#L167)
## NO_VM_EXECUTE

Type: constant

> Exists if **_SQFVM** defined

Description: 


Replaced value:
```sqf
if (true) exitwith {};
```
File: [host\engine.hpp at line 169](../../../Src/host/engine.hpp#L169)
## __vm_log(text)

Type: constant

> Exists if **_SQFVM** not defined

Description: 
- Param: text

Replaced value:
```sqf

```
File: [host\engine.hpp at line 171](../../../Src/host/engine.hpp#L171)
## __vm_warning(data)

Type: constant

> Exists if **_SQFVM** not defined

Description: 
- Param: data

Replaced value:
```sqf

```
File: [host\engine.hpp at line 172](../../../Src/host/engine.hpp#L172)
## NO_VM_EXECUTE

Type: constant

> Exists if **_SQFVM** not defined

Description: 


Replaced value:
```sqf

```
File: [host\engine.hpp at line 174](../../../Src/host/engine.hpp#L174)
## __vm_log(text)

Type: constant

> Exists if **__GH_ACTION** defined

Description: 
- Param: text

Replaced value:
```sqf
diag_log (text)
```
File: [host\engine.hpp at line 178](../../../Src/host/engine.hpp#L178)
## fileExists(file)

Type: constant

Description: check if file exists
- Param: file

Replaced value:
```sqf
fileexists (file)
```
File: [host\engine.hpp at line 182](../../../Src/host/engine.hpp#L182)
## SHORT_PATH

Type: constant

Description: TODO fix path


Replaced value:
```sqf
call {private _arr = __FILE__ splitString "\"; private _ret = ""; if (!isMultiplayer) then \
{ {if (_foreachindex >= 8) then {_ret = _ret + "\" + _x}} forEach _arr } else { \
_ret = __FILE__; \
}; _ret select [1,count _ret - 1]} \

```
File: [host\engine.hpp at line 184](../../../Src/host/engine.hpp#L184)
## SHORT_PATH_CUSTOM(d__)

Type: constant

Description: TODO fix path
- Param: d__

Replaced value:
```sqf
(d__) call {private _arr = _this splitString "\"; private _ret = ""; if (!isMultiplayer) then \
{ if ("relicta.vr" in _arr) then {_ret = (_arr select [(_arr find "relicta.vr")+1,count _arr]) joinString "\"} else {_ret = _this}; } else { \
_ret = _this; \
}; _ret} \

```
File: [host\engine.hpp at line 190](../../../Src/host/engine.hpp#L190)
## null

Type: constant

Description: common macro


Replaced value:
```sqf
nil
```
File: [host\engine.hpp at line 198](../../../Src/host/engine.hpp#L198)
## isNull(val)

Type: constant

Description: prob correct??? (rewrite)
- Param: val

Replaced value:
```sqf
(isnil{val})
```
File: [host\engine.hpp at line 200](../../../Src/host/engine.hpp#L200)
## isNullReference(obj)

Type: constant

Description: 
- Param: obj

Replaced value:
```sqf
(isNULL (obj))
```
File: [host\engine.hpp at line 201](../../../Src/host/engine.hpp#L201)
## isNullVar(var)

Type: constant

Description: 
- Param: var

Replaced value:
```sqf
(isnil 'var')
```
File: [host\engine.hpp at line 202](../../../Src/host/engine.hpp#L202)
## defIsNull(_v,_defval)

Type: constant

Description: Определяет значение переменной
- Param: _v
- Param: _defval

Replaced value:
```sqf
if isNullVar(_v) then {_defval} else {_v}
```
File: [host\engine.hpp at line 205](../../../Src/host/engine.hpp#L205)
## outRef(var,def)

Type: constant

Description: Распаковывает ссылку на переменную из верхнего уровня если существует
- Param: var
- Param: def

Replaced value:
```sqf
var = if isNullVar(var) then {def} else {var}
```
File: [host\engine.hpp at line 207](../../../Src/host/engine.hpp#L207)
## isNullPtr(obj)

Type: constant

Description: prob correct??? (rewrite)
- Param: obj

Replaced value:
```sqf
(obj isequaltypeany [locationnull,controlnull,objnull,displaynull])
```
File: [host\engine.hpp at line 210](../../../Src/host/engine.hpp#L210)
## isReference(obj)

Type: constant

Description: 
- Param: obj

Replaced value:
```sqf
(obj isequaltypeany [locationnull,controlnull,objnull,displaynull])
```
File: [host\engine.hpp at line 212](../../../Src/host/engine.hpp#L212)
## stringEmpty

Type: constant

Description: string help


Replaced value:
```sqf
""
```
File: [host\engine.hpp at line 220](../../../Src/host/engine.hpp#L220)
## isValid(ptr)

Type: constant

Description: Осуществляет проверку значения в стиле C++. Любые nullable значения вернут false
- Param: ptr

Replaced value:
```sqf
([ptr] call rv_cppcheck)
```
File: [host\engine.hpp at line 224](../../../Src/host/engine.hpp#L224)
## valid(ptr)

Type: constant

Description: псевдоним if (valid(modlue_somevariable))
- Param: ptr

Replaced value:
```sqf
([ptr] call rv_cppcheck)
```
File: [host\engine.hpp at line 226](../../../Src/host/engine.hpp#L226)
## bool(val)

Type: constant

Description: alias to valid
- Param: val

Replaced value:
```sqf
valid(val)
```
File: [host\engine.hpp at line 228](../../../Src/host/engine.hpp#L228)
## __gptr_os

Type: constant

Description: 


Replaced value:
```sqf
(selectrandom table_hex)
```
File: [host\engine.hpp at line 231](../../../Src/host/engine.hpp#L231)
## generatePtr

Type: constant

Description: 


Replaced value:
```sqf
(__gptr_os + __gptr_os + __gptr_os + __gptr_os + __gptr_os)
```
File: [host\engine.hpp at line 232](../../../Src/host/engine.hpp#L232)
## inRange(numberToCheck,bottom,top)

Type: constant

Description: Проверка диапазона
- Param: numberToCheck
- Param: bottom
- Param: top

Replaced value:
```sqf
((numberToCheck) >= bottom && (numberToCheck) <= top)
```
File: [host\engine.hpp at line 242](../../../Src/host/engine.hpp#L242)
## boolToInt(bval)

Type: constant

Description: 
- Param: bval

Replaced value:
```sqf
([0,1]select (bval))
```
File: [host\engine.hpp at line 244](../../../Src/host/engine.hpp#L244)
## precentage(checked,precval)

Type: constant

Description: получить процент от числа
- Param: checked
- Param: precval

Replaced value:
```sqf
((checked)*(precval)/100)
```
File: [host\engine.hpp at line 247](../../../Src/host/engine.hpp#L247)
## formatTime(secs)

Type: constant

Description: формат в игровое время мин и сек (часы вряд-ли где-то юзаются)
- Param: secs

Replaced value:
```sqf
(secs call{format["%1 мин. %2 сек.",floor(_this / 60),_this % 60]})
```
File: [host\engine.hpp at line 250](../../../Src/host/engine.hpp#L250)
## t_atMin(s)

Type: constant

Description: форматирование времени: каст секунды в минуты
- Param: s

Replaced value:
```sqf
((s)*60)
```
File: [host\engine.hpp at line 253](../../../Src/host/engine.hpp#L253)
## t_atHrs(s)

Type: constant

Description: 
- Param: s

Replaced value:
```sqf
(t_atMin(s)*60)
```
File: [host\engine.hpp at line 254](../../../Src/host/engine.hpp#L254)
## INFINITY

Type: constant

Description: 


Replaced value:
```sqf
1e39
```
File: [host\engine.hpp at line 256](../../../Src/host/engine.hpp#L256)
## INC(var)

Type: constant

Description: 
- Param: var

Replaced value:
```sqf
var = var+1
```
File: [host\engine.hpp at line 258](../../../Src/host/engine.hpp#L258)
## DEC(var)

Type: constant

Description: 
- Param: var

Replaced value:
```sqf
var = var-1
```
File: [host\engine.hpp at line 259](../../../Src/host/engine.hpp#L259)
## MOD(var,val)

Type: constant

Description: Возможно тут проблема при конкатенации строк с присутствием в них запятых
- Param: var
- Param: val

Replaced value:
```sqf
var = var val
```
File: [host\engine.hpp at line 262](../../../Src/host/engine.hpp#L262)
## modvar(var)

Type: constant

Description: 
- Param: var

Replaced value:
```sqf
var = var
```
File: [host\engine.hpp at line 263](../../../Src/host/engine.hpp#L263)
## MODARR(var,index,modif)

Type: constant

Description: array helpers
- Param: var
- Param: index
- Param: modif

Replaced value:
```sqf
var set[index,(var select(index)) modif]
```
File: [host\engine.hpp at line 266](../../../Src/host/engine.hpp#L266)
## SETARR(arr,index,val)

Type: constant

Description: 
- Param: arr
- Param: index
- Param: val

Replaced value:
```sqf
arr set[index,val]
```
File: [host\engine.hpp at line 267](../../../Src/host/engine.hpp#L267)
## GETARR(arr,index)

Type: constant

Description: 
- Param: arr
- Param: index

Replaced value:
```sqf
arr select(index)
```
File: [host\engine.hpp at line 268](../../../Src/host/engine.hpp#L268)
## array_exists(arr,var)

Type: constant

Description: 
- Param: arr
- Param: var

Replaced value:
```sqf
((var)in arr)
```
File: [host\engine.hpp at line 270](../../../Src/host/engine.hpp#L270)
## array_shuffle(array)

Type: constant

Description: рандомный сорт массива
- Param: array

Replaced value:
```sqf
(array call BIS_fnc_arrayShuffle)
```
File: [host\engine.hpp at line 272](../../../Src/host/engine.hpp#L272)
## array_copy(array)

Type: constant

Description: копирование массива
- Param: array

Replaced value:
```sqf
(+array)
```
File: [host\engine.hpp at line 274](../../../Src/host/engine.hpp#L274)
## array_remlast(arr)

Type: constant

Description: poplast
- Param: arr

Replaced value:
```sqf
(arr call {_this deleteAt (count _this - 1)})
```
File: [host\engine.hpp at line 276](../../../Src/host/engine.hpp#L276)
## array_selectlast(arr)

Type: constant

Description: select last item
- Param: arr

Replaced value:
```sqf
(arr call {_this select (count _this - 1)})
```
File: [host\engine.hpp at line 278](../../../Src/host/engine.hpp#L278)
## array_isempty(arr)

Type: constant

Description: check if array empty
- Param: arr

Replaced value:
```sqf
(count(arr)==0)
```
File: [host\engine.hpp at line 280](../../../Src/host/engine.hpp#L280)
## array_count(arr)

Type: constant

Description: check array elements count
- Param: arr

Replaced value:
```sqf
(count (arr))
```
File: [host\engine.hpp at line 282](../../../Src/host/engine.hpp#L282)
## array_remove(array,el)

Type: constant

Description: 
- Param: array
- Param: el

Replaced value:
```sqf
([array,el] call {params["_a","_e"]; _a deleteAt(_a find _e)})
```
File: [host\engine.hpp at line 284](../../../Src/host/engine.hpp#L284)
## vec1(x)

Type: constant

Description: 
- Param: x

Replaced value:
```sqf
[x]
```
File: [host\engine.hpp at line 286](../../../Src/host/engine.hpp#L286)
## vec2(x,y)

Type: constant

Description: 
- Param: x
- Param: y

Replaced value:
```sqf
[x,y]
```
File: [host\engine.hpp at line 287](../../../Src/host/engine.hpp#L287)
## vec3(x,y,z)

Type: constant

Description: 
- Param: x
- Param: y
- Param: z

Replaced value:
```sqf
[x,y,z]
```
File: [host\engine.hpp at line 288](../../../Src/host/engine.hpp#L288)
## vec4(x,y,w,h)

Type: constant

Description: 
- Param: x
- Param: y
- Param: w
- Param: h

Replaced value:
```sqf
[x,y,w,h]
```
File: [host\engine.hpp at line 289](../../../Src/host/engine.hpp#L289)
## refcreate(value)

Type: constant

Description: reference packer
- Param: value

Replaced value:
```sqf
[value]
```
File: [host\engine.hpp at line 293](../../../Src/host/engine.hpp#L293)
## refget(val)

Type: constant

Description: 
- Param: val

Replaced value:
```sqf
(val select 0)
```
File: [host\engine.hpp at line 294](../../../Src/host/engine.hpp#L294)
## refset(ref,newvalue)

Type: constant

Description: 
- Param: ref
- Param: newvalue

Replaced value:
```sqf
ref set[0,newvalue]
```
File: [host\engine.hpp at line 295](../../../Src/host/engine.hpp#L295)
## refunpack(ref)

Type: constant

Description: 
- Param: ref

Replaced value:
```sqf
ref = (ref select 0)
```
File: [host\engine.hpp at line 296](../../../Src/host/engine.hpp#L296)
## __ptr_struct_internal__(address,value)

Type: constant

Description: 
- Param: address
- Param: value

Replaced value:
```sqf
vec2(address,value)
```
File: [host\engine.hpp at line 315](../../../Src/host/engine.hpp#L315)
## nullptr

Type: constant

Description: 


Replaced value:
```sqf
ptr_cnl
```
File: [host\engine.hpp at line 316](../../../Src/host/engine.hpp#L316)
## ptr_alloc(initial)

Type: constant

Description: 
- Param: initial

Replaced value:
```sqf
((initial)call ptr_create)
```
File: [host\engine.hpp at line 317](../../../Src/host/engine.hpp#L317)
## ptr_free(refval)

Type: constant

Description: 
- Param: refval

Replaced value:
```sqf
((refval)call ptr_destroy)
```
File: [host\engine.hpp at line 318](../../../Src/host/engine.hpp#L318)
## PTR_STRUCT_ADDRESS

Type: constant

Description: internal ptr helpers


Replaced value:
```sqf
0
```
File: [host\engine.hpp at line 320](../../../Src/host/engine.hpp#L320)
## PTR_STRUCT_VALUE

Type: constant

Description: 


Replaced value:
```sqf
1
```
File: [host\engine.hpp at line 321](../../../Src/host/engine.hpp#L321)
## ptr_address(p)

Type: constant

Description: simple commands
- Param: p

Replaced value:
```sqf
((p)call ptr_cts)
```
File: [host\engine.hpp at line 323](../../../Src/host/engine.hpp#L323)
## ptr_read(p)

Type: constant

Description: 
- Param: p

Replaced value:
```sqf
((p)select PTR_STRUCT_VALUE)
```
File: [host\engine.hpp at line 324](../../../Src/host/engine.hpp#L324)
## ptr_write(p,v)

Type: constant

Description: 
- Param: p
- Param: v

Replaced value:
```sqf
(p)set[PTR_STRUCT_VALUE,v]
```
File: [host\engine.hpp at line 325](../../../Src/host/engine.hpp#L325)
## ptr_modvar(p)

Type: constant

Description: functionality
- Param: p

Replaced value:
```sqf
_poldvm_g_=0;(p call ptr_remval)pushBack _poldvm_g_
```
File: [host\engine.hpp at line 327](../../../Src/host/engine.hpp#L327)
## ptr_inc(p)

Type: constant

Description: 
- Param: p

Replaced value:
```sqf
_poldvs_g_=(p)select PTR_STRUCT_VALUE;p set[PTR_STRUCT_VALUE,_poldvs_g_+1];
```
File: [host\engine.hpp at line 328](../../../Src/host/engine.hpp#L328)
## ptr_dec(p)

Type: constant

Description: 
- Param: p

Replaced value:
```sqf
_poldvs_g_=(p)select PTR_STRUCT_VALUE;p set[PTR_STRUCT_VALUE,_poldvs_g_-1];
```
File: [host\engine.hpp at line 329](../../../Src/host/engine.hpp#L329)
## ptr(p)

Type: constant

Description: simple commands
- Param: p

Replaced value:
```sqf
_poldvm_g_=0;(p call ptr_remval)pushBack
```
File: [host\engine.hpp at line 317](../../../Src/host/engine.hpp#L317)
## isptr(p)

Type: constant

Description: check is ptr
- Param: p

Replaced value:
```sqf
((p)call ptr_check)
```
File: [host\engine.hpp at line 333](../../../Src/host/engine.hpp#L333)
## hashSet_createEmpty()

Type: constant

Description: hash set
- Param: 

Replaced value:
```sqf
createHashMap
```
File: [host\engine.hpp at line 336](../../../Src/host/engine.hpp#L336)
## hashSet_create(keys)

Type: constant

Description: hash set
- Param: keys

Replaced value:
```sqf
((keys)createHashMapFromArray [])
```
File: [host\engine.hpp at line 336](../../../Src/host/engine.hpp#L336)
## hashSet_createList(vals)

Type: constant

Description: 
- Param: vals

Replaced value:
```sqf
([vals]createHashMapFromArray [])
```
File: [host\engine.hpp at line 338](../../../Src/host/engine.hpp#L338)
## hashSet_add(hash,item)

Type: constant

Description: 
- Param: hash
- Param: item

Replaced value:
```sqf
(hash)set [item,nil]
```
File: [host\engine.hpp at line 339](../../../Src/host/engine.hpp#L339)
## hashSet_toArray(hash)

Type: constant

Description: 
- Param: hash

Replaced value:
```sqf
(keys(hash))
```
File: [host\engine.hpp at line 340](../../../Src/host/engine.hpp#L340)
## hashSet_rem(hash,item)

Type: constant

Description: 
- Param: hash
- Param: item

Replaced value:
```sqf
(hash)deleteAt (item)
```
File: [host\engine.hpp at line 341](../../../Src/host/engine.hpp#L341)
## hashSet_exists(hash,item)

Type: constant

Description: 
- Param: hash
- Param: item

Replaced value:
```sqf
((item)in(hash))
```
File: [host\engine.hpp at line 342](../../../Src/host/engine.hpp#L342)
## hashSet_count(hash)

Type: constant

Description: 
- Param: hash

Replaced value:
```sqf
(count(hash))
```
File: [host\engine.hpp at line 343](../../../Src/host/engine.hpp#L343)
## hashSet_clear(hash)

Type: constant

Description: 
- Param: hash

Replaced value:
```sqf
(hash)call{{_this deleteat _x}foreach +_this}
```
File: [host\engine.hpp at line 344](../../../Src/host/engine.hpp#L344)
## hashSet_copyFrom(hash,merged)

Type: constant

Description: 
- Param: hash
- Param: merged

Replaced value:
```sqf
(hash)merge (merged)
```
File: [host\engine.hpp at line 345](../../../Src/host/engine.hpp#L345)
## hashMapNew

Type: constant

Description: hashmap


Replaced value:
```sqf
createHashMap
```
File: [host\engine.hpp at line 348](../../../Src/host/engine.hpp#L348)
## hashMapNewArgs

Type: constant

Description: 


Replaced value:
```sqf
createHashMapFromArray
```
File: [host\engine.hpp at line 349](../../../Src/host/engine.hpp#L349)
## prop(varname)

Type: constant

Description: 
- Param: varname

Replaced value:
```sqf
varname
```
File: [host\engine.hpp at line 370](../../../Src/host/engine.hpp#L370)
## onpropset(varname)

Type: constant

Description: 
- Param: varname

Replaced value:
```sqf
varname##_set
```
File: [host\engine.hpp at line 371](../../../Src/host/engine.hpp#L371)
## onpropget(varname)

Type: constant

Description: 
- Param: varname

Replaced value:
```sqf
varname##_get
```
File: [host\engine.hpp at line 372](../../../Src/host/engine.hpp#L372)
## propset(varname,val)

Type: constant

Description: 
- Param: varname
- Param: val

Replaced value:
```sqf
val call onpropset(varname)
```
File: [host\engine.hpp at line 373](../../../Src/host/engine.hpp#L373)
## propget(varname)

Type: constant

Description: 
- Param: varname

Replaced value:
```sqf
call onpropget(varname)
```
File: [host\engine.hpp at line 374](../../../Src/host/engine.hpp#L374)
## objectAddEventHandler

Type: constant

Description: preprocessing protect to native function eventhandler


Replaced value:
```sqf
ADDEVENTHANDLER
```
File: [host\engine.hpp at line 393](../../../Src/host/engine.hpp#L393)
## __eventHandlerName__(varname)

Type: constant

Description: 
- Param: varname

Replaced value:
```sqf
varname##_evh
```
File: [host\engine.hpp at line 395](../../../Src/host/engine.hpp#L395)
## eventHandlerArgs

Type: constant

Description: 


Replaced value:
```sqf
_evhargs__
```
File: [host\engine.hpp at line 396](../../../Src/host/engine.hpp#L396)
## registerEventHandler(varname)

Type: constant

Description: 
- Param: varname

Replaced value:
```sqf
__eventHandlerName__(varname) = []
```
File: [host\engine.hpp at line 397](../../../Src/host/engine.hpp#L397)
## addEventHandler(varname,val)

Type: constant

Description: 
- Param: varname
- Param: val

Replaced value:
```sqf
__eventHandlerName__(varname) pushBack (val)
```
File: [host\engine.hpp at line 398](../../../Src/host/engine.hpp#L398)
## removeEventHandler(varname,val)

Type: constant

Description: 
- Param: varname
- Param: val

Replaced value:
```sqf
__eventHandlerName__(varname) deleteat (__eventHandlerName__(varname) find (val))
```
File: [host\engine.hpp at line 399](../../../Src/host/engine.hpp#L399)
## callEventHandler(varname,evhargs)

Type: constant

Description: 
- Param: varname
- Param: evhargs

Replaced value:
```sqf
private eventHandlerArgs = evhargs; {call _x;true} count __eventHandlerName__(varname)
```
File: [host\engine.hpp at line 400](../../../Src/host/engine.hpp#L400)
## structCreate(name)

Type: constant

Description: 
- Param: name

Replaced value:
```sqf
ps_##name = [["typeName",#name
```
File: [host\engine.hpp at line 417](../../../Src/host/engine.hpp#L417)
## structEnd

Type: constant

Description: 


Replaced value:
```sqf
]];
```
File: [host\engine.hpp at line 418](../../../Src/host/engine.hpp#L418)
## structVar(varname)

Type: constant

Description: 
- Param: varname

Replaced value:
```sqf
],[#varname,
```
File: [host\engine.hpp at line 420](../../../Src/host/engine.hpp#L420)
## structNew(name)

Type: constant

Description: 
- Param: name

Replaced value:
```sqf
(createHashMapFromArray ps_##name)
```
File: [host\engine.hpp at line 422](../../../Src/host/engine.hpp#L422)
## structSet(obj,varname,varval)

Type: constant

Description: accessing struct
- Param: obj
- Param: varname
- Param: varval

Replaced value:
```sqf
obj set [#varname,varval]
```
File: [host\engine.hpp at line 424](../../../Src/host/engine.hpp#L424)
## structGet(obj,varname)

Type: constant

Description: 
- Param: obj
- Param: varname

Replaced value:
```sqf
(obj get #varname)
```
File: [host\engine.hpp at line 425](../../../Src/host/engine.hpp#L425)
## equals(obja,objb)

Type: constant

Description: comparsion
- Param: obja
- Param: objb

Replaced value:
```sqf
((obja)isequalto(objb))
```
File: [host\engine.hpp at line 429](../../../Src/host/engine.hpp#L429)
## not_equals(obja,objb)

Type: constant

Description: 
- Param: obja
- Param: objb

Replaced value:
```sqf
((obja)isnotequalto(objb))
```
File: [host\engine.hpp at line 430](../../../Src/host/engine.hpp#L430)
## equalTypes(obja,objb)

Type: constant

Description: 
- Param: obja
- Param: objb

Replaced value:
```sqf
((obja)isequaltype(objb))
```
File: [host\engine.hpp at line 433](../../../Src/host/engine.hpp#L433)
## not_equalTypes(obja,objb)

Type: constant

Description: 
- Param: obja
- Param: objb

Replaced value:
```sqf
(!equalTypes(obja,objb))
```
File: [host\engine.hpp at line 434](../../../Src/host/engine.hpp#L434)
## pick

Type: constant

Description: random helpers


Replaced value:
```sqf
selectRandom
```
File: [host\engine.hpp at line 437](../../../Src/host/engine.hpp#L437)
## rand(_beg,_end)

Type: constant

Description: выбор рандомного числа включительно Bis_fnc_randomNum
- Param: _beg
- Param: _end

Replaced value:
```sqf
(linearConversion [0,1,random 1,_beg,_end])
```
File: [host\engine.hpp at line 439](../../../Src/host/engine.hpp#L439)
## randInt(_beg,_end)

Type: constant

Description: BIS_fnc_randomInt
- Param: _beg
- Param: _end

Replaced value:
```sqf
(FLOOR linearConversion [0,1,random 1,(_beg)min(_end),(_end)max(_beg)+1])
```
File: [host\engine.hpp at line 441](../../../Src/host/engine.hpp#L441)
## prob(val)

Type: constant

Description: 
- Param: val

Replaced value:
```sqf
(random[0,50,100]<(val))
```
File: [host\engine.hpp at line 443](../../../Src/host/engine.hpp#L443)
## pow(a,b)

Type: constant

Description: math helpers
- Param: a
- Param: b

Replaced value:
```sqf
((a) ^ (b))
```
File: [host\engine.hpp at line 446](../../../Src/host/engine.hpp#L446)
## clamp(val,__min,__max)

Type: constant

Description: Ограничение числа
- Param: val
- Param: __min
- Param: __max

Replaced value:
```sqf
((val)max(__min)min(__max))
```
File: [host\engine.hpp at line 449](../../../Src/host/engine.hpp#L449)
## clampangle(x,a,b)

Type: constant

Description: 
- Param: x
- Param: a
- Param: b

Replaced value:
```sqf
(((((x) % 360 + 360) % 360) max (a)) min (b))
```
File: [host\engine.hpp at line 451](../../../Src/host/engine.hpp#L451)
## parseNumberSafe(v)

Type: constant

Description: 
- Param: v

Replaced value:
```sqf
((parseNumber (v)) call {if(finite _this) then {_this} else {0}})
```
File: [host\engine.hpp at line 453](../../../Src/host/engine.hpp#L453)
## netTickTime

Type: constant

Description: delay subsystem


Replaced value:
```sqf
CBA_missionTime
```
File: [host\engine.hpp at line 457](../../../Src/host/engine.hpp#L457)
## tickTime

Type: constant

Description: 


Replaced value:
```sqf
diag_tickTime
```
File: [host\engine.hpp at line 458](../../../Src/host/engine.hpp#L458)
## deltaTime

Type: constant

Description: 


Replaced value:
```sqf
diag_deltaTime
```
File: [host\engine.hpp at line 459](../../../Src/host/engine.hpp#L459)
## startUpdate(func,delay)

Type: constant

Description: 
- Param: func
- Param: delay

Replaced value:
```sqf
[func,delay] call CBA_fnc_addPerFrameHandler
```
File: [host\engine.hpp at line 461](../../../Src/host/engine.hpp#L461)
## startUpdateParams(func,delay,params)

Type: constant

Description: 
- Param: func
- Param: delay
- Param: params

Replaced value:
```sqf
[func,delay,params] call CBA_fnc_addPerFrameHandler
```
File: [host\engine.hpp at line 462](../../../Src/host/engine.hpp#L462)
## stopUpdate(handle)

Type: constant

Description: 
- Param: handle

Replaced value:
```sqf
handle call CBA_fnc_removePerFrameHandler
```
File: [host\engine.hpp at line 464](../../../Src/host/engine.hpp#L464)
## thisUpdate

Type: constant

Description: 


Replaced value:
```sqf
(_this select 1)
```
File: [host\engine.hpp at line 466](../../../Src/host/engine.hpp#L466)
## stopThisUpdate()

Type: constant

Description: 
- Param: 

Replaced value:
```sqf
stopUpdate(_this select 1)
```
File: [host\engine.hpp at line 468](../../../Src/host/engine.hpp#L468)
## changeUpdateTime(handle,newTime)

Type: constant

Description: 
- Param: handle
- Param: newTime

Replaced value:
```sqf
(call {if (handle < 0 || newTime < 0) exitWith {false}; \
cba_common_perFrameHandlerArray select (handle) set [1,newTime]; true})
```
File: [host\engine.hpp at line 470](../../../Src/host/engine.hpp#L470)
## changeThisUpdateTime(newTime)

Type: constant

Description: 
- Param: newTime

Replaced value:
```sqf
changeUpdateTime(thisUpdate,newTime)
```
File: [host\engine.hpp at line 473](../../../Src/host/engine.hpp#L473)
## getThisCodeInTimeEvent(varname)

Type: constant

Description: 
- Param: varname

Replaced value:
```sqf
varname = _x select 1
```
File: [host\engine.hpp at line 475](../../../Src/host/engine.hpp#L475)
## nextFrame(code)

Type: constant

Description: 
- Param: code

Replaced value:
```sqf
[code] call CBA_fnc_execNextFrame
```
File: [host\engine.hpp at line 477](../../../Src/host/engine.hpp#L477)
## nextFrameParams(code,args)

Type: constant

Description: 
- Param: code
- Param: args

Replaced value:
```sqf
[code,args] call CBA_fnc_execNextFrame
```
File: [host\engine.hpp at line 478](../../../Src/host/engine.hpp#L478)
## invokeAfterDelay(code,delay)

Type: constant

Description: 
- Param: code
- Param: delay

Replaced value:
```sqf
[code,[],delay] call CBA_fnc_waitAndExecute
```
File: [host\engine.hpp at line 480](../../../Src/host/engine.hpp#L480)
## invokeAfterDelayParams(code,delay,params)

Type: constant

Description: 
- Param: code
- Param: delay
- Param: params

Replaced value:
```sqf
[code,params,delay] call CBA_fnc_waitAndExecute
```
File: [host\engine.hpp at line 481](../../../Src/host/engine.hpp#L481)
## deferred

Type: constant

Description: 


Replaced value:
```sqf
__cframe__=
```
File: [host\engine.hpp at line 492](../../../Src/host/engine.hpp#L492)
## doInvoke(delay)

Type: constant

Description: 
- Param: delay

Replaced value:
```sqf
;invokeAfterDelay(__cframe__,delay)
```
File: [host\engine.hpp at line 493](../../../Src/host/engine.hpp#L493)
## doInvokeParams(delay,_prms)

Type: constant

Description: 
- Param: delay
- Param: _prms

Replaced value:
```sqf
;invokeAfterDelayParams(__cframe__,delay,_prms)
```
File: [host\engine.hpp at line 494](../../../Src/host/engine.hpp#L494)
## asyncInvoke(c_condit,c_state,args,timeout,c_tim)

Type: constant

Description: 
- Param: c_condit
- Param: c_state
- Param: args
- Param: timeout
- Param: c_tim

Replaced value:
```sqf
[c_condit, c_state, args,timeout,c_tim] call CBA_fnc_waitUntilAndExecute
```
File: [host\engine.hpp at line 496](../../../Src/host/engine.hpp#L496)
## startAsyncInvoke

Type: constant

Description: 


Replaced value:
```sqf
[
```
File: [host\engine.hpp at line 498](../../../Src/host/engine.hpp#L498)
## endAsyncInvoke

Type: constant

Description: 


Replaced value:
```sqf
] call CBA_fnc_waitUntilAndExecute;
```
File: [host\engine.hpp at line 499](../../../Src/host/engine.hpp#L499)
## ifcheck(val,_trueval,_falseval)

Type: constant

Description: lang helpers
- Param: val
- Param: _trueval
- Param: _falseval

Replaced value:
```sqf
(if(val)then{_trueval}else{_falseval})
```
File: [host\engine.hpp at line 504](../../../Src/host/engine.hpp#L504)
## FHEADER

Type: constant

Description: 


Replaced value:
```sqf
scopename "main"
```
File: [host\engine.hpp at line 506](../../../Src/host/engine.hpp#L506)
## RETURN(val)

Type: constant

Description: 
- Param: val

Replaced value:
```sqf
(val) breakout "main"
```
File: [host\engine.hpp at line 508](../../../Src/host/engine.hpp#L508)
## IF(val)

Type: constant

Description: 
- Param: val

Replaced value:
```sqf
if (val) then
```
File: [host\engine.hpp at line 510](../../../Src/host/engine.hpp#L510)
## IF_EXIT(val)

Type: constant

Description: 
- Param: val

Replaced value:
```sqf
if (val) exitwith
```
File: [host\engine.hpp at line 512](../../../Src/host/engine.hpp#L512)
## IF_RET(val,ret)

Type: constant

Description: 
- Param: val
- Param: ret

Replaced value:
```sqf
if (val) then {RETURN(ret)}
```
File: [host\engine.hpp at line 514](../../../Src/host/engine.hpp#L514)
## FOR(init,start,end)

Type: constant

Description: 
- Param: init
- Param: start
- Param: end

Replaced value:
```sqf
for #init from start to end do
```
File: [host\engine.hpp at line 516](../../../Src/host/engine.hpp#L516)
## WHILE(cond)

Type: constant

Description: 
- Param: cond

Replaced value:
```sqf
while {cond} do
```
File: [host\engine.hpp at line 518](../../../Src/host/engine.hpp#L518)
## SWITCH(cond)

Type: constant

Description: 
- Param: cond

Replaced value:
```sqf
switch(cond) do
```
File: [host\engine.hpp at line 520](../../../Src/host/engine.hpp#L520)
## CASE(cond)

Type: constant

Description: 
- Param: cond

Replaced value:
```sqf
case (cond) :
```
File: [host\engine.hpp at line 522](../../../Src/host/engine.hpp#L522)
## fswitch(val)

Type: constant

Description: extended language helpers
- Param: val

Replaced value:
```sqf
(val) call
```
File: [host\engine.hpp at line 525](../../../Src/host/engine.hpp#L525)
## fcase(val)

Type: constant

Description: 
- Param: val

Replaced value:
```sqf
if equals(_this,val) exitWith
```
File: [host\engine.hpp at line 526](../../../Src/host/engine.hpp#L526)
## fcasein(values)

Type: constant

Description: 
- Param: values

Replaced value:
```sqf
if (_this in (values)) exitWith
```
File: [host\engine.hpp at line 527](../../../Src/host/engine.hpp#L527)
## soundDataDef(path)

Type: constant

Description: sound engine
- Param: path

Replaced value:
```sqf
[path]
```
File: [host\engine.hpp at line 532](../../../Src/host/engine.hpp#L532)
## soundData(path,pithmin,pithmax)

Type: constant

Description: sound engine
- Param: path
- Param: pithmin
- Param: pithmax

Replaced value:
```sqf
[path,pithmin,pithmax]
```
File: [host\engine.hpp at line 532](../../../Src/host/engine.hpp#L532)
## getRandomPitch

Type: constant

Description: Получает рандомный питч от 0.5 до 2


Replaced value:
```sqf
(linearConversion [0, 1, random 1, 0.5, 2])
```
File: [host\engine.hpp at line 536](../../../Src/host/engine.hpp#L536)
## getRandomPitchInRange(low,up)

Type: constant

Description: 
- Param: low
- Param: up

Replaced value:
```sqf
(linearConversion [0, 1, random 1,low, up])
```
File: [host\engine.hpp at line 538](../../../Src/host/engine.hpp#L538)
## criptPtr_index

Type: constant

> Exists if **DISABLE_POINTER_CRIPT** defined

Description: 


Replaced value:
```sqf
0
```
File: [host\engine.hpp at line 550](../../../Src/host/engine.hpp#L550)
## criptPtr(val)

Type: constant

> Exists if **DISABLE_POINTER_CRIPT** defined

Description: 
- Param: val

Replaced value:
```sqf
(toString (toarray (val) apply {_x + criptPtr_index}))
```
File: [host\engine.hpp at line 551](../../../Src/host/engine.hpp#L551)
## criptPtr_index

Type: constant

> Exists if **DISABLE_POINTER_CRIPT** not defined

Description: 


Replaced value:
```sqf
32
```
File: [host\engine.hpp at line 553](../../../Src/host/engine.hpp#L553)
## getArmaVersion()

Type: constant

Description: versioning arma
- Param: 

Replaced value:
```sqf
(format ["%1.%2",(productVersion select 2)/100 toFixed 2,(productVersion select 3)])
```
File: [host\engine.hpp at line 558](../../../Src/host/engine.hpp#L558)
## defineModule(name)

Type: constant

> Exists if **DATA_MANAGER_ENABLED** defined

Description: определяем имя модуля
- Param: name

Replaced value:
```sqf
_thisModule = 'name';
```
File: [host\engine.hpp at line 565](../../../Src/host/engine.hpp#L565)
## global_var(var)

Type: constant

> Exists if **DATA_MANAGER_ENABLED** defined

Description: 
- Param: var

Replaced value:
```sqf
[#var,__FILE__,__LINE__,_thisModule] call gv_rv; var
```
File: [host\engine.hpp at line 567](../../../Src/host/engine.hpp#L567)
## global_func(var)

Type: constant

> Exists if **DATA_MANAGER_ENABLED** defined

Description: 
- Param: var

Replaced value:
```sqf
[#var,__FILE__,__LINE__,_thisModule] call gv_rf; var
```
File: [host\engine.hpp at line 568](../../../Src/host/engine.hpp#L568)
## __iglob_provider(var,type)

Type: constant

> Exists if **DATA_MANAGER_ENABLED** defined

Description: register for type-safety variable
- Param: var
- Param: type

Replaced value:
```sqf
[#var,type] call gv_rts
```
File: [host\engine.hpp at line 583](../../../Src/host/engine.hpp#L583)
## global_num(var)

Type: constant

> Exists if **DATA_MANAGER_ENABLED** defined

Description: 
- Param: var

Replaced value:
```sqf
__iglob_provider(var,0)
```
File: [host\engine.hpp at line 584](../../../Src/host/engine.hpp#L584)
## global_str(var)

Type: constant

> Exists if **DATA_MANAGER_ENABLED** defined

Description: 
- Param: var

Replaced value:
```sqf
__iglob_provider(var,"")
```
File: [host\engine.hpp at line 585](../../../Src/host/engine.hpp#L585)
## global_arr(var)

Type: constant

> Exists if **DATA_MANAGER_ENABLED** defined

Description: 
- Param: var

Replaced value:
```sqf
__iglob_provider(var,[])
```
File: [host\engine.hpp at line 586](../../../Src/host/engine.hpp#L586)
## global_obj(var)

Type: constant

> Exists if **DATA_MANAGER_ENABLED** defined

Description: 
- Param: var

Replaced value:
```sqf
__iglob_provider(var,objnull)
```
File: [host\engine.hpp at line 587](../../../Src/host/engine.hpp#L587)
## global_ptr(var)

Type: constant

> Exists if **DATA_MANAGER_ENABLED** defined

Description: 
- Param: var

Replaced value:
```sqf
__iglob_provider(var,locationnull)
```
File: [host\engine.hpp at line 588](../../../Src/host/engine.hpp#L588)
## __aps_on_assert_exit

Type: constant

Description: 


Replaced value:
```sqf
appExit(APPEXIT_REASON_ASSERTION_FAIL)
```
File: [host\engine.hpp at line 591](../../../Src/host/engine.hpp#L591)
## __aps_on_assert_exit

Type: constant

> Exists if **ENABLE_EXIT_ON_ASSERT** not defined

Description: 


Replaced value:
```sqf

```
File: [host\engine.hpp at line 593](../../../Src/host/engine.hpp#L593)
## __COMMA__

Type: constant

Description: assertion


Replaced value:
```sqf
","
```
File: [host\engine.hpp at line 597](../../../Src/host/engine.hpp#L597)
## __THIS_FILE_REPLACE__

Type: constant

Description: 


Replaced value:
```sqf
SHORT_PATH
```
File: [host\engine.hpp at line 598](../../../Src/host/engine.hpp#L598)
## __assert_string_convert(data)

Type: constant

Description: 
- Param: data

Replaced value:
```sqf
(tostring{data})
```
File: [host\engine.hpp at line 599](../../../Src/host/engine.hpp#L599)
## assert(_cond)

Type: constant

Description: todo assert return bool on clinet, server and editor
- Param: _cond

Replaced value:
```sqf

```
File: [host\engine.hpp at line 602](../../../Src/host/engine.hpp#L602)
## assert_client(_cond)

Type: constant

Description: 
- Param: _cond

Replaced value:
```sqf
ASSERT (_cond);if!(_cond)exitWith{__assert_error__('<Runtime client>',__THIS_MODULE_REPLACE__,__LINE__,"module")};
```
File: [host\engine.hpp at line 602](../../../Src/host/engine.hpp#L602)
## __assert_error__(code,modl,line__,comp__)

Type: constant

Description: 
- Param: code
- Param: modl
- Param: line__
- Param: comp__

Replaced value:
```sqf
errorformat("Assertion failed: %2%1 %5 %3%1 line %4",__COMMA__ arg code arg modl arg line__ arg comp__); __aps_on_assert_exit
```
File: [host\engine.hpp at line 603](../../../Src/host/engine.hpp#L603)
## __THIS_MODULE_REPLACE__

Type: constant

> Exists if **DISABLE_REGEX_ON_FILE** defined

Description: 


Replaced value:
```sqf
"<RUNTIME_MODULE>"
```
File: [host\engine.hpp at line 607](../../../Src/host/engine.hpp#L607)
## assert_client(_cond)

Type: constant

> Exists if **DISABLE_ASSERT** defined

Description: 
- Param: _cond

Replaced value:
```sqf

```
File: [host\engine.hpp at line 612](../../../Src/host/engine.hpp#L612)
## __assert_error__(code,modl,line__,comp__)

Type: constant

> Exists if **DISABLE_ASSERT** defined

Description: 
- Param: code
- Param: modl
- Param: line__
- Param: comp__

Replaced value:
```sqf

```
File: [host\engine.hpp at line 613](../../../Src/host/engine.hpp#L613)
## __COMMA__

Type: constant

> Exists if **DISABLE_ASSERT** defined

Description: assertion


Replaced value:
```sqf

```
File: [host\engine.hpp at line 614](../../../Src/host/engine.hpp#L614)
## __THIS_FILE_REPLACE__

Type: constant

> Exists if **DISABLE_ASSERT** defined

Description: 


Replaced value:
```sqf

```
File: [host\engine.hpp at line 615](../../../Src/host/engine.hpp#L615)
## __assert_string_convert(data)

Type: constant

> Exists if **DISABLE_ASSERT** defined

Description: 
- Param: data

Replaced value:
```sqf

```
File: [host\engine.hpp at line 616](../../../Src/host/engine.hpp#L616)
## assert(_cond)

Type: constant

> Exists if **DISABLE_ASSERT** defined

Description: todo assert return bool on clinet, server and editor
- Param: _cond

Replaced value:
```sqf

```
File: [host\engine.hpp at line 611](../../../Src/host/engine.hpp#L611)
## assert_client(_cond)

Type: constant

> Exists if **DEBUG** not defined

Description: 
- Param: _cond

Replaced value:
```sqf

```
File: [host\engine.hpp at line 622](../../../Src/host/engine.hpp#L622)
## __assert_error__(code,modl,line__,comp__)

Type: constant

> Exists if **DEBUG** not defined

Description: 
- Param: code
- Param: modl
- Param: line__
- Param: comp__

Replaced value:
```sqf

```
File: [host\engine.hpp at line 623](../../../Src/host/engine.hpp#L623)
## __COMMA__

Type: constant

> Exists if **DEBUG** not defined

Description: assertion


Replaced value:
```sqf

```
File: [host\engine.hpp at line 624](../../../Src/host/engine.hpp#L624)
## __THIS_FILE_REPLACE__

Type: constant

> Exists if **DEBUG** not defined

Description: 


Replaced value:
```sqf

```
File: [host\engine.hpp at line 625](../../../Src/host/engine.hpp#L625)
## __assert_string_convert(data)

Type: constant

> Exists if **DEBUG** not defined

Description: 
- Param: data

Replaced value:
```sqf

```
File: [host\engine.hpp at line 626](../../../Src/host/engine.hpp#L626)
## setLastError(data__)

Type: constant

> Exists if **EDITOR** defined

Description: 
- Param: data__

Replaced value:
```sqf
([data__] call relicta_debug_setlasterror); halt
```
File: [host\engine.hpp at line 638](../../../Src/host/engine.hpp#L638)
## setLastError(data__)

Type: constant

> Exists if **EDITOR** not defined

Description: 
- Param: data__

Replaced value:
```sqf

```
File: [host\engine.hpp at line 640](../../../Src/host/engine.hpp#L640)
## exitScope(cond)

Type: constant

Description: 
- Param: cond

Replaced value:
```sqf
if (true) exitWith {cond};
```
File: [host\engine.hpp at line 644](../../../Src/host/engine.hpp#L644)
## getCallStack()

Type: constant

Description: TODO: опционально возвращаем только первые несколько функций стека вызова
- Param: 

Replaced value:
```sqf
diag_stacktrace
```
File: [host\engine.hpp at line 646](../../../Src/host/engine.hpp#L646)
## BASIC_MOB_TYPE

Type: constant

Description: common macro


Replaced value:
```sqf
"B_Survivor_F"
```
File: [host\engine.hpp at line 652](../../../Src/host/engine.hpp#L652)
## VM_COMPILER_ADDFUNC_BINARY(name,cmd)

Type: constant

Description: Пример: VM_COMPILER_ADDFUNC_UNARY(freeExtension_impl,freeExtension) -> для вызова используем: call freeExtension_impl
- Param: name
- Param: cmd

Replaced value:
```sqf
name = compile '(_this select 0) cmd (_this select 1)'
```
File: [host\engine.hpp at line 658](../../../Src/host/engine.hpp#L658)
## VM_COMPILER_ADDFUNC_UNARY(name,cmd)

Type: constant

Description: 
- Param: name
- Param: cmd

Replaced value:
```sqf
name = compile 'cmd _this'
```
File: [host\engine.hpp at line 659](../../../Src/host/engine.hpp#L659)
## VM_COMPILER_ADDFUNC_NULAR(name,cmd)

Type: constant

Description: 
- Param: name
- Param: cmd

Replaced value:
```sqf
name = compile 'cmd'
```
File: [host\engine.hpp at line 660](../../../Src/host/engine.hpp#L660)
# init.sqf

## server_loadingState

Type: Variable

Description: 


Initial value:
```sqf
1
```
File: [host\init.sqf at line 89](../../../Src/host/init.sqf#L89)
# keyboard.hpp

## KEY_ESCAPE

Type: constant

Description: 


Replaced value:
```sqf
0x01
```
File: [host\keyboard.hpp at line 6](../../../Src/host/keyboard.hpp#L6)
## KEY_1

Type: constant

Description: 


Replaced value:
```sqf
0x02
```
File: [host\keyboard.hpp at line 7](../../../Src/host/keyboard.hpp#L7)
## KEY_2

Type: constant

Description: 


Replaced value:
```sqf
0x03
```
File: [host\keyboard.hpp at line 8](../../../Src/host/keyboard.hpp#L8)
## KEY_3

Type: constant

Description: 


Replaced value:
```sqf
0x04
```
File: [host\keyboard.hpp at line 9](../../../Src/host/keyboard.hpp#L9)
## KEY_4

Type: constant

Description: 


Replaced value:
```sqf
0x05
```
File: [host\keyboard.hpp at line 10](../../../Src/host/keyboard.hpp#L10)
## KEY_5

Type: constant

Description: 


Replaced value:
```sqf
0x06
```
File: [host\keyboard.hpp at line 11](../../../Src/host/keyboard.hpp#L11)
## KEY_6

Type: constant

Description: 


Replaced value:
```sqf
0x07
```
File: [host\keyboard.hpp at line 12](../../../Src/host/keyboard.hpp#L12)
## KEY_7

Type: constant

Description: 


Replaced value:
```sqf
0x08
```
File: [host\keyboard.hpp at line 13](../../../Src/host/keyboard.hpp#L13)
## KEY_8

Type: constant

Description: 


Replaced value:
```sqf
0x09
```
File: [host\keyboard.hpp at line 14](../../../Src/host/keyboard.hpp#L14)
## KEY_9

Type: constant

Description: 


Replaced value:
```sqf
0x0A
```
File: [host\keyboard.hpp at line 15](../../../Src/host/keyboard.hpp#L15)
## KEY_0

Type: constant

Description: 


Replaced value:
```sqf
0x0B
```
File: [host\keyboard.hpp at line 16](../../../Src/host/keyboard.hpp#L16)
## KEY_MINUS

Type: constant

Description: 


Replaced value:
```sqf
0x0C    /* - on main keyboard */
```
File: [host\keyboard.hpp at line 17](../../../Src/host/keyboard.hpp#L17)
## KEY_EQUALS

Type: constant

Description: 


Replaced value:
```sqf
0x0D
```
File: [host\keyboard.hpp at line 18](../../../Src/host/keyboard.hpp#L18)
## KEY_BACK

Type: constant

Description: 


Replaced value:
```sqf
0x0E    /* backspace */
```
File: [host\keyboard.hpp at line 19](../../../Src/host/keyboard.hpp#L19)
## KEY_TAB

Type: constant

Description: backspace


Replaced value:
```sqf
0x0F
```
File: [host\keyboard.hpp at line 20](../../../Src/host/keyboard.hpp#L20)
## KEY_Q

Type: constant

Description: 


Replaced value:
```sqf
0x10
```
File: [host\keyboard.hpp at line 21](../../../Src/host/keyboard.hpp#L21)
## KEY_W

Type: constant

Description: System Sleep


Replaced value:
```sqf
0x11
```
File: [host\keyboard.hpp at line 22](../../../Src/host/keyboard.hpp#L22)
## KEY_E

Type: constant

Description: 


Replaced value:
```sqf
0x12
```
File: [host\keyboard.hpp at line 6](../../../Src/host/keyboard.hpp#L6)
## KEY_R

Type: constant

Description: Enter on numeric keypad


Replaced value:
```sqf
0x13
```
File: [host\keyboard.hpp at line 24](../../../Src/host/keyboard.hpp#L24)
## KEY_T

Type: constant

Description: backspace


Replaced value:
```sqf
0x14
```
File: [host\keyboard.hpp at line 20](../../../Src/host/keyboard.hpp#L20)
## KEY_Y

Type: constant

Description: 


Replaced value:
```sqf
0x15
```
File: [host\keyboard.hpp at line 26](../../../Src/host/keyboard.hpp#L26)
## KEY_U

Type: constant

Description: Home on arrow keypad


Replaced value:
```sqf
0x16
```
File: [host\keyboard.hpp at line 27](../../../Src/host/keyboard.hpp#L27)
## KEY_I

Type: constant

Description: PgDn on arrow keypad


Replaced value:
```sqf
0x17
```
File: [host\keyboard.hpp at line 28](../../../Src/host/keyboard.hpp#L28)
## KEY_O

Type: constant

Description: 


Replaced value:
```sqf
0x18
```
File: [host\keyboard.hpp at line 29](../../../Src/host/keyboard.hpp#L29)
## KEY_P

Type: constant

Description: Calculator


Replaced value:
```sqf
0x19
```
File: [host\keyboard.hpp at line 30](../../../Src/host/keyboard.hpp#L30)
## KEY_LBRACKET

Type: constant

Description: 


Replaced value:
```sqf
0x1A
```
File: [host\keyboard.hpp at line 31](../../../Src/host/keyboard.hpp#L31)
## KEY_RBRACKET

Type: constant

Description: 


Replaced value:
```sqf
0x1B
```
File: [host\keyboard.hpp at line 32](../../../Src/host/keyboard.hpp#L32)
## KEY_RETURN

Type: constant

Description: 


Replaced value:
```sqf
0x1C    /* Enter on main keyboard */
```
File: [host\keyboard.hpp at line 33](../../../Src/host/keyboard.hpp#L33)
## KEY_LCONTROL

Type: constant

Description: Enter on main keyboard


Replaced value:
```sqf
0x1D
```
File: [host\keyboard.hpp at line 34](../../../Src/host/keyboard.hpp#L34)
## KEY_A

Type: constant

Description: Right Windows key


Replaced value:
```sqf
0x1E
```
File: [host\keyboard.hpp at line 35](../../../Src/host/keyboard.hpp#L35)
## KEY_S

Type: constant

Description: left Alt


Replaced value:
```sqf
0x1F
```
File: [host\keyboard.hpp at line 36](../../../Src/host/keyboard.hpp#L36)
## KEY_D

Type: constant

Description: End on arrow keypad


Replaced value:
```sqf
0x20
```
File: [host\keyboard.hpp at line 37](../../../Src/host/keyboard.hpp#L37)
## KEY_F

Type: constant

Description: 


Replaced value:
```sqf
0x21
```
File: [host\keyboard.hpp at line 38](../../../Src/host/keyboard.hpp#L38)
## KEY_G

Type: constant

Description: 


Replaced value:
```sqf
0x22
```
File: [host\keyboard.hpp at line 39](../../../Src/host/keyboard.hpp#L39)
## KEY_H

Type: constant

Description: Pause


Replaced value:
```sqf
0x23
```
File: [host\keyboard.hpp at line 40](../../../Src/host/keyboard.hpp#L40)
## KEY_J

Type: constant

Description: 


Replaced value:
```sqf
0x24
```
File: [host\keyboard.hpp at line 41](../../../Src/host/keyboard.hpp#L41)
## KEY_K

Type: constant

Description: 


Replaced value:
```sqf
0x25
```
File: [host\keyboard.hpp at line 42](../../../Src/host/keyboard.hpp#L42)
## KEY_L

Type: constant

Description: Enter on main keyboard


Replaced value:
```sqf
0x26
```
File: [host\keyboard.hpp at line 31](../../../Src/host/keyboard.hpp#L31)
## KEY_SEMICOLON

Type: constant

Description: 


Replaced value:
```sqf
0x27
```
File: [host\keyboard.hpp at line 44](../../../Src/host/keyboard.hpp#L44)
## KEY_APOSTROPHE

Type: constant

Description: 


Replaced value:
```sqf
0x28
```
File: [host\keyboard.hpp at line 45](../../../Src/host/keyboard.hpp#L45)
## KEY_GRAVE

Type: constant

Description: 


Replaced value:
```sqf
0x29    /* accent grave ~ */
```
File: [host\keyboard.hpp at line 46](../../../Src/host/keyboard.hpp#L46)
## KEY_LSHIFT

Type: constant

Description: 


Replaced value:
```sqf
0x2A
```
File: [host\keyboard.hpp at line 47](../../../Src/host/keyboard.hpp#L47)
## KEY_BACKSLASH

Type: constant

Description: 


Replaced value:
```sqf
0x2B
```
File: [host\keyboard.hpp at line 48](../../../Src/host/keyboard.hpp#L48)
## KEY_Z

Type: constant

Description: 


Replaced value:
```sqf
0x2C
```
File: [host\keyboard.hpp at line 49](../../../Src/host/keyboard.hpp#L49)
## KEY_X

Type: constant

Description: 


Replaced value:
```sqf
0x2D
```
File: [host\keyboard.hpp at line 50](../../../Src/host/keyboard.hpp#L50)
## KEY_C

Type: constant

Description: Mute


Replaced value:
```sqf
0x2E
```
File: [host\keyboard.hpp at line 51](../../../Src/host/keyboard.hpp#L51)
## KEY_V

Type: constant

Description: Media Stop


Replaced value:
```sqf
0x2F
```
File: [host\keyboard.hpp at line 52](../../../Src/host/keyboard.hpp#L52)
## KEY_B

Type: constant

Description: 


Replaced value:
```sqf
0x30
```
File: [host\keyboard.hpp at line 19](../../../Src/host/keyboard.hpp#L19)
## KEY_N

Type: constant

Description: Scroll Lock


Replaced value:
```sqf
0x31
```
File: [host\keyboard.hpp at line 54](../../../Src/host/keyboard.hpp#L54)
## KEY_M

Type: constant

Description: Web Back


Replaced value:
```sqf
0x32
```
File: [host\keyboard.hpp at line 17](../../../Src/host/keyboard.hpp#L17)
## KEY_COMMA

Type: constant

Description: 


Replaced value:
```sqf
0x33	/*	symbol <*/
```
File: [host\keyboard.hpp at line 56](../../../Src/host/keyboard.hpp#L56)
## KEY_PERIOD

Type: constant

Description: 


Replaced value:
```sqf
0x34    /* symbol >   and  . on main keyboard */
```
File: [host\keyboard.hpp at line 57](../../../Src/host/keyboard.hpp#L57)
## KEY_SLASH

Type: constant

Description: 


Replaced value:
```sqf
0x35    /* / on main keyboard */
```
File: [host\keyboard.hpp at line 58](../../../Src/host/keyboard.hpp#L58)
## KEY_RSHIFT

Type: constant

Description: 


Replaced value:
```sqf
0x36
```
File: [host\keyboard.hpp at line 59](../../../Src/host/keyboard.hpp#L59)
## KEY_MULTIPLY

Type: constant

Description: 


Replaced value:
```sqf
0x37    /* * on numeric keypad */
```
File: [host\keyboard.hpp at line 60](../../../Src/host/keyboard.hpp#L60)
## KEY_LMENU

Type: constant

Description: 


Replaced value:
```sqf
0x38    /* left Alt */
```
File: [host\keyboard.hpp at line 61](../../../Src/host/keyboard.hpp#L61)
## KEY_SPACE

Type: constant

Description: left Alt


Replaced value:
```sqf
0x39
```
File: [host\keyboard.hpp at line 62](../../../Src/host/keyboard.hpp#L62)
## KEY_CAPITAL

Type: constant

Description: 


Replaced value:
```sqf
0x3A
```
File: [host\keyboard.hpp at line 63](../../../Src/host/keyboard.hpp#L63)
## KEY_F1

Type: constant

Description: 


Replaced value:
```sqf
0x3B
```
File: [host\keyboard.hpp at line 64](../../../Src/host/keyboard.hpp#L64)
## KEY_F2

Type: constant

Description: 


Replaced value:
```sqf
0x3C
```
File: [host\keyboard.hpp at line 65](../../../Src/host/keyboard.hpp#L65)
## KEY_F3

Type: constant

Description: 


Replaced value:
```sqf
0x3D
```
File: [host\keyboard.hpp at line 66](../../../Src/host/keyboard.hpp#L66)
## KEY_F4

Type: constant

Description: 


Replaced value:
```sqf
0x3E
```
File: [host\keyboard.hpp at line 67](../../../Src/host/keyboard.hpp#L67)
## KEY_F5

Type: constant

Description: 


Replaced value:
```sqf
0x3F
```
File: [host\keyboard.hpp at line 68](../../../Src/host/keyboard.hpp#L68)
## KEY_F6

Type: constant

Description: 


Replaced value:
```sqf
0x40
```
File: [host\keyboard.hpp at line 69](../../../Src/host/keyboard.hpp#L69)
## KEY_F7

Type: constant

Description: 


Replaced value:
```sqf
0x41
```
File: [host\keyboard.hpp at line 70](../../../Src/host/keyboard.hpp#L70)
## KEY_F8

Type: constant

Description: 


Replaced value:
```sqf
0x42
```
File: [host\keyboard.hpp at line 71](../../../Src/host/keyboard.hpp#L71)
## KEY_F9

Type: constant

Description: 


Replaced value:
```sqf
0x43
```
File: [host\keyboard.hpp at line 72](../../../Src/host/keyboard.hpp#L72)
## KEY_F10

Type: constant

Description: 


Replaced value:
```sqf
0x44
```
File: [host\keyboard.hpp at line 73](../../../Src/host/keyboard.hpp#L73)
## KEY_NUMLOCK

Type: constant

Description: 


Replaced value:
```sqf
0x45
```
File: [host\keyboard.hpp at line 74](../../../Src/host/keyboard.hpp#L74)
## KEY_SCROLL

Type: constant

Description: 


Replaced value:
```sqf
0x46    /* Scroll Lock */
```
File: [host\keyboard.hpp at line 75](../../../Src/host/keyboard.hpp#L75)
## KEY_NUMPAD7

Type: constant

Description: Scroll Lock


Replaced value:
```sqf
0x47
```
File: [host\keyboard.hpp at line 76](../../../Src/host/keyboard.hpp#L76)
## KEY_NUMPAD8

Type: constant

Description: 


Replaced value:
```sqf
0x48
```
File: [host\keyboard.hpp at line 77](../../../Src/host/keyboard.hpp#L77)
## KEY_NUMPAD9

Type: constant

Description: 


Replaced value:
```sqf
0x49
```
File: [host\keyboard.hpp at line 78](../../../Src/host/keyboard.hpp#L78)
## KEY_SUBTRACT

Type: constant

Description: 


Replaced value:
```sqf
0x4A    /* - on numeric keypad */
```
File: [host\keyboard.hpp at line 79](../../../Src/host/keyboard.hpp#L79)
## KEY_NUMPAD4

Type: constant

Description: 


Replaced value:
```sqf
0x4B
```
File: [host\keyboard.hpp at line 80](../../../Src/host/keyboard.hpp#L80)
## KEY_NUMPAD5

Type: constant

Description: 


Replaced value:
```sqf
0x4C
```
File: [host\keyboard.hpp at line 81](../../../Src/host/keyboard.hpp#L81)
## KEY_NUMPAD6

Type: constant

Description: 


Replaced value:
```sqf
0x4D
```
File: [host\keyboard.hpp at line 82](../../../Src/host/keyboard.hpp#L82)
## KEY_ADD

Type: constant

Description: 


Replaced value:
```sqf
0x4E    /* + on numeric keypad */
```
File: [host\keyboard.hpp at line 83](../../../Src/host/keyboard.hpp#L83)
## KEY_NUMPAD1

Type: constant

Description: 


Replaced value:
```sqf
0x4F
```
File: [host\keyboard.hpp at line 84](../../../Src/host/keyboard.hpp#L84)
## KEY_NUMPAD2

Type: constant

Description: 


Replaced value:
```sqf
0x50
```
File: [host\keyboard.hpp at line 85](../../../Src/host/keyboard.hpp#L85)
## KEY_NUMPAD3

Type: constant

Description: 


Replaced value:
```sqf
0x51
```
File: [host\keyboard.hpp at line 86](../../../Src/host/keyboard.hpp#L86)
## KEY_NUMPAD0

Type: constant

Description: 


Replaced value:
```sqf
0x52
```
File: [host\keyboard.hpp at line 87](../../../Src/host/keyboard.hpp#L87)
## KEY_DECIMAL

Type: constant

Description: 


Replaced value:
```sqf
0x53    /* . on numeric keypad */
```
File: [host\keyboard.hpp at line 88](../../../Src/host/keyboard.hpp#L88)
## KEY_OEM_102

Type: constant

Description: 


Replaced value:
```sqf
0x56    /* < > | on UK/Germany keyboards */
```
File: [host\keyboard.hpp at line 89](../../../Src/host/keyboard.hpp#L89)
## KEY_F11

Type: constant

Description: 


Replaced value:
```sqf
0x57
```
File: [host\keyboard.hpp at line 90](../../../Src/host/keyboard.hpp#L90)
## KEY_F12

Type: constant

Description: 


Replaced value:
```sqf
0x58
```
File: [host\keyboard.hpp at line 91](../../../Src/host/keyboard.hpp#L91)
## KEY_F13

Type: constant

Description: 


Replaced value:
```sqf
0x64    /*                     (NEC PC98) */
```
File: [host\keyboard.hpp at line 92](../../../Src/host/keyboard.hpp#L92)
## KEY_F14

Type: constant

Description: 


Replaced value:
```sqf
0x65    /*                     (NEC PC98) */
```
File: [host\keyboard.hpp at line 93](../../../Src/host/keyboard.hpp#L93)
## KEY_F15

Type: constant

Description: 


Replaced value:
```sqf
0x66    /*                     (NEC PC98) */
```
File: [host\keyboard.hpp at line 94](../../../Src/host/keyboard.hpp#L94)
## KEY_KANA

Type: constant

Description: 


Replaced value:
```sqf
0x70    /* (Japanese keyboard)            */
```
File: [host\keyboard.hpp at line 95](../../../Src/host/keyboard.hpp#L95)
## KEY_ABNT_C1

Type: constant

Description: 


Replaced value:
```sqf
0x73    /* / ? on Portugese (Brazilian) keyboards */
```
File: [host\keyboard.hpp at line 96](../../../Src/host/keyboard.hpp#L96)
## KEY_CONVERT

Type: constant

Description: 


Replaced value:
```sqf
0x79    /* (Japanese keyboard)            */
```
File: [host\keyboard.hpp at line 97](../../../Src/host/keyboard.hpp#L97)
## KEY_NOCONVERT

Type: constant

Description: 


Replaced value:
```sqf
0x7B    /* (Japanese keyboard)            */
```
File: [host\keyboard.hpp at line 98](../../../Src/host/keyboard.hpp#L98)
## KEY_YEN

Type: constant

Description: 


Replaced value:
```sqf
0x7D    /* (Japanese keyboard)            */
```
File: [host\keyboard.hpp at line 99](../../../Src/host/keyboard.hpp#L99)
## KEY_ABNT_C2

Type: constant

Description: 


Replaced value:
```sqf
0x7E    /* Numpad . on Portugese (Brazilian) keyboards */
```
File: [host\keyboard.hpp at line 100](../../../Src/host/keyboard.hpp#L100)
## KEY_NUMPADEQUALS

Type: constant

Description: 


Replaced value:
```sqf
0x8D    /* = on numeric keypad (NEC PC98) */
```
File: [host\keyboard.hpp at line 101](../../../Src/host/keyboard.hpp#L101)
## KEY_PREVTRACK

Type: constant

Description: 


Replaced value:
```sqf
0x90    /* Previous Track (KEY_CIRCUMFLEX on Japanese keyboard) */
```
File: [host\keyboard.hpp at line 102](../../../Src/host/keyboard.hpp#L102)
## KEY_AT

Type: constant

Description: 


Replaced value:
```sqf
0x91    /*                     (NEC PC98) */
```
File: [host\keyboard.hpp at line 103](../../../Src/host/keyboard.hpp#L103)
## KEY_COLON

Type: constant

Description: 


Replaced value:
```sqf
0x92    /*                     (NEC PC98) */
```
File: [host\keyboard.hpp at line 104](../../../Src/host/keyboard.hpp#L104)
## KEY_UNDERLINE

Type: constant

Description: 


Replaced value:
```sqf
0x93    /*                     (NEC PC98) */
```
File: [host\keyboard.hpp at line 105](../../../Src/host/keyboard.hpp#L105)
## KEY_KANJI

Type: constant

Description: 


Replaced value:
```sqf
0x94    /* (Japanese keyboard)            */
```
File: [host\keyboard.hpp at line 106](../../../Src/host/keyboard.hpp#L106)
## KEY_STOP

Type: constant

Description: 


Replaced value:
```sqf
0x95    /*                     (NEC PC98) */
```
File: [host\keyboard.hpp at line 107](../../../Src/host/keyboard.hpp#L107)
## KEY_AX

Type: constant

Description: 


Replaced value:
```sqf
0x96    /*                     (Japan AX) */
```
File: [host\keyboard.hpp at line 108](../../../Src/host/keyboard.hpp#L108)
## KEY_UNLABELED

Type: constant

Description: 


Replaced value:
```sqf
0x97    /*                        (J3100) */
```
File: [host\keyboard.hpp at line 109](../../../Src/host/keyboard.hpp#L109)
## KEY_NEXTTRACK

Type: constant

Description: 


Replaced value:
```sqf
0x99    /* Next Track */
```
File: [host\keyboard.hpp at line 110](../../../Src/host/keyboard.hpp#L110)
## KEY_NUMPADENTER

Type: constant

Description: Next Track


Replaced value:
```sqf
0x9C    /* Enter on numeric keypad */
```
File: [host\keyboard.hpp at line 111](../../../Src/host/keyboard.hpp#L111)
## KEY_RCONTROL

Type: constant

Description: Enter on numeric keypad


Replaced value:
```sqf
0x9D
```
File: [host\keyboard.hpp at line 112](../../../Src/host/keyboard.hpp#L112)
## KEY_MUTE

Type: constant

Description: 


Replaced value:
```sqf
0xA0    /* Mute */
```
File: [host\keyboard.hpp at line 113](../../../Src/host/keyboard.hpp#L113)
## KEY_CALCULATOR

Type: constant

Description: Mute


Replaced value:
```sqf
0xA1    /* Calculator */
```
File: [host\keyboard.hpp at line 114](../../../Src/host/keyboard.hpp#L114)
## KEY_PLAYPAUSE

Type: constant

Description: Calculator


Replaced value:
```sqf
0xA2    /* Play / Pause */
```
File: [host\keyboard.hpp at line 115](../../../Src/host/keyboard.hpp#L115)
## KEY_MEDIASTOP

Type: constant

Description: 


Replaced value:
```sqf
0xA4    /* Media Stop */
```
File: [host\keyboard.hpp at line 116](../../../Src/host/keyboard.hpp#L116)
## KEY_VOLUMEDOWN

Type: constant

Description: Media Stop


Replaced value:
```sqf
0xAE    /* Volume - */
```
File: [host\keyboard.hpp at line 117](../../../Src/host/keyboard.hpp#L117)
## KEY_VOLUMEUP

Type: constant

Description: 


Replaced value:
```sqf
0xB0    /* Volume + */
```
File: [host\keyboard.hpp at line 118](../../../Src/host/keyboard.hpp#L118)
## KEY_WEBHOME

Type: constant

Description: 


Replaced value:
```sqf
0xB2    /* Web home */
```
File: [host\keyboard.hpp at line 119](../../../Src/host/keyboard.hpp#L119)
## KEY_NUMPADCOMMA

Type: constant

Description: Web home


Replaced value:
```sqf
0xB3    /* , on numeric keypad (NEC PC98) */
```
File: [host\keyboard.hpp at line 120](../../../Src/host/keyboard.hpp#L120)
## KEY_DIVIDE

Type: constant

Description: 


Replaced value:
```sqf
0xB5    /* / on numeric keypad */
```
File: [host\keyboard.hpp at line 121](../../../Src/host/keyboard.hpp#L121)
## KEY_SYSRQ

Type: constant

Description: 


Replaced value:
```sqf
0xB7
```
File: [host\keyboard.hpp at line 122](../../../Src/host/keyboard.hpp#L122)
## KEY_RMENU

Type: constant

Description: 


Replaced value:
```sqf
0xB8    /* right Alt */
```
File: [host\keyboard.hpp at line 123](../../../Src/host/keyboard.hpp#L123)
## KEY_PAUSE

Type: constant

Description: right Alt


Replaced value:
```sqf
0xC5    /* Pause */
```
File: [host\keyboard.hpp at line 124](../../../Src/host/keyboard.hpp#L124)
## KEY_HOME

Type: constant

Description: Pause


Replaced value:
```sqf
0xC7    /* Home on arrow keypad */
```
File: [host\keyboard.hpp at line 125](../../../Src/host/keyboard.hpp#L125)
## KEY_UP

Type: constant

Description: Home on arrow keypad


Replaced value:
```sqf
0xC8    /* UpArrow on arrow keypad */
```
File: [host\keyboard.hpp at line 126](../../../Src/host/keyboard.hpp#L126)
## KEY_PRIOR

Type: constant

Description: UpArrow on arrow keypad


Replaced value:
```sqf
0xC9    /* PgUp on arrow keypad */
```
File: [host\keyboard.hpp at line 127](../../../Src/host/keyboard.hpp#L127)
## KEY_LEFT

Type: constant

Description: PgUp on arrow keypad


Replaced value:
```sqf
0xCB    /* LeftArrow on arrow keypad */
```
File: [host\keyboard.hpp at line 128](../../../Src/host/keyboard.hpp#L128)
## KEY_RIGHT

Type: constant

Description: LeftArrow on arrow keypad


Replaced value:
```sqf
0xCD    /* RightArrow on arrow keypad */
```
File: [host\keyboard.hpp at line 129](../../../Src/host/keyboard.hpp#L129)
## KEY_END

Type: constant

Description: RightArrow on arrow keypad


Replaced value:
```sqf
0xCF    /* End on arrow keypad */
```
File: [host\keyboard.hpp at line 130](../../../Src/host/keyboard.hpp#L130)
## KEY_DOWN

Type: constant

Description: End on arrow keypad


Replaced value:
```sqf
0xD0    /* DownArrow on arrow keypad */
```
File: [host\keyboard.hpp at line 131](../../../Src/host/keyboard.hpp#L131)
## KEY_NEXT

Type: constant

Description: DownArrow on arrow keypad


Replaced value:
```sqf
0xD1    /* PgDn on arrow keypad */
```
File: [host\keyboard.hpp at line 110](../../../Src/host/keyboard.hpp#L110)
## KEY_INSERT

Type: constant

Description: PgDn on arrow keypad


Replaced value:
```sqf
0xD2    /* Insert on arrow keypad */
```
File: [host\keyboard.hpp at line 133](../../../Src/host/keyboard.hpp#L133)
## KEY_DELETE

Type: constant

Description: Insert on arrow keypad


Replaced value:
```sqf
0xD3    /* Delete on arrow keypad */
```
File: [host\keyboard.hpp at line 134](../../../Src/host/keyboard.hpp#L134)
## KEY_LWIN

Type: constant

Description: Delete on arrow keypad


Replaced value:
```sqf
0xDB    /* Left Windows key */
```
File: [host\keyboard.hpp at line 135](../../../Src/host/keyboard.hpp#L135)
## KEY_RWIN

Type: constant

Description: Left Windows key


Replaced value:
```sqf
0xDC    /* Right Windows key */
```
File: [host\keyboard.hpp at line 136](../../../Src/host/keyboard.hpp#L136)
## KEY_APPS

Type: constant

Description: Right Windows key


Replaced value:
```sqf
0xDD    /* AppMenu key */
```
File: [host\keyboard.hpp at line 137](../../../Src/host/keyboard.hpp#L137)
## KEY_POWER

Type: constant

Description: AppMenu key


Replaced value:
```sqf
0xDE    /* System Power */
```
File: [host\keyboard.hpp at line 138](../../../Src/host/keyboard.hpp#L138)
## KEY_SLEEP

Type: constant

Description: System Power


Replaced value:
```sqf
0xDF    /* System Sleep */
```
File: [host\keyboard.hpp at line 139](../../../Src/host/keyboard.hpp#L139)
## KEY_WAKE

Type: constant

Description: System Sleep


Replaced value:
```sqf
0xE3    /* System Wake */
```
File: [host\keyboard.hpp at line 140](../../../Src/host/keyboard.hpp#L140)
## KEY_WEBSEARCH

Type: constant

Description: System Wake


Replaced value:
```sqf
0xE5    /* Web Search */
```
File: [host\keyboard.hpp at line 141](../../../Src/host/keyboard.hpp#L141)
## KEY_WEBFAVORITES

Type: constant

Description: Web Search


Replaced value:
```sqf
0xE6    /* Web Favorites */
```
File: [host\keyboard.hpp at line 142](../../../Src/host/keyboard.hpp#L142)
## KEY_WEBREFRESH

Type: constant

Description: Web Favorites


Replaced value:
```sqf
0xE7    /* Web Refresh */
```
File: [host\keyboard.hpp at line 143](../../../Src/host/keyboard.hpp#L143)
## KEY_WEBSTOP

Type: constant

Description: Web Refresh


Replaced value:
```sqf
0xE8    /* Web Stop */
```
File: [host\keyboard.hpp at line 144](../../../Src/host/keyboard.hpp#L144)
## KEY_WEBFORWARD

Type: constant

Description: Web Stop


Replaced value:
```sqf
0xE9    /* Web Forward */
```
File: [host\keyboard.hpp at line 145](../../../Src/host/keyboard.hpp#L145)
## KEY_WEBBACK

Type: constant

Description: Web Forward


Replaced value:
```sqf
0xEA    /* Web Back */
```
File: [host\keyboard.hpp at line 146](../../../Src/host/keyboard.hpp#L146)
## KEY_MYCOMPUTER

Type: constant

Description: Web Back


Replaced value:
```sqf
0xEB    /* My Computer */
```
File: [host\keyboard.hpp at line 147](../../../Src/host/keyboard.hpp#L147)
## KEY_MAIL

Type: constant

Description: My Computer


Replaced value:
```sqf
0xEC    /* Mail */
```
File: [host\keyboard.hpp at line 148](../../../Src/host/keyboard.hpp#L148)
## KEY_MEDIASELECT

Type: constant

Description: Mail


Replaced value:
```sqf
0xED    /* Media Select */
```
File: [host\keyboard.hpp at line 149](../../../Src/host/keyboard.hpp#L149)
## KEY_BACKSPACE

Type: constant

Description: 


Replaced value:
```sqf
KEY_BACK            /* backspace */
```
File: [host\keyboard.hpp at line 152](../../../Src/host/keyboard.hpp#L152)
## KEY_NUMPADSTAR

Type: constant

Description: backspace


Replaced value:
```sqf
KEY_MULTIPLY        /* * on numeric keypad */
```
File: [host\keyboard.hpp at line 153](../../../Src/host/keyboard.hpp#L153)
## KEY_LALT

Type: constant

Description: 


Replaced value:
```sqf
KEY_LMENU           /* left Alt */
```
File: [host\keyboard.hpp at line 154](../../../Src/host/keyboard.hpp#L154)
## KEY_CAPSLOCK

Type: constant

Description: left Alt


Replaced value:
```sqf
KEY_CAPITAL         /* CapsLock */
```
File: [host\keyboard.hpp at line 155](../../../Src/host/keyboard.hpp#L155)
## KEY_NUMPADMINUS

Type: constant

Description: CapsLock


Replaced value:
```sqf
KEY_SUBTRACT        /* - on numeric keypad */
```
File: [host\keyboard.hpp at line 156](../../../Src/host/keyboard.hpp#L156)
## KEY_NUMPADPLUS

Type: constant

Description: 


Replaced value:
```sqf
KEY_ADD             /* + on numeric keypad */
```
File: [host\keyboard.hpp at line 157](../../../Src/host/keyboard.hpp#L157)
## KEY_NUMPADPERIOD

Type: constant

Description: 


Replaced value:
```sqf
KEY_DECIMAL         /* . on numeric keypad */
```
File: [host\keyboard.hpp at line 158](../../../Src/host/keyboard.hpp#L158)
## KEY_NUMPADSLASH

Type: constant

Description: 


Replaced value:
```sqf
KEY_DIVIDE          /* / on numeric keypad */
```
File: [host\keyboard.hpp at line 159](../../../Src/host/keyboard.hpp#L159)
## KEY_RALT

Type: constant

Description: 


Replaced value:
```sqf
KEY_RMENU           /* right Alt */
```
File: [host\keyboard.hpp at line 160](../../../Src/host/keyboard.hpp#L160)
## KEY_UPARROW

Type: constant

Description: right Alt


Replaced value:
```sqf
KEY_UP              /* UpArrow on arrow keypad */
```
File: [host\keyboard.hpp at line 161](../../../Src/host/keyboard.hpp#L161)
## KEY_PGUP

Type: constant

Description: UpArrow on arrow keypad


Replaced value:
```sqf
KEY_PRIOR           /* PgUp on arrow keypad */
```
File: [host\keyboard.hpp at line 162](../../../Src/host/keyboard.hpp#L162)
## KEY_LEFTARROW

Type: constant

Description: PgUp on arrow keypad


Replaced value:
```sqf
KEY_LEFT            /* LeftArrow on arrow keypad */
```
File: [host\keyboard.hpp at line 163](../../../Src/host/keyboard.hpp#L163)
## KEY_RIGHTARROW

Type: constant

Description: LeftArrow on arrow keypad


Replaced value:
```sqf
KEY_RIGHT           /* RightArrow on arrow keypad */
```
File: [host\keyboard.hpp at line 164](../../../Src/host/keyboard.hpp#L164)
## KEY_DOWNARROW

Type: constant

Description: RightArrow on arrow keypad


Replaced value:
```sqf
KEY_DOWN            /* DownArrow on arrow keypad */
```
File: [host\keyboard.hpp at line 165](../../../Src/host/keyboard.hpp#L165)
## KEY_PGDN

Type: constant

Description: DownArrow on arrow keypad


Replaced value:
```sqf
KEY_NEXT            /* PgDn on arrow keypad */
```
File: [host\keyboard.hpp at line 166](../../../Src/host/keyboard.hpp#L166)
## KEY_CIRCUMFLEX

Type: constant

Description: 


Replaced value:
```sqf
KEY_PREVTRACK       /* Japanese keyboard */
```
File: [host\keyboard.hpp at line 169](../../../Src/host/keyboard.hpp#L169)
## MOUSE_LEFT

Type: constant

Description: Japanese keyboard


Replaced value:
```sqf
0
```
File: [host\keyboard.hpp at line 173](../../../Src/host/keyboard.hpp#L173)
## MOUSE_RIGHT

Type: constant

Description: 


Replaced value:
```sqf
1
```
File: [host\keyboard.hpp at line 174](../../../Src/host/keyboard.hpp#L174)
## MOUSE_MIDDLE

Type: constant

Description: 


Replaced value:
```sqf
2
```
File: [host\keyboard.hpp at line 175](../../../Src/host/keyboard.hpp#L175)
# memory.hpp

## size_ptr

Type: constant

Description: 


Replaced value:
```sqf
8
```
File: [host\memory.hpp at line 8](../../../Src/host/memory.hpp#L8)
## size_float

Type: constant

Description: 


Replaced value:
```sqf
4
```
File: [host\memory.hpp at line 9](../../../Src/host/memory.hpp#L9)
## size_bool

Type: constant

Description: 


Replaced value:
```sqf
1
```
File: [host\memory.hpp at line 10](../../../Src/host/memory.hpp#L10)
## size_array

Type: constant

Description: 


Replaced value:
```sqf
size_ptr
```
File: [host\memory.hpp at line 12](../../../Src/host/memory.hpp#L12)
## size_ptr_object

Type: constant

Description: 


Replaced value:
```sqf
size_ptr
```
File: [host\memory.hpp at line 13](../../../Src/host/memory.hpp#L13)
## sizeof(var)

Type: constant

Description: 4 for x32*/
- Param: var

Replaced value:
```sqf
\
((var) call { \
	if (_this isEqualType true) exitWith {1}; \
	if (_this isEqualType 0) exitWith {4}; \
	if (_this isEqualType "") exitWith {count _this}; \
	size_ptr \
}) 
```
File: [host\memory.hpp at line 16](../../../Src/host/memory.hpp#L16)
## obj_sizeof(ref)

Type: constant

Description: 
- Param: ref

Replaced value:
```sqf
\
((ref) call { \
	\
	private _size = size_ptr; \
	\
	if (_this in [locationnull,objnull]) exitWith {_size}; \
	\
	private _gtp = { \
		if (_this isEqualType true) exitWith {1}; \
		if (_this isEqualType 0) exitWith {4}; \
		if (_this isEqualType "") exitWith {count _this}; \
		if (_this isequalType []) exitWith { \
			\
			private _size = size_ptr; \
			{ \
				MOD(_size,+ sizeof(_x)); \
			} foreach _this; \
			\
			_size \
		}; \
		if (_this isEqualType {}) exitWith { \
			size_ptr \
		};\
		size_ptr \
	};\
	\
	{\
		MOD(_size,+ ((_this getvariable _x) call _gtp));\
	} foreach allVariables _this;\
	\
	_size\
})
```
File: [host\memory.hpp at line 26](../../../Src/host/memory.hpp#L26)
# module.hpp

## moduleName

Type: constant

Description: 


Replaced value:
```sqf
common
```
File: [host\module.hpp at line 8](../../../Src/host/module.hpp#L8)
## ___fullmodulename(var)

Type: constant

Description: 
- Param: var

Replaced value:
```sqf
moduleName##_##var
```
File: [host\module.hpp at line 10](../../../Src/host/module.hpp#L10)
## mFunction(name)

Type: constant

Description: 
- Param: name

Replaced value:
```sqf
___fullmodulename(name) = 
```
File: [host\module.hpp at line 12](../../../Src/host/module.hpp#L12)
## mVariable(name)

Type: constant

Description: 
- Param: name

Replaced value:
```sqf
___fullmodulename(name)
```
File: [host\module.hpp at line 14](../../../Src/host/module.hpp#L14)
## mCallFunc(name)

Type: constant

Description: 
- Param: name

Replaced value:
```sqf
call ___fullmodulename(name)
```
File: [host\module.hpp at line 16](../../../Src/host/module.hpp#L16)
## mGetVar(name)

Type: constant

Description: 
- Param: name

Replaced value:
```sqf
___fullmodulename(name)
```
File: [host\module.hpp at line 18](../../../Src/host/module.hpp#L18)
## mSetVar(name)

Type: constant

Description: 
- Param: name

Replaced value:
```sqf
___fullmodulename(name)
```
File: [host\module.hpp at line 20](../../../Src/host/module.hpp#L20)
# oop.hpp

## PROTOTYPE_VAR_NAME

Type: constant

Description: group: macro common


Replaced value:
```sqf
"proto"
```
File: [host\oop.hpp at line 9](../../../Src/host/oop.hpp#L9)
## TYPE_SUPER_BASE

Type: constant

Description: 


Replaced value:
```sqf
"<superbase>"
```
File: [host\oop.hpp at line 10](../../../Src/host/oop.hpp#L10)
## createObj

Type: constant

Description: 


Replaced value:
```sqf
(createLocation ["cba_namespacedummy",[100,100,100],0,0])
```
File: [host\oop.hpp at line 12](../../../Src/host/oop.hpp#L12)
## createNetObj

Type: constant

Description: 


Replaced value:
```sqf
(createSimpleObject ["CBA_NamespaceDummy", [100, 100, 100]])
```
File: [host\oop.hpp at line 13](../../../Src/host/oop.hpp#L13)
## deleteObj

Type: constant

Description: 


Replaced value:
```sqf
deleteLocation
```
File: [host\oop.hpp at line 14](../../../Src/host/oop.hpp#L14)
## nullPtr

Type: constant

Description: 


Replaced value:
```sqf
locationnull
```
File: [host\oop.hpp at line 16](../../../Src/host/oop.hpp#L16)
## __testSyntaxClass

Type: constant

> Exists if **EDITOR** defined

Description: 


Replaced value:
```sqf
__classcandef = isnil{_class}; if (!__classcandef) exitWith {errorformat("Syntax error - keyword 'endclass' not found in (%1)",_class); setLastError(format vec2("Syntax error - keyword 'endclass' not found in (%1)",_class));};
```
File: [host\oop.hpp at line 19](../../../Src/host/oop.hpp#L19)
## __testSyntaxClass

Type: constant

> Exists if **EDITOR** not defined

Description: 


Replaced value:
```sqf

```
File: [host\oop.hpp at line 21](../../../Src/host/oop.hpp#L21)
## createObj

Type: constant

> Exists if **_SQFVM** defined

Description: 


Replaced value:
```sqf
(call { \
		if (isnil "_class") then { \
			(customnamespace__ ("runtime_object<"+ ((round random 999999999999) Tofixed 0) + ">")) \
		} else { \
			(customnamespace__ (_class + "runtime_type<"+ ((round random 999999999999) Tofixed 0) + ">")) \
		}; \
	})
```
File: [host\oop.hpp at line 28](../../../Src/host/oop.hpp#L28)
## vm_throw(ctx)

Type: constant

> Exists if **_SQFVM** defined

Description: 
- Param: ctx

Replaced value:
```sqf
vm_lastError = ctx; throw vm_lastError;
```
File: [host\oop.hpp at line 36](../../../Src/host/oop.hpp#L36)
## setName

Type: constant

> Exists if **_SQFVM** defined

Description: 


Replaced value:
```sqf
;
```
File: [host\oop.hpp at line 38](../../../Src/host/oop.hpp#L38)
## vm_throw(ctx)

Type: constant

> Exists if **_SQFVM** not defined

Description: 
- Param: ctx

Replaced value:
```sqf

```
File: [host\oop.hpp at line 41](../../../Src/host/oop.hpp#L41)
## class(name)

Type: constant

Description: TODO update craft class list
- Param: name

Replaced value:
```sqf
_decl_info___ = [__FILE__,__LINE__ + 1]; __testSyntaxClass \
	private ["_class","_mother","_mem_name","_lastIndex","_fields","_methods"]; \
	_class = #name; _mother = "object"; \
	p_table_allclassnames pushback _class; \
	_fields = []; _methods = []; _attributes = []; _autoref = []; \
	_editor_attrs_cls = []; \
	call pc_oop_declareClassAttr; \
	_editor_next_attr = []; _editor_attrs_f = []; _editor_attrs_m = []; \
	_classmet_declinfo = createHashMap; \
	pt_##name = createObj; private _pt_obj = pt_##name;
```
File: [host\oop.hpp at line 46](../../../Src/host/oop.hpp#L46)
## __class_noStrName(name)

Type: constant

Description: создание типа по строке. Нужно для генерации классов
- Param: name

Replaced value:
```sqf
_decl_info___ = [__FILE__,__LINE__ + 1]; __testSyntaxClass \
	private ["_class","_mother","_mem_name","_lastIndex","_fields","_methods"]; \
	_class = name; _mother = "object"; \
	p_table_allclassnames pushback _class;\
	_fields = []; _methods = []; _attributes = []; _autoref = []; \
	_editor_attrs_cls = []; \
	call pc_oop_declareClassAttr; \
	_editor_next_attr = []; _editor_attrs_f = []; _editor_attrs_m = []; \
	_classmet_declinfo = createHashMap; \
	missionNamespace setVariable ["pt_"+_class,createObj]; private _pt_obj = missionNamespace getVariable ("pt_"+_class);
```
File: [host\oop.hpp at line 58](../../../Src/host/oop.hpp#L58)
## static_class(name)

Type: constant

Description: 
- Param: name

Replaced value:
```sqf
class(name) _decl_info___ = [__FILE__,__LINE__ + 1]; \
	name = _pt_obj;
```
File: [host\oop.hpp at line 69](../../../Src/host/oop.hpp#L69)
## endclass

Type: constant

Description: 


Replaced value:
```sqf
[__FILE__,__LINE__] call pc_oop_declareEOC; \
			p_table_inheritance pushback [_class,_mother]; __postclassVM \
	_pt_obj setName format[pc_oop_carr_tntps select is3DEN,_class]; \
	_pt_obj setvariable ['__fields',_fields]; \
	_pt_obj setvariable ['__methods',_methods]; \
	_pt_obj setvariable ['__motherClass',_mother]; \
	_pt_obj setVariable ['__motherObject',nullPtr]; \
	_pt_obj setVariable ['__childList',[]]; \
	_pt_obj setvariable ['__inhlist',[]]; \
	_pt_obj setvariable ['__instances',0];\
	_pt_obj setvariable ["classname",_class]; \
	_pt_obj setvariable ["__attributes",_attributes]; \
	_pt_obj setvariable ["__autoref",_autoref]; \
	call pc_oop_declareMemAttrs; \
	_pt_obj setvariable ["__decl_info__",_decl_info___]; \
	call pc_oop_postInitClass;
```
File: [host\oop.hpp at line 73](../../../Src/host/oop.hpp#L73)
## extends(child)

Type: constant

Description: 
- Param: child

Replaced value:
```sqf
_mother = #child;
```
File: [host\oop.hpp at line 90](../../../Src/host/oop.hpp#L90)
## __extends_noStrName(child)

Type: constant

Description: 
- Param: child

Replaced value:
```sqf
_mother = child;
```
File: [host\oop.hpp at line 91](../../../Src/host/oop.hpp#L91)
## attribute(name)

Type: constant

Description: attributes system
- Param: name

Replaced value:
```sqf
_attributes pushBack ['name',[]];
```
File: [host\oop.hpp at line 95](../../../Src/host/oop.hpp#L95)
## attributeParams(name,params)

Type: constant

Description: 
- Param: name
- Param: params

Replaced value:
```sqf
_attributes pushBack ['name',[params]];
```
File: [host\oop.hpp at line 97](../../../Src/host/oop.hpp#L97)
## editor_attribute(key_s)

Type: constant

> Exists if **EDITOR** defined

Description: editor_attribute("atrname")
- Param: key_s

Replaced value:
```sqf
_editor_next_attr pushBack [key_s];
```
File: [host\oop.hpp at line 103](../../../Src/host/oop.hpp#L103)
## editor_attribute(key_s)

Type: constant

> Exists if **EDITOR** not defined

Description: editor_attribute("atrname")
- Param: key_s

Replaced value:
```sqf

```
File: [host\oop.hpp at line 106](../../../Src/host/oop.hpp#L106)
## autoref

Type: constant

Description: use this macro for automatic reference cleanup: autoref var(someobject,nullPtr);


Replaced value:
```sqf
_isAutoRefUse = true;
```
File: [host\oop.hpp at line 110](../../../Src/host/oop.hpp#L110)
## const

Type: constant

Description: const modif. Create const inside type: const var(PI,3.14);


Replaced value:
```sqf
_isConstant = true;
```
File: [host\oop.hpp at line 114](../../../Src/host/oop.hpp#L114)
## __set_const_value(var,val)

Type: constant

Description: 
- Param: var
- Param: val

Replaced value:
```sqf
_pt_obj setvariable ['cst_##var',val]
```
File: [host\oop.hpp at line 115](../../../Src/host/oop.hpp#L115)
## __internal_flag_processor(flagname,act)

Type: constant

Description: 
- Param: flagname
- Param: act

Replaced value:
```sqf
if (!isnil 'flagname') then {act; flagname = nil}
```
File: [host\oop.hpp at line 117](../../../Src/host/oop.hpp#L117)
## var(name,value)

Type: constant

Description: Вычисляет значения поля на этапе компиляции
- Param: name
- Param: value

Replaced value:
```sqf
\
	_mem_name = tolower #name ; \
	_lastIndex = _fields pushback [_mem_name,'value']; \
	call pc_oop_handleAttrF;
```
File: [host\oop.hpp at line 119](../../../Src/host/oop.hpp#L119)
## pair(key,val)

Type: constant

Description: 
- Param: key
- Param: val

Replaced value:
```sqf
[key,val]
```
File: [host\oop.hpp at line 131](../../../Src/host/oop.hpp#L131)
## varpair(name,value)

Type: constant

Description: 
- Param: name
- Param: value

Replaced value:
```sqf
\
	_mem_name = tolower #name ; \
	_lastIndex = _fields pushback [_mem_name,"createHashMapFromArray [" + ('value' splitString (";"+toString[9,13,10]) joinString ",") + "]"]; \
	call pc_oop_handleAttrF;
```
File: [host\oop.hpp at line 132](../../../Src/host/oop.hpp#L132)
## __var_noStrName(name,value)

Type: constant

Description: 
- Param: name
- Param: value

Replaced value:
```sqf
\
	_mem_name = tolower name ; \
	_lastIndex = _fields pushback [_mem_name,'value']; \
	call pc_oop_handleAttrF;
```
File: [host\oop.hpp at line 137](../../../Src/host/oop.hpp#L137)
## var_inlinevalue(name,value)

Type: constant

Description: Вычисляет значения поля на этапе компиляции
- Param: name
- Param: value

Replaced value:
```sqf
\
	_mem_name = tolower #name ; \
	_lastIndex = _fields pushback [_mem_name,value]; \
	call pc_oop_handleAttrF;
```
File: [host\oop.hpp at line 143](../../../Src/host/oop.hpp#L143)
## net_use

Type: constant

Description: 


Replaced value:
```sqf
_netuse = true;
```
File: [host\oop.hpp at line 148](../../../Src/host/oop.hpp#L148)
## var_num(name)

Type: constant

Description: 
- Param: name

Replaced value:
```sqf
var(name,0)
```
File: [host\oop.hpp at line 150](../../../Src/host/oop.hpp#L150)
## var_str(name)

Type: constant

Description: 
- Param: name

Replaced value:
```sqf
var(name,"")
```
File: [host\oop.hpp at line 151](../../../Src/host/oop.hpp#L151)
## var_bool(name)

Type: constant

Description: 
- Param: name

Replaced value:
```sqf
var(name,false)
```
File: [host\oop.hpp at line 152](../../../Src/host/oop.hpp#L152)
## var_array(name)

Type: constant

Description: 
- Param: name

Replaced value:
```sqf
var(name,[])
```
File: [host\oop.hpp at line 153](../../../Src/host/oop.hpp#L153)
## var_obj(name)

Type: constant

Description: 
- Param: name

Replaced value:
```sqf
var(name,objnull)
```
File: [host\oop.hpp at line 154](../../../Src/host/oop.hpp#L154)
## var_vobj(name)

Type: constant

Description: 
- Param: name

Replaced value:
```sqf
var(name,locationnull)
```
File: [host\oop.hpp at line 155](../../../Src/host/oop.hpp#L155)
## var_hashmap(name)

Type: constant

Description: 
- Param: name

Replaced value:
```sqf
var(name,createHashMap)
```
File: [host\oop.hpp at line 156](../../../Src/host/oop.hpp#L156)
## func(name)

Type: constant

Description: #define var_multi(defaultvalue)
- Param: name

Replaced value:
```sqf
_mem_name = #name; _classmet_declinfo set [_mem_name,__FILE__ + "?" + (str __LINE__)]; \
	_lastIndex = _methods pushback [_mem_name]; \
	_propOverride = _methods findIf {(_x select 0) == _mem_name}; \
	if (_propOverride != -1) then {_methods deleteAt _lastIndex; _methods set [_propOverride,[_mem_name]]; _lastIndex = _propOverride}; \
	call pc_oop_handleAttrM; \
	(_methods select _lastIndex) pushback
```
File: [host\oop.hpp at line 160](../../../Src/host/oop.hpp#L160)
## __func_noStrName(name)

Type: constant

Description: 
- Param: name

Replaced value:
```sqf
_mem_name = name; _classmet_declinfo set [_mem_name,__FILE__ + "?" + (str __LINE__)]; \
	_lastIndex = _methods pushback [_mem_name]; \
	call pc_oop_handleAttrM; \
	(_methods select _lastIndex) pushback
```
File: [host\oop.hpp at line 167](../../../Src/host/oop.hpp#L167)
## verbList(strlist,motherObj)

Type: constant

Description: verbList()
- Param: strlist
- Param: motherObj

Replaced value:
```sqf
_nCode = 'objParams(); _outArr append ' + (strlist call verbs_parse_strToListOfNum) + '; callSuper(motherObj,getVerbs)'; func(getVerbs) (compile _nCode)
```
File: [host\oop.hpp at line 173](../../../Src/host/oop.hpp#L173)
## verbListOverride(strlist)

Type: constant

Description: 
- Param: strlist

Replaced value:
```sqf
_nCode = 'objParams(); _outArr append ' + (strlist call verbs_parse_strToListOfNum) + ';'; func(getVerbs) (compile _nCode)
```
File: [host\oop.hpp at line 175](../../../Src/host/oop.hpp#L175)
## getter_func(name,do)

Type: constant

Description: 
- Param: name
- Param: do

Replaced value:
```sqf
func(name) {objParams(); do }
```
File: [host\oop.hpp at line 178](../../../Src/host/oop.hpp#L178)
## getterconst_func(name,do)

Type: constant

Description: нет траты памяти на параметризацию. Нужно для константных значений (массивов и строк)
- Param: name
- Param: do

Replaced value:
```sqf
func(name) { do }
```
File: [host\oop.hpp at line 181](../../../Src/host/oop.hpp#L181)
## getset_func(name,getcode,setcode)

Type: constant

Description: 
- Param: name
- Param: getcode
- Param: setcode

Replaced value:
```sqf
_getcode = getcode; _setcode = setcode; __func_noStrName('get' + 'name') _getcode; __func_noStrName('set' + 'name') _setcode
```
File: [host\oop.hpp at line 183](../../../Src/host/oop.hpp#L183)
## simpleGet(getcode)

Type: constant

Description: 
- Param: getcode

Replaced value:
```sqf
{objParams(); getcode }
```
File: [host\oop.hpp at line 185](../../../Src/host/oop.hpp#L185)
## simpleSet(setcode)

Type: constant

Description: 
- Param: setcode

Replaced value:
```sqf
{objParams_1(_value); setcode }
```
File: [host\oop.hpp at line 186](../../../Src/host/oop.hpp#L186)
## value

Type: constant

Description: 


Replaced value:
```sqf
_value
```
File: [host\oop.hpp at line 187](../../../Src/host/oop.hpp#L187)
## abstract_func(name)

Type: constant

Description: TODO поменять местами абстракт и прото
- Param: name

Replaced value:
```sqf
func(name) {}; private _reqImpl = format['[OOP]:    <%1::%2> Method requires implementation (%3)',_class,#name,SHORT_PATH]; warning(_reqImpl);
```
File: [host\oop.hpp at line 191](../../../Src/host/oop.hpp#L191)
## proto_func(name)

Type: constant

Description: 
- Param: name

Replaced value:
```sqf
func(name) {}
```
File: [host\oop.hpp at line 192](../../../Src/host/oop.hpp#L192)
## new(type)

Type: constant

Description: instansing and deleting
- Param: type

Replaced value:
```sqf
(call (pt_##type getvariable "__instance"))
```
File: [host\oop.hpp at line 195](../../../Src/host/oop.hpp#L195)
## newParams(type,Params)

Type: constant

Description: 
- Param: type
- Param: Params

Replaced value:
```sqf
((Params) call (pt_##type getvariable "__instance"))
```
File: [host\oop.hpp at line 196](../../../Src/host/oop.hpp#L196)
## delete(ref)

Type: constant

Description: 
- Param: ref

Replaced value:
```sqf
(ref) call oop_deleteObject
```
File: [host\oop.hpp at line 14](../../../Src/host/oop.hpp#L14)
## instantiate(strType)

Type: constant

Description: 
- Param: strType

Replaced value:
```sqf
(call ((missionNamespace getVariable ("pt_" + (strType))) getvariable '__instance'))
```
File: [host\oop.hpp at line 198](../../../Src/host/oop.hpp#L198)
## instantiateParams(strType,Params)

Type: constant

Description: 
- Param: strType
- Param: Params

Replaced value:
```sqf
((Params) call ((missionNamespace getVariable ("pt_" + (strType))) getvariable '__instance'))
```
File: [host\oop.hpp at line 199](../../../Src/host/oop.hpp#L199)
## ctxParams

Type: constant

Description: Внутренние параметры, переданные через new


Replaced value:
```sqf
_internalParams
```
File: [host\oop.hpp at line 202](../../../Src/host/oop.hpp#L202)
## sizeOf(obj)

Type: constant

Description: 
- Param: obj

Replaced value:
```sqf
obj call oop_getobjsize
```
File: [host\oop.hpp at line 204](../../../Src/host/oop.hpp#L204)
## getObjectsTypeOf(type)

Type: constant

Description: Получает наследников данного типа
- Param: type

Replaced value:
```sqf
([#type,false] call oop_getinhlist)
```
File: [host\oop.hpp at line 207](../../../Src/host/oop.hpp#L207)
## getAllObjectsTypeOf(type)

Type: constant

Description: Получает ВСЕХ наследников от этого типа (глубокое наследование)
- Param: type

Replaced value:
```sqf
([#type,true] call oop_getinhlist)
```
File: [host\oop.hpp at line 209](../../../Src/host/oop.hpp#L209)
## getObjectsTypeOfStr(type)

Type: constant

Description: строковый эквивалент
- Param: type

Replaced value:
```sqf
([type,false] call oop_getinhlist)
```
File: [host\oop.hpp at line 211](../../../Src/host/oop.hpp#L211)
## getAllObjectsTypeOfStr(type)

Type: constant

Description: 
- Param: type

Replaced value:
```sqf
([type,true] call oop_getinhlist)
```
File: [host\oop.hpp at line 212](../../../Src/host/oop.hpp#L212)
## callSuper(superclass,metname)

Type: constant

Description: При переопределении изменить и в крафтовых классах
- Param: superclass
- Param: metname

Replaced value:
```sqf
call ( pt_##superclass getVariable #metname )
```
File: [host\oop.hpp at line 218](../../../Src/host/oop.hpp#L218)
## super()

Type: constant

Description: 
- Param: 

Replaced value:
```sqf
(__BASECALLFLAG__)
```
File: [host\oop.hpp at line 220](../../../Src/host/oop.hpp#L220)
## this

Type: constant

Description: Parameters


Replaced value:
```sqf
_thisobj
```
File: [host\oop.hpp at line 223](../../../Src/host/oop.hpp#L223)
## updateParams()

Type: constant

Description: 
- Param: 

Replaced value:
```sqf
private this = (_this select 0)
```
File: [host\oop.hpp at line 225](../../../Src/host/oop.hpp#L225)
## STD_UPDATE_DELAY

Type: constant

Description: частота вызова каждого объектного апдейта (не менять)


Replaced value:
```sqf
1
```
File: [host\oop.hpp at line 228](../../../Src/host/oop.hpp#L228)
## startSelfUpdate(method)

Type: constant

Description: 
- Param: method

Replaced value:
```sqf
startUpdateParams(getSelfFunc(method),STD_UPDATE_DELAY,this)
```
File: [host\oop.hpp at line 230](../../../Src/host/oop.hpp#L230)
## startObjUpdate(obj,method)

Type: constant

Description: 
- Param: obj
- Param: method

Replaced value:
```sqf
startUpdateParams(getFunc(obj,method),STD_UPDATE_DELAY,obj)
```
File: [host\oop.hpp at line 231](../../../Src/host/oop.hpp#L231)
## startSelfUpdateWithDelay(method,del)

Type: constant

Description: 
- Param: method
- Param: del

Replaced value:
```sqf
startUpdateParams(getSelfFunc(method),del,this)
```
File: [host\oop.hpp at line 233](../../../Src/host/oop.hpp#L233)
## startObjUpdateWithDelay(obj,method,del)

Type: constant

Description: 
- Param: obj
- Param: method
- Param: del

Replaced value:
```sqf
startUpdateParams(getFunc(obj,method),del,obj)
```
File: [host\oop.hpp at line 234](../../../Src/host/oop.hpp#L234)
## setParam(idx,val)

Type: constant

Description: 
- Param: idx
- Param: val

Replaced value:
```sqf
_this set [idx,val]
```
File: [host\oop.hpp at line 236](../../../Src/host/oop.hpp#L236)
## objParams()

Type: constant

Description: 
- Param: 

Replaced value:
```sqf
private this = _this
```
File: [host\oop.hpp at line 238](../../../Src/host/oop.hpp#L238)
## objParams_1(a)

Type: constant

Description: 
- Param: a

Replaced value:
```sqf
params ['this', #a ]
```
File: [host\oop.hpp at line 240](../../../Src/host/oop.hpp#L240)
## objParams_1_nostr(a)

Type: constant

Description: 
- Param: a

Replaced value:
```sqf
params ['this', a ]
```
File: [host\oop.hpp at line 241](../../../Src/host/oop.hpp#L241)
## objParams_2(a,b)

Type: constant

Description: 
- Param: a
- Param: b

Replaced value:
```sqf
params ['this', #a , #b]
```
File: [host\oop.hpp at line 242](../../../Src/host/oop.hpp#L242)
## objParams_2_nostr(a,b)

Type: constant

Description: 
- Param: a
- Param: b

Replaced value:
```sqf
params ['this', a , b]
```
File: [host\oop.hpp at line 243](../../../Src/host/oop.hpp#L243)
## objParams_3(a,b,c)

Type: constant

Description: 
- Param: a
- Param: b
- Param: c

Replaced value:
```sqf
params ['this', #a , #b , #c]
```
File: [host\oop.hpp at line 245](../../../Src/host/oop.hpp#L245)
## objParams_4(a,b,c,d)

Type: constant

Description: 
- Param: a
- Param: b
- Param: c
- Param: d

Replaced value:
```sqf
params ['this', #a , #b , #c , #d]
```
File: [host\oop.hpp at line 246](../../../Src/host/oop.hpp#L246)
## objParams_5(a,b,c,d,e)

Type: constant

Description: 
- Param: a
- Param: b
- Param: c
- Param: d
- Param: e

Replaced value:
```sqf
params ['this', #a , #b , #c , #d , #e]
```
File: [host\oop.hpp at line 247](../../../Src/host/oop.hpp#L247)
## objParams_6(a,b,c,d,e,f)

Type: constant

Description: 
- Param: a
- Param: b
- Param: c
- Param: d
- Param: e
- Param: f

Replaced value:
```sqf
params ['this', #a , #b , #c , #d , #e , #f]
```
File: [host\oop.hpp at line 248](../../../Src/host/oop.hpp#L248)
## setprop(obj,func,val)

Type: constant

Description: 
- Param: obj
- Param: func
- Param: val

Replaced value:
```sqf
([obj,val] call ((obj) getvariable PROTOTYPE_VAR_NAME getvariable ('set##func')))*/
```
File: [host\oop.hpp at line 276](../../../Src/host/oop.hpp#L276)
## privateCall(func)

Type: constant

Description: calling private methods
- Param: func

Replaced value:
```sqf
(call (this getvariable PROTOTYPE_VAR_NAME getvariable #func))
```
File: [host\oop.hpp at line 280](../../../Src/host/oop.hpp#L280)
## getSelf(name)

Type: constant

Description: 
- Param: name

Replaced value:
```sqf
(this getvariable #name)
```
File: [host\oop.hpp at line 282](../../../Src/host/oop.hpp#L282)
## setSelf(name,val)

Type: constant

Description: 
- Param: name
- Param: val

Replaced value:
```sqf
this setvariable [#name,val]
```
File: [host\oop.hpp at line 283](../../../Src/host/oop.hpp#L283)
## modSelf(name,val)

Type: constant

Description: 
- Param: name
- Param: val

Replaced value:
```sqf
setSelf(name,getSelf(name) val)
```
File: [host\oop.hpp at line 284](../../../Src/host/oop.hpp#L284)
## initSelf(name,_initial)

Type: constant

Description: 
- Param: name
- Param: _initial

Replaced value:
```sqf
(if ISNIL{getSelf(name)}then{setSelf(name,_initial);_initial}else{getSelf(name)})
```
File: [host\oop.hpp at line 285](../../../Src/host/oop.hpp#L285)
## getSelfReflect(name)

Type: constant

Description: 
- Param: name

Replaced value:
```sqf
(this getvariable name)
```
File: [host\oop.hpp at line 287](../../../Src/host/oop.hpp#L287)
## setSelfReflect(name,val)

Type: constant

Description: 
- Param: name
- Param: val

Replaced value:
```sqf
this setvariable [name,val]
```
File: [host\oop.hpp at line 288](../../../Src/host/oop.hpp#L288)
## modSelfReflect(name,val)

Type: constant

Description: 
- Param: name
- Param: val

Replaced value:
```sqf
setSelfReflect(name,getSelfReflect(name) val)
```
File: [host\oop.hpp at line 289](../../../Src/host/oop.hpp#L289)
## callSelf(func)

Type: constant

Description: Встраивает параметры в системный вызов метода
- Param: func

Replaced value:
```sqf
(this call (this getvariable PROTOTYPE_VAR_NAME getvariable #func))
```
File: [host\oop.hpp at line 291](../../../Src/host/oop.hpp#L291)
## callSelfAfter(func,time)

Type: constant

Description: 
- Param: func
- Param: time

Replaced value:
```sqf
[this getVariable PROTOTYPE_VAR_NAME getVariable #func,this,time] call CBA_fnc_waitAndExecute
```
File: [host\oop.hpp at line 292](../../../Src/host/oop.hpp#L292)
## callSelfAfterParams(func,time,parms)

Type: constant

Description: 
- Param: func
- Param: time
- Param: parms

Replaced value:
```sqf
[this getVariable PROTOTYPE_VAR_NAME getVariable #func,[this,parms],time] call CBA_fnc_waitAndExecute
```
File: [host\oop.hpp at line 293](../../../Src/host/oop.hpp#L293)
## callSelfParams(func,parms)

Type: constant

Description: 
- Param: func
- Param: parms

Replaced value:
```sqf
([this,parms] call (this getvariable PROTOTYPE_VAR_NAME getvariable #func))
```
File: [host\oop.hpp at line 294](../../../Src/host/oop.hpp#L294)
## callSelfParamsInline(func,parms)

Type: constant

Description: 
- Param: func
- Param: parms

Replaced value:
```sqf
(([this]+(parms)) call (this getvariable PROTOTYPE_VAR_NAME getvariable #func))
```
File: [host\oop.hpp at line 295](../../../Src/host/oop.hpp#L295)
## callSelfReflect(func)

Type: constant

Description: Встраивает параметры в системный вызов метода
- Param: func

Replaced value:
```sqf
(this call (this getvariable PROTOTYPE_VAR_NAME getvariable func))
```
File: [host\oop.hpp at line 297](../../../Src/host/oop.hpp#L297)
## callSelfReflectParams(func,parms)

Type: constant

Description: Встраивает параметры в системный вызов метода
- Param: func
- Param: parms

Replaced value:
```sqf
([this,parms] call (this getvariable PROTOTYPE_VAR_NAME getvariable func))
```
File: [host\oop.hpp at line 298](../../../Src/host/oop.hpp#L298)
## callSelfReflectParamsInline(func,parms)

Type: constant

Description: Встраивает параметры в системный вызов метода
- Param: func
- Param: parms

Replaced value:
```sqf
(([this]+(parms)) call (this getvariable PROTOTYPE_VAR_NAME getvariable func))
```
File: [host\oop.hpp at line 300](../../../Src/host/oop.hpp#L300)
## getSelfFunc(func)

Type: constant

Description: 
- Param: func

Replaced value:
```sqf
(this getvariable PROTOTYPE_VAR_NAME getvariable (#func))
```
File: [host\oop.hpp at line 302](../../../Src/host/oop.hpp#L302)
## getSelfFuncReflect(func)

Type: constant

Description: 
- Param: func

Replaced value:
```sqf
(this getvariable PROTOTYPE_VAR_NAME getvariable (func))
```
File: [host\oop.hpp at line 303](../../../Src/host/oop.hpp#L303)
## getSelfProp(func)

Type: constant

Description: 
- Param: func

Replaced value:
```sqf
(this call (this getvariable PROTOTYPE_VAR_NAME getvariable 'get##func'))
```
File: [host\oop.hpp at line 305](../../../Src/host/oop.hpp#L305)
## setSelfProp(func,val)

Type: constant

Description: 
- Param: func
- Param: val

Replaced value:
```sqf
[this,val] call (this getvariable PROTOTYPE_VAR_NAME getvariable 'set##func')
```
File: [host\oop.hpp at line 306](../../../Src/host/oop.hpp#L306)
## callFunc(obj,func)

Type: constant

Description: external access
- Param: obj
- Param: func

Replaced value:
```sqf
((obj) call ((obj) getvariable PROTOTYPE_VAR_NAME getvariable (#func)))
```
File: [host\oop.hpp at line 309](../../../Src/host/oop.hpp#L309)
## callFuncAfter(obj,func,time)

Type: constant

Description: 
- Param: obj
- Param: func
- Param: time

Replaced value:
```sqf
[(obj) getVariable PROTOTYPE_VAR_NAME getVariable #func,obj,time] call CBA_fnc_waitAndExecute
```
File: [host\oop.hpp at line 310](../../../Src/host/oop.hpp#L310)
## callFuncAfterParams(obj,func,time,parms)

Type: constant

Description: 
- Param: obj
- Param: func
- Param: time
- Param: parms

Replaced value:
```sqf
[(obj) getVariable PROTOTYPE_VAR_NAME getVariable #func,[obj,parms],time] call CBA_fnc_waitAndExecute
```
File: [host\oop.hpp at line 311](../../../Src/host/oop.hpp#L311)
## callFuncParams(obj,func,parms)

Type: constant

Description: 
- Param: obj
- Param: func
- Param: parms

Replaced value:
```sqf
([obj, parms] call ((obj) getvariable PROTOTYPE_VAR_NAME getvariable (#func)))
```
File: [host\oop.hpp at line 312](../../../Src/host/oop.hpp#L312)
## callFuncParamsInline(obj,func,parms)

Type: constant

Description: 
- Param: obj
- Param: func
- Param: parms

Replaced value:
```sqf
(([obj]+(parms)) call ((obj) getvariable PROTOTYPE_VAR_NAME getvariable (#func)))
```
File: [host\oop.hpp at line 313](../../../Src/host/oop.hpp#L313)
## callFuncReflect(obj,func)

Type: constant

Description: Встраивает параметры в системный вызов метода
- Param: obj
- Param: func

Replaced value:
```sqf
((obj) call ((obj) getvariable PROTOTYPE_VAR_NAME getvariable (func)))
```
File: [host\oop.hpp at line 315](../../../Src/host/oop.hpp#L315)
## callFuncReflectParams(obj,func,parms)

Type: constant

Description: Встраивает параметры в системный вызов метода
- Param: obj
- Param: func
- Param: parms

Replaced value:
```sqf
([obj, parms] call ((obj) getvariable PROTOTYPE_VAR_NAME getvariable (func)))
```
File: [host\oop.hpp at line 316](../../../Src/host/oop.hpp#L316)
## callFuncReflectParamsInline(obj,func,parms)

Type: constant

Description: Встраивает параметры в системный вызов метода
- Param: obj
- Param: func
- Param: parms

Replaced value:
```sqf
(([obj]+(parms)) call ((obj) getvariable PROTOTYPE_VAR_NAME getvariable (func)))
```
File: [host\oop.hpp at line 318](../../../Src/host/oop.hpp#L318)
## getFunc(obj,func)

Type: constant

Description: 
- Param: obj
- Param: func

Replaced value:
```sqf
((obj) getvariable PROTOTYPE_VAR_NAME getvariable (#func))
```
File: [host\oop.hpp at line 320](../../../Src/host/oop.hpp#L320)
## getFuncReflect(obj,func)

Type: constant

Description: 
- Param: obj
- Param: func

Replaced value:
```sqf
((obj) getvariable PROTOTYPE_VAR_NAME getvariable (func))
```
File: [host\oop.hpp at line 321](../../../Src/host/oop.hpp#L321)
## getVar(obj,name)

Type: constant

Description: 
- Param: obj
- Param: name

Replaced value:
```sqf
((obj) getvariable (#name))
```
File: [host\oop.hpp at line 323](../../../Src/host/oop.hpp#L323)
## setVar(obj,name,value)

Type: constant

Description: 
- Param: obj
- Param: name
- Param: value

Replaced value:
```sqf
(obj) setvariable [#name,value]
```
File: [host\oop.hpp at line 324](../../../Src/host/oop.hpp#L324)
## modVar(obj,name,val)

Type: constant

Description: 
- Param: obj
- Param: name
- Param: val

Replaced value:
```sqf
setVar(obj,name,getVar(obj,name) val)
```
File: [host\oop.hpp at line 325](../../../Src/host/oop.hpp#L325)
## initVar(obj,name,_initial)

Type: constant

Description: 
- Param: obj
- Param: name
- Param: _initial

Replaced value:
```sqf
(if ISNIL{getVar(obj,name)}then{setVar(obj,name,_initial);_initial}else{getVar(obj,name)})
```
File: [host\oop.hpp at line 326](../../../Src/host/oop.hpp#L326)
## getVarReflect(obj,name)

Type: constant

Description: 
- Param: obj
- Param: name

Replaced value:
```sqf
((obj) getvariable (name))
```
File: [host\oop.hpp at line 328](../../../Src/host/oop.hpp#L328)
## setVarReflect(obj,name,value)

Type: constant

Description: 
- Param: obj
- Param: name
- Param: value

Replaced value:
```sqf
(obj) setvariable [name,value]
```
File: [host\oop.hpp at line 329](../../../Src/host/oop.hpp#L329)
## modVarReflect(obj,name,val)

Type: constant

Description: 
- Param: obj
- Param: name
- Param: val

Replaced value:
```sqf
setVarReflect(obj,name,getVarReflect(obj,name) val)
```
File: [host\oop.hpp at line 330](../../../Src/host/oop.hpp#L330)
## getProp(obj,func)

Type: constant

Description: 
- Param: obj
- Param: func

Replaced value:
```sqf
((obj) call ((obj) getvariable PROTOTYPE_VAR_NAME getvariable ('get##func')))
```
File: [host\oop.hpp at line 332](../../../Src/host/oop.hpp#L332)
## setProp(obj,func,val)

Type: constant

Description: 
- Param: obj
- Param: func
- Param: val

Replaced value:
```sqf
([obj,val] call ((obj) getvariable PROTOTYPE_VAR_NAME getvariable ('set##func')))
```
File: [host\oop.hpp at line 333](../../../Src/host/oop.hpp#L333)
## getConst(obj,constvar)

Type: constant

Description: constant helpers
- Param: obj
- Param: constvar

Replaced value:
```sqf
callFunc(obj,constvar)
```
File: [host\oop.hpp at line 336](../../../Src/host/oop.hpp#L336)
## getSelfConst(constvar)

Type: constant

Description: 
- Param: constvar

Replaced value:
```sqf
callSelf(constvar)
```
File: [host\oop.hpp at line 337](../../../Src/host/oop.hpp#L337)
## typeGet(typ)

Type: constant

Description: type accessing (extended reflection)
- Param: typ

Replaced value:
```sqf
(missionNamespace getvariable ['pt_'+ 'typ',nullPtr])
```
File: [host\oop.hpp at line 340](../../../Src/host/oop.hpp#L340)
## typeGetFromObject(obj)

Type: constant

Description: 
- Param: obj

Replaced value:
```sqf
(obj getVariable PROTOTYPE_VAR_NAME)
```
File: [host\oop.hpp at line 341](../../../Src/host/oop.hpp#L341)
## typeGetFromString(strvar)

Type: constant

Description: 
- Param: strvar

Replaced value:
```sqf
(missionNamespace getvariable ['pt_'+ (strvar),nullPtr])
```
File: [host\oop.hpp at line 342](../../../Src/host/oop.hpp#L342)
## typeGetVar(obj,var)

Type: constant

Description: 
- Param: obj
- Param: var

Replaced value:
```sqf
(obj getVariable 'var')
```
File: [host\oop.hpp at line 343](../../../Src/host/oop.hpp#L343)
## typeHasVar(obj,var)

Type: constant

Description: 
- Param: obj
- Param: var

Replaced value:
```sqf
(!isnil {typeGetVar(obj,var)})
```
File: [host\oop.hpp at line 344](../../../Src/host/oop.hpp#L344)
## typeSetVar(obj,var,val)

Type: constant

Description: 
- Param: obj
- Param: var
- Param: val

Replaced value:
```sqf
obj setvariable ['var',val]
```
File: [host\oop.hpp at line 345](../../../Src/host/oop.hpp#L345)
## typeGetDefaultFieldValueSerialized(tp,var)

Type: constant

Description: 
- Param: tp
- Param: var

Replaced value:
```sqf
(tp getVariable "__allfields_map" get 'var')
```
File: [host\oop.hpp at line 347](../../../Src/host/oop.hpp#L347)
## typeGetDefaultFieldValue(tp,var)

Type: constant

Description: 
- Param: tp
- Param: var

Replaced value:
```sqf
(compile typeGetDefaultFieldValueSerialized(tp,var))
```
File: [host\oop.hpp at line 347](../../../Src/host/oop.hpp#L347)
## isExistsObject(ref)

Type: constant

Description: checkers
- Param: ref

Replaced value:
```sqf
(!isnil {(ref getvariable 'proto')})
```
File: [host\oop.hpp at line 352](../../../Src/host/oop.hpp#L352)
## isTypeOf(obj,type)

Type: constant

Description: Проверка является ли тип наследником isTypeOf(_mob,Mob); //true
- Param: obj
- Param: type

Replaced value:
```sqf
((tolower #type) in ((obj) getvariable PROTOTYPE_VAR_NAME getvariable ("__inhlist_map")))
```
File: [host\oop.hpp at line 354](../../../Src/host/oop.hpp#L354)
## isTypeStringOf(obj,type)

Type: constant

Description: NON USABLE
- Param: obj
- Param: type

Replaced value:
```sqf
((tolower (type)) in ((obj) getvariable PROTOTYPE_VAR_NAME getvariable ("__inhlist_map")))
```
File: [host\oop.hpp at line 355](../../../Src/host/oop.hpp#L355)
## isTypeNameOf(obj,type)

Type: constant

Description: 
- Param: obj
- Param: type

Replaced value:
```sqf
((tolower #type) in (typeGetFromString(obj) getvariable ("__inhlist_map")))
```
File: [host\oop.hpp at line 356](../../../Src/host/oop.hpp#L356)
## isImplementClass(strname)

Type: constant

Description: проверка существования класса
- Param: strname

Replaced value:
```sqf
(!isNullReference(typeGetFromString(strname)))
```
File: [host\oop.hpp at line 358](../../../Src/host/oop.hpp#L358)
## isImplementFunc(objref,met)

Type: constant

Description: проверка наличия членов
- Param: objref
- Param: met

Replaced value:
```sqf
(!isnil{getFunc(objref,met)})
```
File: [host\oop.hpp at line 360](../../../Src/host/oop.hpp#L360)
## isImplementVar(objref,var)

Type: constant

Description: 
- Param: objref
- Param: var

Replaced value:
```sqf
((tolower #var) in getFunc(objref,__allfields_map))
```
File: [host\oop.hpp at line 361](../../../Src/host/oop.hpp#L361)
## getFieldBaseValue(strt,varx)

Type: constant

Description: Прямое получение дефолтных значений по подстроке через рефлексию
- Param: strt
- Param: varx

Replaced value:
```sqf
([strt,varx,true] call oop_getFieldBaseValue)
```
File: [host\oop.hpp at line 363](../../../Src/host/oop.hpp#L363)
## getFieldBaseValueWithMethod(strt,varx,prp)

Type: constant

Description: 
- Param: strt
- Param: varx
- Param: prp

Replaced value:
```sqf
([strt,varx,true,prp] call oop_getFieldBaseValue)
```
File: [host\oop.hpp at line 364](../../../Src/host/oop.hpp#L364)
## isNullObject(obj)

Type: constant

Description: NON USABLE #define isTypeStringOf(obj,type) ((tolower type) in ((obj) getVariable PROTOTYPE_VAR_NAME getVariable "__inhlist_map"))
- Param: obj

Replaced value:
```sqf
((obj) isequalto nullPtr)
```
File: [host\oop.hpp at line 368](../../../Src/host/oop.hpp#L368)
## name

Type: Variable

Description: 


Initial value:
```sqf
_pt_obj
```
File: [host\oop.hpp at line 70](../../../Src/host/oop.hpp#L70)
# precomiled.sqf

## __on_editor_attribute(membername,membertype)

Type: constant

Description: 
- Param: membername
- Param: membertype

Replaced value:
```sqf
if (count _editor_next_attr > 0) then { \
	membertype pushBack [membername,_editor_next_attr]; \
	_editor_next_attr = []; \
};
```
File: [host\precomiled.sqf at line 92](../../../Src/host/precomiled.sqf#L92)
## pc_oop_carr_tntps

Type: Variable

Description: константные типы объектов. 0 - обычные называния типов, 1 - названия в редакторе


Initial value:
```sqf
["<Type::%1>","<EDITOR_Type::%1>"]
```
File: [host\precomiled.sqf at line 36](../../../Src/host/precomiled.sqf#L36)
## pc_oop_declareClassAttr

Type: function

Description: функция декларатор атрибутов класса


File: [host\precomiled.sqf at line 19](../../../Src/host/precomiled.sqf#L19)
## pc_oop_declareEOC

Type: function

Description: декларатор конца класса


File: [host\precomiled.sqf at line 29](../../../Src/host/precomiled.sqf#L29)
## pc_oop_declareMemAttrs

Type: function

Description: функция привязки атрибутов к типу


File: [host\precomiled.sqf at line 39](../../../Src/host/precomiled.sqf#L39)
## pc_oop_postInitClass

Type: function

Description: завершающая иницализация класса.


File: [host\precomiled.sqf at line 48](../../../Src/host/precomiled.sqf#L48)
## pc_oop_handleAttrF

Type: function

Description: обработчик атрибутов поля


File: [host\precomiled.sqf at line 98](../../../Src/host/precomiled.sqf#L98)
## pc_oop_handleAttrM

Type: function

Description: обработчик атрибутов метода


File: [host\precomiled.sqf at line 107](../../../Src/host/precomiled.sqf#L107)
# text.hpp

## lt

Type: constant

Description: <


Replaced value:
```sqf
&lt;
```
File: [host\text.hpp at line 7](../../../Src/host/text.hpp#L7)
## slt

Type: constant

Description: 


Replaced value:
```sqf
"&lt;"
```
File: [host\text.hpp at line 8](../../../Src/host/text.hpp#L8)
## gt

Type: constant

Description: >


Replaced value:
```sqf
&gt;
```
File: [host\text.hpp at line 10](../../../Src/host/text.hpp#L10)
## sgt

Type: constant

Description: 


Replaced value:
```sqf
"&gt;"
```
File: [host\text.hpp at line 11](../../../Src/host/text.hpp#L11)
## lt

Type: constant

> Exists if **_SQFVM** defined

Description: <


Replaced value:
```sqf
left_br
```
File: [host\text.hpp at line 15](../../../Src/host/text.hpp#L15)
## slt

Type: constant

> Exists if **_SQFVM** defined

Description: 


Replaced value:
```sqf
"string_left_br"
```
File: [host\text.hpp at line 16](../../../Src/host/text.hpp#L16)
## gt

Type: constant

> Exists if **_SQFVM** defined

Description: >


Replaced value:
```sqf
right_br
```
File: [host\text.hpp at line 18](../../../Src/host/text.hpp#L18)
## sgt

Type: constant

> Exists if **_SQFVM** defined

Description: 


Replaced value:
```sqf
"string_right_br"
```
File: [host\text.hpp at line 19](../../../Src/host/text.hpp#L19)
## br_inline

Type: constant

Description: 


Replaced value:
```sqf
<br/>
```
File: [host\text.hpp at line 22](../../../Src/host/text.hpp#L22)
## sbr

Type: constant

Description: Не изменять!!! зависимости есть!!!


Replaced value:
```sqf
"<br/>"
```
File: [host\text.hpp at line 24](../../../Src/host/text.hpp#L24)
## comma

Type: constant

Description: Просто символ запятой (обычно используется в препроцессоре чтобы избежать ошибки)


Replaced value:
```sqf
","
```
File: [host\text.hpp at line 27](../../../Src/host/text.hpp#L27)
## pcomma

Type: constant

Description: 


Replaced value:
```sqf
+comma+
```
File: [host\text.hpp at line 29](../../../Src/host/text.hpp#L29)
## capitalize(text)

Type: constant

Description: Первую букву большую
- Param: text

Replaced value:
```sqf
(text call {private _s = toArray _this; toupper tostring(_s select [0,1]) + tostring(_s select [1,count _s - 1])})
```
File: [host\text.hpp at line 32](../../../Src/host/text.hpp#L32)
## lowerize(text)

Type: constant

Description: 
- Param: text

Replaced value:
```sqf
(text call {forceUnicode 0; toLower (_this select [0,1]) + (_this select [1,count _this - 1])})
```
File: [host\text.hpp at line 33](../../../Src/host/text.hpp#L33)
## sanitize(text)

Type: constant

Description: очищает строку от тегов, превращая в обычный текст
- Param: text

Replaced value:
```sqf
((text) call {if not_equalTypes(_this,"") then {str _this} else {_this regexReplace ["&", "&amp;"] regexReplace ["<", "&lt;"] regexReplace [">", "&gt;"] regexReplace ["""", "&quot;"] regexReplace ["'", "&apos;"]}})
```
File: [host\text.hpp at line 36](../../../Src/host/text.hpp#L36)
## sanitizeHTML(text)

Type: constant

Description: Убирает форматирование html. Используется для отслыки в чат дискорда
- Param: text

Replaced value:
```sqf
((text) call {if not_equalTypes(_this,"") then {str _this} else {str parseText _this}})
```
File: [host\text.hpp at line 39](../../../Src/host/text.hpp#L39)
## htmlToString(text)

Type: constant

Description: pseudoname for sanitizeHTML()
- Param: text

Replaced value:
```sqf
sanitizeHTML(text)
```
File: [host\text.hpp at line 42](../../../Src/host/text.hpp#L42)
## setstyle(txt,stl)

Type: constant

Description: http://htmlbook.ru/samhtml/tekst/spetssimvoly
- Param: txt
- Param: stl

Replaced value:
```sqf
('<t stl >'+(txt)+"</t>")
```
File: [host\text.hpp at line 47](../../../Src/host/text.hpp#L47)
## style_prop(name,valstr)

Type: constant

Description: 
- Param: name
- Param: valstr

Replaced value:
```sqf
name=''valstr''
```
File: [host\text.hpp at line 48](../../../Src/host/text.hpp#L48)
## style_learnedskills

Type: constant

Description: 


Replaced value:
```sqf
style_prop(align,center) style_prop(size,1.4) style_prop(color,#00B74A)
```
File: [host\text.hpp at line 50](../../../Src/host/text.hpp#L50)
## style_test

Type: constant

Description: 


Replaced value:
```sqf
color='#ff0000'
```
File: [host\text.hpp at line 51](../../../Src/host/text.hpp#L51)
## style_redbig

Type: constant

Description: 


Replaced value:
```sqf
style_prop(color,#ff0000) style_prop(size,1.5)
```
File: [host\text.hpp at line 52](../../../Src/host/text.hpp#L52)
## ST_ATTR_TOKEN_OPEN

Type: constant

Description: Решение проблемы с T_ATTR_END - поиск по закрывающему токену и пробелу перед ним


Replaced value:
```sqf
@1
```
File: [host\text.hpp at line 64](../../../Src/host/text.hpp#L64)
## ST_ATTR_TOKEN_CLOSE

Type: constant

Description: 


Replaced value:
```sqf
@2
```
File: [host\text.hpp at line 65](../../../Src/host/text.hpp#L65)
## ST_ATTR_TOKEN_END

Type: constant

Description: 


Replaced value:
```sqf
@3
```
File: [host\text.hpp at line 66](../../../Src/host/text.hpp#L66)
## ST_ATTR_TOKEN_OPEN_S

Type: constant

Description: 


Replaced value:
```sqf
@1
```
File: [host\text.hpp at line 68](../../../Src/host/text.hpp#L68)
## ST_ATTR_TOKEN_CLOSE_S

Type: constant

Description: 


Replaced value:
```sqf
@2
```
File: [host\text.hpp at line 69](../../../Src/host/text.hpp#L69)
## ST_ATTR_TOKEN_END_S

Type: constant

Description: 


Replaced value:
```sqf
@3
```
File: [host\text.hpp at line 70](../../../Src/host/text.hpp#L70)
## T_BREAK

Type: constant

Description: breaklines


Replaced value:
```sqf
@4
```
File: [host\text.hpp at line 73](../../../Src/host/text.hpp#L73)
## T_BREAK_S

Type: constant

Description: 


Replaced value:
```sqf
'T_BREAK'
```
File: [host\text.hpp at line 74](../../../Src/host/text.hpp#L74)
## T_ATTR_S(attributes__)

Type: constant

Description: 
- Param: attributes__

Replaced value:
```sqf
'ST_ATTR_TOKEN_OPEN attributes__ ST_ATTR_TOKEN_CLOSE'
```
File: [host\text.hpp at line 76](../../../Src/host/text.hpp#L76)
## T_ATTR(attrs_)

Type: constant

Description: 
- Param: attrs_

Replaced value:
```sqf
ST_ATTR_TOKEN_OPEN attrs_ ST_ATTR_TOKEN_CLOSE
```
File: [host\text.hpp at line 76](../../../Src/host/text.hpp#L76)
## T_ATTR_END_S

Type: constant

Description: 


Replaced value:
```sqf
'ST_ATTR_TOKEN_END'
```
File: [host\text.hpp at line 79](../../../Src/host/text.hpp#L79)
## T_ATTR_END

Type: constant

Description: 


Replaced value:
```sqf
ST_ATTR_TOKEN_END
```
File: [host\text.hpp at line 79](../../../Src/host/text.hpp#L79)
## T_SIZE(val)

Type: constant

Description: 
- Param: val

Replaced value:
```sqf
s=val
```
File: [host\text.hpp at line 82](../../../Src/host/text.hpp#L82)
## T_SIZE_S(val)

Type: constant

Description: 
- Param: val

Replaced value:
```sqf
'T_SIZE(val)'
```
File: [host\text.hpp at line 83](../../../Src/host/text.hpp#L83)
## T_COLOR(val)

Type: constant

Description: 
- Param: val

Replaced value:
```sqf
c=val
```
File: [host\text.hpp at line 85](../../../Src/host/text.hpp#L85)
## T_COLOR_S(val)

Type: constant

Description: 
- Param: val

Replaced value:
```sqf
'T_COLOR(val)'
```
File: [host\text.hpp at line 86](../../../Src/host/text.hpp#L86)
## T_FONT_TAHOMA

Type: constant

Description: 


Replaced value:
```sqf
f=0
```
File: [host\text.hpp at line 88](../../../Src/host/text.hpp#L88)
## __t_align_provider(val)

Type: constant

Description: align attribute
- Param: val

Replaced value:
```sqf
a=val
```
File: [host\text.hpp at line 94](../../../Src/host/text.hpp#L94)
## T_H_ALIGN_LEFT

Type: constant

Description: 


Replaced value:
```sqf
__t_align_provider(0)
```
File: [host\text.hpp at line 96](../../../Src/host/text.hpp#L96)
## T_H_ALIGN_CENTER

Type: constant

Description: 


Replaced value:
```sqf
__t_align_provider(1)
```
File: [host\text.hpp at line 97](../../../Src/host/text.hpp#L97)
## T_H_ALIGN_RIGHT

Type: constant

Description: 


Replaced value:
```sqf
__t_align_provider(2)
```
File: [host\text.hpp at line 98](../../../Src/host/text.hpp#L98)
## T_H_ALIGN_LEFT_S

Type: constant

Description: 


Replaced value:
```sqf
'T_H_ALIGN_LEFT'
```
File: [host\text.hpp at line 100](../../../Src/host/text.hpp#L100)
## T_H_ALIGN_CENTER_S

Type: constant

Description: 


Replaced value:
```sqf
'T_H_ALIGN_CENTER'
```
File: [host\text.hpp at line 101](../../../Src/host/text.hpp#L101)
## T_H_ALIGN_RIGHT_S

Type: constant

Description: 


Replaced value:
```sqf
'T_H_ALIGN_RIGHT'
```
File: [host\text.hpp at line 102](../../../Src/host/text.hpp#L102)
## __t_valign_provider(val)

Type: constant

Description: valign attribute
- Param: val

Replaced value:
```sqf
v=val
```
File: [host\text.hpp at line 105](../../../Src/host/text.hpp#L105)
## T_V_ALIGN_TOP

Type: constant

Description: 


Replaced value:
```sqf
__t_valign_provider(0)
```
File: [host\text.hpp at line 107](../../../Src/host/text.hpp#L107)
## T_V_ALIGN_MIDDLE

Type: constant

Description: 


Replaced value:
```sqf
__t_valign_provider(1)
```
File: [host\text.hpp at line 108](../../../Src/host/text.hpp#L108)
## T_V_ALIGN_BOTTOM

Type: constant

Description: 


Replaced value:
```sqf
__t_valign_provider(2)
```
File: [host\text.hpp at line 109](../../../Src/host/text.hpp#L109)
## T_V_ALIGN_TOP_S

Type: constant

Description: 


Replaced value:
```sqf
'T_V_ALIGN_TOP'
```
File: [host\text.hpp at line 111](../../../Src/host/text.hpp#L111)
## T_V_ALIGN_MIDDLE_S

Type: constant

Description: 


Replaced value:
```sqf
'T_V_ALIGN_MIDDLE'
```
File: [host\text.hpp at line 112](../../../Src/host/text.hpp#L112)
## T_V_ALIGN_BOTTOM_S

Type: constant

Description: 


Replaced value:
```sqf
'T_V_ALIGN_BOTTOM'
```
File: [host\text.hpp at line 113](../../../Src/host/text.hpp#L113)
## T_UNDERLINE(mode)

Type: constant

Description: underline
- Param: mode

Replaced value:
```sqf
u=mode
```
File: [host\text.hpp at line 117](../../../Src/host/text.hpp#L117)
## T_UNDERLINE_S(mode)

Type: constant

Description: 
- Param: mode

Replaced value:
```sqf
'T_UNDERLINE(mode)'
```
File: [host\text.hpp at line 118](../../../Src/host/text.hpp#L118)
## T_SHADOW_MODE(mode)

Type: constant

Description: shadow attributes
- Param: mode

Replaced value:
```sqf
h=mode
```
File: [host\text.hpp at line 121](../../../Src/host/text.hpp#L121)
## T_SHADOW_MODE_S(mode)

Type: constant

Description: 
- Param: mode

Replaced value:
```sqf
'T_SHADOW_MODE(mode)'
```
File: [host\text.hpp at line 122](../../../Src/host/text.hpp#L122)
## T_SHADOW_COLOR(col)

Type: constant

Description: 
- Param: col

Replaced value:
```sqf
g=col
```
File: [host\text.hpp at line 124](../../../Src/host/text.hpp#L124)
## T_SHADOW_COLOR_S(col)

Type: constant

Description: 
- Param: col

Replaced value:
```sqf
'T_SHADOW_COLOR(col)'
```
File: [host\text.hpp at line 125](../../../Src/host/text.hpp#L125)
## T_SHADOW_OFFSET(val)

Type: constant

Description: 
- Param: val

Replaced value:
```sqf
j=val
```
File: [host\text.hpp at line 127](../../../Src/host/text.hpp#L127)
## T_SHADOW_OFFSET_S(val)

Type: constant

Description: 
- Param: val

Replaced value:
```sqf
'T_SHADOW_OFFSET(val)'
```
File: [host\text.hpp at line 128](../../../Src/host/text.hpp#L128)
## T_IMAGE(dat)

Type: constant

Description: T_IMAGE(T_SIZE(0.8) T_IMAGEPATH(\a3\dataf\flags\flag_altis_co.paa))
- Param: dat

Replaced value:
```sqf
@5 dat @6
```
File: [host\text.hpp at line 134](../../../Src/host/text.hpp#L134)
## T_IMAGE_S(dat)

Type: constant

Description: 
- Param: dat

Replaced value:
```sqf
'T_IMAGE(dat)'
```
File: [host\text.hpp at line 135](../../../Src/host/text.hpp#L135)
## T_IMAGEPATH(pth)

Type: constant

Description: 
- Param: pth

Replaced value:
```sqf
i=pth
```
File: [host\text.hpp at line 137](../../../Src/host/text.hpp#L137)
## T_IMAGEPATH_S(pth)

Type: constant

Description: 
- Param: pth

Replaced value:
```sqf
'T_IMAGEPATH(pth)'
```
File: [host\text.hpp at line 138](../../../Src/host/text.hpp#L138)
## T_HREF(data,text)

Type: constant

Description: references
- Param: data
- Param: text

Replaced value:
```sqf
@7 data @8text @9
```
File: [host\text.hpp at line 141](../../../Src/host/text.hpp#L141)
## T_HREF_S(data,text)

Type: constant

Description: 
- Param: data
- Param: text

Replaced value:
```sqf
'T_HREF(data,text)'
```
File: [host\text.hpp at line 142](../../../Src/host/text.hpp#L142)
## T_HREF_COLOR(col)

Type: constant

Description: 
- Param: col

Replaced value:
```sqf
l=col
```
File: [host\text.hpp at line 144](../../../Src/host/text.hpp#L144)
## T_HREF_COLOR_S(col)

Type: constant

Description: 
- Param: col

Replaced value:
```sqf
'T_HREF_COLOR(col)'
```
File: [host\text.hpp at line 145](../../../Src/host/text.hpp#L145)
# thread.hpp

## threadNew(code)

Type: constant

Description: 
- Param: code

Replaced value:
```sqf
[[],code]
```
File: [host\thread.hpp at line 21](../../../Src/host/thread.hpp#L21)
## threadNewArgs(code,args)

Type: constant

Description: 
- Param: code
- Param: args

Replaced value:
```sqf
[args,code]
```
File: [host\thread.hpp at line 23](../../../Src/host/thread.hpp#L23)
## threadStart(thdObj)

Type: constant

Description: 
- Param: thdObj

Replaced value:
```sqf
thdObj call {private _t = (_this select 0)spawn(_this select 1);allThreads pushback _t; _t}
```
File: [host\thread.hpp at line 25](../../../Src/host/thread.hpp#L25)
## threadName(name)

Type: constant

Description: 
- Param: name

Replaced value:
```sqf
scriptname (name)
```
File: [host\thread.hpp at line 27](../../../Src/host/thread.hpp#L27)
## thisThread

Type: constant

Description: 


Replaced value:
```sqf
_thisScript
```
File: [host\thread.hpp at line 29](../../../Src/host/thread.hpp#L29)
## threadStop(thd)

Type: constant

Description: 
- Param: thd

Replaced value:
```sqf
terminate (thd)
```
File: [host\thread.hpp at line 31](../../../Src/host/thread.hpp#L31)
## threadSleep(time)

Type: constant

Description: 
- Param: time

Replaced value:
```sqf
uisleep (time)
```
File: [host\thread.hpp at line 33](../../../Src/host/thread.hpp#L33)
## isAsyncContext

Type: constant

Description: 


Replaced value:
```sqf
canSuspend
```
File: [host\thread.hpp at line 35](../../../Src/host/thread.hpp#L35)
## criticalSectionStart()

Type: constant

Description: critical section
- Param: 

Replaced value:
```sqf
isNil {
```
File: [host\thread.hpp at line 39](../../../Src/host/thread.hpp#L39)
## criticalSectionEnd()

Type: constant

Description: 
- Param: 

Replaced value:
```sqf
true}
```
File: [host\thread.hpp at line 41](../../../Src/host/thread.hpp#L41)
## mutexNew()

Type: constant

Description: mutex
- Param: 

Replaced value:
```sqf
[]
```
File: [host\thread.hpp at line 46](../../../Src/host/thread.hpp#L46)
## mutexLock(mutex)

Type: constant

Description: 
- Param: mutex

Replaced value:
```sqf
waitUntil { (mutex pushBackUnique 0) == 0;}
```
File: [host\thread.hpp at line 48](../../../Src/host/thread.hpp#L48)
## mutexUnlock(mutex)

Type: constant

Description: 
- Param: mutex

Replaced value:
```sqf
mutex deleteAt 0
```
File: [host\thread.hpp at line 50](../../../Src/host/thread.hpp#L50)
## mutexTryLock(mutex)

Type: constant

Description: diag_tickTime becomes less accurate the longer a mission is running, so higher timeout value is better for robustness
- Param: mutex

Replaced value:
```sqf
if(((mutex) pushBackUnique 0) == 0) then {true} else {false}
```
File: [host\thread.hpp at line 52](../../../Src/host/thread.hpp#L52)
## mutexIsLocked(mutex)

Type: constant

Description: 
- Param: mutex

Replaced value:
```sqf
(count (mutex) > 0)
```
File: [host\thread.hpp at line 53](../../../Src/host/thread.hpp#L53)
## mutexTryLockTimeout(mutex, timeout)

Type: constant

Description: diag_tickTime becomes less accurate the longer a mission is running, so higher timeout value is better for robustness
- Param: mutex
- Param: timeout

Replaced value:
```sqf
[] call { private _timer = diag_tickTime; private _locked = false; waitUntil { _locked = ((mutex) pushBackUnique 0) == 0; _locked || {diag_tickTime > (_timer + (timeout))} }; _locked }
```
File: [host\thread.hpp at line 56](../../../Src/host/thread.hpp#L56)
