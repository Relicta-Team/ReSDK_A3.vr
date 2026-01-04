// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================


#include "..\engine.hpp"
#include "..\struct.hpp"
#include "Yaml.h"

yaml_lastErrorLoadFileString = "";

//enable for test cases
//#define YAML_TESTS

//есть куски для чтения
yaml_hasPartsForRead = {
	(YAML_EXTENSION_NAME callExtension [YAML_COMMAND_HAS_PARTS,[]] select 0) == "True"
};
//прочитать кусок
yaml_readNextPart = {
	(YAML_EXTENSION_NAME callExtension [YAML_COMMAND_READ_PART,[text YAML_DEFAULT_CHAR_REPLACER]] select 0);
};
//вычистить куски
yaml_freeParts = {
	(YAML_EXTENSION_NAME callExtension [YAML_COMMAND_FREE_PARTS,[]] select 0)==true;
};
//получить количество кусков для чтения
yaml_getPartsCount = {
	parseNumber (YAML_EXTENSION_NAME callExtension [YAML_COMMAND_GET_LEFT_PARTS_COUNT,[]] select 0);
};
//расширение валидно
yaml_isExtensionLoaded = {
	(YAML_EXTENSION_NAME callExtension "") == YAML_EXTENSION_NAME
};
//получает версию расширения в виде массива
yaml_getExtensionVersion = {
	private _v = (YAML_EXTENSION_NAME callExtension "get_version");
	if (_v == "") exitWith {struct_new(Version)};
	private _varr = (_v splitString ",. ") apply {parseNumber _x};
	struct_newp(Version,_varr);
};

yaml_getLastError = {
	yaml_lastErrorLoadFileString
};

//загрузка yml файла. ошибка загрузи или несуществующий файл приведет к возврату null-значения
yaml_loadFile = {
	params ["_file"];
	yaml_lastErrorLoadFileString = "";

	if (!fileExists(_file)) exitWith {
		errorformat("yaml::loadFile() - File not found: %1",_file);
		null
	};

	private _content = LoadFile(_file);
	private _ref = refcreate(0);
	if !([_content,_ref] call yaml_loadData) exitWith {
		errorformat("yaml::loadFile() - Error loading file: %1; Output: %2",_file arg refget(_ref));
		yaml_lastErrorLoadFileString = format["Error in file: %1; Output: %2",_file arg refget(_ref)];
		null;
	};

	refget(_ref);
};

yaml_loadData = {
	params ["_data","_refData"];
	
	forceUnicode 0;
	_data = _data regexReplace["""/g",YAML_DEFAULT_CHAR_REPLACER];
	private _result = YAML_EXTENSION_NAME callExtension [YAML_COMMAND_PARSE_STRING,[text _data,text YAML_DEFAULT_CHAR_REPLACER]] select 0;
	_result = _result regexReplace[YAML_DEFAULT_CHAR_REPLACER+"/g",""""];

	//handle error
	if ([_result,YAML_OUTPUT_PREFIX_EXCEPTION] call stringStartWith) exitWith {
		refset(_refData,YAML_OUTPUT_SANITIZE_EXCEPTION(_result));
		false
	};

	//handle partial
	if (_result == YAML_OUTPUT_PREFIX_PARTIAL) exitWith {
		private _retCode = true;
		private _parts = [];
		private _curData = null;
		for "_i" from 1 to (call yaml_getPartsCount) do {
			_curData = call yaml_readNextPart;
			_curData = _curData regexReplace[YAML_DEFAULT_CHAR_REPLACER+"/g",""""];
			assert(not_equals(_curData,""));
			
			//handle error
			if ([_curData,YAML_OUTPUT_PREFIX_EXCEPTION] call stringStartWith) exitWith {
				refset(_refData,YAML_OUTPUT_SANITIZE_EXCEPTION(_curData));
				_retCode = false;
			};

			_parts pushBack _curData;
		};
		if (_retCode) then {
			private _result = "";
			private _fmtRes = "_result = " + (_parts joinString "");
			isNil (compile _fmtRes);
			refset(_refData,_result);
		};
		_retCode
	};
	private _fmtRes = "_result = " + _result;
	isNil (compile _fmtRes);
	refset(_refData,_result);
	true
};

yaml_setDLLConfig = {
	params [["_debugMode",false]];
	private _result = [];
	_result pushBack (YAML_EXTENSION_NAME callExtension [YAML_COMMAND_SET_DEBUG_PRINT,[_debugMode]]);
	_result
};

#include "Yaml_tests.sqf"