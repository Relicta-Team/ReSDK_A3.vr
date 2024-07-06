// ======================================================
// Copyright (c) 2017-2024 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include "..\engine.hpp"
#include "..\oop.hpp"
#include "Atmos.h"

/*
    Atmos chunk management
*/
atmos_getChunkAtChId = {
    params ["_chId"];
    private _strKey = str _chId;
    if !(_strKey in atmos_map_chunks) then {
         
			
		#ifdef ATMOS_MODE_SIMPLE_VISUALIZATION
			private _ppos = _chId call atmos_chunkIdToPos;
			private _chObj = ["AtmosChunk",_ppos vectoradd [ATMOS_ADDITIONAL_RANGE_XY,ATMOS_ADDITIONAL_RANGE_XY,ATMOS_ADDITIONAL_RANGE_Z] ] call createGameObjectInWorld;
		#else
			private _chObj = new(AtmosChunk);
		#endif

        #ifdef EDITOR
        _chObj setName (format["AtmosChunk%1",_strKey]);
        #endif
        setVar(_chObj,chId,_chId);
        atmos_map_chunks set [_strKey,_chObj];
    };
    atmos_map_chunks get _strKey
};

atmos_getChunkAtChIdUnsafe = {
    params ["_chId"];
    private _strKey = str _chId;
    atmos_map_chunks getOrDefault [_strKey,nullPtr]
};

//create atmos effect (fire,smoke etc)
atmos_createProcess = {
    params ["_pos","_processClass",["_manualCreate",false],["_initialGas",["GasBase",1]]];
    if !isTypeNameOf(_processClass,AtmosAreaBase) exitWith {nullPtr};

    private _chId = _pos call atmos_chunkPosToId;
    private _centerPos = _chId call atmos_chunkIdToPos;

    private _chObj = [_chId] call atmos_getChunkAtChId;
    private _pObj = callFuncParams(_chObj,getAreaByType,_processClass);
    if isNullReference(_pObj) then {
        _pObj = callFuncParams(_chObj,registerArea,_processClass);
        callFuncParams(_pObj,onCreated,_manualCreate arg _initialGas);
    };
    
    if (_manualCreate) then {
        setVar(_pObj,createdFrom,_pObj);
    };

    _pObj
};

#define ATMOS_DEBUG_TRY_IGNITE atmos_debug_ignite_ptr
#ifndef EDITOR
    #undef ATMOS_DEBUG_TRY_IGNITE
#endif

#ifdef ATMOS_DEBUG_TRY_IGNITE
    #define ignite_info(v) if equals(atmos_debug_ignite_ptr,getVar(_obj,pointer)) then {logformat("atmos::tryIgnite() [%1] - %2",_obj arg v)};
    atmos_debug_ignite_ptr = "";
#else
    #define ignite_info(v) 
#endif

//попытка зажечь область при нахождении предметов рядом
atmos_tryIgnite = {
    params ["_obj"];
    ignite_info("Check process from >>>>>>>>>>>>>>>" + str _obj + "; deleted: " + str isdeleted(_obj))
    if callFunc(_obj,isFlying) exitWith {
        ignite_info("OBJECT IS FLYING")
        false
    };

    private _pos = callFunc(_obj,getPos);
    private _chObj = [_pos call atmos_chunkPosToId] call atmos_getChunkAtChId;
    ignite_info("   Check chunk: " + str _chObj)
    if !isNullReference(_chObj) then {
        
        //already flamed
        if callFunc(_chObj,hasFireInChunk) exitWith {
            ignite_info("   - already inflamed")
        };

        ignite_info("   - objcount: " + str callFunc(_chObj,getObjectsInChunk))

        private _mat = nullPtr;
        {
            if equals(_obj,_x) then {continue};
            _mat = callFunc(_x,getMaterial);
            if !isNullReference(_mat) then {
                ignite_info("   - precheck material object " + str _x)
                if prob(callFunc(_mat,getFireDamageIgniteProb)) then {
                    ignite_info("   - postcheck object " + str _x)
                    if callFuncParams(_obj,checkCanIgniteObject,_x) then {
                        [_pos,"AtmosAreaFire",true] call atmos_createProcess;
                        break;
                    };
                };
            };
        } foreach callFunc(_chObj,getObjectsInChunk);
    };
};