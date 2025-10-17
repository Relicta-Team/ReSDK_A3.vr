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

#include "ai_interact.sqf"

ai_handleUpdate = -1;

ai_allMobs = [];

//#define AI_DEBUG_TRACEPATH

#ifdef EDITOR
	ai_reloadThis = {
		call compile preprocessfilelinenumbers "src\host\AI\ai_init.sqf";
	};
#else
	#undef AI_DEBUG_TRACEPATH
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
	private _mapdata = createHashMap;
	_mapdata set ["lastvalidpos",_pos];
	_mapdata set ["curpath",[]];
	_mapdata set ["targetidx",0];
	_mapdata set ["ismoving",false];
	setVar(_mob,__aiagent,_mapdata);

	_mob
};

ai_init = {
	if (is3den) exitWith {};
	ai_handleUpdate = startUpdate(ai_onUpdate,0.1);
	#ifdef AI_DEBUG_TRACEPATH
	private _upd = {
		call ai_debug_internal_drawPath;
	}; startUpdate(_upd,0);
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
			if (_pos distance (getposasl player) < 1) exitWith {};
			if ([_mob,getposasl player] call ai_planMove) then {
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

ai_updateNav = {

};

