// ======================================================
// Copyright (c) 2017-2025 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================


#ifndef VOICE_DISABLE_LEGACYCODE
TFAR_fnc_setActiveLrRadio = {
	/*
	 	Name: TFAR_fnc_setActiveLrRadio

	 	Author(s):
			NKey

	 	Description:
			Sets the active LR radio to the passed radio

	 	Parameters:
			ARRAY:
				0: OBJECT - Radio
				1: STRING - Radio ID

	 	Returns:
			Nothing

	 	Example:
			TF_lr_dialog_radio call TFAR_fnc_setActiveLrRadio;
	*/
	private "_old";
	_old = TF_lr_active_radio;
	TF_lr_active_radio = _this;
	if (TFAR_currentUnit == player) then {
		TF_lr_active_curator_radio = _this;
	};
	["OnLRChange", TFAR_currentUnit, [TFAR_currentUnit, TF_lr_active_radio, _old]] call TFAR_fnc_fireEventHandlers;
};

TFAR_fnc_setActiveSwRadio = {
	/*
	 	Name: TFAR_fnc_setActiveSwRadio

	 	Author(s):
			NKey

	 	Description:
			Sets the active SW radio.

		Parameters:
			STRING - Radio ID

	 	Returns:
			Nothing

	 	Example:
			"tf_anprc148jem_1" call TFAR_fnc_setActiveSwRadio;
	*/
	_old = (call TFAR_fnc_activeSwRadio);
	TFAR_currentUnit unassignItem _old;
	TFAR_currentUnit assignItem _this;
	["OnSWChange", TFAR_currentUnit, [TFAR_currentUnit, _this, _old]] call TFAR_fnc_fireEventHandlers;
};

TFAR_fnc_setAdditionalLrChannel = {
	/*
	 	Name: TFAR_fnc_setAdditionalLrChannel

	 	Author(s):
			NKey

	 	Description:
			Sets the radio to the passed channel or disables it (if current additional passed).

		Parameters:
			0: OBJECT - Radio object
			1: STRING - Radio ID
			2: NUMBER - Channel : Range (0,8)

	 	Returns:
			Nothing

	 	Example:
			[(call TFAR_fnc_activeLrRadio) select 0, (call TFAR_fnc_activeLrRadio) select 1, 4] call TFAR_fnc_setAdditionalLrChannel;
	*/
	#include "script.h"
	private ["_radio_object", "_radio_qualifier", "_value", "_settings"];
	_radio_object = _this select 0;
	_radio_qualifier = _this select 1;
	_value = _this select 2;
	_settings = [_radio_object, _radio_qualifier] call TFAR_fnc_getLrSettings;
	if ((_settings select TF_ADDITIONAL_CHANNEL_OFFSET) != _value) then {
		_settings set [TF_ADDITIONAL_CHANNEL_OFFSET, _value];
	} else {
		_settings set [TF_ADDITIONAL_CHANNEL_OFFSET, -1];
	};
	[_radio_object, _radio_qualifier, _settings] call TFAR_fnc_setLrSettings;

	//							unit, radio object,		radio ID			channel, additional
	["OnLRchannelSet", TFAR_currentUnit, [TFAR_currentUnit, _radio_object, _radio_qualifier, _value, true]] call TFAR_fnc_fireEventHandlers;
};

TFAR_fnc_setAdditionalLrStereo = {
	/*
	 	Name: TFAR_fnc_setAdditionalLrStereo

	 	Author(s):
			NKey

	 	Description:
			Sets the stereo setting for additional channel the passed radio

	 	Parameters:
			0: OBJECT - Radio object
			1: STRING - Radio ID
			2: NUMBER - Stereo setting : Range (0,2) (0 - Both, 1 - Left, 2 - Right)

	 	Returns:
			Nothing

	 	Example:
			[(call TFAR_fnc_activeLrRadio) select 0, (call TFAR_fnc_activeLrRadio) select 1, 1] call TFAR_fnc_setAdditionalLrStereo;
	*/
	#include "script.h"
	private ["_radio_object", "_radio_qualifier", "_value", "_settings"];
	_radio_object = _this select 0;
	_radio_qualifier = _this select 1;
	_value = _this select 2;

	_settings = [_radio_object, _radio_qualifier] call TFAR_fnc_getLrSettings;
	_settings set [TF_ADDITIONAL_STEREO_OFFSET, _value];
	[_radio_object, _radio_qualifier, _settings] call TFAR_fnc_setLrSettings;

	//							unit, radio object,		radio ID			channel, additional
	["OnLRstereoSet", TFAR_currentUnit, [TFAR_currentUnit, _radio_object, _radio_qualifier, _value, true]] call TFAR_fnc_fireEventHandlers;
};

TFAR_fnc_setAdditionalSwChannel = {
	/*
	 	Name: TFAR_fnc_setAdditionalSwChannel

	 	Author(s):
			NKey

	 	Description:
			Sets the additional channel for the passed radio or disables it (if additional channel in arguments).

	 	Parameters:
			0: STRING - Radio classname
			1: NUMBER - Channel

	 	Returns:
			Nothing

	 	Example:
			[(call TFAR_fnc_activeSwRadio), 2] call TFAR_fnc_setAdditionalSwChannel;
	*/
	#include "script.h"
	private ["_settings", "_radio_id", "_channel_to_set"];
	_radio_id = _this select 0;
	_channel_to_set = _this select 1;
	_settings = _radio_id call TFAR_fnc_getSwSettings;
	if ((_settings select TF_ADDITIONAL_CHANNEL_OFFSET) != _channel_to_set) then {
		_settings set [TF_ADDITIONAL_CHANNEL_OFFSET, _channel_to_set];
	} else {
		_settings set [TF_ADDITIONAL_CHANNEL_OFFSET, -1];
	};
	[_radio_id, _settings] call TFAR_fnc_setSwSettings;

	//							unit, radio ID,		channel, additional
	["OnSWchannelSet", TFAR_currentUnit, [TFAR_currentUnit, _radio_id, _channel_to_set, true]] call TFAR_fnc_fireEventHandlers;
};

TFAR_fnc_setAdditionalSwStereo = {
	/*
	 	Name: TFAR_fnc_setAdditionalSwStereo

	 	Author(s):
			NKey

	 	Description:
			Sets the stereo setting for additional channel the SW radio

	 	Parameters:
	 	0: STRING - Radio
		1: NUMBER - Stereo : Range (0,2) (0 - Both, 1 - Left, 2 - Right)

	 	Returns:
			Nothing

	 	Example:
			[(call TFAR_fnc_ActiveSWRadio), 2] call TFAR_fnc_setAdditionalSwStereo;
	 */
	#include "script.h"
	private ["_settings", "_radio_id", "_value_to_set"];
	_radio_id = _this select 0;
	_value_to_set = _this select 1;
	_settings = _radio_id call TFAR_fnc_getSwSettings;
	_settings set [TF_ADDITIONAL_STEREO_OFFSET, _value_to_set];
	[_radio_id, _settings] call TFAR_fnc_setSwSettings;

	//							unit, radio ID,	stero, additional
	["OnSWstereoSet", TFAR_currentUnit, [TFAR_currentUnit, _radio_id, _value_to_set, true]] call TFAR_fnc_fireEventHandlers;
};

