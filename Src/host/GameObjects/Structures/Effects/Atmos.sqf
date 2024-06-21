// ======================================================
// Copyright (c) 2017-2024 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\..\engine.hpp>
#include <..\..\..\oop.hpp>
#include <..\..\GameConstants.hpp>
#include "..\..\..\Atmos\Atmos.hpp"

//internal class for chunk metadata
editor_attribute("HiddenClass")
class(AtmosChunk)
	#ifdef ATMOS_MODE_SIMPLE_VISUALIZATION
		extends(ILightibleStruct)
		getterconst_func(canApplyDamage,false);
		var(model,"a3\structures_f\system\cluttercutter_small_f.p3d");
	#endif
	
	var(chId,null); //vec3 chunk id
	getter_func(getChunkCenterPos,getSelf(chId) call atmos_chunkIdToPos);
	var_array(objInside); //список геймобджектов внутри зоны
	var(flagUpdObj,true); //когда этот флаг true - будет выполнена пересборка объектов внутри чанка

	var(aObj,[]); //atmos objects

	func(getObjectsInChunk) //getting all objects or part of objects inside this chunk
	{
		objParams();
		
		//assert_str(!array_exists(getSelf(objInside),nullPtr),"Null pointer found in object list inside chunk " + (str this));
		if array_exists(getSelf(objInside),nullPtr) then {
			setSelf(flagUpdObj,true);
		};

		if getSelf(flagUpdObj) then {
			setSelf(flagUpdObj,false);
			setSelf(objInside,[getSelf(chId)] call atmos_chunkGetNearObjects);
		};
		getSelf(objInside)
	};

	func(getFireInChunk)
	{
		objParams();
	#ifdef ATMOS_MODE_SIMPLE_VISUALIZATION
		private _g = getSelf(fireObj);
		if !isNullReference(_g) exitWith {ifcheck(getVar(_g,force)>0,_g,nullPtr)};
		_g
	#else
		private _fire = nullPtr;
		{if isTypeOf(_x,AtmosAreaFire) exitWith {_fire = _x};false} count getSelf(aObj);
		_fire
	#endif
	};

	func(hasFireInChunk)
	{
		objParams();
		!isNullReference(callSelf(getFireInChunk))
	};

	func(getGasInChunk)
	{
		objParams();
	#ifdef ATMOS_MODE_SIMPLE_VISUALIZATION
		private _g = getSelf(gasObj);
		if !isNullReference(_g) exitWith {ifcheck(getVar(_g,volume)>0,_g,nullPtr)};
		_g
	#else
		private _gas = nullPtr;
		{if isTypeOf(_x,AtmosAreaGas) exitWith {_gas = _x};false} count getSelf(aObj);
		_gas
	#endif
	};

	func(hasGasInChunk)
	{
		objParams();
		!isNullReference(callSelf(getGasInChunk))
	};

	func(getAreaByType)
	{
		objParams_1(_classname);
		private _oRet = nullPtr;
		{
			if isTypeStringOf(_x,_classname) exitWith {_oRet = _x};
			false
		} count getSelf(aObj);
		_oRet
	};

	//регистрация атмосферного типа в чанке
	func(registerArea)
	{
		objParams_1(_classname);
		private _areaObj = 
		#ifdef ATMOS_MODE_SIMPLE_VISUALIZATION
			instantiate(_classname);
		#else
			[_classname,callSelf(getChunkCenterPos) 
				vectoradd [ATMOS_ADDITIONAL_RANGE_XY,ATMOS_ADDITIONAL_RANGE_XY,ATMOS_ADDITIONAL_RANGE_Z]
			] call createGameObjectInWorld;
		#endif
		getSelf(aObj) pushBack _areaObj;
		setVar(_areaObj,chunk,this);
		#ifdef ATMOS_MODE_SIMPLE_VISUALIZATION
			private _varNameSave = callFunc(_areaObj,fSetType);
			assert_str(_varNameSave!=stringEmpty,format vec2("%1.fSetType - cannot be empty",this));
			setSelfReflect(_varNameSave,_areaObj);
			callSelf(onUpdateLight);
		#endif
		_areaObj
	};

	#ifdef ATMOS_MODE_SIMPLE_VISUALIZATION
	
	var(fireObj,nullPtr);
	var(gasObj,nullPtr);

	var(light,-1);
	var(lightIsEnabled,false);
	//automaticly select light type for this chunk
	func(onUpdateLight)
	{
		objParams();
		private _f = callSelf(getFireInChunk); if isdeleted(_f) then {_f = nullPtr};
		private _fCall = {
			private _newLight = getVar(_f,light);
			if (_newLight >= 0) then {
				setSelf(lightIsEnabled,true);//enable light forced (handled in lightSetType (used replicateObject on enabled light))
				callSelfParams(lightSetType,_newLight);
			} else {
				//light disposed
				callSelfParams(lightSetMode,false);
			};
		};
		if !isNullReference(_f) exitWith _fCall;
		_f = callSelf(getGasInChunk); if isdeleted(_f) then {_f = nullPtr};
		if !isNullReference(_f) exitWith _fCall;
		
		//no atmos - disable light
		callSelfParams(lightSetMode,false);
	};

	#endif

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

	func(getChunkFromSide)
	{
		objParams_1(_side);
		private _newChid = getSelf(chId) vectorAdd _side;
		[_newChid] call atmos_getChunkAtChId;
	};

	func(getChunkUserInfo)
	{
		objParams_1(_usr);
		if callSelf(hasFireInChunk) exitWith {
			private _f = callSelf(getFireInChunk);
			format ["%1 %2",
				pick["Тут вот","Ещё","Тут","А ещё"],
				pick ["горит","пожар","загорелось","огонь хреначит"]
			] editor_conditional(+ " size:" + (str getVar(_f,size)) + "; force:"+(str getVar(_f,force)),;)
		};
		""
	};

	//event on mob inside turf (contact on legs)
	func(onMobContactTurf)
	{
		objParams_1(_mob);
		{
			callFuncParams(_x,onMobContactTurf,_mob);
			false;
		} count getSelf(aObj)
	};

	//event on mob body contacted to area (breathing etc...)
	func(onMobContactBody)
	{
		objParams_1(_mob);
		{
			callFuncParams(_x,onMobContactBody,_mob);
			false;
		} count getSelf(aObj);
	};

