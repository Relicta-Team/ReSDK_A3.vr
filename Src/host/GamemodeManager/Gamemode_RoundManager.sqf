// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

//проверка эмуляции подключения клиентов. значение является количеством клиентов
//#define TEST_SIMULATION_CLIENTS 5

#ifdef TEST_SIMULATION_CLIENTS
	/*
		Здесь можно конфигурировать каждую из ролей

		Каждая установка должна начинаться с новой строки.
		Допускается указания диапазона клиентов через "-"
		С включением этой опции режим не стартует пока ваш клиент User не нажмет готовность
		После старта раунда вам будет показан репорт с информацией кто за кого хотел зайти и за кого фактически подключился

		Формат:
			<номер клиента>.<свойство> <значение>

		Доступные свойства:
			role - роль клиента (класс роли зарегистрированный в запускаемом режиме)
			antag - режим антагониста (ANTAG_\w+ из <src\host\GamemodeManager\GamemodeManager.hpp>)
			age - возраст (от 18 до 80)
			gender - пол (GENDER_\w+ из <src\Gender\Gender.hpp>)
			ready - готовность (нужна если вам необходима рандомная роль для этого клиента). true - готов
			access - доступ (ACCESS_\w+ из <src\host\clientManager\client.hpp>)

		Пример:
			3.role RHead < установить для третьего клиента роль RHead
			3.antag ANTAG_FULL < установить для третьего клиента полного антагониста
			4-5.age 40 < установить для четвертого и пятого клиента возраст 40
			5.access ACCESS_FORSAKEN < установить для пятого клиента доступ форсекена
			6.gender GENDER_FEMALE < установить для шестого клиента пол женский
	*/
	gm_editor_test_simCli = 
	"
		1-4.role RBanditMainSaloon
		1-5.access ACCESS_FORSAKEN
		5.role RBarmenSaloon
	";
#endif


#ifndef EDITOR
	#undef TEST_SIMULATION_CLIENTS
#endif


#ifdef TEST_SIMULATION_CLIENTS

	assert_str(inRange(TEST_SIMULATION_CLIENTS,1,100),"TEST_SIMULATION_CLIENTS must be in range 1-100");

	//async for wait client ready
	startAsyncInvoke
	{
		if isNull(lobby_isReadyToPlay) exitWith {false};
		gm_lobbyTimeLeft = 123;
		lobby_isReadyToPlay
	},
	{
		gm_lobbyTimeLeft = 1;
	}
	endAsyncInvoke

	startAsyncInvoke
	{
		!isNullVar(server_loadingState) && {
			equals(server_loadingState,1) && ["==","GAME_STATE_LOBBY"] call gm_checkState
		}
	},
	{
		assert_str(!isNull(TEST_SIMULATION_CLIENTS),"TEST_SIMULATION_CLIENTS is not defined");
		assert_str(!isNull(gm_editor_test_simCli),"gm_editor_test_simCli is not defined");

		//configure gm_editor_test_simCli
		private _pat = "(\d+)(\s*-\s*(\d+))?\s*\.(\w+)\s*(.*)";
		private _readyClients = [];
		private _propActions = createHashMapFromArray [
			["role",{
				params ["_c","_role"];
				private _rolesList = callFunc(gm_currentMode,getLobbyRoles) apply {tolower _role};
				private _roleLower = tolower _role;
				assert_str(array_exists(_rolesList,_roleLower),"Invalid role in gm_editor_test_simCli; Role: " + _role);
				
				callFuncParams(_c,setCharSetting,"role1" arg _role);
			}],
			["antag",{
				params ["_c","_mode"];
				_mode = ANTAG_PARSESTRING(_mode);
				callFuncParams(_c,setCharSetting,"role1" arg _mode);
			}],
			["age",{
				params ["_c","_age"];
				_age = clamp(parsenumber _age,18,80);
				callFuncParams(_c,setCharSetting,"age" arg _age);
			}],
			["gender",{
				params ["_c","_gender"];
				private _gen = GENDER_PARSESTRING(_gender);
				callFuncParams(_c,setCharSetting,"gender" arg _gen);
			}],
			["ready",{
				params ["_c","_ready"];
				if (_ready == "true") then {
					_readyClients pushBackUnique _c;
				};
			}],
			["access",{
				params ["_c","_access"];
				private _acc = [_access] call cm_accessTypeToNum;
				setVar(_c,access,_acc);
			}]
		];
		private _configList = [];
		_configList resize TEST_SIMULATION_CLIENTS;
		_configList = _configList apply {[]};

		{
			private _grp = 1;
			private _cli = parseNumber([_x,_pat,_grp] call regex_getFirstMatch);
			assert_str(_cli >= 1 && _cli <= TEST_SIMULATION_CLIENTS,"Invalid client number in gm_editor_test_simCli; Line: " + _x);
			INC(_grp);
			
			//check range
			private _propOrRangeStart = [_x,_pat,_grp] call regex_getFirstMatch;
			private _cliEnd = _cli;
			if ([_propOrRangeStart,"-"] call stringStartWith) then {
				INC(_grp); //3
				_cliEnd = parseNumber([_x,_pat,_grp] call regex_getFirstMatch);
				assert_str(_cliEnd > _cli && _cliEnd <= TEST_SIMULATION_CLIENTS,"Invalid client range in gm_editor_test_simCli; Line: " + _x);
				INC(_grp); //4
			};

			//get prop
			private _propname = [_x,_pat,_grp] call regex_getFirstMatch;
			assert_str(array_exists(_propActions,_propname),"Invalid property in gm_editor_test_simCli; Line: " + _x);
			private _action = _propActions get _propname;
			INC(_grp);

			//get prop value
			private _propvalue = [_x,_pat,_grp] call regex_getFirstMatch;

			//setprop
			for "_i" from _cli to _cliEnd do {
				_configList select (_i-1) pushBack [_action,_propvalue];
			};

		} foreach (gm_editor_test_simCli splitString (endl + (toString [9])));
		

		for "_i" from 1 to TEST_SIMULATION_CLIENTS do {
			
			//register client in db
			private _disId = str(100000 + _i);
			private _name = "DebugClient_"+ (str _i);

			if (!(([_name] call db_isNickRegistered))) then {
				[_disId,_name] call db_registerAccount;
				[_disId] call db_registerStats;
			};

			private _ownerOffset = 10 + _i;
			private _cobj = newParams(ServerClient,[_ownerOffset arg _disId]);
			private _cliconfigCur = _configList select (_i-1);
			{
				_x params ["_act","_pv"];

				[_cobj,_pv] call _act;
			} foreach _cliconfigCur;

			if (count _cliconfigCur > 0) then {
				_readyClients pushBackUnique _cobj;
			};
		};

		{
			rpcCall("onClientPrepareToPlay",vec2(true,callFunc(_x,getOwner)));
		} foreach _readyClients;

		startAsyncInvoke
		{
			(["==","GAME_STATE_PLAY"] call gm_checkState)
			&& gm_roundDuration > 5
		},
		{
			_report = "All clients:"+(str count cm_allClients)+endl;
			_lines = [];
			
			{
				private _curActor = callFunc(_x,getActorMob);
				if isNullReference(_curActor) then {continue}; //skip not ready clients

				private _txt = (format[
					"%1 (sel %2, spawn %3); %4;",getVar(_x,name),
					getVar(_x,charSettings) get "role1",
					callFunc(getVar(_curActor,basicRole),getClassName),
					[getVar(_x,access)] call cm_accessNumToType
				]);

				_hidden = array_exists(gm_antagClientsHidden,_x);
				_full = array_exists(gm_antagClientsFull,_x);
				if (_full || _hidden) then {
					_atxt = [];
					{if(_x select 1)then{_atxt pushBack (_x select 0)} else {""}} foreach [["FULL",_full],["HIDDEN",_hidden]];
					
					_txt = _txt + " (ANTAG "+(_atxt joinString ", ")+")";
				};

				_lines pushBack _txt;
			} foreach cm_allClients;

			modvar(_report) + (format["Joined: %1",count _lines]) + endl;

			private _fullTxt = _report + endl +endl + (_lines joinString endl);
			["Report also copied to clipboard"+endl+_fullTxt] call messageBox;
			copytoClipboard(_fullTxt);
		}
		endAsyncInvoke
	}
	endAsyncInvoke;
