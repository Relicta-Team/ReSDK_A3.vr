// ======================================================
// Copyright (c) 2017-2025 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================


TFAR_fnc_activeLrRadio = {
	/*
	    Name: TFAR_fnc_activeLrRadio

	    Author(s):
	    NKey

	    Description:
	    Returns the active LR radio.

	    Parameters:
	    Nothing

	    Returns:
	    ARRAY: Active LR radio

	    Example:
	    _radio = call TFAR_fnc_activeLRRadio;
	*/
	private ["_radios", "_found"];
	_radios = TFAR_currentUnit call TFAR_fnc_lrRadiosList;
	if (isNil "TF_lr_active_radio") then {
		if (count _radios > 0) then {
			TF_lr_active_radio = _radios select 0;
		};
	} else {
		_found = false;
		{
			if (((_x select 0) == (TF_lr_active_radio select 0)) and ((_x select 1) == (TF_lr_active_radio select 1))) exitWith {_found = true};
		} count _radios;
		if !(_found) then {
			if (count _radios > 0) then {
				TF_lr_active_radio = _radios select 0;
			} else {
				TF_lr_active_radio = nil;
			};
		};
	};
	TF_lr_active_radio

};

TFAR_fnc_activeSwRadio = {
	/*
	 	Name: TFAR_fnc_activeSwRadio

	 	Author(s):
			NKey

	 	Description:
			Returns the active SW radio.

		Parameters:
			Nothing

	 	Returns:
			STRING: Active SW radio

	 	Example:
			_radio = call TFAR_fnc_activeSwRadio;
	*/
	private ["_result"];
	_result = nil;
	{
		if (_x call TFAR_fnc_isRadio) exitWith {_result = _x};
		true;
	} count (assignedItems TFAR_currentUnit);
	_result
};

TFAR_fnc_addEventHandler = {
	/*
	 	Name: TFAR_fnc_addEventHandler

	 	Author(s):
			L-H

	 	Description:
			Adds an eventhandler to the passed unit unless the unit is null then fires globally.

		Parameters:
			0: STRING - ID for custom handler
			1: STRING - ID for event
			2: CODE - Code to execute when event is fired.
			3: OBJECT - Unit to add the event to, ObjNull to add globally.

	 	Returns:
			NOTHING

	 	Example:
			["MyID", "OnSpeak", {
				_unit = _this select 0;
				_volume = _this select 1;
				hint format ["%1 is speaking %2", name _unit, _volume];
			}, player] call TFAR_fnc_addEventHandler;
	*/
	private ["_customID", "_eventID", "_code", "_unit", "_handlers", "_alreadySet"];
	_customID = _this select 0;
	_eventID = _this select 1;
	_code = _this select 2;
	_unit = _this select 3;

	if (isNull _unit) then {
		_unit = missionNamespace;
	};
	_eventID = format ["TFAR_event_%1", _eventID];
	_handlers = _unit getVariable [_eventID, []];
	_alreadySet = -1;
	{
		if (_customID == (_x select 0)) exitWith {
			_alreadySet = _foreachIndex;
			_x set [1, _code];
		};
	} foreach _handlers;
	if (_alreadySet == -1) then {
		_handlers pushBack [_customID, _code];
	};

	_unit setVariable [_eventID, _handlers];
};

TFAR_fnc_backpackLr = {
	/*
	 	Name: TFAR_fnc_backpackLR

	 	Author(s):
			NKey

	 	Description:
			Returns the backpack radio (if there is one)

		Parameters:
			0: Object: Unit

	 	Returns:
			ARRAY: Manpack or empty array

	 	Example:
			_radio = player call TFAR_fnc_backpackLR;
	*/
	private ["_result", "_backpack"];
	_result = [];
	_backpack = backpack _this;
	if (([_backpack, "tf_hasLRradio", 0] call TFAR_fnc_getConfigProperty) == 1) then {
		_result = [unitBackpack _this, "radio_settings"];
	};
	_result
};

