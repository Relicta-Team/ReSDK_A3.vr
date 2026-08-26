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

decl(float) grenadefx_hearingIntensity = 0;
decl(float) grenadefx_hearingBase = 0;
decl(float) grenadefx_hearingEnd = 0;
decl(float) grenadefx_visionBase = 0;
decl(float) grenadefx_visionEnd = 0;
decl(string) grenadefx_tinnitusHandle = "0";
decl(float) grenadefx_effectDuration = 60;

grenadefx_isExplosionVisible = {
	params ["_origin"];
	if (count (worldToScreen _origin) == 0) exitWith {false};
	private _hits = lineIntersectsSurfaces [
		AGLToASL positionCameraToWorld [0,0,0],
		AGLToASL _origin,
		player,
		objNull,
		true,
		1,
		"VIEW",
		"GEOM"
	];
	count _hits == 0
};

grenadefx_update = {
	private _now = tickTime;
	grenadefx_hearingIntensity = ifcheck(
		_now < grenadefx_hearingEnd,
		grenadefx_hearingBase * ((grenadefx_hearingEnd - _now) / grenadefx_effectDuration),
		0
	);
	private _visionIntensity = ifcheck(
		_now < grenadefx_visionEnd,
		grenadefx_visionBase * ((grenadefx_visionEnd - _now) / grenadefx_effectDuration),
		0
	);

	private _blur = getPPVar("grenade_blur");
	private _flash = getPPVar("grenade_flash");
	if (_visionIntensity > 0) then {
		_blur ppEffectAdjust [2.2 * _visionIntensity];
		_blur ppEffectCommit 0.1;
		_flash ppEffectAdjust [1,1,0,[1,1,1,0.75 * _visionIntensity],[1,1,1,1],[0.299,0.587,0.114,0],[0,0,0,0,0,0,4]];
		_flash ppEffectCommit 0.1;
	} else {
		_blur ppEffectAdjust [0];
		_blur ppEffectCommit 0.2;
		_flash ppEffectAdjust [1,1,0,[0,0,0,0],[1,1,1,1],[0.299,0.587,0.114,0],[0,0,0,0,0,0,4]];
		_flash ppEffectCommit 0.2;
		["grenade_blur",false,false] call pp_setEnable;
		["grenade_flash",false,false] call pp_setEnable;
	};
};

grenadefx_onExplosion = {
	params ["_origin","_intensity"];
	_intensity = clamp(_intensity,0,1);
	private _now = tickTime;
	private _remainingHearing = grenadefx_hearingBase * (((grenadefx_hearingEnd - _now) max 0) / grenadefx_effectDuration);
	grenadefx_hearingBase = _remainingHearing max _intensity;
	grenadefx_hearingEnd = _now + grenadefx_effectDuration;

	if ([_origin] call grenadefx_isExplosionVisible) then {
		private _remainingVision = grenadefx_visionBase * (((grenadefx_visionEnd - _now) max 0) / grenadefx_effectDuration);
		grenadefx_visionBase = _remainingVision max _intensity;
		grenadefx_visionEnd = _now + grenadefx_effectDuration;
		["grenade_blur",true,false] call pp_setEnable;
		["grenade_flash",true,false] call pp_setEnable;
	};

	if (grenadefx_tinnitusHandle != "0") then {
		grenadefx_tinnitusHandle call vs_audio_stopSound;
	};
	grenadefx_tinnitusHandle = [PATH_SOUND("effects\grenade_tinnitus"),1,0,0.65 * grenadefx_hearingBase,false] call vs_audio_playSound2d;
	[0.22 * _intensity,25 * _intensity,0.04,0.8 + _intensity] call cam_addCamShake;
};

decl(int) grenadefx_updateHandle = startUpdate(grenadefx_update,0.1);

rpcAdd("grenade_concussion",grenadefx_onExplosion);
