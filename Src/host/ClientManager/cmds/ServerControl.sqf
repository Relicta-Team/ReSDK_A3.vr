// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================


addCommand("call",ACCESS_OWNERS) {
	if not_equalTypes(args,"") exitWith {errorformat("CommandExec - callcode: Wrong type %1",typeName args)};
	private _output = 0;
	private _ret = ISNIL(compile args);
	private _data = format["ISNIL:%1; CALLRES:%2",_ret,_output];
	rpcSendToClient(caller,"chatPrint",[_data arg "log"]);
};

addCommand("srvstop",ACCESS_ADMIN) {
	private _ft = format["%1 called cmd '%2'",getVar(thisClient,name),_command];
	["ADMIN_SERVERCONTROL: "+_ft] call adminLog;
	["ADMIN_SERVERCONTROL: "+_ft] call disc_adminlog_provider;

	call server_end;
};

addCommand("srvrest",ACCESS_ADMIN) {
	private _ft = format["%1 called cmd '%2'",getVar(thisClient,name),_command];
	["ADMIN_SERVERCONTROL: "+_ft] call adminLog;
	["ADMIN_SERVERCONTROL: "+_ft] call disc_adminlog_provider;

	call server_restart;
};

addCommand("srvislocked",ACCESS_ADMIN) {
	callFuncParams(thisClient,localSay, format vec2("Сервер закрыт: %1",vec2("нет","да") select cm_isServerLocked) arg "log");
};

addCommand("srvlock",ACCESS_ADMIN) {
	private _ft = format["%1 called cmd '%2'",getVar(thisClient,name),_command];
	["ADMIN_SERVERCONTROL: "+_ft] call adminLog;
	["ADMIN_SERVERCONTROL: "+_ft] call disc_adminlog_provider;

	callFuncParams(thisClient,localSay,"Выполнено" arg "system");
	call cm_serverLock;
};

addCommand("srvunlock",ACCESS_ADMIN) {
	private _ft = format["%1 called cmd '%2'",getVar(thisClient,name),_command];
	["ADMIN_SERVERCONTROL: "+_ft] call adminLog;
	["ADMIN_SERVERCONTROL: "+_ft] call disc_adminlog_provider;

	callFuncParams(thisClient,localSay,"Выполнено" arg "system");
	call cm_serverUnlock;
};

addCommand("lobbytimer",ACCESS_ADMIN)
{
	gm_lobbyCanProcessTime = !gm_lobbyCanProcessTime;

	private _ft = format["%1 %2 timer",getVar(thisClient,name),ifcheck(gm_lobbyCanProcessTime,"unlocked","locked")];
	["ADMIN_GAME: "+_ft] call adminLog;
	["ADMIN_GAME: "+_ft] call disc_adminlog_provider;
};

addCommandWithDescription("setlastgame",ACCESS_ADMIN,"Активирует или выключает режим 'последнего раунда'. Включить - 1, Выключить - 0. При включенном режиме после конца раунда сервер выключится вместо ухода на перезагрузку.") {
	
	if (call gm_isRoundEnding) exitWith {
		rpcSendToClient(caller,"chatPrint",vec2("Раунд уже завершён. Слишком поздно...","log"));
	};
	
	_islast = parseNumber(args) > 0;
	if equals(gm_isLastRound,_islast) exitWith {
		rpcSendToClient(caller,"chatPrint",vec2("setlastgame - уже принимает значение введённое значение.","log"));
	};
	gm_isLastRound = _islast;
	if (_islast) then {
		rpcSendToClient(caller,"chatPrint",vec2("Этот раунд будет последним. После его конца сервер выключится.","log"));
	} else {
		rpcSendToClient(caller,"chatPrint",vec2("Этот раунд не будет последним. После его конца сервер перезагрузится.","log"));
	};

	private _ft = format["%1 setup last game to '%2'",getVar(thisClient,name),gm_isLastRound];
	["ADMIN_GAME: "+_ft] call adminLog;
	["ADMIN_GAME: "+_ft] call disc_adminlog_provider;
};


