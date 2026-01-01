// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include "..\engine.hpp"
#include "..\oop.hpp"
#include "..\struct.hpp"
#include "..\text.hpp"
#include "..\thread.hpp"
#include "..\..\client\WidgetSystem\widgets.hpp"
#include "..\GameObjects\GameConstants.hpp"

#include "singleplayer_camera.sqf"
#include "singleplayer_view.sqf"
#include "singleplayer_ai.sqf"
#include "singleplayer_scenarioFramework.sqf"
#include "singleplayer_gameControl.sqf"
#include "singleplayer_audio.sqf"

sp_storage = createHashMap;

sp_debug = false;
sp_debug_viewOnReload = true;
sp_debug_skipAudio = false;
sp_debug_doNotHideDebugObjects = false;//показ спавнпоинтов

sp_debug_fastThreadSleep = false;

sp_ai_debug_testmobs = createHashMap;
sp_ai_mobs = createHashMap;
sp_ai_handleFarMobs = startUpdate({call sp_ai_internal_onUpdate},0);
sp_ai_debug_curCaptureBasePos = vec3(0,0,0);

sp_playerCanMove = true;

sp_storageGet = {
	params ["_name","_def"];
	if !(_name in sp_storage) then {
		sp_storage set [_name,_def];
		_def
	} else {
		sp_storage get _name
	};
};
sp_storageUpdate = {
	params ["_name","_valCode","_defval"];
	
	private _val = [_name,_defval] call sp_storageGet;
	sp_storage set [_name, _val call _valCode];
	sp_storage get _name
};

sp_storageSet = {
	params ["_name","_defval"];
	sp_storage set [_name, _defval];
};

sp_internal_reloadScenario = {
	//cleanup input
	sp_gc_internal_map_playerInputHandlers = createHashMap;
	sp_storage = createHashMap;

	sp_internal_lastNotification = "";

	[true] call sp_setHideTaskMessageCtg;
	[false] call sp_setNotificationVisible;

	//reset triggers
	sp_gc_internal_listTriggers = ["Struct_SPTrigger",false] call getAllObjectsInWorldTypeOf;
	sp_gc_internal_listTriggersZones = ["Struct_SPZoneTrigger",false] call getAllObjectsInWorldTypeOf;

	private _oldscn = sp_loadedScenarios;
	
	{
		if not_equals(_x,threadNull) then {
			threadStop(_x);
		}
	} foreach sp_internal_threads;

	sp_map_scenario = createHashMap;
	sp_loadedScenarios = [];

	{
		[_x] call sp_loadScenario;
	} foreach _oldscn;
	
	if (sp_debug_viewOnReload) then {
		[false,0] call setBlackScreenGUI;
		[null] call sp_view_setPlayerHudVisible;
	};
	[sp_lastStartedScene,true] call sp_startScene;
};


if (!isNull(sp_gc_handleUpdateTriggers)) then {
	stopUpdate(sp_gc_handleUpdateTriggers);
};


sp_gc_handleUpdateTriggers = -1;
sp_gc_internal_listTriggers = [];
sp_gc_internal_listTriggersZones = [];
sp_gc_internal_activeTriggers = createhashMap; //key name, value gameobject

