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

TFAR_fnc_ClientInit = {
	//#define DEBUG_MODE_FULL

	// cba settings
	//#include "cba_settings.sqf"

	//Тут задаются канал и пароль тфар канала
	if (isNil "tf_radio_channel_name") then {
		tf_radio_channel_name = "TaskForceRadio";
	};
	if (isNil "tf_radio_channel_password") then {
		tf_radio_channel_password = "123";
	};
	
	
	if (isNil "tf_west_radio_code") then {
		tf_west_radio_code = "_bluefor";
	};
	if (isNil "tf_east_radio_code") then {
		tf_east_radio_code = "_opfor";
	};
	if (isNil "tf_guer_radio_code") then {
		tf_guer_radio_code = "_independent";

		if (([west, resistance] call BIS_fnc_areFriendly) and {!([east, resistance] call BIS_fnc_areFriendly)}) then {
			tf_guer_radio_code = "_bluefor";
		};

		if (([east, resistance] call BIS_fnc_areFriendly) and {!([west, resistance] call BIS_fnc_areFriendly)}) then {
			tf_guer_radio_code = "_opfor";
		};
	};
	if (isNil "TF_defaultWestBackpack") then {
		TF_defaultWestBackpack = "tf_rt1523g";
	};
	if (isNil "TF_defaultEastBackpack") then {
		TF_defaultEastBackpack = "tf_mr3000";
	};
	if (isNil "TF_defaultGuerBackpack") then {
		TF_defaultGuerBackpack = "tf_anprc155";
	};

	if (isNil "TF_defaultWestPersonalRadio") then {
		TF_defaultWestPersonalRadio = "tf_anprc152";
	};
	if (isNil "TF_defaultEastPersonalRadio") then {
		TF_defaultEastPersonalRadio = "tf_fadak";
	};
	if (isNil "TF_defaultGuerPersonalRadio") then {
		TF_defaultGuerPersonalRadio = "tf_anprc148jem";
	};

	if (isNil "TF_defaultWestRiflemanRadio") then {
		TF_defaultWestRiflemanRadio = "tf_rf7800str";
	};
	if (isNil "TF_defaultEastRiflemanRadio") then {
		TF_defaultEastRiflemanRadio = "tf_pnr1000a";
	};
	if (isNil "TF_defaultGuerRiflemanRadio") then {
		TF_defaultGuerRiflemanRadio = "tf_anprc154";
	};

	if (isNil "TF_defaultWestAirborneRadio") then {
		TF_defaultWestAirborneRadio = "tf_anarc210";
	};
	if (isNil "TF_defaultEastAirborneRadio") then {
		TF_defaultEastAirborneRadio = "tf_mr6000l";
	};
	if (isNil "TF_defaultGuerAirborneRadio") then {
		TF_defaultGuerAirborneRadio = "tf_anarc164";
	};

	if (isNil "TF_terrain_interception_coefficient") then {
		TF_terrain_interception_coefficient = 7.0;
	};

	disableSerialization;

	//#include "keys.sqf"

	// Menus
	["TFAR","OpenSWRadioMenu",["Open SW Radio Menu","Open SW Radio Menu"],{["player",[],-3,"_this call TFAR_fnc_swRadioMenu",true] call cba_fnc_fleximenu_openMenuByDef;},{true},[TF_dialog_sw_scancode, TF_dialog_sw_modifiers],false] call cba_fnc_addKeybind;
	["TFAR","OpenLRRadioMenu",["Open LR Radio Menu","Open LR Radio Menu"],{["player",[],-3,"_this call TFAR_fnc_lrRadioMenu",true] call cba_fnc_fleximenu_openMenuByDef;},{true},[TF_dialog_lr_scancode, TF_dialog_lr_modifiers],false] call cba_fnc_addKeybind;

	["TFAR","DDRadioSettings",["DD Radio Settings","DD Radio Settings"],{call TFAR_fnc_onDDDialogOpen},{true},[TF_dialog_dd_scancode, TF_dialog_dd_modifiers],false] call cba_fnc_addKeybind;

	["TFAR","SWChannel1",["SW Channel 1","SW Channel 1"],{[0] call TFAR_fnc_processSWChannelKeys},{true},[TF_sw_channel_1_scancode, TF_sw_channel_1_modifiers],false] call cba_fnc_addKeybind;
	["TFAR","SWChannel2",["SW Channel 2","SW Channel 2"],{[1] call TFAR_fnc_processSWChannelKeys},{true},[TF_sw_channel_2_scancode, TF_sw_channel_2_modifiers],false] call cba_fnc_addKeybind;
	["TFAR","SWChannel3",["SW Channel 3","SW Channel 3"],{[2] call TFAR_fnc_processSWChannelKeys},{true},[TF_sw_channel_3_scancode, TF_sw_channel_3_modifiers],false] call cba_fnc_addKeybind;
	["TFAR","SWChannel4",["SW Channel 4","SW Channel 4"],{[3] call TFAR_fnc_processSWChannelKeys},{true},[TF_sw_channel_4_scancode, TF_sw_channel_4_modifiers],false] call cba_fnc_addKeybind;
	["TFAR","SWChannel5",["SW Channel 5","SW Channel 5"],{[4] call TFAR_fnc_processSWChannelKeys},{true},[TF_sw_channel_5_scancode, TF_sw_channel_5_modifiers],false] call cba_fnc_addKeybind;
	["TFAR","SWChannel6",["SW Channel 6","SW Channel 6"],{[5] call TFAR_fnc_processSWChannelKeys},{true},[TF_sw_channel_6_scancode, TF_sw_channel_6_modifiers],false] call cba_fnc_addKeybind;
	["TFAR","SWChannel7",["SW Channel 7","SW Channel 7"],{[6] call TFAR_fnc_processSWChannelKeys},{true},[TF_sw_channel_7_scancode, TF_sw_channel_7_modifiers],false] call cba_fnc_addKeybind;
	["TFAR","SWChannel8",["SW Channel 8","SW Channel 8"],{[7] call TFAR_fnc_processSWChannelKeys},{true},[TF_sw_channel_8_scancode, TF_sw_channel_8_modifiers],false] call cba_fnc_addKeybind;


	["TFAR","LRChannel1",["LR Channel 1","LR Channel 1"],{[0] call TFAR_fnc_processLRChannelKeys},{true},[TF_lr_channel_1_scancode, TF_lr_channel_1_modifiers],false] call cba_fnc_addKeybind;
	["TFAR","LRChannel2",["LR Channel 2","LR Channel 2"],{[1] call TFAR_fnc_processLRChannelKeys},{true},[TF_lr_channel_2_scancode, TF_lr_channel_2_modifiers],false] call cba_fnc_addKeybind;
	["TFAR","LRChannel3",["LR Channel 3","LR Channel 3"],{[2] call TFAR_fnc_processLRChannelKeys},{true},[TF_lr_channel_3_scancode, TF_lr_channel_3_modifiers],false] call cba_fnc_addKeybind;
	["TFAR","LRChannel4",["LR Channel 4","LR Channel 4"],{[3] call TFAR_fnc_processLRChannelKeys},{true},[TF_lr_channel_4_scancode, TF_lr_channel_4_modifiers],false] call cba_fnc_addKeybind;
	["TFAR","LRChannel5",["LR Channel 5","LR Channel 5"],{[4] call TFAR_fnc_processLRChannelKeys},{true},[TF_lr_channel_5_scancode, TF_lr_channel_5_modifiers],false] call cba_fnc_addKeybind;
	["TFAR","LRChannel6",["LR Channel 6","LR Channel 6"],{[5] call TFAR_fnc_processLRChannelKeys},{true},[TF_lr_channel_6_scancode, TF_lr_channel_6_modifiers],false] call cba_fnc_addKeybind;
	["TFAR","LRChannel7",["LR Channel 7","LR Channel 7"],{[6] call TFAR_fnc_processLRChannelKeys},{true},[TF_lr_channel_7_scancode, TF_lr_channel_7_modifiers],false] call cba_fnc_addKeybind;
	["TFAR","LRChannel8",["LR Channel 8","LR Channel 8"],{[7] call TFAR_fnc_processLRChannelKeys},{true},[TF_lr_channel_8_scancode, TF_lr_channel_8_modifiers],false] call cba_fnc_addKeybind;
	["TFAR","LRChannel9",["LR Channel 9","LR Channel 9"],{[8] call TFAR_fnc_processLRChannelKeys},{true},[TF_lr_channel_9_scancode, TF_lr_channel_9_modifiers],false] call cba_fnc_addKeybind;


	["TFAR","ChangeSpeakingVolume",["Change Speaking Volume","Change Speaking Volume"],{call TFAR_fnc_onSpeakVolumeChange},{true},[TF_speak_volume_scancode, TF_speak_volume_modifiers],false] call cba_fnc_addKeybind;

	["TFAR","CycleSWRadios",["Cycle >> SW Radios","Cycle >> SW Radios"],{true},{["next"] call TFAR_fnc_processSWCycleKeys},[TF_sw_cycle_next_scancode, TF_sw_cycle_next_modifiers],false] call cba_fnc_addKeybind;
	["TFAR","CycleSWRadios",["Cycle << SW Radios","Cycle << SW Radios"],{true},{["prev"] call TFAR_fnc_processSWCycleKeys},[TF_sw_cycle_prev_scancode, TF_sw_cycle_prev_modifiers],false] call cba_fnc_addKeybind;
	["TFAR","CycleLRRadios",["Cycle >> LR Radios","Cycle >> LR Radios"],{true},{["next"] call TFAR_fnc_processLRCycleKeys},[TF_lr_cycle_next_scancode, TF_lr_cycle_next_modifiers],false] call cba_fnc_addKeybind;
	["TFAR","CycleLRRadios",["Cycle << LR Radios","Cycle << LR Radios"],{true},{["prev"] call TFAR_fnc_processLRCycleKeys},[TF_lr_cycle_prev_scancode, TF_lr_cycle_prev_modifiers],false] call cba_fnc_addKeybind;


	["TFAR","SWStereoBoth",	["SW Stereo: Both","SW Stereo: Both"],{[0] call TFAR_fnc_processSWStereoKeys},	{true},[TF_sw_stereo_both_scancode, TF_sw_stereo_both_modifiers],false] call cba_fnc_addKeybind;
	["TFAR","SWStereoLeft",	["SW Stereo: Left","SW Stereo: Left"],{[1] call TFAR_fnc_processSWStereoKeys},	{true},[TF_sw_stereo_left_scancode, TF_sw_stereo_left_modifiers],false] call cba_fnc_addKeybind;
	["TFAR","SWStereoRight",["SW Stereo: Right","SW Stereo: Right"],{[2] call TFAR_fnc_processSWStereoKeys},{true},[TF_sw_stereo_right_scancode,TF_sw_stereo_right_modifiers],false] call cba_fnc_addKeybind;


	["TFAR","LRStereoBoth",	["LR Stereo: Both","LR Stereo: Both"],{[0] call TFAR_fnc_processLRStereoKeys},	{true},[TF_lr_stereo_both_scancode, TF_lr_stereo_both_modifiers],false] call cba_fnc_addKeybind;
	["TFAR","LRStereoLeft",	["LR Stereo: Left","LR Stereo: Left"],{[1] call TFAR_fnc_processLRStereoKeys},	{true},[TF_lr_stereo_left_scancode, TF_lr_stereo_left_modifiers],false] call cba_fnc_addKeybind;
	["TFAR","LRStereoRight",	["LR Stereo: Right","LR Stereo: Right"],{[2] call TFAR_fnc_processLRStereoKeys},{true},[TF_lr_stereo_right_scancode,TF_lr_stereo_right_modifiers],false] call cba_fnc_addKeybind;


	["TFAR","SWTransmit",["SW Transmit","SW Transmit"],{call TFAR_fnc_onSwTangentPressed},{call TFAR_fnc_onSwTangentReleased},[TF_tangent_sw_scancode, TF_tangent_sw_modifiers],false] call cba_fnc_addKeybind;
	["TFAR","SWTransmitAlt",["SW Transmit Alt","SW Transmit Alt"],{call TFAR_fnc_onSwTangentPressed},{call TFAR_fnc_onSwTangentReleased},[TF_tangent_sw_2_scancode, TF_tangent_sw_2_modifiers],false] call cba_fnc_addKeybind;
	["TFAR","SWTransmitAdditional",["SW Transmit Additional","SW Transmit Additional"],{call TFAR_fnc_onAdditionalSwTangentPressed},{call TFAR_fnc_onAdditionalSwTangentReleased},[TF_tangent_additional_sw_scancode, TF_tangent_additional_sw_modifiers],false] call cba_fnc_addKeybind;

	["TFAR","LRTransmit",["LR Transmit","LR Transmit"],{call TFAR_fnc_onLRTangentPressed},{call TFAR_fnc_onLRTangentReleased},[TF_tangent_lr_scancode, TF_tangent_lr_modifiers],false] call cba_fnc_addKeybind;
	["TFAR","LRTransmitAlt",["LR Transmit Alt","LR Transmit Alt"],{call TFAR_fnc_onLRTangentPressed},{call TFAR_fnc_onLRTangentReleased},[TF_tangent_lr_2_scancode, TF_tangent_lr_2_modifiers],false] call cba_fnc_addKeybind;
	["TFAR","LRTransmitAdditional",["LR Transmit Additional","LR Transmit Additional"],{call TFAR_fnc_onAdditionalLRTangentPressed},{call TFAR_fnc_onAdditionalLRTangentReleased},[TF_tangent_additional_lr_scancode, TF_tangent_additional_lr_modifiers],false] call cba_fnc_addKeybind;

	["TFAR","DDTransmit",["DD Transmit","DD Transmit"],{call TFAR_fnc_onDDTangentPressed},{call TFAR_fnc_onDDTangentReleased},[TF_tangent_dd_scancode, TF_tangent_dd_modifiers],false] call cba_fnc_addKeybind;
	["TFAR","DDTransmitAlt",["DD Transmit Alt","DD Transmit Alt"],{call TFAR_fnc_onDDTangentPressed},{call TFAR_fnc_onDDTangentReleased},[TF_tangent_dd_2_scancode, TF_tangent_dd_2_modifiers],false] call cba_fnc_addKeybind;

	//#include "diary.sqf"

	waitUntil {sleep 0.2;time > 0};
	waitUntil {sleep 0.1;!(isNull player)};
	TFAR_currentUnit = call TFAR_fnc_currentUnit;
	[parseText(localize ("STR_init")), 5] call TFAR_fnc_ShowHint;

	#include "VoiceSystem_widgetEnums.h"

	#include "script.h"

	TF_radio_request_mutex = false;

	TF_use_saved_sw_setting = false;
	TF_saved_active_sw_settings = nil;

	TF_use_saved_lr_setting = false;
	TF_saved_active_lr_settings = nil;

	TF_curator_backpack_1 = nil;
	TF_curator_backpack_2 = nil;
	TF_curator_backpack_3 = nil;

	TF_MAX_SW_VOLUME = 10;
	TF_MAX_LR_VOLUME = 10;
	TF_MAX_DD_VOLUME = 10;

	TF_UNDERWATER_RADIO_DEPTH = -3;

	TF_new_line = toString [0xA];
	TF_vertical_tab = toString [0xB];

	TF_dd_volume_level = 7;

	TF_last_lr_tangent_press = 0.0;
	TF_last_dd_tangent_press = 0.0;

	TF_HintFnc = nil;

	IDC_ANPRC152_RADIO_DIALOG_EDIT_ID = IDC_ANPRC152_EDIT;
	IDC_ANPRC152_RADIO_DIALOG_ID = IDD_ANPRC152_RADIO_DIALOG;

	IDC_ANPRC155_RADIO_DIALOG_EDIT_ID = IDC_ANPRC155_EDIT;
	IDC_ANPRC155_RADIO_DIALOG_ID = IDD_ANPRC155_RADIO_DIALOG;

	IDC_PRN1000A_RADIO_DIALOG_ID = IDC_PNR1000A_RADIO_DIALOG;

	IDC_RF7800STR_RADIO_DIALOG_ID =IDD_RF7800STR_RADIO_DIALOG;

	IDC_ANPRC148JEM_RADIO_DIALOG_EDIT_ID = IDC_ANPRC148JEM_EDIT;
	IDC_ANPRC148JEM_RADIO_DIALOG_ID = IDD_ANPRC148JEM_RADIO_DIALOG;

	IDC_FADAK_RADIO_DIALOG_EDIT_ID = IDC_FADAK_EDIT;
	IDC_FADAK_RADIO_DIALOG_ID = IDD_FADAK_RADIO_DIALOG;

	IDC_RT1523G_RADIO_DIALOG_EDIT_ID = IDC_RT1523G_EDIT;
	IDC_RT1523G_RADIO_DIALOG_ID = IDD_RT1523G_RADIO_DIALOG;

	IDC_MR3000_RADIO_DIALOG_EDIT_ID = IDC_MR3000_EDIT;
	IDC_MR3000_RADIO_DIALOG_ID = IDD_MR3000_RADIO_DIALOG;

	IDC_MR6000L_RADIO_DIALOG_EDIT_ID = IDC_MR6000L_EDIT;
	IDC_MR6000L_RADIO_DIALOG_ID = IDD_MR6000L_RADIO_DIALOG;

	IDC_ANARC164_RADIO_DIALOG_EDIT_ID = IDC_ANARC164_EDIT;
	IDC_ANARC164_RADIO_DIALOG_ID = IDD_ANARC164_RADIO_DIALOG;

	IDC_ANPRC210_RADIO_DIALOG_EDIT_ID = IDC_ANPRC210_EDIT;
	IDC_ANPRC210_RADIO_DIALOG_ID = IDD_ANPRC210_RADIO_DIALOG;

	IDC_BUSSOLE_RADIO_DIALOG_EDIT_ID = IDC_BUSSOLE_EDIT;
	IDC_BUSSOLE_RADIO_DIALOG_ID = IDD_BUSSOLE_RADIO_DIALOG;

	IDC_DIDER_RADIO_DIALOG_ID = IDD_DIVER_RADIO_DIALOG;
	IDC_DIVER_RADIO_EDIT_ID = IDC_DIVER_RADIO_EDIT;
	IDC_DIVER_RADIO_DEPTH_ID = IDC_DIVER_RADIO_DEPTH_EDIT;

	TF_BACKGROUND_ID = IDD_BACKGROUND;
	TF_MICRODAGR_BACKGROUND_ID = IDC_MICRODAGR_BACKGROUND;
	TF_MICRODAGR_CLEAR_ID = IDC_MICRODAGR_CLEAR;
	TF_MICRODAGR_ENTER_ID = IDC_MICRODAGR_ENTER;
	TF_MICRODAGR_EDIT_ID = IDC_MICRODAGR_EDIT;
	TF_MICRODAGR_CHANNEL_EDIT_ID = IDC_MICRODAGR_CHANNEL_EDIT;

	TF_tangent_sw_pressed = false;
	TF_tangent_lr_pressed = false;
	TF_tangent_dd_pressed = false;

	TF_dd_frequency = nil;

	TF_speakerDistance = 20;
	TF_speak_volume_level = "normal";
	TF_speak_volume_meters = 20;
	TF_max_voice_volume = 60;
	TF_sw_dialog_radio = nil;

	TF_lr_dialog_radio = nil;
	TF_lr_active_radio = nil;
	TF_lr_active_curator_radio = nil;

	tf_lastNearFrameTick = diag_tickTime;
	tf_lastFarFrameTick = diag_tickTime;
	tf_msPerStep = 0;

	tf_speakerRadios = [];
	tf_nearPlayers = [];
	tf_farPlayers = [];

	tf_nearPlayersIndex = 0;
	tf_nearPlayersProcessed = true;

	tf_farPlayersIndex = 0;
	tf_farPlayersProcessed = true;

	tf_msNearPerStepMax = 0.025;
	tf_msNearPerStepMin = 0.1;
	tf_msNearPerStep = tf_msNearPerStepMax;
	tf_nearUpdateTime = 0.3;

	tf_msFarPerStepMax = 0.025;
	tf_msFarPerStepMin = 1.00;
	tf_msFarPerStep = tf_msFarPerStepMax;
	tf_farUpdateTime = 3.5;

	tf_lastFrequencyInfoTick = 0;
	tf_lastNearPlayersUpdate = 0;

	tf_lastError = false;

	tf_msSpectatorPerStepMax = 0.035;

	_h = [] spawn {
		waituntil {sleep 0.1;!(IsNull (findDisplay 46))};

		(findDisplay 46) displayAddEventHandler ["keyUp", "_this call TFAR_fnc_onSwTangentReleasedHack"];
		(findDisplay 46) displayAddEventHandler ["keyDown", "_this call TFAR_fnc_onSwTangentPressedHack"];
		(findDisplay 46) displayAddEventHandler ["keyUp", "_this call TFAR_fnc_onLRTangentReleasedHack"];
		(findDisplay 46) displayAddEventHandler ["keyUp", "_this call TFAR_fnc_onDDTangentReleasedHack"];

		if (isMultiplayer) then {
			call TFAR_fnc_sendVersionInfo;
			["processPlayerPositionsHandler", "onEachFrame", "TFAR_fnc_processPlayerPositions"] call BIS_fnc_addStackedEventHandler;
		};
	}; allThreads pushBack _h;

	TF_first_radio_request = true;
	TF_last_request_time = 0;

	player addEventHandler ["respawn", {call TFAR_fnc_processRespawn}];
	player addEventHandler ["killed", {
		TF_use_saved_sw_setting = true;
		TF_use_saved_lr_setting = true;
		TF_first_radio_request = true;
		call TFAR_fnc_HideHint;
	}];

	_h = [] spawn {
		call TFAR_fnc_processRespawn;
	}; allThreads pushBack _h;
	TF_respawnedAt = time;
	TFAR_previouscurrentUnit = nil;
	TFAR_currentUnit = player;
	_h = [] spawn {
		waitUntil {sleep 0.1;!(isNull player)};
		if (player call TFAR_fnc_isForcedCurator) then {
			player enableSimulation false;
			player hideObject true;

			player unlinkItem "ItemRadio";
			player addVest "V_Rangemaster_belt";

			switch (typeOf (player)) do {
				case "B_VirtualCurator_F": {
						player addItem TF_defaultWestPersonalRadio;
						TF_curator_backpack_1 = TF_defaultWestAirborneRadio createVehicleLocal [0, 0, 0];
					};
				case "O_VirtualCurator_F": {
						player addItem TF_defaultEastPersonalRadio;
						TF_curator_backpack_1 = TF_defaultEastAirborneRadio createVehicleLocal [0, 0, 0];
					};
				case "I_VirtualCurator_F": {
						player addItem TF_defaultGuerPersonalRadio;
						TF_curator_backpack_1 = TF_defaultGuerAirborneRadio createVehicleLocal [0, 0, 0];
					};
				default {
					player addItem TF_defaultWestPersonalRadio;
					player addItem TF_defaultEastPersonalRadio;
					player addItem TF_defaultGuerPersonalRadio;
					TF_curator_backpack_1 = TF_defaultWestAirborneRadio createVehicleLocal [0, 0, 0];
					TF_curator_backpack_2 = TF_defaultEastAirborneRadio createVehicleLocal [0, 0, 0];
					TF_curator_backpack_3 = TF_defaultGuerAirborneRadio createVehicleLocal [0, 0, 0];
				};
			};

			_h = [] spawn {
				while {true} do {
					if !(isNull curatorCamera) then {
						player setPosATL (getPosATL curatorCamera);
						player setDir (getDir curatorCamera);
					};
					sleep 1;
				};
			}; allThreads pushBack _h;
		};
		sleep 2;
		if (player in (call BIS_fnc_listCuratorPlayers)) then {
			_h = [] spawn {
				while {true} do {
					waitUntil {sleep 0.1;!(isNull (findDisplay 312))};
					(findDisplay 312) displayAddEventHandler ["KeyDown", "[_this, 'keydown'] call TFAR_fnc_processCuratorKey"];
					(findDisplay 312) displayAddEventHandler ["KeyUp", "[_this, 'keyup'] call TFAR_fnc_processCuratorKey"];
					waitUntil {sleep 0.1;isNull (findDisplay 312)};
				};
			}; allThreads pushBack _h;
		};

		call TFAR_fnc_radioReplaceProcess;
	}; allThreads pushBack _h;

	_h = [] spawn {
		waitUntil {sleep 0.1;!((isNil "TF_server_addon_version") and (time < 20))};
		if (isNil "TF_server_addon_version") then {
			hintC (localize "STR_no_server");
		} else {
			if (TF_server_addon_version != TF_ADDON_VERSION) then {
				hintC format[localize "STR_different_version", TF_server_addon_version, TF_ADDON_VERSION];
			};
		};
	};allThreads pushBack _h;

	if (player in (call BIS_fnc_listCuratorPlayers)) then {
		_h = [] spawn {
			while {true} do {
				waitUntil {sleep 0.1;!(isNull (findDisplay 312))};
				(findDisplay 312) displayAddEventHandler ["KeyDown", "[_this, 'keydown'] call TFAR_fnc_processCuratorKey"];
				(findDisplay 312) displayAddEventHandler ["KeyUp", "[_this, 'keyup'] call TFAR_fnc_processCuratorKey"];
				(findDisplay 312) displayAddEventHandler ["keyUp", "_this call TFAR_fnc_onSwTangentReleasedHack"];
				(findDisplay 312) displayAddEventHandler ["keyDown", "_this call TFAR_fnc_onSwTangentPressedHack"];
				(findDisplay 312) displayAddEventHandler ["keyUp", "_this call TFAR_fnc_onLRTangentReleasedHack"];
				(findDisplay 312) displayAddEventHandler ["keyUp", "_this call TFAR_fnc_onDDTangentReleasedHack"];
				waitUntil {sleep 0.1;isNull (findDisplay 312)};
			};
		}; allThreads pushBack _h;
	};

	call TFAR_fnc_sessionTracker;

};

