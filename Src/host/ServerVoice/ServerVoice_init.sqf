// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\engine.hpp>
#include <..\ServerRpc\serverRpc.hpp>
#include <..\Networking\Network.hpp>

#include "revoice_server.sqf"

vsm_map_freqAndCode = createHashMap; //карта ассоциаций кода и частоты
vsm_map_inverted = createHashMap; //инвертированная карта
vsm_counter = 1; //для ассоциаций. является value в FCData и key в inverted. Не должно быть меньше нуля

//регистрирует ид и возвращает его
vsm_registerFCData = {
	params ["_key"];
	
	private _ctr = vsm_counter;
	INC(_ctr);
	
	vsm_map_freqAndCode set [_key,_ctr];
	vsm_map_inverted set [_ctr,_key];
	
	vsm_counter = _ctr;
	_ctr
};

//Пакует значения частоты и кода
vsm_packFreqData = {
	params ["_freq","_code"];
	private _val = str _freq + "@" + _code;
	
	if (_val in vsm_map_freqAndCode) then {
		vsm_map_freqAndCode get _val
	} else {
		[_val] call vsm_registerFCData
	};
};

//распаковывает значения частоты и кода по энумератору
//возвращает массив частоты и кода
vsm_unpackFreqData = {
	params ["_intval"];
	
	if (!(_intval in vsm_map_inverted)) exitWith {
		errorformat("vsm::unpackFreqData() - cant find value <%1> in vsm::map::freqAndCode",_intval);
		"nonfreq@noncode"
	};	
	
	private _dat = (vsm_map_inverted get _intval) splitString "@";
	if (count _dat != 2) exitWith {
		errorformat("vsm::unpackFreqData() - Error unpack value <%1>",_intval);
		"nonfreq@noncode"
	};
	
	[parseNumber (_dat select 0),_dat select 1]
};

//Генерирует частоту
vsm_generateFrequencies = {
	params ["_min","_max",["_rounder",0]];
	
	parseNumber (randInt(_min,_max) toFixed _rounder)
};



//initialize voice manager
vsm_Init = {
	//!this function not called
	if (!canSuspend) exitWith {
		error("vm::Init() - only in thread expected");
	};
	/*
	 	Name: TFAR_fnc_serverInit

	 	Author(s):
			NKey
			L-H

	 	Description:
			Initialises the server and the server loop.

		Parameters:
			Nothing

	 	Returns:
			Nothing

	 	Example:
			call TFAR_fnc_serverInit;
	*/
	#define MAX_RADIO_COUNT 1000
	private ["_variableName", "_radio_request", "_responseVariableName", "_response", "_task_force_radio_used", "_last_check", "_allUnits"];

	// cba settings
	//#include "cba_settings.sqf"

	TF_server_addon_version = TF_ADDON_VERSION;
	publicVariable "TF_server_addon_version";

	waitUntil {sleep 0.1;time > 0};

	TF_Radio_Count = [];

	/*
	while {true} do {
		call TFAR_fnc_processGroupFrequencySettings;
		_allUnits = allUnits;
		{
			_allUnits pushBack _x;
			true;
		} count (call BIS_fnc_listCuratorPlayers);

		{
			if (isPlayer _x) then {
				_variableName = "radio_request_" + (getPlayerUID _x) + str (_x call BIS_fnc_objectSide);
				_radio_request = missionNamespace getVariable (_variableName);
				if !(isNil "_radio_request") then {
					missionNamespace setVariable [_variableName, nil];
					(owner (_x)) publicVariableClient (_variableName);
					_responseVariableName = "radio_response_" + (getPlayerUID _x) + str (_x call BIS_fnc_objectSide);
					_response = [];
					if (typename _radio_request == "ARRAY") then {
						{
							private ["_radio", "_count"];
							_radio = _x;
							if !(_radio call TFAR_fnc_isPrototypeRadio) then {
								_radio = configname inheritsFrom (configFile >> "CfgWeapons" >> _radio);
							};
							_count = -1;
							{
								if ((_x select 0) == _radio) exitWith {
									_x set [1, (_x select 1) + 1];
									if ((_x select 1) > MAX_RADIO_COUNT) then {
										_x set [1, 1];
									};
									_count = (_x select 1);
								};
							} count TF_Radio_Count;
							if (_count == -1) then {
								TF_Radio_Count pushBack [_x,1];
								_count = 1;
							};
							_response pushBack format["%1_%2", _radio, _count];
							true;
						} count _radio_request;
					} else {
						_response = "ERROR:47";
						diag_log format ["TFAR - ERROR:47 - Request Content: %1; Requested By: %2", _radio_request, _x]; //first own fix
					};
					missionNamespace setVariable [_responseVariableName, _response];
					(owner (_x)) publicVariableClient (_responseVariableName);
				};
				_task_force_radio_used = _x getVariable "tf_force_radio_active";
				_variableName = "no_radio_" + (getPlayerUID _x) + str (_x call BIS_fnc_objectSide);
				if (isNil "_task_force_radio_used") then {
					_last_check = missionNamespace getVariable _variableName;

					if (isNil "_last_check") then {
						missionNamespace setVariable [_variableName, time];
					} else {
						if (time - _last_check > 30) then {
							[["LOOKS LIKE TASK FORCE RADIO ADDON NOT ENABLED OR VERSION LESS THAN 0.8.1"],"BIS_fnc_guiMessage",(owner _x), false] spawn BIS_fnc_MP;
							_x setVariable ["tf_force_radio_active", "error_shown", true];
						};
					};
				} else {
					missionNamespace setVariable [_variableName, nil];
				};
			};
		} count _allUnits;
		sleep 1;
	};
	*/
};


