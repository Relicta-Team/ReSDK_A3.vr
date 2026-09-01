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

grenadefx_resetDarkAdaptation = {
	grenadefx_darkAdaptationBase = 0;
	grenadefx_darkAdaptationStart = 0;
	grenadefx_darkAdaptationEnd = 0;
	if isNullReference(grenadefx_darkAdaptationOverlay) exitWith {};
	widgetSetFade(grenadefx_darkAdaptationOverlay,1,0);
};

grenadefx_getDarkAdaptationIntensity = {
	params ["_now"];
	if (_now >= grenadefx_darkAdaptationEnd) exitWith {0};
	private _elapsed = _now - grenadefx_darkAdaptationStart;
	if (_elapsed <= grenadefx_darkAdaptationAttackDuration) exitWith {
		grenadefx_darkAdaptationBase * linearConversion [
			0,
			grenadefx_darkAdaptationAttackDuration,
			_elapsed,
			0,
			1,
			true
		]
	};
	if (_elapsed <= grenadefx_darkAdaptationHalfTime) exitWith {
		grenadefx_darkAdaptationBase * linearConversion [
			grenadefx_darkAdaptationAttackDuration,
			grenadefx_darkAdaptationHalfTime,
			_elapsed,
			1,
			0.5,
			true
		]
	};
	grenadefx_darkAdaptationBase * linearConversion [
		grenadefx_darkAdaptationHalfTime,
		grenadefx_darkAdaptationDuration,
		_elapsed,
		0.5,
		0,
		true
	]
};

grenadefx_updateDarkAdaptation = {
	params ["_now"];
	if isNullReference(grenadefx_darkAdaptationOverlay) exitWith {};
	private _intensity = [_now] call grenadefx_getDarkAdaptationIntensity;
	private _opacity = clamp(
		grenadefx_darkAdaptationMaxOpacity * grenadefx_darkAdaptationPeakIntensity * _intensity,
		0,
		grenadefx_darkAdaptationMaxOpacity * grenadefx_darkAdaptationPeakIntensity
	);
	widgetSetFade(grenadefx_darkAdaptationOverlay,1 - _opacity,0);
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
	if (grenadefx_darkAdaptationEnd > 0) then {
		if (_now >= grenadefx_darkAdaptationEnd) then {
			call grenadefx_resetDarkAdaptation;
		} else {
			[_now] call grenadefx_updateDarkAdaptation;
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

grenadefx_startDarkAdaptation = {
	params ["_intensity","_now"];
	private _remaining = [_now] call grenadefx_getDarkAdaptationIntensity;
	if (_intensity < _remaining) exitWith {};

	grenadefx_darkAdaptationBase = _intensity;
	grenadefx_darkAdaptationStart = _now;
	grenadefx_darkAdaptationEnd = _now + grenadefx_darkAdaptationDuration;
	[_now] call grenadefx_updateDarkAdaptation;
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
		[_intensity,_now] call grenadefx_startDarkAdaptation;
		[_intensity,_now] call grenadefx_startAfterimage;
	};
};
