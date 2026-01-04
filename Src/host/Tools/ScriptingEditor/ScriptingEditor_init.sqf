// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\engine.hpp>

//init rebridge
#include "..\..\..\ReBridge\ReBridge_init.sqf"


// активируем компонет
[] call ReBridge_start; 

// Загрузим проект со скриптами (Путь должен быть полным)
[getMissionPath "src\host\Tools\ScriptingEditor\loader.reproj"] call rescript_build;

// инициализируем скрипт
["TestScript"] call rescript_initScript;
["Breakpoint"] call rescript_initScript;
["ScriptContext"] call rescript_initScript;
["WorkspaceHelper"] call rescript_initScript;
["FileManager"] call rescript_initScript;
["FileWatcher"] call rescript_initScript; //for hot reload
call nbp_initDebugger;

//Вызовем некоторую команду, определённую в скрипте
["TestScript","test",diag_stacktrace] call rescript_callCommandVoid;