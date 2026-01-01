// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\GameMode.h>

#define __isOldGM (callFunc(gm_currentMode,getClassName)=="GMSaloon")
#define __skipIfOldGM if __isOldGM exitWith {null};

class(BasicRoleSaloon) extends(BasicRole)
	var(isKeyRole,false);
	var(canStealMoneyBank,false);
	var(randomHunger,null);
	func(onAssigned)
	{
		objParams_2(_mob,_usr);
		super();
		if getSelf(isKeyRole) then {
			getVar(gm_currentMode,keyRolesList) pushBack _mob;
		};
		if !isNull(getSelf(randomHunger)) then {
			getSelf(randomHunger)params["_min","_max"];
			callFuncParams(_mob,setHunger,randInt(_min,_max));
		};
	};
	func(onDead)
	{
		objParams_2(_mob,_usr);
		super();

		if (getVar(gm_currentMode,deadMobs) <= 4) then {
			callFuncParams(_usr,setDeadTimeout,60 * 2);
		};
		
		modVar(gm_currentMode,deadMobs, + 1);
	};
endclass

class(RBarmenSaloon) extends(BasicRoleSaloon)
	var(isKeyRole,true);
	getter_func(isMainRole,true);
	var(name,"Владелец ""Дыры""");
	var(desc,"Наверное"+comma+" самый богатый человек в Злачнике.");
	var(reputationNeed,rolerep(1,10,10));
	var(count,1);
	getter_func(canTakeInLobby,true);
	getter_func(canVisibleAfterStart,false);
	
	getter_func(getInitialPos,vec3(3470.38,3607.12,22.7355));
	getter_func(getInitialDir,91);

	//Новая точка спавна барника
	getter_func(spawnLocation,	__skipIfOldGM	"pos:RBarmenSaloon");
	getter_func(connectedTo,"ref:RBarmenSaloonBed");	

	getter_func(getSkills,vec4(randInt(10,13),randInt(9,10),randInt(9,10),randInt(7,10)));
	func(getOtherSkills) {[
		skillrand(cooking,2,6) arg
		skillrand(fight,3,5) arg
		skillrand(shotgun,4,7)
	]};

	func(getEquipment)
	{
		objParams_1(_mob);
		private _cloth = ["VestAndTie",_mob,INV_CLOTH] call createItemInInventory;
		private _keyOwn = ["bar" arg "barsuper" arg "barowner"];
		regKeyInUniform(_cloth,_keyOwn,"Ключ от Дыры");
	};
endclass


class(RGromilaSaloon) extends(BasicRoleSaloon)
	var(name,"Вышибала");
	var(desc,"Обеспечьте безопасность бара Дыра.");
	var(reputationNeed,rolerep(1,10,8));
	var(count,1);
	getter_func(getInitialPos,vec3(3482.18,3603.51,22.7188));
	getter_func(getInitialDir,270);

	//новая точка спавна вышыбалы
	getter_func(spawnLocation,	__skipIfOldGM	"pos:RGromilaSaloon");
	getter_func(connectedTo,"ref:RGromilaSaloonBed");
	
	var(randomHunger,vec2(60,80));
	
	getter_func(getSkills,vec4(randInt(14,16),randInt(6,8),randInt(10,13),randInt(9,11)));
	func(getOtherSkills) {[
		skillrand(fight,5,6) arg
		skillrand(baton,2,4) arg
		skillrand(pistol,4,6)
	]};
	getter_func(canTakeInLobby,true);
	getter_func(canVisibleAfterStart,false);

	func(getEquipment)
	{
		objParams_1(_mob);
		private _cloth = ["GromilaCloth",_mob,INV_CLOTH] call createItemInInventory;
		regKeyInUniform(_cloth,["bar" arg "bargrom" arg "barback"],"Ключ Вышибалы");
		callFuncParams(_cloth,initMoney,randInt(4,10));
		
		private _pistol = ["PistolPBM",_mob,INV_BELT] call createItemInInventory;
		setVar(_pistol,name,"""Дозор""");
		callFuncParams(_pistol,createMagazine,"MagazinePBMLoaded");
		["MagazinePBMLoaded",_cloth] call createItemInContainer;
		private _ammo = ["AmmoPBM",_cloth] call createItemInContainer;
		callFuncParams(_ammo,initCount,randInt(5,20));
	};
	