#endif

//событие, запускаемое при старте раунда
gm_startRound = {

	//сбрасываем всех готовых
	private _emptyList = [];
	{
		netSendVar("lobby_RoleContenders",_emptyList,callFunc(_x,getOwner))
	} foreach (call cm_getAllClientsInLobby);

	//pick random gamemode
	//[""] call gm_pickMode;

	//устанавливаем флаг что игра началась (обязательно начинаем перед основным обработчиком)
	[GAME_STATE_PLAY] call gm_onChangeState;

	private _funcCode = {};
	{
		_funcCode = getFunc(_x select 0,startUpdateMethod);
		_x call _funcCode;
	} foreach go_internal_updateMethodsAfterStart;
	logformat("Started %1 update methods",count go_internal_updateMethodsAfterStart);
	go_internal_updateMethodsAfterStart = null;

	call atmos_init;

	["Round started"] call discLog;

	private _allcliInfo = [""];
	private _setmap = ["role1","role2","role3"];
	{
		if getVar(_x,isReady) then {
			private _chSet = getVar(_x,charSettings);
			_allcliInfo pushBack (
				format["%1: %2 => %3",_foreachIndex,getVar(_x,name),_setmap apply {_chSet get _x}]
			);
		};
	} foreach (call cm_getAllClientsInLobby);
	[format["Declare info: %1",_allcliInfo joinString endl]] call gameLog;

	//Выбираем объект аспекта
	call gm_pickRoundAspect;
	//private _curRole = null;

	private _sortedList = call gm_prepareReadyClients;
	
	//! сделать так, чтобы полные и скрытые не моги перемешаться

	// 1. распределяем на роли по vec2
	["----- Prepare to roles -----"] call gameLog;
	{
		_x call gm_prepareToRole;
	} foreach _sortedList;
	// 2. распределяем безролевых
	["----- Prepare no-role clients -----"] call gameLog;
	call gm_prepareNoRoleClients;
	
	// 3. обрабатываем возможных антагов. пустые листы - регеним на всех доступных
	["----- Handle prelist antags -----"] call gameLog;
	call gm_handlePreListAntags;
	// 4. хандлим антагов полных
	["----- Handle full antags -----"] call gameLog;
	call gm_handleDefineFullAntags;
	// 5. спавн
	["----- Spawn prepared clients -----"] call gameLog;
	call gm_spawnPreparedClients;
	call gm_internal_resetContenders;

	// 6. хандлим скрытых
	call gm_handleDefineHiddenAntags;

	[format["Hidden antags: %1",gm_antagClientsHidden apply {getVar(_x,name)}]] call gameLog;
	[format["Full antags: %1",gm_antagClientsFull apply {getVar(_x,name)}]] call gameLog;

	//trace("Start checking gamemode roles");

	traceformat("Registered roles after start: %1",count gm_inGameRoles)

	//Запускаем основной поток проверки финиша
	call gm_startMainThread;

	//Спец методы
	trace("ROUND STARTED");

	{
		netSendVar("lobby_timeLeft",-1,callFunc(_x,getOwner));
	} foreach (call cm_getAllClientsInLobby);

	//Время до эмбарка пещерников
	gm_lobbyTimeToStart = 50;

	gm_lobbyTimeLeft = gm_lobbyTimeToStart; //first reset

	callFunc(gm_currentMode,onKnownMobsProcess);

	//запускаем апдейтер
	gm_onRoundCode_handler = startUpdate(getFunc(gm_currentMode,onRoundCode),1);

	//запускаем менеджер событий
	call gm_startEventHandle;

	//процессим эмбарковые
	{
		if callFunc(_x,isEmbarkRole) then {
			gm_embarks pushBack _x;
		};
	} foreach gm_roundProgressRoles;

	//Пост запуск
	callFunc(gm_currentMode,postSetup);
	callFunc(gm_currentAspect,onRoundBegin);
	
	//start song play
	private _startSong = null;
	private _ctxSong = [["repeat",0],["wait",false],["smooth",0]];
	{
		_startSong = callFuncParams(gm_currentMode,getStartSong,_x);
		if (!isNullVar(_startSong) && {_startSong != ""}) then {
			callFuncParams(_x,playMusic,_startSong arg "MUSIC_CHANNEL_EVENT_GLOBAL" arg _ctxSong);
		};
	} forEach cm_allClients;

	//запись в бд инфы
	call db_onGamemodeSessionStart;
};

gm_prepareToRole = {
	params ["_client"];
	
	private _roleClass = "";
	private _defaultRole = null;
	private _settings = getVar(_client,charSettings);
	private _isSpawned = false;
	private _contenders	= null;
	
	//? performance issue
	//private _isAntag = array_exists(gm_antagClientsFull,_client) || array_exists(gm_antagClientsHidden,_client);
	private _bn = callFunc(_client,getBannedRoles);

	for "_i" from 1 to 3 do {
		_roleClass = _settings get ("role" + str _i);		
		_defaultRole = getRoleObject(_roleClass);
		if (_roleClass != "none") then {
			_contenders = getVarReflect(_defaultRole,"contenders_"+str _i);
			_contenders deleteAt (_contenders find _client); //убираем клиента из претендентов
			
			//Исправление 0.7.606 - Иногда клиента могло пустить за забаненную роль
			private _canTakeStd = getVar(_defaultRole,count) > 0 && !_isSpawned;
			if (_canTakeStd &&
				{callFuncParams(_defaultRole,canTakeInLobby,_client arg true)} &&
				{callFuncParams(_defaultRole,isAllowedRoleToClient,_client arg _bn)}
			) then {
				modVar(_defaultRole,count, - 1);
				_isSpawned = true;
				gm_preparedClients pushBack vec2(_client,_defaultRole);

				[format["Client %1 picking role %2",getVar(_client,name),_defaultRole]] call gameLog;
				//[_client,_roleClass,true] call gm_spawnClientToRole;
			};			
		};
	};

	if (!_isSpawned) then {
		gm_noRoleClients pushBack _client;
		[format["Client %1 cannot pick role (added into norole-list)",getVar(_client,name)]] call gameLog;
	};

};

gm_prepareNoRoleClients = {
	gm_noRoleClients = array_shuffle(gm_noRoleClients);
	private _newVec = null;
	private _bn = [];
	{
		_client = _x;
		_bn = callFunc(_client,getBannedRoles);
		// Сначала обрабатываются ключевые роли, потом дополнительные
		_newVec = array_shuffle(gm_preStartMainRoles) + array_shuffle(gm_preStartRoles - gm_preStartMainRoles);
		{
			// 	доп проверка можно ли взять роль со старта раунда для нераспределённых клиентов
			if (
					(getVar(_x,count) > 0) && //проверка количества
					{callFuncParams(_x,canTakeInLobby,_client arg false)} && //проверка доступности для определенного клиента
					{callFuncParams(_x,isAllowedRoleToClient,_client arg _bn)} //проверка на баны
				) exitWith {
				modVar(_x,count, - 1);
				gm_preparedClients pushBack vec2(_client,_x);
				[format["Norole-list pick for client %1 is %2",getVar(_client,name),_x]] call gameLog;
				//[_client,callFunc(_x,getClassName),true] call gm_spawnClientToRole;
			};
		} foreach _newVec;
	} foreach gm_noRoleClients;
};