TFAR_fnc_setChannelFrequency = {
	/*
	 	Name: TFAR_fnc_SetChannelFrequency

	 	Author(s):
			L-H

	 	Description:
			Sets the frequency for the channel on the passed radio.

	 	Parameters:
	 	0: OBJECT/String - Radio
		1: NUMBER - Channel
		2: STRING - Frequency

	 	Returns:
		Nothing

	 	Example:
		// LR radio - channel 1
		[(call TFAR_fnc_activeLrRadio), 1, "56.2"] call TFAR_fnc_SetChannelFrequency;
		// SW radio - channel 1
		[(call TFAR_fnc_activeSwRadio), 1, "84.3"] call TFAR_fnc_SetChannelFrequency;
	*/
	#include "script.h"
	private ["_radio", "_channel", "_settings", "_frequency", "_lr"];
	_radio = _this select 0;
	_channel = (_this select 1) - 1;
	_frequency = _this select 2;

	_lr = if (typename _radio == "STRING") then { false }else{true};

	if (_lr) then {
		_settings = _radio call TFAR_fnc_getLrSettings;
	} else {
		_settings = _radio call TFAR_fnc_getSwSettings;
	};

	if (isNil "_settings") exitWith {};

	(_settings select TF_FREQ_OFFSET) set [_channel, _frequency];

	if (_lr) then {
		[_radio select 0, _radio select 1, _settings] call TFAR_fnc_setLrSettings;
	} else {
		[_radio, _settings] call TFAR_fnc_setSwSettings;
	};
};

TFAR_fnc_setChannelViaDialog = {
	/*
	   Name: TFAR_fnc_setChannelViaDialog

	   Author(s):
	    L-H

	   Description:
	    Sets the channel of the current Dialog radio.

	  Parameters:
	    0: NUMBER - Mouse button pressed (0,1)
	    1: BOOL - LR radio
	    2: STRING - (OPTIONAL) Update formatting.

	   Returns:
	    NOTHING

	   Example:
	    // LR radio
	    [_this select 1, true] call TFAR_fnc_setChannelViaDialog;
	    // SW radio
	    [_this select 1, false] call TFAR_fnc_setChannelViaDialog;
	*/
	private ["_cChange", "_radio", "_lr", "_maxChannels", "_currentChannel", "_fnc_GetChannel", "_format"];
	playSound "TFAR_rotatorPush";
	_format = "";
	if (count _this > 2) then {
	  _format = _this select 2;
	};
	_lr = _this select 1;
	_maxChannels = 0;
	_radio = "";
	_fnc_GetChannel = {};
	if (_lr) then {
	  _maxChannels = TF_MAX_LR_CHANNELS;
	  _radio = TF_lr_dialog_radio;
	  _fnc_GetChannel = TFAR_fnc_getLrChannel;
	}else{
	  _maxChannels = TF_MAX_CHANNELS;
	  _radio = TF_sw_dialog_radio;
	  _fnc_GetChannel = TFAR_fnc_getSwChannel;
	};
	_cChange = if((_this select 0) == 0)then{-1 + _maxChannels}else{1};
	_cChange = ((_radio call _fnc_GetChannel) + _cChange) mod _maxChannels;

	if (_lr) then {
	  [_radio select 0, _radio select 1, _cChange] call TFAR_fnc_setLRChannel;
	  if (_format != "") then {
	    _format call TFAR_fnc_updateLRDialogToChannel;
	  }else{
	    call TFAR_fnc_updateLRDialogToChannel;
	  };
	}else{
	  [_radio, _cChange] call TFAR_fnc_setSwChannel;
	  if (_format != "") then {
	    _format call TFAR_fnc_updateSWDialogToChannel;
	  }else{
	    call TFAR_fnc_updateSWDialogToChannel;
	  };
	};
	[_radio, _lr] call TFAR_fnc_ShowRadioInfo;

};

TFAR_fnc_setLongRangeRadioFrequency = {
	/*
	 	Name: TFAR_fnc_setLongRangeRadioFrequency

	 	Author(s):
			NKey

	 	Description:
			Sets the frequency for the active channel on the active LR radio.

		Parameters:
			STRING - Frequency

	 	Returns:
			Nothing

	 	Example:
			"45.48" call TFAR_fnc_setLongRangeRadioFrequency;
	*/
	if (call TFAR_fnc_haveLRRadio) then {
		[(call TFAR_fnc_activeLrRadio) select 0, (call TFAR_fnc_activeLrRadio) select 1, _this] call TFAR_fnc_setLrFrequency;
	};
};

TFAR_fnc_setLrChannel = {
	/*
	 	Name: TFAR_fnc_setLrChannel

	 	Author(s):
			NKey

	 	Description:
			Sets the radio to the passed channel

		Parameters:
			0: OBJECT - Radio object
			1: STRING - Radio ID
			2: NUMBER - Channel : Range (0,8)

	 	Returns:
			Nothing

	 	Example:
			[(call TFAR_fnc_activeLrRadio) select 0, (call TFAR_fnc_activeLrRadio) select 1, 4] call TFAR_fnc_setLrChannel;
	*/
	#include "script.h"
	private ["_radio_object", "_radio_qualifier", "_value", "_settings"];
	_radio_object = _this select 0;
	_radio_qualifier = _this select 1;
	_value = _this select 2;
	_settings = [_radio_object, _radio_qualifier] call TFAR_fnc_getLrSettings;
	_settings set [ACTIVE_CHANNEL_OFFSET, _value];
	[_radio_object, _radio_qualifier, _settings] call TFAR_fnc_setLrSettings;

	//							unit, radio object,		radio ID			channel, additional
	["OnLRchannelSet", TFAR_currentUnit, [TFAR_currentUnit, _radio_object, _radio_qualifier, _value, false]] call TFAR_fnc_fireEventHandlers;
};

TFAR_fnc_setLrFrequency = {
	/*
	 	Name: TFAR_fnc_setLrFrequency

	 	Author(s):
			NKey

	 	Description:
			Sets the frequency for the active channel

		Parameters:
			0: OBJECT - Radio object
			1: STRING - Radio ID
			2: STRING - Frequency

	 	Returns:
			Nothing

	 	Example:
			[(call TFAR_fnc_activeLrRadio) select 0, (call TFAR_fnc_activeLrRadio) select 1, "45.48"] call TFAR_fnc_setLrFrequency;
	*/
	#include "script.h"
	private ["_radio"];
	_radio = [_this select 0, _this select 1];

	[_radio, ((_radio call TFAR_fnc_getLrSettings) select ACTIVE_CHANNEL_OFFSET)+1, _this select 2] call TFAR_fnc_setChannelFrequency;
};

