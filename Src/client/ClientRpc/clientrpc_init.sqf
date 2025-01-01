// ======================================================
// Copyright (c) 2017-2025 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\host\engine.hpp>

#define log_client_rpc

#ifndef ENABLE_RPCLOG_CONSOLE_CLIENT
	#undef log_client_rpc
#endif

#ifdef RELEASE
	#undef log_client_rpc
#endif

#ifdef log_client_rpc
	#define rpc_log(event,args) 'debug_console' callExtension format['[NET::LOG::CLIENT]:    <%1> send %3 bytes to SERVER with %2',event,args,args call oop_getTypeSizeFull]
	#define rpc_simple(data) 'debug_console' callExtension format['[NET::LOG]:    %1',data]
#else
	#define rpc_log(event,args)
#endif

// Добавляет обработчик событий на стороне клиента
client_addEvent = {
	params ["_eventName","_eventCode"];
	["client_" + _eventName,_eventCode] call cba_fnc_addEventHandler
};

// Удаляет обработчик событий на стороне клиента
client_removeEvent = {
	params ["_eventName","_eventId"];
	["client_" + _eventName,_eventId] call CBA_fnc_removeeventhandler
};

// Удаляет глобальный обработчик событий на стороне клиента
rpc_removeEventGlobal = {
	params ["_eventName","_eventId"];
	[_eventName,_eventId] call CBA_fnc_removeeventhandler
};

// Вызывает клиентский обработчик событий
client_callEvent = {
	params ["_eventName","_args"];
	["client_" + _eventName,_args] call CBA_fnc_localEvent
};

// Отправляет событие на сервер
client_sendToServer = {
	params ["_eventName","_eventargs"];
	
	#ifdef ENABLE_LAG_NETWORK
		private _c = {
			params ["_eventName","_eventargs"];
	#endif
	
	rpc_log(_eventName,_eventargs);
	
	["server_" + _eventName, _eventargs] call CBA_fnc_serverEvent;

	#ifdef ENABLE_LAG_NETWORK
		}; invokeAfterDelayParams(_c,__LAG_NETWORK_GET_LAG__,_this)
	#endif
};
