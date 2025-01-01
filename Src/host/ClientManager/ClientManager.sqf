// ======================================================
// Copyright (c) 2017-2025 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include "..\engine.hpp"
#include "..\oop.hpp"
#include <..\text.hpp>
#include <ClientManager.h>
#include <Client.hpp>
#include <..\ServerRpc\serverRpc.hpp>

#include "functions.sqf"

#include "CommandsExec.sqf"

#include "ClientController.sqf"


_event_onClientConnected = {
	#include "OnConnected.sqf"
};

_event_onClientDisconnected = {
	#include "OnDisconnected.sqf"
};

#ifdef EMULATE_CLIENT_INSP
	//Чтобы гейммод успел проинититься
	_c = {
		[str random 10000000, "76561198094364528", "noname",false,0] call _this
	};
	invokeAfterDelayParams(_c,0,_event_onClientConnected);
#else

	if (!isMultiplayer) then {
		log("Init emulated player...");
		//newParams(ServerClient,["Yodes(emulate)" arg player arg 0 arg "76561198094364528"]);
		_parameters = [0,false,"76561198094364528"];
		cm_preAwaitClientData pushBack _parameters;
	};


	client_handler_onConnect = addMissionEventHandler ["PlayerConnected",_event_onClientConnected];
	client_handler_onDisconnect = addMissionEventHandler ["PlayerDisconnected",_event_onClientDisconnected]; //HandleDisconnect - не удовлетворяет требованиям
#endif

//Событие когда клиент готов (загрузил все данные)
_onClientReady = {
	params ["_owner"];

	//Убираем из cm_preAwaitClientData нашего клиента (через _doNothing)
	_index = cm_preAwaitClientData findif {(_x select 0) == _owner};
	if (_index != -1) then {
		_el = cm_preAwaitClientData deleteat _index;
		_el set [1,true];//просто сброс

		private _uid = _el select 2;

		//Регистрируем новый клиент как объект если он ещё не заходил
		if (!([_uid,_owner] call cm_checkClientInJIPMemory)) then {
			if ([_uid] call db_isUIDRegistered) then {
				newParams(ServerClient,[_owner arg _uid]); //_el select 2 == UID
			} else {
				//rpc create conn
				rpcSendToClient(_owner,"authproc",null);
			};

		};

		//Тут в зависимости от режима можно уже скинуть моба...

	} else {
		errorformat("cm::onClientReady<RPC>() - index is -1. Client number %1 kicked! list %2",_owner arg cm_preAwaitClientData);
		[_owner,"Внутренняя ошибка инициализации."] call cm_serverKickById;
	};

}; rpcAdd("onClientReady",_onClientReady);

_authRequest = {
	params ["_nick","_owner"];
	if ([_nick] call db_isNickRegistered) exitWith {rpcSendToClient(_owner,"authResult",[1 arg _nick])};

	rpcSendToClient(_owner,"authResult",[0 arg _nick]);

}; rpcAdd("authRequest",_authRequest);

//Регистрация клиента
_onRegClient = {
	params ["_owner","_uid","_name"];

	[_uid,_name] call db_registerAccount;

	newParams(ServerClient,[_owner arg _uid]);

}; rpcAdd("onRegClient",_onRegClient);

//Событие при установке настройки персонажа
_onClientChangeCharSetting = {
	params ["_settingName","_value","_owner"];

	_client = _owner call cm_findClientById;
	if equals(_client,nullPtr) exitWith {
		errorformat("cm::onClientChangeCharSetting<RPC>() - Cant find client with id %1",_owner);
	};
	if (_settingName in getVar(_client,lockedSettings)) exitwith {
		callFuncParams(_client,localSay,"Вам запрещено изменять это!" arg "error");
	};
	callFuncParams(_client,setCharSetting,_settingName arg _value)

}; rpcAdd("onClientChangeCharSetting",_onClientChangeCharSetting);

_onClientPressedTrait = {
	params ["_cli"];
	_client = _owner call cm_findClientById;
	if equals(_client,nullPtr) exitWith {
		errorformat("cm::onClientPressedTrait<RPC>() - Cant find client with id %1",_owner);
	};

	callFunc(_client,handlePressTrait);

}; rpcAdd("onClientPressedTrait",_onClientPressedTrait);

_RequestOpenLobby = {
	params ["_owner",["_disposePrevMob",false]];
	private _client = _owner call cm_findClientById;
	if isNullReference(_client) exitWith {
		errorformat("cm::RequestOpenLobby() - Cant find client by id %1",_owner);
	};
	
	if (_disposePrevMob) then {
		callFunc(getVar(_client,__internal_destrMob),__destroyImpl);
	};
	
	rpcSendToClient(callFunc(_client,getOwner),"openLobby",callFunc(_client,collectClientSettings));
}; rpcAdd("RequestOpenLobby",_RequestOpenLobby);

