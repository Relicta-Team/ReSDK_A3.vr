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
## CRAFT_USING_TYPE_NAMESPACE(var)

Type: constant

Description: 
- Param: var

Replaced value:
```sqf
var##_crft
```
File: [host\CraftSystem\Craft.hpp at line 30](../../../Src/host/CraftSystem/Craft.hpp#L30)
## CRAFT_USING_TYPE_NAMESPACE_STR(var)

Type: constant

Description: 
- Param: var

Replaced value:
```sqf
'var##_crft'
```
File: [host\CraftSystem\Craft.hpp at line 31](../../../Src/host/CraftSystem/Craft.hpp#L31)
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

> Exists if **_SQFVM** not defined

Description: 


Replaced value:
```sqf
_obj
```
File: [host\CraftSystem\Craft_initData.sqf at line 16](../../../Src/host/CraftSystem/Craft_initData.sqf#L16)
## craft_data_count

Type: Variable

> Exists if **_SQFVM** not defined

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

> Exists if **_SQFVM** not defined

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
