// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\..\..\engine.hpp>
#include <..\..\..\..\oop.hpp>
#include <..\..\..\GameConstants.hpp>
#include <..\..\..\..\ServerRpc\serverRpc.hpp>
#include <..\..\..\..\NOEngine\NOEngine.hpp>

class(ElectronicDeviceDoor) extends(DoorStatic)
	#include "..\..\..\Interfaces\ElectronicDevice.Interface"
	var(edIsEnabled,true);
	getterconst_func(canBreak,false);
	func(onInteractWith)
	{
		objParams_2(_with,_usr);
		if callSelf(canBreak) exitWith {
			super();
		};
	};
	
	getterconst_func(getActivationDelay,1);
	var_num(lastActivationTime);
	getter_func(canUseMainAction,isTypeOf(_usr,MobGhost)); //электронные двери нельзя отпитанивать, но госты могут прорваться через них
	func(getMainActionName)
	{
		objParams();
		if isTypeOf(_usr,MobGhost) exitWith {
			"Прорваться"
		};
		super();
	};
	getter_func(isWoodenDoor,false);
	
	var(isLockBreaked,false); //сломан ли замочек
	var(stBreakBonus,-4); //штраф за взлом
	var(doorBreakingHP, 5); //оставшихся успехов до слома.
	
	func(onMainAction)
	{
		objParams_1(_usr);
		if isTypeOf(_usr,MobGhost) exitWith {
			callFuncParams(_usr,ghostBreakThroughDoor,this);
		};
	};
	
	func(onActivate)
	{
		objParams();
		
		if (tickTime < getSelf(lastActivationTime)) exitWith {};
		
		private _isOpen = getSelf(isOpen);
		callSelfParams(setDoorOpen,!_isOpen);
		if (_isOpen != getSelf(isOpen)) then {
			setSelf(lastActivationTime,tickTime + callSelf(getActivationDelay));
		};	
		
	};
	
endclass


class(GateCity) extends(ElectronicDeviceDoor)
	var(name,"Ворота");
	var(desc,null);
	getterconst_func(getDesc,"Они защищают нормальных людей от тебя.");
	var(model,"ml\ml_object_new\model_14_10\germodweri.p3d");
	var(material,"MatMetal");
	var(dr,5);
	getter_func(animateData,[vec3(0,0,0.95) arg 0]);
	getterconst_func(interpSpeed,1.8);
	var(edReqPower,10);
	
	getterconst_func(getActivationDelay,4);
	
	getter_func(getOpenSoundParams,["doors\bulkhead_open" arg getRandomPitchInRange(0.6,1.3) arg null]);
	getter_func(getCloseSoundParams,["doors\bulkhead_close" arg getRandomPitchInRange(0.6,1.3) arg null]);
endclass

class(GateCity1) extends(GateCity)
	var(model,"smg_metro_building\drugoe\smg_germozatvor1.p3d");
	getter_func(animateData,[vec3(-1.8,-1.8,-2) arg 300]);
	getterconst_func(interpSpeed,3);
	getterconst_func(getActivationDelay,4.2);
	getter_func(getOpenSoundParams,["doors\bulkhead_open" arg getRandomPitchInRange(0.6,1) arg null]);
	getter_func(getCloseSoundParams,["doors\bulkhead_close" arg getRandomPitchInRange(0.6,1) arg null]);
endclass

class(SteelGridDoorElectronic) extends(ElectronicDeviceDoor)
	var(name,"Автоматическая решетка");
	var(desc,null);
	getterconst_func(getDesc,"Управляется удалённо.");
	var(model,"ml\ml_object_new\ml_object_2\l01_props\reshetka.p3d");
	var(material,"MatMetal");
	var(dr,4);
	getter_func(animateData,[vec3(0.55,0.55,-1.76488) arg 90]);
	getterconst_func(interpSpeed,0.4);
	
	var(stBreakBonus,-4);
	getterconst_func(canBreak,true);
	
	getterconst_func(getActivationDelay,2.5);

	getter_func(getOpenSoundParams,["doors\tribunal_open" arg getRandomPitchInRange(0.5,1.5) arg null arg 1.5]);
	getter_func(getCloseSoundParams,["doors\falsewall_close" arg getRandomPitchInRange(0.5,1.5) arg null arg 1.5]);
endclass

class(CurtainElectronic) extends(ElectronicDeviceDoor)
	var(name,"Занавес");
	var(model,"ml\ml_object_new\shabbat\shtora_centr.p3d");
	getter_func(animateData,[vec3(0,0,2.3) arg 0]);
	getterconst_func(interpSpeed,4.5);
	var(material,"MatCloth");

	getterconst_func(canBreak,false);

endclass