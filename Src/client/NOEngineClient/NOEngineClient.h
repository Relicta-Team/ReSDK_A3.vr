// ======================================================
// Copyright (c) 2017-2025 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================


//#define DEBUG_MESSAGE_NOE

//packets

#define PACKET_LIFETIME 15

#define pushPacketId(id) noe_client_packets pushBack id
#define popPacketId(id) call{ private _idx = noe_client_packets find id; \
	if (_idx!=-1) then { \
		noe_client_packets deleteAt _idx; \
		noe_client_packetsChunks deleteAt (str id); \
		true} else {false}}

// common macro

#define chunk_loadingState 0
#define chunk_lastupdate 1  
#define chunk_objectsData 2
#define chunk_name 3
#define chunk_progress 4
#define chunk_lastdelete 5

	#define CHUNK_STATE_NOT_LOADED 0
	#define CHUNK_STATE_AWAIT_RESPONSE 1
	#define CHUNK_STATE_LOADED 2

	#define CHUNK_PROGRESS_NOTLOADED 0
	#define CHUNK_PROGRESS_PROCESSED 1
	#define CHUNK_PROGRESS_LOADED 2

//! не изменять значение chunk_lastupdate иначе сломается IStructNonReplicate
#define allocChunk(data) [CHUNK_STATE_NOT_LOADED,0,createHashMap,data,CHUNK_PROGRESS_NOTLOADED,0]

#define registerChunk(ch,pos,buf) ch set [pos,buf]

#define getChunkStorage(type) (noe_client_cs get type)
#define getChunk(chs,pos) (chs get (pos))

// фаст универсалка для получения чанка
#define getChunkData(pos,type) getChunk(getChunkStorage(type),str pos)
#define initChunkData(type,pos,alloc) getChunkStorage(type) set [str pos,alloc]

#define chunk_setLoadingState(chunk,state) (chunk) set [chunk_loadingState,state]
#define chunk_getLoadingState(chunk) ((chunk) select chunk_loadingState)

#define chunk_getLastTicktimeUpdate(chunk) ((chunk) select chunk_lastupdate)
#define chunk_setLastTicktimeUpdate(chunk,time) (chunk) set [chunk_lastupdate,time]


#define chunk_getObjectsData(chunk) ((chunk) select chunk_objectsData)
	//указатель на модель
	#define chunk_objectData_ptr 0
	//полные данные объекта
	#define chunk_objectData_transform 1

#define chunk_getName(chunk) ((chunk) select chunk_name)

#define chunk_getProgress(chunk) ((chunk) select chunk_progress)
#define chunk_setProgress(chunk,state) (chunk) set [chunk_progress,state]

#define chunk_getLastTicktimeDelete(chunk) ((chunk) select chunk_lastdelete)
#define chunk_setLastTicktimeDelete(chunk,time) (chunk) set [chunk_lastdelete,time]

#define chunk_parseNameToPosAndType(ch) (parseSimpleArray (ch))

#define newODataStorage(data) [objnull,data]

//стандартная поточная задержка при удалении
#define stdDelayDelete() uiSleep (2 / diag_fps)