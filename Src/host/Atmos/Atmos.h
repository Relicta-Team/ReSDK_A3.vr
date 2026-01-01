// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#define ATMOS_USE_UPDATE_BUFFER

#define ATMOS_TYPEID_FIRE 0
#define ATMOS_TYPEID_GAS 1
#define ATMOS_TYPEID_WATER 2

//частота обновления основного треда
#define ATMOS_MAIN_THREAD_UPDATE_DELAY 0.1

#define ATMOS_POS_INSIDE_CHUNK(_p,_chunkPos) ((_p) inArea [_chunkPos, ATMOS_SIZE_HALF, ATMOS_SIZE_HALF, 0, true, ATMOS_SIZE_HALF])

//subscribers for chunk update
#define ATMOS_AREA_INDEX_CLIENTS 0
//list of all chunks in area
#define ATMOS_AREA_INDEX_CHUNKS 1
//timestamp of last update area
#define ATMOS_AREA_INDEX_LASTUPDATE 2
//timestamp of last delete inside area
#define ATMOS_AREA_INDEX_LASTDELETE 3

//буффер изменений для следующей отправки
#define ATMOS_AREA_INDEX_UPDATE_BUFFER 4
//отметка последнего рассыла обновлений буфера
#define ATMOS_AREA_INDEX_LASTSEND_BUFFER 5


#define ATMOS_AREA_INDEX_AREAID 6

#define ATMOS_AREA_NEW [[], [], 0, 0 , createHashMap, 0, _aid]


#define ATMOS_SEND_DELAY_BUFFER 1