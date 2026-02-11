// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\..\engine.hpp>
#include <..\..\..\oop.hpp>
#include <..\..\..\text.hpp>
#include <..\..\GameConstants.hpp>


class(PowerGenerator) extends(ElectronicDeviceNode)
	var(name,"Генератор");
	var(model,"relicta_models\models\interier\controlpanel.p3d");
	var(material,"MatMetal");
	getterconst_func(getCoefAutoWeight,10);
	var(dr,4);
	var(desc,"Вырабатывает электричество, которое в наши времена порой дороже сотен бряков.");

	var(edIsEnabled,true);
	var(edIsUsePower,true);

	autoref var(handleGenerator,-1);

	var_num(shuffleLastUpdate);

	var_array(edConnectedND); //данная переменная используется в netdisplay

	func(addConnection)
	{
		objParams_1(_obj);
		private _resultConnection = super();
		assert(_resultConnection);
		if (_resultConnection) then {
			getSelf(edConnectedND) pushBackUnique _obj;
		};
		_resultConnection
	};

	func(removeConnection)
	{
		objParams_1(_obj);
		private _r = super();
		if (_r) then {
			private _edcnd = getSelf(edConnectedND);
			_edcnd deleteAt (_edcnd find _obj);
		};
		assert(_r);
		_r
	};

	func(constructor) {
		objParams();
		#define STD_UPDATE_DELAY 1
		
	};
	
	func(beginUpdateGenerator)
	{
		objParams();
		//setSelf(handleGenerator,startSelfUpdate(Process));INC(oop_upd);
		callSelfParams(startUpdateMethod,"Process" arg "handleGenerator");
	};
	
	var(energyleft,3660*(60*45));
	var(lastRequestedEnergy,0);
	var(lastUsedEnergy,0);
	var(lastAddedEnergy,0);
	
	var(gettedEnergy,0);
	
	

	func(Process) { updateParams();
		//trace("-------------------------------------------------------")
		_t = tickTime;
		_lastAdded = getSelf(gettedEnergy);//randInt(400,800);
		private _energyLeft = getSelf(energyleft) + _lastAdded;//randInt(10,400);
		private _lastAmountEnergy = _energyLeft;
		if (tickTime > getSelf(shuffleLastUpdate)) then {
			setSelf(shuffleLastUpdate,tickTime + randInt(30,120));
			setSelf(edConnected,array_shuffle(getSelf(edConnected))); // <- for random sorting mode
		};

		private _conList = getSelf(edConnected);


		private _nodeReqEnergy = 0;
		private _requestEnergy = 0;
		private _ndIsChanged = false;
		{
			_nodeReqEnergy = callFunc(_x,getNodeReqPower);
			if (_nodeReqEnergy > _energyLeft && getVar(_x,edIsUsePower)) then {
				//disable node
				callFuncParams(_x,setUsePower,false);
				_ndIsChanged = true;
			} else {
				if (!getVar(_x,edIsUsePower) &&
					getVar(_x,edIsEnabled) &&
					_nodeReqEnergy <= _energyLeft) then {
					//restore power on node
					callFuncParams(_x,setUsePower,true);
					_ndIsChanged = true;
				};
			};

			if (getVar(_x,edIsUsePower)) then {
				MOD(_energyLeft, - _nodeReqEnergy);
			};
			MOD(_requestEnergy,+_nodeReqEnergy);

			//if (_energyLeft <= 0) exitWith {};
		} foreach _conList;

		setSelf(lastUsedEnergy,_lastAmountEnergy - _energyLeft);
		setSelf(lastRequestedEnergy,_requestEnergy);
		setSelf(lastAddedEnergy,_lastAdded);
		
		setSelf(gettedEnergy,0);
		
		//if (_ndIsChanged) then {callSelf(updateNDisplay)};

		//traceformat("(%5) Thread check --> USED %4 energy: %2 (%3); perf %1",tickTime - _t arg _energyLeft arg getSelf(energyleft) arg _requestEnergy arg getSelf(pointer));

		setSelf(energyleft,_energyLeft max 0);

		callSelf(updateNDisplay);
	};
	getter_func(getMainActionName,"Электричество");
	func(onMainAction)
	{
		objParams_1(_usr);
		callSelfParams(openNDisplay,_usr);
	};

	#include "..\..\Interfaces\INetDisplay.Interface"

	var(ndName,"PowerConsole");
	var(ndInteractDistance,2.5);

	func(getNDInfo) {
		objParams();
		private _data = [
			getSelf(energyleft),
			getSelf(lastUsedEnergy),
			getSelf(lastAddedEnergy),
			getSelf(lastRequestedEnergy)
		];
		{
			_data pushBack [callFunc(_x,getName),getVar(_x,edIsEnabled),getVar(_x,edIsUsePower)];
		} foreach getSelf(edConnectedND);
		_data
	};

	func(onHandleNDInput) {
		objParams_2(_usr,_inp);

	};

