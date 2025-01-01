// ======================================================
// Copyright (c) 2017-2025 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\engine.hpp>
#include <..\oop.hpp>
#include <..\text.hpp>
#include <..\GameObjects\GameConstants.hpp>

/*
	How to work new ai system?
	TODO...

*/

ai_createMob = {
	params ["_pos",["_stats",[10,10,10,10]]];

	private _gMob = _pos call gm_createMob;
	private _mob = new(Mob);
	callFuncParams(_mob,initAsActor,_gMob);
	[_mob,8,10,8,12] call gurps_initSkills;
	setVar(_mob,name,"Существо");
	([0] call naming_getRandomName) params ["_f_","_s_"];
	[_mob,_f_,_s_] call naming_generateName;

	smd_allInGameMobs pushBackUnique _gMob;
	callFuncParams(_mob,setMobFace,pick faces_list_man);
	setVar(_mob,curTargZone,TARGET_ZONE_RANDOM);

	[_gMob,_mob] call ai_startSM;
};

ai_startSM = {
	params ["_visual","_virtual"];

	_visual setVariable ["ai_mode","stop"];
	_visual setVariable ["ai_lastact",tickTime];
	_visual setVariable ["ai_state","idle"];
	_visual setVariable ["ai_target",nullPtr];

	private _h = startUpdateParams(ai_mob_onUpdate,0.01,vec2(_visual,_virtual));
	_visual setVariable ["ai_handle",_h];
};

ai_mob_onUpdate = {
	(_this select 0) params ["_vis","_virt"];
	if (tickTime < (_vis getVariable "ai_lastact")) exitWith {};
	_state = _vis getVariable "ai_state";
	#define checkState(name) if equals(_state,name) exitWith
	#define gv(name) (_vis getVariable 'ai_##name')
	#define sv(name,val) _vis setVariable ['ai_##name',val]

	checkState(idle) {
		//find target
		_l = callFuncParams(_virt,getNearMobs,5 arg false);
		if (count _l > 0) exitWith {
			//set target
			_visual setVariable ["ai_target",_l select 0];
			_visual setVariable ["ai_state","moveto"];
		};

	};
	checkState(moveto) {
		__canmoveto = {
			private _its = lineIntersectsSurfaces [(getPosASL _vis)vectorAdd[0,0,0.5],_vis modelToWorld [0,0.9,0.5],_vis,objNull,true,1,"GEOM","VIEW"];
			(count _its == 0)
		};
		if (call __canmoveto) then {
			if (gv(mode) != "stop") then {
				_vis playAction "WalkF";
				sv(mode,"move");
			};
		} else {
			if (gv(mode)=="move") then {
				_vis playAction "stop";
				sv(mode,"stop");
			};
		};
	};
};
