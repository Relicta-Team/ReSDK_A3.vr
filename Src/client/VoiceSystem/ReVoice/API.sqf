// ======================================================
// Copyright (c) 2017-2025 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

//usage: apiCmd ["test",[arg1,arg2]]
#define apiCmd "revoicer" callExtension 
#define apiRequest(p) ("revoicer" callExtension (p))

vs_init = {
    #ifndef REDITOR_VOICE_DEBUG
        #ifdef VOICE_DISABLE_IN_SINGLEPLAYERMODE
            if (!isMultiplayer) exitWith {};
        #endif
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
        #ifdef REDITOR_VOICE_DEBUG
            if (true) exitWith {};
        #endif

        waitUntil { !isNullReference(findDisplay 46) };
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

//вызывается когда клиент джоинится в игру
vs_connectToVoiceSystem = {
    vs_serverAddrPortPass params ["_addr","_port","_pass"];
    [_addr,_port,vs_localName,_pass] call vs_connectVoice;

    [player,vs_localName] call vs_initMob;
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

vs_getAllClients = {
    (apiCmd [CMD_GET_ALL_CLIENTS,[]]) params ["_r","_rcode"];
    if (_rcode == 0) then {
        _r splitString vs_horizontal_tab;
    } else {
        [];
    };
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
    #ifdef REDITOR_VOICE_DEBUG
        _args append (getposatl cameraon);
        _args append (velocity cameraon);
        _args append (vectordir cameraon);
        _args append (vectorup cameraon);
    #else
        _args append (ASLToATL eyepos player);
        _args append (velocity player);
        _args append (vectordir player);
        _args append (vectorup player);
    #endif
    
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
    
    #ifdef REDITOR_VOICE_DEBUG
    _nearPlayers = vs_reditor_procObjList;
    _mutedPlayers = [];
    #endif

    

    private _proc = [];
    {
        
        if (
            isPlayer _x
            #ifdef REDITOR_VOICE_DEBUG
            || true
            #endif
            #ifndef VOICE_DISABLE_IN_SINGLEPLAYERMODE
            || true
            #endif
        ) then {
            _proc = [_x getvariable "rv_name"];
            #ifdef REDITOR_VOICE_DEBUG
            _proc append (getposatl _x);
            _proc append (vectorDir _x);
            #else
            _proc append (_x modeltoworldvisual (_x selectionposition "head"));
            _proc append (vectorDir _x);
            #endif
            
            //speaking distance
            _proc pushback (_x getvariable ["rv_distance",0]); 
            
            apiCmd [CMD_SYNC_REMOTE_PLAYER,_proc];

            //процессируем эффекты: вычисляем реверб, лоупасс
            private _lp = [_x] call vs_calcLowpassEffect;
            _lp call vs_setLowpassEffect;

            private _reverb = [_x] call vs_calcReverbEffect;
            _reverb call vs_setReverbEffect;
        };
    } foreach _nearPlayers;

    {
        //todo refactoring
        apiCmd [CMD_SYNC_REMOTE_PLAYER,[_x getvariable "rv_name",[0,0,0],[0,1,0],1]];
    } foreach _mutedPlayers;
};

vs_handleSpeak = {
    params ["_mode"];
    if equals(call vs_isSpeaking,_mode) exitWith {};
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
        _mob setvariable ["rv_distance",4,true];
        //фильтры (маски, кляпы, гостинг)
        _mob setvariable ["rv_filter",[],true];

    };
};

//effects extension

vs_setLowpassEffect = {
    params ["_mob",["_cut",22000],["_res",10]];
    apiCmd [CMD_SETLOWPASS,[_mob getvariable ["rv_name",""],_cut,_res]];
};

vs_setReverbEffect = {
    params ["_mob",["_dec",1200],["_edel",20],["_ldel",40],["_hcut",8000],["_wet",-80],["_dry",0]];
    apiCmd [CMD_SETREVERB,[_mob getvariable ["rv_name",""],_dec,_edel,_ldel,_hcut,_wet,_dry]];
};

//получает настройки реверба для текущего моба (~0.976563ms per call)
vs_calcReverbEffect = {
    params ["_mob"];
    private _rayDistance = 100;
    private _ignore1 = player;
    #ifdef REDITOR_VOICE_DEBUG
        _ignore1 = cameraon;
        private _endPos = getposasl _mob;
    #else
        private _endPos = atltoasl(_mob modeltoworldvisual (_mob selectionposition "head"));
    #endif

    #define __postargs _ignore1,_mob,true,vs_max_voice_volume+1,"VIEW","GEOM",true,1
    private _pointsQuery = [
        //cross check
        [_endPos,_endPos vectorAdd [_rayDistance,0,0], __postargs],
        [_endPos,_endPos vectorAdd [0,_rayDistance,0], __postargs],
        [_endPos,_endPos vectorAdd [-_rayDistance,0,0], __postargs],
        [_endPos,_endPos vectorAdd [0,-_rayDistance,0], __postargs],
        //diagonal check
        [_endPos,_endPos vectorAdd [_rayDistance,_rayDistance,0], __postargs],
        [_endPos,_endPos vectorAdd [_rayDistance,-_rayDistance,0], __postargs],
        [_endPos,_endPos vectorAdd [-_rayDistance,_rayDistance,0], __postargs],
        [_endPos,_endPos vectorAdd [-_rayDistance,-_rayDistance,0], __postargs], //idx7

        //upside
        [_endPos,_endPos vectorAdd [0,0,_rayDistance], __postargs],
        [_endPos,_endPos vectorAdd [_rayDistance,0,_rayDistance], __postargs],
        [_endPos,_endPos vectorAdd [0,_rayDistance,_rayDistance], __postargs],
        [_endPos,_endPos vectorAdd [-_rayDistance,0,_rayDistance], __postargs],
        [_endPos,_endPos vectorAdd [0,-_rayDistance,_rayDistance], __postargs],
        //diagonal check
        [_endPos,_endPos vectorAdd [_rayDistance,_rayDistance,_rayDistance], __postargs],
        [_endPos,_endPos vectorAdd [_rayDistance,-_rayDistance,_rayDistance], __postargs],
        [_endPos,_endPos vectorAdd [-_rayDistance,_rayDistance,_rayDistance], __postargs],
        [_endPos,_endPos vectorAdd [-_rayDistance,-_rayDistance,_rayDistance], __postargs],

        //downside
        [_endPos,_endPos vectorAdd [0,0,-_rayDistance], __postargs],//idx 17
        [_endPos,_endPos vectorAdd [_rayDistance,0,-_rayDistance], __postargs],
        [_endPos,_endPos vectorAdd [0,_rayDistance,-_rayDistance], __postargs],
        [_endPos,_endPos vectorAdd [-_rayDistance,0,-_rayDistance], __postargs],
        [_endPos,_endPos vectorAdd [0,-_rayDistance,-_rayDistance], __postargs],
        //diagonal downside
        [_endPos,_endPos vectorAdd [_rayDistance,_rayDistance,-_rayDistance], __postargs],
        [_endPos,_endPos vectorAdd [_rayDistance,-_rayDistance,-_rayDistance], __postargs],
        [_endPos,_endPos vectorAdd [-_rayDistance,_rayDistance,-_rayDistance], __postargs],
        [_endPos,_endPos vectorAdd [-_rayDistance,-_rayDistance,-_rayDistance], __postargs]
    ];
    private _t = tickTime;
    private _result = lineIntersectsSurfaces [_pointsQuery];
    
    #ifdef REDITOR_VOICE_DEBUG
    ["timecall:%1ms",((tickTime - _t)*1000)toFixed 6] call printTrace;
    #endif
    
    private _nearWall = _rayDistance;
    private _floor = _rayDistance;
    private _ceiling = _rayDistance;
    private _distancesCount = 0;
    private _sumDistances = 0;

    {
        if (count _x > 0) then {
            private _cur = _x select 0;
            #ifdef REDITOR_VOICE_DEBUG
            
            drawLine3d [asltoatl _endPos,asltoatl (_cur select 0),call {
                if (_foreachindex <= 7) exitWith {[1,0,0,1]};
                if (_foreachindex <= 16) exitWith {[0,1,0,1]};
                [1,1,1,1]
            },10.4];
            #endif
            private _posDelta = (_cur select 0) distance _endPos;
            
            INC(_distancesCount);
            _sumDistances = _sumDistances + _posDelta;

            if (_foreachIndex <= 7) then { _nearWall = _nearWall min _posDelta };
            if (_foreachIndex >= 8 && _foreachIndex <= 16) then { _ceiling = _ceiling min _posDelta };
            if (_foreachIndex >= 17) then { _floor = _floor min _posDelta };
        };
        
    } foreach _result;

    private _avgWall = if (_distancesCount > 0) then {_sumDistances / _distancesCount} else {_rayDistance};

    // Добавляем метрику для определения открытой/закрытой местности
    private _upHits = 0;
    {
        if (_foreachIndex >= 8 && _foreachIndex <= 16 && count _x > 0) then {
            INC(_upHits);
        };
    } foreach _result;

    private _isOpen = if (_distancesCount == 0) then {true} else {(_upHits < 3) || (_ceiling >= 50)};

    // Вычисляем параметры с учетом _isOpen
    private _roomSizeApprox = (_avgWall + _ceiling + _floor) / 3;
    private _edel = if (_isOpen) then {0} else {((2 * _nearWall) / 343) * 1000 min 200};
    private _ldel = if (_isOpen) then {0} else {_edel + 40 + random 20};
    private _decay = if (_isOpen) then {0.1} else {0.1 + (_roomSizeApprox / 5) min 10};
    private _hcut = if (_isOpen) then {20000} else {4000 max (20000 - _nearWall * 200)};
    private _wetCalc = -20 + (30 - (_avgWall min 30)) * 1.2;
    private _wet = if (_isOpen) then {-80} else {(_wetCalc max -20) min 0};
    private _dry = 0;

    [
        _mob,
        _decay * 1000,
        _edel,
        _ldel,
        _hcut,
        _wet,
        _dry
    ]
    
};

vs_calcLowpassEffect = {
    params ["_mob"];
    #ifdef REDITOR_VOICE_DEBUG
    private _startPos = getposasl cameraon;
    private _endPos = getposasl _mob;
    private _ignore1 = cameraon;
    #else
    private _startPos = atltoasl(player modeltoworldvisual (player selectionposition "head"));
    private _endPos = atltoasl(_mob modeltoworldvisual (_mob selectionposition "head"));
    private _ignore1 = player;
    #endif

    private _ignore2 = _mob;

    // [begPosASL, endPosASL, ignoreObj1, ignoreObj2, sortMode, maxResults, LOD1, LOD2, returnUnique]
    
    //! СЕЙЧАС УПРОЩЁННЫЙ АЛГОРИТМ
    #ifdef REDITOR_VOICE_DEBUG
    if !isNull(vs_reditor_queryListLowpass) then {
        deletevehicle vs_reditor_queryListLowpass;
    };
    vs_reditor_queryListLowpass = [];
    #endif

    private _its = lineIntersectsSurfaces [_startPos,_endPos,_ignore1,_ignore2,true,100,"VIEW","GEOM",false];
    if (count _its == 0) exitWith {[_mob,22000,10]};
    private _itsRev = lineIntersectsSurfaces [_endPos,_startPos,_ignore1,_ignore2,true,100,"VIEW","GEOM",false];
    if (count _itsRev == 0) exitWith {[_mob,22000,10]};
    reverse _itsRev;
    private _thickness = 0;
    {
        _x params ["_pos","_norm","_cur"];
        #ifdef REDITOR_VOICE_DEBUG
        private _o = "Sign_Arrow_F" createVehicleLocal [0,0,0];
        vs_reditor_queryListLowpass pushBack _o;
        _o setposasl _pos;
        #endif

        while {count _itsRev > 0} do {
            (_itsRev select 0) params ["_posInv","_normInv","_curInv"];
            _itsRev deleteAt 0;
            //["check %1",[_cur,_curInv]] call printTrace;
            if equals(_cur,_curInv) exitWith {
                #ifdef REDITOR_VOICE_DEBUG
                private _o = "Sign_Arrow_F" createVehicleLocal [0,0,0];
                _o setObjectTexture [0,"#(rgb,8,8,3)color(0,1,0,1)"];
                vs_reditor_queryListLowpass pushBack _o;
                _o setposasl _posInv;
                #endif
                _thickness = _thickness + (_pos distance _posInv);
            };
        };

    } foreach _its;
    
    private _distance = _endPos distance _startPos;
    private _distFactor = 1 + (_distance / 10); // каждые 50 м уменьшают cutoff

    private _cutoff =  6000 / (1 + _thickness / 0.5) / _distFactor;
    private _q = 1.2 / (1 + (_thickness / 1.0));

    [_mob,_cutoff,_q]
};