endclass

class(RCookSaloon) extends(BasicRoleSaloon)
	var(name,"Работник Бара");
	var(desc,"Готовит еду и разносит напитки.");
	var(reputationNeed,rolerep(1,4,6));
	var(count,3);
	getter_func(getInitialPos,vec3(3473.81,3616.92,12.8096) vectorAdd vec3(rand(-0.1,0.1),rand(-0.1,0.1),0));
	getter_func(getInitialDir,354);

	//Новые точки спавна работников бара
	getter_func(spawnLocation,	__skipIfOldGM	"rpos:RCookSaloon");

	var(randomHunger,vec2(80,100));
	getter_func(canTakeInLobby,true);
	getter_func(canVisibleAfterStart,false);

	getter_func(getSkills,vec4(randInt(8,10),randInt(7,9),randInt(9,11),randInt(10,11)));
	func(getOtherSkills) {[
		skillrand(cooking,4,8) arg
		skillrand(fight,1,2) arg
		skillrand(farming,1,4) arg
		skillrand(knife,1,4)
	]};

	func(getEquipment)
	{
		objParams_1(_mob);
		["CookerCap",_mob,INV_HEAD] call createItemInInventory;
		private _cloth = ["CookerCloth",_mob,INV_CLOTH] call createItemInInventory;
		private _keyOwn = ["bar" arg "barback"];
		regKeyInUniform(_cloth,_keyOwn,"Ключ от бара");
		callFuncParams(_cloth,initMoney,randInt(1,10));
	};
endclass

class(RCitizenSaloon) extends(BasicRoleSaloon)
	var(name,"Работяга");
	var(desc,"Утро всегда тяжёлое... Но день-то будет нормальный! Надо выпить!");
	var(reputationNeed,rolerep(0,5,0));
	var(count,4 + 3 + 5);
	var(canStealMoneyBank,true);
	getter_func(getInitialDir,callFuncParams(gm_currentMode,handleRandomDir,357));
	getter_func(getInitialPos,callFuncParams(gm_currentMode,handleRandomPos,vec3(3441.08,3591.36,18.3334)));
		
	//Новые точки спавна работяг	
	getter_func(spawnLocation,	__skipIfOldGM	"rpos:RCitizenSaloon");

	getter_func(canTakeInLobby,true);
	getter_func(canVisibleAfterStart,true);
	var(randomHunger,vec2(50,70));
	getter_func(getSkills,vec4(randInt(8,17),randInt(8,11),randInt(8,11),randInt(8,11)));
	func(getOtherSkills) {[
		skillrand(fight,0,6) arg
		skillrand(throw,0,5) arg
		skillrand(stealth,0,7) arg
		skillrand(chemistry,0,3) arg
		skillrand(engineering,0,4) arg
		skillrand(healing,0,3) arg
		skillrand(cooking,0,4) arg
		skillrand(farming,0,4)
	]};

	func(getEquipment)
	{
		objParams_1(_mob);
		private _cloth = ["CitizenCloth" + str randInt(1,22),_mob,INV_CLOTH] call createItemInInventory;
		callFuncParams(_cloth,initMoney,randInt(5,10));
		
		if prob(70) then {
			[
			pick["HatOldUshanka","HatUshanka","WorkerCap","WorkerCoolCap","HatGrayOldUshanka"],
			_mob,INV_HEAD
			] call createItemInInventory;
		};
		if prob(40) then {
			private _pistol = ["PistolPBM",_mob,INV_BELT] call createItemInInventory;
			callFuncParams(_pistol,createMagazine,"MagazinePBMLoaded");
			["MagazinePBMLoaded",_cloth] call createItemInContainer;
			private _ammo = ["AmmoPBM",_cloth] call createItemInContainer;
			callFuncParams(_ammo,initCount,randInt(2,20));
		} else {
			private _weapon = [pick["Crowbar","WorkingAxe"],_mob,INV_BELT] call createItemInInventory;
			private _wname = pick["Рабочий инструмент","Прибор","Работяжья приблуда"];
			setVar(_weapon,name,_wname);
		};
	};
