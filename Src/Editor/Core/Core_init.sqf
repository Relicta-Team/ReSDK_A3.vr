// ======================================================
// Copyright (c) 2017-2023 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

Core_timeSpan_startLoading = tickTime;

Core_isFirstLoad = isNull(Core_internal_firstLoadFlag);

core_debug_skipBuilding = !Editor_enableAutoloadGOLIB;

//обходит все проверки и полностью выключает билдинг. использовать только с core_debug_skipBuilding
core_debug_fullskipBuilding = !Editor_enableAutoloadGOLIB;

Core_isLoaded = false;

projectEditor_isCompileProcess = true; //for scripterror handler

Core_catchedInitError =false;

Core_log_showInitializedFunctions = false; //выводит в консоль все инициализированные функции

Core_postInitCheck_perframe = true; //true включает проверку работы перфрейма в отдельном потоке. Нужно для автоперезагрузки при первом запуске (по какой-то причине перфрейм при старте редактора не хочет стартовать.)

if (Core_isFirstLoad) then {
	Core_internal_firstLoadFlag = true;
	if (core_debug_fullskipBuilding) exitWith {};
	core_debug_skipBuilding = false; //первый раз надо сбилдить обязательно
} else {
	//cleanup all each frame handlers
	cba_common_perFrameHandlerArray = [];
	cba_common_PFHhandles = [];
	cba_common_waitAndExecArray = [];

	if (!isnil {allFunctions}) then {
		//cleanup prev func table
		{
			//log("del " + (_x select 0));
			missionNamespace setVariable [_x select 0, nil];
		} foreach allFunctions;
	};
	
	if (count p_table_inheritance == 0) then {
		if (core_debug_fullskipBuilding) exitWith {};
		core_debug_skipBuilding = false;//объекты не созданы. надо билд
	};

};

#include "Core_settings_preInit.sqf"

{
	_x params ["_setName","_data"];
	if equals(_setName,"region") then {continue};
	private _defStruct = _data select 2;
	if not_equalTypes(_defStruct,[]) exitwith {
		__inline_log("!!! Error on read default value setting " + _setName);
		Core_catchedInitError = true;
	};
	missionnamespace setvariable [format["cfg_%1",_setName],_defStruct select 0];
} foreach core_settings_list_default;

removeAllMissionEventHandlers "ScriptError";

removeAll3DENEventHandlers "OnMissionSave";
removeAll3DENEventHandlers "OnMissionAutosave";
removeAll3DENEventHandlers "OnSelectionChange";
removeAll3DENEventHandlers "onUndo";
removeAll3DENEventHandlers "onRedo";
removeAll3DENEventHandlers "OnPaste";
removeAll3DENEventHandlers "onConnectingStart";
removeAll3DENEventHandlers "onConnectingEnd";
removeAll3DENEventHandlers "OnEntityMenu";
//removeAll3DENEventHandlers "OnModeChange";

set3DENSelected [];

add3DENEventHandler ["OnSelectionChange",{["onSelectionChange",[get3DENSelected "" select 0]] call Core_invokeEvent}];
add3DENEventHandler ["OnMissionSave",{["onSaving",[false]] call Core_invokeEvent}];
add3DENEventHandler ["OnMissionAutosave",{["onSaving",[true]] call Core_invokeEvent}];
add3DENEventHandler ["onUndo",{["onUndo",[]] call Core_invokeEvent}];
add3DENEventHandler ["onRedo",{["onRedo",[]] call Core_invokeEvent}];
add3DENEventHandler ["OnPaste",{["onPaste",[]] call Core_invokeEvent}];
add3DENEventHandler ["onConnectingStart",{["onConnectingStart",[_this select 1]] call Core_invokeEvent}];
add3DENEventHandler ["onConnectingEnd",{["onConnectingEnd",[_this select 1,_this select 2]] call Core_invokeEvent}];
//add3DENEventHandler ["OnModeChange",{["changed to %1",_this] call printWarning}];

add3DENEventHandler ["OnEntityMenu", {
	//called when native context menu opened
	params ["_position", "_entity", "_listPath"];
	_ctx = _this;
	_code = {
		setScopeName("event<OnEntityMenu>");
		setLastError("Current context menu should not appear. If it appears, inform the developers. Debug info:" + str _this);
	}; nextFrameParams(_code,_ctx);
}];

core_internal_contextData = createHashMap;
core_internal_contextStack = [];

allFunctions = []; //vec3:name,attributes,code

functions_list_init = [];

