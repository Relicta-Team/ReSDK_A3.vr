// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\..\host\engine.hpp>
#include <..\..\ClientRpc\clientRpc.hpp>
#include <..\..\..\host\NOEngine\NOEngine.hpp>
#include "..\..\..\host\ServerVoice\ReVoicer.hpp"

#include "ReVoice.h"

#define VOICE_DISABLE_IN_SINGLEPLAYERMODE

vs_apiversion = "stable_v5_with_subscribers";

vs_localName = ""; //sended from server on player connected
vs_canProcess = false;
vs_max_voice_volume = 60;
vs_horizontal_tab = toString [9]; //для запросов
vs_isEnabledText = false;

vs_voiceListenersEnabled = true;
vs_voiceListenerReady = false;
vs_voiceListenerMaxTargets = 10;
vs_voiceListenerEnterDistance = vs_max_voice_volume;
vs_voiceListenerExitDistance = vs_max_voice_volume + 10;
vs_voiceListenerLingerTime = 10;
vs_voiceListenerUpdateDelay = 2;
vs_voiceListenerUpdateJitter = 0.5;
vs_voiceListenerRetryDelay = 1;
vs_voiceListenerRadioTtl = 2;
vs_voiceListenerNextUpdate = 0;
vs_voiceListenerNextEnsure = 0;
vs_voiceListenerLastPayload = "";
vs_voiceListenerTargets = [];
vs_voiceListenerExpires = createHashMap;
vs_voiceListenerRadioRequired = createHashMap;

vs_voipVolCurrent = profileNamespace getvariable ["rel_voipvol",1];
if not_equalTypes(vs_voipVolCurrent,0) then {
	vs_voipVolCurrent = 1;
};
vs_voipVolCurrent = clamp(vs_voipVolCurrent,0,10);

#ifdef REDITOR_VOICE_DEBUG
    //список процессируемых объектов
	if isNull(vs_reditor_procObjList) then {
		vs_reditor_procObjList = [];
	};
#endif

//инициализация и управление системы
#include "API.sqf"
//пользовательский ввод
#include "Input.sqf"
//система динамиков (и радио)
#include "Speaker.sqf"

//аудиосистема
#include "AudioSystem.sqf"

call vs_init;
