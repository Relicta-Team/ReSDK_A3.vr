// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

/*
	Code editor

	main macro:
	mem, docall, getvar, setvar, getref

	syntax:

	mem "initGen" docall; ["initGen"] call invokemember;
	mem "argInitGen", 1 ,true docall; ["argInitGen", 1, true] call invokemember
	_varname = mem "testField" getvar;
	mem "testField", _varname + 1 setvar;
	mem "refname" getref

*/
init_function(golib_code_initializer)
{
	golib_code_deprecatedWarnVisible = false;
}
function(golib_code_open)
{
	params ["_curInstructions","_contextObject"];

	private _hash = [_contextObject,false] call golib_getHashData;
	if (count _hash == 0) exitWith {
		["Cannot unpack hash data for object %1",_contextObject] call printError;
	};

	golib_code_contextObject = _contextObject;
	golib_code_contextHash = _hash;

	private _d = [[],[]] call displayOpen;
	_d displayAddEventHandler ["KeyUp",{
		params ["_d","_key"];
		_input = _d getvariable "_input";
		if (_key == KEY_F6) exitWith {
			[ctrlText _input] call golib_parseCode;
		};
	}];


	private _ctg = [_d,WIDGETGROUP,WIDGET_FULLSIZE] call createWidget;

	private _back = [_d,BACKGROUND,WIDGET_FULLSIZE,_ctg] call createWidget;
	_back setBackgroundColor [0.3,0.3,0.3,1];

	
	private _buttonClose = [_d,BUTTON,[0,96,100,4],_ctg] call createWidget;
	_buttonClose ctrlSetText "Закрыть";
	_buttonClose setvariable ["_d",_d];
	_buttonClose ctrlAddEventHandler ["MouseButtonUp",{
		params ["_w"];
		_d = _w getvariable "_d";
		_input = _d getvariable "_input";

		if equals(ctrlText _input,_input getvariable "_baseText") exitWith {
			nextFrameParams(golib_code_close,[false])
		};

		[ 
			"Вы уверены? Несохраненный прогресс будет утерян", 
			"Закрытие редактора", 
				[ 
					"Закрыть", 
					{ 
						nextFrameParams(golib_code_close,[false])
					} 
				], 
				[ 
					"Отмена", 
					{} 
				], 
			"\A3\ui_f\data\map\markers\handdrawn\warning_CA.paa", 
			_d
		] call createMessageBox;
	}];

	private _input = [_d,INPUTMULTIV2,[0,10,70,100-4-10],_ctg] call createWidget;
	_d setvariable ["_input",_input];
	_input ctrlsettext (golib_code_contextHash getOrDefault ["code_onInit",""]);
	_input setvariable ["_baseText",ctrlText _input];

	private _memberList = [];
	{
		_memberList pushBack (format["m:%1",_x]);
	} foreach ((golib_code_contextHash get "class") call oop_reflect_getAllFields);

	{
		_memberList pushBack (format["f:%1()",_x]);
	} foreach ((golib_code_contextHash get "class") call oop_reflect_getAllMethods);

	_memberList sort true;

	private _list = [_d,LISTBOX,[70,10,30,100-4-10],_ctg] call createWidget;
	{
		_item = _list lbAdd _x;
	} foreach _memberList;
	copy = _memberList;

	private _parse = [_d,BUTTON,[0,2,10,6],_ctg] call createWidget;
	_parse ctrlSetText "CHECK";
	_parse setvariable ["_input",_input];
	_parse setBackgroundColor [0,0.3,1,1];
	_parse ctrlSetTooltip "Нажмите, чтобы провести валидацию инструкций";
	_parse ctrlAddEventHandler ["MouseButtonUp",{
		params ["_b"];
		_input = _b getVariable "_input";
		[ctrlText _input] call golib_parseCode;
	}];

	_save = [_d,BUTTON,[10,2,10,6],_ctg] call createWidget;
	_save setvariable ["_input",_input];
	_save ctrlSetText "SAVE";
	_save ctrlSetTooltip "Сохраняет и закрывает редактор";
	_save setBackgroundColor [0,0.9,0.05,1];
	_save ctrlAddEventHandler ["MouseButtonUp",{
		params ["_b"];
		_input = _b getVariable "_input";
		_txt = ctrlText _input;
		if ([_txt,true] call golib_parseCode) then {
			golib_code_contextHash set ["code_onInit",_txt];
			
			nextFrameParams(golib_code_close,[true])
		};
	}];

};