_RequestNextMob = {
	params ["_owner"];
	private _client = _owner call cm_findClientById;
	if isNullReference(_client) exitWith {
		errorformat("cm::RequestNextMob() - Cant find client by id %1",_owner);
	};
	
	this = _client;
	_client call getVar(_client,delegate_onRequestNextMob);
}; rpcAdd("RequestNextMob",_RequestNextMob);

_onClientPrepareToPlay = {
	params ["_mode","_owner"];

	_client = _owner call cm_findClientById;
	
	if (rep_system_enable && equals(getVar(_client,testResult),"")) exitWith {
		callFuncParams(_client,localSay,"Доступ к игре только у тех" pcomma " кто прошёл тест" arg "system");
		rpcSendToClient(_owner,"onClientPrepareToPlayCallback",[false]);
	};
	if callFunc(_client,isNeedToVote) exitwith {
		callFuncParams(_client,localSay,"Доступ к игре только у тех" pcomma " кто проголосовал в прошлый раз (перезайдите чтобы открыть голосование)" arg "system");
		rpcSendToClient(_owner,"onClientPrepareToPlayCallback",[false]);
	};
	if (call dsm_accounts_canUse && {!callFunc(_client,isDiscordAccountRegistered)}) exitwith {
		callFuncParams(_client,localSay,"Вы должны привязать игровой аккаунт к дискорду RELICTA для входа в игру." arg "system");
		rpcSendToClient(_owner,"onClientPrepareToPlayCallback",[false]);
	};

	setVar(_client,isReady,_mode);

	private _callBack = if (_mode) then {
		//Если ошибка то крит возврат
		if (!callFunc(_client,addDefaultRoles)) then {
			callFunc(_client,removeDefaultRoles);
			!_mode
		} else {_mode};
	} else {
		callFunc(_client,removeDefaultRoles);
		_mode
	};

	setVar(_client,isReady,_callBack);

	rpcSendToClient(_owner,"onClientPrepareToPlayCallback",[_callBack]);

}; rpcAdd("onClientPrepareToPlay",_onClientPrepareToPlay);

_lsbReq = {
	params ["_act","_owner","_ctxParams"];

	private _client = _owner call cm_findClientById;
	if isNullReference(_client) exitWith {
		errorformat("rpc<lsbReq> - client null reference (owner %1)",_owner);
	};

	//local function for send updated info
	private __update = {
		params ["_owner","_client"];
		_templates = getVar(_client,charSettingsTemplates);
		_tData = [];
		{
			if isNullVar(_x) then {
				_tData pushBack "";
			} else {
				_tData pushBack format["(%2) %1, %3 %4",
					_x get "name",
					if((_x get "gender")==0)then{"м"}else{"ж"},
					_x get "age",[_x get "age",["год","года","лет"]] call toNumeralString
				];
			};
		} foreach _templates;

		rpcSendToClient(_owner,"lsbAct",["upd" arg _tData]);
	};

	0 call {
		//sync
		if (_act == 0) exitWith {
			[_owner,_client] call __update;
		};
		if (_ctxParams < 0 || _ctxParams >= 5) exitWith {
			errorformat("rpc<lsbReq> - index of ctxParams out of range %1",_ctxParams);
			[_owner,_client] call __update;
		};
		//save
		if (_act == 1) exitWith {
			private _chSet = getVar(_client,charSettingsTemplates);
			if ( !isNull(_chSet select _ctxParams) && {equals(str (_chSet select _ctxParams),str getVar(_client,charSettings))}) exitWith {
				callFuncParams(_client,localSay,format vec2("Персонаж в слоте %1 уже сохранён.",_ctxParams+1) arg "error");
			};
			_chSet set [_ctxParams,+getVar(_client,charSettings)];
			[_owner,_client] call __update;
		};
		//load
		if (_act == 2) exitWith {
			private _set = (getVar(_client,charSettingsTemplates) select _ctxParams);
			if isNullVar(_set) exitWith {
				errorformat("rpc<lsbReq> - null data at index %1",_ctxParams);
			};

			_set = +_set;

			if equals(str (_set),str getVar(_client,charSettings)) exitWith {
				callFuncParams(_client,localSay,format vec2("Персонаж в слоте %1 уже загружен.",_ctxParams+1) arg "error");
			};

			//Сбрасываем готовность
			if getVar(_client,isReady) then {
				rpcCall("onClientPrepareToPlay",vec2(false,_owner));
			};

			//И только после сброса устанавливаем новые роли

			setVar(_client,charSettings,_set);
			private _bn = callFunc(_client,getBannedRoles);
			for "_i" from 1 to 3 do {
				_value = (_set get "role"+str _i);
				
				if (_value != "none") then {
					private _robj = _value call gm_getRoleObject;
					if isNullReference(_robj) exitWith {trace("work2")
						errorformat("ServerClient::setCharSetting() - Unknown role %1",_value);
						_set set ["role"+str _i,"none"];
						callFuncParams(_client,localSay,format vec2("Роль %1 не существует. Сброс на случайную.",_i) arg "error");
						continue;
					};
					if (!callFuncParams(_robj,canTakeInLobby,_client arg false) || {!([_robj] call gm_isPreStartRoleExist)} || {callFuncParams(_robj,isAllowedRoleToClient,_client arg _bn)}) exitWith {
						_set set ["role"+str _i,"none"];
						callFuncParams(_client,localSay,format vec2("Роль %1 не доступна. Сброс на случайную.",_i) arg "error");
						continue;
					};
				};
				
			};

			{
				rpcSendToClient(_owner,"onCharSettingCallback",vec2(_x,_y));
			} foreach _set;
		};
		//delete
		if (_act == 3) exitWith {
			getVar(_client,charSettingsTemplates) set [_ctxParams,null];
			[_owner,_client] call __update;
		};
	};
}; rpcAdd("lsbReq",_lsbReq);


