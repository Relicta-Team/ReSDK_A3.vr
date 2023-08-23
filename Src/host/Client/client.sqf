// ======================================================
// Copyright (c) 2017-2023 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include "..\oop.hpp"
#include "..\engine.hpp"
#include "..\text.hpp"
#include <..\ServerRpc\serverRpc.hpp>
#include <..\GamemodeManager\GamemodeManager.hpp>
#include <..\Family\Family.hpp>
#include <..\MatterSystem\bloodTypes.hpp>
#include <..\Networking\Network.hpp>

// TODO: если проблема с назначением не исправится, то рекомендуется вариант динамического создания и выгрузки мобов при необходимости.

// логирование подключения клиента
#define use_client_connection_log

#ifdef use_client_connection_log
	#define debug(var,fmt) logformat("[ServerClient::DEBUG]: " + (format[" (client:%1<%2>) " arg getSelf(id) arg getSelf(name)]) + var,fmt);
#else
	#define debug(var,fmt)
#endif

class(ServerClient) /*extends(NetObject)*/

	//список всех чанков на которые подписан клиент
	var(loadedChunks,null);
	
	var(lastDeadTime,0);//время последней смерти
	var(deadTimeout,60*15); //сколько ждать до воскрешения. дефолтное значение
	func(setDeadTimeout) {objParams_1(_time); setSelf(deadTimeout,_time)}; //установка таймера смерти
	func(getDeadTimeout)
	{
		objParams();
		private _deadTimeout = getVar(this,deadTimeout);
		#ifdef EDITOR
		_deadTimeout = 10;
		#endif
		#ifdef DEBUG
		_deadTimeout = 2;
		#endif
		_deadTimeout
	};
	var(lastCharData,vec2("",""));//последние данные которые проверяются для возможности захода
	
	getter_func(isConnected,this in cm_allClients); //подключен ли клиент к игре
	
	var(reputation,0); //репутация игрока
	var(testResult,""); //прошел ли тест игрок
	var(isFirstJoin,true); //первый ли вход игрока в игру

	func(constructor)
	{
		//objParams_2(_uid,_id);
		objParams();

		ctxParams params ["_id","_uid"];

		this setName ((name this) + "::" + str _id);

		setSelf(uid,_uid);
		setSelf(id,_id);

		//private _access = _uid call cm_getAccessByUid;
		//setSelf(access,_access); //player

		//critical exit in debug mode
		/*if (!isMultiplayer) exitWith {
			setSelf(name,_name);
			//[this] call db_updateClientSettings; //test validate
			callSelf(onConnected);
		};*/

		//checking register
		//if ([this] call db_isClientRegistered) then {
			//traceformat("load client %1",_name);
			[this] call db_loadClient;
		/*} else {
			traceformat("register new client %1",_name);
			[this] call db_registerClient;
		};*/		

		callSelf(onConnected);
		
	};
	
	var(votingData,null); //данные о голосовании (лучшие и худшие)
	getter_func(isNeedToVote,!isNull(getSelf(votingData)));

	func(destructor)
	{
		objParams();

		callSelf(onFinalize);

		traceformat("Client %1 deleted",getSelf(name));
	};
	
	func(unsubAllChunks)
	{
		objParams();
		//Был в игре выписываем из чанков
		if (getSelf(state) == "ingame") then {
			private _ch__ = null;
			//отписываем клиента из всех чанков
			{
				_ch__ = parseSimpleArray _x;
				rpcCall("unsubChunkListen",vec4(_ch__ select 0,_ch__ select 1,getSelf(id),false));
			} foreach (getSelf(loadedChunks));
			setSelf(loadedChunks,null);
		};
	};
	
	func(onFinalize)
	{
		objParams();

		[this] call db_saveClient;
		
		callSelf(unsubAllChunks); //вызывается раньше удаления клиента так как в unsubChunkListen используется cm_findClientById
		
		cm_allClients deleteat (cm_allClients find this);

		cm_disconnectedClients set [getSelf(uid),this];

		traceformat("Disconnected client saved - %1",equals(cm_disconnectedClients get getSelf(uid),this));
		
		if getSelf(isMBOpened) then {
			callSelf(onClosedMessageBox);
		};

		//удаляем из претендентов
		if getSelf(isReady) then {
			if (call gm_isRoundLobby) then {
				/*_setList = getSelf(charSettingsValues);

				for "_i" from 1 to 3 do {
					_role = _setList select _i;
					if (_role != "none") then {

						private _oldInd = gm_roles findif {(_x select ROLE_CLASS) == _role};
						if (_oldInd == -1) then {
							warningformat("ServerClient::destructor() - Cant find old role <%1>.",_role);
						} else {
							private _oldContenders = gm_roleContenders select _oldInd;
							private _oldClientIndex = _oldContenders findif {equals(_x select 0,this)};
							if (_oldClientIndex == -1) then {
								warningformat("ServerClient::destructor() - Cant find client for remove in role %1",_role);
							} else {
								//now we finded client! Remove him
								_oldContenders deleteAt _oldClientIndex;
							};
						};
					};
				};*/
				callSelf(removeDefaultRoles); //Функционал убирания игрока из претендентов
			};

			setSelf(isReady,false);

		};
		if getSelf(isInEmbark) then {
			//снять с эмбарка. Включает сброс переменной
			[this,false] call gm_removeClientFromEmbark;
		};


		[format["Disconnected - %1 (netid: %2; uid: %3)",getSelf(name),getSelf(id),getSelf(uid)]] call discLog;
	};

	//Принудительно отключение клиента
	func(forceDisconnect)
	{
		objParams_1(_reason);
		if !callSelf(isConnected) exitWith {false};
		[getSelf(id) arg _reason] call cm_serverKickById;
	};

	var_num(id); //айди клиента
	var_str(uid); //стим-айди клиента
	var_str(name); //имя клиента
	var_num(access); //уровень доступа
	var_num(points); //Очки
	var(clientSettings,[createHashMap arg createHashMap arg createHashMap]); //настройки аккаунта. управление,графика и игра. Порядок фиксирован
	//Цвета ника и сообщений
	var_str(nickColor);
	var_str(mesColor);
	
	//массивы датавремени
	var(prevDayLastJoin,""); //отметка когда последний раз человек заходил в игру на прошлой сессии (значение из DB - lastJoin с предыдущего запуска)
	var(firstJoin,"");
	var(_firstJoinDB,"");//реальное значение из бд. Массив RVDate
	
	var(playedRounds,0); //сколько раундов отыграл (был в игре на конец раунда)
	
	//Отправляет клиентские настройки локальному клиенту. Вызывается в db::loadClient()
	func(sendClientSettings)
	{
		objParams();

		private _list = [];

		{
			_list pushBack [_x,_y];
		} foreach (getSelf(clientSettings) select 0);

		if (count _list > 0) then {
			//Отправляем управление на обработку
			rpcSendToClient(getSelf(id),"onLoadKeybinds",_list);
		};

		//sending game settings
		_list = [];
		{
			_list pushBack [_x,_y];
		} foreach (getSelf(clientSettings) select 2);

		if (count _list > 0) then {
			rpcSendToClient(getSelf(id),"onLoadGameSettings",_list);
		};
	};

	var(state,"awaitlogin"); //где клиент awaitlogin,lobby,ingame

	func(onChangeState)
	{
		objParams_1(_newState);

		private _oldState = getSelf(state);

		call {
			if (_oldState == "lobby") exitWith {

			};
			if (_oldState == "ingame") exitWith {
				callSelfParams(stopMusic,"MUSIC_CHANNEL_AMBIENT");
			};
		};

		setSelf(state,_newState);
	};

	getter_func(isInLobby,getSelf(state) == "lobby");
	getter_func(isInGame,getSelf(state) == "ingame");

	func(onConnected)
	{
		objParams();

		#ifdef RELEASE
		[getSelf(uid)] call db_updateValuesOnConnect;
		#endif

		//cleanup chunks
		setSelf(loadedChunks,createHashMap);

		cm_allClients pushBack this;
		setSelf(isReady,false);
		[format["Connected and ready - %1 (netid: %2; uid: %3)",getSelf(name),getSelf(id),getSelf(uid)]] call discLog;

		netSendVar("cd_clientName",getSelf(name),getSelf(id)); //быстренько отсылаем клиенту его имя

		//Отправляем клиенту его настройки
		callSelf(sendClientSettings);

		//Подключившемуся отправляем его сисмесы
		callSelf(initSystemMessagesOnConnect);

		#ifdef PRIVATELAUNCH
		server_privateLaunch_list_awaitCheck pushBackUnique this;
		#endif

		private _postCheck = {
			
			if (rep_system_enable) then {
				[this] call db_handleReputation;
			};

			if getSelf(isFirstJoin) then {
				setSelf(isFirstJoin,false);

				if (rep_system_enable) then {
					private _ref = refcreate(0);
					if ([getSelf(name),getSelf(reputation),_ref] call db_hasNeedClientVote) then {
						setSelf(votingData,refget(_ref));
					};
				};
			};

			if (!rep_system_enable) exitWith {};

			if (getSelf(state) == "lobby") then {
				if (getSelf(testResult)!="") then {
					private _r = callSelf(reputationToString);
					callSelfParams(localSay,"<t size='1.8' color='#00F59B' shadowColor='#206600'>Ваша репутация - '" + _r+"'</t>" arg "system");
				};
			};

			if callSelf(isNeedToVote) then {
				[this,getSelf(votingData)] call repvote_startVotingClient;
			};
		};

		if (call gm_isRoundLobby || call gm_isRoundPreload) exitWith {

			callSelfParams(onChangeState,"lobby");

			[format["%1 %2.",getSelf(name),pick ["подключился","зашёл на огонёк","залетел"]]] call cm_sendLobbyMessage;

			if (!call gm_isRoundPreload) then {
				[this] call gm_syncRolelistToClient;
			} else {
				if (gm_canVote) then {
					[this] call gm_showVoteMessage;
				};
			};

			rpcSendToClient(callSelf(getOwner),"openLobby",callSelf(collectClientSettings));

			//проверка до старта
			call _postCheck;
		};
		
		//проверка если игра уже идёт
		//! Возможно из-за того, что это событие вызывается раньше открытия лобби могут возникать ошибки с голосованием
		call _postCheck;

		//В любом случае нам нужны все претенденты даже если лейт гейм
		[this] call gm_syncRolelistToClient;
		
		if (call gm_isRoundPlaying || call gm_isRoundEnding) exitWith {				
			if (getSelf(state) == "ingame") then {
				private _playerObject = getSelf(actor);
				private _mob = getVar(_playerObject,link);
				private _initialPos = callFunc(_mob,getInitialPos);
				rpcSendToClient(callSelf(getOwner),"prepPlayerPos",vec2(_initialPos,_playerObject));
			} else {
				
				callSelfParams(onChangeState,"lobby");
				
				rpcSendToClient(callSelf(getOwner),"openLobby",callSelf(collectClientSettings));
			};
		};
	};

	func(tryConnectToMob)
	{
		objParams_1(_mob);
		if callFunc(_mob,isPlayer) exitwith {false};
		private _playerObject = getVar(_mob,owner);
		if isNullReference(_playerObject) exitwith {false};

		if (callSelf(isInLobby)) then {
			rpcSendToClient(callSelf(getOwner),"closeLobby",0);
			callFuncParams(this,onChangeState,"ingame");
		};

		setVar(this,actor,_playerObject);

		private _initialPos = callFunc(_mob,getInitialPos);
		rpcSendToClient(callSelf(getOwner),"prepPlayerPos",vec2(_initialPos,_playerObject));
		true
	};

	func(collectClientSettings)
	{
		objParams();
		private _sets = [];

		{
			_sets pushBack [_x,_y];
		} foreach getSelf(charSettings);

		_sets
	};

	var(isReady,false);//готов ли клиент к игре
	var(isInEmbark,false); //находится ли в эмбарке
		var(embarkRole,nullPtr);//ссылка на эмбарковую роль

	var_obj(actor); //целевой объект клиента
	func(getActorMob) //Получает моба актора. Если нет актора то nullPtr
	{
		objParams();
		private _act = getSelf(actor);
		if isNullReference(_act) exitwith {nullPtr};
		_act getvariable vec2("link",nullPtr)
	};
	var(lastMob,nullPtr); //последняя сущность за которую играл клиент
	var(__internal_destrMob,nullPtr); //системная переменная. используется при удалении моба к которому был подключен игрок

	func(getOwner)
	{
		objParams();
		getSelf(id)
	};

	//! при изменении структуры дополнить шаблон в gm_initHashMapCharSettings
	// (Client::charSettings) mainhand rule: 0 left, 1 right
	#define hashPair(key,val) [#key,val]
	var(charSettings,createHashMapFromArray [
		hashPair(name,([0] call naming_getRandomName) joinString " ") arg
		hashPair(age,randInt(18,80)) arg
		hashPair(gender,0) arg
		hashPair(face,"rand") arg
		hashPair(role1,"none") arg
		hashPair(role2,"none") arg
		hashPair(role3,"none") arg
		hashPair(mainhand,1) arg
		hashPair(vice,"rand") arg
		hashPair(family,FAMILY_DEFAULT) arg
		hashPair(blood,BLOOD_TYPE_RANDOM) arg
		hashPair(faith,"fugu") arg
		hashPair(antag,0)
		]);
		//antag - 0 none; 1 hide, 2 unical, 3 all

	var(charSettingsTemplates,[null arg null arg null arg null arg null]);

	func(setCharSetting) {
		objParams_2(_settingName,_value);

		private _hashSettings = getSelf(charSettings);

		//============================== special for randoms ==============================
			//Random name
		if equals("r-name",_settingName) exitWith {
			_settingName = "name";
			private _gender = _hashSettings get "gender";

			private _newName = ([_gender] call naming_getRandomName) joinString " ";
			_hashSettings set [_settingName,_newName];

			private _owner = callSelf(getOwner);
			rpcSendToClient(_owner,"onCharSettingCallback",["name" arg _newName])
		};
		
		//Ограничение на отыгранные раунды
		private _NEED_PLAYED_ROUNDS_COUNT_TO_CHANGE_NAME = 10;
		if (_settingName == "name" && {(getSelf(access) call cm_accessNumToType) == "ACCESS_PLAYER"} && {getSelf(playedRounds) < _NEED_PLAYED_ROUNDS_COUNT_TO_CHANGE_NAME}) exitWith {
			callSelfParams(localSay,"<t size='1.5'>Отыграйте ещё "+([(_NEED_PLAYED_ROUNDS_COUNT_TO_CHANGE_NAME - getSelf(playedRounds)) arg vec3("раунд","раунда","раундов") arg true] call toNumeralString)+" для возможности установки своего имени.</t>" arg "error");
		};


		private _settingData = _hashSettings get _settingName;

		if isNullVar(_settingData) exitWith {
			errorformat("Cant find setting name %1. Valuse was %2; owner %3",_settingName arg _value arg _owner);
		};

		//special action for role
		if ("role" in _settingName) exitWith {
			private _priority = parseNumber (_settingName select [count _settingName - 1,1]);
			if (_priority <= 0 || _priority > 3) then {
				errorformat("Priority error. Unexpected priority %1. setting: <%2> Set by default to 1.",_priority arg _settingName);
				_priority = 1;
			};

			private _result = if (call gm_isRoundLobby) then {
					private _robj = _value call gm_getRoleObject;
					if (_value != "none" && {isNullReference(_robj)}) exitWith {
						errorformat("ServerClient::setCharSetting() - Unknown role %1",_value);
						false
					};
					private _isBanned = !callFuncParams(_robj,isAllowedRoleToClient,this arg callSelf(getBannedRoles));
					if (_value != "none" && 
						{!callFuncParams(_robj,canTakeInLobby,this arg true)} || 
						{_isBanned}
					) exitWith {
						if (_isBanned) then {
							callSelfParams(localSay,format vec2("<t size='1.5'>Роль '%1' недоступна для вас</t>",getVar(_robj,name)) arg "system");
						};
						false
					};

					if getSelf(isReady) then {
						[this,_value,_priority,_settingData,true] call gm_addContenderToRole
					} else {true}
				} else {
					true //если не лобби то в претенденты не добавляем
				};
			//successed update role
			if (_result) then {
				_hashSettings set [_settingName,_value];

				private _owner = callSelf(getOwner);
				rpcSendToClient(_owner,"onCharSettingCallback",[_settingName arg _value])
			};
		};

		//Высылаем описание порока
		if (_settingName == "vice") then {
			callSelfParams(localSay,[_value] call traits_getViceDescByClass arg "system");
		};

		_hashSettings set [_settingName,_value];

		private _owner = callSelf(getOwner);
		rpcSendToClient(_owner,"onCharSettingCallback",[_settingName arg _value]);

		//При смене пола устанавливаем лицо на рандомное
		//И имя тоже
		if (_settingName == "gender") then {
			private _newFace = ["face","rand"];
			_hashSettings set _newFace;
			rpcSendToClient(_owner,"onCharSettingCallback",_newFace);

			private _gender = _hashSettings get "gender";
			private _newName = ([_gender] call naming_getRandomName) joinString " ";
			_hashSettings set ["name",_newName];

			rpcSendToClient(_owner,"onCharSettingCallback",["name" arg _newName]);
		};
	};

	//Регистрирует роли при готовности
	func(addDefaultRoles)
	{
		objParams();
		private _settings = getSelf(charSettings);
		private _ret = true;
		private _bFlag = true;
		{
			if (!([this,_x,_forEachIndex + 1,null,_bFlag] call gm_addContenderToRole)) exitWith {
				errorformat("Error on ServerClient::addDefaultRoles() - gm::addContenderToRole() returns false on %1 pass",_forEachIndex + 1);
				_ret = false;
			};
			_bFlag = false; //drop flag
		} foreach [_settings get "role1",_settings get "role2",_settings get "role3"];

		_ret
	};

	func(removeDefaultRoles)
	{
		objParams();

		#define getRoleByClass(val) (missionNamespace getVariable ["role_"+(val),nullPtr])
		private _clientSettings = getSelf(charSettings);
		private _role = "nan";
		private _roleKeys = ["role1","role2","role3"];
		private _hasSynced = false;

		{
			_role = _clientSettings get _x;

			if (_role != "none") then {

				//first step - remove client from old contenders
				private _oldData = getRoleByClass(_role);
				if isNullReference(_oldData) then {
					warningformat("ServerClient::removeDefaultRoles() - Cant find old role <%1>.",_role);
				} else {

					private _oldContenders =  getVarReflect(_oldData,"contenders_"+str (_forEachIndex+1));
					private _oldClientIndex = _oldContenders findif {equals(_x,_client)};
					if (_oldClientIndex == -1) then {
						warningformat("ServerClient::removeDefaultRoles() - Cant find client for remove in role %1",_role);
					} else {
						_oldContenders deleteAt _oldClientIndex;
					};
				};

				//Обновляем контендерлист
				if (call gm_isRoundLobby && _forEachIndex == 0) then {
					(_forEachIndex) call gm_syncRoleContenders;
					_hasSynced = true;
				};

			};

		} foreach _roleKeys;

		if (!_hasSynced) then {
			0 call gm_syncRoleContenders;
		};
	};

	//сброс всех ролей с синхронизацией по сети + установка значений в карте настроек
	func(resetAllRoles)
	{
		objParams();
		private _settings = getSelf(charSettings);
		private _ret = true;
		private _bFlag = true;
		{
			if ("none" == _x) then {continue};

			if (!([this,"none",_forEachIndex + 1,_x,_bFlag] call gm_addContenderToRole)) then {
				errorformat("Error on ServerClient::resetAllRoles() - gm::addContenderToRole() returns false on %1 pass",_forEachIndex + 1);
				_ret = false;
				break;
			} else {
				_settings set ["role"+str(_forEachIndex+1),"none"];
			};
			_bFlag = false; //drop flag
		} foreach [_settings get "role1",_settings get "role2",_settings get "role3"];
		_ret
	};

	// Получает приоритет на роли. Позволяет управлять правилом если 2 клиента на одной роли, то получит её тот клиент, у котого getPriorityForRoles() больше
	func(getPriorityForRoles)
	{
		objParams();
		getSelf(access)
	};

	//очистка последней проверки забаненных ролей
	getter_func(flushBannedRolesLastGet,setSelf(_getBannedRoles_lastGet,0));

	var(_getBannedRoles_lastGet,0);
	var(_bannedRolesCache,[]);
	//запрос в бд на получение забаненных ролей
	func(getBannedRoles)
	{
		objParams();
		if (tickTime >= getSelf(_getBannedRoles_lastGet)) then {
			private _lastRes = [getSelf(uid)] call db_getAllBannedRoles;
			setSelf(_getBannedRoles_lastGet,tickTime + (60*10));
			setSelf(_bannedRolesCache,_lastRes);
			_lastRes;
		} else {
			getSelf(_bannedRolesCache);
		};
	};

	//Отсылает личное сообщение клиенту
	func(localSay)
	{
		objParams_2(_mes,_categ);

		rpcSendToClient(getSelf(id),"chatPrint",[_mes arg _categ]);
	};

	//Отсылает в лобби всем сообщение с поддержкой цвета текста и ника
	func(sayLobby)
	{
		objParams_1(_text);

	 	_text = format[
			(if (getSelf(nickColor)!="")then{format["<t color='#%1'>%2</t>: ",getSelf(nickColor),"%1"]}else{"%1: "}) +
			(if (getSelf(mesColor)!="")then{format["<t color='#%1'>%2</t>",getSelf(mesColor),"%2"]}else{"%2"})
		,getVar(_client,name),_text];

		{
			if callFunc(_x,isInLobby) then {
				rpcSendToClient(callFunc(_x,getOwner),"chatPrint",[_text]);
			};
		} foreach (call cm_getAllClientsInLobby);
	};

	func(sayOOC)
	{
		objParams_1(_text);
		NOTIMPLEMENTED(ServerClient::sayOOC);
	};

