// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

variable_define
	// global filewatcher flag enable
	fileWatcher_enableSystem = true;
	fileWatcher_list_checkedPathsForReloadRequest = [
		"\Src\host\GameObjects\"
		,"\Src\host\GameModes\"
		,"\Src\host\ReNode\compiled"
		,"\Src\Editor"
	];
	fileWatcher_list_ignoredPathParts = [
		"\GameModes\scripted_loader.hpp",
		"\Src\host\ReNode\compiled\script_list.hpp",
		"\Src\Editor\Bin\Maps",
		".txt"
	];

	fileWatcher_editorChangedPath = tolower "Src\Editor\";

//fws_changed
function(fileWatcher_initialie)
{
	fileWatcher_enableSystem = cfg_fws_enabled;

	if (!fileWatcher_enableSystem) exitwith {};

	forceUnicode 0;
	fileWatcher_list_checkedPathsForReloadRequest = fileWatcher_list_checkedPathsForReloadRequest apply {tolower _x};
	fileWatcher_list_ignoredPathParts = fileWatcher_list_ignoredPathParts apply {tolower _x};


	["FileWatcher","init",[getMissionPath "Src","*.*",false]] call rescript_callCommand;

	fileWatcher_internal_lastTickTime = 0;
		fileWatcher_internal_const_updateDelay = 1;
	fileWatcher_internal_hasAnyUpdate = false;
	fileWatcher_internal_lastEvent = []; //editor, host
	fileWatcher_internal_preparedLastEvent = [];

	["onFrame",fileWatcher_onFrame] call Core_addEventHandler;
}

function(fileWatcher_guardSafeRebuild)
{
	if (fileWatcher_internal_hasAnyUpdate) then {
		fileWatcher_internal_hasAnyUpdate = false;
	};
}

function(fileWatcher_onFrame)
{
	if (!isGameFocused) exitwith {};
	if (call isDisplayOpened) exitWith {};

	if (tickTime >= fileWatcher_internal_lastTickTime) then {
		fileWatcher_internal_lastTickTime = tickTime + fileWatcher_internal_const_updateDelay;
		if (fileWatcher_internal_hasAnyUpdate) then {
			fileWatcher_internal_hasAnyUpdate = false;

			fileWatcher_internal_preparedLastEvent params ["_lowerPath","_event"];

			if (fileWatcher_list_ignoredPathParts findif {_x in _lowerPath}!=-1) exitwith {};
			if (fileWatcher_list_checkedPathsForReloadRequest findif {_x in _lowerPath}==-1) exitwith {};

			if (_event == "Changed") then {
				[_lowerPath] call FileWatcher_onChangeFile;
			};

			//["TODO: filewatcher update"] call showInfo;
		};
	};
}

function(FileWatcher_handleCallbackExtension)
{
	//( _this) params ["_path","_func","_args"];
	if equals(_this,fileWatcher_internal_lastEvent) exitwith {
		//double shot
	};

	(parseSimpleArray (_this)) params ["_path","_mode","_strmode"];
	private _lowerPath = toLower _path;
	fileWatcher_internal_preparedLastEvent = [_lowerPath,_mode];

	["(%2) callback fws: %1",_path,_mode] call printTrace;
	fileWatcher_internal_hasAnyUpdate = true;
}

function(FileWatcher_onChangeFile)
{
	params ["_filepath"];
	
	["Perform %1",__FUNC__] call printTrace;
	private _relpath = _filepath splitString "\";
	{
		if (_x == "src") exitwith {};
		_relpath set [_foreachIndex,objnull];
	} forEach _relpath;

	_relpath = _relpath - [objnull];
	_relpath = _relpath joinString "\";

	if (fileWatcher_editorChangedPath in _relpath) exitwith {
		if (cfg_fws_autorecompEditor) exitwith {
			nextFrame({[] spawn {isnil compileEditorOnly}});
		};

		if (["Исходные файлы редактора изменены. Пересобрать? " + _relpath] call messageBoxRet) then {
			nextFrame({[] spawn {isnil compileEditorOnly}});
		};
	};

	private _mes = format["Изменен файл игровых объектов:%2%2''%1''.%2Выполнить сборку библиотеки для обновления?",_relpath,endl];

	if ([_mes] call messageBoxRet) then {
		nextFrame(goasm_builder_rebuildClasses)
	};
}