endclass

class(RAssasinSaloon) extends(BasicRoleSaloon)
	var(name,"Наёмный убийца");
	var(desc,"Выполнив очередной заказ"+comma+" ты решаешь сходить в местный бар и немного расслабиться.");
	var(count,1);
	var(reputationNeed,rolerep(0,10,8));
	var(canStealMoneyBank,true);
	getter_func(getInitialPos,callFuncParams(gm_currentMode,handleRandomPos,vec3(3444.87,3669.56,17.7313)));
	getter_func(getInitialDir,callFuncParams(gm_currentMode,handleRandomDir,267));

	//Новые точки спавна наёмного убийцы
	getter_func(spawnLocation,	__skipIfOldGM	"rpos:RAssasinSaloon");

	var(randomHunger,vec2(60,80));
	getter_func(getSkills,vec4(randInt(13,14),randInt(10,12),randInt(14,15),randInt(11,13)));
	func(getOtherSkills) {[
		skillrand(healing,2,4) arg
		skillrand(surgery,1,3) arg
		skillrand(pistol,2,5) arg
		skillrand(throw,6,8) arg
		skillrand(fight,5,7) arg
		skillrand(stealth,6,8) arg
		skillrand(sword,4,8)
	]};

	func(getEquipment)
	{
		objParams_1(_mob);
		
		["FaceCoverMask",_mob,INV_FACE] call createItemInInventory;
		["HoodAssasinSaloon",_mob,INV_HEAD] call createItemInInventory;
		private _cloth = ["NomadCloth23",_mob,INV_CLOTH] call createItemInInventory;
		private _shot = ["ShotgunMini",_cloth] call createItemInContainer;
		callFuncParams(_shot,createAmmoInMagazine,"AmmoShotgunMini");
		
		["MatchBox",_cloth] call createItemInContainer;
		callFuncParams(_cloth,initMoney,randInt(5,7));
		private _arm = ["ArmorLite",_mob,INV_ARMOR] call createItemInInventory;
		private _l = ["ShortSword",_mob,INV_BELT] call createItemInInventory;
		setVar(_l,name,"""Коронный""");
		_l = ["ShortSword",_mob,INV_BACK] call createItemInInventory;
		setVar(_l,name,"""Похоронный""");
		private _b = ["SmallBackpack",_mob,INV_BACKPACK] call createItemInInventory;
		for "_i" from 1 to 5 do {
			["Lockpick",_arm] call createItemInContainer;
		};
		for "_i" from 1 to 2 do {
			["CampfireCreator",_b] call createItemInContainer;
		};
		for "_i" from 1 to 3 do {
			["Trap",_b] call createItemInContainer;
		};
	};
	
	getter_func(canTakeInLobby,true);
	getter_func(canVisibleAfterStart,true);

endclass

	class(HoodAssasinSaloon) extends(HoodBrown)
		var(armaClass,"TIOW_Cultist_Hood");
	endclass

class(RTorgSaloon) extends(BasicRoleSaloon)
	var(name,"Торгаш");
	var(desc,"Торгует всяким хламом и оружием.");
	var(count,1);
	var(reputationNeed,rolerep(1,7,7));
	var(isKeyRole,true);
	getter_func(getInitialPos,vec3(3421.8,3674.8,19.4215));
	getter_func(getInitialDir,181);

	//Новая точка спавна торгаша
	getter_func(spawnLocation,	__skipIfOldGM	"pos:RTorgSaloon");
	getter_func(connectedTo,"ref:RTorgSaloonBed");

	var(randomHunger,vec2(70,100));
	getter_func(getSkills,vec4(randInt(9,12),randInt(11,13),randInt(8,11),randInt(8,12)));
	func(getOtherSkills) {[
		skillrand(pistol,1,3) arg
		skillrand(fight,1,5) arg
		skillrand(stealth,2,4)
	]};
	
	func(getEquipment)
	{
		objParams_1(_mob);
		private _cloth = ["MerchantClothSaloon",_mob,INV_CLOTH] call createItemInInventory;
		regKeyInUniform(_cloth,["torg"],"Ключ торгаша");
		callFuncParams(_cloth,initMoney,randInt(8,30));
		["HatRedSaloon",_mob,INV_HEAD] call createItemInInventory;
	};
	
	getter_func(canTakeInLobby,true);
	getter_func(canVisibleAfterStart,true);
	
	func(onAssigned)
	{
		objParams_2(_mob,_usr);
		super();
		if isTypeOf(getVar(gm_currentMode,task),Saloon_Task_Portfel) then {
			private _m = "Ты прослышал, что у владельца местного бара есть целый чемодан со звяками. Эх... Вот бы тебе такой чемодан получить...";
			callFuncParams(_mob,addFirstJoinMessage,setstyle(_m,style_redbig));
		};
	};
	
