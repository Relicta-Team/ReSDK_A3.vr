// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include "..\GameMode.h"
#include "Okopovo.h"

class(ROkopovoComBase) extends(BasicRole)
	var(classMan,"MobOkopovoGamemode");
	func(canTakeInLobby)
	{
		objParams_2(_cliObj,_canPrintErrors);
		private _isMan = ((getVar(_cliObj,charSettings) get "gender") == 0);
		if (!_isMan) exitWith {
			if (_canPrintErrors) then {
				callFuncParams(_cliObj,localSay,"На войне не место цацам..." arg "error");
			};
			false
		};
		true
	};
	func(canVisibleAfterStart)
	{
		objParams();
		#ifdef EDITOR
			true
		#else
			false
		#endif
	};
	var(count,1);
	var(side,"na");

	getter_func(getSkills,vec4(randInt(10,15),randInt(10,12),randInt(11,15),randInt(10,13))); //["_st","_iq","_dx","_ht"];
	func(getOtherSkills) {[
		skillrand(pistol,5,8) arg
		skillrand(fight,2,4) arg
		skillrand(rifle,3,5) arg
		skillrand(stealth,1,2)
	]};

	func(getEquipment)
	{
		objParams_1(_mob);
		callFuncParams(_mob,setHunger,randInt(60,70));
	};

	func(onDeadBasic)
	{
		objParams_2(_mob,_usr);
		super();
		callFuncParams(_usr,setDeadTimeout,60 * 2);
		callFuncParams(gm_currentMode,removeMobInSide,_mob arg getSelf(side));
	};
	
	func(onAssigned)
	{
		objParams_2(_mob,_usr);
		super();
		callFuncParams(gm_currentMode,addMobInSide,_mob arg getSelf(side));
		if (getSelf(side) == "na") then {
			setVar(gm_currentMode,leaderNA,_mob);
		} else {
			setVar(gm_currentMode,leaderIZ,_mob);
		};

		callFuncParams(_mob,addPerk,"PerkOneHandShooter");

		callFuncParams(_mob,addAction,"Война" arg "Командовать" arg "war_eventPrikaz");
	};

	func(createDocsInCloth)
	{
		objParams_2(_cl,_mob);
		[this,_cl,_mob] call global_function_rOkopovo_createDocs;
	};

endclass

//Правила ролей: сторона закрепляется за человеком
class(ROkopovoCombatRole) extends(BasicRole)
	var(name,"Роль стороны");
	var(classMan,"MobOkopovoGamemode");
	func(getInitialPos)
	{
		objParams();
		if (getSelf(side)=="iz") then {
			vec2("izbase",DP) call getRandomSpawnPosByName
		} else {
			vec2("nabase",DP) call getRandomSpawnPosByName
		};
	};
	getter_func(getInitialDir,random 360);
	getter_func(canTakeInLobby,false);
	func(canVisibleAfterStart)
	{
		objParams_1(_cliObj);
		/*
			Клиент видит:
				Если его нет в списке привязки - всех
				или
				только роли 
		*/
		#ifdef EDITOR
			true
		#else
			
			if (gm_roundDuration <= getVar(gm_currentMode,unblockAllRoles)) exitWith {false};
			if (((getVar(_cliObj,charSettings) get "gender") != 0)) exitWith {false};//only mans

			if !array_exists(getVar(gm_currentMode,clientsInSide),getVar(_cliObj,name)) then {
				//check if new user is balanced
				private _sides = getVar(gm_currentMode,mobsInSide);
				//если мобов меньше или равно 
				count (_sides get getSelf(side)) <= (count (_sides get ifcheck(getSelf(side)=="na","iz","na")))
				//true
			} else {
				(getVar(gm_currentMode,clientsInSide) get getVar(_cliObj,name)) == getSelf(side)
			};
		#endif
	};
	var(count,1);
	var(deadTimeout,60*2);
	func(onDeadBasic)
	{
		objParams_2(_mob,_usr);
		super();
		callFuncParams(_usr,setDeadTimeout,getSelf(deadTimeout));
		callFuncParams(gm_currentMode,removeMobInSide,_mob arg getSelf(side));
	};
	
	func(onAssigned)
	{
		objParams_2(_mob,_usr);
		super();
		if !array_exists(getVar(gm_currentMode,clientsInSide),getVar(_usr,name)) then {
			getVar(gm_currentMode,clientsInSide) set [getVar(_usr,name),getSelf(side)];
		};

		callFuncParams(_mob,addPerk,"PerkOneHandShooter");

		callFuncParams(gm_currentMode,addMobInSide,_mob arg getSelf(side));
	};
	
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
		callFuncParams(_mob,setHunger,randInt(60,70));
	};

	func(createDocsInCloth)
	{
		objParams_2(_cl,_mob);
		[this,_cl,_mob] call global_function_rOkopovo_createDocs;
	};
