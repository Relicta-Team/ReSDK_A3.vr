// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================


//отлов ошибки с any полями бд
#define CATCH_REQUEST_ERROR
//проверка последней ошибки
#define VALIDATE_LAST_ERROR

db_open = {
	parseSimpleArray((dbRequest ["open",[DB_PATH]])select 0)
};

db_close = {
	if (!(call db_isOpened)) exitWith {[-30,"ERROR_RV_DB_NOT_OPENED"]};

	parseSimpleArray((dbRequest ["close",[]])select 0)
};

db_isOpened = {
	(parseNumber((dbRequest ["isopen",[]])select 0))!=0
};

db_getlasterror = {
	((dbRequest ["getlasterror",[]])select 0)
};

db_flushlasterror = {
	dbRequest ["flushlasterror",[]]
};

db_isEnabledStdoutLog = {
	((dbRequest ["canlogstdout",[]]) select 0)=="True"
};

db_switchStdoutLog = {
	dbRequest ["switchlog",[]]
};

//true если системный возврат
db_checkSystemReturn = {
	params ["_output",["_printtoconsole",true]];
	private _isSys = if (count _output == 2) then {
		private _probResultInfo = _output select 1;
		if equalTypes(_probResultInfo,"") then {
			(_probResultInfo == "OK" || "ERROR_" in _probResultInfo)
		} else {
			false
		}
	} else {
		false
	};
	if (_isSys && _printtoconsole) then {
		if equals(_output select 0,1) then {
			logformat("[DATABASE]:	%1 - %2",_output select 0 arg _output select 1);
			["[DATABASE]:	%1 - %2",_output select 0 arg _output select 1] call logInfo;
		} else {
			errorformat("[DATABASE]:	Return code: %1 - %2",_output select 0 arg _output select 1);
			["[DATABASE]:	Return code: %1 - %2",_output select 0 arg _output select 1] call logError;
			errorformat("[DATABASE]: %1",call db_getlasterror);
			["[DATABASE]: %1",call db_getlasterror] call logError;
		};
	};
	_isSys
};

/*
	Осуществляет запрос до базы данных SQLite.
	0 <string> _request - Тело запроса
	1 <string> _retTypes - типы, в которые будут сконвертированы значения из запроса.
		Если содержит недопустипые типы - вернёт пустой массив.
		Если количество столбцов не совпадает с количеством возвращаемых типов - вернёт пустой массив.

			Допустимые типы: string, int, bool, double, float, TimeSpan, DateTime, DateTimeOffset,
			long, uint, decimal, byte, ushort, short, sbyte, byte[], Guid, Uir, StringBuilder, UriBuilder

			Допустимые разделители: "|"; ","; " "

	Пример:
		//make table
		["CREATE TABLE users (Id INTEGER PRIMARY KEY,nick TEXT NOT NULL,RegDate TEXT NOT NULL);"] call db_query;

		//insert item
		[
			format[
				"INSERT INTO users (Id,Name,RegDate) VALUES(%1,'%2','2013-10-07 08:23:19.120')",
				12345,
				"TestUser"
			]
		] call db_query;

		// get values
		(["SELECT Id,RegDate FROM users WHERE nick='TestUser'","uint,DateTime"] call db_query)
			params ["_id","_date"];

		assert(_id == 12345); // ok

		_dateCheck = [2013,10,7,8,23,19,120];
		assert(equals(_dateCheck,_date)); // ok
*/
db_query = {
	params ["_request",["_retTypes",""],["_singleReturn",false]];
	#ifdef SP_MODE
	if (true) exitWith {null};
	#endif

	#ifdef CATCH_REQUEST_ERROR
	private _checked = _request;
	if not_equalTypes(_checked,"") then {_checked = str _checked};
	if ([_checked,"\bany"] call regex_isMatch) then {
		["Probably error database request: %1 (%2)",_request,_retTypes] call logError;
	};
	#endif
	["db::query() ret:%2-%3; req: %1",_request,_retTypes,_singleReturn] call logInfo;
	private _resp = (dbRequest ["query",[_request,_retTypes]]);
	
	//check exceptions
	#ifdef VALIDATE_LAST_ERROR
	if ((_resp select 1) != 0) exitWith {
		["db::query(): Fatal query error: %1",_resp] call logError;
		["db::query(): %1",call db_getlasterror] call logError;

		["Database fatal error. See logs for more details. Server will be restart after 5 seconds"] call discServerNotif;
		["<t size='4'>Ошибочка. Сервер надо перезапустить...</t>","system"] call cm_sendOOSMessage;
		
		{[getVar(_x,id),"Возникла общая ошибка. Сервер сейчас перезапустится."] call cm_serverKickById;} foreach cm_allClients;
		if (!cm_isServerLocked) then {call cm_serverLock;};

		invokeAfterDelay({"#restart" call cm_serverCommand},5);
		null //for skip any actions
	};
	#endif
	
	private _q = parseSimpleArray(_resp select 0);
	if (_singleReturn) exitWith {_q select 0};
	_q
};

//versioning 
db_getVersion = {
	private _query = "select Value from CommonStorage where Key='DBVersion'";
	private _res = [text _query,"string"] call db_query;
	if (count _res == 0) exitWith {""};
	_res select 0 select 0
};

db_getCommonVal = {
	params ["_varName",["_returnType","string"]];
	private _query = format["select Value from CommonStorage where Key='%1'",_varName];
	private _res = [text _query,_returnType] call db_query;
	if (count _res == 0) exitWith {""};
	_res select 0 select 0
};

db_setCommonVal = {
	params ["_varName","_value",["_inString",true]];
	private _query = 
		if (_inString) then {
			format["INSERT OR REPLACE INTO CommonStorage (Key,Value) VALUES ('%1','%2')",_varName,_value];
		} else {
			format["INSERT OR REPLACE INTO CommonStorage (Key,Value) VALUES ('%1',%2)",_varName,_value];
		};
	[text _query] call db_query;
};

/*--------------------------------------------------------------------------------------------------
								SQLITE DB DATETIME HELPERS
--------------------------------------------------------------------------------------------------*/

// Форматирует массив даты-времени в строку, пригодную для сравнения с datetime() в sqlite
db_dateTimeFormatForComparsion = {
	_this params [["_y",1],["_mt",1],["_d",1],["_h",0],["_m",0],["_s",0],["_ms",0]];

	#define applyficator(val) (if (val < 10) then {"0" + str val} else {str val})
	//strftime('%Y-%m-%d %H:%M:%S','2021-11-07T15:22:50.740')
	format[
		"%1-%2-%3 %4:%5:%6",
		applyficator(_y),
		applyficator(_mt),
		applyficator(_d),
		applyficator(_h),
		applyficator(_m),
		applyficator(_s)
	]
};
