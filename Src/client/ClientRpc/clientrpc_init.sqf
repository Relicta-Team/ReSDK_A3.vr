// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\host\engine.hpp>

namespace(ClientRpc,client_)

macro_def(client_log_rpc)
#define log_client_rpc

#ifndef ENABLE_RPCLOG_CONSOLE_CLIENT
	#undef log_client_rpc
#endif

#ifdef RELEASE
	#undef log_client_rpc
#endif

#ifdef log_client_rpc
	inline_macro
	#define rpc_log(event,args) 'debug_console' callExtension format['[NET::LOG::CLIENT]:    <%1> send %3 bytes to SERVER with %2',event,args,args call oop_getTypeSizeFull]
	inline_macro
	#define rpc_simple(data) 'debug_console' callExtension format['[NET::LOG]:    %1',data]
#else
	#define rpc_log(event,args)
#endif

// Добавляет обработчик событий на стороне клиента
decl(void(string;any))
client_addEvent = {
	params ["_eventName","_eventCode"];
	["client_" + _eventName,_eventCode] call cba_fnc_addEventHandler
};

// Удаляет обработчик событий на стороне клиента
decl(void(string;int))
client_removeEvent = {
	params ["_eventName","_eventId"];
	["client_" + _eventName,_eventId] call CBA_fnc_removeeventhandler
};

// Удаляет глобальный обработчик событий на стороне клиента
decl(void(string;int))
rpc_removeEventGlobal = {
	params ["_eventName","_eventId"];
	[_eventName,_eventId] call CBA_fnc_removeeventhandler
};

// Вызывает клиентский обработчик событий
decl(void(string;any))
client_callEvent = {
	params ["_eventName","_args"];
	["client_" + _eventName,_args] call CBA_fnc_localEvent
};

// Отправляет событие на сервер
decl(void(string;any))
client_sendToServer = {
	params ["_eventName","_eventargs"];
	
	#ifdef ENABLE_LAG_NETWORK
		private _c = {
			params ["_eventName","_eventargs"];
	
			rpc_log(_eventName,_eventargs);
	
			["server_" + _eventName, _eventargs] call CBA_fnc_serverEvent;

		}; invokeAfterDelayParams(_c,__LAG_NETWORK_GET_LAG__,_this)
	#else
		rpc_log(_eventName,_eventargs);
	
		["server_" + _eventName, _eventargs] call CBA_fnc_serverEvent;
	#endif
};
