// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================


//для добавления этого клиента в локалке
#define gamemode_testing_antags

//опционал выключаем: доступно только в редакторе и режиме отладки
#ifndef DEBUG
	#undef gamemode_testing_antags
#endif
#ifndef EDITOR
	#undef gamemode_testing_antags
#endif

//инициализирует или сбрасывает все переменные а так же запускает основной поток игры
gm_init = {
	gm_roundDuration = 0; //в секундах (сколько уже длится этот раунд)
	gm_roundName = ""; //имя раунда. Строка

	gm_historyAspect = -1;//аспект истории

	//stop all threads if exists
	if (gm_handleMainLoop != -1) then {
		stopUpdate(gm_handleMainLoop);
	};
	gm_handleMainLoop = -1;
	if (gm_handleLobbyLoop != -1) then {
		stopUpdate(gm_handleLobbyLoop);
	};
	gm_handleLobbyLoop = -1;
	
	//Устанавливаем пре лобби таймер
	gm_lobbyTimeLeft = PRE_LOBBY_AWAIT_TIME;

	gm_lobbyLowOnlineTimeLeft = PRE_LOBBY_LOW_ONLINE_AWAIT;
	
	//Запускаем прелобби ожидание
	//copied and changed from GameMode_ThreadLobby.sqf
	private _code = {
		FHEADER;
		
		// #ifndef EDITOR
		// if (gm_canVote && {!isNullReference(ACCESS_ADMIN call cm_findClientByAccessLevel)}) then {
		// 	gm_canVote = false;
		// 	["Админ в чати, голосование офф.","system"] call cm_sendOOSMessage;
		// };
		// #endif
		
		if (!gm_lobbyCanProcessTime) exitWith {};

		#ifndef TEST_WHITELISTED
		if (count (call cm_getAllClientsInLobby) <= 3) exitWith {
			DEC(gm_lobbyLowOnlineTimeLeft);
			if (gm_lobbyLowOnlineTimeLeft < 0) exitWith {
				stopThisUpdate();
				gm_preLobbyHandler = -1;
				["Народа маловато. Расход!","system"] call cm_sendOOSMessage;
				gm_lobbyCanProcessTime = false;
				invokeAfterDelay(server_end,5);
				RETURN(0);
			};
			if (gm_lobbyLowOnlineTimeLeft%60 == 0) then {
				[format["Низкий онлайн. Если не наберется больше 3х игроков, сервер выключится через %1 секунд",gm_lobbyLowOnlineTimeLeft]] call cm_sendOOSMessage;
			};
		};
		#endif

		DEC(gm_lobbyTimeLeft);
		gm_lobbyLowOnlineTimeLeft = PRE_LOBBY_LOW_ONLINE_AWAIT;
		
		//Каждые 5 секунд проверяем пора ли кончать раунд
		if (gm_lobbyTimeLeft%6==5) then {
			
			USEEVERYDAYRUN_doValidation();
			if (gm_isLastRound) then {
				stopThisUpdate();
				gm_preLobbyHandler = -1;
				["Видимо не судьба сегодня больше поиграть. Выключаемся...","system"] call cm_sendOOSMessage;
				gm_lobbyCanProcessTime = false;
				invokeAfterDelay(server_end,5);
				RETURN(0);
			};
		};
		
		_allClients = call cm_getAllClientsInLobby;
		
		if (call gm_voteProcess) then {
			gm_lobbyTimeLeft = -1;
		};

		if (gm_lobbyTimeLeft < 0) then {
			
			//по истечению таймера и если игроков мало, то выключаемся
			if (count _allClients <= 3) exitWith {
				stopThisUpdate();
				gm_preLobbyHandler = -1;
				["Народа маловато. Расход!","system"] call cm_sendOOSMessage;
				gm_lobbyCanProcessTime = false;
				invokeAfterDelay(server_end,5);
				RETURN(0);
			};
			
			// После конца таймера мы хардкорно выбираем режим
			//gm_canVote
			// if (
			// 	#ifndef EDITOR
			// 	count _allClients <= 1 ||
			// 	#endif
			// 	(gm_canVote && !call gm_voteProcess)) exitWith {
			// 	if (gm_canVote) then {
			// 		[format["Мало проголосовавших. Ждём ещё %1 секунд",PRE_LOBBY_AWAIT_TIME],"system"] call cm_sendOOSMessage;
			// 	} else {
			// 		[format["Игроков маловато. Ждём ещё %1 секунд",PRE_LOBBY_AWAIT_TIME],"system"] call cm_sendOOSMessage;
			// 	};
			// 	//Устанавливаем пре лобби таймер заново
			// 	gm_lobbyTimeLeft = PRE_LOBBY_AWAIT_TIME;
			// };
			
			//Выбираем рандомный режим или голосованный
			if (gm_canVote && gm_votedMode != "") then {
				gm_canVote = false; //снимаем флаг голосования
				[gm_votedMode] call gm_initGameMode;
			} else {
				[] call gm_initGameMode;
			};
			RETURN(0);
		};
		
		{
			netSendVar("lobby_timeLeft",gm_lobbyTimeLeft,callFunc(_x,getOwner));
		} foreach _allClients;

	};
	gm_preLobbyHandler = startUpdate(_code,1);
};

