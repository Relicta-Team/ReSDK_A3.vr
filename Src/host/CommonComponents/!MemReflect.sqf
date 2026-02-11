// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\engine.hpp>


//регистрация переменной
gv_rv = {
	params ["_name","_file","_line",["_moduleName","__undef__"]];

	//придумать как распараллелить клиент и север в режиме дебага
	//private _isHost = if ("src\host" in _file) {true} else {false};

	private _modulesMap = global_modules;

	if (_moduleName == "__undef__") exitWith {
		errorformat("Critical error -> <null>::%1 (%2 on %3): Name of module is undefined.",_name arg _file arg _line);
		appExit(APPEXIT_REASON_UNDEFINEDMODULE);
	};

	_modules = _modulesMap get _moduleName;
	if isNullVar(_modules) then {
		_modules = createHashMap;
		_modulesMap set [_moduleName,_modules];
	};

	if (_name in _modules) exitWith {
		errorformat("Critical error -> %2::%1 (%3 on %4): Variable already defined.",_name arg _moduleName arg _file arg _line);
		appExit(APPEXIT_REASON_DOUBLEDEF);
	};

	_modules set [_name,[_file,_line]];

	logformat("Registered variable %2::%1",_name arg _moduleName);

};

//регистрация функции
gv_rf = {
	params ["_name","_file","_line",["_moduleName","__undef__"]];

	private _modulesMap = global_modules;

	if (_moduleName == "__undef__") exitWith {
		errorformat("Critical error -> <null>::%1 (%2 on %3): Name of module is undefined.",_name arg _file arg _line);
		appExit(APPEXIT_REASON_UNDEFINEDMODULE);
	};

	_modules = _modulesMap get _moduleName;
	if isNullVar(_modules) then {
		_modules = createHashMap;
		_modulesMap set [_moduleName,_modules];
	};

	if (_name in _modules) exitWith {
		errorformat("Critical error -> %2::%1 (%3 on %4): Function already defined.",_name arg _moduleName arg _file arg _line);
		appExit(APPEXIT_REASON_DOUBLEDEF);
	};

	_modules set [_name,[_file,_line]];

	logformat("Registered function %2::%1",_name arg _moduleName);
};


global_modules = createHashMap;


/*
	memory management

	debug
		decl
			function(globalscope::somefunction) {
				//params inlining into code
			}
		runtime
			[]call (globalscope::somefunction) //mem getOrDefault ["globalscope::somefunction",{'globalscope::somefunction'call undef_func}];

	release
		decl
			... same as debug also create pointer
		runtime
			stdcall(f,args) [#f,args] call std_call
			fastcall(f,args) args call f



*/
