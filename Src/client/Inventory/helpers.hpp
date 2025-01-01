// ======================================================
// Copyright (c) 2017-2025 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include "..\..\host\engine.hpp"
#include "..\WidgetSystem\widgets.hpp"
#include "inventory.hpp"

//comment this if dont need logging
#define INVENTORY_LOG

//Новая система слотов. 
//!не работает должным образом
//!Не должна использоваться пока не будет переработан и дополнен рендер 3д объектов со стороны плафтормы
//#define INVENTORY_USE_NEW_RENDER_ICONS


#define BACKGROUND_COLOR_NOITEM [0.161,0.322,0.204,0.25]
#define BACKGROUND_COLOR (["inv_slot_back"] call ct_getValue)/*[0.161,0.322,0.204,0.5]*/
#define BACKGROUND_COLOR_ACTIVEHAND (["inv_slot_act"] call ct_getValue)/*[0,0.6,0,0.5]*/
#define BACKGROUND_COLOR_CANINTERACT [0,0.4,0,0.7]

#define PRESSED_LINK 0 //ссылка на ивентарный нажатый слот
#define PRESSED_DRAG 1 //ссылка на драгуемую ктгшку

#define INDEX_DRAGGER -9

#define SLOT_BIASH 0.3

//время на подготовку (выезжание слотов)
#define TIME_PREPARE_SLOTS 0.09
//Время на подготовку (появление) драга
#define TIME_PREPARE_DRAG 0.1
//Непрозрачность драг-иконки во время перетаскивания
#define DRAG_FADE_PROCESS 0.4

//drag managment. Драг это иконка предмета, идущая за указателем мыши при isDragProcess

#define getDragSlot (inventory_pressedwidget select PRESSED_DRAG)

#define onDragInit(wid) inventory_pressedwidget set [PRESSED_DRAG,wid]; wid ctrlSetFade 1; wid ctrlCommit 0

#define isInteractibleAction ((inventory_previewObject getVariable ["isInteractible",false]) || (typeof getInteractibleTarget == BASIC_MOB_TYPE))
//#define isInteractibleAction ((inventory_previewObject getVariable ["isInteractible",false]) && inventory_isPressedInteractButton || (typeof getInteractibleTarget == BASIC_MOB_TYPE))
#define getInteractibleTarget (inventory_previewObject getVariable ["interactibleTarget",objnull])

// link managment . Нажатый это просто референс на виджет из инвентаря

#define getPressedSlot (inventory_pressedwidget select PRESSED_LINK)

#define isDragProcess (! (getPressedSlot isequalto widgetNull))

#define isHandDrag ((getSlotId(getPressedSlot) in [INV_HAND_L,INV_HAND_R]) && !isContainerSlot(getPressedSlot))

#define onPressSlot(slotwid) [slotwid] call inventory_onPressSlot

#define onReleaseSlot(zone) [zone] call inventory_onReleaseSlot

//other

#define getSlotId(wid) (wid getvariable "slotid")

#define getSlotIcon(wid) (wid getVariable "icon")

#define getSlotDirtOverlay(wid) (wid getvariable "dirtOverlay")

//Вот это раскомментить для текстовых названий иконок (но нужно доделывать)
//#define widgetSetPicture inventory_widgetSetPicture

#define getSlotBackground(wid) (wid getVariable "background")

#define getSlotName(wid) (wid getVariable "slotname")

#define isEmptySlot(id) ((inventory_slotdata select (id)) isequalto [])

#define isEmptyWidget(wid) isEmptySlot(getSlotId(wid))

#define getSlotDataById(id) ((id) call inventory_getSlotDataById)

#define getPressedSlotPosition inventory_pressedSlotPosition
#define setPressedSlotPosition(pos) inventory_pressedSlotPosition = (pos)

#define isInsidePressedSlot inventory_isInsidePressedSlot

#define getVerbMenuWidget (inventory_verbMenuWidgets select 0)
//название данной функции заменено, потому что isInsideVerbMenu уже определён в Interactions
#define isInsideVerbMenu_inv (getVerbMenuWidget call isMouseInsideWidget)
#define isOpenedVerbMenu (!(getVerbMenuWidget isEqualTo widgetNull))

//container helpers
#define getContainerMainCtg (inventory_containerWidgets select 0)
#define getContainerSlotsCtg (inventory_containerWidgets select 1)
#define getContainerNameText (inventory_containerWidgets select 2)

// internal macro for inventory::containerCommonData
	#define container_index_name 0
	#define container_index_ref 1
	#define container_index_object 2
	#define container_index_posoffset 3
	//assoc with container_index_object
	#define container_index_isInWorld container_index_object
	//this does not used
	#define container_object_awaitGenerateValue -1

#define getWorldContainer (inventory_containerCommonData select container_index_object)
#define getContainerRef (inventory_containerCommonData select container_index_ref)
#define getContainerPosOffset (inventory_containerCommonData select container_index_posoffset)
#define setContainerPosOffset(val) inventory_containerCommonData set [container_index_posoffset,val]
#define isWorldContainer (getWorldContainer isEqualType objnull)


#define isContainerSlot(slot) (slot getVariable ["isContainerSlot",false])

#define nullContainerCommonData ["","","none",[0,0,0]]
#define nullPostionPreviewObject [0,0,0]

//self widgets
#define SELF_CTG_SIZE_H 5
#define getSelfCtg (inventory_selfWidgets select 0)
#define setSelfCtg(wid) inventory_selfWidgets set [0,wid]

#define getSelfCtgText (inventory_selfWidgets select 1)
#define setSelfCtgText(wid) inventory_selfWidgets set [1,wid]

//timing protection
#define TIME_TO_RELOAD_EXTRAACTION 0.8
#define TIME_TO_RELOAD_ALTCLICKACTION 0.8

//hiding inventory
#define INV_HIDE_UPDATE_DELAY 0.1
#define INV_HIDE_PERUPDATE_DELAY 0.09


//extended logging

#ifdef RELEASE
	#undef INVENTORY_LOG
#endif

#ifdef INVENTORY_LOG

	#define invlog(mes,ft) logformat(mes,ft)

#else

	#define invlog(mes,ft)

#endif