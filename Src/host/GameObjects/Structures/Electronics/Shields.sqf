// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\..\engine.hpp>
#include <..\..\..\oop.hpp>
#include <..\..\GameConstants.hpp>

class(ElectricalShield) extends(ElectronicDeviceNode)
	var(name,"Щиток");
	var(model,"ml\ml_object_new\model_24\transformator_2.p3d");
	var(material,"MatMetal");
	var(dr,3);
	var(desc,"Обеспечивает распределение и контроль электричества для подключенных источников");
	var(edReqPower,15);
	var(edIsEnabled,true);
	
	#include "..\..\Interfaces\INetDisplay.Interface"
	var(ndName,"ElecticalHacking");
	var(ndInteractDistance,INTERACT_DISTANCE);
	getterconst_func(getCoefAutoWeight,5);
	func(getNDInfo)
	{
		objParams();
		private _dat = [callSelf(getName),callSelf(wireColors)];
		_dat pushBack getSelf(wiresState);
		_dat
	};
	
	func(onHandleNDInput)
	{
		objParams_2(_usr,_inp);
		
		_inp params ["_work","_idx"];
		if (_work == 0) exitWith {
			callSelfParams(onWireChangeState,_idx arg _usr)
		};
		if (_work == 1) exitWith {
			callSelfParams(onCheckPowerState,_idx arg _usr);
		};
	};
	getter_func(getMainActionName,"Осмотреть внутренности");
	func(onMainAction)
	{
		objParams_1(_usr);
		if getSelf(isOpened) then {
			callSelfParams(openNDisplay,_usr);
		} else {
			callFuncParams(_usr,localSay,"Закрыто!" arg "error");
		};
	};
	
	getterconst_func(wireColors,[ \
		vec3(1,0,0) arg \
		vec3(0.3,0,0) arg \
		vec3(0.7,0.7,0) arg \
		vec3(0,1,0) arg \
		vec3(0,0.3,0) arg \
		vec3(0,0.5,0.5) arg \
		vec3(0.5,0,0.5) arg \
		vec3(0,0,0.5) \
	]);



	var(isOpened,false);//открываем отвёрткой
	func(setOpened)
	{
		objParams_1(_mode);
		if (_mode == getSelf(isOpened)) exitWith {};
		setSelf(isOpened,_mode);
		callSelf(onChangeOpened);
	};
	func(onChangeOpened)
	{
		objParams();
		if !callSelf(isOpened) then {
			callSelf(closeNDisplayForAllMobs);
		};
	};
	
	var_array(wiresState);
	var_array(wiresActionIndexes);
	getterconst_func(getDisabledIndexes,[6 arg 7]); //провода выключенные по умолчанию
	
	func(constructor)
	{
		objParams();
		private _cols = callSelf(wireColors);
		private _states = getSelf(wiresState);
		private _wireActIdxs = getSelf(wiresActionIndexes);
		private _countWires = count _cols;
		private _disabledWires = callSelf(getDisabledIndexes);
		
		for "_i" from 0 to (_countWires - 1) do {
			_states set [_i,1];
			
			_wireActIdxs set [_i,_i];
		};
		
		setSelf(wiresActionIndexes,array_shuffle(_wireActIdxs));
		
		{
			if (_x in _disabledWires) then {
				_states set [_forEachIndex,0];
			}
		} foreach getSelf(wiresActionIndexes);
	};
	
	//провода включения
	var_num(disabledWires);
	//список нужных проводов для источника
	var_num(disabledSource);
	
	func(onCheckPowerState)
	{
		objParams_2(_wireIndex,_usr);
		FHEADER;
		private _wiresState = getSelf(wiresState);
		private _state = (_wiresState select _wireIndex) == 0;
		
		private _item = callFunc(_usr,getItemInActiveHand);
		if isNullObject(_item) then {
			//visual info check skills
			private _mes = (pick ["Судя по всему","Как я вижу"]) + " провод " + (["","не "] select _state) + "подсоединён";
			callFuncParams(_usr,localSay,_mes arg "info");
		} else {
			if !isTypeOf(_item,Multimeter) then {
				private _mes = callFunc(_item,getName) + " не может использоваться для проверки напряжения";
				callFuncParams(_usr,localSay,_mes arg "error");
				RETURN(0);
			};
			
			private _act = getSelf(wiresActionIndexes) select _wireIndex;
			
			call {
				if (_act in [0,1]) exitWith {
					
					/*if (_state) then {
						modSelf(disabledWires,-1);
					} else {
						modSelf(disabledWires,+1);
					};*/
					callFuncParams(_usr,localSay,"Провод включения" arg "info");
				};
				if (_act in [2,3]) exitWith {
					private _mes = pick ["Провод не под напряжением","На проводе нет напряжения","Этот провод без напряжения"];
					callFuncParams(_usr,localSay,_mes arg "info");
				};
				if (_act in [4,5]) exitWith {
					/*if (_state) then {
						modSelf(disabledSource,-1);
					} else {
						modSelf(disabledSource,+1);
					};*/
					callFuncParams(_usr,localSay,"Есть напряжение" arg "info");
				};
				if (_act in [6,7]) exitWith {
					callFuncParams(_usr,localSay,"Это переключающий провод" arg "info");
					/*if (_state) then {
						modSelf(disabledWires,+1);
					} else {
						modSelf(disabledWires,-1);
					};*/
				};	
			};
		};
	};
	
	func(onWireChangeState)
	{
		objParams_2(_wireIndex,_usr);
		FHEADER;
		
		if isNullVar(_usr) then {_usr = nullPtr};

		private _wiresState = getSelf(wiresState);
		private _state = (_wiresState select _wireIndex) == 0;
		
		if !isNullReference(_usr) then {
			private _item = callFunc(_usr,getItemInActiveHand);
			if isNullObject(_item) then {
				//todo prob shock!!!
			} else {
				if !isTypeOf(_item,WireCutters) then {
					private _mes = callFunc(_item,getName) + " не может использоваться для " + (["обрезки","соединения"] select _state) + " проводов";
					callFuncParams(_usr,localSay,_mes arg "error");
					RETURN(0);
				};
			};	
		};
		
		
		if (_state) then {_wiresState set [_wireIndex,1]} else {_wiresState set [_wireIndex,0]};
		
		private _act = getSelf(wiresActionIndexes) select _wireIndex;
		
		//warningformat("NEW STATE %1",_state);
		//warningformat("PRESSED WIRE %1",_act);
		
		call {
			if (_act in [0,1]) exitWith {
				
				if (_state) then {
					modSelf(disabledWires,-1);
				} else {
					modSelf(disabledWires,+1);
				};
				
				private _dwires = getSelf(disabledWires);
				if (_dwires > 0) then {
					callSelfParams(setEnable,false);
				} else {
					if (_dwires == 0) then {
						callSelfParams(setEnable,true);
					};
				};
			};
			if (_act in [2,3]) exitWith {
			};
			if (_act in [4,5]) exitWith {
				if (_state) then {
					modSelf(disabledSource,-1);
				} else {
					modSelf(disabledSource,+1);
				};
				
				private _dsrc = getSelf(disabledSource);
				if (_dsrc > 0) then {
					if !isNullObject(getSelf(edOwner)) then {
						setSelf(__cachedOwner,getSelf(edOwner));
						callSelfParams(disconnectFrom,getSelf(__cachedOwner));
					};
				} else {
					if (_dsrc == 0) then {
						
						callSelfParams(connectTo,getSelf(__cachedOwner));
						setSelf(__cachedOwner,null);
					};
				};
			};
			if (_act in [6,7]) exitWith {
				if (_state) then {
					modSelf(disabledWires,+1);
				} else {
					modSelf(disabledWires,-1);
				};
			};	
		};
		
		callSelf(updateNDisplay);
	};
	
	func(onInteractWith)
	{
		objParams_2(_with,_usr);
		if isTypeOf(_with,Screwdriver) exitWith {
			if getSelf(isOpened) then {
				callSelfParams(setOpened,false);
				callFuncParams(_usr,meSay,"закрывает " + callSelf(getName) arg "info");
			} else {
				callSelfParams(setOpened,true);
				callFuncParams(_usr,meSay,"открывает " + callSelf(getName) arg "info");
			};	
		};	
	};	
	
	//! До переработки проводки, в которой физические объекты проводов будут использоваться в щитках этот метод используется для события RatsEatWiresEvent
	//TODO убрать событие после переписки системы
	func(__randomizeWires)
	{
		objParams();

		private _countWires = count getSelf(wiresState);
		private _list = [];
		for "_i" from 0 to _countWires - 1 do {_list pushback _i};
		_list = array_shuffle(_list);
		_prec = precentage(_countWires-1,50);
		if (_prec <= 0) exitwith {};
		private _wiresState = getSelf(wiresState);
		{
			if ((_wiresState select _x) == 1) then {
				callSelfParams(onWireChangeState,_x);
			};
		} foreach (_list select [0,_prec]);
	};

	//! См. выше
	func(__disableAllWires)
	{
		objParams();
		for "_i" from 0 to (count getSelf(wiresState)) - 1 do {
			if ((getSelf(wiresState) select _i) == 1) then {
				callSelfParams(onWireChangeState,_i);
			};
		};
	};

endclass

class(ElectricalShieldSmall) extends(ElectricalShield)
	var(model,"ml\ml_object_new\model_24\transformator.p3d");
endclass