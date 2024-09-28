// ======================================================
// Copyright (c) 2017-2024 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

/*
	Как проверяются крафты:
		При запуске рецепта отправляется его айди
		Для дефолт и строительных рецепт ищется в csys_map_allCraftRefs

		Для интерактивного:
		существует карта ассоциаций: csys_map_allInteractiveCrafts

		Для системных из-за отсутствия меню:
		

*/
#include <..\..\engine.hpp>
#include <..\..\struct.hpp>
#include <..\..\text.hpp>
#include "..\..\ServerRpc\serverRpc.hpp"
#include "..\..\PointerSystem\pointers.hpp"
#include "Craft.hpp"
#include "Craft.h"

#include <..\..\oop.hpp>
#undef class

#include "CraftSystemProcess.sqf"

//key int, val ICraftRecipeBase
csys_map_allCraftRefs = createHashMap;
//key string(typename), val array<ICraftRecipeBase>
csys_map_allInteractiveCrafts = createHashMap;
//key string(typename), val array<ICraftRecipeBase>
csys_map_allSystemCrafts = createHashMap; //! В будущем можно перенести хранение буферов крафтов на типы классов

//глобальное хранилище крафтов по категориям, key int(id), val array<ICraftRecipeBase>
csys_map_storage = createhashMap; 

csys_global_counter = 1;
csys_cat_names = CRAFT_CONST_CATEGORY_NAMES;
csys_cat_map_sysnames = createHashMap;

csys_cat_getNameById = { csys_cat_names select _this };
csys_cat_getSystemNameById = { csys_cat_map_sysnames get _this };

#ifdef DEBUG
csys_cat_debug_allCrafts = [];
#endif

