// ======================================================
// Copyright (c) 2017-2025 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\..\host\engine.hpp>
#include <..\..\ClientRpc\clientRpc.hpp>
#include <..\..\..\host\NOEngine\NOEngine.hpp>

#include "ReVoice.h"

#define VOICE_DISABLE_IN_SINGLEPLAYERMODE

vs_canProcess = true;
vs_max_voice_volume = 60;
vs_horizontal_tab = toString [9]; //для запросов
vs_isEnabledText = false;

//инициализация и управление системы
#include "API.sqf"
//пользовательский ввод
#include "Input.sqf"
//система динамиков (и радио)
#include "Speaker.sqf"
