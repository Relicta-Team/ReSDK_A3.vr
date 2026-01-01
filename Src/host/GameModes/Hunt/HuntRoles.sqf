// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\GameMode.h>

#define DP vec3(3926.05,3961.74,9.64964)

//! bomz1 - bomz6 - точки для бомжей

class(RHuntHunter) extends(BasicRole)
	
	var(name,"Охотник");
	var(desc,"Он пришёл за бомжами.");

	getter_func(canTakeInLobby,true);
	getter_func(canVisibleAfterStart,false);
	var(count,1);
	
	getter_func(getInitialPos,vec2("izcmd",DP) call getSpawnPosByName);
	getter_func(getInitialDir,random 360);
	getter_func(getSkills,vec4(randInt(13,15),randInt(10,12),randInt(12,16),randInt(10,12))); //["_st","_iq","_dx","_ht"];

	func(getOtherSkills) {[
		skillrand(axe,5,8) arg
		skillrand(fight,4,7) arg
		skillrand(shotgun,6,9) arg
		skillrand(stealth,2,4)
	]};

	func(getEquipment)
	{
		objParams_1(_mob);
		["HatShemag",_mob,INV_HEAD] call createItemInInventory;
		_cl = ["NomadCloth12",_mob,INV_CLOTH] call createItemInInventory;
		setVar(_cl,name,"Охотка");
		for "_i" from 1 to randInt(2,5) do {
			["Bandage",_cl] call createItemInContainer;
		};

		["FlashlightLoaded",_mob] call createItemInInventory;
		private _shot = ["Shotgun",_mob] call createItemInInventory;
		callFuncParams(_shot,createAmmoInMagazine,"AmmoShotgun");
		setVar(_shot,name,"""Король пафелей""");

		_arm = ["ArmorMedium",_mob,INV_ARMOR] call createItemInInventory;
		for "_i" from 1 to randInt(2,5) do {
			_ammo = ["AmmoShotgun",_arm] call createItemInContainer;
			callFuncParams(_ammo,initCount,randInt(10,20));
		};

		private _weapon = [pick["WorkingAxe"],_mob,INV_BELT] call createItemInInventory;
		setVar(_weapon,name,"""Бомжерезка""");

		callFuncParams(_mob,setHunger,randInt(40,70));
	};
	
	func(onDeadBasic)
	{
		objParams_2(_mob,_usr);
		super();
		callFuncParams(_usr,setDeadTimeout,60 * 5);

		modVar(gm_currentMode,aliveHumans, - 1);
	};
	
	func(onAssigned)
	{
		objParams_2(_mob,_usr);
		super();

		modVar(gm_currentMode,aliveHumans, + 1);
	};
	
endclass

class(RHuntHunterLate) extends(RHuntHunter)
	getter_func(canTakeInLobby,false);
	getter_func(canVisibleAfterStart,gm_roundduration >= (60*5));
	var(count,2);
	var(desc,"Ты пришёл на помощь другим охотникам.");
endclass

class(RHuntBum) extends(BasicRole)
	var(count,8);

	var(name,"Бомжик");
	var(desc,"Просто пытается как-то выжить.");

	getter_func(canTakeInLobby,true);
	getter_func(canVisibleAfterStart,gm_roundduration <= (60*8));

	getter_func(getInitialPos,vec2("bomz" + str randInt(1,6),DP) call getSpawnPosByName);
	getter_func(getInitialDir,random 360);
	getter_func(getSkills,vec4(randInt(7,11),randInt(3,7),randInt(5,11),randInt(3,8))); //["_st","_iq","_dx","_ht"];

	getter_func(getOtherSkills,[]);

	func(getEquipment)
	{
		objParams_1(_mob);
		private _cloth = ["Castoffs" + str randInt(1,3),_mob,INV_CLOTH] call createItemInInventory;
		if prob(60) then {
			[
		 		pick["HatOldUshanka","HatUshanka","WorkerCap","WorkerCoolCap","HatGrayOldUshanka"],
		 		_mob,INV_HEAD
		 	] call createItemInInventory;
		};

		if prob(40) then {
			["Candle",_mob,INV_HAND_R] call createItemInInventory;
		};
		
		if prob(20) then {
			["PistolPBM",_mob,INV_BELT] call createItemInInventory;
		};

		callFuncParams(_mob,setHunger,randInt(10,40));
	};

	func(onDeadBasic)
	{
		objParams_2(_mob,_usr);
		super();
		callFuncParams(_usr,setDeadTimeout,60 * 3);

		modVar(gm_currentMode,ingameBums, - 1);
		modVar(gm_currentMode,aliveHumans, - 1);
	};
	
	func(onAssigned)
	{
		objParams_2(_mob,_usr);
		super();

		modVar(gm_currentMode,ingameBums, + 1);
		modVar(gm_currentMode,aliveHumans, + 1);
	};
