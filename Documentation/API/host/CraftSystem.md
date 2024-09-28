# Craft.hpp

## CRAFT_CATEGORY_CLOTH

Type: constant

Description: !!! sort order actual !!!


Replaced value:
```sqf
0
```
File: [host\CraftSystem\Craft.hpp at line 8](../../../Src/host/CraftSystem/Craft.hpp#L8)
## CRAFT_CATEGORY_FOOD

Type: constant

Description: 


Replaced value:
```sqf
1
```
File: [host\CraftSystem\Craft.hpp at line 9](../../../Src/host/CraftSystem/Craft.hpp#L9)
## CRAFT_CATEGORY_ALCHEMY

Type: constant

Description: 


Replaced value:
```sqf
2
```
File: [host\CraftSystem\Craft.hpp at line 10](../../../Src/host/CraftSystem/Craft.hpp#L10)
## CRAFT_CATEGORY_MEDICAL

Type: constant

Description: 


Replaced value:
```sqf
3
```
File: [host\CraftSystem\Craft.hpp at line 11](../../../Src/host/CraftSystem/Craft.hpp#L11)
## CRAFT_CATEGORY_WEAPONS

Type: constant

Description: 


Replaced value:
```sqf
4
```
File: [host\CraftSystem\Craft.hpp at line 12](../../../Src/host/CraftSystem/Craft.hpp#L12)
## CRAFT_CATEGORY_FURNITURE

Type: constant

Description: 


Replaced value:
```sqf
5
```
File: [host\CraftSystem\Craft.hpp at line 13](../../../Src/host/CraftSystem/Craft.hpp#L13)
## CRAFT_CATEGORY_LIGHTING

Type: constant

Description: 


Replaced value:
```sqf
6
```
File: [host\CraftSystem\Craft.hpp at line 14](../../../Src/host/CraftSystem/Craft.hpp#L14)
## CRAFT_CATEGORY_BUILDINGS

Type: constant

Description: 


Replaced value:
```sqf
7
```
File: [host\CraftSystem\Craft.hpp at line 15](../../../Src/host/CraftSystem/Craft.hpp#L15)
## CRAFT_CATEGORY_OTHER

Type: constant

Description: 


Replaced value:
```sqf
8
```
File: [host\CraftSystem\Craft.hpp at line 16](../../../Src/host/CraftSystem/Craft.hpp#L16)
## CRAFT_CATEGORY_COUNT_STD

Type: constant

Description: 


Replaced value:
```sqf
5000
```
File: [host\CraftSystem\Craft.hpp at line 18](../../../Src/host/CraftSystem/Craft.hpp#L18)
## CRAFT_CATEGORY_LIST_ALL

Type: constant

Description: 


Replaced value:
```sqf
[0,1,2,3,4,5,6,7,8]
```
File: [host\CraftSystem\Craft.hpp at line 19](../../../Src/host/CraftSystem/Craft.hpp#L19)
## CRAFT_CATEGORY_LIST_NAMES

Type: constant

Description: 


Replaced value:
```sqf
["Одежда","Кулинария","Алхимия","Медицина","Оружие","Мебель","Свет","Постройки","Прочее"]
```
File: [host\CraftSystem\Craft.hpp at line 20](../../../Src/host/CraftSystem/Craft.hpp#L20)
## CRAFT_CATEGORY_TO_NAME(cat)

Type: constant

Description: 
- Param: cat

Replaced value:
```sqf
(CRAFT_CATEGORY_LIST_NAMES select (cat))
```
File: [host\CraftSystem\Craft.hpp at line 21](../../../Src/host/CraftSystem/Craft.hpp#L21)
## CRAFT_RECIPE_SYSTEMID

Type: constant

Description: [_header,_reqinfo,_serverReqItems,_conditionVisible,_handleReqitems,_conditionCraft,_resultAction];


Replaced value:
```sqf
0
```
File: [host\CraftSystem\Craft.hpp at line 24](../../../Src/host/CraftSystem/Craft.hpp#L24)
## CRAFT_RECIPE_NAME

Type: constant

Description: 


Replaced value:
```sqf
1
```
File: [host\CraftSystem\Craft.hpp at line 25](../../../Src/host/CraftSystem/Craft.hpp#L25)
## CRAFT_RECIPE_REQITEMS

Type: constant

Description: 


Replaced value:
```sqf
2
```
File: [host\CraftSystem\Craft.hpp at line 26](../../../Src/host/CraftSystem/Craft.hpp#L26)
## CRAFT_RECIPE_DESC

Type: constant

Description: 


Replaced value:
```sqf
3
```
File: [host\CraftSystem\Craft.hpp at line 27](../../../Src/host/CraftSystem/Craft.hpp#L27)
# Craft.sqf

## craft_trycraft_debug_flag

Type: constant

Description: 


Replaced value:
```sqf

```
File: [host\CraftSystem\Craft.sqf at line 44](../../../Src/host/CraftSystem/Craft.sqf#L44)
## craft_requestOpenMenu

Type: function

Description: запрос открытия крафт меню
- Param: _objSrc
- Param: _usr

File: [host\CraftSystem\Craft.sqf at line 16](../../../Src/host/CraftSystem/Craft.sqf#L16)
## craft_requestLoadCateg

Type: function

Description: 
- Param: _usrptr
- Param: _cat

File: [host\CraftSystem\Craft.sqf at line 35](../../../Src/host/CraftSystem/Craft.sqf#L35)
## craft_tryCraft

Type: function

Description: 
- Param: _usrptr
- Param: _srcptr
- Param: _recipeID

File: [host\CraftSystem\Craft.sqf at line 46](../../../Src/host/CraftSystem/Craft.sqf#L46)
## craft_tryCraft_internal

Type: function

Description: Внутренний метод попытки крафта с отбросом всех исключений
- Param: this
- Param: _obj
- Param: _recipeID

File: [host\CraftSystem\Craft.sqf at line 63](../../../Src/host/CraftSystem/Craft.sqf#L63)
# Craft_initData.sqf

## this

Type: constant

> Exists if **__VM_VALIDATE** not defined

Description: 


Replaced value:
```sqf
_obj
```
File: [host\CraftSystem\Craft_initData.sqf at line 16](../../../Src/host/CraftSystem/Craft_initData.sqf#L16)
## craft_data_count

Type: Variable

> Exists if **__VM_VALIDATE** not defined

Description: 


Initial value:
```sqf
0
```
File: [host\CraftSystem\Craft_initData.sqf at line 13](../../../Src/host/CraftSystem/Craft_initData.sqf#L13)
## craft_data_categories

Type: Variable

Description: 


Initial value:
```sqf
createHashMap //value is array
```
File: [host\CraftSystem\Craft_initData.sqf at line 17](../../../Src/host/CraftSystem/Craft_initData.sqf#L17)
## craft_data_allRecipes

Type: Variable

Description: value is array


Initial value:
```sqf
createHashMap
```
File: [host\CraftSystem\Craft_initData.sqf at line 18](../../../Src/host/CraftSystem/Craft_initData.sqf#L18)
## craft_data_catIndexes

Type: Variable

Description: 


Initial value:
```sqf
CRAFT_CATEGORY_LIST_ALL apply ...
```
File: [host\CraftSystem\Craft_initData.sqf at line 20](../../../Src/host/CraftSystem/Craft_initData.sqf#L20)
## craft_internal_client_mapRecipes

Type: Variable

Description: [5001,"Бибки",["Тесто","Яичко"],""] call craft_newRecipe;


Initial value:
```sqf
createHashMap
```
File: [host\CraftSystem\Craft_initData.sqf at line 68](../../../Src/host/CraftSystem/Craft_initData.sqf#L68)
## craft_data_getRecipes

Type: function

> Exists if **__VM_VALIDATE** not defined

Description: Получает рецепты с категории
- Param: _cat
- Param: _usr

File: [host\CraftSystem\Craft_initData.sqf at line 23](../../../Src/host/CraftSystem/Craft_initData.sqf#L23)
# Basic.sqf

## src

Type: constant

Description: #define DEBUG_DISTANCE_NEAREST


Replaced value:
```sqf
_src
```
File: [host\CraftSystem\Crafts\Basic.sqf at line 19](../../../Src/host/CraftSystem/Crafts/Basic.sqf#L19)
## usr

Type: constant

Description: 


Replaced value:
```sqf
_usr
```
File: [host\CraftSystem\Crafts\Basic.sqf at line 20](../../../Src/host/CraftSystem/Crafts/Basic.sqf#L20)
## collectedItems

Type: constant

Description: список предметов для удаления


Replaced value:
```sqf
_reqItemPointers
```
File: [host\CraftSystem\Crafts\Basic.sqf at line 23](../../../Src/host/CraftSystem/Crafts/Basic.sqf#L23)
## vecForward(pos,dir,bias)

Type: constant

Description: 
- Param: pos
- Param: dir
- Param: bias

Replaced value:
```sqf
(pos) vectorAdd [sin (dir) * bias,cos (dir) * bias,0]
```
File: [host\CraftSystem\Crafts\Basic.sqf at line 74](../../../Src/host/CraftSystem/Crafts/Basic.sqf#L74)
# Craft.h

## CRAFT_PARSER_HEAD

Type: constant

Description: 


Replaced value:
```sqf
private ["_val__","_mes__","_par_output__"]
```
File: [host\CraftSystem\Internal\Craft.h at line 6](../../../Src/host/CraftSystem/Internal/Craft.h#L6)
## value

Type: constant

Description: 


Replaced value:
```sqf
_val__
```
File: [host\CraftSystem\Internal\Craft.h at line 8](../../../Src/host/CraftSystem/Internal/Craft.h#L8)
## message

Type: constant

Description: 


Replaced value:
```sqf
_mes__
```
File: [host\CraftSystem\Internal\Craft.h at line 9](../../../Src/host/CraftSystem/Internal/Craft.h#L9)
## GETVAL(dict,key,types)

Type: constant

Description: 
- Param: dict
- Param: key
- Param: types

Replaced value:
```sqf
_par_output__ = ([dict,key,types] call csys_validateType); value = _par_output__ select 0; message = _par_output__ select 1
```
File: [host\CraftSystem\Internal\Craft.h at line 11](../../../Src/host/CraftSystem/Internal/Craft.h#L11)
## GETVAL_STR(dict,key)

Type: constant

Description: 
- Param: dict
- Param: key

Replaced value:
```sqf
GETVAL(dict,key,"")
```
File: [host\CraftSystem\Internal\Craft.h at line 12](../../../Src/host/CraftSystem/Internal/Craft.h#L12)
## GETVAL_FLOAT(dict,key)

Type: constant

Description: 
- Param: dict
- Param: key

Replaced value:
```sqf
GETVAL(dict,key,0)
```
File: [host\CraftSystem\Internal\Craft.h at line 13](../../../Src/host/CraftSystem/Internal/Craft.h#L13)
## GETVAL_INT(dict,key)

Type: constant

Description: 
- Param: dict
- Param: key

Replaced value:
```sqf
GETVAL(dict,key,"int")
```
File: [host\CraftSystem\Internal\Craft.h at line 14](../../../Src/host/CraftSystem/Internal/Craft.h#L14)
## GETVAL_BOOL(dict,key)

Type: constant

Description: 
- Param: dict
- Param: key

Replaced value:
```sqf
GETVAL(dict,key,false)
```
File: [host\CraftSystem\Internal\Craft.h at line 15](../../../Src/host/CraftSystem/Internal/Craft.h#L15)
## GETVAL_ARRAY(dict,key)

Type: constant

Description: 
- Param: dict
- Param: key

Replaced value:
```sqf
GETVAL(dict,key,[ [] ])
```
File: [host\CraftSystem\Internal\Craft.h at line 16](../../../Src/host/CraftSystem/Internal/Craft.h#L16)
## GETVAL_DICT(dict,key)

Type: constant

Description: 
- Param: dict
- Param: key

Replaced value:
```sqf
GETVAL(dict,key,hashMapNull)
```
File: [host\CraftSystem\Internal\Craft.h at line 17](../../../Src/host/CraftSystem/Internal/Craft.h#L17)
## FAIL_CHECK

Type: constant

Description: 


Replaced value:
```sqf
if (_mes__ != "") exitWith 
```
File: [host\CraftSystem\Internal\Craft.h at line 19](../../../Src/host/CraftSystem/Internal/Craft.h#L19)
## FAIL_CHECK_PRINT

Type: constant

Description: 


Replaced value:
```sqf
FAIL_CHECK { [_mes__] call csys_errorMessage; false }
```
File: [host\CraftSystem\Internal\Craft.h at line 20](../../../Src/host/CraftSystem/Internal/Craft.h#L20)
## FAIL_CHECK_REFSET(ref__)

Type: constant

Description: 
- Param: ref__

Replaced value:
```sqf
FAIL_CHECK { refset(ref__,_mes__); }
```
File: [host\CraftSystem\Internal\Craft.h at line 21](../../../Src/host/CraftSystem/Internal/Craft.h#L21)
## FAIL_CHECK_EMPTY

Type: constant

Description: 


Replaced value:
```sqf
FAIL_CHECK {}
```
File: [host\CraftSystem\Internal\Craft.h at line 22](../../../Src/host/CraftSystem/Internal/Craft.h#L22)
## CRAFT_DEBUG_LOAD

Type: constant

Description: enable for more verbose logging


Replaced value:
```sqf

```
File: [host\CraftSystem\Internal\Craft.h at line 25](../../../Src/host/CraftSystem/Internal/Craft.h#L25)
# Craft.hpp

## CRAFT_CATEGORY_ID_CLOTH

Type: constant

Description: 


Replaced value:
```sqf
0
```
File: [host\CraftSystem\Internal\Craft.hpp at line 6](../../../Src/host/CraftSystem/Internal/Craft.hpp#L6)
## CRAFT_CATEGORY_ID_FOOD

Type: constant

Description: 


Replaced value:
```sqf
1
```
File: [host\CraftSystem\Internal\Craft.hpp at line 7](../../../Src/host/CraftSystem/Internal/Craft.hpp#L7)
## CRAFT_CATEGORY_ID_ALCHEMY

Type: constant

Description: 


Replaced value:
```sqf
2
```
File: [host\CraftSystem\Internal\Craft.hpp at line 8](../../../Src/host/CraftSystem/Internal/Craft.hpp#L8)
## CRAFT_CATEGORY_ID_MEDICAL

Type: constant

Description: 


Replaced value:
```sqf
3
```
File: [host\CraftSystem\Internal\Craft.hpp at line 9](../../../Src/host/CraftSystem/Internal/Craft.hpp#L9)
## CRAFT_CATEGORY_ID_WEAPONS

Type: constant

Description: 


Replaced value:
```sqf
4
```
File: [host\CraftSystem\Internal\Craft.hpp at line 10](../../../Src/host/CraftSystem/Internal/Craft.hpp#L10)
## CRAFT_CATEGORY_ID_FURNITURE

Type: constant

Description: 


Replaced value:
```sqf
5
```
File: [host\CraftSystem\Internal\Craft.hpp at line 11](../../../Src/host/CraftSystem/Internal/Craft.hpp#L11)
## CRAFT_CATEGORY_ID_LIGHTING

Type: constant

Description: 


Replaced value:
```sqf
6
```
File: [host\CraftSystem\Internal\Craft.hpp at line 12](../../../Src/host/CraftSystem/Internal/Craft.hpp#L12)
## CRAFT_CATEGORY_ID_BUILDINGS

Type: constant

Description: 


Replaced value:
```sqf
7
```
File: [host\CraftSystem\Internal\Craft.hpp at line 13](../../../Src/host/CraftSystem/Internal/Craft.hpp#L13)
## CRAFT_CATEGORY_ID_OTHER

Type: constant

Description: 


Replaced value:
```sqf
8
```
File: [host\CraftSystem\Internal\Craft.hpp at line 14](../../../Src/host/CraftSystem/Internal/Craft.hpp#L14)
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
File: [host\CraftSystem\Internal\Craft.hpp at line 16](../../../Src/host/CraftSystem/Internal/Craft.hpp#L16)
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
File: [host\CraftSystem\Internal\Craft.hpp at line 28](../../../Src/host/CraftSystem/Internal/Craft.hpp#L28)
# CraftSystem.sqf

## csys_map_allCraftRefs

Type: Variable

Description: key int, val ICraftRecipeBase


Initial value:
```sqf
createHashMap
```
File: [host\CraftSystem\Internal\CraftSystem.sqf at line 32](../../../Src/host/CraftSystem/Internal/CraftSystem.sqf#L32)
## csys_map_allInteractiveCrafts

Type: Variable

Description: key string(typename), val array<ICraftRecipeBase>


Initial value:
```sqf
createHashMap
```
File: [host\CraftSystem\Internal\CraftSystem.sqf at line 34](../../../Src/host/CraftSystem/Internal/CraftSystem.sqf#L34)
## csys_map_allSystemCrafts

Type: Variable

Description: key string(typename), val array<ICraftRecipeBase>


Initial value:
```sqf
createHashMap //! В будущем можно перенести хранение буферов крафтов на типы классов
```
File: [host\CraftSystem\Internal\CraftSystem.sqf at line 36](../../../Src/host/CraftSystem/Internal/CraftSystem.sqf#L36)
## csys_map_storage

Type: Variable

Description: глобальное хранилище крафтов по категориям, key int(id), val array<ICraftRecipeBase>


Initial value:
```sqf
createhashMap 
```
File: [host\CraftSystem\Internal\CraftSystem.sqf at line 39](../../../Src/host/CraftSystem/Internal/CraftSystem.sqf#L39)
## csys_global_counter

Type: Variable

Description: 


Initial value:
```sqf
1
```
File: [host\CraftSystem\Internal\CraftSystem.sqf at line 41](../../../Src/host/CraftSystem/Internal/CraftSystem.sqf#L41)
## csys_cat_names

Type: Variable

Description: 


Initial value:
```sqf
CRAFT_CONST_CATEGORY_NAMES
```
File: [host\CraftSystem\Internal\CraftSystem.sqf at line 42](../../../Src/host/CraftSystem/Internal/CraftSystem.sqf#L42)
## csys_cat_map_sysnames

Type: Variable

Description: 


Initial value:
```sqf
createHashMap
```
File: [host\CraftSystem\Internal\CraftSystem.sqf at line 43](../../../Src/host/CraftSystem/Internal/CraftSystem.sqf#L43)
## csys_cat_debug_allCrafts

Type: Variable

> Exists if **DEBUG** defined

Description: 


Initial value:
```sqf
[]
```
File: [host\CraftSystem\Internal\CraftSystem.sqf at line 49](../../../Src/host/CraftSystem/Internal/CraftSystem.sqf#L49)
## csys_const_map_mappingTypes

Type: Variable

Description: 


Initial value:
```sqf
createHashMapFromArray [...
```
File: [host\CraftSystem\Internal\CraftSystem.sqf at line 110](../../../Src/host/CraftSystem/Internal/CraftSystem.sqf#L110)
## csys_internal_lastLoadedFile

Type: Variable

Description: 


Initial value:
```sqf
""
```
File: [host\CraftSystem\Internal\CraftSystem.sqf at line 117](../../../Src/host/CraftSystem/Internal/CraftSystem.sqf#L117)
## csys_internal_configNumber

Type: Variable

Description: 


Initial value:
```sqf
0
```
File: [host\CraftSystem\Internal\CraftSystem.sqf at line 118](../../../Src/host/CraftSystem/Internal/CraftSystem.sqf#L118)
## csys_map_tokenMap

Type: Variable

Description: 


Initial value:
```sqf
createHashMapFromArray [...
```
File: [host\CraftSystem\Internal\CraftSystem.sqf at line 305](../../../Src/host/CraftSystem/Internal/CraftSystem.sqf#L305)
## csys_const_regexFunc

Type: Variable

Description: 


Initial value:
```sqf
"(\w+)\s*\(\)"
```
File: [host\CraftSystem\Internal\CraftSystem.sqf at line 370](../../../Src/host/CraftSystem/Internal/CraftSystem.sqf#L370)
## csys_const_regexField

Type: Variable

Description: 


Initial value:
```sqf
"\w+"
```
File: [host\CraftSystem\Internal\CraftSystem.sqf at line 371](../../../Src/host/CraftSystem/Internal/CraftSystem.sqf#L371)
## csys_const_regexOP

Type: Variable

Description: 


Initial value:
```sqf
"==|!=|<=|>=|\|\||&&|>|<"
```
File: [host\CraftSystem\Internal\CraftSystem.sqf at line 372](../../../Src/host/CraftSystem/Internal/CraftSystem.sqf#L372)
## csys_const_alllowRegex

Type: Variable

Description: 


Initial value:
```sqf
(csys_const_regexFunc+"|"+csys_const_regexField+"|"+csys_const_regexOP)
```
File: [host\CraftSystem\Internal\CraftSystem.sqf at line 373](../../../Src/host/CraftSystem/Internal/CraftSystem.sqf#L373)
## csys_cat_getNameById

Type: function

Description: 


File: [host\CraftSystem\Internal\CraftSystem.sqf at line 45](../../../Src/host/CraftSystem/Internal/CraftSystem.sqf#L45)
## csys_cat_getSystemNameById

Type: function

Description: 


File: [host\CraftSystem\Internal\CraftSystem.sqf at line 46](../../../Src/host/CraftSystem/Internal/CraftSystem.sqf#L46)
## csys_init

Type: function

Description: 


File: [host\CraftSystem\Internal\CraftSystem.sqf at line 52](../../../Src/host/CraftSystem/Internal/CraftSystem.sqf#L52)
## csys_loadConfig

Type: function

Description: загрузчик рецептов
- Param: _cfgContent

File: [host\CraftSystem\Internal\CraftSystem.sqf at line 93](../../../Src/host/CraftSystem/Internal/CraftSystem.sqf#L93)
## csys_errorMessage

Type: function

Description: 
- Param: _fmt

File: [host\CraftSystem\Internal\CraftSystem.sqf at line 120](../../../Src/host/CraftSystem/Internal/CraftSystem.sqf#L120)
## csys_validateType

Type: function

Description: 
- Param: _dat
- Param: _key
- Param: _tarr

File: [host\CraftSystem\Internal\CraftSystem.sqf at line 131](../../../Src/host/CraftSystem/Internal/CraftSystem.sqf#L131)
## csys_internal_loadCfgSegment

Type: function

Description: 
- Param: _data

File: [host\CraftSystem\Internal\CraftSystem.sqf at line 169](../../../Src/host/CraftSystem/Internal/CraftSystem.sqf#L169)
## csys_format

Type: function

Description: 
- Param: _str
- Param: _argsmap

File: [host\CraftSystem\Internal\CraftSystem.sqf at line 278](../../../Src/host/CraftSystem/Internal/CraftSystem.sqf#L278)
## csys_defaultTokenCode

Type: function

Description: 


File: [host\CraftSystem\Internal\CraftSystem.sqf at line 310](../../../Src/host/CraftSystem/Internal/CraftSystem.sqf#L310)
## csys_prepareRangedString

Type: function

Description: 
- Param: _input
- Param: _intoArray (optional, default false)

File: [host\CraftSystem\Internal\CraftSystem.sqf at line 312](../../../Src/host/CraftSystem/Internal/CraftSystem.sqf#L312)
## csys_generateInsturctions

Type: function

Description: 
- Param: _condition

File: [host\CraftSystem\Internal\CraftSystem.sqf at line 333](../../../Src/host/CraftSystem/Internal/CraftSystem.sqf#L333)
# CraftSystemProcess.sqf

## csys_requestOpenMenu

Type: function

Description: 
- Param: _objSrc
- Param: _usr

File: [host\CraftSystem\Internal\CraftSystemProcess.sqf at line 6](../../../Src/host/CraftSystem/Internal/CraftSystemProcess.sqf#L6)
## csys_getRecipesForUser

Type: function

Description: возвращает массив данных: vec2(recipeId,name + needs + optdesc)
- Param: _catId
- Param: _usr

File: [host\CraftSystem\Internal\CraftSystemProcess.sqf at line 26](../../../Src/host/CraftSystem/Internal/CraftSystemProcess.sqf#L26)
## csys_requestLoadCateg

Type: function

Description: запрос загрузки новой категории
- Param: _usrptr
- Param: _cat

File: [host\CraftSystem\Internal\CraftSystemProcess.sqf at line 40](../../../Src/host/CraftSystem/Internal/CraftSystemProcess.sqf#L40)
## csys_tryCraft

Type: function

Description: 
- Param: _usrptr
- Param: _srcptr
- Param: _recipeID

File: [host\CraftSystem\Internal\CraftSystemProcess.sqf at line 49](../../../Src/host/CraftSystem/Internal/CraftSystemProcess.sqf#L49)
## csys_tryCraft_internal

Type: function

Description: попытка крафта через меню
- Param: _usr
- Param: _srcPtr
- Param: _recipeID

File: [host\CraftSystem\Internal\CraftSystemProcess.sqf at line 66](../../../Src/host/CraftSystem/Internal/CraftSystemProcess.sqf#L66)