TFAR_fnc_setLrRadioCode = {
	/*
	 	Name: TFAR_fnc_setLrRadioCode

	 	Author(s):
			L-H

	 	Description:
			Allows setting of the encryption code for individual radios.

	 	Parameters:


	 	Returns:
			Nothing

	 	Example:
			[(call TFAR_fnc_activeLrRadio) select 0, (call TFAR_fnc_activeLrRadio) select 1, "NewEncryptionCode"] call TFAR_fnc_setLrRadioCode;
	*/
	#include "script.h"
	private ["_radio_object", "_radio_qualifier", "_value", "_settings"];
	_radio_object = _this select 0;
	_radio_qualifier = _this select 1;
	_value = _this select 2;
	_settings = [_radio_object, _radio_qualifier] call TFAR_fnc_getLrSettings;
	_settings set [TF_CODE_OFFSET, _value];
	[_radio_object, _radio_qualifier, _settings] call TFAR_fnc_setLrSettings;
};

TFAR_fnc_setLrSettings = {
	/*
	 	Name: TFAR_fnc_setLrSettings

	 	Author(s):
			NKey

	 	Description:
			Saves the settings for the passed radio and broadcasts it to all clients and the server.

		Parameters:
			0: OBJECT - Radio object
			1: STRING - Radio ID
			2: ARRAY - Settings, usually acquired via TFAR_fnc_getLrSettings and then changed.

	 	Returns:
			Nothing

	 	Example:
			_settings = (call TFAR_fnc_activeLrRadio) call TFAR_fnc_getSwSettings;
			_settings set [0, 2]; // sets the active channel to 2
			[(call TFAR_fnc_activeLrRadio) select 0, (call TFAR_fnc_activeLrRadio) select 1, _settings] call TFAR_fnc_setLrSettings;
	*/
	private ["_radio_object", "_radio_qualifier", "_value"];
	_radio_object = _this select 0;
	_radio_qualifier = _this select 1;
	_value = _this select 2;
	_radio_object setVariable [_radio_qualifier, + _value, true];
};

TFAR_fnc_setLrSpeakers = {
	/*
	 	Name: TFAR_fnc_setLrSpeakers

	 	Author(s):
			NKey

	 	Description:
			Sets the speakers setting for the passed radio

	 	Parameters:
			0: OBJECT - Radio object
			1: STRING - Radio ID

	 	Returns:
			Nothing

	 	Example:
			[(call TFAR_fnc_activeLrRadio) select 0, (call TFAR_fnc_activeLrRadio) select 1] call TFAR_fnc_setLrSpeakers;
	*/
	#include "script.h"
	private ["_radio_object", "_radio_qualifier", "_flag", "_settings"];
	_radio_object = _this select 0;
	_radio_qualifier = _this select 1;

	_settings = [_radio_object, _radio_qualifier] call TFAR_fnc_getLrSettings;
	if (_settings select TF_LR_SPEAKER_OFFSET) then {
		_settings set [TF_LR_SPEAKER_OFFSET, false];
	} else {
		_settings set [TF_LR_SPEAKER_OFFSET, true];
		_flag = TFAR_currentUnit getVariable "tf_lr_speakers";
		if (isNil "_flag") then {
			TFAR_currentUnit setVariable ["tf_lr_speakers", true, true];
		};
		_flag = _radio_object getVariable "tf_lr_speakers";
		if (isNil "_flag") then {
			_radio_object setVariable ["tf_lr_speakers", true, true];
		};
	};
	[_radio_object, _radio_qualifier, _settings] call TFAR_fnc_setLrSettings;

	//							unit, radio object,		radio ID			speakers
	["OnLRspeakersSet", TFAR_currentUnit, [TFAR_currentUnit, _radio_object, _radio_qualifier, _settings select TF_LR_SPEAKER_OFFSET]] call TFAR_fnc_fireEventHandlers;
};

TFAR_fnc_setLrStereo = {
	/*
	 	Name: TFAR_fnc_setLrStereo

	 	Author(s):
			NKey

	 	Description:
			Sets the stereo setting for the passed radio

	 	Parameters:
			0: OBJECT - Radio object
			1: STRING - Radio ID
			2: NUMBER - Stereo setting : Range (0,2) (0 - Both, 1 - Left, 2 - Right)

	 	Returns:
			Nothing

	 	Example:
			[(call TFAR_fnc_activeLrRadio) select 0, (call TFAR_fnc_activeLrRadio) select 1, 1] call TFAR_fnc_setLrStereo;
	*/
	#include "script.h"
	private ["_radio_object", "_radio_qualifier", "_value", "_settings"];
	_radio_object = _this select 0;
	_radio_qualifier = _this select 1;
	_value = _this select 2;
	if (([_radio_object, _radio_qualifier] call TFAR_fnc_getAdditionalLrChannel) == ([_radio_object, _radio_qualifier] call TFAR_fnc_getLrChannel)) then {
		_this call TFAR_fnc_setAdditionalLrStereo;
	} else {
		_settings = [_radio_object, _radio_qualifier] call TFAR_fnc_getLrSettings;
		_settings set [TF_LR_STEREO_OFFSET, _value];
		[_radio_object, _radio_qualifier, _settings] call TFAR_fnc_setLrSettings;

		//							unit, radio object,		radio ID			channel, additional
		["OnLRstereoSet", TFAR_currentUnit, [TFAR_currentUnit, _radio_object, _radio_qualifier, _value, false]] call TFAR_fnc_fireEventHandlers;
	};
};

TFAR_fnc_setLrVolume = {
	/*
	 	Name: TFAR_fnc_setLrVolume

	 	Author(s):
			NKey

	 	Description:
			Sets the volume for the passed radio

	 	Parameters:
			0: OBJECT - Radio object
			1: STRING - Radio ID
			2: NUMBER - Volume : Range (0,10)

	 	Returns:
			Nothing

	 	Example:
			[(call TFAR_fnc_activeLrRadio) select 0, (call TFAR_fnc_activeLrRadio) select 1, 5] call TFAR_fnc_setLrVolume;
	*/
	#include "script.h"
	private ["_radio_object", "_radio_qualifier", "_value", "_settings"];
	_radio_object = _this select 0;
	_radio_qualifier = _this select 1;
	_value = _this select 2;
	_settings = [_radio_object, _radio_qualifier] call TFAR_fnc_getLrSettings;
	_settings set [VOLUME_OFFSET, _value];
	[_radio_object, _radio_qualifier, _settings] call TFAR_fnc_setLrSettings;

	//							Unit, radio object, radio ID, volume
	["OnLRvolumeSet", TFAR_currentUnit, [TFAR_currentUnit, _radio_object, _radio_qualifier, _value]] call TFAR_fnc_fireEventHandlers;
};

