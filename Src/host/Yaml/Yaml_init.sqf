// ======================================================
// Copyright (c) 2017-2024 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================


#include "..\engine.hpp"

#define YAML_EXTENSION_NAME "ReYaml"

#define YAML_COMMAND_PARSE_STRING "parse_string"
#define YAML_COMMAND_HAS_PARTS "has_parts"
#define YAML_COMMAND_READ_PART "next_read"

#define YAML_COMMAND_FREE_PARTS "free_parts"
#define YAML_COMMAND_GET_LEFT_PARTS_COUNT "get_left_parts_count"

#define YAML_COMMAND_SET_DEBUG_PRINT "set_debug"

#define YAML_DEFAULT_CHAR_REPLACER ""

#define YAML_OUTPUT_PREFIX_EXCEPTION "$EX$:"
#define YAML_OUTPUT_SANITIZE_EXCEPTION(val) ((val) select [count YAML_OUTPUT_PREFIX_EXCEPTION,count (val)])
#define YAML_OUTPUT_PREFIX_PARTIAL "$PART$"

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

//загрузка yml файла. ошибка загрузи или несуществующий файл приведет к возврату null-значения
yaml_loadFile = {
	params ["_file"];
	
	if (!fileExists(_file)) exitWith {
		errorformat("yaml::loadFile() - File not found: %1",_file);
		null
	};

	private _content = LoadFile(_file);
	private _ref = refcreate(0);
	if !([_content,_ref] call yaml_loadData) exitWith {
		errorformat("yaml::loadFile() - Error loading file: %1; Output: %2",_file arg refget(_ref));
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
			private _result = call compile (_parts joinString "");
			refset(_refData,_result);
		};
		_retCode
	};
	_result = call compile _result;
	refset(_refData,_result);
	true
};

yaml_setDLLConfig = {
	params [["_debugMode",false]];
	private _result = [];
	_result pushBack (YAML_EXTENSION_NAME callExtension [YAML_COMMAND_SET_DEBUG_PRINT,[_debugMode]]);
	_result
};

#ifdef YAML_TESTS

[true] call yaml_setDLLConfig;
yaml_debug_testData = "

	# test comment
	testLoot:
	- name: abc
		desc: cde
		test_num: 123
		test_bool: on
		test_float: -0.123
		test_str: abstring
	- onelinearr: [1,2,0xabc]
	- ab: 1
" regexReplace ["\t/g","  "];
private _bufferRef = refcreate(0);
_d1 = [yaml_debug_testData,_bufferRef] call yaml_loadData;
assert(_d1);
_d1 = refget(_bufferRef);
buf = _d1;
assert(count _d1 == 1);
_d1 = _d1 get "testLoot";
assert(count(_d1) == 3);
assert(_d1 isequaltype []);
assert(count (_d1 select 0)==6);
assert(count (_d1 select 1 get "onelinearr")==3);
assert((_d1 select 1 get "onelinearr") isequalto vec3(1,2,0xabc));


private _d = [];
for"_i" from 1 to 20480 do {
	_d pushBack (format["longkey_%1: Ключ с длинным значением по индексу %1",_i]);
};
_d pushBack "LATEST: ""EOF""   ";
yaml_debug_longData = _d joinString endl;

yaml_debug_fileContent = loadfile "src\host\Yaml\test.yaml";



#endif
