// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================


//Проверка загружен ли внешний движок в игру
ReBridge_isLoaded = {
	engineGetReturn(engineCall(isrunning))=="true"
};

ReBridge_defaultLogFile = 
	#ifdef EDITOR
	getMissionPath "src\ReBridge\rebridge_log.txt"
	#else
	""
	#endif
;

//возвращает корневую директорию сервера
#ifdef RBUILDER
ReBridge_getWorkspace = {
	call compile (engineCall(getworkspace) select 0)
};
#endif

ReBridge_loadedLogFile = "";

ReBridge_start = {
	params [["_logFile",
	ReBridge_defaultLogFile
	]];

	ReBridge_loadedLogFile = _logFile;
	engineCallParams(start,[_logFile]);
};

ReBridge_stop = {
	engineCall(stop);
};

// Вызов системной команды, определённой в bridge
ReBridge_callCommand = {
	params ["_func",["_args",[]],["_outstr",false]];
	private _output = engine_extName callExtension [_func,_args];
	if (_outstr) then {
		engineGetReturn(_output)
	} else {
		engineGetReturnAsArray(_output)
	}
};

ReBridge_callCode = {
	params ["_codePath",["_args",[]]];
	if isNullVar(_codePath) then {
		_codePath = "ReEngine\CodeTester.cs";
	};
	(engineCallParams(callcode,[_codePath arg _args]))
};	

//Получает объём используемой памяти движком
ReBridge_getMemUsed = {
	params ["_gcproc"];
	if not_equalTypes(_gcproc,true) exitWith {
		errorformat("engine::gemeMemUsed() - param type error (need bool)");
	};	
	engineGetReturn(engineCallParams(memuse,[_gcproc]));
};