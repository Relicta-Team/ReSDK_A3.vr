// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
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
#include <..\engine.hpp>
#include <..\oop.hpp>
#include <..\struct.hpp>
#include <..\text.hpp>
#include "..\ServerRpc\serverRpc.hpp"
#include "..\PointerSystem\pointers.hpp"
#include "..\..\client\Interactions\interact.hpp"
#include "..\GURPS\gurps.hpp"

#include <..\oop.hpp>
#undef class
#undef value

#include "Craft.hpp"
#include "Craft.h"

#include "CraftSystemProcess.sqf"

//key int, val ICraftRecipeBase
csys_map_allCraftRefs = createHashMap;
//key string(typename) as target, val array<ICraftRecipeBase>
csys_map_allInteractiveCrafts = createHashMap;
//key string(typename), val array<ICraftRecipeBase>
csys_map_allSystemCrafts = createHashMap; //! В будущем можно перенести хранение буферов крафтов на типы классов

//глобальное хранилище крафтов по категориям, key int(id), val array<ICraftRecipeBase>
csys_map_storage = createhashMap; 

//системные крафты...
csys_map_systems_storage = createhashMap;

csys_global_counter = 1;

csys_cat_map_sysnames = createHashMap;
csys_cat_getSystemNameById = { csys_cat_map_sysnames get _this };

#ifdef DEBUG
csys_cat_debug_allCrafts = [];
#endif

csys_init = {


	{
		csys_cat_map_sysnames set [_x,_foreachindex];
		csys_map_storage set [_foreachindex,[]];
		csys_map_systems_storage set [_foreachIndex,[]];
	} foreach CRAFT_CONST_CATEGORY_LIST_SYS_NAMES;

	csys_systemController_handleUpdate = startUpdate(csys_systemController_onUpdate,1);

	#ifdef SP_MODE
	if(true)exitWith{};
	#endif

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
		//assert_str(false,_erroredString);
		error(_erroredString);
		setLastError(_erroredString);
	};

	{
		_x params ["_file","_content"];
		csys_internal_lastLoadedFile = _file;
		csys_internal_configNumber = 1;
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
		INC(csys_internal_configNumber);
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
	#ifdef EDITOR
	["Craft build failed:" +endl+ _message] call messageBox;
	#endif
};

//TODO optimize
csys_validateType = {
	params ["_dat","_key","_tarr"];
	private _keyWithDefault = equalTypes(_key,[]);

	//["after get value %1",_key] call logInfo;
	private _value = ifcheck(_keyWithDefault,_dat getOrDefault _key,_dat get _key);
	
	private _output = "";
	private _keyName = ifcheck(_keyWithDefault,_key select 0,_key);
	//["after get keyname %1 %2",_keyName,isNullVar(_value)] call logInfo;
	#ifdef CRAFT_DEBUG_LOAD
	traceformat("VALIDATE %1 (%2)",_key arg _tarr)
	#endif
	//["before check tarr %1",_tarr] call logInfo;
	if isNullVar(_tarr) exitWith {
		[_value,_output];
	};
	//["before check null value %2 %1",isNullVar(_value),_key] call logInfo;
	if (isNullVar(_value) && {!_keyWithDefault}) exitWith {
		[null,format["'%1' is required",_keyName]];
	};
	//["check tarr types %1",_tarr]call logInfo;
	
	//can be null (temporary)
	if !isNullVar(_value) then {
		//["tarr types not null"] call logInfo;
		if equalTypes(_tarr,[]) then {
			// if (isNullVar(_value) && {_keyWithDefault} && {!isNull(_key select 1)}) exitWith {
			// 	_output = format["Property '%1' wrong type '%2', Expected any of: %3",_keyName,"null",_tarr];
			// };
			if !(_value isEqualTypeAny _tarr) then {
				_output = format["Property '%1' wrong type '%2', Expected any of: %3",_keyName,tolower typename _value,(_tarr apply {tolower typename _x}) joinString ", "];
			};
		} else {
			// if (isNullVar(_value) && {_keyWithDefault} && {!isNull(_key select 1)}) exitWith {
			// 	_output = format["Property '%1' wrong type '%2', Expected instance: %3",_keyName,"null",_tarr];
			// };
			if equals(_tarr,"int") exitWith {
				if (not_equalTypes(_value,0) || {round _value != _value}) then {
					_output = format["Property '%1' wrong type '%2', Expected int",_keyName,tolower typename _value];
				}
			};
			if not_equalTypes(_value,_tarr) then {
				_output = format["Property '%1' wrong type '%2', Expected %3",_keyName,tolower typename _value,tolower typename _tarr];
			};
		};
	}; 
	//["postreturn value and output"] call logInfo;
	//traceformat("=======OUTPUT: %1",_value)
	if isNullVar(_value) then {
		[null,_output]
	} else {
		[_value,_output]
	};
};

