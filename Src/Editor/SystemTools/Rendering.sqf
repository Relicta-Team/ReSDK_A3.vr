// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================


init_function(rendering_initialization)
{
	0 setovercast 0;
	setDate [1985,5,20,12,0];

	if (call rendering_isInGameHDREnabled) then {
		false call rendering_setInGameHDR;
	}
}

function(rendering_isNightEnabled) {(date select 3) == 0}

function(rendering_setNight)
{
	//Есть BIS_fnc_3DENIntel в котором встроенная смена даты
	
	//if equals(_this,call rendering_isNightEnabled) exitwith {false};
	if (_this) then {
		skipTime -12;
	} else {
		skipTime 12;
	};
	true
}

function(rendering_isInGameHDREnabled) {apertureParams select 8}

function(rendering_setInGameHDR)
{
	if (_this) then {
		setApertureNew [6,30,20,200]
	} else {
		setAperture -1;
	}
}