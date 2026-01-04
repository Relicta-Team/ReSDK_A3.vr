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

vs_apiversion = "stable_v4";

vs_localName = ""; //sended from server on player connected
vs_canProcess = false;
vs_max_voice_volume = 60;
vs_horizontal_tab = toString [9]; //для запросов
vs_isEnabledText = false;

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