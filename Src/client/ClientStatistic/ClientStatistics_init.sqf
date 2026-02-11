// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\host\engine.hpp>
#include <..\..\host\text.hpp>
#include <..\WidgetSystem\widgets.hpp>


#include "LogVariables.sqf"
#include "DevbuildWidget_init.sqf"
#include "MemUsage_init.sqf"

#ifdef EDITOR
	_aftCheck = {
		if (
			!isMultiplayer &&
			"enableLogVars" call sdk_hasSystemFlag
		) then {[true] call clistat_setLogVars;};

		if (
			!isMultiplayer &&
			"showMemUsageInfo" call sdk_hasSystemFlag
		) then {call cli_mem_init;};
	}; invokeAfterDelay(_aftCheck,2);

#endif
