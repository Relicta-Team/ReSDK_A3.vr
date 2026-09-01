// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\..\host\lang.hpp>

namespace(Rendering.PostProcess.Effects,pp_)

//old rlct set: [0.96,0.9,-0.02,[0,0.19,0.05,0.14],[1.64,1.43,0.82,0.79],[-0.17,1.09,1.26,0.56],[0,0,0,0,0,0,4]],[0.2]

//cfg gppe: 
//[[false,100,[0.05,0.05,0.3,0.3]],[false,200,[0.05,0.05,true]],[false,300,[1,0.2,0.2,1,1,1,1,0.05,0.01,0.05,0.01,0.1,0.1,0.2,0.2]],[true,1500,[1,1,0,[0,-0.01,0.08,-0.7],[0.68,1,2.33,0.73],[0.33,0.33,0.33,0],[0,0,0,0,0,0,4]]],[false,500,[1]],[false,2000,[0.2,1,1,0.5,0.5,true]],[false,2500,[1,1,1]]]

//new for tests
//[[false,100,[0.05,0.05,0.3,0.3]],[false,200,[0.05,0.05,true]],[false,300,[1,0.2,0.2,1,1,1,1,0.05,0.01,0.05,0.01,0.1,0.1,0.2,0.2]],[true,1500,[1,1,0,[0,-0.01,0.08,-0.1],[0.68,1,1.55,0.73],[0.33,0.33,0.33,0],[0,0,0,0,0,0,4]]],[false,500,[1]],[false,2000,[0.2,1,1,0.5,0.5,true]],[false,2500,[1,1,1]]]
["color_default","ColorCorrections",[1,1,0,[0,-0.01,0.08,-0.1],[0.68,1,1.55,0.73],[0.33,0.33,0.33,0],[0,0,0,0,0,0,4]],[0.2],{
	// _state = __args select 0;
	// INC(_state);
	// if (_state >= 3) then {
	// 	_state = 0;
	// };

	// getPPVar(__EFFECT_NAME) setEffect [0.96,0.9,-0.02,[0,0.19,0.05,0.14],[1.64 + _state,1.43 + _state,0.82 + _state,0.79],[-0.17,1.09,1.26,0.56],[0,0,0,0,0,0,4]];

	// __args set [0,_state];
}] call pp_init;
["grain_default","FilmGrain",[0.12,0.91,1.44,0.36,0.36,true],null,{

}] call pp_init;

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

["eater_nightvision_color","ColorInversion",[0.07,0.02,0]] call pp_init;

["ghost_color","ColorCorrections",[1,0.35,0.05,[2,2,2,-0.13],[2,2,2,0.23],[1,1,1,0.04],[0,0,0,0,0,0,4]]] call pp_init;
["ghost_color_overlay","ColorCorrections",[1,1,0,[-1,-1,-1,0.39],[1,1,1,1],[0.33,0.33,0.33,0],[0.82,0.65,-0.11,0,0,0,4.5]]] call pp_init;
["ghost_grain","FilmGrain",[0.1,0.49,1.89,0.81,0.18,true]] call pp_init;

//alco pp_alc_amount
decl(float) pp_alc_amount = 0;
["alcohol_intox","WetDistortion",[0,0.1,0.1,-3.69,3.09,3.09,-2.74,0.05,0.01,0.05,0.01,0,0,0.23,0.1],null,{
	/*if (pp_alc_amount==0) exitWith {
		setThisEffect [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];
		setThisEffectCommit 0;
	};*/
	
	_lcv1 = linearConversion[0,60,pp_alc_amount,0,2,true];
	_lcv2 = linearConversion[0,60,pp_alc_amount,0,0.9,true];
	setThisEffect [0,_lcv1,_lcv1,-3.69,3.09,3.09,-2.74,0.05,0.01,0.05,0.01,0,0,_lcv2,_lcv2];
	setThisEffectCommit 0.5;
	
},1,{
	pp_alc_amount = 0;
}] call pp_init_active;


/*
PP_colorI = ppEffectCreate ["ColorInversion",2500];
PP_colorI ppEffectEnable true;
PP_colorI ppEffectAdjust [0.07,0.02,0];
PP_colorI ppEffectCommit 0;
*/

//now set on all needed effects
//["color_default",true] call pp_setEnable;
//["grain_default",true] call pp_setEnable;
