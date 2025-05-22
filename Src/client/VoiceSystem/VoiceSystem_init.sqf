// ======================================================
// Copyright (c) 2017-2025 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

//#include <engine.h>
#include <..\..\host\engine.hpp>
#include <..\..\host\lang.hpp>

namespace(VoiceSystem,vs_)

//Новый алгоритм затухания звука
macro_def(vs_use_new_algoritm_voice_intersection)
#define VOICE_USE_NEW_ALGORITM_VOICE_INTERSECTION

#include "VoiceSystem_uncategorized.sqf"

//Публичный интерфейс управления
#include "VoiceSystem_publicInterface.sqf"
