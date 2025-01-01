// ======================================================
// Copyright (c) 2017-2025 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================


// !!!Значение нумератора не должно быть меньше нуля!!!
#define LIGHT_FIRE 1
#define LIGHT_CAMPFIRE 2
#define LIGHT_SIGARETTE 3
#define LIGHT_STREETLAMP 4
#define LIGHT_FLASHLIGHT 5
#define LIGHT_CAMPFIRE_BIG 6
#define LIGHT_SIGN_BAR 7
#define LIGHT_SIGN_MEDICAL 8
#define LIGHT_LAMP_CEILING 9
#define LIGHT_LAMP_WALL 10
#define LIGHT_LAMP_KEROSENE 11
#define LIGHT_CANDLE 12
#define LIGHT_LAMP_CEILING_REDLIGHT 13
#define LIGHT_BAKE 14
#define LIGHT_BAKESTOVE 15
#define LIGHT_MATCH 16
// area light configs (starts after 500)
#define LIGHT_AREA_EATER_NIGHTVISION 501
#define LIGHT_AREA_GHOST_NIGHTVISION 502
//trap effect 
#define LIGHT_TRAP_HIDDEN_EFFECT 1000

#define LIGHT_LAMP_CEILING_OLD 90
#define LIGHT_LAMP_WALL_OLD 100

//effects start after 2000
#define EFF_DUST_PARTICLES 2001
#define EFF_DUST_CLOUDS 2002
#define EFF_GREEN_DUST 2003
#define EFF_ROTTEN_HUMAN 2004

//!custom scripted lights in range le_se_cfgRange
#include "ScriptedEffects.hpp"

//firelghts start after 5000 (le_firelight_startindex)
#define FLIGHT_TEST 5001

//shotable effects start only after 10000 (le_shot_startindex)
#define SHOT_MEATSPLAT 10001
#define SHOT_DESTROYLIMB 10002
#define SHOT_BULLET_PISTOL 10003
#define SHOT_BULLET_SHOTGUN 10004
#define SHOT_BULLET_SHOTRIFLE 10005

//visual states start only after 20000
#define VST_EATER_NIGHTVISION 20001
#define VST_HUMAN_STEALTH 20002
#define VST_CLOTH_BREASTPLATE 20003
#define VST_CLOTH_CERAMIC 20004
#define VST_CLOTH_STRONGARMOR 20005
#define VST_CLOTH_METALARMOR 20006
#define VST_CLOTH_FLEXIBLEARMOR 20007
#define VST_GHOST_EFFECT 20008
#define VST_ATTACHED_OBJECTS 20009