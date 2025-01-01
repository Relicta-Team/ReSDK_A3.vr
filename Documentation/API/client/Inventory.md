# container.sqf

## CONTAINER_SIZE_W

Type: constant

Description: 


Replaced value:
```sqf
3
```
File: [client\Inventory\container.sqf at line 14](../../../Src/client/Inventory/container.sqf#L14)
## CONTAINER_SIZE_Y

Type: constant

Description: 


Replaced value:
```sqf

```
File: [client\Inventory\container.sqf at line 15](../../../Src/client/Inventory/container.sqf#L15)
## SIZE_BUTTON

Type: constant

Description: 


Replaced value:
```sqf
3
```
File: [client\Inventory\container.sqf at line 16](../../../Src/client/Inventory/container.sqf#L16)
## TIME_CONTAINER_ONLOAD

Type: constant

Description: 


Replaced value:
```sqf
0.25
```
File: [client\Inventory\container.sqf at line 18](../../../Src/client/Inventory/container.sqf#L18)
## TIME_CONTAINER_ONUNLOAD

Type: constant

Description: из TIME_PREPARE_SLOTS


Replaced value:
```sqf
0.09
```
File: [client\Inventory\container.sqf at line 20](../../../Src/client/Inventory/container.sqf#L20)
## inventory_openContainer

Type: function

Description: 


File: [client\Inventory\container.sqf at line 22](../../../Src/client/Inventory/container.sqf#L22)
## createWidget_contSlot

Type: function

Description: 
- Param: _display
- Param: _slotName
- Param: _pos
- Param: _slotId
- Param: _ctgScr

File: [client\Inventory\container.sqf at line 107](../../../Src/client/Inventory/container.sqf#L107)
## inventory_loadContainerSlots

Type: function

Description: 


File: [client\Inventory\container.sqf at line 149](../../../Src/client/Inventory/container.sqf#L149)
## inventory_onPrepareContainer

Type: function

Description: 


File: [client\Inventory\container.sqf at line 245](../../../Src/client/Inventory/container.sqf#L245)
## inventory_closeContainer

Type: function

Description: 


File: [client\Inventory\container.sqf at line 266](../../../Src/client/Inventory/container.sqf#L266)
## inventory_onChangeLocContainer

Type: function

Description: 


File: [client\Inventory\container.sqf at line 279](../../../Src/client/Inventory/container.sqf#L279)
## inventory_unloadContainerMenu

Type: function

Description: 


File: [client\Inventory\container.sqf at line 292](../../../Src/client/Inventory/container.sqf#L292)
## inventory_onContainerOpen

Type: function

Description: Открывает контейнер и загружает данные
- Param: _main
- Param: _data

File: [client\Inventory\container.sqf at line 316](../../../Src/client/Inventory/container.sqf#L316)
## inventory_onContainerContentUpdate

Type: function

Description: 
- Param: _data

File: [client\Inventory\container.sqf at line 387](../../../Src/client/Inventory/container.sqf#L387)
## inventory_onUpdateContainer

Type: function

Description: цикл в маин треде


File: [client\Inventory\container.sqf at line 422](../../../Src/client/Inventory/container.sqf#L422)
## inventory_onPressContainerSlot

Type: function

Description: 
- Param: _slotFrom

File: [client\Inventory\container.sqf at line 456](../../../Src/client/Inventory/container.sqf#L456)
## inventory_onReleaseSlotFromContainer

Type: function

Description: 
- Param: _slotTo

File: [client\Inventory\container.sqf at line 480](../../../Src/client/Inventory/container.sqf#L480)
## inventory_onTransferSlotContainer

Type: function

Description: 
- Param: _containerSlot
- Param: _slotTo

File: [client\Inventory\container.sqf at line 514](../../../Src/client/Inventory/container.sqf#L514)
## inventory_onReleaseSlotToContainer

Type: function

Description: 


File: [client\Inventory\container.sqf at line 533](../../../Src/client/Inventory/container.sqf#L533)
# functions.sqf

## SIZE_INVSLOT

Type: constant

Description: 


Replaced value:
```sqf
7
```
File: [client\Inventory\functions.sqf at line 14](../../../Src/client/Inventory/functions.sqf#L14)
## MYPERSON_FADEVAL_EXIT

Type: constant

Description: 


Replaced value:
```sqf
0.9
```
File: [client\Inventory\functions.sqf at line 16](../../../Src/client/Inventory/functions.sqf#L16)
## MYPERSON_FADEVAL_ENTER

Type: constant

Description: 


Replaced value:
```sqf
0.2
```
File: [client\Inventory\functions.sqf at line 17](../../../Src/client/Inventory/functions.sqf#L17)
## MYPERSON_FADETIME

Type: constant

Description: 


Replaced value:
```sqf
0.5
```
File: [client\Inventory\functions.sqf at line 18](../../../Src/client/Inventory/functions.sqf#L18)
## setslotpos(obj,xpos,ypos)

Type: constant

Description: 
- Param: obj
- Param: xpos
- Param: ypos

Replaced value:
```sqf
[obj,[_xp + ((_wp + _biasW) * xpos),_yp + ((_hp + SLOT_BIASH) * ypos)] , TIME_PREPARE_SLOTS] call widgetSetPositionOnly
```
File: [client\Inventory\functions.sqf at line 405](../../../Src/client/Inventory/functions.sqf#L405)
## DEMAP(index,side)

Type: constant

Description: 
- Param: index
- Param: side

Replaced value:
```sqf
(inventory_slotpos_map select index select side)
```
File: [client\Inventory\functions.sqf at line 434](../../../Src/client/Inventory/functions.sqf#L434)
## POS_LEFTUP

Type: constant

Description: 


Replaced value:
```sqf
_xp + ((_wp + _biasW) * DEMAP(INV_BACKPACK,0)),_yp + ((_hp + SLOT_BIASH) * DEMAP(INV_BACKPACK,1))
```
File: [client\Inventory\functions.sqf at line 435](../../../Src/client/Inventory/functions.sqf#L435)
## POS_RIGHTDOWN

Type: constant

Description: 


Replaced value:
```sqf
_xp + ((_wp + _biasW) * DEMAP(INV_HAND_R,0)) + _wp,_yp + ((_hp + SLOT_BIASH) * DEMAP(INV_HAND_R,1)) + _hp
```
File: [client\Inventory\functions.sqf at line 436](../../../Src/client/Inventory/functions.sqf#L436)
## inventory_isGlobalVisible

Type: Variable

Description: 


Initial value:
```sqf
true
```
File: [client\Inventory\functions.sqf at line 106](../../../Src/client/Inventory/functions.sqf#L106)
## inventory_init

Type: function

Description: 


File: [client\Inventory\functions.sqf at line 20](../../../Src/client/Inventory/functions.sqf#L20)
## inventory_setHideHands

Type: function

Description: 
- Param: _mode

File: [client\Inventory\functions.sqf at line 40](../../../Src/client/Inventory/functions.sqf#L40)
## inventory_restoreHide

Type: function

Description: 
- Param: _now
- Param: _applyCommit (optional, default true)

File: [client\Inventory\functions.sqf at line 91](../../../Src/client/Inventory/functions.sqf#L91)
## inventory_setGlobalVisible

Type: function

Description: установка видимости слотов на глобальном уровне
- Param: _mode

File: [client\Inventory\functions.sqf at line 109](../../../Src/client/Inventory/functions.sqf#L109)
## inventory_applyColorTheme

Type: function

Description: 


File: [client\Inventory\functions.sqf at line 127](../../../Src/client/Inventory/functions.sqf#L127)
## inventory_widgetSetPicture

Type: function

Description: Псевдоним widgetSetPicture в этом модуле
- Param: _pic
- Param: _val

File: [client\Inventory\functions.sqf at line 134](../../../Src/client/Inventory/functions.sqf#L134)
## createWidget_invSlot

Type: function

Description: 
- Param: _display
- Param: _slotName
- Param: _pos
- Param: _slotId

File: [client\Inventory\functions.sqf at line 164](../../../Src/client/Inventory/functions.sqf#L164)
## openInventory

Type: function

Description: 


File: [client\Inventory\functions.sqf at line 233](../../../Src/client/Inventory/functions.sqf#L233)
## inventory_onPrepareSlots

Type: function

Description: 
- Param: _xp
- Param: _yp
- Param: _wp
- Param: _hp

File: [client\Inventory\functions.sqf at line 391](../../../Src/client/Inventory/functions.sqf#L391)
## inventory_resetPositionHandWidgets

Type: function

Description: 


File: [client\Inventory\functions.sqf at line 480](../../../Src/client/Inventory/functions.sqf#L480)
## closeInventory

Type: function

Description: 


File: [client\Inventory\functions.sqf at line 490](../../../Src/client/Inventory/functions.sqf#L490)
## closeInventory_handle

Type: function

Description: Событие закрытия инвентаря


File: [client\Inventory\functions.sqf at line 522](../../../Src/client/Inventory/functions.sqf#L522)
## inventoryGetPictureById

Type: function

Description: 


File: [client\Inventory\functions.sqf at line 531](../../../Src/client/Inventory/functions.sqf#L531)
## inventoryGetSlotNameById

Type: function

Description: 


File: [client\Inventory\functions.sqf at line 535](../../../Src/client/Inventory/functions.sqf#L535)
## inventoryGetWidgetById

Type: function

Description: 


File: [client\Inventory\functions.sqf at line 539](../../../Src/client/Inventory/functions.sqf#L539)
## inventoryGetWidgetOnMouse

Type: function

Description: 


File: [client\Inventory\functions.sqf at line 544](../../../Src/client/Inventory/functions.sqf#L544)
## inventoryGetContainerWidgetOnMouse

Type: function

Description: 


File: [client\Inventory\functions.sqf at line 556](../../../Src/client/Inventory/functions.sqf#L556)
## inventoryIsInContainerWidgetsZone

Type: function

Description: 


File: [client\Inventory\functions.sqf at line 567](../../../Src/client/Inventory/functions.sqf#L567)
## inventoryIsInWidgetsZone

Type: function

Description: 


File: [client\Inventory\functions.sqf at line 571](../../../Src/client/Inventory/functions.sqf#L571)
## inventoryIsInsideSelfWidget

Type: function

Description: 


File: [client\Inventory\functions.sqf at line 575](../../../Src/client/Inventory/functions.sqf#L575)
## inventory_onUpdate

Type: function

Description: 


File: [client\Inventory\functions.sqf at line 583](../../../Src/client/Inventory/functions.sqf#L583)
## inventory_onMousePress

Type: function

Description: Событие при нажатии мышки на слот
- Param: _obj
- Param: _key

File: [client\Inventory\functions.sqf at line 725](../../../Src/client/Inventory/functions.sqf#L725)
## inventory_onMouseRelease

Type: function

Description: событие при отпускании мышки на слоте
- Param: _obj
- Param: _key

File: [client\Inventory\functions.sqf at line 774](../../../Src/client/Inventory/functions.sqf#L774)
## inventory_onMouseScroll

Type: function

Description: При скроллинге мышкой
- Param: _disp
- Param: _scroll

File: [client\Inventory\functions.sqf at line 816](../../../Src/client/Inventory/functions.sqf#L816)
## inventory_onSlotUpdate

Type: function

Description: 
- Param: _slotid
- Param: _data
- Param: _supressRestoreHide (optional, default false)

File: [client\Inventory\functions.sqf at line 844](../../../Src/client/Inventory/functions.sqf#L844)
## inventory_syncGerms

Type: function

Description: 
- Param: _data

File: [client\Inventory\functions.sqf at line 891](../../../Src/client/Inventory/functions.sqf#L891)
## inventory_internal_syncGermsBodyPartKey

Type: function

Description: 
- Param: _partKey
- Param: _opacity

File: [client\Inventory\functions.sqf at line 909](../../../Src/client/Inventory/functions.sqf#L909)
## inventory_syncModelPos

Type: function

> Exists if **INVENTORY_USE_NEW_RENDER_ICONS** defined

Description: 
- Param: _wid

File: [client\Inventory\functions.sqf at line 928](../../../Src/client/Inventory/functions.sqf#L928)
## inventory_onSlotListUpdate

Type: function

Description: 
- Param: _data

File: [client\Inventory\functions.sqf at line 957](../../../Src/client/Inventory/functions.sqf#L957)
## inventory_onReleaseSlot

Type: function

Description: 
- Param: _slotTo

File: [client\Inventory\functions.sqf at line 965](../../../Src/client/Inventory/functions.sqf#L965)
## inventory_onPressSlot

Type: function

Description: 
- Param: _slotFrom

File: [client\Inventory\functions.sqf at line 1033](../../../Src/client/Inventory/functions.sqf#L1033)
## inventory_onPutDownItem

Type: function

Description: параметр _isFastPutdown - событие безопасного выкладывания из руки
- Param: _id (optional, default cd_activeHand)
- Param: _isFastPutdown (optional, default false)

File: [client\Inventory\functions.sqf at line 1060](../../../Src/client/Inventory/functions.sqf#L1060)
## inventory_onDropItem

Type: function

Description: Событие которое выбрасывает предмет из инвентаря
- Param: _id (optional, default cd_activeHand)

File: [client\Inventory\functions.sqf at line 1100](../../../Src/client/Inventory/functions.sqf#L1100)
## inventory_onTransferSlot

Type: function

Description: Событие при передачи из одного слота в другой
- Param: _slotFrom
- Param: _slotTo

File: [client\Inventory\functions.sqf at line 1114](../../../Src/client/Inventory/functions.sqf#L1114)
## inventory_onInteractTargetWith

Type: function

Description: 
- Param: _obj
- Param: _slotData

File: [client\Inventory\functions.sqf at line 1151](../../../Src/client/Inventory/functions.sqf#L1151)
## inventory_onMainAction

Type: function

Description: 


File: [client\Inventory\functions.sqf at line 1168](../../../Src/client/Inventory/functions.sqf#L1168)
## inventory_onExtraAction

Type: function

Description: 


File: [client\Inventory\functions.sqf at line 1204](../../../Src/client/Inventory/functions.sqf#L1204)
## inventory_onClick

Type: function

Description: 


File: [client\Inventory\functions.sqf at line 1262](../../../Src/client/Inventory/functions.sqf#L1262)
## inventory_onExamine

Type: function

Description: 


File: [client\Inventory\functions.sqf at line 1303](../../../Src/client/Inventory/functions.sqf#L1303)
## inventory_changeActiveHand

Type: function

Description: Смена активной руки


File: [client\Inventory\functions.sqf at line 1363](../../../Src/client/Inventory/functions.sqf#L1363)
## inventory_changeTwoHandsMode

Type: function

Description: 


File: [client\Inventory\functions.sqf at line 1376](../../../Src/client/Inventory/functions.sqf#L1376)
## inventory_onChangeActiveHand

Type: function

Description: 
- Param: _notAct
- Param: _act
- Param: _setToNew (optional, default false)

File: [client\Inventory\functions.sqf at line 1381](../../../Src/client/Inventory/functions.sqf#L1381)
## inventory_isEmptyHands

Type: function

Description: 


File: [client\Inventory\functions.sqf at line 1406](../../../Src/client/Inventory/functions.sqf#L1406)
## inventory_isEmptyActiveHand

Type: function

Description: 


File: [client\Inventory\functions.sqf at line 1410](../../../Src/client/Inventory/functions.sqf#L1410)
## inventory_getModelById

Type: function

Description: 


File: [client\Inventory\functions.sqf at line 1412](../../../Src/client/Inventory/functions.sqf#L1412)
## inventory_getSlotDataById

Type: function

Description: 


File: [client\Inventory\functions.sqf at line 1416](../../../Src/client/Inventory/functions.sqf#L1416)
## inventory_getContainerSlotDataById

Type: function

Description: 


File: [client\Inventory\functions.sqf at line 1420](../../../Src/client/Inventory/functions.sqf#L1420)
# helpers.hpp

## INVENTORY_LOG

Type: constant

Description: comment this if dont need logging


Replaced value:
```sqf

```
File: [client\Inventory\helpers.hpp at line 11](../../../Src/client/Inventory/helpers.hpp#L11)
## BACKGROUND_COLOR_NOITEM

Type: constant

Description: #define INVENTORY_USE_NEW_RENDER_ICONS


Replaced value:
```sqf
[0.161,0.322,0.204,0.25]
```
File: [client\Inventory\helpers.hpp at line 19](../../../Src/client/Inventory/helpers.hpp#L19)
## BACKGROUND_COLOR

Type: constant

Description: #define INVENTORY_USE_NEW_RENDER_ICONS


Replaced value:
```sqf
(["inv_slot_back"] call ct_getValue)/*[0.161,0.322,0.204,0.5]*/
```
File: [client\Inventory\helpers.hpp at line 19](../../../Src/client/Inventory/helpers.hpp#L19)
## BACKGROUND_COLOR_ACTIVEHAND

Type: constant

Description: 


Replaced value:
```sqf
(["inv_slot_act"] call ct_getValue)/*[0,0.6,0,0.5]*/
```
File: [client\Inventory\helpers.hpp at line 21](../../../Src/client/Inventory/helpers.hpp#L21)
## BACKGROUND_COLOR_CANINTERACT

Type: constant

Description: 


Replaced value:
```sqf
[0,0.4,0,0.7]
```
File: [client\Inventory\helpers.hpp at line 22](../../../Src/client/Inventory/helpers.hpp#L22)
## PRESSED_LINK

Type: constant

Description: 


Replaced value:
```sqf
0 //ссылка на ивентарный нажатый слот
```
File: [client\Inventory\helpers.hpp at line 24](../../../Src/client/Inventory/helpers.hpp#L24)
## PRESSED_DRAG

Type: constant

Description: ссылка на ивентарный нажатый слот


Replaced value:
```sqf
1 //ссылка на драгуемую ктгшку
```
File: [client\Inventory\helpers.hpp at line 25](../../../Src/client/Inventory/helpers.hpp#L25)
## INDEX_DRAGGER

Type: constant

Description: ссылка на драгуемую ктгшку


Replaced value:
```sqf
-9
```
File: [client\Inventory\helpers.hpp at line 27](../../../Src/client/Inventory/helpers.hpp#L27)
## SLOT_BIASH

Type: constant

Description: 


Replaced value:
```sqf
0.3
```
File: [client\Inventory\helpers.hpp at line 29](../../../Src/client/Inventory/helpers.hpp#L29)
## TIME_PREPARE_SLOTS

Type: constant

Description: время на подготовку (выезжание слотов)


Replaced value:
```sqf
0.09
```
File: [client\Inventory\helpers.hpp at line 32](../../../Src/client/Inventory/helpers.hpp#L32)
## TIME_PREPARE_DRAG

Type: constant

Description: Время на подготовку (появление) драга


Replaced value:
```sqf
0.1
```
File: [client\Inventory\helpers.hpp at line 34](../../../Src/client/Inventory/helpers.hpp#L34)
## DRAG_FADE_PROCESS

Type: constant

Description: Непрозрачность драг-иконки во время перетаскивания


Replaced value:
```sqf
0.4
```
File: [client\Inventory\helpers.hpp at line 36](../../../Src/client/Inventory/helpers.hpp#L36)
## getDragSlot

Type: constant

Description: drag managment. Драг это иконка предмета, идущая за указателем мыши при isDragProcess


Replaced value:
```sqf
(inventory_pressedwidget select PRESSED_DRAG)
```
File: [client\Inventory\helpers.hpp at line 40](../../../Src/client/Inventory/helpers.hpp#L40)
## onDragInit(wid)

Type: constant

Description: 
- Param: wid

Replaced value:
```sqf
inventory_pressedwidget set [PRESSED_DRAG,wid]; wid ctrlSetFade 1; wid ctrlCommit 0
```
File: [client\Inventory\helpers.hpp at line 42](../../../Src/client/Inventory/helpers.hpp#L42)
## isInteractibleAction

Type: constant

Description: 


Replaced value:
```sqf
((inventory_previewObject getVariable ["isInteractible",false]) || (typeof getInteractibleTarget == BASIC_MOB_TYPE))
```
File: [client\Inventory\helpers.hpp at line 44](../../../Src/client/Inventory/helpers.hpp#L44)
## getInteractibleTarget

Type: constant

Description: #define isInteractibleAction ((inventory_previewObject getVariable ["isInteractible",false]) && inventory_isPressedInteractButton || (typeof getInteractibleTarget == BASIC_MOB_TYPE))


Replaced value:
```sqf
(inventory_previewObject getVariable ["interactibleTarget",objnull])
```
File: [client\Inventory\helpers.hpp at line 46](../../../Src/client/Inventory/helpers.hpp#L46)
## getPressedSlot

Type: constant

Description: link managment . Нажатый это просто референс на виджет из инвентаря


Replaced value:
```sqf
(inventory_pressedwidget select PRESSED_LINK)
```
File: [client\Inventory\helpers.hpp at line 50](../../../Src/client/Inventory/helpers.hpp#L50)
## isDragProcess

Type: constant

Description: 


Replaced value:
```sqf
(! (getPressedSlot isequalto widgetNull))
```
File: [client\Inventory\helpers.hpp at line 52](../../../Src/client/Inventory/helpers.hpp#L52)
## isHandDrag

Type: constant

Description: 


Replaced value:
```sqf
((getSlotId(getPressedSlot) in [INV_HAND_L,INV_HAND_R]) && !isContainerSlot(getPressedSlot))
```
File: [client\Inventory\helpers.hpp at line 54](../../../Src/client/Inventory/helpers.hpp#L54)
## onPressSlot(slotwid)

Type: constant

Description: 
- Param: slotwid

Replaced value:
```sqf
[slotwid] call inventory_onPressSlot
```
File: [client\Inventory\helpers.hpp at line 56](../../../Src/client/Inventory/helpers.hpp#L56)
## onReleaseSlot(zone)

Type: constant

Description: 
- Param: zone

Replaced value:
```sqf
[zone] call inventory_onReleaseSlot
```
File: [client\Inventory\helpers.hpp at line 58](../../../Src/client/Inventory/helpers.hpp#L58)
## getSlotId(wid)

Type: constant

Description: other
- Param: wid

Replaced value:
```sqf
(wid getvariable "slotid")
```
File: [client\Inventory\helpers.hpp at line 62](../../../Src/client/Inventory/helpers.hpp#L62)
## getSlotIcon(wid)

Type: constant

Description: 
- Param: wid

Replaced value:
```sqf
(wid getVariable "icon")
```
File: [client\Inventory\helpers.hpp at line 64](../../../Src/client/Inventory/helpers.hpp#L64)
## getSlotDirtOverlay(wid)

Type: constant

Description: 
- Param: wid

Replaced value:
```sqf
(wid getvariable "dirtOverlay")
```
File: [client\Inventory\helpers.hpp at line 66](../../../Src/client/Inventory/helpers.hpp#L66)
## getSlotBackground(wid)

Type: constant

Description: #define widgetSetPicture inventory_widgetSetPicture
- Param: wid

Replaced value:
```sqf
(wid getVariable "background")
```
File: [client\Inventory\helpers.hpp at line 71](../../../Src/client/Inventory/helpers.hpp#L71)
## getSlotName(wid)

Type: constant

Description: 
- Param: wid

Replaced value:
```sqf
(wid getVariable "slotname")
```
File: [client\Inventory\helpers.hpp at line 73](../../../Src/client/Inventory/helpers.hpp#L73)
## isEmptySlot(id)

Type: constant

Description: 
- Param: id

Replaced value:
```sqf
((inventory_slotdata select (id)) isequalto [])
```
File: [client\Inventory\helpers.hpp at line 75](../../../Src/client/Inventory/helpers.hpp#L75)
## isEmptyWidget(wid)

Type: constant

Description: 
- Param: wid

Replaced value:
```sqf
isEmptySlot(getSlotId(wid))
```
File: [client\Inventory\helpers.hpp at line 77](../../../Src/client/Inventory/helpers.hpp#L77)
## getSlotDataById(id)

Type: constant

Description: 
- Param: id

Replaced value:
```sqf
((id) call inventory_getSlotDataById)
```
File: [client\Inventory\helpers.hpp at line 79](../../../Src/client/Inventory/helpers.hpp#L79)
## getPressedSlotPosition

Type: constant

Description: 


Replaced value:
```sqf
inventory_pressedSlotPosition
```
File: [client\Inventory\helpers.hpp at line 81](../../../Src/client/Inventory/helpers.hpp#L81)
## setPressedSlotPosition(pos)

Type: constant

Description: 
- Param: pos

Replaced value:
```sqf
inventory_pressedSlotPosition = (pos)
```
File: [client\Inventory\helpers.hpp at line 82](../../../Src/client/Inventory/helpers.hpp#L82)
## isInsidePressedSlot

Type: constant

Description: 


Replaced value:
```sqf
inventory_isInsidePressedSlot
```
File: [client\Inventory\helpers.hpp at line 84](../../../Src/client/Inventory/helpers.hpp#L84)
## getVerbMenuWidget

Type: constant

Description: 


Replaced value:
```sqf
(inventory_verbMenuWidgets select 0)
```
File: [client\Inventory\helpers.hpp at line 86](../../../Src/client/Inventory/helpers.hpp#L86)
## isInsideVerbMenu_inv

Type: constant

Description: название данной функции заменено, потому что isInsideVerbMenu уже определён в Interactions


Replaced value:
```sqf
(getVerbMenuWidget call isMouseInsideWidget)
```
File: [client\Inventory\helpers.hpp at line 88](../../../Src/client/Inventory/helpers.hpp#L88)
## isOpenedVerbMenu

Type: constant

Description: 


Replaced value:
```sqf
(!(getVerbMenuWidget isEqualTo widgetNull))
```
File: [client\Inventory\helpers.hpp at line 89](../../../Src/client/Inventory/helpers.hpp#L89)
## getContainerMainCtg

Type: constant

Description: container helpers


Replaced value:
```sqf
(inventory_containerWidgets select 0)
```
File: [client\Inventory\helpers.hpp at line 92](../../../Src/client/Inventory/helpers.hpp#L92)
## getContainerSlotsCtg

Type: constant

Description: 


Replaced value:
```sqf
(inventory_containerWidgets select 1)
```
File: [client\Inventory\helpers.hpp at line 93](../../../Src/client/Inventory/helpers.hpp#L93)
## getContainerNameText

Type: constant

Description: 


Replaced value:
```sqf
(inventory_containerWidgets select 2)
```
File: [client\Inventory\helpers.hpp at line 94](../../../Src/client/Inventory/helpers.hpp#L94)
## container_index_name

Type: constant

Description: internal macro for inventory::containerCommonData


Replaced value:
```sqf
0
```
File: [client\Inventory\helpers.hpp at line 97](../../../Src/client/Inventory/helpers.hpp#L97)
## container_index_ref

Type: constant

Description: 


Replaced value:
```sqf
1
```
File: [client\Inventory\helpers.hpp at line 98](../../../Src/client/Inventory/helpers.hpp#L98)
## container_index_object

Type: constant

Description: 


Replaced value:
```sqf
2
```
File: [client\Inventory\helpers.hpp at line 99](../../../Src/client/Inventory/helpers.hpp#L99)
## container_index_posoffset

Type: constant

Description: 


Replaced value:
```sqf
3
```
File: [client\Inventory\helpers.hpp at line 100](../../../Src/client/Inventory/helpers.hpp#L100)
## container_index_isInWorld

Type: constant

Description: assoc with container_index_object


Replaced value:
```sqf
container_index_object
```
File: [client\Inventory\helpers.hpp at line 102](../../../Src/client/Inventory/helpers.hpp#L102)
## container_object_awaitGenerateValue

Type: constant

Description: this does not used


Replaced value:
```sqf
-1
```
File: [client\Inventory\helpers.hpp at line 104](../../../Src/client/Inventory/helpers.hpp#L104)
## getWorldContainer

Type: constant

Description: 


Replaced value:
```sqf
(inventory_containerCommonData select container_index_object)
```
File: [client\Inventory\helpers.hpp at line 106](../../../Src/client/Inventory/helpers.hpp#L106)
## getContainerRef

Type: constant

Description: 


Replaced value:
```sqf
(inventory_containerCommonData select container_index_ref)
```
File: [client\Inventory\helpers.hpp at line 107](../../../Src/client/Inventory/helpers.hpp#L107)
## getContainerPosOffset

Type: constant

Description: 


Replaced value:
```sqf
(inventory_containerCommonData select container_index_posoffset)
```
File: [client\Inventory\helpers.hpp at line 108](../../../Src/client/Inventory/helpers.hpp#L108)
## setContainerPosOffset(val)

Type: constant

Description: 
- Param: val

Replaced value:
```sqf
inventory_containerCommonData set [container_index_posoffset,val]
```
File: [client\Inventory\helpers.hpp at line 109](../../../Src/client/Inventory/helpers.hpp#L109)
## isWorldContainer

Type: constant

Description: 


Replaced value:
```sqf
(getWorldContainer isEqualType objnull)
```
File: [client\Inventory\helpers.hpp at line 110](../../../Src/client/Inventory/helpers.hpp#L110)
## isContainerSlot(slot)

Type: constant

Description: 
- Param: slot

Replaced value:
```sqf
(slot getVariable ["isContainerSlot",false])
```
File: [client\Inventory\helpers.hpp at line 113](../../../Src/client/Inventory/helpers.hpp#L113)
## nullContainerCommonData

Type: constant

Description: 


Replaced value:
```sqf
["","","none",[0,0,0]]
```
File: [client\Inventory\helpers.hpp at line 115](../../../Src/client/Inventory/helpers.hpp#L115)
## nullPostionPreviewObject

Type: constant

Description: 


Replaced value:
```sqf
[0,0,0]
```
File: [client\Inventory\helpers.hpp at line 116](../../../Src/client/Inventory/helpers.hpp#L116)
## SELF_CTG_SIZE_H

Type: constant

Description: self widgets


Replaced value:
```sqf
5
```
File: [client\Inventory\helpers.hpp at line 119](../../../Src/client/Inventory/helpers.hpp#L119)
## getSelfCtg

Type: constant

Description: 


Replaced value:
```sqf
(inventory_selfWidgets select 0)
```
File: [client\Inventory\helpers.hpp at line 120](../../../Src/client/Inventory/helpers.hpp#L120)
## setSelfCtg(wid)

Type: constant

Description: 
- Param: wid

Replaced value:
```sqf
inventory_selfWidgets set [0,wid]
```
File: [client\Inventory\helpers.hpp at line 121](../../../Src/client/Inventory/helpers.hpp#L121)
## getSelfCtgText

Type: constant

Description: 


Replaced value:
```sqf
(inventory_selfWidgets select 1)
```
File: [client\Inventory\helpers.hpp at line 123](../../../Src/client/Inventory/helpers.hpp#L123)
## setSelfCtgText(wid)

Type: constant

Description: 
- Param: wid

Replaced value:
```sqf
inventory_selfWidgets set [1,wid]
```
File: [client\Inventory\helpers.hpp at line 124](../../../Src/client/Inventory/helpers.hpp#L124)
## TIME_TO_RELOAD_EXTRAACTION

Type: constant

Description: timing protection


Replaced value:
```sqf
0.8
```
File: [client\Inventory\helpers.hpp at line 127](../../../Src/client/Inventory/helpers.hpp#L127)
## TIME_TO_RELOAD_ALTCLICKACTION

Type: constant

Description: 


Replaced value:
```sqf
0.8
```
File: [client\Inventory\helpers.hpp at line 128](../../../Src/client/Inventory/helpers.hpp#L128)
## INV_HIDE_UPDATE_DELAY

Type: constant

Description: hiding inventory


Replaced value:
```sqf
0.1
```
File: [client\Inventory\helpers.hpp at line 131](../../../Src/client/Inventory/helpers.hpp#L131)
## INV_HIDE_PERUPDATE_DELAY

Type: constant

Description: 


Replaced value:
```sqf
0.09
```
File: [client\Inventory\helpers.hpp at line 132](../../../Src/client/Inventory/helpers.hpp#L132)
## invlog(mes,ft)

Type: constant

> Exists if **INVENTORY_LOG** defined

Description: 
- Param: mes
- Param: ft

Replaced value:
```sqf
logformat(mes,ft)
```
File: [client\Inventory\helpers.hpp at line 143](../../../Src/client/Inventory/helpers.hpp#L143)
## invlog(mes,ft)

Type: constant

> Exists if **INVENTORY_LOG** not defined

Description: 
- Param: mes
- Param: ft

Replaced value:
```sqf

```
File: [client\Inventory\helpers.hpp at line 147](../../../Src/client/Inventory/helpers.hpp#L147)
# inventory.hpp

## INV_BACKPACK

Type: constant

Description: Порядок слотов отвечает за их порядок отрисовки в инвентаре


Replaced value:
```sqf
0
```
File: [client\Inventory\inventory.hpp at line 9](../../../Src/client/Inventory/inventory.hpp#L9)
## INV_ARMOR

Type: constant

Description: 


Replaced value:
```sqf
1
```
File: [client\Inventory\inventory.hpp at line 10](../../../Src/client/Inventory/inventory.hpp#L10)
## INV_HEAD

Type: constant

Description: 


Replaced value:
```sqf
2
```
File: [client\Inventory\inventory.hpp at line 11](../../../Src/client/Inventory/inventory.hpp#L11)
## INV_BACK

Type: constant

Description: Порядок слотов отвечает за их порядок отрисовки в инвентаре


Replaced value:
```sqf
3
```
File: [client\Inventory\inventory.hpp at line 9](../../../Src/client/Inventory/inventory.hpp#L9)
## INV_CLOTH

Type: constant

Description: 


Replaced value:
```sqf
4
```
File: [client\Inventory\inventory.hpp at line 13](../../../Src/client/Inventory/inventory.hpp#L13)
## INV_FACE

Type: constant

Description: 


Replaced value:
```sqf
5
```
File: [client\Inventory\inventory.hpp at line 14](../../../Src/client/Inventory/inventory.hpp#L14)
## INV_HAND_L

Type: constant

Description: 


Replaced value:
```sqf
6
```
File: [client\Inventory\inventory.hpp at line 15](../../../Src/client/Inventory/inventory.hpp#L15)
## INV_BELT

Type: constant

Description: 


Replaced value:
```sqf
7
```
File: [client\Inventory\inventory.hpp at line 16](../../../Src/client/Inventory/inventory.hpp#L16)
## INV_HAND_R

Type: constant

Description: 


Replaced value:
```sqf
8
```
File: [client\Inventory\inventory.hpp at line 17](../../../Src/client/Inventory/inventory.hpp#L17)
## INV_LIST_HANDS

Type: constant

Description: 


Replaced value:
```sqf
[INV_HAND_L,INV_HAND_R]
```
File: [client\Inventory\inventory.hpp at line 19](../../../Src/client/Inventory/inventory.hpp#L19)
## INV_LIST_ALL

Type: constant

Description: 


Replaced value:
```sqf
[INV_BACKPACK, INV_ARMOR, INV_HEAD, INV_BACK,INV_CLOTH,INV_FACE,INV_HAND_L,INV_BELT,INV_HAND_R]
```
File: [client\Inventory\inventory.hpp at line 20](../../../Src/client/Inventory/inventory.hpp#L20)
## INV_LIST_VARNAME

Type: constant

Description: 


Replaced value:
```sqf
["INV_BACKPACK","INV_ARMOR","INV_HEAD","INV_BACK","INV_CLOTH","INV_FACE","INV_HAND_L","INV_BELT","INV_HAND_R"]
```
File: [client\Inventory\inventory.hpp at line 21](../../../Src/client/Inventory/inventory.hpp#L21)
## INV_LIST_SLOTNAMES

Type: constant

Description: 


Replaced value:
```sqf
["Спина","Броня","Голова","Плечо","Одеяния","Лицо","Левая рука","Пояс","Правая рука"]
```
File: [client\Inventory\inventory.hpp at line 22](../../../Src/client/Inventory/inventory.hpp#L22)
## INV_LIST_FACE

Type: constant

Description: 


Replaced value:
```sqf
[INV_HEAD,INV_FACE]
```
File: [client\Inventory\inventory.hpp at line 24](../../../Src/client/Inventory/inventory.hpp#L24)
## INV_LIST_TORSO

Type: constant

Description: 


Replaced value:
```sqf
[INV_BACKPACK,INV_BACK,INV_CLOTH,INV_BELT,INV_ARMOR]
```
File: [client\Inventory\inventory.hpp at line 25](../../../Src/client/Inventory/inventory.hpp#L25)
## SD_NAME

Type: constant

Description: 


Replaced value:
```sqf
0
```
File: [client\Inventory\inventory.hpp at line 27](../../../Src/client/Inventory/inventory.hpp#L27)
## SD_ICON

Type: constant

Description: 


Replaced value:
```sqf
1
```
File: [client\Inventory\inventory.hpp at line 28](../../../Src/client/Inventory/inventory.hpp#L28)
## SD_POINTER

Type: constant

Description: 


Replaced value:
```sqf
2
```
File: [client\Inventory\inventory.hpp at line 29](../../../Src/client/Inventory/inventory.hpp#L29)
## SD_MODEL

Type: constant

Description: 


Replaced value:
```sqf
3
```
File: [client\Inventory\inventory.hpp at line 30](../../../Src/client/Inventory/inventory.hpp#L30)
## PATH_PICTURE_INV(icon)

Type: constant

Description: default picture path
- Param: icon

Replaced value:
```sqf
PATH_PICTURE("inventory\items\" + (icon) + ".paa")
```
File: [client\Inventory\inventory.hpp at line 34](../../../Src/client/Inventory/inventory.hpp#L34)
# inventory_init.sqf

## PIC_PATH(name)

Type: constant

Description: 
- Param: name

Replaced value:
```sqf
(PATH_PICTURE_FOLDER + "inventory\" + name + ".paa")
```
File: [client\Inventory\inventory_init.sqf at line 11](../../../Src/client/Inventory/inventory_init.sqf#L11)
## TEMP_ITEM_ICON

Type: constant

Description: 


Replaced value:
```sqf
PIC_PATH("items\temp_item")
```
File: [client\Inventory\inventory_init.sqf at line 12](../../../Src/client/Inventory/inventory_init.sqf#L12)
## inventory_sloticons_default

Type: Variable

Description: ассоциатор путей до картинок


Initial value:
```sqf
[...
```
File: [client\Inventory\inventory_init.sqf at line 21](../../../Src/client/Inventory/inventory_init.sqf#L21)
## inventory_const_dirtOverlayIcon

Type: Variable

Description: 


Initial value:
```sqf
PIC_PATH("dirt_overlay")
```
File: [client\Inventory\inventory_init.sqf at line 33](../../../Src/client/Inventory/inventory_init.sqf#L33)
## inventory_const_partkeyToSlots

Type: Variable

Description: 


Initial value:
```sqf
[...
```
File: [client\Inventory\inventory_init.sqf at line 34](../../../Src/client/Inventory/inventory_init.sqf#L34)
## inventory_slotdataDirt

Type: Variable

Description: 


Initial value:
```sqf
inventory_const_partkeyToSlots apply ...
```
File: [client\Inventory\inventory_init.sqf at line 41](../../../Src/client/Inventory/inventory_init.sqf#L41)
## invenotry_commitNowAllGerms

Type: Variable

Description: 


Initial value:
```sqf
false//используется для быстрого применения грязи при открытии инвентаря
```
File: [client\Inventory\inventory_init.sqf at line 43](../../../Src/client/Inventory/inventory_init.sqf#L43)
## inventory_openModeSlotsId

Type: Variable

Description: используется для быстрого применения грязи при открытии инвентаря


Initial value:
```sqf
[INV_BACKPACK,INV_ARMOR,INV_HEAD,INV_BACK,INV_CLOTH,INV_FACE,INV_BELT]
```
File: [client\Inventory\inventory_init.sqf at line 45](../../../Src/client/Inventory/inventory_init.sqf#L45)
## inventory_slotnames_default

Type: Variable

Description: 


Initial value:
```sqf
INV_LIST_SLOTNAMES
```
File: [client\Inventory\inventory_init.sqf at line 49](../../../Src/client/Inventory/inventory_init.sqf#L49)
## inventory_slotpos_map

Type: Variable

Description: 


Initial value:
```sqf
[...
```
File: [client\Inventory\inventory_init.sqf at line 51](../../../Src/client/Inventory/inventory_init.sqf#L51)
## inventor_slot_widgets

Type: Variable

Description: 


Initial value:
```sqf
[]
```
File: [client\Inventory\inventory_init.sqf at line 63](../../../Src/client/Inventory/inventory_init.sqf#L63)
## inventory_slotdata

Type: Variable

Description: 


Initial value:
```sqf
_inventory_slotdata apply ...
```
File: [client\Inventory\inventory_init.sqf at line 68](../../../Src/client/Inventory/inventory_init.sqf#L68)
## isInventoryOpen

Type: Variable

Description: 


Initial value:
```sqf
false
```
File: [client\Inventory\inventory_init.sqf at line 70](../../../Src/client/Inventory/inventory_init.sqf#L70)
## inventory_modifierScroll

Type: Variable

Description: 


Initial value:
```sqf
false//множитель прокручивания при нажатом шифте
```
File: [client\Inventory\inventory_init.sqf at line 72](../../../Src/client/Inventory/inventory_init.sqf#L72)
## inventory_pressedwidget

Type: Variable

Description: common flags and other info


Initial value:
```sqf
[widgetNull,widgetNull]
```
File: [client\Inventory\inventory_init.sqf at line 75](../../../Src/client/Inventory/inventory_init.sqf#L75)
## inventory_pressedSlotPosition

Type: Variable

Description: 


Initial value:
```sqf
[0,0]
```
File: [client\Inventory\inventory_init.sqf at line 76](../../../Src/client/Inventory/inventory_init.sqf#L76)
## inventory_isInsidePressedSlot

Type: Variable

Description: 


Initial value:
```sqf
false //На данный момент (Legacy - 0.5.148) данная переменная только устанавливает значения, но не использует их.
```
File: [client\Inventory\inventory_init.sqf at line 77](../../../Src/client/Inventory/inventory_init.sqf#L77)
## inventory_invWidgetSize

Type: Variable

Description: На данный момент (Legacy - 0.5.148) данная переменная только устанавливает значения, но не использует их.


Initial value:
```sqf
[0,0,0,0]
```
File: [client\Inventory\inventory_init.sqf at line 79](../../../Src/client/Inventory/inventory_init.sqf#L79)
## inventory_verbMenuWidgets

Type: Variable

Description: 


Initial value:
```sqf
[widgetNull]
```
File: [client\Inventory\inventory_init.sqf at line 81](../../../Src/client/Inventory/inventory_init.sqf#L81)
## inventory_lastPressedSlotId

Type: Variable

Description: 


Initial value:
```sqf
-1 //нигде не используется?
```
File: [client\Inventory\inventory_init.sqf at line 82](../../../Src/client/Inventory/inventory_init.sqf#L82)
## inventory_verbItemPointer

Type: Variable

Description: нигде не используется?


Initial value:
```sqf
""
```
File: [client\Inventory\inventory_init.sqf at line 83](../../../Src/client/Inventory/inventory_init.sqf#L83)
## inventory_protectAltClick

Type: Variable

Description: inventory_protectExtraAction = false;


Initial value:
```sqf
false
```
File: [client\Inventory\inventory_init.sqf at line 86](../../../Src/client/Inventory/inventory_init.sqf#L86)
## inventory_containerCommonData

Type: Variable

Description: 


Initial value:
```sqf
nullContainerCommonData//name,ref,local game object
```
File: [client\Inventory\inventory_init.sqf at line 88](../../../Src/client/Inventory/inventory_init.sqf#L88)
## inventory_containerData

Type: Variable

Description: name,ref,local game object


Initial value:
```sqf
[]// check SD_<var>
```
File: [client\Inventory\inventory_init.sqf at line 89](../../../Src/client/Inventory/inventory_init.sqf#L89)
## inventory_isOpenContainer

Type: Variable

Description: check SD_<var>


Initial value:
```sqf
false
```
File: [client\Inventory\inventory_init.sqf at line 90](../../../Src/client/Inventory/inventory_init.sqf#L90)
## inventory_containerWidgets

Type: Variable

Description: 


Initial value:
```sqf
[widgetNull,widgetNull]//0 - ctg,1 - ctgScroll
```
File: [client\Inventory\inventory_init.sqf at line 91](../../../Src/client/Inventory/inventory_init.sqf#L91)
## inventory_containerSlots

Type: Variable

Description: 0 - ctg,1 - ctgScroll


Initial value:
```sqf
[]//список виджетов иконок внутри контейнера
```
File: [client\Inventory\inventory_init.sqf at line 92](../../../Src/client/Inventory/inventory_init.sqf#L92)
## inventory_freeSpaceSlots

Type: Variable

Description: список виджетов иконок внутри контейнера


Initial value:
```sqf
[]//список виджетов свободного места
```
File: [client\Inventory\inventory_init.sqf at line 93](../../../Src/client/Inventory/inventory_init.sqf#L93)
## inventory_contWidgetSize

Type: Variable

Description: список виджетов свободного места


Initial value:
```sqf
[0,0,0,0]
```
File: [client\Inventory\inventory_init.sqf at line 94](../../../Src/client/Inventory/inventory_init.sqf#L94)
## inventory_isPressedRMBDrag

Type: Variable

Description: 


Initial value:
```sqf
false //для защиты драга пкмом
```
File: [client\Inventory\inventory_init.sqf at line 96](../../../Src/client/Inventory/inventory_init.sqf#L96)
## inventory_isPressedInteractButton

Type: Variable

Description: для защиты драга пкмом


Initial value:
```sqf
false //специальный модификатор интерации
```
File: [client\Inventory\inventory_init.sqf at line 97](../../../Src/client/Inventory/inventory_init.sqf#L97)
## inventory_isOutsideDragCatch

Type: Variable

Description: специальный модификатор интерации


Initial value:
```sqf
false //указатель защиты от main action при условии: mouseDown > move outside current slot > move inside current
```
File: [client\Inventory\inventory_init.sqf at line 99](../../../Src/client/Inventory/inventory_init.sqf#L99)
## inventory_supressInventoryOpen

Type: Variable

Description: указатель защиты от main action при условии: mouseDown > move outside current slot > move inside current


Initial value:
```sqf
false //подавляет открытие инвентарных функций. работает для ПКМ по предмету
```
File: [client\Inventory\inventory_init.sqf at line 101](../../../Src/client/Inventory/inventory_init.sqf#L101)
## inventory_lastFocusedWidget

Type: Variable

Description: подавляет открытие инвентарных функций. работает для ПКМ по предмету


Initial value:
```sqf
[widgetNull] //последний в фокусе для увеличения
```
File: [client\Inventory\inventory_init.sqf at line 103](../../../Src/client/Inventory/inventory_init.sqf#L103)
## inventory_canHideHands

Type: Variable

Description: Скрывает инвентарь


Initial value:
```sqf
false
```
File: [client\Inventory\inventory_init.sqf at line 106](../../../Src/client/Inventory/inventory_init.sqf#L106)
## inventory_isFullHide

Type: Variable

Description: 


Initial value:
```sqf
false
```
File: [client\Inventory\inventory_init.sqf at line 107](../../../Src/client/Inventory/inventory_init.sqf#L107)
## inventory_hideAfter

Type: Variable

Description: 


Initial value:
```sqf
10
```
File: [client\Inventory\inventory_init.sqf at line 108](../../../Src/client/Inventory/inventory_init.sqf#L108)
## inventory_hideValue

Type: Variable

Description: 


Initial value:
```sqf
0
```
File: [client\Inventory\inventory_init.sqf at line 109](../../../Src/client/Inventory/inventory_init.sqf#L109)
## inventory_hideTimestamp

Type: Variable

Description: 


Initial value:
```sqf
-1
```
File: [client\Inventory\inventory_init.sqf at line 110](../../../Src/client/Inventory/inventory_init.sqf#L110)
## inventory_hideHandler

Type: Variable

Description: 


Initial value:
```sqf
-1
```
File: [client\Inventory\inventory_init.sqf at line 111](../../../Src/client/Inventory/inventory_init.sqf#L111)
## inventory_isHoldMode

Type: Variable

Description: Инвентарь по удержанию


Initial value:
```sqf
false
```
File: [client\Inventory\inventory_init.sqf at line 114](../../../Src/client/Inventory/inventory_init.sqf#L114)
## inventory_selfWidgets

Type: Variable

Description: Селф окно


Initial value:
```sqf
[widgetNull,widgetNull] //0 ctg,1 text
```
File: [client\Inventory\inventory_init.sqf at line 117](../../../Src/client/Inventory/inventory_init.sqf#L117)
# PreviewObject.sqf

## MAX_ONMOUSECURSOR_DROP_ANGLE

Type: constant

Description: угол наклона при котором режим выкладывания меняется с центра экрана на мышь


Replaced value:
```sqf
-0.2
```
File: [client\Inventory\PreviewObject.sqf at line 13](../../../Src/client/Inventory/PreviewObject.sqf#L13)
## PUTDOWN_RADIUS

Type: constant

Description: дистанция выкладывания


Replaced value:
```sqf
INTERACT_ITEM_DISTANCE
```
File: [client\Inventory\PreviewObject.sqf at line 16](../../../Src/client/Inventory/PreviewObject.sqf#L16)
## __internal_resetBackColor

Type: constant

Description: 


Replaced value:
```sqf
getSlotBackground(getDragSlot) setBackgroundColor BACKGROUND_COLOR
```
File: [client\Inventory\PreviewObject.sqf at line 51](../../../Src/client/Inventory/PreviewObject.sqf#L51)
## resetBackgrounDragSlot

Type: constant

Description: 


Replaced value:
```sqf
_visObj hideObject false; __internal_resetBackColor
```
File: [client\Inventory\PreviewObject.sqf at line 52](../../../Src/client/Inventory/PreviewObject.sqf#L52)
## inventory_previewObject

Type: Variable

Description: 


Initial value:
```sqf
objnull
```
File: [client\Inventory\PreviewObject.sqf at line 18](../../../Src/client/Inventory/PreviewObject.sqf#L18)
## inventory_lastDirPreviewObject

Type: Variable

Description: 


Initial value:
```sqf
0
```
File: [client\Inventory\PreviewObject.sqf at line 19](../../../Src/client/Inventory/PreviewObject.sqf#L19)
## inventory_createPreviewObject

Type: function

Description: 
- Param: _slotId

File: [client\Inventory\PreviewObject.sqf at line 21](../../../Src/client/Inventory/PreviewObject.sqf#L21)
## inventory_onVisualPreviewObject

Type: function

Description: 


File: [client\Inventory\PreviewObject.sqf at line 48](../../../Src/client/Inventory/PreviewObject.sqf#L48)
## inventory_collectInfoOnPutdown

Type: function

Description: 
- Param: _isFastPutdown

File: [client\Inventory\PreviewObject.sqf at line 118](../../../Src/client/Inventory/PreviewObject.sqf#L118)
## inventory_deletePreviewObject

Type: function

Description: 


File: [client\Inventory\PreviewObject.sqf at line 133](../../../Src/client/Inventory/PreviewObject.sqf#L133)
# verbs.sqf

## TIME_PREPARE_VERBMENU

Type: constant

Description: as TIME_PREPARE_SLOTS


Replaced value:
```sqf
0.09
```
File: [client\Inventory\verbs.sqf at line 12](../../../Src/client/Inventory/verbs.sqf#L12)
## inventory_onGetItemVerbs

Type: function

Description: 
- Param: _slot

File: [client\Inventory\verbs.sqf at line 14](../../../Src/client/Inventory/verbs.sqf#L14)
## inventory_onLoadVerbsInventory

Type: function

Description: 
- Param: _targetName
- Param: _verbList
- Param: _slotId
- Param: _pointer

File: [client\Inventory\verbs.sqf at line 31](../../../Src/client/Inventory/verbs.sqf#L31)
## inventory_onPrepareVerbMenu

Type: function

Description: 


File: [client\Inventory\verbs.sqf at line 70](../../../Src/client/Inventory/verbs.sqf#L70)
## inventory_onPressVerb

Type: function

Description: 
- Param: _control

File: [client\Inventory\verbs.sqf at line 87](../../../Src/client/Inventory/verbs.sqf#L87)
## inventory_unloadVerbMenu

Type: function

Description: 


File: [client\Inventory\verbs.sqf at line 107](../../../Src/client/Inventory/verbs.sqf#L107)