endclass


//mini station part
class(ConvertorForGenerator) extends(IStruct)
	
	var(model,"ml_exodusnew\stalker_tun\domen3.p3d");
	var(material,"MatMetal");
	getterconst_func(getCoefAutoWeight,15);
	var(dr,3);
	var(name,null);
	var(desc,null);
	getterconst_func(getName,"Конвертор");
	getterconst_func(getDesc,"Устройство"+comma+" создающее в биотопливо.");
	
	autoref var_num(handleupd);
	
	var_num(assimContentNextTime);
	getterconst_func(getNextAssimTime,randInt(15,30));
	
	func(onUpdate)
	{
		updateParams();
	
		_ct = getSelf(content);

		if (count _ct > 0) then {
			if callSelf(canGenerateEnergy) then {
				callSelf(generateEnergy);
			};	
		};	
	};
	
	getter_func(canGenerateEnergy, !isNullReference(getSelf(generator)));//tickTime > getSelf(lastCheckedTime) &&
	
	var(content,[]);
	var(generator,nullPtr);
	var_num(lastCheckedTime);
	
	func(connectToGenerator)
	{
		objParams_1(_gen);
		if !isNullReference(getSelf(generator)) exitWith {
			error("Convertor already linked to generator");
		};
		setSelf(generator,_gen);
	};
	
	func(generateEnergy)
	{
		objParams();
		
		_doDel = false;
		//_ct external reference
		{
			_itm = _x;
			//randInt(10,25) в каждом грибе
			//с каждой единицы * (1000 * (60)) -> 1 ед даёт 1000 энергии на 60 сек (60к энергии)
			if isTypeOf(_itm,Tumannik) then {
				if callFuncParams(_itm,hasReagent,"Ipamitin") then {
					callFuncParams(_itm,removeReagent,"Ipamitin" arg 1);
					_gen = getSelf(generator);
					modVar(_gen,gettedEnergy,+ randInt(900,1000)*60);
				} else {
					delete(_itm);
					_ct set [_forEachIndex,objNUll];
					_doDel = true;
				};
			} else {
				_ct set [_forEachIndex,objNUll];
				_doDel = true;
				delete(_itm);
			};
		} foreach _ct;
		
		if (_doDel) then {
			setSelf(content,_ct - [objNUll]);
		};
		
		
	};
	
	func(onInteractWith)
	{
		objParams_2(_with,_usr);
		callFuncParams(_with,moveItem,this);
	};
	
	func(onMoveInItem)
	{
		objParams_1(_item);
		private _newref = [_item];
		_newref append getSelf(content);
		setSelf(content,_newref);
		callSelfParams(playSound,"electronics\air_fill" arg getRandomPitch);
	};	
	
	func(canMoveInItem)
	{
		objParams_1(_itm);
		!isTypeOf(_itm,SystemItem)
	};
	
	func(constructor)
	{
		objParams();
		callSelfParams(startUpdateMethod,"onUpdate" arg "handleupd");
	};
	
	func(destructor)
	{
		objParams();
	};
	
	
	
endclass