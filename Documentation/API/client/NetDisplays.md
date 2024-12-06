# NetDisplay.h

## ND_INIT(name)

Type: constant

Description: 
- Param: name

Replaced value:
```sqf
nd_map_displays set ['name',{ private _args = _this select 0; private _isFirstCreate = _this select 1; private _w_d_ = widgetNull;
```
File: [client\NetDisplays\NetDisplay.h at line 10](../../../Src/client/NetDisplays/NetDisplay.h#L10)
## ND_END

Type: constant

Description: 


Replaced value:
```sqf
}];
```
File: [client\NetDisplays\NetDisplay.h at line 12](../../../Src/client/NetDisplays/NetDisplay.h#L12)
## vec4(x,y,w,h)

Type: constant

Description: 
- Param: x
- Param: y
- Param: w
- Param: h

Replaced value:
```sqf
[x,y,w,h]
```
File: [client\NetDisplays\NetDisplay.h at line 14](../../../Src/client/NetDisplays/NetDisplay.h#L14)
## ctgNULL

Type: constant

Description: 


Replaced value:
```sqf
NIL
```
File: [client\NetDisplays\NetDisplay.h at line 15](../../../Src/client/NetDisplays/NetDisplay.h#L15)
## addSavedWdiget(wid)

Type: constant

Description: 
- Param: wid

Replaced value:
```sqf
getSavedWidgets pushBack(wid)
```
File: [client\NetDisplays\NetDisplay.h at line 17](../../../Src/client/NetDisplays/NetDisplay.h#L17)
## getSavedWidgets

Type: constant

Description: 


Replaced value:
```sqf
(nd_list_widgets select 0)
```
File: [client\NetDisplays\NetDisplay.h at line 18](../../../Src/client/NetDisplays/NetDisplay.h#L18)
## regNDWidget(widgetType,vecpos,probCtg,datatype)

Type: constant

Description: 
- Param: widgetType
- Param: vecpos
- Param: probCtg
- Param: datatype

Replaced value:
```sqf
_w_d_ = [_d,widgetType,vecpos,probCtg] call createWidget; \
(nd_list_widgets select 1)pushBack _w_d_; \
_w_d_ setVariable ["data",datatype];
```
File: [client\NetDisplays\NetDisplay.h at line 20](../../../Src/client/NetDisplays/NetDisplay.h#L20)
## regNDRPC(evname)

Type: constant

Description: 
- Param: evname

Replaced value:
```sqf
_w_d_ setVariable ["__ndevent",evname]; _w_d_ ctrlAddEventHandler ["MouseButtonUp",{ \
params ["_wid","_butt"]; \
todo \
}];
```
File: [client\NetDisplays\NetDisplay.h at line 24](../../../Src/client/NetDisplays/NetDisplay.h#L24)
## lastNDWidget

Type: constant

Description: 


Replaced value:
```sqf
_w_d_
```
File: [client\NetDisplays\NetDisplay.h at line 29](../../../Src/client/NetDisplays/NetDisplay.h#L29)
## thisDisplay

Type: constant

Description: 


Replaced value:
```sqf
_d
```
File: [client\NetDisplays\NetDisplay.h at line 30](../../../Src/client/NetDisplays/NetDisplay.h#L30)
## isFirstLoad

Type: constant

Description: 


Replaced value:
```sqf
_isFirstCreate
```
File: [client\NetDisplays\NetDisplay.h at line 31](../../../Src/client/NetDisplays/NetDisplay.h#L31)
## ctxParams

Type: constant

Description: 


Replaced value:
```sqf
_args
```
File: [client\NetDisplays\NetDisplay.h at line 32](../../../Src/client/NetDisplays/NetDisplay.h#L32)
# NetDisplays.sqf

## nd_map_displays

Type: Variable

Description: 


Initial value:
```sqf
createHashMap
```
File: [client\NetDisplays\NetDisplays.sqf at line 17](../../../Src/client/NetDisplays/NetDisplays.sqf#L17)
## nd_handleUpdate

Type: Variable

Description: 


Initial value:
```sqf
-1
```
File: [client\NetDisplays\NetDisplays.sqf at line 23](../../../Src/client/NetDisplays/NetDisplays.sqf#L23)
## nd_list_widgets

Type: Variable

Description: 


Initial value:
```sqf
[[],[]] //список виджетов с данными. В левом стеке неочищаемые данные до закрытия окна, в правом обновляемый список
```
File: [client\NetDisplays\NetDisplays.sqf at line 25](../../../Src/client/NetDisplays/NetDisplays.sqf#L25)
## nd_sourceObject

Type: Variable

Description: список виджетов с данными. В левом стеке неочищаемые данные до закрытия окна, в правом обновляемый список


Initial value:
```sqf
objNUll
```
File: [client\NetDisplays\NetDisplays.sqf at line 26](../../../Src/client/NetDisplays/NetDisplays.sqf#L26)
## nd_interactionDistance

Type: Variable

Description: 


Initial value:
```sqf
0
```
File: [client\NetDisplays\NetDisplays.sqf at line 27](../../../Src/client/NetDisplays/NetDisplays.sqf#L27)
## nd_isOpenDisplay

Type: Variable

Description: 


Initial value:
```sqf
false
```
File: [client\NetDisplays\NetDisplays.sqf at line 28](../../../Src/client/NetDisplays/NetDisplays.sqf#L28)
## nd_openedDisplayType

Type: Variable

Description: 


Initial value:
```sqf
""
```
File: [client\NetDisplays\NetDisplays.sqf at line 29](../../../Src/client/NetDisplays/NetDisplays.sqf#L29)
## nd_sourceRef

Type: Variable

Description: 


Initial value:
```sqf
""
```
File: [client\NetDisplays\NetDisplays.sqf at line 30](../../../Src/client/NetDisplays/NetDisplays.sqf#L30)
## nd_checkedPos

Type: Variable

Description: find nearest intersection point


Initial value:
```sqf
vec3(0,0,0)
```
File: [client\NetDisplays\NetDisplays.sqf at line 31](../../../Src/client/NetDisplays/NetDisplays.sqf#L31)
## nd_lobby_isOpen

Type: Variable

Description: variables for lobby


Initial value:
```sqf
false
```
File: [client\NetDisplays\NetDisplays.sqf at line 34](../../../Src/client/NetDisplays/NetDisplays.sqf#L34)
## nd_internal_attemptLoad

Type: Variable

Description: 


Initial value:
```sqf
0
```
File: [client\NetDisplays\NetDisplays.sqf at line 36](../../../Src/client/NetDisplays/NetDisplays.sqf#L36)
## nd_createTestDisplay

Type: function

> Exists if **DEBUG** defined

Description: 
- Param: _class
- Param: _data

File: [client\NetDisplays\NetDisplays.sqf at line 39](../../../Src/client/NetDisplays/NetDisplays.sqf#L39)
## nd_loadDisplay

Type: function

Description: 
- Param: _type
- Param: _data (optional, default [])
- Param: _srcRef
- Param: _interactDistance

File: [client\NetDisplays\NetDisplays.sqf at line 57](../../../Src/client/NetDisplays/NetDisplays.sqf#L57)
## nd_loadDisplay_lobby

Type: function

Description: 
- Param: _type
- Param: _data (optional, default [])

File: [client\NetDisplays\NetDisplays.sqf at line 204](../../../Src/client/NetDisplays/NetDisplays.sqf#L204)
## nd_closeND_lobby

Type: function

Description: 
- Param: _isRpc (optional, default false)

File: [client\NetDisplays\NetDisplays.sqf at line 238](../../../Src/client/NetDisplays/NetDisplays.sqf#L238)
## nd_closeND_lobbyImpl

Type: function

Description: 


File: [client\NetDisplays\NetDisplays.sqf at line 250](../../../Src/client/NetDisplays/NetDisplays.sqf#L250)
## nd_onPressButton

Type: function

Description: отсылает тип ввода пользователем. можно отправлять данные. Вся логика обработки на сервере в onHandleNDInput
- Param: _data

File: [client\NetDisplays\NetDisplays.sqf at line 257](../../../Src/client/NetDisplays/NetDisplays.sqf#L257)
## nd_cleanupData

Type: function

Description: очистка списка виджетов для полной перегрузки визуала


File: [client\NetDisplays\NetDisplays.sqf at line 270](../../../Src/client/NetDisplays/NetDisplays.sqf#L270)
## nd_regWidget

Type: function

Description: 
- Param: _type
- Param: _vecpos
- Param: _probCtg
- Param: _dataType

File: [client\NetDisplays\NetDisplays.sqf at line 278](../../../Src/client/NetDisplays/NetDisplays.sqf#L278)
## nd_addClosingButton

Type: function

Description: 
- Param: _display
- Param: _vec4Pos
- Param: _ctg (optional, default widgetNull)
- Param: _registerAsReloaded (optional, default false)

File: [client\NetDisplays\NetDisplays.sqf at line 284](../../../Src/client/NetDisplays/NetDisplays.sqf#L284)
## nd_onUpdate

Type: function

Description: 


File: [client\NetDisplays\NetDisplays.sqf at line 300](../../../Src/client/NetDisplays/NetDisplays.sqf#L300)
## nd_onClose

Type: function

Description: 


File: [client\NetDisplays\NetDisplays.sqf at line 306](../../../Src/client/NetDisplays/NetDisplays.sqf#L306)
## nd_unloadDisplay

Type: function

Description: 


File: [client\NetDisplays\NetDisplays.sqf at line 316](../../../Src/client/NetDisplays/NetDisplays.sqf#L316)
## nd_stdLoad

Type: function

Description: стандартный алгоритм
- Param: _sx (optional, default 50)
- Param: _sy (optional, default 50)
- Param: _btName (optional, default "Закрыть")

File: [client\NetDisplays\NetDisplays.sqf at line 333](../../../Src/client/NetDisplays/NetDisplays.sqf#L333)
# Book.sqf

## nd_internal_map_books

Type: Variable

Description: 


Initial value:
```sqf
createHashMap //key:pointer,value:content
```
File: [client\NetDisplays\Displays\Book.sqf at line 8](../../../Src/client/NetDisplays/Displays/Book.sqf#L8)
# MessageBoxes.sqf

## __ND_MB_INPUT_MAX_CHARS

Type: constant

Description: 


Replaced value:
```sqf
255
```
File: [client\NetDisplays\Displays\MessageBoxes.sqf at line 250](../../../Src/client/NetDisplays/Displays/MessageBoxes.sqf#L250)
## __ND_MB_INPUT_MIN_CHARS

Type: constant

Description: 


Replaced value:
```sqf
100
```
File: [client\NetDisplays\Displays\MessageBoxes.sqf at line 251](../../../Src/client/NetDisplays/Displays/MessageBoxes.sqf#L251)
## ND_VOTEREP_WIDGET_INDEX_ERROR

Type: constant

Description: 


Replaced value:
```sqf
0
```
File: [client\NetDisplays\Displays\MessageBoxes.sqf at line 344](../../../Src/client/NetDisplays/Displays/MessageBoxes.sqf#L344)
## ND_VOTEREP_WIDGET_INDEX_BESTCTG

Type: constant

Description: 


Replaced value:
```sqf
1
```
File: [client\NetDisplays\Displays\MessageBoxes.sqf at line 345](../../../Src/client/NetDisplays/Displays/MessageBoxes.sqf#L345)
## ND_VOTEREP_WIDGET_INDEX_BADCTG

Type: constant

Description: 


Replaced value:
```sqf
2
```
File: [client\NetDisplays\Displays\MessageBoxes.sqf at line 346](../../../Src/client/NetDisplays/Displays/MessageBoxes.sqf#L346)
## nd_internal_voterep_widgets

Type: Variable

Description: 


Initial value:
```sqf
[]
```
File: [client\NetDisplays\Displays\MessageBoxes.sqf at line 343](../../../Src/client/NetDisplays/Displays/MessageBoxes.sqf#L343)
## nd_internal_voterep_cleanupMaps

Type: function

Description: структуры с виджетами


File: [client\NetDisplays\Displays\MessageBoxes.sqf at line 339](../../../Src/client/NetDisplays/Displays/MessageBoxes.sqf#L339)
# MobInventory.sqf

## ND_ObjectPull_getHelper

Type: function

Description: 


File: [client\NetDisplays\Displays\MobInventory.sqf at line 84](../../../Src/client/NetDisplays/Displays/MobInventory.sqf#L84)
