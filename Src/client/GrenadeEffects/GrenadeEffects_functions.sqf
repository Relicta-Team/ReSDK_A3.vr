// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

grenadefx_getRemainingIntensity = {
	params ["_base","_end","_duration",["_now",tickTime]];
	if (_now >= _end) exitWith {0};
	_base * ((_end - _now) / _duration)
};

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

grenadefx_resetAfterimage = {
	private _effect = getPPVar("grenade_afterimage");
	if !(ppEffectEnabled _effect) exitWith {};
	_effect ppEffectAdjust [1,1,0,[0,0,0,0],[1,1,1,1],[0.299,0.587,0.114,0]];
	_effect ppEffectCommit 0;
	["grenade_afterimage",false,false] call pp_setEnable;
};

grenadefx_updateAfterimage = {
	params ["_intensity"];
	if (_intensity <= 0) exitWith {
		call grenadefx_resetAfterimage;
	};

	// Loss of dark adaptation is represented by a washed-out image. Brightness
	// and offset never fall below neutral, while contrast decreases. The blend
	// channel remains disabled so the effect cannot recover through a dark frame.
	private _brightness = 1 + (0.35 * _intensity);
	private _contrast = 1 - (0.45 * _intensity);
	private _offset = 0.2 * _intensity;
	private _effect = getPPVar("grenade_afterimage");
	_effect ppEffectAdjust [_brightness,_contrast,_offset,[0,0,0,0],[1,1,1,1],[0.299,0.587,0.114,0]];
	_effect ppEffectCommit 0.1;
};

grenadefx_update = {
	private _now = tickTime;
	grenadefx_hearingIntensity = [
		grenadefx_hearingBase,
		grenadefx_hearingEnd,
		grenadefx_hearingDuration,
		_now
	] call grenadefx_getRemainingIntensity;
	private _afterimageIntensity = [
		grenadefx_afterimageBase,
		grenadefx_afterimageEnd,
		grenadefx_afterimageDuration,
		_now
	] call grenadefx_getRemainingIntensity;
	[_afterimageIntensity] call grenadefx_updateAfterimage;
};

grenadefx_startHearingEffect = {
	params ["_intensity","_now"];
	private _remaining = [
		grenadefx_hearingBase,
		grenadefx_hearingEnd,
		grenadefx_hearingDuration,
		_now
	] call grenadefx_getRemainingIntensity;
	grenadefx_hearingBase = _remaining max _intensity;
	grenadefx_hearingEnd = _now + grenadefx_hearingDuration;

	if (grenadefx_tinnitusHandle != "0") then {
		grenadefx_tinnitusHandle call vs_audio_stopSound;
	};
	grenadefx_tinnitusHandle = [
		PATH_SOUND("effects\grenade_tinnitus"),
		1,
		0,
		0.65 * grenadefx_hearingBase,
		false
	] call vs_audio_playSound2d;
};

grenadefx_startAfterimage = {
	params ["_intensity","_now"];
	private _remaining = [
		grenadefx_afterimageBase,
		grenadefx_afterimageEnd,
		grenadefx_afterimageDuration,
		_now
	] call grenadefx_getRemainingIntensity;
	if (_intensity < _remaining) exitWith {};

	grenadefx_afterimageDuration = linearConversion [
		0.05,
		1,
		_intensity,
		grenadefx_afterimageMinDuration,
		grenadefx_afterimageMaxDuration,
		true
	];
	grenadefx_afterimageBase = _intensity;
	grenadefx_afterimageEnd = _now + grenadefx_afterimageDuration;
	["grenade_afterimage",true,false] call pp_setEnable;
};

grenadefx_onExplosion = {
	params ["_origin","_intensity"];
	_intensity = clamp(_intensity,0,1);
	private _now = tickTime;
	[_intensity,_now] call grenadefx_startHearingEffect;
	if ([_origin] call grenadefx_isExplosionVisible) then {
		[_intensity,_now] call grenadefx_startAfterimage;
	};
	[0.22 * _intensity,25 * _intensity,0.04,0.8 + _intensity] call cam_addCamShake;
};
