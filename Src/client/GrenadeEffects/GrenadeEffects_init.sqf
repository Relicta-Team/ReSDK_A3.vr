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
if !isNullVar(grenadefx_debugObjects) then {
	{deleteVehicle _x} foreach grenadefx_debugObjects;
};
#endif

decl(float) grenadefx_hearingIntensity = 0;
decl(float) grenadefx_hearingBase = 0;
decl(float) grenadefx_hearingEnd = 0;
decl(float) grenadefx_blurBase = 0;
decl(float) grenadefx_blurEnd = 0;
decl(float) grenadefx_blurDuration = 5;
decl(float) grenadefx_flashBase = 0;
decl(float) grenadefx_flashEnd = 0;
decl(float) grenadefx_flashDuration = 2.5;
decl(string) grenadefx_tinnitusHandle = "0";
decl(float) grenadefx_hearingDuration = 60;
decl(float) grenadefx_blurMinDuration = 5;
decl(float) grenadefx_blurMaxDuration = 60;
decl(float) grenadefx_flashMinDuration = 2.5;
decl(float) grenadefx_flashMaxDuration = 30;
#ifdef DEBUG
decl(mesh[]) grenadefx_debugObjects = [];
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
		if (ppEffectEnabled _blur) then {
			_blur ppEffectAdjust [0];
			_blur ppEffectCommit 0;
			["grenade_blur",false,false] call pp_setEnable;
		};
	};
	if (_flashIntensity > 0) then {
		_flash ppEffectAdjust [1,1,0,[1,1,1,0.75 * _flashIntensity],[1,1,1,1],[0.299,0.587,0.114,0]];
		_flash ppEffectCommit 0.1;
	} else {
		if (ppEffectEnabled _flash) then {
			// Restore the documented neutral ColorCorrections state immediately
			// before disabling it. A pending neutral commit can leave the scene
			// black while emissive point lights remain visible.
			_flash ppEffectAdjust [1,1,0,[0,0,0,0],[1,1,1,1],[0.299,0.587,0.114,0]];
			_flash ppEffectCommit 0;
			["grenade_flash",false,false] call pp_setEnable;
		};
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
		if (_intensity >= _remainingBlur) then {
			grenadefx_blurDuration = linearConversion [0.05,1,_intensity,grenadefx_blurMinDuration,grenadefx_blurMaxDuration,true];
			grenadefx_blurBase = _intensity;
			grenadefx_blurEnd = _now + grenadefx_blurDuration;
		};
		if (_intensity >= _remainingFlash) then {
			grenadefx_flashDuration = linearConversion [0.05,1,_intensity,grenadefx_flashMinDuration,grenadefx_flashMaxDuration,true];
			grenadefx_flashBase = _intensity;
			grenadefx_flashEnd = _now + grenadefx_flashDuration;
		};
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
grenadefx_createDebugMarker = {
	params ["_pos","_color",["_scale",1]];
	private _marker = "Sign_Sphere10cm_F" createVehicleLocal [0,0,0];
	_marker enableSimulation false;
	_marker setPhysicsCollisionFlag false;
	_marker setPosATL _pos;
	_marker setObjectTexture [0,format[
		"#(argb,8,8,3)color(%1,%2,%3,%4,co)",
		_color select 0,
		_color select 1,
		_color select 2,
		_color select 3
	]];
	_marker setObjectScale _scale;
	_marker
};

grenadefx_deleteDebugObjects = {
	params ["_objects"];
	{deleteVehicle _x} foreach _objects;
	grenadefx_debugObjects = grenadefx_debugObjects - _objects;
};

grenadefx_onDebugExplosion = {
	params ["_origin","_blastRadius","_rays"];
	private _objects = [];
	private _blastColor = [1,0.15,0,0.85];
	_objects pushBack ([_origin,[1,1,1,1],4] call grenadefx_createDebugMarker);

	// Three beaded great circles use the same model-marker idiom as the existing
	// ray-debug tools and show the blast radius from inside and outside the zone.
	private _angle = 0;
	for "_i" from 0 to 23 do {
		_angle = _i * 15;
		_objects pushBack ([_origin vectorAdd [_blastRadius * cos _angle,_blastRadius * sin _angle,0],_blastColor,1.8] call grenadefx_createDebugMarker);
		_objects pushBack ([_origin vectorAdd [_blastRadius * cos _angle,0,_blastRadius * sin _angle],_blastColor,1.8] call grenadefx_createDebugMarker);
		_objects pushBack ([_origin vectorAdd [0,_blastRadius * cos _angle,_blastRadius * sin _angle],_blastColor,1.8] call grenadefx_createDebugMarker);
	};

	private _rayLength = 0;
	private _rayDirection = [0,0,0];
	private _offset = 0;
	{
		_x params ["_start","_end","_color"];
		_rayLength = _start distance _end;
		if (_rayLength < 0.01) then {continue};
		_rayDirection = vectorNormalized (_end vectorDiff _start);
		for "_step" from 0 to ceil _rayLength do {
			_offset = (_step min _rayLength);
			_objects pushBack ([_start vectorAdd (_rayDirection vectorMultiply _offset),_color,1.25] call grenadefx_createDebugMarker);
		};
		_objects pushBack ([_end,_color,2.5] call grenadefx_createDebugMarker);
	} foreach _rays;

	grenadefx_debugObjects append _objects;
	invokeAfterDelayParams(grenadefx_deleteDebugObjects,12,[_objects]);
};
#endif

decl(int) grenadefx_updateHandle = startUpdate(grenadefx_update,0.1);

rpcAdd("grenade_concussion",grenadefx_onExplosion);
#ifdef DEBUG
rpcAdd("grenade_debug",grenadefx_onDebugExplosion);
#endif
