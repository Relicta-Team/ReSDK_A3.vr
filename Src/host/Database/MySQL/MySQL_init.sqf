// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\engine.hpp>
#include <MySQL.h>
#include "MySQL_functions.sqf"
#include "MySQL_manager.sqf"

error("Do not use this database type. Only allowed SQLite");
appExit(APPEXIT_REASON_COMPILATIOEXCEPTION);

if (isMultiplayer) then {
	call db_init;
};