endclass
/*
	Ист
		Сержант
			Жнец - предводитель ватаги - небольшого отряда.
		Рядовой
		_cl = [pick["NomadCloth14","NomadCloth3"],_mob,INV_CLOTH] call createItemInInventory;
			Оборвыш - обычный боец
			Лазутчик - разведчик
			Боевой раб - выдрисированный и сильный боевой раб
			Черпак - готовщик еды
			Целитель - лечит раны
	НА
		Сержант
			Сержант
		Рядовой
			Солдат - обычный солдат
			Разведчик - мастер ловушек и скрытности
			Штурмовик - сильный боец с автоматом
			Полевой кухарь - имеет навыки готовки
			Фронтовой медик - навыки и лекарства
*/
class(ROkopovoCombatSergant) extends(ROkopovoCombatRole)
	var(side,"na");
	var(count,4);
	var(deadTimeout,60*4);
	getter_func(getSkills,vec4(randInt(10,13),randInt(10,12),randInt(10,13),randInt(10,13))); //["_st","_iq","_dx","_ht"];
	func(getOtherSkills) {[
		skillrand(pistol,5,8) arg
		skillrand(fight,4,7) arg
		skillrand(rifle,5,8)
	]};

	func(canVisibleAfterStart)
	{
		objParams_1(_cliObj);
		private _baseRule = super();
		if (!_baseRule) exitWith {false};
		private _cnt = count (getVar(gm_currentMode,sergantesInSide) get getSelf(side));
		_cnt <= getVar(gm_currentMode,maxSergantsPerTime); 
	};

	func(getEquipment)
	{
		objParams_1(_mob);
		super();
		if (getSelf(side) == "na") then {
			_w = ["Shotgun",_mob] call createItemInInventory;
			callFuncParams(_w,createAmmoInMagazine,"AmmoShotgun");

			["HatBeret",_mob,INV_HEAD] call createItemInInventory;
			_cl = ["GreatcoatBlack",_mob,INV_CLOTH] call createItemInInventory;
			callSelfParams(createDocsInCloth,_cl arg _mob);
			["HalfHandedSword",_mob,INV_BELT] call createItemInInventory;
		} else {
			_w = ["Shotgun",_mob] call createItemInInventory;
			callFuncParams(_w,createAmmoInMagazine,"AmmoShotgun");

			["HatShemag",_mob,INV_HEAD] call createItemInInventory;
			_cl = ["ArmyCloth5",_mob,INV_CLOTH] call createItemInInventory;
			callSelfParams(createDocsInCloth,_cl arg _mob);
			["ShortSword",_mob,INV_BACK] call createItemInInventory;
		};
	};

	func(onAssigned)
	{
		objParams_2(_mob,_usr);
		super();
		private _squad = new(OkopovoSergantesSquad);
		callFuncParams(_squad,onMakeSquad,_mob arg getSelf(side));
		callFuncParams(_mob,addFirstJoinMessage," <t size='1.4'>Я командир своего отряда - <t size='1.8' color='#7109AA'>" + getVar(_squad,squadName)+"</t></t>");

		callFuncParams(_mob,addAction,"Война" arg "Приказ отряду" arg "war_eventPrikaz");
		setVar(_mob,__gmokopovo_mysquad,_squad);
	};

	func(onDeadBasic)
	{
		objParams_2(_mob,_usr);
		super();
		private _squads = (getVar(gm_currentMode,sergantesInSide) get getSelf(side));
		private _idx = -1;
		_idx = _squads findif {equals(getVar(_x,commander),_mob)};
		if (_idx != -1) then {
			(getVar(gm_currentMode,deadSquads) get getSelf(side)) pushBack (_squads select _idx);
			_squads deleteAt _idx;
		};
	};
endclass

