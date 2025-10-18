// ======================================================
// Copyright (c) 2017-2025 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\engine.hpp>
#include <..\oop.hpp>
#include <..\text.hpp>
#include <..\struct.hpp>
#include <..\GameObjects\GameConstants.hpp>
#include <..\Gender\Gender.hpp>
#include <..\..\client\WidgetSystem\widgets.hpp>

#include "ai.h"

#include "HPAstar\core.sqf"
#include "HPAstar\debug.sqf"
#include "HPAstar\region.sqf"
#include "HPAstar\update.sqf"
#include "HPAstar\entrance.sqf"

#include "Brain\brain_init.sqf"

#include "ai_interact.sqf"

ai_handleUpdate = -1;

ai_allMobs = [];

// #define AI_DEBUG_TRACEPATH
// #define AI_DEBUG_BRAINIINFO
// #define AI_DEBUG_MOVETOPLAYER

#ifdef EDITOR
	ai_reloadThis = {
		call compile preprocessfilelinenumbers "src\host\AI\ai_init.sqf";
	};
#else
	#undef AI_DEBUG_TRACEPATH
	#undef AI_DEBUG_BRAINIINFO
	#undef AI_ENABLE_DEBUG_LOG
	#undef AI_DEBUG_MOVETOPLAYER
#endif

ai_log = {
	log("[AI]: "+(_this call formatLazy));
};

ai_createMob = {
	params ["_pos",["_stats",[10,10,10,10]]];

	private _gMob = _pos call gm_createMob;
	private _mob = new(Mob);
	callFuncParams(_mob,initAsActor,_gMob);
	[_mob,8,10,8,12] call gurps_initSkills;
	setVar(_mob,name,"Существо");
	([GENDER_MALE] call naming_getRandomName) params ["_f_","_s_"];
	[_mob,_f_,_s_] call naming_generateName;

	smd_allInGameMobs pushBackUnique _gMob;
	callFuncParams(_mob,setMobFace,pick faces_list_man);
	setVar(_mob,curTargZone,TARGET_ZONE_RANDOM);
	
	_gMob enableAI "MOVE";
	_gMob enableAI "ANIM";

	[_mob,SPEED_MODE_WALK] call ai_setSpeed;

	//создаем регион для существа
	[_pos] call ai_nav_updateOrCreateRegion;
	
	ai_allMobs pushBack _mob;

	
	private _mapdata = [_pos,_mob] call ai_createAgent;
	setVar(_mob,__aiagent,_mapdata);

	_mob
};

ai_createAgent = {
	params ["_pos","_mob","_gMob"];
	private _mapdata = createHashMap;
	_mapdata set ["actor",toActor(_mob)];
	_mapdata set ["lastvalidpos",_pos];
	_mapdata set ["curpath",[]];
	_mapdata set ["targetidx",0];
	_mapdata set ["ismoving",false];
	
	// Utility AI - создание поведения
	_mapdata set ["behavior",struct_new(BHVZombie)];
	_mapdata set ["currentAction",null];
	_mapdata set ["nextSensorUpdate",0];
	_mapdata set ["nextActionUpdate",0];
	
	// инициализировать действия
	private _bhv = _mapdata get "behavior";
	_bhv callp(generateActions,_mapdata);
	_mapdata set ["possibleActions",_bhv getv(_possibleActions)];
	
	_mapdata
};

ai_init = {
	if (is3den) exitWith {};
	ai_handleUpdate = startUpdate(ai_onUpdate,0.1);
	#ifdef AI_DEBUG_TRACEPATH
		if !isNull(ai_internal_debug_drawPathHandle) then {
			stopUpdate(ai_internal_debug_drawPathHandle);
		};
		private _upd = {
			call ai_debug_internal_drawPath;
		}; 
		ai_internal_debug_drawPathHandle = startUpdate(_upd,0);
	#endif
	#ifdef AI_DEBUG_BRAINIINFO
		if !isNull(ai_internal_debug_brainiInfoHandle) then {
			stopUpdate(ai_internal_debug_brainiInfoHandle);
		};
		private _upd = {
			call ai_debug_internal_brainiInfo;
		}; 
		ai_internal_debug_brainiInfoHandle = startUpdate(_upd,0);
	#endif
};

//цикл обновления AI
ai_onUpdate = {
	//синхронизируем регионы
	{
		_r = [getposasl _x] call ai_nav_updateOrCreateRegion;
		if (_r != "") then {
			["New region: " + _r,"system"] call chatprint;
		};
	} foreach smd_allInGameMobs;
	//процессим моба
	{
		private _mob = _x;
		private _body = toActor(_mob);
		private _pos = getposasl _body;
		private _mapdata = getVar(_mob,__aiagent);
		
		if !(_mapdata get "ismoving") then {
			if (tickTime < (_mapdata getOrDefault ["nextPlanTime",tickTime])) exitWith {};
			_target = 
			#ifdef AI_DEBUG_MOVETOPLAYER
				getposasl player;
			#else
				getposasl player; //todo change to gettarget
			#endif

			if (_pos distance _target < 1.2) exitWith {};
			if ([_mob,_target] call ai_planMove) then {
				
				#ifdef AI_DEBUG_TRACEPATH
					if !isNull(ai_debug_internal_drawPathObjects) then {
						deleteVehicle ai_debug_internal_drawPathObjects;
					};
					ai_debug_internal_drawPathObjects = [];
					private _path = _mapdata get "curpath";
					{
						private _obj = "Sign_Arrow_F" createVehicle [0,0,0];
						_obj setPosASL _x;
						ai_debug_internal_drawPathObjects pushBack _obj;
					} foreach _path;
					ai_debug_internal_drawLines = [];
					for "_i" from 0 to (count _path - 2) do {
						private _p1 = _path select _i;
						private _p2 = _path select (_i + 1);
						ai_debug_internal_drawLines pushBack [asltoatl _p1, asltoatl _p2];
					};
				#endif
			};
		};
		
		if (_mapdata get "ismoving") then {
			[_mob] call ai_handleMove;
		};
		
		// Обновление Utility AI
		[_mob,_mapdata] call ai_brain_update;
	} foreach ai_allMobs;
};

