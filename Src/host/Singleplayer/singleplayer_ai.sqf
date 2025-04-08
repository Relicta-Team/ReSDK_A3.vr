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
#include "..\NOEngine\NOEngine.hpp"
#include "..\GameObjects\GameConstants.hpp"

/*
TODO head control:
lookAt with enabling all enableAI "ANIM"
*/

sp_ai_debug_curCaptureHandle = -1;
sp_ai_debug_curCaptureTarget = objNull;

sp_ai_debug_captureMove = false;

sp_ai_debug_startCapture = {
    params ["_target","_movecapt"];

    if (call sp_ai_debug_isCapturing) then {
        call sp_ai_debug_suspendCapture;
    };

    if (!call sp_cam_isCreated) then {
        call sp_cam_createCinematicCam;
    };
    
    [true] call sp_cam_setCinematicCam;


    sp_ai_debug_previewPerson = call sp_ai_debug_getPreviewPerson;
    sp_ai_debug_curCaptureBasePos = getposatlvisual _target;
    sp_ai_debug_previewPerson setposatl sp_ai_debug_curCaptureBasePos;
    sp_ai_debug_curCaptureTarget = _target;
    
    sp_cam_cinematicCam attachto [sp_ai_debug_previewPerson,[0.1,-0.7,0.2],"head",true];

    sp_ai_debug_stateCount = 1;

    sp_ai_debug_captureData = [
        "cap_v1",
        [
            ["usepos",_movecapt]
        ]
    ]; //[[frame1, data1], [frame2, data2]]...
    sp_ai_debug_lastAnim = "";
    sp_ai_debug_lastAnimTime = 0;
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
        [format["Capture --> STARTED... %1",ifcheck(sp_ai_debug_captureMove,"with MOVE","")],"debug"] call chatPrint;
        [player,sp_ai_debug_captureMove] call sp_ai_debug_startCapture;
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
#define SP_AI_DATAFRAME_SCRIPTEDSTATE 4

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

    _targ setposatl (_basePos vectorAdd [0,0,0]);
    
    _animState = animationState _targ;
    _deltaTime = tickTime - sp_ai_debug_startTime;
    _camtargpos = (positioncameratoworld [0,0,0.5]) vectorDiff _basePos;
    
    if (_animState != sp_ai_debug_lastAnim
    //!error on play -> || {(animationState sp_ai_debug_previewPerson) != _animState}
    ) then {
        
        _prevanim = sp_ai_debug_lastAnim;
        sp_ai_debug_lastAnim = _animState;
        sp_ai_debug_lastAnimTime = _mTime;
        sp_ai_debug_captureData pushBack [
            _deltaTime,SP_AI_DATAFRAME_ANIMSTATE,[_animState,_mProg,_mTime,_mDur,_mBlndFact]
        ];
        sp_ai_debug_previewPerson switchmove [_animState,_mProg,_mBlndFact,false];
    };
    

    if (tickTime >= sp_ai_debug_lastPosChecked && {not_equals(_localPos,sp_ai_debug_lastPos)}) then {
        sp_ai_debug_lastPos = _localPos;
        sp_ai_debug_lastPosChecked = tickTime + SP_AI_TICKRATE_POSITION;
        if (sp_ai_debug_captureMove) then {
            sp_ai_debug_captureData pushBack [
                _deltaTime,SP_AI_DATAFRAME_POSITION,_localPos
            ];
        };
        
    };
    if (tickTime >= sp_ai_debug_lastDirChecked && {not_equals(_lastVDir,sp_ai_debug_lastDir)}) then {
        sp_ai_debug_lastDir = _lastVDir;
        sp_ai_debug_lastDirChecked = tickTime + SP_AI_TICKRATE_DIRECTION;
        sp_ai_debug_captureData pushBack [
            _deltaTime,SP_AI_DATAFRAME_DIRECTION,_lastVDir
        ];

        sp_ai_debug_previewPerson setvectordir _lastVDir;
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

sp_ai_debug_addScriptedState = {
    sp_ai_debug_captureData pushBack [
        tickTime - sp_ai_debug_startTime,SP_AI_DATAFRAME_SCRIPTEDSTATE,format["state_%1",sp_ai_debug_stateCount]
    ];
    [format["State saved - %1",sp_ai_debug_stateCount],"log"] call chatPrint;
    INC(sp_ai_debug_stateCount);
};

sp_ai_debug_isCapturing = {
    sp_ai_debug_curCaptureHandle != -1;
};

sp_ai_debug_suspendCapture = {
    [false] call sp_cam_setCinematicCam;

    stopUpdate(sp_ai_debug_curCaptureHandle);
    sp_ai_debug_curCaptureHandle = -1;
    sp_ai_debug_headMovingEnable = false;
    sp_ai_debug_curCaptureTarget = objNull;
    //sp_ai_debug_curCaptureBasePos = vec3(0,0,0);
};


sp_ai_playCapture = {
    params ["_target","_cdata","_basePos",["_postCode",{}],"_mapStates","_internalContext"];
    private _cpydta = array_copy(_cdata);

    private _moveproc = true;
    if equalTypes(_cpydta select 0,"") then {
        _cpydta deleteAt 0;
        private _pars = _cpydta deleteAt 0;
        {
            _x params ["_name","_val"];
            if (_name == "usepos") then {
                _moveproc = _val;
                continue;
            };
        } foreach _pars;
    };

    private _ctx = createHashMapFromArray [
        //["curPos",_cpydta select (_cpydta findif {_x select 1 == SP_AI_DATAFRAME_POSITION}) select 2],
        ["curPos",_basePos],
        ["prevPos",_basePos],
        ["capturePos",_moveproc],
        ["prevDir",vectorDirVisual _target],
        ["curDir",vectorDirVisual _target],
        ["prevDeltaPos",0],
        ["prevDeltaDir",0],

        ["lastState",animationState _target],
        ["lastHeadPos",[0,0,0]],

        ["postAnimCode",_postCode],

        ["mapStates",_mapStates],

        ["internalContext",_internalContext]
    ];

    if equals(_internalContext,"__not_provided__") then {
       _ctx set ["internalContext",null];
    };
    
    _target setanimspeedcoef 1;

    traceformat("CAPINFO: %1 [%2]",_ctx get "capturePos" arg _moveproc)
    if (_ctx get "capturePos") then {
        _target attachto [player,[0,0,0]];
    } else {
        _target setPosATL _basePos;
    };

    //process write postendPos
    if (_ctx get "capturePos") then {
        _finalPos = [0,0,0];
        reverse _cpydta;
        _iposlast = _cpydta findif {_x select 1 == SP_AI_DATAFRAME_POSITION};
        if (_iposlast != -1) then {
            _finalPos = _cpydta select _iposlast select 2;
        };
        if not_equals(_finalPos,vec3(0,0,0)) then {
            _ctx set ["postendPos",_finalPos vectoradd _basePos];
        };
        reverse _cpydta;
    };
    
    startUpdateParams(sp_ai_internal_processPlayingStates,0,[tickTime arg _target arg _cpydta arg _basePos arg _ctx]);
};

sp_ai_internal_processPlayingStates = {
    (_this select 0) params ["_t","_obj","_cdata","_basePos","_ctx"];
    
    if isNullReference(_obj) exitWith {
        stopThisUpdate();
    }; //already destroyed
    _capmove = _ctx get "capturePos";
    
    if (count _cdata == 0) exitWith {
        
        stopThisUpdate();

        if (_capmove) then {
            if ("postendPos" in _ctx) then {
                _obj setposatl (_ctx get "postendPos");
                _obj switchmove "";
            };
            detach _obj;
        };
        
        [_obj,getposatl _obj,false] call sp_ai_commitMobPos;
        [_obj,_ctx get "internalContext"] call (_ctx get "postAnimCode");
    };
    _curDelta = tickTime - _t;
    _firstFrame = _cdata select 0;
    _firstFrame params ["_dt","_opType","_frameData"];

    //interpolate
    _pos = null;
    if (_capmove) then {
        _pos = vectorLinearConversion [_ctx getv(prevDeltaPos),(_ctx getv(prevDeltaPos)) + SP_AI_TICKRATE_POSITION,_curDelta,_ctx getv(prevPos),_ctx getv(curPos),true];
    };
    //_dir = vectorLinearConversion [_ctx getv(prevDeltaDir),(_ctx getv(prevDeltaDir)) + SP_AI_TICKRATE_DIRECTION,_curDelta,_ctx getv(prevDir),_ctx getv(curDir),true];
    

    if (_curDelta < _dt) then {
        _lstate = _ctx getv(lastState);
        if (animationState _obj != _lstate && {!("_" in _lstate)}) then {
            _obj switchMove [_lstate,0,1,true];
        };
    };
    
    //_obj attachto [player,player worldToModelVisual _pos];
    if (_capmove) then {
        _obj setPosAtl _pos;
    };
    //_obj setvectordir _dir;
    
    //detach _obj;

    if (_curDelta >= _dt) then {
        _cdata deleteAt 0;
        //traceformat("called opt: %1 (diff: %2) FRAME %3",_opType arg _curDelta - _dt arg diag_frameNo)
        if (_opType == SP_AI_DATAFRAME_ANIMSTATE) exitWith {
            _frameData params ["_animState","_mProg","_mTime","_mDur","_mBlndFact"];
            _obj switchMove [_animState,_mProg,_mBlndFact,false];
            _ctx setv(lastState,_animState);
        };
        if (_opType == SP_AI_DATAFRAME_POSITION) exitWith {
            if (!_capmove) exitWith {}; //no-pos-handle
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
            _obj setvectordir _frameData;
            //_obj setposatl _ps;
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
        if (_opType == SP_AI_DATAFRAME_SCRIPTEDSTATE) exitWith {
            _mapStates = _ctx get "mapStates";
            if equals(_mapStates,"debug_preview") exitWith {
                ["Debug preview state " + _frameData,"log"] call chatPrint;
            };
            [_obj] call (_mapStates getOrDefault [_frameData,{
                ["Unknown scripted state " + _frameData,"log"] call chatPrint;
            }]);
        };

    };
};

sp_ai_debug_playLastAnim = {
    if (!array_exists(sp_ai_debug_testmobs,"PREVIEW")) then {
        [sp_ai_debug_curCaptureBasePos,null,"PREVIEW"] call sp_ai_debug_createTestPerson;
    };
    private _pmob = sp_ai_debug_testmobs get "PREVIEW";
    _pmob setposatl sp_ai_debug_curCaptureBasePos;
    [_pmob,sp_ai_debug_captureData,sp_ai_debug_curCaptureBasePos,null,"debug_preview"] call sp_ai_playCapture;
};

sp_ai_debug_getPreviewPerson = {
     if (!array_exists(sp_ai_debug_testmobs,"PREVIEW")) then {
        [sp_ai_debug_curCaptureBasePos,null,"PREVIEW"] call sp_ai_debug_createTestPerson;
    };
    sp_ai_debug_testmobs get "PREVIEW";
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

sp_ai_playAnim = {
    params ["_target","_basePos","_animName",["_postCode",{}],"_mapStates",["_internalContext","__not_provided__"]];

    if isNullVar(_mapStates) then {
        _mapStates = createHashMap;
    };
    if equalTypes(_mapStates,[]) then {
        _mapStates = createHashMapFromArray _mapStates;
    };

    if equalTypes(_target,"") then {
        _target = _target call sp_ai_getMobObject;
    };
    if equalTypes(_target,nullPtr) then {
        _target = getVar(_target,owner);
    };
    if isNullReference(_target) exitWith {
        errorformat("sp::ai::playAnim - Wrong target - cannot play animation %1 at %2",_animName arg _target);
    };

    if isNullVar(_basePos) then {
        _basePos = getposatlvisual _target;
    } else {
        if equalTypes(_basePos,"") then {
            private _ptrobj = _basePos call sp_getObject;
            if !isNullReference(_ptrobj) then {
                _basePos = callFunc(_ptrobj,getPos);
            };
        };
    };
    
    if !([_animName,".anm"] call stringEndWith) then {
        modvar(_animName) + ".anm";
    };
    
    private _prefix = "Src\host\Singleplayer\Anims\";
    _animName = _prefix + _animName;
    if (!fileExists(_animName)) exitwith {
        errorformat("sp::ai::playAnim - Animation %1 not found",_animName);
    };

    private _buff = call compile LOADFILE _animName;

    [_target,_buff,_basePos,_postCode,_mapStates,_internalContext] call sp_ai_playCapture;
};

sp_ai_createPerson = {
    params ["_pos",["_mtype","Mob"],["_target","CREATE_NEW"]];
    if (_target == "CREATE_NEW") then {
        _target = "mob_" + (count sp_ai_mobs + 1);
    };
    if equalTypes(_pos,"") then {
        if isNullReference(_pos call sp_getObject) exitWith {
            _pos = [0,0,0];
        };
        _pos = callFunc(_pos call sp_getObject,getPos);
    };
    private _m = _pos call gm_createMob;
    [_m,_pos,false] call sp_ai_commitMobPos;
    private _mob = instantiate(_mtype);
	callFuncParams(_mob,initAsActor,_m);
    smd_allInGameMobs pushBackUnique _m;
    sp_ai_mobs set [_target,_m];
    _m
};

sp_ai_createPersonEx = {
    params ["_pos","_tname",["_params",[]],["_mobHandler",{}],["_bodyhandler",{}]];
    
    if (_tname in sp_ai_mobs) then {
        [_tname] call sp_ai_deletePerson;
    };

    private _body = [_pos,null,_tname] call sp_ai_createPerson;
    if equalTypes(_pos,"") then {
        _body setDir (callFunc(_pos call sp_getObject,getDir));
    };
    _mob = _body getvariable "link";
    if equalTypes(_params,[]) then {
        _params = createHashMapFromArray _params;
    };
    setVar(_mob,age,_params getOrDefault vec2("age",randInt(20,40)));

    if ("uniform" in _params) then {
        [_params getOrDefault ["uniform","Cloth"],_mob,INV_CLOTH] call createItemInInventory;
    };
    
    private _pnm = _params getOrDefault vec2("name",["Мужик" arg "Неизвестный"]);
    callFuncParams(_mob,generateNaming,_pnm select 0 arg _pnm select 1);
    [_body] call anim_syncAnim;
    
    _body setAnimSpeedCoef 1;

    _body call _bodyhandler;
    _mob call _mobHandler;
    _mob
};

sp_ai_deletePerson = {
    params ["_m"];
    if equalTypes(_m,"") then {
        _m = sp_ai_mobs getOrDefault [_m,objNull];
    };
    if isNullReference(_m) exitWith {};
    if equalTypes(_m,objNull) then {
        _m = _m getvariable "link";
    };
    if isNullVar(_m) exitWith {};
    _body = getVar(_m,owner);
    {
        if equals(_y,_body) then {
            sp_ai_mobs deleteAt _x;
        };
    } foreach sp_ai_mobs;
    array_remove(smd_allInGameMobs,_body);
    delete(_m);
    deleteVehicle _body;
};

sp_ai_getMobObject = {
    private _body = sp_ai_mobs getOrDefault [_this,objNull];
    if isNullReference(_body) exitWith {nullPtr};
    _body getvariable ["link",nullPtr]
};

sp_ai_commitMobPos = {
    params ["_m","_p",["_doApply",true]];
    
    _m setvariable ["__sp_ai_internal_commitPos",_p];
    if (_doApply) then {
        _m setposatl _p;
    };

};

sp_ai_moveItemToWorld = {
    params ["_m","_it","_pos",["_dir",random 360],["_vecup",[0,0,1]]];
    
    if (canSuspend) exitWith {
        private _p = _this;
        private _r = "nonevalue";
        {_r = _p call sp_ai_moveItemToWorld} call sp_threadCriticalSection;
        if isNullVar(_r) exitWith {};
        if equals(_r,"nonevalue") exitWith {};
        _r
    };

    if equalTypes(_m,objNull) then {
        _m = _m getvariable "link";
    };
    if isNullVar(_m) exitWith {nullPtr};

    if equalTypes(_it,1) then {
        _it = callFuncParams(_m,getItemInSlotRedirect,_it);
    };
    if isNullReference(_it) exitWith {nullPtr};

    //params ["_pos","_dir","_vecUp","_objPlace"];
    private _positionData = [_pos,_dir,_vecup,nullPtr];
    callFuncParams(_m,putdownItem, _it arg _positionData);

    [getVar(_m,owner)] call anim_syncAnim;

    _it
};

sp_ai_moveItemToMob = {
    params ["_m","_item","_slot"];
    if (canSuspend) exitWith {
        private _p = _this;
        private _r = "nonevalue";
        {_r = _p call sp_ai_moveItemToMob} call sp_threadCriticalSection;
        if isNullVar(_r) exitWith {};
        if equals(_r,"nonevalue") exitWith {};
        _r
    };
    
    if equalTypes(_m,objNull) then {
        _m = _m getvariable "link";
    };
    if isNullVar(_m) exitWith {};
    if isNullReference(_item) exitWith {};
    private this = _m;
    //check if in world (server protect)
    if !callFunc(_item,isInWorld) exitWith {};

    if !callFunc(_item,canPickup) exitWith {
        callFuncParams(_item,onCantPickup,this);
    }; //cant pickup item

    if !callSelfParams(canSetItemOnSlot,args2(_item,_slot)) exitWith {};

    callSelfParams(interpolate,"pickup" arg _item arg _slot);

    callFunc(_item,simulatePhysics);

    callFunc(_item,unloadModel);

    callSelfParams(setItemOnSlot, _item arg _slot);

    callFuncParams(_item,onPickup,this); //calling std event on pickup

    [getSelf(owner)] call anim_syncAnim;
};

sp_ai_setMobPos = {
    params ["_mob","_reforpos",["_dir",null]];
	private _pos = vec3(0,0,0);
	if equalTypes(_reforpos,"") then {
		private _obj = _reforpos call sp_getObject;
		_pos = callFunc(_obj,getPos);
		if !isNullVar(_dir) then {
			_dir = callFunc(_obj,getDir);
		};	
	} else {
		_pos = _reforpos;
	};

	if equals(_pos,vec3(0,0,0)) exitWith {};

    if equalTypes(_mob,"") then {
        _mob = _mob call sp_ai_getMobObject;
        _mob = getVar(_mob,owner);
    };
    if equalTypes(_mob,nullPtr) then {
        _mob = getVar(_mob,owner);
    };

	_mob setPosAtl _pos;
    [_mob,_pos,false] call sp_ai_commitMobPos;
	if !isNullVar(_dir) then {
		_mob setDir _dir;
	};
};

sp_ai_internal_onUpdate = {
    _chunkLoaded = {
        params ["_ps"];
        private _cht = CHUNK_TYPE_STRUCTURE;
        [[[_ps,_cht] call noe_posToChunk,_cht] call noe_client_getPosChunkToData] call noe_client_isObjectsLoadingDone
    };
    _specvar = "__sp_ai_internal_nftime";
    _svstate = "__sp_ai_internal_statepos";
    {
        _vpos = _y getvariable "__sp_ai_internal_commitPos";
        _loaded = [_vpos] call _chunkLoaded;
        if (!_loaded) then {
            _y setposatl _vpos;
            _y setVelocity [0,0,0];
            _y setvariable [_specvar,null];
        } else {
            if isNull(_y getvariable _specvar) then {
                _val = createSimpleObject ["rel_vox\obj\block_dirt.p3d",[0,0,0],true];
                _mptr = struct_newp(AutoModelPtr,_val);
                _y setvariable [_specvar,_mptr];
                startAsyncInvoke
                    {
                        params ["_m","_vpos","_specvar","_tskip"];
                        if isNull(_m getvariable _specvar) exitWith {true};
                        _mptr = _m getvariable _specvar;
                        _mptr callv(get) setposatl (_vpos vectordiff [0,0,0.1]);
                        _m setposatl (_vpos vectoradd [0,0,0.3]);
                        
                        _aslPos = ATLToASL _vpos;
                        _trace = lineIntersectsSurfaces [
                            _aslPos,
                            _aslPos vectorAdd [0,0,-500],
                            _m,
                            objNull,
                            true,
                            1,
                            "GEOM",
                            "NONE"
                        ];
                        
                        count _trace > 0 && tickTime > _tskip
                    },
                    {
                        params ["_m","_vpos","_specvar"];
                        if (!isNull(_m getvariable _specvar)) then {
                            _mptr = _m getvariable _specvar;
                            _mptr callv(get) setposatl (_vpos vectordiff [0,0,0.1]);
                            _m setPosAtl (_vpos vectoradd [0,0,0.3]);
                            _mptr callv(get) hideObject true;
                        };
                    },
                    [_y,_vpos,_specvar,tickTime + 2]
                endAsyncInvoke
            };
        };
    } foreach sp_ai_mobs;
};

/*
    Play looped animlist
    ["target",[
        ["pos1","anim1","_pauseCodeOrFloat","_additionalPostcode"]
    ]] call sp_ai_playAnimsLooped
*/
sp_ai_playAnimsLooped = {
    params ["_target","_anims",["_commonState",{}]];
    
    if (count _anims == 0) exitWith {};

    //_anims -> params ["_target","_basePos","_animName",["_postCode",{}],"_mapStates"];
    private _anmStateContext = createHashMapFromArray [
        ["target",_target], //cur target
        ["curAnim",0], //cur anim
        ["animList",_anims], //animlist
        ["commonState",_commonState],

        ["_tref",objNull]
    ];
    
    [_target,_anims select 0,_anmStateContext] call sp_ai_internal_playAnimStateLoop;
};

sp_ai_internal_playAnimStateLoop = {
    params ["_t","_anm","_ctxInt"];
    _anm params ["_p","_anmName","_pauseAft",["_callPostCode",{}]];
    
    _ctxInt set ["pause",_pauseAft];
    _ctxInt set ["callPostAnim",_callPostCode];

    [_t,_p,_anmName,{
        params ["_obj","_ctxInt"];
        
        //save object reference (for hotreload checks)
        if !isNullReference(_obj) then {
            _ctxInt set ["_tref",_obj];
        };

        if not_equals(_obj,_ctxInt get "_tref") exitWith {}; //exit on obsolete object

        //calculate awaiter
        _pause = _ctxInt getOrDefault ["pause",0];
        if equalTypes(_pause,{}) then {
            _pause = call _pause;
        };

        //get next anim
        _curAnimId = _ctxInt get "curAnim";
        _anmList = _ctxInt get "animList";
        _maxAnimId = count _anmList - 1;
        _nextId = _curAnimId + 1;
        if (_nextId > _maxAnimId) then {_nextId = 0};

        //write new id
        _ctxInt set ["curAnim",_nextId];

        //play commonstate
        _commonState = _ctxInt get "commonState";
        [_obj,_ctxInt] call _commonState;

        //play additional code (e.g. set anim, or play sound)
        [_obj,_ctxInt] call (_ctxInt getOrDefault ["callPostAnim",{}]);

        //play anim
        _paramList = [_ctxInt get "target",_anmList select _nextId,_ctxInt];
        if (_pause > 0) then {
            invokeAfterDelayParams(sp_ai_internal_playAnimStateLoop,_pause,_paramList)
        } else {
            _paramList call sp_ai_internal_playAnimStateLoop;
        };
    },_states,_ctxInt] call sp_ai_playAnim;
};

sp_ai_setLookAtControl = {
    params ["_mob","_target"];
    if (isNullReference(_mob)) exitWith {};
    if isNullReference(_target) then {
        _mob lookat objnull;
        _mob disableAI "ANIM";
    } else {
        _mob enableAI "ANIM";
        _mob lookat _target;
    };
};