sp_initMainModule = {
	//fix error trigger activate on prestart game
	player setposatl [0,0,0];

	//fix for ghost enter
	startAsyncInvoke
	{
		!isNullReference(player)
	},
	{
		clientMob = player;
	}
	endAsyncInvoke

	call sp_initGUI;
	
	private _modeLoaded = !isNull(gm_currentMode);
	if (!_modeLoaded || isNullReference(gm_currentMode)) then {
		call sp_preloadScenarioEnvironment;
	};


	//reset triggers
	if (_modeLoaded) then {
		sp_gc_internal_listTriggers = ["Struct_SPTrigger",false] call getAllObjectsInWorldTypeOf;
		sp_gc_internal_listTriggersZones = ["Struct_SPZoneTrigger",false] call getAllObjectsInWorldTypeOf;
	};

	private _triggerHandle = {
		_del = false;
		_dist = 0;
		{
			if isNullReference(_x) then {_del = true; continue};
			_dist = player distance (callFunc(_x,getPos));
			if (_dist <= getVar(_x,triggerDistance)) then {
				_del = true;
				[getVar(_x,triggerName)] call sp_startScene;
				sp_gc_internal_listTriggers set [_foreachIndex,nullPtr]; //delete trigger only after called scene
			};
		} foreach sp_gc_internal_listTriggers;
		if (_del) then {
			sp_gc_internal_listTriggers = sp_gc_internal_listTriggers - [nullPtr];
		};

		//handle triggers
		_usrPos = player modelToWorld (player selectionPosition "head");
		_inZone = false;
		_trgname = null;
		_mapcollide = sp_gc_internal_activeTriggers;
		{
			if isNullReference(_x) then {continue};
			_inZone = callFuncParams(_x,isInsideTrigger,_usrPos);
			_trgname = getVar(_x,triggerName);
			if (_inZone) then {
				if !(_trgname in _mapcollide) then {
					_mapcollide set [_trgname,_x];
					[_trgname,true] call sp_callTriggerEvent;
				};
			} else {
				if (_trgname in _mapcollide) then {
					_mapcollide deleteAt _trgname;
					[_trgname,false] call sp_callTriggerEvent;
				};
			};

		} foreach sp_gc_internal_listTriggersZones;
	};
	sp_gc_handleUpdateTriggers = startUpdate(_triggerHandle,0.05);
};

sp_getTriggerByName = {
	private _searchName = _this;
	private _retObj = nullPtr;
	{
		if isNullReference(_x) then {continue};
		
		if (_searchName == getVar(_x,triggerName)) exitWith {
			_retObj = _x;
		};
	} foreach sp_gc_internal_listTriggers;
	_retObj
};

//get actor
sp_getActor = { player getvariable "link" };

/*
	create conditional trigger with cancellation token:

	[{
		getposatl player distance (_this select 0) > 10
	},{
		["called on player move"] call chatprint
	},[getposatl player]] call sp_createTrigger
*/
sp_createTrigger = {
	params ["_cond",["_succ",{}],["_params",[]]];
	private _ctok = refcreate(false);
	startAsyncInvoke
	{
		params ["_trgpar","_ctok"];
		if refget(_ctok) exitWith {true};
		(_trgpar select 2) call (_trgpar select 0)
	},
	{
		params ["_trgpar","_ctok"];
		if refget(_ctok) exitWith {};
		(_trgpar select 2) call (_trgpar select 1)
	},
	[_params,_ctok]
	endAsyncInvoke

	_ctok
};

sp_threadNull = threadNull;

if !isNull(sp_internal_threads) then {
	{
		if not_equals(_x,threadNull) then {
			threadStop(_x);
		}
	} foreach sp_internal_threads;
};
sp_internal_threads = [];

sp_threadStart = {
	params ["_thdCode",["_args",[]]];
	
	sp_internal_threads = sp_internal_threads - [threadNull];

	private _handl = threadStart(threadNewArgs(_thdCode,_args));
	sp_internal_threads pushback _handl;
	_handl
};

sp_threadStop = {
	params ["_thd"];
	threadStop(_thd);
	sp_internal_threads = sp_internal_threads - [_thd];
};

sp_threadStopAll = {
	{
		if not_equals(_x,threadNull) then {
			threadStop(_x);
		}
	} foreach sp_internal_threads;
	sp_internal_threads = [];
};

sp_threadCriticalSection = {
	params ["_code"];
	isnil _code;
};

sp_threadPause = {
	params ["_time"];
	if (sp_debug_fastThreadSleep) then {_time = 0.001};
	threadSleep(_time);
};

//called only when result is true
sp_threadWait = {
	waitUntil _this;
};

sp_threadWaitForEnd = {
	waitUntil {equals(_this,threadNull)};
};

call sp_initMainModule;

