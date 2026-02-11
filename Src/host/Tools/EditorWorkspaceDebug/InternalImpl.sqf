// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\engine.hpp>
#include <..\..\oop.hpp>
#include <..\..\GameObjects\GameConstants.hpp>

//режим глубокой отладки. При изменении нужно перезапустить симуляцию.
#define DEEP_DEBUG_MODE

/* *********************************************************
	Section: Reflection types
********************************************************* */
#ifdef DEEP_DEBUG_MODE
	if (!is3DEN) then {
		//first initialize
		if isNull(relicta_debug_internal_nativeData) then {
			relicta_debug_internal_nativeData = hashSet_create((allVariables missionnamespace) apply {tolower _x});
		};

		relicta_debug_internal_postCompileProcess = {
			{
				if !(_x in relicta_debug_internal_nativeData) then {
					_data = missionNamespace getvariable _x;
					if equalTypes(_data,{}) then {
						if (isFinal _data) exitWith {};
						missionNamespace setvariable [_x,compile ((format["private ___fn___ = ""%1"";",_x splitString "_" joinString "::"])
							+ toString _data)
						];
					};
				};
			} foreach ((allVariables missionnamespace) apply {tolower _x});
		};
	};
#endif
/* *********************************************************
	Section: Performing the entry point function
********************************************************* */
relicta_debug_internal_isEntryPointInitialized = false;

relicta_debug_internal_invokeEntryPoint = {
	params ["_usr","_role"];
	if (relicta_debug_internal_isEntryPointInitialized) exitWith {};
	relicta_debug_internal_isEntryPointInitialized = true;
	[_usr,_role] call relicta_debug_main;
};

relicta_debug_clearUserInventory = {
	params ["_usr"];
	assert(equalTypes(_usr,nullPtr));
	assert(isTypeOf(_usr,Mob));

	{
		private _item = callFuncParams(_usr,getItemInSlotRedirect,_x);
		if isNullReference(_item) then {continue};
		if !isTypeOf(_item,Item) then {continue};
		delete(_item);
	} foreach INV_LIST_ALL;
};

/* *********************************************************
	Section: System message box
********************************************************* */
messageBox = {
	private _d = _this;
	if not_equalTypes(_d,[]) then {_d = [_d]};
	["Breakpoint","Relicta Message Box",[format _d,""],true] call rescript_callCommand
};

messageBox_Node = {
	params ["_mes",["_opt",[]]];
	if not_equalTypes(_opt,[]) then {_opt = [_opt]};
	([_mes] + _opt) call messageBox
};

messageBoxRet = {
	private _d = _this;
	if not_equalTypes(_d,[]) then {_d = [_d]};
	(["Breakpoint","Relicta Message Box",[format _d,"CUSTOM"],true] call rescript_callCommand) == "True";
};

/* *********************************************************
	Section: Script error handler
********************************************************* */
#define TAB__ (toString [9])

relicta_debug_onPostErrorHandle = {};

relicta_debug_internal_isHandledError = false;

relicta_debug_internal_canShowStackVariables = false;

relicta_debug_internal_lastErrorName = "";
relicta_debug_internal_lastStackTrace = [];
relicta_debug_internal_lastErrorFileLine = null;

relicta_debug_internal_handleError = {
	params ["_errorMsg","_file","_line","_stack","_offset"];
	
	if (relicta_debug_internal_isHandledError) exitWith {};
	relicta_debug_internal_isHandledError = true;
	
	if (relicta_debug_internal_lastErrorName!="") then {
		_errorMsg = relicta_debug_internal_lastErrorName;
		if !isNull(relicta_debug_internal_lastErrorFileLine) then {
			_file = relicta_debug_internal_lastErrorFileLine select 0;
			_line = relicta_debug_internal_lastErrorFileLine select 1;
		};
	};

	private _f__ = "";
	private _l__ = _line;

	if ("\" in _file) then {
		_f__ = _file;
		_file = SHORT_PATH_CUSTOM(_file);
	} else {
		if (_file == "") then {
			_file = "<RUNTIME_CODE>";
			if (count _stack > 0 && {"___fd___" in (_stack select 0 select 3)}) then {
				(((_stack select 0 select 3) get "___fd___") splitString "?") params [["_lf","unknown_file"],["_ll",1]];
				_file = _lf;
				_f__ = _lf;
				_line = format["%1 in function %2",_ll,((_stack select 0 select 3) get "___fn___")];
				_l__ = _ll;
			};
		};
	};

	private _stackStr = (_stack apply {_x call relicta_debug_internal_serializeStackTrace}) joinString endl;

	private _codeType = ifcheck(projectEditor_isCompileProcess,"Compilation","Runtime");
	#ifdef RBUILDER
	_codeType = "RBuilder";
	#endif
	private _text = format["%1 error: %2"+endl+"file: %3 at line %4;"+endl+endl+endl+"Stacktrace:" + endl +"%5",_codeType,
		_errorMsg,
		_file,
		_line,
		_stackStr
	];
	
	["Breakpoint","Relicta " + tolower _codeType + " error",[_text,_f__,_l__,_offset],true] call rescript_callCommand;
	call relicta_debug_onPostErrorHandle;
};

relicta_debug_internal_serializeStackTrace = {
	params ["_fn","_line","_scope","_varmap"];
	if ("\" in _fn) then {
		_fn = SHORT_PATH_CUSTOM(_fn);
	};

	if (_fn == "") then {
		_fn = "anon";
		if ("___fd___" in _varmap) then {
			((_varmap get "___fd___") splitString "?")params["_f","_l"];
			_fn = _f;
			_line = _l;
			_varmap deleteat "___fd___";
		};
	};

	if (_scope != "" && !is3DEN) then {
		_scope = format["::(scope:%1)",_scope];
	} else {
		if ("___fn___" in _varmap) then {
			_scope = format["->%1",_varmap get "___fn___"];
			_varmap deleteat "___fn___";
		};
	};

	private _varmapStr = if (count _varmap == 0 || !relicta_debug_internal_canShowStackVariables) then {""} else {
		" (LV:" + (
			(keys _varmap) joinString "; "
		)+")"
	};

	format["  f:%1(%2)%3;%4",_fn,_line,_scope,_varmapStr];
};


//used on halt system call
relicta_debug_setlasterror = {
	params ["_name"];

	relicta_debug_internal_lastErrorName = _name;
	relicta_debug_internal_lastStackTrace = diag_stackTrace;
};

relicta_debug_internal_testErrorInternal = {
	_a = {
		call compile "a = a = a";
	};
	call _a;
};

relicta_debug_internal_testError = {
	invokeAfterDelay(relicta_debug_internal_testErrorInternal,1.2);
};

