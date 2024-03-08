# ReagentSystem_functions.sqf

## __nativecall

Type: constant

Description: 


Replaced value:
```sqf
"MatterSystem" CALLExtension
```
File: [host\Reagents\ReagentSystem_functions.sqf at line 36](../../../Src/host/Reagents/ReagentSystem_functions.sqf#L36)
## reagentSystem_getActiveCount

Type: function

Description: получить количество текущих созданных реагентов


File: [host\Reagents\ReagentSystem_functions.sqf at line 7](../../../Src/host/Reagents/ReagentSystem_functions.sqf#L7)
## reagentSystem_initReactions

Type: function

Description: 


File: [host\Reagents\ReagentSystem_functions.sqf at line 11](../../../Src/host/Reagents/ReagentSystem_functions.sqf#L11)
## reagentSystem_loadExension

Type: function

Description: 


File: [host\Reagents\ReagentSystem_functions.sqf at line 34](../../../Src/host/Reagents/ReagentSystem_functions.sqf#L34)
## reagentSystem_createOnObj

Type: function

Description: 
- Param: _mats (optional, default [])
- Param: _capacity

File: [host\Reagents\ReagentSystem_functions.sqf at line 129](../../../Src/host/Reagents/ReagentSystem_functions.sqf#L129)
## reagentSystem_createHolder

Type: function

Description: 
- Param: _src
- Param: _maxvol
- Param: _mats

File: [host\Reagents\ReagentSystem_functions.sqf at line 145](../../../Src/host/Reagents/ReagentSystem_functions.sqf#L145)
# Reagetns.hpp

## SOLID

Type: constant

Description: 


Replaced value:
```sqf
1
```
File: [host\Reagents\Reagetns.hpp at line 6](../../../Src/host/Reagents/Reagetns.hpp#L6)
## LIQUID

Type: constant

Description: 


Replaced value:
```sqf
2
```
File: [host\Reagents\Reagetns.hpp at line 7](../../../Src/host/Reagents/Reagetns.hpp#L7)
## GAS

Type: constant

Description: 


Replaced value:
```sqf
3
```
File: [host\Reagents\Reagetns.hpp at line 8](../../../Src/host/Reagents/Reagetns.hpp#L8)
## TOUCH

Type: constant

Description: 


Replaced value:
```sqf
1
```
File: [host\Reagents\Reagetns.hpp at line 10](../../../Src/host/Reagents/Reagetns.hpp#L10)
## INGEST

Type: constant

Description: 


Replaced value:
```sqf
2
```
File: [host\Reagents\Reagetns.hpp at line 11](../../../Src/host/Reagents/Reagetns.hpp#L11)
## INJECT

Type: constant

Description: 


Replaced value:
```sqf
3
```
File: [host\Reagents\Reagetns.hpp at line 12](../../../Src/host/Reagents/Reagetns.hpp#L12)
## REACTION_COOKING

Type: constant

Description: сварить. Такая реакция возникает при варке в колбах и кастрюлях


Replaced value:
```sqf
0
```
File: [host\Reagents\Reagetns.hpp at line 15](../../../Src/host/Reagents/Reagetns.hpp#L15)
## REACTION_BLENDING

Type: constant

Description: смешать. Такая реакция возникает при смешивании


Replaced value:
```sqf
1
```
File: [host\Reagents\Reagetns.hpp at line 17](../../../Src/host/Reagents/Reagetns.hpp#L17)
## REACTION_GRIND

Type: constant

Description: молоть. Реакция возникнет при размоле


Replaced value:
```sqf
2
```
File: [host\Reagents\Reagetns.hpp at line 19](../../../Src/host/Reagents/Reagetns.hpp#L19)
## REACTION_CHEM

Type: constant

Description: химическая реакция. происходит только в хим блендере или химсистеме


Replaced value:
```sqf
5
```
File: [host\Reagents\Reagetns.hpp at line 21](../../../Src/host/Reagents/Reagetns.hpp#L21)
## REACTION_FRY

Type: constant

Description: DEPREACTED::::::::::::::::::::::::::::: жарить. Реакция возникнет при жарке на сковороде или открытом огне


Replaced value:
```sqf
3
```
File: [host\Reagents\Reagetns.hpp at line 23](../../../Src/host/Reagents/Reagetns.hpp#L23)
## REACTION_DRYING

Type: constant

Description: DEPREACTED::::::::::::::::::::::::::::: сушка - вытяжка. Реакция возникнет


Replaced value:
```sqf
4
```
File: [host\Reagents\Reagetns.hpp at line 25](../../../Src/host/Reagents/Reagetns.hpp#L25)
## REACTION_ENUM_TO_TYPENAME(enum)

Type: constant

Description: 
- Param: enum

Replaced value:
```sqf
(["REACTION_COOKING","REACTION_BLENDING","REACTION_GRIND","REACTION_FRY","REACTION_DRYING"] select enum)
```
File: [host\Reagents\Reagetns.hpp at line 27](../../../Src/host/Reagents/Reagetns.hpp#L27)
## REACTION_ENUM_TO_NAME(enum)

Type: constant

Description: 
- Param: enum

Replaced value:
```sqf
(["Готовка","Смешивание","Перемалывание","Жарка","Сушка"] select enum)
```
File: [host\Reagents\Reagetns.hpp at line 28](../../../Src/host/Reagents/Reagetns.hpp#L28)
## __KELVIN__

Type: constant

Description: температура абсолютного нуля для кельвинов


Replaced value:
```sqf
273.15
```
File: [host\Reagents\Reagetns.hpp at line 31](../../../Src/host/Reagents/Reagetns.hpp#L31)
## TOCELSIUS(val)

Type: constant

Description: умная замена: var(temp,TOCELSIUS(3000))
- Param: val

Replaced value:
```sqf
((val) - __KELVIN__)
```
File: [host\Reagents\Reagetns.hpp at line 34](../../../Src/host/Reagents/Reagetns.hpp#L34)
## TCEL(val)

Type: constant

Description: конвертация из цельсиев в кельвины
- Param: val

Replaced value:
```sqf
(val-__KELVIN__)
```
File: [host\Reagents\Reagetns.hpp at line 37](../../../Src/host/Reagents/Reagetns.hpp#L37)
## TKEL(val)

Type: constant

Description: конвертация из кельвинов в цельсии (используется для визуализации)
- Param: val

Replaced value:
```sqf
(val+__KELVIN__)
```
File: [host\Reagents\Reagetns.hpp at line 39](../../../Src/host/Reagents/Reagetns.hpp#L39)
## DEFAULT_TEMPERATURE

Type: constant

Description: стандартная температура созданных мсов


Replaced value:
```sqf
26
```
File: [host\Reagents\Reagetns.hpp at line 42](../../../Src/host/Reagents/Reagetns.hpp#L42)
## _UNC_GRAMM_VALUE_

Type: constant

Description: 


Replaced value:
```sqf
28.35
```
File: [host\Reagents\Reagetns.hpp at line 45](../../../Src/host/Reagents/Reagetns.hpp#L45)
## U

Type: constant

Description: 


Replaced value:
```sqf
* _UNC_GRAMM_VALUE_
```
File: [host\Reagents\Reagetns.hpp at line 47](../../../Src/host/Reagents/Reagetns.hpp#L47)
## OZ(gramm)

Type: constant

Description: унции меньше грамма. В унциях все мсы
- Param: gramm

Replaced value:
```sqf
(gramm U)
```
File: [host\Reagents\Reagetns.hpp at line 50](../../../Src/host/Reagents/Reagetns.hpp#L50)
## REAGENT_ML2OZ(am)

Type: constant

Description: милилитры в унции
- Param: am

Replaced value:
```sqf
(am / 28.35)
```
File: [host\Reagents\Reagetns.hpp at line 59](../../../Src/host/Reagents/Reagetns.hpp#L59)
## REAGENT_L2OZ(am)

Type: constant

Description: литры в унции
- Param: am

Replaced value:
```sqf
(1000*(am) / 28.35)
```
File: [host\Reagents\Reagetns.hpp at line 61](../../../Src/host/Reagents/Reagetns.hpp#L61)
# ReagetSystem_init.sqf

## reagentSystem_count_created

Type: Variable

Description: 


Initial value:
```sqf
0 //сколько создано реагентов
```
File: [host\Reagents\ReagetSystem_init.sqf at line 12](../../../Src/host/Reagents/ReagetSystem_init.sqf#L12)
## reagentSystem_count_destroyed

Type: Variable

Description: сколько создано реагентов


Initial value:
```sqf
0 //сколько удалено реагетов
```
File: [host\Reagents\ReagetSystem_init.sqf at line 13](../../../Src/host/Reagents/ReagetSystem_init.sqf#L13)
## reagentSystem_internal_lastEx

Type: Variable

Description: сколько удалено реагетов


Initial value:
```sqf
""
```
File: [host\Reagents\ReagetSystem_init.sqf at line 17](../../../Src/host/Reagents/ReagetSystem_init.sqf#L17)
## reagentSystem_internal_lastObj

Type: Variable

Description: 


Initial value:
```sqf
nullPtr
```
File: [host\Reagents\ReagetSystem_init.sqf at line 18](../../../Src/host/Reagents/ReagetSystem_init.sqf#L18)
## reagentSystem_map_allReactions

Type: Variable

Description: 


Initial value:
```sqf
createHashMap
```
File: [host\Reagents\ReagetSystem_init.sqf at line 20](../../../Src/host/Reagents/ReagetSystem_init.sqf#L20)
# Reaction.sqf

## reactgen_common

Type: constant

Description: 


Replaced value:
```sqf
INC(reagentsystem_reactions_counter); _reactionName = "react_gen_" + str reagentsystem_reactions_counter; \
class_runtime(_reactionName) extends(ReagentReaction)
```
File: [host\Reagents\Reactions\Reaction.sqf at line 36](../../../Src/host/Reagents/Reactions/Reaction.sqf#L36)
## reactgen_first

Type: constant

Description: 


Replaced value:
```sqf
reactgen_common
```
File: [host\Reagents\Reactions\Reaction.sqf at line 39](../../../Src/host/Reagents/Reactions/Reaction.sqf#L39)
## reactgen

Type: constant

Description: 


Replaced value:
```sqf
endclass reactgen_common
```
File: [host\Reagents\Reactions\Reaction.sqf at line 36](../../../Src/host/Reagents/Reactions/Reaction.sqf#L36)
## endreactgen

Type: constant

Description: 


Replaced value:
```sqf
endclass
```
File: [host\Reagents\Reactions\Reaction.sqf at line 43](../../../Src/host/Reagents/Reactions/Reaction.sqf#L43)
## reagentsystem_reactions_counter

Type: Variable

Description: 


Initial value:
```sqf
0
```
File: [host\Reagents\Reactions\Reaction.sqf at line 7](../../../Src/host/Reagents/Reactions/Reaction.sqf#L7)
# ReagentsAll.sqf

## defchem(__class,txtpropval)

Type: constant

Description: basic chemical
- Param: __class
- Param: txtpropval

Replaced value:
```sqf
class(__class) extends(ReagentBase) var(name,txtpropval); endclass
```
File: [host\Reagents\Reagents\ReagentsAll.sqf at line 94](../../../Src/host/Reagents/Reagents/ReagentsAll.sqf#L94)
## defchem_impl(__class,txtpropval)

Type: constant

Description: 
- Param: __class
- Param: txtpropval

Replaced value:
```sqf
class(__class) extends(ReagentBase) var(name,txtpropval);
```
File: [host\Reagents\Reagents\ReagentsAll.sqf at line 95](../../../Src/host/Reagents/Reagents/ReagentsAll.sqf#L95)
