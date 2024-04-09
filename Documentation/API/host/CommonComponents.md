# !MemReflect.sqf

## global_modules

Type: Variable

Description: 


Initial value:
```sqf
createHashMap
```
File: [host\CommonComponents\!MemReflect.sqf at line 68](../../../Src/host/CommonComponents/!MemReflect.sqf#L68)
## gv_rv

Type: function

Description: регистрация переменной
- Param: _name
- Param: _file
- Param: _line
- Param: _moduleName (optional, default "__undef__")

File: [host\CommonComponents\!MemReflect.sqf at line 10](../../../Src/host/CommonComponents/!MemReflect.sqf#L10)
## gv_rf

Type: function

Description: регистрация функции
- Param: _name
- Param: _file
- Param: _line
- Param: _moduleName (optional, default "__undef__")

File: [host\CommonComponents\!MemReflect.sqf at line 41](../../../Src/host/CommonComponents/!MemReflect.sqf#L41)
# !PreInit.sqf

## PRFX__

Type: constant

Description: 


Replaced value:
```sqf
"WARN: "
```
File: [host\CommonComponents\!PreInit.sqf at line 69](../../../Src/host/CommonComponents/!PreInit.sqf#L69)
## __ptr_size__

Type: constant

Description: 


Replaced value:
```sqf
8
```
File: [host\CommonComponents\!PreInit.sqf at line 148](../../../Src/host/CommonComponents/!PreInit.sqf#L148)
## __num_size__

Type: constant

Description: 


Replaced value:
```sqf
8
```
File: [host\CommonComponents\!PreInit.sqf at line 149](../../../Src/host/CommonComponents/!PreInit.sqf#L149)
## __vector_size__

Type: constant

Description: 


Replaced value:
```sqf
24
```
File: [host\CommonComponents\!PreInit.sqf at line 150](../../../Src/host/CommonComponents/!PreInit.sqf#L150)
## __map_size__

Type: constant

Description: 


Replaced value:
```sqf
48
```
File: [host\CommonComponents\!PreInit.sqf at line 151](../../../Src/host/CommonComponents/!PreInit.sqf#L151)
## C_PTR_REALOC_SIZE

Type: constant

Description: allocated before realoc ( not used now...)


Replaced value:
```sqf
1024
```
File: [host\CommonComponents\!PreInit.sqf at line 185](../../../Src/host/CommonComponents/!PreInit.sqf#L185)
## C_PTR_BYTE_SITE

Type: constant

Description: 


Replaced value:
```sqf
4
```
File: [host\CommonComponents\!PreInit.sqf at line 186](../../../Src/host/CommonComponents/!PreInit.sqf#L186)
## testcheck(value,errortext)

Type: constant

> Exists if **__ENABLE_STATIC_TEST** defined

Description: 
- Param: value
- Param: errortext

Replaced value:
```sqf
if !(value) exitWith { \
		private _format = format["%1 - %2",errortext,'value']; \
		setLastError(_format); \
	};
```
File: [host\CommonComponents\!PreInit.sqf at line 502](../../../Src/host/CommonComponents/!PreInit.sqf#L502)
## cprint_usestdout

Type: Variable

Description: console helpers


Initial value:
```sqf
true //flag for standart console output
```
File: [host\CommonComponents\!PreInit.sqf at line 36](../../../Src/host/CommonComponents/!PreInit.sqf#L36)
## cprint_isserver

Type: Variable

Description: flag for standart console output


Initial value:
```sqf
isMultiplayer && isServer
```
File: [host\CommonComponents\!PreInit.sqf at line 37](../../../Src/host/CommonComponents/!PreInit.sqf#L37)
## allThreads

Type: Variable

Description: 


Initial value:
```sqf
[] //init thread pool
```
File: [host\CommonComponents\!PreInit.sqf at line 111](../../../Src/host/CommonComponents/!PreInit.sqf#L111)
## hashMapNull

Type: Variable

Description: init thread pool


Initial value:
```sqf
createHashMapFromArray [["__NULL_HASH_MAP__","__NULL_HASH_MAP__"]]
```
File: [host\CommonComponents\!PreInit.sqf at line 112](../../../Src/host/CommonComponents/!PreInit.sqf#L112)
## table_hex

Type: Variable

Description: 


Initial value:
```sqf
"0123456789abcdef"splitString stringEmpty
```
File: [host\CommonComponents\!PreInit.sqf at line 114](../../../Src/host/CommonComponents/!PreInit.sqf#L114)
## ptr_i_mctr

Type: Variable

Description: 


Initial value:
```sqf
1//internal memory counter
```
File: [host\CommonComponents\!PreInit.sqf at line 183](../../../Src/host/CommonComponents/!PreInit.sqf#L183)
## ptr_i_al

Type: Variable

Description: internal memory counter


Initial value:
```sqf
0 //allocated before realoc ( not used now...)
```
File: [host\CommonComponents\!PreInit.sqf at line 184](../../../Src/host/CommonComponents/!PreInit.sqf#L184)
## ptr_cnl

Type: Variable

Description: 


Initial value:
```sqf
__ptr_struct_internal__(str ptr_i_mctr,0) //null pointer
```
File: [host\CommonComponents\!PreInit.sqf at line 187](../../../Src/host/CommonComponents/!PreInit.sqf#L187)
## ptr_htable

Type: Variable

Description: null pointer


Initial value:
```sqf
createHashMap
```
File: [host\CommonComponents\!PreInit.sqf at line 188](../../../Src/host/CommonComponents/!PreInit.sqf#L188)
## ptr_i_hex__

Type: Variable

Description: 


Initial value:
```sqf
"0123456789abcdef"splitString stringEmpty
```
File: [host\CommonComponents\!PreInit.sqf at line 206](../../../Src/host/CommonComponents/!PreInit.sqf#L206)
## client_sendNotifToServer

Type: function

Description: 
- Param: _mes

File: [host\CommonComponents\!PreInit.sqf at line 25](../../../Src/host/CommonComponents/!PreInit.sqf#L25)
## cprint

Type: function

Description: 


File: [host\CommonComponents\!PreInit.sqf at line 40](../../../Src/host/CommonComponents/!PreInit.sqf#L40)
## cprintErr

Type: function

Description: 


File: [host\CommonComponents\!PreInit.sqf at line 54](../../../Src/host/CommonComponents/!PreInit.sqf#L54)
## cprintWarn

Type: function

Description: 


File: [host\CommonComponents\!PreInit.sqf at line 68](../../../Src/host/CommonComponents/!PreInit.sqf#L68)
## rpc_addEventGlobal

Type: function

Description: 
- Param: _eventName
- Param: _eventCode

File: [host\CommonComponents\!PreInit.sqf at line 116](../../../Src/host/CommonComponents/!PreInit.sqf#L116)
## rv_cppcheck

Type: function

Description: if (isValid(nullPtr)) then {} else {};
- Param: _val

File: [host\CommonComponents\!PreInit.sqf at line 135](../../../Src/host/CommonComponents/!PreInit.sqf#L135)
## rv_sizeOf

Type: function

Description: 


File: [host\CommonComponents\!PreInit.sqf at line 147](../../../Src/host/CommonComponents/!PreInit.sqf#L147)
## ptr_create

Type: function

Description: initialize new pointer


File: [host\CommonComponents\!PreInit.sqf at line 192](../../../Src/host/CommonComponents/!PreInit.sqf#L192)
## ptr_destroy

Type: function

Description: delete pointer if not null


File: [host\CommonComponents\!PreInit.sqf at line 198](../../../Src/host/CommonComponents/!PreInit.sqf#L198)
## ptr_cts

Type: function

Description: convert to string
- Param: _p

File: [host\CommonComponents\!PreInit.sqf at line 209](../../../Src/host/CommonComponents/!PreInit.sqf#L209)
## ptr_remval

Type: function

Description: 


File: [host\CommonComponents\!PreInit.sqf at line 241](../../../Src/host/CommonComponents/!PreInit.sqf#L241)
## ptr_check

Type: function

Description: 


File: [host\CommonComponents\!PreInit.sqf at line 247](../../../Src/host/CommonComponents/!PreInit.sqf#L247)
## toNumeralString

Type: function

Description: Склоняет слова в числительное
- Param: _number
- Param: _counter (optional, default ['"Штука"', '"Штуки"', '"Штук"'])
- Param: _addNumToText (optional, default false)

File: [host\CommonComponents\!PreInit.sqf at line 254](../../../Src/host/CommonComponents/!PreInit.sqf#L254)
## regex_isMatch

Type: function

Description: ==================================================================================================
- Param: _txt
- Param: _pattern

File: [host\CommonComponents\!PreInit.sqf at line 268](../../../Src/host/CommonComponents/!PreInit.sqf#L268)
## regex_getFirstMatch

Type: function

Description: 
- Param: _txt
- Param: _pattern
- Param: _optMath (optional, default 0)

File: [host\CommonComponents\!PreInit.sqf at line 274](../../../Src/host/CommonComponents/!PreInit.sqf#L274)
## regex_replace

Type: function

Description: 
- Param: _txt
- Param: _pattern
- Param: _replacer

File: [host\CommonComponents\!PreInit.sqf at line 281](../../../Src/host/CommonComponents/!PreInit.sqf#L281)
## stringStartWith

Type: function

Description: Строковые хелперы
- Param: _checked
- Param: _started
- Param: _casesense (optional, default true)

File: [host\CommonComponents\!PreInit.sqf at line 336](../../../Src/host/CommonComponents/!PreInit.sqf#L336)
## stringEndWith

Type: function

Description: 
- Param: _checked
- Param: _ended
- Param: _casesense (optional, default true)

File: [host\CommonComponents\!PreInit.sqf at line 342](../../../Src/host/CommonComponents/!PreInit.sqf#L342)
## stringReplace

Type: function

Description: 
- Param: _string (optional, default "")
- Param: _find (optional, default "")
- Param: _replace (optional, default "")

File: [host\CommonComponents\!PreInit.sqf at line 349](../../../Src/host/CommonComponents/!PreInit.sqf#L349)
## selectBest

Type: function

Description: Выбирает лучший случай [[1,2,3],{_x > 2}] call selectBest
- Param: _array
- Param: _criteria
- Param: _return

File: [host\CommonComponents\!PreInit.sqf at line 368](../../../Src/host/CommonComponents/!PreInit.sqf#L368)
## searchInList

Type: function

Description: 
- Param: _list
- Param: _lambda
- Param: _defaultReturn

File: [host\CommonComponents\!PreInit.sqf at line 384](../../../Src/host/CommonComponents/!PreInit.sqf#L384)
## arrayDeleteItem

Type: function

Description: 
- Param: _a
- Param: _it

File: [host\CommonComponents\!PreInit.sqf at line 391](../../../Src/host/CommonComponents/!PreInit.sqf#L391)
## arrayIsValidIndex

Type: function

Description: 
- Param: _a
- Param: _ix

File: [host\CommonComponents\!PreInit.sqf at line 398](../../../Src/host/CommonComponents/!PreInit.sqf#L398)
## arrayShuffleOrig

Type: function

Description: shuffle array elements, return alter array
- Param: _array

File: [host\CommonComponents\!PreInit.sqf at line 404](../../../Src/host/CommonComponents/!PreInit.sqf#L404)
## arraySwap

Type: function

Description: swap 2 elements in array
- Param: _a
- Param: _is
- Param: _id

File: [host\CommonComponents\!PreInit.sqf at line 416](../../../Src/host/CommonComponents/!PreInit.sqf#L416)
## stringLength

Type: function

Description: 
- Param: _str
- Param: _unicode (optional, default true)

File: [host\CommonComponents\!PreInit.sqf at line 423](../../../Src/host/CommonComponents/!PreInit.sqf#L423)
## stringSelect

Type: function

Description: 
- Param: _s
- Param: _i
- Param: _c

File: [host\CommonComponents\!PreInit.sqf at line 433](../../../Src/host/CommonComponents/!PreInit.sqf#L433)
## randomFloat

Type: function

Description: 
- Param: _beg
- Param: _end

File: [host\CommonComponents\!PreInit.sqf at line 439](../../../Src/host/CommonComponents/!PreInit.sqf#L439)
## randomInt

Type: function

Description: 
- Param: _beg
- Param: _end

File: [host\CommonComponents\!PreInit.sqf at line 444](../../../Src/host/CommonComponents/!PreInit.sqf#L444)
## randomProbably

Type: function

Description: 
- Param: _v

File: [host\CommonComponents\!PreInit.sqf at line 449](../../../Src/host/CommonComponents/!PreInit.sqf#L449)
## getPrecentage

Type: function

Description: 
- Param: _checkedval
- Param: _pval

File: [host\CommonComponents\!PreInit.sqf at line 454](../../../Src/host/CommonComponents/!PreInit.sqf#L454)
## clampNumber

Type: function

Description: 
- Param: _v
- Param: _mi
- Param: _ma

File: [host\CommonComponents\!PreInit.sqf at line 459](../../../Src/host/CommonComponents/!PreInit.sqf#L459)
## stringFormat

Type: function

Description: 
- Param: _fmt
- Param: _val
- Param: _breakArr (optional, default false)

File: [host\CommonComponents\!PreInit.sqf at line 464](../../../Src/host/CommonComponents/!PreInit.sqf#L464)
## functionalitests_preinit

Type: function

> Exists if **__ENABLE_STATIC_TEST** defined

Description: 


File: [host\CommonComponents\!PreInit.sqf at line 501](../../../Src/host/CommonComponents/!PreInit.sqf#L501)
# Algorithm.sqf

## allOf

Type: function

Description: 
- Param: _list

File: [host\CommonComponents\Algorithm.sqf at line 18](../../../Src/host/CommonComponents/Algorithm.sqf#L18)
## anyOf

Type: function

Description: 
- Param: _list

File: [host\CommonComponents\Algorithm.sqf at line 23](../../../Src/host/CommonComponents/Algorithm.sqf#L23)
## noneOf

Type: function

Description: 
- Param: _list

File: [host\CommonComponents\Algorithm.sqf at line 28](../../../Src/host/CommonComponents/Algorithm.sqf#L28)
# Animator.sqf

## addAnim(name)

Type: constant

Description: 
- Param: name

Replaced value:
```sqf
INC(__animIndex); anim_assocList_keyString set [name,__animIndex]; anim_assocList_keyInt set [__animIndex,name]
```
File: [host\CommonComponents\Animator.sqf at line 9](../../../Src/host/CommonComponents/Animator.sqf#L9)
## __compareanims(idx)

Type: constant

Description: 
- Param: idx

Replaced value:
```sqf
((_anims select idx) == "nl" && ((_blender select idx) == 1))
```
File: [host\CommonComponents\Animator.sqf at line 219](../../../Src/host/CommonComponents/Animator.sqf#L219)
## anim_assocList_keyString

Type: Variable

Description: 


Initial value:
```sqf
createHashMap 
```
File: [host\CommonComponents\Animator.sqf at line 10](../../../Src/host/CommonComponents/Animator.sqf#L10)
## anim_assocList_keyInt

Type: Variable

Description: 


Initial value:
```sqf
createHashMap
```
File: [host\CommonComponents\Animator.sqf at line 11](../../../Src/host/CommonComponents/Animator.sqf#L11)
## anim_getAssoc

Type: function

Description: конвертор ассоциаций
- Param: _value

File: [host\CommonComponents\Animator.sqf at line 25](../../../Src/host/CommonComponents/Animator.sqf#L25)
## anim_getUnitAnim

Type: function

Description: 


File: [host\CommonComponents\Animator.sqf at line 72](../../../Src/host/CommonComponents/Animator.sqf#L72)
## anim_isSprinting

Type: function

Description: 
- Param: _anm

File: [host\CommonComponents\Animator.sqf at line 74](../../../Src/host/CommonComponents/Animator.sqf#L74)
## anim_isRunning

Type: function

Description: 
- Param: _anm

File: [host\CommonComponents\Animator.sqf at line 75](../../../Src/host/CommonComponents/Animator.sqf#L75)
## anim_isWalking

Type: function

Description: 


File: [host\CommonComponents\Animator.sqf at line 76](../../../Src/host/CommonComponents/Animator.sqf#L76)
## anim_syncAnim

Type: function

Description: 
- Param: _mob

File: [host\CommonComponents\Animator.sqf at line 78](../../../Src/host/CommonComponents/Animator.sqf#L78)
## anim_doAttack

Type: function

Description: 
- Param: _mob
- Param: _slotIdx
- Param: _enumAtt

File: [host\CommonComponents\Animator.sqf at line 233](../../../Src/host/CommonComponents/Animator.sqf#L233)
## anim_doDodge

Type: function

Description: 
- Param: _mob
- Param: _side

File: [host\CommonComponents\Animator.sqf at line 281](../../../Src/host/CommonComponents/Animator.sqf#L281)
## anim_doParry

Type: function

Description: 
- Param: _mob
- Param: _idxHand
- Param: _enumParry

File: [host\CommonComponents\Animator.sqf at line 301](../../../Src/host/CommonComponents/Animator.sqf#L301)
# Assert.sqf

## __vmthrow_assert(res)

Type: constant

Description: 
- Param: res

Replaced value:
```sqf
__vm_log(res); exitcode__ -100;
```
File: [host\CommonComponents\Assert.sqf at line 9](../../../Src/host/CommonComponents/Assert.sqf#L9)
## __vmthrow_assert_nothrow(res)

Type: constant

Description: 
- Param: res

Replaced value:
```sqf
__vm_log(res); if(true)exitwith{};
```
File: [host\CommonComponents\Assert.sqf at line 10](../../../Src/host/CommonComponents/Assert.sqf#L10)
## sys_int_evalassert

Type: function

Description: 
- Param: _value

File: [host\CommonComponents\Assert.sqf at line 12](../../../Src/host/CommonComponents/Assert.sqf#L12)
## sys_static_assert_

Type: function

Description: 
- Param: _expr (optional, default "NO_EXPR")
- Param: _module (optional, default "UNK_MODULE")
- Param: _line (optional, default 0)
- Param: _message (optional, default "")

File: [host\CommonComponents\Assert.sqf at line 25](../../../Src/host/CommonComponents/Assert.sqf#L25)
## sys_assert_

Type: function

Description: 
- Param: _expr (optional, default "NO_EXPR")
- Param: _module (optional, default "UNK_MODULE")
- Param: _line (optional, default 0)
- Param: _message (optional, default "")

File: [host\CommonComponents\Assert.sqf at line 89](../../../Src/host/CommonComponents/Assert.sqf#L89)
# AttackTypesAssoc.sqf

## ata_assoc_map

Type: Variable

Description: assoc for attack types


Initial value:
```sqf
createHashMap
```
File: [host\CommonComponents\AttackTypesAssoc.sqf at line 90](../../../Src/host/CommonComponents/AttackTypesAssoc.sqf#L90)
## ata_buf_process

Type: function

Description: эту функцию можно ускорить переделав выбор типа из хэшкарты
- Param: _ctx
- Param: _type
- Param: _mode

File: [host\CommonComponents\AttackTypesAssoc.sqf at line 12](../../../Src/host/CommonComponents/AttackTypesAssoc.sqf#L12)
# bitflags.sqf

## bitwise_and

Type: function

Description: 
- Param: _num1 (optional, default 0, expected types: ['0'])
- Param: _num2 (optional, default 0, expected types: ['0'])
- Param: _num1rem
- Param: _num2rem

File: [host\CommonComponents\bitflags.sqf at line 8](../../../Src/host/CommonComponents/bitflags.sqf#L8)
## bitwise_or

Type: function

Description: 
- Param: _num1 (optional, default 0, expected types: ['0'])
- Param: _num2 (optional, default 0, expected types: ['0'])
- Param: _num1rem
- Param: _num2rem

File: [host\CommonComponents\bitflags.sqf at line 29](../../../Src/host/CommonComponents/bitflags.sqf#L29)
## bitwise_xor

Type: function

Description: 
- Param: _num1 (optional, default 0, expected types: ['0'])
- Param: _num2 (optional, default 0, expected types: ['0'])
- Param: _num1rem
- Param: _num2rem

File: [host\CommonComponents\bitflags.sqf at line 48](../../../Src/host/CommonComponents/bitflags.sqf#L48)
## bitwise_not

Type: function

Description: 
- Param: _num (optional, default 0, expected types: ['0'])
- Param: _numrem

File: [host\CommonComponents\bitflags.sqf at line 67](../../../Src/host/CommonComponents/bitflags.sqf#L67)
## bit_set

Type: function

Description: 
- Param: _flagset
- Param: _flags

File: [host\CommonComponents\bitflags.sqf at line 84](../../../Src/host/CommonComponents/bitflags.sqf#L84)
## bit_unset

Type: function

Description: 
- Param: _flagset
- Param: _flags

File: [host\CommonComponents\bitflags.sqf at line 90](../../../Src/host/CommonComponents/bitflags.sqf#L90)
## bit_flip

Type: function

Description: 
- Param: _flagset
- Param: _flags

File: [host\CommonComponents\bitflags.sqf at line 96](../../../Src/host/CommonComponents/bitflags.sqf#L96)
## bit_check

Type: function

Description: 
- Param: _flagset
- Param: _flags

File: [host\CommonComponents\bitflags.sqf at line 102](../../../Src/host/CommonComponents/bitflags.sqf#L102)
## bit_toArray

Type: function

Description: 
- Param: _flags (optional, default 0)
- Param: _flag

File: [host\CommonComponents\bitflags.sqf at line 108](../../../Src/host/CommonComponents/bitflags.sqf#L108)
# Color.sqf

## importNative(funcname__)

Type: constant

Description: 
- Param: funcname__

Replaced value:
```sqf
BIS_fnc_##funcname__
```
File: [host\CommonComponents\Color.sqf at line 18](../../../Src/host/CommonComponents/Color.sqf#L18)
## color_diagfonts

Type: Variable

> Exists if **DEBUG** defined

Description: 


Initial value:
```sqf
importNative(3DENDiagFonts)
```
File: [host\CommonComponents\Color.sqf at line 20](../../../Src/host/CommonComponents/Color.sqf#L20)
## color_hexTable256

Type: Variable

Description: 


Initial value:
```sqf
[]
```
File: [host\CommonComponents\Color.sqf at line 42](../../../Src/host/CommonComponents/Color.sqf#L42)
## color_map_hexStrToNum

Type: Variable

Description: 


Initial value:
```sqf
createHashMap
```
File: [host\CommonComponents\Color.sqf at line 43](../../../Src/host/CommonComponents/Color.sqf#L43)
## color_RGBAtoHTML

Type: function

Description: свои
- Param: _r
- Param: _g
- Param: _b
- Param: _a

File: [host\CommonComponents\Color.sqf at line 57](../../../Src/host/CommonComponents/Color.sqf#L57)
## color_RGBtoHTML

Type: function

Description: 
- Param: _r
- Param: _g
- Param: _b

File: [host\CommonComponents\Color.sqf at line 69](../../../Src/host/CommonComponents/Color.sqf#L69)
## color_RGBAtoTex

Type: function

Description: 
- Param: _r
- Param: _g
- Param: _b
- Param: _a (optional, default 1)

File: [host\CommonComponents\Color.sqf at line 80](../../../Src/host/CommonComponents/Color.sqf#L80)
## color_HTMLtoRGBA

Type: function

Description: 
- Param: _html

File: [host\CommonComponents\Color.sqf at line 92](../../../Src/host/CommonComponents/Color.sqf#L92)
## color_HTMLtoRGB

Type: function

Description: 
- Param: _html

File: [host\CommonComponents\Color.sqf at line 114](../../../Src/host/CommonComponents/Color.sqf#L114)
# CombatMode.sqf

## cc_setCombatMode

Type: function

Description: 
- Param: _mob
- Param: _mode
- Param: _needSyncCameraAnim (optional, default false)
- Param: _doSkipApplyMove (optional, default false)

File: [host\CommonComponents\CombatMode.sqf at line 9](../../../Src/host/CommonComponents/CombatMode.sqf#L9)
# DateTime.sqf

## applyficator(val)

Type: constant

Description: 
- Param: val

Replaced value:
```sqf
(if (val < 10 && _zero) then {"0" + str val} else {str val})
```
File: [host\CommonComponents\DateTime.sqf at line 16](../../../Src/host/CommonComponents/DateTime.sqf#L16)
## dateTime_toString

Type: function

Description: Конвертация даты и времени в строку
- Param: _dt
- Param: _zero (optional, default false)
- Param: _outms (optional, default false)

File: [host\CommonComponents\DateTime.sqf at line 13](../../../Src/host/CommonComponents/DateTime.sqf#L13)
# loader.hpp

## importCommon(path)

Type: constant

> Exists if **__VM_BUILD** defined

Description: 
- Param: path

Replaced value:
```sqf
if (isNil {allClientContents}) then {allClientContents = [];}; \
	__vm_log("[LOAD] " + ("src\host\CommonComponents\" + path)); \
	_path = "src\host\CommonComponents\" + path; \
	private _ctx = compile ((__pragma_prep_cli _path)); \
	allClientContents pushback _ctx;
```
File: [host\CommonComponents\loader.hpp at line 10](../../../Src/host/CommonComponents/loader.hpp#L10)
## importCommon(path)

Type: constant

> Exists if **__VM_VALIDATE** defined

Description: 
- Param: path

Replaced value:
```sqf
diag_log format["Start validate common module %1",path]; \
	private _ctx = compile preprocessFileLineNumberS ("src\host\CommonComponents\" + path); \
	diag_log format["   - Module %1 loaded",path];
```
File: [host\CommonComponents\loader.hpp at line 18](../../../Src/host/CommonComponents/loader.hpp#L18)
# ModelsPath.sqf

## model_getAssoc

Type: function

Description: 
- Param: _value

File: [host\CommonComponents\ModelsPath.sqf at line 8](../../../Src/host/CommonComponents/ModelsPath.sqf#L8)
## model_convertPithBankYawToVec

Type: function

Description: 


File: [host\CommonComponents\ModelsPath.sqf at line 24](../../../Src/host/CommonComponents/ModelsPath.sqf#L24)
## model_SetPitchBankYaw

Type: function

Description: 
- Param: _object
- Param: _data

File: [host\CommonComponents\ModelsPath.sqf at line 63](../../../Src/host/CommonComponents/ModelsPath.sqf#L63)
## model_getPitchBankYaw

Type: function

Description: 
- Param: _vehicle

File: [host\CommonComponents\ModelsPath.sqf at line 69](../../../Src/host/CommonComponents/ModelsPath.sqf#L69)
## model_debug_dumpAllModels

Type: function

> Exists if **DEBUG** defined

Description: 


File: [host\CommonComponents\ModelsPath.sqf at line 75](../../../Src/host/CommonComponents/ModelsPath.sqf#L75)
# Pencfg.sqf

## addtobj(model,soundpen,armpen)

Type: constant

Description: 
- Param: model
- Param: soundpen
- Param: armpen

Replaced value:
```sqf
pencfg_map_all set [tolower model,[soundpen,armpen]]
```
File: [host\CommonComponents\Pencfg.sqf at line 13](../../../Src/host/CommonComponents/Pencfg.sqf#L13)
## pencfg_map_all

Type: Variable

Description: common data


Initial value:
```sqf
createHashMap
```
File: [host\CommonComponents\Pencfg.sqf at line 11](../../../Src/host/CommonComponents/Pencfg.sqf#L11)
## pencfg_isExistsModel

Type: function

Description: 


File: [host\CommonComponents\Pencfg.sqf at line 15](../../../Src/host/CommonComponents/Pencfg.sqf#L15)
## pencfg_handleVoice

Type: function

Description: 
- Param: _obj
- Param: _srcDist

File: [host\CommonComponents\Pencfg.sqf at line 21](../../../Src/host/CommonComponents/Pencfg.sqf#L21)
## pencfg_handleObject_canPenetrate

Type: function

Description: 
- Param: _obj

File: [host\CommonComponents\Pencfg.sqf at line 37](../../../Src/host/CommonComponents/Pencfg.sqf#L37)
# Replicator.sqf

## repl_map_funcs

Type: Variable

Description: 


Initial value:
```sqf
createHashMapFromArray [...
```
File: [host\CommonComponents\Replicator.sqf at line 8](../../../Src/host/CommonComponents/Replicator.sqf#L8)
# SMD_shared.sqf

## smd_getAnimValue

Type: function

Description: 
- Param: _mob
- Param: _slot
- Param: _animType (optional, default ANIM_INDEX_HANDED)

File: [host\CommonComponents\SMD_shared.sqf at line 11](../../../Src/host/CommonComponents/SMD_shared.sqf#L11)
## smd_isCombatModeEnabled

Type: function

Description: 
- Param: _mob

File: [host\CommonComponents\SMD_shared.sqf at line 19](../../../Src/host/CommonComponents/SMD_shared.sqf#L19)
## smd_isTwoHandedModeEnabled

Type: function

Description: 
- Param: _mob

File: [host\CommonComponents\SMD_shared.sqf at line 21](../../../Src/host/CommonComponents/SMD_shared.sqf#L21)
## smd_isCustomAnimationEnabled

Type: function

Description: 
- Param: _mob

File: [host\CommonComponents\SMD_shared.sqf at line 35](../../../Src/host/CommonComponents/SMD_shared.sqf#L35)
## smd_internal_generateCustomAnimation

Type: function

Description: 
- Param: _mob

File: [host\CommonComponents\SMD_shared.sqf at line 37](../../../Src/host/CommonComponents/SMD_shared.sqf#L37)
## smd_isSitting

Type: function

Description: 
- Param: _mob

File: [host\CommonComponents\SMD_shared.sqf at line 58](../../../Src/host/CommonComponents/SMD_shared.sqf#L58)
## smd_isLyingOnBed

Type: function

Description: 
- Param: _mob

File: [host\CommonComponents\SMD_shared.sqf at line 63](../../../Src/host/CommonComponents/SMD_shared.sqf#L63)
# SoundEngine.sqf

## SIMPLE_RUNTIME_PROCESS_SOUNDS

Type: constant

Description: Упрощённый режим симуляции звуков


Replaced value:
```sqf

```
File: [host\CommonComponents\SoundEngine.sqf at line 27](../../../Src/host/CommonComponents/SoundEngine.sqf#L27)
## soundGlobal_play

Type: function

Description: динамический источник звука, удаление невозможно. Публикуется по сети
- Param: _file
- Param: _source
- Param: _vol (optional, default 1)
- Param: _pitch (optional, default 1)
- Param: _maxDist (optional, default 20)
- Param: _soundExtension (optional, default "ogg")
- Param: _offset (optional, default 0)
- Param: _isLocal (optional, default false)
- Param: _isRTProcess (optional, default false)

File: [host\CommonComponents\SoundEngine.sqf at line 21](../../../Src/host/CommonComponents/SoundEngine.sqf#L21)
## soundLocal_play

Type: function

Description: Аналог soundGlobal::play() но без репликации по сети


File: [host\CommonComponents\SoundEngine.sqf at line 141](../../../Src/host/CommonComponents/SoundEngine.sqf#L141)
## soundUI_play

Type: function

Description: 
- Param: _file
- Param: _volume (optional, default 1)
- Param: _soundPitch (optional, default 1)
- Param: _isEffect (optional, default false)
- Param: _soundExtension (optional, default "ogg")

File: [host\CommonComponents\SoundEngine.sqf at line 147](../../../Src/host/CommonComponents/SoundEngine.sqf#L147)
# TransportLayer.sqf

## rpc_internal_regEnum_server

Type: function

Description: 
- Param: _enumName

File: [host\CommonComponents\TransportLayer.sqf at line 33](../../../Src/host/CommonComponents/TransportLayer.sqf#L33)
# Voice.sqf

## TF_ADDON_VERSION

Type: Variable

Description: 


Initial value:
```sqf
"TF RELICTA ADDON API 1.8"
```
File: [host\CommonComponents\Voice.sqf at line 8](../../../Src/host/CommonComponents/Voice.sqf#L8)
## vs_list_langs

Type: Variable

Description: список языков


Initial value:
```sqf
[...
```
File: [host\CommonComponents\Voice.sqf at line 10](../../../Src/host/CommonComponents/Voice.sqf#L10)
## vs_map_whohear

Type: Variable

Description: ["eater",["eater","human"]] -> жруны слышат жрунов и людей


Initial value:
```sqf
createHashMapFromArray [...
```
File: [host\CommonComponents\Voice.sqf at line 15](../../../Src/host/CommonComponents/Voice.sqf#L15)
# __notcompile__PerFrame.sqf

## PF_IND_CODE

Type: constant

Description: 	CUSTOM PERFRAME (DO NOT COMPILE)


Replaced value:
```sqf
0
```
File: [host\CommonComponents\__notcompile__PerFrame.sqf at line 177](../../../Src/host/CommonComponents/__notcompile__PerFrame.sqf#L177)
## PF_IND_DELAY

Type: constant

Description: 


Replaced value:
```sqf
1
```
File: [host\CommonComponents\__notcompile__PerFrame.sqf at line 178](../../../Src/host/CommonComponents/__notcompile__PerFrame.sqf#L178)
## PF_IND_ARGS

Type: constant

Description: 


Replaced value:
```sqf
2
```
File: [host\CommonComponents\__notcompile__PerFrame.sqf at line 179](../../../Src/host/CommonComponents/__notcompile__PerFrame.sqf#L179)
## PF_IND_DISPOSE

Type: constant

Description: 


Replaced value:
```sqf
3
```
File: [host\CommonComponents\__notcompile__PerFrame.sqf at line 13](../../../Src/host/CommonComponents/__notcompile__PerFrame.sqf#L13)
## sizeofnum

Type: constant

Description: 


Replaced value:
```sqf
1
```
File: [host\CommonComponents\__notcompile__PerFrame.sqf at line 22](../../../Src/host/CommonComponents/__notcompile__PerFrame.sqf#L22)
## fixed(num)

Type: constant

Description: 
- Param: num

Replaced value:
```sqf
(num toFixed sizeofnum)
```
File: [host\CommonComponents\__notcompile__PerFrame.sqf at line 23](../../../Src/host/CommonComponents/__notcompile__PerFrame.sqf#L23)
## fixnum(num)

Type: constant

Description: 
- Param: num

Replaced value:
```sqf
(parseNumber fixed(num))
```
File: [host\CommonComponents\__notcompile__PerFrame.sqf at line 24](../../../Src/host/CommonComponents/__notcompile__PerFrame.sqf#L24)
## _mapval

Type: constant

Description: 


Replaced value:
```sqf
_y
```
File: [host\CommonComponents\__notcompile__PerFrame.sqf at line 32](../../../Src/host/CommonComponents/__notcompile__PerFrame.sqf#L32)
## PF_IND_DISPOS

Type: constant

Description: 


Replaced value:
```sqf
3
```
File: [host\CommonComponents\__notcompile__PerFrame.sqf at line 13](../../../Src/host/CommonComponents/__notcompile__PerFrame.sqf#L13)
## pointfloat

Type: constant

Description: 


Replaced value:
```sqf
2
```
File: [host\CommonComponents\__notcompile__PerFrame.sqf at line 182](../../../Src/host/CommonComponents/__notcompile__PerFrame.sqf#L182)
## fixefize(numb)

Type: constant

Description: 
- Param: numb

Replaced value:
```sqf
numb
```
File: [host\CommonComponents\__notcompile__PerFrame.sqf at line 184](../../../Src/host/CommonComponents/__notcompile__PerFrame.sqf#L184)
## maxtime

Type: constant

Description: 


Replaced value:
```sqf
5
```
File: [host\CommonComponents\__notcompile__PerFrame.sqf at line 274](../../../Src/host/CommonComponents/__notcompile__PerFrame.sqf#L274)
## pf_hash

Type: Variable

Description: 


Initial value:
```sqf
createHashMap
```
File: [host\CommonComponents\__notcompile__PerFrame.sqf at line 8](../../../Src/host/CommonComponents/__notcompile__PerFrame.sqf#L8)
## pf_addTimer

Type: function

Description: 
- Param: _code
- Param: _delay
- Param: _args

File: [host\CommonComponents\__notcompile__PerFrame.sqf at line 86](../../../Src/host/CommonComponents/__notcompile__PerFrame.sqf#L86)
## pf_removeTimer

Type: function

Description: 
- Param: _handle

File: [host\CommonComponents\__notcompile__PerFrame.sqf at line 101](../../../Src/host/CommonComponents/__notcompile__PerFrame.sqf#L101)
## pf_changeTimerInterval

Type: function

Description: 
- Param: _handle
- Param: _newDelay

File: [host\CommonComponents\__notcompile__PerFrame.sqf at line 108](../../../Src/host/CommonComponents/__notcompile__PerFrame.sqf#L108)
## pf_performanceTest

Type: function

Description: 
- Param: _isPF (optional, default false)
- Param: _amounter (optional, default 1000)
- Param: _delay (optional, default 0.1)

File: [host\CommonComponents\__notcompile__PerFrame.sqf at line 113](../../../Src/host/CommonComponents/__notcompile__PerFrame.sqf#L113)
## pf_add

Type: function

Description: 
- Param: _code
- Param: _delay
- Param: _args (optional, default 0)

File: [host\CommonComponents\__notcompile__PerFrame.sqf at line 250](../../../Src/host/CommonComponents/__notcompile__PerFrame.sqf#L250)
## pf_getworks

Type: function

Description: 


File: [host\CommonComponents\__notcompile__PerFrame.sqf at line 263](../../../Src/host/CommonComponents/__notcompile__PerFrame.sqf#L263)
## pf_test

Type: function

Description: 
- Param: _isHashed
- Param: _counter

File: [host\CommonComponents\__notcompile__PerFrame.sqf at line 272](../../../Src/host/CommonComponents/__notcompile__PerFrame.sqf#L272)