TFAR_fnc_setPersonalRadioFrequency = {
	/*
	 	Name: TFAR_fnc_setPersonalRadioFrequency

	 	Author(s):
			NKey

	 	Description:
			Sets the frequency for the active SW radio to passed frequency

	 	Parameters:
			STRING - Frequency

	 	Returns:
			Nothing

	 	Example:
			"65.12" call TFAR_fnc_setPersonalRadioFrequency;
	*/
	if (call TFAR_fnc_haveSWRadio) then {
		[(call TFAR_fnc_activeSwRadio), _this] call TFAR_fnc_setSwFrequency;
	};
};

TFAR_fnc_setRadioOwner = {
	/*
	 	Name: TFAR_fnc_setRadioOwner

	 	Author(s):
			L-H

	 	Description:
			Sets the owner of a SW radio.

	 	Parameters:
			0: STRING - radio classname
			1: STRING - UID of owner
			2: BOOLEAN - Local only

	 	Returns:
			Nothing

	 	Example:
			[(call TFAR_fnc_activeSwRadio),player] call TFAR_fnc_setRadioOwner;
	*/
	#include "script.h"
	private ["_radio", "_settings", "_local"];
	_radio = _this select 0;

	_local = false;
	if (count _this == 3) then {
		_local = _this select 2;
	};

	_settings = _radio call TFAR_fnc_getSwSettings;
	_settings set [RADIO_OWNER, _this select 1];
	[_radio, _settings, _local] call TFAR_fnc_setSwSettings;

	//							owner, radio ID
	["OnRadioOwnerSet", TFAR_currentUnit, [TFAR_currentUnit, _radio]] call TFAR_fnc_fireEventHandlers;
};

TFAR_fnc_setSwChannel = {
	/*
	 	Name: TFAR_fnc_setSwChannel

	 	Author(s):
			NKey

	 	Description:
			Sets the channel for the passed radio

	 	Parameters:
			0: STRING - Radio classname
			1: NUMBER - Channel

	 	Returns:
			Nothing

	 	Example:
			[(call TFAR_fnc_activeSwRadio), 2] call TFAR_fnc_setSwChannel;
	*/
	#include "script.h"
	private ["_settings", "_radio_id", "_channel_to_set"];
	_radio_id = _this select 0;
	_channel_to_set = _this select 1;
	_settings = _radio_id call TFAR_fnc_getSwSettings;
	_settings set [ACTIVE_CHANNEL_OFFSET, _channel_to_set];
	[_radio_id, _settings] call TFAR_fnc_setSwSettings;

	//							unit, radio ID,		channel, additional
	["OnSWchannelSet", TFAR_currentUnit, [TFAR_currentUnit, _radio_id, _channel_to_set, false]] call TFAR_fnc_fireEventHandlers;
};

TFAR_fnc_setSwFrequency = {
	/*
	 	Name: TFAR_fnc_setSwFrequency

	 	Author(s):
			NKey
			L-H

	 	Description:
			Sets the frequency for the currently active channel

	 	Parameters:
			0: STRING - Radio classname
			1: STRING - Frequency

	 	Returns:
			Nothing

	 	Example:
			[(call TFAR_fnc_activeSwRadio), "76.2"] call TFAR_fnc_setSwFrequency;
	*/
	#include "script.h"
	private ["_radio"];
	_radio = _this select 0;

	[_radio, ((_radio call TFAR_fnc_getSwSettings) select ACTIVE_CHANNEL_OFFSET)+1, _this select 1] call TFAR_fnc_setChannelFrequency;
};

TFAR_fnc_setSwRadioCode = {
	/*
	 	Name: TFAR_fnc_setSwRadioCode

	 	Author(s):
			L-H

	 	Description:
			Allows setting of the encryption code for individual radios.

	 	Parameters:
			0: STRING - Radio classname
			1: STRING - Encryption code.

	 	Returns:
			Nothing

	 	Example:
			[call TFAR_fnc_activeSwRadio, "NewEncryptionCode"] call TFAR_fnc_setSwRadioCode;
	*/
	private ["_settings", "_radio_id", "_code_to_set"];
	_radio_id = _this select 0;
	_code_to_set = _this select 1;
	_settings = _radio_id call TFAR_fnc_getSwSettings;
	_settings set [TF_CODE_OFFSET, _code_to_set];
	[_radio_id, _settings] call TFAR_fnc_setSwSettings;
};

TFAR_fnc_setSwSettings = {
	/*
	 	Name: TFAR_fnc_setSwSettings

	 	Author(s):
			NKey

	 	Description:
			Saves the settings for the passed radio and broadcasts it to all clients and the server.

	 	Parameters:
			0: STRING - Radio classname
			1: ARRAY - Settings, usually acquired via TFAR_fnc_getSwSettings and then changed.
			2: BOOLEAN - Set local only

	 	Returns:
			Nothing

	 	Example:
			_settings = (call TFAR_fnc_activeSwRadio) call TFAR_fnc_getSwSettings;
			_settings set [0, 2]; // sets the active channel to 2
			[(call TFAR_fnc_activeSwRadio), _settings] call TFAR_fnc_setSwSettings;
	*/
	private ["_radio_id", "_value", "_variableName", "_local"];
	_radio_id = _this select 0;
	_value = _this select 1;
	_variableName = format["%1_settings", _radio_id];
	_local = false;
	if (count _this == 3) then {
		_local = _this select 2;
	};
	missionNamespace setVariable [_variableName, + _value];
	missionNamespace setVariable [_variableName + "_local", + _value];
	if !(_local) then {
		publicVariable _variableName;
	}
};

TFAR_fnc_setSwSpeakers = {
	/*
	 	Name: TFAR_fnc_setSwSpeakers

	 	Author(s):
			NKey

	 	Description:
			Sets the speakers setting for the SW radio

	 	Parameters:
	 	0: STRING - Radio

	 	Returns:
			Nothing

	 	Example:
			[call TFAR_fnc_ActiveSWRadio] call TFAR_fnc_setSwSpeakers;
	 */
	#include "script.h"
	private ["_settings", "_radio_id", "_flag"];
	_radio_id = _this select 0;

	_settings = _radio_id call TFAR_fnc_getSwSettings;
	if (_settings select TF_SW_SPEAKER_OFFSET) then {
		_settings set [TF_SW_SPEAKER_OFFSET, false];
	} else {
		_settings set [TF_SW_SPEAKER_OFFSET, true];
		_flag = TFAR_currentUnit getVariable "tf_sw_speakers";
		if (isNil "_flag") then {
			TFAR_currentUnit setVariable ["tf_sw_speakers", true, true];
		};
	};
	[_radio_id, _settings] call TFAR_fnc_setSwSettings;

	//									unit, radio ID,	speakers
	["OnSWspeakersSet", TFAR_currentUnit, [TFAR_currentUnit, _radio_id, _settings select TF_SW_SPEAKER_OFFSET]] call TFAR_fnc_fireEventHandlers;

};