endclass

editor_attribute("HiddenClass")
class(AtmosAreaBase) 
	#ifdef ATMOS_MODE_SIMPLE_VISUALIZATION
		extends(object)
		getterconst_func(fSetType,"");
	#else
		extends(ILightibleStruct)
	#endif
	var(model,"a3\structures_f\system\cluttercutter_small_f.p3d");
	var(name,null);
	var(light,-1);
	var(lightIsEnabled,true);
	getterconst_func(canApplyDamage,false);

	#ifdef ATMOS_MODE_FORCE_OPTIMIZE
	var(areaPower,ATMOS_MODE_SPREAD_FORCE_OPTIMIZE);
	var(canDecrementAreaPower,true);
	#endif

	getterconst_func(canContactOnMob,false);
	getterconst_func(canContactOnObjects,false);
	getterconst_func(propagationMode,ATMOS_SEARCH_MODE_FIRST_INTERSECT);
	var(chunk,nullPtr); //в каком чанке этот объект
	getter_func(getChunkId,getVar(getSelf(chunk),chId)); //ref to chunk vec3 id
	var(createdFrom,nullPtr); //создатель объекта. если создан системно то ссылка на this

	getterconst_func(getPropagationChunkMode,ATMOS_SPREAD_MODE_NORMAL);
	getterconst_func(getPropagationSideMin,ATMOS_PROPAGATION_SIDE_MAX_COUNT);
	getterconst_func(getPropagationSideMax,ATMOS_PROPAGATION_SIDE_MAX_COUNT);
	getterconst_func(spreadTimeout,5); //распространение (цикл симуляции) каждые 5 секунд
	var(lastActivity,0); //время последней активности. обновляется по прошествию spreadTimeout

	func(onCreated) //called on create
	{
		objParams_2(_manualCreate,_initGas);
		setVar(this,lastActivity,tickTime + randInt(1,callFunc(this,spreadTimeout)));
	};

	//react on mob inside this atmos object
	func(onMobContactTurf)
	{
		objParams_1(_mob);
	};

	//react on mob breathing or contacted this with body
	func(onMobContactBody)
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
		tickTime > getSelf(lastActivity)
	};

	func(preActivity)
	{
		objParams();
		setSelf(lastActivity,tickTime + callSelf(spreadTimeout));
	};

	func(handleActivitySides)
	{
		objParams_1(_sides);
	};

	func(onActivity)
	{
		objParams();
		private _sides = [
			randInt(callSelf(getPropagationSideMin),callSelf(getPropagationSideMax)),
			callSelf(getPropagationChunkMode)
		] call atmos_getNextRandAroundChunks;

		callSelfParams(handleActivitySides,_sides);

		#ifdef ATMOS_DEBUG_TEST_SIDE_SPREAD
		_sides = [ATMOS_DEBUG_TEST_SIDE_SPREAD];
		#endif
		
		{
			if callSelfParams(canPropagateTo,_x) then {
				callSelfParams(onPropagateTo,_x);
			};
			false
		} count _sides;
	};

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
		#ifdef ATMOS_MODE_FORCE_OPTIMIZE
		if getVar(_procObj,canDecrementAreaPower) then {
			setVar(_procObj,areaPower,(getSelf(areaPower)-1) max 0);
			setVar(_procObj,canDecrementAreaPower,false);
		};
		#endif
		_procObj
	};

	#ifdef EDITOR
	func(getDeubgInfo)
	{
		objParams();
		private _aObj = this;
		format[
		"%1>%5 s:%4 - f:%2 (t:%3)",
			_aObj,getVar(_aObj,force),round(getVar(_aObj,lastActivity)-tickTime),getVar(_aObj,size),getVar(getVar(_aObj,createdFrom),pointer)
		]
	};
	#endif

	#ifdef ATMOS_MODE_SIMPLE_VISUALIZATION
	func(lightSetType)
	{
		objParams_1(_t);
		setSelf(light,_t);
		callFunc(getSelf(chunk),onUpdateLight);
	};

	func(destructor)
	{
		objParams();
		private _myCh = getSelf(chunk);
		callFunc(getSelf(chunk),onUpdateLight);
		//todo remove from aobj list if not simple vis (can be memleaks)
	};

	func(getModelPosition)
	{
		objParams();
		callFunc(getSelf(chunk),getChunkCenterPos)
	};

	#endif