#ifdef TEST_WHITELISTED
addCommand("setmode",PUBLIC_COMMAND) 
#else
addCommand("setmode",ACCESS_ADMIN) 
#endif
{
	if (call gm_isRoundPreload) then {
		(args splitString " ") call gm_initGameMode;
	} else {
		callFuncParams(thisClient,localSay,"Режим можно установить только до начала раунда" arg "log");
	};
};

private ____CAN_ADD_SETGAMEMODE_PUBLIC = false;
#ifdef PRIVATELAUNCH
	____CAN_ADD_SETGAMEMODE_PUBLIC = true;
#endif
#ifdef TEST_WHITELISTED
	____CAN_ADD_SETGAMEMODE_PUBLIC = true;
#endif

if (____CAN_ADD_SETGAMEMODE_PUBLIC) then {
	addCommand("setgamemode",PUBLIC_COMMAND)
	{
		if !isNullReference(gm_currentMode) exitwith {
			callSelfParams(localSay,"Режим уже установлен" arg "error");
			_canSet = false;
		};
		if (["!=","GAME_STATE_PRELOAD"] call gm_checkState) exitWith {
			callSelfParams(localSay,"Режим можно установить только до его выбора игры" arg "error");
		};
		if !([thisClient,"+3 months"] call db_checkAccountLifetime) exitWith {
			callSelfParams(localSay,"Режим могут установить только игроки, которые больше 3х месяцев на сервере" arg "system");
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
				callSelfParams(localSay,"Режим установлен" arg "log");
				//[this,"setmode " + _value,true] call cm_processClientCommand;
				[_value] call gm_initGameMode;
				[format["<t size='1.5'>%1 выбрал режим крутого запуска...</t>",getSelf(name)],"system"]call cm_sendLobbyMessage;
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
			callFuncParams(thisClient,localSay,"Нет доступных режимов" arg "error");
		};

		callFuncParams(thisClient,ShowMessageBox,"Listbox" arg _dat arg _handler);
	};
};



addCommand("forceaspect",ACCESS_ADMIN) {
	
	if (gm_forcedAspect != "") exitWith {
		callFuncParams(thisClient,localSay,"Аспект уже установлен" arg "error");
	};
	if (["!=","GAME_STATE_LOBBY"] call gm_checkState) exitWith {
		callFuncParams(thisClient,localSay,"Аспект можно установить только до начала игры" arg "error");
	};

	_handler = {
		private _canSet = true;
		if (gm_forcedAspect != "") then {
			callSelfParams(localSay,"Аспект уже установлен" arg "error");
			_canSet = false;
		};

		if (["!=","GAME_STATE_LOBBY"] call gm_checkState) then {
			callSelfParams(localSay,"Аспект можно установить только до начала игры" arg "error");
			_canSet = false;
		};

		if (_canSet) then {
			gm_forcedAspect = _value;
			callSelfParams(localSay,"Аспект "+_value+" установлен" arg "log");
		};
		callSelf(CloseMessageBox);
	};
	_dat = ["Выберите аспект из доступных (поменять нельзя):"];
	{
		_dat pushback (format["%1|%2",getFieldBaseValue(_x,"name"),_x]);
	} foreach ([callFunc(gm_currentMode,getClassName)] call gm_internal_getPossibleAspects);
	
	if (count _dat == 1) exitWith {
		callFuncParams(thisClient,localSay,"Нет доступных аспектов" arg "error");
	};

	callFuncParams(thisClient,ShowMessageBox,"Listbox" arg _dat arg _handler);

};

