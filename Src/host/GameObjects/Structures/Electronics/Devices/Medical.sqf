// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\..\..\engine.hpp>
#include <..\..\..\..\oop.hpp>
#include <..\..\..\GameConstants.hpp>


class(FreezerStruct) extends(ElectronicDeviceNode)
	var(name,"Холодильник");
	var(desc,"Подморозить в самый раз!");
	var(model,"ca\structures\furniture\kitchen\fridge\fridge.p3d");
	
	var(edIsEnabled,true);
	var(edReqPower,150);

	#include "..\..\..\Interfaces\INetDisplay.Interface"
	var(ndName,"FreezerDisplay");
	var(ndInteractDistance,1.3);

	#include "..\..\..\Interfaces\IContainer.Interface"
	var(countSlots,40);
	var(maxSize,ITEM_SIZE_LARGE);
	var_array(freezedObjects);
	
	func(onAddItemInContainer)
	{
		objParams_1(_item);
		if callFunc(_item,isReagentContainer) then {
			getSelf(freezedObjects) pushBackUnique _item;
			
			if getSelf(edIsEnabled) then {
				
			}; //при выключенном состоянии ничего с итемом делать не надо
		};
	};
	
	func(onRemoveItemFromContainer)
	{
		objParams_1(_item);
		if callFunc(_item,isReagentContainer) then {
			private _fobj = getSelf(freezedObjects);
			_fobj deleteAt (_fobj find _item);
		};
	};
	
	var(updatehandle,-1);
	func(onUpdate)
	{
		updateParams();
		
	};

	func(onChangeUsePower)
	{
		objParams();
		if getSelf(edIsEnabled) then {		
			callSelfParams(startUpdateMethod,"onUpdate" arg "updatehandle");
			
		} else {
			callSelfParams(stopUpdateMethod,"updatehandle");
		
		};
	};

	func(getNDInfo) {
		objParams();
		private _dat = [
			callSelf(getName)
		];
		_dat pushBack getSelf(edIsEnabled);
		_dat
	};

	func(onHandleNDInput) {
		objParams_2(_usr,_inp);
		call {
			if (_inp == 0) exitWith {
				callSelfParams(setEnable,!getSelf(edIsEnabled));
				callSelfParams(closeNDisplayServer,_usr);
				callSelf(updateNDisplay);
			};
		}
	};

endclass

class(MedicalFreezer) extends(FreezerStruct)
	var(name,"Медицинский холодильник");
	var(desc,"Модифицированный холодильник для лекарских нужд");
	var(model,"a3\structures_f_heli\items\electronics\fridge_01_f.p3d");
	var(edReqPower,150);
	
endclass



class(DryChemStruct) extends(ElectronicDeviceNode)
	var(name,"Сушилка");
	getterconst_func(getDesc,"Пригодится если надо подсушить что-то.");
	var(model,"a3\structures_f_heli\civ\accessories\airconcondenser_01_f.p3d");
	
	var(edIsEnabled,false);
	var(edReqPower,150);
	
	var(connectedContainer,nullPtr);
	var(timeProcessLeft,0);
	getterconst_func(timeNeed,6);
	
	#include "..\..\..\Interfaces\INetDisplay.Interface"
	var(ndName,"DryChemDisplay");
	var(ndInteractDistance,1.3);
	
	func(getNDInfo) {
		objParams();
		private _dat = [
			callSelf(getName)
		];
		private _isLaucnhed = getSelf(edIsEnabled);
		private _isConnected = callSelf(isConnectedContainer);
		_dat append [_isLaucnhed,_isConnected];
		if (_isLaucnhed) then {_dat pushBack getSelf(timeProcessLeft)};
		
		_dat
	};
	
	func(onHandleNDInput)
	{
		objParams_2(_usr,_inp);
		call {
			if equals(_inp,0) exitWith {
				callSelfParams(setEnable,!getSelf(edIsEnabled));
				callSelf(updateNDisplay);
			};
		}
	};
	
	func(onChangeUsePower)
	{
		objParams();
		if getSelf(edIsEnabled) then {
			setSelf(timeProcessLeft,callSelf(timeNeed));
			callSelfParams(startUpdateMethod,"onUpdate" arg "handleupdate");	
		} else {
			callSelfParams(stopUpdateMethod,"handleUpdate");
		};
	};
	
	getter_func(isConnectedContainer,!isNullObject(getSelf(connectedContainer)));
	
	func(canConnectContainer)
	{
		objParams_1(_cont);
		isTypeOf(_cont,FryingPan) && !callSelf(isConnectedContainer)
	};	
	
	func(connectContainer)
	{
		objParams_1(_itm);
	
		if !callSelfParams(canConnectContainer,_itm) exitWith {};
		
		if callFunc(getVar(_itm,loc),isMob) then {
			callFuncParams(getVar(_itm,loc),removeItem,_itm);
		};	
	
		setSelf(connectedContainer,_itm);
		setVar(_itm,loc,this);
		if getSelf(edIsEnabled) then {
			setSelf(timeProcessLeft,callSelf(timeNeed));
		};
	};
	
	func(removeContainer)
	{
		objParams_1(_usr);
		
		private _item = getSelf(connectedContainer);
		setSelf(connectedContainer,nullPtr);
		
		callSelfParams(stopUpdateMethod,"handleUpdate");
		
		callFuncParams(_usr,addItem,_item);
	};	
	
	var(handleupdate,-1);
	
	func(onUpdate)
	{
		updateParams();
		
		if callSelf(isConnectedContainer) then {
		
			_timeleft = getSelf(timeProcessLeft);
			DEC(_timeleft);
			
			if (_timeleft >= 0) then {
				setSelf(timeProcessLeft,_timeleft);
				callSelf(updateNDisplay);
			} else {
				callFuncParams(getSelf(connectedContainer),processReaction,REACTION_DRYING)
			};
			
		};
		
	};
	
	/*func(onInteractWith)
	{
		objParams_2(_with,_usr);
		if callFunc(_with,isReagentContainer) exitWith {
			callSelfParams(connectContainer,_with);
		};	
	};
	
	func(onMainAction)
	{
		objParams_1(_usr);
		callSelfParams(openNDisplay,_usr);
	};
	*/
	
