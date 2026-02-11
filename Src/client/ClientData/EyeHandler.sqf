// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include "..\..\host\lang.hpp"
namespace(ClientData,cd_)

decl(float)
cd_eyeState = 1; // 0 - ok; > 0 - closed

decl(bool())
cd_isEyesClosed = {cd_eyeState > 0};

decl(void(float;NULL|string))
cd_onChangeEyeState = {
	params ["_newState","_changeStateReason"];

	cd_eyeState = _newState;

	_fadeInTime = 0.05;
	_fadeOutTime = 0.5;


	if !isNullVar(_changeStateReason) then {
		call {
			#define check_state(str,action) if equals('str',_changeStateReason) exitWith {action}
			check_state(deunc,_fadeOutTime = rand(1.2,1.4));
			check_state(opneye,_fadeOutTime = rand(0.3,0.7));
			check_state(itmuneq,_fadeOutTime = rand(0.6,0.8));
			check_state(wkup,_fadeOutTime = rand(5.3,5.8));

			check_state(unc,_fadeInTime=rand(0.03,0.1));
			check_state(clseye,_fadeInTime=rand(0.1,0.3));
			check_state(itmeq,_fadeInTime=rand(0.1,0.2));
			check_state(losseyes,_fadeInTime=rand(0,0.01));
			check_state(slp,_fadeInTime=rand(0.9,1.5));

			check_state(load,_fadeOutTime=rand(1,2));
		}
	};

	if (cd_eyeState <= 0) then {
		if (hasEnabledBlackScreen) then {
			[false,_fadeOutTime] call setBlackScreenGUI;
		};
	} else {
		if (!hasEnabledBlackScreen) then {
			[true,_fadeInTime] call setBlackScreenGUI;
		};
	};
}; rpcAdd("onChangeEyeState",cd_onChangeEyeState);
