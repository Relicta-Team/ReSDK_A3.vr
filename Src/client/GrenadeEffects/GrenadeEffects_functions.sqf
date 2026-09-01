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

grenadefx_resetHearingEffect = {
	grenadefx_hearingIntensity = 0;
	grenadefx_hearingBase = 0;
	grenadefx_hearingStart = 0;
	grenadefx_hearingEnd = 0;
	if (grenadefx_tinnitusHandle != "0") then {
		grenadefx_tinnitusHandle call vs_audio_stopSound;
		grenadefx_tinnitusHandle = "0";
	};
};

grenadefx_getHearingIntensity = {
	params ["_now"];
	if (_now >= grenadefx_hearingEnd) exitWith {0};
	private _elapsed = _now - grenadefx_hearingStart;
	if (_elapsed <= grenadefx_hearingSteadyDuration) exitWith {
		grenadefx_hearingBase
	};
	grenadefx_hearingBase * linearConversion [
		grenadefx_hearingSteadyDuration,
		grenadefx_hearingDuration,
		_elapsed,
		1,
		0,
		true
	]
};

grenadefx_resetAfterimage = {
	grenadefx_afterimageBase = 0;
	grenadefx_afterimageEnd = 0;
	private _effect = getPPVar("grenade_afterimage");
	if !(ppEffectEnabled _effect) exitWith {};
	_effect ppEffectAdjust [0];
	_effect ppEffectCommit 0;
	["grenade_afterimage",false,false] call pp_setEnable;
};

grenadefx_startAfterimageFade = {
	params ["_intensity","_duration"];
	if (_intensity <= 0) exitWith {
		call grenadefx_resetAfterimage;
	};

	private _effect = getPPVar("grenade_afterimage");
	_effect ppEffectAdjust [grenadefx_afterimageMaxBlur * _intensity];
	_effect ppEffectCommit 0;
	_effect ppEffectAdjust [0];
	_effect ppEffectCommit _duration;
};

grenadefx_update = {
	private _now = tickTime;
	if (grenadefx_hearingEnd > 0) then {
		if (_now >= grenadefx_hearingEnd) then {
			call grenadefx_resetHearingEffect;
		} else {
			grenadefx_hearingIntensity = [_now] call grenadefx_getHearingIntensity;
		};
	};
	if (grenadefx_afterimageEnd > 0 && {_now >= grenadefx_afterimageEnd}) then {
		call grenadefx_resetAfterimage;
	};
};

grenadefx_startHearingEffect = {
	params ["_intensity","_now"];
	private _remaining = [_now] call grenadefx_getHearingIntensity;
	grenadefx_hearingBase = _remaining max _intensity;
	grenadefx_hearingIntensity = grenadefx_hearingBase;
	grenadefx_hearingStart = _now;
	grenadefx_hearingEnd = _now + grenadefx_hearingDuration;

	if (grenadefx_tinnitusHandle != "0") then {
		grenadefx_tinnitusHandle call vs_audio_stopSound;
	};
	grenadefx_tinnitusHandle = [
		PATH_SOUND("effects\grenade_tinnitus"),
		1,
		0,
		grenadefx_tinnitusVolume * grenadefx_hearingBase,
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
	[_intensity,grenadefx_afterimageDuration] call grenadefx_startAfterimageFade;
};

grenadefx_onExplosion = {
	params ["_origin","_intensity"];
	_intensity = clamp(_intensity,0,1);
	private _now = tickTime;
	[_intensity,_now] call grenadefx_startHearingEffect;
	if ([_origin] call grenadefx_isExplosionVisible) then {
		[_intensity,_now] call grenadefx_startAfterimage;
	};
};
