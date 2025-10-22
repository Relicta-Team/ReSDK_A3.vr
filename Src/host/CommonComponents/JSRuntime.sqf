// ======================================================
// Copyright (c) 2017-2025 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================
/*
	JSRuntime is a component that allows you to run JavaScript code in game.
	!!! Currently it is supported only as javascript code executer on serverside, not as a web browser.

	Example of usage:

		//# initialize runtime
		private _initialized = ["test_runtime"] call jsr_initRuntime;
		
		//# register runtime signal
		["test_runtime",{
			params ["_message"];
			["message is: " + _message] call cprint;
		}] call jsr_registerRuntimeSignal;

		//# send signal to runtime
		["test_runtime","var e = 123; JSRuntimeCallback(e);"] call jsr_sendToRuntime;

		//by example we can execute code from files
		private _code = loadfile "path/to/file.js";
		["test_runtime",_code] call jsr_sendToRuntime;

		//# destroy runtime
		["test_runtime"] call jsr_deleteRuntime;

	
	In javascript we can use A3API interface (see src\client\WebUI\A3API.d.ts)
	But for correct work currently we must use JSRuntimeCallback() function

*/


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
function JSRuntimeCallback(value) {
	A3API.SendAlert(value);
}" 
/* + "var a = 0;
function jsr_test() {
	a++;
	A3API.SendAlert(a);
}
"*/ + 
"</script></head><body></body></html>";

// get display object for runtime
jsr_getRuntimeDisplay = {
	if (isServer && isMultiplayer) exitWith {
		if (jsr_isRuntimeFirstRun) then {
			if (count allDisplays == 0) then {
				createDialog "rscdisplayempty";
			};
			private _display = allDisplays select 0;
			if !isNullReference(_display) then {
				//cleanup display
				{
					ctrlDelete _x;
				} foreach (allControls _display);
			};
		};
		allDisplays select 0;
	};
	findDisplay ifcheck(is3DEN,JSR_DISPLAY_ID_EDITOR,JSR_DISPLAY_ID_SIMULATION);
};

// delete all runtimes
jsr_deleteAllRuntimes = {
	private _d = call jsr_getRuntimeDisplay;
	if (isNullReference(_d)) exitWith {false};
	{
		[_y] call jsr_internal_destroyWebBrowser;
	} foreach (_d getvariable "_jsr_runtime_ref");
	true
};

// initialize runtime (we can create multiple runtimes for separate contexts)
jsr_initRuntime = {
	params [["_runtime_name",JSR_CONST_MAIN_RUNTIME_NAME],["_recreate",false]];
	private _hasRuntime = _runtime_name in jsr_runtimes;
	if (_hasRuntime && !_recreate) exitWith {
		warningformat("Runtime already exists: %1",_runtime_name);
		false
	};

	private _d = call jsr_getRuntimeDisplay;
	if (isNullReference(_d)) exitWith {
		warningformat("Game environment not found (null display): %1",_runtime_name);
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

	_wb setvariable ["_runtime_events",[]];

	_wb ctrlAddEventHandler ["JSDialog",{
		params ["_wb","_isconfirm","_msg"];
		[_wb getvariable "_runtime_name",_msg] call jsr_handleRuntimeSignal;

		true
	}];

	JSR_CALL_WEBBROWSER_EXECFROM(_wb,"OpenDataAsURL",jsr_const_baseHtml);

	jsr_runtimes set [_runtime_name,_wb];
	true
};

//force delete runtime manually
jsr_deleteRuntime = {
	params [["_runtime_name",JSR_CONST_MAIN_RUNTIME_NAME]];
	private _wb = [_runtime_name] call jsr_getRuntime;
	if (isNullReference(_wb)) exitWith {false};
	[_wb] call jsr_internal_destroyWebBrowser;
	jsr_runtimes deleteAt _runtime_name;
	true
};

// reload runtime (fully reloads the runtime)
jsr_reloadRuntime = {
	params [["_runtime_name",JSR_CONST_MAIN_RUNTIME_NAME]];
	private _wb = [_runtime_name] call jsr_getRuntime;
	if (isNullReference(_wb)) exitWith {false};
	JSR_CALL_WEBBROWSER_EXECFROM(_wb,"OpenDataAsURL",jsr_const_baseHtml);
	true
};	

// get runtime object by name (runtime object is a web browser control)
jsr_getRuntime = {
	params [["_runtime_name",JSR_CONST_MAIN_RUNTIME_NAME]];
	jsr_runtimes getOrDefault [_runtime_name,null];
};

// open developer console for runtime
jsr_openDevCon = {
	params [["_runtime_name",JSR_CONST_MAIN_RUNTIME_NAME]];
	private _wb = [_runtime_name] call jsr_getRuntime;
	if (isNullReference(_wb)) exitWith {false};
	JSR_CALL_WEBBROWSER_EXECFROM(_wb,"OpenDevConsole",[]);
	true
};

/*
	Register a callback for a runtime signal.
	example:

		["main",{
			params ["_message"];
			["Runtime signal received: %1",_message] call messageBox;
		}] call jsr_registerRuntimeSignal;

	return handle of the registered callback
	-1 if error
*/
jsr_registerRuntimeSignal = {
	params ["_runtime_name","_callback"];
	private _wb = [_runtime_name] call jsr_getRuntime;
	if (isNullReference(_wb)) exitWith {-1};
	private _evtList = _wb getvariable ["_runtime_events",[]];
	private _handle = _evtList pushBack _callback;
	_wb setvariable ["_runtime_events",_evtList];
	_handle
};

/*
	Unregister a callback for a runtime signal.
	example:
	
		["main",_handle] call jsr_unregisterRuntimeSignal;
*/
jsr_unregisterRuntimeSignal = {
	params ["_runtime_name","_handle"];
	private _wb = [_runtime_name] call jsr_getRuntime;
	if (isNullReference(_wb)) exitWith {false};
	private _evtList = _wb getvariable ["_runtime_events",[]];
	if (_handle < 0 || _handle >= count _evtList) exitWith {false};
	_evtList deleteAt _handle;
	_wb setvariable ["_runtime_events",_evtList];
	true
};

//execute javascript code in runtime
jsr_sendToRuntime = {
	params ["_runtime_name","_jscode"];
	private _wb = [_runtime_name] call jsr_getRuntime;
	if (isNullReference(_wb)) exitWith {false};
	JSR_CALL_WEBBROWSER_EXECFROM(_wb,"ExecJS",_jscode);
	true
};

jsr_handleRuntimeSignal = {
	params ["_runtime_name","_data"];
	private _runtime = [_runtime_name] call jsr_getRuntime;
	if (isNullReference(_runtime)) exitWith {false};
	private _evtList = _runtime getvariable ["_runtime_events",[]];
	{
		[_data] call _x;
	} foreach array_copy(_evtList); //мы делаем копию потому что внутри колбэка может быть удаление обработчика
	traceformat("Runtime signal: %1, %2",_runtime_name arg _data);
	true
};

// ---------------------------
// internal functions
// ---------------------------

jsr_internal_allocateWebBrowser = {
	params ["_d"];
	logformat("jsr browser allocation: %1",_d);
	private _r = _d ctrlCreate ["RscWebBrowser",-1];
	logformat("jsr browser allocated: %1",_r);
	_r
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