ai_debugStart = {
	private _o = [getposatl player] call ai_createMob;
	private _map = createHashMap;
	_map set ["curpath",[]];
	_map set ["targetidx",0];
	_map set ["ismoving",false];
	setVar(_o,__aidata,_map);
	ai_debug_procMobs = [_o];
	private _upd = {
		{
			_act = getVar(_x,owner);
			_pos = getposasl _act;
			_map = getVar(_x,__aidata);
			if (!([_pos] call ai_nav_hasRegion)) then {
				["update region at pos: " + (str _pos)] call chatprint;
				[_pos] call ai_nav_updateRegion;
			};
			if !(_map get "ismoving") then {
				_path = [_pos,getposasl player] call ai_nav_findPath;
				if (count _path > 0) then {
					_map set ["curpath",_path];
					_map set ["targetidx",0];
					_map set ["ismoving",true];
					["start moving to target"] call chatprint;
				};
			};
			if (_map get "ismoving") then {
				_curidx = _map get "targetidx";
				_targetPos = (_map get "curpath") select _curidx;
				_act stop false;
				_act forcespeed 2;
				_act setDestination [_targetPos,"LEADER DIRECT",true];
				if (((getposasl _act) distance _targetPos) < 0.8) then {
					["increment target idx to " + (str _curidx)] call chatprint;
					INC(_curidx);
					_map set ["targetidx",_curidx];
					if (_curidx >= count (_map get "curpath")) then {
						_map set ["ismoving",false];
						_act stop true;
						["final target reached"] call chatprint;
					};
				};
			};
		} foreach ai_debug_procMobs;
	};
	startUpdate(_upd,0.1);
};

ai_debug_internal_drawPath = {
	if (!isNull(ai_debug_internal_drawLines)) then {
		{
			drawLine3d [
				_x select 0,
				_x select 1,
				[0,1,0,1],
				30
			]
		} foreach ai_debug_internal_drawLines;
	};
};

#ifdef EDITOR
ai_debug_internal_needLoadBrainWidget = true;
#endif

ai_debug_internal_brainiInfo = {
	if (ai_debug_internal_needLoadBrainWidget) then {
		if !isNull(ai_debug_internal_brainInfoWidget) then {
			[ai_debug_internal_brainInfoWidget select 0] call deleteWidget;
			ai_debug_internal_brainInfoWidget = null;
		};

		ai_debug_internal_needLoadBrainWidget = false;
		private _gui = getGUI;
		_w = [_gui,TEXT,[60,0,100-60,70]] call createWidget;
		ai_debug_internal_brainInfoWidget = [_w];
		_w setBackgroundColor [0,0,0,0.5];
	};
	private _t = [];

	_t pushBack "=== BRAIN INFO ===";
	_t pushback format["Agents: %1 | Mobs: %2",count ai_allMobs,count smd_allInGameMobs];
	_t pushBack "";

	// Находим ближайшего моба к игроку для детальной информации
	if (count ai_allMobs > 0) then {
		private _nearestMob = nullPtr;
		private _nearestDist = 999999;
		{
			private _mob = _x;
			private _actor = toActor(_mob);
			private _dist = player distance _actor;
			if (_dist < _nearestDist) then {
				_nearestDist = _dist;
				_nearestMob = _mob;
			};
		} foreach ai_allMobs;

		if (!isNullReference(_nearestMob)) then {
			private _agent = getVar(_nearestMob,__aiagent);
			private _behavior = _agent getOrDefault ["behavior",null];
			
			_t pushBack format["Nearest: %1 (%2m)",getVar(_nearestMob,name),(_nearestDist toFixed 1)];
			
			if (!isNullVar(_behavior)) then {
				_t pushBack format["Behavior: %1",_behavior getv(name)];
				
				// Текущее действие
				private _currentAction = _agent getOrDefault ["currentAction",null];
				if (!isNullVar(_currentAction)) then {
					_t pushBack format["Current: %1",str _currentAction];
				} else {
					_t pushBack "Current: none";
				};
				
				_t pushBack "";
				_t pushBack "--- Actions ---";
				
				// Все возможные действия и их стоимости
				private _possibleActions = _agent getOrDefault ["possibleActions",[]];
				{
					private _action = _x;
					private _name = _action getv(name);
					private _score = _action getv(_lastScore);
					private _state = _action getv(state);
					private _marker = "";
					
					if (!isNullVar(_currentAction) && {equals(_action,_currentAction)}) then {
						_marker = " [*]";
					};
					
					_t pushBack format["%1: %2 (%3)%4",_name,_score,_state,_marker];
				} foreach _possibleActions;
				
				// Информация о сенсорах
				_t pushBack "";
				private _target = _agent getOrDefault ["visibleTarget",nullPtr];
				if (!isNullReference(_target)) then {
					_t pushBack format["Target: detected (%1m)",((toActor(_nearestMob)) distance _target) toFixed 1];
				} else {
					_t pushBack "Target: none";
				};
			};
		};
	} else {
		_t pushBack "No mobs active";
	};

	[ai_debug_internal_brainInfoWidget select 0,_t joinString sbr] call widgetSetText;
};

ai_debug_showBrainInfo = {
	params ["_mode"];
	(ai_debug_internal_brainInfoWidget select 0) ctrlShow _mode;
};

