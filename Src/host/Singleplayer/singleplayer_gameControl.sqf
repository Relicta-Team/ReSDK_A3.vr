// ======================================================
// Copyright (c) 2017-2025 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

sp_gc_playerInteractHandlers = [];

/*
	if returns true - input intercept
	
	[{
		params ["_mob","_target","_opthanditem"];
		
	}] call sp_gc_addPlayerInteractHandler
*/
sp_gc_handlePlayerInteract = {
	params ["_target",["_opthanditem",""]];
	private _mob = call sp_getActor;
	private _lst = sp_gc_playerInteractHandlers apply {[_mob,_target,_opthanditem] call _x};
	any_of(_lst)
};

sp_gc_addPlayerInteractHandler = {
	params ["_code"];
	sp_gc_playerInteractHandlers pushBack _code;
};

sp_gc_internal_map_playerInputHandlers = createHashMap;

//if returns true - input intercepted
sp_gc_handlePlayerInput = {
	params ["_inputType","_params"];
	private _input = sp_gc_internal_map_playerInputHandlers get _inputType;
	if isNullVar(_input) exitWith {false};
	

	false
};

//used for on assigned handler
sp_gc_onPlayerAssigned = {
	params ["_mob"];

	["Chapter1"] call sp_loadScenario;
	["cpt1_begin"] call sp_startScene;
};

//устанавливает позицию игрока
sp_setPlayerPos = {
	params ["_reforpos",["_dir",null]];
	private _pos = vec3(0,0,0);
	if equalTypes(_reforpos,"") then {
		private _obj = _reforpos call sp_getObject;
		_pos = callFunc(_obj,getPos);
		if !isNullVar(_dir) then {
			_dir = callFunc(_obj,getDir);
		};	
	} else {
		_pos = _reforpos;
	};

	if equals(_pos,vec3(0,0,0)) exitWith {};

	player setPosAtl _pos;
	if !isNullVar(_dir) then {
		player setDir _dir;
	};
	
};

//получает объект по глобальной ссылке
sp_getObject = {
	params ["_gref"];
	_gref call getObjectByRef
};

//получает точку спавна
sp_getPoint = {
	params ["_pointName"];
	sp_gc_map_pointList getOrDefault [_pointName,nullPtr];
};

