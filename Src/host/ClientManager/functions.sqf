// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include "..\oop.hpp"
#include "..\engine.hpp"
#include "..\struct.hpp"
#include <..\Networking\Network.hpp>

if (IS_INIT_MODULE) then {


	//закрыт ли сервер
	cm_isServerLocked = false;

	//список клиентов на ожидание кика. PreAwaitClientData является значением, ключ uint (clientOwner)
	cm_preAwaitClientData = hashMapNew;
	cm_map_ownerToDisIdAssoc = hashMapNew;

	cm_allClients = []; //список зарегистрированных объектов клиентов
	cm_disconnectedClients = hashMapNew; //список дисконнектнутых клиентов. Отсюда берутся все jip-ам
	cm_allInGameMobs = []; //список всех мобов в игре. Этот массив требуется в основном потоке обработчика карты
		netSetGlobal(smd_allInGameMobs,cm_allInGameMobs);
	cm_allInGamePlayerMobs = []; //список всех игроков в игре
		netSetGlobal(smd_allInGamePlayerMobs,cm_allInGamePlayerMobs);
	cm_allAwaitMobs = allUnits; //список нераспределённых мобов

	cm_maxClients = 0; //сколько максимально клиентов подключалось

}; //IS_INIT_MODULE

//Быренько раскидываем указатели мобов
_tx = table_hex;
{
	_x setvariable ["voiceptr","0x" + pick _tx + pick _tx + pick _tx + pick _tx + pick _tx + pick _tx,true]; //generator pointers for voice system
} foreach cm_allAwaitMobs;

cm_owners = ["76561198094364528"]; //me

//админы           пони					румын
cm_admins = ["76561198057042311","76561197994426107"];

//игроки              квадрат              krakatuk          борзый             ходовой
cm_forsakens = ["76561198096453655","76561198072294284","76561198156220735","76561198156220735",
	/*амир*/
	"76561198247184258",
	/*лисовик*/
	"76561198090227690",
	"76561198102145602",
	/*Медь*/
	"76561198133594763",
	/*Шаста*/
	"76561198148249349",
	/*Хуязбин*/
	"76561198162236852",
	/*вирус */
	"76561198234305200",
	/*sranych*/
	"76561198078325188",
	/*markus*/
	"76561198088714219",
	/*irmos */
	"76561198417147639",
	/*baunti*/
	"76561198814314229",
	/*dev1l*/
	"76561198315583132"
];

#define __compare_equality_hard isequalto
#define __compare_equality_soft ==
#define protoFind(by_func,var,comparer) cm_findClientBy##by_func = { \
	params ["_id",["_checkInDisconnected",false]]; \
	private _rez = cm_allClients findif {getVar(_x,var) comparer _id}; \
	if (_rez == -1) exitWith { \
		if (!_checkInDisconnected) exitWith {nullPtr}; \
		private _listDisc = values cm_disconnectedClients; \
		_rez = _listDisc findif {getVar(_x,var) comparer _id}; \
		if (_rez == -1) exitWith {nullPtr}; \
		_listDisc select _rez; \
	}; \
	cm_allClients select _rez}

//найти клиента по айди. Допускается перегрузка с двумя параметрами, где второй - искать ли клиента в отключенных
protoFind(Id,id,__compare_equality_hard); //cm_findClientById
protoFind(Name,name,__compare_equality_soft); //cm_findClientByName
protoFind(DisId,discordId,__compare_equality_hard); //cm_findClientByDisId
protoFind(Access,access,__compare_equality_hard); //cm_findClientByAccess

cm_findClientByAccessLevel = {
	private _id = _this;
	private _rez = cm_allClients findif {getVar(_x,access) >= _id};
	if (_rez == -1) exitWith {nullPtr};
	cm_allClients select _rez
};

//Получить клиентов по уровню доступа
cm_getAllClientsByAccessLevel = {
	params ["_lvl",["_thisAndHight",false]]; //_thisAndHight указывает что будут получаться эта роль и все кто выше неё
	if equalTypes(_lvl,"") then {_lvl = [_lvl] call cm_accessTypeToNum};

	private _cli = [];
	private _algGet = ifcheck(_thisAndHight,{getVar(_this,access) >= _lvl},{getVar(_this,access) == _lvl});
	{
		if (_x call _algGet) then { _cli pushBack _x };
	} foreach cm_allClients;
	_cli
};

