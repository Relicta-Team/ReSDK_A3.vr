// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================



#ifdef REDITOR_VOICE_DEBUG
    #define revoice_debug_only(debug_expr) debug_expr;
    #define REDITOR_VOICE_DEBUG_RENDER
#else
    #define revoice_debug_only(debug_expr) 
#endif

#undef REDITOR_VOICE_DEBUG_RENDER

//частота вычисления позиционных эффектов. для лучшего импакта рекомендую в будущем снизить до 0.2
#define VOICE_UPDATE_EFFECTS_DELAY 0.5

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
        //внутри только нативный код. все функции клиента на этом этапе выгружены
        private _nativeCode = (toString vs_speakReleaseAll)+";"+(toString vs_disconnectVoice)+";diag_log 'vs_init() - internal voice disconnect on unload game display';";
        findDisplay 46 displayAddEventHandler ["Unload",compile _nativeCode];
    };

    logformat("vs::init() - voip system: %1; api version: %2",apiRequest(REQ_GET_VERSION) arg vs_apiversion);

    vs_processPlayerPosHandler = "";
    call vs_startHandleProcessPlayerPos;
};

//подключен ли к голосовому серверу
vs_isConnectedVoice = {
    apiRequest(REQ_IS_CONNECTED_VOICE) == "true";
};

vs_connectVoice = {
    params ["_addr","_port","_user","_pass"];
    ((apiCmd [CMD_CONNECT_VOICE,[_addr,_port,_user,_pass]]) select 0) == "True";
};

//вызывается когда клиент джоинится в игру
vs_connectToVoiceSystem = {
    #ifdef VOICE_DISABLE_IN_SINGLEPLAYERMODE
        if (!isMultiplayer) exitWith {};
    #endif
    vs_serverAddrPortPass params ["_addr","_port","_pass"];
    private _r = [_addr,_port,vs_localName,_pass] call vs_connectVoice;

    [player,vs_localName] call vs_initMob;

    [2] call vs_changeVoiceVolume;

    vs_canProcess = true;
    _r
};

//низкоуровневая функция остановки войса. Вызывается при кике или отключении от сервера
vs_disconnectVoice = {
    apiRequest(REQ_DISCONNECT_VOICE) == "true";  
};

