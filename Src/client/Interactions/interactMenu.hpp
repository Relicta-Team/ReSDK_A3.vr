// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include "..\..\host\lang.hpp"

namespace(InteractMenu,interactMenu_)

#include <..\..\host\CombatSystem\CombatSystem.hpp>

macro_const(interactMenu_sizeHitpartZone)
#define SIZE_HITPART_ZONE 5

macro_func(interactMenu_MapHit,vector4(float;float))
#define map_hit(x,y) [x,y,32,SIZE_HITPART_ZONE]

macro_const(interactMenu_map_zoneNames)
#define map_zonenames ["Голова","Лицо","Рот","Шея","Торс","Живот","Пах"]
macro_const(interactMenu_map_zoneIndex)
#define map_zoneindex [TARGET_ZONE_HEAD,TARGET_ZONE_FACE,TARGET_ZONE_MOUTH,TARGET_ZONE_NECK,TARGET_ZONE_TORSO,TARGET_ZONE_ABDOMEN,TARGET_ZONE_GROIN]

macro_const(interactMenu_map_limbs)
#define map_limbs [TARGET_ZONE_EYE_L,TARGET_ZONE_EYE_R,TARGET_ZONE_ARM_L,TARGET_ZONE_ARM_R,TARGET_ZONE_LEG_L,TARGET_ZONE_LEG_R]

macro_const(interactMenu_callingInDisplayMode)
#define CALLING_IN_DISPLAY_MODE true

macro_const(interactMenu_timeToLoadInteractMenu)
#define TIME_TOLOAD_INTERACTMENU TIME_PREPARE_SLOTS

macro_const(interactMenu_timeToUnloadInteractMenu)
#define TIME_TOUNLOAD_INTERACTMENU TIME_PREPARE_SLOTS

macro_const(interactMenu_fadeInSpecAct)
#define FADEIN_SPECACT 0.7
macro_const(interactMenu_fadeTime)
#define FADE_TIME 0.1

macro_const(interactMenu_fadeForSelected)
#define FADE_FOR_SELECTED 0.6

macro_const(interactMenu_timeToInfade)
#define TIME_TO_INFADE 0.2

//типы действий. ACTION_SWITCHABLE - переключаемое, ACTION_PLAYING - проигрываемое
enum(InteractMenuActionType,ACTION_)
#define ACTION_SWITCHABLE 0
#define ACTION_PLAYING 1
enumend