csys_internal_loadCfgSegment = {
	params ["_data"];
	if (_data getOrDefault ["ignored",false]) exitWith {
		traceformat("IGNORE: config %1 in %2",csys_internal_configNumber arg csys_internal_lastLoadedFile);
		true
	};
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
	private _err = false;
	private _canUseSysSpec = _sobj callv(canApplySystemSpecific);
	if (value != "") then {
		if (!_canUseSysSpec) then {
			_err = true;
			["Item %1 (%2) cannot contain system specific (required 'system_specific')",csys_internal_configNumber,csys_internal_lastLoadedFile] call csys_errorMessage;
		};
		_sobj setv(systemSpecific,value);
	} else {
		if (_canUseSysSpec) then {
			_err = true;
			["Item %1 (%2) must contain system specific (required 'system_specific')",csys_internal_configNumber,csys_internal_lastLoadedFile] call csys_errorMessage;
		};
	};
	if (_err) exitWith {false};
	

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
	GETVAL_DICT(_data, vec2("failed_handler",null));
	FAIL_CHECK_PRINT;
	if !isNullVar(value) then {
		_sobj callp(_parseFailed,value arg _ref);
	};
	if (refget(_ref)!="") exitWith {
		[refget(_ref)] call csys_errorMessage;
		false
	};

	// ----------------------- options check -----------------------
	GETVAL_DICT(_data, vec2("options",null));
	FAIL_CHECK_PRINT;
	if !isNullVar(value) then {
		_sobj callp(_parseOptions,value arg _ref);
	};
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
	private _patternKeys = "\ *[\w:]+([ \t]*\.[ \t]*\w+)*\ *";
	private _patternFormatter = "\{("+_patternKeys+")\}";
	private _match = null;
	private _kmap = null;
	private _tokens = null;
	private _argName = null;

	while {[_str,_patternFormatter] call regex_isMatch} do {
		_match = [_str,_patternFormatter] call regex_getFirstMatch;
		_kmap = [_match,_patternKeys] call regex_getFirstMatch;
		_tokens = _kmap splitString " ."; //tokenlist a.b.c.d
		_argName = _tokens deleteAt 0; //first part
		if (_argName in _argsmap) then {
			private _val = _argsmap get _argName; //is value
			assert(!isNullVar(_val));
			//pass of all func tokens b.c.d
			{
				_val = _val call (csys_map_tokenMap getOrDefault [_x,csys_defaultTokenCode]);
			} foreach _tokens;			
			_str = [_str,_match,_val] call stringReplace;
		};
	};

	_str
};

csys_formatSelector = {
	params ["_val"];
	private _patternSelector = "\([^()]*\)";
	private _patternElements = "[^\(\)\|]+";
	private _match = null;
	private _elements = null;
	while {[_val,_patternSelector] call regex_isMatch} do {
		_match = [_val,_patternSelector] call regex_getFirstMatch;
		_elements = [_match,_patternElements] call regex_getMatches;
		if (count _elements > 0) then {
			_val = [_val,_match,pick _elements] call stringReplace;
		};
	};
	_val
};

csys_map_tokenMap = createHashMapFromArray [
	["lower",{lowerize(_this)}],
	["upper",{capitalize(_this)}]
];

csys_defaultTokenCode = { _this };

//генериурет ранжированный список на основе входной строки: "item(1-5)" -> ["item1","item2","item3","item4","item5"]
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
	генератор кода из yaml строки
	if (tagged:instructions()) then {
	  	tagged:doaction()
	}
*/
csys_internal_generateYamlExpr = {
	params ["_instr"];
	private _lines = _instr splitString endl;
	private _stack = ["scopename 'YAMLEXPR'; "];
	private _pat_metcall = "(\w+):(\w+)\s*\(([^)]+)\)";
	private _pat_met = "(\w+):(\w+)\s*\(\s*\)";
	private _pat_field = "(\w+):(\w+)";
	private _pat_return = "\s*(return)\s*;?";
	private _pat_delete = "\s*(delete)\s*\(([^)]+)\)";
	private _pat_tags = "\b(tags)\b";
	private _pat_vardef = "\b(var)\b";
	private _pat_endl = "[)}\w]\s*$";
	private _pat_istypeof = "isTypeOf\(([^,]+)\,([^)]+)\)";
	{
		private _curLine = _x;
		_curLine = ([_curLine,_pat_metcall,'callFuncParams(_tags get "$1",$2,$3)'] call regex_replace);
		
		_curLine = ([_curLine,_pat_met,'callFunc(_tags get "$1",$2)'] call regex_replace);
	
		_curLine = ([_curLine,_pat_field,'getVar(_tags get "$1",$2)'] call regex_replace);
	
		_curLine = ([_curLine,_pat_return,"(0) breakout 'main'"] call regex_replace);

		_curLine = ([_curLine,_pat_delete,'delete(_tags get "$2")'] call regex_replace);
		
		_curLine = ([_curLine,_pat_tags,"_tags"] call regex_replace);
		_curLine = ([_curLine,_pat_vardef,"private"] call regex_replace);

		_curLine = ([_curLine,_pat_istypeof,'isTypeOf($1,$2)'] call regex_replace);

		_stack pushBack _curLine;
		
		if ([_curLine,_pat_endl] call regex_isMatch) then {
			_stack pushBack ";";
		};
	} foreach _lines;

	private _CODEINSTR_ = null;
	private _code = "_CODEINSTR_ = {" + (_stack joinString endl) + "};";
	#ifdef EDITOR
	debug_compiler_csys_lastInstructions = [_code,_stack];
	#endif
	isNIL (compile _code);
	_CODEINSTR_
};

