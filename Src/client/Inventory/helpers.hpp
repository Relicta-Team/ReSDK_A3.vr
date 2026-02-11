// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include "..\..\host\engine.hpp"
#include "..\WidgetSystem\widgets.hpp"
#include "inventory.hpp"

namespace(Inventory,inventory_)

//comment this if dont need logging
macro_def(inventory_use_log)
#define INVENTORY_LOG

//Новая система слотов. 
//!не работает должным образом
//!Не должна использоваться пока не будет переработан и дополнен рендер 3д объектов со стороны плафтормы
//#define INVENTORY_USE_NEW_RENDER_ICONS

macro_func(inventory_getBackgroundColorNoItem,vector4())
#define BACKGROUND_COLOR_NOITEM [0.161,0.322,0.204,0.25]
/*[0.161,0.322,0.204,0.5]*/
macro_func(inventory_getBackgroundColor,vector4())
#define BACKGROUND_COLOR (["inv_slot_back"] call ct_getValue)
/*[0,0.6,0,0.5]*/
macro_func(inventory_getBackgroundColorActiveHand,vector4())
#define BACKGROUND_COLOR_ACTIVEHAND (["inv_slot_act"] call ct_getValue)
macro_func(inventory_getBackgroundColorCanInteract,vector4())
#define BACKGROUND_COLOR_CANINTERACT [0,0.4,0,0.7]

enum(PressedRefId,PRESSED_)
//ссылка на ивентарный нажатый слот
#define PRESSED_LINK 0
//ссылка на драгуемую ктгшку 
#define PRESSED_DRAG 1
enumend

macro_const(inventory_indexDragger)
#define INDEX_DRAGGER -9

macro_const(inventory_widgetSlotBiasH)
#define SLOT_BIASH 0.3

//время на подготовку (выезжание слотов)
macro_const(inventory_timePrepareSlots)
#define TIME_PREPARE_SLOTS 0.09
//Время на подготовку (появление) драга
macro_const(inventory_timePrepareDrag)
#define TIME_PREPARE_DRAG 0.1
//Непрозрачность драг-иконки во время перетаскивания
macro_const(inventory_dragFadeProcess)
#define DRAG_FADE_PROCESS 0.4

//drag managment. Драг это иконка предмета, идущая за указателем мыши при isDragProcess
macro_func(inventory_getDragSlot,widget())
#define getDragSlot (inventory_pressedwidget select PRESSED_DRAG)

inline_macro
#define onDragInit(wid) inventory_pressedwidget set [PRESSED_DRAG,wid]; wid ctrlSetFade 1; wid ctrlCommit 0

macro_func(inventory_isInteractibleAction,bool())
#define isInteractibleAction ((inventory_previewObject getVariable ["isInteractible",false]) || (typeof getInteractibleTarget == BASIC_MOB_TYPE))
//#define isInteractibleAction ((inventory_previewObject getVariable ["isInteractible",false]) && inventory_isPressedInteractButton || (typeof getInteractibleTarget == BASIC_MOB_TYPE))
macro_func(inventory_getInteractibleTarget,mesh())
#define getInteractibleTarget (inventory_previewObject getVariable ["interactibleTarget",objnull])

// link managment . Нажатый это просто референс на виджет из инвентаря

macro_func(inventory_getPressedSlot,widget())
#define getPressedSlot (inventory_pressedwidget select PRESSED_LINK)

macro_func(inventory_isDragProcess,bool())
#define isDragProcess (! (getPressedSlot isequalto widgetNull))

macro_func(inventory_isHandDrag,bool())
#define isHandDrag ((getSlotId(getPressedSlot) in [INV_HAND_L,INV_HAND_R]) && !isContainerSlot(getPressedSlot))

inline_macro
#define onPressSlot(slotwid) [slotwid] call inventory_onPressSlot

inline_macro
#define onReleaseSlot(zone) [zone] call inventory_onReleaseSlot

//other
macro_func(inventory_getSlotId,int(widget))
#define getSlotId(wid) (wid getvariable "slotid")

macro_func(inventory_getSlotIcon,string(widget))
#define getSlotIcon(wid) (wid getVariable "icon")

macro_func(inventory_getSlotDirtOverlay,widget(widget))
#define getSlotDirtOverlay(wid) (wid getvariable "dirtOverlay")

//Вот это раскомментить для текстовых названий иконок (но нужно доделывать)
//#define widgetSetPicture inventory_widgetSetPicture
macro_func(inventory_getSlotBackground,widget())
#define getSlotBackground(wid) (wid getVariable "background")