gm_internal_resetContenders = {
	{
		//cleanup contenders
		setVar(_x,contenders_1,[]);
		setVar(_x,contenders_2,[]);
		setVar(_x,contenders_3,[]);
		//check canadd
		if (getVar(_x,count) > 0 && {callFunc(_x,canAddAfterStart)}) then {
			gm_roundProgressRoles pushBackUnique _x;
			callFunc(_x,onStarted);
		};
	} foreach gm_preStartRoles;
};

gm_handlePreListAntags = {
	private _antag = 0;

	//TODO
	/*
		В OldNewOrder есть только скрытые антаги. Надо сделать так, чтобы все кто указал полных переаллоцировались в скрытых
		Такое правило должно работать и если есть полные но нет скрытых
	*/

	//стандартная коллекция
	{
		_x params ["_client","_rObj"];
		_antag = getVar(_client,charSettings) get "antag";
		//antag - 0 none; 1 hide, 2 unical, 3 all
		if (_antag == ANTAG_ALL) then {
			if callFuncParams(_rObj,canBeFullAntag,_client) then {
				gm_antagClientsFull pushBack _client;
			};
			if callFuncParams(_rObj,canBeHiddenAntag,_client) then {
				gm_antagClientsHidden pushback _client;
			};
			continue;
		};
		if (_antag == ANTAG_UNICAL) then {
			if callFuncParams(_rObj,canBeFullAntag,_client) then {
				gm_antagClientsFull pushBack _client;
			};
		};
		if (_antag == ANTAG_HIDDEN) then {
			if callFuncParams(_rObj,canBeHiddenAntag,_client) then {
				gm_antagClientsHidden pushback _client;
			};
		};
	} foreach gm_preparedClients;

	//Если количество меньше небоходимого перевыбираем всех возможных
	private _checkFull = count gm_antagClientsFull < callFunc(gm_currentMode,getMinFullAntags);
	private _checkHidden = count gm_antagClientsHidden < callFunc(gm_currentMode,getMinHiddenAntags);

	if (_checkFull || _checkHidden) then {
		
		[format["Catch empty list antags: full %1; hidden %2",_checkFull,_checkHidden]] call gameLog;
		
		if (_checkFull) then {gm_antagClientsFull = []};
		if (_checkHidden) then {gm_antagClientsHidden = []};

		{
			_x params ["_client","_rObj"];

			if (_checkFull && {callFuncParams(_rObj,canBeFullAntag,_client)}) then {
				gm_antagClientsFull pushBack _client;
			};
			if (_checkHidden && {callFuncParams(_rObj,canBeHiddenAntag,_client)}) then {
				gm_antagClientsHidden pushBack _client;
			};
		} foreach gm_preparedClients;
	};

	//! Это в 2 раза медленнее чем один раз перебрать по массиву
/*
	if (count gm_antagClientsFull < callFunc(gm_currentMode,getMinFullAntags)) then {
		gm_antagClientsFull = [];
		{
			_x params ["_client","_rObj"];
			if callFuncParams(_rObj,canBeFullAntag,_client) then {
				gm_antagClientsFull pushBack _client;
			};
		} foreach gm_preparedClients;
	};
	if (count gm_antagClientsHidden < callFunc(gm_currentMode,getMinHiddenAntags)) then {
		gm_antagClientsHidden = [];
		{
			_x params ["_client","_rObj"];
			if callFuncParams(_rObj,canBeHiddenAntag,_client) then {
				gm_antagClientsHidden pushback _client;
			};
		} foreach gm_preparedClients;
	};
*/

	//Финальная проверка если количества всё ещё не удовлетворяют
	//! В нормальной ситуации это не должно быть вызывано
	if (count gm_antagClientsFull < callFunc(gm_currentMode,getMinFullAntags)) then {
		[format["Full antags count critical low (%1 / %2)",count gm_antagClientsFull,callFunc(gm_currentMode,getMinFullAntags)]] call discError;

		gm_antagClientsFull = gm_preparedClients apply {_x select 0}
	};
	if (count gm_antagClientsHidden < callFunc(gm_currentMode,getMinHiddenAntags)) then {
		[format["Hidden antags count critical low (%1 / %2)",count gm_antagClientsHidden,callFunc(gm_currentMode,getMinHiddenAntags)]] call discError;

		gm_antagClientsHidden = gm_preparedClients apply {_x select 0};
	};
};

gm_handleDefineFullAntags = {
	private __findClientVec2 = {
		private _cli = _this;
		private _idx = gm_preparedClients findif {equals(_x select 0,_cli)};
		if (_idx == -1) exitwith {};
		gm_preparedClients select _idx
	};
	private _indx = 1;
	private _struct = null;
	
	//? used in getAntagRoleFull()
	//------------- extenral references ------------------
	private _countInGame = count gm_preparedClients;
	private _countProbFullAntags = count gm_antagClientsFull;
	//---------------------------------------------------

	{
		_struct = _x call __findClientVec2;
		if !isNullVar(_struct) then {
			//!critical section: do not change name _struct and _struct select 1 (_prevRoleObj)
			private _newRole = callFuncParams(gm_currentMode,getAntagRoleFull,_struct select 0 arg _indx);
			if (!isNullVar(_newRole) && {not_equals(_newRole,"")}) then {
				//TODO если он может взять роль
				//! пока что на это нет ограничений
				private _prevRoleObj = _struct select 1;
				private _newRoleObj = getRoleObject(_newRole);
				
				modVar(_prevRoleObj,count, + 1);
				modVar(_newRoleObj,count, - 1);

				_struct set [1,_newRoleObj];
			};
		};
		INC(_indx);
	} foreach array_shuffle(gm_antagClientsFull);
};

gm_spawnPreparedClients = {
	private _newMob = 0;
	private _indexAntag = 0;

	{
		_x params ["_client","_rObj",["_isFullAntag",false]];
		//! _isFullAntag - пока не задействован и не назначен! Может быть добавлен в будущем...
		[_client,callFunc(_rObj,getClassName),false] call gm_spawnClientToRole;
	} foreach gm_preparedClients;
};

gm_handleDefineHiddenAntags = {
	private _countInGame = count gm_preparedClients;
	private _countProbHiddenAntags = count gm_antagClientsHidden;
	private _curClient = nullPtr;
	private _mob = nullPtr;
	private _index = 1;
	
	{
		_curClient = _x;
		_mob = getVar(_curClient,actor) getvariable "link";

		//! Правило отключено, так как ломает логику и иногда может не быть допустимых антагов.
		//дополнительная проверка чтобы полные антаги могли быть скрытыми антагами
		//if callFuncParams(getVar(_mob,basicRole),canBeHiddenAntag,_curClient) then {
			callFuncParams(gm_currentMode,handleAntagRoleHidden,_curClient arg _mob arg _index);
		//};
		INC(_index);
	} foreach gm_antagClientsHidden;
};

