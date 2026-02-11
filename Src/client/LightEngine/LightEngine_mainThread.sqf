// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

//! This file not used.

le_lastChunkItem = null;
le_lastChunkStructure = null;

//основной поток обновления
le_onUpdate = {
	_chunksToCheck = [];
	
	//Collecting all chunk types
	{
		_chunkType = _x;
		
		_chunk = [getPosATL player,_chunkType] call dmlExt_posToChunk;
		[_chunksToCheck,_chunk,_chunkType] call le_collectAroundChunks;	
	} foreach le_allChunkTypes;
	
	
	//Checkout all chunks
	/*
		Внутри объекта хранится информация:
			__hash - хэш по которому было вызывано создание света
			
			__light - приаттаченный источник света. Назначается при активации le_loadLight
			
		Внутри источника света хранится информация:
			__config - номер конфига освещения
			
		------------------------------------------------------------------------
		Проход по циклу чанков
			Если gls этого чанка не пустая
				если хэш отличается от последнего локального хэша этого чанка
					обновляем локальный чанк
						проход по циклу объектов
							если указатель конфига на объекте отличается от hash
								если объект есть в старом конфиге
									сравниваем и обновляем свет при необходимости
								или
									удаляем свет
	
	*/
	private _objectInfoListNeed = [];
	#define loadLightOnObject(_x) [_x getVariable "light",_x] call le_loadLight
	#define unloadLightOnObject(_x) [_x] call le_unloadLight
	
	#define __chunkToGLSType() (format["%1:%2:%3",_type,_cx,_cy])
	#define __compareHashesStr() (format["G:%1 -> L:%2",_hash,_localHash])
	
	//#define use_trace_onloadlight 
	
	{
		_x params ["_type","_cx","_cy"];
		_data = getGLSData(_type,_cx,_cy);
		_data = +_data;
		_localData = getLocalGLSData(_type,_cx,_cy);
		_hash = _data select 0;
		_localHash = _localData select 0;
		
		if equals(_localData,glsNull) then {
			if (_hash != "nan") then {
				if (count _data > 1) then {
					{
						loadLightOnObject(_x);
					} foreach getOnlyObjects(_data);
				};
				
				#ifdef use_trace_onloadlight
					traceformat("UPDATE LOCAL - %1; hash %2; data %3",__chunkToGLSType() arg _hash arg _data)
				#endif
				
				setLocalGLSData(_type,_cx,_cy,_data);
			};
		} else {
			
			if not_equals(_hash,_localHash) then {
				
				#ifdef use_trace_onloadlight
					traceformat("DO SYNC: not synced light in chunk %1 - %2",__chunkToGLSType() arg __compareHashesStr())
				#endif
				
				_dataObjects = getOnlyObjects(_data);
				_dataLocalObjects = getOnlyObjects(_localData);
				{
					if equals(_x getVariable ["__light" arg objNUll],objNUll) then {
						loadLightOnObject(_x);
					} else {
						errorformat("LIGHT ALREADY LOADED - EXCEPTION - %1",_x);
					};
				} foreach _dataObjects;
				
				_toRemove = _dataLocalObjects - _dataObjects;
				{
					unloadLightOnObject(_x);
				} foreach _toRemove;
				
				setLocalGLSData(_type,_cx,_cy,_data);
			//} else {trace("hashes equals")
			
			}; //или ничего
		};
		
	} foreach _chunksToCheck; //[[2,389,444]]; //
	
};

le_collectAroundChunks = {
	params ["_loadList","_chunk","_chunkType"];
	
	_loadList pushBackUnique [_chunkType,_chunk select 0,_chunk select 1];
	private _newChunk = [];
	
	{
		_newChunk = _chunk vectorAdd _x;
		_loadList pushBackUnique [_chunkType,_newChunk select 0,_newChunk select 1];
	} foreach [[1,0],[1,1],[0,1],[-1,1],[-1,0],[-1,-1],[0,-1],[1,-1]];
};