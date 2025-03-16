// ======================================================
// Copyright (c) 2017-2025 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

/*
TODO head control:
lookAt with enabling all enableAI "ANIM"
*/

sp_ai_debug_curCaptureHandle = -1;
sp_ai_debug_curCaptureTarget = objNull;
sp_ai_debug_curCaptureBasePos = vec3(0,0,0);

sp_ai_debug_startCapture = {
    params ["_target"];

    if (call sp_ai_debug_isCapturing) then {
        call sp_ai_debug_suspendCapture;
    };

    sp_ai_debug_curCaptureBasePos = getposatl _target;
    sp_ai_debug_curCaptureTarget = _target;
    sp_ai_debug_captureData = []; //[[frame1, data1], [frame2, data2]]...
    sp_ai_debug_lastAnim = "";
    sp_ai_debug_lastPos = [0,0,0];
        sp_ai_debug_lastPosChecked = tickTime;
        
    sp_ai_debug_lastDir = [0,0,0];
        sp_ai_debug_lastDirChecked = tickTime;

    sp_ai_debug_frame = 0;
    sp_ai_debug_startTime = tickTime;
    sp_ai_debug_curCaptureHandle = startUpdate(sp_ai_debug_internal_handleUpdate,0);
};

sp_ai_debug_stopCapture = {
    if (call sp_ai_debug_isCapturing) then {
        call sp_ai_debug_suspendCapture;
        copyToClipboard(str sp_ai_debug_captureData);
    };
};

sp_ai_debug_processCaptureSwitch = {
    if (!call sp_ai_debug_isCapturing) then {
        ["Capture --> STARTED...","debug"] call chatPrint;
        [player] call sp_ai_debug_startCapture;
    } else {
        ["!!!STOPPED CAPTURE!!! Pasted to clipboard. Buffer size: " + (str count sp_ai_debug_captureData),"debug"] call chatPrint;
        call sp_ai_debug_stopCapture;
    };
};

#define SP_AI_TICKRATE_POSITION 0.1
#define SP_AI_TICKRATE_DIRECTION 0.05

#define SP_AI_DATAFRAME_ANIMSTATE 0
#define SP_AI_DATAFRAME_POSITION 1
#define SP_AI_DATAFRAME_DIRECTION 2

/*
    Usage: 
    each frame perform checks:
    if animation state was obsoleted - update
*/
sp_ai_debug_internal_handleUpdate = {
    _targ = sp_ai_debug_curCaptureTarget;
    _lastVDir = vectorDir _targ;
    _basePos = sp_ai_debug_curCaptureBasePos;
    _localPos = (getposatl _targ) vectorDiff _basePos;
    (getUnitMovesInfo _targ) params [
        "_mProg","_mTime","_mDur","_mBlndFact",
        "_rtmStep",
        "_gProg","_gTime","_gDur","_gBlndFact"
    ];
    _animState = animationState _targ;
    _deltaTime = tickTime - sp_ai_debug_startTime;

    if (_animState != sp_ai_debug_lastAnim) then {
        sp_ai_debug_lastAnim = _animState;
        sp_ai_debug_captureData pushBack [
            _deltaTime,SP_AI_DATAFRAME_ANIMSTATE,[_animState,_mProg,_mTime,_mDur,_mBlndFact]
        ];
    };
    if (tickTime >= sp_ai_debug_lastPosChecked && {not_equals(_localPos,sp_ai_debug_lastPos)}) then {
        sp_ai_debug_lastPos = _localPos;
        sp_ai_debug_lastPosChecked = tickTime + SP_AI_TICKRATE_POSITION;
        sp_ai_debug_captureData pushBack [
            _deltaTime,SP_AI_DATAFRAME_POSITION,_localPos
        ];
    };
    if (tickTime >= sp_ai_debug_lastDirChecked && {not_equals(_lastVDir,sp_ai_debug_lastDir)}) then {
        sp_ai_debug_lastDir = _lastVDir;
        sp_ai_debug_lastDirChecked = tickTime + SP_AI_TICKRATE_DIRECTION;
        sp_ai_debug_captureData pushBack [
            _deltaTime,SP_AI_DATAFRAME_DIRECTION,_lastVDir
        ];
    };
};

sp_ai_debug_isCapturing = {
    sp_ai_debug_curCaptureHandle != -1;
};

sp_ai_debug_suspendCapture = {
    stopUpdate(sp_ai_debug_curCaptureHandle);
    sp_ai_debug_curCaptureHandle = -1;
    sp_ai_debug_curCaptureTarget = objNull;
    sp_ai_debug_curCaptureBasePos = vec3(0,0,0);
};


sp_ai_startCapture = {
    params ["_target","_cdata","_basePos"];
    private _cpydta = array_copy(_cdata);
    private _ctx = createHashMapFromArray [
        ["curPos",_basePos],
        ["prevPos",_basePos],
        ["prevDir",vectorDir _target],
        ["curDir",vectorDir _target],
        ["prevDeltaPos",0],
        ["prevDeltaDir",0]
    ];
    startUpdateParams(sp_ai_internal_processPlayingStates,0,[tickTime arg _target arg _cpydta arg _basePos arg _ctx]);
};

sp_ai_internal_processPlayingStates = {
    (_this select 0) params ["_t","_obj","_cdata","_basePos","_ctx"];
    if (count _cdata == 0) exitWith {
        stopThisUpdate();
    };
    _curDelta = tickTime - _t;
    _firstFrame = _cdata select 0;
    _firstFrame params ["_dt","_opType","_frameData"];

    //interpolate
    _pos = vectorLinearConversion [_ctx getv(prevDeltaPos),_dt,_curDelta,_ctx getv(prevPos),_ctx getv(curPos),true];
    _dir = vectorLinearConversion [_ctx getv(prevDeltaDir),_dt,_curDelta,_ctx getv(prevDir),_ctx getv(curDir),true];
    _obj setPosAtl _pos;
    _obj setvectordir _dir;

    if (_curDelta >= _dt) then {
        _cdata deleteAt 0;
        if (_opType == SP_AI_DATAFRAME_ANIMSTATE) exitWith {
            _frameData params ["_animState","_mProg","_mTime","_mDur","_mBlndFact"];
            _obj switchMove [_animState,_mProg,_mBlndFact,false];
        };
        if (_opType == SP_AI_DATAFRAME_POSITION) exitWith {
            _newRealPos = _basePos vectoradd _frameData;
            
            _ctx setv(prevPos,_ctx getv(curPos));
            _ctx setv(prevDeltaPos,_curDelta);
            _ctx setv(curPos,_newRealPos);
        };
        if (_opType == SP_AI_DATAFRAME_DIRECTION) exitWith {
            _ctx setv(prevDir,_ctx getv(curDir));
            _ctx setv(prevDeltaDir,_curDelta);
            _ctx setv(curDir,_frameData);
        };

    };
};

/*

    Plane movable ai
    TODO:

    ...
*/