endclass


class(RHunterEater) extends(BasicRole)
	var(name,"Жрун");
	var(desc,"Что это за звуки в тех развалинах? Надо проверить...");
	//У жрунов нет душ...
	//var(returnInLobbyAfterDead,true);
	getter_func(canStoreNameAndFaceForValidate,false);
	
	getter_func(canTakeInLobby,false);
	getter_func(canVisibleAfterStart,gm_roundDuration > (60*13));
	var(count,2);
	var(classMan,"GMPreyMobEater");
	var(classWoman,"GMPreyMobEater");
	
	func(getInitialPos)
	{
		objParams();
		
		vec2("event",DP) call getSpawnPosByName
		
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
		
		modVar(gm_currentMode,ingameEaters, + 1);
	};
	func(onDeadBasic)
	{
		objParams_2(_mob,_usr);
		super();
		callFuncParams(_usr,setDeadTimeout,60 * 4);
		modVar(gm_currentMode,ingameEaters, - 1);
	};
	
endclass

class(RHuntNACleaner) extends(BasicRole)
	
	var(name,"Боец Новой Армии");
	var(desc,"Боец отряда зачистки. Задача - занять и зачистить район развалин.");

	getter_func(canTakeInLobby,false);
	#ifdef EDITOR
	getter_func(canVisibleAfterStart,true);
	#else
	getter_func(canVisibleAfterStart,gm_roundDuration > (60*10));
	#endif
	var(count,4);
	
	getter_func(getInitialPos,vec2("event",DP) call getSpawnPosByName);
	getter_func(getInitialDir,random 360);
	getter_func(getSkills,vec4(randInt(13,15),randInt(10,12),randInt(12,16),randInt(10,12))); //["_st","_iq","_dx","_ht"];

	func(getOtherSkills) {[
		skillrand(sword,2,5) arg
		skillrand(fight,4,7) arg
		skillrand(rifle,6,9) arg
		skillrand(stealth,2,4)
	]};

	func(getEquipment)
	{
		objParams_1(_mob);
		["CombatHat",_mob,INV_HEAD] call createItemInInventory;
		_cl = ["NewArmyStdCloth",_mob,INV_CLOTH] call createItemInInventory;
		setVar(_cl,name,"Охотка");
		for "_i" from 1 to randInt(2,5) do {
			["Bandage",_cl] call createItemInContainer;
		};

		private _shot = ["RifleAuto",_mob] call createItemInInventory;
		callFuncParams(_shot,createMagazine,"MagazineAutoLoaded");

		_arm = ["ArmorHeavy",_mob,INV_ARMOR] call createItemInInventory;
		for "_i" from 2 to randInt(4,5) do {
			_ammo = ["MagazineAutoLoaded",_arm] call createItemInContainer;
			callFuncParams(_ammo,initCount,randInt(10,20));
		};
		private _weapon = ["ShortSword",_mob,INV_BELT] call createItemInInventory;

		callFuncParams(_mob,setHunger,randInt(60,90));
	};
	
	func(onDeadBasic)
	{
		objParams_2(_mob,_usr);
		super();
		callFuncParams(_usr,setDeadTimeout,60 * 7);

		modVar(gm_currentMode,ingameNA, - 1);
		modVar(gm_currentMode,aliveHumans, - 1);
	};
	
	func(onAssigned)
	{
		objParams_2(_mob,_usr);
		super();

		modVar(gm_currentMode,ingameNA, + 1);
		modVar(gm_currentMode,aliveHumans, + 1);
	};
	
endclass