TFAR_fnc_setSwStereo = {
	/*
	 	Name: TFAR_fnc_setSwStereo

	 	Author(s):
			NKey

	 	Description:
			Sets the stereo setting for the SW radio

	 	Parameters:
	 	0: STRING - Radio
		1: NUMBER - Stereo : Range (0,2) (0 - Both, 1 - Left, 2 - Right)

	 	Returns:
			Nothing

	 	Example:
			[(call TFAR_fnc_ActiveSWRadio), 2] call TFAR_fnc_setSwStereo;
	 */
	#include "script.h"
	private ["_settings", "_radio_id", "_value_to_set"];
	_radio_id = _this select 0;
	if ((_radio_id call TFAR_fnc_getAdditionalSwChannel) == (_radio_id call TFAR_fnc_getSwChannel)) then {
		_this call TFAR_fnc_setAdditionalSwStereo;
	} else {
		_value_to_set = _this select 1;
		_settings = _radio_id call TFAR_fnc_getSwSettings;
		_settings set [TF_SW_STEREO_OFFSET, _value_to_set];
		[_radio_id, _settings] call TFAR_fnc_setSwSettings;

		//							unit, radio ID,	stero, additional
		["OnSWstereoSet", TFAR_currentUnit, [TFAR_currentUnit, _radio_id, _value_to_set, false]] call TFAR_fnc_fireEventHandlers;
	};
};

TFAR_fnc_setSwVolume = {
	/*
	 	Name: TFAR_fnc_setSwVolume

	 	Author(s):
			NKey

	 	Description:
			Sets the volume for the SW radio

	 	Parameters:
	 	0: STRING - Radio
		1: NUMBER - Volume : Range (0,10)

	 	Returns:
			Nothing

	 	Example:
			[(call TFAR_fnc_ActiveSWRadio), 10] call TFAR_fnc_setSwVolume;
	 */
	#include "script.h"
	private ["_settings", "_radio_id", "_value"];
	_radio_id = _this select 0;
	_value = _this select 1;
	_settings = _radio_id call TFAR_fnc_getSwSettings;
	_settings set [VOLUME_OFFSET, _value];
	[_radio_id, _settings] call TFAR_fnc_setSwSettings;

	//							Unit, radio ID, volume
	["OnSWvolumeSet", TFAR_currentUnit, [TFAR_currentUnit, _radio_id, _value]] call TFAR_fnc_fireEventHandlers;
};

TFAR_fnc_setVoiceVolume = {
	/*
	 	Name: TFAR_fnc_setVoiceVolume

	 	Author(s):
			NKey

	 	Description:
			Sets the volume for the player's voice in game

	 	Parameters:
		0: NUMBER - Volume : Range (0,TF_max_voice_volume)

	 	Returns:
			Nothing

	 	Example:
			30 call TFAR_fnc_setVoiceVolume;
	 */
	#include "script.h"
	TF_speak_volume_meters = TF_max_voice_volume min _this;

	//							unit, range
	["OnSpeakVolume", TFAR_currentUnit, [TFAR_currentUnit, TF_speak_volume_meters]] call TFAR_fnc_fireEventHandlers;

};

TFAR_fnc_setVolumeViaDialog = {
	/*
	   Name: TFAR_fnc_setVolumeViaDialog

	   Author(s):
	    L-H

	   Description:
	    Sets the volume of the current Dialog radio.

	  Parameters:
	    0: NUMBER - Mouse button pressed (0,1)
	    1: BOOL - LR radio

	   Returns:
	    NOTHING

	   Example:
	    // LR radio
	    [_this select 1, true] call TFAR_fnc_setVolumeViaDialog;
	    // SW radio
	    [_this select 1, false] call TFAR_fnc_setVolumeViaDialog;
	*/
	private ["_vChange", "_radio", "_lr", "_maxVolume", "_currentVolume", "_fnc_GetVolume"];
	playSound "TFAR_rotatorPush";

	_lr = _this select 1;
	_maxVolume = 0;
	_radio = "";
	_fnc_GetVolume = {};
	if (_lr) then {
	  _maxVolume = TF_MAX_LR_VOLUME;
	  _radio = TF_lr_dialog_radio;
	  _fnc_GetVolume = TFAR_fnc_getLrVolume;
	}else{
	  _maxVolume = TF_MAX_SW_VOLUME;
	  _radio = TF_sw_dialog_radio;
	  _fnc_GetVolume = TFAR_fnc_getSwVolume;
	};
	_vChange = if((_this select 0) == 0)then{-1 + _maxVolume}else{1};
	_vChange = ((_radio call _fnc_GetVolume) + _vChange) mod _maxVolume;

	if (_lr) then {
	  [_radio select 0, _radio select 1, _vChange] call TFAR_fnc_setLrVolume;
	}else{
	  [_radio,_vChange] call TFAR_fnc_setSwVolume;
	};
	[_radio] call TFAR_fnc_ShowRadioVolume;

};
#endif
//VOICE_DISABLE_LEGACYCODE

TFAR_fnc_ShowHint = {
	/*
	 	Name: TFAR_fnc_ShowHint

	 	Author(s):
			L-H

	 	Description:
		Displays a hint at the bottom right of the screen.

	 	Parameters:
	 	0: STRING - Text to display
		1: Number - Time to display the hint (-1 for infinite)

	 	Returns:
		Nothing

	 	Example:
		["Hello", 3] call TFAR_fnc_ShowHint;
		["Hello", -1] call TFAR_fnc_ShowHint;
	 */
	private ["_text","_time"];
	_text = _this select 0;
	_time = _this select 1;
	
	if (true) exitWith {
		traceformat("[VoiceSystem::hint()]: - %1",_text)
	};	
	
	if (isNull (uiNamespace getVariable ["TFAR_Hint_Display", displayNull])) then {
		("TFAR_HintLayer" call BIS_fnc_rscLayer) cutRsc["RscTaskForceHint", "PLAIN",0,true];
	};
	((uiNamespace getVariable ["TFAR_Hint_Display", displayNull]) displayCtrl 1100) ctrlSetStructuredText _text;

	if !(isNil "TF_HintFnc") then {
		terminate TF_HintFnc;
	};
	if (_time == -1) exitWith {};

	TF_HintFnc = [_time] spawn {
		sleep (_this select 0);
		call TFAR_fnc_HideHint;
	}; allThreads pushBack TF_HintFnc;
};

