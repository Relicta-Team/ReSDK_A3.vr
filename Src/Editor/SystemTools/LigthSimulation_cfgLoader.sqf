// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include "..\EditorEngine.h"
#include "..\..\host\engine.hpp"

if !(call vcom_emit_io_isConfigsLoaded) then {
	call vcom_emit_io_readConfigs;
};

//use: vcom_emit_io_enumAssocKeyStr, vcom_emit_io_enumAssocKeyInt
if !(call vcom_emit_io_isEnumConfigsLoaded) then {
	[true] call vcom_emit_io_loadEnumAssoc;
};

//fix 1
missionNamespace setVariable ["pushFront",
{
	params ["_list","_element",["_unique",false]];
	reverse _list;
	if (_unique) then {
		_list pushBackUnique _element;
	} else {
		_list pushBack _element;
	};
	reverse _list;
}
];

//for init varobjects

//light functions init
#include "..\..\client\LightEngine\ScriptedEffects.sqf"

;
//get files
private _pathPrefix = "src\client\LightEngine\ScriptedConfigs";
private _flist = [_pathPrefix,true,"*.sqf",true] call file_getFileList;
if (count _flist == 0) exitWith {
	["Light configs not found"] call showError;
};
private _commentPat = "^\/\/[^\n\r]*";
call lightSys_preInitialize;
{
	["Attempt load scripted config: %1",_x] call printTrace;

	private _content = [_pathPrefix + "\" + _x] call file_read;
	_content = [_content,_commentPat,""] call regex_replace;
	if !([_content,false] call lightSys_registerConfig) exitWith {
		["Build scripted config error on client; File: " + _x] call showError;
	};
} foreach _flist;

//load cfgs
//call le_se_initScriptedLights;
//prepare cfgs
call le_se_doSorting;