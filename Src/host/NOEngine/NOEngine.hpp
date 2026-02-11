// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

//shared header

#include <NOEngine_SharedTransportLevel.hpp>

#define CHUNK_TYPE_ITEM 0
#define CHUNK_TYPE_STRUCTURE 1
#define CHUNK_TYPE_DECOR 2

//расстояния указаны в диаметре. Т.е. если chunkSize_decor == 10 то радиус 5
//Внимание!!! не указывать значения меньше 1
//std dists: 60,35,15

// size for non-interactible objects
#define chunkSize_decor 65

//size for interactible objects
#define chunkSize_structure 30

//size for small items
#define chunkSize_item 10


/*
	CHUNK COUNT:

	client chunk + 3(left) => max 4

	NOW DOES NOT USED
*/
#define chunkZoneSize_decor 3
#define chunkZoneSize_structure 2
#define chunkZoneSize_item 0


//частота обновления основного треда
#define mainThreadUpdateDelay 1.1
//дополнительная задержка проверки остальных типов чанков.
	//Для items: delay + mult;
	//struct: delay + (mult *2);
	//decor: delay + (mult *3)
#define mainThreadUpdateMultiplier 0.3

/*

	GROUP: INTERNAL MACRO

*/
//внутренние псевдонимы
#define chunkType_decor CHUNK_TYPE_DECOR
#define chunkType_structure CHUNK_TYPE_STRUCTURE
#define chunkType_item CHUNK_TYPE_ITEM

//Получает размер одного чанка по типу
#define getChunkSizeByType(type) ([chunkSize_item,chunkSize_structure,chunkSize_decor] select type)

//начальное число с которого начинается отсчёт чанков
#define startChunkIndex 1