//Выполняет рестарт раунда
gm_restart = {
	["gm::restart() - called"] call gameLog;
	//#define implementation_dynamic_restart

	//Пока полностью не реализовано высвобождение памяти использовать полный перезапуск сервера
	#ifndef implementation_dynamic_restart
		if (true) exitWith {
			call server_restart;
		};
	#endif

	call gm_init;

	//очистка серверной памяти
	#include "GamemodeRestart.sqf"


};

gm_getLobbySoundsCount = {
	getNumber((if(isServer && isMultiplayer)then{configFile}else{missionConfigFile}) >> "cfgMusic" >> ("lobby" + "_count"))
};

gm_setLobbySound = {
	params [["_number_name_rnd","random"]];
	if equalTypes(_number_name_rnd,0) exitWith {
		errorformat("gm::setLobbySound() - unsupported param type - %1",typeName _number_name_rnd);
		if (true) exitWith {}; 
		//! недостижимый код
		
		if (floor _number_name_rnd != _number_name_rnd) exitWith {
			errorformat("gm::setLobbySound() - Argument is not int32 value: %1",_number_name_rnd);
		};
		if (_number_name_rnd > call gm_getLobbySoundsCount || _number_name_rnd < 1) exitWith {
			errorformat("gm::setLobbySound() - Int value out of range: %1",_number_name_rnd);
		};
		netSetGlobal(music_lobbyTheme,"lobby_" + _number_name_rnd);
	};
	if equalTypes(_number_name_rnd,"") exitWith {
		if (_number_name_rnd == "random") then {
			errorformat("gm::setLobbySound() - unsupported param - %1",_number_name_rnd);
			_number_name_rnd = "lobby_" + str randInt(1,call gm_getLobbySoundsCount);
		};
		netSetGlobal(music_lobbyTheme,_number_name_rnd);
		{
			callFuncParams(_x,sendInfo,"onMusicSetupLobby");
		} foreach cm_allClients;
	};
	errorformat("gm::setLobbySound() - Wrong argument format - %1",typeName _number_name_rnd);
};

// for checking gamemode states visit src\host\CommonComponents\Gamemode.sqf

gm_onChangeState = {
	params ["_newState"];

	[format["gm::onChangeState() - new state is %1 (%2)",_newState,_newState call gm_getState]] call gameLog;

	private _oldState = gm_state;
	netSetGlobal(gm_state,_newState);
	rpcSendToAll("onChangeGameState",[_oldState arg _newState]);
	if (_oldState == GAME_STATE_PRELOAD) then {
		{
			callFuncParams(_x,removeSystemAction,"system" arg "system_votemode");
		} foreach cm_allClients;
	};

};

gm_startMainThread = {
	private _code = {
		#include "GameMode_ThreadMain.sqf"
	};

	private _handle = startUpdate(_code,1);
	if (_handle >= 0) then {
		gprintformat("Main thread launched. Handle %1",_handle);
		gm_handleMainLoop = _handle;
	} else {
		errorformat("gm::startMainThread() - Cant launch main thread. Handle return %1",_handle);
	};
};

gm_startLobbyThread = {
	private _code = {
		#include "GameMode_ThreadLobby.sqf"
	};

	private _handle = startUpdate(_code,1);
	if (_handle >= 0) then {
		gprintformat("Lobby thread launched. Handle %1",_handle);
		gm_handleLobbyLoop = _handle;
	} else {
		errorformat("gm::startLobbyThread() - Cant launch lobby thread. Handle return %1",_handle);
	};
};

