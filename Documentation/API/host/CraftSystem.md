# Craft.h

## CRAFT_PARSER_HEAD

Type: constant

Description: private ["_val__","_mes__","_par_output__"]


Replaced value:
```sqf
private _val__ = nil; private _mes__ = nil
```
File: [host\CraftSystem\Craft.h at line 7](../../../Src/host/CraftSystem/Craft.h#L7)
## value

Type: constant

Description: 


Replaced value:
```sqf
_val__
```
File: [host\CraftSystem\Craft.h at line 9](../../../Src/host/CraftSystem/Craft.h#L9)
## message

Type: constant

Description: 


Replaced value:
```sqf
_mes__
```
File: [host\CraftSystem\Craft.h at line 10](../../../Src/host/CraftSystem/Craft.h#L10)
## GETVAL(dict,key,types)

Type: constant

Description: 
- Param: dict
- Param: key
- Param: types

Replaced value:
```sqf
([dict,key,types] call csys_validateType) params [['value',null],['message',""]]
```
File: [host\CraftSystem\Craft.h at line 12](../../../Src/host/CraftSystem/Craft.h#L12)
## GETVAL_STR(dict,key)

Type: constant

Description: 
- Param: dict
- Param: key

Replaced value:
```sqf
GETVAL(dict,key,"")
```
File: [host\CraftSystem\Craft.h at line 13](../../../Src/host/CraftSystem/Craft.h#L13)
## GETVAL_FLOAT(dict,key)

Type: constant

Description: 
- Param: dict
- Param: key

Replaced value:
```sqf
GETVAL(dict,key,0)
```
File: [host\CraftSystem\Craft.h at line 14](../../../Src/host/CraftSystem/Craft.h#L14)
## GETVAL_INT(dict,key)

Type: constant

Description: 
- Param: dict
- Param: key

Replaced value:
```sqf
GETVAL(dict,key,"int")
```
File: [host\CraftSystem\Craft.h at line 15](../../../Src/host/CraftSystem/Craft.h#L15)
## GETVAL_BOOL(dict,key)

Type: constant

Description: 
- Param: dict
- Param: key

Replaced value:
```sqf
GETVAL(dict,key,false)
```
File: [host\CraftSystem\Craft.h at line 16](../../../Src/host/CraftSystem/Craft.h#L16)
## GETVAL_ARRAY(dict,key)

Type: constant

Description: 
- Param: dict
- Param: key

Replaced value:
```sqf
GETVAL(dict,key,[ [] ])
```
File: [host\CraftSystem\Craft.h at line 17](../../../Src/host/CraftSystem/Craft.h#L17)
## GETVAL_DICT(dict,key)

Type: constant

Description: 
- Param: dict
- Param: key

Replaced value:
```sqf
GETVAL(dict,key,hashMapNull)
```
File: [host\CraftSystem\Craft.h at line 18](../../../Src/host/CraftSystem/Craft.h#L18)
## FAIL_CHECK

Type: constant

Description: 


Replaced value:
```sqf
if (_mes__ != "") exitWith 
```
File: [host\CraftSystem\Craft.h at line 20](../../../Src/host/CraftSystem/Craft.h#L20)
## FAIL_CHECK_PRINT

Type: constant

Description: 


Replaced value:
```sqf
FAIL_CHECK { [_mes__] call csys_errorMessage; false }
```
File: [host\CraftSystem\Craft.h at line 21](../../../Src/host/CraftSystem/Craft.h#L21)
## FAIL_CHECK_REFSET(ref__)

Type: constant

Description: 
- Param: ref__

Replaced value:
```sqf
FAIL_CHECK { refset(ref__,_mes__); }
```
File: [host\CraftSystem\Craft.h at line 22](../../../Src/host/CraftSystem/Craft.h#L22)
## FAIL_CHECK_EMPTY

Type: constant

Description: 


Replaced value:
```sqf
FAIL_CHECK {}
```
File: [host\CraftSystem\Craft.h at line 23](../../../Src/host/CraftSystem/Craft.h#L23)
## CRAFT_DEBUG_LOAD

Type: constant

Description: enable for more verbose logging


Replaced value:
```sqf

```
File: [host\CraftSystem\Craft.h at line 26](../../../Src/host/CraftSystem/Craft.h#L26)
## CRAFT_DEBUG_DURATION_CREATING

Type: constant

Description: 


Replaced value:
```sqf
10
```
File: [host\CraftSystem\Craft.h at line 28](../../../Src/host/CraftSystem/Craft.h#L28)
## CRAFT_DEBUG_VISUAL_ON_ATTEMPT

Type: constant

Description: 


Replaced value:
```sqf

```
File: [host\CraftSystem\Craft.h at line 30](../../../Src/host/CraftSystem/Craft.h#L30)
# Craft.hpp

## CRAFT_CATEGORY_TO_NAME(v)

Type: constant

Description: 
- Param: v

Replaced value:
```sqf
(CRAFT_CONST_CATEGORY_LIST_NAMES select (v))
```
File: [host\CraftSystem\Craft.hpp at line 7](../../../Src/host/CraftSystem/Craft.hpp#L7)
## CRAFT_CATEGORY_ID_CLOTH

Type: constant

Description: 


Replaced value:
```sqf
0
```
File: [host\CraftSystem\Craft.hpp at line 9](../../../Src/host/CraftSystem/Craft.hpp#L9)
## CRAFT_CATEGORY_ID_FOOD

Type: constant

Description: 


Replaced value:
```sqf
1
```
File: [host\CraftSystem\Craft.hpp at line 10](../../../Src/host/CraftSystem/Craft.hpp#L10)
## CRAFT_CATEGORY_ID_ALCHEMY

Type: constant

Description: 


Replaced value:
```sqf
2
```
File: [host\CraftSystem\Craft.hpp at line 11](../../../Src/host/CraftSystem/Craft.hpp#L11)
## CRAFT_CATEGORY_ID_MEDICAL

Type: constant

Description: 


Replaced value:
```sqf
3
```
File: [host\CraftSystem\Craft.hpp at line 12](../../../Src/host/CraftSystem/Craft.hpp#L12)
## CRAFT_CATEGORY_ID_WEAPONS

Type: constant

Description: 


Replaced value:
```sqf
4
```
File: [host\CraftSystem\Craft.hpp at line 13](../../../Src/host/CraftSystem/Craft.hpp#L13)
## CRAFT_CATEGORY_ID_FURNITURE

Type: constant

Description: 


Replaced value:
```sqf
5
```
File: [host\CraftSystem\Craft.hpp at line 14](../../../Src/host/CraftSystem/Craft.hpp#L14)
## CRAFT_CATEGORY_ID_LIGHTING

Type: constant

Description: 


Replaced value:
```sqf
6
```
File: [host\CraftSystem\Craft.hpp at line 15](../../../Src/host/CraftSystem/Craft.hpp#L15)
## CRAFT_CATEGORY_ID_BUILDINGS

Type: constant

Description: 


Replaced value:
```sqf
7
```
File: [host\CraftSystem\Craft.hpp at line 16](../../../Src/host/CraftSystem/Craft.hpp#L16)
## CRAFT_CATEGORY_ID_OTHER

Type: constant

Description: 


Replaced value:
```sqf
8
```
File: [host\CraftSystem\Craft.hpp at line 17](../../../Src/host/CraftSystem/Craft.hpp#L17)
## CRAFT_CONST_CATEGORY_LIST_NAMES

Type: constant

Description: 


Replaced value:
```sqf
[ \
	"Одежда", \
	"Кулинария", \
	"Алхимия", \
	"Медицина", \
	"Оружие", \
	"Мебель", \
	"Свет", \
	"Постройки", \
	"Прочее" \
] 
```
File: [host\CraftSystem\Craft.hpp at line 19](../../../Src/host/CraftSystem/Craft.hpp#L19)
## CRAFT_CONST_CATEGORY_LIST_SYS_NAMES

Type: constant

Description: 


Replaced value:
```sqf
[ \
	"Cloth", \
	"Food", \
	"Alchemy", \
	"Medical", \
	"Weapon", \
	"Furniture", \
	"Light", \
	"Building", \
	"Other" \
]
```
File: [host\CraftSystem\Craft.hpp at line 31](../../../Src/host/CraftSystem/Craft.hpp#L31)
## CRAFT_CONST_CATEGORY_LIST_IDS

Type: constant

Description: 


Replaced value:
```sqf
(call{ private _idIter = -1; CRAFT_CONST_CATEGORY_LIST_SYS_NAMES apply \
{_idIter = _idIter + 1; _idIter} \
})
```
File: [host\CraftSystem\Craft.hpp at line 43](../../../Src/host/CraftSystem/Craft.hpp#L43)
# CraftSystemProcess.sqf

## csys_internal_editor_list_prepobjects

Type: Variable

> Exists if **CRAFT_DEBUG_VISUAL_ON_ATTEMPT** defined

Description: 


Initial value:
```sqf
[]
```
File: [host\CraftSystem\CraftSystemProcess.sqf at line 89](../../../Src/host/CraftSystem/CraftSystemProcess.sqf#L89)
## csys_internal_editor_lastRecipe

Type: Variable

> Exists if **EDITOR** defined

Description: 


Initial value:
```sqf
null
```
File: [host\CraftSystem\CraftSystemProcess.sqf at line 117](../../../Src/host/CraftSystem/CraftSystemProcess.sqf#L117)
## csys_internal_editor_lastIngredients

Type: Variable

Description: 


Initial value:
```sqf
null
```
File: [host\CraftSystem\CraftSystemProcess.sqf at line 118](../../../Src/host/CraftSystem/CraftSystemProcess.sqf#L118)
## csys_requestOpenMenu

Type: function

Description: 
- Param: _objSrc
- Param: _usr
- Param: _onlyPreviewMode (optional, default false)

File: [host\CraftSystem\CraftSystemProcess.sqf at line 6](../../../Src/host/CraftSystem/CraftSystemProcess.sqf#L6)
## csys_getRecipesForUser

Type: function

Description: возвращает массив данных: vec2(recipeId,name + needs + optdesc)
- Param: _catId
- Param: _usr
- Param: _src
- Param: _onlyPreview (optional, default false)

File: [host\CraftSystem\CraftSystemProcess.sqf at line 45](../../../Src/host/CraftSystem/CraftSystemProcess.sqf#L45)
## csys_requestLoadCateg

Type: function

Description: запрос загрузки новой категории
- Param: _usrptr
- Param: _srcPtr
- Param: _cat
- Param: _isPreview (optional, default false)

File: [host\CraftSystem\CraftSystemProcess.sqf at line 59](../../../Src/host/CraftSystem/CraftSystemProcess.sqf#L59)
## csys_tryCraft

Type: function

Description: 
- Param: _usrptr
- Param: _srcptr
- Param: _recipeID

File: [host\CraftSystem\CraftSystemProcess.sqf at line 72](../../../Src/host/CraftSystem/CraftSystemProcess.sqf#L72)
## csys_onCraftEndPreview

Type: function

Description: 
- Param: this
- Param: _isApply
- Param: _tfmOpt

File: [host\CraftSystem\CraftSystemProcess.sqf at line 100](../../../Src/host/CraftSystem/CraftSystemProcess.sqf#L100)
## csys_processCraftMain

Type: function

Description: 
- Param: _usr
- Param: _objectColleciton
- Param: _recipeIdOrSystem

File: [host\CraftSystem\CraftSystemProcess.sqf at line 125](../../../Src/host/CraftSystem/CraftSystemProcess.sqf#L125)
# CraftSystem_init.sqf

## csys_map_allCraftRefs

Type: Variable

Description: key int, val ICraftRecipeBase


Initial value:
```sqf
createHashMap
```
File: [host\CraftSystem\CraftSystem_init.sqf at line 37](../../../Src/host/CraftSystem/CraftSystem_init.sqf#L37)
## csys_map_allInteractiveCrafts

Type: Variable

Description: key string(typename) as target, val array<ICraftRecipeBase>


Initial value:
```sqf
createHashMap
```
File: [host\CraftSystem\CraftSystem_init.sqf at line 39](../../../Src/host/CraftSystem/CraftSystem_init.sqf#L39)
## csys_map_allSystemCrafts

Type: Variable

Description: key string(typename), val array<ICraftRecipeBase>


Initial value:
```sqf
createHashMap //! В будущем можно перенести хранение буферов крафтов на типы классов
```
File: [host\CraftSystem\CraftSystem_init.sqf at line 41](../../../Src/host/CraftSystem/CraftSystem_init.sqf#L41)
## csys_map_storage

Type: Variable

Description: глобальное хранилище крафтов по категориям, key int(id), val array<ICraftRecipeBase>


Initial value:
```sqf
createhashMap 
```
File: [host\CraftSystem\CraftSystem_init.sqf at line 44](../../../Src/host/CraftSystem/CraftSystem_init.sqf#L44)
## csys_map_systems_storage

Type: Variable

Description: системные крафты...


Initial value:
```sqf
createhashMap
```
File: [host\CraftSystem\CraftSystem_init.sqf at line 47](../../../Src/host/CraftSystem/CraftSystem_init.sqf#L47)
## csys_global_counter

Type: Variable

Description: 


Initial value:
```sqf
1
```
File: [host\CraftSystem\CraftSystem_init.sqf at line 49](../../../Src/host/CraftSystem/CraftSystem_init.sqf#L49)
## csys_cat_map_sysnames

Type: Variable

Description: 


Initial value:
```sqf
createHashMap
```
File: [host\CraftSystem\CraftSystem_init.sqf at line 51](../../../Src/host/CraftSystem/CraftSystem_init.sqf#L51)
## csys_cat_debug_allCrafts

Type: Variable

> Exists if **DEBUG** defined

Description: 


Initial value:
```sqf
[]
```
File: [host\CraftSystem\CraftSystem_init.sqf at line 55](../../../Src/host/CraftSystem/CraftSystem_init.sqf#L55)
## csys_const_map_mappingTypes

Type: Variable

Description: 


Initial value:
```sqf
createHashMapFromArray [...
```
File: [host\CraftSystem\CraftSystem_init.sqf at line 127](../../../Src/host/CraftSystem/CraftSystem_init.sqf#L127)
## csys_internal_lastLoadedFile

Type: Variable

Description: 


Initial value:
```sqf
""
```
File: [host\CraftSystem\CraftSystem_init.sqf at line 134](../../../Src/host/CraftSystem/CraftSystem_init.sqf#L134)
## csys_internal_configNumber

Type: Variable

Description: 


Initial value:
```sqf
0
```
File: [host\CraftSystem\CraftSystem_init.sqf at line 135](../../../Src/host/CraftSystem/CraftSystem_init.sqf#L135)
## csys_map_tokenMap

Type: Variable

Description: 


Initial value:
```sqf
createHashMapFromArray [...
```
File: [host\CraftSystem\CraftSystem_init.sqf at line 376](../../../Src/host/CraftSystem/CraftSystem_init.sqf#L376)
## debug_compiler_csys_lastInstructions

Type: Variable

> Exists if **EDITOR** defined

Description: 


Initial value:
```sqf
[_code,_stack]
```
File: [host\CraftSystem\CraftSystem_init.sqf at line 445](../../../Src/host/CraftSystem/CraftSystem_init.sqf#L445)
## csys_const_regexFunc

Type: Variable

Description: obsolete constants


Initial value:
```sqf
"(\w+)\s*\(\)"
```
File: [host\CraftSystem\CraftSystem_init.sqf at line 510](../../../Src/host/CraftSystem/CraftSystem_init.sqf#L510)
## csys_const_regexField

Type: Variable

Description: 


Initial value:
```sqf
"\w+"
```
File: [host\CraftSystem\CraftSystem_init.sqf at line 511](../../../Src/host/CraftSystem/CraftSystem_init.sqf#L511)
## csys_const_regexOP

Type: Variable

Description: 


Initial value:
```sqf
"==|!=|<=|>=|\|\||&&|>|<"
```
File: [host\CraftSystem\CraftSystem_init.sqf at line 512](../../../Src/host/CraftSystem/CraftSystem_init.sqf#L512)
## csys_const_alllowRegex

Type: Variable

Description: 


Initial value:
```sqf
(csys_const_regexFunc+"|"+csys_const_regexField+"|"+csys_const_regexOP)
```
File: [host\CraftSystem\CraftSystem_init.sqf at line 513](../../../Src/host/CraftSystem/CraftSystem_init.sqf#L513)
## csys_list_systemControllers

Type: Variable

Description: 


Initial value:
```sqf
[] //SystemControllerCrafts  системы зарегистрированы здесь
```
File: [host\CraftSystem\CraftSystem_init.sqf at line 517](../../../Src/host/CraftSystem/CraftSystem_init.sqf#L517)
## csys_map_systemControllersIndexes

Type: Variable

Description: SystemControllerCrafts  системы зарегистрированы здесь


Initial value:
```sqf
createhashMap //k<int>, v<SystemControllerCrafts>
```
File: [host\CraftSystem\CraftSystem_init.sqf at line 518](../../../Src/host/CraftSystem/CraftSystem_init.sqf#L518)
## csys_systemController_handleUpdate

Type: Variable

Description: 


Initial value:
```sqf
-1
```
File: [host\CraftSystem\CraftSystem_init.sqf at line 534](../../../Src/host/CraftSystem/CraftSystem_init.sqf#L534)
## csys_cat_getSystemNameById

Type: function

Description: 


File: [host\CraftSystem\CraftSystem_init.sqf at line 52](../../../Src/host/CraftSystem/CraftSystem_init.sqf#L52)
## csys_init

Type: function

Description: 


File: [host\CraftSystem\CraftSystem_init.sqf at line 58](../../../Src/host/CraftSystem/CraftSystem_init.sqf#L58)
## csys_loadConfig

Type: function

Description: загрузчик рецептов
- Param: _cfgContent

File: [host\CraftSystem\CraftSystem_init.sqf at line 109](../../../Src/host/CraftSystem/CraftSystem_init.sqf#L109)
## csys_errorMessage

Type: function

Description: 
- Param: _fmt

File: [host\CraftSystem\CraftSystem_init.sqf at line 137](../../../Src/host/CraftSystem/CraftSystem_init.sqf#L137)
## csys_validateType

Type: function

Description: TODO optimize
- Param: _dat
- Param: _key
- Param: _tarr

File: [host\CraftSystem\CraftSystem_init.sqf at line 151](../../../Src/host/CraftSystem/CraftSystem_init.sqf#L151)
## csys_internal_loadCfgSegment

Type: function

Description: 
- Param: _data

File: [host\CraftSystem\CraftSystem_init.sqf at line 207](../../../Src/host/CraftSystem/CraftSystem_init.sqf#L207)
## csys_format

Type: function

Description: 
- Param: _str
- Param: _argsmap

File: [host\CraftSystem\CraftSystem_init.sqf at line 332](../../../Src/host/CraftSystem/CraftSystem_init.sqf#L332)
## csys_formatSelector

Type: function

Description: 
- Param: _val

File: [host\CraftSystem\CraftSystem_init.sqf at line 360](../../../Src/host/CraftSystem/CraftSystem_init.sqf#L360)
## csys_defaultTokenCode

Type: function

Description: 


File: [host\CraftSystem\CraftSystem_init.sqf at line 381](../../../Src/host/CraftSystem/CraftSystem_init.sqf#L381)
## csys_prepareRangedString

Type: function

Description: генериурет ранжированный список на основе входной строки: "item(1-5)" -> ["item1","item2","item3","item4","item5"]
- Param: _input
- Param: _intoArray (optional, default false)

File: [host\CraftSystem\CraftSystem_init.sqf at line 384](../../../Src/host/CraftSystem/CraftSystem_init.sqf#L384)
## csys_internal_generateYamlExpr

Type: function

Description: 
- Param: _instr

File: [host\CraftSystem\CraftSystem_init.sqf at line 405](../../../Src/host/CraftSystem/CraftSystem_init.sqf#L405)
## csys_generateInsturctions

Type: function

Description: 
- Param: _condition

File: [host\CraftSystem\CraftSystem_init.sqf at line 457](../../../Src/host/CraftSystem/CraftSystem_init.sqf#L457)
## csys_getSystemController

Type: function

Description: get or register craft system controller (SystemControllerCrafts)
- Param: _sysname

File: [host\CraftSystem\CraftSystem_init.sqf at line 521](../../../Src/host/CraftSystem/CraftSystem_init.sqf#L521)
## csys_systemController_onUpdate

Type: function

Description: 


File: [host\CraftSystem\CraftSystem_init.sqf at line 535](../../../Src/host/CraftSystem/CraftSystem_init.sqf#L535)
## csys_internal_generateSchema

Type: function

> Exists if **EDITOR** defined

Description: 


File: [host\CraftSystem\CraftSystem_init.sqf at line 543](../../../Src/host/CraftSystem/CraftSystem_init.sqf#L543)
# Modifier_base_struct.sqf

## mmap

Type: constant

Description: 


Replaced value:
```sqf
createHashMapFromArray
```
File: [host\CraftSystem\Modifiers\Modifier_base_struct.sqf at line 131](../../../Src/host/CraftSystem/Modifiers/Modifier_base_struct.sqf#L131)
# ObjectSystem.h

## debug_system(argvals)

Type: constant

> Exists if **ENABLE_THIS_SYSTEM_DEBUG** defined

Description: 
- Param: argvals

Replaced value:
```sqf
[format ['<%1> %2',self,format [argvals]]] call cprint;
```
File: [host\CraftSystem\ObjectSystems\ObjectSystem.h at line 14](../../../Src/host/CraftSystem/ObjectSystems/ObjectSystem.h#L14)
## debug_system(argvals)

Type: constant

> Exists if **ENABLE_THIS_SYSTEM_DEBUG** not defined

Description: 
- Param: argvals

Replaced value:
```sqf

```
File: [host\CraftSystem\ObjectSystems\ObjectSystem.h at line 16](../../../Src/host/CraftSystem/ObjectSystems/ObjectSystem.h#L16)
