// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

//replaced with local
// addCommandWithDescription("ping",PUBLIC_COMMAND,"Проверка соединения") {
// 	rpcSendToClient(caller,"chatPrint",["pong" arg "log"]);
// };

addCommandWithDescription("help",PUBLIC_COMMAND,"Отображает доступные вам команды") {
	_comliststr = "Доступные команды:" ;
	_list = [];
	{
		_accessList = _y select 0;
		if (!array_exists(_accessList,getVar(_client,access)) && !array_exists(_accessList,PUBLIC_COMMAND) && (selectMax _accessList > getVar(_client,access))) then {
			//warningformat("processClientCommand() - No access to call %1 (called on %2): list access:%3; client access %4",_command arg _owner arg _accessList arg getVar(_client,access));
		} else {
			_list pushBack (sbr + _x + "            - " + (_y select 1));
		};
	} foreach cm_commands_map;
	_list sort true;
	_comliststr = _comliststr + (_list joinString "");
	callFuncParams(thisClient,ShowMessageBox,"Text" arg _comliststr);
	
	//rpcSendToClient(caller,"chatPrint",[_comliststr arg "log"]);
};

addCommandWithDescription("netinfo",PUBLIC_COMMAND,"Получить короткую информацию о сети")
{
	// [networkId, owner, playerUID, soldierName, soldierNameInclSquad, steamProfileName, clientStateNumber, isHeadless, adminState, [avgPing, avgBandwidth, desync], playerObject]
	{
		_usrData = (getUserInfo _x);
		if equals(caller,_usrData select 1) exitWith {
			(_usrData select 9) params ["_ping", "_bandwidth", "_desync"];
			_mdat = format["<t align='center'>Short netstat:%1Ping: %2%1Desync: %3%1Bandwidth: %4</t>",sbr,_ping,_desync,_bandwidth];
			callFuncParams(thisClient,localSay, _mdat arg "log");
		};
	} foreach allUsers;
};

addCommand("getonline",PUBLIC_COMMAND) {
	if (getVar(thisClient,access) >= ACCESS_ADMIN) then {
		private _data = format["All clients: %3; In lobby: %1; In game: %2;",count(call cm_getAllClientsInLobby),count (call cm_getAllClientsInGame),count cm_allClients];
		rpcSendToClient(caller,"chatPrint",[_data arg "log"]);
	};
	callFuncParams(thisClient,playSystemAction,"system_whoonline");
};

addCommandWithDescription("nrp",PUBLIC_COMMAND,"Печатает сообщение всем игрокам на сервере") {

	private _text = args;
	if not_equalTypes(_text,"") exitWith {
		errorformat("nrp system error: wrong type %1",typename _text);
	};

	_text = sanitize(_text);

	rpcCall("onSendOOCMessage",vec2(caller,_text));
};

addCommandWithDescription("whovoted",PUBLIC_COMMAND,"Узнать кто проголосовал")
{
	if (!gm_canVote) exitWith {};
	
	private _data = "Проголосовали: ";
	if (count gm_votedClients == 0) then {
		_data = "Пока никто не проголосовал";
	} else {
		{ modvar(_data) +sbr+"    "+ getVar(_x,name) } foreach gm_votedClients;
	};
	callFuncParams(thisClient,localSay,_data arg "mind");
};

addCommandWithDescription("getid",PUBLIC_COMMAND,"Получить айди раунда")
{
	if (["<","GAME_STATE_LOBBY"] call gm_checkState) exitWith {
		callFuncParams(thisClient,localSay,"Ещё не пришло время" arg "error");
	};
	callFuncParams(thisClient,localSay,"Айди смены:" + str gm_currentModeId arg "system");
};