TFAR_fnc_calcTerrainInterception = {
	/*
	 	Name: TFAR_fnc_calcTerrainInterception

	 	Author(s):
			NKey

	 	Description:
			Calculates the terrain interception between the player and the passed unit.

		Parameters:
			OBJECT - Unit to calculate terrain interception with.

	 	Returns:
			NUMBER - Terrain Interception

	 	Example:
			_interception = soldier2 call TFAR_fnc_calcTerrainInterception;
	*/
	private ["_result", "_l", "_r", "_m", "_p1", "_p2", "_middle"];

	_result = 0;
	_p1 = eyePos TFAR_currentUnit;
	_p2 = eyePos _this;

	if (terrainIntersectASL[_p1, _p2]) then {
		_l = 10.0;
		_r = 250.0;
		_m = 100.0;

		_middle = [((_p1 select 0) + (_p2 select 0)) / 2.0, ((_p1 select 1) + (_p2 select 1)) / 2.0, ((_p1 select 2) + (_p2 select 2)) / 2.0];
		_base = _middle select 2;

		while {(_r - _l) > 10} do {
			_middle set[2, _base + _m];
			if ((!terrainIntersectASL [ _p1, _middle ]) and {!terrainIntersectASL [ _p2, _middle ]}) then {
				_r = _m;
			} else {
				_l = _m;
			};
			_m = (_l + _r) / 2.0;
		};
		_result = _m;
	};
	_result
};

TFAR_fnc_canSpeak = {
	/*
	 	Name: TFAR_fnc_canSpeak

	 	Author(s):
			NKey

	 	Description:
			Tests whether it would be possible to speak at the given eye height and whether the unit is within an isolated vehicle.

		Parameters:
			0: BOOLEAN - Whether the unit is isolated and inside a vehicle.
			1: NUMBER - The eye depth.

	 	Returns:
			BOOLEAN - Whether it is possible to speak.

	 	Example:
			_canSpeak = [false, -12] call TFAR_fnc_canSpeak;
	*/
	private ["_result"];

	_result = false;

	if ((_this select 1) > 0) then {
		_result = true;
	} else {
		_result = _this select 0;
	};
	_result
};

TFAR_fnc_canUseDDRadio = {
	/*
	 	Name: TFAR_fnc_canUseDDRadio

	 	Author(s):
			NKey

	 	Description:
			Checks whether it is possible for the DD radio to be used at the current height and isolated status.

		Parameters:
			0: NUMBER - Depth
			1: BOOLEAN - Isolated and inside

	 	Returns:
			BOOLEAN

	 	Example:
			_canUseDD = [-12,true] call TFAR_fnc_canUseDDRadio;
	*/
	private ["_isolated_and_inside", "_depth"];

	_depth = _this select 0;
	_isolated_and_inside = _this select 1;

	(_depth < 0) and !(_isolated_and_inside)
};

TFAR_fnc_canUseLRRadio = {
	/*
	 	Name: TFAR_fnc_canUseLrRadio

	 	Author(s):
			NKey

	 	Description:
			Checks whether the radio would be able to be used at passed depth.

		Parameters:
			0: OBJECT - Unit
			1: BOOLEAN - Isolated and inside
			2: BOOLEAN - Can Speak
			3: NUMBER - Depth

	 	Returns:
			BOOLEAN

	 	Example:
			_canUseSW = [player, false, false, 10] call TFAR_fnc_canUseLrRadio;
	*/
	private ["_player", "_isolated_and_inside", "_result", "_depth"];

	_depth = _this select 2;
	_result = false;

	if (_depth > 0) then {
		_result = true;
	} else {
		_player = _this select 0;
		_isolated_and_inside = _this select 1;
		if ((vehicle _player != _player) and {_depth > TF_UNDERWATER_RADIO_DEPTH}) then {
			if ((_isolated_and_inside) or {isAbleToBreathe _player}) then {
				_result = true;
			};
		};
	};

	_result
};

