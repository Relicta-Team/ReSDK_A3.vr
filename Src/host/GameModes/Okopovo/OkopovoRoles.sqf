// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include "..\GameMode.h"
#include "Okopovo.h"

class(ROkopvoComIZ) extends(ROkopovoComBase)
	
	var(name,"Атаман");
	var(desc,"Вожак стаи");
	var(side,"iz");
	getter_func(getInitialPos,vec2("izcmd",DP) call getSpawnPosByName);
	getter_func(getInitialDir,random 360);


	func(getEquipment)
	{
		objParams_1(_mob);
		super();
		["HatShemag",_mob,INV_HEAD] call createItemInInventory;
		["RespiratorMask",_mob,INV_FACE] call createItemInInventory;
		_cl = ["ROkopovoArmyCloth5IsCMD",_mob,INV_CLOTH] call createItemInInventory;
		callSelfParams(createDocsInCloth,_cl arg _mob);
		["WoolCoat",_mob,INV_BACK] call createItemInInventory;
		_w = ["PistolPBM",_mob,INV_BELT] call createItemInInventory;
		callFuncParams(_w,createMagazine,"MagazinePBMLoaded");
	};
	

	
endclass

	class(ROkopovoArmyCloth5IsCMD) extends(ArmyCloth5)
		var(armaClass,"rds_uniform_Woodlander3");
	endclass

class(ROkopvoComNA) extends(ROkopovoComBase)
	
	var(name,"Капитан");
	var(desc,"Командир взвода");
	var(side,"na");
	
	getter_func(getInitialPos,vec2("nacmd",DP) call getSpawnPosByName);
	getter_func(getInitialDir,random 360);
	getter_func(getSkills,vec4(randInt(10,15),randInt(10,12),randInt(11,15),randInt(10,13))); //["_st","_iq","_dx","_ht"];

	func(getOtherSkills) {[
		skillrand(pistol,5,8) arg
		skillrand(fight,4,7) arg
		skillrand(rifle,5,8) arg
		skillrand(stealth,0,2)
	]};

	func(getEquipment)
	{
		objParams_1(_mob);
		super();
		["HatArmyCap",_mob,INV_HEAD] call createItemInInventory;
		_cl = ["GreatcoatWhiteBrown",_mob,INV_CLOTH] call createItemInInventory;
		callSelfParams(createDocsInCloth,_cl arg _mob);

		callFuncParams(_cl,createItemInContainer,"MagazinePistolHandmadeLoaded" arg 2);
		_w = ["PistolHandmade",_mob,INV_BELT] call createItemInInventory;
		setVar(_w,name,"Гравированный ""Тряхун""");
		setVar(_w,desc,"Выдаётся за особые заслуги перед Новой Армией. На рукоятке выгравированы буквы ""НА"".");
		callFuncParams(_w,createMagazine,"MagazinePistolHandmadeLoaded");
	};
	
endclass

class(ROkopovoCombatSergantNA) extends(ROkopovoCombatSergant)
	var(name,"Сержант");
	var(desc,"Командир отряда Новой Армии");
	var(side,"na");
	var(count,10);
endclass

class(ROkopovoCombatSergantIZ) extends(ROkopovoCombatSergant)
	var(name,"Жнец");
	var(desc,"Предводитель ватаги - небольшой группы");
	var(side,"iz");
	var(count,10);
endclass
//---------------------------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------------------------
class(ROkopovoCombatRiflemanRoleNA) extends(ROkopovoCombatRiflemanRole)
	var(name,"Солдат");
	var(desc,"Рядовой боец");
	var(side,"na");
endclass
class(ROkopovoCombatRiflemanRoleIZ) extends(ROkopovoCombatRiflemanRole)
	var(name,"Червь");
	var(desc,"Вооруженный оборванец");
	var(side,"iz");
endclass

class(ROkopovoCombatScoutRoleNA) extends(ROkopovoCombatScoutRole)
	var(name,"Разведчик");
	var(desc,"Мастер ловушек и скрытности");
	var(side,"na");
endclass
class(ROkopovoCombatScoutRoleIZ) extends(ROkopovoCombatScoutRole)
	var(name,"Лазутчик");
	var(desc,"Мерзкий проныра");
	var(side,"iz");
endclass

class(ROkopovoCombatTroopRoleNA) extends(ROkopovoCombatTroopRole)
	var(name,"Штурмовик");
	var(desc,"Сильный боец");
	var(side,"na");
endclass
class(ROkopovoCombatTroopRoleIZ) extends(ROkopovoCombatTroopRole)
	var(name,"Боевой раб");
	var(desc,"Выдрисированный боевой раб");
	var(side,"iz");
endclass

class(ROkopovoCombatCookRoleNA) extends(ROkopovoCombatCookRole)
	var(name,"Полевой кухарь");
	var(desc,"Отвечает за провиант и готовку еды");
	var(side,"na");
endclass
class(ROkopovoCombatCookRoleIZ) extends(ROkopovoCombatCookRole)
	var(name,"Черпак");
	var(desc,"Готовщик съестного");
	var(side,"iz");
endclass

class(ROkopovoCombatHealerRoleNA) extends(ROkopovoCombatHealerRole)
	var(name,"Санитар");
	var(desc,"Фронтовой медик Новой Армии");
	var(side,"na");
endclass
class(ROkopovoCombatHealerRoleIZ) extends(ROkopovoCombatHealerRole)
	var(name,"Целитель");
	var(desc,"Истязательский лекарь");
	var(side,"iz");
endclass