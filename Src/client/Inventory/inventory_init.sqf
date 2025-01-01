// ======================================================
// Copyright (c) 2017-2025 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include "..\WidgetSystem\widgets.hpp"
#include "..\..\host\engine.hpp"
#include "..\..\host\text.hpp"
#include "inventory.hpp"

#define PIC_PATH(name) (PATH_PICTURE_FOLDER + "inventory\" + name + ".paa")
#define TEMP_ITEM_ICON PIC_PATH("items\temp_item")

#include <..\Interactions\interact_component_shared.hpp>

#include <..\Interactions\interact.hpp>

//#define UNIT_TEST_ITEM

//ассоциатор путей до картинок
inventory_sloticons_default = [
	PIC_PATH("back"),
	PIC_PATH("armor"),
	PIC_PATH("head"),
	PIC_PATH("shoulder"),
	PIC_PATH("cloth"),
	PIC_PATH("face"),
	PIC_PATH("hand_l"),
	PIC_PATH("belt_r"),
	PIC_PATH("hand_r")
];

inventory_const_dirtOverlayIcon = PIC_PATH("dirt_overlay");
inventory_const_partkeyToSlots = [
	["bd",[INV_BACKPACK,INV_BACK,INV_CLOTH,INV_BELT,INV_ARMOR]],
	["hd",[INV_HEAD,INV_FACE]],
	["lh",INV_HAND_L],
	["rh",INV_HAND_R]
];

inventory_slotdataDirt = inventory_const_partkeyToSlots apply {[_x select 0,1]};

invenotry_commitNowAllGerms = false;//используется для быстрого применения грязи при открытии инвентаря

inventory_openModeSlotsId = [INV_BACKPACK,INV_ARMOR,INV_HEAD,INV_BACK,INV_CLOTH,INV_FACE,INV_BELT];

private _invSize = count inventory_sloticons_default;

inventory_slotnames_default = INV_LIST_SLOTNAMES;

inventory_slotpos_map = [
	[-1,-2],
	[0,-2],
	[1,-2],
	[-1,-1],
	[0,-1],
	[1,-1],
	[-1,0],
	[0,0],
	[1,0]
];

inventor_slot_widgets = [];
inventor_slot_widgets resize _invSize;

private _inventory_slotdata = [];
_inventory_slotdata resize _invSize;
inventory_slotdata = _inventory_slotdata apply {[]};

isInventoryOpen = false;

inventory_modifierScroll = false;//множитель прокручивания при нажатом шифте

//common flags and other info
inventory_pressedwidget = [widgetNull,widgetNull];
inventory_pressedSlotPosition = [0,0];
inventory_isInsidePressedSlot = false; //На данный момент (Legacy - 0.5.148) данная переменная только устанавливает значения, но не использует их.

inventory_invWidgetSize = [0,0,0,0];

inventory_verbMenuWidgets = [widgetNull];
inventory_lastPressedSlotId = -1; //нигде не используется?
inventory_verbItemPointer = "";

//inventory_protectExtraAction = false;
inventory_protectAltClick = false;

inventory_containerCommonData = nullContainerCommonData;//name,ref,local game object
inventory_containerData = [];// check SD_<var>
inventory_isOpenContainer = false;
inventory_containerWidgets = [widgetNull,widgetNull];//0 - ctg,1 - ctgScroll
inventory_containerSlots = [];//список виджетов иконок внутри контейнера
inventory_freeSpaceSlots = [];//список виджетов свободного места
inventory_contWidgetSize = [0,0,0,0];

inventory_isPressedRMBDrag = false; //для защиты драга пкмом
inventory_isPressedInteractButton = false; //специальный модификатор интерации

inventory_isOutsideDragCatch = false; //указатель защиты от main action при условии: mouseDown > move outside current slot > move inside current

inventory_supressInventoryOpen = false; //подавляет открытие инвентарных функций. работает для ПКМ по предмету

inventory_lastFocusedWidget = [widgetNull]; //последний в фокусе для увеличения

//Скрывает инвентарь
inventory_canHideHands = false;
	inventory_isFullHide = false;
	inventory_hideAfter = 10;
	inventory_hideValue = 0;
	inventory_hideTimestamp = -1;
	inventory_hideHandler = -1;

//Инвентарь по удержанию
inventory_isHoldMode = false;

//Селф окно
inventory_selfWidgets = [widgetNull,widgetNull]; //0 ctg,1 text

#include "functions.sqf"
#include "PreviewObject.sqf"
#include "verbs.sqf"
#include "container.sqf"

call inventory_init;

#ifdef UNIT_TEST_ITEM

	[INV_HAND_L,["Штучка",TEMP_ITEM_ICON,"noptr"]] call inventory_onSlotUpdate

#endif
