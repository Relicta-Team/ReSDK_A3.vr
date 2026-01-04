// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\engine.hpp>
#include <..\struct.hpp>
#include <..\text.hpp>

scriptError_internal_handleStack = {
	params ["_fn","_line","_scope","_varmap"];
	private _stackInfo = []; private _valInfo = null; private _cleanString = true;
	{
		_valInfo = _y;
		_cleanString = true;
		if equalTypes(_valInfo,[]) then {
			_valInfo = format ["array(%1 elements)",count _valInfo];
			_cleanString = false;
		};
		if equalTypes(_valInfo,{}) then {
			_valInfo = "<CODE>";
			_cleanString = false;
		};
		if equalTypes(_valInfo,hashMapNull) then {
			if (struct_isstruct(_valInfo)) then {
				_valInfo = format["struct(%1)",struct_typename(_valInfo)];
			} else {
				_valInfo = format["map(%1 keys)",count _valInfo];
			};
			_cleanString = false;
		};
		if equalTypes(_valInfo,"") then {
			if (count _valInfo > 255) then {
				_valInfo = _valInfo select [0,255];
			};
			if (_cleanString) then {_valInfo = str _valInfo};
		};
		_stackInfo pushBack (format["%1=%2",_x,_valInfo]);
	} foreach _varmap;
	if (_fn=="") then {_fn="unknown"};
	_fn = _varmap getorDefault ["___fn___",_fn];
	format["-> f:%1 at %2 (scope:%3), lv: %4",_fn,_line,_scope,_stackInfo joinString ", "];
};

scriptError_internal_handleStack_short = {
	params ["_fn","_line","_scope","_varmap"];
	if (_fn == "" && _scope == "") exitWith {""};
	
	private _stackInfo = null;
	_stackInfo = keys _varmap;
	format["f:%1 at %2 (scope:%3), lv: %4",[_fn,getMissionPath "",""] call stringReplace,_line,_scope,_stackInfo joinString ", "];
};

scriptErrGlobLastMessage = "";
scriptErrHndlGlobal = addMissionEventHandler ["ScriptError",
{
	#ifdef RBUILDER
	if (true) exitWith {};
	#endif
	/*
		[error text, 
		filename, 
		fileline, 
		fileoffset (character from start), 
		filecontent (the whole function/file as string), 
		stacktrace (literally output of diag_stacktrace)]
			_functionName: String - function name
			_lineNumber: Number - line number
			_scopeName: String - scope name
			_variablesHashmap: HashMap - all local variables
	*/
	params ["_errorMsg","_file","_line","_offset","_content","_stack"];
	
	#ifdef DEBUG
		if !isNullReference(findDisplay 49) exitwith {};
	#endif

	//stack reverse (deep up)
	reverse _stack;

	_text = format["SCRIPT_ERROR: %1 (file: %2 at %3); %4",
		_errorMsg,
		ifcheck(_file=="","RUNTIME_CODE",_file),
		_line,
			endl + ((_stack apply {_x call scriptError_internal_handleStack}) joinString endl)
		];
	
	scriptErrGlobLastMessage = _text;

	[_text] call cprintErr;

	if (!isNull(chatPrint)) then {
		forceUnicode 1;
		["<t color='#ff0000' size='0.9'>"+(sanitize(_text) regexReplace [endl,sbr])+"</t>","log"] call chatPrint;
	};

	if (!isNull(logError)) then {
		[_text] call logError;
	};

	if (!isNull(relicta_debug_internal_handleError)) then {
		[_errorMsg,_file,_line,_stack,_offset] call relicta_debug_internal_handleError;
	};
}];

#ifdef DEBUG
scriptError_makeError = {
	params ["_mode"];
	if (_mode == 0) exitwith {
		_var = 0 / 0;
	};
	if (_mode == 1) exitwith {
		_val = true;
		_val = _val + 3;
	};
	if (_mode == 2) exitwith {
		_de = player;
		_test = +_de;
	};
	if (_mode == 3) exitwith {
		call compile "a = a = a";
	};
	a = b + c;
};
#endif