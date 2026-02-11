// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================


//Закрывает базу данных
db_closeConnection = {
	[call db_close] call db_checkSystemReturn;

};

db_isClientRegistered = {
	params ['this'];
	count([text format["select Id from Accounts where discordId=%1",getSelf(discordId)],"uint"] call db_query)!=0
};

db_isDiscordIdRegistered = {
	params ["_disId"];
	count([text format["select Id from Accounts where discordId=%1",_disId],"string"] call db_query)!=0
};

//Проверяет юид в бан-листе. Если забанен выводит сообщение. Если срок бана истёк - разбаниваем клиента
db_checkBan = {
	params ["_disId","_refData"];

	private _query = format["select BanTime,BanReason,UnbanAfter,IsPermanent from Bans where discordId=%1",_disId];

	private _res = [text format[_query,_disId],"DateTime|string|DateTime|bool"] call db_query;

	if (count _res == 0) exitWith {false};
	(_res select 0) params ["_banTime",["_banReason",""],"_unbanAfter","_isPerm"];

	// _isPerm = _isPerm != 0; //already converted to bool

	//Проверка на разбан
	private _unbanCheckQuery = format["select datetime('now','localtime') >= '%1'",_unbanAfter call db_dateTimeFormatForComparsion];
	private _canUnban = if (_isPerm)then {false} else {([text _unbanCheckQuery,"bool",true] call db_query) select 0};
	if (_canUnban) exitWith {
		//remove ban
		[text format["DELETE FROM Bans WHERE discordId=%1",_disId]] call db_query;
		false
	};

	_banTime = [_banTime,true] call dateTime_toString;
	_unbanAfter = [_unbanAfter,true] call dateTime_toString;

	refset(_refData,vec4(_banTime,_banReason,_unbanAfter,_isPerm));

	true
};

db_unbanByName = {
	params ["_name","_whoWantUnban"];

	//Получаем юид по имени
	private _disId = [text format["select discordId from Accounts where Name='%1' COLLATE NOCASE",_name],"string"] call db_query;
	if (count _disId == 0) exitWith {format["ERROR: Account '%1' not found" arg _name]};
	_disId = _disId select 0 select 0;

	// check if name in banlist

	private _return = [text format["select discordIdBanner from Bans where discordId='%1'",_disId],"string"] call db_query;

	if (count _return == 0) exitWith {
		callFuncParams(_whoWantUnban,localSay,format vec2("Client '%1' not banned.",_name) arg "log");
		format vec2("Client '%1' not banned",_name)
	};
	// get access _whoWantUnban and compare to discordIdBanner
	private _discordIdBanner = _return select 0 select 0;
	private _accBanner = [text format["select Access from Accounts where discordId=%1",_discordIdBanner],"string"] call db_query;
	private _accBan = if (count _accBanner == 0) then {
		callFuncParams(_whoWantUnban,localSay,"DiscordId ban is undefined in accounts table" arg "log");
		["ACCESS_PLAYER"] call cm_accessTypeToNum;
	} else {
		private _accLvl = _accBanner select 0 select 0;
		if (_accLvl == "system") exitWith {
			["ACCESS_OWNERS"] call cm_accessTypeToNum
		};
		[_accLvl] call cm_accessTypeToNum;
	};

	//	if access low - cant unban
	if (getVar(_whoWantUnban,access) <= _accBan) exitWith {
		callFuncParams(_whoWantUnban,localSay,"Access is too low. Cant unban" arg "log");
		"Acces is to low. Cant unban"
	};

	//process unban
	[text format["DELETE FROM Bans WHERE discordId='%1'",_disId]] call db_query;

	callFuncParams(_whoWantUnban,localSay,vec2("Client '%1' unbanned!",_name) arg "log");

	format vec2("Client '%1' unbanned!",_name)
};

db_banByName = {
	//[thisClient,_name,_reason,_modifMap] call db_banByName;
	params [["_banner","AUTOMATIC"],"_name",["_reason",""],["_modif",[]]];

	private _isPerm = count _modif == 0;
	private _bannerDisId = ifcheck(equals(_banner,"AUTOMATIC"),"system",getVar(_banner,discordId));

	//get name and access
	private _res = [text format["select discordId,Access from Accounts where Name='%1' COLLATE NOCASE",_name],"string,string"] call db_query;

	if (count _res == 0) exitWith {format["NOT BANNED: Account '%1' not found",_name]};
	(_res select 0) params ["_disId","_access"];

	//! чтобы раскомментить эту строчку надо дорабатывать логику когда _banner AUTOMATIC
	//if (getVar(_banner,Access) <= ([_access] call cm_accessTypeToNum)) exitWith {format["NOT BANNED: Your access level is lower than %1",_access]};

	//get client by disId
	private _bannedClient = _disId call cm_findClientByDisId;
	private _andKicked = "";
	if !isNullReference(_bannedClient) then {
		[callFunc(_bannedClient,getOwner),"Вы были забанены." + (if(_isPerm)then{""}else{" Перезайдите на сервер чтобы узнать дату разбана."})] call cm_serverKickById;
		_andKicked = " AND KICKED";
	};

	// generate unban timestamp
	private _dt = if (_isPerm) then {"datetime('now','localtime')"} else {
		private __dt__ = "datetime('now','localtime'";
		{
			_x params ["_key","_val"];
			__dt__ = __dt__ + format[",'%1 %2'",_val,_key];
		} foreach _modif;
		__dt__ + ")"
	};

	private _query = format["%1,%2,%3,%4,'%5',%6",_disId,"datetime('now','localtime')",_dt,_isPerm,_reason,_bannerDisId];
	//insert or replace ???
	[text format["insert into Bans (discordId, BanTime,UnbanAfter, IsPermanent, BanReason, discordIdBanner) values (%1)",_query],""] call db_query;
	
	"BANNED" + _andKicked + " until the " + ifcheck(_isPerm,"(permanent)",_dt) + " user " + _name;
};