endclass

	class(MerchantClothSaloon) extends(MerchantCloth)
		var(armaClass,"rds_uniform_citizen3");
		var(name,"Торгашинские шмотки");
		var(desc,"Красиво и богато...");
	endclass
	
	class(HatRedSaloon) extends(HatUshanka)
		var(armaClass,"H_Cap_red");
		var(name,"Кепарик");
		var(desc,"Такие только у самых крутых!");
	endclass

class(RDoctorSaloon) extends(BasicRoleSaloon)
	var(name,"Лекарь"); 
	var(desc,"Помогает побитым и покалеченым"+comma+" но только за звяки");
	getter_func(spawnLocation,"pos:RDoctorSaloon");
	getter_func(connectedTo,"ref:RDoctorSaloonBed");

	getter_func(getSkills,"st:7-8; dx:9-11; iq:12-14; ht:9-11");
	func(getOtherSkills) {
		"healing:5;" 
		+"surgery:5;"
		+"chemistry:5;"
	};

	func(getEquipment)
	{
		objParams_1(_mob);
		private _cloth = ["DoctorCloth",_mob,INV_CLOTH] call createItemInInventory;
		setVar(_cloth,name,"Лекарские одеяния");
		["Rag",_cloth] call createItemInContainer;
		["HatGrayOldUshanka",_mob,INV_HEAD] call createItemInInventory;
		private _keyOwn = ["RDoctorSaloonKey"];
		regKeyInUniform(_cloth,_keyOwn,"Лекарский ключ");
		private _shot = ["Revolver",_mob,INV_BELT] call createItemInInventory; // Оружие на слоте пояса
		callFuncParams(_shot,createAmmoInMagazine,"AmmoRevolver"); // Вызов метода, создающий патроны в "магазине" дробовика
		_ammo = ["AmmoRevolver",_cloth] call createItemInContainer; // Патроны в инвентаре
		callFuncParams(_ammo,initCount,randInt(4,10));
	};
endclass

