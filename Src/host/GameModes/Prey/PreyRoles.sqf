// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\GameMode.h>

class(RPreyNomadBase) extends(BasicRole)
	
	getter_func(canTakeInLobby,true);
	getter_func(canVisibleAfterStart,false);
	var(count,1);
	
	getter_func(getInitialPos,vec3(1997.45,1999.07,10.0939));
	getter_func(getInitialDir,random 360);
	getter_func(getSkills,vec4(randInt(10,15),randInt(10,12),randInt(10,14),randInt(9,12))); //["_st","_iq","_dx","_ht"];
	func(getEquipment)
	{
		objParams_1(_mob);
		if prob(60) then {
			[
			pick["HatOldUshanka","HatUshanka","WorkerCap","WorkerCoolCap","HatGrayOldUshanka"],
			_mob,INV_HEAD
			] call createItemInInventory;
		};
		["NomadCloth" + str randInt(1,15),_mob,INV_CLOTH] call createItemInInventory;
	};
	
	func(onDeadBasic)
	{
		objParams_2(_mob,_usr);
		super();
		modVar(gm_currentMode,aliveNomads, - 1);
	};
	
	func(onAssigned)
	{
		objParams_2(_mob,_usr);
		super();
		modVar(gm_currentMode,aliveNomads, + 1);
	};
	
endclass

class(RPreyEater) extends(BasicRole)
	
	//У жрунов нет душ...
	var(returnInLobbyAfterDead,true);
	getter_func(canStoreNameAndFaceForValidate,false);
	
	getter_func(canTakeInLobby,true);
	getter_func(canVisibleAfterStart,true);
	var(count,20);
	var(classMan,"GMPreyMobEater");
	var(classWoman,"GMPreyMobEater");
	
	func(getInitialPos)
	{
		objParams();
		
		_pos = callFunc(getVar(gm_currentMode,relicObj),getModelPosition);
		_relicNearBase = _pos distance [2000,2000,10] <= 80;
		if (_relicNearBase) then {
			[2000,2000,10] vectorAdd [rand(-.1,.1),rand(-.1,1),0];
		} else {
			pick getVar(gm_currentMode,relicProbSpawnpos)
		};
		
	};
	getter_func(getInitialDir,random 360);
	
	func(getEquipment)
	{
		objParams_1(_mob);
		["Castoffs" + str randInt(1,3),_mob,INV_CLOTH] call createItemInInventory;
	};
	
	func(onAssigned)
	{
		objParams_2(_mob,_usr);
		super();
		callFuncParams(_mob,setMobFace,"");//reset face
		
		callFuncParams(_mob,generateNaming,callFunc(_mob,getRandomNamePrefix) arg "жрун");
	};
	func(onDead)
	{
		objParams_2(_mob,_usr);
		super();
		
		callFuncParams(_usr,setDeadTimeout,30);
	};
	
endclass


class(RPreyNomadLeader) extends(RPreyNomadBase)
	var(name,"Лидер кочевников");
	var(desc,"Именно ты поведёшь группу к заветной мечте.");
	func(getOtherSkills) {[
		skillrand(fight,2,6) arg
		skillrand(stealth,3,5) arg
		skillrand(sword,5,8)
	]};
	func(getEquipment)
	{
		objParams_1(_mob);
		_cloth = super();
		["GMPreyMap",_cloth] call createItemInContainer;
		["ShortSword",_mob] call createItemInInventory;
		["Torch",_mob] call createItemInInventory;
		["WoolCoat",_mob,INV_BACK] call createItemInInventory;
	};
endclass

class(RPreyNomadHealer) extends(RPreyNomadBase)
	var(name,"Пещерный лекарь");
	var(desc,"Залечит раны в пути.");
	func(getOtherSkills) {[
		skillrand(fight,1,3) arg
		skillrand(stealth,1,5) arg
		skillrand(sword,2,4) arg 
		skillrand(healing,4,8) arg
		skillrand(surgery,4,8)
	]};
	func(getEquipment)
	{
		objParams_1(_mob);
		_cloth = super();
		["ShortSword",_mob] call createItemInInventory;
		["Torch",_mob,INV_BELT] call createItemInInventory;
		
		_m = ["MedicalBag",_mob] call createItemInInventory;
		["NeedleWithThreads",_m] call createItemInContainer;
		["Syringe",_m] call createItemInContainer;
		["LiqPainkiller",_m] call createItemInContainer;
		["LiqTovimin",_m] call createItemInContainer;
		for "_i" from 0 to randInt(1,6) do {["Bandage",_m] call createItemInContainer;};
	};
endclass

class(RPreyNomadCaveman) extends(RPreyNomadBase)
	var(name,"Топорщик");
	var(desc,"Безжалостно разрубит врагов на две части.");
	func(getOtherSkills) {[
		skillrand(fight,1,3) arg
		skillrand(axe,2,6) arg 
		skillrand(throw,3,6)
	]};
	func(getEquipment)
	{
		objParams_1(_mob);
		_cloth = super();
		["BattleAxe",_mob] call createItemInInventory;
		["Torch",_mob,INV_BELT] call createItemInInventory;
		["ArmorLite",_mob,INV_ARMOR] call createItemInInventory;
	};
endclass

/*class(RPreyNomadFighter) extends(RPreyNomadBase)
	var(name,"Боевой кочевник");
	var(desc,"Молодой, шутливый да ещё и с мечом.");
endclass*/

class(RPreyNomadLighter) extends(RPreyNomadBase)
	var(name,"Светоч");
	var(desc,"Осветит путь в пещерах.");
	func(getEquipment)
	{
		objParams_1(_mob);
		_cloth = super();
		["CaveAxe",_mob] call createItemInInventory;
		["LampKerosene",_mob] call createItemInInventory;
		_bag = ["FabricBagBig1",_mob,INV_BACKPACK] call createItemInInventory;
		for "_i" from 1 to 5 do {
			["TorchDisabled",_bag] call createItemInContainer;
		};
	};
endclass

/*class(RPreyNomadDragger) extends(RPreyNomadBase)
	var(name,"Таскальщик");
	var(desc,"Такой себе боец.");
endclass*/

//monsters
class(RPreyEaterStrong) extends(RPreyEater)
	var(name,"Сильный едок");
	var(desc,"В одиночку всех уложит.");
	getter_func(getSkills,vec4(randInt(15,18),randInt(10,12),randInt(13,19),randInt(9,11))); //["_st","_iq","_dx","_ht"];
	func(getOtherSkills) {[
		skillrand(fight,5,8) arg
		skillrand(stealth,3,7)
	]};
endclass

class(RPreyEaterStandard) extends(RPreyEater)
	var(name,"Едок");
	var(desc,"Мерзкая тварь.");
	getter_func(getSkills,vec4(randInt(13,16),randInt(10,12),randInt(12,15),randInt(9,11))); //["_st","_iq","_dx","_ht"];
	func(getOtherSkills) {[
		skillrand(fight,5,8) arg
		skillrand(stealth,3,7)
	]};
endclass