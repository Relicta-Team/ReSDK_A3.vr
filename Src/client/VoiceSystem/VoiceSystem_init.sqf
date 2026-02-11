// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#define USE_REVOICE_BACKEND

//#include <engine.h>
#include <..\..\host\engine.hpp>
#include <..\..\host\lang.hpp>

namespace(VoiceSystem,vs_)

//Новый алгоритм затухания звука
macro_def(vs_use_new_algoritm_voice_intersection)
#define VOICE_USE_NEW_ALGORITM_VOICE_INTERSECTION

#ifdef USE_REVOICE_BACKEND
    vs_useReVoice = true;
#else
    vs_useReVoice = false;
#endif

#ifdef USE_REVOICE_BACKEND
    #include "ReVoice\ReVoice_init.sqf"
#else
    #include "VoiceSystem_uncategorized.sqf"

    //Публичный интерфейс управления
    #include "VoiceSystem_publicInterface.sqf"
#endif