//Получает начальный уровень доступа по айди
//! DEPRECATED - не используется
cm_getAccessByUid = {
	if (_this in cm_owners) exitWith {ACCESS_OWNERS};
	if (_this in cm_admins) exitWith {ACCESS_ADMIN};
	if (_this in cm_forsakens) exitWith {ACCESS_FORSAKEN};
	ACCESS_PLAYER
};

#define __mapped(t1,t2) cm_accessMap set [t1,t2]; cm_accessMap_inverted set [t2,t1];
cm_accessMap = createHashMap;
cm_accessMap_inverted = createHashMap;

// маппинг цвета ника и сообщений по доступу
#define __colorMap(access,nick,mes) cm_map_nickColor set [access,nick]; cm_map_messagesColor set [access,mes];
cm_map_nickColor = createHashMap;
cm_map_messagesColor = createHashMap;

/****************************************************************************
								MAP ACCESS
****************************************************************************/

__mapped("ACCESS_PLAYER",ACCESS_PLAYER);
__mapped("ACCESS_FORSAKEN",ACCESS_FORSAKEN);
__mapped("ACCESS_ADMIN",ACCESS_ADMIN);
__mapped("ACCESS_OWNERS",ACCESS_OWNERS);

//Получить уровень по строке
cm_accessTypeToNum = {
	params ["_accessString"];
	cm_accessMap getOrDefault [toUpper _accessString,ACCESS_PLAYER];
};
//Получить уровень по числу
cm_accessNumToType = {
	params ["_accessNum"];
	cm_accessMap_inverted getOrDefault [_accessNum,"ACCESS_PLAYER"];
};

/****************************************************************************
								MAP COLORS
****************************************************************************/

__colorMap(ACCESS_PLAYER,"","")
__colorMap(ACCESS_FORSAKEN,"136b22","")
__colorMap(ACCESS_ADMIN,"751365","")
__colorMap(ACCESS_OWNERS,"700808","")


cm_getNickColorByAccess = { params ["_access"]; cm_map_nickColor getOrDefault [_access,""]};
cm_getMessageColorByAccess = { params ["_access"]; cm_map_messagesColor getOrDefault [_access,""]};


/****************************************************************************
								Other commands
****************************************************************************/

//конвертация айди в имя клиента
cm_idToName = {
	params ["_id"];
	private _cli = _id call cm_findClientById;
	if isNullReference(_cli) exitWith {format["<Unknown client (%1)>",_id]};
	getVar(_cli,name);
};

cm_idToDisId = {
	params ["_id"];
	private _cli = _id call cm_findClientById;
	if isNullReference(_cli) exitWith {format["<Unknown client (%1)>",_id]};
	getVar(_cli,discordId);
};

//зарегистрирован в памяти или нет
cm_isClientExist = {
	not_equals(_this call cm_findClientById,nullPtr);
};


cm_serverCommand = {
	private _command = _this;
	private _pass = SERVER_PASSWORD;

	if (!isMultiplayer) exitWith {
		if ("#kick" in _command) then {
			error("EMUMODE: CONNECTION LOST")
		};
	};

	private _result = _pass serverCommand _command;
	if (!_result) then {
		warningformat("Server command unknown <%1> or wrong password",_command);
	};

	_result
};

cm_serverLock = {
	if (cm_isServerLocked) exitWith {
		warning("cm::serverLock() - Server already locked");
	};
	cm_isServerLocked = true;
	["Server locked"] call logInfo;
	"#lock" call cm_serverCommand;
};


cm_serverUnlock = {
	if (!cm_isServerLocked) exitWith {
		warning("cm::serverUnlock() - Server already unlocked");
	};
	cm_isServerLocked = false;
	["Server unlocked"] call logInfo;
	"#unlock" call cm_serverCommand;
};