gm_startEventHandle = {
	
	if callFunc(gm_currentMode,canPlayEvents) then {
		private _event = {
			//initial state
			if (gm_nextEventPlay == 0) then {
				gm_nextEventPlay = tickTime + randInt(callFunc(gm_currentMode,getMinPlayEventTime),callFunc(gm_currentMode,getMaxPlayEventTime));
			};

			if (tickTime >= gm_nextEventPlay) then {
				//shot event
				call gameEvents_process;
				gm_nextEventPlay = tickTime + randInt(callFunc(gm_currentMode,getMinPlayEventTime),callFunc(gm_currentMode,getMaxPlayEventTime));
			};
		};
		gm_handleEvents = startUpdate(_event,1);
	};
};


//Инициализация режима. Выполняет основные сабсистемы раннера: загрузка карты, подгрузка ролей, перевод в стейт лобби
gm_initGameMode = {
	// if name == string.empty then select random mode...
	params [["_name",""]];
	
	if !isNullReference(gm_currentMode) exitWith {};
	
	if (gm_preLobbyHandler != -1) then {
		stopUpdate(gm_preLobbyHandler);
		gm_preLobbyHandler = -1;
	};
	//reset lobby time
	gm_lobbyTimeLeft = gm_lobbyTimeToStart;
	
	private _loadingTime = tickTime;
	gprintformat("Start loading game mode <%1>",_name);
	
	["Загружаем режим...","system"] call cm_sendLobbyMessage;
	
	["    Пишем правила...","system"] call cm_sendLobbyMessage;
	private _modeObj = [_name] call gm_pickMode;
	if isNullReference(_modeObj) exitWith {
		errorformat("gm::initGameMode() - cant initialize mode %1",_name);
		["ОШИБКА ЗАГРУЗКИ РЕЖИМА. Что-то пошло не так.","system"] call cm_sendLobbyMessage;
	};
	callFunc(gm_currentMode,onModeSetup);

	setGameModeName(getVar(gm_currentMode,name));
	
	//инициализируем субсистемы
	#ifdef DO_NOT_CREATE_MAP
	private __DO_NOT_CREATE_MAP__ = true;
	#endif
	
	//Загрузка карты
	//Загрузка самой реликтовской карты
	["    Строим Сеть...","system"] call cm_sendLobbyMessage;
	private _errMapLoading = false;
	if isNullVar(__DO_NOT_CREATE_MAP__) then {
		private _mapName = callFunc(gm_currentMode,getMapName);
		if (_mapName != "") then {
			private _loaded = [_mapName] call mapManager_load;
			if (!_loaded) then {
				_errMapLoading = true;
				["<t size='2'>Карта не установлена. Требуется перезапуск</t>","system"] call cm_sendLobbyMessage;
				setLastError("Map loading '"+_mapName+"' error; See console for more details");
			};
		};
	};
	if (_errMapLoading) exitWith {};
	
	["    Придумываем должности...","system"] call cm_sendLobbyMessage;
	{
		addPreStartRole(_x);
	} foreach callFunc(gm_currentMode,getLobbyRoles);
	
	["    Ищем выживших в пещерах...","system"] call cm_sendLobbyMessage;
	{
		addLateRole(_x);
	} foreach callFunc(gm_currentMode,getLateRoles);
	
	private _pic = callFunc(gm_currentMode,getLobbyBackground);
	if isTypeOf(gm_currentMode,ScriptedGamemode) then {
		if !([_pic,PATH_PICTURE("")] call stringStartWith) then {
			_pic = PATH_PICTURE(_pic);
		};
	};
	netSetGlobal(lobby_background,_pic);
	[callFunc(gm_currentMode,getLobbySoundName)] call gm_setLobbySound;
	
	["    Наполняем местность жизнью...","system"] call cm_sendLobbyMessage;
	call gm_startLobbyThread;
	
	gprintformat("Game mode <%1> loaded!",_modeObj);

	call gm_syncRolelistToAllClients;

	//Проверяем дефолтные роли из режима
	{
		[_x] call gm_validateAvailableRoles;
	} foreach cm_allClients;

	[GAME_STATE_LOBBY] call gm_onChangeState;

	_loadingTime = round((tickTime - _loadingTime)*1000);
	[format["Сеть построена за %1 %2",_loadingTime,[_loadingTime,["день","дня","дней"]] call toNumeralString],"system"] call cm_sendLobbyMessage;
	[format["<t size='1.3'>Смена %1 готова!</t>",gm_currentModeId],"system"] call cm_sendLobbyMessage;
	
	#ifdef EDITOR
	["Campfire",[1931.15,2214.4,5.36588],null,false] call createStructure;
	#endif
	
	//Предустановка
	callFunc(gm_currentMode,preSetup);

	[format["Gamemode setup done - %1; Round id: %2",callFunc(gm_currentMode,getClassName),gm_currentModeId]] call gameLog;
};

