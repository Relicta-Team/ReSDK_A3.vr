// ======================================================
// Copyright (c) 2017-2025 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

/*
	Регистрирует привязку сигнала на native функцию из библиотеки (плагина)
	Создает обертку для опционального вызова native функции, если RVEngine загружен
*/
rve_nativeFunc = {
	params ["_module", "_fname",["_condString","rve_loaded"]];
	
	private _origFuncImplStr = toString (missionNamespace getvariable [_fname,{nil}]);
	if (_origFuncImplStr == "{nil}") exitWith {
		#ifdef errorformat
			errorformat("RVEngine: function %1 from %2 is not implemented",_fname arg _module);
		#endif
		#ifdef setLastError
			setLastError(format["RVEngine: function %1 from %2 is not implemented" arg _fname arg _module]);
		#endif
		false
	};
	private _nativeFuncImplStr = format["['%1','%2',_this] call rve_signalRet",_module,_fname];
	private _scriptedName = format["%1_sqf", _fname];
	private _nativeName = format["%1_native", _fname];
	
	private _wrapperImpl = compile format["if (%1) then {%2} else {%3}",_condString,_nativeFuncImplStr,_origFuncImplStr];

	missionNamespace setvariable [_fname,_wrapperImpl];

	true
};