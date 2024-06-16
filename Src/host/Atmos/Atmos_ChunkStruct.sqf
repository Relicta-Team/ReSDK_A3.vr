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
        private _chObj = new(AtmosChunk);
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