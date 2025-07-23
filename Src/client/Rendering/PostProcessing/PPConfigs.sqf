// ======================================================
// Copyright (c) 2017-2025 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\..\host\engine.hpp>
#include <..\..\..\host\struct.hpp>

struct(PPDefaultColor) base(PPColorCorrections)
    //used from ppdefines color_default
    def(brightness) 1;
    def(contrast) 1;
    def(offset) 0;
    def(blend) [0,-0.01,0.08,-0.1];
    def(colorize) [0.68,1,1.55,0.73];
    def(desaturate) [0.33,0.33,0.33,0];
    def(radialMajorAxisRadius) 0;
    def(radialMinorAxisRadius) 0;
    def(radialRotationDeg) 0;
    def(radialCenterX) 0;
    def(radialCenterY) 0;
    def(radialInnerRadiusCoef) 0;
    def(radialInterpCoef) 4;
endstruct

struct(PPGrainDefault) base(PPFilmGrain)
    def(intensity) 0.12;
    def(sharpness) 0.91;
    def(grainSize) 1.44;
    def(intensityX0) 0.36;
    def(intensityX1) 0.36;
    def(monochromatic) true;
endstruct

struct(PPEaterNightvisionColor) base(PPColorInversion)
    def(red) 0.07;
    def(green) 0.02;
    def(blue) 0;
endstruct

struct(PPGhostColor) base(PPColorCorrections)
    def(brightness) 1;
    def(contrast) 0.35;
    def(offset) 0.05;
    def(blend) [2,2,2,-0.13];
    def(colorize) [2,2,2,0.23];
    def(desaturate) [1,1,1,0.04];
    def(radialMajorAxisRadius) 0;
    def(radialMinorAxisRadius) 0;
    def(radialRotationDeg) 0;
    def(radialCenterX) 0;
    def(radialCenterY) 0;
    def(radialInnerRadiusCoef) 0;
    def(radialInterpCoef) 4;
endstruct

struct(PPGhostColorOverlay) base(PPColorCorrections)
    def(brightness) 1;
    def(contrast) 1;
    def(offset) 0;
    def(blend) [-1,-1,-1,0.39];
    def(colorize) [1,1,1,1];
    def(desaturate) [0.33,0.33,0.33,0];
    def(radialMajorAxisRadius) 0.82;
    def(radialMinorAxisRadius) 0.65;
    def(radialRotationDeg) -0.11;
    def(radialCenterX) 0;
    def(radialCenterY) 0;
    def(radialInnerRadiusCoef) 0;
    def(radialInterpCoef) 4.5;
endstruct

struct(PPGhostGrain) base(PPFilmGrain)
    def(intensity) 0.1;
    def(sharpness) 0.49;
    def(grainSize) 1.89;
    def(intensityX0) 0.81;
    def(intensityX1) 0.18;
    def(monochromatic) true;
endstruct

