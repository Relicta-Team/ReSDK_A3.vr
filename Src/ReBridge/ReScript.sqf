// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================


//билд скрипт-файла
rescript_build = {
	params ["_path"];
	private _status = engineGetReturn(engineCallParams(scriptbuild,[_path]));
	_rb_logformat("initialize project status: %1",_status);
	if (_status != "ok") exitWith {
		ReBridge_lastError = _status;
		_rb_errorformat("Error at initialize project: %1",_path)
	};
	_status
};	
//инициализация скрипта
rescript_initScript = {
	params ["_scriptName"];
	if (ReBridge_lastError != "") exitWith {
		_rb_errorformat("Cant init script %1. Last error: %2",_scriptName arg ReBridge_lastError);
	};
	private _r = engineGetReturn(engineCallParams(scriptinit,[_scriptName]));
	_rb_logformat("Initialized script module - %1 (%2)",_scriptName arg _r);
	_r
};
//вызов команды
rescript_callCommand = {
	params ["_scriptName","_command",["_optionalArgs",[]],["_outstr",false]];
	_command = [_scriptName,_command];
	_command append _optionalArgs;
	if (_outstr) then {
		engineGetReturn(engineCallParams(scriptcmd,_command))
	} else {
		engineGetReturnAsArray(engineCallParams(scriptcmd,_command))
	};
};	
//вызов команды без возврата
rescript_callCommandVoid = {
	params ["_scriptName","_command",["_optionalArgs",[]]];
	_command = [_scriptName,_command];
	_command append _optionalArgs;
	engineCallParams(scriptcmd,_command)
};	