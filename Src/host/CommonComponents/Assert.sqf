// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================


#include <..\engine.hpp>

sys_int_evalassert = {
	params ["_value"];
	
	if isNullVar(_value) exitwith {false}; //
	if equalTypes(_value,true) then {
		_value
	} else {
		if equalTypes(_value,0) exitWith {_value > 0};
		if isReference(_value) exitWith {!isNullReference(_value)};
		true // is any other case this is false (0)
	};
};

sys_static_assert_ = {
	params [["_expr","NO_EXPR"],["_module","UNK_MODULE"],["_line",0],["_message",""]];
	
	private _syslogprefix__ = "&SYSTEMLOG ";
	
	#ifdef EDITOR
	
		if (!projectEditor_isCompileProcess) exitwith {
			setLastError("Static assert cannot be used in runtime code: " + _module + " at line " + str _line);
		};

		if (_message != "") then {_message = " - " + _message};
		relicta_debug_internal_lastErrorFileLine = [_module,_line];
		private _fullmessage = format["Static assertion failed '%1'%2",_expr,_message];
		if ("src\client" in _module && projectEditor_isCompileProcess) then {
			nextFrameParams({setLastError(_this)},_fullmessage);
		} else {
			setLastError(_fullmessage);
		};

	#else
		
		if (_message != "") then {_message = " - " + _message};
		private _fullmessage = format["Static assertion failed '%1'%2 [%3 at line %4]",_expr,_message,_module,_line];

		if (isServer) then {
			
			//forward decl print functions
			if isNull(cprintErr) then {
				call compile preprocessFile "src\host\CommonComponents\!PreInit.sqf";
			};
			error(_fullmessage);

			if isNull(discError) then {
				call compile preprocessFile "src\host\Discord\Discord.sqf";
			};
			[__ASSERT_WEBHOOK_PREFIX__ + _fullmessage] call discError;
			if !isNull(logCritical) then {
				[_fullmessage] call logCritical;
			};
			appExit(APPEXIT_REASON_COMPILATIOEXCEPTION);
		} else {
			[_fullmessage] call client_sendNotifToServer;
		};

	#endif
};

sys_assert_ = {
	params [["_expr","NO_EXPR"],["_module","UNK_MODULE"],["_line",0],["_message",""]];

	#ifdef EDITOR

		if (projectEditor_isCompileProcess) exitwith {
			setLastError("Assert cannot be used in compile time: " + _module + " at line " + str _line);
		};

		if (_message != "") then {_message = " - " + _message};
		relicta_debug_internal_lastErrorFileLine = [_module,_line];
		private _fullmessage = format["Assertion failed '%1'%2",_expr,_message];
		if ("src\client" in _module && projectEditor_isCompileProcess) then {
			nextFrameParams({setLastError(_this)},_fullmessage);
		} else {
			setLastError(_fullmessage);
		};
	
	#else
		if (_message != "") then {_message = " - " + _message};
		private _fullmessage = format["Assertion failed '%1'%2 [%3 at line %4]",_expr,_message,_module,_line];

		if (isServer) then {
			

			//forward decl print functions
			if isNull(cprintErr) then {
				call compile preprocessFile "src\host\CommonComponents\!PreInit.sqf";
			};
			error(_fullmessage);

			if isNull(discError) then {
				call compile preprocessFile "src\host\Discord\Discord.sqf";
			};
			[__ASSERT_WEBHOOK_PREFIX__ + _fullmessage] call discError;
			if !isNull(logCritical) then {
				[_fullmessage] call logCritical;
			};
			//ub, but can work..
			//appExit(APPEXIT_REASON_ASSERTION_FAIL);
		} else {
			[_fullmessage] call client_sendNotifToServer;
		};
	#endif
};

