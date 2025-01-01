// ======================================================
// Copyright (c) 2017-2025 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

//Системные сообщения для вызова различных действий. работают почти как команды но добавлять легче

sysmes("system_whoonline")
	//Берем всех клиентов
	_text = format["Сейчас в Сети %1 человек:%2",count cm_allClients,sbr];
	{
		modvar(_text) + sbr + format["%1. <t color='#%3'>%2</t> - счет: %4; Игр: %6<t align='right'>Дата регистрации: %5</t>",_forEachIndex+1,getVar(_x,name),getVar(_x,nickColor),
			[getVar(_x,points),["хвостик","хвостика","хвостиков"],true] call toNumeralString,
			(getVar(_x,firstJoin) splitString " ") select 0,
			getVar(_x,playedRounds)
		];
	} foreach (cm_allClients);
	
	callSelfParams(ShowMessageBox,"Text" arg _text);
sysmes("system_whatnews")
	callSelf(showChangelogs);
	
sysmes("system_votemode")

	if (true) exitwith {
		callFuncParams(this,localSay,"Голосование временно отключено.");
	};

	_handler = {
	#ifdef EDITOR
			["val is "+str _value] call chatPrint;
	#endif
		if (!gm_canVote) exitWith {
			callSelf(CloseMessageBox);
		};

		private _num = parseNumber _value;
		if (_num < 0 || _num >= count gm_allowedModes) exitWith {
			callFuncParams(this,localSay,"Неверное число.");
			callSelf(CloseMessageBox);
		};
		if array_exists(gm_votedClients,this) exitWith {
			callFuncParams(this,localSay,"Вы уже проголосовали.");
			callSelf(CloseMessageBox);
		};

		private _strMode = gm_allowedModes select _num;
		gm_votedClients pushBackUnique this;

		gm_voteMap set [_strMode,(gm_voteMap get _strMode) + 1];

		[format["<t size='1.2'>%1 голосует %2</t>",getVar(this,name),pick["фуфлыжно","кучеряво","куралесно","бибово","сюсяво"]],"system"] call cm_sendLobbyMessage;

		callSelf(CloseMessageBox);
	};
	_dat = ["Проголосуйте за режим:"];
	{
		_gobj = missionNamespace getVariable ["story_" + _x,nullPtr];
		if isNullReference(_gobj) then {continue};
		_dat pushBack (format["%2. %1|%3",getVar(_gobj,name),_forEachIndex + 1,_foreachIndex]);
	} foreach gm_allowedModes;
	
	callSelfParams(ShowMessageBox,"Listbox" arg _dat arg _handler);

// -----------------------------------------------------------
sysmes("admin_emptycmd")
	//no action
sysmes("admin_setmode")
	if !isNullReference(gm_currentMode) exitwith {
		callSelfParams(localSay,"Режим уже установлен" arg "error");
		_canSet = false;
	};
	if (["!=","GAME_STATE_PRELOAD"] call gm_checkState) exitWith {
		callSelfParams(localSay,"Режим можно установить только до его выбора игры" arg "error");
	};

	_handler = {
		private _canSet = true;
		if !isNullReference(gm_currentMode) then {
			callSelfParams(localSay,"Режим уже установлен" arg "error");
			_canSet = false;
		};

		if (["!=","GAME_STATE_PRELOAD"] call gm_checkState) then {
			callSelfParams(localSay,"Режим можно установить только до его выбора игры" arg "error");
			_canSet = false;
		};

		if (_canSet) then {
			//gm_forcedAspect = _value;
			callSelfParams(localSay,"Режим "+_value+" установлен" arg "log");
			[this,"setmode " + _value,true] call cm_processClientCommand;
		};
		callSelf(CloseMessageBox);
	};
	_dat = ["Выберите режим из доступных (поменять нельзя):"];
	{
		_dat pushback (format["%1 (на %3 часа)|%2",getFieldBaseValue(_x,"name"),_x,
			getFieldBaseValue(_x,"duration")/60/60
		]);
	} foreach (gm_allowedModes);
	
	if (count _dat == 1) exitWith {
		callFuncParams(this,localSay,"Нет доступных режимов" arg "error");
	};

	callFuncParams(this,ShowMessageBox,"Listbox" arg _dat arg _handler);
