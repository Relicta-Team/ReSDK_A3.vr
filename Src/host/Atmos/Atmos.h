// ======================================================
// Copyright (c) 2017-2024 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

//начальное число с которого начинается отсчёт позиций
#define ATMOS_START_INDEX 1

//частота обновления основного треда
#define ATMOS_MAIN_THREAD_UPDATE_DELAY 1

#define ATMOS_POS_INSIDE_CHUNK(_p,_chunkPos) ((_p) inArea [_chunkPos, ATMOS_SIZE_HALF, ATMOS_SIZE_HALF, 0, true, ATMOS_SIZE_HALF])