//При изменении кода: все ошибочные возвраты должны иметь часть строки "ERROR:"
db_banJobByName = {
	params [["_banner","AUTOMATIC"],"_name",["_role",""],["_reason",""],["_modif",[]]];
	if (_role == "" || _reason == "") exitWith {"ERROR: Role or reason is empty"};
	if ("'" in _reason || """" in _reason) exitwith {"ERROR: symbol ' or "" cannot added in reason"};

	private _isPerm = count _modif == 0;
	private _bannerDisId = ifcheck(equals(_banner,"AUTOMATIC"),"system",getVar(_banner,discordId));

	//Получаем дискорд-айди по имени
	private _disId = [text format["select discordId from Accounts where Name='%1' COLLATE NOCASE",_name],"string"] call db_query;
	if (count _disId == 0) exitWith {format["ERROR: Account '%1' not found",_name]};
	_disId = _disId select 0 select 0;

	private _unbanDate = if (_isPerm) then {"datetime('now','localtime','+300 years')"} else {
		private __dt__ = "datetime('now','localtime'";
		{
			_x params ["_key","_val"];
			__dt__ = __dt__ + format[",'%1 %2'",_val,_key];
		} foreach _modif;
		__dt__ + ")"
	};

	//добавляем новую запись в таблицу JobBans. если она уже есть, обновляем время
	private _qText = "INSERT OR IGNORE INTO JobBans (discordId, Job, AddedDate, UnbanDate, Reason, WhoAdded) VALUES (%1, '%2', datetime('now','localtime'), %3, '%4', %5);" + 
	"UPDATE JobBans SET AddedDate='%3' WHERE discordId=%1 and Job='%2';";
	private _query = format[_qText,_disId,_role,_unbanDate,_reason,_bannerDisId];
	[text format["%1",_query],""] call db_query;

	private _probCli = [_disId,true] call cm_findClientByDisId;
	if !isNullReference(_probCli) then {
		callFunc(_probCli,flushBannedRolesLastGet);
	};

	format["Job %1 banned for client %2 to %3",_role,_name,_unbanDate];
};

db_unbanJobByName = {
	params ["_banner","_name",["_role",""]];
	if (_role == "") exitWith {"ERROR: Role is empty"};

	//Получаем юид по имени
	private _disId = [text format["select discordId from Accounts where Name='%1' COLLATE NOCASE",_name],"string"] call db_query;
	if (count _disId == 0) exitWith {format["ERROR: Account '%1' not found",_name]};
	_disId = _disId select 0 select 0;

	// check if role is banned. search by disId and return iteself
	private _res = [text format["select WhoAdded from JobBans where discordId=%1 and Job='%2'",_disId,_role],"string"] call db_query;
	if (count _res == 0) exitWith {format["ERROR: Job '%1' is not banned for client '%2'",_role,_name]};

	//covert returned value to access from table Accounts
	//private _access = [text format["select Access from Accounts where discordId=%1",_res select 0],"string"] call db_query;
	//_access = _access select 0;

	//check access level
	//if (getVar(_banner,access) <= ([_access] call cm_accessTypeToNum)) exitWith {format["ERROR: Your access level is lower than %1",_access]};

	//удаляем запись из таблицы JobBans
	private _query = format["DELETE FROM JobBans WHERE discordId=%1 and Job='%2'",_disId,_role];
	[text format["%1",_query],""] call db_query;

	private _probCli = [_disId,true] call cm_findClientByDisId;
	if !isNullReference(_probCli) then {
		callFunc(_probCli,flushBannedRolesLastGet);
	};

	format["Job %1 unbanned for client %2",_role,_name];
};


db_isNickRegistered = {
	params ["_nick"];
	count([text format["select discordId from Accounts where Name='%1' COLLATE NOCASE",_nick],"uint"] call db_query)!=0
};

//конвертация uid в никнейм из базы данных
db_disIdToNick = {
	params ["_disId",["_errorNick",""]];
	private _r = [text format["select Name from Accounts where discordId='%1' COLLATE NOCASE",_disId],"string"] call db_query;
	if (count _r == 0) exitwith {_errorNick};
	_r select 0 select 0
};

db_NickToDisId = {
	params ["_nick",["_errorDisId",""]];
	private _r = [text format["select discordId from Accounts where Name='%1' COLLATE NOCASE",_nick],"string"] call db_query;
	if (count _r == 0) exitwith {_errorDisId};
	_r select 0 select 0
};

db_getClientLockedSettings = {
	params ["_nick"];
	private _r = [text format["select LockedSettings from Accounts where Name='%1' COLLATE NOCASE",_nick],"string"] call db_query;
	if (count _r == 0) exitwith {[]};
	parseSimpleArray (_r select 0 select 0)
};

db_updateClientLockedSettings = {
	params ["_nick",["_lockedSettings",""]];
	if not_equalTypes(_lockedSettings,"") then {
		_lockedSettings = str _lockedSettings;
	};

	if !([_nick]call db_isNickRegistered) exitwith {false};
	private _r = [text format["Update Accounts set LockedSettings='%1',CharSettings='[%3]' where Name='%2' COLLATE NOCASE",
		_lockedSettings regexReplace["""/g",""""""],_nick,
		"nil,nil,nil,nil"//reset saved settings
	],"string"] call db_query;
	true
};

//Регистрация аккаунта по айди и имени
db_registerAccount = {
	params ['_disId',"_name"];

	private _query = "INSERT INTO Accounts (DiscordId,Name,Access,ClientSettings,CharSettings,CountConnections,LastJoin,FirstJoin)" +
	"VALUES('%1','%2','ACCESS_PLAYER','[[],[],[]]','[nil,nil,nil,nil]',1,datetime('now','localtime'),datetime('now','localtime'))";

	[text format[_query,_disId,_name]] call db_query
};

db_registerStats = {
	params ["_disId",["_arrCity",0]];

	private _query = "INSERT INTO Stats (DiscordId,ArrivedInCity) VALUES('%1',%2)";
	[text format[_query,_disId,_arrCity]] call db_query
};

db_registerAuthTokenData = {
	params ["_disId","_gameToken","_atok","_reftok","_expDT"];
	
	//disabled in editor mode
	#ifdef EDITOR
	if(true) exitWith {};
	#endif

	//insert or update
	private _query = format["INSERT INTO Discord (DiscordId, discordToken, refreshToken, gameToken, tokenExpiryDate, LastUpdate)"
		+ "VALUES ('%1', '%2', '%3', '%4', '%5', datetime('now','localtime'))"
		+ "ON CONFLICT(DiscordId) DO UPDATE SET
		discordToken = excluded.discordToken,
		refreshToken = excluded.refreshToken,
		gameToken = excluded.gameToken,
		tokenExpiryDate = excluded.tokenExpiryDate,
		LastUpdate = excluded.LastUpdate;"
		,_disId,_atok,_reftok,_gameToken,_expDT
	];

	[text format[_query,_disId,_name]] call db_query
};

//Обновление коунтера подключений и даты последнего коннекта
db_updateValuesOnConnect = {
	params ['_disId'];

	private _query = "UPDATE Accounts SET LastJoin=datetime('now','localtime'),CountConnections=CountConnections+1 where DiscordId=%1";
	[text format[_query,_disId]] call db_query
};

db_checkAccessOnFirstSession = {
	params ["_dt"];
	if equalTypes(_dt,[]) then {
		_dt = _dt call db_dateTimeFormatForComparsion;
	};
	private _query = format["select datetime('%1','+1 months') <= datetime('now','localtime')",_dt];
	([text _query,"bool",true] call db_query) select 0
};

//Проверить есть ли аккаунту n дней
// [this,"+1 months"] call db_checkAccountLifetime
//! только для системных вызовов
db_checkAccountLifetime = {
	params ["_cli","_values"];
	//["days","hours","minutes","months","years"]
	private _real = ((_values splitString ",")apply{"'"+_x+"'"})joinString ",";

	private _dt = getVar(_cli,_firstJoinDB);
	if equalTypes(_dt,[]) then {
		_dt = _dt call db_dateTimeFormatForComparsion;
	};
	//		текущая дата больше или равна дате регистрации
	private _query = format["select datetime('%1',%2) <= datetime('now','localtime')",_dt,_real];
	([text _query,"bool",true] call db_query) select 0
};

db_isConnectedFirstTimeToday = {
	params ["_dt"];
	if equalTypes(_dt,[]) then {
		_dt = _dt call db_dateTimeFormatForComparsion;
	};
	private _query = format["select datetime('now','localtime','-12 hours') >= datetime('%1','localtime')",_dt];
	([text _query,"bool",true] call db_query) select 0
};

db_getAllBannedRoles = {
	params ["_disId"];
	
	private _query = format["delete from JobBans where datetime('now','localtime') >= UnbanDate and discordId=%1;",_disId];
	([text _query,"string"] call db_query);
	_query = format["select Job from JobBans where discordId=%1",_disId];
	([text _query,"string"] call db_query) apply {_x select 0}
};

/* 
	_jobClass - класснейм роли бана
	_addedDate - когда добавлен
	_unbanDate - когда снимется
	_reason - причина бана
	_banner - кто забанил
*/
db_getAllBannedRolesWithDescription = {
	params ["_disId",["_handlerDesc",{_jobClass}]];
	private _mapBanner = createHashMap;
	private _query = format["delete from JobBans where datetime('now','localtime') >= UnbanDate and discordId=%1;",_disId];
	([text _query,"string"] call db_query);
	_query = format["select Job,AddedDate,UnbanDate,Reason,WhoAdded from JobBans where discordId=%1",_disId];
	([text _query,"string|DateTime|DateTime|string|string"] call db_query) apply {
		_x params ["_jobClass","_addedDate","_unbanDate","_reason","_banner"];
		_addedDate = _addedDate call db_dateTimeFormatForComparsion;
		_unbanDate = _unbanDate call db_dateTimeFormatForComparsion;
		if (_banner in _mapBanner) then {
			_banner = _mapBanner get _banner;
		} else {
			private _newbanner = [_banner,"ERROR_NAME_UNKNOWN"] call db_disIdToNick;
			_banner = _newbanner;
		};
		call _handlerDesc;
	}
};

//! прямая проверка на бан роли по юиду и названию роли
// db_checkBanRole = {
// 	params ["_uid","_role"];
// 	private _query = format["delete from JobBans where datetime('now','localtime') >= UnbanDate and Uid=%1 and Job='%2'; select Job from JobBans where Uid=%1 and Job='%2'",_uid,_role];
// 	//поиск не получился. условиям не удовлетворяет - человека нет в базе
// 	(count ([text _query,"string",true] call db_query)) == 0
// };

//регистрация аккаунта по объекту
// db_registerClient = {
// 	params ['this'];

// 	private _query = "INSERT INTO Accounts (Uid,Name,Access,ClientSettings,CharSettings,CountConnections,LastJoin,FirstJoin)" +
// 	"VALUES('%1','%2','ACCESS_PLAYER','[[],[],[]]','[nil,nil,nil,nil]',1,datetime('now','localtime'),datetime('now','localtime'))";

// 	[text format[_query,getSelf(uid),getSelf(name)]] call db_query
// };

db_saveClient = {
	params ['this'];

	private _cliSet = str getSelf(charSettings);
	{
		if isNullVar(_x) then {
			_cliSet = _cliSet + ",null";
		} else {
			_cliSet = _cliSet +","+str _x;
		};

	} forEach getSelf(charSettingsTemplates);

	private _usrSet = "";
	{
		if (_forEachIndex > 0) then {_usrSet = _usrSet + ","};
		MOD(_usrSet, + str _x);
	} foreach getSelf(clientSettings);

	private _lockSettings = "";
	{
		if !isNullVar(_x) then {
			if (_forEachIndex > 0) then {_lockSettings = _lockSettings + ","};
			_lockSettings = _lockSettings + str _x;
		};
	} foreach getSelf(lockedSettings);

	[
		text format["UPDATE Accounts SET Name='%2',Access='%3',Points=%4,CharSettings='[%5]',ClientSettings='[%6]',PlayedRounds=%7,LockedSettings='[%8]' where DiscordId=%1",
		getSelf(discordId),
		getSelf(name),
		[getSelf(access)] call cm_accessNumToType,
		getSelf(points),
		_cliSet
			regexReplace["""/g",""""""], //экранируем двойные кавычки для правильной выгрузки из бд
		_usrSet regexReplace["""/g",""""""],
		getSelf(playedRounds),
		_lockSettings regexReplace["""/g",""""""]
		]
	] call db_query;

	if (rep_system_enable) then {
		[this] call db_saveReputation;
	};
};

//TODO implement
// db_updateAccountInfo = {
// 	params ["_nick","_kvargs"];
// 	if !([_nick] call db_isNickRegistered) exitwith {false};
// 	private _struct = "Update Accounts SET ";

// 	assert(count _kvargs > 0);
// 	if (count _kvargs == 0) exitWith {false};
// 	private _sdat = [];
// 	{
// 		_x params ["_k","_v"];
// 		_sdat pushBack [format["%1='%2'",_k,_v]];
// 	} foreach _kvargs;
// };

db_loadClient = {
	params ['this'];

	([text format["select Name,Access,Points,ClientSettings,CharSettings,FirstJoin,LastJoin,PlayedRounds,LockedSettings from Accounts where DiscordId=%1",getSelf(discordId)],
		"string|string|int|string|string|DateTime|DateTime|int|string",true] call db_query
	) params ["_name","_access","_points","_cliSet","_charSet","_firstJoin","_lastJoin","_playedRounds","_lockedSettings"];

	setSelf(name,_name);
	private _accessNum = [_access] call cm_accessTypeToNum;
	
	#ifdef RELEASE
	if (_access == "ACCESS_PLAYER") then {
		if (([_firstJoin] call db_checkAccessOnFirstSession) && {_playedRounds >= 5}) then {
			_accessNum = ["ACCESS_FORSAKEN"] call cm_accessTypeToNum;
			callSelfAfterParams(localSay,2,"<t size='1.5' color='#00E36E'>Поздравляем!"+sbr+"Вы с нами уже больше месяца и повышаетесь до статуса - Покинутый</t>" arg "");
		};
	};
	if ([_lastJoin] call db_isConnectedFirstTimeToday) then {
		callSelfAfter(showChangelogs,1.5);
	};
	#endif
	
	setSelf(access,_accessNum);
	setSelf(points,_points);
	setSelf(playedRounds,_playedRounds);

	// getting colors
	setSelf(nickColor,[_accessNum] call cm_getNickColorByAccess);
	setSelf(mesColor,[_accessNum] call cm_getMessageColorByAccess);
	
	setSelf(firstJoin,[_firstJoin arg true] call dateTime_toString);
	setSelf(prevDayLastJoin,[_lastJoin arg true] call dateTime_toString);
	setSelf(_firstJoinDB,_firstJoin);

	//locked player settings
	private _lockSets = parseSimpleArray _lockedSettings;
	setSelf(lockedSettings,_lockSets);

	//parse cliset
	private _cliSetList = (parseSimpleArray _cliSet) params ["_keyboard","_graph","_usrsets"];
	private _kbMap = hashMapNew; private _allvals = [];
	{
		if ((_x select 1) in _allvals) then {
			warningformat("db::loadClient() - Wrong keybind <%1> - Already exists",_x select 0);
		} else {
			_kbMap set _x;
			_allvals pushBack (_x select 1);
		};
	} foreach _keyboard;
	_graph = hashMapNewArgs _graph;
	_usrsets = hashMapNewArgs _usrsets;
	setSelf(clientSettings,vec3(_kbMap,_graph,_usrsets));

	private _doNotSetDefaultSettings = false;
	private _settingsArr = parseSimpleArray _charSet;
	private _nativeSettings = + getSelf(charSettings);
	private _roleKey = "";

	for "_i" from 0 to 6 do {

		if (_i >= (count _settingsArr)) then {
			//Создаём буфер для настроек
			_settingsArr set [_i,null];
		} else {
			//Обрабатываем текущий буфер
			_set = _settingsArr select _i;

			//Проверяем существенность
			//пустые настройки не буферизуем
			if (isNullVar(_set) || {count _set == 0}) exitWith {
				if (_i == 0) then {
					_doNotSetDefaultSettings = true;
					warningformat("db::loadClient() - Default charset is null (%1)",_name);
				};
			};

			//Генерируем хэшкарту настроек
			_settingsArr set [_i,createHashMapFromArray (_settingsArr select _i)];
		};
	};

/*	//DO NOT UNCOMMENTED THIS
	private _settings = createHashMapFromArray _settingsArr;


	for "_i" from 1 to 3 do {
		_roleKey = "role"+str _i;
		if (!([_settings get _roleKey] call gm_isDefaultRoleExist) && not_equals(_settings get _roleKey,"none")) then {
			warningformat("db::loadClient() - finded obsolete setting: %1->%2 (client:%3)",_roleKey arg _settings get _roleKey arg getSelf(name));
			_settings set [_roleKey,"none"];
			_hasObsoleteSettings = true;
		};
	};*/

	//загружаем темплейты
	private _charSettingsTemplates = getSelf(charSettingsTemplates);
	for "_i" from 1 to 5 do {
		_charSettingsTemplates set [_i-1,_settingsArr select _i];
	};

	if (!_doNotSetDefaultSettings) then {
		_nativeSettings merge [_settingsArr select 0,true];
		setSelf(charSettings,_nativeSettings);
	};

	[this] call db_updateClientSettings;

	[this,_name] call dsm_accounts_loadDiscordId;

	//load user stats
	private _statsq = "select ArrivedInCity from Stats where DiscordId='%1'";
	private _statsDat = [text format[_statsq,getSelf(discordId)],"int"] call db_query;
	if (count _statsDat > 0) then {
		(_statsDat select 0) params ["_acit"];
		setSelf(arrivedInCity,_acit);
	};
};

//проверяет клиентские настройки. Если что-то не так делает логику...
//При обновлении никнейма, доступа и прочих данных
db_updateClientSettings = {
	params ['this',["_doSyncData",false]];
	private _hasModified = false;
	private _doSyncListRoles = [];

	//check roles
	private _settings = getSelf(charSettings);
	private _bn = callSelf(getBannedRoles);
	{
		if ((_settings get _x) != "none") then {
			private _robj = (_settings get _x) call gm_getRoleObject;
			if (isNullReference(_robj) || {!callFuncParams(_robj,canTakeInLobby,this arg true)} || {callFuncParams(_robj,isAllowedRoleToClient,this arg _bn)}) then {
				_hasModified = true;
				_settings set [_x,"none"];
			};
		};
	} foreach ["role1","role2","role3"];

	if (_doSyncData && _hasModified) then {
		
	};

	if _hasModified then {
		callSelfParams(localSay,"Какие-то настройки были изменены системой." arg "log");
	};
};


db_handleReputation = {
	params ['this'];

	private _res = ([text format["select Reputation,TestResult from Reputations where Name='%1'",getSelf(name)],"int|string"] call db_query);
	if (count _res == 0) then {
		//репутация не зарегана. проходим тестирование
		[this] call rep_startTesting;
	} else {
		(_res select 0) params ["_rep",["_testResult","UNDEFINED"]];
		//он не закончил обучение
		if ("progress" in tolower(_testResult)) exitwith {
			if (true) exitwith {
				[this] call rep_processTesting;
			};

			_res = ([text format["select TestResult,TestQuestions,TestProgress from Reputations where Name='%1'",getSelf(name)],"string|string|string"] call db_query);
			(_res select 0) params ["_testResult","_testQuestions","_testProgress"];
			[this,_testResult,_testQuestions, _testProgress] call rep_continueTesting;
		};
		// null var or empty db entry
		if (_testResult == "UNDEFINED" || _testResult == stringEmpty) exitwith {
			[this] call rep_startTesting;
		};
		setSelf(reputation,_rep);
		setSelf(testResult,_testResult);
	};
};

//сохраняет результаты ответов
//в TestResult записывается структура: status(progress,done)|testNumber(int)|points(int)
//в TestQuestions записывается результирующая строука: Q: Q1_text\nA: Q1_ans\n (e.t.c...)
db_saveReputationTests = {
	params ['this',"_result","_mode"]; //mode was: init, save, done
	/*
	setSelf(__repCurTestId,0);
	setSelf(__repQuestionMap,_questionMap);
	setSelf(__repPoints,0); 
	setSelf(__repQuestionsText,"");
	 */
	if (_mode == "initNODATA") exitwith {
		_result = _result + "|" + str getSelf(__repCurTestId) + "|" + str getSelf(__repPoints);
		private _dataTest = "";
		{
			_x params ["_qT","_aT","_cT"];

			_dataTest = _dataTest + (_qT) + "@" + (_aT joinString "&") + "@" + (_cT joinString "&") + "~";
		} foreach getSelf(__repQuestionMap);
		
		_dataQuestions = getSelf(__repQuestionsText);
		private _query = format["INSERT OR REPLACE INTO Reputations (Name,Reputation,TestResult,DateTested,TestProgress,TestQuestions) VALUES ('%1',%2,'%3',datetime('now','localtime'),'%4','%5')",getSelf(name),0,_result,_dataTest regexReplace ["""/g",""""""],_dataQuestions regexReplace ["""/g",""""""]];
		//[text _query,"string"] call db_query;
	};
	if (_mode == "save" || _mode == "done" || _mode == "init") exitwith {
		_result = _result + "|" + str getSelf(__repCurTestId) + "|" + str getSelf(__repPoints);
		private _q = format["INSERT OR REPLACE INTO Reputations (TestResult,TestQuestions,DateTested,Name) VALUES ('%1','%2',datetime('now','localtime'),'%3')",_result,
			getSelf(__repQuestionsText) regexReplace ["""/g",""""""],
			getSelf(name)
		];
		[text _q,"string"] call db_query;
	};
};

//обычное сохранение репы
db_saveReputation = {
	params ['this'];
	private _query = format["UPDATE Reputations SET DateTested=datetime('now','localtime'),Reputation=%2,TestResult='%3' WHERE Name='%1'",getSelf(name),getSelf(reputation),getSelf(testResult)];
	[text _query,"string"] call db_query;
};

// game manager

//создаем сессию и возвращаем её айди
db_createGamemodeSession = {
	params ["_gmName"];
	
	#ifdef SP_MODE
	if(true) exitWith {floor random 999999};
	#endif

	#ifdef DEBUG
	if (isMultiplayer) exitwith {-1};
	#endif

	//проверяем существующую сессию
	private _res = [text "select max(Id) from Sessions","int",true] call db_query;
	_res params [["_id",0]];
	//increment and create new
	INC(_id);
	private _query = format["INSERT INTO Sessions (Id,Gamemode,Started) VALUES (%1,'%2',datetime('now','localtime'))",_id,_gmName];
	[text _query,"string"] call db_query;

	_id
};

//вызывается когда сессия началась
db_onGamemodeSessionStart = {
	#ifdef DEBUG
	if (isMultiplayer) exitwith {[]};
	#endif

	private _query = format["UPDATE Sessions SET Started=datetime('now','localtime') WHERE Id=%1",gm_currentModeId];
	[text _query,"string"] call db_query;
};

//вызывается когда сессия закончилась
db_onGamemodeSessionEnd = {
	#ifdef DEBUG
	if (isMultiplayer) exitwith {[]};
	#endif

	private _id = gm_currentModeId;
	private _cliList = (gm_internal_ingameClients apply {getVar(_x,name)}) joinString ";";
	private _roundResult = getVar(gm_currentMode,finishResult);
	private _maxClients = cm_maxClients;
	private _query = format["UPDATE Sessions SET Ended=datetime('now','localtime'),ListPlayers='%1',RoundResult='%2',MaxPlayers=%3,Duration=%5 WHERE Id=%4",_cliList,_roundResult,_maxClients,_id,gm_roundDuration];
	[text _query,"string"] call db_query;
};

//Создает запись в таблице голосований
/*
	айди режима, дату начала голосования, персонажи в режиме за которых можно проголосовать (tStruct), список клиентов которые должны голоснуть (просто список) через разделитель |, счетчик сколько должно проголосовать (конст) - полное количество, счетчик сколько уже проголосовало

*/
db_registerNewVote = {
	params ["_id","_charTStruct","_clientList"];

	//объединяем _charTStruct с ; и заменяем двойные кавычки через regex
	_charTStruct = (_charTStruct joinString ";") regexReplace ["""/g",""""""];
	
	private _query = format ["INSERT INTO Votes (GameId,DateStart,CharStructs,Clients,CountNeed) VALUES (%1,datetime('now','localtime'),'%2','%3',%4)",_id,_charTStruct,_clientList joinString ";",count _clientList];
	[text _query,"string"] call db_query;
};

db_registerVoteClient = {
	params ["_id","_name"];

	private _query = format ["INSERT OR REPLACE INTO VotePlayersInfo (Name,LastGameId) VALUES ('%1',%2)",_name,_id];
	[text _query,"string"] call db_query;
};


db_processVoteClient = {
	params ["_name","_vote",["_autoSync",true]];
	//(_best joinString ";") + "|" + (_bad joinString ";")

	private _query = format ["UPDATE VotePlayersInfo SET VoteStruct='%1',VotedTime=datetime('now','localtime') WHERE Name='%2'",_vote,_name];	
	[text _query,"string"] call db_query;
	private _lastId = [text format["SELECT LastGameId FROM VotePlayersInfo WHERE Name='%1'",_name],"int",true] call db_query;
	_lastId params [["_id",-1]];
	if (_id == -1) exitwith {
		errorformat("db::processVoteClient() - Cannot vote client %1; game id not found",_name);
	};
	_query = format ["UPDATE Votes SET CountVoted=CountVoted+1 WHERE GameId=%1",_id];
	[text _query,"string"] call db_query;

	if (_autoSync) then {
		[_id] call db_onSyncReputations;
	};
};

/*
	Событие когда клиент проголосовал.
	1. удаляем все голосования, старше 14 дней 
	и подчищаем все значения в VotePlayersInfo по LastGameId
	2. выбираем все айди в которы проголосовало 2/3 от всех игроков

	3. Собираем по айди всех клиентов в указанной сессии
	4. Получаем у этих клиентов данные голосования за лучших и худших игроков 
	! структура VoteStruct теперь принимает вид: BESTS|BADS -> CharName=RoleClass;CharNam2=RoleClass2;...
	5. Парсим VoteStruct и выполняем голосование
	6. Подсчитываем результаты и получаем данные выбранных игроков (репутация, результат теста). Если за выбранного игрока голосуют в первый раз (testResult == awaitrep) то применяем специальную формулу (+3,-3)
	7. Применяем новое значение репутации и возможно результат теста
	8. удаляем голосование и всех в VotePlayersInfo
 */
db_onSyncReputations = {

	if (!rep_system_enable) exitwith {};

	#ifdef EDITOR
		db_internal_list_maps = [];
		#define __logrepsync(txtval,fmt) [(format[txtval arg fmt]) call {if not_equalTypes(_this,"") then {str _this} else {str parseText _this}},"log"] call chatPrint;
	#else
		#define __logrepsync(txtval,fmt)
	#endif

	//удаляем запросы старше 14 дней
	private _query = "DELETE FROM Votes WHERE DateStart < datetime('now','localtime','-14 days')";
	[text _query,"string"] call db_query;
	_query = "DELETE FROM VotePlayersInfo WHERE LastGameId NOT IN (SELECT GameId FROM Votes)";
	[text _query,"string"] call db_query;

	__logrepsync("db::onSyncReputations() [+++++++STARTED+++++++] - Cleaned old votes",_query);

	//выбираем все айди в которы проголосовало 2/3 от всех игроков
	_query = "SELECT GameId FROM Votes WHERE CountVoted > (SELECT CountNeed FROM Votes) * 0.66";
	private _voteInfo = [text _query,"int"] call db_query;

	__logrepsync("db::onSyncReputations() - Selecting game ids; count %1",count _voteInfo);

	{
		_x params ["_id"];
		_query = format ["SELECT Clients,CharStructs FROM Votes WHERE GameId=%1",_id];
		private _res = [text _query,"string|string"] call db_query;
		(_res select 0) params [["_clients",""],["_charTStruct",""]];

		__logrepsync("db::onSyncReputations() - Processing game id %1; clients %2; char struct %3",_id arg _clients arg _charTStruct);

		private _charData = [];
		private _countBest = 0;
		private _countBad = 0;
		{
			(_x splitString "|") params ["_name","_charName","_roleClass","_flags"];
			_flags = _flags call repvote_deserializeFlags;
			_charData pushback [_name,_charName,_roleClass,_flags];

			if ("earlygame" in _flags) then {
				if ("lowrep" in _flags) exitwith {};
				INC(_countBest);
			};
			INC(_countBad);
		} foreach (_charTStruct splitString ";");
		private _mapClientsData = createHashMap;

		__logrepsync("db::onSyncReputations() - chars count %1; count best %2; count bad %3",count _charData arg _countBest arg _countBad);

		#ifdef EDITOR
		db_internal_list_maps pushback _mapClientsData;
		#endif

		{
			private _ldat = createHashMap;

			//получаем репутацию и результат теста по имени из таблицы Reputations
			_query = format ["SELECT Reputation,TestResult FROM Reputations WHERE Name='%1'",_x];
			_res = [text _query,"string|string"] call db_query;
			
			//cannot find client
			if (count _res == 0) then {
				warningformat("db::onSyncReputations() - Cannot find client by name for collect info - %1",_x);
				continue
			};

			(_res select 0) params [["_reputation","0"],["_testResult",""]];

			__logrepsync("db::onSyncReputations() [REGCLI] - can register new client %1 - %2",_x arg _testResult != "");

			if (_testResult != "") then {
				_mapClientsData set [_x,_ldat];
				(_testResult splitString "|")params [["_tState","ERRUNK"],["_points","0"]];
				_points = parseNumber _points;
				_ldat set ["isawait","awaitrep" in tolower (_tState)];
				_ldat set ["testStatus",_tState];
				_ldat set ["reputation",parseNumber _reputation]; //текущая репа
				_ldat set ["reputationLevel",(_ldat get "reputation") call repvote_reputationToLevel]; //текущая репа в текстовом виде
				_ldat set ["points",_points]; //очки за тест
				_ldat set ["amountedPoints",0];
			};


		} foreach (_clients splitString ";");
		
		//После генерации карты клиентов собираем все VoteStruct из VotePlayersInfo по айди игры
		_query = format ["SELECT VoteStruct,Name FROM VotePlayersInfo WHERE LastGameId=%1",_id];
		_clientVoteResult = [text _query,"string|string"] call db_query;
		{
			_x params ["_voteStruct","_voterName"];
			
			if (_voteStruct == "") then {continue};
			(_voteStruct splitString "|") params [["_best",""],["_bad",""]];

			//парсим лучших. разделитель ;
			// при голосовании за лучшего накидываем баллы по имени в соответствии с его уровнем
			{
				(_x splitString "=") params [["_name",""],["_roleClass",""]];
				_pts = 1;
				_lvl = _mapClientsData get _name get "reputationLevel";
				if (_lvl == 6) then {modvar(_pts) * 0.7};
				if (_lvl > 6) then {modvar(_pts) * 0.5};

				//голос игроков со сниженной репутацией имеет пониженную силу
				if ((_mapClientsData get _voterName get "reputationLevel") <= -2) then {modvar(_pts) * 0.5};
				
				_mapClientsData get _name set ["amountedPoints",(_mapClientsData get _name get "amountedPoints") + _pts];
			} foreach (_best splitString ";");
			//парсим худших
			{
				(_x splitString "=") params [["_name",""],["_roleClass",""]];
				_pts = 1;
				_lvl = _mapClientsData get _name get "reputationLevel";
				if (_lvl == 2) then {modvar(_pts) * 1.5};
				if (_lvl == 1) then {modvar(_pts) * 2};
				if (_lvl == 0) then {modvar(_pts) * 3};
				
				if (_lvl == 7) then {modvar(_pts) * 0.66};
				if (_lvl == 8) then {modvar(_pts) * 0.5};
				
				//голос игроков со сниженной репутацией имеет пониженную силу
				if ((_mapClientsData get _voterName get "reputationLevel") <= -2) then {modvar(_pts) * 0.5};

				_mapClientsData get _name set ["amountedPoints",(_mapClientsData get _name get "amountedPoints") - _pts];
			} foreach (_bad splitString ";");

			__logrepsync("db::onSyncReputations() [POINTCOUNTER] - client %1 - accum vote points = %2",_voterName arg _mapClientsData get _voterName);

		} foreach _clientVoteResult;

		//после подсчета всех голосований производим расчеты и выбираем победителей
		//если количество больше чем число игроков в типе голосования (за лучшего или худшего)
		{
			_pts = _mapClientsData get _x get "amountedPoints";
			
			//за кого не голосовали - пропускаем
			if (_pts == 0) then {continue};

			_repMod = 0;
			if (_pts > 0) then {
				if (_pts > /*round*/(_countBest/2/2.3)) then {
					INC(_repMod)
				};
			} else {
				if ((abs _pts) > /*round*/(_countBad/3/2.3)) then {
					DEC(_repMod)
				};
			};
			
			

			__logrepsync("db::onSyncReputations() [REPAPPLY] - client %1 - repMod = %2",_x arg _repMod);

			if (_repMod != 0) then {
				_oldRep = _mapClientsData get _x get "reputation";
				
				if (_mapClientsData get _x get "isawait") then {
					_testReward = _mapClientsData get _x get "points";
					_testReward = clamp(_testReward,0,5);
					_testApplyficator = [-3,-2,-1,1,2,3]; //значения от результатов теста
					if (_testReward <= 2) then {
						// тест сдан плохо
						if (_repMod < 0) then {
							_repMod = _testApplyficator select _testReward;
						} else {
							_repMod = 0;
						}
					} else {
						// тест сдан хорошо
						if (_repMod > 0) then {
							_repMod = _testApplyficator select _testReward;
						} else {
							_repMod = 0;
						}
					};

					//устанавливаем новый testResult в бд
					_mapClientsData get _x set ["testStatus","done"];

					__logrepsync("db::onSyncReputations() [TESTRESULT] - client %1 - new repmod = %2",_x arg _repMod);
				};

				//обновляем Reputation и TestResult по имени в базе данных
				_qSet = format["UPDATE Reputations SET Reputation = %1, TestResult = '%2' WHERE Name = '%3'",clamp(_oldRep + _repMod,-10,30),
				[
					_mapClientsData get _x get "testStatus",
					_mapClientsData get _x get "points"
				] joinString "|",_x];
				[text _qSet,"string"] call db_query;

				__logrepsync("db::onSyncReputations() [REPAPPLY] - client %1 - new rep = %2; test status: %3",_x arg _oldRep + _repMod arg _mapClientsData get _x get "testStatus");

				// TODO Если клиент был в игре устанавливаем ему новые данные
			};
		} foreach (keys _mapClientsData);

		//удаляем голосование по айди игры
		_qDel = format["DELETE FROM Votes WHERE GameId = %1",_id];
		[text _qDel,"string"] call db_query;
		//удаляем все записи из VotePlayersInfo по LastGameId
		_qDel2 = format["DELETE FROM VotePlayersInfo WHERE LastGameId = %1",_id];
		[text _qDel2,"string"] call db_query;

	} foreach _voteInfo;

	#ifdef EDITOR
	db_internal_list_maps
	#endif
};


db_hasNeedClientVote = {
	params ["_name",["_reputation",""],"_refInfo"]; //refset(_refInfo,[_best arg _bad])

	#ifdef DISABLE_VOTING_SYSTEM
	if (true) exitwith {false};
	#endif

	private _q = format["SELECT VoteStruct,LastGameId FROM VotePlayersInfo WHERE Name = '%1'",_name];
	_q = [text _q,"string|string"] call db_query;
	//его записи нет в таблице
	if (count _q == 0) exitwith {false};
	(_q select 0) params ['_voteStruct','_lastGameId'];
	if (_voteStruct != "") exitwith {false};

	//получаем срез игроков с этого айди
	_q = format["SELECT CharStructs FROM Votes WHERE GameId = %1",_lastGameId];
	_q = [text _q,"string"] call db_query;
	if (count _q == 0) exitwith {
		//Ошибка! выводим в консоль и удаляем из бд
		errorformat("db::hasNeedClientVote() - cant find game with id %1",_lastGameId);
		_q = format["DELETE FROM VotePlayersInfo WHERE Name = %1",_name];
		[text _q,"string"] call db_query;
		_q = format["DELETE FROM Votes WHERE GameId = %1",_lastGameId];
		[text _q,"string"] call db_query;
		false
	};
	(_q select 0) params ['_charTStruct'];
	_rv_list_unpacked = [];
	{
		(_x splitString "|") params ["_name","_charName","_roleClass","_flags"];
		_rv_list_unpacked pushBack [_name,_charName,_roleClass,_flags call repvote_deserializeFlags];
	} foreach (_charTStruct splitString ";");
	private _bestPla = [];
	private _badPla = [];

	//репа говно. он не голосует
	// даже с хуёвой репой он по логике должен голоснуть. иначе голосование локнется
	//if (_reputation <= -4) exitwith {false};

	//персональная модификация. тут собираются списки лучших и худших
	_cName = _name;
	{
		_x params ["_name","_nick","_role","_flags"]; 
		
		// исключаем локального игрока из голосования
		if (_name == _cName) then {
			continue;
		};
		// на голосование за лучших добавляем только тех, кто зашёл в первые 20 минут
		if ("earlygame" in _flags) then {
			// исключаются игроки с репутационнм требованием (проверка через флаг)
			if ("lowrep" in _flags) exitwith {};
			_bestPla pushBack ([_name,_nick,getVar(_role call gm_getRoleObject,name),_role] joinString "|");
		};

		// на голосование за худших добавляем всех, кроме тех у кого роли: TOMMonsterRole и TheEssenseRole
		if (_role in ["TOMMonsterRole","TheEssenseRole"]) then {
			continue;
		};
		_badPla pushBack ([_name,_nick,getVar(_role call gm_getRoleObject,name),_role] joinString "|");

	} foreach _rv_list_unpacked;

	refset(_refInfo,[_bestPla arg _badPla]);

	true
};

//======================================
// Discord accounting
//======================================
//! not used
db_da_isSynced = {
	params ["_nick","_refId",["_loadArrived",false]];
	private _res = if(_loadArrived) then {
		([text format["select DiscordId,ArrivedInCity from Discord where Nick='%1' COLLATE NOCASE",_nick],"string|int"] call db_query);
	} else {
		([text format["select DiscordId from Discord where Nick='%1' COLLATE NOCASE",_nick],"string"] call db_query);
	};
	
	if (count _res == 0) exitwith {false};

	if (_loadArrived) then {
		refset(_refId,_res select 0);
	} else {
		refset(_refId,_res select 0 select 0);
	};

	true
};

//! not used
db_da_isSyncedAsDiscordId = {
	params ["_id"];
	private _res = ([text format["select Nick from Discord where DiscordId='%1' COLLATE NOCASE",_id],"string"] call db_query);
	if (count _res == 0) exitwith {false};
	true
};

//! not used
db_da_updateArrivedInCity = {
	params ["_nick"];
	if ([_nick] call db_da_isSynced) exitwith {
		private _cli = [_nick,true] call cm_findClientByName;
		private _query = format["UPDATE Discord SET ArrivedInCity=%2 where Nick='%1' COLLATE NOCASE",
			_nick,
			getVar(_cli,arrivedInCity)
		];
		[text format[_query,_uid]] call db_query;
		true
	};
	false
};

//! not used
db_da_register = {
	params ["_nick","_discordid"];
	private _query = "INSERT INTO Discord (Nick,DiscordId,AddedDate,ArrivedInCity)" +
	"VALUES('%1','%2',datetime('now','localtime'),0)";

	[text format[_query,_nick,_discordid]] call db_query
};

//обновляем статистику посещения города
db_da_updateStatArrivedInCity = {
	params ["_client"];
	if isNullReference(_client) exitWith {};
	private _query = format["UPDATE Stats SET ArrivedInCity=%2 where DiscordId='%1'",
		getVar(_client,discordId),
		getVar(_client,arrivedInCity)
	];
	[text format[_query,_uid]] call db_query
};

//======================================
// Legacy db porting
//======================================

//port handler, if true - successed port from old account
db_port_oldAccountRegistered = {
	params ["_did"];
	private _query = "select Nick,ArrivedInCity from Discord_OLD where DiscordId='%1'";
	private _dusr = ([text format[_query,_did],"string|int"] call db_query);
	if (count _dusr == 0) exitwith {false};
	(_dusr select 0) params ["_nickLwr","_arrCity"];

	_query = "select Name,Access,Points,ClientSettings,CharSettings,CountConnections,PlayedRounds,FirstJoin,LockedSettings from Accounts_OLD where Name=='%1' COLLATE nocase";
	private _dacc = ([text format[_query,_nickLwr],
		"string|string|int|string|string|int|int|string|string"
	] call db_query);
	if (count _dacc == 0) exitwith {false};
	(_dacc select 0) params ["_name","_acc","_pt","_cset","_chset","_ccn","_pr","_fj","_lset"];


	_query = "INSERT INTO Accounts (DiscordId,Name,Access,Points,ClientSettings,CharSettings,LockedSettings,CountConnections,PlayedRounds,FirstJoin,LastJoin)" +
	"VALUES('%1','%2','%3',%4,'%5','%6','%7',%8,%9,'%10',datetime('now','localtime'))";

	[text format[_query
		,_did
		,_name
		,_acc
		,_pt
		,_cset regexReplace["""/g",""""""]
		,_chset regexReplace["""/g",""""""]
		,_lset regexReplace["""/g",""""""]
		,_ccn
		,_pr
		,_fj
	]] call db_query;

	//add arrived in city info
	[_did,_arrCity] call db_registerStats;

	true
};
