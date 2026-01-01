// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

//быстрое процессирование симуляции
//#define ATMOS_DEBUG_USE_FAST_SIM
//тест только одной стороны распространения
//#define ATMOS_DEBUG_TEST_SIDE_SPREAD [0,1,0]

#ifndef EDITOR
	#undef ATMOS_DEBUG_USE_FAST_SIM
	#undef ATMOS_DEBUG_TEST_SIDE_SPREAD
#endif

//turn on if you want simple visualization of chunks (only one particle type per chunk)
//#define ATMOS_MODE_SIMPLE_VISUALIZATION

//prerelease optimize
#define ATMOS_MODE_FORCE_OPTIMIZE
//this value decremented on instance copy of object
#define ATMOS_MODE_SPREAD_FORCE_OPTIMIZE 6

//начальное число с которого начинается отсчёт позиций
#define ATMOS_START_INDEX 1

//size one chunk in meters and half (only constexpr in prod. required)
#define ATMOS_SIZE 1
#define ATMOS_SIZE_HALF 0.5
#define ATMOS_SIZE_HALF_OFFSET 0.1

// одна зона = 10 чанков
#define ATMOS_AREA_SIZE 10

#ifdef EDITOR
	#define ATMOS_RPC_SERVER_REQUEST_AREA "atmos_request_area"
	#define ATMOS_RPC_SERVER_DELETE_EXPIRED_CHUNKS "atmos_delete_expired"
	#define ATMOS_RPC_CLIENT_UPDATE_CHUNK "atmos_update_chunk"
	#define ATMOS_RPC_CLIENT_UNSUBSCRIBE_LISTEN_CHUNK "atmos_unsub_area"
#else
	#define ATMOS_RPC_SERVER_REQUEST_AREA "salr"
	#define ATMOS_RPC_SERVER_DELETE_EXPIRED_CHUNKS "sald"
	#define ATMOS_RPC_CLIENT_UPDATE_CHUNK "cuar"
	#define ATMOS_RPC_CLIENT_UNSUBSCRIBE_LISTEN_CHUNK "cdar"
#endif

//left, right, top, bottom, front, back
#define ATMOS_PROPAGATION_SIDE_MAX_COUNT 6

#define ATMOS_ADDITIONAL_RANGE_XY rand(-0.25, 0.25)
#define ATMOS_ADDITIONAL_RANGE_Z rand(-0.1, 0.1)

//режим поиска для atmos_getIntersectInfo
// Получение количества пересечений
#define ATMOS_SEARCH_MODE_GET_COUNT 0
// поиск до первого пересечения
#define ATMOS_SEARCH_MODE_FIRST_INTERSECT 1
// поиск до первого отсутствия пересечения
#define ATMOS_SEARCH_MODE_NO_INTERSECT 2
// получение виртуальных объектов на пересечении
#define ATMOS_SEARCH_MODE_GET_VOBJECTS 3


// Типы распространения. Нормальный тип это 4 стороны от центра, +1z,-1z
#define ATMOS_SPREAD_TYPE_NORMAL 0
#define ATMOS_SPREAD_TYPE_NORMAL_XY_ANGLES 1
#define ATMOS_SPREAD_TYPE_NO_Z 2