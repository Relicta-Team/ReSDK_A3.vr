// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\host\engine.hpp>
#include <..\ClientRpc\clientRpc.hpp>
#include <..\Rendering\PostProcessing\postprocessing.h>

namespace(GrenadeEffects,grenadefx_)

if !isNullVar(grenadefx_updateHandle) then {
	stopUpdate(grenadefx_updateHandle);
};
if (!isNullVar(grenadefx_tinnitusHandle) && {grenadefx_tinnitusHandle != "0"}) then {
	grenadefx_tinnitusHandle call vs_audio_stopSound;
};
#ifdef DEBUG_GRENADES
if !isNullVar(grenadefx_debugObjects) then {
	{deleteVehicle _x} foreach grenadefx_debugObjects;
};
#endif

// Hearing state is public because ReVoice reads the current low-pass intensity.
decl(float) grenadefx_hearingIntensity = 0;
decl(float) grenadefx_hearingBase = 0;
decl(float) grenadefx_hearingStart = 0;
decl(float) grenadefx_hearingEnd = 0;
decl(string) grenadefx_tinnitusHandle = "0";
decl(float) grenadefx_hearingSteadyDuration = 6;
decl(float) grenadefx_hearingFadeDuration = 4;
decl(float) grenadefx_hearingDuration = grenadefx_hearingSteadyDuration + grenadefx_hearingFadeDuration;
decl(float) grenadefx_tinnitusVolume = 1;

#ifdef DEBUG_GRENADES
decl(mesh[]) grenadefx_debugObjects = [];
#endif

#include "GrenadeEffects_functions.sqf"
call grenadefx_cleanupLegacyVisualState;
#ifdef DEBUG_GRENADES
#include "GrenadeEffects_debug.sqf"
#endif

decl(int) grenadefx_updateHandle = startUpdate(grenadefx_update,0.1);

rpcAdd("grenade_concussion",grenadefx_onExplosion);
#ifdef DEBUG_GRENADES
rpcAdd("grenade_debug",grenadefx_onDebugExplosion);
#endif
