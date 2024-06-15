// ======================================================
// Copyright (c) 2017-2024 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

//быстрое процессирование симуляции
//#define ATMOS_DEBUG_USE_FAST_SIM

#ifndef EDITOR
	#undef ATMOS_DEBUG_USE_FAST_SIM
#endif

//size one chunk in meters and half (only constexpr in prod. required)
#define ATMOS_SIZE 1
#define ATMOS_SIZE_HALF 0.5
#define ATMOS_SIZE_HALF_OFFSET 0.1

//left, right, top, bottom, front, back
#define ATMOS_PROPAGATION_SIDE_MAX_COUNT 6

#define ATMOS_ADDITIONAL_RANGE_XY rand(-0.25, 0.25)
#define ATMOS_ADDITIONAL_RANGE_Z rand(-0.1, 0.1)

//for gases
//распространяется по воздуху. не распространяется если есть препятствие
#define ATMOS_PROPAGATION_AIR 0
//for fire
//может жить и распространяться на объекты. умирает в если нет поверхности
#define ATMOS_PROPAGATION_OBJECTS 1
//спец.режим для огня (собирает ATMOS_SEARCH_MODE_GET_VOBJECTS)
#define ATMOS_PROPAGATION_FIRE 2


//режим поиска для atmos_getIntersectInfo
// Получение количества пересечений
#define ATMOS_SEARCH_MODE_GET_COUNT 0
// поиск до первого пересечения
#define ATMOS_SEARCH_MODE_FIRST_INTERSECT 1
// поиск до первого отсутствия пересечения
#define ATMOS_SEARCH_MODE_NO_INTERSECT 2
// получение виртуальных объектов на пересечении
#define ATMOS_SEARCH_MODE_GET_VOBJECTS 3