macro_func(inventory_getSlotName,string())
#define getSlotName(wid) (wid getVariable "slotname")

macro_func(inventory_isEmptySlot,bool(int))
#define isEmptySlot(id) ((inventory_slotdata select (id)) isequalto [])

macro_func(inventory_isEmptyWidget,bool(widget))
#define isEmptyWidget(wid) isEmptySlot(getSlotId(wid))

inline_macro
#define getSlotDataById(id) ((id) call inventory_getSlotDataById)

macro_func(inventory_getPressedSlotPosition,vector2())
#define getPressedSlotPosition inventory_pressedSlotPosition
macro_func(inventory_setPressedSlotPosition,vector2())
#define setPressedSlotPosition(pos) inventory_pressedSlotPosition = (pos)

inline_macro
#define isInsidePressedSlot inventory_isInsidePressedSlot

macro_func(inventory_getVerbMenuWidget,widget())
#define getVerbMenuWidget (inventory_verbMenuWidgets select 0)
//название данной функции заменено, потому что isInsideVerbMenu уже определён в Interactions

macro_func(inventory_isInsideVerbMenu_inv,bool())
#define isInsideVerbMenu_inv (getVerbMenuWidget call isMouseInsideWidget)
macro_func(inventory_isOpenedVerbMenu,bool())
#define isOpenedVerbMenu (!(getVerbMenuWidget isEqualTo widgetNull))

//container helpers
macro_func(inventory_getContainerMainCtg,widget())
#define getContainerMainCtg (inventory_containerWidgets select 0)
macro_func(inventory_getContainerSlotsCtg,widget())
#define getContainerSlotsCtg (inventory_containerWidgets select 1)
macro_func(inventory_getContainerNameText,widget())
#define getContainerNameText (inventory_containerWidgets select 2)

// internal macro for inventory::containerCommonData
	enum(ContainerDataIndex,container_index_)
	#define container_index_name 0
	#define container_index_ref 1
	#define container_index_object 2
	#define container_index_posoffset 3
	//assoc with container_index_object
	#define container_index_isInWorld container_index_object
	//this does not used
	#define container_object_awaitGenerateValue -1
	enumend

macro_func(inventory_getWorldContainer,mesh())
#define getWorldContainer (inventory_containerCommonData select container_index_object)
macro_func(inventory_getContainerRef,string())
#define getContainerRef (inventory_containerCommonData select container_index_ref)
macro_func(inventory_getContainerName,vector3())
#define getContainerPosOffset (inventory_containerCommonData select container_index_posoffset)
macro_func(inventory_setContainerPosOffset,void(vector3))
#define setContainerPosOffset(val) inventory_containerCommonData set [container_index_posoffset,val]
macro_func(inventory_isWorldContainer,bool())
#define isWorldContainer (getWorldContainer isEqualType objnull)

macro_func(inventory_isContainerSlot,bool(widget))
#define isContainerSlot(slot) (slot getVariable ["isContainerSlot",false])

macro_const(inventory_nullContainerCommonData)
#define nullContainerCommonData ["","","none",[0,0,0]]
macro_const(inventory_nullPostionPreviewObject)
#define nullPostionPreviewObject [0,0,0]

//self widgets
macro_const(inventory_selfCtgSizeH)
#define SELF_CTG_SIZE_H 5
macro_func(inventory_getSelfCtg,widget())
#define getSelfCtg (inventory_selfWidgets select 0)
macro_func(inventory_setSelfCtg,widget())
#define setSelfCtg(wid) inventory_selfWidgets set [0,wid]

macro_func(inventory_getSelfCtgText,widget())
#define getSelfCtgText (inventory_selfWidgets select 1)
macro_func(inventory_setSelfCtgText,void(widget))
#define setSelfCtgText(wid) inventory_selfWidgets set [1,wid]

//timing protection
macro_const(inventory_timeToReloadExtraAction)
#define TIME_TO_RELOAD_EXTRAACTION 0.8
macro_const(inventory_timeToReloadAltClickAction)
#define TIME_TO_RELOAD_ALTCLICKACTION 0.8

//hiding inventory
macro_const(inventory_hideUpdateDelay)
#define INV_HIDE_UPDATE_DELAY 0.1
macro_const(inventory_hidePerUpdateDelay)
#define INV_HIDE_PERUPDATE_DELAY 0.09


//extended logging

#ifdef RELEASE
	#undef INVENTORY_LOG
#endif

#ifdef INVENTORY_LOG
	macro_func(inventory_log,void(string;...any[]))
	#define invlog(mes,ft) logformat(mes,ft)

#else

	#define invlog(mes,ft)

#endif