region(Points system)

	//_onlyOnGame - добавляет только пока идет раунд
	func(addPoints)
	{
		params ['this',"_p",["_onlyOnGame",false]];

		//forceoff onlygame onEndGame, onEndGameBasic
		if !isNullVar(__GFLAG_ENDGAME_POINTS_UPDATE__) then {_onlyOnGame = false};

		if (_onlyOnGame && {[">=","GAME_STATE_END"] call gm_checkState}) exitwith {};

		_p = round _p;
		if (_p <= 0) exitwith {};
		#ifndef DEBUG
		modSelf(points, + _p);
		#endif
		callSelfParams(playSound,"effects\tension3" arg rand(0.9,1.1) arg 1.1);
		private _m = format["<t size='1.8' color='#00A876' shadow='1' shadowColor='#014708'>%1</t>",
			format[[_p,["Получен %1 хвостик","Получено %1 хвостика","Получено %1 хвостиков"],false] call toNumeralString,_p]
		];
		callSelfParams(localSay,_m);
	};

	func(removePoints)
	{
		params ['this',"_p",["_onlyOnGame",false]];

		//forceoff onlygame onEndGame, onEndGameBasic
		if !isNullVar(__GFLAG_ENDGAME_POINTS_UPDATE__) then {_onlyOnGame = false};

		if (_onlyOnGame && {[">=","GAME_STATE_END"] call gm_checkState}) exitwith {};

		_p = round _p;
		if (_p <= 0) exitwith {};
		#ifndef DEBUG
		modSelf(points, - _p);
		#endif
		callSelfParams(playSound,"effects\tension1" arg rand(0.6,0.8) arg 1.1);
		private _m = format["<t size='1.8' color='#D95638' shadow='1' shadowColor='#B53600'>%1</t>",
			format[[_p,["Потерян %1 хвостик","Потеряно %1 хвостика","Потеряно %1 хвостиков"],false] call toNumeralString,_p]
		];
		callSelfParams(localSay,_m);
	};

