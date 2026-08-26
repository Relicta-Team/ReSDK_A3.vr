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
#ifdef DEBUG
if !isNullVar(grenadefx_debugDrawHandles) then {
	{removeMissionEventHandler ["Draw3D",_x]} foreach grenadefx_debugDrawHandles;
};
#endif

decl(float) grenadefx_hearingIntensity = 0;
decl(float) grenadefx_hearingBase = 0;
decl(float) grenadefx_hearingEnd = 0;
decl(float) grenadefx_blurBase = 0;
decl(float) grenadefx_blurEnd = 0;
decl(float) grenadefx_flashBase = 0;
decl(float) grenadefx_flashEnd = 0;
decl(string) grenadefx_tinnitusHandle = "0";
decl(float) grenadefx_hearingDuration = 60;
decl(float) grenadefx_blurDuration = 60;
decl(float) grenadefx_flashDuration = 10;
#ifdef DEBUG
decl(any[]) grenadefx_debugDrawHandles = [];
#endif

grenadefx_isExplosionVisible = {
	params ["_origin"];
	if (count (worldToScreen _origin) == 0) exitWith {false};
	private _hits = lineIntersectsSurfaces [
		AGLToASL positionCameraToWorld [0,0,0],
		AGLToASL _origin,
		player,
		cameraOn,
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
		grenadefx_hearingBase * ((grenadefx_hearingEnd - _now) / grenadefx_hearingDuration),
		0
	);
	private _blurIntensity = ifcheck(
		_now < grenadefx_blurEnd,
		grenadefx_blurBase * ((grenadefx_blurEnd - _now) / grenadefx_blurDuration),
		0
	);
	private _flashIntensity = ifcheck(
		_now < grenadefx_flashEnd,
		grenadefx_flashBase * ((grenadefx_flashEnd - _now) / grenadefx_flashDuration),
		0
	);

	private _blur = getPPVar("grenade_blur");
	private _flash = getPPVar("grenade_flash");
	if (_blurIntensity > 0) then {
		_blur ppEffectAdjust [2.2 * _blurIntensity];
		_blur ppEffectCommit 0.1;
	} else {
		_blur ppEffectAdjust [0];
		_blur ppEffectCommit 0.2;
		["grenade_blur",false,false] call pp_setEnable;
	};
	if (_flashIntensity > 0) then {
		_flash ppEffectAdjust [1,1,0,[1,1,1,0.75 * _flashIntensity],[1,1,1,1],[0.299,0.587,0.114,0],[0,0,0,0,0,0,4]];
		_flash ppEffectCommit 0.1;
	} else {
		_flash ppEffectAdjust [1,1,0,[0,0,0,0],[1,1,1,1],[0.299,0.587,0.114,0],[0,0,0,0,0,0,4]];
		_flash ppEffectCommit 0.2;
		["grenade_flash",false,false] call pp_setEnable;
	};
};

grenadefx_onExplosion = {
	params ["_origin","_intensity"];
	_intensity = clamp(_intensity,0,1);
	private _now = tickTime;
	private _remainingHearing = grenadefx_hearingBase * (((grenadefx_hearingEnd - _now) max 0) / grenadefx_hearingDuration);
	grenadefx_hearingBase = _remainingHearing max _intensity;
	grenadefx_hearingEnd = _now + grenadefx_hearingDuration;

	if ([_origin] call grenadefx_isExplosionVisible) then {
		private _remainingBlur = grenadefx_blurBase * (((grenadefx_blurEnd - _now) max 0) / grenadefx_blurDuration);
		private _remainingFlash = grenadefx_flashBase * (((grenadefx_flashEnd - _now) max 0) / grenadefx_flashDuration);
		grenadefx_blurBase = _remainingBlur max _intensity;
		grenadefx_blurEnd = _now + grenadefx_blurDuration;
		grenadefx_flashBase = _remainingFlash max _intensity;
		grenadefx_flashEnd = _now + grenadefx_flashDuration;
		["grenade_blur",true,false] call pp_setEnable;
		["grenade_flash",true,false] call pp_setEnable;
	};

	if (grenadefx_tinnitusHandle != "0") then {
		grenadefx_tinnitusHandle call vs_audio_stopSound;
	};
	grenadefx_tinnitusHandle = [PATH_SOUND("effects\grenade_tinnitus"),1,0,0.65 * grenadefx_hearingBase,false] call vs_audio_playSound2d;
	[0.22 * _intensity,25 * _intensity,0.04,0.8 + _intensity] call cam_addCamShake;
};

#ifdef DEBUG
grenadefx_onDebugExplosion = {
	params ["_origin","_blastRadius","_rays"];
	private _handle = addMissionEventHandler ["Draw3D",{
		_thisArgs params ["_origin","_blastRadius","_rays","_expiresAt"];
		if (tickTime >= _expiresAt) exitWith {
			removeMissionEventHandler ["Draw3D",_thisEventHandler];
		};
		[_origin,[1,0.15,0,0.35],2,_blastRadius,16] call debug_drawSphereEx;
		{
			_x params ["_start","_end","_color"];
			drawLine3D [_start,_end,_color,2];
		} foreach _rays;
	},[_origin,_blastRadius,_rays,tickTime + 12]];
	grenadefx_debugDrawHandles pushBack _handle;
};
#endif

decl(int) grenadefx_updateHandle = startUpdate(grenadefx_update,0.1);

rpcAdd("grenade_concussion",grenadefx_onExplosion);
#ifdef DEBUG
rpcAdd("grenade_debug",grenadefx_onDebugExplosion);
#endif
