// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include "..\engine.hpp"
#include "..\oop.hpp"
#include <..\PointerSystem\pointers.hpp>
#include <..\Networking\Network.hpp>
#include "ObjectManager.sqf"
#include "DynamicMapLoader.sqf"

mapmanager_minMapVersion = 5;

mapmanager_savemap = {

	_buffer = '[';
	_isFirst = true;
	{
		if (not ((tolower (typeof _x)) in ["cba_namespacedummy","logic","b_survivor_f",""])) then {
			_model = (getModelInfo _x) select 1;
			_pos = getposatl _x;
			_vecdir = vectorDir _x;
			_vecup = vectorUp _x;

			if (_isFirst) then
			{
				_isFirst = false;

				_buffer = _buffer + endl + "[";
			} else {
				_buffer = _buffer + endl + ",[";
			};

			_buffer = _buffer + format["'%1',%2,%3,%4]",_model,_pos,_vecdir,_vecup];
		};
	} foreach (allMissionObjects "");

	_buffer = _buffer + endl + "]";

	copyToClipboard _buffer;
	log("Map saved!");
};

//deprecated loader
MapManager_loadmap = {
	params ["_mappath"];

	private _timing = diag_ticktime;

	private _mapdata = call compile preprocessFile _mappath;

	{
		_x params ["_model","_pos","_vecdir","_vecup"]; //todo uncommon attributes

		_obj = createMesh( [_model arg [0 arg 0 arg 0]]);
		_obj setposatl _pos;
		_obj setVectorDirAndUp [_vecdir,_vecup];

	} foreach _mapdata;

	_timing = diag_ticktime - _timing;
	logformat("Map loaded in %2 sec! - (%1)",_mappath arg _timing);
};


mapManager_collectAllGameObjects = {
	if (isMultiplayer) exitWith {
		error("mapManager::collectAllgameObject() - is not allowed in mp game");
	};

	_data = [];
	_counter = 0;
	{
		_pt = missionNamespace getVariable ("pt_" + _x);

		_inheritance_list = _pt getvariable "__inhlist";
		
		if ("gameobject" in (_inheritance_list)) then {

			this = instantiate(_x);

			_model = getSelf(model);
			if (!isNullVar(_model)) then {

				_categ = -1;
				if callSelf(isDecor) then {_categ = 0};
				if callSelf(isStruct) then {_categ = 1};
				if callSelf(isItem) then {_categ = 2};

				if (_categ != -1) then {
					INC(_counter);
					_data pushBack [_x,[_model,_categ]];
				};


			};

			//delete(this);
			deleteLocation this;

		};

	} foreach p_table_allclassnames;

	logformat("Collect %1 game objects",_counter);

	copyToClipboard str _data;

}; if (!isMultiplayer) then {
	import_godtoeden = mapManager_collectAllGameObjects;
};


//for test loading map use:
// ["Map1"] call mapManager_load; (allUnits select (allUnits findif {isPlayer _x}) setposatl [3714.46,3722.83,40.1354])
mapManager_load = {
	params ["_path"];

	private _timing = diag_ticktime;

	_fullpath = "src\host\MapManager\Maps\" + _path + ".sqf";

	if (!fileExists(_fullpath)) exitWith {
		errorformat("Cant find map '%1'",_path);
		false
	};

	private _mapContent = preprocessFileLineNumbers _fullpath;

	private _mapHeaderEnd = _mapContent find "go_editor_globalRefs";
	if (_mapHeaderEnd == -1) exitWith {
		errorformat("Cant find map header '%1'",_path);
		false
	};
	private _mapHeader = _mapContent select [0,_mapHeaderEnd];
	private __metaInfoVersion__ = -1;
	call compile _mapHeader;
	if (__metaInfoVersion__ == -1) exitWith {
		errorformat("Cant resolve map version '%1'",_path);
		false
	};

	if (__metaInfoVersion__ < mapmanager_minMapVersion) exitWith {
		errorformat("Cant load obsoleted version '%2' for map '%1'; Required version '%3' or higher",_path arg __metaInfoVersion__ arg mapmanager_minMapVersion);
		false
	};

	call compile _mapContent;

	_timing = diag_ticktime - _timing;

	logformat("Map segment loaded in %2 sec! - (%1)",_path arg _timing);

	//[format["Мир сотворился за %1 сек",_timing]] call cm_sendLobbyMessage;

	true
};
