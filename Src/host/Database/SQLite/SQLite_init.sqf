// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\engine.hpp>
#include <..\..\oop.hpp>
#include <..\..\text.hpp>
#include <SQLite.h>
#include "SQLite_functions.sqf"
#include "SQLite_manager.sqf"

//!версия базы данных (не расширения)
db_version = "3.0";
//true будет выводить каждый запрос в дебаг консоль
db_canUseQueryLogToStdout = false;

//Основная функция инициализации базы данных
db_init = {
	#ifdef SP_MODE
	if(true) exitWith {[0,"OK_BUT_SP_MODE"]};
	#endif
	["Start initialize database"] call logInfo;
	["Database path: %1",DB_PATH] call logInfo;

	#ifdef RELEASE
	db_canUseQueryLogToStdout = false;
	#endif

	private _result = if (isMultiplayer) then {
		if (!(call db_isOpened)) then {
			call db_open;
		} else {
			[-31,"ERROR_RV_DB_ALREADY_OPENED"]
		};
	} else {
		if (!(call db_isOpened)) then {
			call db_open;
		} else {
			[0,"OK_BUT_ALREADY_OPENED"]
		};
	};

	if (call db_isOpened) then {
		private _ver = call db_getVersion;
		if (_ver == "") exitWith {
			error("Cannot find database version");
			["Cannot find database version"] call logCritical;
			appExit(APPEXIT_REASON_CRITICAL);
		};
		if (_ver != db_version) exitwith {
			errorformat("Database version mismatch. Expected: %1, found: %2", db_version arg _ver);
			["Database version mismatch. Expected: %1, found: %2", db_version, _ver] call logCritical;
			#ifdef EDITOR
			["Версия базы данных отличается от используемой в '%3'.%4%4Текущая версия: %1; Используемая %2;%4%4Обновите БД через RBuilder, либо скопируйте базу вручную, взяв её из 'RBuilder\deploy\editor\db'",
			_ver,db_version,DB_PATH,endl] call messageBox;
			#endif
			appExit(APPEXIT_REASON_CRITICAL);
		};
		["Database version - %1",_ver] call logInfo;
	} else {
		["Database is not opened"] call logError;
	};

	if (db_canUseQueryLogToStdout) then {
		if (!call db_isEnabledStdoutLog) then {
			call db_switchStdoutLog;
		};
	} else {
		//switchoff in editor after changed value
		if (call db_isEnabledStdoutLog) then {
			call db_switchStdoutLog;
		};
	};

	_result
};