class(RTrampSaloon) extends(BasicRoleSaloon)
	var(name,"Бродяга");
	var(desc,"Нелёгкая судьба занесла тебя в этот ужасный район. Ну хоть сходи в местный бар. Говорят"+comma+" там отличная выпивка.");
	var(count,4 + 3 + 5);
	var(reputationNeed,rolerep(0,6,0));
	var(canStealMoneyBank,true);
	getter_func(getInitialPos,callFuncParams(gm_currentMode,handleRandomPos,vec3(3437.66,3712.57,17.7246)));
	getter_func(getInitialDir,callFuncParams(gm_currentMode,handleRandomDir,174));

	//Новые точки спавна бродяг
	getter_func(spawnLocation,	__skipIfOldGM	"rpos:RTrampSaloon");

	var(randomHunger,vec2(30,50));
	getter_func(getSkills,vec4(randInt(13,14),randInt(10,12),randInt(14,15),randInt(11,13)));
	func(getOtherSkills) {[
		skillrand(pistol,2,5) arg
		skillrand(throw,6,8) arg
		skillrand(fight,5,7) arg
		skillrand(stealth,6,8) arg
		skillrand(sword,4,8)
	]};

	func(getEquipment)
	{
		objParams_1(_mob);
		
		[pick["Candle","Torch"],_mob] call createItemInInventory;
		
		private _cloth = ["NomadCloth" + str randInt(1,15),_mob,INV_CLOTH] call createItemInInventory;
		callFuncParams(_cloth,initMoney,randInt(2,8));
		if prob(60) then {
			[
			pick["HatOldUshanka","HatUshanka","WorkerCap","WorkerCoolCap","HatGrayOldUshanka"],
			_mob,INV_HEAD
			] call createItemInInventory;
		};
		if prob(60) then {
			[
			pick["BlackBandannaMask","BrownBandannaMask"],
			_mob,INV_FACE
			] call createItemInInventory;
		};
		if prob(50) then {
			private _pistol = ["PistolPBM",_mob,INV_BELT] call createItemInInventory;
			callFuncParams(_pistol,createMagazine,"MagazinePBMLoaded");
			["MagazinePBMLoaded",_cloth] call createItemInContainer;
			private _ammo = ["AmmoPBM",_cloth] call createItemInContainer;
			callFuncParams(_ammo,initCount,randInt(2,20));
		} else {
			private _pistol = ["Revolver",_mob,INV_BELT] call createItemInInventory;
			private _ammo = ["AmmoRevolver",_cloth] call createItemInContainer;
			callFuncParams(_ammo,initCount,randInt(2,20));
		};
		if prob(40) then {
			["WoolCoat",_mob,INV_BACK] call createItemInInventory;
		};
	};
	
	getter_func(canTakeInLobby,true);
	getter_func(canVisibleAfterStart,true);

endclass

class(RBanditMainSaloon) extends(BasicRoleSaloon)
	var(isKeyRole,true);
	var(name,"Пахан");
	getter_func(isMainRole,true);
	var(desc,"Сей страх среди мужиков и управляй братками. Вы должны сделать свои грязные дела.");
	var(reputationNeed,rolerep(1,10,10));
	var(count,1);
	getter_func(getInitialPos,vec3(3367.15,3705.29,21.0036));
	getter_func(getInitialDir,272);

	//Новая точка спавна пахана
	getter_func(spawnLocation,	__skipIfOldGM	"pos:RBanditMainSaloon");
	getter_func(connectedTo,"ref:RBanditMainSaloonChair");

	var(randomHunger,vec2(60,70));
	getter_func(getSkills,vec4(randInt(10,13),randInt(11,12),randInt(10,13),randInt(9,12)));
	func(getOtherSkills) {[
		skillrand(healing,2,4) arg
		skillrand(surgery,1,3) arg
		skillrand(pistol,2,5) arg
		skillrand(fight,5,7) arg
		skillrand(stealth,6,8) arg
		skillrand(lockpicking,3,4)
	]};

	func(getEquipment)
	{
		objParams_1(_mob);
		private _cloth = ["BanditCommanderSaloonCloth",_mob,INV_CLOTH] call createItemInInventory;
		private _w = ["RifleFinisherSmall",_mob] call createItemInInventory;
		setVar(_w,name,"""Братан""");
		callFuncParams(_w,createMagazine,"MagazineFinisherLoadedExtendedSaloon");
		
		_w = ["WoolCoat",_mob,INV_BACK] call createItemInInventory;
		setVar(_w,name,"Чёткая шуба");
		
		
	};
	
	getter_func(canTakeInLobby,true);
	getter_func(canVisibleAfterStart,false);
	
	func(onAssigned)
	{
		objParams_2(_mob,_usr);
		super();
		private _mes = format["<t size='1.4' color='#FF7400' font='RobotoCondensed'>%1</t>",callFunc(getVar(gm_currentMode,task),getDesc)];
		callFuncParams(_mob,addFirstJoinMessage,_mes);
		modVar(gm_currentMode,countAliveBandits, + 1);
		
		getVar(gm_currentMode,allAliveBandits) pushBack _mob;
	};
	
	func(onDead)
	{
		objParams_2(_mob,_usr);
		super();
		modVar(gm_currentMode,countAliveBandits, - 1);
		
		private _list = getVar(gm_currentMode,allAliveBandits);
		_list deleteAt (_list find _mob);
	};

