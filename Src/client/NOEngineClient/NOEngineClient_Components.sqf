// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\host\lang.hpp>

namespace(NOEngine.Client.Components,noe_client_)

/*

			 === FUNCTIONS ===

*/
decl(bool(vector2;int))
noe_client_isChunkCreated = {
	params ["_chunk","_type"];
	!isNull(getChunk(getChunkStorage(_type),str _chunk))
};

//получает временную отметку чанка. Если чанк не существует - создаёт его
decl(float(vector2;int))
noe_client_GetChunkLastUpdate = {
	chunk_getLastTicktimeUpdate(_this call noe_client_getPosChunkToData)
};

//Получает объект чанка с информацией
decl(any(vector2;int))
noe_client_getPosChunkToData = {
	params ["_chunk","_type"];
	
	private _ch = getChunkData(_chunk,_type);
	//точка создания несуществующих чанков здесь!
	if isNullVar(_ch) then {
		_ch = allocChunk(str [_chunk arg _type]);
		initChunkData(_type,_chunk,_ch);
	};
	
	_ch
};


/*

			 === loaders ===

*/


decl(thread_handle[])
noe_client_threadList = [];

//Производит спавн объектов
//_spawnObjList - массив обновления данных. Чанк загружается весь
decl(void(any;any[]))
noe_client_loadObjects = {
	params ["_chunkObject","_spawnObjList"];
	
	private _odata = chunk_getObjectsData(_chunkObject);
	{
		_x params ["_ptr","_data"];
		//здесь мы просто обновляем указатели
		_odata set [_ptr,newODataStorage(_data)]
	} foreach _spawnObjList;
	
	/*#ifdef NOE_CLIENT_THREAD_DEBUG
		__thd =
	#else
		//noe_client_threadList pushBack
	#endif
	  ([_chunkObject] spawn {
		#ifdef NOE_CLIENT_THREAD_DEBUG
		scriptName "load_objs";
		#endif*/
		private _stamp = tickTime;
		//_chunkObject = _this select 0;
		//объекты загружаются все что сохранены у клиента
		private _chunkObjData = chunk_getObjectsData(_chunkObject); //as hash
		
		chunk_setProgress(_chunkObject,CHUNK_PROGRESS_PROCESSED);
		
		//_doDispose = false;
		//_spawnedObjects = [];
		{
			/*if (chunk_getLoadingState(_chunkObject) != CHUNK_STATE_LOADED) exitWith {
				_doDispose = true;
			};*/
			//_y as [GObject null,Array data]
			//_spawnedObjects pushBack 
			(_y call noe_client_spawnObject);
			//uiSleep (15 / diag_fps);
		} foreach _chunkObjData; //keyval pair
		
		//поточная защита от мертвых объектов
		/*if (_doDispose) exitWith {
			
			chunk_setProgress(_chunkObject,CHUNK_PROGRESS_NOTLOADED);
			{[_x] call vs_unloadWorldRadio; true} count _spawnedObjects;
			_disposeThread = _spawnedObjects spawn {
				#ifdef NOE_CLIENT_THREAD_DEBUG
				scriptName "prot_disp_objs";
				#endif
				{
					deleteVehicle _x;
					stdDelayDelete();//(0.01); //fixed timeout to delete
				} foreach _this;
			};
			//noe_client_threadList deleteat (noe_client_threadList find _thisScript);
		};*/
		
		chunk_setProgress(_chunkObject,CHUNK_PROGRESS_LOADED);
		
		//noe_client_threadList deleteat (noe_client_threadList find _thisScript);
		#ifdef DEBUG_MESSAGE_NOE
		traceformat("Process load chunk done by %1 sec",tickTime - _stamp);
		#endif
	//});
	
	/*#ifdef NOE_CLIENT_THREAD_DEBUG
		//noe_client_threadList pushBack __thd;
		noe_debug_allthreads pushBack __thd;
	#endif*/
};

//проверят созданы ли все объекты в чанке
decl(bool(any))
noe_client_isObjectsLoadingDone = {
	params ["_chunk"];
	chunk_getProgress(_chunk) == CHUNK_PROGRESS_LOADED
};	

//проверяет загружены ли все объекты чанков в которых позиционируется игрок
decl(bool())
noe_client_isPlayerPositionChunksLoaded = {
	FHEADER;
	private _ppos = getPosATL player;
	{
		if !([[[_ppos,_x] call noe_posToChunk,_x] call noe_client_getPosChunkToData] call noe_client_isObjectsLoadingDone) then {
			RETURN(false);
		};
	} foreach noe_client_allChunkTypes;
	
	RETURN(true);
};