#ifndef VOICE_DISABLE_LEGACYCODE
TFAR_fnc_ShowRadioInfo = {
	/*
	 	Name: TFAR_fnc_ShowRadioInfo

	 	Author(s):
			L-H

	 	Description:

	 	Parameters:
		0: OBJECT/STRING - Radio
		1: BOOLEAN - is LR radio

	 	Returns:
		Nothing

	 	Example:
		// LR radio
		[(call TFAR_fnc_activeLrRadio), true] call TFAR_fnc_ShowRadioInfo;
		// SW radio
		[(call TFAR_fnc_activeSwRadio), false] call TFAR_fnc_ShowRadioInfo;
	*/
	private ["_hintText", "_radio", "_isLrRadio", "_name", "_picture", "_channel", "_additional", "_add_channel", "_imagesize"];
	_radio = _this select 0;
	_isLrRadio = _this select 1;

	_name = if(_isLrRadio) then {getText (ConfigFile >> "CfgVehicles" >> typeof (_radio select 0) >> "displayName")} else {getText(configFile >> "CfgWeapons" >> _radio >> "displayName")};
	_picture = if(_isLrRadio) then {getText (ConfigFile >> "CfgVehicles" >> typeof (_radio select 0) >> "picture")} else {getText(configFile >> "CfgWeapons" >> _radio >> "picture")};

	_channel = if(_isLrRadio) then {format[localize "STR_active_lr_channel", (_radio call TFAR_fnc_getLrChannel) + 1]} else {format[localize "STR_active_sw_channel", (_radio call TFAR_fnc_getSwChannel) + 1]};
	_additional = nil;
	if (_isLrRadio) then {
		_additional = _radio call TFAR_fnc_getAdditionalLrChannel;
	} else {
		_additional = _radio call TFAR_fnc_getAdditionalSwChannel;
	};
	_add_channel = "";
	if (_additional > -1) then {
		_add_channel = if(_isLrRadio) then {format[localize "STR_active_additional_lr_channel", (_radio call TFAR_fnc_getAdditionalLrChannel) + 1]} else {format[localize "STR_active_additional_sw_channel", (_radio call TFAR_fnc_getAdditionalSwChannel) + 1]};
	};

	_imagesize = "1.6";
	if ((_isLrRadio) and {!((_radio select 0) isKindOf "Bag_Base")}) then {
		_imagesize = "1.0";
	};
	_hintText = format [("<t size='1' align='center'>%1 <img size='" + _imagesize + "' image='%2'/></t><br /><t align='center'>%3</t><br /><t align='center'>%4</t><br /><t align='center'>%5</t>"), _name,_picture,_channel,
		format[localize "STR_active_frequency", if(_isLrRadio) then {_radio call TFAR_fnc_getLrFrequency} else {_radio call TFAR_fnc_getSwFrequency}], _add_channel];

	[parseText (_hintText), 5] call TFAR_fnc_showHint;
};

TFAR_fnc_showRadioSpeakers = {
	/*
	 	Name: TFAR_fnc_ShowRadioSpeakers

	 	Author(s):
			L-H
			Nkey

	 	Description:

	 	Parameters:
		0: OBJECT/STRING - Radio
		1: BOOLEAN - DD radio (Optional)

	 	Returns:
		Nothing

	 	Example:
		// LR radio
		[(call TFAR_fnc_activeLrRadio)] call TFAR_fnc_ShowRadioSpeakers;
		// SW radio
		[(call TFAR_fnc_activeSwRadio)] call TFAR_fnc_ShowRadioSpeakers;
		// DD radio
		["", true] call TFAR_fnc_ShowRadioSpeakers;
	*/
	private ["_hintText", "_radio", "_isLrRadio", "_name", "_picture", "_volume", "_speakers", "_imagesize"];
	_radio = _this select 0;
	_isDDRadio = [_this,1,false,[true]] call BIS_fnc_param;
	_isLrRadio = if (typename _radio == "STRING")then{false}else{true};

	if !(_isDDRadio) then {
		_name = if(_isLrRadio) then {getText (ConfigFile >> "CfgVehicles" >> typeof (_radio select 0) >> "displayName")} else {getText(configFile >> "CfgWeapons" >> _radio >> "displayName")};
		_picture = if(_isLrRadio) then {getText (ConfigFile >> "CfgVehicles" >> typeof (_radio select 0) >> "picture")} else {getText(configFile >> "CfgWeapons" >> _radio >> "picture")};
		_volume = formatText [localize "STR_radio_volume",if(_isLrRadio) then {((_radio call TFAR_fnc_getLrVolume) + 1) * 10} else {((_radio call TFAR_fnc_getSwVolume) + 1) * 10}];
		_speakers = localize format ["STR_speakers_settings_%1", if(_isLrRadio) then {_radio call TFAR_fnc_getLrSpeakers} else {_radio call TFAR_fnc_getSwSpeakers}];

		_imagesize = "1.6";
		if ((_isLrRadio) and {!((_radio select 0) isKindOf "Bag_Base")}) then {
			_imagesize = "1.0";
		};
		_hintText = format [("<t size='1' align='center'>%1 <img size='" + _imagesize + "' image='%2'/></t><br /><t align='center'>%3</t><br /><t align='center'>%4</t><br /><t size='0.8' align='center'>%5</t>"), _name, _picture, _volume, _speakers];
	}else{
		_hintText = format ["%1<br />%2", "DD Radio",formatText [localize "STR_radio_volume",((TF_dd_volume_level + 1) * 10)]];
	};

	[parseText (_hintText), 5] call TFAR_fnc_showHint;
};

