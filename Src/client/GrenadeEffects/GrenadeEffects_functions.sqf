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

grenadefx_resetDarkAdaptation = {
	grenadefx_darkAdaptationBase = 0;
	grenadefx_darkAdaptationEnd = 0;
	private _effect = getPPVar("grenade_dark_adaptation");
	if !(ppEffectEnabled _effect) exitWith {};
	_effect ppEffectAdjust [1,1,0,[0,0,0,0],[1,1,1,1],[0.299,0.587,0.114,0]];
	_effect ppEffectCommit 0;
	["grenade_dark_adaptation",false,false] call pp_setEnable;
};

grenadefx_startDarkAdaptationTransition = {
	params ["_intensity","_duration"];
	if (_intensity <= 0) exitWith {
		call grenadefx_resetDarkAdaptation;
	};

	private _strength = grenadefx_darkAdaptationStrength * _intensity;
	private _brightness = 1 - (0.35 * _strength);
	private _contrast = 1 + (0.45 * _strength);
	private _offset = -0.2 * _strength;
	private _effect = getPPVar("grenade_dark_adaptation");
	["grenade_dark_adaptation",true,false] call pp_setEnable;

	// The loss of adaptation is immediate. Recovery is one uninterrupted engine
	// transition; recommitting it from the update loop caused visible cycling.
	_effect ppEffectAdjust [_brightness,_contrast,_offset,[0,0,0,0],[1,1,1,1],[0.299,0.587,0.114,0]];
	_effect ppEffectCommit 0;
	_effect ppEffectAdjust [1,1,0,[0,0,0,0],[1,1,1,1],[0.299,0.587,0.114,0]];
	_effect ppEffectCommit _duration;
};

grenadefx_resetAfterimage = {
	private _effect = getPPVar("grenade_afterimage");
	if !(ppEffectEnabled _effect) exitWith {};
	_effect ppEffectAdjust [0];
	_effect ppEffectCommit 0;
	["grenade_afterimage",false,false] call pp_setEnable;
};

// Dynamic blur is deliberately emitted in short pulses. This gives a broken,
// afterimage-like loss of visual continuity without chromatic aberration.
grenadefx_updateAfterimage = {
	params ["_intensity","_now"];
	if (_intensity <= 0) exitWith {
		call grenadefx_resetAfterimage;
	};
	private _phase = _now % grenadefx_afterimagePulsePeriod;
	private _pulse = ifcheck(_phase < grenadefx_afterimagePulseLength,1,grenadefx_afterimageResidual);
	private _effect = getPPVar("grenade_afterimage");
	_effect ppEffectAdjust [grenadefx_afterimageMaxBlur * _intensity * _pulse];
	_effect ppEffectCommit 0.08;
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
	if (grenadefx_darkAdaptationEnd > 0 && {_now >= grenadefx_darkAdaptationEnd}) then {
		call grenadefx_resetDarkAdaptation;
	};
	[_afterimageIntensity,_now] call grenadefx_updateAfterimage;
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

grenadefx_startDarkAdaptation = {
	params ["_intensity","_now"];
	private _remaining = [
		grenadefx_darkAdaptationBase,
		grenadefx_darkAdaptationEnd,
		grenadefx_darkAdaptationDuration,
		_now
	] call grenadefx_getRemainingIntensity;
	if (_intensity < _remaining) exitWith {};

	grenadefx_darkAdaptationDuration = linearConversion [
		0.05,
		1,
		_intensity,
		grenadefx_darkAdaptationMinDuration,
		grenadefx_darkAdaptationMaxDuration,
		true
	];
	grenadefx_darkAdaptationBase = _intensity;
	grenadefx_darkAdaptationEnd = _now + grenadefx_darkAdaptationDuration;
	[_intensity,grenadefx_darkAdaptationDuration] call grenadefx_startDarkAdaptationTransition;
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
		[_intensity,_now] call grenadefx_startDarkAdaptation;
		[_intensity,_now] call grenadefx_startAfterimage;
	};
};
