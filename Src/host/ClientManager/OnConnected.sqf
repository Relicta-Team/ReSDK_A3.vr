// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

params ["_id", "_uid", "_name", "_jip", "_owner", "_idstr"];


cm_maxClients = (count allPlayers) max cm_maxClients;


/*
if !isNull(CRYPT_ENABLED) then {
	[[RC_CLIENT_KEY,rc_deflow_cli],
		if (!isNull(CRYPT_SAVE_AS_BINARY) && {CRYPT_SAVE_AS_BINARY}) then {
			{
				params ["_k","_co"];
				forceUnicode 1;[_k,toArray (loadfile PATH_TO_CLIENT_DATA)] call _co;
			}
		} else {
			{
				params ["_k","_co"];
				[_k,parsesimplearray loadfile PATH_TO_CLIENT_DATA] call _co;
			}
		}
	] remoteExecCall ["spawn", _owner];
} else {
	[[],
		{
			call relicta_cli_publicLoader;
		}
	] remoteExecCall ["spawn", _owner];
};
*/	


//Запускаем таймер	
_timer = {
	params ["_pwData"];
	
	_pwData callv(onConnectTimeout);
}; 

_pwData = struct_newp(PreAwaitClientData,_owner);
invokeAfterDelayParams(_timer,TIME_TO_INIT_CLIENT,[_pwData]);

cm_preAwaitClientData set [_owner,_pwData];

//send client auth process
[	
	[_owner],
	srv_auth_connected
] remoteExecCall ["spawn", _owner];

logger_client("Client connected. Owner %1; UID:%2; ID %3",_owner arg _uid arg _id);