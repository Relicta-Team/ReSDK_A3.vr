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
	var(chId,null); //vec3 chunk id
	getter_func(getChunkCenterPos,getSelf(chId) call atmos_chunkIdToPos);
	var_array(objInside); //список геймобджектов внутри зоны
	var(flagUpdObj,true); //когда этот флаг сбрасывается будет выполнена пересборка объектов внутри чанка

	var(aObj,[]); //atmos objects

	func(getObjectsInChunk) //getting all objects or part of objects inside this chunk
	{
		objParams();
		if getSelf(flagUpdObj) then {
			setSelf(flagUpdObj,false);
			setSelf(objInside,[getSelf(chId)] call atmos_chunkGetNearObjects);
		};
		getSelf(objInside)
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

	//регистрация атмосферного типа в чанке
	func(registerArea)
	{
		objParams_1(_classname);
		private _areaObj = [_classname,callSelf(getChunkCenterPos) 
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

	func(getChunkDown)
	{
		objParams();
		private _newChid = getSelf(chId) vectorDiff [0,0,1];
		[_newChid] call atmos_getChunkAtChId;
	};

	func(getChunkUp)
	{
		objParams();
		private _newChid = getSelf(chId) vectorAdd [0,0,1];
		[_newChid] call atmos_getChunkAtChId;
	};

	func(getChunkUserInfo)
	{
		objParams_1(_usr);
		if callSelf(hasFireInChunk) exitWith {
			private _f = callSelf(getFireInChunk);
			format ["%1 %2",
				pick["Тут вот","Ещё ","Тут","А ещё"],
				pick ["горит","пожар","загорелось","огонь хреначит"]
			] editor_conditional(+ " size:" + (str getVar(_f,size)),;)
		};
		""
	};


endclass

editor_attribute("HiddenClass")
class(AtmosAreaBase) extends(ILightibleStruct)
	var(model,"a3\structures_f\system\cluttercutter_small_f.p3d");
	var(name,null);
	var(light,-1);
	var(lightIsEnabled,true);
	getterconst_func(canApplyDamage,false);

	getterconst_func(canContactOnMob,false);
	getterconst_func(canContactOnObjects,false);
	getterconst_func(propagationType,ATMOS_PROPAGATION_AIR); //!depreacted
	getterconst_func(propagationMode,ATMOS_SEARCH_MODE_FIRST_INTERSECT);
	var(chunk,nullPtr); //в каком чанке этот объект
	getter_func(getChunkId,getVar(getSelf(chunk),chId)); //ref to chunk vec3 id
	var(createdFrom,nullPtr); //создатель объекта. если создан системно то ссылка на this

	getterconst_func(getPropagationSideMin,ATMOS_PROPAGATION_SIDE_MAX_COUNT);
	getterconst_func(getPropagationSideMax,ATMOS_PROPAGATION_SIDE_MAX_COUNT);
	getterconst_func(spreadTimeout,5); //распространение каждые 5 секунд
	var(lastActivity,0); //время последней активности
	
	
	var(force,10); //todo replace to fire

	//react on mob inside this atmos object
	func(onMobContact)
	{
		objParams_1(_mob);
	};

	//react on objects inside this atmos object
	func(onObjectContact)
	{
		objParams_1(_obj);
	};

	func(canActivity)
	{
		objParams();
		getSelf(lastActivity) > tickTime
	};

	func(preActivity)
	{
		objParams();
		setSelf(lastActivity,tickTime + callSelf(spreadTimeout));
		
		callSelfParams(adjustForce,-1);	
	};

	func(onActivity)
	{
		objParams();

		private _sides = [
			randInt(callSelf(getPropagationSideMin),callSelf(getPropagationSideMax))
		] call atmos_getNextRandAroundChunks;
		{
			if callSelfParams(canPropagateTo,_x) then {
				callSelfParams(onPropagateTo,_x);
			};
		} count _sides;
	};

	//params: baseChunkId, vectorSide
	func(canPropagateTo)
	{
		objParams_1(_side);
		
		[getVar(getSelf(chunk),chId),_side,callSelf(propagationMode)] call atmos_getIntersectInfo;
	};

	func(onPropagateTo)
	{
		objParams_1(_side);
		private _pos = (callSelf(getChunkId) vectorAdd _side) call atmos_chunkIdToPos;
		private _procObj = [_pos,callSelf(getClassName)] call atmos_createProcess;
		_procObj
	};

endclass


class(AtmosAreaFire) extends(AtmosAreaBase)
	var(size,1);//1-3
	var(light,SLIGHT_ATMOS_FIRE_1);
	var(force,3);

	#ifdef ATMOS_DEBUG_USE_FAST_SIM
	getterconst_func(spreadTimeout,0.5);
	#else
	getterconst_func(spreadTimeout,5);
	#endif

	func(onPropagateTo)
	{
		objParams_2(_chObj,_side);
		private _new = super();
		setVar(_new,createdFrom,this);
		callFuncParams(_new,adjustForce,+5);
	};

	func(calcFireSize)
	{
		objParams();
		round linearConversion [1,15,getSelf(force),1,3,true];
	};

	func(getLightTypeBySize)
	{
		objParams();
		[SLIGHT_ATMOS_FIRE_1,SLIGHT_ATMOS_FIRE_2,SLIGHT_ATMOS_FIRE_3] select (getSelf(size)-1)
	};

	func(adjustForce)
	{
		objParams_1(_lt);
		modSelf(force, + _lt);
		private _size = callSelf(calcFireSize);
		private _newForce = getSelf(force);

		//sorce deleted
		if isNullReference(getSelf(createdFrom)) then {
			if !callSelf(hasFireDown) then {
				if !getSelf(lastCanPropagateDown) exitWith {};//can propagate down but not exists fire
				//_newForce = 0;//del mark
			};
		};

		if (_size!=getSelf(size)) then {
			setSelf(size,_size);
			if (_newForce > 0) then {
				callSelfParams(lightSetType,callSelf(getLightTypeBySize));
			};
		};
		if (_newForce <= 0) then {
			delete(this);
		};
	};

	getterconst_func(canContactOnMob,true);
	getterconst_func(canContactOnObjects,true);
	getterconst_func(getPropagationSideMin,4);

	var(lastCanPropagateDown,false);

	func(canPropagateTo)
	{
		objParams_1(_side);
		private _pRet = super();
		
		private _propRes = if (_pRet) then {
			private _curCh = getSelf(chunk);
			private _chObjMid = [callSelf(getChunkId) vectorAdd _side] call atmos_getChunkAtChId;
			if callFunc(_chObjMid,hasFireInChunk) exitWith {false};
			private _fndOb = false;
			private _mobj = nullPtr;
			
			{
				_mobj = callFunc(_x,getMaterial);
				if isNullReference(_mobj) then {
					continue;
				};
				
				if prob(callFunc(_mobj,getFireDamageIgniteProb)) exitWith {
					_fndOb = true;
				};
			} foreach callFunc(_chObjMid,getObjectsInChunk);
			
			_fndOb
		} else {
			false
		};

		_propRes
	};

	func(onObjectContact)
	{
		objParams_1(_obj);
		if callFunc(_obj,canApplyDamage) then {
			private _m = callFunc(_obj,getMaterial);
			if isNullReference(_m) exitWith {};
			private _dam = floor (D6 * callFunc(_m,getFireDamageModifier));
			if (_dam > 0) then {
				callFuncParams(_obj,applyDamage,_dam arg DAMAGE_TYPE_BURN arg callFunc(_obj,getModelPosition));
				callSelfParams(adjustForce,1);
			};
		};
	};

	func(hasFireDown)
	{
		objParams();
		callFunc(callFunc(getSelf(chunk),getChunkDown),hasFireInChunk)
	};

endclass

class(AtmosAreaGas) extends(AtmosAreaBase)
	getterconst_func(canContactOnMob,true);

	func(getGasLightType)
	{
		objParams();
		//calculate of gas types
	};

endclass

class(AtmosAreaLiquid) extends(AtmosAreaBase)
	getterconst_func(canContactOnMob,true);
endclass
