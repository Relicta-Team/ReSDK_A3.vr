// ======================================================
// Copyright (c) 2017-2023 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

//fws_changed
init_function(fileWatcher_initialie)
{
	["FileWatcher","init",[getMissionPath "Src","*.*",false]] call rescript_callCommand;

	fileWatcher_internal_lastTickTime = 0;
		fileWatcher_internal_const_updateDelay = 1;
	fileWatcher_internal_hasAnyUpdate = false;
	fileWatcher_internal_lastEvent = []; //editor, host

	["onFrame",fileWatcher_onFrame] call Core_addEventHandler;
}

function(fileWatcher_onFrame)
{
	if (!isGameFocused) exitwith {};

	if (tickTime >= fileWatcher_internal_lastTickTime) then {
		fileWatcher_internal_lastTickTime = tickTime + fileWatcher_internal_const_updateDelay;
		if (fileWatcher_internal_hasAnyUpdate) then {
			fileWatcher_internal_hasAnyUpdate = false;
			["TODO: filewatcher update"] call showInfo;
		};
	};
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
	fileWatcher_internal_hasAnyUpdate = true;
}
