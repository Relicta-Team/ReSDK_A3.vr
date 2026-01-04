// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

// Вызывается когда все функции готовы

for"_i" from 1 to 5 do {
	__inline_emptylog();
};
__header = "";
{
	_x params ["_name","_attribList","_code"];
	_code = toString _code;
	__header = format['private __FUNC__ = "%1"; scriptName "%1"; scopeName "%1";',_name];
	if ("ext_api" in _attribList) then {
		__header = format['private __FUNC__ = "%1";',_name];
	};
	_code = __header + _code;
	if (Core_log_showInitializedFunctions) then {
		__inline_log("Registered function - "+_name);
	};
	missionNamespace setVariable [_name,compile _code];
} foreach allFunctions;

Core_isLoaded = true;
for"_i" from 1 to 5 do {
	__inline_emptylog();
};
["               > Compiled at %1 ms",(tickTime - Core_timeSpan_startLoading)*1000] call printLog;
["               > Editor loaded. Version %1 (number %2)",Core_version_name,Core_version_number] call printLog;
for"_i" from 1 to 5 do {
	__inline_emptylog();
};

// ---------- resolution checks ------------
_res = tolower(getVideoOptions get "guiScaleName");
_okResMode = _res in ["small","verysmall"];
_nonok = _res == "normal";
if (!_okResMode) then {
	if (!_nonok) then {
		private _afterInitCall = {
			["Недопустимое разрешение UI"+endl+endl+
			"Для нормальной работы редактора и режима симуляции требуется размер интерфейса Маленький или Очень маленький."+
				" Измените разрешение UI и перезапустите редактор через выход в главное меню."] call messageBox;
		};
		invokeAfterDelay(_afterInitCall,2);
	} else {
		["The UI resolution does not exceed the allowed limits. Normal display is not guaranteed. Current: %1; Required: Small or Very Small",getVideoOptions get "guiScaleName"] call printWarning;
	};
};
_res = tolower(getVideoOptions get "displayModeName");
if ("FullScreen" == _res) then {
	private _afterInitCall = {
		["Недопустимый режим вывода"+endl+endl+
			"Для нормальной работы редактора требуется перевести окно платформы в оконный режим."] call messageBox;
	};
	invokeAfterDelay(_afterInitCall,2);
};

// ---------- resolution checks end ------------

// validate script error
if (ReBridge_lastError != "") exitWith {
	[ 
		(format[
			"Компиляция ReBridge завершена с ошибкой: %1%2Лог: %3",
			ReBridge_lastError,
			endl,
			ReBridge_loadedLogFile
		]), 
		"Ошибка ReBridge", 
		[ 
			"Recompile", 
			{ 
				[]spawn{isnil compileEditor};
			} 
		], 
		[ 
			"Reload editor", 
			{[] spawn Core_reloadEditorFull; } 
		], 
		"\A3\ui_f\data\map\markers\handdrawn\warning_CA.paa", 
		findDisplay 313 
	] call createMessageBox;
};

["onSaving",{
	params ["_isAuto"];
	["Saving process; is autosave - %1",_isAuto] call printLog;
	if (cfg_map_autosaveBinary) then {
		nextFrameParams(mm_saveCurrentMapToFile,[true]);
	};
}] call Core_addEventHandler;

startUpdateParams(Core_invokeEvent,0,"onFrame");

projectEditor_isCompileProcess = false;

call struct_initialize;

{
	if (Core_catchedInitError) exitWith {};

	call (missionNamespace getVariable _x);
} foreach functions_list_init;

if (Core_catchedInitError) exitWith {};

//init object creation event
call Core_initObjects;

//main loader gameobjects
_postInit = {
	call core_settings_init;
	call inspector_init;
	call golib_main_init;
	call golib_initCommonStorage_nonAuto;

	call Core_setWindowVisual;

	call Core_onPostInitCheckPerFrame;

	call classValidator_init;
};
if (!isNull(__FLAG_SKIP_OBJECT_BUILD__) && isNull(goasm_builder_isBuildedClasses)) then {
	//без объектов нельзя пропустить только редактора
	__FLAG_SKIP_OBJECT_BUILD__ = null;
};
if (core_debug_skipBuilding || !isNull(__FLAG_SKIP_OBJECT_BUILD__)) exitWith _postInit;

[_postInit,_postInit] call goasm_builder_build;
