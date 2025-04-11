# container.sqf

## CONTAINER_SIZE_W

Type: constant

Description: 


Replaced value:
```sqf
3
```
File: [client\Inventory\container.sqf at line 17](../../../Src/client/Inventory/container.sqf#L17)
## CONTAINER_SIZE_Y

Type: constant

Description: 


Replaced value:
```sqf

```
File: [client\Inventory\container.sqf at line 19](../../../Src/client/Inventory/container.sqf#L19)
## SIZE_BUTTON

Type: constant

Description: 


Replaced value:
```sqf
3
```
File: [client\Inventory\container.sqf at line 21](../../../Src/client/Inventory/container.sqf#L21)
## TIME_CONTAINER_ONLOAD

Type: constant

Description: 


Replaced value:
```sqf
0.25
```
File: [client\Inventory\container.sqf at line 24](../../../Src/client/Inventory/container.sqf#L24)
## TIME_CONTAINER_ONUNLOAD

Type: constant

Description: 


Replaced value:
```sqf
0.09
```
File: [client\Inventory\container.sqf at line 27](../../../Src/client/Inventory/container.sqf#L27)
## inventory_openContainer

Type: function

Description: 


File: [client\Inventory\container.sqf at line 30](../../../Src/client/Inventory/container.sqf#L30)
## createWidget_contSlot

Type: function

Description: 
- Param: _display
- Param: _slotName
- Param: _pos
- Param: _slotId
- Param: _ctgScr

File: [client\Inventory\container.sqf at line 116](../../../Src/client/Inventory/container.sqf#L116)
## inventory_loadContainerSlots

Type: function

Description: 


File: [client\Inventory\container.sqf at line 159](../../../Src/client/Inventory/container.sqf#L159)
## inventory_onPrepareContainer

Type: function

Description: 


File: [client\Inventory\container.sqf at line 256](../../../Src/client/Inventory/container.sqf#L256)
## inventory_closeContainer

Type: function

Description: 


File: [client\Inventory\container.sqf at line 278](../../../Src/client/Inventory/container.sqf#L278)
## inventory_onChangeLocContainer

Type: function

Description: 


File: [client\Inventory\container.sqf at line 292](../../../Src/client/Inventory/container.sqf#L292)
## inventory_unloadContainerMenu

Type: function

Description: 


File: [client\Inventory\container.sqf at line 306](../../../Src/client/Inventory/container.sqf#L306)
## inventory_onContainerOpen

Type: function

Description: 
- Param: _main
- Param: _data

File: [client\Inventory\container.sqf at line 331](../../../Src/client/Inventory/container.sqf#L331)
## inventory_onContainerContentUpdate

Type: function

Description: 
- Param: _data

File: [client\Inventory\container.sqf at line 403](../../../Src/client/Inventory/container.sqf#L403)
## inventory_onUpdateContainer

Type: function

Description: 


File: [client\Inventory\container.sqf at line 439](../../../Src/client/Inventory/container.sqf#L439)
## inventory_onPressContainerSlot

Type: function

Description: 
- Param: _slotFrom

File: [client\Inventory\container.sqf at line 473](../../../Src/client/Inventory/container.sqf#L473)
## inventory_onReleaseSlotFromContainer

Type: function

Description: 
- Param: _slotTo

File: [client\Inventory\container.sqf at line 498](../../../Src/client/Inventory/container.sqf#L498)
## inventory_onTransferSlotContainer

Type: function

Description: 
- Param: _containerSlot
- Param: _slotTo

File: [client\Inventory\container.sqf at line 533](../../../Src/client/Inventory/container.sqf#L533)
## inventory_onReleaseSlotToContainer

Type: function

Description: 


File: [client\Inventory\container.sqf at line 553](../../../Src/client/Inventory/container.sqf#L553)
# functions.sqf

## SIZE_INVSLOT

Type: constant

Description: 


Replaced value:
```sqf
7
```
File: [client\Inventory\functions.sqf at line 17](../../../Src/client/Inventory/functions.sqf#L17)
## MYPERSON_FADEVAL_EXIT

Type: constant

Description: 


Replaced value:
```sqf
0.9
```
File: [client\Inventory\functions.sqf at line 20](../../../Src/client/Inventory/functions.sqf#L20)
## MYPERSON_FADEVAL_ENTER

Type: constant

Description: 


Replaced value:
```sqf
0.2
```
File: [client\Inventory\functions.sqf at line 22](../../../Src/client/Inventory/functions.sqf#L22)
## MYPERSON_FADETIME

Type: constant

Description: 


Replaced value:
```sqf
0.5
```
File: [client\Inventory\functions.sqf at line 24](../../../Src/client/Inventory/functions.sqf#L24)
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
File: [client\Inventory\functions.sqf at line 424](../../../Src/client/Inventory/functions.sqf#L424)
## DEMAP(index,side)

Type: constant

Description: 
- Param: index
- Param: side

Replaced value:
```sqf
(inventory_slotpos_map select index select side)
```
File: [client\Inventory\functions.sqf at line 453](../../../Src/client/Inventory/functions.sqf#L453)
## POS_LEFTUP

Type: constant

Description: 


Replaced value:
```sqf
_xp + ((_wp + _biasW) * DEMAP(INV_BACKPACK,0)),_yp + ((_hp + SLOT_BIASH) * DEMAP(INV_BACKPACK,1))
```
File: [client\Inventory\functions.sqf at line 454](../../../Src/client/Inventory/functions.sqf#L454)
## POS_RIGHTDOWN

Type: constant

Description: 


Replaced value:
```sqf
_xp + ((_wp + _biasW) * DEMAP(INV_HAND_R,0)) + _wp,_yp + ((_hp + SLOT_BIASH) * DEMAP(INV_HAND_R,1)) + _hp
```
File: [client\Inventory\functions.sqf at line 455](../../../Src/client/Inventory/functions.sqf#L455)
## inventory_isGlobalVisible

Type: Variable

Description: 


Initial value:
```sqf
true
```
File: [client\Inventory\functions.sqf at line 115](../../../Src/client/Inventory/functions.sqf#L115)
## inventory_init

Type: function

Description: 


File: [client\Inventory\functions.sqf at line 27](../../../Src/client/Inventory/functions.sqf#L27)
## inventory_setHideHands

Type: function

Description: 
- Param: _mode

File: [client\Inventory\functions.sqf at line 48](../../../Src/client/Inventory/functions.sqf#L48)
## inventory_restoreHide

Type: function

Description: 
- Param: _now
- Param: _applyCommit (optional, default true)

File: [client\Inventory\functions.sqf at line 100](../../../Src/client/Inventory/functions.sqf#L100)
## inventory_setGlobalVisible

Type: function

Description: 
- Param: _mode

File: [client\Inventory\functions.sqf at line 119](../../../Src/client/Inventory/functions.sqf#L119)
## inventory_applyColorTheme

Type: function

Description: 


File: [client\Inventory\functions.sqf at line 138](../../../Src/client/Inventory/functions.sqf#L138)
## inventory_widgetSetPicture

Type: function

Description: 
- Param: _pic
- Param: _val

File: [client\Inventory\functions.sqf at line 146](../../../Src/client/Inventory/functions.sqf#L146)
## createWidget_invSlot

Type: function

Description: 
- Param: _display
- Param: _slotName
- Param: _pos
- Param: _slotId

File: [client\Inventory\functions.sqf at line 177](../../../Src/client/Inventory/functions.sqf#L177)
## openInventory

Type: function

Description: 


File: [client\Inventory\functions.sqf at line 247](../../../Src/client/Inventory/functions.sqf#L247)
## inventory_onPrepareSlots

Type: function

Description: 
- Param: _xp
- Param: _yp
- Param: _wp
- Param: _hp

File: [client\Inventory\functions.sqf at line 410](../../../Src/client/Inventory/functions.sqf#L410)
## inventory_resetPositionHandWidgets

Type: function

Description: 


File: [client\Inventory\functions.sqf at line 500](../../../Src/client/Inventory/functions.sqf#L500)
## inventory_resetPositionHandWidgetsForced

Type: function

Description: 


File: [client\Inventory\functions.sqf at line 511](../../../Src/client/Inventory/functions.sqf#L511)
## closeInventory

Type: function

Description: 


File: [client\Inventory\functions.sqf at line 522](../../../Src/client/Inventory/functions.sqf#L522)
## closeInventory_handle

Type: function

Description: 


File: [client\Inventory\functions.sqf at line 555](../../../Src/client/Inventory/functions.sqf#L555)
## inventoryGetPictureById

Type: function

Description: 


File: [client\Inventory\functions.sqf at line 565](../../../Src/client/Inventory/functions.sqf#L565)
## inventoryGetSlotNameById

Type: function

Description: 


File: [client\Inventory\functions.sqf at line 570](../../../Src/client/Inventory/functions.sqf#L570)
## inventoryGetWidgetById

Type: function

Description: 


File: [client\Inventory\functions.sqf at line 575](../../../Src/client/Inventory/functions.sqf#L575)
## inventoryGetWidgetOnMouse

Type: function

Description: 


File: [client\Inventory\functions.sqf at line 580](../../../Src/client/Inventory/functions.sqf#L580)
## inventoryGetContainerWidgetOnMouse

Type: function

Description: 


File: [client\Inventory\functions.sqf at line 592](../../../Src/client/Inventory/functions.sqf#L592)
## inventoryIsInContainerWidgetsZone

Type: function

Description: 


File: [client\Inventory\functions.sqf at line 604](../../../Src/client/Inventory/functions.sqf#L604)
## inventoryIsInWidgetsZone

Type: function

Description: 


File: [client\Inventory\functions.sqf at line 609](../../../Src/client/Inventory/functions.sqf#L609)
## inventoryIsInsideSelfWidget

Type: function

Description: 


File: [client\Inventory\functions.sqf at line 614](../../../Src/client/Inventory/functions.sqf#L614)
## inventory_onUpdate

Type: function

Description: 


File: [client\Inventory\functions.sqf at line 623](../../../Src/client/Inventory/functions.sqf#L623)
## inventory_onMousePress

Type: function

Description: 
- Param: _obj
- Param: _key

File: [client\Inventory\functions.sqf at line 766](../../../Src/client/Inventory/functions.sqf#L766)
## inventory_onMouseRelease

Type: function

Description: 
- Param: _obj
- Param: _key

File: [client\Inventory\functions.sqf at line 816](../../../Src/client/Inventory/functions.sqf#L816)
## inventory_onMouseScroll

Type: function

Description: 
- Param: _disp
- Param: _scroll

File: [client\Inventory\functions.sqf at line 859](../../../Src/client/Inventory/functions.sqf#L859)
## inventory_onSlotUpdate

Type: function

Description: 
- Param: _slotid
- Param: _data
- Param: _supressRestoreHide (optional, default false)

File: [client\Inventory\functions.sqf at line 888](../../../Src/client/Inventory/functions.sqf#L888)
## inventory_syncGerms

Type: function

Description: 
- Param: _data

File: [client\Inventory\functions.sqf at line 936](../../../Src/client/Inventory/functions.sqf#L936)
## inventory_internal_syncGermsBodyPartKey

Type: function

Description: 
- Param: _partKey
- Param: _opacity

File: [client\Inventory\functions.sqf at line 955](../../../Src/client/Inventory/functions.sqf#L955)
## inventory_syncModelPos

Type: function

> Exists if **INVENTORY_USE_NEW_RENDER_ICONS** defined

Description: 
- Param: _wid

File: [client\Inventory\functions.sqf at line 975](../../../Src/client/Inventory/functions.sqf#L975)
## inventory_onSlotListUpdate

Type: function

Description: 
- Param: _data

File: [client\Inventory\functions.sqf at line 1005](../../../Src/client/Inventory/functions.sqf#L1005)
## inventory_onReleaseSlot

Type: function

Description: 
- Param: _slotTo

File: [client\Inventory\functions.sqf at line 1014](../../../Src/client/Inventory/functions.sqf#L1014)
## inventory_onPressSlot

Type: function

Description: 
- Param: _slotFrom

File: [client\Inventory\functions.sqf at line 1083](../../../Src/client/Inventory/functions.sqf#L1083)
## inventory_onPutDownItem

Type: function

Description: 
- Param: _id (optional, default cd_activeHand)
- Param: _isFastPutdown (optional, default false)

File: [client\Inventory\functions.sqf at line 1110](../../../Src/client/Inventory/functions.sqf#L1110)
## inventory_onDropItem

Type: function

Description: 
- Param: _id (optional, default cd_activeHand)

File: [client\Inventory\functions.sqf at line 1151](../../../Src/client/Inventory/functions.sqf#L1151)
## inventory_onTransferSlot

Type: function

Description: 
- Param: _slotFrom
- Param: _slotTo

File: [client\Inventory\functions.sqf at line 1166](../../../Src/client/Inventory/functions.sqf#L1166)
## inventory_onInteractTargetWith

Type: function

Description: 
- Param: _obj
- Param: _slotData

File: [client\Inventory\functions.sqf at line 1203](../../../Src/client/Inventory/functions.sqf#L1203)
## inventory_onMainAction

Type: function

Description: 


File: [client\Inventory\functions.sqf at line 1221](../../../Src/client/Inventory/functions.sqf#L1221)
## inventory_onExtraAction

Type: function

Description: 


File: [client\Inventory\functions.sqf at line 1258](../../../Src/client/Inventory/functions.sqf#L1258)
## inventory_onClick

Type: function

Description: 


File: [client\Inventory\functions.sqf at line 1317](../../../Src/client/Inventory/functions.sqf#L1317)
## inventory_onExamine

Type: function

Description: 


File: [client\Inventory\functions.sqf at line 1359](../../../Src/client/Inventory/functions.sqf#L1359)
## inventory_changeActiveHand

Type: function

Description: 


File: [client\Inventory\functions.sqf at line 1420](../../../Src/client/Inventory/functions.sqf#L1420)
## inventory_changeTwoHandsMode

Type: function

Description: 


File: [client\Inventory\functions.sqf at line 1437](../../../Src/client/Inventory/functions.sqf#L1437)
## inventory_onChangeActiveHand

Type: function

Description: 
- Param: _notAct
- Param: _act
- Param: _setToNew (optional, default false)

File: [client\Inventory\functions.sqf at line 1447](../../../Src/client/Inventory/functions.sqf#L1447)
## inventory_isEmptyHands

Type: function

Description: 


File: [client\Inventory\functions.sqf at line 1473](../../../Src/client/Inventory/functions.sqf#L1473)
## inventory_isEmptyActiveHand

Type: function

Description: 


File: [client\Inventory\functions.sqf at line 1478](../../../Src/client/Inventory/functions.sqf#L1478)
## inventory_getModelById

Type: function

Description: 


File: [client\Inventory\functions.sqf at line 1481](../../../Src/client/Inventory/functions.sqf#L1481)
## inventory_getSlotDataById

Type: function

Description: 


File: [client\Inventory\functions.sqf at line 1486](../../../Src/client/Inventory/functions.sqf#L1486)
## inventory_getContainerSlotDataById

Type: function

Description: 


File: [client\Inventory\functions.sqf at line 1491](../../../Src/client/Inventory/functions.sqf#L1491)
# helpers.hpp

## INVENTORY_LOG

Type: constant

Description: 


Replaced value:
```sqf

```
File: [client\Inventory\helpers.hpp at line 14](../../../Src/client/Inventory/helpers.hpp#L14)
## BACKGROUND_COLOR_NOITEM

Type: constant

Description: 


Replaced value:
```sqf
[0.161,0.322,0.204,0.25]
```
File: [client\Inventory\helpers.hpp at line 22](../../../Src/client/Inventory/helpers.hpp#L22)
## BACKGROUND_COLOR

Type: constant

Description: 


Replaced value:
```sqf
(["inv_slot_back"] call ct_getValue)
```
File: [client\Inventory\helpers.hpp at line 22](../../../Src/client/Inventory/helpers.hpp#L22)
## BACKGROUND_COLOR_ACTIVEHAND

Type: constant

Description: 


Replaced value:
```sqf
(["inv_slot_act"] call ct_getValue)
```
File: [client\Inventory\helpers.hpp at line 28](../../../Src/client/Inventory/helpers.hpp#L28)
## BACKGROUND_COLOR_CANINTERACT

Type: constant

Description: 


Replaced value:
```sqf
[0,0.4,0,0.7]
```
File: [client\Inventory\helpers.hpp at line 30](../../../Src/client/Inventory/helpers.hpp#L30)
## PRESSED_LINK

Type: constant

Description: ссылка на ивентарный нажатый слот


Replaced value:
```sqf
0
```
File: [client\Inventory\helpers.hpp at line 34](../../../Src/client/Inventory/helpers.hpp#L34)
## PRESSED_DRAG

Type: constant

Description: ссылка на драгуемую ктгшку


Replaced value:
```sqf
1
```
File: [client\Inventory\helpers.hpp at line 36](../../../Src/client/Inventory/helpers.hpp#L36)
## INDEX_DRAGGER

Type: constant

Description: 


Replaced value:
```sqf
-9
```
File: [client\Inventory\helpers.hpp at line 40](../../../Src/client/Inventory/helpers.hpp#L40)
## SLOT_BIASH

Type: constant

Description: 


Replaced value:
```sqf
0.3
```
File: [client\Inventory\helpers.hpp at line 43](../../../Src/client/Inventory/helpers.hpp#L43)
## TIME_PREPARE_SLOTS

Type: constant

Description: 


Replaced value:
```sqf
0.09
```
File: [client\Inventory\helpers.hpp at line 47](../../../Src/client/Inventory/helpers.hpp#L47)
## TIME_PREPARE_DRAG

Type: constant

Description: 


Replaced value:
```sqf
0.1
```
File: [client\Inventory\helpers.hpp at line 50](../../../Src/client/Inventory/helpers.hpp#L50)
## DRAG_FADE_PROCESS

Type: constant

Description: 


Replaced value:
```sqf
0.4
```
File: [client\Inventory\helpers.hpp at line 53](../../../Src/client/Inventory/helpers.hpp#L53)
## getDragSlot

Type: constant

Description: 


Replaced value:
```sqf
(inventory_pressedwidget select PRESSED_DRAG)
```
File: [client\Inventory\helpers.hpp at line 57](../../../Src/client/Inventory/helpers.hpp#L57)
## onDragInit(wid)

Type: constant

Description: 
- Param: wid

Replaced value:
```sqf
inventory_pressedwidget set [PRESSED_DRAG,wid]; wid ctrlSetFade 1; wid ctrlCommit 0
```
File: [client\Inventory\helpers.hpp at line 60](../../../Src/client/Inventory/helpers.hpp#L60)
## isInteractibleAction

Type: constant

Description: 


Replaced value:
```sqf
((inventory_previewObject getVariable ["isInteractible",false]) || (typeof getInteractibleTarget == BASIC_MOB_TYPE))
```
File: [client\Inventory\helpers.hpp at line 63](../../../Src/client/Inventory/helpers.hpp#L63)
## getInteractibleTarget

Type: constant

Description: 


Replaced value:
```sqf
(inventory_previewObject getVariable ["interactibleTarget",objnull])
```
File: [client\Inventory\helpers.hpp at line 66](../../../Src/client/Inventory/helpers.hpp#L66)
## getPressedSlot

Type: constant

Description: 


Replaced value:
```sqf
(inventory_pressedwidget select PRESSED_LINK)
```
File: [client\Inventory\helpers.hpp at line 71](../../../Src/client/Inventory/helpers.hpp#L71)
## isDragProcess

Type: constant

Description: 


Replaced value:
```sqf
(! (getPressedSlot isequalto widgetNull))
```
File: [client\Inventory\helpers.hpp at line 74](../../../Src/client/Inventory/helpers.hpp#L74)
## isHandDrag

Type: constant

Description: 


Replaced value:
```sqf
((getSlotId(getPressedSlot) in [INV_HAND_L,INV_HAND_R]) && !isContainerSlot(getPressedSlot))
```
File: [client\Inventory\helpers.hpp at line 77](../../../Src/client/Inventory/helpers.hpp#L77)
## onPressSlot(slotwid)

Type: constant

Description: 
- Param: slotwid

Replaced value:
```sqf
[slotwid] call inventory_onPressSlot
```
File: [client\Inventory\helpers.hpp at line 80](../../../Src/client/Inventory/helpers.hpp#L80)
## onReleaseSlot(zone)

Type: constant

Description: 
- Param: zone

Replaced value:
```sqf
[zone] call inventory_onReleaseSlot
```
File: [client\Inventory\helpers.hpp at line 83](../../../Src/client/Inventory/helpers.hpp#L83)
## getSlotId(wid)

Type: constant

Description: 
- Param: wid

Replaced value:
```sqf
(wid getvariable "slotid")
```
File: [client\Inventory\helpers.hpp at line 87](../../../Src/client/Inventory/helpers.hpp#L87)
## getSlotIcon(wid)

Type: constant

Description: 
- Param: wid

Replaced value:
```sqf
(wid getVariable "icon")
```
File: [client\Inventory\helpers.hpp at line 90](../../../Src/client/Inventory/helpers.hpp#L90)
## getSlotDirtOverlay(wid)

Type: constant

Description: 
- Param: wid

Replaced value:
```sqf
(wid getvariable "dirtOverlay")
```
File: [client\Inventory\helpers.hpp at line 93](../../../Src/client/Inventory/helpers.hpp#L93)
## getSlotBackground(wid)

Type: constant

Description: 
- Param: wid

Replaced value:
```sqf
(wid getVariable "background")
```
File: [client\Inventory\helpers.hpp at line 98](../../../Src/client/Inventory/helpers.hpp#L98)
## getSlotName(wid)

Type: constant

Description: 
- Param: wid

Replaced value:
```sqf
(wid getVariable "slotname")
```
File: [client\Inventory\helpers.hpp at line 101](../../../Src/client/Inventory/helpers.hpp#L101)
## isEmptySlot(id)

Type: constant

Description: 
- Param: id

Replaced value:
```sqf
((inventory_slotdata select (id)) isequalto [])
```
File: [client\Inventory\helpers.hpp at line 104](../../../Src/client/Inventory/helpers.hpp#L104)
## isEmptyWidget(wid)

Type: constant

Description: 
- Param: wid

Replaced value:
```sqf
isEmptySlot(getSlotId(wid))
```
File: [client\Inventory\helpers.hpp at line 107](../../../Src/client/Inventory/helpers.hpp#L107)
## getSlotDataById(id)

Type: constant

Description: 
- Param: id

Replaced value:
```sqf
((id) call inventory_getSlotDataById)
```
File: [client\Inventory\helpers.hpp at line 110](../../../Src/client/Inventory/helpers.hpp#L110)
## getPressedSlotPosition

Type: constant

Description: 


Replaced value:
```sqf
inventory_pressedSlotPosition
```
File: [client\Inventory\helpers.hpp at line 113](../../../Src/client/Inventory/helpers.hpp#L113)
## setPressedSlotPosition(pos)

Type: constant

Description: 
- Param: pos

Replaced value:
```sqf
inventory_pressedSlotPosition = (pos)
```
File: [client\Inventory\helpers.hpp at line 115](../../../Src/client/Inventory/helpers.hpp#L115)
## isInsidePressedSlot

Type: constant

Description: 


Replaced value:
```sqf
inventory_isInsidePressedSlot
```
File: [client\Inventory\helpers.hpp at line 118](../../../Src/client/Inventory/helpers.hpp#L118)
## getVerbMenuWidget

Type: constant

Description: 


Replaced value:
```sqf
(inventory_verbMenuWidgets select 0)
```
File: [client\Inventory\helpers.hpp at line 121](../../../Src/client/Inventory/helpers.hpp#L121)
## isInsideVerbMenu_inv

Type: constant

Description: 


Replaced value:
```sqf
(getVerbMenuWidget call isMouseInsideWidget)
```
File: [client\Inventory\helpers.hpp at line 125](../../../Src/client/Inventory/helpers.hpp#L125)
## isOpenedVerbMenu

Type: constant

Description: 


Replaced value:
```sqf
(!(getVerbMenuWidget isEqualTo widgetNull))
```
File: [client\Inventory\helpers.hpp at line 127](../../../Src/client/Inventory/helpers.hpp#L127)
## getContainerMainCtg

Type: constant

Description: 


Replaced value:
```sqf
(inventory_containerWidgets select 0)
```
File: [client\Inventory\helpers.hpp at line 131](../../../Src/client/Inventory/helpers.hpp#L131)
## getContainerSlotsCtg

Type: constant

Description: 


Replaced value:
```sqf
(inventory_containerWidgets select 1)
```
File: [client\Inventory\helpers.hpp at line 133](../../../Src/client/Inventory/helpers.hpp#L133)
## getContainerNameText

Type: constant

Description: 


Replaced value:
```sqf
(inventory_containerWidgets select 2)
```
File: [client\Inventory\helpers.hpp at line 135](../../../Src/client/Inventory/helpers.hpp#L135)
## container_index_name

Type: constant

Description: 


Replaced value:
```sqf
0
```
File: [client\Inventory\helpers.hpp at line 139](../../../Src/client/Inventory/helpers.hpp#L139)
## container_index_ref

Type: constant

Description: 


Replaced value:
```sqf
1
```
File: [client\Inventory\helpers.hpp at line 140](../../../Src/client/Inventory/helpers.hpp#L140)
## container_index_object

Type: constant

Description: 


Replaced value:
```sqf
2
```
File: [client\Inventory\helpers.hpp at line 141](../../../Src/client/Inventory/helpers.hpp#L141)
## container_index_posoffset

Type: constant

Description: 


Replaced value:
```sqf
3
```
File: [client\Inventory\helpers.hpp at line 142](../../../Src/client/Inventory/helpers.hpp#L142)
## container_index_isInWorld

Type: constant

Description: assoc with container_index_object


Replaced value:
```sqf
container_index_object
```
File: [client\Inventory\helpers.hpp at line 144](../../../Src/client/Inventory/helpers.hpp#L144)
## container_object_awaitGenerateValue

Type: constant

Description: this does not used


Replaced value:
```sqf
-1
```
File: [client\Inventory\helpers.hpp at line 146](../../../Src/client/Inventory/helpers.hpp#L146)
## getWorldContainer

Type: constant

Description: 


Replaced value:
```sqf
(inventory_containerCommonData select container_index_object)
```
File: [client\Inventory\helpers.hpp at line 150](../../../Src/client/Inventory/helpers.hpp#L150)
## getContainerRef

Type: constant

Description: 


Replaced value:
```sqf
(inventory_containerCommonData select container_index_ref)
```
File: [client\Inventory\helpers.hpp at line 152](../../../Src/client/Inventory/helpers.hpp#L152)
## getContainerPosOffset

Type: constant

Description: 


Replaced value:
```sqf
(inventory_containerCommonData select container_index_posoffset)
```
File: [client\Inventory\helpers.hpp at line 154](../../../Src/client/Inventory/helpers.hpp#L154)
## setContainerPosOffset(val)

Type: constant

Description: 
- Param: val

Replaced value:
```sqf
inventory_containerCommonData set [container_index_posoffset,val]
```
File: [client\Inventory\helpers.hpp at line 156](../../../Src/client/Inventory/helpers.hpp#L156)
## isWorldContainer

Type: constant

Description: 


Replaced value:
```sqf
(getWorldContainer isEqualType objnull)
```
File: [client\Inventory\helpers.hpp at line 158](../../../Src/client/Inventory/helpers.hpp#L158)
## isContainerSlot(slot)

Type: constant

Description: 
- Param: slot

Replaced value:
```sqf
(slot getVariable ["isContainerSlot",false])
```
File: [client\Inventory\helpers.hpp at line 161](../../../Src/client/Inventory/helpers.hpp#L161)
## nullContainerCommonData

Type: constant

Description: 


Replaced value:
```sqf
["","","none",[0,0,0]]
```
File: [client\Inventory\helpers.hpp at line 164](../../../Src/client/Inventory/helpers.hpp#L164)
## nullPostionPreviewObject

Type: constant

Description: 


Replaced value:
```sqf
[0,0,0]
```
File: [client\Inventory\helpers.hpp at line 166](../../../Src/client/Inventory/helpers.hpp#L166)
## SELF_CTG_SIZE_H

Type: constant

Description: 


Replaced value:
```sqf
5
```
File: [client\Inventory\helpers.hpp at line 170](../../../Src/client/Inventory/helpers.hpp#L170)
## getSelfCtg

Type: constant

Description: 


Replaced value:
```sqf
(inventory_selfWidgets select 0)
```
File: [client\Inventory\helpers.hpp at line 172](../../../Src/client/Inventory/helpers.hpp#L172)
## setSelfCtg(wid)

Type: constant

Description: 
- Param: wid

Replaced value:
```sqf
inventory_selfWidgets set [0,wid]
```
File: [client\Inventory\helpers.hpp at line 174](../../../Src/client/Inventory/helpers.hpp#L174)
## getSelfCtgText

Type: constant

Description: 


Replaced value:
```sqf
(inventory_selfWidgets select 1)
```
File: [client\Inventory\helpers.hpp at line 177](../../../Src/client/Inventory/helpers.hpp#L177)
## setSelfCtgText(wid)

Type: constant

Description: 
- Param: wid

Replaced value:
```sqf
inventory_selfWidgets set [1,wid]
```
File: [client\Inventory\helpers.hpp at line 179](../../../Src/client/Inventory/helpers.hpp#L179)
## TIME_TO_RELOAD_EXTRAACTION

Type: constant

Description: 


Replaced value:
```sqf
0.8
```
File: [client\Inventory\helpers.hpp at line 183](../../../Src/client/Inventory/helpers.hpp#L183)
## TIME_TO_RELOAD_ALTCLICKACTION

Type: constant

Description: 


Replaced value:
```sqf
0.8
```
File: [client\Inventory\helpers.hpp at line 185](../../../Src/client/Inventory/helpers.hpp#L185)
## INV_HIDE_UPDATE_DELAY

Type: constant

Description: 


Replaced value:
```sqf
0.1
```
File: [client\Inventory\helpers.hpp at line 189](../../../Src/client/Inventory/helpers.hpp#L189)
## INV_HIDE_PERUPDATE_DELAY

Type: constant

Description: 


Replaced value:
```sqf
0.09
```
File: [client\Inventory\helpers.hpp at line 191](../../../Src/client/Inventory/helpers.hpp#L191)
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
File: [client\Inventory\helpers.hpp at line 202](../../../Src/client/Inventory/helpers.hpp#L202)
## invlog(mes,ft)

Type: constant

> Exists if **INVENTORY_LOG** not defined

Description: 
- Param: mes
- Param: ft

Replaced value:
```sqf

```
File: [client\Inventory\helpers.hpp at line 206](../../../Src/client/Inventory/helpers.hpp#L206)
# inventory.hpp

## INV_BACKPACK

Type: constant

Description: 


Replaced value:
```sqf
0
```
File: [client\Inventory\inventory.hpp at line 13](../../../Src/client/Inventory/inventory.hpp#L13)
## INV_ARMOR

Type: constant

Description: 


Replaced value:
```sqf
1
```
File: [client\Inventory\inventory.hpp at line 14](../../../Src/client/Inventory/inventory.hpp#L14)
## INV_HEAD

Type: constant

Description: 


Replaced value:
```sqf
2
```
File: [client\Inventory\inventory.hpp at line 15](../../../Src/client/Inventory/inventory.hpp#L15)
## INV_BACK

Type: constant

Description: 


Replaced value:
```sqf
3
```
File: [client\Inventory\inventory.hpp at line 13](../../../Src/client/Inventory/inventory.hpp#L13)
## INV_CLOTH

Type: constant

Description: 


Replaced value:
```sqf
4
```
File: [client\Inventory\inventory.hpp at line 17](../../../Src/client/Inventory/inventory.hpp#L17)
## INV_FACE

Type: constant

Description: 


Replaced value:
```sqf
5
```
File: [client\Inventory\inventory.hpp at line 18](../../../Src/client/Inventory/inventory.hpp#L18)
## INV_HAND_L

Type: constant

Description: 


Replaced value:
```sqf
6
```
File: [client\Inventory\inventory.hpp at line 19](../../../Src/client/Inventory/inventory.hpp#L19)
## INV_BELT

Type: constant

Description: 


Replaced value:
```sqf
7
```
File: [client\Inventory\inventory.hpp at line 20](../../../Src/client/Inventory/inventory.hpp#L20)
## INV_HAND_R

Type: constant

Description: 


Replaced value:
```sqf
8
```
File: [client\Inventory\inventory.hpp at line 21](../../../Src/client/Inventory/inventory.hpp#L21)
## INV_LIST_HANDS

Type: constant

Description: 


Replaced value:
```sqf
[INV_HAND_L,INV_HAND_R]
```
File: [client\Inventory\inventory.hpp at line 25](../../../Src/client/Inventory/inventory.hpp#L25)
## INV_LIST_ALL

Type: constant

Description: 


Replaced value:
```sqf
[INV_BACKPACK, INV_ARMOR, INV_HEAD, INV_BACK,INV_CLOTH,INV_FACE,INV_HAND_L,INV_BELT,INV_HAND_R]
```
File: [client\Inventory\inventory.hpp at line 27](../../../Src/client/Inventory/inventory.hpp#L27)
## INV_LIST_VARNAME

Type: constant

Description: 


Replaced value:
```sqf
["INV_BACKPACK","INV_ARMOR","INV_HEAD","INV_BACK","INV_CLOTH","INV_FACE","INV_HAND_L","INV_BELT","INV_HAND_R"]
```
File: [client\Inventory\inventory.hpp at line 29](../../../Src/client/Inventory/inventory.hpp#L29)
## INV_LIST_SLOTNAMES

Type: constant

Description: 


Replaced value:
```sqf
["Спина","Броня","Голова","Плечо","Одеяния","Лицо","Левая рука","Пояс","Правая рука"]
```
File: [client\Inventory\inventory.hpp at line 31](../../../Src/client/Inventory/inventory.hpp#L31)
## INV_LIST_FACE

Type: constant

Description: 


Replaced value:
```sqf
[INV_HEAD,INV_FACE]
```
File: [client\Inventory\inventory.hpp at line 34](../../../Src/client/Inventory/inventory.hpp#L34)
## INV_LIST_TORSO

Type: constant

Description: 


Replaced value:
```sqf
[INV_BACKPACK,INV_BACK,INV_CLOTH,INV_BELT,INV_ARMOR]
```
File: [client\Inventory\inventory.hpp at line 36](../../../Src/client/Inventory/inventory.hpp#L36)
## SD_NAME

Type: constant

Description: 


Replaced value:
```sqf
0
```
File: [client\Inventory\inventory.hpp at line 39](../../../Src/client/Inventory/inventory.hpp#L39)
## SD_ICON

Type: constant

Description: 


Replaced value:
```sqf
1
```
File: [client\Inventory\inventory.hpp at line 40](../../../Src/client/Inventory/inventory.hpp#L40)
## SD_POINTER

Type: constant

Description: 


Replaced value:
```sqf
2
```
File: [client\Inventory\inventory.hpp at line 41](../../../Src/client/Inventory/inventory.hpp#L41)
## SD_MODEL

Type: constant

Description: 


Replaced value:
```sqf
3
```
File: [client\Inventory\inventory.hpp at line 42](../../../Src/client/Inventory/inventory.hpp#L42)
## PATH_PICTURE_INV(icon)

Type: constant

Description: 
- Param: icon

Replaced value:
```sqf
PATH_PICTURE("inventory\items\" + (icon) + ".paa")
```
File: [client\Inventory\inventory.hpp at line 48](../../../Src/client/Inventory/inventory.hpp#L48)
# inventory_init.sqf

## PIC_PATH(name)

Type: constant

Description: 
- Param: name

Replaced value:
```sqf
(PATH_PICTURE_FOLDER + "inventory\" + name + ".paa")
```
File: [client\Inventory\inventory_init.sqf at line 14](../../../Src/client/Inventory/inventory_init.sqf#L14)
## TEMP_ITEM_ICON

Type: constant

Description: 


Replaced value:
```sqf
PIC_PATH("items\temp_item")
```
File: [client\Inventory\inventory_init.sqf at line 16](../../../Src/client/Inventory/inventory_init.sqf#L16)
## inventory_sloticons_default

Type: Variable

Description: 


Initial value:
```sqf
[...
```
File: [client\Inventory\inventory_init.sqf at line 26](../../../Src/client/Inventory/inventory_init.sqf#L26)
## inventory_const_dirtOverlayIcon

Type: Variable

Description: 


Initial value:
```sqf
PIC_PATH("dirt_overlay")
```
File: [client\Inventory\inventory_init.sqf at line 39](../../../Src/client/Inventory/inventory_init.sqf#L39)
## inventory_const_partkeyToSlots

Type: Variable

Description: 


Initial value:
```sqf
[...
```
File: [client\Inventory\inventory_init.sqf at line 41](../../../Src/client/Inventory/inventory_init.sqf#L41)
## inventory_slotdataDirt

Type: Variable

Description: 


Initial value:
```sqf
inventory_const_partkeyToSlots apply ...
```
File: [client\Inventory\inventory_init.sqf at line 51](../../../Src/client/Inventory/inventory_init.sqf#L51)
## inventory_commitNowAllGerms

Type: Variable

Description: 


Initial value:
```sqf
false//используется для быстрого применения грязи при открытии инвентаря
```
File: [client\Inventory\inventory_init.sqf at line 54](../../../Src/client/Inventory/inventory_init.sqf#L54)
## inventory_openModeSlotsId

Type: Variable

Description: 


Initial value:
```sqf
[INV_BACKPACK,INV_ARMOR,INV_HEAD,INV_BACK,INV_CLOTH,INV_FACE,INV_BELT]
```
File: [client\Inventory\inventory_init.sqf at line 57](../../../Src/client/Inventory/inventory_init.sqf#L57)
## inventory_slotnames_default

Type: Variable

Description: 


Initial value:
```sqf
INV_LIST_SLOTNAMES
```
File: [client\Inventory\inventory_init.sqf at line 62](../../../Src/client/Inventory/inventory_init.sqf#L62)
## inventory_slotpos_map

Type: Variable

Description: 


Initial value:
```sqf
[...
```
File: [client\Inventory\inventory_init.sqf at line 65](../../../Src/client/Inventory/inventory_init.sqf#L65)
## inventor_slot_widgets

Type: Variable

Description: 


Initial value:
```sqf
[]
```
File: [client\Inventory\inventory_init.sqf at line 78](../../../Src/client/Inventory/inventory_init.sqf#L78)
## inventory_slotdata

Type: Variable

Description: 


Initial value:
```sqf
_inventory_slotdata apply ...
```
File: [client\Inventory\inventory_init.sqf at line 87](../../../Src/client/Inventory/inventory_init.sqf#L87)
## isInventoryOpen

Type: Variable

Description: 


Initial value:
```sqf
false
```
File: [client\Inventory\inventory_init.sqf at line 90](../../../Src/client/Inventory/inventory_init.sqf#L90)
## inventory_modifierScroll

Type: Variable

Description: 


Initial value:
```sqf
false//множитель прокручивания при нажатом шифте
```
File: [client\Inventory\inventory_init.sqf at line 93](../../../Src/client/Inventory/inventory_init.sqf#L93)
## inventory_pressedwidget

Type: Variable

Description: 


Initial value:
```sqf
[widgetNull,widgetNull]
```
File: [client\Inventory\inventory_init.sqf at line 97](../../../Src/client/Inventory/inventory_init.sqf#L97)
## inventory_pressedSlotPosition

Type: Variable

Description: 


Initial value:
```sqf
[0,0]
```
File: [client\Inventory\inventory_init.sqf at line 99](../../../Src/client/Inventory/inventory_init.sqf#L99)
## inventory_isInsidePressedSlot

Type: Variable

Description: 


Initial value:
```sqf
false //На данный момент (Legacy - 0.5.148) данная переменная только устанавливает значения, но не использует их.
```
File: [client\Inventory\inventory_init.sqf at line 101](../../../Src/client/Inventory/inventory_init.sqf#L101)
## inventory_invWidgetSize

Type: Variable

Description: 


Initial value:
```sqf
[0,0,0,0]
```
File: [client\Inventory\inventory_init.sqf at line 104](../../../Src/client/Inventory/inventory_init.sqf#L104)
## inventory_verbMenuWidgets

Type: Variable

Description: 


Initial value:
```sqf
[widgetNull]
```
File: [client\Inventory\inventory_init.sqf at line 107](../../../Src/client/Inventory/inventory_init.sqf#L107)
## inventory_lastPressedSlotId

Type: Variable

Description: 


Initial value:
```sqf
-1 //нигде не используется?
```
File: [client\Inventory\inventory_init.sqf at line 109](../../../Src/client/Inventory/inventory_init.sqf#L109)
## inventory_verbItemPointer

Type: Variable

Description: 


Initial value:
```sqf
""
```
File: [client\Inventory\inventory_init.sqf at line 111](../../../Src/client/Inventory/inventory_init.sqf#L111)
## inventory_protectAltClick

Type: Variable

Description: 


Initial value:
```sqf
false
```
File: [client\Inventory\inventory_init.sqf at line 115](../../../Src/client/Inventory/inventory_init.sqf#L115)
## inventory_containerCommonData

Type: Variable

Description: 


Initial value:
```sqf
nullContainerCommonData//name,ref,local game object
```
File: [client\Inventory\inventory_init.sqf at line 118](../../../Src/client/Inventory/inventory_init.sqf#L118)
## inventory_containerData

Type: Variable

Description: 


Initial value:
```sqf
[]// check SD_<var>
```
File: [client\Inventory\inventory_init.sqf at line 120](../../../Src/client/Inventory/inventory_init.sqf#L120)
## inventory_isOpenContainer

Type: Variable

Description: 


Initial value:
```sqf
false
```
File: [client\Inventory\inventory_init.sqf at line 122](../../../Src/client/Inventory/inventory_init.sqf#L122)
## inventory_containerWidgets

Type: Variable

Description: 


Initial value:
```sqf
[widgetNull,widgetNull]//0 - ctg,1 - ctgScroll
```
File: [client\Inventory\inventory_init.sqf at line 124](../../../Src/client/Inventory/inventory_init.sqf#L124)
## inventory_containerSlots

Type: Variable

Description: 


Initial value:
```sqf
[]//список виджетов иконок внутри контейнера
```
File: [client\Inventory\inventory_init.sqf at line 126](../../../Src/client/Inventory/inventory_init.sqf#L126)
## inventory_freeSpaceSlots

Type: Variable

Description: 


Initial value:
```sqf
[]//список виджетов свободного места
```
File: [client\Inventory\inventory_init.sqf at line 128](../../../Src/client/Inventory/inventory_init.sqf#L128)
## inventory_contWidgetSize

Type: Variable

Description: 


Initial value:
```sqf
[0,0,0,0]
```
File: [client\Inventory\inventory_init.sqf at line 130](../../../Src/client/Inventory/inventory_init.sqf#L130)
## inventory_isPressedRMBDrag

Type: Variable

Description: 


Initial value:
```sqf
false //для защиты драга пкмом
```
File: [client\Inventory\inventory_init.sqf at line 133](../../../Src/client/Inventory/inventory_init.sqf#L133)
## inventory_isPressedInteractButton

Type: Variable

Description: 


Initial value:
```sqf
false //специальный модификатор интерации
```
File: [client\Inventory\inventory_init.sqf at line 135](../../../Src/client/Inventory/inventory_init.sqf#L135)
## inventory_isOutsideDragCatch

Type: Variable

Description: 


Initial value:
```sqf
false //указатель защиты от main action при условии: mouseDown > move outside current slot > move inside current
```
File: [client\Inventory\inventory_init.sqf at line 138](../../../Src/client/Inventory/inventory_init.sqf#L138)
## inventory_supressInventoryOpen

Type: Variable

Description: 


Initial value:
```sqf
false //подавляет открытие инвентарных функций. работает для ПКМ по предмету
```
File: [client\Inventory\inventory_init.sqf at line 141](../../../Src/client/Inventory/inventory_init.sqf#L141)
## inventory_lastFocusedWidget

Type: Variable

Description: 


Initial value:
```sqf
[widgetNull] //последний в фокусе для увеличения
```
File: [client\Inventory\inventory_init.sqf at line 144](../../../Src/client/Inventory/inventory_init.sqf#L144)
## inventory_canHideHands

Type: Variable

Description: 


Initial value:
```sqf
false
```
File: [client\Inventory\inventory_init.sqf at line 148](../../../Src/client/Inventory/inventory_init.sqf#L148)
## inventory_isFullHide

Type: Variable

Description: 


Initial value:
```sqf
false
```
File: [client\Inventory\inventory_init.sqf at line 150](../../../Src/client/Inventory/inventory_init.sqf#L150)
## inventory_hideAfter

Type: Variable

Description: 


Initial value:
```sqf
10
```
File: [client\Inventory\inventory_init.sqf at line 152](../../../Src/client/Inventory/inventory_init.sqf#L152)
## inventory_hideValue

Type: Variable

Description: 


Initial value:
```sqf
0
```
File: [client\Inventory\inventory_init.sqf at line 154](../../../Src/client/Inventory/inventory_init.sqf#L154)
## inventory_hideTimestamp

Type: Variable

Description: 


Initial value:
```sqf
-1
```
File: [client\Inventory\inventory_init.sqf at line 156](../../../Src/client/Inventory/inventory_init.sqf#L156)
## inventory_hideHandler

Type: Variable

Description: 


Initial value:
```sqf
-1
```
File: [client\Inventory\inventory_init.sqf at line 158](../../../Src/client/Inventory/inventory_init.sqf#L158)
## inventory_isHoldMode

Type: Variable

Description: 


Initial value:
```sqf
false
```
File: [client\Inventory\inventory_init.sqf at line 162](../../../Src/client/Inventory/inventory_init.sqf#L162)
## inventory_selfWidgets

Type: Variable

Description: 


Initial value:
```sqf
[widgetNull,widgetNull] //0 ctg,1 text
```
File: [client\Inventory\inventory_init.sqf at line 166](../../../Src/client/Inventory/inventory_init.sqf#L166)
# PreviewObject.sqf

## MAX_ONMOUSECURSOR_DROP_ANGLE

Type: constant

Description: 


Replaced value:
```sqf
-0.2
```
File: [client\Inventory\PreviewObject.sqf at line 16](../../../Src/client/Inventory/PreviewObject.sqf#L16)
## PUTDOWN_RADIUS

Type: constant

Description: 


Replaced value:
```sqf
INTERACT_ITEM_DISTANCE
```
File: [client\Inventory\PreviewObject.sqf at line 20](../../../Src/client/Inventory/PreviewObject.sqf#L20)
## __internal_resetBackColor

Type: constant

Description: 


Replaced value:
```sqf
getSlotBackground(getDragSlot) setBackgroundColor BACKGROUND_COLOR
```
File: [client\Inventory\PreviewObject.sqf at line 60](../../../Src/client/Inventory/PreviewObject.sqf#L60)
## resetBackgrounDragSlot

Type: constant

Description: 


Replaced value:
```sqf
_visObj hideObject false; __internal_resetBackColor
```
File: [client\Inventory\PreviewObject.sqf at line 62](../../../Src/client/Inventory/PreviewObject.sqf#L62)
## inventory_previewObject

Type: Variable

Description: 


Initial value:
```sqf
objnull
```
File: [client\Inventory\PreviewObject.sqf at line 23](../../../Src/client/Inventory/PreviewObject.sqf#L23)
## inventory_lastDirPreviewObject

Type: Variable

Description: 


Initial value:
```sqf
0
```
File: [client\Inventory\PreviewObject.sqf at line 25](../../../Src/client/Inventory/PreviewObject.sqf#L25)
## inventory_createPreviewObject

Type: function

Description: 
- Param: _slotId

File: [client\Inventory\PreviewObject.sqf at line 28](../../../Src/client/Inventory/PreviewObject.sqf#L28)
## inventory_onVisualPreviewObject

Type: function

Description: 


File: [client\Inventory\PreviewObject.sqf at line 56](../../../Src/client/Inventory/PreviewObject.sqf#L56)
## inventory_collectInfoOnPutdown

Type: function

Description: 
- Param: _isFastPutdown

File: [client\Inventory\PreviewObject.sqf at line 129](../../../Src/client/Inventory/PreviewObject.sqf#L129)
## inventory_deletePreviewObject

Type: function

Description: 


File: [client\Inventory\PreviewObject.sqf at line 145](../../../Src/client/Inventory/PreviewObject.sqf#L145)
# verbs.sqf

## TIME_PREPARE_VERBMENU

Type: constant

Description: 


Replaced value:
```sqf
0.09
```
File: [client\Inventory\verbs.sqf at line 15](../../../Src/client/Inventory/verbs.sqf#L15)
## inventory_onGetItemVerbs

Type: function

Description: 
- Param: _slot

File: [client\Inventory\verbs.sqf at line 18](../../../Src/client/Inventory/verbs.sqf#L18)
## inventory_onLoadVerbsInventory

Type: function

Description: 
- Param: _targetName
- Param: _verbList
- Param: _slotId
- Param: _pointer

File: [client\Inventory\verbs.sqf at line 36](../../../Src/client/Inventory/verbs.sqf#L36)
## inventory_onPrepareVerbMenu

Type: function

Description: 


File: [client\Inventory\verbs.sqf at line 75](../../../Src/client/Inventory/verbs.sqf#L75)
## inventory_onPressVerb

Type: function

Description: 
- Param: _control

File: [client\Inventory\verbs.sqf at line 93](../../../Src/client/Inventory/verbs.sqf#L93)
## inventory_unloadVerbMenu

Type: function

Description: 


File: [client\Inventory\verbs.sqf at line 114](../../../Src/client/Inventory/verbs.sqf#L114)
