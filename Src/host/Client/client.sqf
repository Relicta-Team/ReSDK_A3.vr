// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include "..\oop.hpp"
#include "..\engine.hpp"
#include "..\text.hpp"
#include <..\ServerRpc\serverRpc.hpp>
#include <..\GamemodeManager\GamemodeManager.hpp>
#include <..\Family\Family.hpp>
#include <..\MatterSystem\bloodTypes.hpp>
#include <..\Gender\Gender.hpp>
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

	"
		name:Клиент
		desc:Класс клиента, создаваемый на стороне сервера, когда пользователь подключился к серверу.
		path:Клиенты
	"
	node_class

	//список всех чанков на которые подписан клиент
	var(loadedChunks,null);
	var(loadedAreas,null);
	
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
	
	"
		name:Подключен к серверу
		desc:Возвращает @[bool ИСТИНУ], если клиент подключен к серверу. Объекты отключенных клиентов не удаляются а остаются в кеше до перезапуска сервера.
		type:get
		lockoverride:1
		return:bool:Подключен ли клиент к серверу
	" node_met
	getter_func(isConnected,this in cm_allClients); //подключен ли клиент к игре
	
	var(reputation,0); //репутация игрока
	var(testResult,""); //прошел ли тест игрок

	"
		name:Первое подключение
		desc:Возвращает @[bool ИСТИНУ], когда клиент впервые подключился к серверу с момента его запуска. При повторных подключениях в рамках одной игровой сессии возвращает @[bool ЛОЖЬ].
		prop:get
		classprop:0
	" node_var
	var(isFirstJoin,true); //первый ли вход игрока в игру

	func(_updateObjectName)
	{
		objParams();
		private _cls = callSelf(getClassName);
		if getSelf(isFirstJoin) then {
			this setName (_cls + "::" + (str getSelf(id)));
		} else {
			this setName (_cls + "::" + (str getSelf(id)) + "(relog)");
		};
	};

	func(constructor)
	{
		objParams();

		ctxParams params ["_id","_disId"];

		this setName ((name this) + "::" + str _id);

		setSelf(discordId,_disId);
		setSelf(id,_id);

		#ifndef SP_MODE
		[this] call db_loadClient;
		#endif

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
				rpcCall("unsubChunkListen",vec4(_ch__ select 0,_ch__ select 1,this,false));
			} foreach (keys getSelf(loadedChunks));
			setSelf(loadedChunks,createHashMap);
			
			[this] call atmos_unsubscribeClientListeningSrv;
			setSelf(loadedAreas,createHashMap);
		};
	};
	
	func(onFinalize)
	{
		objParams();

		[this] call db_saveClient;
		
		callSelf(unsubAllChunks); //вызывается раньше удаления клиента так как в unsubChunkListen используется cm_findClientById
		
		cm_allClients deleteat (cm_allClients find this);

		cm_disconnectedClients set [getSelf(discordId),this];

		traceformat("Disconnected client saved - %1",equals(cm_disconnectedClients get getSelf(discordId),this));
		
		if getSelf(isMBOpened) then {
			callSelf(onClosedMessageBox);
		};

		//delete local person
		if (!([callSelf(getOwner)] call personServ_unregisterMob)) then {
			["Cant find person %1 for deleting from %2",callSelf(getOwner),(call personServ_getMobIdList) joinString ";"] call logError;
		};

		//удаляем из претендентов
		if getSelf(isReady) then {
			
			setSelf(isReady,false);
			
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

		};
		if getSelf(isInEmbark) then {
			//снять с эмбарка. Включает сброс переменной
			[this,false] call gm_removeClientFromEmbark;
		};

		//удаляем голос клиента из голосования
		[this] call gm_voteOnClientDisconnected;

		//отправляем на войс сигнал что клиент отключился
		[getSelf(name)] call vs_server_onClientDisconnected;


		[format["Disconnected - %1 (netid: %2; disid: %3)",getSelf(name),getSelf(id),getSelf(discordId)]] call discLog;
	};

	//Принудительно отключение клиента

	"
		name:Принудительно отключить
		desc:Незамедлительно отключает клиента от сервера с указанной причиной.
		type:method
		lockoverride:1
		in:string:Причина:Отображаемая клиенту причина отключения от сервера.
		return:bool:Было ли выполнено отключение клиента.
	" node_met
	func(forceDisconnect)
	{
		objParams_1(_reason);
		if !callSelf(isConnected) exitWith {false};
		[getSelf(id) arg _reason] call cm_serverKickById;
	};

	"
		name:Идентификатор клиента
		desc:Сетевой идентификатор клиента. Это уникальное число, идентифицирующее клиента на сервере. На сервере никогда не может быть клиентов с одинаковыми сетевыми идентификаторами. 
		prop:get
		classprop:0
		return:int:Идентификатор клиента
	" node_var
	var_num(id); //айди клиента
	"
		name:SteamID клиента
		desc:Уникальный 16-ти значный SteamID клиента.
		prop:get
		classprop:0
		return:string:Строчное представление SteamID
	" node_var
	var_str(uid); //стим-айди клиента

	var_str(discordId); //дискорд айди
	
	"
		name:Никнейм клиента
		desc:Уникальное имя клиента, выводимое в чате, лобби и служащее идентификатором игрока.
		prop:get
		classprop:0
		return:string:Имя клиента (никнейм) 
	" node_var
	var_str(name); //имя клиента
	"
		name:Доступ клиента
		desc:Уровень доступа клиента
		prop:get
		classprop:0
		return:enum.AccessLevel:Текущий уровень доступа
	" node_var
	var_num(access); //уровень доступа
	"
		name:Очки клиента
		desc:Количество очков клиента. Может быть как отрицательным, так и положительным
		prop:get
		classprop:0
		return:int:Количество очков
	" node_var
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

	"
		name:Клиент в лобби
		desc:Возвращает @[bool ИСТИНУ], если проверяемый клиент находится в лобби в данный момент
		type:get
		lockoverride:1
		return:bool:Находится ли клиент в лобби
	" node_met
	getter_func(isInLobby,getSelf(state) == "lobby" && callSelf(isConnected));
	"
		name:Клиент в игре
		desc:Возвращает @[bool ИСТИНУ], если проверяемый клиент находится в игре в данный момент
		type:get
		lockoverride:1
		return:bool:Находится ли клиент в игре
	" node_met
	getter_func(isInGame,getSelf(state) == "ingame" && callSelf(isConnected));

	func(onConnected)
	{
		objParams();

		callSelf(_updateObjectName);

		#ifdef RELEASE
		[getSelf(discordId)] call db_updateValuesOnConnect;
		#endif

		//cleanup chunks
		setSelf(loadedChunks,createHashMap);
		setSelf(loadedAreas,createHashMap);

		cm_allClients pushBack this;
		setSelf(isReady,false);
		[format["Connected and ready - %1 (netid: %2; disid: %3)",getSelf(name),getSelf(id),getSelf(discordId)]] call discLog;

		netSendVar("cd_clientName",getSelf(name),getSelf(id)); //быстренько отсылаем клиенту его имя
		netSendVar("vs_localName",getSelf(name),getSelf(id)); //и дублим в войс систему временно

		//Отправляем клиенту его настройки
		callSelf(sendClientSettings);

		//Подключившемуся отправляем его сисмесы
		callSelf(initSystemMessagesOnConnect);

		#ifdef PRIVATELAUNCH
		server_privateLaunch_list_awaitCheck pushBackUnique this;
		#endif

		if array_exists(getSelf(lockedSettings),"run") then {
			callSelfParams(fastSendInfo,"cd_sp_lockedSetting" arg true);
		};

		//creating local personmob
		[callSelf(getOwner)] call personServ_registerMob;

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
	
			if (call gm_isRoundLobby) then {
				[this, false] call gm_validateAvailableRoles;
			};

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

	"
		name:Готовность к игре
		desc:Возвращает @[bool ИСТИНУ], если клиент нажал кнопку готовности в лобби
		prop:get
		classprop:0
		return:bool:Готов ли клиент к игре
	" node_var
	var(isReady,false);//готов ли клиент к игре
	var(isInEmbark,false); //находится ли в эмбарке
		var(embarkRole,nullPtr);//ссылка на эмбарковую роль

	var_obj(actor); //целевой объект клиента
	"
		name:Получить моба
		desc:Получает объект моба клиента, за которого он играет
		type:get
		lockoverride:1
		return:BasicMob:Моб, за которого играет клиент
	" node_met
	func(getActorMob) //Получает моба актора. Если нет актора то nullPtr
	{
		objParams();
		private _act = getSelf(actor);
		if isNullReference(_act) exitwith {nullPtr};
		_act getvariable vec2("link",nullPtr)
	};
	"
		name:Последний моб
		desc:Последний моб, за которого заходил клиент
		prop:get
		classprop:0
		return:BasicMob:Последний моб
	" node_var
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
		hashPair(name,([GENDER_MALE] call naming_getRandomName) joinString " ") arg
		hashPair(age,randInt(18,80)) arg
		hashPair(gender,GENDER_MALE) arg
		hashPair(face,"rand") arg
		hashPair(role1,"none") arg
		hashPair(role2,"none") arg
		hashPair(role3,"none") arg
		hashPair(mainhand,1) arg
		hashPair(vice,"rand") arg
		hashPair(family,FAMILY_DEFAULT) arg
		hashPair(blood,BLOOD_TYPE_RANDOM) arg
		hashPair(faith,"fugu") arg
		hashPair(antag,ANTAG_NONE)
		]);
		//antag - 0 none; 1 hide, 2 unical, 3 all

	var(charSettingsTemplates,[null arg null arg null arg null arg null]); //заготовленные шаблоны персонажей

	var(lockedSettings,[]);//locked char settings (this settings current client can't change)

	//TODO enum: family, blood type, antag, gender, mainhand
	"
		name:Имя персонажа клиента
		desc:Получает введенное имя персонажа, устанавливаемое через лобби.
		type:get
		lockoverride:1
		return:string
	" node_met
	getter_func(_getCharSettingNameWrapper,getSelf(charSettings) get "name");
	"
		name:Возраст персонажа клиента
		desc:Получает возраст персонажа, устанавливаемый через лобби.
		type:get
		lockoverride:1
		return:int
	" node_met
	getter_func(_getCharSettingAgeWrapper,getSelf(charSettings) get "age");
	"
		name:Пол персонажа клиента
		desc:Получает пол персонажа, устанавливаемый через лобби.
		type:get
		lockoverride:1
		return:enum.Gender
	" node_met
	getter_func(_getCharSettingGenderWrapper,getSelf(charSettings) get "gender");
	"
		name:Лицо персонажа клиента
		desc:Получает лицо персонажа, устанавливаемое через лобби.
		type:get
		lockoverride:1
		return:string
	" node_met
	getter_func(_getCharSettingFaceWrapper,getSelf(charSettings) get "face");
	"
		name:Роль 1 персонажа клиента
		desc:Получает заданную роль персонажа, устанавливаемую через лобби.
		type:get
		lockoverride:1
		return:classname
	" node_met
	getter_func(_getCharSettingRole1Wrapper,getSelf(charSettings) get "role1");
	


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

			if callSelf(isInLobby) then {
				private _owner = callSelf(getOwner);
				rpcSendToClient(_owner,"onCharSettingCallback",["name" arg _newName])
			};
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

				if callSelf(isInLobby) then {
					private _owner = callSelf(getOwner);
					rpcSendToClient(_owner,"onCharSettingCallback",[_settingName arg _value])
				};
			};
		};

		//Высылаем описание порока
		if (_settingName == "vice") then {
			callSelfParams(localSay,[_value] call traits_getViceDescByClass arg "system");
		};

		_hashSettings set [_settingName,_value];

		private _owner = callSelf(getOwner);
		if callSelf(isInLobby) then {
			rpcSendToClient(_owner,"onCharSettingCallback",[_settingName arg _value]);
		};

		//При смене пола устанавливаем лицо на рандомное
		//И имя тоже
		if (_settingName == "gender") then {
			private _newFace = ["face","rand"];
			_hashSettings set _newFace;
			if callSelf(isInLobby) then {
				rpcSendToClient(_owner,"onCharSettingCallback",_newFace);
			};

			private _gender = _hashSettings get "gender";
			private _newName = ([_gender] call naming_getRandomName) joinString " ";
			_hashSettings set ["name",_newName];

			if callSelf(isInLobby) then {
				rpcSendToClient(_owner,"onCharSettingCallback",["name" arg _newName]);
			};
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
					private _oldClientIndex = _oldContenders findif {equals(_x,this)};
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
		private _status = getSelf(access);
		if (_status >= (["ACCESS_FORSAKEN"] call cm_accessTypeToNum)) then {
			//Игрок >= форсекена то приоритет на роли/антаг
			10
		} else {
			//Если меньше форсекена то приоритет 0
			0
		};
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
			private _lastRes = [getSelf(discordId)] call db_getAllBannedRoles;
			setSelf(_getBannedRoles_lastGet,tickTime + (60*10));
			setSelf(_bannedRolesCache,_lastRes);
			_lastRes;
		} else {
			getSelf(_bannedRolesCache);
		};
	};

	//Отсылает личное сообщение клиенту
	"
		name:Локальное сообщение в чат
		desc:Отправляет клиенту в чат переданный текст. Другие игроки не увидят это сообщение. Данный узел предназначен для оповещения клиентов, находящихся в лобби.
		type:method
		lockoverride:1
		in:string:Сообщение:Текст сообщения.
		in:enum.ChatMessageChannel:Тип:Тип сообщения.
	" node_met
	func(_localSayWrapper)
	{
		assert_str(count _this > 2,"Param count error");
		private _ch = _this select 2;
		assert_str(!isNullVar(_ch),"Channel param cannot be null");
		assert_str(equalTypes(_ch,0),"Channel param type error. Must be integer - not " + typename _ch);
		assert_str(inRange(_ch,0,count go_internal_chatMesMap - 1),"Channel index out of range: " + str _ch);
		_this set [2,go_internal_chatMesMap select _ch];

		private this = _this select 0;
		_this call getSelfFunc(localSay)
	};

	func(localSay)
	{
		objParams_2(_mes,_categ);

		rpcSendToClient(getSelf(id),"chatPrint",[_mes arg _categ]);
	};

	//Отсылает в лобби всем сообщение с поддержкой цвета текста и ника
	"
		name:Сообщение в лобби
		desc:Отправляет сообщение в лобби от лица клиента. Если клиент в игре, то он не увидит собственное сообщение.
		type:method
		lockoverride:1
		in:string:Сообщение:Текст сообщения.
	" node_met
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
			forceUnicode 0;
			_t = LOADFILE "src\CHANGELOGS.txt";
			//_t = _t splitString (toString[10,13]) joinString sbr;

			//replace task number and feature author
			_t = [_t,"\(\#\d+\)\s*\*\*\w+\*\*",""] call regex_replace;

			//replace 1lvl headers
			_t = [_t,"\#\s*([\w ]{3,})","<t size='1.5'>$1</t>"+sbr] call regex_replace;
			
			//replace 2lvl headers
			_t = [_t,"\#\#\s*\*\*([\w ]{3,})\**","<t size='1.3'>$1</t>"] call regex_replace;

			serverclient_internal_string_changelogs = _t;
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