region(Traits system)
	var(traitObject,nullPtr);
	getter_func(hasTrait,!isNullReference(getSelf(traitObject)));

	func(handlePressTrait)
	{
		objParams();
		if callSelf(hasTrait) then {
			callSelfParams(localSay,"Ваша особенность: " + getVar(getSelf(traitObject),desc));
		} else {
			//TODO generate trait
		};
	};

region(system actions)

	//Обработчик системных действий
	func(playSystemAction)
	{
		objParams_1(_action);
		call (serverclient_internal_map_sysmes getOrDefault [_action,{
			errorformat("Cant call system message %1 - not found",_action);
			}]);
	};
	func(addSystemAction)
	{
		objParams_3(_cat,_name,_runame);
		
		rpcSendToClient(getSelf(id),"addLobbySystemAction",vec3(_cat,_name,_runame));
	};
	func(removeSystemAction)
	{
		objParams_2(_cat,_name);
		
		rpcSendToClient(getSelf(id),"removeLobbySystemAction",vec2(_cat,_name));
	};

	func(initSystemMessagesOnConnect)
	{
		objParams();
		private _status = getSelf(access);
		if (_status >= (["ACCESS_ADMIN"] call cm_accessTypeToNum)) then {
			callSelfParams(addSystemAction,"admin" arg "admin_lobbytimer" arg "Переключить таймер");
			callSelfParams(addSystemAction,"admin" arg "admin_setmode" arg "Установить режим");
			callSelfParams(addSystemAction,"admin" arg "admin_forceaspect" arg "Форс аспекта");
			callSelfParams(addSystemAction,"admin" arg "admin_startObserver" arg "Зайти в наблюдателя");
			callSelfParams(addSystemAction,"admin" arg "admin_returnToLastBody" arg "Вернуться в своего персонажа");
			callSelfParams(addSystemAction,"admin" arg "admin_discrolesprotect" arg "Переключить доступ к ролям по дискорду");
			callSelfParams(addSystemAction,"admin" arg "admin_setlastgame" arg "Переключить режим последнего раунда");
			callSelfParams(addSystemAction,"admin" arg "admin_setendgame" arg "Закончить режим с кастомным текстом");

			callSelfParams(addSystemAction,"server" arg "server_srvrest" arg "ПЕРЕЗАПУСТИТЬ СЕРВЕР");
			callSelfParams(addSystemAction,"server" arg "server_srvstop" arg "ВЫКЛЮЧИТЬ СЕРВЕР");
			callSelfParams(addSystemAction,"server" arg "server_srvislock" arg "Залочен ли сервер?");
			callSelfParams(addSystemAction,"server" arg "server_srvlockswitch" arg "Переключить лок сервера");
		};
	};
	
	var(isMBOpened,false);

	//аналогия как на мобе
	func(ShowMessageBox)
	{
		objParams_4(_name,_data,_eventHandler,_eventClose);
		if isNullVar(_eventClose) then {_eventClose = {}};

		if callSelf(isInLobby) then {
			//отключенный клиент не откроет МБХ
			if !callSelf(isConnected) exitwith {};

			private _noHandler = isNullVar(_eventHandler);
			if (_name != "Text" && _noHandler) exitWith {
				errorformat("Error on show message box: Event handler cannot be empty on mode %1; Data was: %2",_name arg _data);
				false
			};
			if (!(_name in ["Text","MessageBox","Listbox","Input","Alert"]) && _noHandler) exitWith {
				errorformat("Unknown message box type - %1; Data was: %2",_name arg _data);
			};
			if !callSelfParams(__updateMBHandler,_name arg _eventHandler) exitWith {
				errorformat("Cannot update message box handler - %1; Data was: %2",_name arg _data);
			};

			//closing prev mb
			if getSelf(isMBOpened) then {
				callSelf(closeMessageBox);
			};

			setSelf(delegate_messageBoxInput,_eventHandler);
			setSelf(delegate_messageBoxClose,_eventClose);
			setSelf(isMBOpened,true);
			rpcSendToClient(getSelf(id),"opnNDLobby",vec2(_name,_data));
		} else {
			_mob = getVar(getSelf(actor),link);
			callFuncParams(_mob,ShowMessageBox,_name arg _data arg _eventHandler arg null arg _eventClose);
		};
	};
	
	//Обратите внимание, что этот месседжбокс обновляется через параметры а не через внутреннюю логику
	func(UpdateMessageBox)
	{
		objParams_1(_data);
		if !getSelf(isMBOpened) exitWith {
			errorformat("Cant update message box: Message box is not opened for client %1",getSelf(name));
		};
		rpcSendToClient(getSelf(id),"updND",_data);
	};
	
	func(CloseMessageBox)
	{
		objParams();
		setSelf(isMBOpened,false);
		rpcSendToClient(getSelf(id),"clsNDLobby",[true]);
	};
	//событие вызывается когда клиент закрывает месседжбокс
	func(onClosedMessageBox)
	{
		objParams();
		setSelf(isMBOpened,false);
		call getSelf(delegate_messageBoxClose);
	};
	
	var(delegate_messageBoxInput,{});
	var(delegate_messageBoxClose,{});
	func(handleMessageBoxInput)
	{
		objParams_1(_inp);
		call getSelf(__mbHandler);
	};
	var(__mbHandler,{});
	func(__updateMBHandler)
	{
		objParams_2(_typeHandler,_codeHandler);
		private _list = [
			["Listbox",{
				//_inp was index and value from data
				_inp params ["_value","_index"];
				_ev__ = getSelf(delegate_messageBoxInput);
				call _ev__;
			}],
			["Text",
			{
				//no action was placed
			}],
			["MessageBox",
			{
				//_inp == 1 - is pressed apply button
				// other cases is cannot be sended
				_value = _inp;
				_ev__ = getSelf(delegate_messageBoxInput);
				call _ev__;
			}],
			["Input",
			{
				_value = _inp;
				_ev__ = getSelf(delegate_messageBoxInput);
				call _ev__;
			}]
		];
		private _idx = _list findif {_x select 0 == _typeHandler};
		if (_idx == -1) exitwith {
			setSelf(__mbHandler,_codeHandler);
			true
		};
		setSelf(__mbHandler,_list select _idx select 1);
		true
	};

	func(showChangelogs)
	{
		objParams();
		if (serverclient_internal_string_changelogs == "") then {
			_t = preprocessFile "src\CHANGELOGS.txt";
			_t = _t splitString (toString[10,13]) joinString sbr;
			serverclient_internal_string_changelogs = format[_t,relicta_version];
		};
		if (rep_system_enable && equals(getSelf(testResult),"")) exitwith {};
		if getSelf(isMBOpened) exitwith {};
		
		callSelfParams(ShowMessageBox,"Text" arg serverclient_internal_string_changelogs);
	};

	//событие которое вызывается при смене моба. Например при перемещении из живчика в госта
	var(delegate_onRequestNextMob,{});
	var(ctxOnRequestNextMob,[]); //контекст параметры события при переключении на нового моба

