// ======================================================
// Copyright (c) 2017-2025 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\host\CombatSystem\CombatSystem.hpp>

#define SIZE_HITPART_ZONE 5

#define map_hit(x,y) [x,y,32,SIZE_HITPART_ZONE]

#define map_zonenames ["Голова","Лицо","Рот","Шея","Торс","Живот","Пах"]
#define map_zoneindex [TARGET_ZONE_HEAD,TARGET_ZONE_FACE,TARGET_ZONE_MOUTH,TARGET_ZONE_NECK,TARGET_ZONE_TORSO,TARGET_ZONE_ABDOMEN,TARGET_ZONE_GROIN]

#define map_limbs [TARGET_ZONE_EYE_L,TARGET_ZONE_EYE_R,TARGET_ZONE_ARM_L,TARGET_ZONE_ARM_R,TARGET_ZONE_LEG_L,TARGET_ZONE_LEG_R]

#define CALLING_IN_DISPLAY_MODE true

#define TIME_TOLOAD_INTERACTMENU TIME_PREPARE_SLOTS
#define TIME_TOUNLOAD_INTERACTMENU TIME_PREPARE_SLOTS

#define FADEIN_SPECACT 0.7
#define FADE_TIME 0.1

#define FADE_FOR_SELECTED 0.6
#define TIME_TO_INFADE 0.2

//типы действий. ACTION_SWITCHABLE - переключаемое, ACTION_PLAYING - проигрываемое
#define ACTION_SWITCHABLE 0
#define ACTION_PLAYING 1