TFAR_fnc_ShowRadioVolume = {
	/*
	 	Name: TFAR_fnc_ShowRadioVolume

	 	Author(s):
			L-H

	 	Description:

	 	Parameters:
		0: OBJECT/STRING - Radio
		1: BOOLEAN - DD radio (Optional)

	 	Returns:
		Nothing

	 	Example:
		// LR radio
		[(call TFAR_fnc_activeLrRadio)] call TFAR_fnc_ShowRadioVolume;
		// SW radio
		[(call TFAR_fnc_activeSwRadio)] call TFAR_fnc_ShowRadioVolume;
		// DD radio
		["", true] call TFAR_fnc_ShowRadioVolume;
	*/
	private ["_hintText", "_radio", "_isLrRadio", "_name", "_picture", "_volume", "_stereo", "_add_stereo", "_additional", "_imagesize"];
	_radio = _this select 0;
	_isDDRadio = [_this,1,false,[true]] call BIS_fnc_param;
	_isLrRadio = if (typename _radio == "STRING")then{false}else{true};

	if !(_isDDRadio) then {
		_name = if(_isLrRadio) then {getText (ConfigFile >> "CfgVehicles" >> typeof (_radio select 0) >> "displayName")} else {getText(configFile >> "CfgWeapons" >> _radio >> "displayName")};
		_picture = if(_isLrRadio) then {getText (ConfigFile >> "CfgVehicles" >> typeof (_radio select 0) >> "picture")} else {getText(configFile >> "CfgWeapons" >> _radio >> "picture")};
		_volume = formatText [localize "STR_radio_volume",if(_isLrRadio) then {((_radio call TFAR_fnc_getLrVolume) + 1) * 10} else {((_radio call TFAR_fnc_getSwVolume) + 1) * 10}];
		_stereo = localize format ["STR_stereo_settings_%1", if(_isLrRadio) then {_radio call TFAR_fnc_getLrStereo} else {_radio call TFAR_fnc_getSwStereo}];

		if (_isLrRadio) then {
			_additional = _radio call TFAR_fnc_getAdditionalLrChannel;
		} else {
			_additional = _radio call TFAR_fnc_getAdditionalSwChannel;
		};
		_add_stereo = "";
		if (_additional > -1) then {
			_add_stereo =  localize format ["STR_additional_stereo_settings_%1", if(_isLrRadio) then {_radio call TFAR_fnc_getAdditionalLrStereo} else {_radio call TFAR_fnc_getAdditionalSwStereo}];
		};
		_imagesize = "1.6";
		if ((_isLrRadio) and {!((_radio select 0) isKindOf "Bag_Base")}) then {
			_imagesize = "1.0";
		};
		_hintText = format [("<t size='1' align='center'>%1 <img size='" + _imagesize + "' image='%2'/></t><br /><t align='center'>%3</t><br /><t align='center'>%4</t><br /><t size='0.8' align='center'>%5</t>"), _name,_picture,_volume, _stereo, _add_stereo];
	}else{
		_hintText = format ["%1<br />%2", "DD Radio",formatText [localize "STR_radio_volume",((TF_dd_volume_level + 1) * 10)]];
	};

	[parseText (_hintText), 5] call TFAR_fnc_showHint;
};

TFAR_fnc_swRadioMenu = {
	/*
	 	Name: TFAR_fnc_swRadioMenu

	 	Author(s):
			NKey
			L-H

	 	Description:
			Returns a list of SW radios if more than one is on the player.

	 	Parameters:
			Nothing

	 	Returns:
			ARRAY:
				CBA UI menu.

	 	Example:
			Called internally by CBA UI
	*/
	private ["_menuDef","_positions","_active_radio","_submenu","_command","_menu","_position"];
	_menu = [];
	if ((count (TFAR_currentUnit call TFAR_fnc_radiosList) > 1) or {(count (TFAR_currentUnit call TFAR_fnc_radiosList) == 1) and !(call TFAR_fnc_haveSWRadio)}) then {
		_menuDef = ["main", localize "STR_select_radio", "buttonList", "", false];
		_positions = [];
		{
			_command = format["TF_sw_dialog_radio = '%1';call TFAR_fnc_onSwDialogOpen;", _x];
			_submenu = "";
			_active_radio = call TFAR_fnc_activeSwRadio;
			if ((isNil "_active_radio") or {_x != _active_radio}) then{
				_command = format["TF_sw_dialog_radio = '%1';", _x];
				_submenu = "_this call TFAR_fnc_swRadioSubMenu";
			};
			_position = [
				getText(configFile >> "CfgWeapons"  >> _x >> "displayName"),
				_command,
				getText(configFile >> "CfgWeapons"  >> _x >> "picture"),
				"",
				_submenu,
				-1,
				true,
				true
			];
			_positions pushBack _position;
		} forEach (TFAR_currentUnit call TFAR_fnc_radiosList);
		_menu =
		[
			_menuDef,
			_positions
		];
	} else {
		if (call TFAR_fnc_haveSWRadio) then {
			TF_sw_dialog_radio = call TFAR_fnc_activeSwRadio;
			call TFAR_fnc_onSwDialogOpen;
		};
	};
	_menu
};

TFAR_fnc_swRadioSubMenu = {
	/*
	 	Name: TFAR_fnc_swRadioSubMenu

	 	Author(s):
			NKey
			L-H

	 	Description:
			Returns a sub menu for a particular radio.

	 	Parameters:
			Nothing

	 	Returns:
			ARRAY: CBA UI menu.

	 	Example:
			Called internally by CBA UI
	*/
	private ["_submenu"];
	_submenu =
	[
		["secondary", localize "STR_select_action", "buttonList", "", false],
		[
			[localize "STR_select_action_setup", "call TFAR_fnc_onSwDialogOpen;", "", localize "STR_select_action_setup_tooltip", "", -1, true, true],
			[localize "STR_select_action_use", "TF_sw_dialog_radio call TFAR_fnc_setActiveSwRadio;[(call TFAR_fnc_activeSwRadio), false] call TFAR_fnc_ShowRadioInfo;", "", localize "STR_select_action_use_tooltip", "", -1, true, true],
			[localize "STR_select_action_copy_settings_from", "", "", localize "STR_select_action_settings_from_tooltip", "_this call TFAR_fnc_copyRadioSettingMenu", -1, true, true]
		]
	];
	_submenu
};

TFAR_fnc_TaskForceArrowheadRadioInit = {

	if (true) exitWith {};

	/*
	 	Name: TFAR_fnc_TaskForceArrowheadRadioInit

	 	Author(s):
			NKey
			L-H

	 	Description:
			Initialises TFAR, server and client.

	 	Parameters:
			Nothing

	 	Returns:
			Nothing

	 	Example:
			Called by ArmA via functions library.
	*/
	TF_ADDON_VERSION = "0.9.12";

	//#include "common.sqf"

	if (isServer or isDedicated) then {
		[] spawn TFAR_fnc_ServerInit;
	};
	if (hasInterface) then {
		[] spawn TFAR_fnc_ClientInit;
	};

};

TFAR_fnc_unableToUseHint = {
	[parseText (localize "STR_unable_to_use_hint"), 5] call TFAR_fnc_showHint;
};

TFAR_fnc_updateDDDialog = {
	/*
	 	Name: TFAR_fnc_updateDDDialog

	 	Author(s):
			NKey

	 	Description:
			Updates the DD dialog to the channel and depth if switched.

	 	Parameters:
			Nothing

	 	Returns:
			Nothing

	 	Example:
			call TFAR_fnc_updateDDDialog;
	*/

	#include "VoiceSystem_widgetEnums.h"
	private ["_depth", "_depthText"];
	ctrlSetText [IDC_DIVER_RADIO_EDIT_ID, TF_dd_frequency];
	_depth = round (((eyepos TFAR_currentUnit) select 2) * TF_FREQ_ROUND_POWER) / TF_FREQ_ROUND_POWER;
	_depthText =  format["%1m", _depth];
	ctrlSetText [IDC_DIVER_RADIO_DEPTH_ID, _depthText];
};