endclass

	class(MagazineFinisherLoadedExtendedSaloon) extends(MagazineFinisherLoaded)
		var(maxCount,10);
		var(name,"Магазин Навертыша (увеличенный)");
	endclass
	
	class(BanditSaloonCloth) extends(CaretakerCloth)
		var(armaClass,"Skyline_Character_U_CivilC_06_F");
		var(name,"Кожак");
	endclass
	
	class(Bandit2SaloonCloth) extends(CaretakerCloth)
		var(armaClass,"rds_uniform_Woodlander4");
		var(name,"Серьёзная одежда");
	endclass
	
	class(BanditCommanderSaloonCloth) extends(CaretakerCloth)
		var(armaClass,"Skyline_Character_U_Chasseur_02_F");
		var(name,"Паханка");
	endclass

class(RBanditMiniSaloon) extends(BasicRoleSaloon)
	var(name,"Шестёрка");
	var(desc,"Вы часть группировки ""Рука"". Слушайте своего Пахана и будете купаться в бряках.");
	var(count,4);
	var(reputationNeed,rolerep(1,7,6));
	var(randomHunger,vec2(60,70));
	func(getInitialPos)
	{
		objParams();
		//Если командир заспавнен то лочим чела в тюряге
		if getVar(gm_currentMode,isSBSCommandirSpawned) then {
			vec3(3361.84,3619.38,23.8667) vectorAdd vec3(rand(-0.2,0.2),rand(-0.2,0.2),0)
		} else {
			vec3(3362.2,3705.94,21.0036) vectorAdd vec3(rand(-0.2,0.2),rand(-0.2,0.2),0)
		};
	};
	getter_func(getInitialDir,ifcheck(getVar(gm_currentMode,isSBSCommandirSpawned),88,272));

