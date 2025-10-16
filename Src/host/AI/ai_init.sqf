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

#ifdef EDITOR
ai_reloadThis = {
	call compile preprocessfilelinenumbers "src\host\AI\ai_init.sqf";
};
#endif

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
	_mapdata set ["curpath",[]];
	_mapdata set ["targetidx",0];
	_mapdata set ["ismoving",false];
	setVar(_mob,__aiagent,_mapdata);

	_mob
};

ai_init = {
	if (is3den) exitWith {};
	ai_handleUpdate = startUpdate(ai_onUpdate,0.1);
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
			
			[_mob,getposasl player] call ai_planMove;
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

ai_updateNav = {

};

