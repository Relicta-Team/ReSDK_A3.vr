// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================


mysql_sessionId = "";


mysql_connect = {

	// generate unical id
	call mysql_generateSessionId;

	private _query = format["9:ADD_DATABASE:%1:%2", MYSQL_DATABASE_SECTION, MYSQL_DATABASE_NAME];
	private _ret = DLLCallRet(_query);
	private _output = false;

	if !isNullVar(_ret) then {
		if equals(_ret select 0,1) then {
			_output = call mysql_initProtocol;
		} else {
			if equals(tolower(_ret select 1),"already connected to database") then {
				_output = call mysql_initProtocol;
			};
		};
	};

	_output
};

mysql_initProtocol = {
	private _query = format ["9:ADD_DATABASE_PROTOCOL:%1:SQL:%3:%2", MYSQL_DATABASE_NAME, MYSQL_DATABASE_ESCAPECHAR, mysql_sessionId];
	private _return = false;
	private _rez = DLLCallRet(_query);
	if !isNullVar(_rez) then {
		if equals(_rez select 0,1) then {_return = true};
	};
	_return
};

mysql_generateSessionId = {
	mysql_sessionId = str(round(random(999999))) + str(round(random(999999)));
};
