// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

/*
	ReBridge 2.0
	
	Компонент для использования скриптинга C#
	
	Для использования проиницилизируйте данную библиотеку и вызовите следующий код:
	
	// активируем компонет
	//Первым параметром можно указать абсолютный путь до файлов с логом
	[] call ReBridge_start; 
	
	// Загрузим проект со скриптами (Путь должен быть полным)
	[getMissionPath "src\ReEngine\ReEngine\Scripts\loader.reproj"] call rescript_build;
	
	// инициализируем скрипт
	["TestScript"] call rescript_initScript;
	
	//Вызовем некоторую команду, определённую в скрипте
	["TestScript","doAny"] call rescript_callCommandVoid;
	
*/

#include <..\host\engine.hpp>

//public settings
#define CALLBACK_DEBUG
#define CALLBACK_COUNTER_INFO

#ifdef DISABLE_CALLBACK_DEBUG
	#undef CALLBACK_DEBUG
#endif

//generic bridge macros
#define engine_extName "ReEngine"
#define __callExt(func,args) (engine_extName callExtension [#func,args])
#define __noargs__ []
#define engineCall(func) __callExt(func,__noargs__)
#define engineCallParams(func,args) __callExt(func,args) 
#define engineGetReturn(dat) (dat select 0)
#define engineGetReturnAsArray(dat) ifcheck(dat select 0 == "",[],parseSimpleArray(dat select 0))

//internal logger
#define _rb_log(message) "debug_console" callExtension ("REBRIDGE_LOG: " + message + "#1111")
#define _rb_warning(message) "debug_console" callExtension ("REBRIDGE_WARN: " + message + "#1101")
#define _rb_error(message) "debug_console" callExtension ("REBRIDGE_ERROR: " + message + "#1001")
#define _rb_logformat(message,fmt) "debug_console" callExtension (format ["REBRIDGE_LOG: " + message + "#1111",fmt])
#define _rb_warningformat(message,fmt) "debug_console" callExtension (format ["REBRIDGE_WARN: " + message + "#1101",fmt])
#define _rb_errorformat(message,fmt) "debug_console" callExtension (format ["REBRIDGE_ERROR: " + message  + "#1001",fmt])

#define printlinesegment() _rb_log("----------------------------------------------")

/*for "_i" from 0 to 10 do {
	//conDllCall("");
};*/
private _REBRIDGE_timerEngineLoad_ = tickTime;
printlinesegment();
_rb_log("ReBridge initialization start...");

//adding interfaces
#include "ReScript.sqf"
#include "ReBridge_interface.sqf"

if !isNull(ReBridge_callbackHandle) then {
	removeMissionEventHandler ["ExtensionCallback", ReBridge_callbackHandle];
	if (call ReBridge_isLoaded) then {
		_rb_log("Unload previous ReBridge assembly...");
		call ReBridge_stop;
	};
};

ReBridge_lastError = "";

ReBridge_callbackHandle = -1;

ReBridge_callback_errorCB = {
	_rb_errorformat("[CALLBACK_ERROR]: Error on calling callback %1 - not found",_x);
};

ReBridge_callback_delegate = {
	params ["_category","_func","_args"];
	
	if (_category != "rengine_callback") exitWith {};
	
	#ifdef CALLBACK_DEBUG
	_rb_logformat(" -------> Callback calling start: %1",_this);
	#endif
	
	if (_func select [0,1] == """") then {_func = call compile _func};
	
	_args call (missionNamespace getVariable [_func,ReBridge_callback_errorCB]);
};

ReBridge_callbackHandle = addMissionEventHandler ["ExtensionCallback",{_this call ReBridge_callback_delegate}];

private _ver = engineGetReturn(engineCall(version));
if (_ver == "") exitWith {
	_rb_error("ReBridge extension not loaded");
};
ReBridge_version = _ver;

_rb_logformat("ReBridge (ver %2) -> loaded at %1 sec",tickTime - _REBRIDGE_timerEngineLoad_ arg ReBridge_version);
printlinesegment();

//undef all decl macros
//public settings
#undef CALLBACK_DEBUG
#undef CALLBACK_COUNTER_INFO
#undef engine_extName
#undef __callExt
#undef __noargs__
#undef engineCall
#undef engineCallParams
#undef engineGetReturn
#undef engineGetReturnAsArray
#undef _rb_log
#undef _rb_warning
#undef _rb_error
#undef _rb_logformat
#undef _rb_warningformat
#undef _rb_errorformat
#undef printlinesegment