addCommandWithDescription("playinfluence",ACCESS_OWNERS,"Запуск игрового эвента")
{
	if (["!=","GAME_STATE_PLAY"] call gm_checkState) exitWith {
		callFuncParams(thisClient,localSay,"Событие можно запустить только во время раунда" arg "error");
	};
	_dat = ["Выберите событие:"];
	{
		_dat pushback (format["%1|%2",getFieldBaseValue(_x,"name"),_x]);
	} foreach (call gameEvents_sys_getAllEventTypes);

	_handler = {
		private _obj = instantiate(_value);
		gameEvents_internal_list_allObjects pushback _obj;
		callSelf(CloseMessageBox);
	};

	callFuncParams(thisClient,ShowMessageBox,"Listbox" arg _dat arg _handler);
};


#ifdef TEST_WHITELISTED
addCommand("startgame",PUBLIC_COMMAND) 
#else
addCommand("startgame",ACCESS_ADMIN) 
#endif
{
	//gm_startFromLobbyCondition = {true}; 
	gm_lobbyTimeLeft = 1;
	gm_supressStartCondition = true;

	private _ft = format["%1 started round",getVar(thisClient,name),gm_isLastRound];
	["ADMIN_GAME: "+_ft] call adminLog;
	["ADMIN_GAME: "+_ft] call disc_adminlog_provider;
};

addCommandWithDescription("endgame",ACCESS_ADMIN,"Позволяет закончить режим с кастомным концом")
{
	if (["!=","GAME_STATE_PLAY"] call gm_checkState) exitWith {
		callFuncParams(thisClient,localSay,"Установить конец можно только пока идёт раунд" arg "error");
	};
	if (gm_isCustomRoundEnd) exitwith {
		callFuncParams(thisClient,localSay,"Процедура уже вызвана" arg "system");
	};
	
	
	private _h = {
		private thisClient = ifcheck(isTypeOf(this,ServerClient),this,getSelf(client));

		if (count _value == 0) exitwith {
			callFuncParams(this,localSay,"Пустая строка конца раунда" arg "system");
		};

		if (["!=","GAME_STATE_PLAY"] call gm_checkState) exitWith {
			callFuncParams(this,localSay,"Установить конец можно только пока идёт раунд" arg "error");
			callFunc(this,closeMessageBox);
		};
		if (gm_isCustomRoundEnd) exitwith {
			callFuncParams(this,localSay,"Процедура уже вызвана" arg "system");
			callFunc(this,closeMessageBox);
		};

		private _ft = format["%1 called endgame cmd with result: %2",getVar(thisClient,name),_value];
		["ADMIN_GAME: "+_ft] call adminLog;
		["ADMIN_GAME: "+_ft] call disc_adminlog_provider;

		callFunc(this,closeMessageBox);
		gm_isCustomRoundEnd = true;
		gm_customTextResult = _value;
	};

	private _t = "Введите текст конца раунда. Обратите внимание, что такой конец раунда не позволит получить людям награды за выполнение задач";
	callFuncParams(thisClient,ShowMessageBox,"Input" arg [_t arg gm_customTextResult arg "Конец раунда"] arg _h);

};

cmd_ai_internal_nextSpawnPos = null;

addCommandWithDescription("ai_setspawnpoint",ACCESS_ADMIN,"Установить следующую точку спавна АИ")
{
	checkIfMobExists();
	private _posAtl = callSelf(getPos);
	cmd_ai_internal_nextSpawnPos = _posAtl;
	callFuncParams(thisClient,localSay,"Точка спавна установлена: " + (str _posAtl) arg "system");
};

addCommandWithDescription("ai_spawn",ACCESS_ADMIN,"Спавнит АИ в следующей точке спавна")
{
	if isNull(cmd_ai_internal_nextSpawnPos) exitWith {
		callFuncParams(thisClient,localSay,"Нет установленной точки спавна" arg "system");
	};

	private _mob = [cmd_ai_internal_nextSpawnPos] call ai_createMob;
	if isNullReference(_mob) exitWith {
		callFuncParams(thisClient,localSay,"Не удалось создать АИ" arg "system");
	};

	callFuncParams(thisClient,localSay,"АИ создан" arg "system");
};