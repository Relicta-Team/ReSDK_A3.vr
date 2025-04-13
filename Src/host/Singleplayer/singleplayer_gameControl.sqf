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
		if (sp_debug) exitWith {
			traceformat("intercepted debug-skipped command - %1",_inputType)
			false
		};
		
		traceformat("intercepted command - %1",_inputType)
		true
	};
	private __curPlayerInputHandler__ = -1;
	private _removeEvents = [];
	private _inptercepted = _input apply { 
		INC(__curPlayerInputHandler__);
		_params call (_x select 0)
	};
	if (count _removeEvents > 0) then {
		{
			_input set [_x,objNull];
		} foreach _removeEvents;
		_input = _input - [objNull];
		if (count _input == 0) then {
			sp_gc_internal_map_playerInputHandlers deleteAt _inputType;
		} else {
			sp_gc_internal_map_playerInputHandlers set [_inputType,_input];
		};
	};
	traceformat("intercepted logic - %1 is %2",_inputType arg any_of(_inptercepted))
	if (sp_debug) exitWith {false};
	any_of(_inptercepted)
};

sp_removeCurrentPlayerHandler = {
	_removeEvents pushBackUnique __curPlayerInputHandler__;
};

//Добавить обработчик ввода игрока. возврат true перехватит управление
sp_addPlayerHandler = {
	params ["_inputType","_handlerCode"];
	private _stack = sp_gc_internal_map_playerInputHandlers getOrDefault [_inputType,[]];
	private _h = floor random 999999;
	_stack pushBack [_handlerCode,_h];
	sp_gc_internal_map_playerInputHandlers set [_inputType,_stack];
	[_inputType,_h]
};

sp_isValidPlayerHandler = {
	params ["_inputType","_hndlIndex"];
	private _stack = sp_gc_internal_map_playerInputHandlers getOrDefault [_inputType,[]];
	(_stack findif {equals(_x select 1,_hndlIndex)}) != -1
};

//фильтрует доступные ПКМ-действия
sp_filterVerbsOnHandle = {
	params ["_verbs","_handlerCode"];
	
	private _vrbs_backup = array_copy(_verbs);
	_verbs resize 0;
	{
		if ([_x call verb_getTypeById,_x] call _handlerCode) then {
			_verbs pushBack _x;
		};
	} foreach _vrbs_backup;

	true
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
	["Chapter2"] call sp_loadScenario;
	["Chapter3"] call sp_loadScenario;
	["Chapter4"] call sp_loadScenario;
	["Chapter5"] call sp_loadScenario;

	//["cpt1_begin"] call sp_startScene;
	["cpt4_begin",true] call sp_startScene;
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
	
	startAsyncInvoke
	{
		params ["_pos","_dir"];
		player setposatl _pos;
		if !isNullVar(_dir) then {
			player setDir _dir;
		};

		call noe_client_isPlayerPositionChunksLoaded;
	},
	{
		params ["_pos","_dir"];
		player setposatl _pos;
		if !isNullVar(_dir) then {
			player setDir _dir;
		};
	},
	[_pos,_dir]
	endAsyncInvoke
	
	
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

sp_internal_map_wsim = createHashMap;
_wsim = [
	"atmos" //atmos sim
	,"light" //lightsim (fireplace,torchs)
	,"damage" //applydamage for mob
	,"hunger" //hunger loss
	,"blood" //bloodloss 
	,"pain"
];

{
	sp_internal_map_wsim set [_x,false];
} foreach _wsim;

//use wsim sp_checkWSim for disable world simulation
sp_wsimIsActive = {
	sp_internal_map_wsim getOrDefault [_this,true]
};

sp_wsimSetActive = {
	params ["_handler","_mode"];
	if (!array_exists(sp_internal_map_wsim,_handler)) exitWith {false};
	sp_internal_map_wsim set [_handler,_mode];
	true
};