region(Reputation helpers)
	//кастомная репутация
	var(reputationCustom,"");

	func(__rep_customToName)
	{
		objParams();
		private _repCustom = getSelf(reputationCustom);
		if (_repCustom == "bgvn") exitwith {"Быть говну"};
		if (_repCustom == "forsaken") exitwith {"Покинутый"};
		if (_repCustom == "essence") exitwith {"Суть"};
		""
	};

	func(reputationToString)
	{
		objParams();
		private _pCust = callSelf(__rep_customToName);
		if (_pCust != "") exitwith {
			_pCust
		};
		getSelf(reputation) call repvote_getReputationText;
	};

	func(isAllowedRoleByReputation)
	{
		objParams_1(_roleObj);
		
		if (!rep_system_enable) exitWith {true};

		[getSelf(reputation),_roleObj] call repvote_isAllowedRoleByReputation;
	};


region(rpc messaging)
	//отправка сообщения с обработкой на клиенте
	func(sendInfo)
	{
		objParams_2(_mes,_data);
		private _own = getSelf(id);
		rpcSendToClient(_own,_mes,_data);
	};

region(Clientside music manager and local sounds)

	func(playSound)
	{
		params['this',"_path",["_pitch",1],["_vol",1],"_isEffect"];
		
		private _ctx = [_path,_vol,_pitch];
		
		if !isNullVar(_isEffect) then {_ctx pushback _isEffect};

		callSelfParams(sendInfo,"sui_p" arg _ctx);
	};

	func(playMusic)
	{
		params ['this',"_pathOrArray","_chan","_ctx"];
		callSelfParams(sendInfo,"mproc" arg [0 arg _pathOrArray arg _chan arg _ctx]);
	};
	func(pauseMusic)
	{
		params ['this',"_chan",["_smooth",false]];
		callSelfParams(sendInfo,"mproc" arg [1 arg _chan arg _smooth]);
	};
	func(stopMusic)
	{
		params ['this',"_chan"];
		callSelfParams(sendInfo,"mproc" arg [2 arg _chan]);
	};

