// ======================================================
// Copyright (c) 2017-2025 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\host\engine.hpp>
#include <..\ClientRpc\clientRpc.hpp>
#include <..\..\host\NOEngine\NOEngine.hpp>


//использует клиентский ник как имя для тимспика
//#define VOICE_IS_USE_NICKNAME_AS_TS

// при включенном режиме не будет запускать войс в СП-моде
#define VOICE_DISABLE_IN_SINGLEPLAYERMODE

// режим отладки войс системы (для возможности изменения переменных кода)
#define VOICE_DEBUG

//таймаут до кика
#define VS_ERROR_CONNECTION_TIMEOUT 30
#define VS_ERROR_NOTINGAMECHANNEL_TIMEOUT 15

#define VS_INTERCOM_MAXDISTANCE_TRANSMITH 1.25

vs_canProcess = true; //при выключенном режиме процессинг радио не будет происходить

vs_intercom_maxdist = VS_INTERCOM_MAXDISTANCE_TRANSMITH;

vs_init = {
	#ifdef VOICE_DISABLE_IN_SINGLEPLAYERMODE
	if (!isMultiplayer) exitWith {};
	#endif

	if (!isMultiplayer) then {
		if !isNull(vs_processPlayerPosHandler) then {
			//clear handler
			call vs_stopHandleProcessPlayerPos;
		};
	};

	registerEventHandler(OnSpeak); //params: mob,mode
		if !isNull(relicta_global_textChatEnabled) then {
			addEventHandler(OnSpeak,chatos_event_onSpeak);
		};

	vs_nickName = "No_player";

	//serverside
	if isNull(tf_radio_channel_name)  then {
		tf_radio_channel_name = "Channel";
		tf_radio_channel_password = "Password";
	};


	TFAR_currentUnit = call TFAR_fnc_currentUnit;

	vs_isEnabledText = !isNull(relicta_global_textChatEnabled);

	//группа непонятных переменных
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
		TF_horizontal_tab = toString [9]; //для запросов

		TF_dd_volume_level = 7;

		TF_last_lr_tangent_press = 0.0;
		TF_last_dd_tangent_press = 0.0;

		TF_HintFnc = nil;

	//и ещё переменные после инициализации клиента
	TF_tangent_sw_pressed = false; //флаги нажаты ли радейки
		TF_tangent_lr_pressed = false;
		TF_tangent_dd_pressed = false;

		TF_dd_frequency = nil;

		TF_speakerDistance = 20;
			TF_speakerDistance = chunkSize_structure ; //struct distance
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
		vs_lastErrorText = "";
		vs_lastErrorTimeout = 0;

		tf_msSpectatorPerStepMax = 0.035;


	//ненужный спам
	TF_first_radio_request = true;
	TF_last_request_time = 0;


	//а вот здесь вижу хуйню
	TF_respawnedAt = time;
	TFAR_previouscurrentUnit = nil;
	TFAR_currentUnit = player; //конкретно тут, так как раньше вызвано было

	//вот тут самое вкусное

	logformat("vs::init() - Plugin version %1",TF_ADDON_VERSION);
	call vs_sendVersionInfo;

	vs_processPlayerPosHandler = "";
	//call vs_startHandleProcessPlayerPos; //no handle after init
	call vs_startHandleProcessPlayerPos;

	//call TFAR_fnc_processRespawn;
};

//Sends information about the current TFAR version.
vs_sendVersionInfo = {
	private ["_request","_result"];
	_request = format["VERSION	%1	%2	%3", TF_ADDON_VERSION, tf_radio_channel_name, tf_radio_channel_password];
	_result = "task_force_radio_pipe" callExtension _request;
};

vs_isPluginEnabled = {
	("task_force_radio_pipe" callExtension "TS_INFO	PING") == "PONG"
};

//Получает строковое название канала
vs_getCurrentTSChannel = {
	"task_force_radio_pipe" callExtension "TS_INFO	CHANNEL"
};

vs_isIngameTSChannel = {
	(call vs_getCurrentTSChannel)=="InGame"
};

//получает строковое название сервера
vs_getCurrentTSServer = {
	"task_force_radio_pipe" callExtension "TS_INFO	SERVER"
};

