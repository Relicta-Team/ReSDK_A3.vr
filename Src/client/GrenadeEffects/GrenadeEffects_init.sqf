// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\host\engine.hpp>
#include <..\ClientRpc\clientRpc.hpp>
#include <..\Rendering\PostProcessing\postprocessing.h>
#include <..\WidgetSystem\widgets.hpp>

namespace(GrenadeEffects,grenadefx_)

if !isNullVar(grenadefx_updateHandle) then {
	stopUpdate(grenadefx_updateHandle);
};
if (!isNullVar(grenadefx_tinnitusHandle) && {grenadefx_tinnitusHandle != "0"}) then {
	grenadefx_tinnitusHandle call vs_audio_stopSound;
};
if (!isNullVar(grenadefx_darkAdaptationOverlay) && {!isNullReference(grenadefx_darkAdaptationOverlay)}) then {
	[grenadefx_darkAdaptationOverlay] call deleteWidget;
};
#ifdef DEBUG_GRENADES
if !isNullVar(grenadefx_debugObjects) then {
	{deleteVehicle _x} foreach grenadefx_debugObjects;
};
#endif

// Hearing state is public because ReVoice reads the current low-pass intensity.
decl(float) grenadefx_hearingIntensity = 0;
decl(float) grenadefx_hearingBase = 0;
decl(float) grenadefx_hearingEnd = 0;
decl(string) grenadefx_tinnitusHandle = "0";
decl(float) grenadefx_hearingDuration = 60;
decl(float) grenadefx_tinnitusVolume = 1;

// Visual channels are sight-gated and keep the strongest remaining exposure.
decl(float) grenadefx_darkAdaptationBase = 0;
decl(float) grenadefx_darkAdaptationEnd = 0;
decl(float) grenadefx_darkAdaptationDuration = 2;
decl(float) grenadefx_darkAdaptationMinDuration = 2;
decl(float) grenadefx_darkAdaptationMaxDuration = 10;
decl(float) grenadefx_darkAdaptationMaxOpacity = 0.525;
decl(widget) grenadefx_darkAdaptationOverlay = [getGUI,BACKGROUND,WIDGET_FULLSIZE] call createWidget;
grenadefx_darkAdaptationOverlay setBackgroundColor [0,0,0,1];
grenadefx_darkAdaptationOverlay ctrlEnable false;
widgetSetFade(grenadefx_darkAdaptationOverlay,1,0);
decl(float) grenadefx_afterimageBase = 0;
decl(float) grenadefx_afterimageEnd = 0;
decl(float) grenadefx_afterimageDuration = 4;
decl(float) grenadefx_afterimageMinDuration = 4;
decl(float) grenadefx_afterimageMaxDuration = 20;
decl(float) grenadefx_afterimageMaxBlur = 1.6;
decl(float) grenadefx_afterimagePulsePeriod = 0.45;
decl(float) grenadefx_afterimagePulseLength = 0.28;
decl(float) grenadefx_afterimageResidual = 0.2;
#ifdef DEBUG_GRENADES
decl(mesh[]) grenadefx_debugObjects = [];
#endif

#include "GrenadeEffects_functions.sqf"
#ifdef DEBUG_GRENADES
#include "GrenadeEffects_debug.sqf"
#endif

decl(int) grenadefx_updateHandle = startUpdate(grenadefx_update,0.1);

rpcAdd("grenade_concussion",grenadefx_onExplosion);
#ifdef DEBUG_GRENADES
rpcAdd("grenade_debug",grenadefx_onDebugExplosion);
#endif