//Готовит структуру с приоритетами на роли
gm_prepareReadyClients = {
	private _struct = [];
	private _hashAssoc = createHashMap;
	private _prior = 0;

/*	//#define debuguser_fortestspawn
	#ifdef debuguser_fortestspawn
		for "_i" from 10 to 50 do {
			this = newParams(ServerClient,["Персонаж " + str  _i arg objNUll arg _i - 5 arg "0000000" + str _i]);
			setSelf(isReady,true);
		};
	#endif*/


	//Первый проход - распределение: приоритет
	//У кого больший приоритет, тот и первый
	{
		_prior = rand(0,1); //строки из-за хэшкарт

		//Эти данные управляют типом структуры. Сюда можно впихнуть выпавшее значение
		#define additionalData [_x,_prior]

		//готовый клиент
		if (getVar(_x,isReady)) then {

			//Предварительно накинуть приоритет клиенту...
			modvar(_prior) + callFunc(_x,getPriorityForRoles);

			_prior = str _prior;

			_struct pushBack _prior; //добавляем приоритет
			_preval = _hashAssoc get _prior; //добавляем ассоциацию приоритета клиента
			if isNullVar(_preval) then {
				_hashAssoc set [_prior,[additionalData]];
			} else {
				_preval pushBack additionalData;
			};
		};
	} foreach (call cm_getAllClientsInLobby);

	//Сортируем приоритеты
	_struct sort false;

	private _outputList = [];
	private _keyList = [];

	{
		//Берём приоритет
		_keyList = _hashAssoc get _x;
		if (count _keyList > 1) then {
			//сортим массив если больше 1 элемента
			_keyList = _keyList call BIS_fnc_arrayShuffle;
		};

		//По приоритетам добавляем клиентов в конец списка
		_outputList append _keyList;

	} foreach _struct;

	//traceformat("Sorted list - %1:: struct: %2",_outputList arg _struct)
	//Выходной лист по приоритетам от самых успешных к самым лохам
	_outputList
};

//Установка настроек персонажа для рега в роль
gm_initHashMapCharSettings = {
	#define hashPair(key,val) [#key,val]
	private _mapSettings = createHashMapFromArray [
		hashPair(name,"") arg
		hashPair(age,randInt(18,80)) arg
		hashPair(gender,GENDER_MALE) arg
		hashPair(face,"rand") arg
		hashPair(mainhand,pick vec2(0,1)) arg //0 левая, 1 правая
		hashPair(vice,"rand") arg
		hashPair(family,FAMILY_DEFAULT) arg
		hashPair(blood,BLOOD_TYPE_RANDOM) arg
		hashPair(faith,"fugu") arg
		hashPair(antag,ANTAG_NONE)
	];
	{
		_X params ["_name","_val"];
		_mapSettings set [_name,_val];
		
	} foreach _this;
	
	//post check
	if (_mapSettings get "name" == "") then {
		_mapSettings set ["name",[_mapSettings get "gender",true] call naming_getRandomName]
	};
	_mapSettings
};

//Создать клиента в игре
gm_spawnClientToRole = {

	params [["_client",nullPtr],["_roleName",""],["_decrementRoleCount",true],"_mobsetup_map"];
	
	if isNullReference(_client) exitwith {
		errorformat("Cant spawn null client to role %1",_roleName);
		nullPtr
	};

	private _cli = callFunc(_client,getOwner);

	private _robj = getRoleObject(_roleName); //Объект роли
	
	if isNullReference(_robj) exitwith {
		errorformat("Cant spawn client %1 to null role",getVar(_client,name));
		nullPtr
	};
	if !callFunc(_client,isInLobby) exitwith {
		errorformat("Spawn from non-lobby is not supported yet: Client %1; Role %2",getVar(_client,name) arg getVar(_robj,name));
		nullPtr
	};

	if callFunc(_client,isInLobby) then {
		//Закрываем лобби
		rpcSendToClient(_cli,"closeLobby",0);
	};
	
	//Создаем армовского моба
	private _playerObject = 0 call gm_createMob;
	
	private _cliSettings = getVar(_client,charSettings);
	#define getClientSetting(var) (_cliSettings get #var)
	
	if !isNullVar(_mobsetup_map) then {
		_cliSettings = _mobsetup_map; //TODO приплюсовать карту к _cliSettings
	};
	
	private _gender = getClientSetting(gender);
	private _genderObject = _gender;
	if equalTypes(_gender,GENDER_MALE) then {
		_genderObject = [_gender] call gender_enumToObject;
	};

	//Создаём ролевого персонажа
	private this = ifcheck(equals(_genderObject,gender_male),instantiate(getVar(_robj,classMan)),instantiate(getVar(_robj,classWoman))); //if mob is woman then gender change

	//назначаем руку
	callSelfParams(initMainHand,getClientSetting(mainhand));

	[_playerObject,_client] call cm_registerMobInGame; //сначала регистрируем моба в глобале а потом регаем актера
	
	callSelfParams(initAsActor, _playerObject); // сначала зарегаем владельца чтобы отправить ему инфу

	//Сохранение клиента теперь при подключении к сущности
	//сохраняем клиента в объекте моба
	// Просто нужно знать последнего клиента
	//setVar(this,client,_client);

	//Выдаём ему шмотки и спавним его на позицию
	if (_decrementRoleCount) then {modVar(_robj,count,-1);};
	callFuncParams(this,onInitRole,_robj); //инициализация на роли

	//naming setup
	private _charName = getClientSetting(name);
	private _cliSetName = if (_charName == "Неизвестный") then {
		//get random name
		[GENDER_MALE] call naming_getRandomName
	} else {
		_charName splitString " ";
	};

	callSelfParams(generateNaming,_cliSetName select 0 arg _cliSetName select 1);

	//age setting
	private _age = getClientSetting(age);
	setSelf(age,_age);

	setSelf(gender,_genderObject);

	//устанавливаем женскую одежду
	if equals(getSelf(gender),gender_female) then {
		callSelf(onApplyDefaultUniform);
	};

	//face setting
	private _face = getClientSetting(face);
	if (_face == "rand") then {
		_face = if (_gender == GENDER_MALE) then {pick faces_list_man} else {pick faces_list_woman};
	};
	callSelfParams(setMobFace,_face);
	callSelfParams(setMobFaceAnim,"");

	private _bType = getClientSetting(blood);
	if (_bType == BLOOD_TYPE_RANDOM) then {
		private _types = [BLOOD_TYPE_O_PLUS,BLOOD_TYPE_O_MINUS,BLOOD_TYPE_A_PLUS,BLOOD_TYPE_A_MINUS,BLOOD_TYPE_B_PLUS,BLOOD_TYPE_B_MINUS,BLOOD_TYPE_AB_PLUS,BLOOD_TYPE_AB_MINUS];
		private _probs = [42,10,25,5,9,3,2,2];

		private _psum = 0;

		{MOD(_psum,+ _x)} count _probs;

		private _prbRnd = randInt(0,_psum);

		private _tmp = 0;
		private _idx = 0;

		{
			MOD(_tmp,+ (_probs select _forEachIndex));
			if (_tmp > _prbRnd) exitWith {
				_idx = _forEachIndex;
			};
		} foreach _types;

		setSelf(bloodGroupMatter,BLOOD_ENUM_TO_MATTER(_types select _idx));
	} else {
		setSelf(bloodGroupMatter,BLOOD_ENUM_TO_MATTER(_bType));
	};
	
	if callFunc(_robj,canStoreNameAndFaceForValidate) then {
		setVar(_client,lastCharData,vec2(_cliSetName joinString " ",_face));
	};

	//добавление клиента в список владельцев сущности
	getVar(this,playerClients) pushBack _client;

	//Инициализация только после установки имени и тд.
	[_robj,this,_client] call gm_internal_assignToImpl;
	callFuncParams(_robj,onAssigned,this arg _client);

	// С этого момента клиент считается как находящийся в игре
	callFuncParams(_client,onChangeState,"ingame");

	//репутационный обработчик
	[this,_client] call repvote_collectPlayer;

	//если клиент не был в игре добавляем его в массив
	gm_internal_ingameClients pushBackUnique _client;

	//Добавляем игрока в лист 
	system_internal_list_allJoiners pushBack this;

	//После полной инициализации клиента можно и подгрузить позицию
	private _initialPos = callSelf(getInitialPos);
	rpcSendToClient(_cli,"prepPlayerPos",vec2(_initialPos,_playerObject));

	logformat("[Round]: Client %1 (%2) spawned as %3",getVar(_client,name) arg _charName arg _roleName);
	
	[format["(gm::spawnClientToRole): %2 joined at role %3 (%1) <%4>",getVar(_client,name),_charName,_roleName,_playerObject]] call gameLog;
	
	this
};

