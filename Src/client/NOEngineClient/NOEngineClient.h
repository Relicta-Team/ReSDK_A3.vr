// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\host\lang.hpp>

namespace(NOEngine.Client,noe_client_)

//#define DEBUG_MESSAGE_NOE

//packets
macro_const(noe_client_transportPacketLifetime)
#define PACKET_LIFETIME 15

macro_func(noe_client_pushPacketId,void(int))
#define pushPacketId(id) noe_client_packets pushBack id
macro_func(noe_client_popPacketId,bool(int))
#define popPacketId(id) call{ private _idx = noe_client_packets find id; \
	if (_idx!=-1) then { \
		noe_client_packets deleteAt _idx; \
		noe_client_packetsChunks deleteAt (str id); \
		true} else {false}}

// common macro

enum(ChunkDataIndex,chunk_)
#define chunk_loadingState 0
#define chunk_lastupdate 1  
#define chunk_objectsData 2
#define chunk_name 3
#define chunk_progress 4
#define chunk_lastdelete 5
enumend

	enum(ChunkState,CHUNK_STATE_)
	#define CHUNK_STATE_NOT_LOADED 0
	#define CHUNK_STATE_AWAIT_RESPONSE 1
	#define CHUNK_STATE_LOADED 2
	enumend

	enum(ChunkLoadingProgress,CHUNK_PROGRESS_)
	#define CHUNK_PROGRESS_NOTLOADED 0
	#define CHUNK_PROGRESS_PROCESSED 1
	#define CHUNK_PROGRESS_LOADED 2
	enumend

//! не изменять значение chunk_lastupdate иначе сломается IStructNonReplicate
macro_func(noe_client_allocateChunk,any[](any))
#define allocChunk(data) [CHUNK_STATE_NOT_LOADED,0,createHashMap,data,CHUNK_PROGRESS_NOTLOADED,0]

macro_func(noe_client_registerChunk,void(any;any;any))
#define registerChunk(ch,pos,buf) ch set [pos,buf]

macro_func(noe_client_getChunkStorage,any(int))
#define getChunkStorage(type) (noe_client_cs get type)
macro_func(noe_client_getChunk,any(any))
#define getChunk(chs,pos) (chs get (pos))

// фаст универсалка для получения чанка
macro_func(noe_client_getChunkData,any(vector2;int))
#define getChunkData(pos,type) getChunk(getChunkStorage(type),str pos)
macro_func(noe_client_initChunkData,any(int;vector2;any))
#define initChunkData(type,pos,alloc) getChunkStorage(type) set [str pos,alloc]

macro_func(noe_client_chunkSetLoadingState,void(any;int))
#define chunk_setLoadingState(chunk,state) (chunk) set [chunk_loadingState,state]
macro_func(noe_client_chunkGetLoadingState,int(any))
#define chunk_getLoadingState(chunk) ((chunk) select chunk_loadingState)

macro_func(noe_client_chunkGetLastTicktimeUpdate,float(any))
#define chunk_getLastTicktimeUpdate(chunk) ((chunk) select chunk_lastupdate)
macro_func(noe_client_chunkSetLastTicktimeUpdate,void(any;float))
#define chunk_setLastTicktimeUpdate(chunk,time) (chunk) set [chunk_lastupdate,time]

macro_func(noe_client_chunkGetObjectData,any[](any))
#define chunk_getObjectsData(chunk) ((chunk) select chunk_objectsData)
	
	enum(ChunkObjectDataIndex,chunk_objectData_)
	//указатель на модель
	#define chunk_objectData_ptr 0
	//полные данные объекта
	#define chunk_objectData_transform 1
	enumend

macro_func(noe_client_chunkGetName,string(any))
#define chunk_getName(chunk) ((chunk) select chunk_name)

macro_func(noe_client_chunkGetProgress,int(any))
#define chunk_getProgress(chunk) ((chunk) select chunk_progress)
macro_func(noe_client_chunkSetProgress,void(any;int))
#define chunk_setProgress(chunk,state) (chunk) set [chunk_progress,state]

macro_func(noe_client_chunkGetLastTicktimeDelete,float(any))
#define chunk_getLastTicktimeDelete(chunk) ((chunk) select chunk_lastdelete)
macro_func(noe_client_chunkSetLastTicktimeDelete,void(any;float))
#define chunk_setLastTicktimeDelete(chunk,time) (chunk) set [chunk_lastdelete,time]

macro_func(noe_client_chunkParseNameToPosAndType,any[](string))
#define chunk_parseNameToPosAndType(ch) (parseSimpleArray (ch))

macro_func(noe_client_newODataStorage,any[](any))
#define newODataStorage(data) [objnull,data]

//стандартная поточная задержка при удалении
macro_func(noe_client_stdDelayDelete,void())
#define stdDelayDelete() uiSleep (2 / diag_fps)