endclass



class(ChemicalBlender) extends(ElectronicDeviceNode)
	var(name,"Химический смешиватель");
	var(model,"ml\ml_object_new\model_24\her.p3d");
	var(material,"MatMetal");
	var(dr,5);
	
	var(edReqPower,100);

	#include "..\..\..\Interfaces\INetDisplay.Interface"
	var(ndName,"ChemicalBlender");
	var(ndInteractDistance,INTERACT_DISTANCE);
	
	#include "..\..\..\Interfaces\IReagentContainer.Interface"
	var(reagents,vec2(this,500) call ms_create);
	var(curTransAm,1);
	
	var(chemBlenderStorage,nullPtr);
	var(holders,vec2(nullPtr,nullPtr));
	func(getHoldersInfoForND)
	{
		objParams();
		private _hldrs = getSelf(holders);
		
		[
		if !isNullObject(_hldrs select 0) then {private _th = _hldrs select 0;
			[callFunc(_th,getName),callFunc(_th,getFilledSpace),callFunc(_th,getCapacity)]} else {null},
		if !isNullObject(_hldrs select 1) then {private _th = _hldrs select 1;
			[callFunc(_th,getName),callFunc(_th,getFilledSpace),callFunc(_th,getCapacity)]} else {null}
		];
		
	};
	var(handleUpdate,-1);
	getter_func(isWorking,getSelf(handleUpdate) != -1);
	
	func(setWorking)
	{
		objParams_1(_mode);
		if (callSelf(isWorking) == _mode) exitWith {false};
		if (!getSelf(edIsEnabled) && _mode) exitWith {false};
		
		private _workPower = 200;
		if (_mode) then {
			callSelfParams(startUpdateMethod,"onUpdate" arg "handleUpdate");
			modSelf(edReqPower,+_workPower);
		} else {
			callSelfParams(stopUpdateMethod,"handleUpdate");
			modSelf(edReqPower,-_workPower);
		};	
		true
	};
	
	func(onChangeEnable)
	{
		objParams();
		if !getSelf(edIsEnabled) then {
			callSelfParams(setWorking,false);
		};	
	};
	
	func(onUpdate)
	{
		updateParams();
		if callSelfParams(processReaction,REACTION_BLENDING) then {
			callSelf(updateNDisplay);
		};
	};	
	
	func(getNDInfo)
	{
		objParams();
		private _dat = [callSelf(getName),callSelf(getFilledSpace),callSelf(getCapacity)];
		
		private _reagents = ms_getMatterList(getSelf(reagents));
		if (count _reagents > 0)then {
			private _idat = [];
			private _mat = null;
			{
				_mat = getMatter(_x);
				_idat append [_mat get "scienceName",_y];
			} foreach _reagents;
			_dat pushBack _idat;
		} else {
			_dat append [null];
		};
		
		_dat append [callSelf(isWorking),getSelf(edIsEnabled),getSelf(curTransAm)];
		
		_dat append callSelf(getHoldersInfoForND);
		
		_dat
	};	
	
	func(playConsoleInputSound)
	{
		objParams();
		private _s = "electronics\console_input"+str randInt(1,3);
		callSelfParams(playSound, _s arg getRandomPitch arg 7);
	};
	
	func(playSwitcherSound)
	{
		objParams();
		callSelfParams(playSound, "electronics\click" arg getRandomPitch arg 7);
	};
	
	func(onHandleNDInput)
	{
		objParams_2(_usr,_inp);

		
		if equalTypes(_inp,[]) exitWith {
			_inp params ["_mode","_value"];
			if (_mode == 1) exitWith {
				setSelf(curTransAm,_value);
				callSelf(updateNDisplay);
				
				callSelf(playConsoleInputSound);
			};//setdose
			if (_mode == 6) exitWith {
				if (!callFunc(getSelf(holders) select _value,canTransfer)) exitWith {trace("CANT")};
				private _tram = getSelf(curTransAm);
				callFuncParams(getSelf(holders) select _value,transferReagents,this arg _tram);
				callSelf(updateNDisplay);
				
				callSelf(playConsoleInputSound);
			};//trans to chemBlender
			if (_mode == 7) exitWith {
				if (!callFunc(getSelf(holders) select _value,canTransfer)) exitWith {};
				private _tram = getSelf(curTransAm);
				callSelfParams(transferReagents,getSelf(holders) select _value arg _tram);
				callSelf(updateNDisplay);
				
				callSelf(playConsoleInputSound);
			};//trans from chemBlender
			if (_mode == 8) exitWith {
				private _holders = getSelf(holders);
				private _thisHolder = _holders select _value;
				if isNullObject(_thisHolder) then {
					//connect
					private _itm = callFunc(_usr,getItemInActiveHand);
					if (isNullVar(_itm) || {!callFunc(_itm,isReagentContainer)}) exitWith {};
					
					callFuncParams(_usr,removeItem,_itm arg _thisHolder);
					_holders set [_value,_itm];
					callSelf(updateNDisplay);
				} else {
					//disconnect
					if !callFunc(_usr,isEmptyActiveHand) exitWith {};
					callFuncParams(_usr,addItem,_thisHolder);
					_holders set [_value,nullPtr];
					callSelf(updateNDisplay);
				};	
			};//disconnect or connect
			if (_mode == 9) exitWith {
				private _holders = getSelf(holders);
				private _thisHolder = _holders select _value;
				if (!isNullObject(_thisHolder) && callFunc(_thisHolder,canTransfer)) then {
					callFunc(_thisHolder,clearReagentSpace);
					callSelf(updateNDisplay);
				};
				
				callSelf(playConsoleInputSound);
			};//clear holder space
			
		};
		
		//just numbers
		call {
			if (_inp == 0) exitWith {
				if (callSelfParams(setWorking,!callSelf(isWorking))) then {
					callSelf(updateNDisplay);
					callSelf(playConsoleInputSound);
				};
				
			};//launch or stop
			if (_inp == 2) exitWith {
				callSelf(clearReagentSpace);
				callSelf(updateNDisplay);
				
				callSelf(playConsoleInputSound);
			};//clear
			if (_inp == 3) exitWith {
				if (callSelf(getFilledSpace) == 0) exitWith {};
				private _trAm = getSelf(curTransAm);
				private _pill = ["Pill",getSelf(chemBlenderStorage)] call createItemInContainer;
				
				if !isNullObject(_pill) then {
					private _rets = [getSelf(reagents),_trAm] call ms_removeMattersWithReturns;
					
					setVar(_pill,reagents,_rets);
					
					if (count _rets == 1) then {
						private _matter = getMatter(_rets select 0 select 0);
						setVar(_pill,name,getVar(_pill,name) + " '" + (_matter get "slangName") + "'");
					};	
					callSelf(updateNDisplay);
				};
			};//make pill
			if (_inp == 4) exitWith {
				callFuncParams(getSelf(chemBlenderStorage),onContainerOpen,_usr);
			};//open pills storage
			if (_inp == 5) exitWith {
				if callSelfParams(setEnable,!getSelf(edIsEnabled)) then {
					callSelf(updateNDisplay);
				};
				
				callSelf(playSwitcherSound);
			};//set enable
		};
	};
	
	// обёртка для работы контейнерного прикола
	func(onContainerClose)
	{
		objParams_1(_usr);
		callFuncParams(getSelf(chemBlenderStorage),onContainerClose,_usr);
	};	
	
	func(removeItem)
	{
		objParams_2(_item,_newLoc);
		callFuncParams(getSelf(chemBlenderStorage),removeItem,_item arg _newLoc);
	};
	
	
	func(onInteractWith)
	{
		objParams_2(_with,_usr);
		if equals(getVar(_usr,openedContainer),getSelf(chemBlenderStorage)) exitWith {
			callFuncParams(getSelf(chemBlenderStorage),addItem,_with);
		};
	};
	
	func(constructor)
	{
		objParams();
		
		// creating virtual storage
		private _chbStorage = new(Virt_ChemBlender);
		setSelf(chemBlenderStorage,_chbStorage);
		setVar(_chbStorage,chemBlender,this);
		setVar(_chbStorage,loc,this);
	};
	getter_func(getMainActionName,"Химичить");
	func(onMainAction)
	{
		objParams_1(_usr);
		callSelfParams(openNDisplay,_usr);
	};
endclass

