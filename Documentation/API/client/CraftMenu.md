# CraftMenu_RPC.sqf

## craft_openCraftMenuRequest

Type: function

Description: 
- Param: _src
- Param: _usr
- Param: _categories
- Param: _listFirstCat
- Param: _onlyPreview (optional, default false)

File: [client\CraftMenu\CraftMenu_RPC.sqf at line 11](../../../Src/client/CraftMenu/CraftMenu_RPC.sqf#L11)
## craft_onCraftLoadCateg

Type: function

Description: 
- Param: _categ
- Param: _list

File: [client\CraftMenu\CraftMenu_RPC.sqf at line 21](../../../Src/client/CraftMenu/CraftMenu_RPC.sqf#L21)
## craft_craftPreviewProcess

Type: function

Description: 
- Param: _pos
- Param: _model

File: [client\CraftMenu\CraftMenu_RPC.sqf at line 37](../../../Src/client/CraftMenu/CraftMenu_RPC.sqf#L37)
# craftmeun_init.sqf

## CRAFT_WIND_SIZE_X

Type: constant

Description: 


Replaced value:
```sqf
60
```
File: [client\CraftMenu\craftmeun_init.sqf at line 19](../../../Src/client/CraftMenu/craftmeun_init.sqf#L19)
## CRAFT_WIND_SIZE_Y

Type: constant

Description: 


Replaced value:
```sqf
80
```
File: [client\CraftMenu\craftmeun_init.sqf at line 21](../../../Src/client/CraftMenu/craftmeun_init.sqf#L21)
## SIZE_CATEGORY_BUTTON

Type: constant

Description: 


Replaced value:
```sqf
10
```
File: [client\CraftMenu\craftmeun_init.sqf at line 24](../../../Src/client/CraftMenu/craftmeun_init.sqf#L24)
## SIZE_RECIPE_TEXT

Type: constant

Description: 


Replaced value:
```sqf
8
```
File: [client\CraftMenu\craftmeun_init.sqf at line 27](../../../Src/client/CraftMenu/craftmeun_init.sqf#L27)
## getRecipesWidget()

Type: constant

Description: 
- Param: 

Replaced value:
```sqf
(craft_widgets select 0)
```
File: [client\CraftMenu\craftmeun_init.sqf at line 30](../../../Src/client/CraftMenu/craftmeun_init.sqf#L30)
## setRecipesWidget(_refer)

Type: constant

Description: 
- Param: _refer

Replaced value:
```sqf
(craft_widgets set [0,_refer])
```
File: [client\CraftMenu\craftmeun_init.sqf at line 32](../../../Src/client/CraftMenu/craftmeun_init.sqf#L32)
## getRecipeInfoWidget()

Type: constant

Description: 
- Param: 

Replaced value:
```sqf
(craft_widgets select 1)
```
File: [client\CraftMenu\craftmeun_init.sqf at line 35](../../../Src/client/CraftMenu/craftmeun_init.sqf#L35)
## setRecipeInfoWidget(_refer)

Type: constant

Description: 
- Param: _refer

Replaced value:
```sqf
(craft_widgets set [1,_refer])
```
File: [client\CraftMenu\craftmeun_init.sqf at line 37](../../../Src/client/CraftMenu/craftmeun_init.sqf#L37)
## getCraftButton()

Type: constant

Description: 
- Param: 

Replaced value:
```sqf
(craft_widgets select 2)
```
File: [client\CraftMenu\craftmeun_init.sqf at line 40](../../../Src/client/CraftMenu/craftmeun_init.sqf#L40)
## setCraftButton(_refer)

Type: constant

Description: 
- Param: _refer

Replaced value:
```sqf
(craft_widgets set [2,_refer])
```
File: [client\CraftMenu\craftmeun_init.sqf at line 42](../../../Src/client/CraftMenu/craftmeun_init.sqf#L42)
## craft_cxtRpcSourcePtr

Type: Variable

Description: 


Initial value:
```sqf
""
```
File: [client\CraftMenu\craftmeun_init.sqf at line 45](../../../Src/client/CraftMenu/craftmeun_init.sqf#L45)
## craft_isMenuOpen

Type: Variable

Description: 


Initial value:
```sqf
false
```
File: [client\CraftMenu\craftmeun_init.sqf at line 48](../../../Src/client/CraftMenu/craftmeun_init.sqf#L48)
## craft_widgets

Type: Variable

Description: 


Initial value:
```sqf
[widgetNull,widgetNull,widgetNull]
```
File: [client\CraftMenu\craftmeun_init.sqf at line 51](../../../Src/client/CraftMenu/craftmeun_init.sqf#L51)
## craft_isActiveCraftButton

Type: Variable

Description: 


Initial value:
```sqf
false
```
File: [client\CraftMenu\craftmeun_init.sqf at line 53](../../../Src/client/CraftMenu/craftmeun_init.sqf#L53)
## craft_attributes

Type: Variable

Description: 


Initial value:
```sqf
createHashMap
```
File: [client\CraftMenu\craftmeun_init.sqf at line 55](../../../Src/client/CraftMenu/craftmeun_init.sqf#L55)
## craft_lastPressedRecipeID

Type: Variable

Description: 


Initial value:
```sqf
-1
```
File: [client\CraftMenu\craftmeun_init.sqf at line 57](../../../Src/client/CraftMenu/craftmeun_init.sqf#L57)
## craft_loadCateg_isLoading

Type: Variable

Description: 


Initial value:
```sqf
false
```
File: [client\CraftMenu\craftmeun_init.sqf at line 59](../../../Src/client/CraftMenu/craftmeun_init.sqf#L59)
## craft_loadCateg_lastLoadingTime

Type: Variable

Description: 


Initial value:
```sqf
0
```
File: [client\CraftMenu\craftmeun_init.sqf at line 61](../../../Src/client/CraftMenu/craftmeun_init.sqf#L61)
## craft_isPreviewOnlyMode

Type: Variable

Description: 


Initial value:
```sqf
false
```
File: [client\CraftMenu\craftmeun_init.sqf at line 65](../../../Src/client/CraftMenu/craftmeun_init.sqf#L65)
## craft_open

Type: function

Description: 
- Param: _visibleCat
- Param: _listRecipes
- Param: _onlyPreview (optional, default false)

File: [client\CraftMenu\craftmeun_init.sqf at line 68](../../../Src/client/CraftMenu/craftmeun_init.sqf#L68)
## craft_onLoadCategory

Type: function

Description: 
- Param: _cat
- Param: _listRecipes

File: [client\CraftMenu\craftmeun_init.sqf at line 172](../../../Src/client/CraftMenu/craftmeun_init.sqf#L172)
## craft_onSelectRecipe

Type: function

Description: 
- Param: _wid

File: [client\CraftMenu\craftmeun_init.sqf at line 244](../../../Src/client/CraftMenu/craftmeun_init.sqf#L244)
## craft_clearRecipeInfo

Type: function

Description: 


File: [client\CraftMenu\craftmeun_init.sqf at line 268](../../../Src/client/CraftMenu/craftmeun_init.sqf#L268)
## craft_setActiveCraftButton

Type: function

Description: 
- Param: _mode

File: [client\CraftMenu\craftmeun_init.sqf at line 276](../../../Src/client/CraftMenu/craftmeun_init.sqf#L276)
## craft_onPressCraft

Type: function

Description: 


File: [client\CraftMenu\craftmeun_init.sqf at line 293](../../../Src/client/CraftMenu/craftmeun_init.sqf#L293)
## craft_onClose

Type: function

Description: 


File: [client\CraftMenu\craftmeun_init.sqf at line 302](../../../Src/client/CraftMenu/craftmeun_init.sqf#L302)
## craft_close

Type: function

Description: 


File: [client\CraftMenu\craftmeun_init.sqf at line 307](../../../Src/client/CraftMenu/craftmeun_init.sqf#L307)
# Craft_preview.sqf

## craft_isPreviewEnabled

Type: Variable

Description: 


Initial value:
```sqf
false
```
File: [client\CraftMenu\Craft_preview.sqf at line 11](../../../Src/client/CraftMenu/Craft_preview.sqf#L11)
## craft_previewMesh

Type: Variable

Description: 


Initial value:
```sqf
null
```
File: [client\CraftMenu\Craft_preview.sqf at line 13](../../../Src/client/CraftMenu/Craft_preview.sqf#L13)
## craft_previewMeshDistance

Type: Variable

Description: 


Initial value:
```sqf
0
```
File: [client\CraftMenu\Craft_preview.sqf at line 16](../../../Src/client/CraftMenu/Craft_preview.sqf#L16)
## craft_previewMeshDir

Type: Variable

Description: safe-release display handlers


Initial value:
```sqf
0
```
File: [client\CraftMenu\Craft_preview.sqf at line 18](../../../Src/client/CraftMenu/Craft_preview.sqf#L18)
## craft_preview_modifierRotation

Type: Variable

Description: 


Initial value:
```sqf
false
```
File: [client\CraftMenu\Craft_preview.sqf at line 20](../../../Src/client/CraftMenu/Craft_preview.sqf#L20)
## craft_preview_modifierDistance

Type: Variable

Description: 


Initial value:
```sqf
false
```
File: [client\CraftMenu\Craft_preview.sqf at line 22](../../../Src/client/CraftMenu/Craft_preview.sqf#L22)
## craft_internal_handlers

Type: Variable

Description: bind display handlers and save mesh


Initial value:
```sqf
[] //zchanged, mouseup
```
File: [client\CraftMenu\Craft_preview.sqf at line 24](../../../Src/client/CraftMenu/Craft_preview.sqf#L24)
## craft_internal_releaseHandlers

Type: function

Description: 


File: [client\CraftMenu\Craft_preview.sqf at line 27](../../../Src/client/CraftMenu/Craft_preview.sqf#L27)
## craft_startPreview

Type: function

Description: 
- Param: _model
- Param: _pos

File: [client\CraftMenu\Craft_preview.sqf at line 42](../../../Src/client/CraftMenu/Craft_preview.sqf#L42)
## craft_endPreview

Type: function

Description: 
- Param: _apply

File: [client\CraftMenu\Craft_preview.sqf at line 132](../../../Src/client/CraftMenu/Craft_preview.sqf#L132)
## craft_endPreviewImpl

Type: function

Description: 
- Param: _apply

File: [client\CraftMenu\Craft_preview.sqf at line 140](../../../Src/client/CraftMenu/Craft_preview.sqf#L140)
