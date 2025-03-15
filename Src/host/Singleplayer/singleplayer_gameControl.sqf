// ======================================================
// Copyright (c) 2017-2025 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

sp_gc_internal_map_playerInputHandlers = createHashMap;

//if returns true - input intercepted
sp_gc_handlePlayerInput = {
	params ["_inputType","_params"];
	private _input = sp_gc_internal_map_playerInputHandlers get _inputType;
	if isNullVar(_input) exitWith {
		traceformat("intercepted command - %1",_inputType)
		true
	};
	private _inptercepted = _input apply {
		_params call (_x select 0)
	};
	traceformat("intercepted logic - %1 is %2",_inputType arg any_of(_inptercepted))
	any_of(_inptercepted)
};

sp_addPlayerHandler = {
	params ["_inputType","_handlerCode"];
	private _stack = sp_gc_internal_map_playerInputHandlers getOrDefault [_inputType,[]];
	private _h = floor random 999999;
	_stack pushBack [_handlerCode,_h];
	sp_gc_internal_map_playerInputHandlers set [_inputType,_stack];
	[_inputType,_h]
};

sp_removePlayerHandler = {
	_this params ["_inputType","_hndlIndex"];
	private _stack = sp_gc_internal_map_playerInputHandlers getOrDefault [_inputType,[]];
	private _id = _stack findif {_x select 1 == _hndlIndex};
	if (_id != -1) then {
		_stack deleteAt _id;
		if (count _stack == 0) then {
			sp_gc_internal_map_playerInputHandlers deleteAt _inputType;
		} else {
			sp_gc_internal_map_playerInputHandlers set [_inputType,_stack];
		};
	};
};

//clear all handlers
sp_clearPlayerHandlers = {
	sp_gc_internal_map_playerInputHandlers = createHashMap;
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