TFAR_fnc_copyRadioSettingMenu = {
	/*
	 	Name: TFAR_fnc_copyRadioSettingMenu

	 	Author(s):
			NKey

	 	Description:
			Returns a sub menu for radio settings copying.

	 	Parameters:
			Nothing

	 	Returns:
			ARRAY: CBA UI menu.

	 	Example:
			Called internally by CBA UI
	*/
	private ["_menuDef","_positions","_command","_menu","_position"];
	_menu = [];

	_menuDef = ["main", localize "STR_select_action_copy_settings_from", "buttonList", "", false];
	_positions = [];
	{
		if (((_x call TFAR_fnc_getSwRadioCode) == (TF_sw_dialog_radio call TFAR_fnc_getSwRadioCode)) and {TF_sw_dialog_radio != _x}) then {
			_command = format["['%1',TF_sw_dialog_radio] call TFAR_fnc_CopySettings;", _x];
			_position = [
				getText(configFile >> "CfgWeapons"  >> _x >> "displayName"),
				_command,
				getText(configFile >> "CfgWeapons"  >> _x >> "picture"),
				"",
				"",
				-1,
				true,
				true
			];
			_positions set [count _positions, _position];
		};
	} forEach (TFAR_currentUnit call TFAR_fnc_radiosList);
	_menu =
	[
		_menuDef,
		_positions
	];
	_menu
};

