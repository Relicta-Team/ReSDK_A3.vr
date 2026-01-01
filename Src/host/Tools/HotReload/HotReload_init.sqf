// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include "..\..\engine.hpp"
#include "..\..\oop.hpp"

fileWatcher_enableSystem = true;

fileWatcher_autoReloadObjects = true;

fileWatcher_list_checkedPathsForReloadRequest = [
	"\Src\host\GameObjects\"
	,"\Src\host\GameModes\"
	,"\Src\host\ReNode\compiled\"
];
fileWatcher_list_ignoredPathParts = [
	"\GameModes\scripted_loader.hpp",
	"\Src\host\ReNode\compiled\script_list.hpp",
	"\Src\Editor\Bin\Maps",
	".txt"
];

fileWatcher_hostChangedPath = tolower "Src\host\";
fileWatcher_clientChangedPath = tolower "Src\client";

#define printTrace fws_printTrace
fws_autorecompSources = false;

fws_printTrace = {
	private _m = (if equalTypes(_this,[]) then { \
	format _this \
	} else { \
		if not_equalTypes(_this,"") then {str _this} else {_this} \
	});
	trace(_m)
};

fileWatcher_init = {
	if (!fileWatcher_enableSystem) exitwith {};

	forceUnicode 0;
	fileWatcher_list_checkedPathsForReloadRequest = fileWatcher_list_checkedPathsForReloadRequest apply {tolower _x};
	fileWatcher_list_ignoredPathParts = fileWatcher_list_ignoredPathParts apply {tolower _x};


	["FileWatcher","init",[getMissionPath "Src","*.*",false]] call rescript_callCommand;

	fileWatcher_internal_lastTickTime = 0;
		fileWatcher_internal_const_updateDelay = 0.001;
	fileWatcher_internal_hasAnyUpdate = false;
	fileWatcher_internal_lastEvent = []; //editor, host
	fileWatcher_internal_preparedLastEvent = [];

	fileWatcher_handle_update = startUpdate(fileWatcher_onFrame,0);
};

fileWatcher_onFrame = {
	//if (!isGameFocused) exitwith {};

	if (tickTime >= fileWatcher_internal_lastTickTime) then {
		fileWatcher_internal_lastTickTime = tickTime + fileWatcher_internal_const_updateDelay;
		if (fileWatcher_internal_hasAnyUpdate) then {
			fileWatcher_internal_hasAnyUpdate = false;
			{
				_x params ["_lowerPath","_event"];

				if (fileWatcher_list_ignoredPathParts findif {_x in _lowerPath}!=-1) then {continue};
				if (fileWatcher_list_checkedPathsForReloadRequest findif {_x in _lowerPath}==-1) then {continue};

				if (_event == "Changed") then {
					[_lowerPath] call FileWatcher_onChangeFile;
				};
			} foreach fileWatcher_internal_preparedLastEvent;
			
			fileWatcher_internal_preparedLastEvent = [];
			//["TODO: filewatcher update"] call showInfo;
		};
	};
};

FileWatcher_handleCallbackExtension = {
	//( _this) params ["_path","_func","_args"];
	if equals(_this,fileWatcher_internal_lastEvent) exitwith {
		//double shot
	};

	fileWatcher_internal_lastEvent = _this;

	(parseSimpleArray (_this)) params ["_path","_mode","_strmode"];
	private _lowerPath = toLower _path;
	fileWatcher_internal_preparedLastEvent pushBack [_lowerPath,_mode];

	["(%2) callback fws: %1",_path,_mode] call printTrace;
	fileWatcher_internal_hasAnyUpdate = true;
};

FileWatcher_onChangeFile = {
	params ["_filepath"];
	
	private _relpath = _filepath splitString "\";
	

	{
		if (_x == "src") exitwith {};
		_relpath set [_foreachIndex,objnull];
	} forEach _relpath;

	_relpath = _relpath - [objnull];
	_relpath = _relpath joinString "\";

	["Perform %1 (%2)","FileWatcher_onChangeFile",_relpath] call printTrace;

	if (
		(fileWatcher_clientChangedPath in _relpath)
	) exitwith {
		_recompAct = {
			nextFrame({[]SPAWN{isNIL{call go}}});
		};

		if (fws_autorecompSources) exitwith {
			call _recompAct;
		};

		if (["Исходные файлы клиента изменены. Пересобрать? " + _relpath] call messageBoxRet) then {
			call _recompAct;
		};
	};

	if !([_relpath,".sqf"] call stringEndWith) exitWith {}; //is not a file

	if (fileWatcher_autoReloadObjects) exitwith {
		nextFrameParams(oop_reloadModule,[_relpath]);
	};

	private _mes = format["Изменен файл игровых объектов:%2%2''%1''.%2Выполнить сборку библиотеки для обновления?",_relpath,endl];
	
	if ([_mes] call messageBoxRet) then {
		[_relpath] call printTrace;
		nextFrameParams(oop_reloadModule,[_relpath]);
	};
};

call fileWatcher_init;