//Говорит ли юнит в данный момент
vs_isSpeaking = {
	(("task_force_radio_pipe" callExtension format ["IS_SPEAKING	%1", _this getVariable ["voiceptr","<_nonsppl_>"]]) == "SPEAKING")
};	

// Process some player positions on each call and sends it to the plugin.
vs_onProcessPlayerPosition = {
	private ["_elemsNearToProcess","_elemsFarToProcess","_other_units", "_unit", "_controlled", "_speakers"];

	if (!vs_canProcess) exitWith {}; //отключает процессирование войса

	// TEMPORARY FIX
	if (TFAR_currentUnit != player) then {
		TFAR_currentUnit = player;
	};

	call vs_handleProcessedTransmith;

	//if !(isNull (findDisplay 46)) then {
		//if !(isNull TFAR_currentUnit) then {
			if ((tf_farPlayersProcessed) and {tf_nearPlayersProcessed}) then {
				tf_nearPlayersIndex = 0;
				tf_farPlayersIndex = 0;

				if (count tf_nearPlayers == 0) then {
					tf_nearPlayers = call vs_getNearInGameMobs; //replace to vs_getNearInGameMobs
				};

				// Другие юниты как дальняковые подлежат вырезке нахуй
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
				call vs_sendVersionInfo;
			} else {
				_elemsNearToProcess = (diag_tickTime - tf_lastNearFrameTick) / tf_msNearPerStep;
				if (_elemsNearToProcess >= 1) then {
					for "_y" from 0 to _elemsNearToProcess step 1 do {
						if (tf_nearPlayersIndex < count tf_nearPlayers) then {
							_unit = (tf_nearPlayers select tf_nearPlayersIndex);
							_controlled = _unit getVariable "tf_controlled_unit";
							if !(isNil "_controlled") then {
								[_controlled, true, _unit getvariable "voiceptr"] call vs_sendPlayerInfo;
							} else {
								[_unit, true, _unit getvariable "voiceptr"] call vs_sendPlayerInfo;
							};
							tf_nearPlayersIndex = tf_nearPlayersIndex + 1;
						} else {
							tf_nearPlayersIndex = 0;
							tf_nearPlayersProcessed = true;

							if (diag_tickTime - tf_lastNearPlayersUpdate > 0.5) then {
								tf_nearPlayers = call TFAR_fnc_getNearPlayers;
								tf_lastNearPlayersUpdate = diag_tickTime;
							};

							//call TFAR_fnc_processSpeakerRadios; //а тут как раз радейки обрабатываются
							call vs_processSpeakerRadios;

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
							[_unit, false, _unit getvariable "voiceptr"] call vs_sendPlayerInfo;
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
				call vs_sendFrequencyInfo;
				tf_lastFrequencyInfoTick = diag_tickTime;
			};
		//};
	//};
};

vs_startHandleProcessPlayerPos = {
	//DISABLETEAMSPEAK
	if !isNull(vs_serverdisabled) exitWith {};
	if not_equals(vs_processPlayerPosHandler,"") then {
		call vs_stopHandleProcessPlayerPos;
	};
	vs_processPlayerPosHandler = ["processPlayerPositionsHandler", "onEachFrame", "vs_onProcessPlayerPosition"] call BIS_fnc_addStackedEventHandler;
};

//останавливает процессинг
vs_stopHandleProcessPlayerPos = {
	if equals(vs_processPlayerPosHandler,"") exitWith {};
	[vs_processPlayerPosHandler, "onEachFrame"] call BIS_fnc_removeStackedEventHandler;
	vs_processPlayerPosHandler = "";
};


// отсылает частоты раций у игрока в плагин
vs_sendFrequencyInfo = {
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
		//TFAR_player_name = name player;
		#ifdef VOICE_IS_USE_NICKNAME_AS_TS
			vs_nickName = cd_clientName;
		#else
			vs_nickName = player getVariable ["voiceptr",cd_clientName];
		#endif
	};

	_nickname = vs_nickName;
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

	// getting local player all radios
	_freq = call vs_onProcessingRadios;
	
	_volLocPlay = TF_speak_volume_meters;
	//если в бессознанке или в лобби то собсна нихуя
	if (!([] call interact_isActive) || isLobbyOpen) then {
		_volLocPlay = 0;
		_voiceVolume = 0;
	};
	
	_request = format["FREQ	%1	%2	%3	%4	%5	%6	%7	%8	%9	%10	%11	%12	%13", str(_freq), str(_freq_lr), _freq_dd, _alive, _volLocPlay min TF_max_voice_volume, TF_dd_volume_level, _nickname, waves, TF_terrain_interception_coefficient, _globalVolume, _voiceVolume, _receivingDistanceMultiplicator, TF_speakerDistance];
	_result = "task_force_radio_pipe" callExtension _request;
};

vs_calculateInteraction = {
	params ["_curVoice","_unit"];
};

//Обрабатывает все радио спикерные
vs_processSpeakerRadios = {

	private ["_item", "_freq", "_pos", "_unit_pos", "_p", "_manpack", "_lrs", "_isolation"];
	_unit_pos = eyepos TFAR_currentUnit;
	{
		_pos = getPosASL _x;
		if ((_pos select 2) > 0) then {//радио не может быть под землёй а потому проверка неактуальна
			//todo vectoradd biasPos
			_p = [(_pos select 0) - (_unit_pos select 0), (_pos select 1) - (_unit_pos select 1), (_pos select 2) - (_unit_pos select 2)];
			{
				if ((_x call TFAR_fnc_isRadio) and {_x call TFAR_fnc_getSwSpeakers}) then {
					_freq = format ["%1%2", _x call TFAR_fnc_getSwFrequency, _x call TFAR_fnc_getSwRadioCode];
					if ((_x call TFAR_fnc_getAdditionalSwChannel) > -1) then {
						_freq = _freq + format ["|%1%2", [_x, (_x call TFAR_fnc_getAdditionalSwChannel) + 1] call TFAR_fnc_GetChannelFrequency, _x call TFAR_fnc_getSwRadioCode];
					};
					tf_speakerRadios pushBack (format ["%1%2%3%4%5%6%7%8%9%10%11%12%13", _x, TF_new_line, _freq, TF_new_line,  "", TF_new_line, _p, TF_new_line, _x call TFAR_fnc_getSwVolume, TF_new_line, "no", TF_new_line, _pos select 2]);
				};
			} forEach ((getItemCargo _x) select 0); //рефракторинг

			//lr не юзаемс)))
			/*{
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

			} forEach (everyBackpack _x);*/
		};

	// вместо прохода по массиву берём call vs_collectSpeakersInWorld
	} forEach (nearestObjects [getPos TFAR_currentUnit, ["WeaponHolder", "GroundWeaponHolder", "WeaponHolderSimulated"], TF_speakerDistance]);

	call vs_processWorldRadios;

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


// Notifies the plugin about a player
vs_sendPlayerInfo = {
	private ["_request","_result", "_player", "_isNearPlayer", "_killSet"];
	_player = _this select 0;

	_request = _this call vs_preparePositionCoordinates;//TFAR_fnc_preparePositionCoordinates;
	_result = "task_force_radio_pipe" callExtension _request;

	if ((_result != "OK") and {_result != "SPEAKING"} and {_result != "NOT_SPEAKING"} || {!call vs_isIngameTSChannel}) then {
		if (vs_lastErrorText != _result) then {
			errorformat("vs::sendPlayerInfo() - Internal exception: %1",_result);
			vs_lastErrorText = _result;
			vs_lastErrorTimeout = tickTime + ifcheck(!call vs_isIngameTSChannel,VS_ERROR_NOTINGAMECHANNEL_TIMEOUT,VS_ERROR_CONNECTION_TIMEOUT);
		};
		//[parseText (_result), 10] call TFAR_fnc_showHint;
		// todo handle pipe closing error
		tf_lastError = true;

		if (tickTime > vs_lastErrorTimeout) then {
			warningformat("vs::sendPlayerInfo() - Plugin connection timeout. The connection was not restored for %1 sec. Client is being disconnected.",ifcheck(!call vs_isIngameTSChannel,VS_ERROR_NOTINGAMECHANNEL_TIMEOUT,VS_ERROR_CONNECTION_TIMEOUT));
			vs_stopHandleProcessPlayerPos;
			
			rpcCall("clientDisconnect",vec2("Ошибка подключения плагина","Истекло время ожидания подключения плагина. Пожалуйста зайдите в тимспик srv.relicta.ru во время игры и включите плагин TaskForceRadio в настройках вашего тимспика."));
		};
	} else {
		if (tf_lastError) then {
			//call TFAR_fnc_hideHint;
			log("vs::sendPlayerInfo() - Restored plugin pipe connection!");
			tf_lastError = false;
			vs_lastErrorText = "";
			vs_lastErrorTimeout = 0;
		};
	};
	if (_result == "SPEAKING") then {
		if (!vs_isEnabledText) then {
			_player setRandomLip true;
		};
		if (!(_player getVariable ["tf_isSpeaking", false])) then {
			_player setVariable ["tf_isSpeaking", true];
			//["OnSpeak", _player, [_player, true]] call TFAR_fnc_fireEventHandlers;
			callEventHandler(OnSpeak,vec2(_player,true));
		};
		_player setVariable ["tf_start_speaking", diag_tickTime];
	} else {
		if (!vs_isEnabledText) then {
			_player setRandomLip false;
		};
		if ((_player getVariable ["tf_isSpeaking", false])) then {
			_player setVariable ["tf_isSpeaking", false];
			//["OnSpeak", _player, [_player, false]] call TFAR_fnc_fireEventHandlers;
			callEventHandler(OnSpeak,vec2(_player,false));
		};
	};
	/*
	_killSet = _player getVariable "tf_killSet";
	if (isNil "_killSet") then {
		_player objectAddEventHandler ["Killed", {(_this select 0) call TFAR_fnc_sendPlayerKilled}];
		_player setVariable ["tf_killSet", true];
	};
	*/

};

// Prepares the position coordinates of the passed unit.
vs_preparePositionCoordinates = {
	/*
		0: OBJECT - unit
		1: BOOLEAN - Is near player
		2: STRING - Unit name
	*/
	private ["_x_player","_isolated_and_inside","_can_speak", "_pos", "_depth", "_useSw", "_useLr", "_useDd", "_freq", "_vehicle", "_radio_id"];
	_unit = _this select 0;
	_nearPlayer = _this select 1;

	// + оптимизация
	_pos = [_unit, _nearPlayer] call TFAR_fnc_defaultPositionCoordinates;//(_unit getVariable ["TF_fnc_position", TFAR_fnc_defaultPositionCoordinates]);
	_isolated_and_inside = _unit call TFAR_fnc_vehicleIsIsolatedAndInside;
	_depth = _unit call TFAR_fnc_eyeDepth;
	_can_speak = [_isolated_and_inside, _depth] call TFAR_fnc_canSpeak; //заменить на vs_canSpeakUnit (означает может ли слышать кто-то этого юнита)
	_useSw = true;
	_useLr = true;
	_useDd = false;
	// никогда у нас глубина не опустится под ноль
	/*if (_depth < 0) then {
		_useSw = [_unit, _isolated_and_inside, _can_speak, _depth] call TFAR_fnc_canUseSWRadio;
		_useLr = [_unit, _isolated_and_inside, _depth] call TFAR_fnc_canUseLRRadio;
		_useDd = [_depth, _isolated_and_inside] call TFAR_fnc_canUseDDRadio;
	};*/
	if (count _pos != 4) then {
		_pos pushBack 0;
	};

	//вообще по-хорошему должен вернуть "no" (техники у нас нет).
	//однако можно юзать для затухания громкости юнита
	_vehicle = _unit call TFAR_fnc_vehicleId;

	//подключаем все динамики на юнитах
	if ((_nearPlayer) and {TFAR_currentUnit distance _unit <= TF_speakerDistance}) then {
		// LR нет
		/*if (_unit getVariable ["tf_lr_speakers", false] && _useLr) then {
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
		};*/

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
			} count (_unit call TFAR_fnc_radiosList); //заменить на vs_getUnitRadios
		};
	};

	_can_speak = true; //хардкод. при выключенном режиме будет применён фильтр нижних частот

	_newVoiceVolume = [_unit,_unit getVariable ["tf_voiceVolume", 1.0]] call vs_calcVoiceIntersection;
	
	_newVoiceVolume = [_unit,_newVoiceVolume] call vs_processSpeakingLangs;
	
	#ifdef VOICE_DEBUG
	__tb = TF_horizontal_tab;
	format["POS"+__tb+"%1"+__tb+"%2"+__tb+"%3"+__tb+"%4"+__tb+"%5"+__tb+"%6"+__tb+"%7"+__tb+"%8"+__tb+"%9"+__tb+"%10"+__tb+"%11"+__tb+"%12"+__tb+"%13",
	#else
	format["POS	%1	%2	%3	%4	%5	%6	%7	%8	%9	%10	%11	%12	%13",
	#endif
	_this select 2, _pos select 0, _pos select 1, _pos select 2, _pos select 3, _can_speak, _useSw, _useLr, _useDd, _vehicle, _unit call TFAR_fnc_calcTerrainInterception, _newVoiceVolume, call TFAR_fnc_currentDirection]
};

//Калькулирует понимание речи персонажа
vs_processSpeakingLangs = {
	params ["_unit","_curVol"];
	/*
		vs_vt - переменная на персонаже
		
		vs_list_langs = [
			"human","eater"
		];
		//список кого слышат эти персонажи
		vs_map_whohear = createHashMapFromArray [
			["human",["human"]],
			["eater",["eater","human"]]
		];
		
	*/
	
	if equals(_unit,player) exitWith {_curVol}; //локальный игрок без изменений
	_lang_ = _unit getVariable ["vs_vt","human"];
	_playerlang_ = player getVariable ["vs_vt","human"];
	_curlang = vs_map_whohear getOrDefault [_playerlang_,"human"];
	if !array_exists(_curlang,_lang_) then {
		_curVol = 0;
	};
	
	_curVol
};

//Просчитывает гашение звука от препятствий
vs_calcVoiceIntersection = {
	params ["_unit","_curVol"];

	if equals(_unit,player) exitWith {
		_curVol
	};
	
	#define itermes(me,data) if !isNullVar(__excheck__) then {traceformat(me,data)};
	#define itermes(me,data)
	/*
		Алгоритм:
		
		1. Собираем объекты от игрока до цели
		2. получаем дистацию от игрока до цели - __distAll и создаем __distCur = 0
		3. Объекты выше 1 метра процессим следующим образом
			3.1 Плюсуем отрезок от глаз до точки пересечения
		4. Вычитаем из дистанции общее расстояние
	*/
	#ifdef VOICE_USE_NEW_ALGORITM_VOICE_INTERSECTION
		
		_plaEyePos = eyepos player;
		
		//(0 boundingBoxReal call interact_cursorobject)
		__vs_cvi_ = lineIntersectsSurfaces [
		    _plaEyePos,
		    eyepos _unit,
		    player,
		    _unit,
		    false,
		    20,
		    "VIEW",
		    "NONE"
		];
		
		__distAll = _plaEyePos distance(eyePos _unit);
		//__distCur = __distAll;
		__itscDists = 0;
		_curPoint = (eyePos _unit);
		_curItscObj = objnull;
		itermes("ITERATION NEW (dist: %1)",__distAll)
		{
			_curItscObj = _x select 2;
			if !(_curItscObj call noe_client_isNGO) then {
				itermes("CHECK OBJ %1",_x select 2)
				
				([_curItscObj] call vs_internal_getObjBBXData) params ["_h","_plosh"];
				_srcDist = _curPoint distance (_x select 0);
				_curPoint = _x select 0;

				if (_curItscObj call pencfg_isExistsModel) then {
					_srcDist = [_curItscObj,_srcDist] call pencfg_handleVoice;
				};

				if (_h >= 1) then {
					modvar(__itscDists) + _srcDist;
					itermes("	DIST TO OBJ %1",_srcDist)
				}
				
				//modvar(_curVol) - (_plosh*0.9/100);
			};
			
			true;
		} count __vs_cvi_;

		itermes("	FULL DIST %1",__itscDists)
		
		if (__itscDists == 0) exitWith {_curVol max 0};

		(_curVol - (linearConversion [__distAll,0,__itscDists,_curVol,0,true]))max 0;
		
		/*itermes("ITERATION NEW (dist: %1)",__distAll)
		{
			itermes("CHECK OBJ %1",_x select 2)
			
			([(_x select 2)] call vs_internal_getObjBBXData) params ["_h","_plosh"];
			
			_convres = linearConversion[_h,0,(_x select 0) distance _plaEyePos,100,1,true];
			itermes("	DIST EYE-ITPS %1",(_x select 0) distance _plaEyePos)
			itermes("	CONVERSION %1",_convres)
			itermes("	H-SIZE %1",_h)
			itermes("	PLOSH %1",_plosh)
			
			if (_h >= 1) then {
				modvar(__distCur) - _plosh/_convres;
			};
			true
		} count __vs_cvi_;
		
		itermes("ITERATION END. New distance %1 (count %2)",__distCur arg count __vs_cvi_)
		
		//_curVol
		linearConversion [__distAll,0,__distCur,_curVol,0,true];*/
	
	#else
	__vs_cvi_ = lineIntersectsSurfaces [
	    eyepos player,
	    eyepos _unit,
	    player,
	    _unit,
	    true,
	    10,
	    "GEOM",
	    "NONE"
	];
	
	//[_unit,__vs_cvi_] call vs_debug_voiceIntersection;
	
	//TODO checking bounding box of objects
	/*{
		__sphSize = (boundingBoxReal (_x select 2))select 2;
		
		true;
	} count __vs_cvi_;*/

	_curVol / ((count __vs_cvi_) max 1);
	#endif
};

//возвращает высоту объекта и площадь
vs_internal_getObjBBXData = {
	params ["_obj"];
	_bbr = 0 boundingBoxReal _obj;
	_p1 = _bbr select 0;
	_p2 = _bbr select 1;
	_maxWidth = abs ((_p2 select 0) - (_p1 select 0));
	_maxLength = abs ((_p2 select 1) - (_p1 select 1));
	_maxHeight = abs ((_p2 select 2) - (_p1 select 2));
	//_dia = sqrt(_maxWidth^2+_maxLength^2); _maxLength * (sqrt(_dia^2-_maxLength^2))
	[_maxHeight,
	_maxWidth * _maxLength]
};

#ifdef DEBUG
vs_debug_voiceIntersection = {
	params ["_unit","_posesASL"];
	{
		deleteVehicle _x;
		true;
	} count (_unit getVariable ["__objs_dvi",[]]);
	__list = [];
	{
		_a__ = "Sign_Arrow_F" createVehicle [0,0,0];
		__list pushBack _a__;
		_a__ setPosAtl ASLToATL(_x select 0);
		_a__ setVectorUp (_x select 1);
		true;
	} count _posesASL;
	_unit setVariable ["__objs_dvi",__list];
};
#endif



//Получает ближайших мобов
vs_getNearInGameMobs = {

	//private _players_in_group = count (units (group TFAR_currentUnit)); // - 0.0012 ms
	private _result = [];
	//Вот эта замечательная проверка могла бы замениться на проверку призраков
	if (alive TFAR_currentUnit || true) then {

		//	TF_max_voice_volume - Данная константа по моему хотению будет меняться. А значит нужен копир
		private _allUnits = TFAR_currentUnit nearEntities ["Man", TF_max_voice_volume];

		//У нас все юниты по своим группам. Не думаю что тут нужен ктонить
		// - 0.003ms
		/*if (_players_in_group < 10) then {
			{
				if (_x != TFAR_currentUnit) then {
					_allUnits pushBack _x;
				};
				true;
			} count (units (group TFAR_currentUnit));
		};*/

		// спас 0.0023 мс на самой лучшей машине
		/*
		private _v = nil;
		{
			_v = _x;
			{
				_allUnits pushBack _x;
			} forEach (crew _v);
		} forEach  (TFAR_currentUnit nearEntities [["LandVehicle", "Air", "Ship"], TF_max_voice_volume]);*/


		//В теории тут тоже можно спасти фпса
		{
			if ((isPlayer _x) and {alive _x}) then {
				private _spectator = _x getVariable "tf_forceSpectator";
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

//вырубает локальному плееру все рации
vs_releaseAllTangents = {
	if (isMultiplayer) then {
		"task_force_radio_pipe" callExtension (format ["RELEASE_ALL_TANGENTS	%1", player getVariable 'voiceptr']);
	};
};

#define getRadioVar(obj,var) (obj getvariable '__radio_##var')

#include "VoiceSystem_WorldRadioComponent.sqf"
#include "VoiceSystem_Transmith.sqf"
#include "VoiceSystem_HandleTangent.sqf"
#include "VoiceSystem_Control.sqf"



call vs_init;