region(rpc and networking messaging)
	//отправка сообщения с обработкой на клиенте
	func(sendInfo)
	{
		objParams_2(_mes,_data);
		private _own = getSelf(id);
		rpcSendToClient(_own,_mes,_data);
	};

	func(fastSendInfo)
	{
		objParams_2(_varname,_data);
		private _own = getSelf(id);
		netSendVar(_varname,_data,_own);
	};

region(Clientside music manager and local sounds)

	"
		name:Проиграть звук клиенту
		desc:Воспроизводит звук у конечного клиента в формате ogg по указанному пути
		type:method
		lockoverride:1
		in:string:Путь:Путь до файла звука, например: ""fire\\torch_on""
		in:float:Тон:Тон звука. 2 - максимальный возможный, 0.5 - минимальный возможный
			opt:def=1
		in:float:Громкость:Громкость звука. Не рекомендуется менять это значение
			opt:def=1
		in:bool:В канал эффектов:При влкючении данного параметра проигрываемый звук воспроизводится на канале эффектов.
			opt:def=true
	" node_met
	func(playSound)
	{
		params['this',"_path",["_pitch",1],["_vol",1],"_isEffect"];
		
		private _ctx = [_path,_vol,_pitch];
		
		if !isNullVar(_isEffect) then {_ctx pushback _isEffect};

		callSelfParams(sendInfo,"sui_p" arg _ctx);
	};
	//todo use enum.MusicChannel
	//need new struct music params
	// "
	// 	name:Запустить музыку клиенту
	// 	desc:Запускает музыкальную композицию клиенту для воспроизведения.
	// " node_met
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

	var(discordIdAcc,""); //unique discord id
	var(arrivedInCity,0); //сколько раз был зарегистрирован в городе

	var(hasFirstLoadedRoles,false);

	//зареган ли в дискорде чел
	getter_func(isDiscordAccountRegistered,getSelf(discordIdAcc)!="");

	//производит асинхронную синхронизацию дискордовых ролей с этим клиентом
	func(requestDiscordRoles)
	{
		objParams();
		if (!callSelf(isDiscordAccountRegistered)) exitWith {};

		[getSelf(name),getSelf(discordIdAcc)] call dsm_accounts_requestUpdateRoles;
	};
	//bot callback set roles
	func(updateDiscordRoles)
	{
		objParams_1(_roles);
		setSelf(hasFirstLoadedRoles,true);
		setSelf(_discordRolesCache,_roles);
		//? возможно здесь стоит обновить _getDiscordRoles_lastGet
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

		[getSelf(discordIdAcc),_role] call dsm_accounts_addToRole;
		callSelf(flushDiscordRolesLastGet);
		callSelf(getDiscordRoles);

		true
	};

	func(removeDiscordRole)
	{
		objParams_1(_role);

		if (!callSelf(isDiscordAccountRegistered)) exitWith {false};

		[getSelf(discordIdAcc),_role] call dsm_accounts_removeFromRole;
		callSelf(flushDiscordRolesLastGet);
		callSelf(getDiscordRoles);

		true
	};

	//prestart vote vars
	var(prestartVotedTo,""); //за какой режим проголосовал клиент

endclass

serverclient_internal_string_changelogs = "";


//system message internal funcs
serverclient_internal_map_sysmes = createHashMapFromArray [

["NULL",{

#include <sysmes.h>
#include "client_SysMessages.sqf"

}]];