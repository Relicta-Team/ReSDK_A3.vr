// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
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
removeAllMissionEventHandlers "Draw3d";

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
removeAll3DENEventHandlers "OnEditableEntityAdded";
removeAll3DENEventHandlers "OnEditableEntityRemoved";

set3DENSelected [];

core_internal_lastSelFrame = 0;
core_internal_select_nframe = {
	["onSelectionChange",[get3DENSelected "" select 0]] call Core_invokeEvent;
};
add3DENEventHandler ["OnSelectionChange",{
	//При множественном выделении хандлер вызывается один раз для каждого объекта в одном кадре
	//Здесь мы группируем эти выделения чтобы избежать проблемы с падением производительности перезагрузки инспектора
	if (core_internal_lastSelFrame != diag_frameNo) then {
		core_internal_lastSelFrame = diag_frameNo;
		nextFrame(core_internal_select_nframe);
	};
}];
add3DENEventHandler ["OnMissionSave",{["onSaving",[false]] call Core_invokeEvent}];
add3DENEventHandler ["OnMissionAutosave",{["onSaving",[true]] call Core_invokeEvent}];
add3DENEventHandler ["onUndo",{["onUndo",[]] call Core_invokeEvent}];
add3DENEventHandler ["onRedo",{["onRedo",[]] call Core_invokeEvent}];
add3DENEventHandler ["OnPaste",{["onPaste",[flatten get3denselected ""]] call Core_invokeEvent}];
add3DENEventHandler ["onConnectingStart",{["onConnectingStart",[_this select 1]] call Core_invokeEvent}];
add3DENEventHandler ["onConnectingEnd",{["onConnectingEnd",[_this select 1,_this select 2]] call Core_invokeEvent}];

add3DENEventHandler ["OnEditableEntityAdded", {params ["_entity"]; ["onEntityAdded",[_entity]] call Core_invokeEvent}];
add3DENEventHandler ["OnEditableEntityRemoved", {params ["_entity"]; ["onEntityRemoved",[_entity]] call Core_invokeEvent}];

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
	["onDraw",[]],
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
	["onPaste",[]], // params ["_listObjects"]
	["onConnectingStart",[]],
	["onConnectingEnd",[]],

	//события добавления и удаления объектов // params ["_obj"]
	["onObjectAdded",[]], 
	["onObjectRemoved",[]],
	//события добавления и удаления любых энтитей редактора
	["onEntityAdded",[]],
	["onEntityRemoved",[]],

	["onMouseAreaPressed",[]] //событие при отпускании мыши по зоне 52(MouseArea)
];

addMissionEventHandler ["draw3D",{
	["onDraw",[]] call Core_invokeEvent;
}];

function(compileEditorOnly)
{
	private __FLAG_SKIP_OBJECT_BUILD__ = true;
	call compileEditor;
}

function(Core_initObjects)
{
	{
		[_x] call Core_initObjectEvents	
	} foreach (all3DENEntities select 0);

	//register paste events
	["onPaste",{
		params ["_objList"];
		{
			if (grpNull isequaltype _x) then {			
				continue;
			};

			[_x,true] call Core_initObjectEvents;
		} foreach _objList;
	}] call Core_addEventHandler;
}

function(Core_getCliArgs)
{
	private _cli = (["ScriptContext","getcliargs",null,true] call rescript_callCommand) splitString endl;
	private _map = createHashMap;
	_map set ["application_path",_cli deleteAt 0];
	forceUnicode 0;
	{
		if ([_x,"-"] call stringStartWith) then {
			private _param = _x select [1];
			if ("=" in _x) then {
				_key = _param select [0,_param find "="];
				_val = _param select [(_param find "=")+1];
				_map set [_key,_val];
			} else {
				_map set [_param,""];
			};
		};
	} foreach _cli;
	_map;
}

function(Core_initObjectEvents)
{
	params ["_obj",["_callOnCreate",false]];
	//unload events if exists
	private _evh = _obj getvariable ["__handlerObjAdd__",null];
	if !isNullVar(_evh) then {
		_obj RemoveEventHandler ["RegisteredToWorld3DEN",_evh];	
	};
	_evh = _obj getvariable ["__handlerObjRemove__",null];
	if !isNullVar(_evh) then {
		_obj RemoveEventHandler ["UnregisteredFromWorld3DEN",_evh];
	};

	//register events
	private _onCreate = {
		["created %1",_this select 0] call printTrace;
		["onObjectAdded",[_this select 0]] call Core_invokeEvent;
	};
	_obj setVariable ["__handlerObjAdd__",_obj AddEventHandler ["RegisteredToWorld3DEN",_onCreate]];
	_obj setVariable ["__handlerObjRemove__",_obj AddEventHandler ["UnregisteredFromWorld3DEN",{
		["deleted %1",_this select 0] call printTrace;
		["onObjectRemoved",[_this select 0]] call Core_invokeEvent;
	}]];

	if (_callOnCreate) then {
		[_obj] call _onCreate;
	};
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
}

function(Core_getStackTrace)
{
	params [["_returnAsString",true]];
	private _stack = diag_stackTrace;
	_stack deleteAt [-1];
	private _stackList = (_stack apply {_x call scriptError_internal_handleStack});
	if (_returnAsString) then {
		(_stackList joinString endl)
	} else {
		_stackList
	};
}

;// for normally including file
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
