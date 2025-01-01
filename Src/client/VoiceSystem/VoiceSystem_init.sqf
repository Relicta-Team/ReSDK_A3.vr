// ======================================================
// Copyright (c) 2017-2025 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <engine.h>
#include <script.h>
#include <VoiceSystem_widgetEnums.h>

//Включенный флаг отключает компиляцию старых функций
#define VOICE_DISABLE_LEGACYCODE

//Новый алгоритм затухания звука
#define VOICE_USE_NEW_ALGORITM_VOICE_INTERSECTION

#include "VoiceSystem_keysConstant.sqf"
#include "VoiceSystem_uncategorized.sqf"
//Всё что не влезло в первый файл по препроцессору влезет во вторую часть
#include "VoiceSystem_part2.sqf"

//Публичный интерфейс управления
#include "VoiceSystem_publicInterface.sqf"