//Загружает игровой режим. Запускает потоки лобби
gm_loadGamemode = {

	params ["_modeName","_gmName"];
	private _loadingTime = tickTime;

	private _path = gm_modesFolder + _modeName + "\init.sqf";

	gprintformat("Start loading game mode <%1>",_modeName);
	["Загружаем режим...","system"] call cm_sendLobbyMessage;

	private _code = compile preprocessFileLineNumbers (_path);

	if (isNullVar(_code) || {equals(_code,{})}) exitWith {
		errorformat("Cant load game mode <%1>. Path (%2) not found or script error.",_modeName arg _path);
	};

	gm_gameModeClass = _modeName;

	//cleanup rolesarray
	//gm_roles = createHashMap;

	call _code;

	call gm_startLobbyThread;

	gprintformat("Game mode <%1> loaded!",_modeName);

	call gm_syncRolelistToAllClients;

	//Проверяем дефолтные роли из режима
	{
		[_x] call gm_validateAvailableRoles;
	} foreach cm_allClients;

	[GAME_STATE_LOBBY] call gm_onChangeState;

	private _msLoad = _loadingTime;
	_loadingTime = round((tickTime - _loadingTime)*1000);
	[format["Сеть построена за %1 %2",_loadingTime,[_loadingTime,["день","дня","дней"]] call toNumeralString],"system"] call cm_sendLobbyMessage;

	[format["Gamemode loaded - %1 at %2 sec",callFunc(gm_currentMode,getClassName),_msLoad]] call gameLog;
};

gm_pickMode = {
	params [["_name",""]];

	if !isNullReference(gm_currentMode) exitWith {
		errorformat("gm::pickMode() - Game mode already setted on %1",gm_currentMode);
		nullPtr
	};

	if (_name != "") exitWith {
		[format["(gm::pickMode) - forced setup to mode %1",_name]] call gameLog;

		private _modeObj = missionNamespace getVariable ["story_"+_name,nullPtr];
		if isNullReference(_modeObj) exitWith {errorformat("gm::pickMode() - Cant find game mode %1",_name); nullPtr};
		gm_currentMode = _modeObj;
		["Установлена пользовательская история.","system"] call cm_sendLobbyMessage;
		gm_currentMode
	};
	
	private _struct = [];
	private _hashAssoc = createHashMap;
	private _lobbyClientList = call cm_getAllClientsInLobby;
	private _ingamePlayers = count _lobbyClientList;
	
	//collect antags

	{
		private _modeObj = missionNamespace getVariable ["story_"+_x,nullPtr];
		if isNullReference(_modeObj) then {
			errorformat("Unknown gamemode %1",_x);
			continue;
		} else {

			//Если клиентов меньше какого-то значения
			if (
				_ingamePlayers < callFunc(_modeObj,getReqPlayersMin)  ||
				_ingamePlayers > callFunc(_modeObj,getReqPlayersMax)
			) exitWith {
				
			};

			private _prior = str rand(0,callFunc(_modeObj,getProbability)/100);

			_struct pushBack _prior; //добавляем приоритет
			_preval = _hashAssoc get _prior; //добавляем ассоциацию приоритета клиента
			if isNullVar(_preval) then {
				_hashAssoc set [_prior,[_modeObj]];
			} else {
				_preval pushBack _modeObj;
			};
		};

	} foreach gm_allowedModes;
	
	logformat("[GM:PICKMODE]: List modes %1",_hashAssoc);
	
	//Сортируем приоритеты
	_struct sort false;

	private _outputList = [];
	private _keyList = [];

	{
		_keyList = _hashAssoc get _x;
		if (count _keyList > 1) then {
			_keyList = _keyList call BIS_fnc_arrayShuffle;
		};
		_outputList append _keyList;

	} foreach _struct;

	if (count _outputList == 0) then {
		errorformat("gm::pickMode() - Cant select mode. List modes empty. Select by default %1", gm_defaultMode);
		gm_currentMode = missionNamespace getVariable ("story_"+gm_defaultMode);
	} else {
		gm_currentMode = _outputList select 0;
	};
	[format["(gm::pickMode) - random gamemode is %1",callFunc(gm_currentMode,getClassName)]] call gameLog;
	gm_currentMode
};