//settings manager...

// Удаляет сохраненные неактуальные настройки управление из объекта серверклиента
_remKeyBindList = {

	params ["_list","_owner"];

	_client = _owner call cm_findClientById;
	if isNullReference(_client) exitWith {warningformat("rpc::remKeyBindList() - null owner reference %1",_owner)};

	private _inputMap = getVar(_client,clientSettings) select 0;

	{
		if (_x in _inputMap) then {
			_inputMap deleteAt _x;
		};
	} foreach _list;

}; rpcAdd("remKeyBindList",_remKeyBindList);

//Обновляет бинды на сервере
_syncKeyBindList = {
	params ["_list","_owner"];

	_client = _owner call cm_findClientById;
	if isNullReference(_client) exitWith {warningformat("rpc::syncKeyBindList() - null owner reference %1",_owner)};

	private _inputMap = getVar(_client,clientSettings) select 0;
	{
		_x params ["_key","_val",["_flagRem",false]];

		if (_flagRem) then {
			_inputMap deleteAt _key;
		} else {
			_inputMap set [_key,_val];
		};

	} foreach _list;

}; rpcAdd("syncKeyBindList",_syncKeyBindList);

_syncGameSettings = {
	params ["_list","_owner"];

	_client = _owner call cm_findClientById;
	if isNullReference(_client) exitWith {warningformat("rpc::syncGameSettings() - null owner reference %1",_owner);
		traceformat("(%1) -> %2",cm_allClients apply {getVar(_x,id)} arg count cm_allClients)
	};

	private _inputMap = getVar(_client,clientSettings) select 2;
	{
		_x params ["_key","_val",["_flagRem",false]];

		if (_flagRem) then {
			_inputMap deleteAt _key;
		} else {
			_inputMap set [_key,_val];
		};

	} foreach _list;

}; rpcAdd("syncGameSettings",_syncGameSettings);

if (isMultiplayer) then {
	client_handler_onConnectUser = addMissionEventHandler ["OnUserConnected", {
		params ["_networkId", "_clientStateNumber", "_clientState"];
		
		(getUserInfo _networkId) params ["","_owner","_uid"];
		
		if (server_isHandleEndSession) exitWith {
			nextFrameParams(cm_serverKickById,vec2(_owner,"Вход заблокирован. Будет рестарт или перезапуск."));
		};

		if (count cm_allClients >= server_maxclients) exitwith {
			nextFrameParams(cm_serverKickById,vec2(_owner,"Сервер переполнен."));
		};

		_ref = refcreate(0);
		if ([_uid,_ref] call db_checkBan) exitWith {
			refget(_ref) params ["_banTime","_banReason","_unbanAfter","_isPerm"];
			if (_isPerm) then {

				_mes = format[
					if (_banReason == "") then {
						"Доступ заблокирован."
					} else {
						"Доступ заблокирован. %1"
					},_banReason];
				nextFrameParams(cm_serverKickById,vec2(_owner,_mes));
			} else {
				_mes = format[
					if (_banReason == "") then {
						"Вы забанены до %2."
					} else {
						"Вы забанены до %2. %1"
					}
				,_banReason,_unbanAfter];
				nextFrameParams(cm_serverKickById,vec2(_owner,_mes));
			};
		};

		//whitelist protect
		#ifdef TEST_WHITELISTED
			private _listAllow = cm_owners + cm_admins + cm_forsakens;
			if (!array_exists(_listAllow,_uid)) exitWith {
				//logformat("[WHITELIST_PROTECT] Client not in whitelist. Owner %1; UID:%2; ID %3",_owner arg _uid arg _networkId);
				nextFrameParams(cm_serverKickById,[_owner arg "Вы не находитесь в вайтлисте."]);
			};
		#endif
	}];
};
