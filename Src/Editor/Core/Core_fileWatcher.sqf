// ======================================================
// Copyright (c) 2017-2023 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

//fws_changed
init_function(fileWatcher_initialie)
{
	["FileWatcher","init",[getMissionPath "Src","*.*",false]] call rescript_callCommand;

	fileWatcher_internal_lastTickTime = 0;
	fileWatcher_internal_lastUpdateMode = 0;
	fileWatcher_internal_lastEvent = []; //editor, host
}

function(FileWatcher_handleCallbackExtension)
{
	( _this) params ["_path","_func","_args"];
	if equals(_this,fileWatcher_internal_lastEvent) exitwith {
		//double shot
	};
	fileWatcher_internal_lastEvent = _this;

	private _lowerPath = toLower _path;

	["callback fws: %1",_this] call printTrace;
}


