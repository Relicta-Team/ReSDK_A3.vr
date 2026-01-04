// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

cba_common_perFrameHandlerArray = [];
cba_common_perFrameHandlersToRemove = [];
cba_common_lastTickTime = diag_tickTime;

cba_common_waitAndExecArray = [];
cba_common_waitAndExecArrayIsSorted = false;
cba_common_nextFrameNo = diag_frameno + 1;
cba_common_nextFrameBufferA = [];
cba_common_nextFrameBufferB = [];
cba_common_waitUntilAndExecArray = [];

// per frame handler system
private _onFrame = {
    private _tickTime = diag_tickTime;
	CBA_missionTime = _tickTime;
	
    // frame number does not match expected; can happen between pre and postInit, save-game load and on closing map
    // need to manually set nextFrameNo, so new items get added to buffer B and are not executed this frame
    if (diag_frameno != cba_common_nextFrameNo) then {
        cba_common_nextFrameNo = diag_frameno;
    };

    // Execute per frame handlers
    {
        _x params ["_function", "_delay", "_delta", "", "_args", "_handle"];

        if (diag_tickTime > _delta) then {
            _x set [2, _delta + _delay];
            [_args, _handle] call _function;
        };
    } forEach cba_common_perFrameHandlerArray;


    // Execute wait and execute functions
    // Sort the queue if necessary
    if (!cba_common_waitAndExecArrayIsSorted) then {
        cba_common_waitAndExecArray sort true;
        cba_common_waitAndExecArrayIsSorted = true;
    };
    private __deleteEVH = false;
    {
        if (_x select 0 > CBA_missionTime) exitWith {};

        (_x select 2) call (_x select 1);

        // Mark the element for deletion so it's not executed ever again
        cba_common_waitAndExecArray set [_forEachIndex, objNull];
        __deleteEVH = true;
    } forEach cba_common_waitAndExecArray;
    if (__deleteEVH) then {
        cba_common_waitAndExecArray = cba_common_waitAndExecArray - [objNull];
        __deleteEVH = false;
    };


    // Execute the exec next frame functions
    {
        (_x select 0) call (_x select 1);
    } forEach cba_common_nextFrameBufferA;
    // Swap double-buffer:
    cba_common_nextFrameBufferA = cba_common_nextFrameBufferB;
    cba_common_nextFrameBufferB = [];
    cba_common_nextFrameNo = diag_frameno + 1;


    // Execute the waitUntilAndExec functions:
    {
        // if condition is satisfied call statement
        if ((_x select 2) call (_x select 0)) then {
            (_x select 2) call (_x select 1);

            // Mark the element for deletion so it's not executed ever again
            cba_common_waitUntilAndExecArray set [_forEachIndex, objNull];
            __deleteEVH = true;
        };
    } forEach cba_common_waitUntilAndExecArray;
    if (__deleteEVH) then {
        cba_common_waitUntilAndExecArray = cba_common_waitUntilAndExecArray - [objNull];
    };
}; onEachFrame _onFrame;

// fix for save games. subtract last tickTime from ETA of all PFHs after mission was loaded
/*addMissionEventHandler ["Loaded", {
    private _tickTime = diag_tickTime;

    {
        _x set [2, (_x select 2) - GVAR(lastTickTime) + _tickTime];
    } forEach GVAR(perFrameHandlerArray);

    GVAR(lastTickTime) = _tickTime;
}];*/

CBA_missionTime = 0;
