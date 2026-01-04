// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

//#define DSM_DISABLE

dsm_onlineUpdateHandle = -1;
if isNull(dsm_callbackExtensionHandle) then {
	dsm_callbackExtensionHandle = -1;
};
dsm_isFirstLoad = false;

dsm_connectedToManager = false;

#define DSM_CALLBACKNAME "dsm_ext"

#ifdef EDITOR
	#define DSM_CHANNEL_CHANGELOG "781280820912062556"
#else
	#define DSM_CHANNEL_CHANGELOG "847850893076201522"
#endif


#ifndef EDITOR
	#undef DSM_DISABLE
#endif

dsm_stdCall = {
	params ["_func",["_args",[]]];
	("gamepipe" CALLEXTENSION [_func,_args]) select 0
};

dsm_isErrorReturn = {
	"[Error]" in _this
};

dsm_deserializeStringList = {
	parseSimpleArray _this
};

dsm_sendToChannel = {
	params ["_chanId","_content"];
	if not_equalTypes(_content,"") then {
		_content = format["%1",_content];
	};
	["pipe_printdisc",["print",_chanId,_content]] call dsm_stdCall;
};

dsm_sendOnline = {
	params ["_num"];
	["online_upd",[_num]] call dsm_stdCall;
};

dsm_onOnlineUpdate = {
	[count cm_allClients] call dsm_sendOnline;
};

dsm_initialize = {
	#ifdef RBUILDER
	if (true) exitWith {
		log("dsm::initialize() - RBUILDER mode. Skip initialization");
	};
	#endif

	#ifdef DSM_DISABLE
	if (true) exitwith {
		log("dsm::initialize() - Flag DSM_DISABLE active. Skip initialization");
	};
	#endif
	log("dsm::initialize() - start");
	if !isNull(dsm_callbackExtensionHandle) then {
		removeMissionEventHandler ["ExtensionCallback",dsm_callbackExtensionHandle];
		dsm_callbackExtensionHandle = -1;
	};

	dsm_isFirstLoad = !(call dsm_isLoaded);

	private _result = ["pipe_start",[]] call dsm_stdCall;

	if (_result call dsm_isErrorReturn) exitwith {
		errorformat("dsm::initialize() - Error on initialize pipe: %1",_result);
		appExit(APPEXIT_REASON_EXTENSION_ERROR);
	};

	logformat("dsm::initialize() - pipe status: %1",_result);

	dsm_callbackExtensionHandle = addMissionEventHandler [
		"ExtensionCallback", 
		dsm_callbackHandle
	];

	dsm_onlineUpdateHandle = startUpdate(dsm_onOnlineUpdate,10);

	private _after = {
		["connection_check",[0]] call dsm_stdCall;
	};
	invokeAfterDelay(_after,2);

	logformat("dsm::initialize() - pipe ready; callback handle %1 with name '%2'; update online handle %3", dsm_callbackExtensionHandle arg DSM_CALLBACKNAME arg dsm_onlineUpdateHandle);
};

dsm_deinitialize = {
	if (call dsm_isLoaded) then {
		["pipe_stop"] call dsm_stdCall;
	};
};

dsm_callbackHandle = {
	params ["_name", "_function", "_data"];
	#ifdef EDITOR
	traceformat("DSM_CALLBACK: %1",_this)
	#endif
	if (_name == DSM_CALLBACKNAME) exitwith {
		//_data : str(code); str(channel_id)
		if (_function == "srvcall") exitwith {
			_list = _data call dsm_deserializeStringList;
			if (count _list != 2) exitwith {
				errorformat("dsm::callbackHandle() <%1> - param count error (%2) with data %3",_function arg count _list arg _data);
			};
			_list params ["_code","_channel"];
			_ret = "___$DSM_CB_NODATA$___";
			_code = "_ret = 0 call {"+_code+"}";
			isNIL (compile _code);
			[_channel,format["[CALLRET]: ```sqf
%1
```",_ret]] call dsm_sendToChannel;
		};
		if (_function == "callcmd") exitwith {
			
			_list = _data call dsm_deserializeStringList;
			if (count _list != 2) exitwith {
				errorformat("dsm::callbackHandle() <%1> - param count error (%2) with data %3",_function arg count _list arg _data);
			};
			_list params ["_cmd","_channel"];
			[_channel,"Not supported in version "+ project_version] call dsm_sendToChannel;
		};
		if (_function == "setlastgame") exitwith {
			gm_isLastRound = true;
			["setlastgame_success",[0]] call dsm_stdCall;
		};
		if (_function == "connection_check_respone") exitwith {
			dsm_connectedToManager = true;
		};
		if (_function == "oauth_response") exitwith {
			//traceformat("oauth resp: %1",_data);
			if !isNull(srv_auth_onResponse) then {
				_list = _data call dsm_deserializeStringList;
				_list call srv_auth_onResponse;
			};
		};
		if (_function == "oauth_callback") exitWith {
			//traceformat("oauth callback: %1",_data);
			if !isNull(srv_auth_onCallback) then {
				_list = _data call dsm_deserializeStringList;
				_list call srv_auth_onCallback;
			};
		};
		//Ответ от дискорда (регистрация через лс)
		//! not used
		if (_function == "accounting_register_request") exitwith {
			_list = _data call dsm_deserializeStringList;
			_list params ["_id","_nick","_hash","_discordUserId"];
			if (!call dsm_accounts_canUse) exitwith {
				[_id,"Система привязки отключена или не активна."] call dsm_sendToChannel;
			};
			[_nick,_hash,_id,_discordUserId] call dsm_accounts_checkSync;
			//ctx.Channel.Id.ToString(),nickname,hash
		};
		if (_function == "sync_client_roles") exitwith {
			if (!call dsm_accounts_canUse) exitwith {};
			_list = _data call dsm_deserializeStringList;
			_list params ["_nick","_rolesStr"];
			_roleList = _rolesStr splitString ";";
			private _cli = [_nick,true] call cm_findClientByName;
			if isNullReference(_cli) exitwith {};
			callFuncParams(_cli,updateDiscordRoles,_roleList);
		};
	};	
};

dsm_isLoaded = {
	(["pipe_isenabled"] call dsm_stdCall) == "true";
};

//================================= server command executer =============================


dsm_internal_virtualClient = nullPtr;

dsm_callServerCommand = {
	params ["_cmd","_executorName"];
	if isNullReference(dsm_internal_virtualClient) then {
		dsm_internal_virtualClient = new(ServerClient);
		private _c = dsm_internal_virtualClient;
		setVar(_c,uid,"");
		setVar(_c,id,0);
	};

	private _cli = dsm_internal_virtualClient;
	setVar(_cli,name,"[SERVER]");
};