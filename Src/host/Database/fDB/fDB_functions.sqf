// ======================================================
// Copyright (c) 2017-2025 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

/*
	Function list:
		fdb_open - Opens file for manipulation.
		fdb_close - Закрывает файл, не записывает в него никаких данных.
		fdb_getFiles - Возвращает массив имен файлов в папке хранения.
		fdb_fileExist - Проверяет, существует ли данный файл.
		fdb_delete - Удаляет файл из файловой системы. Не влияет на состояние любых файлов, открытых с помощью fdb_open.

		fdb_read - Считывает содержимое файла в ОЗУ.
		fdb_write - Записывает в файл текущее содержимое ОЗУ, связанное с этим файлом.


		fdb_get - Получает значение, связанное с ключом из памяти. Не читает ничего из самого файла. Если в настоящее время этот файл не открыт или данный ключ не существует, возвращаемое значение равно нулю.
		fdb_set - Устанавливает значение, связанное с ключом в памяти. В файл ничего не записывает.
		fdb_removeKey - Стирает ключ из памяти. После этого вызовы fdb_get вернут nil.

		fdb_error - Внутренняя функци логирования ошибок локальной бд.


	Usage:
		private _handleFile = "test.db";

		[_handleFile] call fdb_open;
		[_handleFile] call fdb_read;
		[_handleFile,"testkey","testvalue"] call fdb_set;

		_val = [_handleFile,"testkey"] call fdb_get;
		logformat("Value is %1",_val);

		[_handleFile] call fdb_write;
		[_handleFile] call fdb_close;#include "fDB_functions.sqf"


*/
fdb_close = {
	params [["_fileName", "", [""]]];

	private _ret = "filext" callExtension ["", ["close", _fileName]];
	private _errorCode = _ret#1;
	if (_errorCode != FDB_SUCCESS) exitWith {
	    [_errorCode, _this,"close"] call fdb_error;
	    false;
	};

	true;
};


fdb_delete = {
	params [["_fileName", "", [""]]];

	private _ret = "filext" callExtension ["", ["deleteFile", _fileName]];
	private _errorCode = _ret#1;
	if (_errorCode != FDB_SUCCESS) exitWith {
	    [_errorCode, _this,"delete"] call fdb_error;
	    false;
	};

	true;
};

fdb_removeKey = {
	params [["_fileName", "", [""]], ["_key", "", [""]], ["_value", "", [""]]];

	private _ret = "filext" callExtension [_value, ["eraseKey", _fileName, _key]];

	private _errorCode = _ret#1;
	if (_errorCode != FDB_SUCCESS) exitWith {
	    [_errorCode, _this,"removeKey"] call fdb_error;
	    false;
	};

	true;
};

fdb_error = {
	params [["_errorCode", 0, [0]], ["_args", [], [[]]],["_fnName","<no_method>"]];

	private _errorText = switch (_errorCode) do {
	    case FDB_SUCCESS: {"Success"};
	    //case FDB_GET_MORE_AVAILABLE: {};
	    case FDB_ERROR_WRONG_ARG_COUNT: {"Wrong argument count"};
	    case FDB_ERROR_WRONG_FILE_NAME: {"Wrong file name"};
	    case FDB_ERROR_WRONG_FUNCTION_NAME: {"Wrong function name"};
	    case FDB_ERROR_FILE_NOT_OPEN: {"File not open"};
	    case FDB_ERROR_KEY_NOT_FOUND: {"Key not found"};
	    case FDB_ERROR_WRITE: {"Generic file write error"};
	    case FDB_ERROR_READ: {"Generic file read error"};
	    case FDB_ERROR_WRONG_FILE_FORMAT: {"Wrong file format"};
	    default {"Unknown error"};
	};

	_errorText = format ["[FDB] fdb::%3() - Error: %1, arguments: %2", _errorText, _args,_fnName];

	error(_errorText);
};

fdb_fileExist = {
	params [["_fileName", "", [""]]];

	private _ret = "filext" callExtension ["", ["fileExists", _fileName]];
	private _errorCode = _ret#1;
	_errorCode == FDB_SUCCESS;
};


fdb_get = {
	params [["_fileName", "", [""]], ["_key", "", [""]]];
	
	private _substrings = [];

	// Get first part of value
	("filext" callExtension ["", ["get", _fileName, _key, 1]]) params ["_substr", "_retCode"]; // 1 means we start getting value from the start of the string
	
	// Common case, value returned immediately
	if (_retCode == FDB_SUCCESS) exitWith {
	    _substr;
	};

	// If key was not found, return nil, don't print error
	if (_retCode == FDB_ERROR_KEY_NOT_FOUND) exitWith {
	    nil; // Either it doesn't exist or file is not open.
	};

	// If by this point return code is not FDB_GET_MORE_AVAILABLE, it is an error
	if (_retCode != FDB_GET_MORE_AVAILABLE) exitWith {
	    [_retCode, _this,"get"] call fdb_error;
	    nil;
	};

	// = = = There is more parts of string available, read and combine them all

	_substrings pushBack _substr;

	// Read other parts of value
	while {_retCode == FDB_GET_MORE_AVAILABLE} do {
	    ("filext" callExtension ["", ["get", _fileName, _key, 0]]) params ["_substr", "__retCode"]; // 0 means we continue getting parts of the string
	    _retCode = __retCode;
	    _substrings pushBack _substr;
	};
	
	_substrings joinString "";
};

fdb_getFiles = {
	private _retArray = "filext" callExtension ["", ["getFiles"]];
	parseSimpleArray (_retArray#0);
};

fdb_open = {
	params [["_fileName", "", [""]]];

	private _ret = "filext" callExtension ["", ["open", _fileName]];
	private _errorCode = _ret#1;
	if (_errorCode != FDB_SUCCESS) exitWith {
	    [_errorCode, _this,"open"] call fdb_error;
	    false;
	};

	true;
};

fdb_read = {
	params [["_fileName", "", [""]]];

	private _ret = "filext" callExtension ["", ["read", _fileName]];
	private _errorCode = _ret#1;
	if (_errorCode != FDB_SUCCESS) exitWith {
	    [_errorCode, _this,"read"] call fdb_error;
	    false;
	};

	true;
};

fdb_set = {
	params [["_fileName", "", [""]], ["_key", "", [""]], ["_value", "", [""]]];

	private _ret = "filext" callExtension [_value, ["set", _fileName, _key]];

	private _errorCode = _ret#1;
	if (_errorCode != FDB_SUCCESS) exitWith {
	    [_errorCode, _this,"set"] call fdb_error;
	    false;
	};

	true;
};

fdb_write = {
	params [["_fileName", "", [""]]];

	private _ret = "filext" callExtension ["", ["write", _fileName]];
	private _errorCode = _ret#1;
	if (_errorCode != FDB_SUCCESS) exitWith {
	    [_errorCode, _this,"write"] call fdb_error;
	    false;
	};

	true;
};
