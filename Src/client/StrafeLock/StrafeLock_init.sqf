// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\host\engine.hpp>
#include <..\..\host\text.hpp>
#include <..\ClientRpc\clientRpc.hpp>
#include <..\WidgetSystem\blockedButtons.hpp>

namespace(StrafeLock,strafeLock_)

macro_const(strafeLock_checkDelay)
#define STRAFELOCK_CHECKDELAY 2.4

//check with left and right buttons
macro_const(strafeLock_maximumPressCount)
#define STRAFELOCK_MAXPRESS 2

decl(void(bool))
strafeLock_setEnable = {
	params ["_mode"];
	if (_mode == (call strafeLock_isEnabled)) exitwith {};

	if (_mode) then {
		if (strafeLock_handleKeyUp == -1) then {
			strafeLock_handleKeyUp = (findDisplay 46) displayAddEventHandler ["KeyUp",strafeLock_onKeyUp];
		};
		strafeLock_handle = startUpdate(strafeLock_onUpdate,STRAFELOCK_CHECKDELAY);
	} else {
		stopUpdate(strafeLock_handle);
		strafeLock_handle = -1;
	};
}; rpcAdd("strafeLock",strafeLock_setEnable);

decl(bool())
strafeLock_isEnabled = { strafeLock_handle != -1 };

decl(int[])
strafeLock_lrButtonsCountPress = [0,0];
decl(int)
strafeLock_handleKeyUp = -1;
decl(int)
strafeLock_handle = -1;
decl(any[])
strafeLock_const_lrButtons = LEFT_MOVE_BUTTONS + RIGHT_MOVE_BUTTONS;
decl(bool)
strafeLock_catched = false;

decl(void())
strafeLock_onUpdate = {
	strafeLock_lrButtonsCountPress = [0,0];
	strafeLock_catched = false;
};

decl(void(display;int;bool;bool;bool))
strafeLock_onKeyUp = {
	params ["_d","_key","_shift","_ctrl","_alt"];
	if (call strafeLock_isEnabled) then {

		if (player call anim_isWalking) exitWith {};
		if (abs speed player == 0) exitWith {};

		if (_key in strafeLock_const_lrButtons) then {
			[_key in RIGHT_MOVE_BUTTONS] call strafeLock_incrementBackMovePress;
		};
	};
};

decl(void(int))
strafeLock_incrementBackMovePress = {
	params ["_sideIndex"];

	MODARR(strafeLock_lrButtonsCountPress,boolToInt(_sideIndex), + 1);

	call strafeLock_checkConditions;
};

decl(void())
strafeLock_checkConditions = {
	if (strafeLock_catched) exitWith {};

	if (
		({_x>=STRAFELOCK_MAXPRESS} count strafeLock_lrButtonsCountPress) == 2
		|| ({_x>=(STRAFELOCK_MAXPRESS*2.5)}count strafeLock_lrButtonsCountPress) == 1
	) then {
		rpcSendToServer("onStrafeCatch",[player]);
		strafeLock_catched = true;
	};
};