//функция "правильного" завершения системы. Вызывается при выходе в лобби или перезагрузке войса
vs_disconnectVoiceSystem = {
    
    [false] call vs_handleSpeak; //stop voice and radios

    vs_canProcess = false;
    {
        [_x,true] call vs_internal_clearEffectValues;
    } foreach (smd_allInGameMobs);
    call vs_disconnectVoice;
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

vs_setMasterVoiceVolume = {
    params ["_vol"];
    _vol = clamp(_vol,0,10);
    ((apiCmd [CMD_SET_MASTER_VOICE_VOLUME,[_vol]])select 0)=="True";
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
        //revoice_debug_only(_t = tickTime; _mv = {vs_debug_maxvalue=_this max vs_debug_maxvalue;vs_debug_maxvalue})
        /*
            max 1.098633ms for local or remotes without effects
            ~max 17 ms for 100 players (only remotes,noeffects)
            mid 3-4 ms for 100 players (only remotes,noeffects)
        */
        call vs_syncLocalPlayer;
        //revoice_debug_only(["sync local %1ms" arg (((tickTime - _t)*1000)call _mv)tofixed 6]call printTrace;_t=tickTime;)
        //revoice_debug_only(_t = tickTime; _mv = {vs_debug_maxvalue=round _this max vs_debug_maxvalue;vs_debug_maxvalue})
        call vs_syncRemotePlayers;
        //revoice_debug_only(if (((tickTime - _t)*1000) > 10) then {["LOWPERF: sync remote %1ms" arg (((tickTime - _t)*1000) )tofixed 0]call printTrace;_t=tickTime;})

        call vs_processRadios;
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
    if (!isGameFocused) then {
        [false] call vs_handleSpeak;
    };

    private _args = [];
    #ifdef REDITOR_VOICE_DEBUG
        _args append (getposatl cameraon);
        _args append (velocity cameraon);
        _args append (vectordir cameraon);
        _args append (vectorup cameraon);
    #else
        _args append (ASLToATL eyepos player);
        _args append (velocity player);
        //используется cam_fixedObject из-за вектора камеры, синхронизированной с рендером
        _args append (vectordir cam_fixedObject);
        _args append (vectorup cam_fixedObject);
    #endif
    
    apiCmd [CMD_SYNC_LOCAL_PLAYER,_args];
};

#ifdef EDITOR
vs_debug_generateClients = {
    _r = [];
    for "_i" from 1 to _this do {
        _o = create3DENEntity["object", "Land_Orange_01_F",getposatl cameraon];
        _o setvariable ["rv_name","rem"];
        _o setvariable ["rv_distance",4];
        _r pushback _o;
    };
    _r
};
#endif

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
            //speaking volume
            _vol = _x getvariable ["rv_volume",1];
            _vol = [_x,_vol] call vs_processSpeakingLangs;
            _proc pushback _vol;
            
            private _state = apiCmd [CMD_SYNC_REMOTE_PLAYER,_proc];
            
            if ((_state select 1) == 0) then {
                [_x,_state select 0] call vs_handleUserSpeakInternal;

                //мы не слышим игрока - выход
                if (_vol <= 0) exitWith {};

                //мы находимся дальше дистанции слышимости
                if (
                    (_proc select [1,3]) distance (
                        #ifdef REDITOR_VOICE_DEBUG
                        getposatl cameraon
                        #else
                        ASLToATL eyepos player
                        #endif
                    ) >= (_x getvariable ["rv_distance",0])
                ) exitWith {};

                //для оптимизации эффекты процессятся только при разговоре
                if (_state select 0=="speak") then {

                    //процессируем эффекты: вычисляем реверб, лоупасс
                    _nextUpd = _x getvariable ["__rv_nexteffupd",0];
                    if (tickTime>=(_nextUpd)) then {
                        private _newTime = tickTime+VOICE_UPDATE_EFFECTS_DELAY;
                        //при первой инициализации добавляем случайное смещение
                        //! пробуем этот подход распределения нагрузки с 1.5+, если не поможет - убрать
                        if (_nextUpd == 0) then {
                            _newTime = _newTime + (random 1)+(_foreachindex/32);
                        };
                        _x setvariable ["__rv_nexteffupd",_newTime];
                        private _lp = [_x] call vs_calcLowpassEffect;
                        private _reverb = [_x] call vs_calcReverbEffect;
                        [_x,_lp,_reverb] call vs_internal_setTargetEffectValues;
                    };
                    
                    [_x] call vs_internal_applyEffects;
                }

            };
        };
    } foreach _nearPlayers;
    

    {
        if (isPlayer _x) then {
            _x setvariable ["__rv_nexteffupd",null];
            apiCmd [CMD_SYNC_REMOTE_PLAYER,[_x getvariable "rv_name",0,0,0,0,1,0,1,0]];
        };
    } foreach _mutedPlayers;
};

vs_handleUserSpeakInternal = {
    params ["_mob","_state"];
    if (_state == "speak") exitWith {
        if (!(_mob getvariable ["rv_isSpeaking",false])) then {
            _mob setvariable ["rv_isSpeaking",true];
            [_mob,true] call vs_onUserSpeak;
        };
    };
    if (_state == "nospeak") exitWith {
        if ((_mob getvariable ["rv_isSpeaking",false])) then {
            _mob setvariable ["rv_isSpeaking",false];
            [_mob,false] call vs_onUserSpeak;
        };
    };
};

//событие когда другой клиент говорит или перестает говорить
vs_onUserSpeak = {
    params ["_mob","_isSpeaking"];
    if (_isSpeaking) then {
        _mob setRandomLip true;
    } else {
        _mob setRandomLip false;
    };
};

