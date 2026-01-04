// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================



//переключение контекстов
function(Core_pushContext)
{
	private __thisContext___ = call Core_setContext;
	core_internal_contextStack pushBack __thisContext___;
	["Push new context. Now count %1", count core_internal_contextStack] call printTrace;
}

function(Core_popContext)
{
	private _ctxStack = core_internal_contextStack;
	if (count _ctxStack == 0) exitWith {
		["%1 - Context empty",__FUNC__] call printTrace;
	};
	_ctxStack deleteAt (count _ctxStack - 1);
	if (count _ctxStack == 0) exitWith {
		["%1 - Context empty after pop context",__FUNC__] call printTrace;
	};
	core_internal_contextData =  _ctxStack select (count _ctxStack - 1);
	
	["Pop upper context. Now count %1", count _ctxStack] call printTrace;
}

//проверка пуст ли контекст
function(Core_context_validate)
{
	params ["_nameSeg"];
	assert(count core_internal_contextStack == 0);
	if (count core_internal_contextStack > 0) exitWith {
		["%1 - Context leak in '%3': stack: %2",__FUNC__,core_internal_contextStack,_nameSeg] call printError;
	};
}

function(Core_setContext)
{
	//params ["_varStrList"];
	private _listData = createHashMap;
	private _stack = diag_stacktrace;
	private _maxIndex = (count _stack) - 1;
	{
		//["[stack level %1]: %2",_forEachIndex,_x] call printTrace;
		if (_forEachIndex >= _maxIndex) exitWith {};
		{
			_listData set [tolower _x,_y];
		} foreach (_x select 3);	
	} foreach _stack;
	
	core_internal_contextData = _listData;
	core_internal_contextData
}

function(Core_addContext)
{
	params ["_varName","_varValue"];
	core_internal_contextData set [tolower _varName,_varValue];
}

function(Core_getContextVar)
{
	private _varName = tolower _this;
	if !(_varName in core_internal_contextData) exitWith {
		["Cant get context undefined variable - %1",_varName] call printError;
		null
	};
	core_internal_contextData get _varName
}

function(Core_updateContextVar)
{
	params ["_varname","_varval"];
	private _varName = tolower _varname;
	if !(_varName in core_internal_contextData) exitWith {false};
	core_internal_contextData set [_varname,_varval];
	true
}

function(Core_callContext)
{
	if equalTypes(_this,[]) then {
		params ["_code"];
		["%1(params val) - override not supported",__FUNC__] call printError;
	} else {
		/*
		ctx = [["_a",1],["_b",<reftoobject>]];
		_listparams = [1,<reftoobject>];
		
		{
			(_this select 0) params ["_a"];
			call (_this select 1);
		}
		
		*/
		private _listvalues = [];
		private _listparams = [];
		{
			_listvalues pushBack _y;
			_listparams pushBack (str _x);
		} foreach core_internal_contextData;
		
		private _buildedCode = '__FUNC__ = "<core_internal_contextedCall>";'+"(_this select 0) params [" + 
			(_listparams joinString ",") + "]; call (_this select 1)";
		
		[_listvalues,_this] call (compile _buildedCode);
		
	}
}

function(Core_debugContext)
{
	["Context data: %1",core_internal_contextData] call printTrace;
}

variable_define
	core_debug_const_internal_nsNames = ["misNS","uiNS","parsNS","locNS","profNS"];
	core_debug_const_internal_allNamespaces = [missionNamespace,uiNamespace,parsingNamespace,localNamespace,profileNamespace];

function(Core_debug_dumpAllVariables)
{
	core_internal_debug_varmap = createHashMap;
	_allObjs = array_copy(core_debug_const_internal_allNamespaces);

	{
		_allObjs pushBack _x;
		{
			_allObjs pushBack _x;
		} foreach (allControls _x);
	} foreach (allDisplays);

	{
		_data = [];
		_ns = _x;
		_nsStrIdx = _foreachIndex;
		_nsName = if (_nsStrIdx >= count core_debug_const_internal_allNamespaces) then {
			(str _ns) + ifcheck(equalTypes(_ns,displayNull),str (ctrlIDD _ns),(str (ctrlPosition _ns))+str(ctrlIdc _ns)+"+"+str(ctrlClassName _ns));
		} else {
			core_debug_const_internal_nsNames select _nsStrIdx
		};
		core_internal_debug_varmap set [
			_nsName,
			_data
		];
		{
			if (
				_x == "core_internal_debug_varmap"
				|| _x == "rscdebugconsole_expression"
			) then {continue};

			_value = _ns getvariable _x;
			if (!isNullVar(_value) && not_equalTypes(_value,{})) then {
				_data pushBack [_x,_value];
			};
		} foreach (allVariables _x);
	} foreach _allObjs;
	["Done"] call showInfo;
}

function(Core_debug_printChangedVariables)
{
	_changed = [];
	_allObjs = array_copy(core_debug_const_internal_allNamespaces);

	{
		_allObjs pushBack _x;
		{
			_allObjs pushBack _x;
		} foreach (allControls _x);
	} foreach (allDisplays);

	{
		_ns = _x;
		_nsStrIdx = _foreachIndex;
		//_nsName = core_debug_const_internal_nsNames select _foreachIndex;
		_nsName = if (_nsStrIdx >= count core_debug_const_internal_allNamespaces) then {
			(str _ns) + ifcheck(equalTypes(_ns,displayNull),str (ctrlIDD _ns),(str (ctrlPosition _ns))+str(ctrlIdc _ns)+"+"+str(ctrlClassName _ns));
		} else {
			core_debug_const_internal_nsNames select _nsStrIdx
		};
		_allVarsDump = (core_internal_debug_varmap get _nsName);
		{
			_varname = _x;
			if (
				_varname == "core_internal_debug_varmap"
				|| _x == "rscdebugconsole_expression"
			) then {continue};

			_value = _ns getvariable _varname;
			if (!isNullVar(_value) && not_equalTypes(_value,{})) then {
				_existsIdx = _allVarsDump findif {_x select 0 == _varname};
				if (_existsIdx == -1) then {
					_changed pushBack (format["[%1] Added %2 with %3",_nsName,_x,_value]);
				} else {
					_newvalue = _allVarsDump select _existsIdx select 1;
					if not_equals(_value,_newvalue) then {
						_changed pushBack (format["[%1] Updated %2 with %3 (old:%4)",_nsName,_x,_newvalue,_value]);
					};
				};

			};
		} foreach (allVariables _ns);
	} foreach _allObjs;

	if (count _changed > 0) then {
		[_changed joinString endl] call MessageBox;
	} else {
		["No changes"] call showInfo;
	}
}