cm_serverKickById = {
	if equalTypes(_this,0) then {
		
		//закрытие дисплея
		//rpcSendToClient(_this,"syscc",null);

		("#kick " + str _this) call cm_serverCommand;
	} else {
		params ["_owner",["_reasonText",""]];
		
		//закрытие дисплея
		//rpcSendToClient(_owner,"syscc",null);

		("#kick " + format["%1 %2",_owner,_reasonText]) call cm_serverCommand;
	};

	/*if (_this > 2) then {
		rpcSendToClient(_this,"clientDisconnect",0);
	} else {
		errorformat("cm::serverKickById() - Cant kick client %1. Is not client.",_this);
	};*/
};

	// Системная функция при обнаружении подозрительной активности
	pre_oncheat = {
		params ["_owner","_ctxCheat"];
		_ctxCheat params [["_mes","nullmes"],["_data",null]];
		call {

			//eachframe modified (sync error) - permaban
			if (_mes == "EFHmod") exitWith {
				//[format["[RECHEAT]:	<%1> (%2) : deviation of the frame number by %3 frames",_mes,_uid,_data]] call discLog;
				
				//private _errorNick = "ERROR_UID_NOT_IN_DATABASE:"+_uid;
				//private _nick = [_uid,_errorNick] call db_disIdToNick;
				private _m = format["[RECHEAT]:	<%1> (owner %2) : deviation of the frame number by %3 frames",_mes,_owner,_data];
				
				// if (_nick != _errorNick) then {
				// 	modvar(_m) + "; Attempt execute ban by uid (platform side)";
				// };

				["ADMIN_RECHEAT: "+ _m] call adminLog;
				["@everyone ADMIN_RECHEAT: "+_m] call disc_adminlog_provider;

				[_owner,"Подозрительная активность. Код: 1"] call cm_serverKickById;
				
				/*
				if (_nick != _errorNick) then {
					private _reason = "Подозрительная активность. Код: 1. Зайдите в discord.relicta.ru";
					[null,_nick,_reason] call db_banByName;
				} else {
					//if client not registered then global ban
					//? Where placed .txt banfile on serverside?
					private _r = (format["#exec ban %1",_uid]) call cm_serverCommand;
					["@everyone ADMIN_RECHEAT: Client " + str _uid + "not registered. Executed platform ban; Result: " + str _r] call disc_adminlog_provider;
				};
				*/	
			};

		};
	};

	pre_notifClientAssert = {
		params ["_message","_owner"];
		private _id = (str randInt(1,1000)) + "-" + (toUpper generatePtr);
		_message = format["%1 (ID: %2, Owner: %3)",_message,_id,_owner];
		[__ASSERT_WEBHOOK_PREFIX__ + _message] call discError;
		[_message] call logCritical;
		[_owner,format["Системная ошибка. Сообщите администрации в дискорде айди: %1",_id]] call cm_serverKickById;
	};

	pre_notifClientStatistic = {
		params ["_message","_owner","_nick"];
		_message = format["%1 (Owner: %2, Nick: %3)",_message,_owner,_nick];
		[_message] call discLog;
		[_message] call logInfo;
	};

_kickself_ = {
	params ["_owner",["_reason",""]];
	if equals(_reason,"") then {
		_owner call cm_serverKickById;
	} else {
		[_owner,_reason] call cm_serverKickById;
	};
}; rpcAdd("_kickself_",_kickself_);

//Получает всех клиентов в лобби
cm_getAllClientsInLobby = {
	private _list = [];

	{
		if (callFunc(_x,isInLobby)) then {
			_list pushBack _x;
		};
	} foreach cm_allClients;

	_list
};

//Получает всех клиентов в игре
cm_getAllClientsInGame = {
	private _list = [];

	{
		if (callFunc(_x,isInGame)) then {
			_list pushBack _x;
		};
	} foreach cm_allClients;

	_list
};

//регистрирует моба как ingameMob
cm_registerMobInGame = {
	params ["_mobObj","_client","_vMob"];
	
	if !isNullVar(_client) then {
		setVar(_client,actor,_mobObj);
	};
	
	cm_allInGameMobs pushBackUnique _mobObj;
	netSetGlobal(smd_allInGameMobs,cm_allInGameMobs); //региструруем сетевую переменную
};

//снимаем регистрацию моба с игры
cm_unregisterMobInGame = {
	params ["_mobObj",["_removeObj",true]];
	
	cm_allInGameMobs deleteAt (cm_allInGameMobs find _mobObj);
	netSetGlobal(smd_allInGameMobs,cm_allInGameMobs); //региструруем сетевую переменную
	if (_removeObj) then {
		deleteVehicle _mobObj;
	};
};

//Проверяет наличие ранее подключенного клиента
cm_checkClientInJIPMemory = {
	params ["_disId","_owner"];

	private _client = cm_disconnectedClients getOrDefault [_disId,nullPtr];
	if equals(_client,nullPtr) exitWith {
		false
	};

	setVar(_client,id,_owner);
	callFunc(_client,onConnected);

	true
};

