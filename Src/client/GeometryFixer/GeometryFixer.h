// ======================================================
// Copyright (c) 2017-2025 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================


//#define GEOMETRY_FIXER_TRACE_POSITIONS

//расстояние сохранения позиций
#define GEOMETRY_FIXER_DISTANCE_SAVE_POSITION 1

//Если за отведённое время в падении расстояние с начала падения не дальше этого то вернём персонажа назад
#define GEOMETRY_FIXER_DISTANCE_TO_RESET_POSITION 1

// Частота обновления проверки геометрии
#define GEOMETRY_FIXER_UPDATE_DELAY 0

#define GEOMETRY_FIXER_FALLING_TIMEOUT 0.6

//Если позиция в режиме падения не сменится 4 раза то возвращаем 
//#define GEOMETRY_FIXER_COUNT_FALLING_CHECK 4

#define __falling_animation_prefix__ "afal"
#define __handler_falling_animation(state_value) ((state_value select [0,4]) == __falling_animation_prefix__)

#define isInFallingAnimation(mob) __handler_falling_animation(animationState mob)
#define isOnGround(mob) (isTouchingGround mob)
#define getLastSavedPos() (gf_lastPositions select 2)
#define getSavedPosAtIndex(idx) (gf_lastPositions select idx)
#define getDistance(from,to) (from distance to)


#ifdef RELEASE
#undef GEOMETRY_FIXER_TRACE_POSITIONS
#endif