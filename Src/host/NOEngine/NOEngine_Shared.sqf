// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================


//Конвертирует мировые координаты в позицию чанка
noe_posToChunk = {
	params ["_pos","_chunkType"];

	_pos params ["_x","_y"];

	private _chunkSize = getChunkSizeByType(_chunkType);

	[
		floor(_x / _chunkSize) + startChunkIndex,
		floor(_y / _chunkSize) + startChunkIndex
	]
};

//Конвертирует позицию чанка в мировые координаты. Координата z всегда 0
noe_chunkToPos = {
	params ["_chunk","_chunkType"];

	_chunk params ["_chunkX","_chunkY"];
	private _chunkSize = getChunkSizeByType(_chunkType);

	[(_chunkX - startChunkIndex) * _chunkSize,(_chunkY - startChunkIndex) * _chunkSize,0]
};


noe_collectAroundChunks = {
	params ["_loadList","_chunk","_chunkType"];

	_loadList pushBackUnique [_chunk,_chunkType];

	{
		_loadList pushBackUnique [(_chunk vectorAdd _x) select [0,2],_chunkType];
	} foreach [[1,0],[1,1],[0,1],[-1,1],[-1,0],[-1,-1],[0,-1],[1,-1]];
};