if IS_INIT_MODULE then {

	_onOOCMessage = {
		params ["_owner","_text"];

		_client = _owner call cm_findClientById;
		if equals(_client,nullPtr) exitWith {
			warningformat("Cant find client %1 for sending OOC message: %2",_owner arg _text);
		};

		_text = format["%1: %2",getVar(_client,name),_text];

		[_text] call cm_sendOOSMessage;

	};	rpcAdd("onSendOOCMessage",_onOOCMessage);

	//Отправляет всем клиентам сообщение в чат
	cm_sendOOSMessage = {
		params ["_text",["_type",null],["_groups",""]];
		
		if (!isNullVar(_type) && {equalTypes(_type,0)}) then {
			_type = go_internal_chatMesMap select _type
		};

		[format["[CHAT:OOS]:	%1",_text]] call discLog;

		{
			rpcSendToClient(callFunc(_x,getOwner),"chatPrint",[_text arg _type]);
		} foreach cm_allClients;
	};

	//Отправляет сообщение всем клиентам в лобби
	cm_sendLobbyMessage = {
		params ["_text",["_type",null],["_groups",""]];
		
		if (!isNullVar(_type) && {equalTypes(_type,0)}) then {
			_type = go_internal_chatMesMap select _type
		};

		[format["[CHAT:LOBBY]:	%1",_text]] call discLog;

		{
			if callFunc(_x,isInLobby) then {
				rpcSendToClient(callFunc(_x,getOwner),"chatPrint",[_text arg _type]);
			};
		} foreach (call cm_getAllClientsInLobby);
	};

	_onLobbyMessage = {
		params ["_owner","_text"];

		_client = _owner call cm_findClientById;
		if equals(_client,nullPtr) exitWith {
			warningformat("Cant find client %1 for sending OOC message: %2",_owner arg _text);
		};

		if (rep_system_enable && equals(getVar(_client,testResult),"")) exitWith {
			callFuncParams(_client,localSay,"Доступ к чату только у тех" pcomma " кто прошёл тест" arg "system");
		};

		_textDisc = format["%1: %2",getVar(_client,name),_text];
		[format["[CHAT:LOBBY]:	%1",_textDisc]] call discLog;

		callFuncParams(_client,sayLobby,_text);
	};
	rpcAdd("onSendLobbyMessage",_onLobbyMessage);


	_onHandleMBInput = {
		params ["_owner","_ctx"];
		_client = _owner call cm_findClientById;
		if equals(_client,nullPtr) exitWith {
			warningformat("Cant find client %1 for handling input: %2",_owner arg _ctx);
		};
		callFuncParams(_client,handleMessageBoxInput,_ctx);
	}; rpcAdd("onHandleMBInput",_onHandleMBInput);

	_playLobbySystemAction = {
		params ["_owner",["_ctx",""]];
		_client = _owner call cm_findClientById;
		if equals(_client,nullPtr) exitWith {
			warningformat("Cant find client %1 for playing system action: %2",_owner arg _ctx);
		};
		if not_equalTypes(_ctx,"") exitWith {
			warningformat("Wrong datatype on playing lobby action %1 %2",_owner arg _ctx);
		};
		callFuncParams(_client,playSystemAction,_ctx);
	}; rpcAdd("playLobbySystemAction",_playLobbySystemAction);

	_onClosedNDLobby = {
		params ["_owner"];
		_client = _owner call cm_findClientById;
		if equals(_client,nullPtr) exitWith {
			warningformat("Cant find client %1 for playing system action: %2",_owner arg _ctx);
		};
		callFunc(_client,onClosedMessageBox);
	}; rpcAdd("onClosedNDLobby",_onClosedNDLobby);

	#ifdef EDITOR
	_testmb = {
		params ["_owner","_ctx"];
		_client = _owner call cm_findClientById;
		_event = {
			callSelf(CloseMessageBox);
			callSelfParams(addSystemAction,"system" arg "sysact_test" arg "Кнопочка прикольчик");
		};
		callFuncParams(_client,ShowMessageBox,"MessageBox" arg vec2("приветик!","Жмяк") arg _event);
	}; rpcAdd("testmessagebox",_testmb);
	#endif

}; //IS_INIT_MODULE