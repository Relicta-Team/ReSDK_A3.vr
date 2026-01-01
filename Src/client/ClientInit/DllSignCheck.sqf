// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\host\lang.hpp>

#include "_allowed_extensions.h"
private _signDLLError = false;
private _signDLLErrorMessage = "";

if (isMultiplayer) then {
	private _extMap = createHashMapFromArray CLIENTSIDE_LIST_ALLOWED_EXTENSIONS;
	{
		private _ext = _x get "name";
		if (_ext in _extMap) then {
			if not_equals(_extMap get _ext,_x get "hash") then {
				_signDLLError = true;
				_signDLLErrorMessage = format["Library %1 wrong hash",_ext];
				break;
			} else {
				logformat("Validated %1",_ext);
			};
		} else {
			_signDLLError = true;
			_signDLLErrorMessage = format["Library %1 not allowed",_ext];
			break;
		};
	} foreach allExtensions;
};

if (_signDLLError) exitWith {
	errorformat("DLL validation error: %1",_signDLLErrorMessage);
	rpcCall("clientDisconnect",vec2("Вы были отключены от сервера","Нарушена целостность содержимого мода (не найдена или изменена DLL). Обновите мод."));
    endMission "LOSER";
};
