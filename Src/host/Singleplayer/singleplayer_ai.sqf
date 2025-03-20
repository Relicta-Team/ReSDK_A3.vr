// ======================================================
// Copyright (c) 2017-2025 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include "..\engine.hpp"
#include "..\oop.hpp"
#include "..\struct.hpp"
#include "..\text.hpp"
#include "..\thread.hpp"
#include "..\..\client\WidgetSystem\widgets.hpp"

/*
TODO head control:
lookAt with enabling all enableAI "ANIM"
*/

sp_ai_debug_curCaptureHandle = -1;
sp_ai_debug_curCaptureTarget = objNull;

sp_ai_debug_startCapture = {
    params ["_target"];

    if (call sp_ai_debug_isCapturing) then {
        call sp_ai_debug_suspendCapture;
    };


    sp_ai_debug_curCaptureBasePos = getposatlvisual _target;
    sp_ai_debug_curCaptureTarget = _target;
    sp_ai_debug_captureData = []; //[[frame1, data1], [frame2, data2]]...
    sp_ai_debug_lastAnim = "";
    sp_ai_debug_lastPos = [0,0,0];
        sp_ai_debug_lastPosChecked = tickTime;
        
    sp_ai_debug_lastDir = [0,0,0];
        sp_ai_debug_lastDirChecked = tickTime;

    sp_ai_debug_lastHeadTarg = [0,0,0];
        sp_ai_debug_lastHeadChecked = tickTime;
        sp_ai_debug_headMovingEnable = false;

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

#define SP_AI_TICKRATE_POSITION 0.5
#define SP_AI_TICKRATE_DIRECTION 0.05
#define SP_AI_TICKRATE_HEADTARGET 0.1

#define SP_AI_DATAFRAME_ANIMSTATE 0
#define SP_AI_DATAFRAME_POSITION 1
#define SP_AI_DATAFRAME_DIRECTION 2
#define SP_AI_DATAFRAME_HEADTARGET 3

/*
    Usage: 
    each frame perform checks:
    if animation state was obsoleted - update
*/
sp_ai_debug_internal_handleUpdate = {
    _targ = sp_ai_debug_curCaptureTarget;
    _lastVDir = vectorDirVisual _targ;
    _basePos = sp_ai_debug_curCaptureBasePos;
    _localPos = (getPosATLVisual _targ) vectorDiff _basePos;
    (getUnitMovesInfo _targ) params [
        "_mProg","_mTime","_mDur","_mBlndFact",
        "_rtmStep",
        "_gProg","_gTime","_gDur","_gBlndFact"
    ];
    _animState = animationState _targ;
    _deltaTime = tickTime - sp_ai_debug_startTime;
    _camtargpos = (positioncameratoworld [0,0,0.5]) vectorDiff _basePos;

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
    /*
    if (FreeLook != sp_ai_debug_headMovingEnable) then {
        if (!FreeLook) then {
            //_targ lookAt objNull;
            sp_ai_debug_lastHeadChecked = 0;
            sp_ai_debug_lastHeadTarg = [0,0,0];
            // sp_ai_debug_captureData pushBack [
            //     _deltaTime,SP_AI_DATAFRAME_HEADTARGET,0
            // ];
        };
        sp_ai_debug_headMovingEnable = FreeLook;
    };
    if (FreeLook) then {
        if (tickTime >= sp_ai_debug_lastHeadChecked && {not_equals(_camtargpos,sp_ai_debug_lastHeadTarg)}) then {
            sp_ai_debug_lastHeadTarg = _camtargpos;
            sp_ai_debug_lastHeadChecked = tickTime + SP_AI_TICKRATE_HEADTARGET;
            sp_ai_debug_captureData pushBack [
                _deltaTime,SP_AI_DATAFRAME_HEADTARGET,_camtargpos
            ]
        };
    };
    */
};

sp_ai_debug_isCapturing = {
    sp_ai_debug_curCaptureHandle != -1;
};

sp_ai_debug_suspendCapture = {
    stopUpdate(sp_ai_debug_curCaptureHandle);
    sp_ai_debug_curCaptureHandle = -1;
    sp_ai_debug_headMovingEnable = false;
    sp_ai_debug_curCaptureTarget = objNull;
    //sp_ai_debug_curCaptureBasePos = vec3(0,0,0);
};


sp_ai_playCapture = {
    params ["_target","_cdata","_basePos"];
    private _cpydta = array_copy(_cdata);
    private _ctx = createHashMapFromArray [
        ["curPos",_cpydta select (_cpydta findif {_x select 1 == SP_AI_DATAFRAME_POSITION}) select 2],
        ["prevPos",_basePos],
        ["prevDir",vectorDirVisual _target],
        ["curDir",vectorDirVisual _target],
        ["prevDeltaPos",0],
        ["prevDeltaDir",0],

        ["lastState",animationState _target],
        ["lastHeadPos",[0,0,0]]
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
    _pos = vectorLinearConversion [_ctx getv(prevDeltaPos),(_ctx getv(prevDeltaPos)) + SP_AI_TICKRATE_POSITION,_curDelta,_ctx getv(prevPos),_ctx getv(curPos),true];
    _dir = vectorLinearConversion [_ctx getv(prevDeltaDir),(_ctx getv(prevDeltaDir)) + SP_AI_TICKRATE_DIRECTION,_curDelta,_ctx getv(prevDir),_ctx getv(curDir),true];
    

    if (_curDelta < _dt) then {
        _lstate = _ctx getv(lastState);
        if (animationState _obj != _lstate && {!("_" in _lstate)}) then {
            _obj switchMove [_lstate,0,1,true];
        };
    };
    _obj setPosAtl _pos;
    _obj setvectordir _dir;
    

    if (_curDelta >= _dt) then {
        _cdata deleteAt 0;
        //traceformat("called opt: %1 (diff: %2) FRAME %3",_opType arg _curDelta - _dt arg diag_frameNo)
        if (_opType == SP_AI_DATAFRAME_ANIMSTATE) exitWith {
            _frameData params ["_animState","_mProg","_mTime","_mDur","_mBlndFact"];
            _obj switchMove [_animState,_mProg,_mBlndFact,false];
            _ctx setv(lastState,_animState);
        };
        if (_opType == SP_AI_DATAFRAME_POSITION) exitWith {
            _newRealPos = _basePos vectoradd _frameData;
            _ctx setv(prevPos,_newRealPos);
            
            _ctx setv(prevDeltaPos,_curDelta);
            _npsIdx = (_cdata findif {_x select 1 == SP_AI_DATAFRAME_POSITION});
            if (_npsIdx != -1) then {
                _posNext = _basePos vectoradd (_cdata select _npsIdx select 2);
                
                _ctx setv(curPos,_posNext);
            };
        };
        if (_opType == SP_AI_DATAFRAME_DIRECTION) exitWith {
            _ctx setv(prevDir,_ctx getv(curDir));
            _ctx setv(prevDeltaDir,_curDelta);
            _ctx setv(curDir,_frameData);
        };
        /*
        if (_opType == SP_AI_DATAFRAME_HEADTARGET) exitWith {
            if equals(_frameData,0) then {
                //_obj lookAt objNull;
            } else {
                //_obj lookAt (_basePos vectoradd _frameData);
                _ctx setv(lastHeadPos,_basePos vectoradd _frameData);
                //_obj lookat  (sp_ai_debug_testmobs get "look");
            };
        };
        */

    };
};

sp_ai_debug_playLastAnim = {
    if (!array_exists(sp_ai_debug_testmobs,"PREVIEW")) then {
        [sp_ai_debug_curCaptureBasePos,null,"PREVIEW"] call sp_ai_debug_createTestPerson;
    };
    private _pmob = sp_ai_debug_testmobs get "PREVIEW";
    _pmob setposatl sp_ai_debug_curCaptureBasePos;
    [_pmob,sp_ai_debug_captureData,sp_ai_debug_curCaptureBasePos] call sp_ai_playCapture;
};

sp_ai_debug_createTestPerson = {
    params ["_pos",["_mtype","Mob"],["_target","CREATE_NEW"]];
    if (_target == "CREATE_NEW") then {
        _target = "mob_" + (count sp_ai_debug_testmobs + 1);
    };
    private _m = _pos call gm_createMob;
    private _mob = instantiate(_mtype);
	callFuncParams(_mob,initAsActor,_m);
    sp_ai_debug_testmobs set [_target,_m];
    _m
};

/*

    Plane movable ai
    TODO:

    ...
*/