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

#include "ai.h"

#include "HPAstar\core.sqf"
#include "HPAstar\debug.sqf"
#include "HPAstar\region.sqf"
#include "HPAstar\update.sqf"
#include "HPAstar\entrance.sqf"

#include "Brain\brain_init.sqf"

#include "ai_interact.sqf"
#include "ai_util.sqf"

ai_handleUpdate = -1;

ai_allMobs = [];



ai_log = {
	log("[AI]: "+(_this call formatLazy));
};

ai_createMob = {
	params ["_pos",["_builderType","AgentBuilderEater"]];

	if !struct_existType_str(_builderType) exitWith {nullPtr};

	private _builder = [_builderType] call struct_alloc;
	private _instanceType = _builder getv(instanceType);
	private _agentType = _builder getv(agentType);

	if !isImplementClass(_instanceType) exitWith {nullPtr};
	if !struct_existType_str(_agentType) exitWith {nullPtr};

	private _gMob = _pos call gm_createMob;
	private _mob = instantiate(_instanceType);
	callFuncParams(_mob,initAsActor,_gMob);

	(_builder callv(getSkills)) params [["_st",10],["_iq",10],["_dx",10],["_ht",10]];
	[_mob,_st,_iq,_dx,_ht] call gurps_initSkills;
	
	private _firstName = _builder callp(getFirstName,_mob);
	if (_firstName != "") then {
		setVar(_mob,name,"Существо");
		([GENDER_MALE] call naming_getRandomName) params ["_f_","_s_"];
		[_mob,_f_,_s_] call naming_generateName;
	} else {
		private _secondName = _builder callp(getSecondName,_mob);
		[_mob,_firstName,_secondName] call naming_generateName;
	};

	[_gMob,null,_mob] call cm_registerMobInGame;
	
	private _face = _builder callp(getFace,_mob);
	callFuncParams(_mob,setMobFace,_face);

	_builder callp(onApply,_mob);

	setVar(_mob,curTargZone,TARGET_ZONE_RANDOM);
	
	_gMob enableAI "MOVE";
	_gMob enableAI "ANIM";

	[_mob,SPEED_MODE_WALK] call ai_setSpeed;

	//создаем регион для существа
	[_pos] call ai_nav_updateOrCreateRegion;
	
	ai_allMobs pushBack _mob;

	private _agent = [_pos,_mob,_agentType] call ai_createAgent;

	_mob
};

ai_createAgent = {
	params ["_pos","_mob",["_agentType","AgentEater"]];
	
	// Создаем агента как структуру
	private _agent = [_agentType] call struct_alloc;
	
	setVar(_mob,__aiagent,_agent);

	// Инициализация системных данных
	_agent setv(actor,toActor(_mob));
	_agent setv(mob,_mob);
	_agent setv(lastvalidpos,_pos);
	_agent setv(curpath,[]);
	_agent setv(targetidx,0);
	_agent setv(ismoving,false);
	
	// Инициализация Utility AI
	_agent setv(currentAction,null);
	_agent setv(nextSensorUpdate,0);
	_agent setv(nextActionUpdate,0);
	
	// Генерируем действия
	_agent callv(generateActions);
	
	_agent
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
			#ifdef EDITOR
			["New region: " + _r,"system"] call chatprint;
			#endif
		};
	} foreach smd_allInGameMobs;
	//процессим моба
	{
		private _mob = _x;
		private _agent = getVar(_mob,__aiagent);
		
		#ifdef AI_DEBUG_MOVETOPLAYER
		private _body = toActor(_mob);
		private _pos = getposasl _body;
		if !(_agent getv(ismoving)) then {
			if (tickTime < (_agent getOrDefault ["nextPlanTime",tickTime])) exitWith {};
			_target = getposasl player;
			

			if (_pos distance _target < 1.2) exitWith {};
			if ([_mob,_target] call ai_planMove) then {
				
				
			};
		};
		#endif
		
		if (_agent getv(ismoving)) then {
			[_mob] call ai_handleMove;
		};
		
		// Обновление Utility AI
		[_mob,_agent] call ai_brain_update;
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

#include <..\..\client\WidgetSystem\widgets.hpp>

ai_debug_internal_needLoadBrainWidget = true;


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
			
			_t pushBack format["Nearest: %1 (%2m)",getVar(_nearestMob,name),(_nearestDist toFixed 1)];
			_t pushBack format["Agent: %1",_agent getv(name)];
			_t pushback format["stopped: %1",stopped(_agent getv(actor))];
			_t pushback format["moving: %1",(_agent getv(ismoving))];
			
			// Текущее действие
			private _currentAction = _agent getv(currentAction);
			if (!isNullVar(_currentAction)) then {
				_t pushBack format["Current: %1",str _currentAction];
				{
					[_x,_y] params ["_name","_value"];
					if not_equalTypes(_value,{}) then {
						if (_name select [0,1] == "#") exitWith {};
						if (_name in [
							"__dflg__",
							"name",
							"state",
							"requiredAgentFields",
							"_lastScore",
							"baseScore"
						]) exitWith {};
						_t pushback format["%1: %2",_name,_value];
					};
				} foreach (_currentAction);
			} else {
				_t pushBack "Current: none";
			};

			_t pushback "";
			_t pushBack "--- Actions ---";
			
			// Все возможные действия и их стоимости
			private _possibleActions = _agent getv(possibleActions);
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
			private _target = _agent getv(visibleTarget);
			if (!isNullReference(_target)) then {
				_t pushBack format["Target: detected (%1m)",((toActor(_nearestMob)) distance callFunc(_target,getBasicLoc)) toFixed 1];
			} else {
				_t pushBack "Target: none";
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


//! fix score on recompile behaviors
ai_reloadBehaviors = {
	["src\host\AI\Brain\brain_struct.sqf"] call struct_reinitialize;
	{
		private _mob = _x;
		[_mob,SPEED_MODE_WALK] call ai_setSpeed;
		private _mapdata = [callFunc(_mob,getPos),_mob] call ai_createAgent;
		setVar(_mob,__aiagent,_mapdata);
	} foreach ai_allMobs;
	
};

#endif