TFAR_fnc_canUseSWRadio = {
	/*
	 	Name: TFAR_fnc_canUseSWRadio

	 	Author(s):
			NKey

	 	Description:
			Checks whether the radio would be able to be used at passed depth.

		Parameters:
			0: OBJECT - Unit
			1: BOOLEAN - Isolated and inside
			2: BOOLEAN - Can Speak
			3: NUMBER - Depth

	 	Returns:
			BOOLEAN

	 	Example:
			_canUseSW = [player, false, false, 10] call TFAR_fnc_canUseSwRadio;
	*/
	private ["_player","_result","_depth"];

	_result = false;
	_depth = _this select 3;

	if (_depth > 0) then {
		_result = true;
	} else {
		_player = _this select 0;
		if ((_this select 2) and {_depth > -1} and {vehicle _player != _player}) then {
			if ((_this select 1) or {isAbleToBreathe _player}) then {
				_result = true;
			};
		};
	};
	_result
};



TFAR_fnc_currentDirection = {
	/*
	 	Name: TFAR_fnc_currentDirection

	 	Author(s):
			NKey

	 	Description:
			Returns current direction of players head.

	 	Parameters:
			Nothing

	 	Returns:
			0: NUMBER: head direction azimuth

	 	Example:
			call TFAR_fnc_currentDirection
	*/
	private ["_current_look_at_x","_current_look_at_y","_current_look_at_z","_current_hyp_horizontal","_current_rotation_horizontal"];

	_current_look_at = (screenToWorld [0.5,0.5]) vectorDiff (eyepos TFAR_currentUnit);
	_current_look_at_x = _current_look_at select 0;
	_current_look_at_y = _current_look_at select 1;
	_current_look_at_z = _current_look_at select 2;

	_current_rotation_horizontal = 0;
	_current_hyp_horizontal = sqrt(_current_look_at_x * _current_look_at_x + _current_look_at_y * _current_look_at_y);

	if (_current_hyp_horizontal > 0) then {
		if (_current_look_at_x < 0) then {
			_current_rotation_horizontal = round - acos(_current_look_at_y / _current_hyp_horizontal);
		}else{
			_current_rotation_horizontal = round acos(_current_look_at_y / _current_hyp_horizontal);
		};
	} else {
		_current_rotation_horizontal = 0;
	};
	while{_current_rotation_horizontal < 0} do {
		_current_rotation_horizontal = _current_rotation_horizontal + 360;
	};
	_current_rotation_horizontal;
};

TFAR_fnc_currentUnit = {
	/*
	    Name: TFAR_fnc_currentUnit

	    Author(s):
	    Nkey

	    Description:
	    Return current player unit (player or remote controlled by Zeus).

	    Parameters:
	    Nothing

	    Returns:
	    OBJECT: current unit

	    Example:
	    call TFAR_fnc_currentUnit;
	*/
	private ["_unit"];
	missionNamespace getVariable ["bis_fnc_moduleRemoteControl_unit", player]

};

