// ======================================================
// Copyright (c) 2017-2025 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\engine.hpp>
#include <..\..\oop.hpp>
#include <fDB.h>
#include <fDB.hpp>
error("Do not use this database type. Only allowed SQLite");
appExit(APPEXIT_REASON_COMPILATIOEXCEPTION);

#include "fDB_functions.sqf"
#include "fDB_manager.sqf"

if (isMultiplayer) then {
	call db_init;
};

if (!isMultiplayer) then {
	private _dbName = "database.rdb";

	if !dbFileExist(_dbName) then {
		if dbOpen(_dbName) then {
			dbRead(_dbName);

			_randParam = {
				_charParams = "";
				_randKey = "0123456789abcdef" splitString "";
				for "_i" from 1 to 100 do {
					MOD(_charParams,+ (pick _randKey));
				};
				_charParams
			};

			for "_i" from 1 to 1000 do {
				_key = "player_" + str _i;
				_val = "charparams:" + (call _randParam);
				dbSet(_dbName,_key,_val);
			};

			dbWrite(_dbName);
			dbClose(_dbName);
		};

	};
};
