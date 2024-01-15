// ======================================================
// Copyright (c) 2017-2024 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================


vs_openEditor = {
	private _exepath = getMissionPath core_path_renode;


	private _result = ["VisualScripting","run",[_exepath],true] call rescript_callCommand;
	if (_result != "ok") exitwith {
		private _reason = _result;
		if (_result == "already") then {
			_reason = "Приложение уже запущено";
		};

		[format["Не удалось запустить редактор. Причина: %1",_reason],10] call showError;
	};

	["Редактор запускается...",10] call showInfo;
};