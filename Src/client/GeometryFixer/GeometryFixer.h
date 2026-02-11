// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\host\lang.hpp>

namespace(GeometryFixer,gf_)

//#define GEOMETRY_FIXER_TRACE_POSITIONS

//расстояние сохранения позиций
macro_const(gf_distanceSavePosition)
#define GEOMETRY_FIXER_DISTANCE_SAVE_POSITION 1

//Если за отведённое время в падении расстояние с начала падения не дальше этого то вернём персонажа назад
macro_const(gf_distanceToResetPosition)
#define GEOMETRY_FIXER_DISTANCE_TO_RESET_POSITION 1

// Частота обновления проверки геометрии
macro_const(gf_updateDelay)
#define GEOMETRY_FIXER_UPDATE_DELAY 0

//Время падения
macro_const(gf_fallingTimeout)
#define GEOMETRY_FIXER_FALLING_TIMEOUT 0.6

//Если позиция в режиме падения не сменится 4 раза то возвращаем 
//#define GEOMETRY_FIXER_COUNT_FALLING_CHECK 4

inline_macro
#define __falling_animation_prefix__ "afal"
inline_macro
#define __handler_falling_animation(state_value) ((state_value select [0,4]) == __falling_animation_prefix__)

macro_func(gm_isInFallingAnimation,bool(actor))
#define isInFallingAnimation(mob) __handler_falling_animation(animationState mob)
macro_func(gf_isOnGround,bool(actor))
#define isOnGround(mob) (isTouchingGround mob)

macro_func(gf_getLastSavedPos,vector3())
#define getLastSavedPos() (gf_lastPositions select 2)
macro_func(gf_getSavedPosAtIndex,vector3(int))
#define getSavedPosAtIndex(idx) (gf_lastPositions select idx)
inline_macro
#define getDistance(from,to) (from distance to)


#ifdef RELEASE
#undef GEOMETRY_FIXER_TRACE_POSITIONS
#endif