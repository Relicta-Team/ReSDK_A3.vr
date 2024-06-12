// ======================================================
// Copyright (c) 2017-2024 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\..\engine.hpp>
#include <..\..\..\oop.hpp>
#include <..\..\GameConstants.hpp>
#include "..\..\..\Atmos\Atmos.hpp"

//internal class for chunk metadata
class(AtmosChunk)
    //var(realPos,vec3(0,0,0)); //center pos of chunk
    var(pos,vec3(0,0,0));
    var(chId,null);

    var(aObj,[]); //atmos objects
    var(lastSim,0); //time of last simulation
    
    func(getLeadObject)
    {
        objParams();
        private _objlist = getSelf(aObj);
        if (count _objlist == 0) exitWith {nullPtr};
        _objlist select 0
    };

    func(getFireInChunk)
    {
        objParams();
        private _fire = nullPtr;
        {if isTypeOf(_x,AtmosAreaFire) exitWith {_fire = _x}} foreach getSelf(aObj);
        _fire
    };

    func(hasFireInChunk)
    {
        objParams();
        !isNullReference(callSelf(getFireInChunk))
    };

    func(getAreaByType)
    {
        objParams_1(_classname);
        private _oRet = nullPtr;
        {
            if isTypeStringOf(_x,_classname) exitWith {_oRet = _x};
        } foreach getSelf(aObj);
        _oRet
    };

    func(registerArea)
    {
        objParams_1(_classname);
        private _areaObj = [_classname,getSelf(pos) 
            vectoradd [ATMOS_ADDITIONAL_RANGE_XY,ATMOS_ADDITIONAL_RANGE_XY,ATMOS_ADDITIONAL_RANGE_Z]
        ] call createGameObjectInWorld;
        getSelf(aObj) pushBack _areaObj;
        setVar(_areaObj,chunk,this);
        _areaObj
    };

    func(destructor)
    {
        objParams();
        {
            delete(_x);
        } foreach getSelf(aObj);
    };


endclass

editor_attribute("HiddenClass")
class(AtmosAreaBase) extends(ILightibleStruct)
	var(model,"a3\structures_f\system\cluttercutter_small_f.p3d");
    var(name,null);
	var(light,-1);
	var(lightIsEnabled,true);
    var(layer,0);
    getterconst_func(canApplyDamage,false);

    getterconst_func(canContactOnMob,false);
    getterconst_func(canContactOnObjects,false);
    getterconst_func(propagationType,ATMOS_PROPAGATION_AIR);
    var(chunk,nullPtr);
    var(lastTransfer,nullPtr);

	func(onMobContact)
	{
		objParams_1(_mob);
	};

	func(onObjectContact)
	{
		objParams_1(_obj);
	};

	func(onUpdate)
	{
		objParams();
	};

    func(canActivity)
    {
        objParams();
    };

    //params: baseChunkId, vectorSide
    func(canPropagateTo)
    {
        objParams_3(_chId,_side,_propT);
        
        [_chId,_side,_propT] call atmos_getIntersectInfo;
    };

    getterconst_func(getPropagationSideMin,ATMOS_PROPAGATION_SIDE_MAX_COUNT);
    getterconst_func(getPropagationSideMax,ATMOS_PROPAGATION_SIDE_MAX_COUNT);
    getterconst_func(spreadTimeout,5); //распространение каждые 5 секунд
    var(lastActivity,0); //время последней активности
    var(force,10);

    func(doPropagateTo)
    {
        objParams_2(_chObj,_side);
        private _pos = (getVar(_chObj,chId) vectorAdd _side) call atmos_chunkIdToPos;
        [_pos,callSelf(getClassName)] call atmos_createProcess;
    };

endclass


class(AtmosAreaFire) extends(AtmosAreaBase)
	var(size,1);//1-3
    var(light,SLIGHT_ATMOS_FIRE_1);

    var(force,5);

    func(doPropagateTo)
    {
        objParams_2(_chObj,_side);
        private _new = super();
        modVar(_new,force,+ 5);
    };

    getterconst_func(canContactOnMob,true);
    getterconst_func(canContactOnObjects,true);
    getterconst_func(getPropagationSideMin,3);
    getterconst_func(propagationType,ATMOS_PROPAGATION_FIRE);

    func(canPropagateTo)
    {
        objParams_3(_chId,_side,_propT);
        private _pRet = super();
        if (count _pRet > 0) then {
            //сосдений чанк не должен гореть
            private _chObjMid = [_chId vectorAdd _side] call atmos_getChunkAtChId;
            if callFunc(_chObjMid,hasFireInChunk) exitWith {false};

            private _matObj = nullPtr;
            (_pRet findif {
                _matObj = callFunc(_x,getMaterial);
                if (!isNullReference(_matObj)) then {
                    isTypeOf(_matObj,MatWood)
                    || isTypeOf(_matObj,MatCloth)
                    || isTypeOf(_matObj,MatPaper)
                } else {false};
            } )!=-1;
        } else {false};
    };

endclass

class(AtmosAreaGas) extends(AtmosAreaBase)
    getterconst_func(canContactOnMob,true);
endclass

class(AtmosAreaSmoke) extends(AtmosAreaGas)
    getterconst_func(canContactOnMob,true);
endclass

class(AtmosAreaMiasm) extends(AtmosAreaGas)
    getterconst_func(canContactOnMob,true);
endclass