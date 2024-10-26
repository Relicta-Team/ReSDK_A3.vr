# craftmeun_init.sqf

## CRAFT_WIND_SIZE_X

Type: constant

Description: 


Replaced value:
```sqf
60
```
File: [client\CraftMenu\craftmeun_init.sqf at line 16](../../../Src/client/CraftMenu/craftmeun_init.sqf#L16)
## CRAFT_WIND_SIZE_Y

Type: constant

Description: 


Replaced value:
```sqf
80
```
File: [client\CraftMenu\craftmeun_init.sqf at line 17](../../../Src/client/CraftMenu/craftmeun_init.sqf#L17)
## SIZE_CATEGORY_BUTTON

Type: constant

Description: 


Replaced value:
```sqf
10
```
File: [client\CraftMenu\craftmeun_init.sqf at line 19](../../../Src/client/CraftMenu/craftmeun_init.sqf#L19)
## SIZE_RECIPE_TEXT

Type: constant

Description: 


Replaced value:
```sqf
8
```
File: [client\CraftMenu\craftmeun_init.sqf at line 20](../../../Src/client/CraftMenu/craftmeun_init.sqf#L20)
## getRecipesWidget()

Type: constant

Description: 
- Param: 

Replaced value:
```sqf
(craft_widgets select 0)
```
File: [client\CraftMenu\craftmeun_init.sqf at line 22](../../../Src/client/CraftMenu/craftmeun_init.sqf#L22)
## setRecipesWidget(_refer)

Type: constant

Description: 
- Param: _refer

Replaced value:
```sqf
(craft_widgets set [0,_refer])
```
File: [client\CraftMenu\craftmeun_init.sqf at line 23](../../../Src/client/CraftMenu/craftmeun_init.sqf#L23)
## getRecipeInfoWidget()

Type: constant

Description: 
- Param: 

Replaced value:
```sqf
(craft_widgets select 1)
```
File: [client\CraftMenu\craftmeun_init.sqf at line 25](../../../Src/client/CraftMenu/craftmeun_init.sqf#L25)
## setRecipeInfoWidget(_refer)

Type: constant

Description: 
- Param: _refer

Replaced value:
```sqf
(craft_widgets set [1,_refer])
```
File: [client\CraftMenu\craftmeun_init.sqf at line 26](../../../Src/client/CraftMenu/craftmeun_init.sqf#L26)
## getCraftButton()

Type: constant

Description: 
- Param: 

Replaced value:
```sqf
(craft_widgets select 2)
```
File: [client\CraftMenu\craftmeun_init.sqf at line 28](../../../Src/client/CraftMenu/craftmeun_init.sqf#L28)
## setCraftButton(_refer)

Type: constant

Description: 
- Param: _refer

Replaced value:
```sqf
(craft_widgets set [2,_refer])
```
File: [client\CraftMenu\craftmeun_init.sqf at line 29](../../../Src/client/CraftMenu/craftmeun_init.sqf#L29)
## craft_cxtRpcSourcePtr

Type: Variable

Description: 


Initial value:
```sqf
""
```
File: [client\CraftMenu\craftmeun_init.sqf at line 31](../../../Src/client/CraftMenu/craftmeun_init.sqf#L31)
## isCraftOpen

Type: Variable

Description: 


Initial value:
```sqf
false
```
File: [client\CraftMenu\craftmeun_init.sqf at line 33](../../../Src/client/CraftMenu/craftmeun_init.sqf#L33)
## craft_widgets

Type: Variable

Description: 


Initial value:
```sqf
[widgetNull,widgetNull,widgetNull]
```
File: [client\CraftMenu\craftmeun_init.sqf at line 35](../../../Src/client/CraftMenu/craftmeun_init.sqf#L35)
## craft_isActiveCraftButton

Type: Variable

Description: 


Initial value:
```sqf
false
```
File: [client\CraftMenu\craftmeun_init.sqf at line 36](../../../Src/client/CraftMenu/craftmeun_init.sqf#L36)
## craft_attributes

Type: Variable

Description: 


Initial value:
```sqf
createHashMap
```
File: [client\CraftMenu\craftmeun_init.sqf at line 37](../../../Src/client/CraftMenu/craftmeun_init.sqf#L37)
## craft_lastPressedRecipeID

Type: Variable

Description: 


Initial value:
```sqf
-1
```
File: [client\CraftMenu\craftmeun_init.sqf at line 39](../../../Src/client/CraftMenu/craftmeun_init.sqf#L39)
## craft_loadCateg_isLoading

Type: Variable

Description: 


Initial value:
```sqf
false
```
File: [client\CraftMenu\craftmeun_init.sqf at line 41](../../../Src/client/CraftMenu/craftmeun_init.sqf#L41)
## craft_loadCateg_lastLoadingTime

Type: Variable

Description: 


Initial value:
```sqf
0
```
File: [client\CraftMenu\craftmeun_init.sqf at line 42](../../../Src/client/CraftMenu/craftmeun_init.sqf#L42)
## craft_isPreviewOnlyMode

Type: Variable

Description: режим предпросмотра рецептов (без кнопки крафта)


Initial value:
```sqf
false
```
File: [client\CraftMenu\craftmeun_init.sqf at line 45](../../../Src/client/CraftMenu/craftmeun_init.sqf#L45)
## craft_open

Type: function

Description: 
- Param: _visibleCat
- Param: _listRecipes
- Param: _onlyPreview (optional, default false)

File: [client\CraftMenu\craftmeun_init.sqf at line 47](../../../Src/client/CraftMenu/craftmeun_init.sqf#L47)
## craft_onLoadCategory

Type: function

Description: 
- Param: _cat
- Param: _listRecipes

File: [client\CraftMenu\craftmeun_init.sqf at line 151](../../../Src/client/CraftMenu/craftmeun_init.sqf#L151)
## craft_onSelectRecipe

Type: function

Description: 
- Param: _wid

File: [client\CraftMenu\craftmeun_init.sqf at line 223](../../../Src/client/CraftMenu/craftmeun_init.sqf#L223)
## craft_clearRecipeInfo

Type: function

Description: 


File: [client\CraftMenu\craftmeun_init.sqf at line 246](../../../Src/client/CraftMenu/craftmeun_init.sqf#L246)
## craft_setActiveCraftButton

Type: function

Description: 
- Param: _mode

File: [client\CraftMenu\craftmeun_init.sqf at line 253](../../../Src/client/CraftMenu/craftmeun_init.sqf#L253)
## craft_onPressCraft

Type: function

Description: 


File: [client\CraftMenu\craftmeun_init.sqf at line 269](../../../Src/client/CraftMenu/craftmeun_init.sqf#L269)
## craft_onClose

Type: function

Description: 


File: [client\CraftMenu\craftmeun_init.sqf at line 277](../../../Src/client/CraftMenu/craftmeun_init.sqf#L277)
## craft_close

Type: function

Description: 


File: [client\CraftMenu\craftmeun_init.sqf at line 281](../../../Src/client/CraftMenu/craftmeun_init.sqf#L281)
# Craft_preview.sqf

## craft_isPreviewEnabled

Type: Variable

Description: 


Initial value:
```sqf
false
```
File: [client\CraftMenu\Craft_preview.sqf at line 6](../../../Src/client/CraftMenu/Craft_preview.sqf#L6)
## craft_previewMesh

Type: Variable

Description: 


Initial value:
```sqf
null
```
File: [client\CraftMenu\Craft_preview.sqf at line 7](../../../Src/client/CraftMenu/Craft_preview.sqf#L7)
## craft_previewMeshDistance

Type: Variable

Description: 


Initial value:
```sqf
0
```
File: [client\CraftMenu\Craft_preview.sqf at line 9](../../../Src/client/CraftMenu/Craft_preview.sqf#L9)
## craft_previewMeshDir

Type: Variable

Description: safe-release display handlers


Initial value:
```sqf
0
```
File: [client\CraftMenu\Craft_preview.sqf at line 10](../../../Src/client/CraftMenu/Craft_preview.sqf#L10)
## craft_preview_modifierRotation

Type: Variable

Description: 


Initial value:
```sqf
false
```
File: [client\CraftMenu\Craft_preview.sqf at line 11](../../../Src/client/CraftMenu/Craft_preview.sqf#L11)
## craft_preview_modifierDistance

Type: Variable

Description: 


Initial value:
```sqf
false
```
File: [client\CraftMenu\Craft_preview.sqf at line 12](../../../Src/client/CraftMenu/Craft_preview.sqf#L12)
## craft_internal_handlers

Type: Variable

Description: bind display handlers and save mesh


Initial value:
```sqf
[] //zchanged, mouseup
```
File: [client\CraftMenu\Craft_preview.sqf at line 13](../../../Src/client/CraftMenu/Craft_preview.sqf#L13)
## craft_internal_releaseHandlers

Type: function

Description: zchanged, mouseup


File: [client\CraftMenu\Craft_preview.sqf at line 15](../../../Src/client/CraftMenu/Craft_preview.sqf#L15)
## craft_startPreview

Type: function

Description: 
- Param: _model
- Param: _pos

File: [client\CraftMenu\Craft_preview.sqf at line 29](../../../Src/client/CraftMenu/Craft_preview.sqf#L29)
## craft_endPreview

Type: function

Description: 
- Param: _apply

File: [client\CraftMenu\Craft_preview.sqf at line 118](../../../Src/client/CraftMenu/Craft_preview.sqf#L118)
## craft_endPreviewImpl

Type: function

Description: 
- Param: _apply

File: [client\CraftMenu\Craft_preview.sqf at line 125](../../../Src/client/CraftMenu/Craft_preview.sqf#L125)