endclass


class(AtmosAreaFire) extends(AtmosAreaBase)
	#ifdef ATMOS_MODE_SIMPLE_VISUALIZATION
	getterconst_func(fSetType,"fireObj");
	#endif
	var(size,1);//1-3
	var(light,SLIGHT_ATMOS_FIRE_1);
	var(force,3);

	#ifdef ATMOS_DEBUG_USE_FAST_SIM
	getterconst_func(spreadTimeout,0.5);
	#else
	getterconst_func(spreadTimeout,5);
	#endif

	func(onMobContactTurf)
	{
		objParams_1(_mob);
		private _dz = TARGET_ZONE_TORSO;

		//turf calculate random body part
		call {
			private _sta = callFunc(_mob,getStance);
			private _tzList = [];
			if (_sta <= STANCE_UP) then {
				_tzList append [TARGET_ZONE_LEG_L,TARGET_ZONE_LEG_R];
			};
			if (_sta <= STANCE_MIDDLE) then {
				_tzList append TARGET_ZONE_LIST_TORSO;
				_tzList append [TARGET_ZONE_ARM_R,TARGET_ZONE_ARM_L];
			};
			if (_sta <= STANCE_DOWN) then {
				_tzList append TARGET_ZONE_LIST_HEAD;
			};
			if (count _tzList > 0) then {
				_dz = pick _tzList;
			};
		};

		callSelfParams(applyFireDamage,_mob arg _dz);
	};

	func(onMobContactBody)
	{
		objParams_1(_mob);
		_tzlist = TARGET_ZONE_LIST_HEAD;
		_tzlist append TARGET_ZONE_LIST_TORSO;
		
		callSelfParams(applyFireDamage,_mob arg pick _tzlist);
	};

	func(applyFireDamage)
	{
		objParams_2(_m,_sel);
		if (tickTime >= getVar(_m,__lastFireDamage)) then {
			private _dam = D6 - 1;
			callFuncParams(_m,applyDamage,_dam arg DAMAGE_TYPE_BURN arg _sel arg DIR_RANDOM);
			setVar(_m,__lastFireDamage,tickTime+0.3);//each 300ms
		};
	};

	func(preActivity)
	{
		objParams();
		super();
		callSelfParams(adjustForce,-1);
		
		if !isNullReference(this) then {
			//огонь прогорает - выделяется дым
			private _gas = [
				callFunc(getSelf(chunk),getChunkCenterPos),
				"AtmosAreaGas",
				true,
				["GasBase",
					4 * getSelf(size)
				]
			] call atmos_createProcess;
			callFuncParams(_gas,adjustGas,"GasBase" arg 1.0 * getSelf(size));
		};
	};

	func(onPropagateTo)
	{
		objParams_1(_side);
		private _new = super();
		setVar(_new,createdFrom,this);
		if equals(_side,vec3(0,0,1)) then {
			callFuncParams(_new,adjustForce,+2);
		};
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
		//modSelf(force, + _lt);
		private _newForce = (getSelf(force) + _lt) min 30;
		setSelf(force,_newForce);

		//sorce deleted
		//if isNullReference(getSelf(createdFrom)) then {
			if !callSelf(hasFireDown) then {
				if (_newForce > 5) then {
					private _dch = getSelf(chunk);//callFunc(getSelf(chunk),getChunkDown);
					
					if ((count callFunc(_dch,getObjectsInChunk))==0) then {
						_newForce = 0;
						setSelf(force,_newForce);
					};
				};
				
			};
		//};

		private _size = callSelf(calcFireSize);
		

		if (_size!=getSelf(size)) then {
			setSelf(size,_size);
			if (_newForce > 0) then {
				callSelfParams(lightSetType,callSelf(getLightTypeBySize));
			};
		};
		if (_newForce <= 0) then {
			#ifdef ATMOS_MODE_SIMPLE_VISUALIZATION
			setSelf(force,0);
			#else
			delete(this);
			#endif
		};
	};

	getterconst_func(canContactOnMob,true);
	getterconst_func(canContactOnObjects,true);
	getterconst_func(getPropagationSideMin,4);

	func(canPropagateTo)
	{
		objParams_1(_side);
		#ifdef ATMOS_MODE_FORCE_OPTIMIZE
		if (getSelf(areaPower)<=0) exitWith {false};
		#endif
		private _pRet = super();
		
		_pRet = _pRet && getSelf(size) > 1;

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
				if (callFunc(_m,getFireDamageModifier) <= 1) exitWith {};

				private _oldHP = getVar(_obj,hp);
				private _mpos = ifcheck(prob(30),callFunc(_obj,getModelPosition),null);
				callFuncParams(_obj,applyDamage,_dam arg DAMAGE_TYPE_BURN arg _mpos);
				if not_equals(_oldHP,getVar(_obj,hp)) then {
					callSelfParams(adjustForce,2);//because decrement is 1
				};

			};
		};
	};

	func(hasFireDown)
	{
		objParams();
		callFunc(callFunc(getSelf(chunk),getChunkDown),hasFireInChunk)
	};