//синхронизирует со всеми клиентами ролелист
gm_syncRolelistToAllClients = {
	{
		[_x] call gm_syncRolelistToClient;
	} foreach cm_allClients;

};

//отсылает клиенту все доступные роли для лобби или игры
gm_syncRolelistToClient = {
	params ["_cli"];

	/*private _replicatedList = if (call gm_isRoundLobby) then {
		//Вариант с кешированием = доп.производительность
		if (gm_isCachedDefaultRoles) then {
			gm_chachedDefaultRoles
		} else {
			private _list = [];
			{
				//["_cls","_name","_desc","_ind"]
				_list pushBack [callFunc(_x,getClassName),getVar(_x,name),getVar(_x,desc),_forEachIndex];
			} foreach gm_preStartRoles;
			gm_chachedDefaultRoles = _list;
			reverse gm_chachedDefaultRoles; //список в обратном порядке
			gm_isCachedDefaultRoles = true;
			gm_chachedDefaultRoles
		}

	} else {
		error("gm::syncRolelistToClient() - not allowed in non lobby");
		[]
		//gm_roles apply {[_x select ROLE_CLASS,_x select ROLE_NAME]};
	};*/
	private _replicatedList = if (gm_isCachedDefaultRoles) then {
		gm_chachedDefaultRoles
	} else {
		private _list = [];
		{
			//["_cls","_name","_desc","_ind"]
			_list pushBack [callFunc(_x,getClassName),getVar(_x,name),getVar(_x,desc),_forEachIndex];
		} foreach gm_preStartRoles;
		gm_chachedDefaultRoles = _list;
		reverse gm_chachedDefaultRoles; //список в обратном порядке
		gm_isCachedDefaultRoles = true;
		gm_chachedDefaultRoles
	};

	rpcSendToClient(callFunc(_cli,getOwner),"loadRoles",_replicatedList);
};

//Добавляет претендента в лист претендентов на выбранную роль (не забыв удалить при этом предыдущий приоритет)
gm_addContenderToRole = {
	params ["_client","_roleClass","_priority",["_oldRoleName","none"],["_doNeedSyncAfterSet",false]];

	private _oldValue = _oldRoleName;

	#define getRoleByClass(val) (missionNamespace getVariable ["role_"+(val),nullPtr])

	private _hasRandomRole = _roleClass == "none";
	
	private _roleData = getRoleByClass(_roleClass);
	if (isNullReference(_roleData) && !_hasRandomRole) exitWith {
		errorformat("gm::addContenderToRole() - Cant find role <%1>. Selected by default 0 index",_roleClass);
		false;
	};

	//removing previous role contender
	if (_oldValue != "none") then {

		//first step - remove client from old contenders
		private _oldData = getRoleByClass(_oldValue);
		if isNullReference(_oldData) then {
			warningformat("gm::addContenderToRole() - Cant find old role <%1>.",_oldValue);
		} else {

			private _oldContenders = getVarReflect(_oldData,"contenders_"+str _priority);
			private _oldClientIndex = _oldContenders findif {equals(_x,_client)};
			if (_oldClientIndex == -1) then {
				warningformat("gm::addContenderToRole() - Cant find client for remove in role %1",_oldValue);
			} else {
				//now we finded client! Remove him
				_oldContenders deleteAt _oldClientIndex;
			};
		};

		//second step - just add role to contenders
	};

	if (!_hasRandomRole) then {

		private _contenders = getVarReflect(_roleData,"contenders_"+str _priority);
		private _probContInd = _contenders findif {equals(_x,_client)};

		if (_probContInd != -1) then {
			warningformat("gm::addContenderToRole() - Contender already added to role <%1>. Priority %2",_roleClass arg _priority);
		} else {
			_contenders pushBack _client;
		};

	};

	//finaly do sync info
	if (_doNeedSyncAfterSet) then {
		(_priority-1) call gm_syncRoleContenders;
		trace("SYNC CONTENDERS PROCESS LAUNCHED")
	};

	traceformat("Contenders now %1 for role %2",getVarReflect(_roleData,"contenders_"+str _priority) arg _roleData)
	true;
};