gm_internal_assignToImpl = {
	params ['this',"_mob","_usr"];

	//запоминаем моба для клиента
	if (callSelf(getClassName)!="GhostRole" && callSelf(getClassName)!="AdminObserverRole") then {
		setVar(_usr,lastMob,_mob);
	};
	
	// TODO: use serialization
	private _skills = callSelf(getSkills);
	private _skillsMap = ["ST","IQ","DX","HT"];
	private _allocSkills = [10,10,10,10];
	if equalTypes(_skills,"") then {
		private _skList = null;
		private _skName = null; private _skVal = null;
		private _idxSkill = -1;
		{
			_skList = _x splitString "=:- ";
			if !inRange(count _skList,2,3) exitWith {
				#ifdef EDITOR
				["Неверно определен навык ""%3"" для роли %1 -> ""%2""",callFunc(this,getClassName) arg _skills arg _x] call messageBox;
				#endif
				
			};
			_skName = _skList select 0;
			_skVal = parseNumber (_skList select 1);
			if (count _skList > 2) then {
				_skVal = randInt(_skVal,parseNumber (_skList select 2));
			};
			_idxSkill = _skillsMap findif {_x == _skName};
			if (_idxSkill == -1) exitwith {
				#ifdef EDITOR
				["Неверное название навыка для роли %1 -> %2",callFunc(this,getClassName) arg _skName] call messageBox;
				#endif
			};
			_allocSkills set [_idxSkill,_skVal];
		} foreach (_skills splitString ";,");
	} else {
		_allocSkills = _skills;
	};
	_allocSkills params [["_st",10],["_iq",10],["_dx",10],["_ht",10]];
	[_mob,_st,_iq,_dx,_ht] call gurps_initSkills;
	callFunc(_mob,calculateCommonSkillsBasicValues);

	// TODO: use serialization
	private _otherSkills = callSelf(getOtherSkills);
	private _arrayOtherSkills = _otherSkills;

	if equalTypes(_otherSkills,"") then {
		private _skName = null; private _skVal = null;
		private _idxSkill = -1; private _skList = null;
		_arrayOtherSkills = []; _mapAllSkills = createHashMap;
		{
			_skList = _x splitString "=:- ";
			if !inRange(count _skList,2,3) exitWith {
				#ifdef EDITOR
				["Неверно определен дополнительный навык ""%3"" для роли %1 -> ""%2""",callFunc(this,getClassName) arg _otherSkills arg _x] call messageBox;
				#endif
			};

			_skName = _skList select 0;
			_skVal = parseNumber (_skList select 1);
			if (count _skList > 2) then {
				_skVal = vec2(_skVal,parseNumber (_skList select 2));
			};
			_idxSkill = skills_internal_list_otherSkillsSystemNames findif {_x == _skName};
			if (_idxSkill == -1) exitwith {
				#ifdef EDITOR
				["Неверное название дополнительного навыка для роли %1 -> %2",callFunc(this,getClassName) arg _skName] call messageBox;
				#endif
			};
			if ((tolower _skName) in _mapAllSkills) then {
				#ifdef EDITOR
				["Дубликат дополнительного навыка для роли %1 -> %2",callFunc(this,getClassName) arg _skName] call messageBox;
				#endif
				continue;	
			};
			_mapAllSkills set [tolower _skName,0];

			_arrayOtherSkills pushBack [_skName,_skVal];
			
		} foreach (_otherSkills splitString ";,");
	};
	
	{
		_x params ["_skName","_val"];
		if equalTypes(_val,[]) then {_val = randInt(_val select 0,_val select 1)};
		if !(tolower _skName in skills_internal_map_nameAssoc) then {
			errorformat("%1::onAssigned() - Unknown skill %2 for role %1",callSelf(getClassName) arg _skName);
			continue;
		};
		callFuncParams(_mob,updateSkillLevel,_skName arg _val);
	} foreach _arrayOtherSkills;

	callSelfParams(initLocation,_mob);
	callSelfParams(getEquipment,_mob);
	callSelfParams(initWelcome,_mob);
	
	if array_exists(getVar(_usr,lockedSettings),"run") then {
		callFuncParams(_usr,localSay,setstyle("Суровая жизнь в Сети пошатнула моё здоровье...",style_redbig) arg "info");
	};
	
	if array_exists(getVar(_usr,lockedSettings),"combat") then {
		if ("lockedSettings" in (toString getFunc(_mob,isFailCombat))) then {
			callFuncParams(_usr,localSay,setstyle("Я страдаю редкой болезнью - Небойка. Из-за неё я не могу постоять за себя и проявлять агрессию...",style_redbig) arg "info");
		};
	};

	//here adding game aspect info
	callFuncParams(_mob,addFirstJoinMessage,callFunc(gm_currentAspect,getAspectText));

	if callSelf(isLateAssigned) then {
		if callFunc(gm_currentAspect,canActivateOnMobAfterStart) then {
			callFuncParams(gm_currentAspect,onMob,_mob);
		};
	} else {
		callFuncParams(gm_currentAspect,onMob,_mob);
	};
	
	//подсказки 
	callFunc(_mob,__generateGameInfo);

	#ifdef EDITOR
	[_mob,this] call relicta_debug_internal_invokeEntryPoint;
	#endif

	//Цацам добавим язык жестов
	if isTypeOf(_mob,GMPreyMobEater) exitWith {}; //жруны однополые
	if callFunc(_mob,isFemale) then {
		callFuncParams(_mob,addPerk,"PerkSignLang");
	} else {
		//Временный фикс на помещика. пока нет системы родства
		private _brole = callFunc(getVar(_mob,basicRole),getClassName);
		if (_brole in ["RPomeshik","RHead","RHeadSon"]) exitWith {
			callFuncParams(_mob,addPerk,"PerkSignLang");
		};
		
		//стандартная процедура. перс не тупой
		if (_iq > 10) then {
			//слишком молодой едва-ли смог бы выучить язык жестов.
			if (prob(50) && getVar(_mob,age) >= 25) then {
				callFuncParams(_mob,addPerk,"PerkSignLang");
			};
		};
	};
};