vs_handleSpeak = {
    params ["_mode"];
    if equals(call vs_isSpeaking,_mode) exitWith {};
    if (_mode) then {
        //unconscious/dead skip mic capture
        if !([] call interact_isActive) exitWith {};
        apiRequest(REQ_SPEAK_START);

        [true] call vs_handleMicRadioObjects;
    } else {
        apiRequest(REQ_SPEAK_STOP);

        [false] call vs_handleMicRadioObjects;
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
        //! это теперь ставится на сервере
        //_mob setvariable ["rv_name",_nick,true];
        
        //дистанция речи
        _mob setvariable ["rv_distance",4,true];
        
        //todo фильтры (маски, кляпы, гостинг)
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

vs_internal_setTargetEffectValues = {
    params ["_mob","_lowpass","_reverb"];
    //save previous values
    _mob setvariable ["__rv_lowpass_prev",_mob getvariable "__rv_lowpass"];
    _mob setvariable ["__rv_reverb_prev",_mob getvariable "__rv_reverb"];

    //then update current
    _mob setvariable ["__rv_lowpass",_lowpass];
    _mob setvariable ["__rv_reverb",_reverb];
    _mob setvariable ["__rv_effLastUpdateTime",tickTime];
};

//сбрасывает все значения эффектов
vs_internal_clearEffectValues = {
    params ["_mob",["_clearUpdateMark",false]];
    _mob setvariable ["__rv_lowpass",null];
    _mob setvariable ["__rv_reverb",null];
    _mob setvariable ["__rv_lowpass_prev",null];
    _mob setvariable ["__rv_reverb_prev",null];
    _mob setvariable ["__rv_effLastUpdateTime",null];
    if (_clearUpdateMark) then {
        _mob setvariable ["__rv_nexteffupd",null];
    };
};

vs_internal_applyEffects = {
    params ["_mob"];
    private _lp = _mob getvariable "__rv_lowpass";
    private _lpPrev = _mob getvariable "__rv_lowpass_prev";
    private _rv = _mob getvariable "__rv_reverb";
    private _rvPrev = _mob getvariable "__rv_reverb_prev";
    private _lastSet = _mob getvariable ["__rv_effLastUpdateTime",tickTime];

    if (!isNullVar(_lp) && !isNullVar(_lpPrev)) then {
        private _lpReal = [];
        {
            if equalTypes(_x,0) then {
                _lpReal pushback (linearConversion [_lastSet,_lastSet + VOICE_UPDATE_EFFECTS_DELAY,tickTime,_lpPrev select _foreachIndex,_x,true])
            } else {
                _lpReal pushback _x
            }
        } foreach _lp;
        _lpReal call vs_setLowpassEffect;
    };
    if (!isNullVar(_rv) && !isNullVar(_rvPrev)) then {
        private _rvReal = [];
        {
            if equalTypes(_x,0) then {
                _rvReal pushback (linearConversion [_lastSet,_lastSet + VOICE_UPDATE_EFFECTS_DELAY,tickTime,_rvPrev select _foreachIndex,_x,true])
            } else {
                _rvReal pushback _x
            }
        } foreach _rv;
        _rvReal call vs_setReverbEffect;
    };
};

//получает настройки реверба для текущего моба (~0.976563ms per call)
vs_calcReverbEffect = {
    params ["_target",["_targetAsPos",false],["_soundId",-1],["_dist",0]];
    
    private _rayDistance = 100;
    private _ignore1 = player;
    #ifdef REDITOR_VOICE_DEBUG
        _ignore1 = cameraon;
        private _endPos = ifcheck(_targetAsPos,atltoasl _target,getposasl _target);
        private _isMob = _target in vs_reditor_procObjList;
        if (_targetAsPos) then {
            _ignore2 = objNull;
            _endPos = atltoasl _target;
            _target = _soundId;
        };
    #else
        private _isMob = false;
        private _endPos = [0,0,0];
        private _ignore2 = _target;
        if (_targetAsPos) then {
            _ignore2 = objNull;
            _endPos = atltoasl _target;
            _target = _soundId;
        } else {
            _isMob = typeof _target == BASIC_MOB_TYPE;
            _endPos = if (_isMob) then {
                atltoasl(_target modeltoworldvisual (_target selectionposition "head"));
            } else {
                getposasl _target;
            };
        };
    #endif

    #define __postargs _ignore1,_ignore2,true,1,"VIEW","GEOM",true
    
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

    //private _t = tickTime;
    private _result = lineIntersectsSurfaces [_pointsQuery];
    
    // #ifdef REDITOR_VOICE_DEBUG
    // ["timecall:%1ms",((tickTime - _t)*1000)toFixed 6] call printTrace;
    // #endif
    
    private _nearWall = _rayDistance;
    private _floor = _rayDistance;
    private _ceiling = _rayDistance;
    private _distancesCount = 0;
    private _sumDistances = 0;

    {
        if (count _x > 0) then {
            private _cur = _x select 0;
            #ifdef REDITOR_VOICE_DEBUG_RENDER
            
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

    //private _avgWall = if (_distancesCount > 0) then { _sumDistances / _distancesCount } else { _rayDistance };

    // // === FMOD-параметры ===
    // private _edel = (_nearWall / 343) * 1000;         // ранние отражения (мс)
    // private _ldel = _edel + 20 + random 10;           // поздние отражения
    // private _decay = 0.3 + ((_avgWall + _ceiling + _floor) / 3) / 10; // затухание
    // private _hcut = 8000 max (22000 - _nearWall * 300);
    // private _wet = -20 + (_avgWall min 30) * 0.5;
    // private _dry = 0;

    // [
    //     _target,
    //     _decay * 1000,
    //     _edel,
    //     _ldel,
    //     _hcut,
    //     _wet,
    //     _dry
    // ]

    //new algo v2(works fine)
    private _avgWall = if (_distancesCount > 0) then { _sumDistances / _distancesCount } else { _rayDistance };

    private _volumeFactor = if (_targetAsPos) then {
        (linearConversion [4,60,_dist,0.8,1.5 * 1.5,true] ); //немного увеличенный фактор для лучшей "эффектности" реверба
    } else {
        if (_isMob) then {
            private _distSpeaker = _target getvariable ["rv_distance",4]; 
            linearConversion [4,60,_distSpeaker,0.8,1.5,true];
        } else {
            //currently constant value
            if (_target call vs_isWorldRadioObject) then {
                private _rdata = _target call vs_getObjectRadioData;
                linearConversion [4,60,_rdata get "dist",0.8,1.5,true];
            } else {
                1.5;
            };
        };
    };
    
    private _avgDim = (_avgWall + _ceiling + _floor) / 3;


    //wetupdate
    // параметры для подстройки
    private _minWet = -20;      // wet в самой маленькой коробке (dB)
    private _maxWet = -2;       // wet в очень большой пещере (dB)
    private _wetScale = 8;      // "скала" в метрах — как быстро wet поднимается с размером
    private _wetBoostPerVol = 6; // сколько dB добавить при полном "крике" (volumeFactor>1)

    // экспоненциальная петля: 1 - exp(-avgDim / scale) — даёт S-образный рост
    private _wetBase = _minWet + (_maxWet - _minWet) * (1 - (exp (- (_avgDim / _wetScale))));

    // усиление от громкости говорящего: volumeFactor в твоём коде ~ [0.8..1.5]
    // делаем так: если volumeFactor > 1 => прибавляем (volumeFactor-1) * wetBoostPerVol
    private _wetFromVol = (_volumeFactor - 1) * _wetBoostPerVol;
    //wetupdate end

    private _edel  = (_nearWall / 343) * 1000;
    private _ldel  = _edel + (_avgDim / 2) + random 15;
    private _decay = (0.5 + (sqrt _avgDim) * 0.15) * _volumeFactor;
    _decay = _decay min 7;

    private _hcut = 18000 - (_nearWall * 200);
    _hcut = _hcut max 4000;

    // private _wet = (-8 + (_avgDim * 0.4)) * _volumeFactor;
    // _wet = _wet max -60 min 0;

    //new wet
    // итоговый wet (dB), с зажимом в допустимом диапазоне
    private _wet = _wetBase + _wetFromVol;
    _wet = _wet max _minWet;   // не ниже минимального
    _wet = _wet min 0;         // не выше 0 dB (FMOD ожидает отрицательные/нулевые значения)

    private _dry = 0;

    [
        _target,
        _decay * 1000,
        _edel,
        _ldel,
        _hcut,
        _wet,
        _dry
    ]
    
};

vs_calcLowpassEffect = {
    params ["_target",["_targetAsPos",false],["_soundId",-1]];
    #ifdef REDITOR_VOICE_DEBUG
    private _startPos = getposasl cameraon;
    private _endPos = ifcheck(_targetAsPos,atltoasl _target,getposasl _target);
    private _ignore1 = cameraon;
    #else
    private _startPos = atltoasl(player modeltoworldvisual (player selectionposition "head"));
    private _endPos = if (_targetAsPos) then {
        atltoasl _target
    } else {
        if (typeof _target == BASIC_MOB_TYPE) then {
            atltoasl(_target modeltoworldvisual (_target selectionposition "head"));
        } else {
            getposasl _target;
        };
    };
    private _ignore1 = player;
    #endif

    private _ignore2 = _target;

    //override ignore2 if target is sound id
    if (_targetAsPos) then {
        _ignore2 = objNull;
        _target = _soundId;
    };

    // [begPosASL, endPosASL, ignoreObj1, ignoreObj2, sortMode, maxResults, LOD1, LOD2, returnUnique]
    
    //! СЕЙЧАС УПРОЩЁННЫЙ АЛГОРИТМ
    #ifdef REDITOR_VOICE_DEBUG_RENDER
    private _t = tickTime;
    if !isNull(vs_reditor_queryListLowpass) then {
        deletevehicle vs_reditor_queryListLowpass;
    };
    vs_reditor_queryListLowpass = [];
    #endif

    //постпроцессоры эффекта
    private _checkFilters = {
        //TODO мы можем настроить срез частот при отдалении от игрока
        // private _distance = _endPos distance _startPos;
        // private _distFactor = 1 + (_distance / 10);
        // _cutoff =  _cutoff / (1 / 0.3) / _distFactor;

        #ifdef REDITOR_VOICE_DEBUG
        if(true) exitWith {};
        #endif

        if !([] call interact_isActive) then {
            _cutoff = _cutoff min 600;
	        _q = _q min 1;
        };
    };
    private _defRet = {
        private _cutoff = 22000;
        private _q = 2; //снижено для более плавного перехода между есть\нет препятствий
        call _checkFilters;
        [_target,_cutoff,_q]
    };

    private _its = lineIntersectsSurfaces [_startPos,_endPos,_ignore1,_ignore2,true,100,"VIEW","GEOM",false];
    if (count _its == 0) exitWith _defRet;
    private _itsRev = lineIntersectsSurfaces [_endPos,_startPos,_ignore1,_ignore2,true,100,"VIEW","GEOM",false];
    if (count _itsRev == 0) exitWith _defRet;
    reverse _itsRev;
    private _thickness = 0;

    //срезаем ненужные элементы (юниты и малые объекты (объем меньше 0.3))
    private _remlist = [];
    private _xCur = objNull;
    {
        _xCur = _x select 2;
        if (typeof _xCur == BASIC_MOB_TYPE) then {
            _remlist pushBack _foreachIndex;
            continue;
        };
        //TODO после нормального расчета убрать. тонкие мелкие предметы не должны влиять на слышимость
        if (((0 boundingBoxReal _xCur) select 2) <= 0.8) then {
            _remlist pushBack _foreachIndex;
            continue;
        };
    } foreach _its;
    _its deleteAt _remlist;
    //нет элементов после отрбаковки - возвращаем дефолт
    if (count _its == 0) exitWith _defRet;
    
    {
        _x params ["_pos","_norm","_cur"];
        #ifdef REDITOR_VOICE_DEBUG_RENDER
        private _o = "Sign_Arrow_F" createVehicleLocal [0,0,0];
        vs_reditor_queryListLowpass pushBack _o;
        _o setposasl _pos;
        #endif

        while {count _itsRev > 0} do {
            (_itsRev select 0) params ["_posInv","_normInv","_curInv"];
            _itsRev deleteAt 0;
            //["check %1",[_cur,_curInv]] call printTrace;
            if equals(_cur,_curInv) exitWith {
                #ifdef REDITOR_VOICE_DEBUG_RENDER
                private _o = "Sign_Arrow_F" createVehicleLocal [0,0,0];
                _o setObjectTexture [0,"#(rgb,8,8,3)color(0,1,0,1)"];
                vs_reditor_queryListLowpass pushBack _o;
                _o setposasl _posInv;
                #endif
                _thickness = _thickness + (_pos distance _posInv);
            };

            #ifdef REDITOR_VOICE_DEBUG_RENDER
            private _o = "Sign_Arrow_F" createVehicleLocal [0,0,0];
            _o setObjectTexture [0,"#(rgb,8,8,3)color(0,0,1,1)"];
            vs_reditor_queryListLowpass pushBack _o;
            _o setposasl _posInv;
            #endif
        };

    } foreach _its;
    
    private _distance = _endPos distance _startPos;
    private _distFactor = 1 + (_distance / 10); // каждые 50 м уменьшают cutoff

    private _cutoff =  6000 / (1 + _thickness / 0.5) / _distFactor;
    private _q = 1.2 / (1 + (_thickness / 1.0));
    
    call _checkFilters;

    #ifdef REDITOR_VOICE_DEBUG_RENDER
    ["lowpass timecall:%1ms; Thickness:%2",((tickTime - _t)*1000)toFixed 6,_thickness] call printTrace;
    #endif

    [_target,_cutoff,_q]
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