struct(PPPain) base(PPChromAberration)
/*
// Оригинальный кастомный update-код из PPDefines.sqf:
decl(int) pp_pain_lvl = 0;
decl(float) pp_pain_nextGlobal = 0;
decl(float) pp_pain_nextTime = 0;
decl(bool) pp_pain_isLocked = false;
decl(bool) pp_pain_isProgressed = false;
decl(float) pp_pain_timing = 2;
["pain","ChromAberration",[0,0,true],null,{
	if (pp_pain_lvl==0)exitWith{
		if (pp_pain_isLocked || pp_pain_isProgressed) then {
			pp_pain_isLocked = false;
			pp_pain_isProgressed = false;
			setThisEffect [0,0,true];
			setThisEffectCommit 2;
		};
	};
	
	pp_pain_timing = linearConversion [0,20,pp_pain_lvl,0.05,2.55,true];
	if (tickTime >= pp_pain_nextTime) then {
		
		if (pp_pain_isProgressed) then {
			setThisEffect [0,0,true];
			setThisEffectCommit pp_pain_timing;
			
			
			pp_pain_nextTime = tickTime + pp_pain_timing;
			pp_pain_isLocked = true;
			pp_pain_isProgressed = false;
			_mTime = linearConversion [0, 20, pp_pain_lvl, 10, 2, true];
			pp_pain_nextGlobal = tickTime + randInt(1,_mTime) + pp_pain_timing;
		} else {
			if (tickTime >= pp_pain_nextGlobal) then {
				pp_pain_isLocked = false;
			};
			
		};

	};
	if (pp_pain_isLocked) exitWith {};
	
	_newValue = linearConversion [0, 20, pp_pain_lvl, 0, 0.6, true];
	setThisEffect [_newValue,_newValue,true];
	setThisEffectCommit pp_pain_timing;
	
	if prob(60) then {
		[0.23,10, linearConversion [0.05*2,2.55*2,pp_pain_timing*2,0.85,0.02,true],pp_pain_timing*2]call cam_addCamShake;
	};
	
	pp_pain_nextTime = tickTime + pp_pain_timing;
	pp_pain_isLocked = true;
	pp_pain_isProgressed = true;
},null,{
	pp_pain_lvl = 0;
	
	pp_pain_nextGlobal = 0;
	pp_pain_nextTime = 0;
	pp_pain_isLocked = false;
	pp_pain_isProgressed = false;
	pp_pain_timing = 2;
}] call pp_init_active;
*/
    def(aberrationPowerX) 0;
    def(aberrationPowerY) 0;
    def(aspectCorrection) true;
endstruct

struct(PPAgony) base(PPChromAberration)
/*
// Оригинальный кастомный update-код из PPDefines.sqf:
decl(any[]) pp_agony_data = [false,0];
["agony","ChromAberration",[0,0,true],null,{
	if (!(pp_agony_data select 0)) exitWith {};
	pp_agony_data set [0,false];
	_t = pp_agony_data select 1;
	
	[0.01,25, 0.03,_t+2] call cam_addCamShake;
	
	setThisEffect [randInt(0.1,3),randInt(0.1,3),true];
	setThisEffectCommit 0.3;
	
	deferred {
		unpackParams();
		
		//[0.01,30, 0.7,(pp_agony_data select 1)*2.8/3] call cam_addCamShake;
		setThisEffect [0,0,true];
		setThisEffectCommit (pp_agony_data select 1)*2.8/3;
	} doInvokeParams(0.3,packParams());
	
},null,{
	pp_agony_data = [false,0];
}] call pp_init_active;
*/
    def(aberrationPowerX) 0;
    def(aberrationPowerY) 0;
    def(aspectCorrection) true;
endstruct

struct(PPAlcoholIntox) base(PPWetDistortion)
/*
// Оригинальный кастомный update-код из PPDefines.sqf:
decl(float) pp_alc_amount = 0;
["alcohol_intox","WetDistortion",[0,0.1,0.1,-3.69,3.09,3.09,-2.74,0.05,0.01,0.05,0.01,0,0,0.23,0.1],null,{
	
	_lcv1 = linearConversion[0,60,pp_alc_amount,0,2,true];
	_lcv2 = linearConversion[0,60,pp_alc_amount,0,0.9,true];
	setThisEffect [0,_lcv1,_lcv1,-3.69,3.09,3.09,-2.74,0.05,0.01,0.05,0.01,0,0,_lcv2,_lcv2];
	setThisEffectCommit 0.5;
	
},1,{
	pp_alc_amount = 0;
}] call pp_init_active;
*/
    def(value) 0;
    def(top) 0.1;
    def(bottom) 0.1;
    def(horizontal1) -3.69;
    def(horizontal2) 3.09;
    def(vertical1) 3.09;
    def(vertical2) -2.74;
    def(horizontal1Amplitude) 0.05;
    def(horizontal2Amplitude) 0.01;
    def(vertical1Amplitude) 0.05;
    def(vertical2Amplitude) 0.01;
    def(randX) 0;
    def(randY) 0;
    def(posX) 0.23;
    def(posY) 0.1;
endstruct