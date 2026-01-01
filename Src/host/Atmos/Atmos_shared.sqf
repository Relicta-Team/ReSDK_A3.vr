// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include "Atmos.hpp"

//convert world postion to virtual chunk id
atmos_chunkPosToId = {
	params ["_x","_y","_z"];

	[
		floor(_x / ATMOS_SIZE) + ATMOS_START_INDEX,
		floor(_y / ATMOS_SIZE) + ATMOS_START_INDEX,
		floor(_z / ATMOS_SIZE) + ATMOS_START_INDEX
	]
};

atmos_coordToId = { floor(_this/ATMOS_SIZE)+ATMOS_START_INDEX };

//returns center atl pos of chunk
atmos_chunkIdToPos = {
	params ["_iX","_iY","_iZ"];

	[
		(_iX - ATMOS_START_INDEX) * ATMOS_SIZE,
		(_iY - ATMOS_START_INDEX) * ATMOS_SIZE,
		(_iZ - ATMOS_START_INDEX) * ATMOS_SIZE
	] vectorAdd vec3(ATMOS_SIZE_HALF,ATMOS_SIZE_HALF,ATMOS_SIZE_HALF)
};

//returns area id by world position
atmos_getAreaIdByPos = {
	params ["_x","_y","_z"];
	[
		floor(_x / ATMOS_AREA_SIZE) + ATMOS_START_INDEX,
		floor(_y / ATMOS_AREA_SIZE) + ATMOS_START_INDEX,
		floor(_z / ATMOS_AREA_SIZE) + ATMOS_START_INDEX
	]
};

//returns world pos by areaid
atmos_getPosByAreaId = {
	params ["_x","_y","_z"];
	[
		(_x - ATMOS_START_INDEX) * ATMOS_AREA_SIZE,
		(_y - ATMOS_START_INDEX) * ATMOS_AREA_SIZE,
		(_z - ATMOS_START_INDEX) * ATMOS_AREA_SIZE
	] vectoradd [ATMOS_AREA_SIZE/2,ATMOS_AREA_SIZE/2,ATMOS_AREA_SIZE/2]
};

// Получение локального айди чанка для зоны
atmos_getLocalChunkIdInArea = {
	params ["_chunkX", "_chunkY", "_chunkZ"];

	// Определяем размер области в чанках
	//! пока размер чанков равен 1 метру - тут ничего не менять.
	private _chunksPerArea = ATMOS_AREA_SIZE; //floor(ATMOS_AREA_SIZE / ATMOS_SIZE);

	// Вычисляем локальные координаты чанка в области
	[
		(_chunkX - ATMOS_START_INDEX) mod _chunksPerArea + 1,
		(_chunkY - ATMOS_START_INDEX) mod _chunksPerArea + 1,
		(_chunkZ - ATMOS_START_INDEX) mod _chunksPerArea + 1
	]
};

// Возвращает айди чанка по зоне
atmos_localChunkIdToGlobal = {
    params ["_arId", "_locChId"];
	_arId params ["_areaX", "_areaY", "_areaZ"];
	_locChId params ["_localChunkX", "_localChunkY", "_localChunkZ"];

    // Определяем размер области в чанках
    private _chunksPerArea = ATMOS_AREA_SIZE; //floor(ATMOS_AREA_SIZE / ATMOS_SIZE);

    // Вычисляем начальные координаты области
    private _areaPos = [
        (_areaX - ATMOS_START_INDEX) * _chunksPerArea,
        (_areaY - ATMOS_START_INDEX) * _chunksPerArea,
        (_areaZ - ATMOS_START_INDEX) * _chunksPerArea
    ];

    // Вычисляем глобальные координаты чанка
    private _globalChunkX = (_areaPos select 0) + (_localChunkX);
    private _globalChunkY = (_areaPos select 1) + (_localChunkY);
    private _globalChunkZ = (_areaPos select 2) + (_localChunkZ);

    // Возвращаем глобальный идентификатор чанка
    [_globalChunkX, _globalChunkY, _globalChunkZ]
};

// Преобразование айдичанка в айдизону
atmos_chunkIdToAreaId = {

	params ["_iX", "_iY", "_iZ"];
    
    // Вычисляем позиции чанка
    private _chunkPos = [
        (_iX - ATMOS_START_INDEX) * ATMOS_SIZE,
        (_iY - ATMOS_START_INDEX) * ATMOS_SIZE,
        (_iZ - ATMOS_START_INDEX) * ATMOS_SIZE
    ];

    // Вычисляем идентификатор области, в которую попадает чанк
    private _areaId = [
        floor((_chunkPos select 0) / ATMOS_AREA_SIZE) + ATMOS_START_INDEX,
        floor((_chunkPos select 1) / ATMOS_AREA_SIZE) + ATMOS_START_INDEX,
        floor((_chunkPos select 2) / ATMOS_AREA_SIZE) + ATMOS_START_INDEX
    ];

    _areaId
};

atmos_getAroundAreas = {
	params ["_curAr"];
	private _l = [_curAr];
	{_l pushBack (_curAr vectorAdd _x)} foreach [
		//s,e,w,n
		[1,0,0],
		[-1,0,0],
		[0,1,0],
		[0,-1,0],
		//se,sw,nw,ne
		[1,1,0],
		[-1,1,0],
		[-1,-1,0],
		[1,-1,0],
		//center+1|-1
		[0,0,1],
		[0,0,-1]
	];
	_l
};

//! only for local chunk pos
atmos_encodeChId = {
	params ["_x","_y","_z"];
	(_x - 1) * 100 + (_y - 1) * 10 + (_z - 1) + 1
};

//! returns local chunk pos
atmos_decodeChId = {
	params ["_id"];
	_id = _id - 1;
	private _x = (_id / 100) + 1;
    private _y = ((_id % 100) / 10) + 1;
    private _z = (_id % 10) + 1;
	[floor _x,floor _y,floor _z]
};

atmos_decodeChIdAt = {
	params ["_id","_posIdx"];
	(_id call atmos_decodeChId) select _posIdx
};