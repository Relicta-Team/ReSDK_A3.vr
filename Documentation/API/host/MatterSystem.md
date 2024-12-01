# bloodTypes.hpp

## BLOOD_TYPE_RANDOM

Type: constant

Description: Случайная группа. не используется в значениях


Replaced value:
```sqf
-1
```
File: [host\MatterSystem\bloodTypes.hpp at line 9](../../../Src/host/MatterSystem/bloodTypes.hpp#L9)
## BLOOD_TYPE_O_MINUS

Type: constant

Description: 


Replaced value:
```sqf
10
```
File: [host\MatterSystem\bloodTypes.hpp at line 11](../../../Src/host/MatterSystem/bloodTypes.hpp#L11)
## BLOOD_TYPE_O_PLUS

Type: constant

Description: 


Replaced value:
```sqf
11
```
File: [host\MatterSystem\bloodTypes.hpp at line 12](../../../Src/host/MatterSystem/bloodTypes.hpp#L12)
## BLOOD_TYPE_A_MINUS

Type: constant

Description: 


Replaced value:
```sqf
20
```
File: [host\MatterSystem\bloodTypes.hpp at line 13](../../../Src/host/MatterSystem/bloodTypes.hpp#L13)
## BLOOD_TYPE_A_PLUS

Type: constant

Description: 


Replaced value:
```sqf
21
```
File: [host\MatterSystem\bloodTypes.hpp at line 14](../../../Src/host/MatterSystem/bloodTypes.hpp#L14)
## BLOOD_TYPE_B_MINUS

Type: constant

Description: 


Replaced value:
```sqf
30
```
File: [host\MatterSystem\bloodTypes.hpp at line 15](../../../Src/host/MatterSystem/bloodTypes.hpp#L15)
## BLOOD_TYPE_B_PLUS

Type: constant

Description: 


Replaced value:
```sqf
31
```
File: [host\MatterSystem\bloodTypes.hpp at line 16](../../../Src/host/MatterSystem/bloodTypes.hpp#L16)
## BLOOD_TYPE_AB_MINUS

Type: constant

Description: 


Replaced value:
```sqf
40
```
File: [host\MatterSystem\bloodTypes.hpp at line 17](../../../Src/host/MatterSystem/bloodTypes.hpp#L17)
## BLOOD_TYPE_AB_PLUS

Type: constant

Description: 


Replaced value:
```sqf
41
```
File: [host\MatterSystem\bloodTypes.hpp at line 18](../../../Src/host/MatterSystem/bloodTypes.hpp#L18)
## BLOOD_LIST_ALL_TYPES

Type: constant

Description: 


Replaced value:
```sqf
[BLOOD_TYPE_O_MINUS,BLOOD_TYPE_O_PLUS,BLOOD_TYPE_A_MINUS,BLOOD_TYPE_A_PLUS,BLOOD_TYPE_B_MINUS,BLOOD_TYPE_B_PLUS,BLOOD_TYPE_AB_MINUS,BLOOD_TYPE_AB_PLUS]
```
File: [host\MatterSystem\bloodTypes.hpp at line 21](../../../Src/host/MatterSystem/bloodTypes.hpp#L21)
## BLOOD_LIST_ALL_MATTERS

Type: constant

Description: 


Replaced value:
```sqf
["Blood_OMinus","Blood_OPlus","Blood_AMinus","Blood_APlus","Blood_BMinus","Blood_BPlus","Blood_ABMinus","Blood_ABPlus"]
```
File: [host\MatterSystem\bloodTypes.hpp at line 22](../../../Src/host/MatterSystem/bloodTypes.hpp#L22)
## BLOOD_LIST_ALL_NAMES

Type: constant

Description: 


Replaced value:
```sqf
["O-","O+","A-","A+","B-","B+","AB-","AB+"]
```
File: [host\MatterSystem\bloodTypes.hpp at line 23](../../../Src/host/MatterSystem/bloodTypes.hpp#L23)
## BLOOD_ENUM_TO_STRING(enum)

Type: constant

Description: 
- Param: enum

Replaced value:
```sqf
(BLOOD_LIST_ALL_NAMES select (BLOOD_LIST_ALL_TYPES find (enum)))
```
File: [host\MatterSystem\bloodTypes.hpp at line 25](../../../Src/host/MatterSystem/bloodTypes.hpp#L25)
## BLOOD_ENUM_TO_MATTER(enum)

Type: constant

Description: 
- Param: enum

Replaced value:
```sqf
(BLOOD_LIST_ALL_MATTERS select (BLOOD_LIST_ALL_TYPES find (enum)))
```
File: [host\MatterSystem\bloodTypes.hpp at line 26](../../../Src/host/MatterSystem/bloodTypes.hpp#L26)
# MatterSystem.h

## throwFloor(a,b)

Type: constant

Description: math helpers
- Param: a
- Param: b

Replaced value:
```sqf
(floor(a * 10^b) / 10^b)
```
File: [host\MatterSystem\MatterSystem.h at line 7](../../../Src/host/MatterSystem/MatterSystem.h#L7)
## throwCeil(a,b)

Type: constant

Description: 
- Param: a
- Param: b

Replaced value:
```sqf
(ceil(a * 10^b) / 10^b)
```
File: [host\MatterSystem\MatterSystem.h at line 8](../../../Src/host/MatterSystem/MatterSystem.h#L8)
## throwRound(a,b)

Type: constant

Description: 
- Param: a
- Param: b

Replaced value:
```sqf
(round(a * 10^b) / 10^b)
```
File: [host\MatterSystem\MatterSystem.h at line 9](../../../Src/host/MatterSystem/MatterSystem.h#L9)
## __nativecall

Type: constant

Description: 


Replaced value:
```sqf
"MatterSystem" callExtension
```
File: [host\MatterSystem\MatterSystem.h at line 12](../../../Src/host/MatterSystem/MatterSystem.h#L12)
## __validate(space,errtypemes)

Type: constant

Description: 
- Param: space
- Param: errtypemes

Replaced value:
```sqf
if (_className in space) exitWith {errorformat("[MatterSystem]: Generic error on loading %1 -> %2 already exists",errtypemes arg _className); appExit(APPEXIT_REASON_RUNTIMEERROR)}
```
File: [host\MatterSystem\MatterSystem.h at line 14](../../../Src/host/MatterSystem/MatterSystem.h#L14)
## __class_activator_provider(name,space,errtypemes)

Type: constant

Description: 
- Param: name
- Param: space
- Param: errtypemes

Replaced value:
```sqf
_newMatter = createHashMap; _className = #name; __validate(space,errtypemes); space set [_className,_newMatter]; _newMatter set ["classname",_className]; _newMatter set ["inherit","NOTYPE"];
```
File: [host\MatterSystem\MatterSystem.h at line 16](../../../Src/host/MatterSystem/MatterSystem.h#L16)
## __class_activator_provider_NOSTR(name,space,errtypemes)

Type: constant

Description: 
- Param: name
- Param: space
- Param: errtypemes

Replaced value:
```sqf
_newMatter = createHashMap; _className = name; __validate(space,errtypemes); space set [_className,_newMatter]; _newMatter set ["classname",_className]; _newMatter set ["inherit","NOTYPE"];
```
File: [host\MatterSystem\MatterSystem.h at line 17](../../../Src/host/MatterSystem/MatterSystem.h#L17)
## matter(name)

Type: constant

Description: 
- Param: name

Replaced value:
```sqf
__class_activator_provider(name,ms_map_allMatters,"reagent")
```
File: [host\MatterSystem\MatterSystem.h at line 19](../../../Src/host/MatterSystem/MatterSystem.h#L19)
## react(name)

Type: constant

Description: 
- Param: name

Replaced value:
```sqf
__class_activator_provider(name,ms_map_allReactions,"reaction")
```
File: [host\MatterSystem\MatterSystem.h at line 21](../../../Src/host/MatterSystem/MatterSystem.h#L21)
## reactgen

Type: constant

Description: 


Replaced value:
```sqf
INC(ms_internal_react_gen); __class_activator_provider_NOSTR("react_gen_" + str ms_internal_react_gen,ms_map_allReactions,"reaction")
```
File: [host\MatterSystem\MatterSystem.h at line 23](../../../Src/host/MatterSystem/MatterSystem.h#L23)
## prop(__p,val)

Type: constant

Description: 
- Param: __p
- Param: val

Replaced value:
```sqf
_fieldName = #__p; if ((_fieldName in _newMatter)) exitWith {errorformat("MatterSystem - Cant initialize property <%1> ===> property <%2> already defined",_className arg _fieldName)}; _newMatter set [_fieldName,val];
```
File: [host\MatterSystem\MatterSystem.h at line 25](../../../Src/host/MatterSystem/MatterSystem.h#L25)
## extends(name)

Type: constant

Description: 
- Param: name

Replaced value:
```sqf
_newMatter set ["inherit",#name];
```
File: [host\MatterSystem\MatterSystem.h at line 27](../../../Src/host/MatterSystem/MatterSystem.h#L27)
## callExtend(__class,func)

Type: constant

Description: 
- Param: __class
- Param: func

Replaced value:
```sqf
call(ms_map_allMatters get #__class get #func)
```
File: [host\MatterSystem\MatterSystem.h at line 29](../../../Src/host/MatterSystem/MatterSystem.h#L29)
## def(funcname)

Type: constant

Description: 
- Param: funcname

Replaced value:
```sqf
_lastfunc = [#funcname , {
```
File: [host\MatterSystem\MatterSystem.h at line 31](../../../Src/host/MatterSystem/MatterSystem.h#L31)
## end

Type: constant

Description: 


Replaced value:
```sqf
}]; _newMatter set _lastfunc;
```
File: [host\MatterSystem\MatterSystem.h at line 33](../../../Src/host/MatterSystem/MatterSystem.h#L33)
## amount

Type: constant

Description: сколько осталось этого реагента


Replaced value:
```sqf
__amount__
```
File: [host\MatterSystem\MatterSystem.h at line 36](../../../Src/host/MatterSystem/MatterSystem.h#L36)
## thisSpace

Type: constant

Description: 


Replaced value:
```sqf
_ms
```
File: [host\MatterSystem\MatterSystem.h at line 38](../../../Src/host/MatterSystem/MatterSystem.h#L38)
## thisMatter

Type: constant

Description: внешняя переменная всегда должна быть такой


Replaced value:
```sqf
_matterObj
```
File: [host\MatterSystem\MatterSystem.h at line 40](../../../Src/host/MatterSystem/MatterSystem.h#L40)
## MIXING_DATA_CTX

Type: constant

Description: для миксинга данных


Replaced value:
```sqf
__NEW_DATA__
```
File: [host\MatterSystem\MatterSystem.h at line 43](../../../Src/host/MatterSystem/MatterSystem.h#L43)
## MIXING_DATA_NAME

Type: constant

Description: 


Replaced value:
```sqf
__MD_NAME__
```
File: [host\MatterSystem\MatterSystem.h at line 44](../../../Src/host/MatterSystem/MatterSystem.h#L44)
## MIXING_DATA_CONTAINER

Type: constant

Description: 


Replaced value:
```sqf
__mdata__
```
File: [host\MatterSystem\MatterSystem.h at line 45](../../../Src/host/MatterSystem/MatterSystem.h#L45)
# MatterSystem.hpp

## newReagents

Type: constant

Description: pseudoname


Replaced value:
```sqf
call ms_createOnObject
```
File: [host\MatterSystem\MatterSystem.hpp at line 8](../../../Src/host/MatterSystem/MatterSystem.hpp#L8)
## newReagentsFood

Type: constant

Description: 


Replaced value:
```sqf
call {[_this]newReagents}
```
File: [host\MatterSystem\MatterSystem.hpp at line 10](../../../Src/host/MatterSystem/MatterSystem.hpp#L10)
## rs(mat,am)

Type: constant

Description: rs: reagent structure (MatterType,amount)
- Param: mat
- Param: am

Replaced value:
```sqf
[#mat,am]
```
File: [host\MatterSystem\MatterSystem.hpp at line 13](../../../Src/host/MatterSystem/MatterSystem.hpp#L13)
## ri(object,__cnt)

Type: constant

Description: is: item structure for matters (required_reagents): (TypeName_item,count)
- Param: object
- Param: __cnt

Replaced value:
```sqf
[#object,__cnt]
```
File: [host\MatterSystem\MatterSystem.hpp at line 16](../../../Src/host/MatterSystem/MatterSystem.hpp#L16)
## MS_STRUCT_INDEX_SOURCE

Type: constant

Description: 


Replaced value:
```sqf
0
```
File: [host\MatterSystem\MatterSystem.hpp at line 18](../../../Src/host/MatterSystem/MatterSystem.hpp#L18)
## MS_STRUCT_INDEX_CAPACITY

Type: constant

Description: 


Replaced value:
```sqf
1
```
File: [host\MatterSystem\MatterSystem.hpp at line 19](../../../Src/host/MatterSystem/MatterSystem.hpp#L19)
## MS_STRUCT_INDEX_MATTERS

Type: constant

Description: 


Replaced value:
```sqf
2
```
File: [host\MatterSystem\MatterSystem.hpp at line 20](../../../Src/host/MatterSystem/MatterSystem.hpp#L20)
## MS_STRUCT_INDEX_MATDATA

Type: constant

Description: 


Replaced value:
```sqf
3
```
File: [host\MatterSystem\MatterSystem.hpp at line 21](../../../Src/host/MatterSystem/MatterSystem.hpp#L21)
## getMatter(strname)

Type: constant

Description: 
- Param: strname

Replaced value:
```sqf
(ms_map_allMatters get (strname))
```
File: [host\MatterSystem\MatterSystem.hpp at line 23](../../../Src/host/MatterSystem/MatterSystem.hpp#L23)
## getMatterProp(strname,pname)

Type: constant

Description: 
- Param: strname
- Param: pname

Replaced value:
```sqf
(ms_map_allMatters get (strname) get #pname )
```
File: [host\MatterSystem\MatterSystem.hpp at line 24](../../../Src/host/MatterSystem/MatterSystem.hpp#L24)
## isReagentTypeOf(strname,checkedtype)

Type: constant

Description: 
- Param: strname
- Param: checkedtype

Replaced value:
```sqf
((tolower checkedtype) in (ms_map_allMatters get (strname) get "__typelist"))
```
File: [host\MatterSystem\MatterSystem.hpp at line 26](../../../Src/host/MatterSystem/MatterSystem.hpp#L26)
## ms_getCapacity(ms)

Type: constant

Description: 
- Param: ms

Replaced value:
```sqf
(ms select MS_STRUCT_INDEX_CAPACITY)
```
File: [host\MatterSystem\MatterSystem.hpp at line 28](../../../Src/host/MatterSystem/MatterSystem.hpp#L28)
## ms_setCapacity(ms,cap)

Type: constant

Description: 
- Param: ms
- Param: cap

Replaced value:
```sqf
ms set [MS_STRUCT_INDEX_CAPACITY,cap]
```
File: [host\MatterSystem\MatterSystem.hpp at line 29](../../../Src/host/MatterSystem/MatterSystem.hpp#L29)
## ms_getSource(ms)

Type: constant

Description: 
- Param: ms

Replaced value:
```sqf
(ms select MS_STRUCT_INDEX_SOURCE)
```
File: [host\MatterSystem\MatterSystem.hpp at line 31](../../../Src/host/MatterSystem/MatterSystem.hpp#L31)
## ms_getMatterList(ms)

Type: constant

Description: 
- Param: ms

Replaced value:
```sqf
(ms select MS_STRUCT_INDEX_MATTERS)
```
File: [host\MatterSystem\MatterSystem.hpp at line 33](../../../Src/host/MatterSystem/MatterSystem.hpp#L33)
## ms_getMatterData(ms)

Type: constant

Description: 
- Param: ms

Replaced value:
```sqf
(ms select MS_STRUCT_INDEX_MATDATA)
```
File: [host\MatterSystem\MatterSystem.hpp at line 35](../../../Src/host/MatterSystem/MatterSystem.hpp#L35)
## ms_getFilledSpace(ms)

Type: constant

Description: 
- Param: ms

Replaced value:
```sqf
call{private _it=0;{_it = _it + _x}count(values ms_getMatterList(ms)); _it}
```
File: [host\MatterSystem\MatterSystem.hpp at line 37](../../../Src/host/MatterSystem/MatterSystem.hpp#L37)
## ms_getFreeSpace(ms)

Type: constant

Description: 
- Param: ms

Replaced value:
```sqf
call{private _it=0;{_it = _it + _x}count(values ms_getMatterList(ms)); ms_getCapacity(ms) - _it}
```
File: [host\MatterSystem\MatterSystem.hpp at line 39](../../../Src/host/MatterSystem/MatterSystem.hpp#L39)
## REACTION_COOKING

Type: constant

Description: сварить. Такая реакция возникает при варке в колбах и кастрюлях


Replaced value:
```sqf
0
```
File: [host\MatterSystem\MatterSystem.hpp at line 42](../../../Src/host/MatterSystem/MatterSystem.hpp#L42)
## REACTION_BLENDING

Type: constant

Description: смешать. Такая реакция возникает при смешивании


Replaced value:
```sqf
1
```
File: [host\MatterSystem\MatterSystem.hpp at line 44](../../../Src/host/MatterSystem/MatterSystem.hpp#L44)
## REACTION_GRIND

Type: constant

Description: молоть. Реакция возникнет при размоле


Replaced value:
```sqf
2
```
File: [host\MatterSystem\MatterSystem.hpp at line 46](../../../Src/host/MatterSystem/MatterSystem.hpp#L46)
## REACTION_CHEM

Type: constant

Description: химическая реакция. происходит только в хим блендере или химсистеме


Replaced value:
```sqf
5
```
File: [host\MatterSystem\MatterSystem.hpp at line 48](../../../Src/host/MatterSystem/MatterSystem.hpp#L48)
## REACTION_FRY

Type: constant

Description: DEPREACTED::::::::::::::::::::::::::::: жарить. Реакция возникнет при жарке на сковороде или открытом огне


Replaced value:
```sqf
3
```
File: [host\MatterSystem\MatterSystem.hpp at line 50](../../../Src/host/MatterSystem/MatterSystem.hpp#L50)
## REACTION_DRYING

Type: constant

Description: DEPREACTED::::::::::::::::::::::::::::: сушка - вытяжка. Реакция возникнет


Replaced value:
```sqf
4
```
File: [host\MatterSystem\MatterSystem.hpp at line 52](../../../Src/host/MatterSystem/MatterSystem.hpp#L52)
## REACTION_ENUM_TO_TYPENAME(enum)

Type: constant

Description: 
- Param: enum

Replaced value:
```sqf
(["REACTION_COOKING","REACTION_BLENDING","REACTION_GRIND","REACTION_FRY","REACTION_DRYING"] select enum)
```
File: [host\MatterSystem\MatterSystem.hpp at line 54](../../../Src/host/MatterSystem/MatterSystem.hpp#L54)
## REACTION_ENUM_TO_NAME(enum)

Type: constant

Description: 
- Param: enum

Replaced value:
```sqf
(["Готовка","Смешивание","Перемалывание","Жарка","Сушка"] select enum)
```
File: [host\MatterSystem\MatterSystem.hpp at line 55](../../../Src/host/MatterSystem/MatterSystem.hpp#L55)
## __KELVIN__

Type: constant

Description: температура абсолютного нуля для кельвинов


Replaced value:
```sqf
273.15
```
File: [host\MatterSystem\MatterSystem.hpp at line 58](../../../Src/host/MatterSystem/MatterSystem.hpp#L58)
## TOCELSIUS(val)

Type: constant

Description: умная замена: var(temp,TOCELSIUS(3000))
- Param: val

Replaced value:
```sqf
((val) - __KELVIN__)
```
File: [host\MatterSystem\MatterSystem.hpp at line 61](../../../Src/host/MatterSystem/MatterSystem.hpp#L61)
## TCEL(val)

Type: constant

Description: конвертация из цельсиев в кельвины
- Param: val

Replaced value:
```sqf
(val-__KELVIN__)
```
File: [host\MatterSystem\MatterSystem.hpp at line 64](../../../Src/host/MatterSystem/MatterSystem.hpp#L64)
## TKEL(val)

Type: constant

Description: конвертация из кельвинов в цельсии (используется для визуализации)
- Param: val

Replaced value:
```sqf
(val+__KELVIN__)
```
File: [host\MatterSystem\MatterSystem.hpp at line 66](../../../Src/host/MatterSystem/MatterSystem.hpp#L66)
## DEFAULT_TEMPERATURE

Type: constant

Description: стандартная температура созданных мсов


Replaced value:
```sqf
26
```
File: [host\MatterSystem\MatterSystem.hpp at line 69](../../../Src/host/MatterSystem/MatterSystem.hpp#L69)
## _UNC_GRAMM_VALUE_

Type: constant

Description: 


Replaced value:
```sqf
28.35
```
File: [host\MatterSystem\MatterSystem.hpp at line 72](../../../Src/host/MatterSystem/MatterSystem.hpp#L72)
## U

Type: constant

Description: 


Replaced value:
```sqf
* _UNC_GRAMM_VALUE_
```
File: [host\MatterSystem\MatterSystem.hpp at line 74](../../../Src/host/MatterSystem/MatterSystem.hpp#L74)
## OZ(gramm)

Type: constant

Description: унции меньше грамма. В унциях все мсы
- Param: gramm

Replaced value:
```sqf
(gramm U)
```
File: [host\MatterSystem\MatterSystem.hpp at line 77](../../../Src/host/MatterSystem/MatterSystem.hpp#L77)
## REAGENT_ML2OZ(am)

Type: constant

Description: милилитры в унции
- Param: am

Replaced value:
```sqf
(am / 28.35)
```
File: [host\MatterSystem\MatterSystem.hpp at line 86](../../../Src/host/MatterSystem/MatterSystem.hpp#L86)
## REAGENT_L2OZ(am)

Type: constant

Description: литры в унции
- Param: am

Replaced value:
```sqf
(1000*(am) / 28.35)
```
File: [host\MatterSystem\MatterSystem.hpp at line 88](../../../Src/host/MatterSystem/MatterSystem.hpp#L88)
# MatterSystem_functions.sqf

## __getMatter__(val)

Type: constant

Description: 
- Param: val

Replaced value:
```sqf
(_ns get (val))
```
File: [host\MatterSystem\MatterSystem_functions.sqf at line 19](../../../Src/host/MatterSystem/MatterSystem_functions.sqf#L19)
## ms_debug_count

Type: Variable

Description: 


Initial value:
```sqf
0
```
File: [host\MatterSystem\MatterSystem_functions.sqf at line 293](../../../Src/host/MatterSystem/MatterSystem_functions.sqf#L293)
## ms_internal_initInheritance

Type: function

Description: Внутренняя функция активации наследования всех свойств


File: [host\MatterSystem\MatterSystem_functions.sqf at line 8](../../../Src/host/MatterSystem/MatterSystem_functions.sqf#L8)
## ms_internal_processInheritanceOnNamespace

Type: function

Description: 
- Param: _ns

File: [host\MatterSystem\MatterSystem_functions.sqf at line 16](../../../Src/host/MatterSystem/MatterSystem_functions.sqf#L16)
## ms_internal_prepToTester

Type: function

Description: 
- Param: _value

File: [host\MatterSystem\MatterSystem_functions.sqf at line 39](../../../Src/host/MatterSystem/MatterSystem_functions.sqf#L39)
## ms_internal_copyFrom

Type: function

Description: Внутренняя функция копирования свойств
- Param: _thisMatter
- Param: _copyData

File: [host\MatterSystem\MatterSystem_functions.sqf at line 86](../../../Src/host/MatterSystem/MatterSystem_functions.sqf#L86)
## ms_internal_makeReactionTable

Type: function

Description: Внутренняя функция генерации возможных реакций


File: [host\MatterSystem\MatterSystem_functions.sqf at line 106](../../../Src/host/MatterSystem/MatterSystem_functions.sqf#L106)
## ms_internal_printInfo

Type: function

Description: 


File: [host\MatterSystem\MatterSystem_functions.sqf at line 124](../../../Src/host/MatterSystem/MatterSystem_functions.sqf#L124)
## ms_internal_loadExtension

Type: function

Description: 


File: [host\MatterSystem\MatterSystem_functions.sqf at line 130](../../../Src/host/MatterSystem/MatterSystem_functions.sqf#L130)
## ms_canReact

Type: function

Description: 
- Param: _ms
- Param: _reactType

File: [host\MatterSystem\MatterSystem_functions.sqf at line 233](../../../Src/host/MatterSystem/MatterSystem_functions.sqf#L233)
## ms_processReaction

Type: function

Description: process reaction
- Param: _ms
- Param: _rT

File: [host\MatterSystem\MatterSystem_functions.sqf at line 240](../../../Src/host/MatterSystem/MatterSystem_functions.sqf#L240)
## ms_create

Type: function

Description: 
- Param: _src
- Param: _capacity
- Param: _matters (optional, default [])
- Param: _matData (optional, default [])

File: [host\MatterSystem\MatterSystem_functions.sqf at line 295](../../../Src/host/MatterSystem/MatterSystem_functions.sqf#L295)
## ms_addMatterData

Type: function

Description: Добавляет данные для реагента
- Param: _ms
- Param: _matter
- Param: _data

File: [host\MatterSystem\MatterSystem_functions.sqf at line 319](../../../Src/host/MatterSystem/MatterSystem_functions.sqf#L319)
## ms_removeMatterData

Type: function

Description: убирает данные
- Param: _ms
- Param: _matter

File: [host\MatterSystem\MatterSystem_functions.sqf at line 326](../../../Src/host/MatterSystem/MatterSystem_functions.sqf#L326)
## ms_createOnObject

Type: function

Description: 
- Param: _mats (optional, default [])
- Param: _capacity

File: [host\MatterSystem\MatterSystem_functions.sqf at line 336](../../../Src/host/MatterSystem/MatterSystem_functions.sqf#L336)
## ms_delete

Type: function

Description: 
- Param: _ms

File: [host\MatterSystem\MatterSystem_functions.sqf at line 355](../../../Src/host/MatterSystem/MatterSystem_functions.sqf#L355)
## ms_addMatter

Type: function

Description: 
- Param: _ms
- Param: _matter
- Param: _amount
- Param: _data

File: [host\MatterSystem\MatterSystem_functions.sqf at line 360](../../../Src/host/MatterSystem/MatterSystem_functions.sqf#L360)
## ms_removeMatter

Type: function

Description: 
- Param: _ms
- Param: _matter
- Param: _amount

File: [host\MatterSystem\MatterSystem_functions.sqf at line 393](../../../Src/host/MatterSystem/MatterSystem_functions.sqf#L393)
## ms_transToHolder

Type: function

Description: 
- Param: _ms
- Param: _amount
- Param: _chemType

File: [host\MatterSystem\MatterSystem_functions.sqf at line 417](../../../Src/host/MatterSystem/MatterSystem_functions.sqf#L417)
## ms_transferMatter

Type: function

Description: #define ms_log_transfer
- Param: _mFrom
- Param: _mTo
- Param: _mAmount (optional, default INFINITY)

File: [host\MatterSystem\MatterSystem_functions.sqf at line 441](../../../Src/host/MatterSystem/MatterSystem_functions.sqf#L441)
## ms_removeMatters

Type: function

Description: 
- Param: _mFrom
- Param: _mAmount (optional, default INFINITY)

File: [host\MatterSystem\MatterSystem_functions.sqf at line 501](../../../Src/host/MatterSystem/MatterSystem_functions.sqf#L501)
## ms_removeMattersWithReturns

Type: function

Description: убирает материи из мса и возвращает сколько было убрано и чего в виде массива
- Param: _mFrom
- Param: _mAmount (optional, default INFINITY)

File: [host\MatterSystem\MatterSystem_functions.sqf at line 548](../../../Src/host/MatterSystem/MatterSystem_functions.sqf#L548)
# MatterSystem_init.sqf

## ms_map_allMatters

Type: Variable

Description: 


Initial value:
```sqf
createHashMap
```
File: [host\MatterSystem\MatterSystem_init.sqf at line 16](../../../Src/host/MatterSystem/MatterSystem_init.sqf#L16)
## ms_map_allReactions

Type: Variable

Description: 


Initial value:
```sqf
createHashMap
```
File: [host\MatterSystem\MatterSystem_init.sqf at line 17](../../../Src/host/MatterSystem/MatterSystem_init.sqf#L17)
# Basic.sqf

## defchem(class,txtpropval)

Type: constant

Description: basic chemical
- Param: class
- Param: txtpropval

Replaced value:
```sqf
matter(class) extends(Matter) prop(name,txtpropval);
```
File: [host\MatterSystem\Matters\Basic.sqf at line 107](../../../Src/host/MatterSystem/Matters/Basic.sqf#L107)
# Reactions.sqf

## ms_internal_react_gen

Type: Variable

Description: 


Initial value:
```sqf
0
```
File: [host\MatterSystem\Reactions\Reactions.sqf at line 7](../../../Src/host/MatterSystem/Reactions/Reactions.sqf#L7)
# Reagent.sqf

## SOLID

Type: constant

Description: 


Replaced value:
```sqf
1
```
File: [host\MatterSystem\Reagents\Reagent.sqf at line 6](../../../Src/host/MatterSystem/Reagents/Reagent.sqf#L6)
## LIQUID

Type: constant

Description: 


Replaced value:
```sqf
2
```
File: [host\MatterSystem\Reagents\Reagent.sqf at line 7](../../../Src/host/MatterSystem/Reagents/Reagent.sqf#L7)
## GAS

Type: constant

Description: 


Replaced value:
```sqf
3
```
File: [host\MatterSystem\Reagents\Reagent.sqf at line 8](../../../Src/host/MatterSystem/Reagents/Reagent.sqf#L8)
## TOUCH

Type: constant

Description: 


Replaced value:
```sqf
1
```
File: [host\MatterSystem\Reagents\Reagent.sqf at line 10](../../../Src/host/MatterSystem/Reagents/Reagent.sqf#L10)
## INGEST

Type: constant

Description: 


Replaced value:
```sqf
2
```
File: [host\MatterSystem\Reagents\Reagent.sqf at line 11](../../../Src/host/MatterSystem/Reagents/Reagent.sqf#L11)
## INJECT

Type: constant

Description: 


Replaced value:
```sqf
3
```
File: [host\MatterSystem\Reagents\Reagent.sqf at line 12](../../../Src/host/MatterSystem/Reagents/Reagent.sqf#L12)
