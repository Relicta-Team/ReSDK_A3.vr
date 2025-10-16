// ======================================================
// Copyright (c) 2017-2025 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

/*
	Здесь описаны все функции взаимодействия AI с другими объектами, в том числе движение
*/

//=========================================================
//lowlewel functions for moving
//=========================================================

ai_moveTo = {
	params ["_mob","_pos"];
	private _actor = toActor(_mob);
	[_mob,false] call ai_setStop;
	_actor setDestination [_pos,"LEADER DIRECT",true];
};

ai_planMove = {
	params ["_mob","_destPos"];
	private _body = toActor(_mob);
	private _srcPos = getposasl _body;
	private _mapdata = getVar(_mob,__aiagent);
	private _path = [_srcPos,_destPos] call ai_nav_findPartialPath;
	if (count _path == 0) exitWith {false};

	_mapdata set ["curpath",_path];
	_mapdata set ["targetidx",0];
	_mapdata set ["ismoving",true];

	[_mob,false] call ai_setStop;

	true
};

//обработчик движения и корректировка пути (восстановление пути, если сущность зашла в препятствие)
ai_handleMove = {
	params ["_mob"];
	private _body = toActor(_mob);
	private _mapdata = getVar(_mob,__aiagent);
	private _curidx = _mapdata get "targetidx";
	private _targetPos = (_mapdata get "curpath") select _curidx;
	private _nextPos = (_mapdata get "curpath") select ((_curidx + 1)min(count (_mapdata get "curpath") - 1));
	[_mob,_targetPos] call ai_moveTo;

	//коррекция пути если персонаж сбился
	private _curpos = getposasl _body;
	

	if (((getposasl _body) distance _targetPos) < 0.6) then {
		INC(_curidx);
		_mapdata set ["targetidx",_curidx];
		if (_curidx >= count (_mapdata get "curpath")) then {
			_mapdata set ["ismoving",false];
			[_mob,true] call ai_setStop;
			_mapdata set ["nextPlanTime",tickTime + 3];
			["TARGET REACHED","system"] call chatprint;
		};
	};
};

ai_setStop = {
	params ["_mob","_stop"];
	private _actor = toActor(_mob);
	_actor stop _stop;
};

// константа режимов движения сущности
ai_internal_speedModes_names = createHashMapFromArray [
	[SPEED_MODE_WALK,"SLOW"],
	[SPEED_MODE_RUN,"NORMAL"],
	[SPEED_MODE_SPRINT,"FAST"]
];

ai_setSpeed = {
	params ["_mob","_speedMode"];
	private _actor = toActor(_mob);
	_actor forceSpeed (_actor getSpeed (ai_internal_speedModes_names get _speedMode));
};

//todo 
/*
	rotateTo
	setStance

	pickupItem
	dropItem
	putdownItem
	
	setCombatMode
	setStealth

	attackTarget
	throwItem

*/