class(ROkopovoCombatCommonRole) extends(ROkopovoCombatRole)
	
	func(canVisibleAfterStart)
	{
		objParams_1(_cliObj);
		private _baseRule = super();
		if (!_baseRule) exitWith {false};
		private _sq = callFuncParams(gm_currentMode,getOptimalSquad,getSelf(side));
		if isNullReference(_sq) exitwith {false};
		true
	};
	
	var(count,999);
	func(getEquipment)
	{
		objParams_1(_mob);
		super();

		if isTypeOf(this,ROkopovoCombatTroopRole) then {
			_w = ["RifleAuto",_mob] call createItemInInventory;
			callFuncParams(_w,createMagazine,"MagazineAutoLoaded");
		} else {
			_w = [pick["RifleFinisherSmall","RifleFinisher"],_mob] call createItemInInventory;
			callFuncParams(_w,createMagazine,"MagazineFinisherLoaded");
		};


		if (getSelf(side) == "na") then {
			_cl = ["NewArmyStdCloth",_mob,INV_CLOTH] call createItemInInventory;
			callSelfParams(createDocsInCloth,_cl arg _mob);
			if prob(60) then {
				[
				pick["HatOldUshanka","HatUshanka","WorkerCap","WorkerCoolCap","HatGrayOldUshanka"],
				_mob,INV_HEAD
				] call createItemInInventory;
			};
		} else {
			["HatShemag",_mob,INV_HEAD] call createItemInInventory;
			_cl = [pick["NomadCloth14","NomadCloth3"],_mob,INV_CLOTH] call createItemInInventory;
			callSelfParams(createDocsInCloth,_cl arg _mob);
			
		};
	};

	func(onAssigned)
	{
		objParams_2(_mob,_usr);
		super();

		//Находим доступный сквад
		private _squad = callFuncParams(gm_currentMode,getOptimalSquad,getSelf(side));
		if isNullReference(_squad) exitWith {
			//не должно срабатывать
			callFuncParams(_mob,addFirstJoinMessage," <t size='2.5'>Мне нужно прибиться к одному из существующих отрядов...</t>");	
		};
		callFuncParams(_squad,onAddMob,_mob arg getSelf(side));
		private _fmt = format["<t size='1.8'>Я член отряда <t color='#7109AA'>%2</t>. Мой командир - <t color='#7109AA'>%1</t></t>",callFuncParams(getVar(_squad,commander),getNameEx,"кто"),getVar(_squad,squadName)];
		callFuncParams(_mob,addFirstJoinMessage,_fmt);
	};

	func(onDeadBasic)
	{
		objParams_2(_mob,_usr);
		super();
		private _squad = getVar(_mob,__gmokopovo_mysquad);
		if (!isNullVar(_squad) && {!isNullReference(_squad)}) then {
			array_remove(getVar(_squad,soldiers),_mob)
		};
	};
endclass

//strelok
class(ROkopovoCombatRiflemanRole) extends(ROkopovoCombatCommonRole)
	var(side,"na");
	var(count,999);
	var(deadTimeout,60);
	getter_func(getSkills,vec4(randInt(9,11),randInt(9,11),randInt(10,12),randInt(9,12))); //["_st","_iq","_dx","_ht"];
	func(getOtherSkills) {[
		skillrand(pistol,1,3) arg
		skillrand(fight,3,5) arg
		skillrand(rifle,4,7)
	]};
endclass

class(ROkopovoCombatScoutRole) extends(ROkopovoCombatCommonRole)
	var(side,"na");
	var(count,999);
	var(deadTimeout,60*2);
	getter_func(getSkills,vec4(randInt(7,10),randInt(9,11),randInt(11,13),randInt(8,11))); //["_st","_iq","_dx","_ht"];
	func(getOtherSkills) {[
		skillrand(pistol,1,3) arg
		skillrand(fight,1,3) arg
		skillrand(rifle,1,5) arg
		skillrand(stealth,6,8) arg
		skillrand(stealing,6,8) arg
		skillrand(traps,4,6)
	]};
endclass

class(ROkopovoCombatTroopRole) extends(ROkopovoCombatCommonRole)
	var(side,"na");
	var(count,6);
	var(deadTimeout,60*3);
	getter_func(getSkills,vec4(randInt(12,14),randInt(7,9),randInt(7,11),randInt(12,14))); //["_st","_iq","_dx","_ht"];
	func(getOtherSkills) {[
		skillrand(pistol,1,3) arg
		skillrand(fight,5,8) arg
		skillrand(rifle,1,2) 
	]};
endclass

class(ROkopovoCombatCookRole) extends(ROkopovoCombatCommonRole)
	var(side,"na");
	var(count,999);
	var(deadTimeout,60*2);
	getter_func(getSkills,vec4(randInt(7,10),randInt(7,9),randInt(9,11),randInt(10,11))); //["_st","_iq","_dx","_ht"];
	func(getOtherSkills) {[
		skillrand(cooking,7,10) arg
		skillrand(fight,1,2) arg
		skillrand(farming,1,4) arg
		skillrand(knife,1,4) arg
		skillrand(rifle,1,2) 
	]};
endclass

class(ROkopovoCombatHealerRole) extends(ROkopovoCombatCommonRole)
	var(side,"na");
	var(count,999);

	getter_func(getSkills,vec4(randInt(7,9),randInt(10,13),randInt(11,12),10)); //["_st","_iq","_dx","_ht"];
	func(getOtherSkills) {[
		skillrand(pistol,1,2) arg
		skillrand(fight,1,3) arg
		skillrand(rifle,1,2) arg
		skillrand(healing,4,8) arg
		skillrand(surgery,4,8) arg
		skillrand(chemistry,2,6)
	]};
endclass