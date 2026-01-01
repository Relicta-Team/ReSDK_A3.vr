// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================


function(vs_openEditor) 
{
	private _exepath = getMissionPath core_path_renode;
	private _cli = "";
	if !([core_path_renode_lib_json] call file_exists) then {
		_cli = "-genlib_run";
	};

	private _result = ["VisualScripting","run",[_exepath,_cli],true] call rescript_callCommand;
	if (_result != "ok") exitwith {
		private _reason = _result;
		if (_result == "already") then {
			_reason = "Приложение уже запущено";
		};

		[format["Не удалось запустить редактор. Причина: %1",_reason],10] call showError;
	};

	["Редактор запускается...",10] call showInfo;
}

function(vs_generateLib)
{
	private _rez = [core_path_renode_lib_obj] call nodegen_generateLib;
	[format["Результат сборки '%1' - %2",core_path_renode_lib_obj,_rez]] call showInfo;
}