sysmes("admin_lobbytimer")
	[this,"lobbytimer",true] call cm_processClientCommand;
sysmes("admin_forceaspect")
	[this,"forceaspect",true] call cm_processClientCommand;
sysmes("admin_setlastgame")
	[this,"setlastgame "+ifcheck(gm_isLastRound,"0","1"),true] call cm_processClientCommand;
sysmes("admin_setendgame")
	[this,"endgame",true] call cm_processClientCommand;
sysmes("admin_startObserver")
	if ([">=","GAME_STATE_PLAY"] call gm_checkState) then {
		
		
		_handler = {
			private _idx = cm_allInGameMobs findif {getVar(_x getvariable vec2("link",nullPtr),pointer) == _value};
			private _r = "AdminObserverRole" call gm_getRoleObject;
			if (_idx == -1 || isNullReference(_r)) exitWith {
				callSelfParams(localSay,"Нет. Не найдена сущность, объект роли или иная ошибка." arg "system");
				callSelf(CloseMessageBox);
			};
			private _mob = (cm_allInGameMobs select _idx) getvariable vec2("link",nullPtr);
			if isNullReference(_mob) exitwith {
				callSelfParams(localSay,"Отмена по isNullReference(_mob)" arg "system");
				callSelf(CloseMessageBox);
			};
			setVar(_r,spawnPosition,callFunc(_mob,getPos) vectorAdd vec3(0.1,0.1,0));
			[this,"AdminObserverRole",false] call gm_spawnClientToRole;
		};
		_dat = ["Выберите сущность, на позиции которой вы появитесь:"];
		{
			_x = _x getvariable ["link",nullPtr];
			if !isNullReference(_x) then {
				_dat pushback (format["%1|%2",
					callFuncParams(gm_currentMode,getCreditsInfo,_x arg false),
					getVar(_x,pointer)
				]);
			};
		} foreach (cm_allInGameMobs);
		
		if (count _dat == 1) exitWith {
			callFuncParams(this,localSay,"Нет доступных персонажей для наблюдения" arg "error");
		};

		callFuncParams(this,ShowMessageBox,"Listbox" arg _dat arg _handler);

	} else {
		callSelfParams(localSay,"Игра ещё не началась" arg "system");
	};

sysmes("admin_returnToLastBody")
	//callSelfParams(localSay,"Пока не готово" arg "system");
	private _m = getSelf(lastMob);
	if isNullReference(_m) exitwith {};

	callSelfParams(tryConnectToMob,_m);
sysmes("admin_discrolesprotect")
	[this,"setdiscordroleprotect " + ifcheck(dsm_accounts_enableRoleAccessCheck,"0","1"),true] call cm_processClientCommand;
//--------------------------
sysmes("server_srvrest")
	private _event = {
		callSelf(CloseMessageBox);
		[this,"srvrest",true] call cm_processClientCommand;
	};
	callSelfParams(ShowMessageBox,"MessageBox" arg ["<t size='1.4'>Если игра уже идет, то не рекомендуется этого делать. Вы уверены?</t>" arg "Да"] arg _event);
sysmes("server_srvstop")
	private _event = {
		callSelf(CloseMessageBox);
		[this,"srvstop",true] call cm_processClientCommand;
	};
	callSelfParams(ShowMessageBox,"MessageBox" arg ["<t size='1.4'>Сервер будет полностью выключен. Вы уверены?</t>" arg "Да"] arg _event);
sysmes("server_srvislock")
	[this,"srvislocked",true] call cm_processClientCommand;
sysmes("server_srvlockswitch")
	[this,ifcheck(cm_isServerLocked,"srvunlock","srvlock"),true] call cm_processClientCommand;