TFAR_fnc_CopySettings = {
	/*
	 	Name: TFAR_fnc_copySettings

	 	Author(s):
			L-H

	 	Description:
			Copies the settings from a radio to another.

	 	Parameters:
			0:ARRAY/STRING - Source Radio (SW/LR)
			1:ARRAY/STRING - Destination Radio (SW/LR)

	 	Returns:
			Nothing

	 	Example:
		// LR - LR
		[(call TFAR_fnc_activeLrRadio),[(vehicle player), "driver"]] call TFAR_fnc_CopySettings;
		// SW - SW
		[(call TFAR_fnc_activeSwRadio),"tf_anprc148jem_20"] call TFAR_fnc_CopySettings;
	*/
	#include "script.h"
	private ["_source", "_destination", "_settings", "_isDLR", "_isSLR", "_support_additional"];
	_source = _this select 0;
	_destination = _this select 1;

	_isDLR = if (typename _destination == typename []) then {true}else{false};
	_isSLR = if (typename _source == typename []) then {true}else{false};

	if (_isSLR) then {
		_settings = _source call TFAR_fnc_GetLRSettings;
		if (_isDLR) then {
			[_destination select 0, _destination select 1,[]+_settings] call TFAR_fnc_SetLRSettings;
		} else {
			diag_log "TFAR - unable to copy from LR to SW";
			hint "TFAR - unable to copy from LR to SW";
		};
	} else {
		_settings = _source call TFAR_fnc_GetSwSettings;
		if (!_isDLR) then {
			_settings = []+_settings;
			_support_additional = getNumber (configFile >> "CfgWeapons" >> _destination >> "tf_additional_channel");
			if ((isNil "_support_additional") or {_support_additional == 0}) then {
				_settings set [TF_ADDITIONAL_CHANNEL_OFFSET, -1];
			};
			[_destination, _settings] call TFAR_fnc_SetSwSettings;
		} else {
			diag_log "TFAR - unable to copy from SW to LR";
			hint "TFAR - unable to copy from SW to LR";
		};
	};
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

TFAR_fnc_currentLRFrequency = {
	(call TFAR_fnc_activeLrRadio) call TFAR_fnc_getLrFrequency
};

TFAR_fnc_currentSWFrequency = {
	(call TFAR_fnc_activeSwRadio) call TFAR_fnc_getSwFrequency
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

#ifndef VOICE_DISABLE_LEGACYCODE
TFAR_fnc_fireEventHandlers = {
	/*
	 	Name: TFAR_fnc_fireEventHandlers

	 	Author(s):
			L-H

	 	Description:
			Fires all eventhandlers associated with the passed unit

		Parameters:
			0: STRING - ID for event
			1: OBJECT - unit to fire events on.
			2: ANY - parameters

	 	Returns:
			NOTHING

	 	Example:
			["OnSpeak", player, [player, TF_speak_volume_meters]] call TFAR_fnc_fireEventHandlers;
	*/
	private ["_eventID", "_unit", "_handlers", "_parameters"];
	_eventID = _this select 0;
	_unit = _this select 1;
	_parameters = _this select 2;

	_eventID = format ["TFAR_event_%1", _eventID];
	_handlers = missionNamespace getVariable [_eventID, []];
	{
		_parameters call (_x select 1);
		true;
	} count _handlers;
	if (isNil "_unit" || {isNull _unit}) exitWith {};
	_handlers = _unit getVariable [_eventID, []];
	{
		_parameters call (_x select 1);
	} foreach _handlers;
};

TFAR_fnc_forceSpectator = {
	/*
	 	Name: TFAR_fnc_forceSpectator

	 	Author(s):
			NKey

	 	Description:
			If second parameter is true player will force to be moved in spectator mode (at radio level).
			If false - normal behaviour restore.

	 	Parameters:
			ARRAY:
				0 - Object - Player
				1 - Boolean - Force or not

	 	Returns:
			Nothing

	 	Example:
			[player, true] call TFAR_fnc_forceSpectator;
	 */
	 private ["_player", "_value"];
	 _player = _this select 0;
	 _value = _this select 1;
	 if (_value) then {
		_player call TFAR_fnc_sendPlayerKilled;
	 };
	 _player setVariable ["tf_forceSpectator", _value, true];
};

TFAR_fnc_getAdditionalLrChannel = {
	/*
	 	Name: TFAR_fnc_getAdditionalLrChannel

	 	Author(s):
			NKey

	 	Description:
			Gets the additional channel for the passed radio

		Parameters:
			Array: Radio
				0: OBJECT - Radio object
				1: STRING - Radio ID

	 	Returns:
			NUMBER: Channel

	 	Example:
			_channel = (call TFAR_fnc_ActiveLrRadio) call TFAR_fnc_getAdditionalLrChannel;
	*/
	#include "script.h"
	private ["_settings"];
	_settings = _this call TFAR_fnc_getLrSettings;
	_settings select TF_ADDITIONAL_CHANNEL_OFFSET
};

TFAR_fnc_getAdditionalLrStereo = {
	/*
	 	Name: TFAR_fnc_getAdditionalLrStereo

	 	Author(s):
			NKey

	 	Description:
			Gets the stereo setting of additional channel of the passed radio

		Parameters:
			Array: Radio
				0: OBJECT - Radio object
				1: STRING - Radio ID

	 	Returns:
			NUMBER: Stereo setting : Range (0,2) (0 - Both, 1 - Left, 2 - Right)

	 	Example:
			_stereo = (call TFAR_fnc_ActiveLrRadio) call TFAR_fnc_getAdditionalLrStereo;
	*/
	#include "script.h"
	private ["_settings", "_result"];
	_settings = _this call TFAR_fnc_getLrSettings;
	_result = 0;
	if (count _settings > TF_ADDITIONAL_STEREO_OFFSET) then {
		_result = _settings select TF_ADDITIONAL_STEREO_OFFSET;
	};
	_result
};

TFAR_fnc_getAdditionalSwChannel = {
	/*
	 	Name: TFAR_fnc_getAdditionalSwChannel

	 	Author(s):
			NKey

	 	Description:
			Gets the additional channel for the passed radio

		Parameters:
			STRING: Radio classname

	 	Returns:
			NUMBER: Channel

	 	Example:
			_channel = (call TFAR_fnc_ActiveSwRadio) call TFAR_fnc_getAdditionalSwChannel;
	*/
	#include "script.h"
	private ["_settings"];
	_settings = _this call TFAR_fnc_getSwSettings;
	_settings select TF_ADDITIONAL_CHANNEL_OFFSET
};

TFAR_fnc_getAdditionalSwStereo = {
	/*
	 	Name: TFAR_fnc_getAdditionalSwStereo

	 	Author(s):
			NKey

	 	Description:
			Gets the stereo setting of additional channel of the passed radio

		Parameters:
			STRING: Radio classname

	 	Returns:
			NUMBER: Stereo setting : Range (0,2) (0 - Both, 1 - Left, 2 - Right)

	 	Example:
			_stereo = (call TFAR_fnc_ActiveSwRadio) call TFAR_fnc_getAdditionalSwStereo;
	*/
	#include "script.h"
	private ["_settings", "_result"];
	_settings = _this call TFAR_fnc_getSwSettings;
	_result = 0;
	if (count _settings > TF_ADDITIONAL_STEREO_OFFSET) then {
		_result = _settings select TF_ADDITIONAL_STEREO_OFFSET;
	};
	_result
};

TFAR_fnc_getChannelFrequency = {
	/*
	 	Name: TFAR_fnc_GetChannelFrequency

	 	Author(s):
			L-H

	 	Description:
			Returns the frequency for the passed channel and radio.

	 	Parameters:
	 	0: OBJECT/String - Radio
		1: NUMBER - Channel

	 	Returns:
		STRING - Frequency

	 	Example:
		// LR radio - channel 1
		[(call TFAR_fnc_activeLrRadio), 1] call TFAR_fnc_GetChannelFrequency;
		// SW radio - channel 1
		[(call TFAR_fnc_activeSwRadio), 1] call TFAR_fnc_GetChannelFrequency;
	*/
	#include "script.h"
	private ["_radio", "_channel", "_settings"];
	_radio = _this select 0;
	_channel = (_this select 1) - 1;

	if (typename _radio == "STRING") then {
		_settings = _radio call TFAR_fnc_getSwSettings;
	} else {
		_settings = _radio call TFAR_fnc_getLrSettings;
	};

	if (!isNil "_settings") then {
		((_settings select TF_FREQ_OFFSET) select _channel)
	} else {
		"";
	};
};

TFAR_fnc_getConfigProperty = {
	/*
	 	Name: TFAR_fnc_getConfigProperty

	 	Author(s):
			NKey
			L-H

	 	Description:
		Gets a config property (getNumber/getText)
		Only works for CfgVehicles.

	 	Parameters:
	 	0: STRING - Item classname
		1: STRING - property
		2: ANYTHING - Default (Optional)

	 	Returns:
	 	NUMBER or TEXT - Result

	 	Example:
			[_LRradio, "tf_hasLrRadio", 0] call TFAR_fnc_getConfigProperty;
	 */
	private ["_result", "_item", "_property", "_default"];
	_item = _this select 0;
	_property = _this select 1;
	_result = "";
	_default = "";
	if (count _this > 2) then {
		_default = _this select 2;
	};

	if ((isNil "_item") or {str(_item) == ""}) exitWith {_default};
	if (isNumber (ConfigFile >> "CfgVehicles" >> _item >> _property + "_api")) then {
		_result = getNumber (ConfigFile >> "CfgVehicles" >> _item >> _property + "_api");
	}else{
		if (isNumber (ConfigFile >> "CfgVehicles" >> _item >> _property)) then{
			_result = getNumber (ConfigFile >> "CfgVehicles" >> _item >> _property);
		}else{
			if (isText (configFile >> "CfgVehicles" >> _item >> _property + "_api")) then{
				_result = getText (ConfigFile >> "CfgVehicles" >> _item >> _property + "_api");
			}else{
				if (isText (configFile >> "CfgVehicles" >> _item >> _property)) then {
					_result = getText (ConfigFile >> "CfgVehicles" >> _item >> _property);
				} else {
					_result = _default;
				}
			};
		};
	};
	_result
};

TFAR_fnc_getCurrentLrStereo = {
	/*
	 	Name: TFAR_fnc_getCurrentLrStereo

	 	Author(s):
			NKey

	 	Description:
			Gets the stereo of current channel (special logic for additional) setting of the passed radio

		Parameters:
			Array: Radio
				0: OBJECT - Radio object
				1: STRING - Radio ID

	 	Returns:
			NUMBER: Stereo setting : Range (0,2) (0 - Both, 1 - Left, 2 - Right)

	 	Example:
			_stereo = (call TFAR_fnc_ActiveLrRadio) call TFAR_fnc_getCurrentLrStereo;
	*/
	#include "script.h"
	private ["_result"];
	_result = 0;
	if ((_this call TFAR_fnc_getAdditionalLrChannel) == (_this call TFAR_fnc_getLrChannel)) then {
		_result = _this call TFAR_fnc_getAdditionalLrStereo;
	} else {
		_result = _this call TFAR_fnc_getLrStereo;
	};
	_result
};

TFAR_fnc_getCurrentSwStereo = {
	/*
	 	Name: TFAR_fnc_getCurrentSwStereo

	 	Author(s):
			NKey

	 	Description:
			Gets the stereo setting of current channel (special logic for additional) the passed radio

		Parameters:
			STRING: Radio classname

	 	Returns:
			NUMBER: Stereo setting : Range (0,2) (0 - Both, 1 - Left, 2 - Right)

	 	Example:
			_stereo = (call TFAR_fnc_ActiveSwRadio) call TFAR_fnc_getCurrentSwStereo;
	*/
	#include "script.h"
	private ["_result"];
	_result = 0;
	if ((_this call TFAR_fnc_getAdditionalSwChannel) == (_this call TFAR_fnc_getSwChannel)) then {
		_result = _this call TFAR_fnc_getAdditionalSwStereo;
	} else {
		_result = _this call TFAR_fnc_getSwStereo;
	};
	_result
};

TFAR_fnc_getDefaultRadioClasses = {
	/*
	 	Name: TFAR_fnc_getDefaultRadioClasses

	 	Author(s):
			NKey

	 	Description:
			Return array of default radio classes for player.

		Parameters:
			Nothing

	 	Returns:
			ARRAY - [defaultLR, defaultPersonal, defaultRifleman, defaultAirborne]

	 	Example:
			_classes = call TFAR_fnc_getDefaultRadioClasses;
	*/
	private ["_personalRadio", "_riflemanRadio", "_lrRadio", "_airborne"];

	switch (TFAR_currentUnit call BIS_fnc_objectSide) do {
		case west: {_personalRadio = TF_defaultWestPersonalRadio; _riflemanRadio = TF_defaultWestRiflemanRadio; _lrRadio = TF_defaultWestBackpack; _airborne = TF_defaultWestAirborneRadio;};
		case east: {_personalRadio = TF_defaultEastPersonalRadio; _riflemanRadio = TF_defaultEastRiflemanRadio;_lrRadio = TF_defaultEastBackpack; _airborne = TF_defaultEastAirborneRadio;};
		default {_personalRadio = TF_defaultGuerPersonalRadio; _riflemanRadio = TF_defaultGuerRiflemanRadio;_lrRadio = TF_defaultGuerBackpack; _airborne = TF_defaultGuerAirborneRadio;};
	};

	TFAR_tryResolveFactionClass =
	{
		private ["_prefix", "_faction", "_result", "_default"];
		_prefix = _this select 0;
		_default = _this select 1;
		_faction = faction TFAR_currentUnit;
		_result = missionNamespace getVariable (_faction + "_" + _prefix + "_tf_faction_radio");
		if (isNil "_result") then {
			if (isText (configFile >> "CfgFactionClasses" >> _faction >> (_prefix + "_tf_faction_radio_api"))) then {
				 _result = getText (configFile >> "CfgFactionClasses" >> _faction >> (_prefix + "_tf_faction_radio_api"));
			} else {
				if (isText (configFile >> "CfgFactionClasses" >> _faction >> _prefix + "_tf_faction_radio")) then {
					_result = getText (configFile >> "CfgFactionClasses" >> _faction >> (_prefix + "_tf_faction_radio"));
				} else {
					_result = _default;
				};
			};
		};
		_result
	};

	[["backpack", _lrRadio] call TFAR_tryResolveFactionClass , ["personal", _personalRadio] call TFAR_tryResolveFactionClass , ["rifleman", _riflemanRadio] call TFAR_tryResolveFactionClass, ["airborne", _airborne] call TFAR_tryResolveFactionClass];
};

TFAR_fnc_getLrChannel = {
	/*
	 	Name: TFAR_fnc_getLrChannel

	 	Author(s):
			NKey

	 	Description:
			Gets the channel for the passed radio

		Parameters:
			Array: Radio
				0: OBJECT - Radio object
				1: STRING - Radio ID

	 	Returns:
			NUMBER: Channel

	 	Example:
			_channel = (call TFAR_fnc_ActiveLrRadio) call TFAR_fnc_getLrChannel;
	*/
	#include "script.h"
	private ["_settings"];
	_settings = _this call TFAR_fnc_getLrSettings;
	_settings select ACTIVE_CHANNEL_OFFSET
};

TFAR_fnc_getLrFrequency = {
	/*
	 	Name: TFAR_fnc_getLrFrequency

	 	Author(s):
			NKey
			L-H

	 	Description:
			Gets the frequency for the active channel.

		Parameters:
			Array: Radio
				0: OBJECT - Radio object
				1: STRING - Radio ID

	 	Returns:
			NUMBER: Frequency

	 	Example:
			_frequency = (call TFAR_fnc_ActiveLrRadio) call TFAR_fnc_getLrFrequency;
	*/
	#include "script.h"
	[_this, ((_this call TFAR_fnc_getLrSettings) select ACTIVE_CHANNEL_OFFSET)+1] call TFAR_fnc_GetChannelFrequency;
};

TFAR_fnc_getLrRadioCode = {
	/*
	 	Name: TFAR_fnc_getLrRadioCode

	 	Author(s):
			NKey
			L-H

	 	Description:
			Returns the encryption code for the passed radio.

	 	Parameters:
	 	0: OBJECT - Radio

	 	Returns:
		STRING - Encryption code

	 	Example:
		(call TFAR_fnc_activeLrRadio) call TFAR_fnc_getLrRadioCode;
	*/
	((_this call TFAR_fnc_getLrSettings) select TF_CODE_OFFSET)
};

TFAR_fnc_getLrRadioProperty = {
	/*
	 	Name: TFAR_fnc_getLrRadioProperty

	 	Author(s):
			L-H

	 	Description:

	 	Parameters:
	 	0: OBJECT - Backpack/vehicle
		1: STRING - Property name

	 	Returns:
		NUMBER or TEXT- Value of property

	 	Example:
		[(vehicle player), "TF_hasLRradio"] call TFAR_fnc_getLrRadioProperty;
	*/
	private ["_radio", "_property", "_result", "_air"];
	_radio = _this select 0;
	_property = _this select 1;
	_result = _radio getVariable _property;

	if (isNil "_result") then {
		if (!(_radio isKindOf "Bag_Base")) then {
			if (isNumber (ConfigFile >> "CfgVehicles" >> (typeof _radio) >> _property)
			    or {isText (configFile >> "CfgVehicles" >> (typeof _radio) >> _property)}
			    or {isNumber (ConfigFile >> "CfgVehicles" >> (typeof _radio) >> (_property + "_api"))}
			    or {isText (ConfigFile >> "CfgVehicles" >> (typeof _radio) >> (_property + "_api"))}
			    ) exitWith {
				_radio = typeof _radio;
			    };
			_result = _radio getVariable "TF_RadioType";
			if (isNil "_result") then {
				_result = [typeof _radio, "tf_RadioType"] call TFAR_fnc_getConfigProperty;

				if (!isNil "_result" AND {_result != ""}) exitWith {};
				_air = (typeof(_radio) isKindOf "Air");
				if ((_radio call TFAR_fnc_getVehicleSide) == west) then {
					if (_air) then {
						_result = TF_defaultWestAirborneRadio;
					} else {
						_result = TF_defaultWestBackpack;
					};
				} else {
					if ((_radio call TFAR_fnc_getVehicleSide) == east) then {
						if (_air) then {
							_result = TF_defaultEastAirborneRadio;
						} else {
							_result = TF_defaultEastBackpack;
						};
					} else {
						if (_air) then {
							_result = TF_defaultGuerAirborneRadio;
						} else {
							_result = TF_defaultGuerBackpack;
						};
					};
				};
			};
			_radio = _result;
		} else {
			_radio = typeof _radio;
		};
		_result = [_radio, _property] call TFAR_fnc_getConfigProperty;
	};

	_result

};

TFAR_fnc_getLrSettings = {
	/*
	 	Name: TFAR_fnc_getLrSettings

	 	Author(s):
			NKey
			L-H

	 	Description:
			Returns the current settings for the passed radio.

	 	Parameters:
	 	0: OBJECT - Radio
		1: STRING - Radio Qualifier

	 	Returns:
		ARRAY - settings.

	 	Example:
		(call TFAR_fnc_activeLrRadio) call TFAR_fnc_getLrSettings;
	*/
	#include "script.h"
	private ["_radio_object", "_radio_qualifier", "_value", "_rc", "_radioType"];
	_radio_object = _this select 0;
	_radio_qualifier = _this select 1;
	_value = _radio_object getVariable _radio_qualifier;

	if (_radio_object isKindOf "Bag_Base") then {
		_radioType = typeof _radio_object;
	} else {
		_radioType = _radio_object getVariable "TF_RadioType";
		if (isNil "_radioType") then {
			_radioType = [typeof _radio_object, "tf_RadioType"] call TFAR_fnc_getConfigProperty;
			if ((isNil "_radioType") or {_radioType == ""}) then {
				_air = (typeof(_radio_object) isKindOf "Air");
				if ((_radio_object call TFAR_fnc_getVehicleSide) == west) then {
					if (_air) then {
						_radioType = TF_defaultWestAirborneRadio;
					} else {
						_radioType = TF_defaultWestBackpack;
					};
				} else {
					if ((_radio_object call TFAR_fnc_getVehicleSide) == east) then {
						if (_air) then {
							_radioType = TF_defaultEastAirborneRadio;
						} else {
							_radioType = TF_defaultEastBackpack;
						};
					} else {
						if (_air) then {
							_radioType = TF_defaultGuerAirborneRadio;
						} else {
							_radioType = TF_defaultGuerBackpack;
						};
					};
				};
			};
		};
	};

	if (isNil "_value") then {
		if (!(TF_use_saved_lr_setting) or (isNil "TF_saved_active_lr_settings")) then {
			if (((call TFAR_fnc_getDefaultRadioClasses select 0) == _radioType) or {(call TFAR_fnc_getDefaultRadioClasses select 3) == _radioType} or {getText(configFile >> "CfgVehicles" >> _radioType >> "tf_encryptionCode") == toLower (format ["tf_%1_radio_code",(TFAR_currentUnit call BIS_fnc_objectSide)])}) then {
				_value = (group TFAR_currentUnit) getVariable "tf_lr_frequency";
			};
			if (isNil "_value") then {
				_value = call TFAR_fnc_generateLrSettings;
			};
		} else {
			_value = TF_saved_active_lr_settings;
		};
		if (TF_use_saved_lr_setting) then {
			TF_use_saved_lr_setting = false;
		};
		_rc = _value select TF_CODE_OFFSET;
		if (isNil "_rc") then {
			private ["_code", "_hasDefaultEncryption"];
			_code = [_radio_object, "tf_encryptionCode"] call TFAR_fnc_getLrRadioProperty;
			_hasDefaultEncryption = (_code == "tf_west_radio_code") or {_code == "tf_east_radio_code"} or {_code == "tf_guer_radio_code"};
			if (_hasDefaultEncryption and {((TFAR_currentUnit call BIS_fnc_objectSide) != civilian)}) then {
				if (((call TFAR_fnc_getDefaultRadioClasses select 0) == _radioType) or {(call TFAR_fnc_getDefaultRadioClasses select 3) == _radioType} or {_radio_object call TFAR_fnc_getVehicleSide == TFAR_currentUnit call BIS_fnc_objectSide}) then {
					_rc = missionNamespace getVariable format ["tf_%1_radio_code",(TFAR_currentUnit call BIS_fnc_objectSide)];
				}else{
					_rc = missionNamespace getVariable [_code, ""];
				};
			} else {
				_rc = "";
				if (_code != "") then {
					_rc = missionNamespace getVariable [_code, ""];
				};
			};

			_value set [TF_CODE_OFFSET, _rc];
		};
		[_radio_object, _radio_qualifier, + _value] call TFAR_fnc_setLrSettings;
	};
	_value
};

TFAR_fnc_getLrSpeakers = {
	/*
	 	Name: TFAR_fnc_getLrSpeakers

	 	Author(s):
			NKey

	 	Description:
			Gets the speakers setting of the passed radio

		Parameters:
			Array: Radio
				0: OBJECT - Radio object
				1: STRING - Radio ID

	 	Returns:
			BOOLEAN : speakers or headphones

	 	Example:
			_speakers = (call TFAR_fnc_ActiveLrRadio) call TFAR_fnc_getLrSpeakers;
	*/
	#include "script.h"
	private ["_settings", "_result"];
	_settings = _this call TFAR_fnc_getLrSettings;
	_result = false;
	if (count _settings > TF_LR_SPEAKER_OFFSET) then {
		_result = _settings select TF_LR_SPEAKER_OFFSET;
	};
	_result
};

TFAR_fnc_getLrStereo = {
	/*
	 	Name: TFAR_fnc_getLrStereo

	 	Author(s):
			NKey

	 	Description:
			Gets the stereo setting of the passed radio

		Parameters:
			Array: Radio
				0: OBJECT - Radio object
				1: STRING - Radio ID

	 	Returns:
			NUMBER: Stereo setting : Range (0,2) (0 - Both, 1 - Left, 2 - Right)

	 	Example:
			_stereo = (call TFAR_fnc_ActiveLrRadio) call TFAR_fnc_getLrStereo;
	*/
	#include "script.h"
	private ["_settings", "_result"];
	_settings = _this call TFAR_fnc_getLrSettings;
	_result = 0;
	if (count _settings > TF_LR_STEREO_OFFSET) then {
		_result = _settings select TF_LR_STEREO_OFFSET;
	};
	_result
};

TFAR_fnc_getLrVolume = {
	/*
	 	Name: TFAR_fnc_getLrVolume

	 	Author(s):
			NKey

	 	Description:
			Gets the volume of the passed radio

		Parameters:
			Array: Radio
				0: OBJECT - Radio object
				1: STRING - Radio ID

	 	Returns:
			NUMBER: Volume : range (0,10)

	 	Example:
			_volume = (call TFAR_fnc_ActiveLrRadio) call TFAR_fnc_getLrVolume;
	*/
	#include "script.h"
	private ["_settings"];
	_settings = _this call TFAR_fnc_getLrSettings;
	_settings select VOLUME_OFFSET
};

#endif
//VOICE_DISABLE_LEGACYCODE

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


#ifndef VOICE_DISABLE_LEGACYCODE
TFAR_fnc_getRadioOwner = {
	/*
	 	Name: TFAR_fnc_getRadioOwner

	 	Author(s):
			L-H

	 	Description:
			Gets the owner of a SW radio.

	 	Parameters:
			STRING - radio classname

	 	Returns:
			STRING - UID of owner of radio

	 	Example:
			_owner = (call TFAR_fnc_activeSwRadio) call TFAR_fnc_getRadioOwner;
	*/
	#include "script.h"
	private "_settings";
	_settings = (_this call TFAR_fnc_getSwSettings);
	if (count _settings > RADIO_OWNER) exitWith {
		((_this call TFAR_fnc_getSwSettings) select RADIO_OWNER)
	};

	""
};

TFAR_fnc_getSideRadio = {
	/*
	 	Name: TFAR_fnc_getSideRadio

	 	Author(s):
			L-H

	 	Description:
			Returns the default radio for the passed side.

	 	Parameters:
			0: SIDE - side
			1: NUMBER - radio type : Range [0,2] (0 - LR, 1 - SW, 2 - Rifleman)

	 	Returns:
			STRING/OBJECT - Default Radio

	 	Example:
			_defaultLRRadio = [side player, 0] call TFAR_fnc_getSideRadio;
			_defaultSWRadio = [side player, 1] call TFAR_fnc_getSideRadio;
			_defaultRiflemanRadio = [side player, 2] call TFAR_fnc_getSideRadio;
	*/
	private ["_side", "_radioType", "_result", "_variable"];
	_side = _this select 0;
	_radioType = _this select 1;
	_result = "";

	_variable = "TF_default" + str(_side);

	switch (_radioType) do {
		case 0: {
			_result = missionNamespace getVariable (_variable + "Backpack");
		};
		case 1: {
			_result = missionNamespace getVariable (_variable + "PersonalRadio");
		};
		case 2:	{
			_result = missionNamespace getVariable (_variable + "RiflemanRadio");
		};
	};

	_result
};

TFAR_fnc_getSwChannel = {
	/*
	 	Name: TFAR_fnc_getSwChannel

	 	Author(s):
			NKey

	 	Description:
			Gets the channel for the passed radio

		Parameters:
			STRING: Radio classname

	 	Returns:
			NUMBER: Channel

	 	Example:
			_channel = (call TFAR_fnc_ActiveSwRadio) call TFAR_fnc_getSwChannel;
	*/
	#include "script.h"
	private ["_settings"];
	_settings = _this call TFAR_fnc_getSwSettings;
	_settings select ACTIVE_CHANNEL_OFFSET
};

TFAR_fnc_getSwFrequency = {
	/*
	 	Name: TFAR_fnc_getSwFrequency

	 	Author(s):
			NKey
			L-H

	 	Description:
			Gets the frequency for the active channel.

		Parameters:
			STRING: Radio classname

	 	Returns:
			NUMBER: Frequency

	 	Example:
			_frequency = (call TFAR_fnc_ActiveSwRadio) call TFAR_fnc_getSwFrequency;
	*/
	#include "script.h"
	[_this, ((_this call TFAR_fnc_getSwSettings) select ACTIVE_CHANNEL_OFFSET)+1] call TFAR_fnc_GetChannelFrequency;
};

TFAR_fnc_getSwRadioCode = {
	/*
	 	Name: TFAR_fnc_getSwRadioCode

	 	Author(s):
			NKey
			L-H

	 	Description:
			Returns the encryption code for the passed radio.

	 	Parameters:
	 	0: STRING - Radio classname

	 	Returns:
		STRING - Encryption code

	 	Example:
		(call TFAR_fnc_activeSwRadio) call TFAR_fnc_getSwRadioCode;
	*/
	((_this call TFAR_fnc_getSwSettings) select TF_CODE_OFFSET)
};

TFAR_fnc_getSwSettings = {
	/*
	 	Name: TFAR_fnc_getSwSettings

	 	Author(s):
			NKey
			L-H

	 	Description:
			Returns the current settings for the passed radio.

	 	Parameters:
	 	0: String - Radio classname

	 	Returns:
		ARRAY - settings.

	 	Example:
		(call TFAR_fnc_activeSwRadio) call TFAR_fnc_getSwSettings;
	*/
	#include "script.h"
	private ["_variableName", "_value", "_rc"];
	_variableName = format["%1_settings", _this];
	_value = missionNamespace getVariable _variableName;
	if (isNil "_value") then {
		if (!(TF_use_saved_sw_setting) or (isNil "TF_saved_active_sw_settings")) then {
			private ["_parent", "_defaultRadios"];
			_defaultRadios = call TFAR_fnc_getDefaultRadioClasses;
			_parent = getText (ConfigFile >> "CfgWeapons" >> _this >> "tf_parent");
			if ((_defaultRadios select 1) == _parent or {(_defaultRadios select 2) == _parent}) then {
				_value = (group TFAR_currentUnit) getVariable "tf_sw_frequency";
			};
			if (isNil "_value") then {
				_value = call TFAR_fnc_generateSwSettings;
			};
		} else {
			_value = TF_saved_active_sw_settings;
		};
		if (TF_use_saved_sw_setting) then {
			TF_use_saved_sw_setting = false;
		};
		_rc = _value select TF_CODE_OFFSET;
		if (isNil "_rc") then {
			private ["_parent", "_code", "_hasDefaultEncryption"];
			_code = getText (ConfigFile >>  "CfgWeapons" >> _this >> "tf_encryptionCode");
			_hasDefaultEncryption = (_code == "tf_west_radio_code") or {_code == "tf_east_radio_code"} or {_code == "tf_guer_radio_code"};
			if (_hasDefaultEncryption and {(TFAR_currentUnit call BIS_fnc_objectSide) != civilian}) then {
				_parent = getText (ConfigFile >> "CfgWeapons" >> _this >> "tf_parent");
				private "_default";
				_default = call TFAR_fnc_getDefaultRadioClasses;
				if ((_default select 1) == _parent or {(_default select 2) == _parent}) then {
					_rc = missionNamespace getVariable format ["tf_%1_radio_code", (TFAR_currentUnit call BIS_fnc_objectSide)];
				}else{
					_rc = missionNamespace getVariable [_code, ""];
				};
			} else {
				_rc = "";
				if (_code != "") then {
					_rc = missionNamespace getVariable [_code, ""];
				};
			};
			_value set [TF_CODE_OFFSET, _rc];
		};
		[_this, _value, true] call TFAR_fnc_setSwSettings;
	};
	_value
};

TFAR_fnc_getSwSpeakers = {
	/*
	 	Name: TFAR_fnc_getSwSpeakers

	 	Author(s):
			NKey

	 	Description:
			Gets the speakers setting of the passed radio

		Parameters:
			STRING: Radio classname

	 	Returns:
			BOOLEAN: speakers or headphones

	 	Example:
			_stereo = (call TFAR_fnc_ActiveSwRadio) call TFAR_fnc_getSwSpeakers;
	*/
	#include "script.h"
	private ["_settings", "_result"];
	_settings = _this call TFAR_fnc_getSwSettings;
	_result = false;
	if (count _settings > TF_SW_SPEAKER_OFFSET) then {
		_result = _settings select TF_SW_SPEAKER_OFFSET;
	};
	_result
};

TFAR_fnc_getSwStereo = {
	/*
	 	Name: TFAR_fnc_getSwStereo

	 	Author(s):
			NKey

	 	Description:
			Gets the stereo setting of the passed radio

		Parameters:
			STRING: Radio classname

	 	Returns:
			NUMBER: Stereo setting : Range (0,2) (0 - Both, 1 - Left, 2 - Right)

	 	Example:
			_stereo = (call TFAR_fnc_ActiveSwRadio) call TFAR_fnc_getSwStereo;
	*/
	#include "script.h"
	private ["_settings", "_result"];
	_settings = _this call TFAR_fnc_getSwSettings;
	_result = 0;
	if (count _settings > TF_SW_STEREO_OFFSET) then {
		_result = _settings select TF_SW_STEREO_OFFSET;
	};
	_result
};

TFAR_fnc_getSwVolume = {
	/*
	 	Name: TFAR_fnc_getSwVolume

	 	Author(s):
			NKey

	 	Description:
			Gets the volume of the passed radio

		Parameters:
			STRING: Radio classname

	 	Returns:
			NUMBER: Volume : range (0,10)

	 	Example:
			_volume = (call TFAR_fnc_ActiveSwRadio) call TFAR_fnc_getSwVolume;
	*/
	#include "script.h"
	private ["_settings"];
	_settings = _this call TFAR_fnc_getSwSettings;
	_settings select VOLUME_OFFSET
};

TFAR_fnc_getTransmittingDistanceMultiplicator = {
	/*
	 	Name: TFAR_fnc_getTransmittingDistanceMultiplicator

	 	Author(s):
			NKey

	 	Description:
			Return multiplicator for sending distance of radio.

		Parameters:
			Nothing

	 	Returns:
			Nothing

	 	Example:
			call TFAR_fnc_getTransmittingDistanceMultiplicator;
	*/
	private ["_result"];
	_result = TFAR_currentUnit getVariable "tf_sendingDistanceMultiplicator";
	if (isNil "_result") then {
		_result = 1.0;
	};
	_result;
};

TFAR_fnc_getVehicleSide = {
	/*
	 	Name: TFAR_fnc_getVehicleSide

	 	Author(s):
			NKey

	 	Description:
			Returns the side of the vehicle, based on the vehicle model and not who has captured it.
			Also takes into account a variable on the vehicle (tf_side)

	 	Parameters:
			OBJECT: vehicle

	 	Returns:
			SIDE: side of vehicle

	 	Example:
			_vehicleSide = (vehicle player) call TFAR_fnc_getVehicleSide;
	*/
	private ["_result", "_side"];
	_side = _this getVariable "tf_side";
	if !(isNil "_side") then {
		switch(_side) do {
			case "west": {
				_result = west;
			};
			case "east": {
				_result = east;
			};
			default {
				_result = resistance;
			};
		};
	} else {
		_result = [getNumber(configFile >> "CfgVehicles" >> typeOf(_this) >> "side")] call BIS_fnc_sideType;
	};
	_result
};

TFAR_fnc_hasVehicleRadio = {
	/*
	 	Name: TFAR_fnc_hasVehicleRadio

	 	Author(s):
			NKey

	 	Description:
			Checks _this for LW radio presence

		Parameters:
			OBJECT: Vehicle to check

	 	Returns:
			BOOL: True|False

	 	Example:
			_present = (vehicle player) call TFAR_fnc_hasVehicleRadio;;
	*/

	private "_result";
	_result = _this getVariable "tf_hasRadio";
	if (isNil "_result") then {
		_result = ([(typeof _this), "tf_hasLRradio", 0] call TFAR_fnc_getConfigProperty == 1);
	};
	_result
};

TFAR_fnc_haveDDRadio = {
	/*
	 	Name: TFAR_fnc_haveDDRadio

	 	Author(s):

	 	Description:
			Returns whether the player has a DD radio.

	 	Parameters:
		Nothing

	 	Returns:
		Bool

	 	Example:
		_hasDD = call TFAR_fnc_haveDDRadio;
	 */
	 if (isNil {TFAR_currentUnit} || {isNull (TFAR_currentUnit)}) exitWith{false};
	private ["_currentVest", "_rebreather"];
	if (isNil "TF_dd_frequency") then {
		TF_dd_frequency = (group TFAR_currentUnit) getVariable "tf_dd_frequency";
	};
	if ((vest TFAR_currentUnit) == "V_RebreatherB") exitWith {true};
	_rebreather = configFile >> "CfgWeapons" >> "V_RebreatherB";
	_currentVest = configFile >> "CfgWeapons" >> (vest TFAR_currentUnit);
	[_currentVest, _rebreather] call CBA_fnc_inheritsFrom

};

TFAR_fnc_haveLRRadio = {
	/*
	 	Name: TFAR_fnc_haveLRRadio

	 	Author(s):

	 	Description:
			Returns whether the player has a LR radio

	 	Parameters:
		Nothing

	 	Returns:
		BOOLEAN

	 	Example:
		_hasLR = call TFAR_fnc_haveLRRadio;
	 */
	if (isNil {TFAR_currentUnit} || {isNull (TFAR_currentUnit)}) exitWith{false};
	count (TFAR_currentUnit call TFAR_fnc_lrRadiosList) > 0

};

TFAR_fnc_haveProgrammator = {
	/*
	    Name: TFAR_fnc_haveProgrammator

	    Author(s):

	    Description:
	    Returns whether the player has a programmer

	    Parameters:
	    Nothing

	    Returns:
	    BOOLEAN

	    Example:
	    _hasProgrammer = call TFAR_fnc_haveProgrammator;
	*/
	if (isNil {TFAR_currentUnit} || {isNull (TFAR_currentUnit)}) exitWith{false};
	"tf_microdagr" in (assignedItems TFAR_currentUnit);

};

TFAR_fnc_haveSWRadio = {
	/*
	 	Name: TFAR_fnc_haveSWRadio

	 	Author(s):

	 	Description:
			Returns whether the player has a SW radio

	 	Parameters:
		Nothing

	 	Returns:
		BOOLEAN

	 	Example:
		_hasSW = call TFAR_fnc_haveSWRadio;
	 */
	private ["_result"];
	_result = false;
	if (isNil {TFAR_currentUnit} || {isNull (TFAR_currentUnit)}) exitWith{false};
	{
		if (_x call TFAR_fnc_isRadio) exitWith {_result = true};
		true;
	} count (assignedItems TFAR_currentUnit);
	_result

};

TFAR_fnc_HideHint = {
	/*
	 	Name: TFAR_fnc_HideHint

	 	Author(s):
			L-H

	 	Description:
		Removes the hint from the bottom right

	 	Parameters:
		Nothing

	 	Returns:
		Nothing

	 	Example:
		call TFAR_fnc_HideHint;
	 */
	("TFAR_HintLayer" call BIS_fnc_rscLayer) cutText ["", "PLAIN"];
};

TFAR_fnc_initialiseBaseModule = {
	/*
	 	Name: TFAR_fnc_initialiseBaseModule

	 	Author(s):
			L-H

	 	Description:
			Initialises variables based on module settings.

	 	Parameters:

	 	Returns:
			Nothing

	 	Example:

	 */
	//#include "common.sqf"
	private ["_logic", "_activated"];
	_logic = [_this,0,objNull,[objNull]] call BIS_fnc_param;
	_units = [_this,1,[],[[]]] call BIS_fnc_param;
	_activated = [_this,2,true,[true]] call BIS_fnc_param;

	if (_activated) then {
		private ["_LRradio","_radio", "_currentSide", "_swFreq", "_lrFreq", "_freqs","_randomFreqs"];

		_swFreq = false call TFAR_fnc_generateSwSettings;
		_freqs = call compile (_logic getVariable "PrFreq");
		_randomFreqs = [TF_MAX_CHANNELS,TF_MAX_SW_FREQ,TF_MIN_SW_FREQ,TF_FREQ_ROUND_POWER] call TFAR_fnc_generateFrequencies;
		while {count _freqs < TF_MAX_CHANNELS} do {
			_freqs set [count _freqs, _randomFreqs select (count _freqs)];
		};
		_swFreq set [2,_freqs];

		_lrFreq = false call TFAR_fnc_generateLrSettings;
		_freqs = call compile (_logic getVariable "LrFreq");
		_randomFreqs = [TF_MAX_LR_CHANNELS,TF_MAX_ASIP_FREQ,TF_MIN_ASIP_FREQ,TF_FREQ_ROUND_POWER] call TFAR_fnc_generateFrequencies;
		while {count _freqs < TF_MAX_LR_CHANNELS} do {
			_freqs set [count _freqs, _randomFreqs select (count _freqs)];
		};
		_lrFreq set [2,_freqs];

		_LRradio = _logic getVariable "LRradio";
		_radio = _logic getVariable "Radio";
		_currentSide = "North";

		tf_same_sw_frequencies_for_side = true;
		tf_same_lr_frequencies_for_side = true;

		_RiflemanRadio = _logic getVariable "RiflemanRadio";
		_radio_code = _logic getVariable "Encryption";
		if (([_LRradio, "tf_hasLrRadio",0] call TFAR_fnc_getConfigProperty) != 1) then {
			diag_log format ["TFAR ERROR: %1 is not a valid LR radio", _LRradio];
			hint format ["TFAR ERROR: %1 is not a valid LR radio", _LRradio];
			_LRradio = "-1";
		};
		if (getNumber (ConfigFile >> "CfgWeapons" >> _radio >> "tf_prototype") != 1) then {
			diag_log format ["TFAR ERROR: %1 is not a valid personal radio", _radio];
			hint format ["TFAR ERROR: %1 is not a valid personal radio", _radio];
			_radio = "-1";
		};
		{
			if ((str _currentSide) != (str side _x)) then {
				_currentSide = side _x;
				if (_currentSide == independent || {_currentSide == civilian}) then {
					_currentSide = "guer";
				};

				missionNamespace setVariable [format ["TF_default%1RiflemanRadio", _currentSide], _RiflemanRadio];
				missionNamespace setVariable [format ["TF_%1_radio_code", _currentSide], _radio_code];
				if (_LRradio != "-1") then {
					missionNamespace setVariable [format ["TF_default%1Backpack", _currentSide], _LRradio];
				};
				if (_radio != "-1") then {
					missionNamespace setVariable [format ["TF_default%1PersonalRadio", _currentSide], _radio];
				};

				if (isServer) then {
					if (!isNil (format ["tf_freq_%1", _currentSide])) then {hint "TFAR - tf_freq_west already set, module overriding.";diag_log "TFAR - tf_freq_west already set, module overriding.";};
					if (!isNil (format ["tf_freq_%1_lr", _currentSide])) then {hint "TFAR - tf_freq_west_lr already set, module overriding.";diag_log "TFAR - tf_freq_west_lr already set, module overriding.";};
					missionNamespace setVariable [format ["tf_freq_%1", _currentSide], _swFreq];
					missionNamespace setVariable [format ["tf_freq_%1_lr", _currentSide], _lrFreq];
				};
			};
			true;
		} count _units;
	};

	true
};

TFAR_fnc_initialiseEnforceUsageModule = {
	/*
	 	Name: TFAR_fnc_initialiseEnforceUsageModule

	 	Author(s):
			L-H

	 	Description:
			Initialises variables based on module settings.

	 	Parameters:

	 	Returns:
			Nothing

	 	Example:

	 */
	private ["_logic", "_activated"];
	_logic = [_this,0,objNull,[objNull]] call BIS_fnc_param;
	_activated = [_this,2,true,[true]] call BIS_fnc_param;

	if (_activated) then {
		tf_no_auto_long_range_radio = !(_logic getVariable "TeamLeaderRadio");
		TF_give_personal_radio_to_regular_soldier = !(_logic getVariable "RiflemanRadio");

		TF_terrain_interception_coefficient = (_logic getVariable "terrain_interception_coefficient");
		tf_radio_channel_name = (_logic getVariable "radio_channel_name");
		tf_radio_channel_password = (_logic getVariable "radio_channel_password");

		if (isServer) then {
			tf_same_sw_frequencies_for_side = (_logic getVariable "same_sw_frequencies_for_side");
			tf_same_lr_frequencies_for_side = (_logic getVariable "same_lr_frequencies_for_side");
		};
	};

	true
};

TFAR_fnc_initialiseFreqModule = {
	/*
	 	Name: TFAR_fnc_initialiseFreqModule

	 	Author(s):
			L-H

	 	Description:
			Initialises variables based on module settings.

	 	Parameters:

	 	Returns:
			Nothing

	 	Example:

	 */
	//#include "common.sqf"
	private ["_logic", "_activated", "_units"];
	_logic = [_this,0,objNull,[objNull]] call BIS_fnc_param;
	_units = [_this,1,[],[[]]] call BIS_fnc_param;
	_activated = [_this,2,true,[true]] call BIS_fnc_param;

	if (_activated) then {
		if (count _units == 0) exitWith { hint "TFAR - No units set for Frequency Module";diag_log "TFAR - No units set for Frequency Module";};
		if (isServer) then {
			private ["_swFreq", "_lrFreq", "_freqTest", "_freqs", "_randomFreqs"];

			_swFreq = false call TFAR_fnc_generateSwSettings;
			_freqs = call compile (_logic getVariable "PrFreq");
			_randomFreqs = [TF_MAX_CHANNELS,TF_MAX_SW_FREQ,TF_MIN_SW_FREQ,TF_FREQ_ROUND_POWER] call TFAR_fnc_generateFrequencies;
			while {count _freqs < TF_MAX_CHANNELS} do {
				_freqs set [count _freqs, _randomFreqs select (count _freqs)];
			};
			_swFreq set [2,_freqs];

			_lrFreq = false call TFAR_fnc_generateLrSettings;
			_freqs = call compile (_logic getVariable "LrFreq");
			_randomFreqs = [TF_MAX_LR_CHANNELS,TF_MAX_ASIP_FREQ,TF_MIN_ASIP_FREQ,TF_FREQ_ROUND_POWER] call TFAR_fnc_generateFrequencies;
			while {count _freqs < TF_MAX_LR_CHANNELS} do{
				_freqs set [count _freqs, _randomFreqs select (count _freqs)];
			};
			_lrFreq set [2,_freqs];

			{
				_freqTest = (group _x) getVariable "tf_sw_frequency";
				if (!isNil "_freqTest") then {hint format["TFAR - tf_sw_frequency already set, might be assigning a group (%1) to multiple frequency modules.", (group _x)];diag_log format["TFAR - tf_sw_frequency already set, might be assigning a group (%1) to multiple frequency modules.", (group _x)];};

				_freqTest = (group _x) getVariable "tf_lr_frequency";
				if (!isNil "_freqTest") then {hint format["TFAR - tf_lr_frequency already set, might be assigning a group (%1) to multiple frequency modules.", (group _x)];diag_log format["TFAR - tf_lr_frequency already set, might be assigning a group (%1) to multiple frequency modules.", (group _x)];};

				(group _x) setVariable ["tf_sw_frequency", _swFreq, true];
				(group _x) setVariable ["tf_lr_frequency", _lrFreq, true];
				true;
			} count _units;
		};
	};

	true
};

TFAR_fnc_inWaterHint = {
	[parseText (localize "STR_in_water_hint"), 5] call TFAR_fnc_showHint;
};

TFAR_fnc_isAbleToUseRadio = {
	private ["_result"];
	_result = TFAR_currentUnit getVariable "tf_unable_to_use_radio";
	if (isNil "_result") then {
		_result = false;
	};
	_result
};

TFAR_fnc_isForcedCurator = {
	/*
	 	Name: TFAR_fnc_isForcedCurator

	 	Author(s):
			Nkey

	 	Description:
			Return if unit if forced curator.

		Parameters:
			OBJECT: unit to check

	 	Returns:
			BOOLEN: is unit forced curator

	 	Example:
			player call TFAR_fnc_isForcedCurator;
	*/
	private ["_result"];
	_result = _this getVariable "tf_forcedCurator";
	if (isNil "_result") then {
		_result = ((typeof _this) == "VirtualCurator_F") || ([configFile >> "CfgVehicles" >> (typeof _this), configFile >> "CfgVehicles" >> "VirtualCurator_F"] call CBA_fnc_inheritsFrom);
		_this setVariable ["tf_forcedCurator", _result];
	};
	 _result
};


TFAR_fnc_isRadio = {
	/*
	 	Name: TFAR_fnc_isRadio

	 	Author(s):
			NKey
			L-H

	 	Description:
			Checks whether the passed radio is a TFAR radio.

		Parameters:
			STRING - Radio classname

	 	Returns:
			BOOLEAN

	 	Example:
			_isRadio = "NotARadioClass" call TFAR_fnc_isRadio;
	*/
	private "_result";
	_result = getNumber (configFile >> "CfgWeapons" >> _this >> "tf_radio");
	if (isNil "_result") then {
		_result = 0;
	};

	(_result == 1)
};

TFAR_fnc_isSameRadio = {
	/*
	 	Name: TFAR_fnc_isSameRadio

	 	Author(s):
			L-H

	 	Description:
			Checks whether the two passed radios have the same prototype radio

	 	Parameters:
			0: STRING - radio classname
			1: STRING - radio classname

	 	Returns:
			BOOLEAN - same parent radio

	 	Example:
			if([(call TFAR_fnc_activeSwRadio),"tf_fadak"] call TFAR_fnc_isSameRadio) then {
				hint "same parent radio";
			};
	*/
	private ["_radio1", "_radio2"];
	_radio1 = _this select 0;
	_radio2 = _this select 1;

	if !(_radio1 call TFAR_fnc_isPrototypeRadio) then {
		_radio1 = configName inheritsFrom (configFile >> "CfgWeapons" >> _radio1);
	};
	if !(_radio2 call TFAR_fnc_isPrototypeRadio) then {
		_radio2 = configName inheritsFrom (configFile >> "CfgWeapons" >> _radio2);
	};

	(_radio2 == _radio1)
};

TFAR_fnc_isSpeaking = {
	/*
	 	Name: TFAR_fnc_isSpeaking

	 	Author(s):
			L-H

	 	Description:
			Check whether a unit is speaking

		Parameters:
			OBJECT - Unit

	 	Returns:
			BOOLEAN - If the unit is speaking

	 	Example:
			if (player call TFAR_fnc_isSpeaking) then {
				hint "You are speaking";
			};
	*/
	(("task_force_radio_pipe" callExtension format ["IS_SPEAKING	%1", name _this]) == "SPEAKING")
};

TFAR_fnc_isTeamSpeakPluginEnabled = {
	/*
	 	Name: TFAR_fnc_isTeamSpeakPluginEnabled

	 	Author(s):
			NKey

	 	Description:
			Returns is TeamSpeak plugin enabled on client.

		Parameters:
			Nothing

	 	Returns:
			BOOLEAN: enabled or not

	 	Example:
			call TFAR_fnc_isTeamSpeakPluginEnabled;
	*/
	("task_force_radio_pipe" callExtension "TS_INFO	PING") == "PONG"
};

TFAR_fnc_isTurnedOut = {
	// by commy2 v0.4

	private "_fnc_getTurrets";

	_fnc_getTurrets = {
	        private ["_vehicle", "_config", "_turrets", "_fnc_addTurrets"];

	        _vehicle = _this select 0;

	        _config = configFile >> "CfgVehicles" >> typeOf _vehicle;

	        _turrets = [];

	        _fnc_addTurret = {
	                private ["_config", "_path", "_count", "_index"];

	                _config = _this select 0;
	                _path = _this select 1;

	                _config = _config >> "Turrets";
	                _count = count _config;

	                for "_index" from 0 to (_count - 1) do {
	                        _turrets set [count _turrets, _path + [_index]];
	                        [_config select _index, [_index]] call _fnc_addTurret;
	                };
	        };

	        [_config, []] call _fnc_addTurret;

	        _turrets
	};

	private "_fnc_getTurretIndex";

	_fnc_getTurretIndex = {
	        private ["_unit", "_vehicle", "_turrets", "_units", "_index"];

	        _unit = _this select 0;
	        _vehicle = vehicle _unit;

	        _turrets = [_vehicle] call _fnc_getTurrets;

	        _units = [];
	        {
	                _units set [count _units, _vehicle turretUnit _x];
	        } forEach _turrets;

	        _index = _units find _unit;

	        if (_index == -1) exitWith {[]};

	        _turrets select _index;
	};

	private ["_unit", "_vehicle", "_config", "_animation", "_action", "_inAction", "_turretIndex", "_count", "_index", "_result"];

	_unit = _this select 0;
	_vehicle = vehicle _unit;
	_config = configFile >> "CfgVehicles" >> typeOf _vehicle;
	_result = false;

	if (_vehicle== _unit) then {
		_result = true;
	} else {
		if ((driver _vehicle == _unit) && {getNumber(_config >> "forceHideDriver") == 1}) then {
			_result = false;
		} else {
			if ((commander _vehicle == _unit) && {getNumber(_config >> "forceHideCommander") == 1}) then {
				_result = false;
			} else {
				_animation = animationState _unit;

				if (_unit == driver _vehicle) then {
						_action = getText (_config >> "driverAction");
						_inAction = getText (_config >> "driverInAction");
				} else {
						_turretIndex = [_unit] call _fnc_getTurretIndex;

						_count = count _turretIndex;

						for "_index" from 0 to (_count - 1) do {
								_config = _config >> "Turrets";
								_config = _config select (_turretIndex select _index);
						};

						_action = getText (_config >> "gunnerAction");
						_inAction = getText (_config >> "gunnerInAction");
				};

				if (_action == "" || {_inAction == ""} || {_action == _inAction}) exitWith {_result = false};

				_animation = toArray _animation;
				_animation resize (count toArray _action);
				_animation = toString _animation;
				_result = (_animation == _action);
			};
		};
	};
	_result;



};

TFAR_fnc_isVehicleIsolated = {
	/*
	 	Name: TFAR_fnc_isVehicleIsolated

	 	Author(s):
			NKey

	 	Description:
			Checks whether the vehicle is isolated.

		Parameters:
			OBJECT - The vehicle

	 	Returns:
			BOOLEAN

	 	Example:
			_isolated = (vehicle player) call TFAR_fnc_isVehicleIsolated;
	*/
	private ["_isolated"];

	_isolated = [(typeof _this), "tf_isolatedAmount", 0.0] call TFAR_fnc_getConfigProperty;

	_isolated > 0.5
};

TFAR_fnc_lrRadioMenu = {
	private ["_menuDef","_positions","_active_radio","_submenu","_command","_pos","_menu","_position"];
	_menu = [];
	if (count (TFAR_currentUnit call TFAR_fnc_lrRadiosList) > 1) then {
		_menuDef = ["main", localize "STR_select_lr_radio", "buttonList", "", false];
		_positions = [];
		_pos = 0;
		{
			_command = format["TF_lr_dialog_radio = (TFAR_currentUnit call TFAR_fnc_lrRadiosList) select %1;call TFAR_fnc_onLrDialogOpen;", _pos];
			_submenu = "";
			_active_radio = call TFAR_fnc_activeLrRadio;
			if (((_x select 0) != (_active_radio select 0)) or ((_x select 1) != (_active_radio select 1))) then {
				_command = format["TF_lr_dialog_radio = (TFAR_currentUnit call TFAR_fnc_lrRadiosList) select %1;", _pos];
				_submenu = "_this call TFAR_fnc_lrRadioSubMenu";
			};
			_position = [
				getText(configFile >> "CfgVehicles"  >> typeof(_x select 0) >> "displayName"),
				_command,
				getText(configFile >> "CfgVehicles"  >> typeof(_x select 0) >> "picture"),
				"",
				_submenu,
				-1,
				true,
				true
			];
			_positions set [count _positions, _position];
			_pos = _pos + 1;
			true;
		} count (TFAR_currentUnit call TFAR_fnc_lrRadiosList);
		_menu =
		[
			_menuDef,
			_positions
		];
	} else {
		if (call TFAR_fnc_haveLRRadio) then {
			TF_lr_dialog_radio = call TFAR_fnc_activeLrRadio;
			call TFAR_fnc_onLrDialogOpen;
		};
	};
	_menu
};

TFAR_fnc_lrRadiosList = {
	private ["_result", "_active_lr", "_vehicle_lr", "_backpack_lr", "_backpack_check", "_vehicle_check"];
	_result = [];
	_active_lr = nil;
	if (!isNil "TF_lr_active_radio") then {
		_active_lr = TF_lr_active_radio;
	};
	_vehicle_lr = _this call TFAR_fnc_vehicleLr;

	_backpack_check = {
		_backpack_lr = _this call TFAR_fnc_backpackLr;
		if (count _backpack_lr > 0) then {
			_result set [count _result, _backpack_lr];
		};
	};

	_vehicle_check = {
		if (count _this > 0) then {
			_result set [count _result, _this];
		};
	};

	if (!(isNil "_active_lr") and {count _vehicle_lr > 0} and {(_active_lr select 0) == (_vehicle_lr select 0)} and {(_active_lr select 1) == (_vehicle_lr select 1)}) then {
		_result set [count _result, _active_lr];
		call _backpack_check;
	} else {
		call _backpack_check;
		_vehicle_lr call _vehicle_check;
	};

	if ((player call TFAR_fnc_isForcedCurator) and {TFAR_currentUnit == player}) then {
		if !(isNil "TF_curator_backpack_1") then {
			_result pushBack [TF_curator_backpack_1, "TF_curatorBackPack"];
		};
		if !(isNil "TF_curator_backpack_2") then {
			_result pushBack [TF_curator_backpack_2, "TF_curatorBackPack"];
		};
		if !(isNil "TF_curator_backpack_3") then {
			_result pushBack [TF_curator_backpack_3, "TF_curatorBackPack"];
		};
	};

	_result
};

TFAR_fnc_lrRadioSubMenu = {
	private ["_submenu"];
	_submenu =
	[
		["secondary", localize "STR_select_action", "buttonList", "", false],
		[
			[localize "STR_select_action_setup", "call TFAR_fnc_onLrDialogOpen;", "", localize "STR_select_action_setup_tooltip", "", -1, true, true],
			[localize "STR_select_action_use", "TF_lr_dialog_radio call TFAR_fnc_setActiveLrRadio;[(call TFAR_fnc_activeLrRadio), true] call TFAR_fnc_ShowRadioInfo;", "", localize "STR_select_action_use_tooltip", "", -1, true, true]
		]
	];
	_submenu
};

TFAR_fnc_objectInterception = {
	#include "script.h"
	private ["_result", "_s"];

	KK_fnc_inString = {
	    private ["_needle","_haystack","_needleLen","_hay","_found"];
	    _needle = [_this, 0, "", [""]] call BIS_fnc_param;
	    _haystack = toArray ([_this, 1, "", [""]] call BIS_fnc_param);
	    _needleLen = count toArray _needle;
	    _hay = +_haystack;
	    _hay resize _needleLen;
	    _found = false;
	    for "_i" from _needleLen to count _haystack do {
	        if (toString _hay == _needle) exitWith {_found = true};
	        _hay set [_needleLen, _haystack select _i];
	        _hay set [0, "x"];
	        _hay = _hay - ["x"]
	    };
	    _found
	};

	_result = "";
	{
		if ((_x isKindOf "Static") or {_x isKindOf "AllVehicles"}) then {
			if (!(_x isKindOf "Lamps_Base_F") and {!(_x isKindOf "PowerLines_base_F")}) then {
				_result = _result + "wall|";
			};
		} else {
			if ((typeOf _x) == "") then {
				_result = _result + str(_x) + "|";
				//(if ((["wall", _s] call KK_fnc_inString)
				//	or {["city", _s] call KK_fnc_inString}
				//	or {["rock", _s] call KK_fnc_inString}
				//	or {["wreck", _s] call KK_fnc_inString}
				//	or {["cargo", _s] call KK_fnc_inString}
				//	or {["stone", _s] call KK_fnc_inString}) then {
				//	_result = _result + 1;
				//};
			};
		};
		true;
	} count (lineIntersectsWith  [eyepos TFAR_currentUnit, eyepos _this, TFAR_currentUnit, _this]);

	_result;
};

TFAR_fnc_onAdditionalLRTangentPressed = {
	private["_freq","_radio"];
	if (!(TF_tangent_lr_pressed) and {alive TFAR_currentUnit} and {call TFAR_fnc_haveLRRadio}) then {
		if (call TFAR_fnc_isAbleToUseRadio) then {
			call TFAR_fnc_unableToUseHint;
		} else {
			if ([TFAR_currentUnit, TFAR_currentUnit call TFAR_fnc_vehicleIsIsolatedAndInside, TFAR_currentUnit call TFAR_fnc_eyeDepth] call TFAR_fnc_canUseLRRadio) then {
				_radio = call TFAR_fnc_activeLrRadio;
				if ((_radio call TFAR_fnc_getAdditionalLrChannel) > -1) then {
					_freq = [_radio, (_radio call TFAR_fnc_getAdditionalLrChannel) + 1] call TFAR_fnc_GetChannelFrequency;
					["OnBeforeTangent", TFAR_currentUnit, [TFAR_currentUnit, _radio, 1, true, true]] call TFAR_fnc_fireEventHandlers;
					[format[localize "STR_additional_transmit",format ["%1<img size='1.5' image='%2'/>",[_radio select 0, "displayName"] call TFAR_fnc_getLrRadioProperty, getText(configFile >> "CfgVehicles"  >> typeof (_radio select 0) >> "picture")], (_radio call TFAR_fnc_getAdditionalLrChannel) + 1, _freq],
					format["TANGENT_LR	PRESSED	%1%2	%3	%4", _freq, _radio call TFAR_fnc_getLrRadioCode, ([_radio select 0, "tf_range"] call TFAR_fnc_getLrRadioProperty)  * (call TFAR_fnc_getTransmittingDistanceMultiplicator), [_radio select 0, "tf_subtype"] call TFAR_fnc_getLrRadioProperty],
					-1
					] call TFAR_fnc_ProcessTangent;
					TF_tangent_lr_pressed = true;
					//						unit, radio, radioType, additional, buttonDown
					["OnTangent", TFAR_currentUnit, [TFAR_currentUnit, _radio, 1, true, true]] call TFAR_fnc_fireEventHandlers;
				};
			} else {
				call TFAR_fnc_inWaterHint;
			}
		};
	};
	false
};

TFAR_fnc_onAdditionalLRTangentReleased = {
	private ["_freq"];
	if ((TF_tangent_lr_pressed) and {alive TFAR_currentUnit}) then {
		private "_radio";
		_radio = call TFAR_fnc_activeLrRadio;
		if ((_radio call TFAR_fnc_getAdditionalLrChannel) > -1) then {
			_freq = [_radio, (_radio call TFAR_fnc_getAdditionalLrChannel) + 1] call TFAR_fnc_GetChannelFrequency;

			["OnBeforeTangent", TFAR_currentUnit, [TFAR_currentUnit, _radio, 1, true, false]] call TFAR_fnc_fireEventHandlers;
			[format[localize "STR_additional_transmit_end",format ["%1<img size='1.5' image='%2'/>",[_radio select 0, "displayName"] call TFAR_fnc_getLrRadioProperty, getText(configFile >> "CfgVehicles"  >> typeof (_radio select 0) >> "picture")], (_radio call TFAR_fnc_getAdditionalLrChannel) + 1, _freq],
			format["TANGENT_LR	RELEASED	%1%2	%3	%4", _freq, (call TFAR_fnc_activeLrRadio) call TFAR_fnc_getLrRadioCode, ([_radio select 0, "tf_range"] call TFAR_fnc_getLrRadioProperty) * (call TFAR_fnc_getTransmittingDistanceMultiplicator), [_radio select 0, "tf_subtype"] call TFAR_fnc_getLrRadioProperty]
			] call TFAR_fnc_ProcessTangent;
			TF_tangent_lr_pressed = false;
			//						unit, radio, radioType, additional, buttonDown
			["OnTangent", TFAR_currentUnit, [TFAR_currentUnit, _radio, 1, true, false]] call TFAR_fnc_fireEventHandlers;
		};
	};
	false
};

TFAR_fnc_onAdditionalSwTangentPressed = {
	private["_depth", "_freq"];
	if (!(TF_tangent_sw_pressed) and {alive TFAR_currentUnit} and {call TFAR_fnc_haveSWRadio}) then {
		if (call TFAR_fnc_isAbleToUseRadio) then {
			call TFAR_fnc_unableToUseHint;
		} else {
			_depth = TFAR_currentUnit call TFAR_fnc_eyeDepth;
			if ([TFAR_currentUnit, TFAR_currentUnit call TFAR_fnc_vehicleIsIsolatedAndInside, [TFAR_currentUnit call TFAR_fnc_vehicleIsIsolatedAndInside, _depth] call TFAR_fnc_canSpeak, _depth] call TFAR_fnc_canUseSWRadio) then {
				private "_radio";
				_radio = call TFAR_fnc_activeSwRadio;

				if ((_radio call TFAR_fnc_getAdditionalSwChannel) > -1) then {
					_freq = [_radio, (_radio call TFAR_fnc_getAdditionalSwChannel) + 1] call TFAR_fnc_GetChannelFrequency;
					["OnBeforeTangent", TFAR_currentUnit, [TFAR_currentUnit, _radio, 0, true, true]] call TFAR_fnc_fireEventHandlers;
					[format[localize "STR_additional_transmit",format ["%1<img size='1.5' image='%2'/>", getText (ConfigFile >> "CfgWeapons" >> _radio >> "displayName"), getText(configFile >> "CfgWeapons"  >> _radio >> "picture")], (_radio call TFAR_fnc_getAdditionalSwChannel) + 1, _freq],
					format["TANGENT	PRESSED	%1%2	%3	%4", _freq, _radio call TFAR_fnc_getSwRadioCode, getNumber(configFile >> "CfgWeapons" >> _radio >> "tf_range") * (call TFAR_fnc_getTransmittingDistanceMultiplicator), getText(configFile >> "CfgWeapons" >> _radio >> "tf_subtype")],
					-1
					] call TFAR_fnc_ProcessTangent;
					TF_tangent_sw_pressed = true;
					//						unit, radio, radioType, additional, buttonDown
					["OnTangent", TFAR_currentUnit, [TFAR_currentUnit, _radio, 0, true, true]] call TFAR_fnc_fireEventHandlers;
				};
			} else {
				call TFAR_fnc_inWaterHint;
			};
		};
	};
	false
};

TFAR_fnc_onAdditionalSwTangentReleased = {
	private ["_freq"];
	if ((TF_tangent_sw_pressed) and {alive TFAR_currentUnit}) then {
		private "_radio";
		_radio = call TFAR_fnc_activeSwRadio;
		if ((_radio call TFAR_fnc_getAdditionalSwChannel) > -1) then {
			_freq = [_radio, (_radio call TFAR_fnc_getAdditionalSwChannel) + 1] call TFAR_fnc_GetChannelFrequency;
			["OnBeforeTangent", TFAR_currentUnit, [TFAR_currentUnit, _radio, 0, true, false]] call TFAR_fnc_fireEventHandlers;
			[format[localize "STR_additional_transmit_end",format ["%1<img size='1.5' image='%2'/>", getText (ConfigFile >> "CfgWeapons" >> _radio >> "displayName"), getText(configFile >> "CfgWeapons"  >> _radio >> "picture")], (_radio call TFAR_fnc_getAdditionalSwChannel) + 1,  _freq],
			format["TANGENT	RELEASED	%1%2	%3	%4", _freq, (call TFAR_fnc_activeSwRadio) call TFAR_fnc_getSwRadioCode, getNumber(configFile >> "CfgWeapons" >> _radio >> "tf_range") * (call TFAR_fnc_getTransmittingDistanceMultiplicator), getText(configFile >> "CfgWeapons" >> _radio >> "tf_subtype")]
			] call TFAR_fnc_ProcessTangent;
			TF_tangent_sw_pressed = false;
			//						unit, radio, radioType, additional, buttonDown
			["OnTangent", TFAR_currentUnit, [TFAR_currentUnit, _radio, 0, true, false]] call TFAR_fnc_fireEventHandlers;
		};
	};
	false
};

TFAR_fnc_onDDDialogOpen = {
	if ((alive TFAR_currentUnit) and {call TFAR_fnc_haveDDRadio}) then {
		if !(dialog) then {
			createDialog "diver_radio_dialog";
			TFAR_currentUnit playAction "Gear";
			call TFAR_fnc_updateDDDialog;
			["OnRadioOpen", player, [player, "DDRadio", false, "diver_radio_dialog", true]] call TFAR_fnc_fireEventHandlers;
		};
	};
	true

};

TFAR_fnc_onDDTangentPressed = {
	private["_result", "_request", "_hintText"];
	if (time - TF_last_dd_tangent_press > 0.1) then {
		if (!(TF_tangent_dd_pressed) and {alive TFAR_currentUnit} and {call TFAR_fnc_haveDDRadio}) then {
			if (call TFAR_fnc_isAbleToUseRadio) then {
				call TFAR_fnc_unableToUseHint;
			} else {
				if ([TFAR_currentUnit call TFAR_fnc_eyeDepth, TFAR_currentUnit call TFAR_fnc_vehicleIsIsolatedAndInside] call TFAR_fnc_canUseDDRadio) then {
					["OnBeforeTangent", TFAR_currentUnit, [TFAR_currentUnit, "DD", 2, false, true]] call TFAR_fnc_fireEventHandlers;
					[format[localize "STR_transmit", "DD", "1", TF_dd_frequency], format["TANGENT_DD	PRESSED	%1	0	dd", TF_dd_frequency], -1] call TFAR_fnc_ProcessTangent;
					TF_tangent_dd_pressed = true;
					//						unit, radio, radioType, additional, buttonDown
					["OnTangent", TFAR_currentUnit, [TFAR_currentUnit, "DD", 2, false, true]] call TFAR_fnc_fireEventHandlers;
				} else {
					call TFAR_fnc_onGroundHint;
				}
			};
		};
	};
	TF_last_dd_tangent_press = time;
	true

};

TFAR_fnc_onDDTangentReleased = {
	if ((TF_tangent_dd_pressed) and {alive TFAR_currentUnit}) then {
		["OnBeforeTangent", TFAR_currentUnit, [TFAR_currentUnit, "DD", 2, false, false]] call TFAR_fnc_fireEventHandlers;
		[format[localize "STR_transmit_end", "DD", "1", TF_dd_frequency], format["TANGENT_DD	RELEASED	%1	0	dd", TF_dd_frequency]] call TFAR_fnc_ProcessTangent;
		TF_tangent_dd_pressed = false;
		//						unit, radio, radioType, additional, buttonDown
		["OnTangent", TFAR_currentUnit, [TFAR_currentUnit, "DD", 2, false, false]] call TFAR_fnc_fireEventHandlers;
	};
	true
};

TFAR_fnc_onDDTangentReleasedHack = {
	#include "script.h"
	private ["_scancode", "_mods", "_keybind", "_scancode_dd"];
	_scancode = _this select 1;
	_keybind = ["TFAR", "DDTransmit"] call cba_fnc_getKeybind;
	if !(isNil "_keybind") then {
		_mods = ((_keybind) select 5) select 1;
		_scancode_dd = ((_keybind) select 5) select 0;

		if (((_scancode == SHIFTL) and (_mods select 0))
		   or ((_scancode == CTRLL) and (_mods select 1))
		   or ((_scancode == ALTL) and (_mods select 2))
		   or (_scancode == _scancode_dd))
		then {
			call TFAR_fnc_onDDTangentReleased;
		};
	};
	false
};

TFAR_fnc_onGroundHint = {
	[parseText (localize "STR_on_ground_hint"), 5] call TFAR_fnc_showHint;
};

TFAR_fnc_onLRDialogOpen = {
	_h = [] spawn {
	    private ["_radio","_dialog_to_open","_dialog_update"];
	    sleep 0.1;

		if ((alive TFAR_currentUnit) and {call TFAR_fnc_haveLRRadio}) then {
			if !(dialog) then {
				_radio = (TF_lr_dialog_radio select 0);
				_dialog_to_open = ([_radio, "tf_dialog"] call TFAR_fnc_getLrRadioProperty);
				_dialog_update = ([_radio, "tf_dialogUpdate"] call TFAR_fnc_getLrRadioProperty);

				createDialog _dialog_to_open;
				TFAR_currentUnit playAction "Gear";
				call compile _dialog_update;
	            ["OnRadioOpen", player, [player, TF_lr_dialog_radio, true, _dialog_to_open, true]] call TFAR_fnc_fireEventHandlers;
			};
		};
	}; allThreads pushBack _h;
	true

};

TFAR_fnc_onLRTangentPressed = {
	private["_radio"];
	if (time - TF_last_lr_tangent_press > 0.1) then {
		if (!(TF_tangent_lr_pressed) and {alive TFAR_currentUnit} and {call TFAR_fnc_haveLRRadio}) then {

			if (call TFAR_fnc_isAbleToUseRadio) then {
				call TFAR_fnc_unableToUseHint;
			} else {
				if ([TFAR_currentUnit, TFAR_currentUnit call TFAR_fnc_vehicleIsIsolatedAndInside, TFAR_currentUnit call TFAR_fnc_eyeDepth] call TFAR_fnc_canUseLRRadio) then {
					_radio = call TFAR_fnc_activeLrRadio;
					["OnBeforeTangent", TFAR_currentUnit, [TFAR_currentUnit, _radio, 1, false, true]] call TFAR_fnc_fireEventHandlers;
					[format[localize "STR_transmit",format ["%1<img size='1.5' image='%2'/>",[_radio select 0, "displayName"] call TFAR_fnc_getLrRadioProperty,
						getText(configFile >> "CfgVehicles"  >> typeof (_radio select 0) >> "picture")],(_radio call TFAR_fnc_getLrChannel) + 1, call TFAR_fnc_currentLRFrequency],
					format["TANGENT_LR	PRESSED	%1%2	%3	%4", call TFAR_fnc_currentLRFrequency, _radio call TFAR_fnc_getLrRadioCode, ([_radio select 0, "tf_range"] call TFAR_fnc_getLrRadioProperty)  * (call TFAR_fnc_getTransmittingDistanceMultiplicator), [_radio select 0, "tf_subtype"] call TFAR_fnc_getLrRadioProperty],
					-1
					] call TFAR_fnc_ProcessTangent;
					TF_tangent_lr_pressed = true;
					//						unit, radio, radioType, additional, buttonDown
					["OnTangent", TFAR_currentUnit, [TFAR_currentUnit, _radio, 1, false, true]] call TFAR_fnc_fireEventHandlers;
				} else {
					call TFAR_fnc_inWaterHint;
				}
			};
		};
	};
	TF_last_lr_tangent_press = time;
	true
};

TFAR_fnc_onLRTangentReleased = {
	private ["_radio"];
	if ((TF_tangent_lr_pressed) and {alive TFAR_currentUnit}) then {
		_radio = call TFAR_fnc_activeLrRadio;

		["OnBeforeTangent", TFAR_currentUnit, [TFAR_currentUnit, _radio, 1, false, false]] call TFAR_fnc_fireEventHandlers;
		[format[localize "STR_transmit_end",format ["%1<img size='1.5' image='%2'/>",[_radio select 0, "displayName"] call TFAR_fnc_getLrRadioProperty,
			getText(configFile >> "CfgVehicles"  >> typeof (_radio select 0) >> "picture")],(_radio call TFAR_fnc_getLrChannel) + 1, call TFAR_fnc_currentLRFrequency],
		format["TANGENT_LR	RELEASED	%1%2	%3	%4", call TFAR_fnc_currentLRFrequency, (call TFAR_fnc_activeLrRadio) call TFAR_fnc_getLrRadioCode, ([_radio select 0, "tf_range"] call TFAR_fnc_getLrRadioProperty) * (call TFAR_fnc_getTransmittingDistanceMultiplicator), [_radio select 0, "tf_subtype"] call TFAR_fnc_getLrRadioProperty]
		] call TFAR_fnc_ProcessTangent;
		TF_tangent_lr_pressed = false;
		//						unit, radio, radioType, additional, buttonDown
		["OnTangent", TFAR_currentUnit, [TFAR_currentUnit, _radio, 1, false, false]] call TFAR_fnc_fireEventHandlers;
	};

	true
};

TFAR_fnc_onLRTangentReleasedHack = {
	#include "script.h"
	private ["_scancode", "_mods", "_keybind", "_scancode_lr"];
	_scancode = _this select 1;
	_keybind = ["TFAR", "LRTransmit"] call cba_fnc_getKeybind;
	if !(isNil "_keybind") then {
		_mods = ((_keybind) select 5) select 1;
		_scancode_lr = ((_keybind) select 5) select 0;

		if (((_scancode == SHIFTL) and (_mods select 0))
		   or ((_scancode == CTRLL) and (_mods select 1))
		   or ((_scancode == ALTL) and (_mods select 2))
		   or (_scancode == _scancode_lr))
		 then {
			call TFAR_fnc_onLRTangentReleased;
		};
	};
	false
};

TFAR_fnc_onSpeakVolumeChange = {
	private["_localName", "_hintText"];
	if (alive TFAR_currentUnit) then {
		_localName = "STR_voice_normal";
		if (TF_speak_volume_level == "Whispering") then {
			TF_speak_volume_level = "normal";
			TF_speak_volume_meters = 20;
			_localName = localize "STR_voice_normal";
		} else {
			if (TF_speak_volume_level == "Normal") then {
				TF_speak_volume_level = "yelling";
				TF_speak_volume_meters = 60;
				_localName = localize "STR_voice_yelling";
			} else {
				TF_speak_volume_level = "whispering";
				TF_speak_volume_meters = 5;
				_localName = localize "STR_voice_whispering";
			}
		};
		_hintText = format[localize "STR_voice_volume", _localName];
		[parseText (_hintText), 5] call TFAR_fnc_showHint;
		//							unit, range
		["OnSpeakVolume", TFAR_currentUnit, [TFAR_currentUnit, TF_speak_volume_meters]] call TFAR_fnc_fireEventHandlers;
	};
	true
};

TFAR_fnc_onSwDialogOpen = {
	_h = [] spawn {
		sleep 0.1;
		if ((alive TFAR_currentUnit) and {!(isNil "TF_sw_dialog_radio")} and {!dialog}) then {
			private ["_dialog_to_open"];
			_dialog_to_open = getText(configFile >> "CfgWeapons" >> TF_sw_dialog_radio >> "tf_dialog");
			createDialog _dialog_to_open;
			TFAR_currentUnit playAction "Gear";
			call compile getText(configFile >> "CfgWeapons" >> TF_sw_dialog_radio >> "tf_dialogUpdate");
			["OnRadioOpen", player, [player, TF_sw_dialog_radio, false, _dialog_to_open, true]] call TFAR_fnc_fireEventHandlers;
		};
	}; allThreads pushBack _h;
	true

};

TFAR_fnc_onSwTangentPressed = {
	private["_depth", "_radio"];
	if (time - TF_last_lr_tangent_press > 0.5) then {
		if (!(TF_tangent_sw_pressed) and {alive TFAR_currentUnit} and {call TFAR_fnc_haveSWRadio}) then {
			if (call TFAR_fnc_isAbleToUseRadio) then {
				call TFAR_fnc_unableToUseHint;
			} else {
				_depth = TFAR_currentUnit call TFAR_fnc_eyeDepth;
				if ([TFAR_currentUnit, TFAR_currentUnit call TFAR_fnc_vehicleIsIsolatedAndInside, [TFAR_currentUnit call TFAR_fnc_vehicleIsIsolatedAndInside, _depth] call TFAR_fnc_canSpeak, _depth] call TFAR_fnc_canUseSWRadio) then {
					_radio = call TFAR_fnc_activeSwRadio;
					["OnBeforeTangent", TFAR_currentUnit, [TFAR_currentUnit, _radio, 0, false, true]] call TFAR_fnc_fireEventHandlers;
					[format[localize "STR_transmit",format ["%1<img size='1.5' image='%2'/>", getText (ConfigFile >> "CfgWeapons" >> _radio >> "displayName"),
						getText(configFile >> "CfgWeapons"  >> _radio >> "picture")],(_radio call TFAR_fnc_getSwChannel) + 1, call TFAR_fnc_currentSWFrequency],
					format["TANGENT	PRESSED	%1%2	%3	%4",call TFAR_fnc_currentSWFrequency, _radio call TFAR_fnc_getSwRadioCode, getNumber(configFile >> "CfgWeapons" >> _radio >> "tf_range") * (call TFAR_fnc_getTransmittingDistanceMultiplicator), getText(configFile >> "CfgWeapons" >> _radio >> "tf_subtype")],
					-1
					] call TFAR_fnc_ProcessTangent;
					TF_tangent_sw_pressed = true;
					//						unit, radio, radioType, additional, buttonDown
					["OnTangent", TFAR_currentUnit, [TFAR_currentUnit, _radio, 0, false, true]] call TFAR_fnc_fireEventHandlers;
				} else {
					call TFAR_fnc_inWaterHint;
				};
			};
		};
	};
	true

};

TFAR_fnc_onSwTangentPressedHack = {
	#include "script.h"
	private ["_scancode", "_mods", "_mods_lr", "_is_lr", "_sw_keybind", "_lr_keybind", "_scancode_lr"];
	if !(call TFAR_fnc_isAbleToUseRadio) then {
		_scancode = _this select 1;
		_sw_keybind = ["TFAR", "SWTransmit"] call cba_fnc_getKeybind;
		_lr_keybind = ["TFAR", "LRTransmit"] call cba_fnc_getKeybind;
		if (!(isNil "_sw_keybind") and !(isNil "_lr_keybind")) then {
			_mods = ((_sw_keybind) select 5) select 1;
			_mods_lr = ((_lr_keybind) select 5) select 1;
			_scancode_lr = ((_lr_keybind) select 5) select 0;

			_is_lr = (_this select 2 && _mods_lr select 0) || (_this select 3 && _mods_lr select 1) || (_this select 4 && _mods_lr select 2);
			if ((_scancode == _scancode_lr) and !(_is_lr) and !(_mods select 0) and !(_mods select 1) and !(_mods select 2)) then {
				call TFAR_fnc_onSwTangentPressed;
			};
		};
	};
	false
};

TFAR_fnc_onSwTangentReleased = {
	private ["_radio"];
	if ((TF_tangent_sw_pressed) and {alive TFAR_currentUnit}) then {
		_radio = call TFAR_fnc_activeSwRadio;

		["OnBeforeTangent", TFAR_currentUnit, [TFAR_currentUnit, _radio, 0, false, false]] call TFAR_fnc_fireEventHandlers;

		[format[localize "STR_transmit_end",format ["%1<img size='1.5' image='%2'/>", getText (ConfigFile >> "CfgWeapons" >> _radio >> "displayName"),
			getText(configFile >> "CfgWeapons"  >> _radio >> "picture")],(_radio call TFAR_fnc_getSwChannel) + 1, call TFAR_fnc_currentSWFrequency],
		format["TANGENT	RELEASED	%1%2	%3	%4",call TFAR_fnc_currentSWFrequency, (call TFAR_fnc_activeSwRadio) call TFAR_fnc_getSwRadioCode, getNumber(configFile >> "CfgWeapons" >> _radio >> "tf_range") * (call TFAR_fnc_getTransmittingDistanceMultiplicator), getText(configFile >> "CfgWeapons" >> _radio >> "tf_subtype")]
		] call TFAR_fnc_ProcessTangent;

		TF_tangent_sw_pressed = false;
		//						unit, radio, radioType, additional, buttonDown
		["OnTangent", TFAR_currentUnit, [TFAR_currentUnit, _radio, 0, false, false]] call TFAR_fnc_fireEventHandlers;
	};
	true
};

TFAR_fnc_onSwTangentReleasedHack = {
	#include "script.h"
	private ["_scancode", "_scancode_sw", "_keybind"];
	_scancode = _this select 1;
	_keybind = ["TFAR", "SWTransmit"] call cba_fnc_getKeybind;
	if !(isNil "_keybind") then {
		_scancode_sw = ((_keybind) select 5) select 0;
		if (_scancode == _scancode_sw) then {
			call TFAR_fnc_onSwTangentReleased;
		};
	};
	false
};

TFAR_fnc_preparePositionCoordinates = {
	/*
	 	Name: TFAR_fnc_preparePositionCoordinates

	 	Author(s):
			NKey

	 	Description:
			Prepares the position coordinates of the passed unit.

		Parameters:
			0: OBJECT - unit
			1: BOOLEAN - Is near player
			3: STRING - Unit name

	 	Returns:
			Nothing

	 	Example:

	*/
	private ["_x_player","_isolated_and_inside","_can_speak", "_pos", "_depth", "_useSw", "_useLr", "_useDd", "_freq", "_vehicle", "_radio_id"];
	_unit = _this select 0;
	_nearPlayer = _this select 1;

	_pos = [_unit, _nearPlayer] call (_unit getVariable ["TF_fnc_position", TFAR_fnc_defaultPositionCoordinates]);
	_isolated_and_inside = _unit call TFAR_fnc_vehicleIsIsolatedAndInside;
	_depth = _unit call TFAR_fnc_eyeDepth;
	_can_speak = [_isolated_and_inside, _depth] call TFAR_fnc_canSpeak;
	_useSw = true;
	_useLr = true;
	_useDd = false;
	if (_depth < 0) then {
		_useSw = [_unit, _isolated_and_inside, _can_speak, _depth] call TFAR_fnc_canUseSWRadio;
		_useLr = [_unit, _isolated_and_inside, _depth] call TFAR_fnc_canUseLRRadio;
		_useDd = [_depth, _isolated_and_inside] call TFAR_fnc_canUseDDRadio;
	};
	if (count _pos != 4) then {
		_pos pushBack 0;
	};

	_vehicle = _unit call TFAR_fnc_vehicleId;
	if ((_nearPlayer) and {TFAR_currentUnit distance _unit <= TF_speakerDistance}) then {
		if (_unit getVariable ["tf_lr_speakers", false] && _useLr) then {
			{
				if (_x call TFAR_fnc_getLrSpeakers) then {
					_freq = format ["%1%2", _x call TFAR_fnc_getLrFrequency, _x call TFAR_fnc_getLrRadioCode];
					if ((_x call TFAR_fnc_getAdditionalLrChannel) > -1) then {
						_freq = _freq + format ["|%1%2", [_x, (_x call TFAR_fnc_getAdditionalLrChannel) + 1] call TFAR_fnc_GetChannelFrequency, _x call TFAR_fnc_getLrRadioCode];
					};
					_radio_id = netId (_x select 0);
					if (_radio_id == '') then {
						_radio_id = str (_x select 0);
					};

					tf_speakerRadios pushBack (format ["%1%2%3%4%5%6%7%8%9%10%11%12%13", _radio_id, TF_new_line, _freq, TF_new_line, _this select 2, TF_new_line, [], TF_new_line, _x call TFAR_fnc_getLrVolume, TF_new_line, _vehicle, TF_new_line, (getPosASL _unit) select 2]);
				};
				true;
			} count (_unit call TFAR_fnc_lrRadiosList);
		};

		if (_unit getVariable ["tf_sw_speakers", false] && _useSw) then {
			{
				if (_x call TFAR_fnc_getSwSpeakers) then {
					_freq = format ["%1%2", _x call TFAR_fnc_getSwFrequency, _x call TFAR_fnc_getSwRadioCode];
					if ((_x call TFAR_fnc_getAdditionalSwChannel) > -1) then {
						_freq = _freq + format ["|%1%2", [_x, (_x call TFAR_fnc_getAdditionalSwChannel) + 1] call TFAR_fnc_GetChannelFrequency, _x call TFAR_fnc_getSwRadioCode];
					};
					_radio_id = _x;
					tf_speakerRadios pushBack (format ["%1%2%3%4%5%6%7%8%9%10%11%12%13", _radio_id, TF_new_line, _freq, TF_new_line, _this select 2, TF_new_line, [], TF_new_line, _x call TFAR_fnc_getSwVolume, TF_new_line, _vehicle, TF_new_line, (getPosASL _unit) select 2]);
				};
				true;
			} count (_unit call TFAR_fnc_radiosList);
		};
	};
 
	(format["POS	%1	%2	%3	%4	%5	%6	%7	%8	%9	%10	%11	%12	%13", _this select 2, _pos select 0, _pos select 1, _pos select 2, _pos select 3, _can_speak, _useSw, _useLr, _useDd, _vehicle, _unit call TFAR_fnc_calcTerrainInterception, _unit getVariable ["tf_voiceVolume", 1.0], call TFAR_fnc_currentDirection])
};

TFAR_fnc_processCuratorKey = {
	private ["_keys", "_pressed", "_result", "_keyup"];

	_pressed = _this select 0;
	_result = false;
	_keyup = (_this select 1) isEqualTo 'keyup';

	_processKeys = {
		private ["_mods", "_key_pressed", "_handler"];

		if ([_key, "tfar_"] call CBA_fnc_find == 0) then {

			_key_pressed = _value select 0;
			_mods = _value select 1;
			_handler = _value select 2;

			if ((_key_pressed == _pressed select 1) and {(_mods select 0) isEqualTo (_pressed select 2)} and {(_mods select 1) isEqualTo  (_pressed select 3)} and {(_mods select 2) isEqualTo (_pressed select 4)}) exitWith {
				_result = call _handler;
			};
		 };
	};

	[if (_keyup) then {cba_events_keyhandlers_up} else {cba_events_keyhandlers_down}, _processKeys] call CBA_fnc_hashEachPair;

	_result;
};


TFAR_fnc_processLRChannelKeys = {
	/*
	 	Name: TFAR_fnc_processLRChannelKeys

	 	Author(s):
			NKey

	 	Description:
			Switches the active LR radio to the passed channel.

		Parameters:
			0: NUMBER - Channel : Range (0,8)

	 	Returns:
			BOOLEAN - If the event was handled by this function.

	 	Example:
			Called by CBA.
	*/
	private ["_lr_channel_number","_hintText","_result","_active_lr"];
	_lr_channel_number = _this select 0;
	_result = false;

	if ((call TFAR_fnc_haveLRRadio) and {alive TFAR_currentUnit}) then {
		_active_lr = call TFAR_fnc_activeLrRadio;
		[_active_lr select 0, _active_lr select 1, _lr_channel_number] call TFAR_fnc_setLrChannel;

		[_active_lr, true] call TFAR_fnc_ShowRadioInfo;
		if (dialog) then {
			call compile ([_active_lr select 0, "tf_dialogUpdate"] call TFAR_fnc_getLrRadioProperty);
		};
		_result = true;
	};
	_result
};

TFAR_fnc_processLRCycleKeys = {
	/*
	 	Name: TFAR_fnc_processLRCycleKeys

	 	Author(s):


	 	Description:
			Allows rotating through the list of LR radios with keys.

		Parameters:
			0: STRING - Direction to cycle : VALUES (next, prev)

	 	Returns:
			BOOLEAN - If the event was handled or not.

	 	Example:
			Handled via CBA's onKey eventhandler.
	*/
	private ["_lr_cycle_direction", "_result"];
	_lr_cycle_direction = _this select 0;
	_result = false;

	if ((call TFAR_fnc_haveLRRadio) and {alive TFAR_currentUnit}) then {
		private ["_radio", "_radio_list", "_active_radio_index", "_new_radio_index"];
		_radio = call TFAR_fnc_activeLrRadio;
		_radio_list = TFAR_currentUnit call TFAR_fnc_lrRadiosList;

		_active_radio_index = 0;
		_new_radio_index = 0;

		{
			if (((_x select 0) == (_radio select 0)) or {(_x select 1) == (_radio select 1)}) exitWith{
				_active_radio_index = _forEachIndex;
			};
		} forEach _radio_list;


		switch (_lr_cycle_direction) do{
			case "next":
				{
					_new_radio_index = (_active_radio_index + 1) mod (count _radio_list);
				};
		    case "prev":
		    {
		    	if (_active_radio_index != 0) then {
		    		_new_radio_index = (_active_radio_index - 1);
		    	} else {
		    		_new_radio_index = (count _radio_list) - 1;
		    	};
		    };
		};

		(_radio_list select _new_radio_index) call TFAR_fnc_setActiveLrRadio;

		[(call TFAR_fnc_activeLrRadio), true] call TFAR_fnc_ShowRadioInfo;

		_result = true;
	};
	_result
};

TFAR_fnc_processLRStereoKeys = {
	/*
	 	Name: TFAR_fnc_processLRStereoKeys

	 	Author(s):


	 	Description:
			Switches the LR stereo setting on the active LR radio.

		Parameters:
			0: NUMBER - Stereo number : Range (0,2) (0 - Both, 1 - Left, 2 - Right)

	 	Returns:
			BOOLEAN - if handled or not.

	 	Example:
			Called via CBA onKey EventHandler
	*/
	private ["_lr_stereo_number", "_result"];
	_lr_stereo_number = _this select 0;
	_result = false;

	if ((alive TFAR_currentUnit) and {call TFAR_fnc_haveLRRadio}) then {
		private "_radio";
		_radio = call TFAR_fnc_activeLrRadio;
		[_radio select 0, _radio select 1, _lr_stereo_number] call TFAR_fnc_setLrStereo;
		[_radio] call TFAR_fnc_ShowRadioVolume;
		_result = true;
	};
	_result

};

TFAR_fnc_processPlayerPositions = {
	/*
	 	Name: TFAR_fnc_processPlayerPositions

	 	Author(s):
			NKey

	 	Description:
			Process some player positions on each call and sends it to the plugin.

		Parameters:
			Nothing

	 	Returns:
			Nothing

	 	Example:
			call TFAR_fnc_processPlayerPositions;
	*/
	private ["_elemsNearToProcess","_elemsFarToProcess","_other_units", "_unit", "_controlled", "_speakers"];
	if !(isNull (findDisplay 46)) then {
		if !(isNull TFAR_currentUnit) then {
			if ((tf_farPlayersProcessed) and {tf_nearPlayersProcessed}) then {
				tf_nearPlayersIndex = 0;
				tf_farPlayersIndex = 0;

				if (count tf_nearPlayers == 0) then {
					tf_nearPlayers = call TFAR_fnc_getNearPlayers;
				};

				_other_units = allUnits - tf_nearPlayers;


				{
					if !(_x in _other_units) then {
						_other_units pushBack _x;
					};
					true;
				} count (call BIS_fnc_listCuratorPlayers);//Add curators


				tf_farPlayers = [];
				tf_farPlayersIndex = 0;
				{
					_spectator = _x getVariable "tf_forceSpectator";
					if (isNil "_spectator") then {
						_spectator = false;
					};
					if ((isPlayer _x) and {!_spectator}) then {
						tf_farPlayers set[tf_farPlayersIndex, _x];
						tf_farPlayersIndex = tf_farPlayersIndex + 1;
					};
					true;
				} count _other_units;

				tf_farPlayersIndex = 0;

				if (count tf_nearPlayers > 0) then {
					tf_nearPlayersProcessed = false;
					tf_msNearPerStep = tf_msNearPerStepMax max (tf_nearUpdateTime / (count tf_nearPlayers));
					tf_msNearPerStep = tf_msNearPerStep min tf_msNearPerStepMin;
				} else {
					tf_msNearPerStep = tf_nearUpdateTime;
				};
				if (count tf_farPlayers > 0) then {
					tf_farPlayersProcessed = false;
					if (count tf_nearPlayers > 0) then {
						tf_msFarPerStep = tf_msFarPerStepMax max (tf_farUpdateTime / (count tf_farPlayers));
						tf_msFarPerStep = tf_msFarPerStep min tf_msFarPerStepMin;
					} else {
						tf_msFarPerStep = tf_msSpectatorPerStepMax;
					};
				} else {
					tf_msFarPerStep = tf_farUpdateTime;
				};
				call TFAR_fnc_sendVersionInfo;
			} else {
				_elemsNearToProcess = (diag_tickTime - tf_lastNearFrameTick) / tf_msNearPerStep;
				if (_elemsNearToProcess >= 1) then {
					for "_y" from 0 to _elemsNearToProcess step 1 do {
						if (tf_nearPlayersIndex < count tf_nearPlayers) then {
							_unit = (tf_nearPlayers select tf_nearPlayersIndex);
							_controlled = _unit getVariable "tf_controlled_unit";
							if !(isNil "_controlled") then {
								[_controlled, true, name _unit] call TFAR_fnc_sendPlayerInfo;
							} else {
								[_unit, true, name _unit] call TFAR_fnc_sendPlayerInfo;
							};
							tf_nearPlayersIndex = tf_nearPlayersIndex + 1;
						} else {
							tf_nearPlayersIndex = 0;
							tf_nearPlayersProcessed = true;

							if (diag_tickTime - tf_lastNearPlayersUpdate > 0.5) then {
								tf_nearPlayers = call TFAR_fnc_getNearPlayers;
								tf_lastNearPlayersUpdate = diag_tickTime;
							};

							call TFAR_fnc_processSpeakerRadios;

							_speakers = "SPEAKERS	";
							{
								_speakers = _speakers + TF_vertical_tab + _x;
							} count (tf_speakerRadios);
							"task_force_radio_pipe" callExtension _speakers;

							tf_speakerRadios = [];
						};
					};
					tf_lastNearFrameTick = diag_tickTime;
				};

				_elemsFarToProcess = (diag_tickTime - tf_lastFarFrameTick) / tf_msFarPerStep;
				if (_elemsFarToProcess >= 1) then {
					for "_y" from 0 to _elemsFarToProcess step 1 do {
						if (tf_farPlayersIndex < count tf_farPlayers) then {
							_unit = (tf_farPlayers select tf_farPlayersIndex);
							[_unit, false, name _unit] call TFAR_fnc_sendPlayerInfo;
							tf_farPlayersIndex = tf_farPlayersIndex + 1;
						} else {
							tf_farPlayersIndex = 0;
							tf_farPlayersProcessed = true;
						};
					};
					tf_lastFarFrameTick = diag_tickTime;
				};
			};
			if (diag_tickTime - tf_lastFrequencyInfoTick > 0.5) then {
				call TFAR_fnc_sendFrequencyInfo;
				tf_lastFrequencyInfoTick = diag_tickTime;
			};
		};
	};

};

TFAR_fnc_processRespawn = {
	/*
	 	Name: TFAR_fnc_processRespawn

	 	Author(s):
			NKey
			L-H

	 	Description:
			Handles getting switching radios, handles whether a manpack must be added to the player or not.

		Parameters:
			Nothing

	 	Returns:
			Nothing

	 	Example:
			call TFAR_fnc_processRespawn;
	*/
	_h = [] spawn {
		waitUntil {!(isNull player)};
		TFAR_currentUnit = call TFAR_fnc_currentUnit;

		TF_respawnedAt = time;
		if (alive TFAR_currentUnit) then {
			if (TF_give_microdagr_to_soldier)  then {
				TFAR_currentUnit linkItem "tf_microdagr";
			};
			if (leader TFAR_currentUnit == TFAR_currentUnit) then {
				if (tf_no_auto_long_range_radio or {backpack TFAR_currentUnit == "B_Parachute"} or {player call TFAR_fnc_isForcedCurator}) exitWith {};
				if ([(backpack TFAR_currentUnit), "tf_hasLRradio", 0] call TFAR_fnc_getConfigProperty == 1) exitWith {};

				private ["_items", "_backPack", "_newItems"];
				_items = backpackItems TFAR_currentUnit;
				_backPack = unitBackpack TFAR_currentUnit;
				TFAR_currentUnit action ["putbag", TFAR_currentUnit];
				sleep 3;
				TFAR_currentUnit addBackpack ((call TFAR_fnc_getDefaultRadioClasses) select 0);
				_newItems = [];
				{
					if (TFAR_currentUnit canAddItemToBackpack _x) then {
						TFAR_currentUnit addItemToBackpack _x;
					}else{
						_newItems pushBack _x;
					};
					true;
				} count _items;

				clearItemCargoGlobal _backPack;
				clearMagazineCargoGlobal _backPack;
				clearWeaponCargoGlobal _backPack;
				{
					if (isClass (configFile >> "CfgMagazines" >> _x)) then{
						_backPack addMagazineCargoGlobal [_x, 1];
					}else{
						_backPack addItemCargoGlobal [_x, 1];
						_backPack addWeaponCargoGlobal [_x, 1];
					};
					true;
				} count _newItems;
			};
			true call TFAR_fnc_requestRadios;
		};
	}; allThreads pushBack _h;
};

TFAR_fnc_processSpeakerRadios = {
	private ["_item", "_freq", "_pos", "_unit_pos", "_p", "_manpack", "_lrs", "_isolation"];
	_unit_pos = eyepos TFAR_currentUnit;
	{
		_pos = getPosASL _x;
		if ((_pos select 2) > 0) then {
			_p = [(_pos select 0) - (_unit_pos select 0), (_pos select 1) - (_unit_pos select 1), (_pos select 2) - (_unit_pos select 2)];
			{
				if ((_x call TFAR_fnc_isRadio) and {_x call TFAR_fnc_getSwSpeakers}) then {
					_freq = format ["%1%2", _x call TFAR_fnc_getSwFrequency, _x call TFAR_fnc_getSwRadioCode];
					if ((_x call TFAR_fnc_getAdditionalSwChannel) > -1) then {
						_freq = _freq + format ["|%1%2", [_x, (_x call TFAR_fnc_getAdditionalSwChannel) + 1] call TFAR_fnc_GetChannelFrequency, _x call TFAR_fnc_getSwRadioCode];
					}; 
					tf_speakerRadios pushBack (format ["%1%2%3%4%5%6%7%8%9%10%11%12%13", _x, TF_new_line, _freq, TF_new_line,  "", TF_new_line, _p, TF_new_line, _x call TFAR_fnc_getSwVolume, TF_new_line, "no", TF_new_line, _pos select 2]);
				};
			} forEach ((getItemCargo _x) select 0);


			{
				if  ((_x getVariable ["tf_lr_speakers", false]) and {[typeof (_x), "tf_hasLRradio", 0] call TFAR_fnc_getConfigProperty == 1}) then {
					_manpack = [_x, "radio_settings"];
					if (_manpack call TFAR_fnc_getLrSpeakers) then {
						_freq = format ["%1%2", _manpack call TFAR_fnc_getLrFrequency, _manpack call TFAR_fnc_getLrRadioCode];
						if ((_manpack call TFAR_fnc_getAdditionalLrChannel) > -1) then {
							_freq = _freq + format ["|%1%2", [_manpack, (_manpack call TFAR_fnc_getAdditionalLrChannel) + 1] call TFAR_fnc_GetChannelFrequency, _manpack call TFAR_fnc_getLrRadioCode];
						};
						_radio_id = netId (_manpack select 0);
						if (_radio_id == '') then {
							_radio_id = str (_manpack select 0);
						};

						tf_speakerRadios pushBack (format ["%1%2%3%4%5%6%7%8%9%10%11%12%13", _radio_id, TF_new_line, _freq, TF_new_line,  "", TF_new_line, _p, TF_new_line, _manpack call TFAR_fnc_getLrVolume, TF_new_line, "no", TF_new_line, _pos select 2]);
					};
				};

			} forEach (everyBackpack _x);
		};
	} forEach (nearestObjects [getPos TFAR_currentUnit, ["WeaponHolder", "GroundWeaponHolder", "WeaponHolderSimulated"], TF_speakerDistance]);

	{
		if ((_x getVariable ["tf_lr_speakers", false]) and {_x call TFAR_fnc_hasVehicleRadio}) then {
			_pos = getPosASL _x;
			if (_pos select 2 >= TF_UNDERWATER_RADIO_DEPTH) then {
				_p = [(_pos select 0) - (_unit_pos select 0), (_pos select 1) - (_unit_pos select 1), (_pos select 2) - (_unit_pos select 2)];

				_lrs = [];
				if (isNull (gunner _x) && {count (_x getVariable ["gunner_radio_settings", []]) > 0}) then {
					_lrs pushBack [_x, "gunner_radio_settings"];
				};
				if (isNull (driver _x) && {count (_x getVariable ["driver_radio_settings", []]) > 0}) then {
					_lrs pushBack [_x, "driver_radio_settings"];
				};
				if (isNull (commander _x) && {count (_x getVariable ["commander_radio_settings", []]) > 0}) then {
					_lrs pushBack [_x, "commander_radio_settings"];
				};
				if (isNull (_x turretUnit [0]) && {count (_x getVariable ["turretUnit_0_radio_setting", []]) > 0}) then {
					_lrs pushBack [_x, "turretUnit_0_radio_setting"];
				};

				{
					if (_x call TFAR_fnc_getLrSpeakers) then {
						_freq = format ["%1%2", _x call TFAR_fnc_getLrFrequency, _x call TFAR_fnc_getLrRadioCode];
						if ((_x call TFAR_fnc_getAdditionalLrChannel) > -1) then {
							_freq = _freq + format ["|%1%2", [_x, (_x call TFAR_fnc_getAdditionalLrChannel) + 1] call TFAR_fnc_GetChannelFrequency, _x call TFAR_fnc_getLrRadioCode];
						};
						_radio_id = netId (_x select 0);
						if (_radio_id == '') then {
							_radio_id = str (_x select 0);
						};
						_radio_id =  _radio_id + (_x select 1);
						_isolation = netid (_x select 0);
						if (_isolation == "") then {
							_isolation = "singleplayer";
						};
						_isolation = _isolation + "_" + str ([(typeof (_x select 0)), "tf_isolatedAmount", 0.0] call TFAR_fnc_getConfigProperty);

						tf_speakerRadios pushBack (format ["%1%2%3%4%5%6%7%8%9%10%11%12%13", _radio_id, TF_new_line, _freq, TF_new_line,  "", TF_new_line, _p, TF_new_line, _x call TFAR_fnc_getLrVolume, TF_new_line, _isolation, TF_new_line, _pos select 2]);
					};
				}
				forEach (_lrs);
			};

		};
	} forEach  (TFAR_currentUnit nearEntities [["LandVehicle", "Air", "Ship"], TF_speakerDistance]);
};

TFAR_fnc_processSWChannelKeys = {
	/*
	 	Name: TFAR_fnc_processSWChannelKeys

	 	Author(s):
			NKey

	 	Description:
			Switches the active SW radio to the passed channel.

		Parameters:
			0: NUMBER - Channel : Range (0,7)

	 	Returns:
			BOOLEAN - If the event was handled by this function.

	 	Example:
			Called by CBA.
	*/
	private ["_sw_channel_number", "_hintText", "_result"];
	_sw_channel_number = _this select 0;
	_result = false;

	if ((call TFAR_fnc_haveSWRadio) and {alive TFAR_currentUnit}) then {
		private "_radio";
		_radio = call TFAR_fnc_activeSwRadio;
		[_radio, _sw_channel_number] call TFAR_fnc_setSwChannel;
		[_radio, false] call TFAR_fnc_ShowRadioInfo;
		if (dialog) then {
			call compile getText(configFile >> "CfgWeapons" >> _radio >> "tf_dialogUpdate");
		};
		_result = true;
	};
	_result
};

TFAR_fnc_processSWCycleKeys = {
	/*
	 	Name: TFAR_fnc_processSWCycleKeys

	 	Author(s):


	 	Description:
			Allows rotating through the list of SW radios with keys.

		Parameters:
			0: STRING - Direction to cycle : VALUES (next, prev)

	 	Returns:
			BOOLEAN - If the event was handled or not.

	 	Example:
			Handled via CBA's onKey eventhandler.
	*/
	private ["_sw_cycle_direction", "_result"];
	_sw_cycle_direction = _this select 0;
	_result = false;

	if ((call TFAR_fnc_haveSWRadio) and {alive TFAR_currentUnit}) then{
		private ["_radio", "_radio_list", "_active_radio_index", "_new_radio_index"];
		_radio = call TFAR_fnc_activeSwRadio;
		_radio_list = TFAR_currentUnit call TFAR_fnc_radiosListSorted;

		_active_radio_index = 0;
		_new_radio_index = 0;

		{
			if (_x == _radio) exitWith{
				_active_radio_index = _forEachIndex;
			};
		} forEach _radio_list;


		switch (_sw_cycle_direction) do{
			case "next":
				{
					_new_radio_index = (_active_radio_index + 1) mod (count _radio_list);
				};
		    case "prev":
		    {
		    	if (_active_radio_index != 0) then {
		    		_new_radio_index = (_active_radio_index - 1);
		    	} else {
		    		_new_radio_index = (count _radio_list) - 1;
		    	};
		    };
		};

		(_radio_list select _new_radio_index) call TFAR_fnc_setActiveSwRadio;

		[(call TFAR_fnc_activeSwRadio), false] call TFAR_fnc_ShowRadioInfo;

		_result = true;
	};
	_result
};

TFAR_fnc_processSWStereoKeys = {
	/*
	 	Name: TFAR_fnc_processSWStereoKeys

	 	Author(s):


	 	Description:
			Switches the SW stereo setting on the active SW radio.

		Parameters:
			0: NUMBER - Stereo number : Range (0,2) (0 - Both, 1 - Left, 2 - Right)

	 	Returns:
			BOOLEAN - if handled or not.

	 	Example:
			Called via CBA onKey EventHandler
	*/
	private ["_sw_stereo_number", "_result"];
	_sw_stereo_number = _this select 0;
	_result = false;

	if ((alive TFAR_currentUnit) and {call TFAR_fnc_haveSWRadio}) then {
		private "_radio";
		_radio = call TFAR_fnc_activeSwRadio;
		[_radio, _sw_stereo_number] call TFAR_fnc_setSwStereo;
		[_radio] call TFAR_fnc_ShowRadioVolume;
		_result = true;
	};
	_result

};

TFAR_fnc_ProcessTangent = {
	/*
	 	Name: TFAR_fnc_ProcessTangent

	 	Author(s):
			NKey
			L-H

	 	Description:
			Called when tangent is released.

		Parameters:
			0: STRING - Hint text
			1: STRING - Request string
			(Optional)2: NUMBER  - Hint display time

	 	Returns:
			Nothing

	 	Example:
			_hintText = format[localize "STR_transmit_end",format ["%1<img size='1.5' image='%2'/>",[_radio select 0, "displayName"] call TFAR_fnc_getLrRadioProperty, getText(configFile >> "CfgVehicles"
				>> typeof (_radio select 0) >> "picture")],(_radio call TFAR_fnc_getLrChannel) + 1, call TFAR_fnc_currentLRFrequency];
			_request = format["TANGENT_LR	RELEASED	%1%2	%3	%4", call TFAR_fnc_currentLRFrequency, (call TFAR_fnc_activeLrRadio) call TFAR_fnc_getLrRadioCode, ([_radio select 0, "tf_range"]
				call TFAR_fnc_getLrRadioProperty) * (call TFAR_fnc_getTransmittingDistanceMultiplicator), [_radio select 0, "tf_subtype"] call TFAR_fnc_getLrRadioProperty];

			[_hintText, _request] call TFAR_fnc_ProcessTangent;
	*/
	private "_timer";
	_timer = 2.5;
	if ((count _this) == 3) then{
		_timer = _this select 2;
	};
	[parseText (_this select 0), _timer] call TFAR_fnc_showHint;
	if (isMultiplayer) then {
		"task_force_radio_pipe" callExtension (_this select 1);
	};
};

TFAR_fnc_radioReplaceProcess = {
	/*
	 	Name: TFAR_fnc_radioReplaceProcess

	 	Author(s):
			NKey

	 	Description:
			Replaces a player's radios if there are any prototype radios.

		Parameters:
			Nothing

	 	Returns:
			Nothing

	 	Example:
			[] spawn TFAR_fnc_radioReplaceProcess;
	*/
	private ["_currentPlayerFlag", "_active_sw_radio", "_active_lr_radio", "_set", "_controlled"];
	while {true} do {
		TFAR_currentUnit = call TFAR_fnc_currentUnit;
		if ((isNil "TFAR_previouscurrentUnit") or {TFAR_previouscurrentUnit != TFAR_currentUnit}) then {
			TFAR_previouscurrentUnit = TFAR_currentUnit;
			_set = (TFAR_currentUnit getVariable "tf_handlers_set");
			if (isNil "_set") then {
				TFAR_currentUnit addEventHandler ["Take", {
					private "_class";
					_class = ConfigFile >> "CfgWeapons" >> (_this select 2);
					if (isClass _class AND {isNumber (_class >> "tf_radio")}) then {
						[(_this select 2), getPlayerUID player] call TFAR_fnc_setRadioOwner;
					};
				}];
				TFAR_currentUnit addEventHandler ["Put", {
					private "_class";
					_class = ConfigFile >> "CfgWeapons" >> (_this select 2);
					if (isClass _class AND {isNumber (_class >> "tf_radio")}) then {
						[(_this select 2), ""] call TFAR_fnc_setRadioOwner;
					};
				}];
				TFAR_currentUnit addEventHandler ["Killed", {
					private ["_class", "_items", "_unit"];
					_unit = _this select 0;
					_items = (assignedItems _unit) + (items _unit);
					{
						_class = ConfigFile >> "CfgWeapons" >> _x;
						if (isClass _class AND {isNumber (_class >> "tf_radio")}) then {
							[_x, ""] call TFAR_fnc_setRadioOwner;
						};
						true;
					} count _items;
				}];
				TFAR_currentUnit setVariable ["tf_handlers_set", true];
			};
		};
		if (TFAR_currentUnit != player) then {
			_controlled = player getVariable "tf_controlled_unit";
			if (isNil "_controlled") then {
				player setVariable ["tf_controlled_unit", TFAR_currentUnit, true];
				if (isMultiplayer) then {
					"task_force_radio_pipe" callExtension (format ["RELEASE_ALL_TANGENTS	%1", name player]);
				};
			};
		} else {
			_controlled = player getVariable "tf_controlled_unit";
			if !(isNil "_controlled") then {
				player setVariable ["tf_controlled_unit", nil, true];
				if (isMultiplayer) then {
					"task_force_radio_pipe" callExtension (format ["RELEASE_ALL_TANGENTS	%1", name player]);
				};
			};
		};

		// hide curator players
		{
			if (_x call TFAR_fnc_isForcedCurator) then {
				_x enableSimulation false;
				_x hideObject true;
			};
			true;
		} count (call BIS_fnc_listCuratorPlayers);

		if !(TF_use_saved_sw_setting) then {
			if ((alive TFAR_currentUnit) and (call TFAR_fnc_haveSWRadio)) then {
				_active_sw_radio = call TFAR_fnc_activeSwRadio;
				if !(isNil "_active_sw_radio") then {
					TF_saved_active_sw_settings = _active_sw_radio call TFAR_fnc_getSwSettings;
				} else {
					TF_saved_active_sw_settings = nil;
				};
			} else {
				TF_saved_active_sw_settings = nil;
			};
		};

		if !(TF_use_saved_lr_setting) then {
			if ((alive TFAR_currentUnit) and (call TFAR_fnc_haveLRRadio)) then {
				_active_lr_radio = call TFAR_fnc_activeLrRadio;
				if !(isNil "_active_lr_radio") then {
					TF_saved_active_lr_settings = _active_lr_radio call TFAR_fnc_getLrSettings;
				} else {
					TF_saved_active_lr_settings = nil;
				};
			} else {
				TF_saved_active_lr_settings = nil;
			};
		};

		sleep 2;
		if ((time - TF_respawnedAt > 10) and (alive TFAR_currentUnit)) then {
			false call TFAR_fnc_requestRadios;
		};
		if !(isNull TFAR_currentUnit) then {
			_currentPlayerFlag = TFAR_currentUnit getVariable "tf_force_radio_active";
			if (isNil "_currentPlayerFlag") then {
				TFAR_currentUnit setVariable ["tf_force_radio_active", TF_ADDON_VERSION, true];
			};
		}
	};

};

TFAR_fnc_radiosList = {
	/*
	 	Name: TFAR_fnc_radiosList

	 	Author(s):
			NKey

	 	Description:
			List of all the player's SW radios.

		Parameters:
			0: OBJECT: unit

	 	Returns:
			ARRAY - List of all the player's SW radios.

	 	Example:
			_radios = TFAR_currentUnit call TFAR_fnc_radiosList;
	*/
	private ["_result"];
	_result = [];
	{
		if (_x call TFAR_fnc_isRadio) then {
			_result pushBack _x;
		};
		true;
	} count (assignedItems _this);

	{
		if (_x call TFAR_fnc_isRadio) then {
			_result pushBack _x;
		};
		true;
	} count (items _this);
	_result
};

TFAR_fnc_radiosListSorted = {
	/*
	 	Name: TFAR_fnc_radiosListSorted

	 	Author(s):

	 	Description:
			Sorts the SW radio list alphabetically.

		Parameters:
			0: OBJECT: Unit

	 	Returns:
			ARRAY - Radio list sorted.

	 	Example:
			_radios = TFAR_currentUnit call TFAR_fnc_radiosListSorted;
	*/
	(_this call TFAR_fnc_radiosList) call BIS_fnc_sortAlphabetically
};

TFAR_fnc_radioToRequestCount = {
	/*
	 	Name: TFAR_fnc_radioToRequestCount

	 	Author(s):
			NKey
			L-H

	 	Description:
			Searches through all the items assigned to and on the player and checks if it is a prototype radio
			and then creates an array of all the classnames of the prototype radios and returns it.

		Parameters:
			BOOLEAN - Regardless of whether the radio is prototype or not, return it as a radio to be replaced.

	 	Returns:
			ARRAY - List of all radio classes to be replaced.

	 	Example:
			_radios = false call TFAR_fnc_radioToRequestCount;
	*/
	private ["_to_remove", "_allRadios", "_personalRadio", "_riflemanRadio", "_defaultRadio", "_classes"];
	waitUntil {sleep 0.1;!(isNull TFAR_currentUnit)};

	_to_remove = [];
	_allRadios = _this;

	_personalRadio = nil;
	_riflemanRadio = nil;

	_classes = call TFAR_fnc_getDefaultRadioClasses;
	_personalRadio = _classes select 1;
	_riflemanRadio = _classes select 2;

	if ((TF_give_personal_radio_to_regular_soldier) or {leader TFAR_currentUnit == TFAR_currentUnit} or {rankId TFAR_currentUnit >= 2}) then {
		_defaultRadio = _personalRadio;
	} else {
		_defaultRadio = _riflemanRadio;
	};

	TF_settingsToCopy = [];
	{
	    if (_x call TFAR_fnc_isPrototypeRadio) then {
			_to_remove pushBack _x;
	        TF_first_radio_request = true;
	    } else {
			if (_x call TFAR_fnc_isRadio) then {
				if ((_x call TFAR_fnc_getRadioOwner) == "") then {
					[_x, getPlayerUID player] call TFAR_fnc_setRadioOwner;
				};
				if (((_x call TFAR_fnc_getRadioOwner) != (getPlayerUID player)) or _allRadios) then {
					_to_remove pushBack _x;
					TF_settingsToCopy set [0, _x];
					TF_first_radio_request = true;
				};
			};
		};
		true;
	} count (assignedItems TFAR_currentUnit);
	{
	    if (_x call TFAR_fnc_isPrototypeRadio) then {
	        _to_remove pushBack _x;
	    } else {
			if (_x call TFAR_fnc_isRadio) then {
				if ((_x call TFAR_fnc_getRadioOwner) == "") then {
					[_x, getPlayerUID player] call TFAR_fnc_setRadioOwner;
				};
				if (((_x call TFAR_fnc_getRadioOwner) != (getPlayerUID player)) or _allRadios) then {
					_to_remove pushBack _x;
					TF_settingsToCopy pushBack _x;
				};
			};
		};
		true;
	} count (items TFAR_currentUnit);

	{
		TFAR_currentUnit unassignItem _x;
		TFAR_currentUnit removeItem _x;
		if (_x == "ItemRadio") then {
			_to_remove set [_forEachIndex, _defaultRadio];
		};
	} forEach _to_remove;
	_to_remove
};

TFAR_fnc_removeEventHandler = {
	/*
	 	Name: TFAR_fnc_removeEventHandler

	 	Author(s):
			L-H

	 	Description:
			Removes an event from a unit/global

		Parameters:
			0: STRING - ID for custom handler
			1: STRING - ID for event
			2: OBJECT - Unit to add the event to, ObjNull to add globally.

	 	Returns:
			NOTHING

	 	Example:
			["MyID", "OnSpeak", player] call TFAR_fnc_removeEventHandler;
	*/
	private ["_customID", "_eventID", "_unit", "_handlers", "_alreadySet"];
	_customID = _this select 0;
	_eventID = _this select 1;
	_unit = _this select 2;

	if (isNull _unit) then {
		_unit = missionNamespace;
	};
	_eventID = format ["TFAR_event_%1", _eventID];
	_handlers = _unit getVariable [_eventID, []];
	{
		if (_customID == (_x select 0)) exitWith {
			_handlers = _handlers - _x;
		};
		true;
	} count _handlers;

	_unit setVariable [_eventID, _handlers];
};

TFAR_fnc_requestRadios = {
	/*
	 	Name: TFAR_fnc_requestRadios

	 	Author(s):
			NKey
			L-H

	 	Description:
			Checks whether the player needs to have radios converted to "instanced" versions,
			handles waiting for response from server with radio classnames and applying them to the player.

		Parameters:
			Nothing

	 	Returns:
			Nothing

	 	Example:
			spawn TFAR_fnc_requestRadios;
	*/
	private ["_radiosToRequest", "_variableName", "_responseVariableName", "_response", "_fnc_CopySettings"];

	_fnc_CopySettings = {
		private ["_source", "_destination", "_variableName", "_localSettings"];
		if ((_this select 0) > (_this select 1)) then {
			if ([(_this select 2), TF_settingsToCopy select (_this select 1)] call TFAR_fnc_isSameRadio) then {
				_source = TF_settingsToCopy select (_this select 1);
				_variableName = format["%1_settings_local", _source];
				_localSettings = missionNamespace getVariable _variableName;
				if !(isNil "_variableName") then {
					_destination = (_this select 2);
					[_destination, _localSettings, true] call TFAR_fnc_setSwSettings;
				};
				_copyIndex = _copyIndex + 1;
			};
		};
		((_this select 1) + 1)
	};

	waitUntil {
		if (!TF_radio_request_mutex) exitWith {TF_radio_request_mutex = true; true};
		false;
	};

	if ((time - TF_last_request_time > 3) or {_this}) then {
		TF_last_request_time = time;
		_variableName = "radio_request_" + (getPlayerUID player) + str (player call BIS_fnc_objectSide);
		_radiosToRequest = _this call TFAR_fnc_radioToRequestCount;

		if ((count _radiosToRequest) > 0) then {
			missionNamespace setVariable [_variableName, _radiosToRequest];
			_responseVariableName = "radio_response_" + (getPlayerUID player) + str (player call BIS_fnc_objectSide);
			missionNamespace setVariable [_responseVariableName, nil];
			publicVariableServer _variableName;
			[parseText(localize ("STR_wait_radio")), 10] call TFAR_fnc_ShowHint;

			waitUntil {!(isNil _responseVariableName)};
			_response = missionNamespace getVariable _responseVariableName;
			private "_copyIndex";
			_copyIndex = 0;
			if ((typename _response) == "ARRAY") then {
				private ["_radioCount","_settingsCount", "_startIndex"];
				_radioCount = count _response;
				_settingsCount = count TF_SettingsToCopy;
				_startIndex = 0;
				if (_radioCount > 0) then {
					if (TF_first_radio_request) then {
						TF_first_radio_request = false;
						TFAR_currentUnit linkItem (_response select 0);
						_copyIndex = [_settingsCount, _copyIndex, (_response select 0)] call _fnc_CopySettings;
						[(_response select 0), getPlayerUID player, true] call TFAR_fnc_setRadioOwner;
						_startIndex = 1;
					};
					_radioCount = _radioCount - 1;
					for "_index" from _startIndex to _radioCount do {
						TFAR_currentUnit addItem (_response select _index);
						_copyIndex = [_settingsCount, _copyIndex, (_response select _index)] call _fnc_CopySettings;
						[(_response select _index), getPlayerUID player, true] call TFAR_fnc_setRadioOwner;
					};
					//TF_settingsToCopy = [];
				};
			}else{
				hintC _response;
			};
			call TFAR_fnc_HideHint;
			//								unit, radios
			["OnRadiosReceived", TFAR_currentUnit, [TFAR_currentUnit, _response]] call TFAR_fnc_fireEventHandlers;
		};
		TF_last_request_time = time;
	};
	TF_radio_request_mutex = false;
};

TFAR_fnc_sendFrequencyInfo = {
	/*
	 	Name: TFAR_fnc_sendFrequencyInfo

	 	Author(s):
			NKey

	 	Description:
			Notifies the plugin about the radios currently being used by the player and various settings active on the radio.

		Parameters:
			Nothing

	 	Returns:
			Nothing

	 	Example:
			call TFAR_fnc_sendFrequencyInfo;
	*/

	private ["_request","_result","_freq","_freq_lr","_freq_dd","_alive","_nickname","_isolated_and_inside","_can_speak","_depth","_globalVolume", "_voiceVolume", "_spectator", "_receivingDistanceMultiplicator", "_radios"];

	// send frequencies
	_freq = ["No_SW_Radio"];
	_freq_lr = ["No_LR_Radio"];
	_freq_dd = "No_DD_Radio";

	_isolated_and_inside = TFAR_currentUnit call TFAR_fnc_vehicleIsIsolatedAndInside;
	_depth = TFAR_currentUnit call TFAR_fnc_eyeDepth;
	_can_speak = [_isolated_and_inside, _depth] call TFAR_fnc_canSpeak;

	if (((call TFAR_fnc_haveSWRadio) or (TFAR_currentUnit != player)) and {[TFAR_currentUnit, _isolated_and_inside, _can_speak, _depth] call TFAR_fnc_canUseSWRadio}) then {
		_freq = [];
		_radios = TFAR_currentUnit call TFAR_fnc_radiosList;
		if (TFAR_currentUnit != player) then {
			_radios = _radios + (player call TFAR_fnc_radiosList);
		};
		{
			if (!(_x call TFAR_fnc_getSwSpeakers) or {(TFAR_currentUnit != player) and (_x in (player call TFAR_fnc_radiosList))}) then {
				if ((_x call TFAR_fnc_getAdditionalSwChannel) == (_x call TFAR_fnc_getSwChannel)) then {
					_freq pushBack format ["%1%2|%3|%4", _x call TFAR_fnc_getSwFrequency, _x call TFAR_fnc_getSwRadioCode, _x call TFAR_fnc_getSwVolume, _x call TFAR_fnc_getAdditionalSwStereo];
				} else {
					_freq pushBack format ["%1%2|%3|%4", _x call TFAR_fnc_getSwFrequency, _x call TFAR_fnc_getSwRadioCode, _x call TFAR_fnc_getSwVolume, _x call TFAR_fnc_getSwStereo];
					if ((_x call TFAR_fnc_getAdditionalSwChannel) > -1) then {
						_freq pushBack format ["%1%2|%3|%4", [_x, (_x call TFAR_fnc_getAdditionalSwChannel) + 1] call TFAR_fnc_GetChannelFrequency, _x call TFAR_fnc_getSwRadioCode, _x call TFAR_fnc_getSwVolume, _x call TFAR_fnc_getAdditionalSwStereo];
					};
				};
			};
			true;
		} count (_radios);
	};
	if (((call TFAR_fnc_haveLRRadio) or (TFAR_currentUnit != player)) and {[TFAR_currentUnit, _isolated_and_inside, _depth] call TFAR_fnc_canUseLRRadio}) then {
		_freq_lr = [];
		_radios = TFAR_currentUnit call TFAR_fnc_lrRadiosList;
		if (TFAR_currentUnit != player) then {
			_radios = _radios + (player call TFAR_fnc_lrRadiosList);
		};
		{
			if (!(_x call TFAR_fnc_getLrSpeakers) or {(TFAR_currentUnit != player) and (_x in (player call TFAR_fnc_lrRadiosList))}) then {
				if ((_x call TFAR_fnc_getAdditionalLrChannel) == (_x call TFAR_fnc_getLrChannel)) then {
					_freq_lr pushBack format ["%1%2|%3|%4", _x call TFAR_fnc_getLrFrequency, _x call TFAR_fnc_getLrRadioCode, _x call TFAR_fnc_getLrVolume, _x call TFAR_fnc_getAdditionalLrStereo];
				} else {
					_freq_lr pushBack format ["%1%2|%3|%4", _x call TFAR_fnc_getLrFrequency, _x call TFAR_fnc_getLrRadioCode, _x call TFAR_fnc_getLrVolume, _x call TFAR_fnc_getLrStereo];
					if ((_x call TFAR_fnc_getAdditionalLrChannel) > -1) then {
						_freq_lr pushBack format ["%1%2|%3|%4", [_x, (_x call TFAR_fnc_getAdditionalLrChannel) + 1] call TFAR_fnc_GetChannelFrequency, _x call TFAR_fnc_getLrRadioCode, _x call TFAR_fnc_getLrVolume, _x call TFAR_fnc_getAdditionalLrStereo];
					};
				};
			};
			true;
		} count (_radios);
	};
	if ((call TFAR_fnc_haveDDRadio) and {[_depth, _isolated_and_inside] call TFAR_fnc_canUseDDRadio}) then {
		_freq_dd = TF_dd_frequency;
	};
	_alive = alive TFAR_currentUnit;
	if (_alive) then {
		TFAR_player_name = name player;
	};

	_nickname = TFAR_player_name;
	_globalVolume = TFAR_currentUnit getVariable "tf_globalVolume";
	if (isNil "_globalVolume") then {
		_globalVolume = 1.0;
	};
	_voiceVolume = TFAR_currentUnit getVariable "tf_voiceVolume";
	if (isNil "_voiceVolume") then {
		_voiceVolume = 1.0;
	};
	_spectator = TFAR_currentUnit getVariable "tf_forceSpectator";
	if (isNil "_spectator") then {
		_spectator = false;
	};
	if (_spectator) then {
		_alive = false;
	};
	_receivingDistanceMultiplicator = TFAR_currentUnit getVariable "tf_receivingDistanceMultiplicator";
	if (isNil "_receivingDistanceMultiplicator") then {
		_receivingDistanceMultiplicator = 1.0;
	};
	
	_volLocPlay = TF_speak_volume_meters;
	//если в бессознанке то собсна нихуя
	if (!([] call interact_isActive)) then {
		_volLocPlay = 0;
		_voiceVolume = 0;
	};
	// NE TOT METHOD
	
	_request = format["FREQ	%1	%2	%3	%4	%5	%6	%7	%8	%9	%10	%11	%12	%13", str(_freq), str(_freq_lr), _freq_dd, _alive, _volLocPlay min TF_max_voice_volume, TF_dd_volume_level, _nickname, waves, TF_terrain_interception_coefficient, _globalVolume, _voiceVolume, _receivingDistanceMultiplicator, TF_speakerDistance];
	_result = "task_force_radio_pipe" callExtension _request;
};

TFAR_fnc_sendPlayerInfo = {
	/*
	 	Name: TFAR_fnc_sendPlayerInfo

	 	Author(s):
			NKey

	 	Description:
			Notifies the plugin about a player

		Parameters:
			1: OBJECT - Unit
			2: BOOLEAN - Is unit close to player
			3: STRING - Unit name


	 	Returns:
			Nothing

	 	Example:
			[player] call TFAR_fnc_sendPlayerInfo;
	*/
	private ["_request","_result", "_player", "_isNearPlayer", "_killSet"];
	_player = _this select 0;

	_request = _this call TFAR_fnc_preparePositionCoordinates;
	_result = "task_force_radio_pipe" callExtension _request;

	if ((_result != "OK") and {_result != "SPEAKING"} and {_result != "NOT_SPEAKING"}) then {
		[parseText (_result), 10] call TFAR_fnc_showHint;
		tf_lastError = true;
	} else {
		if (tf_lastError) then {
			call TFAR_fnc_hideHint;
			tf_lastError = false;
		};
	};
	if (_result == "SPEAKING") then {
		_player setRandomLip true;
		if (!(_player getVariable ["tf_isSpeaking", false])) then {
			_player setVariable ["tf_isSpeaking", true];
			["OnSpeak", _player, [_player, true]] call TFAR_fnc_fireEventHandlers;
		};
		_player setVariable ["tf_start_speaking", diag_tickTime];
	} else {
		_player setRandomLip false;
		if ((_player getVariable ["tf_isSpeaking", false])) then {
			_player setVariable ["tf_isSpeaking", false];
			["OnSpeak", _player, [_player, false]] call TFAR_fnc_fireEventHandlers;
		};
	};
	_killSet = _player getVariable "tf_killSet";
	if (isNil "_killSet") then {
		_player addEventHandler ["Killed", {(_this select 0) call TFAR_fnc_sendPlayerKilled}];
		_player setVariable ["tf_killSet", true];
	};

};

TFAR_fnc_sendPlayerKilled = {
	/*
	 	Name: TFAR_fnc_sendPlayerKilled

	 	Author(s):
			NKey

	 	Description:
			Notifies the plugin that a unit has been killed.

		Parameters:
			OBJECT - Unit that was killed

	 	Returns:
			Nothing

	 	Example:
			player call TFAR_fnc_sendPlayerKilled;
	*/
	private ["_request", "_result"];
	_this setRandomLip false;
	_request = format["KILLED	%1", name _this];
	_result = "task_force_radio_pipe" callExtension _request;
};

TFAR_fnc_sendVersionInfo = {
	/*
	 	Name: TFAR_fnc_sendVersionInfo

	 	Author(s):
			NKey

	 	Description:
			Sends information about the current TFAR version.

		Parameters:
			Nothing

	 	Returns:
			Nothing

	 	Example:
			call TFAR_fnc_sendVersionInfo;
	*/
	// send information about version
	private ["_request","_result"];
	_request = format["VERSION	%1	%2	%3", TF_ADDON_VERSION, tf_radio_channel_name, tf_radio_channel_password];
	_result = "task_force_radio_pipe" callExtension _request;
};

#endif
//VOICE_DISABLE_LEGACYCODE

TFAR_fnc_sessionTracker = {
	/*
	 	Name: TFAR_fnc_sessionTracker

	 	Author(s):
			NKey

	 	Description:
			Collects some statistic information to help make TFAR better.

		Parameters:
			Nothing

	 	Returns:
			Nothing

	 	Example:
			call TFAR_fnc_sessionTracker
	*/
	if (true) exitWith {}; //fuckoff
		
	_h = [] spawn {
		private ["_request", "_action"];
		waitUntil {sleep 10;!(isNull player)};
		_action = "start";
		if (isMultiplayer) then {
			sleep (60 * 1);
			 while {true} do {
				_request = format['TRACK	piwik.php?idsite=2&rec=1&url="radio.task-force.ru&action_name=%1&rand=%2&uid=%3&cvar={"1":["group","%4"], "2":["playableUnits","%5"], "3":["allUnits","%6"], "4":["BIS_fnc_listCuratorPlayers","%7"], "5":["playerSide","%8"], "5":["faction","%9"], "6":["isServer","%10"], "7":["isDedicated","%11"], "8":["missionName","%12"], "9":["currentSW","%13"], "10":["currentLR","%14"], "11":["nearPlayers","%15"], "12":["farPlayers","%16"], "13":["typeof","%17"], "14":["diag_fps","%18"], "15":["diag_fpsmin","%19"], "16":["daytime","%20"], "17":["vehicle","%21"], "18":["time","%22"], "19":["version","%23"]}', _action, random 1000, getPlayerUID player, count (units group player), count playableUnits, count allUnits, count (call BIS_fnc_listCuratorPlayers), playerSide, faction player, isServer, isDedicated, missionName, count (TFAR_currentUnit call TFAR_fnc_radiosList), count (TFAR_currentUnit call TFAR_fnc_lrRadiosList), count tf_nearPlayers, count tf_farPlayers, typeof TFAR_currentUnit, diag_fps, diag_fpsmin, daytime, typeof (vehicle TFAR_currentUnit), time, TF_ADDON_VERSION];
				"task_force_radio_pipe" callExtension _request;
				_action = "continue";
				sleep (60 * 10);
			};
		};

	}; allThreads pushBack _h;
};
