// ======================================================
// Copyright (c) 2017-2024 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================


//size one chunk in meters and half (only constexpr)
#define ATMOS_SIZE 1
#define ATMOS_SIZE_HALF 0.5

//начальное число с которого начинается отсчёт позиций
#define ATMOS_START_INDEX 1

//частота обновления основного треда
#define ATMOS_MAIN_THREAD_UPDATE_DELAY 1

//left, right, top, bottom, front, back
#define ATMOS_SPREAD_MAX_COUNT 6

#define ATMOS_POS_INSIDE_CHUNK(_p,_chunkPos) ((_p) inArea [_chunkPos, ATMOS_SIZE, ATMOS_SIZE, 0, true, ATMOS_SIZE])