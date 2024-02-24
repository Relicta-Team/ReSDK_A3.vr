// ======================================================
// Copyright (c) 2017-2024 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================



//noe_tdch = [false,[]];

// Регистрируем карту чанков

//содержит список типов чанков
noe_chunkTypes = createHashMap;
noe_allChunkTypes = [CHUNK_TYPE_ITEM,CHUNK_TYPE_STRUCTURE,CHUNK_TYPE_DECOR];


{
	_ch = createHashMap;
	noe_chunkTypes set [_x,_ch];
} forEach noe_allChunkTypes;



//Получает объект чанка. Если нет - создаёт
noe_getChunkObject = {
	params ["_chpos","_cht"];
	
	private _ch = getChunkStorage(_cht); //получаем хранилище чанков
	
	//Вносим объект в массив
	private _chdata = getChunk(_ch,str _chpos);
	if isNullVar(_chdata) then {
		_chdata = allocChunk;
		registerChunk(_ch,str _chpos,_chdata);
	};	
	
	_chdata
};