//Отсылает клиенту запрос на открытие окна выбора доступных лейт ролей и список
gm_sendLateRolesToClient = {
	params ["_owner"];

	private _data = [gm_roundDuration];
	private _client = _owner call cm_findClientById;

	if isNullReference(_client) exitWith {
		errorformat("gm::sendLateRolesToClient() - Cant find client by id %1",_owner);
		rpcSendToClient(_owner,"chatPrint",vec2("Системная ошибка. Не удалось получить клиента","error"));
		rpcSendToClient(_owner,"onSelectLateRole",-1);
	};

	if (rep_system_enable && equals(getVar(_client,testResult),"")) exitWith {
		callFuncParams(_client,localSay,"Доступ к игре только у тех" pcomma " кто прошёл тест" arg "system");
		rpcSendToClient(_owner,"onSelectLateRole",-1);
	};
	if callFunc(_client,isNeedToVote) exitwith {
		callFuncParams(_client,localSay,"Доступ к игре только у тех" pcomma " кто проголосовал (перезайдите чтобы открыть голосование)" arg "system");
		rpcSendToClient(_owner,"onSelectLateRole",-1);
	};
	if (call dsm_accounts_canUse && {!callFunc(_client,isDiscordAccountRegistered)}) exitwith {
		callFuncParams(_client,localSay,"Вы должны привязать игровой аккаунт к дискорду RELICTA для входа в игру." arg "system");
		rpcSendToClient(_owner,"onClientPrepareToPlayCallback",[false]);
	};

	private _obsoleteSettings = "";
	private _lastCharData = getVar(_client,lastCharData);
	private _lastMap = [["name","имя"],["face","лицо"]];
	private _charSettings = getVar(_client,charSettings);
	{
		(_lastMap select _forEachIndex)params ["_set","_ruName"];
		if equals(_charSettings get _set,_x) exitWith {
			_obsoleteSettings = _ruName;
		};
	} foreach _lastCharData;
	
	#ifndef EDITOR
	if not_equals(_obsoleteSettings,"") exitWith {
		callFuncParams(_client,localSay,"Измени " + _obsoleteSettings + " и сможешь зайти в раунд." arg "log");
		rpcSendToClient(_owner,"onSelectLateRole",-1);
	};
	#else
	if not_equals(_obsoleteSettings,"") then {
		callFuncParams(_client,localSay,"<t size='2'>Внимание! Требования смены " + _obsoleteSettings + " выключено в режиме EDITOR</t>" arg "log");
	};
	#endif


	private _deadTimeout = callFunc(_client,getDeadTimeout);
	private _deadTime = getVar(_client,lastDeadTime);

	if (_deadTime > 0 && {(_deadTime+_deadTimeout)>tickTime}) exitWith {
		private _timeToPick = round((_deadTime+_deadTimeout)-tickTime);
		//private _m = format["Вы недавно умерли и сможете зайти за нового персонажа через %1",[_timeToPick,["секундочку","секундочки","секундочек"],true] call toNumeralString];
		//callFuncParams(_client,localSay,_m arg "log");
		rpcSendToClient(_owner,"onSelectLateRole",_timeToPick);
	};

	//снимаем с эмбарка
	if getVar(_client,isInEmbark) exitWith {
		[_client,true] call gm_removeClientFromEmbark;
	};

	//for "_i" from 1 to 30 do {_data pushBack ["Роль "+str _i,"class_"+str _i ];};
	private _bn = callFunc(_client,getBannedRoles);
	{
		if (callFuncParams(_x,canVisibleAfterStart,_client) && {callFuncParams(_x,isAllowedRoleToClient,_client arg _bn)} /*&& {callFuncParams(_x,canTakeInLobby,_client)}*/) then {
			_data pushBack [getVar(_x,name),callFunc(_x,getClassName)];
		};
	} foreach gm_roundProgressRoles;

	rpcSendToClient(_owner,"onSelectLateRole",_data);

}; rpcAdd("getAllowedLateRoles",gm_sendLateRolesToClient);

//спавнит лейтового персонажа на свою роль
gm_spawnSelectedLateRole = {
	params ["_roleClass","_owner"];

	private _client = _owner call cm_findClientById;

	private _roleData = getRoleObject(_roleClass);

	if isNullReference(_roleData) exitWith {
		errorformat("gm::spawnSelectedLateRole() - Role %1 does not exists",_roleClass);
		callFuncParams(_client,localSay,"Выбранной роли не существует." arg "error");
	};
	if !callFuncParams(_roleData,canVisibleAfterStart,_client) exitWith {
		callFuncParams(_client,localSay,"Вам не доступна выбранная роль. Прошло слишком много времени и доступность роли изменилась. Повторите попытку взятия роли" arg "error");
	};
	if (call gm_isRoundEnding) exitWith {
		callFuncParams(_client,localSay,"Раунд уже окончен." arg "error");
	};
	private _isDefault = _roleData in gm_preStartRoles;

	//fast decrement
	private _curRoleCount = getVar(_roleData,count);

	//таких лейт ролей больше не осталось
	if (_curRoleCount <= 0) exitWith {
		callFuncParams(_client,localSay,"Таких ролей уже не осталось." arg "error");
		rpcSendToClient(_owner,"onClientPrepareToPlayCallback",[0]);
	};

	//Последняя роль - удаляем её из списка прогрессных
	if (_curRoleCount == 1) then {
		gm_roundProgressRoles deleteAt (gm_roundProgressRoles find _roleData);
	};

	if callFunc(_roleData,isEmbarkRole) then {
		setVar(_roleData,count,_curRoleCount-1);
		[_client,_roleData,_owner] call gm_addClientToEmbark;
	} else {
		[_client,_roleClass,true] call gm_spawnClientToRole;
	};

}; rpcAdd("spawnSelectedLateRole",gm_spawnSelectedLateRole);

gm_addClientToEmbark = {
	params ["_client","_roleData","_owner"];

	setVar(_client,isInEmbark,true);
	private _emb = getVar(_roleData,embark);
	setVar(_client,embarkRole,_roleData);

	_emb pushBackUnique _client;
	0 call gm_syncRoleContenders;
	rpcSendToClient(_owner,"onClientPrepareToPlayCallback",[1]);
};

gm_removeClientFromEmbark = {
	params ["_client",["_syncRPC",true]];

	setVar(_client,isInEmbark,false);
	private _roleObj = getVar(_client,embarkRole);
	private _emb = getVar(_roleObj,embark);
	_emb deleteAt (_emb find _client);
	setVar(_client,embarkRole,nullPtr);

	modVar(_roleObj,count, + 1); //restore role count
	//restore role in roundprogress pool if count now 1
	if (getVar(_roleObj,count) == 1) then {
		gm_roundProgressRoles pushBackUnique _roleObj;
	};

	0 call gm_syncRoleContenders;

	if (_syncRPC) then {
		rpcSendToClient(callFunc(_client,getOwner),"onClientPrepareToPlayCallback",[0]);
	};
};

gm_doEmbark = {

	private _emb = null;
	private _canSyncContenders = false;
	{
		_emb = getVar(_x,embark);
		if (count _emb > 0) then {
			private _embarkName = callFunc(_x,getClassName);
			if callFunc(_x,canEmbark) then {
				{

					[_x,_embarkName,false] call gm_spawnClientToRole;

					//do empty role contenders for this client
					netSendVar("lobby_RoleContenders",[],callFunc(_x,getOwner));

					true
				} count _emb;

				callFunc(_x,onEmbarkSpawned);

				setVar(_x,embark,[]);

				_canSyncContenders = true;
			};
		};
		true
	} count gm_embarks;

	//Для тех кто остался сидеть в лобби синхронизируем лист претендентов
	if (_canSyncContenders) then {
		0 call gm_syncRoleContenders;
	};

};

