// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
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

//функция принудительно отписывает клиента с его загруженных зон. функция исключительно для отладки
noe_forceChunksUnsubscribe = {
	params ["_client","_mob"];

	private _pos = getPosATL _mob;
	private _chunk = null;
	private _chunkPos = [0,0,0];
	private _owners = null;
	private _ownIndx = -1;
	{
		private _listCh = [];
		_chunkPos = [_pos,_x] call noe_posToChunk;
		[_listCh,_chunkPos,_x] call noe_collectAroundChunks;
		{
			_chunk = _x call noe_getChunkObject;
			_owners = chunk_getOwners(_chunk);
			_ownIndx = _owners find _client;
			if (_ownIndx == -1) then {
				errorformat("noe::forceChunksUnsubscribe() - cant find client %1 in chunk %2 (typeid:%3)",_client arg _chunkPos arg _x);
				["noe::forceChunksUnsubscribe() - cant find client %1 in chunk %2 (typeid:%3)",_client arg _chunkPos arg _x] call logError;
			} else {
				_owners deleteAt _ownIndx;
			};
		} foreach _listCh;
	} foreach noe_allChunkTypes;
};