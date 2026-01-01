// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\bitflags.hpp>

// Bitflags for clothing parts.
#define HEAD        0x1
#define FACE        0x2
#define EYES        0x4
#define UPPER_TORSO 0x8
#define LOWER_TORSO 0x10
#define TORSO 0x18
#define LEG_LEFT    0x20
#define LEG_RIGHT   0x40
#define LEGS        0x60   /*  LEG_LEFT | LEG_RIGHT*/
/*#define FOOT_LEFT   0x80
#define FOOT_RIGHT  0x100
#define FEET        0x180  // FOOT_LEFT | FOOT_RIGHT*/
#define ARM_LEFT    0x200
#define ARM_RIGHT   0x400
#define ARMS        0x600 /*  ARM_LEFT | ARM_RIGHT*/
/*#define HAND_LEFT   0x800
#define HAND_RIGHT  0x1000
#define HANDS       0x1800 // HAND_LEFT | HAND_RIGHT*/
#define GROIN 0x2000
#define NECK 0x4000

#define FULL_BODY   0xFFFF


//associated with INV_...
//Нужно для проверки allowedSlots
// НЕ ИСПОЛЬЗУЕТСЯ
#define SLOT_BACKPACK b_0
#define SLOT_ARMOR b_1
#define SLOT_HEAD b_2
#define SLOT_BACK b_3
#define SLOT_CLOTH b_4
#define SLOT_FACE b_5
#define SLOT_OTHER b_6
#define SLOT_HANDS b_7
#define SLOT_BELT b_8

//Обстоятельства брони
#define ARMOR_NOTE_ONLYFRONT "F" /*Обеспечивает защитой только спереди*/
#define ARMOR_NOTE_DOUBLEDR "D" /*Двойное сп*/
#define ARMOR_NOTE_HIDE "H" /*скрытное ношение*/
#define ARMOR_NOTE_FLEXIBLE "*" /*означает гибкую броню*/]

//Флаги возможности экипировывания предмета
#define EQUIP_HASPART 0x1
#define EQUIP_BLOCKED 0x2 /*заблокировано например другим предметом*/
//TODO продумать, переделать