function(golib_code_close)
{
	params ["_isSave"];
	if (_isSave) then {
		_t = golib_code_contextHash get "code_onInit";
		if !([_t,"[^ 	\n]"] call regex_isMatch) then {
			golib_code_contextHash deleteat "code_onInit";
		};
		[golib_code_contextObject,golib_code_contextHash] call golib_setHashData;

		//reload inspector
		if (golib_code_contextObject in (call golib_getSelectedObjects)) then {
			[null] call inspector_menuLoad;
		};
	};

	call displayClose;
}

function(golib_code_prepareInstructions)
{
	params ["_codeStr",["_doLogs",true]];

	if !([_codeStr,_doLogs] call golib_parseCode) exitWith {
		_codeStr = "!ERROR!";
		_codeStr
	};

	_codeStr = [_codeStr,"\bmem\b",		"([_o,"] call regex_replace;
	_codeStr = [_codeStr,"\bmem_f\b",	"([_o,"] call regex_replace;
	_codeStr = [_codeStr,"\bmem_s\b",	"([_o,"] call regex_replace;
	_codeStr = [_codeStr,"\bmem_o\b",	"([_o,"] call regex_replace;
	_codeStr = [_codeStr,"\bdocall\b",	"] call reditor_binding_fc)"] call regex_replace;
	_codeStr = [_codeStr,"\bgetvar\b",	"] call reditor_binding_gv)"] call regex_replace;
	_codeStr = [_codeStr,"\bsetvar\b",	"] call reditor_binding_sv)"] call regex_replace;
	_codeStr = [_codeStr,"\bgetref\b","] call reditor_binding_gref)"] call regex_replace;

	_codeStr
}

function(golib_getCodeCallers)
{
	
	"reditor_binding_fc = {" + toString {
		private _o = _this deleteAt 0;
		private _m = _this deleteAt 0;
		if (count _this == 0) then {
			callFuncReflect(_o,_m)
		} else {
			callFuncReflectParamsInline(_o,_m,_this)
		};
	} + "};
	reditor_binding_gv = {" + toString {
		private _o = _this deleteAt 0;
		private _m = _this deleteAt 0;
		getVarReflect(_o,_m)
	} + "};
	reditor_binding_sv = {" + toString {
		private _o = _this deleteAt 0;
		private _m = _this deleteAt 0;
		setVarReflect(_o,_m,_this)
	} + "};
	reditor_binding_gref = {" + toString {
		private _o = _this deleteAt 0;
		private _m = _this deleteAt 0;
		go_editor_globalRefs getOrDefault [_m,nullPtr];
	} + "};";
}

function(golib_parseCode)
{
	params ["_codeStr",["_doLogs",true]];
	if (_doLogs) then {
		["Start parsing code"] call printLog;
	};

	//replace macro
	_codeStr = [_codeStr,"\bmem\b","(['void',"] call regex_replace;
	_codeStr = [_codeStr,"\bmem_f\b","(['num',"] call regex_replace;
	_codeStr = [_codeStr,"\bmem_s\b","(['str',"] call regex_replace;
	_codeStr = [_codeStr,"\bmem_o\b","(['void',"] call regex_replace;
	_codeStr = [_codeStr,"\bdocall\b","] call golib_codeCheck_docall)"] call regex_replace;
	_codeStr = [_codeStr,"\bgetvar\b","] call golib_codeCheck_getvar)"] call regex_replace;
	_codeStr = [_codeStr,"\bsetvar\b","] call golib_codeCheck_setvar)"] call regex_replace;
	_codeStr = [_codeStr,"\bgetref\b","] call golib_codeCheck_getref)"] call regex_replace;

	_codeStr = _codeStr + "; '$EXIT_SUCCESS$'";

	//[_codeStr] call printLog;

	private _abort__EXTERNAL = false;
	private _abort_context = "";
	private _exit = isNIL {call compile _codeStr};
	private _input = (call getOpenedDisplay) getvariable "_input";
	private _success = false;
	if !isNullVar(_input) then {
		if (_abort__EXTERNAL) then {
			_exit = true;
			["Parsing error - %1",_abort_context] call printError;
		};

		if (!_exit) then {
			_success = true;
			_input setBackgroundColor [0,1,0,0.3];
			invokeAfterDelayParams({_this setBackgroundColor vec4(0,0,0,0)},0.2,_input);
		} else {
			_input setBackgroundColor [1,0,0,0.3];
			invokeAfterDelayParams({_this setBackgroundColor vec4(0,0,0,0)},0.2,_input);
		};
	} else {
		_success = !_exit;
	};
	
	if (_doLogs) then {
		["Parsing success - %1",_success] call printLog;
	};

	_success
}

