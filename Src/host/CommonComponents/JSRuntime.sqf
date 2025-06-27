// ======================================================
// Copyright (c) 2017-2025 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include "..\engine.hpp"


#define JSR_CALL_WEBBROWSER_EXECFROM(wb,apiname,paramList) ((wb) ctrlWebBrowserAction [apiname,paramList])
#define JSR_CALL_WEBBROWSER_API(apiname,paramList) JSR_CALL_WEBBROWSER_EXECFROM(ControlNULL,apiname,paramList)

#define JSR_CONST_MAIN_RUNTIME_NAME "main"

#define JSR_DISPLAY_ID_SIMULATION 46
#define JSR_DISPLAY_ID_EDITOR 313

/*
	Функции для создания рантаймов
*/
jsr_runtimes = createHashMap;
jsr_isRuntimeFirstRun = true;

jsr_const_baseHtml = "<!DOCTYPE html><html lang=""utf-8""><head><script>"+
"
var a = 0;
function jsr_test() {
	a++;
	A3API.SendAlert(a);
}
" + 
"</script></head><body></body></html>";

jsr_getRuntimeDisplay = {
	findDisplay ifcheck(is3DEN,JSR_DISPLAY_ID_EDITOR,JSR_DISPLAY_ID_SIMULATION);
};

jsr_deleteAllRuntimes = {
	private _d = call jsr_getRuntimeDisplay;
	if (isNullReference(_d)) exitWith {false};
	{
		[_y] call jsr_internal_destroyWebBrowser;
	} foreach (_d getvariable "_jsr_runtime_ref");
	true
};

jsr_initRuntime = {
	params [["_runtime_name",JSR_CONST_MAIN_RUNTIME_NAME],["_recreate",false]];
	private _hasRuntime = _runtime_name in jsr_runtimes;
	if (_hasRuntime && !_recreate) exitWith {
		warningformat("Runtime already exists: %1",_runtime_name);
		false
	};

	private _d = call jsr_getRuntimeDisplay;
	if (isNullReference(_d)) exitWith {
		setLastError("Game environment not found (null display)");
		false
	};
	if (jsr_isRuntimeFirstRun) then {
		jsr_isRuntimeFirstRun = false;
		call jsr_deleteAllRuntimes;
	};
	_d setvariable ["_jsr_runtime_ref",jsr_runtimes];

	if (_hasRuntime && _recreate) then {
		private _wb = jsr_runtimes get _runtime_name;
		if (!isNullReference(_wb)) then {
			[_wb] call jsr_internal_destroyWebBrowser;
		};
	};

	private _wb = [_d] call jsr_internal_allocateWebBrowser;
	_wb setvariable ["_runtime_name",_runtime_name];
	_wb ctrlSetPosition [-100,-100,1,1];
	_wb ctrlcommit 0;

	_wb ctrlAddEventHandler ["JSDialog",{
		params ["_wb","_isconfirm","_msg"];
		[_wb getvariable "_runtime_name",_msg] call jsr_handleRuntimeSignal;

		true
	}];

	JSR_CALL_WEBBROWSER_EXECFROM(_wb,"OpenDataAsURL",jsr_const_baseHtml);

	jsr_runtimes set [_runtime_name,_wb];
	true
};

jsr_reloadRuntime = {
	params [["_runtime_name",JSR_CONST_MAIN_RUNTIME_NAME]];
	private _wb = [_runtime_name] call jsr_getRuntime;
	if (isNullReference(_wb)) exitWith {false};
	JSR_CALL_WEBBROWSER_EXECFROM(_wb,"OpenDataAsURL",jsr_const_baseHtml);
	true
};	

jsr_getRuntime = {
	params [["_runtime_name",JSR_CONST_MAIN_RUNTIME_NAME]];
	jsr_runtimes getOrDefault [_runtime_name,null];
};

jsr_openDevCon = {
	params [["_runtime_name",JSR_CONST_MAIN_RUNTIME_NAME]];
	private _wb = [_runtime_name] call jsr_getRuntime;
	if (isNullReference(_wb)) exitWith {false};
	JSR_CALL_WEBBROWSER_EXECFROM(_wb,"OpenDevConsole",[]);
	true
};


jsr_callback = {};
jsr_sendToRuntime = {
	params ["_runtime_name","_jscode"];
	private _wb = [_runtime_name] call jsr_getRuntime;
	if (isNullReference(_wb)) exitWith {false};
	JSR_CALL_WEBBROWSER_EXECFROM(_wb,"ExecJS",_jscode);
	true
};

jsr_handleRuntimeSignal = {
	params ["_runtime_name","_data"];
	_data call jsr_callback;
	//TODO handle runtime signals
	traceformat("Runtime signal: %1, %2",_runtime_name arg _data);
	true
};

// ---------------------------
// internal functions
// ---------------------------

jsr_internal_allocateWebBrowser = {
	params ["_d"];
	_d ctrlCreate ["RscWebBrowser",-1];
};

jsr_internal_destroyWebBrowser = {
	params ["_wb"];
	ctrlDelete _wb
};

// ---------------------------
// utility functions
// ---------------------------
jsr_toBase64 = {
	JSR_CALL_WEBBROWSER_API("toBase64",_this); 
};

jsr_fromBase64 = {
	JSR_CALL_WEBBROWSER_API("fromBase64",_this);
};

/*
	Компрессия входных данных и возврат base64 строки с zlib заголовком.  
*/
jsr_compress = {
	JSR_CALL_WEBBROWSER_API("Deflate",_this);
};

/*
	Распаковка входных данных из base64 строки с zlib заголовком.
	Выходные данные ограничены размером в 1 МБ.
*/
jsr_decompress = {
	JSR_CALL_WEBBROWSER_API("Inflate",_this);
};

/*
not documented
controlnull ctrlWebBrowserAction ["GetTextureAsDataURL","A3\ui_f\data\IGUI\RscTitles\SplashArma3\arma3_lite_splash_ca.paa", 1024]
*/