TFAR_fnc_defaultPositionCoordinates = {
	/*
	 	Name: TFAR_fnc_defaultPositionCoordinates

	 	Author(s):
			NKey

	 	Description:
			Prepares the position coordinates of the passed unit.

		Parameters:
			0: OBJECT - unit
			1: BOOLEAN - Is near player

	 	Returns:
			Nothing

	 	Example:

	*/
	private ["_unit","_current_eyepos","_current_x","_current_y","_current_z","_player_pos","_isolated_and_inside","_can_speak","_current_look_at", "_isNearPlayer", "_renderAt", "_pos", "_depth", "_useSw", "_useLr", "_useDd"];
	_unit = _this select 0;
	_isNearPlayer = _this select 1;
	_current_eyepos = eyepos _unit;
	_current_rotation_horizontal = 0;

	if (_unit != TFAR_currentUnit) then {
		if (_isNearPlayer) then {
			// This portion of the code appears that it will be extremely slow
			// It makes use of the 2 slower position functions.
			_renderAt = visiblePosition _unit;
			_pos = getPos _unit;
			// add different between pos and eyepos to visiblePosition to get some kind of visiblePositionEyepos
			_current_eyepos = _renderAt vectorAdd (_current_eyepos vectorDiff _pos);
		};
		// for now it used only for player
		_current_rotation_horizontal = 0;
		if (alive TFAR_currentUnit) then {
			_current_eyepos = _current_eyepos vectorDiff (eyePos TFAR_currentUnit);
		};
	} else {
		_current_rotation_horizontal = call TFAR_fnc_currentDirection;
		_current_eyepos = [0,0,0];
	};
	_current_eyepos pushBack _current_rotation_horizontal;

	_current_eyepos
};

TFAR_fnc_eyeDepth = {
	((eyepos _this) select 2) + ((getPosASLW _this) select 2) - ((getPosASL _this) select 2)
};

TFAR_fnc_getNearPlayers = {
	private ["_result","_index","_players_in_group","_spectator", "_v"];
	_players_in_group = count (units (group TFAR_currentUnit));
	_result = [];
	if (alive TFAR_currentUnit) then {
		private "_allUnits";
		_allUnits = TFAR_currentUnit nearEntities ["Man", TF_max_voice_volume];

		if (_players_in_group < 10) then {
			{
				if (_x != TFAR_currentUnit) then {
					_allUnits pushBack _x;
				};
				true;
			} count (units (group TFAR_currentUnit));
		};

		{
			_v = _x;
			{
				_allUnits pushBack _x;
			} forEach (crew _v);
		} forEach  (TFAR_currentUnit nearEntities [["LandVehicle", "Air", "Ship"], TF_max_voice_volume]);

		{
			if ((isPlayer _x) and {alive _x}) then {
				_spectator = _x getVariable "tf_forceSpectator";
				if (isNil "_spectator") then {
					_spectator = false;
				};
				if (!_spectator) then {
					_result pushBack _x;
				};
			};
			true;
		} count _allUnits;
	};
	_result
};

/*
	sleep (60 * 1);
	while {true} do {
		_request = format['TRACK	piwik.php?idsite=2&rec=1&url="radio.task-force.ru&action_name=%1&rand=%2&uid=%3&cvar={"1":["group","%4"], "2":["playableUnits","%5"], "3":["allUnits","%6"], "4":["BIS_fnc_listCuratorPlayers","%7"], "5":["playerSide","%8"], "5":["faction","%9"], "6":["isServer","%10"], "7":["isDedicated","%11"], "8":["missionName","%12"], "9":["currentSW","%13"], "10":["currentLR","%14"], "11":["nearPlayers","%15"], "12":["farPlayers","%16"], "13":["typeof","%17"], "14":["diag_fps","%18"], "15":["diag_fpsmin","%19"], "16":["daytime","%20"], "17":["vehicle","%21"], "18":["time","%22"], "19":["version","%23"]}', _action, random 1000, getPlayerUID player, count (units group player), count playableUnits, count allUnits, count (call BIS_fnc_listCuratorPlayers), playerSide, faction player, isServer, isDedicated, missionName, count (TFAR_currentUnit call TFAR_fnc_radiosList), count (TFAR_currentUnit call TFAR_fnc_lrRadiosList), count tf_nearPlayers, count tf_farPlayers, typeof TFAR_currentUnit, diag_fps, diag_fpsmin, daytime, typeof (vehicle TFAR_currentUnit), time, TF_ADDON_VERSION];
		"task_force_radio_pipe" callExtension _request;
		_action = "continue";
		sleep (60 * 10);
	};

*/