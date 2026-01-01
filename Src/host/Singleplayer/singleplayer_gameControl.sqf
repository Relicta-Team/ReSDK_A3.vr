// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
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
	traceformat("intercepted logic - %1 is %2 => %3",_inputType arg any_of(_inptercepted) arg _inptercepted)
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

sp_gc_isPlayerInitialized = false;

//used for on assigned handler
sp_gc_onPlayerAssigned = {
	params ["_mob"];
	
	[-1] call music_stop;
	[] call sp_audio_stopMusic;

	["begin"] call sp_loadScenario;
	["Chapter1"] call sp_loadScenario;
	["Chapter2"] call sp_loadScenario;
	["Chapter3"] call sp_loadScenario;
	["Chapter4"] call sp_loadScenario;
	["Chapter5"] call sp_loadScenario;

	#ifdef SP_PROD
	private _chidx = uiNameSpace getVariable ["rel_sp_selchapter",0];
	if not_equalTypes(_chidx,0) then {
		_chidx = 0;
	};

	private _sceneList = ["begin_playerSetup","cpt1_begin","cpt2_begin","cpt3_begin","cpt4_begin","cpt5_begin"];
	if (_chidx < 0 || _chidx >= count _sceneList) then {
		_chidx = 0;
	};

	[_sceneList select _chidx] call sp_startScene;

	#else
	//["begin_prestart"] call sp_startScene;
	["begin_playerSetup"] call sp_startScene;
	//["cpt4_begin",true] call sp_startScene;
	#endif
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

sp_isPlayerPosPrepared = {
	call noe_client_isPlayerPositionChunksLoaded;
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
sp_internal_map_wsimHandlers = createHashMap;
_wsim = [
	"atmos" //atmos sim
	,"light" //lightsim (fireplace,torchs)
	,"damage" //applydamage for mob
	,"hunger" //hunger loss
	,"blood" //bloodloss 
	,"burn" //burn loss
	,"pain"
];

{
	sp_internal_map_wsim set [_x,false];
	sp_internal_map_wsimHandlers set [_x,[]];
} foreach _wsim;

sp_wsim_invokeNextAction = false;

//use wsim sp_checkWSim for disable world simulation
sp_wsimIsActive = {
	if (sp_wsim_invokeNextAction) exitWith {
		sp_wsim_invokeNextAction = false;
		true
	};
	sp_internal_map_wsim getOrDefault [_this,true]
};

sp_addWsimHandler = {
	params ["_wsimMode","_func"];
	(sp_internal_map_wsimHandlers get _wsimMode)pushBack _func;
};
sp_removeWsimHandler = {
	params ["_wsimMode","_handle"];
	private _data = sp_internal_map_wsimHandlers getOrDefault [_wsimMode,[]];
	!isNull(_data deleteat _handle)
};
sp_internal_wsimHandleAction = {
	params ["_wsim","_params"];
	private _data = sp_internal_map_wsimHandlers getOrDefault [_wsim,[]];
	{
		_params call _x;
	} foreach _data;
};

sp_wsimSetActive = {
	params ["_handler","_mode"];
	if (!array_exists(sp_internal_map_wsim,_handler)) exitWith {false};
	sp_internal_map_wsim set [_handler,_mode];
	true
};

sp_playerHp = 100;
sp_playerLastDamagedTime = 0;
sp_internal_handleTargetThrowingContact = {
	params ["_bulletMesh","_targ"];
	if equals(_targ,player) exitWith {
		[randInt(10,25)] call sp_applyPlayerDamage;
		
	};
};

sp_applyPlayerDamage = {
	params ["_val",["_isSet",false]];
	if (_isSet) then {
		sp_playerHp = clamp(100-_val,0,100);
	} else {
		sp_playerHp = (sp_playerHp - _val) max 0;
	};
	sp_playerLastDamagedTime = tickTime;

	if (sp_playerHp <= 0) then {
		call sp_callEventDiePlayer;
	};
};

sp_delegateDiePlayer = {};
sp_setEventDiePlayer = {
	params ["_code"];
	sp_delegateDiePlayer = _code;
};
sp_callEventDiePlayer = {
	nextFrame(sp_delegateDiePlayer);
};

sp_clearPlayerInventory = {
	if (canSuspend) exitWith {
		{
			call sp_clearPlayerInventory;
		} call sp_threadCriticalSection;
	};

	{
		private _item = callFuncParams(call sp_getActor,getItemInSlotRedirect,_x);
		if !isNullReference(_item) then {
			delete(_item);
		};
	} foreach INV_LIST_ALL;
};

sp_whitelistClickItems = [];
sp_blacklistClickItems = [];
sp_delegateCanClickItem = {
	true	
};
sp_allowebVerbs = []; //managed
sp_defaultAllowedVerbs = ["description","mainact","pickup"]; //readonly

sp_canRemoveCloth = false;

sp_canResist = true;
sp_canExamine = true;

sp_defaultHandlers = createHashMapFromArray [
	["resist",true],
	["examine",true],
	["main_action",true],
	["open_inventory",true],
	["item_action",true],
	["main_action",true],
	["two_hands",true],
	["verbs",true],
	["combat",true],
	["fall",true],
	["crush",true],
	["extra_action",true],
	["press_specact",true]
];
sp_const_defaultHandlersCopy = array_copy(sp_defaultHandlers);

sp_const_list_stdPlayerHandlers = [
	"open_inventory"
	,"examine"
	,"resist"
	,"item_action"
	,"main_action"
	,"verbs"
];

sp_setLockPlayerHandler = {
	params ["_option","_value"];
	if equalTypes(_option,[]) exitWith {
		{
			[_x,_value] call sp_setLockPlayerHandler;
		} foreach _option;
	};

	if (!array_exists(sp_defaultHandlers,_option)) exitWith {
		errorformat("Cant found player option %1",_option);
	};
	sp_defaultHandlers set [_option,_value];
};

sp_internal_torchhandler_thread = threadNull;
sp_internal_torchHandler = {
	params ["_t"];
	if getVar(_t,lightIsEnabled) then {
		
		[sp_internal_torchhandler_thread] call sp_threadStop;

		sp_internal_torchhandler_thread = [{
			params ["_t"];
			10 call sp_threadPause;
			if (!getVar(_t,lightIsEnabled)) then {
				callFuncParams(_t,lightSetMode,true);
				["В этот раз факел снова загорится","system"] call chatPrint;
			};
		},[_t]] call sp_threadStart;
	};
};

sp_initializeDefaultPlayerHandlers = {

	private _actor = call sp_getActor;
	setVar(_actor,specialAction,SPECIAL_ACTION_NO);
	setVar(_actor,otherSpecialAction,SPECIAL_ACTION_NO);
	callFuncParams(_actor,onChangeAttackType,"sync");

	callFuncParams(_actor,setCombatMode,false);

	//bypass first unsleep message
	setVar(_actor,__isFirstUnsleep,false);

	sp_defaultHandlers = array_copy(sp_const_defaultHandlersCopy);

	sp_allowebVerbs = array_copy(sp_defaultAllowedVerbs);
	sp_delegateCanClickItem = {
		true	
	};
	sp_whitelistClickItems = [];
	sp_blacklistClickItems = [];

	[false] call sp_setPlayerSprintAllowed;

	["get_memories",{
		params ["_mode"];
		if (_mode == 0) then {["Я помню всё что нужно...","mind"] call chatPrint};
		if (_mode == 1) then {["Я умею всё что нужно...","mind"] call chatPrint};
		true
	}] call sp_addPlayerHandler;

	["chat_show_history",{false}] call sp_addPlayerHandler;

	sp_canResist = true;
	["resist",{!sp_canResist}] call sp_addPlayerHandler;

	sp_canExamine = true;
	["examine",{!sp_canExamine}] call sp_addPlayerHandler;

	["main_action",{
		params ["_t"];
		sp_defaultHandlers get "main_action"
	}] call sp_addPlayerHandler;

	//inventory interact
	["open_inventory",{sp_defaultHandlers get "open_inventory"}] call sp_addPlayerHandler;

	["change_active_hand",{sp_defaultHandlers get "item_action"}] call sp_addPlayerHandler;
	["click_target",{
		params ["_t"];
		if (sp_defaultHandlers get "item_action") exitWith {true};
		private __printErr = {
			[pick[
				"Не стоит трогать это...",
				"Не то, что стоит трогать",
				"Лучше не трогать.",
				"Мне это не нужно"
			],"mind"] call chatPrint;			
		};
		if array_exists(sp_whitelistClickItems,_t) exitWith {false};
		if array_exists(sp_blacklistClickItems,_t) exitWith {call __printErr; true};
		if (_t call sp_delegateCanClickItem) exitWith {false};
		call __printErr;

		true
	}] call sp_addPlayerHandler;
	["click_self",{
        params ["_item"];
		sp_defaultHandlers get "item_action"
	}] call sp_addPlayerHandler;
	["interact_with",{sp_defaultHandlers get "item_action"}] call sp_addPlayerHandler;
	["drop_item",{sp_defaultHandlers get "item_action"}] call sp_addPlayerHandler;
	["putdown_item",{sp_defaultHandlers get "item_action"}] call sp_addPlayerHandler;

	["transfer_slots_item",{
		params ["_slotFrom","_slotTo"];
		if (equals(_slotFrom,INV_CLOTH) && !sp_canRemoveCloth) exitWith {
			[pick[
				"Не стоит раздеваться",
				"Я не хочу снимать свою одежду",
				"Раздеться сейчас было бы глупо"
			],"mind"] call chatPrint;
			true
		};
		sp_defaultHandlers get "item_action"
	}] call sp_addPlayerHandler;

	//two hands
	["change_two_hands",{sp_defaultHandlers get "two_hands"}] call sp_addPlayerHandler;

	//combat
	["set_combat",{sp_defaultHandlers get "combat"}] call sp_addPlayerHandler;

	//extra
	["extra_action",{sp_defaultHandlers get "extra_action"}] call sp_addPlayerHandler;

	["press_specact",{sp_defaultHandlers get "press_specact"}] call sp_addPlayerHandler;

	["on_falling",{sp_defaultHandlers get "fall"}] call sp_addPlayerHandler;
	["crush_contact",{sp_defaultHandlers get "crush"}] call sp_addPlayerHandler;

	["emote_action",{false}] call sp_addPlayerHandler;
	["emote_text",{false}] call sp_addPlayerHandler;

	//verbs
	["load_verbs",{
		params ["_targ","_verbs"];
		if (sp_defaultHandlers get "verbs") exitWith {true};

		[_verbs,{
			params ["_name","_id"];
			_name in sp_allowebVerbs
		}] call sp_filterVerbsOnHandle;
		
		false
	}] call sp_addPlayerHandler;

	["activate_verb",{
		params ["_t","_name"];
		if (_name == "mainact") exitWith {
			sp_defaultHandlers get "main_action"
		};
		if (_name == "description") exitWith {
			sp_defaultHandlers get "examine"
		};
		//duplicate or typo?
		// if (_name == "pickup") exitWith {
		// 	sp_defaultHandlers get "item_action"
		// };
		if (_name == "pickup") exitWith {
			if (sp_defaultHandlers get "item_action") exitWith {true};
			private __printErr = {
				[pick[
					"Не стоит трогать это...",
					"Не то, что стоит трогать",
					"Лучше не трогать.",
					"Мне это не нужно"
				],"mind"] call chatPrint;
			};
			if array_exists(sp_whitelistClickItems,_t) exitWith {false};
			if array_exists(sp_blacklistClickItems,_t) exitWith {call __printErr; true};
			if (_t call sp_delegateCanClickItem) exitWith {false};
			call __printErr;
			true
		};
		if (_name == "standupfromchair") exitWith {
			!sp_canResist
		};
		false
	}] call sp_addPlayerHandler;
};

sp_copyPlayerInventoryTo = {
	params ["_target"];
	private _player = call sp_getActor;
	{
		private _item = callFuncParams(_player,getItemInSlotRedirect,_x);
		if !isNullReference(_item) then {
			private _newitem = [callFunc(_item,getClassName),_target,_x] call createItemInInventory;
			if (callFunc(_newitem,isFireLight)) then {
				callFuncParams(_newitem,lightSetMode,getVar(_item,lightIsEnabled));
			};
		};
	} foreach INV_LIST_ALL;

	callFuncParams(_target,setMobFace,callFunc(_player,getMobFace));
};

//sprint control
sp_setPlayerSprintAllowed = {
	params ["_mode"];
	cd_sp_enabled = _mode;
	call cd_spr_sync;
};