//events handlers
Core_internal_map_events = createHashMapFromArray [
	//Все необходимые события добавляются тут
	//основной обработчик обновления каждого кадра
	["onFrame",[]],
	//visual event
	["onDisplayOpen",[]],
	["onDisplayClose",[]],
	["onSaving",[]], //params ["_isauto"]
	//params ["_hidden"];
	["onToggleLeftPanelState",[]],
	["onToggleRightPanelState",[]],
	//change selection //params ["_listObjects"]
	["onSelectionChange",[]],
	//отмена и повторение
	["onUndo",[]],
	["onRedo",[]],
	["onPaste",[]],
	["onConnectingStart",[]],
	["onConnectingEnd",[]],

	["onMouseAreaPressed",[]] //событие при отпускании мыши по зоне 52(MouseArea)
];

function(compileEditorOnly)
{
	private __FLAG_SKIP_OBJECT_BUILD__ = true;
	call compileEditor;
}

function(Core_reloadEditorFull)
{
	params [["_validateUnsaved",true]];

	if (golib_hasUnsavedChanges && _validateUnsaved) exitWith {
		["Есть несохранённые изменения на временной карте. Сохраните изменения"] call showWarning;
	};
	do3DENAction "MissionLoad";
	//uiSleep 1;
	//systemChat str (count allControls findDisplay 314);
	private _ref = (findDisplay 314 displayCtrl 101);

	private _finded = false;

	for "_i" from 0 to (_ref tvCount [])-1 do {
		//if (_ref tvText[_i] == "MPMissions") exitWith {
			//_ref tvSetCurSel [_i]
		//}
		//check for missions, mpmissions etc...
		_ref tvSetCurSel [_i];
		_lb= (findDisplay 314 displayCtrl 103);
		
		for "_i" from 0 to (lnbSize _lb select 0) - 1 do {
			_t = (_lb lnbText [_i,0]);
			["check %1",_t] call printTrace;
			if (_t == missionname) exitWith {
				_lb lnbSetCurSelRow _i;
				["ok - %1",_t] call printTrace;
				_finded = true;
				ctrlActivate((findDisplay 314) displayctrl 1);
			}
		};
		if (_finded) exitWith {};
	};
	
}

function(Core_setSessionPlatformCachedValue)
{
	params ["_name", "_value"];
	uiNamespace setvariable ["resdk_internal_cached_" + _name,_value]
}

function(Core_getSessionPlatformCachedValue)
{
	params ["_name"];
	uiNamespace getvariable ["resdk_internal_cached_" + _name,null]
}

function(Core_onPostInitCheckPerFrame)
{
	Core_posInit_perframe_awaitInput = false;

	if (Core_postInitCheck_perframe && Core_isFirstLoad) then {
		[] spawn {
			waitUntil { Core_posInit_perframe_awaitInput; };
			if (count cba_common_perFrameHandlerArray == 0) then {
				isnil compileEditorOnly;
			};
		};
	};
}

function(Core_addEventHandler)
{
	params ["_name","_code"];
	private _list = Core_internal_map_events get _name;
	if isNullVar(_list) exitWith {
		["Cant add event %1 - Event not exists",_name] call printError;
		-1
	};
	_list pushBack _code;
};

function(Core_removeEventHandler)
{
	params ["_name","_id"];
	private _list = Core_internal_map_events get _name;
	if isNullVar(_list) exitWith {
		["Cant add event %1 - Event not exists",_name] call printError;
		false
	};
	if (_id < 0 || _id >= (count _list)) exitWith {false};
	_list deleteAt _id;
	true
};

function(Core_getEventHandlersCount)
{
	params ["_name"];
	count (Core_internal_map_events getOrDefault [_name,[]]);
};

function(Core_removeAllEventHandlers)
{
	params ["_name"];
	private _list = Core_internal_map_events get _name;
	for "_i" from 0 to (call Core_getEventHandlersCount) - 1 do {
		_list deleteAt 0;
	};
};

function(Core_invokeEvent)
{
	params ["_name",["_params",[]]];
	private _evList = Core_internal_map_events get _name;
	if isNullVar(_evList) exitWith {
		["Cant call event %1 - Event not exists",_name] call printError;
	};
	{
		_params call _x;
	} foreach _evList;
};

//native error handler
#include "Core_errorHandler.sqf"

#define DISABLE_CALLBACK_DEBUG

#include "..\..\ReBridge\ReBridge_init.sqf"

#undef DISABLE_CALLBACK_DEBUG

//shared debug
#include "..\..\host\Tools\EditorDebug\EditorDebug_shared.sqf"

// активируем компонет
[] call ReBridge_start;

// Загрузим проект со скриптами (Путь должен быть полным)
[getMissionPath "src\Scripts\EditorScriptsProject.reproj"] call rescript_build;

// инициализируем скрипт
["ScriptContext"] call rescript_initScript;
["Breakpoint"] call rescript_initScript;
["OOPBuilder"] call rescript_initScript;
["FileManager"] call rescript_initScript;
["WorkspaceHelper"] call rescript_initScript;
["FileWatcher"] call rescript_initScript;
["VisualScripting"] call rescript_initScript;
call nbp_initDebugger;
