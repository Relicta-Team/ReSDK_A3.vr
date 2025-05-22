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
File: [host\CommonComponents\!PreInit.sqf at line 81](../../../Src/host/CommonComponents/!PreInit.sqf#L81)
## STRUCT_INIT_FUNCTIONS

Type: constant

Description: 


Replaced value:
```sqf

```
File: [host\CommonComponents\!PreInit.sqf at line 126](../../../Src/host/CommonComponents/!PreInit.sqf#L126)
## __ptr_size__

Type: constant

Description: 


Replaced value:
```sqf
8
```
File: [host\CommonComponents\!PreInit.sqf at line 166](../../../Src/host/CommonComponents/!PreInit.sqf#L166)
## __num_size__

Type: constant

Description: 


Replaced value:
```sqf
8
```
File: [host\CommonComponents\!PreInit.sqf at line 167](../../../Src/host/CommonComponents/!PreInit.sqf#L167)
## __vector_size__

Type: constant

Description: 


Replaced value:
```sqf
24
```
File: [host\CommonComponents\!PreInit.sqf at line 168](../../../Src/host/CommonComponents/!PreInit.sqf#L168)
## __map_size__

Type: constant

Description: 


Replaced value:
```sqf
48
```
File: [host\CommonComponents\!PreInit.sqf at line 169](../../../Src/host/CommonComponents/!PreInit.sqf#L169)
## C_PTR_REALOC_SIZE

Type: constant

Description: allocated before realoc ( not used now...)


Replaced value:
```sqf
1024
```
File: [host\CommonComponents\!PreInit.sqf at line 203](../../../Src/host/CommonComponents/!PreInit.sqf#L203)
## C_PTR_BYTE_SITE

Type: constant

Description: 


Replaced value:
```sqf
4
```
File: [host\CommonComponents\!PreInit.sqf at line 204](../../../Src/host/CommonComponents/!PreInit.sqf#L204)
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
File: [host\CommonComponents\!PreInit.sqf at line 129](../../../Src/host/CommonComponents/!PreInit.sqf#L129)
## hashMapNull

Type: Variable

Description: init thread pool


Initial value:
```sqf
createHashMapFromArray [["__NULL_HASH_MAP__","__NULL_HASH_MAP__"]]
```
File: [host\CommonComponents\!PreInit.sqf at line 130](../../../Src/host/CommonComponents/!PreInit.sqf#L130)
## table_hex

Type: Variable

Description: 


Initial value:
```sqf
"0123456789abcdef"splitString stringEmpty
```
File: [host\CommonComponents\!PreInit.sqf at line 132](../../../Src/host/CommonComponents/!PreInit.sqf#L132)
## ptr_i_mctr

Type: Variable

Description: 


Initial value:
```sqf
1//internal memory counter
```
File: [host\CommonComponents\!PreInit.sqf at line 201](../../../Src/host/CommonComponents/!PreInit.sqf#L201)
## ptr_i_al

Type: Variable

Description: internal memory counter


Initial value:
```sqf
0 //allocated before realoc ( not used now...)
```
File: [host\CommonComponents\!PreInit.sqf at line 202](../../../Src/host/CommonComponents/!PreInit.sqf#L202)
## ptr_cnl

Type: Variable

Description: 


Initial value:
```sqf
__ptr_struct_internal__(str ptr_i_mctr,0) //null pointer
```
File: [host\CommonComponents\!PreInit.sqf at line 205](../../../Src/host/CommonComponents/!PreInit.sqf#L205)
## ptr_htable

Type: Variable

Description: null pointer


Initial value:
```sqf
createHashMap
```
File: [host\CommonComponents\!PreInit.sqf at line 206](../../../Src/host/CommonComponents/!PreInit.sqf#L206)
## ptr_i_hex__

Type: Variable

Description: 


Initial value:
```sqf
"0123456789abcdef"splitString stringEmpty
```
File: [host\CommonComponents\!PreInit.sqf at line 224](../../../Src/host/CommonComponents/!PreInit.sqf#L224)
## client_sendNotifToServer

Type: function

Description: 
- Param: _mes

File: [host\CommonComponents\!PreInit.sqf at line 25](../../../Src/host/CommonComponents/!PreInit.sqf#L25)
## stdoutPrint

Type: function

Description: ["PREFIX","message %1, arg %2, last %3",...,...] call stdoutPrint
- Param: _args

File: [host\CommonComponents\!PreInit.sqf at line 40](../../../Src/host/CommonComponents/!PreInit.sqf#L40)
## cprint

Type: function

Description: 


File: [host\CommonComponents\!PreInit.sqf at line 48](../../../Src/host/CommonComponents/!PreInit.sqf#L48)
## cprintErr

Type: function

Description: 


File: [host\CommonComponents\!PreInit.sqf at line 64](../../../Src/host/CommonComponents/!PreInit.sqf#L64)
## cprintWarn

Type: function

Description: 


File: [host\CommonComponents\!PreInit.sqf at line 80](../../../Src/host/CommonComponents/!PreInit.sqf#L80)
## rpc_addEventGlobal

Type: function

Description: 
- Param: _eventName
- Param: _eventCode

File: [host\CommonComponents\!PreInit.sqf at line 134](../../../Src/host/CommonComponents/!PreInit.sqf#L134)
## rv_cppcheck

Type: function

Description: if (isValid(nullPtr)) then {} else {};
- Param: _val

File: [host\CommonComponents\!PreInit.sqf at line 153](../../../Src/host/CommonComponents/!PreInit.sqf#L153)
## rv_sizeOf

Type: function

Description: 


File: [host\CommonComponents\!PreInit.sqf at line 165](../../../Src/host/CommonComponents/!PreInit.sqf#L165)
## ptr_create

Type: function

Description: initialize new pointer


File: [host\CommonComponents\!PreInit.sqf at line 210](../../../Src/host/CommonComponents/!PreInit.sqf#L210)
## ptr_destroy

Type: function

Description: delete pointer if not null


File: [host\CommonComponents\!PreInit.sqf at line 216](../../../Src/host/CommonComponents/!PreInit.sqf#L216)
## ptr_cts

Type: function

Description: convert to string
- Param: _p

File: [host\CommonComponents\!PreInit.sqf at line 227](../../../Src/host/CommonComponents/!PreInit.sqf#L227)
## ptr_remval

Type: function

Description: 


File: [host\CommonComponents\!PreInit.sqf at line 259](../../../Src/host/CommonComponents/!PreInit.sqf#L259)
## ptr_check

Type: function

Description: 


File: [host\CommonComponents\!PreInit.sqf at line 265](../../../Src/host/CommonComponents/!PreInit.sqf#L265)
## toNumeralString

Type: function

Description: Склоняет слова в числительное
- Param: _number
- Param: _counter (optional, default ['"Штука"', '"Штуки"', '"Штук"'])
- Param: _addNumToText (optional, default false)

File: [host\CommonComponents\!PreInit.sqf at line 272](../../../Src/host/CommonComponents/!PreInit.sqf#L272)
## regex_isMatch

Type: function

Description: ==================================================================================================
- Param: _txt
- Param: _pattern

File: [host\CommonComponents\!PreInit.sqf at line 286](../../../Src/host/CommonComponents/!PreInit.sqf#L286)
## regex_getFirstMatch

Type: function

Description: 
- Param: _txt
- Param: _pattern
- Param: _optMath (optional, default 0)

File: [host\CommonComponents\!PreInit.sqf at line 292](../../../Src/host/CommonComponents/!PreInit.sqf#L292)
## regex_getMatches

Type: function

Description: 
- Param: _txt
- Param: _pattern
- Param: _optMath (optional, default 0)

File: [host\CommonComponents\!PreInit.sqf at line 299](../../../Src/host/CommonComponents/!PreInit.sqf#L299)
## regex_replace

Type: function

Description: 
- Param: _txt
- Param: _pattern
- Param: _replacer

File: [host\CommonComponents\!PreInit.sqf at line 310](../../../Src/host/CommonComponents/!PreInit.sqf#L310)
## stringStartWith

Type: function

Description: Строковые хелперы
- Param: _checked
- Param: _started
- Param: _casesense (optional, default true)

File: [host\CommonComponents\!PreInit.sqf at line 362](../../../Src/host/CommonComponents/!PreInit.sqf#L362)
## stringEndWith

Type: function

Description: 
- Param: _checked
- Param: _ended
- Param: _casesense (optional, default true)

File: [host\CommonComponents\!PreInit.sqf at line 368](../../../Src/host/CommonComponents/!PreInit.sqf#L368)
## stringReplace

Type: function

Description: 
- Param: _string (optional, default "")
- Param: _find (optional, default "")
- Param: _replace (optional, default "")

File: [host\CommonComponents\!PreInit.sqf at line 375](../../../Src/host/CommonComponents/!PreInit.sqf#L375)
## selectBest

Type: function

Description: Выбирает лучший случай [[2, -6, 4], {abs _x}] call selectBest
- Param: _array
- Param: _criteria
- Param: _return

File: [host\CommonComponents\!PreInit.sqf at line 394](../../../Src/host/CommonComponents/!PreInit.sqf#L394)
## searchInList

Type: function

Description: 
- Param: _list
- Param: _lambda
- Param: _defaultReturn

File: [host\CommonComponents\!PreInit.sqf at line 410](../../../Src/host/CommonComponents/!PreInit.sqf#L410)
## arrayDeleteItem

Type: function

Description: 
- Param: _a
- Param: _it

File: [host\CommonComponents\!PreInit.sqf at line 417](../../../Src/host/CommonComponents/!PreInit.sqf#L417)
## arrayIsValidIndex

Type: function

Description: 
- Param: _a
- Param: _ix

File: [host\CommonComponents\!PreInit.sqf at line 424](../../../Src/host/CommonComponents/!PreInit.sqf#L424)
## arrayShuffleOrig

Type: function

Description: shuffle array elements, return alter array
- Param: _array

File: [host\CommonComponents\!PreInit.sqf at line 430](../../../Src/host/CommonComponents/!PreInit.sqf#L430)
## arraySwap

Type: function

Description: swap 2 elements in array
- Param: _a
- Param: _is
- Param: _id

File: [host\CommonComponents\!PreInit.sqf at line 442](../../../Src/host/CommonComponents/!PreInit.sqf#L442)
## stringLength

Type: function

Description: 
- Param: _str
- Param: _unicode (optional, default true)

File: [host\CommonComponents\!PreInit.sqf at line 449](../../../Src/host/CommonComponents/!PreInit.sqf#L449)
## stringSelect

Type: function

Description: 
- Param: _s
- Param: _i
- Param: _c

File: [host\CommonComponents\!PreInit.sqf at line 459](../../../Src/host/CommonComponents/!PreInit.sqf#L459)
## randomFloat

Type: function

Description: 
- Param: _beg
- Param: _end

File: [host\CommonComponents\!PreInit.sqf at line 465](../../../Src/host/CommonComponents/!PreInit.sqf#L465)
## randomInt

Type: function

Description: 
- Param: _beg
- Param: _end

File: [host\CommonComponents\!PreInit.sqf at line 470](../../../Src/host/CommonComponents/!PreInit.sqf#L470)
## randomProbably

Type: function

Description: 
- Param: _v

File: [host\CommonComponents\!PreInit.sqf at line 475](../../../Src/host/CommonComponents/!PreInit.sqf#L475)
## getPrecentage

Type: function

Description: 
- Param: _checkedval
- Param: _pval

File: [host\CommonComponents\!PreInit.sqf at line 480](../../../Src/host/CommonComponents/!PreInit.sqf#L480)
## clampNumber

Type: function

Description: 
- Param: _v
- Param: _mi
- Param: _ma

File: [host\CommonComponents\!PreInit.sqf at line 485](../../../Src/host/CommonComponents/!PreInit.sqf#L485)
## clampInRange

Type: function

Description: 
- Param: _v
- Param: _mi
- Param: _ma

File: [host\CommonComponents\!PreInit.sqf at line 490](../../../Src/host/CommonComponents/!PreInit.sqf#L490)
## pulsate

Type: function

Description: See - BIS_fnc_pulsate; frequency: Number - the frequency in Hz, 1 / _frequency = 0.1 second is the period
- Param: _freq
- Param: _timeval (optional, default diag_tickTime)

File: [host\CommonComponents\!PreInit.sqf at line 503](../../../Src/host/CommonComponents/!PreInit.sqf#L503)
## numberGetDigits

Type: function

Description: число в массив цифр
- Param: _num

File: [host\CommonComponents\!PreInit.sqf at line 509](../../../Src/host/CommonComponents/!PreInit.sqf#L509)
## numberCutDecimals

Type: function

Description: срезает дробную часть числа
- Param: _num
- Param: _digits

File: [host\CommonComponents\!PreInit.sqf at line 515](../../../Src/host/CommonComponents/!PreInit.sqf#L515)
## stringFormat

Type: function

Description: 
- Param: _fmt
- Param: _val
- Param: _breakArr (optional, default false)

File: [host\CommonComponents\!PreInit.sqf at line 520](../../../Src/host/CommonComponents/!PreInit.sqf#L520)
## formatLazy

Type: function

Description: 
- Param: _args

File: [host\CommonComponents\!PreInit.sqf at line 547](../../../Src/host/CommonComponents/!PreInit.sqf#L547)
## getPosListCenter

Type: function

Description: 
- Param: _poses (optional, default [])
- Param: _dummyParam

File: [host\CommonComponents\!PreInit.sqf at line 562](../../../Src/host/CommonComponents/!PreInit.sqf#L562)
## randomRadius

Type: function

Description: Специальный рандом по области. Чем ближе к центру тем выше вероятность. Распределение идёт по всей окружности.
- Param: _center
- Param: _radius

File: [host\CommonComponents\!PreInit.sqf at line 578](../../../Src/host/CommonComponents/!PreInit.sqf#L578)
## randomPosition

Type: function

Description: Специальный рандом по области. Равномерное распределение по позиции в радиусе.
- Param: _center
- Param: _radius

File: [host\CommonComponents\!PreInit.sqf at line 586](../../../Src/host/CommonComponents/!PreInit.sqf#L586)
## randomGaussian

Type: function

Description: Специальный рандом по области. Распределение идёт ближе к центру. Чем ближе к центру тем выше вероятность.
- Param: _center
- Param: _radius

File: [host\CommonComponents\!PreInit.sqf at line 594](../../../Src/host/CommonComponents/!PreInit.sqf#L594)
## fileExists_Node

Type: function

Description: 
- Param: _f

File: [host\CommonComponents\!PreInit.sqf at line 601](../../../Src/host/CommonComponents/!PreInit.sqf#L601)
## sortBy

Type: function

Description: _mode == true -> asc, false -> desc: [[20,2,5],{_x}] call sortBy;
- Param: _list
- Param: _algorithm
- Param: _modeIsAscend (optional, default true)

File: [host\CommonComponents\!PreInit.sqf at line 607](../../../Src/host/CommonComponents/!PreInit.sqf#L607)
## nearNumber

Type: function

Description: find nearest number in array of numbers
- Param: _arr
- Param: _num

File: [host\CommonComponents\!PreInit.sqf at line 623](../../../Src/host/CommonComponents/!PreInit.sqf#L623)
## fileLoad_Node

Type: function

Description: 
- Param: _f
- Param: _doPreprocess (optional, default false)

File: [host\CommonComponents\!PreInit.sqf at line 638](../../../Src/host/CommonComponents/!PreInit.sqf#L638)
## pushFront

Type: function

Description: 
- Param: _list
- Param: _element
- Param: _unique (optional, default false)

File: [host\CommonComponents\!PreInit.sqf at line 648](../../../Src/host/CommonComponents/!PreInit.sqf#L648)
# Algorithm.sqf

## allOf

Type: function

Description: #define __ENABLE_ALGORITHM_TEST___
- Param: _list

File: [host\CommonComponents\Algorithm.sqf at line 14](../../../Src/host/CommonComponents/Algorithm.sqf#L14)
## anyOf

Type: function

Description: 
- Param: _list

File: [host\CommonComponents\Algorithm.sqf at line 19](../../../Src/host/CommonComponents/Algorithm.sqf#L19)
## noneOf

Type: function

Description: 
- Param: _list

File: [host\CommonComponents\Algorithm.sqf at line 24](../../../Src/host/CommonComponents/Algorithm.sqf#L24)
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
## anim_addAttach

Type: function

Description: с помощью этого метода можно контролирвать анимированные атачи
- Param: _dest
- Param: _ctxAtt

File: [host\CommonComponents\Animator.sqf at line 352](../../../Src/host/CommonComponents/Animator.sqf#L352)
## anim_removeAttach

Type: function

Description: 
- Param: _dest
- Param: _src

File: [host\CommonComponents\Animator.sqf at line 364](../../../Src/host/CommonComponents/Animator.sqf#L364)
## anim_syncOnFrameAttaches

Type: function

Description: 
- Param: _mob

File: [host\CommonComponents\Animator.sqf at line 371](../../../Src/host/CommonComponents/Animator.sqf#L371)
# Assert.sqf

## sys_int_evalassert

Type: function

Description: 
- Param: _value

File: [host\CommonComponents\Assert.sqf at line 9](../../../Src/host/CommonComponents/Assert.sqf#L9)
## sys_static_assert_

Type: function

Description: 
- Param: _expr (optional, default "NO_EXPR")
- Param: _module (optional, default "UNK_MODULE")
- Param: _line (optional, default 0)
- Param: _message (optional, default "")

File: [host\CommonComponents\Assert.sqf at line 22](../../../Src/host/CommonComponents/Assert.sqf#L22)
## sys_assert_

Type: function

Description: 
- Param: _expr (optional, default "NO_EXPR")
- Param: _module (optional, default "UNK_MODULE")
- Param: _line (optional, default 0)
- Param: _message (optional, default "")

File: [host\CommonComponents\Assert.sqf at line 70](../../../Src/host/CommonComponents/Assert.sqf#L70)
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
# LightCfg.sqf

## lightSys_null_t

Type: Variable

Description: 


Initial value:
```sqf
null
```
File: [host\CommonComponents\LightCfg.sqf at line 8](../../../Src/host/CommonComponents/LightCfg.sqf#L8)
## lightSys_replacer_client_header

Type: Variable

Description: %1 type(int)


Initial value:
```sqf
"...
```
File: [host\CommonComponents\LightCfg.sqf at line 57](../../../Src/host/CommonComponents/LightCfg.sqf#L57)
## lightSys_replacer_server_header

Type: Variable

Description: здесь приходится обходить пробему undefined variable. в генераторе мы выбираем null значение


Initial value:
```sqf
"...
```
File: [host\CommonComponents\LightCfg.sqf at line 68](../../../Src/host/CommonComponents/LightCfg.sqf#L68)
## lightSys_replacer_footer

Type: Variable

Description: common footer for scripted config


Initial value:
```sqf
"] " 
```
File: [host\CommonComponents\LightCfg.sqf at line 77](../../../Src/host/CommonComponents/LightCfg.sqf#L77)
## lightSys_assocCfg_keyId

Type: Variable

Description: assoc maps


Initial value:
```sqf
createHashMap
```
File: [host\CommonComponents\LightCfg.sqf at line 80](../../../Src/host/CommonComponents/LightCfg.sqf#L80)
## lightSys_assocCfg_keyName

Type: Variable

Description: 


Initial value:
```sqf
createHashMap
```
File: [host\CommonComponents\LightCfg.sqf at line 81](../../../Src/host/CommonComponents/LightCfg.sqf#L81)
## lightSys_cfgId_cur

Type: Variable

Description: base config id


Initial value:
```sqf
2100
```
File: [host\CommonComponents\LightCfg.sqf at line 84](../../../Src/host/CommonComponents/LightCfg.sqf#L84)
## lightSys_prepConfig

Type: function

Description: light config parser
- Param: _content
- Param: _id
- Param: _refName
- Param: _isServerPrep (optional, default false)

File: [host\CommonComponents\LightCfg.sqf at line 11](../../../Src/host/CommonComponents/LightCfg.sqf#L11)
## lightSys_registerConfig

Type: function

Description: 
- Param: _content
- Param: _isServer (optional, default false)

File: [host\CommonComponents\LightCfg.sqf at line 35](../../../Src/host/CommonComponents/LightCfg.sqf#L35)
## lightSys_preInitialize

Type: function

Description: 


File: [host\CommonComponents\LightCfg.sqf at line 86](../../../Src/host/CommonComponents/LightCfg.sqf#L86)
## lightSys_getConfigNameById

Type: function

Description: get cfg name by id
- Param: _id

File: [host\CommonComponents\LightCfg.sqf at line 93](../../../Src/host/CommonComponents/LightCfg.sqf#L93)
## lightSys_getConfigIdByName

Type: function

Description: get cfg id by name
- Param: _name

File: [host\CommonComponents\LightCfg.sqf at line 99](../../../Src/host/CommonComponents/LightCfg.sqf#L99)
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
## model_cnvPBYToVec_v2

Type: function

Description: optimized variant;
- Param: _aroundX
- Param: _aroundY
- Param: _aroundZ

File: [host\CommonComponents\ModelTransform.hpp at line 47](../../../Src/host/CommonComponents/ModelTransform.hpp#L47)
## model_SetPitchBankYaw

Type: function

Description: 
- Param: _object
- Param: _data

File: [host\CommonComponents\ModelTransform.hpp at line 80](../../../Src/host/CommonComponents/ModelTransform.hpp#L80)
## model_getPitchBankYaw

Type: function

Description: 
- Param: _vehicle

File: [host\CommonComponents\ModelTransform.hpp at line 86](../../../Src/host/CommonComponents/ModelTransform.hpp#L86)
## model_getPitchBankYawAccurate

Type: function

Description: 
- Param: _v

File: [host\CommonComponents\ModelTransform.hpp at line 91](../../../Src/host/CommonComponents/ModelTransform.hpp#L91)
## model_isSafedirTransform

Type: function

Description: проверяет является ли направление безопасным
- Param: _vdu_dir
- Param: _fromVUP (optional, default false)

File: [host\CommonComponents\ModelTransform.hpp at line 105](../../../Src/host/CommonComponents/ModelTransform.hpp#L105)
## model_isPosInsideBBX

Type: function

Description: 
- Param: _pos
- Param: _obj

File: [host\CommonComponents\ModelTransform.hpp at line 123](../../../Src/host/CommonComponents/ModelTransform.hpp#L123)
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
"TF RELICTA ADDON API 2.0"
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
# Collections.sqf

## stdf_const_types

Type: Variable

Description: constant hashable type


Initial value:
```sqf
[...
```
File: [host\CommonComponents\Structs\Collections.sqf at line 308](../../../Src/host/CommonComponents/Structs/Collections.sqf#L308)
## stdf_const_containerTypes

Type: Variable

Description: 


Initial value:
```sqf
[...
```
File: [host\CommonComponents\Structs\Collections.sqf at line 320](../../../Src/host/CommonComponents/Structs/Collections.sqf#L320)
## stdf_varnameCnt

Type: Variable

Description: 


Initial value:
```sqf
".@hash_container__"
```
File: [host\CommonComponents\Structs\Collections.sqf at line 328](../../../Src/host/CommonComponents/Structs/Collections.sqf#L328)
## stdf_genHash

Type: function

Description: 


File: [host\CommonComponents\Structs\Collections.sqf at line 325](../../../Src/host/CommonComponents/Structs/Collections.sqf#L325)
## sftd_hashFunc

Type: function

Description: 
- Param: _val

File: [host\CommonComponents\Structs\Collections.sqf at line 331](../../../Src/host/CommonComponents/Structs/Collections.sqf#L331)
# Pointers.sqf

## SAFE_REFERENCE_POOL_CONTAINER

Type: constant

Description: 


Replaced value:
```sqf
0
```
File: [host\CommonComponents\Structs\Pointers.sqf at line 6](../../../Src/host/CommonComponents/Structs/Pointers.sqf#L6)
## SAFE_REFERENCE_POOL_COUNTER

Type: constant

Description: 


Replaced value:
```sqf
1
```
File: [host\CommonComponents\Structs\Pointers.sqf at line 7](../../../Src/host/CommonComponents/Structs/Pointers.sqf#L7)
## SAFE_REFERENCE_POOL_NAME

Type: constant

Description: 


Replaced value:
```sqf
2
```
File: [host\CommonComponents\Structs\Pointers.sqf at line 8](../../../Src/host/CommonComponents/Structs/Pointers.sqf#L8)
## SAFE_REFERENCE_MEMORY_ADDR

Type: constant

Description: 


Replaced value:
```sqf
"mpstor"
```
File: [host\CommonComponents\Structs\Pointers.sqf at line 10](../../../Src/host/CommonComponents/Structs/Pointers.sqf#L10)
## sref_defaultPool

Type: Variable

Description: 


Initial value:
```sqf
["DefaultPool"] call SafeReference_CreatePool
```
File: [host\CommonComponents\Structs\Pointers.sqf at line 24](../../../Src/host/CommonComponents/Structs/Pointers.sqf#L24)
## SafeReference_CreatePool

Type: function

Description: создание нового пула для безопасных ссылок
- Param: _poolName

File: [host\CommonComponents\Structs\Pointers.sqf at line 13](../../../Src/host/CommonComponents/Structs/Pointers.sqf#L13)
# Profiling.sqf

## profiler_getSystemContainer

Type: function

Description: 


File: [host\CommonComponents\Structs\Profiling.sqf at line 52](../../../Src/host/CommonComponents/Structs/Profiling.sqf#L52)
## profiler_getResults

Type: function

Description: 
- Param: _printOnConsole (optional, default false)

File: [host\CommonComponents\Structs\Profiling.sqf at line 56](../../../Src/host/CommonComponents/Structs/Profiling.sqf#L56)
## profiler_clearResults

Type: function

Description: 


File: [host\CommonComponents\Structs\Profiling.sqf at line 74](../../../Src/host/CommonComponents/Structs/Profiling.sqf#L74)
