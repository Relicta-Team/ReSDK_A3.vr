# craftmeun_init.sqf

## CRAFT_WIND_SIZE_X

Type: constant

Description: 


Replaced value:
```sqf
60
```
File: [client\CraftMenu\craftmeun_init.sqf at line 14](../../../Src/client/CraftMenu/craftmeun_init.sqf#L14)
## CRAFT_WIND_SIZE_Y

Type: constant

Description: 


Replaced value:
```sqf
80
```
File: [client\CraftMenu\craftmeun_init.sqf at line 15](../../../Src/client/CraftMenu/craftmeun_init.sqf#L15)
## SIZE_CATEGORY_BUTTON

Type: constant

Description: 


Replaced value:
```sqf
10
```
File: [client\CraftMenu\craftmeun_init.sqf at line 17](../../../Src/client/CraftMenu/craftmeun_init.sqf#L17)
## SIZE_RECIPE_TEXT

Type: constant

Description: 


Replaced value:
```sqf
8
```
File: [client\CraftMenu\craftmeun_init.sqf at line 18](../../../Src/client/CraftMenu/craftmeun_init.sqf#L18)
## getRecipesWidget()

Type: constant

Description: 
- Param: 

Replaced value:
```sqf
(craft_widgets select 0)
```
File: [client\CraftMenu\craftmeun_init.sqf at line 20](../../../Src/client/CraftMenu/craftmeun_init.sqf#L20)
## setRecipesWidget(_refer)

Type: constant

Description: 
- Param: _refer

Replaced value:
```sqf
(craft_widgets set [0,_refer])
```
File: [client\CraftMenu\craftmeun_init.sqf at line 21](../../../Src/client/CraftMenu/craftmeun_init.sqf#L21)
## getRecipeInfoWidget()

Type: constant

Description: 
- Param: 

Replaced value:
```sqf
(craft_widgets select 1)
```
File: [client\CraftMenu\craftmeun_init.sqf at line 23](../../../Src/client/CraftMenu/craftmeun_init.sqf#L23)
## setRecipeInfoWidget(_refer)

Type: constant

Description: 
- Param: _refer

Replaced value:
```sqf
(craft_widgets set [1,_refer])
```
File: [client\CraftMenu\craftmeun_init.sqf at line 24](../../../Src/client/CraftMenu/craftmeun_init.sqf#L24)
## getCraftButton()

Type: constant

Description: 
- Param: 

Replaced value:
```sqf
(craft_widgets select 2)
```
File: [client\CraftMenu\craftmeun_init.sqf at line 26](../../../Src/client/CraftMenu/craftmeun_init.sqf#L26)
## setCraftButton(_refer)

Type: constant

Description: 
- Param: _refer

Replaced value:
```sqf
(craft_widgets set [2,_refer])
```
File: [client\CraftMenu\craftmeun_init.sqf at line 27](../../../Src/client/CraftMenu/craftmeun_init.sqf#L27)
## craft_cxtRpcSourcePtr

Type: Variable

Description: 


Initial value:
```sqf
""
```
File: [client\CraftMenu\craftmeun_init.sqf at line 29](../../../Src/client/CraftMenu/craftmeun_init.sqf#L29)
## isCraftOpen

Type: Variable

Description: 


Initial value:
```sqf
false
```
File: [client\CraftMenu\craftmeun_init.sqf at line 31](../../../Src/client/CraftMenu/craftmeun_init.sqf#L31)
## craft_widgets

Type: Variable

Description: 


Initial value:
```sqf
[widgetNull,widgetNull,widgetNull]
```
File: [client\CraftMenu\craftmeun_init.sqf at line 33](../../../Src/client/CraftMenu/craftmeun_init.sqf#L33)
## craft_isActiveCraftButton

Type: Variable

Description: 


Initial value:
```sqf
false
```
File: [client\CraftMenu\craftmeun_init.sqf at line 34](../../../Src/client/CraftMenu/craftmeun_init.sqf#L34)
## craft_attributes

Type: Variable

Description: 


Initial value:
```sqf
createHashMap
```
File: [client\CraftMenu\craftmeun_init.sqf at line 35](../../../Src/client/CraftMenu/craftmeun_init.sqf#L35)
## craft_lastPressedRecipeID

Type: Variable

Description: 


Initial value:
```sqf
-1
```
File: [client\CraftMenu\craftmeun_init.sqf at line 37](../../../Src/client/CraftMenu/craftmeun_init.sqf#L37)
## craft_loadCateg_isLoading

Type: Variable

Description: 


Initial value:
```sqf
false
```
File: [client\CraftMenu\craftmeun_init.sqf at line 39](../../../Src/client/CraftMenu/craftmeun_init.sqf#L39)
## craft_loadCateg_lastLoadingTime

Type: Variable

Description: 


Initial value:
```sqf
0
```
File: [client\CraftMenu\craftmeun_init.sqf at line 40](../../../Src/client/CraftMenu/craftmeun_init.sqf#L40)
## craft_open

Type: function

Description: 
- Param: _visibleCat
- Param: _listRecipes

File: [client\CraftMenu\craftmeun_init.sqf at line 42](../../../Src/client/CraftMenu/craftmeun_init.sqf#L42)
## craft_onLoadCategory

Type: function

Description: 
- Param: _cat
- Param: _listRecipes

File: [client\CraftMenu\craftmeun_init.sqf at line 142](../../../Src/client/CraftMenu/craftmeun_init.sqf#L142)
## craft_onSelectRecipe

Type: function

Description: 
- Param: _systemId

File: [client\CraftMenu\craftmeun_init.sqf at line 189](../../../Src/client/CraftMenu/craftmeun_init.sqf#L189)
## craft_clearRecipeInfo

Type: function

Description: 


File: [client\CraftMenu\craftmeun_init.sqf at line 208](../../../Src/client/CraftMenu/craftmeun_init.sqf#L208)
## craft_setActiveCraftButton

Type: function

Description: 
- Param: _mode

File: [client\CraftMenu\craftmeun_init.sqf at line 215](../../../Src/client/CraftMenu/craftmeun_init.sqf#L215)
## craft_onPressCraft

Type: function

Description: 


File: [client\CraftMenu\craftmeun_init.sqf at line 231](../../../Src/client/CraftMenu/craftmeun_init.sqf#L231)
## craft_onClose

Type: function

Description: 


File: [client\CraftMenu\craftmeun_init.sqf at line 239](../../../Src/client/CraftMenu/craftmeun_init.sqf#L239)
## craft_close

Type: function

Description: 


File: [client\CraftMenu\craftmeun_init.sqf at line 243](../../../Src/client/CraftMenu/craftmeun_init.sqf#L243)
