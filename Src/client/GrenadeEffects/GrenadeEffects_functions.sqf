// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

// Compatibility for developer hot-reloads from builds that still owned the
// removed screen effects. Production clients start without this legacy state.
grenadefx_cleanupLegacyVisualState = {
	if (!isNullVar(grenadefx_darkAdaptationOverlay) && {!isNullReference(grenadefx_darkAdaptationOverlay)}) then {
		[grenadefx_darkAdaptationOverlay] call deleteWidget;
	};
	private _obsoleteAfterimage = getPPVar("grenade_afterimage");
	if !isNullVar(_obsoleteAfterimage) then {
		_obsoleteAfterimage ppEffectAdjust [0];
		_obsoleteAfterimage ppEffectCommit 0;
		_obsoleteAfterimage ppEffectEnable false;
	};
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

grenadefx_update = {
	private _now = tickTime;
	if (grenadefx_hearingEnd > 0) then {
		if (_now >= grenadefx_hearingEnd) then {
			call grenadefx_resetHearingEffect;
		} else {
			grenadefx_hearingIntensity = [_now] call grenadefx_getHearingIntensity;
		};
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
	// One playback per explosion; duration is fixed, independent of distance.
	grenadefx_tinnitusHandle = [
		PATH_SOUND("effects\grenade_tinnitus"),
		1,
		0,
		clamp(grenadefx_tinnitusVolume * grenadefx_hearingBase,0,2),
		false,
		false
	] call vs_audio_playSound2d;
};

grenadefx_onExplosion = {
	params ["_origin","_intensity"];
	_intensity = clamp(_intensity,0,1);
	private _now = tickTime;
	[_intensity,_now] call grenadefx_startHearingEffect;
};
