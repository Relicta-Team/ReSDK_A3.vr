// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\engine.hpp>

repl_map_funcs = createHashMapFromArray [
	["setVelocity",{(_this select 0) setVelocity (_this select 1)}],
	["collisionOff",{(_this select 0) disableCollisionWith (_this select 1)}],
	["addBackpack",{(_this select 0) addBackpack (_this select 1)}],
	["removeBackpack",{removeBackpack _this}],
	["seatConnect",{
		params ["_mob","_dir","_attSource"];
		// engine.hpp reserves isNull(...) for nil checks; these values are object references.
		if (isNullReference(_mob) || {isNullReference(_attSource)}) exitWith {};
		_mob attachTo [_attSource,[0,0,0]];
		// The source already has the world heading (_dir). Attached axes are model-relative.
		_mob setDir 0;
		// Publish the final attached transform, including orientation, from the mob's owner.
		_mob setPosWorld getPosWorld _mob;
	}],
	["seatConnectUpdate",{
		params ["_mob","_dir","_attSource"];
		// A queued update must not detach a mob after its old seat has been deleted.
		if (isNullReference(_mob) || {isNullReference(_attSource)}) exitWith {};
		detach _mob;
		_this call (repl_map_funcs get "seatConnect");
	}],
	["setDir",{
		(_this select 0) setDir (_this select 1)
	}],
	["allowDamage",{
		params ["_mob","_mode"];
		_mob allowDamage _mode;
	}],
	/*
	* Notes:
	 * Head: Blood visuals @ 0.45
	 * Body: Blood visuals @ 0.45
	 * Arms: Blood visuals @ 0.35, increases weapon sway linerarly
	 * Legs: Blood visuals @ 0.35, limping @ 0.5
	*/
	["syncHitpoints",{
		params ["_mob","_lst"];
		_lst params ["_head","_tors","_arms","_legs"];
		_mob allowDamage true;
		_mob setHitPointDamage ["HitHead", _head];
		_mob setHitPointDamage ["HitBody", _tors];
		_mob setHitPointDamage ["HitHands", _arms];
		_mob setHitPointDamage ["HitLegs", _legs];
		_mob allowDamage false;
	}]
];