endclass

#include "Gases.sqf"


//#define DEBUG_GAS_VISUALIZE

#ifndef EDITOR
	#undef DEBUG_GAS_VISUALIZE
#endif

class(AtmosAreaGas) extends(AtmosAreaBase)
	#ifdef ATMOS_MODE_SIMPLE_VISUALIZATION
	getterconst_func(fSetType,"gasObj");
	#endif
	getterconst_func(canContactOnMob,true);
	var(light,SLIGHT_ATMOS_SMOKE_1);

	getterconst_func(propagationMode,ATMOS_SEARCH_MODE_NO_INTERSECT);
	getterconst_func(getPropagationChunkMode,ATMOS_SPREAD_MODE_NO_Z);
	getterconst_func(getPropagationSideMin,4);
	getterconst_func(getPropagationSideMax,3);
	#ifdef ATMOS_DEBUG_USE_FAST_SIM
	getterconst_func(spreadTimeout,0.5);
	#else
	getterconst_func(spreadTimeout,5);
	#endif

	var(gCont,createHashMap);//gas container
	var(volume,0); //текущий полный объем
	var(leftVol,1000); //оставшееся место
	getterconst_func(maxVolume,1000);
	var(leadingGas,nullPtr);

	func(destructor)
	{
		objParams();
		{
			delete(_y);
		} foreach getSelf(gCont);
		
		#ifdef DEBUG_GAS_VISUALIZE
		deleteVehicle getSelf(__gvis);
		#endif
	};
	#ifdef DEBUG_GAS_VISUALIZE
	var(__gvis,objNull);
	#endif

	func(onCreated)
	{
		objParams_2(_manualCreate,_initGas);
		if (_manualCreate) then {
			_initGas params ["_gt","_v"];
			//при распространении газ перемещается из источника
			callSelfParams(adjustGas,_gt arg _v);
			callSelf(updateLeadingGas);
		} else {
			// if (getSelf(volume)<=0.3) then {
			// 	callSelfParams(adjustGas,_gt arg _v);
			// 	callSelf(updateLeadingGas);
			// };
		};

		//побольше времени чтобы было нормально...
		//setVar(this,lastActivity,tickTime + callFunc(this,spreadTimeout) + randInt(1,callFunc(this,spreadTimeout)));
		super();//std timing

		#ifdef DEBUG_GAS_VISUALIZE
		if isNullReference(getSelf(__gvis)) then {
			private _s = "Sign_Sphere10cm_F" createVehicleLocal [0,0,0];
			_s setposatl callFunc(getSelf(chunk),getChunkCenterPos);
			setSelf(__gvis,_s);
		};
		#endif
	};

	func(onMobContactBody)
	{
		objParams_1(_mob);
		
		{
			callFuncParams(_y,onBreathing,_mob);
			callFuncParams(_y,onSkinContact,_mob);
		} foreach getSelf(gCont);
	};

	func(onMobContactTurf)
	{
		objParams_1(_mob);
	};

	func(updateLeadingGas)
	{
		objParams();
		private _ld = nullPtr;
		private _max = 0;
		private _cur = 0;

		{
			_cur = getVar(_y,volume);
			if (_cur > _max) then {
				_max = _cur;
				_ld = _y;
			};
		} foreach getSelf(gCont);

		if !isNullReference(_ld) then {
			setSelf(leadingGas,_ld);
			private _pt = callFunc(_ld,getParticleTypes) select callFunc(_ld,getParticleBySize);
			if (_pt != getSelf(light)) then {
				callSelfParams(lightSetType,_pt);
			};

			#ifdef DEBUG_GAS_VISUALIZE
			_col = [
				[0,1,0],
				[1,1,0],
				[1,0,0]
			];
			getSelf(__gvis) setObjectTexture [0,format(
				["#(rgb,8,8,3)color(%1,%2,%3,1)"]
				+ (_col select clamp(callFunc(_ld,getParticleBySize),0,2))
			)];
			#endif
		};
	};

	func(adjustGas)
	{
		objParams_2(_gt,_vol);
		private _left = getSelf(leftVol);
		_vol = _vol max 0 min getSelf(leftVol);
		_gt = tolower _gt;
		private _gc = getSelf(gCont);
		if (_gt in _gc) then {
			private _gobj = (_gc get _gt);
			setVar(_gobj,volume,getVar(_gobj,volume) + _vol);
			setSelf(leftVol,(_left - _vol) max 0);
		} else {
			private _gobj = instantiate(_gt);
			_gc set [_gt,_gobj];
			setVar(_gobj,volume,_vol);
			setSelf(leftVol,(_left - _vol) max 0);
		};
		setSelf(volume,getSelf(volume) + _vol min callSelf(maxVolume));
		true
	};

	func(removeGas)
	{
		objParams_2(_gt,_vol);
		_gt = tolower _gt;
		private _gc = getSelf(gCont);
		if !(_gt in _gc) exitWith {false};
		private _gobj = (_gc get _gt);
		private _newamount = getVar(_gobj,volume) - _vol;
		if (_newamount <= 0 || (_newamount toFixed 4) == "0.0000") then {
			_vol = getVar(_gobj,volume);
			delete(_gobj);
			_gc deleteAt _gt;
			setSelf(volume,(getSelf(volume) - _vol) max 0);
			setSelf(leftVol,(getSelf(leftVol) + _vol) min callSelf(maxVolume));
		} else {
			setVar(_gobj,volume,_newamount);
			setSelf(volume,(getSelf(volume) - _vol) max 0);
			setSelf(leftVol,(getSelf(leftVol) + _vol) min callSelf(maxVolume));
		};
		
		
		true
	};

	func(addVolume) //TODO implement
	{
		objParams_1(_val);
	};

	func(removeVolume)
	{
		objParams_1(_val);
		private _curvol = getSelf(volume);
		if (_curvol<=0) exitWith {false};
		_val = _val max 0 min _curvol;
		private _gcmap = getSelf(gCont);
		private _trEach = _val / _curvol;
		private _trans = 0;
		private _newamount = 0;
		private _newvol = 0;
		private _toDel = [];
		{
			_trans = getVar(_y,volume) * _trEach;
			modVar(_y,volume, - _trans);
			_newamount = getVar(_y,volume);
			//traceformat("trans %1(%3) new %2",_trans arg _newamount toFixed 4 arg _y);
			if (_newamount <= 0 || (_newamount toFixed 4) == "0.0000") then {
				_toDel pushBack _x;
				_newamount = 0;
			};

			modvar(_newvol) + _newamount;
		} foreach _gcmap;
		setSelf(leftVol,callSelf(maxVolume) - _newvol);
		setSelf(volume,_newvol max 0);

		{
			delete(_gcmap get _x);
			_gcmap deleteAt _x;
		} foreach _toDel;

		true
	};

	func(transferTo)
	{
		objParams_2(_toAreaGas,_vol);
		_vol = _vol max 0 min getSelf(volume);
		_vol = _vol max 0 min getVar(_toAreaGas,leftVol);

		if (_vol==0) exitWith {false};

		private _gcFrom = getSelf(gCont);
		private _trEach = _vol/getSelf(volume);
		private _trans = 0;
		{
			_trans = getVar(_y,volume) * _trEach;
			callSelfParams(removeGas,_x arg _trans);
			callFuncParams(_toAreaGas,adjustGas,_x arg _trans);
		} foreach +_gcFrom;

		true
	};

	// func(getTransferAmountBySize)
	// {
	// 	objParams_1(_vol);
	// 	null
	// };


	func(updateVolume)
	{
		objParams();
		private _vol = 0;
		{
			modvar(_vol) + getVar(_x,volume);
		} foreach getSelf(gCont);
		setSelf(volume,_vol);
		setSelf(leftVol,callSelf(maxVolume) - _vol);
		_vol
	};

	func(preActivity)
	{
		objParams();
		super();
		callSelfParams(removeVolume,0.1);
		if (getSelf(volume) <= 0) then {
			#ifdef ATMOS_MODE_SIMPLE_VISUALIZATION
				setSelf(volume,0);
			#else
				delete(this);
			#endif
		} else {
			callSelf(updateLeadingGas);
		};
	};

	//todo unload model visual on dispose object
	var(enabledVisual,false);
	func(setEnableVisual)
	{
		objParams_1(_mode);
		if equals(_mode,getSelf(enabledVisual)) exitWith {false};
		
	};

	func(handleActivitySides)
	{
		objParams_1(_sides);
		_sides insert [0,[[0,0,1]],false];//top spread
	};

	func(onActivity)
	{
		objParams();
		private _sides = [
			randInt(callSelf(getPropagationSideMin),callSelf(getPropagationSideMax)),
			callSelf(getPropagationChunkMode)
		] call atmos_getNextRandAroundChunks;

		callSelfParams(handleActivitySides,_sides);

		#ifdef ATMOS_DEBUG_TEST_SIDE_SPREAD
		_sides = [ATMOS_DEBUG_TEST_SIDE_SPREAD];
		#endif
		
		private _psides = [];
		{
			if callSelfParams(canPropagateTo,_x) then {
				_psides pushBack _x;
			};
			false
		} count _sides;

		private _iterCnt = count _psides;
		if (_iterCnt == 0) exitWith {};

		//private _valPass = getSelf(volume)/2;//0.5 min getSelf(volume);

		private _DIFF_RATE = 0.5;
		private _valPass = getSelf(volume) * _DIFF_RATE;

		private _val = _valPass/_iterCnt;
		//traceformat("Calculate end: pass %1, cnt: %2 %3",_val arg _iterCnt);
		{
			callSelfParams(onPropagateToGas,_x arg _val);
			false
		} count _psides;
	};

	func(getDiffusionRate)
	{
	//	objParams_3(_)
	};

	func(onPropagateToGas)
	{
		objParams_2(_side,_transVal);
		private _myVol = getSelf(volume);
		if (_myVol <= 0) exitWith {};
		private _new = callSelfParams(onPropagateTo,_side);
		setVar(_new,createdFrom,this);
		callSelfParams(transferTo,_new arg _transVal);
		callSelf(updateLeadingGas);
		callFunc(_new,updateLeadingGas);

		private _srcCh = getVar(_new,createdSource);
		if isNullReference(_srcCh) then {
			setVar(_new,createdSource,getSelf(chunk));
		};
	};
	var(createdSource,nullPtr);

	func(canPropagateTo)
	{
		objParams_1(_side);
		#ifdef ATMOS_MODE_FORCE_OPTIMIZE
		if (getSelf(areaPower)<=0) exitWith {false};
		#endif
		//if (getSelf(volume) <= ifcheck(equals(_side,vec3(0,0,1)),1,5)) exitWith {false};
		if (getSelf(volume) < 0.8) exitWith {false};
		private _canProp = true;
		private _chIdTo = callFuncParams(getSelf(chunk),getChunkFromSide,_side);
		private _gas = callFunc(_chIdTo,getGasInChunk);
		
		if equals(getSelf(createdSource),_chIdTo) then {
			_canProp = false;
		};
		
		
		if (!_canProp) exitWith {false};
		super() && getSelf(volume) > 0;
	};

	// func(onPropagateTo)
	// {
	// 	objParams_1(_side);
	// 	private _myVol = getSelf(volume);
	// 	if (_myVol <= 0) exitWith {};
	// 	private _new = super();
	// 	setVar(_new,createdFrom,this);
	// 	private _transVal = _myVol/3;
	// 	callSelfParams(transferTo,_new arg _transVal);
	// 	callSelf(updateLeadingGas);
	// 	callFunc(_new,updateLeadingGas);
	// };

	func(getGasLightType)
	{
		objParams();
		//calculate of gas types
	};

	#ifdef EDITOR
	func(getDeubgInfo)
	{
		objParams();
		private _aObj = this;
		if (callFunc(_aObj,getModelPosition) distance (asltoatl eyepos player) > 2) exitWith {""};
		private _lg = getVar(_aObj,leadingGas);
		private _gsize = callFunc(_lg,getParticleBySize);
		if isNullVar(_gsize) then {_gsize="nullval"};
		format[
		"%1>%2 v:%3/%4=%7 :: ct:%5 (t:%6) s:%8",
			_aObj,getVar(getVar(_aObj,createdFrom),pointer)
			,getVar(_aObj,volume)
			,getVar(_aObj,leftVol)
			,((values getVar(_aObj,gCont)) apply {
				format["%1=%2",callFunc(_x,getClassName),getVar(_x,volume)]
			}) joinString ","
			,round(getVar(_aObj,lastActivity)-tickTime)
			,getVar(_aObj,volume)+getVar(_aObj,leftVol)
			,_gsize
		]
	};
	#endif

endclass

class(AtmosAreaLiquid) extends(AtmosAreaBase)
	getterconst_func(canContactOnMob,true);
endclass