/* 
	Генератор кода условия
	Правила:
		все \w+ являются полями объекта
		все \w+\s*\(.*\) являются вызываемыми функциями. Функции могут быть pure-only и не должны иметь параметров
*/
csys_generateInsturctions = {
	params ["_condition"];

	private _pat_methodArgs = ":(\w+)\s*\(([^)]+)\)";
	private _pat_method = ":(\w+)\s*\(\s*\)";
	private _pat_field = ":(\w+)\b";
	private _pat_istypeof = "isTypeOf\(([^,]+)\,([^)]+)\)";

	//replace parametrize methods
	_condition = [_condition,_pat_istypeof,'isTypeOf($1,$2)'] call regex_replace;
	_condition = [_condition,_pat_methodArgs,'callFuncParams(this,$1,$2)'] call regex_replace;
	_condition = [_condition,_pat_method,'callFunc(this,$1)'] call regex_replace;
	_condition = [_condition,_pat_field,'getVar(this,$1)'] call regex_replace;

	private _CODE_INSTR_ = null;
	_condition = ["_CODE_INSTR_ = {params["""+'this'+"""];",_condition,"}; true"] joinString " ";
	isNIL (compile _condition);

	_CODE_INSTR_
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

//obsolete constants
csys_const_regexFunc = "(\w+)\s*\(\)";
csys_const_regexField = "\w+";
csys_const_regexOP = "==|!=|<=|>=|\|\||&&|>|<";
csys_const_alllowRegex = (csys_const_regexFunc+"|"+csys_const_regexField+"|"+csys_const_regexOP);



csys_list_systemControllers = []; //SystemControllerCrafts  системы зарегистрированы здесь
csys_map_systemControllersIndexes = createhashMap; //k<int>, v<SystemControllerCrafts>

//get or register craft system controller (SystemControllerCrafts)
csys_getSystemController = {
	params ["_sysname"];
	if (_sysname in csys_map_systemControllersIndexes) then {
		private _index = csys_map_systemControllersIndexes get _sysname;
		csys_list_systemControllers select _index
	} else {
		private _sysObj = struct_newp(SystemControllerCrafts,_sysname);
		private _indSys = csys_list_systemControllers pushBack _sysObj;
		csys_map_systemControllersIndexes set [_sysname,_indSys];
		_sysObj
	};
};

csys_systemController_handleUpdate = -1;
csys_systemController_onUpdate = {
	{
		_x callv(update);
		false
	} count (csys_list_systemControllers);
};

#ifdef EDITOR
csys_internal_generateSchema = {
	private _types = ["CraftModifierAbstract"] call struct_getAllTypesOf;
	private _headSegment = ["// place part 1 here"];
	private _modNames = [];
	private _dictSegment = ["// here placed dict of modifiers"];
	private _allOfList = createHashMapFromArray[["allOf",[]]];
	{
		private _obj = [_x,["GETMODINFO"]] call struct_alloc;
		_modNames pushBack (_obj getv(name__));

		(_allOfList get "allOf") pushBack (_obj callv(getModifierDict));
	} foreach _types;

	_dictEnum = toJson(createHashMapFromArray[["enum",_modNames]]);
	_dictEnum = _dictEnum select [1];
	_dictEnum = _dictEnum select [0,count _dictEnum-1];
	_headSegment pushBack (_dictEnum);

	_dct = (toJson(_allOfList));
	_dct = _dct select [1];
	_dct = _dct select [0,count _dct-1];
	_dictSegment pushBack _dct;

	//return
	private _r = (_headSegment joinString endl)+endl+endl+endl + ([_dictSegment joinString endl,"\\n","\n"] call stringReplace);
	copytoclipboard _r;
	text _r
};

#endif