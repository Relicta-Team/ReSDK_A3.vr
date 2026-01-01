// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include "..\WidgetSystem\widgets.hpp"
#include "..\..\host\engine.hpp"
#include "..\..\host\text.hpp"
#include "inventory.hpp"

namespace(Inventory,inventory_)

macro_func(inventory_picturePatch,string(string))
#define PIC_PATH(name) (PATH_PICTURE_FOLDER + "inventory\" + name + ".paa")
macro_const(inventory_tempItemIcon)
#define TEMP_ITEM_ICON PIC_PATH("items\temp_item")

#include <..\Interactions\interact_component_shared.hpp>

#include <..\Interactions\interact.hpp>

//#define UNIT_TEST_ITEM

//ассоциатор путей до картинок
decl(string[])
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

decl(string)
inventory_const_dirtOverlayIcon = PIC_PATH("dirt_overlay");
decl(any[])
inventory_const_partkeyToSlots = [
	["bd",[INV_BACKPACK,INV_BACK,INV_CLOTH,INV_BELT,INV_ARMOR]],
	["hd",[INV_HEAD,INV_FACE]],
	["lh",INV_HAND_L],
	["rh",INV_HAND_R]
];

decl(any[])
inventory_slotdataDirt = [];

inventory_slotdataDirt = inventory_const_partkeyToSlots apply {[_x select 0,1]};

decl(bool)
inventory_commitNowAllGerms = false;//используется для быстрого применения грязи при открытии инвентаря

decl(int[])
inventory_openModeSlotsId = [INV_BACKPACK,INV_ARMOR,INV_HEAD,INV_BACK,INV_CLOTH,INV_FACE,INV_BELT];

private _invSize = count inventory_sloticons_default;

decl(string[])
inventory_slotnames_default = INV_LIST_SLOTNAMES;

decl(vector2[])
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

decl(widget[])
inventor_slot_widgets = [];

decl(any[])
inventory_slotdata = [];

inventor_slot_widgets resize _invSize;

private _inventory_slotdata = [];
_inventory_slotdata resize _invSize;
inventory_slotdata = _inventory_slotdata apply {[]};

decl(bool)
isInventoryOpen = false;

decl(bool)
inventory_modifierScroll = false;//множитель прокручивания при нажатом шифте

//common flags and other info
decl(widget[])
inventory_pressedwidget = [widgetNull,widgetNull];
decl(vector2)
inventory_pressedSlotPosition = [0,0];
decl(bool)
inventory_isInsidePressedSlot = false; //На данный момент (Legacy - 0.5.148) данная переменная только устанавливает значения, но не использует их.

decl(vector4)
inventory_invWidgetSize = [0,0,0,0];

decl(widget[])
inventory_verbMenuWidgets = [widgetNull];
decl(int)
inventory_lastPressedSlotId = -1; //нигде не используется?
decl(string)
inventory_verbItemPointer = "";

//inventory_protectExtraAction = false;
decl(bool)
inventory_protectAltClick = false;

decl(any[])
inventory_containerCommonData = nullContainerCommonData;//name,ref,local game object
decl(any[])
inventory_containerData = [];// check SD_<var>
decl(bool)
inventory_isOpenContainer = false;
decl(widget[])
inventory_containerWidgets = [widgetNull,widgetNull];//0 - ctg,1 - ctgScroll
decl(widget[])
inventory_containerSlots = [];//список виджетов иконок внутри контейнера
decl(widget[])
inventory_freeSpaceSlots = [];//список виджетов свободного места
decl(vector4)
inventory_contWidgetSize = [0,0,0,0];

decl(bool)
inventory_isPressedRMBDrag = false; //для защиты драга пкмом
decl(bool)
inventory_isPressedInteractButton = false; //специальный модификатор интерации

decl(bool)
inventory_isOutsideDragCatch = false; //указатель защиты от main action при условии: mouseDown > move outside current slot > move inside current

decl(bool)
inventory_supressInventoryOpen = false; //подавляет открытие инвентарных функций. работает для ПКМ по предмету

decl(widget[])
inventory_lastFocusedWidget = [widgetNull]; //последний в фокусе для увеличения

//Скрывает инвентарь
decl(bool)
inventory_canHideHands = false;
	decl(bool)
	inventory_isFullHide = false;
	decl(float)
	inventory_hideAfter = 10;
	decl(float)
	inventory_hideValue = 0;
	decl(float)
	inventory_hideTimestamp = -1;
	decl(float)
	inventory_hideHandler = -1;

//Инвентарь по удержанию
decl(bool)
inventory_isHoldMode = false;

//Селф окно
decl(widget[])
inventory_selfWidgets = [widgetNull,widgetNull]; //0 ctg,1 text

#include "functions.sqf"
#include "PreviewObject.sqf"
#include "verbs.sqf"
#include "container.sqf"

call inventory_init;

#ifdef UNIT_TEST_ITEM

	[INV_HAND_L,["Штучка",TEMP_ITEM_ICON,"noptr"]] call inventory_onSlotUpdate

#endif