addCommandWithDescription("ahelp",PUBLIC_COMMAND,"Написать админу сообщение")
{
	private _admins = ["ACCESS_ADMIN",true] call cm_getAllClientsByAccessLevel;
	if (count _admins == 0) then {
		callFuncParams(thisClient,localSay,"Внимание! Сейчас никто не сможет принять ваше сообщение. Оно будет отправлено в дискорд" arg "system");
	};
	
	private _h = {
		private _name = ifcheck(isTypeOf(this,ServerClient),getSelf(name),getVar(getSelf(client),name));
		
		private _mes = "ADMIN_HELP: (from "+_name+") " + _value;
		private _admins = ["ACCESS_ADMIN",true] call cm_getAllClientsByAccessLevel;

		["@everyone "+_mes] call disc_adminlog_provider;
		[_mes] call adminLog;

		{
			callFuncParams(_x,localSay,setstyle(sanitizeHTML(_mes),style_redbig) arg "system");
		} foreach _admins;

		callSelf(CloseMessageBox);
		callSelfParams(localSay,"Ваше сообщение отправлено" arg "system");
	};
	private _t = "Введите ваше сообщение для администрации. <t color='#ff0000'>Обратите внимание, что администрация не отвечает на следующие вопросы:"+sbr+
		" - Любые вопросы по управлению."+sbr +
		" - Вопросы по ЛОРу, странным словам, описанным в словаре и истории мира.</t>";
	callFuncParams(thisClient,ShowMessageBox,"Input" arg [_t arg "" arg "Отправить"] arg _h);
};


addCommandWithDescription("showmybans",PUBLIC_COMMAND,"Показывает какие роли забанены для вас")
{
	private _uid = getVar(thisClient,uid);
	private _text = format["Мне заблокированы следующие роли:",args];
	modvar(_text) + sbr + (([_uid,{
	/* 
	_jobClass - класснейм роли бана
	_addedDate - когда добавлен
	_unbanDate - когда снимется
	_reason - причина бана
	_banner - кто забанил */
		format["%1%2    - добавлено :%3;%2    - разбан: %4;%2    - причина: %5",
			getVar(_jobClass call gm_getRoleObject,name),
			sbr,
			_addedDate,
			_unbanDate,
			sanitizeHTML(_reason)
		]
	}] call db_getAllBannedRolesWithDescription) joinString sbr);

	callFuncParams(thisClient,ShowMessageBox,"Text" arg _text);
};

// addCommandWithDescription("discordsync",PUBLIC_COMMAND,"Привязывает дискорд к игровому аккаунту по токену")
// {
// 	_h = {
// 		private thisClient = ifcheck(isTypeOf(this,ServerClient),this,getSelf(client));
		
// 		//fix #236 - removing spaces,and nextlines from token
// 		private _token = (_value splitString (" "+endl)) joinString "";

// 		private _result = [thisClient,_token] call dsm_accounts_register;
// 		callFuncParams(thisClient,localSay,_result arg "system");

// 		callSelf(CloseMessageBox);
// 	};
// 	_m = "<t color='#ff0000'>Внимание! Никому не передавайте свой токен до активации.</t>"+sbr +
// 	"Введите токен, который был получен от бота RELICTA в дискорде.";
// 	callFuncParams(thisClient,ShowMessageBox,"Input" arg [_m arg "" arg "Активировать"] arg _h);
// };

addCommandWithDescription("discordgetroles",PUBLIC_COMMAND,"Получить свои роли из дискорда")
{
	private _roles = callFunc(thisClient,getDiscordRoles);
	if (count _roles == 0) exitwith {
		callFuncParams(thisClient,localSay,"Список пуст..." arg "system");
	};

	private _text = "Мои роли в дискорде:" + sbr + (_roles joinString sbr);
	callFuncParams(thisClient,ShowMessageBox,"Text" arg _text);
};

system_internal_list_allJoiners = [];
system_internal_string_generatedJoinedString = "";
system_internal_generateJoinedRoles = {
	private _gen = "";
	private _mob = 0;
	{
		if isNullReference(_x) then {continue};
		if isTypeOf(_x,MobGhost) then {continue};
		_mob = _x;
		modvar(_gen) + (format["%3 - %1 (%2)",
			callFuncParams(_mob,getNameEx,"кто"),
			getVar(getVar(_mob,basicRole),name),
			(getVar(_mob,playerClients) apply {getVar(_x,name)})joinString (" -"+ sgt+" ")
		]) + sbr;
	} foreach system_internal_list_allJoiners;

	system_internal_string_generatedJoinedString = _gen;
};
addCommandWithDescription("showplayers",PUBLIC_COMMAND,"Показать кто и за какую роль заходил в игру")
{
	if (!call gm_isRoundEnding) exitwith {
		callFuncParams(thisClient,localSay,"Эта команда доступна только после конца раунда" arg "system");
	};

	if (system_internal_string_generatedJoinedString == "") then {
		call system_internal_generateJoinedRoles;
	};

	callFuncParams(thisClient,ShowMessageBox,"Text" arg system_internal_string_generatedJoinedString);
};