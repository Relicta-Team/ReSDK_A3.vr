// ======================================================
// Copyright (c) 2017-2023 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\host\engine.hpp>
#include <..\..\host\text.hpp>
#include <..\ClientRpc\clientRpc.hpp>
#include <..\WidgetSystem\blockedButtons.hpp>

#define STRAFELOCK_CHECKDELAY 0.5

//check with left and right buttons
#define STRAFELOCK_MAXPRESS 3

strafeLock_setEnable = {
    params ["_mode"];
    if (_mode == (call strafeLock_isEnabled)) exitwith {};

    if (_mode) then {
        if (strafeLock_handleKeyUp == -1) then {
            strafeLock_handleKeyUp = (findDisplay 46) displayAddEventHandler ["KeyUp",strafeLock_handleKeyUp];
        };
        strafeLock_handle = startUpdate(strafeLock_onUpdate,STRAFELOCK_CHECKDELAY);
    } else {
        stopUpdate(strafeLock_handle);
        strafeLock_handle = -1;
    };
}; rpcAdd("strafeLock",strafeLock_setEnable);

strafeLock_isEnabled = { strafeLock_handle != -1 };

strafeLock_lrButtonsCountPress = [0,0];
strafeLock_handleKeyUp = -1;
strafeLock_handle = -1;
strafeLock_const_lrButtons = (LEFT_MOVE_BUTTONS + RIGHT_MOVE_BUTTONS);

strafeLock_onUpdate = {
    strafeLock_lrButtonsCountPress = [0,0];
};

strafeLock_handleKeyUp = {
    params ["","_key","_shift","_ctrl","_alt"];
    if (call strafeLock_isEnabled) then {

        if (player call anim_isWalking) exitWith {};

        if (_key in strafeLock_const_lrButtons) then {
            [_key in RIGHT_MOVE_BUTTONS] call strafeLock_incrementBackMovePress;
        };
    };
};

strafeLock_incrementBackMovePress = {
    params ["_sideIndex"];

    MODARR(strafeLock_lrButtonsCountPress,_sideIndex, + 1);

    call strafeLock_checkConditions;
};

strafeLock_checkConditions = {
    if (({_x>=STRAFELOCK_MAXPRESS} count strafeLock_lrButtonsCountPress) == 2) then {
        rpcSendToServer("onStrafeCatch",[player]);
    };
};