//синхронизирует со всеми клиентами информацию о занятых ролях
gm_syncRoleContenders = {
	private _idxContenders = _this;
	private _roles = [];

	if (call gm_isRoundLobby) then {

		private _contenders = [];
		private _cliToRole = [];
		private _ignrolesClients = [];
		{
			_cliToRole = [];
			_contenders = getVar(_x,contenders_1); //обрабатываются только роли первого приоритета
			{
				_cliToRole pushBack getVar(_x,name);
				_ignrolesClients pushBack _x;
				//_cliToRole pushBack "Игрок " + str floor random 1000;_cliToRole pushBack "Игрок " + str floor random 1000;
			} foreach _contenders;

			if (count _cliToRole > 0) then {
				_roles pushBack [getVar(_x,name),_cliToRole];
			};

		} foreach gm_preStartRoles;

		private _rlist = [];
		{
			if (getVar(_x,isReady) && !(_x in _ignrolesClients)) then {
				_rlist pushBack getVar(_x,name);
			};
		} foreach (call cm_getAllClientsInLobby);
		if (count _rlist > 0) then {
			_roles pushBack ["(СЛУЧАЙНАЯ РОЛЬ)",_rlist];
		};

		{
			netSendVar("lobby_RoleContenders",_roles,callFunc(_x,getOwner))
		} foreach (call cm_getAllClientsInLobby);

		gm_roleContenders set [_idxContenders,_roles];

	} else {

		{
			if (count getVar(_x,embark) > 0) then {
				private _cls = getVar(_x,embark) apply {getVar(_x,name)};
				_roles pushBack [getVar(_x,name),_cls];
			};
		} foreach gm_embarks;

		{
			netSendVar("lobby_RoleContenders",_roles,callFunc(_x,getOwner))
		} foreach (call cm_getAllClientsInLobby);

		//error("gm::syncRoleContenders() - not implemented in non-lobby mode");
	};
};

//Проверяет наличие роли в списке дефолтных ролей. Принимает ссылку на объект роли или строковое название
gm_isPreStartRoleExist = {
	params ["_roleClass"];
	private _probRoleData = ifcheck(equalTypes(_roleClass,nullPtr),_roleClass,missionNamespace getVariable vec2("role_"+_roleClass,nullPtr));

	if isNullReference(_probRoleData) exitWith {false};

	(gm_preStartRoles find _probRoleData)!=-1
};

//Осуществляет проверку наличия класса роли. Не учитывается статус роли количество и прочие факторы. Просто проверщик
//! not used anywhere...
gm_isRoleExists = {
	params ["_roleClass"];
	private _probRoleData = missionNamespace getVariable ["role_"+_roleClass,nullPtr];

	if isNullReference(_probRoleData) exitWith {false};

	true
};

gm_getRoleObject = {getRoleObject(_this)};

//Получаем объект игрового режима
gm_getGameModeObject = {missionNamespace getVariable ["story_"+_this,nullPtr]};

// Подготавливает описание роли, заменяя куски текста на \n
gm_prepDesc = {
	private _textCounter = 40;
	forceUnicode 0;
	private _sourceText = _this;
	if (_sourceText == "" || true) exitWith {_sourceText};

	// TODO done this function
	for "_i" from 0 to floor(count _sourceText / _textCounter) do {
		_sourceText = _sourceText insert [_i * _textCounter + 2 * _i,"\n"];
	};

	_sourceText
};

gm_printRoleNamesEx = {
	private _list = [];
	
	{
		_y params ["_name"];
		_list pushBack (parseSimpleArray ("RelictaNC" callExtension _name))

	} foreach gm_defaultRoles;
	{
		_y params ["_name"];
		_list pushBack (parseSimpleArray ("RelictaNC" callExtension _name))

	} foreach gm_roles;
	_list
};