//Новые точки спавна шестёрок в общаке
	func(spawnLocation)
	{
		objParams();
			__skipIfOldGM	
		if getVar(gm_currentMode,isSBSCommandirSpawned) then {
			//Новая точка спавна шестерок если заспавнен командин СБС
			"rpos:RBanditMiniSaloonJail"
		} else {
			if(getSelf(count)==3) exitWith{"pos:RBanditMiniSaloon4"};
			if(getSelf(count)==2) exitWith{"pos:RBanditMiniSaloon3"};
			if(getSelf(count)==1) exitWith{"pos:RBanditMiniSaloon2"};
			"pos:RBanditMiniSaloon2"
		};
	};

	func(connectedTo)
	{
		objParams();
		if getVar(gm_currentMode,isSBSCommandirSpawned) then {
		null}
		else {
		if(getSelf(count)==3) exitWith{"ref:RBanditMiniSaloonBed4"};
		if(getSelf(count)==2) exitWith{"ref:RBanditMiniSaloonBed3"};
		if(getSelf(count)==1) exitWith{"ref:RBanditMiniSaloonBed2"};
		"ref:RBanditMiniSaloonBed2"
		}	
	};

	getter_func(getSkills,vec4(randInt(10,13),randInt(11,12),randInt(10,13),randInt(9,12)));
	func(getOtherSkills) {[
		skillrand(healing,1,2) arg
		skillrand(surgery,1,2) arg
		skillrand(pistol,2,5) arg
		skillrand(fight,5,7) arg
		skillrand(stealth,6,8) arg 
		skillrand(lockpicking,2,3)
	]};

	func(getEquipment)
	{
		objParams_1(_mob);
		private _cloth = [pick["BanditSaloonCloth","Bandit2SaloonCloth"],_mob,INV_CLOTH] call createItemInInventory;
		
		if !getVar(gm_currentMode,isSBSCommandirSpawned) then {
			if prob(30) then {
				private _w = ["RifleAuto",_mob] call createItemInInventory;
				callFuncParams(_w,createMagazine,"MagazineAutoLoaded");
				for "_i" from 1 to 2 do {
					["MagazineAutoLoaded",_cloth] call createItemInContainer;
				};
			} else {
				if prob(50) then {
					private _w = ["SawedOff",_mob] call createItemInInventory;
					callFuncParams(_w,createAmmoInMagazine,"AmmoShotgun");
					for "_i" from 1 to 2 do {
						private _am = ["AmmoShotgun",_cloth] call createItemInContainer;
						callFuncParams(_am,initCount,randInt(8,20));
					};
				} else {
					private _w = ["RifleSVT",_mob] call createItemInInventory;
					callFuncParams(_w,createMagazine,"MagazineSVTLoaded");
					for "_i" from 1 to 2 do {
						["MagazineSVTLoaded",_cloth] call createItemInContainer;
					};
				};
			};
		} else {
			["Candle",_mob] call createItemInInventory;
		};
		
		
		if prob(40) then {
			[
			pick["HatOldUshanka","HatUshanka","WorkerCap","WorkerCoolCap","HatGrayOldUshanka"],
			_mob,INV_HEAD
			] call createItemInInventory;
		};

	};
	
	getter_func(canTakeInLobby,true);
	getter_func(canVisibleAfterStart,true);
	
	func(onAssigned)
	{
		objParams_2(_mob,_usr);
		super();
		modVar(gm_currentMode,countAliveBandits, + 1);
		
		if getVar(gm_currentMode,isSBSCommandirSpawned) then {
			{
				callFuncParams(_x,localSay,setstyle("У нас же браток на нарах... Надо его спасти! Он в заложниках на базе у ополчения...",style_redbig) arg "info");
			} foreach getVar(gm_currentMode,allAliveBandits);
		};
		
		
		getVar(gm_currentMode,allAliveBandits) pushBack _mob;
		
		if getVar(gm_currentMode,isSBSCommandirSpawned) then {
			//закрываем и лочим решетку второго этажа
			private _reshPos = [3365.11,3621.77,23.8667];
			private _resh = ["SteelGridDoor",_reshPos,3,false,true] call getGameObjectOnPosition;
			if isNullReference(_resh) exitWith {};
			if getVar(_resh,isOpen) then {
				callFuncParams(_resh,setDoorOpen,false arg true);
			};
			if !getVar(_resh,isLocked) then {
				callFuncParams(_resh,setDoorLock,true);
			};
			
			private _task = getVar(gm_currentMode,task);
			setVar(_task,needFreeBratok,true);
			getVar(_task,bratki) pushBackUnique _mob;
		};
	};
	
	func(onDead)
	{
		objParams_2(_mob,_usr);
		super();
		modVar(gm_currentMode,countAliveBandits, - 1);
		
		private _list = getVar(gm_currentMode,allAliveBandits);
		_list deleteAt (_list find _mob);
	};

endclass


//охры


class(RSBSComannderSaloon) extends(BasicRoleSaloon)
	var(isKeyRole,true);
	var(name,"Начальник Ополчения");
	var(desc,"Глава ополчения Грязноямска. Огранизуйте своих подчинённых и следуйте указам Головы.");
	var(count,1);
	var(reputationNeed,rolerep(1,8,7));
	getter_func(getInitialPos,vec3(3352.27,3629.16,23.8996));
	getter_func(getInitialDir,85);

	//Новая точка спавна начальника ополчения
	getter_func(spawnLocation,	__skipIfOldGM	"pos:RSBSComannderSaloon");
	getter_func(connectedTo,"ref:RSBSComannderSaloonChair");

	getter_func(getSkills,vec4(randInt(12,14),randInt(10,12),randInt(12,15),randInt(13,15)));
	func(getOtherSkills) {[
		skillrand(pistol,2,5) arg
		skillrand(rifle,2,4) arg
		skillrand(shotgun,1,5) arg
		skillrand(throw,2,4) arg
		skillrand(fight,4,6) arg
		skillrand(baton,2,5) arg
		skillrand(sword,2,6)
	]};

	func(getEquipment)
	{
		objParams_1(_mob);
		private _cloth = ["VeteranCloth",_mob,INV_CLOTH] call createItemInInventory;
		regKeyInUniform(_cloth,["turma" arg "police"],"Ключ ополчения");
		callFuncParams(_cloth,initMoney,randInt(10,30));

		["ArmorHeavy",_mob,INV_ARMOR] call createItemInInventory;
		["CombatHat",_mob,INV_HEAD] call createItemInInventory;
		["ShortSword",_mob,INV_BELT] call createItemInInventory;
	};
	
	func(onAssigned)
	{
		objParams_2(_mob,_usr);
		super();
		private _mes = "<t size='1.4' color='#F60018' font='RobotoCondensed'>Поступил вызов - бар Дыра. Собрать бойцов, снарядить их и выдвинуться на место.</t>";
		callFuncParams(_mob,addFirstJoinMessage,_mes);
		setVar(gm_currentMode,isSBSCommandirSpawned,true);
		
		{
			delete(_x);
		} foreach getVar(gm_currentMode,protectedWalls);
	};
	
	getter_func(canTakeInLobby,false);
	getter_func(canVisibleAfterStart,getVar(gm_currentMode,deadMobs) > 0); //если есть хотя-бы 1 смерть