TFAR_fnc_processGroupFrequencySettings = {
	/*
	 	Name: TFAR_fnc_processGroupFrequencySettings

	 	Author(s):
			NKey

	 	Description:
			Sets frequency settings for groups.

		Parameters:
			Nothing

	 	Returns:
			Nothing

	 	Example:
			call TFAR_fnc_processGroupFrequencySettings;
	*/
	private ["_group_freq"];
	if (isNil "tf_same_sw_frequencies_for_side") then {
		if (!isNil "tf_same_sw_frequencies_for_side_server") then {
			tf_same_sw_frequencies_for_side = tf_same_sw_frequencies_for_side_server;
		}else{
			tf_same_sw_frequencies_for_side = false;
		};
	};
	if (isNil "tf_same_lr_frequencies_for_side") then {
		if (!isNil "tf_same_lr_frequencies_for_side_server") then {
			tf_same_lr_frequencies_for_side = tf_same_lr_frequencies_for_side_server;
		}else{
			tf_same_lr_frequencies_for_side = true;
		};
	};
	if (isNil "tf_same_dd_frequencies_for_side") then {
		if (!isNil "tf_same_dd_frequencies_for_side_server") then {
			tf_same_dd_frequencies_for_side = tf_same_dd_frequencies_for_side_server;
		}else{
			tf_same_dd_frequencies_for_side = true;
		};
	};
	if (isNil "tf_freq_west") then {
		tf_freq_west = call TFAR_fnc_generateSwSettings;
	};
	if (isNil "tf_freq_east") then {
		TF_freq_east = call TFAR_fnc_generateSwSettings;
	};
	if (isNil "tf_freq_guer") then {
		tf_freq_guer = call TFAR_fnc_generateSwSettings;
	};

	if (isNil "tf_freq_west_lr") then {
		tf_freq_west_lr = call TFAR_fnc_generateLrSettings;
	};
	if (isNil "tf_freq_east_lr") then {
		TF_freq_east_lr = call TFAR_fnc_generateLrSettings;
	};
	if (isNil "tf_freq_guer_lr") then {
		tf_freq_guer_lr = call TFAR_fnc_generateLrSettings;
	};
	if (isNil "tf_freq_west_dd") then {
		tf_freq_west_dd = call TFAR_fnc_generateDDFreq;
	};
	if (isNil "tf_freq_east_dd") then {
		TF_freq_east_dd = call TFAR_fnc_generateDDFreq;
	};
	if (isNil "tf_freq_guer_dd") then {
		tf_freq_guer_dd = call TFAR_fnc_generateDDFreq;
	};

	{
		_group_freq = _x getVariable "tf_sw_frequency";
		if (isNil "_group_freq") then {
			if !(tf_same_sw_frequencies_for_side) then {
				_x setVariable ["tf_sw_frequency", call TFAR_fnc_generateSwSettings, true];
			} else {
				switch (side _x) do {
					case west: {
						_x setVariable ["tf_sw_frequency", tf_freq_west, true];
					};
					case east: {
						_x setVariable ["tf_sw_frequency", tf_freq_east, true];
					};
					default {
						_x setVariable ["tf_sw_frequency", tf_freq_guer, true];
					};
				};
			};
		};
		_group_freq = _x getVariable "tf_dd_frequency";
		if (isNil "_group_freq") then {
			if !(tf_same_dd_frequencies_for_side) then {
				_x setVariable ["tf_dd_frequency", call TFAR_fnc_generateDDFreq, true];
			} else {
				switch (side _x) do {
					case west: {
						_x setVariable ["tf_dd_frequency", tf_freq_west_dd, true];
					};
					case east: {
						_x setVariable ["tf_dd_frequency", tf_freq_east_dd, true];
					};
					default {
						_x setVariable ["tf_dd_frequency", tf_freq_guer_dd, true];
					};
				};
			};
		};
		_group_freq = _x getVariable "tf_lr_frequency";
		if (isNil "_group_freq") then {
			if !(tf_same_lr_frequencies_for_side) then {
				_x setVariable ["tf_lr_frequency", call TFAR_fnc_generateLrSettings, true];
			} else {
				switch (side _x) do {
					case west: {
						_x setVariable ["tf_lr_frequency", tf_freq_west_lr, true];
					};
					case east: {
						_x setVariable ["tf_lr_frequency", tf_freq_east_lr, true];
					};
					default {
						_x setVariable ["tf_lr_frequency", tf_freq_guer_lr, true];
					};
				};
			};
		};
		true;
	} count allGroups;

};