region(discord accounting)

	var(discordId,""); //unique discord id
	var(arrivedInCity,0); //сколько раз был зарегистрирован в городе

	var(hasFirstLoadedRoles,false);

	//зареган ли в дискорде чел
	getter_func(isDiscordAccountRegistered,getSelf(discordId)!="");

	//производит асинхронную синхронизацию дискордовых ролей с этим клиентом
	func(requestDiscordRoles)
	{
		objParams();
		if (!callSelf(isDiscordAccountRegistered)) exitWith {};

		[getSelf(name),getSelf(discordId)] call dsm_accounts_requestUpdateRoles;
	};
	//bot callback set roles
	func(updateDiscordRoles)
	{
		objParams_1(_roles);
		setSelf(hasFirstLoadedRoles,true);
		setSelf(_discordRolesCache,_roles);
	};

	func(hasDiscordRole)
	{
		objParams_1(_role);
		if (!call dsm_accounts_canUse) exitwith {true};
		(_role) in callSelf(getDiscordRoles)
	};

	//очистка последней проверки дискорд ролей
	getter_func(flushDiscordRolesLastGet,setSelf(_getDiscordRoles_lastGet,0));

	var(_getDiscordRoles_lastGet,0);
	var(_discordRolesCache,[]);

	//запрос на получение дискорд ролей
	func(getDiscordRoles)
	{
		objParams();
		if (tickTime >= getSelf(_getDiscordRoles_lastGet)) then {
			setSelf(_getDiscordRoles_lastGet,tickTime + (60*1));
			callSelf(requestDiscordRoles);
		};
		getSelf(_discordRolesCache);
	};

	func(addDiscordRole)
	{
		objParams_1(_role);

		if (!callSelf(isDiscordAccountRegistered)) exitWith {false};

		[getSelf(discordId),_role] call dsm_accounts_addToRole;
		callSelf(flushDiscordRolesLastGet);
		callSelf(getDiscordRoles);

		true
	};

	func(removeDiscordRole)
	{
		objParams_1(_role);

		if (!callSelf(isDiscordAccountRegistered)) exitWith {false};

		[getSelf(discordId),_role] call dsm_accounts_removeFromRole;
		callSelf(flushDiscordRolesLastGet);
		callSelf(getDiscordRoles);

		true
	};

endclass

serverclient_internal_string_changelogs = "";


//system message internal funcs
serverclient_internal_map_sysmes = createHashMapFromArray [

["NULL",{

#include <sysmes.h>
#include "client_SysMessages.sqf"

}]];