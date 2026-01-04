// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================


#include "..\..\host\lang.hpp"

namespace(InteractCombat,interactCombat_)

//ключи для комбат стилей
enum(CombatStyleMapIndex,CS_MAP_INDEX_)
#define CS_MAP_INDEX_TEXT 0
#define CS_MAP_INDEX_COLOR 1
#define CS_MAP_INDEX_ENUM 2
#define CS_MAP_INDEX_TEXT_RANGED 3
enumend

//ссылки на массив в interactCombat_curWidgets
inline_macro
#define curWidgets interactCombat_curWidgets

enum(CombatModeCurrentIndex,CM_CUR_IND_)
#define CM_CUR_IND_ATT 0
#define CM_CUR_IND_DEF 1
#define CM_CUR_IND_CS 2
enumend

//высота комбат меню
macro_const(interactCombat_combatStyleMenuSizeH)
#define CS_SIZE_H 25
//ширина
macro_const(interactCombat_combatStyleMenuSizeW)
#define CS_SIZE_W 30

macro_const(interactCombat_timeToLoadInteractCombat)
#define TIME_TOLOAD_INTERACTCOMBAT 0.05
macro_const(interactCombat_timeToUnloadInteractCombat)
#define TIME_TOUNLOAD_INTERACTCOMBAT 0.2


enum(CombatFadeButtonValue,FADE_BUT_)
#define FADE_BUT_AT 0.7
#define FADE_BUT_DEF 0.7
#define FADE_BUT_CS 0.8
enumend

enum(CombatTimeButtonValue,TIME_BUT_)
#define TIME_BUT_AT 0.1
#define TIME_BUT_DEF 0.1
#define TIME_BUT_CS 0.1
enumend