endclass

class(RSBSRookieSaloon) extends(BasicRoleSaloon)
	var(name,"Ополченец");
	var(desc,"Хранитель правопорядка. Находится на дежурстве в отделении Злачника.");
	var(count,5+2);
	var(reputationNeed,rolerep(1,7,6));
	getter_func(getInitialPos,vec3(3363.56,3629.32,23.8653));
	getter_func(getInitialDir,85);

	//Новые точки спавна ополченцев
	func(spawnLocation)
	{
		objParams();
			__skipIfOldGM	
		if(getSelf(count)==6) exitWith{"pos:RSBSRookieSaloon1"};
		if(getSelf(count)==5) exitWith{"pos:RSBSRookieSaloon1"};
		if(getSelf(count)==4) exitWith{"pos:RSBSRookieSaloon2"};
		if(getSelf(count)==3) exitWith{"pos:RSBSRookieSaloon2"};
		if(getSelf(count)==2) exitWith{"pos:RSBSRookieSaloon3"};
		if(getSelf(count)==1) exitWith{"pos:RSBSRookieSaloon3"};		
		"pos:RSBSRookieSaloon4"
	};

	func(connectedTo)
	{
		objParams();
		if(getSelf(count)==6) exitWith{"ref:RSBSRookieSaloonBed1"};
		if(getSelf(count)==5) exitWith{"ref:RSBSRookieSaloonBed1"};
		if(getSelf(count)==4) exitWith{"ref:RSBSRookieSaloonBed2"};
		if(getSelf(count)==3) exitWith{"ref:RSBSRookieSaloonBed2"};
		if(getSelf(count)==2) exitWith{"ref:RSBSRookieSaloonBed3"};
		if(getSelf(count)==1) exitWith{"ref:RSBSRookieSaloonBed3"};
		"ref:RSBSRookieSaloonBed4"	
	};	

	getter_func(getSkills,vec4(randInt(12,14),randInt(10,12),randInt(12,15),randInt(13,15)));
	func(getOtherSkills) {[
		skillrand(pistol,2,5) arg
		skillrand(rifle,5,6) arg
		skillrand(shotgun,1,5) arg
		skillrand(throw,2,4) arg
		skillrand(fight,4,6) arg
		skillrand(baton,2,5) arg
		skillrand(sword,2,6)
	]};

	func(getEquipment)
	{
		objParams_1(_mob);
		private _cloth = ["StreakCloth",_mob,INV_CLOTH] call createItemInInventory;
		regKeyInUniform(_cloth,["turma" arg "police"],"Ключ ополчения");
		callFuncParams(_cloth,initMoney,randInt(5,20));
		["ArmorMedium",_mob,INV_ARMOR] call createItemInInventory;
		["CombatHat",_mob,INV_HEAD] call createItemInInventory;
		["ShortSword",_mob,INV_BELT] call createItemInInventory;
	};
	
	getter_func(canTakeInLobby,false);
	getter_func(canVisibleAfterStart,getVar(gm_currentMode,isSBSCommandirSpawned));

endclass