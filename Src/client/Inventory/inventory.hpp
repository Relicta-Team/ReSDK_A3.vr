// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include "..\..\host\lang.hpp"

namespace(Inventory,inventory_)

//Порядок слотов отвечает за их порядок отрисовки в инвентаре

enum(InventorySlotId,INV_)
#define INV_BACKPACK 0
#define INV_ARMOR 1
#define INV_HEAD 2
#define INV_BACK 3
#define INV_CLOTH 4
#define INV_FACE 5
#define INV_HAND_L 6
#define INV_BELT 7
#define INV_HAND_R 8
enumend

macro_const(inventory_listSlotIDHands)
#define INV_LIST_HANDS [INV_HAND_L,INV_HAND_R]
macro_const(inventory_listSlotIDAll)
#define INV_LIST_ALL [INV_BACKPACK, INV_ARMOR, INV_HEAD, INV_BACK,INV_CLOTH,INV_FACE,INV_HAND_L,INV_BELT,INV_HAND_R]
macro_const(inventory_listSlotVarnames)
#define INV_LIST_VARNAME ["INV_BACKPACK","INV_ARMOR","INV_HEAD","INV_BACK","INV_CLOTH","INV_FACE","INV_HAND_L","INV_BELT","INV_HAND_R"]
macro_const(inventory_listSlotNames)
#define INV_LIST_SLOTNAMES ["Спина","Броня","Голова","Плечо","Одеяния","Лицо","Левая рука","Пояс","Правая рука"]

macro_const(inventory_listSlotIdFace)
#define INV_LIST_FACE [INV_HEAD,INV_FACE]
macro_const(inventory_listSlotIdTorso)
#define INV_LIST_TORSO [INV_BACKPACK,INV_BACK,INV_CLOTH,INV_BELT,INV_ARMOR]

enum(SlotDataId,SD_)
#define SD_NAME 0
#define SD_ICON 1
#define SD_POINTER 2
#define SD_MODEL 3
enumend


//default picture path
macro_func(inventory_getItemPicturePath,string(string))
#define PATH_PICTURE_INV(icon) PATH_PICTURE("inventory\items\" + (icon) + ".paa")