//Проверяет роли клиента на наличие в базе gm_preStartRoles дефолтных ролей.
//Если таких ролей не указано или клиент не имеет возможности взять роль - сбрасываем её
gm_validateAvailableRoles = {
	params ['this', ['_canPrintMessage',true]];

	private _settings = getSelf(charSettings);
	private _hasRemovedRoles = false;
	private _bn = callSelf(getBannedRoles);
	for "_i" from 1 to 3 do {
		_roleKey = "role"+str _i;
		if (not_equals(_settings get _roleKey,"none") &&
			{!([_settings get _roleKey] call gm_isPreStartRoleExist)}
		) then {
			warningformat("gm::validateRoles() - finded obsolete role: %1->%2 (client:%3)",_roleKey arg _settings get _roleKey arg getSelf(name));
			_settings set [_roleKey,"none"];
			_hasRemovedRoles = true;

			rpcSendToClient(callSelf(getOwner),"onCharSettingCallback",[_roleKey arg "none"]);
		} else {
			private _rObj = (_settings get _roleKey) call gm_getRoleObject;
			if (!callFuncParams(_rObj,canTakeInLobby,this arg true) || {callFuncParams(_rObj,isAllowedRoleToClient,this arg _bn)}) then {
				_settings set [_roleKey,"none"];
				//_hasRemovedRoles = true;

				rpcSendToClient(callSelf(getOwner),"onCharSettingCallback",[_roleKey arg "none"]);
			} else {
				rpcSendToClient(callSelf(getOwner),"onCharSettingCallback",[_roleKey arg _settings get _roleKey]);
			};
		};
	};

	if (_hasRemovedRoles && _canPrintMessage) then {
		callSelfParams(localSay,"Что-то не так пошло с выбранными ролями и некоторые роли были сброшены." arg "log");
	};
};

gm_endRound = {
	params ["_endgameState"];

	[GAME_STATE_END] call gm_onChangeState;

	if (gm_handleEvents > -1) then {
		stopUpdate(gm_handleEvents);
		gm_handleEvents = -1;
	};

	if (gm_onRoundCode_handler > -1) then {
		stopUpdate(gm_onRoundCode_handler);
		gm_onRoundCode_handler = -1;
	};

	private _mob = null;
	private __GFLAG_ENDGAME_POINTS_UPDATE__ = true; // используется в addPoints, removePoints
	//Всем клиентам в игре инкрементируем отыгранные раунды
	{
		modVar(_x,playedRounds, + 1);

		//обрабатываем сущностей клиентов с методом onEndgameBasic и onEndgame
		_mob = callFunc(_x,getActorMob);
		if !isNullReference(_mob) then {
			private _role = getVar(_mob,basicRole);
			callFuncParams(_role,onEndgameBasic,_mob arg _x);
			_role = getVar(_mob,role);
			callFuncParams(_role,onEndgame,_mob arg _x);
		};
		
	} foreach (call cm_getAllClientsInGame);

	// reset flag
	__GFLAG_ENDGAME_POINTS_UPDATE__ = null;

	//Обрабатываем все задачи
	{
		callFunc(_x,updateMethodInternal);
	} foreach taskSystem_checkedOnEndRound;

	//обрабатываем все незавершенные задачи как проваленные
	{
		// Предварительно проверим задачи перед завершением (потому что поток проверит их только в следующем цикле симуляции)
		if (!getVar(_x,isDone) && !callFunc(_x,checkCompleteOnEnd)) then {
			callFunc(_x,updateMethodInternal);
		};
		if !getVar(_x,isDone) then {
			callFuncParams(_x,setTaskResult,-1 arg true);
		};
	} foreach taskSystem_allTasks;

	setVar(gm_currentMode,finishResult,_endgameState);

	callFunc(gm_currentMode,onFinish);
	
	callFunc(gm_currentAspect,onRoundEnd);

	//end song play
	private _endSong = null;
	private _ctxSong = [["repeat",0],["wait",false],["smooth",0]];
	{
		_endSong = callFuncParams(gm_currentMode,getEndSong,_x);
		if (!isNullVar(_endSong) && {_endSong != ""}) then {
			callFuncParams(_x,playMusic,_endSong arg "MUSIC_CHANNEL_EVENT_GLOBAL" arg _ctxSong);
		};
	} forEach cm_allClients;

	//фиксация режима в бд
	call db_onGamemodeSessionEnd;

	if (rep_system_enable) then {
		if (callFunc(gm_currentMode,isVoteSystemEnabled) && count repvote_list_tStructVoteObject > 4) then {
			invokeAfterDelay(repvote_onEndRound,5);
		};
	};

	//Последний раунд - вырубаем каточку
	if (gm_isLastRound) exitWith {
		private _timeRest = 60;

		[format["Грязноямску пора отдохнуть..."],"system"] call cm_sendOOSMessage;
		invokeAfterDelay(server_end,_timeRest);
	};

	_reloadEvent = {
		private _timeRest = if (count cm_allClients >= 12) then {60*2} else {60};

		[format["Раунд будет перезапущен через %1 секунд",_timeRest],"system"] call cm_sendOOSMessage;
		invokeAfterDelay(server_restart,_timeRest);
	};
	invokeAfterDelay(_reloadEvent,10);
};

//может ли аспект быть установленным в этом режиме
gm_isAspectAllowedToMode = {
	params ["_aspect","_curMode"];

	if (server_gameAspects_list_nopicked findif {_x == _aspect}!=-1) exitwith {false};

	private _modes = getFieldBaseValue(_aspect,"allowedModes");
	private _maps = getFieldBaseValue(_aspect,"allowedMaps");
	private _curmap = getFieldBaseValueWithMethod(_curMode,"map","getMapName");
	private _isAllowed = false;

	//не доступен для всех карт (не публичный) И не доступен для текущией карты
	if (count _maps > 0 && {(_maps findif {_x == _curmap})==-1}) exitwith {false};

	if (count _modes == 0) then {
		_isAllowed = true;
	} else {
		private _idx = _modes findif {_x == _curMode};
		if (_idx != -1) then {
			_isAllowed = true;
		};
	};
	_isAllowed
};

gm_internal_getPossibleAspects = {
	params ["_curMode"];
	private _allAspects = getAllObjectsTypeOf(BaseGameAspect);
	private _possibleAspects = [];
	{
		if ([_x,_curMode] call gm_isAspectAllowedToMode) then {
			_possibleAspects pushBack _x;
		};
	} foreach _allAspects;
	_possibleAspects
};

gm_isAspectSetup = {
	private _checked = _this;
	if isTypeOf(gm_currentAspect,MultiGameAspect) exitwith {
		(getVar(gm_currentAspect,internalAspects) findif {
			_checked == (callFunc(_x,getClassName))
		}) != -1 
	};
	_checked == (callFunc(gm_currentAspect,getClassName))
};

gm_pickRoundAspect = {
	
	if !getVar(gm_currentMode,canAddAspect) exitWith {
		gm_currentAspect = nullPtr;
	};
	
	private _allAspects = getAllObjectsTypeOf(BaseGameAspect);
	private _possibleAspects = [];
	private _aspectWeights = [];
	private _modes = [];
	private _curMode = callFunc(gm_currentMode,getClassName);
	{

		if ([_x,_curMode] call gm_isAspectAllowedToMode) then {
			_possibleAspects pushBack _x;
			_aspectWeights pushBack getFieldBaseValue(_x,"weight");
		} else {
			//! _modes не меняется и скорее всего не нужно. Проверить и поправить
			/*
			private _idx = _modes findif {_x == _curMode};
			if (_idx != -1) then {
				_possibleAspects pushBack _x;
				_aspectWeights pushBack getFieldBaseValue(_x,"weight");
			};*/
		};
	} foreach _allAspects;
	
	private _aspect = _possibleAspects selectRandomWeighted _aspectWeights;
	if isNullVar(_aspect) then {
		_aspect = pick _possibleAspects;
	};
	#ifdef EDITOR
	if (!isNull(sdk_temp_internal_forcedAspect)) then {
		_aspect = sdk_temp_internal_forcedAspect;
	};
	#endif
	
	if not_equals(gm_forcedAspect,"") then {
		private _aspectForced = gm_forcedAspect;
		if ([_aspectForced,_curMode] call gm_isAspectAllowedToMode) then {
			_aspect = _aspectForced;
		};
	};

	gm_currentAspect = instantiate(_aspect);
	
};

