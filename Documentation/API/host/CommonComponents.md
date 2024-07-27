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
## STRUCT_INIT_FUNCTIONS

Type: constant

Description: 


Replaced value:
```sqf

```
File: [host\CommonComponents\!PreInit.sqf at line 110](../../../Src/host/CommonComponents/!PreInit.sqf#L110)
## __ptr_size__

Type: constant

Description: 


Replaced value:
```sqf
8
```
File: [host\CommonComponents\!PreInit.sqf at line 150](../../../Src/host/CommonComponents/!PreInit.sqf#L150)
## __num_size__

Type: constant

Description: 


Replaced value:
```sqf
8
```
File: [host\CommonComponents\!PreInit.sqf at line 151](../../../Src/host/CommonComponents/!PreInit.sqf#L151)
## __vector_size__

Type: constant

Description: 


Replaced value:
```sqf
24
```
File: [host\CommonComponents\!PreInit.sqf at line 152](../../../Src/host/CommonComponents/!PreInit.sqf#L152)
## __map_size__

Type: constant

Description: 


Replaced value:
```sqf
48
```
File: [host\CommonComponents\!PreInit.sqf at line 153](../../../Src/host/CommonComponents/!PreInit.sqf#L153)
## C_PTR_REALOC_SIZE

Type: constant

Description: allocated before realoc ( not used now...)


Replaced value:
```sqf
1024
```
File: [host\CommonComponents\!PreInit.sqf at line 187](../../../Src/host/CommonComponents/!PreInit.sqf#L187)
## C_PTR_BYTE_SITE

Type: constant

Description: 


Replaced value:
```sqf
4
```
File: [host\CommonComponents\!PreInit.sqf at line 188](../../../Src/host/CommonComponents/!PreInit.sqf#L188)
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
File: [host\CommonComponents\!PreInit.sqf at line 537](../../../Src/host/CommonComponents/!PreInit.sqf#L537)
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
File: [host\CommonComponents\!PreInit.sqf at line 113](../../../Src/host/CommonComponents/!PreInit.sqf#L113)
## hashMapNull

Type: Variable

Description: init thread pool


Initial value:
```sqf
createHashMapFromArray [["__NULL_HASH_MAP__","__NULL_HASH_MAP__"]]
```
File: [host\CommonComponents\!PreInit.sqf at line 114](../../../Src/host/CommonComponents/!PreInit.sqf#L114)
## table_hex

Type: Variable

Description: 


Initial value:
```sqf
"0123456789abcdef"splitString stringEmpty
```
File: [host\CommonComponents\!PreInit.sqf at line 116](../../../Src/host/CommonComponents/!PreInit.sqf#L116)
## ptr_i_mctr

Type: Variable

Description: 


Initial value:
```sqf
1//internal memory counter
```
File: [host\CommonComponents\!PreInit.sqf at line 185](../../../Src/host/CommonComponents/!PreInit.sqf#L185)
## ptr_i_al

Type: Variable

Description: internal memory counter


Initial value:
```sqf
0 //allocated before realoc ( not used now...)
```
File: [host\CommonComponents\!PreInit.sqf at line 186](../../../Src/host/CommonComponents/!PreInit.sqf#L186)
## ptr_cnl

Type: Variable

Description: 


Initial value:
```sqf
__ptr_struct_internal__(str ptr_i_mctr,0) //null pointer
```
File: [host\CommonComponents\!PreInit.sqf at line 189](../../../Src/host/CommonComponents/!PreInit.sqf#L189)
## ptr_htable

Type: Variable

Description: null pointer


Initial value:
```sqf
createHashMap
```
File: [host\CommonComponents\!PreInit.sqf at line 190](../../../Src/host/CommonComponents/!PreInit.sqf#L190)
## ptr_i_hex__

Type: Variable

Description: 


Initial value:
```sqf
"0123456789abcdef"splitString stringEmpty
```
File: [host\CommonComponents\!PreInit.sqf at line 208](../../../Src/host/CommonComponents/!PreInit.sqf#L208)
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

File: [host\CommonComponents\!PreInit.sqf at line 118](../../../Src/host/CommonComponents/!PreInit.sqf#L118)
## rv_cppcheck

Type: function

Description: if (isValid(nullPtr)) then {} else {};
- Param: _val

File: [host\CommonComponents\!PreInit.sqf at line 137](../../../Src/host/CommonComponents/!PreInit.sqf#L137)
## rv_sizeOf

Type: function

Description: 


File: [host\CommonComponents\!PreInit.sqf at line 149](../../../Src/host/CommonComponents/!PreInit.sqf#L149)
## ptr_create

Type: function

Description: initialize new pointer


File: [host\CommonComponents\!PreInit.sqf at line 194](../../../Src/host/CommonComponents/!PreInit.sqf#L194)
## ptr_destroy

Type: function

Description: delete pointer if not null


File: [host\CommonComponents\!PreInit.sqf at line 200](../../../Src/host/CommonComponents/!PreInit.sqf#L200)
## ptr_cts

Type: function

Description: convert to string
- Param: _p

File: [host\CommonComponents\!PreInit.sqf at line 211](../../../Src/host/CommonComponents/!PreInit.sqf#L211)
## ptr_remval

Type: function

Description: 


File: [host\CommonComponents\!PreInit.sqf at line 243](../../../Src/host/CommonComponents/!PreInit.sqf#L243)
## ptr_check

Type: function

Description: 


File: [host\CommonComponents\!PreInit.sqf at line 249](../../../Src/host/CommonComponents/!PreInit.sqf#L249)
## toNumeralString

Type: function

Description: Склоняет слова в числительное
- Param: _number
- Param: _counter (optional, default ['"Штука"', '"Штуки"', '"Штук"'])
- Param: _addNumToText (optional, default false)

File: [host\CommonComponents\!PreInit.sqf at line 256](../../../Src/host/CommonComponents/!PreInit.sqf#L256)
## regex_isMatch

Type: function

Description: ==================================================================================================
- Param: _txt
- Param: _pattern

File: [host\CommonComponents\!PreInit.sqf at line 270](../../../Src/host/CommonComponents/!PreInit.sqf#L270)
## regex_getFirstMatch

Type: function

Description: 
- Param: _txt
- Param: _pattern
- Param: _optMath (optional, default 0)

File: [host\CommonComponents\!PreInit.sqf at line 276](../../../Src/host/CommonComponents/!PreInit.sqf#L276)
## regex_replace

Type: function

Description: 
- Param: _txt
- Param: _pattern
- Param: _replacer

File: [host\CommonComponents\!PreInit.sqf at line 283](../../../Src/host/CommonComponents/!PreInit.sqf#L283)
## stringStartWith

Type: function

Description: Строковые хелперы
- Param: _checked
- Param: _started
- Param: _casesense (optional, default true)

File: [host\CommonComponents\!PreInit.sqf at line 338](../../../Src/host/CommonComponents/!PreInit.sqf#L338)
## stringEndWith

Type: function

Description: 
- Param: _checked
- Param: _ended
- Param: _casesense (optional, default true)

File: [host\CommonComponents\!PreInit.sqf at line 344](../../../Src/host/CommonComponents/!PreInit.sqf#L344)
## stringReplace

Type: function

Description: 
- Param: _string (optional, default "")
- Param: _find (optional, default "")
- Param: _replace (optional, default "")

File: [host\CommonComponents\!PreInit.sqf at line 351](../../../Src/host/CommonComponents/!PreInit.sqf#L351)
## selectBest

Type: function

Description: Выбирает лучший случай [[1,2,3],{_x > 2}] call selectBest
- Param: _array
- Param: _criteria
- Param: _return

File: [host\CommonComponents\!PreInit.sqf at line 370](../../../Src/host/CommonComponents/!PreInit.sqf#L370)
## searchInList

Type: function

Description: 
- Param: _list
- Param: _lambda
- Param: _defaultReturn

File: [host\CommonComponents\!PreInit.sqf at line 386](../../../Src/host/CommonComponents/!PreInit.sqf#L386)
## arrayDeleteItem

Type: function

Description: 
- Param: _a
- Param: _it

File: [host\CommonComponents\!PreInit.sqf at line 393](../../../Src/host/CommonComponents/!PreInit.sqf#L393)
## arrayIsValidIndex

Type: function

Description: 
- Param: _a
- Param: _ix

File: [host\CommonComponents\!PreInit.sqf at line 400](../../../Src/host/CommonComponents/!PreInit.sqf#L400)
## arrayShuffleOrig

Type: function

Description: shuffle array elements, return alter array
- Param: _array

File: [host\CommonComponents\!PreInit.sqf at line 406](../../../Src/host/CommonComponents/!PreInit.sqf#L406)
## arraySwap

Type: function

Description: swap 2 elements in array
- Param: _a
- Param: _is
- Param: _id

File: [host\CommonComponents\!PreInit.sqf at line 418](../../../Src/host/CommonComponents/!PreInit.sqf#L418)
## stringLength

Type: function

Description: 
- Param: _str
- Param: _unicode (optional, default true)

File: [host\CommonComponents\!PreInit.sqf at line 425](../../../Src/host/CommonComponents/!PreInit.sqf#L425)
## stringSelect

Type: function

Description: 
- Param: _s
- Param: _i
- Param: _c

File: [host\CommonComponents\!PreInit.sqf at line 435](../../../Src/host/CommonComponents/!PreInit.sqf#L435)
## randomFloat

Type: function

Description: 
- Param: _beg
- Param: _end

File: [host\CommonComponents\!PreInit.sqf at line 441](../../../Src/host/CommonComponents/!PreInit.sqf#L441)
## randomInt

Type: function

Description: 
- Param: _beg
- Param: _end

File: [host\CommonComponents\!PreInit.sqf at line 446](../../../Src/host/CommonComponents/!PreInit.sqf#L446)
## randomProbably

Type: function

Description: 
- Param: _v

File: [host\CommonComponents\!PreInit.sqf at line 451](../../../Src/host/CommonComponents/!PreInit.sqf#L451)
## getPrecentage

Type: function

Description: 
- Param: _checkedval
- Param: _pval

File: [host\CommonComponents\!PreInit.sqf at line 456](../../../Src/host/CommonComponents/!PreInit.sqf#L456)
## clampNumber

Type: function

Description: 
- Param: _v
- Param: _mi
- Param: _ma

File: [host\CommonComponents\!PreInit.sqf at line 461](../../../Src/host/CommonComponents/!PreInit.sqf#L461)
## stringFormat

Type: function

Description: 
- Param: _fmt
- Param: _val
- Param: _breakArr (optional, default false)

File: [host\CommonComponents\!PreInit.sqf at line 466](../../../Src/host/CommonComponents/!PreInit.sqf#L466)
## getPosListCenter

Type: function

Description: 
- Param: _poses (optional, default [])
- Param: _dummyParam

File: [host\CommonComponents\!PreInit.sqf at line 482](../../../Src/host/CommonComponents/!PreInit.sqf#L482)
## randomRadius

Type: function

Description: Специальный рандом по области. Чем ближе к центру тем выше вероятность. Распределение идёт по всей окружности.
- Param: _center
- Param: _radius

File: [host\CommonComponents\!PreInit.sqf at line 498](../../../Src/host/CommonComponents/!PreInit.sqf#L498)
## randomPosition

Type: function

Description: Специальный рандом по области. Равномерное распределение по позиции в радиусе.
- Param: _center
- Param: _radius

File: [host\CommonComponents\!PreInit.sqf at line 504](../../../Src/host/CommonComponents/!PreInit.sqf#L504)
## randomGaussian

Type: function

Description: Специальный рандом по области. Распределение идёт ближе к центру. Чем ближе к центру тем выше вероятность.
- Param: _center
- Param: _radius

File: [host\CommonComponents\!PreInit.sqf at line 510](../../../Src/host/CommonComponents/!PreInit.sqf#L510)
## functionalitests_preinit

Type: function

> Exists if **__ENABLE_STATIC_TEST** defined

Description: 


File: [host\CommonComponents\!PreInit.sqf at line 536](../../../Src/host/CommonComponents/!PreInit.sqf#L536)
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

> Exists if **ANIMATOR_EDITOR** not defined

Description: 
- Param: name

Replaced value:
```sqf
INC(__animIndex); anim_assocList_keyString set [name,__animIndex]; anim_assocList_keyInt set [__animIndex,name]
```
File: [host\CommonComponents\Animator.sqf at line 11](../../../Src/host/CommonComponents/Animator.sqf#L11)
## __compareanims(idx)

Type: constant

Description: 
- Param: idx

Replaced value:
```sqf
((_anims select idx) == "nl" && ((_blender select idx) == 1))
```
File: [host\CommonComponents\Animator.sqf at line 224](../../../Src/host/CommonComponents/Animator.sqf#L224)
## anim_assocList_keyString

Type: Variable

> Exists if **ANIMATOR_EDITOR** not defined

Description: 


Initial value:
```sqf
createHashMap 
```
File: [host\CommonComponents\Animator.sqf at line 12](../../../Src/host/CommonComponents/Animator.sqf#L12)
## anim_assocList_keyInt

Type: Variable

Description: 


Initial value:
```sqf
createHashMap
```
File: [host\CommonComponents\Animator.sqf at line 13](../../../Src/host/CommonComponents/Animator.sqf#L13)
## anim_getAssoc

Type: function

> Exists if **ANIMATOR_EDITOR** not defined

Description: конвертор ассоциаций
- Param: _value

File: [host\CommonComponents\Animator.sqf at line 28](../../../Src/host/CommonComponents/Animator.sqf#L28)
## anim_getUnitAnim

Type: function

Description: 


File: [host\CommonComponents\Animator.sqf at line 75](../../../Src/host/CommonComponents/Animator.sqf#L75)
## anim_isSprinting

Type: function

Description: 
- Param: _anm

File: [host\CommonComponents\Animator.sqf at line 77](../../../Src/host/CommonComponents/Animator.sqf#L77)
## anim_isRunning

Type: function

Description: 
- Param: _anm

File: [host\CommonComponents\Animator.sqf at line 78](../../../Src/host/CommonComponents/Animator.sqf#L78)
## anim_isWalking

Type: function

Description: 


File: [host\CommonComponents\Animator.sqf at line 79](../../../Src/host/CommonComponents/Animator.sqf#L79)
## anim_syncAnim

Type: function

Description: 
- Param: _mob

File: [host\CommonComponents\Animator.sqf at line 81](../../../Src/host/CommonComponents/Animator.sqf#L81)
## anim_doAttack

Type: function

Description: 
- Param: _mob
- Param: _slotIdx
- Param: _enumAtt

File: [host\CommonComponents\Animator.sqf at line 238](../../../Src/host/CommonComponents/Animator.sqf#L238)
## anim_doDodge

Type: function

Description: 
- Param: _mob
- Param: _side

File: [host\CommonComponents\Animator.sqf at line 288](../../../Src/host/CommonComponents/Animator.sqf#L288)
## anim_doParry

Type: function

Description: 
- Param: _mob
- Param: _idxHand
- Param: _enumParry

File: [host\CommonComponents\Animator.sqf at line 308](../../../Src/host/CommonComponents/Animator.sqf#L308)
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
# io.sqf

## ASCII_COLON

Type: constant

Description: 


Replaced value:
```sqf
58
```
File: [host\CommonComponents\io.sqf at line 14](../../../Src/host/CommonComponents/io.sqf#L14)
## ASCII_MINUS

Type: constant

Description: 


Replaced value:
```sqf
45
```
File: [host\CommonComponents\io.sqf at line 15](../../../Src/host/CommonComponents/io.sqf#L15)
## ASCII_HASH

Type: constant

Description: 


Replaced value:
```sqf
35
```
File: [host\CommonComponents\io.sqf at line 16](../../../Src/host/CommonComponents/io.sqf#L16)
## ASCII_VERTICAL_BAR

Type: constant

Description: 


Replaced value:
```sqf
124
```
File: [host\CommonComponents\io.sqf at line 17](../../../Src/host/CommonComponents/io.sqf#L17)
## ASCII_NEWLINE

Type: constant

Description: 


Replaced value:
```sqf
10
```
File: [host\CommonComponents\io.sqf at line 19](../../../Src/host/CommonComponents/io.sqf#L19)
## ASCII_CR

Type: constant

Description: 


Replaced value:
```sqf
13
```
File: [host\CommonComponents\io.sqf at line 20](../../../Src/host/CommonComponents/io.sqf#L20)
## ASCII_TAB

Type: constant

Description: 


Replaced value:
```sqf
9
```
File: [host\CommonComponents\io.sqf at line 21](../../../Src/host/CommonComponents/io.sqf#L21)
## ASCII_SPACE

Type: constant

Description: 


Replaced value:
```sqf
32
```
File: [host\CommonComponents\io.sqf at line 22](../../../Src/host/CommonComponents/io.sqf#L22)
## WHITE_SPACE

Type: constant

Description: White-space, used by the SPON_stringTrim* functions.


Replaced value:
```sqf
[ASCII_TAB, ASCII_SPACE, ASCII_NEWLINE, ASCII_CR]
```
File: [host\CommonComponents\io.sqf at line 25](../../../Src/host/CommonComponents/io.sqf#L25)
## YAML_MODE_STRING

Type: constant

Description: 


Replaced value:
```sqf
0
```
File: [host\CommonComponents\io.sqf at line 27](../../../Src/host/CommonComponents/io.sqf#L27)
## YAML_MODE_ASSOC_KEY

Type: constant

Description: 


Replaced value:
```sqf
1
```
File: [host\CommonComponents\io.sqf at line 28](../../../Src/host/CommonComponents/io.sqf#L28)
## YAML_MODE_ASSOC_VALUE

Type: constant

Description: 


Replaced value:
```sqf
2
```
File: [host\CommonComponents\io.sqf at line 29](../../../Src/host/CommonComponents/io.sqf#L29)
## YAML_MODE_ARRAY

Type: constant

Description: 


Replaced value:
```sqf
3
```
File: [host\CommonComponents\io.sqf at line 30](../../../Src/host/CommonComponents/io.sqf#L30)
## YAML_TYPE_UNKNOWN

Type: constant

Description: 


Replaced value:
```sqf
0
```
File: [host\CommonComponents\io.sqf at line 32](../../../Src/host/CommonComponents/io.sqf#L32)
## YAML_TYPE_SCALAR

Type: constant

Description: 


Replaced value:
```sqf
1
```
File: [host\CommonComponents\io.sqf at line 33](../../../Src/host/CommonComponents/io.sqf#L33)
## YAML_TYPE_ARRAY

Type: constant

Description: 


Replaced value:
```sqf
2
```
File: [host\CommonComponents\io.sqf at line 34](../../../Src/host/CommonComponents/io.sqf#L34)
## YAML_TYPE_ASSOC

Type: constant

Description: 


Replaced value:
```sqf
3
```
File: [host\CommonComponents\io.sqf at line 35](../../../Src/host/CommonComponents/io.sqf#L35)
## ASCII_YAML_COMMENT

Type: constant

Description: 


Replaced value:
```sqf
ASCII_HASH
```
File: [host\CommonComponents\io.sqf at line 37](../../../Src/host/CommonComponents/io.sqf#L37)
## ASCII_YAML_ASSOC

Type: constant

Description: 


Replaced value:
```sqf
ASCII_COLON
```
File: [host\CommonComponents\io.sqf at line 38](../../../Src/host/CommonComponents/io.sqf#L38)
## ASCII_YAML_ARRAY

Type: constant

Description: 


Replaced value:
```sqf
ASCII_MINUS
```
File: [host\CommonComponents\io.sqf at line 39](../../../Src/host/CommonComponents/io.sqf#L39)
## DEFAULT_INTEGER_WIDTH

Type: constant

Description: 


Replaced value:
```sqf
1
```
File: [host\CommonComponents\io.sqf at line 74](../../../Src/host/CommonComponents/io.sqf#L74)
## DEFAULT_DECIMAL_PLACES

Type: constant

Description: 


Replaced value:
```sqf
0
```
File: [host\CommonComponents\io.sqf at line 75](../../../Src/host/CommonComponents/io.sqf#L75)
## DEFAULT_SEPARATE_THOUSANDS

Type: constant

Description: 


Replaced value:
```sqf
false
```
File: [host\CommonComponents\io.sqf at line 76](../../../Src/host/CommonComponents/io.sqf#L76)
## io_praseYaml

Type: function

Description: from CBA_fnc_parseYAML
- Param: _file
- Param: _loadFromString (optional, default false)

File: [host\CommonComponents\io.sqf at line 42](../../../Src/host/CommonComponents/io.sqf#L42)
## io_yml_formatNumber

Type: function

Description: cba_fnc_formatNumber
- Param: _number
- Param: _integerWidth (optional, default DEFAULT_INTEGER_WIDTH)
- Param: _decimalPlaces (optional, default DEFAULT_DECIMAL_PLACES)
- Param: _separateThousands (optional, default DEFAULT_SEPARATE_THOUSANDS)

File: [host\CommonComponents\io.sqf at line 72](../../../Src/host/CommonComponents/io.sqf#L72)
## io_yml_raiseError

Type: function

Description: 
- Param: _message
- Param: _yaml
- Param: _pos
- Param: _lines

File: [host\CommonComponents\io.sqf at line 108](../../../Src/host/CommonComponents/io.sqf#L108)
## io_yml_parse

Type: function

Description: 
- Param: _yaml
- Param: _pos
- Param: _indent
- Param: _lines

File: [host\CommonComponents\io.sqf at line 145](../../../Src/host/CommonComponents/io.sqf#L145)
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
## model_debug_dumpAllModels

Type: function

> Exists if **DEBUG** defined

Description: 


File: [host\CommonComponents\ModelsPath.sqf at line 27](../../../Src/host/CommonComponents/ModelsPath.sqf#L27)
# ModelTransform.hpp

## model_convertPithBankYawToVec

Type: function

Description: 


File: [host\CommonComponents\ModelTransform.hpp at line 6](../../../Src/host/CommonComponents/ModelTransform.hpp#L6)
## model_SetPitchBankYaw

Type: function

Description: 
- Param: _object
- Param: _data

File: [host\CommonComponents\ModelTransform.hpp at line 45](../../../Src/host/CommonComponents/ModelTransform.hpp#L45)
## model_getPitchBankYaw

Type: function

Description: 
- Param: _vehicle

File: [host\CommonComponents\ModelTransform.hpp at line 51](../../../Src/host/CommonComponents/ModelTransform.hpp#L51)
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
# Allocator.sqf

## mmr_allocator_s

Type: Variable

Description: only one reference to allocator


Initial value:
```sqf
null
```
File: [host\CommonComponents\Structs\Allocator.sqf at line 7](../../../Src/host/CommonComponents/Structs/Allocator.sqf#L7)
# Pointers.sqf

## sref_cont

Type: Variable

Description: Safe reference. Used for bypass crossreferences and possible memory leaks


Initial value:
```sqf
createHashMap
```
File: [host\CommonComponents\Structs\Pointers.sqf at line 7](../../../Src/host/CommonComponents/Structs/Pointers.sqf#L7)
## sref_i

Type: Variable

Description: 


Initial value:
```sqf
0
```
File: [host\CommonComponents\Structs\Pointers.sqf at line 8](../../../Src/host/CommonComponents/Structs/Pointers.sqf#L8)
# Profiling.sqf

## prof_map_zones

Type: Variable

Description: PROFILING


Initial value:
```sqf
createHashMap
```
File: [host\CommonComponents\Structs\Profiling.sqf at line 10](../../../Src/host/CommonComponents/Structs/Profiling.sqf#L10)
