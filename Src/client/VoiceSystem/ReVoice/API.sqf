// ======================================================
// Copyright (c) 2017-2025 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

//usage: apiCmd ["test",[arg1,arg2]]
#define apiCmd "revoicer" callExtension 
#define apiRequest(p) ("revoicer" callExtension (p))

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
    
    vs_isEnabledText = !isNull(relicta_global_textChatEnabled);

    0 spawn
    {
        waitUntil { !isNull findDisplay 46 };
        findDisplay 46 displayAddEventHandler ["Unload",
        {
            // code here gets executed on the client at end of mission, whether due to player abort, loss of connection, or mission ended by server
            // might not work on headless clients
            
            //force disconnect voice
            call vs_releaseAllTangents;
            call vs_disconnectVoice;
        }];
    };

    logformat("vs::init() - voip system: %1",apiRequest(REQ_GET_VERSION));

    vs_processPlayerPosHandler = "";
    call vs_startHandleProcessPlayerPos;
};

//подключен ли к голосовому серверу
vs_isConnectedVoice = {
    apiRequest(REQ_IS_CONNECTED_VOICE) == "true";
};

vs_connectVoice = {
    params ["_addr","_port","_user","_pass"];
    apiCmd [CMD_CONNECT_VOICE,[_addr,_port,_user,_pass]];
};
vs_disconnectVoice = {
    apiRequest(REQ_DISCONNECT_VOICE) == "true";  
};

//разговаривает ли
vs_isSpeaking = {
    apiRequest(REQ_IS_SPEAKING) == "true";
};

//получить микрофоны
vs_getMicDevices = {
    apiCmd CMD_GET_MIC_DEVICES;
};
//установить устройство записи
vs_setMicDevice = {
    params ["_id"];
    apiCmd [CMD_SET_MIC_DEVICE,[_id]];
};
//получить устройство воспроизведения
vs_getPlaybackDevices = {
    apiCmd CMD_GET_PLAYBACK_DEVICES;
};
//установить устройство воспроизведения
vs_setPlaybackDevice = {
    params ["_id"];
    apiCmd [CMD_SET_PLAYBACK_DEVICE,[_id]];
};

vs_startHandleProcessPlayerPos = {
	//todo remove - DISABLETEAMSPEAK 
    if !isNull(vs_serverdisabled) exitWith {};
	if not_equals(vs_processPlayerPosHandler,"") then {
		call vs_stopHandleProcessPlayerPos;
	};
	vs_processPlayerPosHandler = ["processPlayerPositionsHandler", "onEachFrame", "vs_onProcessPlayerPosition"] call BIS_fnc_addStackedEventHandler;
};

vs_stopHandleProcessPlayerPos = {
	if equals(vs_processPlayerPosHandler,"") exitWith {};
	[vs_processPlayerPosHandler, "onEachFrame"] call BIS_fnc_removeStackedEventHandler;
	vs_processPlayerPosHandler = "";
};

//main system loop
vs_onProcessPlayerPosition = {
    if (!vs_canProcess) exitWith {};

    if (call vs_checkConnection) then {
        call vs_syncLocalPlayer;
        call vs_syncRemotePlayers;
    };
};

//проверка подключения системы
vs_checkConnection = {
    if (call vs_isConnectedVoice) exitWith {true};
    //с последней проверки связи с сервером прошло время
    /*
    private _t = parseNumber apiRequest(REQ_GET_LAST_HEARTBEAT);
    if (_t > 0) then {
        if (!vs_lastError) then {

        };

        false
    } else {
        vs_lastError = false;
        true
    };
    */
    false
};

//синхронизация позиции локального юзера
vs_syncLocalPlayer = {
    private _args = [];
    _args append (ASLToATL eyepos player);
    _args append (velocity player);
    _args append getcameraviewdirection;
    _args append (vectorup player);
    
    apiCmd [CMD_SYNC_LOCAL_PLAYER,_args];
};

/* синхронизация удаленных людей
    uses:
        set3DConeOrientation
        set3DConeSettings
*/
vs_syncRemotePlayers = {
    private _nearPlayers = (player nearEntities ["Man", vs_max_voice_volume])-[player];
    private _mutedPlayers = (allPlayers-[player]) - _nearPlayers;
    private _proc = [];
    {
        if (isPlayer _x) then {
            _proc = [_x getvariable "rv_name"];
            _proc append (asltoatl eyepos _x);
            _proc append (eyedirection _x);
            
            //speaking distance
            _proc append (_x getvariable ["rv_distance",0]); 
            
            apiCmd [CMD_SYNC_REMOTE_PLAYER,_proc];

            //процессируем эффекты: вычисляем реверб, лоупасс
        };
    } foreach _nearPlayers;

    {
        //todo mute near
        
    } foreach _mutedPlayers;
};

vs_handleSpeak = {
    params ["_mode"];
    if equals(cal vs_isSpeaking,_mode) exitWith {};
    if (_mode) then {
        apiRequest(REQ_SPEAK_START);
    } else {
        apiRequest(REQ_SPEAK_STOP);
    };
};

vs_speakReleaseAll = {
    apiRequest(REQ_SPEAK_RELEASEALL);
};

vs_setLocalPlayerVoiceDistance = {
    params ["_d"];
    player setvariable ["rv_distance",_d,true];
};

//иницилизация сущности
vs_initMob = {
    params ["_mob","_nick"];

    if (local _mob) then {
        _mob setvariable ["rv_name",_nick,true];
        //дистанция речи
        _mob setvariable ["rv_distance",1,true];
        //фильтры (маски, кляпы, гостинг)
        _mob setvariable ["rv_filter",[],true];

    };
};