TFAR_fnc_updateLRDialogToChannel = {
	/*
	 	Name: TFAR_fnc_updateLRDialogToChannel

	 	Author(s):
			NKey
			L-H

	 	Description:
			Updates the LR dialog to the channel if switched.

	 	Parameters:
			0: STRING - Format to display channel with. Requires %1. (Optional)

	 	Returns:
			Nothing

	 	Example:
			// No custom format.
			call TFAR_fnc_updateLRDialogToChannel;
			// Custom format
			["CH: %1"] call TFAR_fnc_updateLRDialogToChannel;
	*/
	#include "VoiceSystem_widgetEnums.h"
	private ["_channelText", "_formatText"];
	_formatText = "CH:%1";

	if ((typename(_this) == typename ([])) and {count _this > 0} and  {typename (_this select 0) == (typename "")}) then {
		_formatText = _this select 0;
	};

	if ((TF_lr_dialog_radio call TFAR_fnc_getAdditionalLrChannel) == (TF_lr_dialog_radio call TFAR_fnc_getLrChannel)) then {
		_formatText = "CA:%1";
	};

	ctrlSetText [LR_EDIT, TF_lr_dialog_radio call TFAR_fnc_getLrFrequency];
	_channelText =  format[_formatText, (TF_lr_dialog_radio call TFAR_fnc_getLrChannel) + 1];
	ctrlSetText [LR_CHANNEL, _channelText];
};

TFAR_fnc_updateProgrammatorDialog = {
	if !(call TFAR_fnc_haveProgrammator) then {
		((_this select 0) displayCtrl TF_MICRODAGR_BACKGROUND_ID) ctrlShow false;
		((_this select 0) displayCtrl TF_MICRODAGR_CLEAR_ID) ctrlShow false;
		((_this select 0) displayCtrl TF_MICRODAGR_ENTER_ID) ctrlShow false;
		((_this select 0) displayCtrl TF_MICRODAGR_EDIT_ID) ctrlShow false;
		((_this select 0) displayCtrl TF_MICRODAGR_CHANNEL_EDIT_ID) ctrlShow false;
	};
};

TFAR_fnc_updateSWDialogToChannel = {
	/*
	 	Name: TFAR_fnc_updateSWDialogToChannel

	 	Author(s):
			NKey
			L-H

	 	Description:
			Updates the SW dialog to the channel if switched.

	 	Parameters:
			0: STRING - Format to display channel with. Requires %1. (Optional)

	 	Returns:
			Nothing

	 	Example:
			// No custom format.
			call TFAR_fnc_updateSWDialogToChannel;
			// Custom format
			["CH: %1"] call TFAR_fnc_updateSWDialogToChannel;
	*/
	#include "VoiceSystem_widgetEnums.h"
	private ["_channelText", "_formatText"];
	_formatText = "C%1";

	if ((typename(_this) == typename ([])) and {count _this > 0} and  {typename (_this select 0) == (typename "")}) then {
		_formatText = _this select 0;
	};

	if ((TF_sw_dialog_radio call TFAR_fnc_getAdditionalSwChannel) == (TF_sw_dialog_radio call TFAR_fnc_getSwChannel)) then {
		_formatText = "A%1";
	};

	ctrlSetText [SW_EDIT, TF_sw_dialog_radio call TFAR_fnc_getSwFrequency];
	_channelText =  format[_formatText, (TF_sw_dialog_radio call TFAR_fnc_getSwChannel) + 1];
	ctrlSetText [SW_CHANNEL, _channelText];
};

TFAR_fnc_vehicleId = {
	/*
	 	Name: TFAR_fnc_vehicleID

	 	Author(s):
			NKey

	 	Description:
			Returns a string with information about the player vehicle, used at the plugin side.

	 	Parameters:
			0: OBJECT - The unit to check.

	 	Returns:
			STRING - NetworkID, Turned out

	 	Example:
			_vehicleID = player call TFAR_fnc_vehicleID;
	*/
	private["_result"];
	_result = "no";
	if ((vehicle _this) != _this) then {
		_result = netid (vehicle _this);
		if (_result == "") then {
			_result = "singleplayer";
		};
		if ([_this] call TFAR_fnc_isTurnedOut) then {
			_result = _result + "_turnout";
		} else {
			_result = _result + "_" + str ([(typeof (vehicle _this)), "tf_isolatedAmount", 0.0] call TFAR_fnc_getConfigProperty);
		};
	};
	_result
};

TFAR_fnc_vehicleLr = {
	/*
	 	Name: TFAR_fnc_VehicleLR

	 	Author(s):
			NKey

	 	Description:
			Gets the LR radio of the vehicle and the settings for it depending on the player's
			position within the vehicle

	 	Parameters:
			0: Object - unit

	 	Returns:
			ARRAY: 0 - Object - Vehicle, 1 - String - Radio Settings ID

	 	Example:
			_radio = player call TFAR_fnc_VehicleLR;
	 */
	private ["_result"];
	_result = [];
	if (((vehicle _this) != _this) and {(vehicle _this) call TFAR_fnc_hasVehicleRadio}) then {
		switch (_this) do {
			case (gunner (vehicle _this)): {
				_result = [vehicle _this, "gunner_radio_settings"];
			};
			case (driver (vehicle _this)): {
				_result = [vehicle _this, "driver_radio_settings"];
			};
			case (commander (vehicle _this)): {
				_result = [vehicle _this, "commander_radio_settings"];
			};
			case ((vehicle _this) turretUnit [0]): {
				_result = [vehicle _this, "turretUnit_0_radio_setting"];
			};
		};
	};
	_result
};
#endif
//VOICE_DISABLE_LEGACYCODE

TFAR_fnc_vehicleIsIsolatedAndInside = {
	/*
	 	Name: TFAR_fnc_vehicleIsIsolatedAndInside

	 	Author(s):
			NKey

	 	Description:
			Checks whether a unit is in an isolated vehicle and not turned out.

	 	Parameters:
			0: OBJECT - The unit to check.

	 	Returns:
			BOOLEAN - True if isolated and not turned out, false if turned out or vehicle is not isolated.

	 	Example:
			_isolated = player call TFAR_fnc_vehicleIsIsolatedAndInside;
	*/
	private ["_result"];
	_result = false;
	if (vehicle _this != _this) then {
		if ((vehicle _this) call TFAR_fnc_isVehicleIsolated) then {
			if !([_this] call TFAR_fnc_isTurnedOut) then {
				_result = true;
			};
		};
	};
	_result
};