csys_init = {
	{
		csys_cat_map_sysnames set [_x,_foreachindex];
		csys_map_storage set [_foreachindex,[]];
	} foreach CRAFT_CONST_CATEGORY_LIST_SYS_NAMES;

	//collecting all files and load into buffer
	private _files = ["src\host\CraftSystem\Crafts\",".yml",true] call fso_getFiles;
	private _content = [];//this is full array of preloaded crafts
	private _loaded = null;
	private _errored = false;
	private _erroredString = "";
	{
		_loaded = [_x] call yaml_loadFile;
		if isNullVar(_loaded) then {
			_errored = true;
			_erroredString = format["Craft error: %1",call yaml_getLastError];
		} else {
			_content pushBack [_x,_loaded];
		};
	} foreach _files;

	if (_errored) exitWith {
		assert_str(false,_erroredString);
		setLastError(_erroredString);
	};

	{
		_x params ["_file","_content"];
		csys_internal_lastLoadedFile = _file;
		csys_internal_configNumber = _foreachindex + 1;
		traceformat("Loading craft file: %1",_file);

		if !([_content] call csys_loadConfig) exitWith {
			errorformat("Error on parse file %1",_file);
		};

	} foreach _content;
};

// загрузчик рецептов
csys_loadConfig = {
	params ["_cfgContent"];
	
	private _loaded = 0;
	private _isok = true;
	private _t = tickTime;
	{
		if !([_x] call csys_internal_loadCfgSegment) exitWith {
			_isok = false;
		};
		INC(_loaded);
	} foreach _cfgContent;
	traceformat("Loaded %1 configs (%2 sec)",_loaded arg tickTime - _t);

	_isok
};

csys_const_map_mappingTypes = createHashMapFromArray [
	["default","CraftRecipeDefault"],
	["building","CraftRecipeBuilding"],
	["system","CraftRecipeSystem"],
	["interact","CraftRecipeInteract"]
];

csys_internal_lastLoadedFile = "";
csys_internal_configNumber = 0;

csys_errorMessage = {
	private _fmt = _this;
	if not_equalTypes(_fmt,[]) then {
		_fmt = [_fmt];
	};
	_fmt set [0,(_fmt select 0) + (format[" (file: %1; item: %2)",csys_internal_lastLoadedFile,csys_internal_configNumber])];
	private _message = format _fmt;
	errorformat("[CraftError]: %1",_message);
	setLastError(_message);
};

csys_validateType = {
	params ["_dat","_key","_tarr"];
	private _keyWithDefault = equalTypes(_key,[]);
	private _value = ifcheck(_keyWithDefault,_dat getOrDefault _key,_dat get _key);
	private _output = "";
	private _keyName = ifcheck(_keyWithDefault,_key select 0,_key);
	
	#ifdef CRAFT_DEBUG_LOAD
	traceformat("VALIDATE %1 (%2)",_key arg _tarr)
	#endif

	if isNullVar(_tarr) exitWith {
		[_value,_output];
	};
	
	if (isNullVar(_value) && {!_keyWithDefault}) exitWith {
		[_value,format["'%1' is required",_keyName]];
	};
	
	if equalTypes(_tarr,[]) then {
		if !(_value isEqualTypeAny _tarr) then {
			_output = format["Property '%1' wrong type '%2', Expected any of: %3",_keyName,tolower typename _value,(_tarr apply {tolower typename _x}) joinString ", "];
		};
	} else {
		if equals(_tarr,"int") exitWith {
			if (not_equalTypes(_value,0) || {round _value != _value}) then {
				_output = format["Property '%1' wrong type '%2', Expected int",_keyName,tolower typename _value];
			}
		};
		if not_equalTypes(_value,_tarr) then {
			_output = format["Property '%1' wrong type '%2', Expected %3",_keyName,tolower typename _value,tolower typename _tarr];
		};
	};
	//traceformat("=======OUTPUT: %1",_value)
	
	[_value,_output]
};

csys_internal_loadCfgSegment = {
	params ["_data"];
	CRAFT_PARSER_HEAD;
	
	// ----------------------- base check -----------------------
	GETVAL_STR(_data, vec2("type","default"));
	FAIL_CHECK_PRINT;
	private _instancer = csys_const_map_mappingTypes get (tolower value);
	if isNullVar(_instancer) exitWith {
		["Cannot found craft type: %1",value] call csys_errorMessage;
		false
	};
	private _sobj = [_instancer] call struct_alloc;

	// name and description check
	GETVAL_STR(_data, vec2("name",""));
	FAIL_CHECK_PRINT;
	if (value != "") then {
		_sobj setv(name,value);
	} else {
		_sobj setv(__canGetNameFromResult,true);
	};

	GETVAL_STR(_data, vec2("desc",""));
	FAIL_CHECK_PRINT;
	if (value != "") then {
		_sobj setv(desc,value);
	};

	GETVAL_STR(_data, vec2("category","Other"));
	FAIL_CHECK_PRINT;
	private _catId = csys_cat_map_sysnames get value;
	if isNullVar(_catId) exitWith {
		["Unknown category: %1",value] call csys_errorMessage;
		false
	};
	_sobj setv(categoryId,_catId);

	GETVAL_STR(_data, vec2("system_specific",""));
	FAIL_CHECK_PRINT;
	if (value != "" && {!(_sobj callv(canApplySystemSpecific))}) exitWith {
		["Type %1 cannot contain system specific (required 'type: system')",_type] call csys_errorMessage;
		false
	};
	if (value != "") then {
		_sobj setv(systemSpecific,value);
	};

	// ----------------------- requirements check -----------------------
	GETVAL_DICT(_data, "required");
	FAIL_CHECK_PRINT;
	
	private _ref = refcreate("");
	_sobj callp(_parseRequired,value arg _ref);
	if (refget(_ref)!="") exitWith {
		[refget(_ref)] call csys_errorMessage;
		false
	};

	// ----------------------- failed check -----------------------
	GETVAL_DICT(_data, vec2("failed",null));
	FAIL_CHECK_PRINT;

	_sobj callp(_parseFailed,value arg _ref);
	if (refget(_ref)!="") exitWith {
		[refget(_ref)] call csys_errorMessage;
		false
	};

	// ----------------------- options check -----------------------
	GETVAL_DICT(_data, vec2("options",null));
	FAIL_CHECK_PRINT;
	_sobj callp(_parseOptions,value arg _ref);
	if (refget(_ref)!="") exitWith {
		[refget(_ref)] call csys_errorMessage;
		false
	};

	// ----------------------- result check -----------------------
	GETVAL_DICT(_data, "result");
	FAIL_CHECK_PRINT;
	_sobj callp(_parseResult,value arg _ref);
	if (refget(_ref)!="") exitWith {
		[refget(_ref)] call csys_errorMessage;
		false
	};

	#ifdef DEBUG
	csys_cat_debug_allCrafts pushBack _sobj;
	#endif

	_sobj callv(onRecipeReady);
	
	#ifdef CRAFT_DEBUG_LOAD
	traceformat("============= Recipe ready: %1",_sobj)
	#endif

	true
};

/*
	специальное форматирование строк
	["{message.lower} {postfix}", 
		createHashMapFromArray [
			["message","Hello!"],
			["postfix","world!"]
		]
	] call csys_format; // "hello! world!"
*/
csys_format = {
	params ["_str","_argsmap"];
	private _patternKeys = "\ *\w+([ \t]*\.[ \t]*\w+)*\ *";
	private _patternFormatter = "\{("+_patternKeys+")\}";
	private _match = null;
	private _kmap = null;
	private _tokens = null;
	private _argName = null;

	while {[_str,_patternFormatter] call regex_isMatch} do {
		_match = [_str,_patternFormatter] call regex_getFirstMatch;
		_kmap = [_match,_patternKeys] call regex_getFirstMatch;
		_tokens = _kmap splitString " .";
		_argName = _tokens deleteAt 0;
		if (_argName in _argsmap) then {
			private _val = _argsmap get _argName;
			assert(!isNullVar(_val));
			{
				_val = _val call (csys_map_tokenMap getOrDefault [_x,csys_defaultTokenCode]);
			} foreach _tokens;
			_str = [_str,_match,_val] call regex_replace;
		};
	};

	_str
};

csys_map_tokenMap = createHashMapFromArray [
	["lower",{lowerize(_this)}],
	["upper",{capitalize(_this)}]
];

csys_defaultTokenCode = { _this };

csys_prepareRangedString = {
	params ["_input",["_intoArray",false]];
	if !([_input,"\(\d+\-\d+\)"] call regex_isMatch) exitWith {ifcheck(_intoArray,[_input],_input)};

	private _matchFull = [_input,"\(\d+\-\d+\)"] call regex_getFirstMatch;
	_input = [_input,"\(\d+\-\d+\)","%1"] call regex_replace;
	(_matchFull splitString " .-()" apply {parseNumberSafe(_x)}) params [["_min",1],["_max",1]];
	private _buff = [];
	for "_i" from _min to _max do {
		_buff pushBack (format[_input,_i]);
	};
	_buff
};


/* 
	Генератор кода условия
	Правила:
		все \w+ являются полями объекта
		все \w+\s*\(.*\) являются вызываемыми функциями. Функции могут быть pure-only и не должны иметь параметров
*/
csys_generateInsturctions = {
	params ["_condition"];
	
	setLastError("Component.condition - not implemented yet...");

	// private _baseCondition = _condition;
	// private _condExecution = [];
	// private _lop = [];
	// private _eop = [];

	// private _needOp = false;
	// private _parseError = false;
	// while {[_condition,csys_const_alllowRegex] call regex_isMatch} do {
	// 	private _isOp = [_condition,csys_const_regexOP] call regex_isMatch;
	// 	private _anyVal = [_condition,csys_const_regexOP]
	// 	if (_isOp != _needOp) exitWith {
	// 		setLastError("Failed to parse condition (operator error): " + _baseCondition);
	// 		_parseError = true;
	// 	};
	// 	if (_isOp) then {

	// 	} else {

	// 	};

	// 	private _signature = [_condition,csys_const_regexFunc] call regex_getFirstMatch;
	// 	private _funcName = ["\w+",_signature]call regex_getFirstMatch;
	// 	private _repl = format['callFunc(_this,%1)'];
	// };

	// if (_parseError) exitWith {null};
	// _condExecution append _lop;
	// _condExecution append _eop;

	// if (count _condExecution == 0) then { _condExecution = ["true"]};
	// compile (_condExecution joinString "")
};
csys_const_regexFunc = "(\w+)\s*\(\)";
csys_const_regexField = "\w+";
csys_const_regexOP = "==|!=|<=|>=|\|\||&&|>|<";
csys_const_alllowRegex = (csys_const_regexFunc+"|"+csys_const_regexField+"|"+csys_const_regexOP);