gm_pickMultiAspects = {
	params ["_aspObj"];
	private _count = getVar(_aspObj,aspectsCount);
	private _picked = [];
	private _allAspects = getAllObjectsTypeOf(BaseGameAspect) - ["EmptyGameAspect"]; //тихий день убираем из мультиаспектов
	private _curMode = callFunc(gm_currentMode,getClassName);

	for "_i" from 1 to _count do {
		private _possibleAspects = [];
		private _aspectWeights = [];
		private _modes = [];
		
		{

			if ([_x,_curMode] call gm_isAspectAllowedToMode) then {
				_possibleAspects pushBack _x;
				_aspectWeights pushBack getFieldBaseValue(_x,"weight");
			} else {
				//! _modes не меняется и скорее всего не нужно. Проверить и поправить
				/*
				private _idx = _modes findif {_x == _curMode};
				if (_idx != -1) then {
					_possibleAspects pushBack _x;
					_aspectWeights pushBack getFieldBaseValue(_x,"weight");
				};
				*/
			};
		} foreach _allAspects;
		
		if (count _possibleAspects == 0 )exitwith {
			errorformat("gm::pickMultiAspects() - error on %1; Picked %2",_aspObj arg _picked);
		};

		private _aspect = _possibleAspects selectRandomWeighted _aspectWeights;
		if isNullVar(_aspect) then {
			_aspect = pick _possibleAspects;
		};

		_picked pushBackUnique _aspect;
		_allAspects = _allAspects - [_aspect];
	};

	setVar(_aspObj,internalAspects,_picked apply {instantiate(_x)});
};

//получение всех доступных событий
gameEvents_getPossibleEvents = {
	private _typelist = call gameEvents_sys_getAllEventTypes;
	private _possibleEvents = [];
	private _weights = [];
	private _curMode = callFunc(gm_currentMode,getClassName);
	{
		traceformat("	check allow event %1",_x)
		//std check map and gamemode
		if ([_x,_curMode] call gameEvents_internal_isEventAllowedToSession) then {
			traceformat("	allowed to session - %1",_x)
			//check multiplay
			private _canPlayMoreOneTime = if (call typeGetVar(typeGetFromString(_x),isMultiplay)) then {
				true
			} else {
				!(_x in gameEvents_internal_map_createdEvents)
			};
			if (_canPlayMoreOneTime) then {
				traceformat("	multiplay check - %1",_x)
				//low-level reflection check
				if (call typeGetVar(typeGetFromString(_x),canPlay)) then {
					traceformat("	canplay - %1",_x)
					_possibleEvents pushBack _x;
					_weights pushBack getFieldBaseValue(_x,"weight");
				};
			};
			

		};
		trace("------------")
	} foreach _typelist;
	
	[_possibleEvents,_weights];
};

gameEvents_internal_list_allObjects = [];

//запуск события
gameEvents_pickEvent = {
	params ["_evs","_wts"];
	if (count _evs == 0) exitwith {nullPtr};

	private _event = _evs selectRandomWeighted _wts;
	if isNullVar(_event) then {
		_event = pick _evs;
	};
	private _obj = instantiate(_event);
	gameEvents_internal_list_allObjects pushback _obj;
	_obj
};

gameEvents_internal_isEventAllowedToSession = {
	params ["_aspect","_curMode"];
	private _modes = getFieldBaseValue(_aspect,"allowedModes");
	private _maps = getFieldBaseValue(_aspect,"allowedMaps");
	private _curmap = getFieldBaseValueWithMethod(_curMode,"map","getMapName");
	private _isAllowed = false;

	//не доступен для всех карт (не публичный) И не доступен для текущией карты
	if (count _maps > 0 && {(_maps findif {_x == _curmap})==-1}) exitwith {false};

	if (count _modes == 0) then {
		_isAllowed = true;
	} else {
		private _idx = _modes findif {_x == _curMode};
		if (_idx != -1) then {
			_isAllowed = true;
		};
	};
	_isAllowed
};

gameEvents_process = {
	private _dat = call gameEvents_getPossibleEvents;
	
	//logging
	[format["EVT -> Possible events: %1",_dat]] call gameLog;
	traceformat("EVT -> Possible events: %1",_dat)
	
	private _obj = _dat call gameEvents_pickEvent;
	if isNullReference(_obj) exitwith {
		["EVT -> No event selected..."] call gameLog;
		trace("EVT -> No event selected...")
		false;
	};

	[format["EVT -> Now started %1 (%2)",getVar(_obj,roundDurationCreated),_obj]] call gameLog;
	traceformat("EVT -> Now started %1 (%2)",getVar(_obj,roundDurationCreated) arg _obj)

	// message already printed in ctor
	//print message
	//callFunc(_obj,playNotification);

	true
};


//gm_mainGroup = createGroup east;

//создаёт игровую оболочку
gm_createMob = {
	private _pos = _this;
	//private _mob = gm_mainGroup createUnit [BASIC_MOB_TYPE, [0,0,0], [], 0, "NONE"];

	private _mob = createAgent [BASIC_MOB_TYPE, [0,0,0], [], 0, "NONE"];
	
	//only after platform 2.18
	_mob setPhysicsCollisionFlag false;

	_mob disableAI "MOVE";
	_mob disableAI "TARGET";
	_mob disableAI "AUTOTARGET";
	_mob disableAI "FSM";
	_mob disableAI "ANIM";

	_mob setVariable ["mob_flag",true];

	//_mob addWeaponGlobal "CombatMode"; // add handgun weapon for combat anim

	//freefall update works only after platform version 2.10
	_mob setUnitFreefallHeight 5000;

	private _tx = table_hex;
	_mob setvariable ["voiceptr",pick _tx + pick _tx + pick _tx + pick _tx + pick _tx + pick _tx,true]; //generator pointers for voice system
	removeUniform _mob;
	assert(uniform _mob == "");
	//_mob action ["SwitchWeapon", _mob, _mob, 100];
	//_mob switchmove "amovpercmstpsnonwnondnon";
	if equals(_pos,0) exitWith {_mob};
	_mob setPosAtl _pos;
	_mob
};

gm_createSimpleMob = {
	params ["_pos"];
	private _mob = createAgent [BASIC_MOB_TYPE, [0,0,0], [], 0, "NONE"];
	removeUniform _mob;
	_mob disableAI "MOVE";
	_mob disableAI "TARGET";
	_mob disableAI "AUTOTARGET";
	_mob disableAI "FSM";
	_mob disableAI "ANIM";
	
	_mob setUnitFreefallHeight 5000;
	_mob setPhysicsCollisionFlag false;
	
	_mob setPosAtl _pos;
	_mob
};

lobby_createDummy = {
	params ["_pos",["_isWoman",false],["_canSim",false]];
	private _mob = createAgent [BASIC_MOB_TYPE, [0,0,0], [], 0, "NONE"];
	_mob disableAI "MOVE";
	_mob disableAI "TARGET";
	_mob disableAI "AUTOTARGET";
	_mob disableAI "FSM";
	_mob disableAI "ANIM";

	

	removeUniform _mob;
	_mob setPosAtl _pos;
	if (_isWoman) then {
		_mob forceAddUniform getFieldBaseValue("MobWoman","defaultUniform");
	};
	//отключение симуляции сбивает синхронизацию формы
	_mob ENABLESIMULATIONGLOBAL _canSim;
	_mob
};
private _canCreateDummy = true;

if (_canCreateDummy) then {
	private _dummyMobPos = [50,50,0];
	private _dummyMan = [_dummyMobPos,false,true] call lobby_createDummy;
	netSetGlobal(lobby_glob_dummy_man,_dummyMan);
	assert(!isNullReference(_dummyMan));
};

