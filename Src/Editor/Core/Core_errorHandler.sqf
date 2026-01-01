// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================




scriptError_internal_handleStack = {
	params ["_fn","_line","_scope","_varmap"];
	format["-> f:%1 at %2 (scope:%3), lv: %4",_fn,_line,_scope,(keys _varmap) joinString ", "];
};
scriptErrGlobLastMessage = "";
scriptErrHndlGlobal = addMissionEventHandler ["ScriptError",
{
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
	
	if !isNullReference(findDisplay 316000) exitWith {};

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

	[_text] call printError;

	[_errorMsg,_file,_line,_stack,_offset] call relicta_debug_internal_handleError;
	
}];
