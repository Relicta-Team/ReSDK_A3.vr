# NetDisplays.sqf

## nd_map_displays

Type: Variable

Description: 


Initial value:
```sqf
createHashMap
```
File: [client\NetDisplays\NetDisplays.sqf at line 19](../../../Src/client/NetDisplays/NetDisplays.sqf#L19)
## nd_handleUpdate

Type: Variable

Description: 


Initial value:
```sqf
-1
```
File: [client\NetDisplays\NetDisplays.sqf at line 26](../../../Src/client/NetDisplays/NetDisplays.sqf#L26)
## nd_list_widgets

Type: Variable

Description: 


Initial value:
```sqf
[[],[]] //список виджетов с данными. В левом стеке неочищаемые данные до закрытия окна, в правом обновляемый список
```
File: [client\NetDisplays\NetDisplays.sqf at line 29](../../../Src/client/NetDisplays/NetDisplays.sqf#L29)
## nd_sourceObject

Type: Variable

Description: 


Initial value:
```sqf
objNUll
```
File: [client\NetDisplays\NetDisplays.sqf at line 31](../../../Src/client/NetDisplays/NetDisplays.sqf#L31)
## nd_interactionDistance

Type: Variable

Description: 


Initial value:
```sqf
0
```
File: [client\NetDisplays\NetDisplays.sqf at line 33](../../../Src/client/NetDisplays/NetDisplays.sqf#L33)
## nd_isOpenDisplay

Type: Variable

Description: 


Initial value:
```sqf
false
```
File: [client\NetDisplays\NetDisplays.sqf at line 35](../../../Src/client/NetDisplays/NetDisplays.sqf#L35)
## nd_openedDisplayType

Type: Variable

Description: 


Initial value:
```sqf
""
```
File: [client\NetDisplays\NetDisplays.sqf at line 37](../../../Src/client/NetDisplays/NetDisplays.sqf#L37)
## nd_sourceRef

Type: Variable

Description: 


Initial value:
```sqf
""
```
File: [client\NetDisplays\NetDisplays.sqf at line 39](../../../Src/client/NetDisplays/NetDisplays.sqf#L39)
## nd_checkedPos

Type: Variable

Description: find nearest intersection point


Initial value:
```sqf
vec3(0,0,0)
```
File: [client\NetDisplays\NetDisplays.sqf at line 41](../../../Src/client/NetDisplays/NetDisplays.sqf#L41)
## nd_lobby_isOpen

Type: Variable

Description: 


Initial value:
```sqf
false
```
File: [client\NetDisplays\NetDisplays.sqf at line 45](../../../Src/client/NetDisplays/NetDisplays.sqf#L45)
## nd_internal_attemptLoad

Type: Variable

Description: 


Initial value:
```sqf
0
```
File: [client\NetDisplays\NetDisplays.sqf at line 48](../../../Src/client/NetDisplays/NetDisplays.sqf#L48)
## nd_internal_currentStructObj

Type: Variable

Description: 


Initial value:
```sqf
null
```
File: [client\NetDisplays\NetDisplays.sqf at line 372](../../../Src/client/NetDisplays/NetDisplays.sqf#L372)
## nd_createTestDisplay

Type: function

> Exists if **DEBUG** defined

Description: 
- Param: _class
- Param: _data

File: [client\NetDisplays\NetDisplays.sqf at line 52](../../../Src/client/NetDisplays/NetDisplays.sqf#L52)
## nd_createNDObject

Type: function

Description: 
- Param: _type

File: [client\NetDisplays\NetDisplays.sqf at line 73](../../../Src/client/NetDisplays/NetDisplays.sqf#L73)
## nd_loadDisplay

Type: function

Description: 
- Param: _type
- Param: _data (optional, default [])
- Param: _srcRef
- Param: _interactDistance

File: [client\NetDisplays\NetDisplays.sqf at line 81](../../../Src/client/NetDisplays/NetDisplays.sqf#L81)
## nd_loadDisplay_lobby

Type: function

Description: 
- Param: _type
- Param: _data (optional, default [])

File: [client\NetDisplays\NetDisplays.sqf at line 231](../../../Src/client/NetDisplays/NetDisplays.sqf#L231)
## nd_closeND_lobby

Type: function

Description: 
- Param: _isRpc (optional, default false)

File: [client\NetDisplays\NetDisplays.sqf at line 267](../../../Src/client/NetDisplays/NetDisplays.sqf#L267)
## nd_closeND_lobbyImpl

Type: function

Description: 


File: [client\NetDisplays\NetDisplays.sqf at line 280](../../../Src/client/NetDisplays/NetDisplays.sqf#L280)
## nd_onPressButton

Type: function

Description: 
- Param: _data

File: [client\NetDisplays\NetDisplays.sqf at line 290](../../../Src/client/NetDisplays/NetDisplays.sqf#L290)
## nd_cleanupData

Type: function

Description: 


File: [client\NetDisplays\NetDisplays.sqf at line 304](../../../Src/client/NetDisplays/NetDisplays.sqf#L304)
## nd_regWidget

Type: function

Description: 
- Param: _type
- Param: _vecpos
- Param: _probCtg
- Param: _dataType

File: [client\NetDisplays\NetDisplays.sqf at line 313](../../../Src/client/NetDisplays/NetDisplays.sqf#L313)
## nd_addClosingButton

Type: function

Description: 
- Param: _display
- Param: _vec4Pos
- Param: _ctg (optional, default widgetNull)
- Param: _registerAsReloaded (optional, default false)

File: [client\NetDisplays\NetDisplays.sqf at line 320](../../../Src/client/NetDisplays/NetDisplays.sqf#L320)
## nd_onUpdate

Type: function

Description: 


File: [client\NetDisplays\NetDisplays.sqf at line 337](../../../Src/client/NetDisplays/NetDisplays.sqf#L337)
## nd_onClose

Type: function

Description: 


File: [client\NetDisplays\NetDisplays.sqf at line 344](../../../Src/client/NetDisplays/NetDisplays.sqf#L344)
## nd_unloadDisplay

Type: function

Description: 


File: [client\NetDisplays\NetDisplays.sqf at line 354](../../../Src/client/NetDisplays/NetDisplays.sqf#L354)
## nd_stdLoad

Type: function

Description: 
- Param: _isFirstCall
- Param: _sx (optional, default 50)
- Param: _sy (optional, default 50)
- Param: _btName (optional, default "Закрыть")

File: [client\NetDisplays\NetDisplays.sqf at line 376](../../../Src/client/NetDisplays/NetDisplays.sqf#L376)
# MessageBoxes.sqf

## __ND_MB_INPUT_MAX_CHARS

Type: constant

Description: 


Replaced value:
```sqf
255
```
File: [client\NetDisplays\Displays\MessageBoxes.sqf at line 284](../../../Src/client/NetDisplays/Displays/MessageBoxes.sqf#L284)
## __ND_MB_INPUT_MIN_CHARS

Type: constant

Description: 


Replaced value:
```sqf
100
```
File: [client\NetDisplays\Displays\MessageBoxes.sqf at line 285](../../../Src/client/NetDisplays/Displays/MessageBoxes.sqf#L285)
## ND_VOTEREP_WIDGET_INDEX_ERROR

Type: constant

Description: 


Replaced value:
```sqf
0
```
File: [client\NetDisplays\Displays\MessageBoxes.sqf at line 384](../../../Src/client/NetDisplays/Displays/MessageBoxes.sqf#L384)
## ND_VOTEREP_WIDGET_INDEX_BESTCTG

Type: constant

Description: 


Replaced value:
```sqf
1
```
File: [client\NetDisplays\Displays\MessageBoxes.sqf at line 385](../../../Src/client/NetDisplays/Displays/MessageBoxes.sqf#L385)
## ND_VOTEREP_WIDGET_INDEX_BADCTG

Type: constant

Description: 


Replaced value:
```sqf
2
```
File: [client\NetDisplays\Displays\MessageBoxes.sqf at line 386](../../../Src/client/NetDisplays/Displays/MessageBoxes.sqf#L386)
## nd_internal_voterep_widgets

Type: Variable

Description: 


Initial value:
```sqf
[]
```
File: [client\NetDisplays\Displays\MessageBoxes.sqf at line 381](../../../Src/client/NetDisplays/Displays/MessageBoxes.sqf#L381)
## nd_internal_voterep_cleanupMaps

Type: function

Description: 


File: [client\NetDisplays\Displays\MessageBoxes.sqf at line 376](../../../Src/client/NetDisplays/Displays/MessageBoxes.sqf#L376)
# MobInventory.sqf

## ND_ObjectPull_getHelper

Type: function

Description: 


File: [client\NetDisplays\Displays\MobInventory.sqf at line 91](../../../Src/client/NetDisplays/Displays/MobInventory.sqf#L91)
