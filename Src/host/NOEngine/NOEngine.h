// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================


//Альтернативный алгоритм ищи тут: Legacy - 0.6.198

//индексы инфомрации о чанке: массив владельцев, последняя метка обновления, список объектов
#define chunk_owners 0
#define chunk_lastupdate 1  
#define chunk_objectsData 2
#define chunk_lastdelete 3

#define allocChunk [[],tickTime,createHashMap,0]

#define registerChunk(ch,pos,buf) ch set [pos,buf]

#define getChunkStorage(type) (noe_chunkTypes get type)
#define getChunk(chs,pos) (chs get (pos))

#define chunk_getOwners(chunk) ((chunk) select chunk_owners)
#define chunk_isEmptyOwnerList(chunk) equals(chunk_getOwners(chunk),[])

#define chunk_getLastTicktimeUpdate(chunk) ((chunk) select chunk_lastupdate)
#define chunk_setLastTicktimeUpdate(chunk,time) (chunk) set [chunk_lastupdate,time]

#define chunk_getObjectsData(chunk) ((chunk) select chunk_objectsData)

//Отметка последнего удаления
#define chunk_getLastTicktimeDelete(chunk) ((chunk) select chunk_lastdelete)
#define chunk_setLastTicktimeDelete(chunk,time) (chunk) set [chunk_lastdelete,time]

// !!!!!!!!!
// НИЖЕ - СИСТЕМНЫЕ ВНУТРЕННИЕ ФУНКЦИИ
// !!!!!!!!!

//безопасное получение клиента. выход из контекста если ошибка
#define __chunk_getClientSafe(refvar,own,methodName) refvar = own call cm_findClientById; \
if isNullReference(refvar) exitWith {errorformat("[%1]: cant find client by id %2",methodName arg own)}

#define __chunk_getStrName(ch,tp) (str [ch,tp])