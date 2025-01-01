// ======================================================
// Copyright (c) 2017-2025 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================


//Внешние макросы для функций работы с базой данных

#define dbOpen(file) ([file] call fdb_open)

#define dbClose(file) ([file] call fdb_close)

#define dbGetFiles() (call fdb_getFiles)

#define dbFileExist(file) ([file] call fdb_fileExist)

#define dbDelete(file) ([file] call fdb_delete)

#define dbRead(file) ([file] call fdb_read)

#define dbWrite(file) ([file] call fdb_write)

#define dbGet(file,key) ([file,key] call fdb_get)

#define dbSet(file,key,val) ([file,key,val] call fdb_set)

#define dbRemoveKey(file,key) ([file,key] call fdb_removeKey)
