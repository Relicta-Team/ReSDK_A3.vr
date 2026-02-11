// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\engine.hpp>

#define log_server_rpc

#ifndef ENABLE_RPCLOG_CONSOLE_SERVER
	#undef log_server_rpc
#endif

#ifdef RELEASE
	#undef log_server_rpc
#endif

#define DISABLED_RPC_LOG ["onupdch","onupdob"]
#define canlog(eventname,code) if !((toLower eventname) in DISABLED_RPC_LOG) then {code}

#define debugprint_type "debug_console" callExtension

#ifdef log_server_rpc
	#define rpc_log(event,owner,args) canlog(event,debugprint_type format['[NET::LOG::SERVER]:    <%1> send %4 bytes to (%2) with %3' arg event arg owner arg args arg args call oop_getTypeSizeFull]; ["<%1> send %4 bytes to (%2) with %3" arg event arg owner arg args arg args call oop_getTypeSizeFull] call logInfo)
	#define rpc_simple(data) debugprint_type format['[NET::LOG]:    %1' arg data]; ["<RPC::Simple> %1" arg  data] call logInfo
#else
	#define rpc_log(event,owner,args) 
	#define rpc_simple(data) 
#endif

#define EMULATE_SERVERINDEBUG

server_addEvent = {
	params ["_eventName","_eventCode"];
	rpc_simple("Added RPC - " + _eventName);

	["server_" + _eventName,_eventCode] call cba_fnc_addEventHandler
};

server_removeEvent = {
	params ["_eventName","_eventId"];
	["server_" + _eventName,_eventId] call CBA_fnc_removeeventhandler
};

rpc_removeEventGlobal = {
	params ["_eventName","_eventId"];
	[_eventName,_eventId] call CBA_fnc_removeeventhandler
};

server_callEvent = {
	params ["_eventName","_args"];
	["server_" + _eventName,_args] call CBA_fnc_localEvent
};

server_sendtoclient = {

		params ["_clientId","_eventName","_args"];

		#ifdef ENABLE_LAG_NETWORK
			private _c = {
				params ["_clientId","_eventName","_args"];
		#endif
		
		rpc_log(_eventName,_clientId,_args);

		["client_" + _eventName,_args,_clientId] call CBA_fnc_ownerEvent;

		#ifdef ENABLE_LAG_NETWORK
			}; invokeAfterDelayParams(_c,__LAG_NETWORK_GET_LAG__,_this);
		#endif

};

server_sendtoclientobject = {
	params ["_clientobj","_eventName","_args"];
	
	// fix isplayer
	if (owner _clientobj <= 3 && isMultiplayer) exitWith {
		traceformat("skip sending packets. Rpc: %1; args %2",_eventName arg _args)
	};

	if equals(_clientobj,objNull) exitWith {
		errorformat("Server::rpcSendToObject() - client object is null reference. Rpc name - %1; data %2",_eventName arg _args);
	};

	#ifdef ENABLE_LAG_NETWORK
		private _c = {
			params ["_clientobj","_eventName","_args"];
	#endif
	
	rpc_log(_eventName,_clientobj,_args);
	
	if (isMultiplayer) then {
		#ifdef ENABLE_LAG_NETWORK
			private _c = {
				params ["_clientobj","_eventName","_args"];
				["client_" + _eventName,_args,_clientobj] call CBA_fnc_targetEvent
			}; invokeAfterDelayParams(_c,__LAG_NETWORK_GET_LAG__,_this);
		#else
			["client_" + _eventName,_args,_clientobj] call CBA_fnc_targetEvent
		#endif

	} else {
		#ifdef EMULATE_SERVERINDEBUG
			if (_clientobj isEqualTo player) then {
				["client_" + _eventName,_args,_clientobj] call CBA_fnc_targetEvent;
			};
		#else
			["client_" + _eventName,_args,_clientobj] call CBA_fnc_targetEvent;
		#endif
	};

	#ifdef ENABLE_LAG_NETWORK
		}; invokeAfterDelayParams(_c,__LAG_NETWORK_GET_LAG__,_this);
	#endif

};

server_sendtoallclients = {
	params ["_eventName","_args"];

	#ifdef ENABLE_LAG_NETWORK
		private _c = {
			params ["_eventName","_args"];
	#endif

	rpc_log(_eventName,'ALL CLIENTS',_args);

	["client_" + _eventName,_args] call CBA_fnc_globalEvent;

	#ifdef ENABLE_LAG_NETWORK
		}; invokeAfterDelayParams(_c,__LAG_NETWORK_GET_LAG__,_this);
	#endif
};

rpc_sendGlobal = {
	params ["_eventName","_args"];

	#ifdef ENABLE_LAG_NETWORK
		private _c = {
			params ["_eventName","_args"];
	#endif

	rpc_log(_eventName,'GLOBAL',_args);

	if (isMultiplayer) then {
		[_eventName,_args] call CBA_fnc_globalEvent
	} else {
		[_eventName,_args] call CBA_fnc_localEvent
	};

	#ifdef ENABLE_LAG_NETWORK
		}; invokeAfterDelayParams(_c,__LAG_NETWORK_GET_LAG__,_this);
	#endif
};


#ifdef DEBUG
	rpc_getClientEvent = {
		params ["_name"];
		cba_events_eventNamespace getVariable ["client_" + _name,[]];
	};
	rpc_getServerEvent = {
		params ["_name"];
		cba_events_eventNamespace getVariable ["server_" + _name,[]];
	};
#endif