function(golib_codeCheck_getValByMem)
{
	private _mems = ["void","num","str","obj"];
	private _vals = [null,0,"",null];
	private _idx = _mems find _this;
	if (_idx == -1) exitWith {null};
	_vals select _idx
}

function(golib_codeCheck_setFirstError)
{
	if (!_abort__EXTERNAL) then {
		_abort__EXTERNAL = true;
		_abort_context = format[_this,format["%1 %2::%3",_mCat,golib_code_contextHash get "class",_memName]];
	};
	
}

function(golib_codeCheck_docall)
{
	if (count _this < 2) exitWith {
		private _memName = "NOT_STRING";
		private _mCat = "void";
		"Generic calling error - '%1'" call golib_codeCheck_setFirstError;
		null;
	};

	private _mCat = _this deleteAt 0;
	private _memName = _this deleteAt 0;

	if isNullVar(_memName) then {
		_memName = "NOT_STRING_METHOD";
		"Generic error - member name must be in the form of a string" call golib_codeCheck_setFirstError;
	};

	if !([golib_code_contextHash get "class",_memName] call oop_reflect_hasMethod) then {
		"Method not found - '%1'" call golib_codeCheck_setFirstError;
	};

	if ([golib_code_contextHash get "class",_memName,"InternalImpl"] call goasm_attributes_hasAttributeMethod) then {
		"Method '%1' is not an element of the public API" call golib_codeCheck_setFirstError;
	};

	_mCat call golib_codeCheck_getValByMem;
}

function(golib_codeCheck_getref)
{
	if (count _this < 2) exitWith {
		private _memName = "NOT_STRING";
		private _mCat = "void";
		"Generic calling error - '%1'" call golib_codeCheck_setFirstError;
		null;
	};

	private _mCat = _this deleteAt 0;
	private _memName = _this deleteAt 0;

	if isNullVar(_memName) then {
		_memName = "NOT_STRING_METHOD";
		"Generic error - member name must be in the form of a string" call golib_codeCheck_setFirstError;
	};

	if !(_memName in golib_internal_map_marks) then {
		"Global reference not found - '"+_memName+"'" call golib_codeCheck_setFirstError;
	};
}

function(golib_codeCheck_getvar)
{
	if (count _this < 2) exitWith {
		private _memName = "NOT_STRING";
		private _mCat = "void";
		"Generic calling error - '%1'" call golib_codeCheck_setFirstError;
		null;
	};

	private _mCat = _this deleteAt 0;
	private _memName = _this deleteAt 0;

	if isNullVar(_memName) then {
		_memName = "NOT_STRING_FIELD";
		"Generic error - member name must be in the form of a string" call golib_codeCheck_setFirstError;
	};

	if (count _this > 0) then {
		("Syntax error: '%1' -> unexpected arguments in field getter") call golib_codeCheck_setFirstError;
	};

	if !([golib_code_contextHash get "class",_memName] call oop_reflect_hasField) then {
		"Field not found - '%1'" call golib_codeCheck_setFirstError;
	};
	if ([golib_code_contextHash get "class",_memName,"InternalImpl"] call goasm_attributes_hasAttributeField) then {
		"Field '%1' is not an element of the public API" call golib_codeCheck_setFirstError;
	};

	_mCat call golib_codeCheck_getValByMem;
}

function(golib_codeCheck_setvar)
{
	if (count _this < 2) exitWith {
		private _memName = "NOT_STRING";
		private _mCat = "void";
		"Generic calling error - '%1'" call golib_codeCheck_setFirstError;
		null;
	};

	private _mCat = _this deleteAt 0;
	private _memName = _this deleteAt 0;

	if isNullVar(_memName) then {
		_memName = "NOT_STRING_FIELD";
		"Generic error - member name must be in the form of a string" call golib_codeCheck_setFirstError;
	};

	if (count _this == 0) then {
		("Syntax error: '%1' -> no value in field setter") call golib_codeCheck_setFirstError;
	};

	if !([golib_code_contextHash get "class",_memName] call oop_reflect_hasField) then {
		"Field not found - '%1'" call golib_codeCheck_setFirstError;
	};
	if ([golib_code_contextHash get "class",_memName,"ReadOnly"] call goasm_attributes_hasAttributeField) then {
		"Field '%1' is readonly" call golib_codeCheck_setFirstError;
	};
	if ([golib_code_contextHash get "class",_memName,"InternalImpl"] call goasm_attributes_hasAttributeField) then {
		"Field '%1' is not an element of the public API" call golib_codeCheck_setFirstError;
	};

	_mCat call golib_codeCheck_getValByMem;
}