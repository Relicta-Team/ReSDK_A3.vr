// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\GameMode.h>

//Получает массив ролей с мобами
gm_getStationRoleList = {
	getVar("IRStationRole" call gm_getRoleObject,stationMobs)
};

class(IRStationRole) extends(BasicRole)
	var_array(stationMobs); //станционные мобы

	func(onAssigned)
	{
		objParams_2(_mob,_usr);
		callSuper(BasicRole,onAssigned);
		getVar("IRStationRole" call gm_getRoleObject,stationMobs) pushBack _mob;

		getVar("IRStationRole" call gm_getRoleObject,playedClients) pushBackUnique _usr;

		private _ideology = getVar(gm_currentMode,ideology);
		if !isNullReference(_ideology) then {
			callFuncParams(_ideology,onApplyToMob,_mob arg false);
		};
	};

	getter_func(getInitialDir,random 360);
	getter_func(getInitialPos,vec3(3789.56,3779.98,28.9044));

	var(playedClients,[]); //unical clients

	func(onDeadBasic)
	{
		objParams_2(_mob,_usr);
		callFuncParams(_usr,setDeadTimeout,60 * 7.5); //station mobs dead timeout
	};
	
	func(isClientPlayedInStation)
	{
		objParams_1(_usr);
		_usr in getVar("IRStationRole" call gm_getRoleObject,playedClients)
	};

	func(canVisibleAfterStart)
	{
		objParams_1(_cliObj);
		!callSelfParams(isClientPlayedInStation,_cliObj);
	};

	getter_func(needDiscordRoles,["Forsaken" arg "S.R.I." arg "Cool man"]);

endclass

class(RTramp) extends(BasicRole)
	var(name,"Бродяга");
	getter_func(canTakeInLobby,false);
	getter_func(canVisibleAfterStart,false);
	var(count,999999);
endclass

class(RTail) extends(BasicRole)
	var(name,"Хвост");
	var(desc,"Безработный бездельник");
	#ifndef EDITOR
	getter_func(canTakeInLobby,false);
	getter_func(canVisibleAfterStart,false);
	#else
	func(onAssigned)
	{
		objParams_2(_mob,_usr);

		callSuper(IRStationRole,onAssigned);

		[_mob,13,12,16,9] call gurps_initSkills;

		_virtCloth = [pick getAllObjectsTypeOf(Cloth),_mob,INV_CLOTH] call createItemInInventory;
		_virtArmor = ["Breastplate",_mob,INV_ARMOR] call createItemInInventory;
		["CaveAxe",_mob,INV_BELT] call createItemInInventory;

		callFuncParams(_mob,setInitialPos,_pos);
		callFuncParams(_mob,setDir,_dir);

		if (!isMultiplayer) then {
			call debug_asyncCode;
		};
	};

	#endif
	var(count,99999);
endclass

#define regKeyInUniform(cloth,owners,name__) callFuncParams(cloth,createItemInContainer,"Key" arg null arg null arg [vec3("var","keyOwner",owners) arg vec3("var","name",name__)])

class(RHead) extends(IRStationRole)
	var(name,"Голова");
	var(desc,"Правьте Грязноямском мудро. Слава Голове!");
	var(reputationNeed,rolerep(1,10,10));
	getter_func(isMainRole,true);
	getter_func(getSkills,vec4(randInt(9,11),randInt(8,13),randInt(9,12),randInt(9,11)));
	func(getOtherSkills) {[
		skillrand(sword,1,2) arg
		skillrand(fight,1,3) arg
		skillrand(throw,1,2) arg
		skillrand(pistol,1,3)
	]};

	func(canTakeInLobby)
	{
		objParams_2(_cliObj,_canPrintErrors);
		if ((getVar(_cliObj,charSettings) get "gender") != 0) exitWith {
			if (_canPrintErrors) then {
				callFuncParams(_cliObj,localSay,"Доступно только для мужских персонажей." arg "error");
			};
			false
		};
		true
	};

	func(canBeFullAntag)
	{
		objParams_1(_client);
		false
	};
	func(canBeHiddenAntag)
	{
		objParams_1(_client);
		false
	};

	var(count,1);
	getter_func(getInitialPos,vec3(3744.11,3764.5,33.3969));
	getter_func(getInitialDir,180.463);
	

	func(onAssigned)
	{
		objParams_2(_mob,_usr);
		private _v = [
			(callFuncParams(_mob,getNameEx,"кто") splitString " ") select 1,
			(callFuncParams(_mob,getNameEx,"кого") splitString " ") select 1
		];
		setVar(gm_currentMode,headSecondNames,_v);

		callSuper(IRStationRole,onAssigned);
	};

	func(getEquipment)
	{
		objParams_1(_mob);
		private _cloth = ["HeadCloth",_mob,INV_CLOTH] call createItemInInventory;
		private _keyOwn = ["headup", "sobranie","headpre"];
		regKeyInUniform(_cloth,_keyOwn,"Головной ключ");
		regKeyInUniform(_cloth,["moneybank"],"Ключ от Банка");
		callFuncParams(_cloth,initMoney,randInt(7,20));
	};

	func(onStarted)
	{
		objParams();

	};

	//снимаем голову при смерти
	func(onDead)
	{
		objParams_2(_mob,_usr);
		private _robj = "RTramp" call gm_getRoleObject;
		if isNullReference(_robj) exitWith {};
		// Пускай остаётся в листе жителей
		//private _listRef = call gm_getStationRoleList;
		//_listRef deleteAt (_listRef find _mObj);
		callFuncParams(_mob,setToRole,_robj);
	};

	func(onEndgameBasic)
	{
		objParams_2(_mob,_usr);
		super();
		callSelfParams(addPoints,_mob arg _usr arg 1);
	};

endclass

class(RHeadSon) extends(IRStationRole)
	var(name,"Сын Головы");
	var(desc,"Молодой наследник правителя Грязноямска.");
	var(count,1);

	getter_func(getSkills,vec4(randInt(2,5),randInt(3,6),randInt(3,7),randInt(4,9)));
	func(getOtherSkills) {[
		skillrand(fight,0,2) arg
		skillrand(throw,1,2) arg
		skillrand(stealth,1,2)
	]};

	func(canBeFullAntag)
	{
		objParams_1(_client);
		false
	};
	func(canBeHiddenAntag)
	{
		objParams_1(_client);
		false
	};

	getter_func(getInitialPos,vec3(3748.64,3757.19,33.1959));
	getter_func(getInitialDir,353.949);

	func(canVisibleAfterStart)
	{
		objParams_1(_cliObj);
		((getVar(_cliObj,charSettings) get "gender") == 0)
		&& super()
	};

	//Можно ли взять роль в лобби. Второй параметр означает будет ли выводиться сообщение в вызываемом контексте
	func(canTakeInLobby)
	{
		objParams_2(_cliObj,_canPrintErrors);
		if ((getVar(_cliObj,charSettings) get "gender") != 0) exitWith {
			if (_canPrintErrors) then {
				callFuncParams(_cliObj,localSay,"Доступно только для мужских персонажей." arg "error");
			};
			false
		};
		true
	};

	func(onAssigned)
	{
		objParams_2(_mob,_usr);
		super();
		setVar(_mob,age,randInt(16,19));
		//берем фамилию головы
		private _fname = (callFuncParams(_mob,getNameEx,"кто") splitString " ") select 0;
		callFuncAfterParams(_mob,generateNaming,3,_fname arg getVar(gm_currentMode,headSecondNames) select 0);
	};

	func(getEquipment)
	{
		objParams_1(_mob);
		private _cloth = ["BrightRedCloth",_mob,INV_CLOTH] call createItemInInventory;
		private _keyOwn = ["headup"];
		regKeyInUniform(_cloth,_keyOwn,"Ключ от верховой");
	};


endclass

class(RWifeHead) extends(IRStationRole)
	var(name,"Жена Головы");
	var(desc,"Жена Головы.");
	var(count,1);
	getter_func(getInitialPos,vec3(3744.05,3760.24,33.3045));
	getter_func(getInitialDir,359.659);
	getter_func(getSkills,vec4(randInt(7,9),randInt(9,12),randInt(6,9),randInt(9,12))); //["_st","_iq","_dx","_ht"];
	func(getOtherSkills) {[
		skillrand(stealth,2,3)
	]};

	func(canVisibleAfterStart)
	{
		objParams_1(_cliObj);
		((getVar(_cliObj,charSettings) get "gender") == 1)
		&& super()
	};

	//Можно ли взять роль в лобби. Второй параметр означает будет ли выводиться сообщение в вызываемом контексте
	func(canTakeInLobby)
	{
		objParams_2(_cliObj,_canPrintErrors);
		if ((getVar(_cliObj,charSettings) get "gender") != 1) exitWith {
			if (_canPrintErrors) then {
				callFuncParams(_cliObj,localSay,"Доступно только для женских персонажей." arg "error");
			};
			false
		};
		true
	};

	//cloth WomanBasicCloth
	func(getEquipment)
	{
		objParams_1(_mob);

		private _cloth = ["WomanBasicCloth",_mob,INV_CLOTH] call createItemInInventory;
		setVar(_cloth,name,"Роскошная женская одежда");
		private _keyOwn = ["headup", "sobranie","headpre"];
		regKeyInUniform(_cloth,_keyOwn,"Головной ключ");
		
		callFuncParams(_cloth,initMoney,randInt(1,5));
	};

	func(onAssigned)
	{
		objParams_2(_mob,_usr);
		super();
		//берем фамилию головы
		private _fname = (callFuncParams(_mob,getNameEx,"кто") splitString " ") select 0;
		callFuncAfterParams(_mob,generateNaming,3,_fname arg getVar(gm_currentMode,headSecondNames) select 1);
	};
endclass

class(RKnut) extends(IRStationRole)
	var(name,"Кнут");
	var(desc,"Вы были выбраны самим Головой для надзора за исполнением его приказов. Они должны быть выполнены! Дайте слабину — и с утратой доверия Головы вы потеряете и столь высокое положение. Вникайте в проблемы жителей и предоставляйте Голове отчёт.");
	var(count,1);
	var(reputationNeed,rolerep(1,6,9));
	getter_func(getInitialPos,vec3(3757.2,3752.06,24.6181));
	getter_func(getInitialDir,94);

	getter_func(getSkills,vec4(randInt(11,12),11,randInt(11,13),randInt(11,12)));
	func(getOtherSkills) {[
		skillrand(fight,1,2) arg
		skillrand(throw,1,3) arg
		skillrand(pistol,1,2)
	]};

	func(getEquipment)
	{
		objParams_1(_mob);
		private _cloth = ["KnutCloth",_mob,INV_CLOTH] call createItemInInventory;
		private _keyOwn = ["minihead", "sobranie","headpre"];
		regKeyInUniform(_cloth,_keyOwn,"Ключ Кнута");
		callFuncParams(_cloth,initMoney,randInt(8,20));
	};


endclass

class(RAbbat) extends(IRStationRole)
	var(name,"Аббат");
	var(desc,"Став главой церкви Фуга делайте всё возможное"+comma+" чтобы каждый житель Грязноямска стал чем-то большим"+comma+" слившись воедино со своими страхами.");
	var(count,1);
	var(reputationNeed,rolerep(1,6,8));
	getter_func(getInitialPos,vec3(3762.35,3727.35,19.8617));
	getter_func(getInitialDir,267);

	getter_func(getSkills,vec4(randInt(8,10),randInt(10,13),randInt(8,10),10));
	func(getOtherSkills) {[
		skillrand(whip,3,5) arg
		skillrand(fight,1,2) arg
		skillrand(throw,1,3) arg
		skillrand(healing,2,3)
	]};

	func(getEquipment)
	{
		objParams_1(_mob);
		private _cloth = ["AbbatCloth",_mob,INV_CLOTH] call createItemInInventory;
		private _keyOwn = ["abbat","sobranie","headpre"];
		regKeyInUniform(_cloth,_keyOwn,"Ключ церкви страха");
		["HoodAbbat",_mob,INV_HEAD] call createItemInInventory;
		callFuncParams(_cloth,initMoney,randInt(7,20));
	};

	func(onEndgameBasic)
	{
		objParams_2(_mob,_usr);
		super();
		callSelfParams(addPoints,_mob arg _usr arg 1);
	};
endclass

class(RAbbatNovice) extends(IRStationRole)
	var(name,"Послушник");
	var(desc,"Доверенное лицо Аббата.");
	var(count,2);
	var(reputationNeed,rolerep(1,4,6));
	getter_func(getInitialPos,vec3(3760.12,3722.05,19.858));
	getter_func(getInitialDir,2.2);

	getter_func(getSkills,vec4(randInt(11,12),randInt(8,10),randInt(11,13),randInt(11,12)));
	func(getOtherSkills) {[
		skillrand(whip,2,4) arg
		skillrand(fight,1,4) arg
		skillrand(throw,1,2) arg
		skillrand(healing,1,2) arg
		skillrand(stealth,1,3)
	]};

	func(getEquipment)
	{
		objParams_1(_mob);
		private _cloth = ["CliricCloth",_mob,INV_CLOTH] call createItemInInventory;
		private _keyOwn = ["abbat"];
		regKeyInUniform(_cloth,_keyOwn,"Малый ключ церкви страха");
		["HoodClirik",_mob,INV_HEAD] call createItemInInventory;
		callFuncParams(_cloth,initMoney,randInt(1,10));
	};
endclass

class(RCaretaker) extends(IRStationRole)
	var(name,"Смотритель");
	var(desc,"Глава ополчения Грязноямска. Огранизуйте своих подчинённых и следуйте указам Головы.");
	getter_func(isMainRole,true);
	var(count,1);
	var(reputationNeed,rolerep(1,10,10));
	getter_func(getInitialPos,vec3(3820.18,3714.71,23.7711));
	getter_func(getInitialDir,182);

	getter_func(getSkills,vec4(randInt(12,14),randInt(10,12),randInt(12,15),randInt(13,15)));
	func(getOtherSkills) {[
		skillrand(surgery,0,2) arg
		skillrand(healing,0,3) arg
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
		private _cloth = ["CaretakerCloth",_mob,INV_CLOTH] call createItemInInventory;
		private _keyOwn = ["sobranie","headpre","sbshall","sbsmain","sbshome","sbsprivate","sbsweapons"];
		regKeyInUniform(_cloth,_keyOwn,"Ключ Смотрителя");
		regKeyInUniform(_cloth,["sbshall" arg "sbsmain" arg "sbshome"],"Ключ ополчения");
		callFuncParams(_cloth,initMoney,randInt(6,30));

		private _pistol = ["PistolPBM",_mob,INV_BELT] call createItemInInventory;
		setVar(_pistol,name,"Именной ПБМ");
		setVar(_pistol,desc,"На рукоятке выгравировано: """+callFuncParams(_mob,getNameEx,"кому")+" за верную службу Голове и Грязноямску!""");
		callFuncParams(_pistol,createMagazine,"MagazinePBMLoaded_NonLethal");
	};

	func(canBeFullAntag)
	{
		objParams_1(_client);
		false
	};
	func(canBeHiddenAntag)
	{
		objParams_1(_client);
		false
	};

	func(onEndgameBasic)
	{
		objParams_2(_mob,_usr);
		super();
		callSelfParams(addPoints,_mob arg _usr arg 1);
	};

endclass

class(RVeteran) extends(IRStationRole)
	var(name,"Бывалый");
	var(desc,"Боец ополчения Грязноямска. Слушайте Смотрителя"+comma+" следите за порядком.");
	var(count,3);
	var(reputationNeed,rolerep(1,9,8));
	getter_func(getInitialPos,vec3(3807.14,3711.39,25.6072));
	getter_func(getInitialDir,2);

	getter_func(getSkills,vec4(randInt(12,14),randInt(10,12),randInt(12,15),randInt(13,15)));
	func(getOtherSkills) {[
		skillrand(healing,0,3) arg
		skillrand(pistol,1,3) arg
		skillrand(throw,2,3) arg
		skillrand(fight,3,5) arg
		skillrand(baton,1,4) arg
		skillrand(sword,1,5)
	]};


	func(getEquipment)
	{
		objParams_1(_mob);
		private _cloth = ["VeteranCloth",_mob,INV_CLOTH] call createItemInInventory;
		regKeyInUniform(_cloth,["sbshall" arg "sbsmain" arg "sbshome"],"Ключ ополчения");
		callFuncParams(_cloth,initMoney,randInt(3,10));
	};

	func(canBeFullAntag)
	{
		objParams_1(_client);
		false
	};
	func(canBeHiddenAntag)
	{
		objParams_1(_client);
		false
	};
endclass

class(RStreak) extends(IRStationRole)
	var(name,"Штрих");
	var(desc,"Молодой новобранец"+comma+" недавно вступивший в ополчение. Следуйте указаниям старших и набирайтесь опыта.");
	var(count,2);
	var(reputationNeed,rolerep(1,8,7));
	getter_func(getInitialPos,vec3(3806.34,3713.02,25.6072));
	getter_func(getInitialDir,88);

	getter_func(getSkills,vec4(randInt(9,10),randInt(7,10),randInt(13,15),randInt(9,10)));
	func(getOtherSkills) {[
		skillrand(throw,1,2) arg
		skillrand(fight,1,3) arg
		skillrand(baton,1,3) arg
		skillrand(sword,1,2)
	]};


	func(onAssigned)
	{
		objParams_2(_mob,_usr);
		callSuper(IRStationRole,onAssigned);
		setVar(_mob,age,randInt(17,20));//17-20
	};

	func(getEquipment)
	{
		objParams_1(_mob);
		private _cloth = ["StreakCloth",_mob,INV_CLOTH] call createItemInInventory;
		regKeyInUniform(_cloth,["sbshall" arg "sbsmain" arg "sbshome"],"Ключ ополчения");
		callFuncParams(_cloth,initMoney,randInt(2,6));
	};

	func(canBeFullAntag)
	{
		objParams_1(_client);
		false
	};
	func(canBeHiddenAntag)
	{
		objParams_1(_client);
		false
	};
endclass

class(RBrigadir) extends(IRStationRole)
	var(name,"Бригадир");
	var(desc,"На ваши плечи ложится ответственность за электроснабжение в поселении.");
	var(count,1);
	var(reputationNeed,rolerep(1,5,6));
	getter_func(getInitialPos,vec3(3827.39,3730.21,17.052));
	getter_func(getInitialDir,178);

	getter_func(getSkills,vec4(randInt(12,13),randInt(8,10),randInt(7,9),randInt(11,13)));
	func(getOtherSkills) {[
		skillrand(engineering,4,8) arg
		skillrand(repair,4,8) arg
		skillrand(baton,1,4) arg
		skillrand(fight,1,3)
	]};

	func(getEquipment)
	{
		objParams_1(_mob);
		["BrownBandannaMask",_mob,INV_FACE] call createItemInInventory;
		private _cloth = ["BrigadirCloth",_mob,INV_CLOTH] call createItemInInventory;
		private _keyOwn = ["brig"];
		regKeyInUniform(_cloth,_keyOwn,"Ключ от генераторной");
		callFuncParams(_cloth,initMoney,randInt(2,10));

		["Crowbar",_mob,INV_HAND_R] call createItemInInventory;
	};
endclass

class(RBrigadirNovice) extends(RBrigadir)
	var(name,"Копалка");
	var(desc,"Помощник бригадира с лопатой.");
	var(count,1);

	getter_func(getInitialPos,vec3(3836.12,3728.53,17.2768));
	getter_func(getInitialDir,0);

	getter_func(getSkills,vec4(randInt(12,13),randInt(8,10),randInt(7,9),randInt(11,13)));
	func(getOtherSkills) {[
		skillrand(engineering,4,8) arg
		skillrand(repair,4,8) arg
		skillrand(baton,1,4) arg
		skillrand(fight,1,3)
	]};

	func(getEquipment)
	{
		objParams_1(_mob);
		["BrownBandannaMask",_mob,INV_FACE] call createItemInInventory;
		private _cloth = ["CitizenCloth" + str randInt(1,22),_mob,INV_CLOTH] call createItemInInventory;
		private _keyOwn = ["brig"];
		regKeyInUniform(_cloth,_keyOwn,"Ключ от генераторной");
		callFuncParams(_cloth,initMoney,randInt(2,5));

		["Shovel",_mob,INV_HAND_R] call createItemInInventory;
	};
endclass

class(RBarmen) extends(IRStationRole)
	var(name,"Барник");
	var(desc,"Владелец местного кабака.");
	var(count,1);
	var(reputationNeed,rolerep(1,4,5));
	getter_func(getInitialPos,vec3(3843.05,3776.99,22.8349));
	getter_func(getInitialDir,178);

	getter_func(getSkills,vec4(randInt(9,10),randInt(9,10),randInt(9,10),randInt(7,10)));
	func(getOtherSkills) {[
		skillrand(cooking,2,6) arg
		skillrand(fight,1,2) arg
		skillrand(shotgun,1,3)
	]};

	func(getEquipment)
	{
		objParams_1(_mob);
		private _cloth = ["BarmenCloth",_mob,INV_CLOTH] call createItemInInventory;
		private _keyOwn = ["barhome","kitchen","barpublic"];
		regKeyInUniform(_cloth,_keyOwn,"Ключ Барника");
		callFuncParams(_cloth,initMoney,randInt(5,10));

	};
endclass

class(RCook) extends(IRStationRole)
	var(name,"Кухарь");
	var(desc,"Заведует кухней при кабаке под предводительством Барника.");
	var(count,1);
	var(reputationNeed,rolerep(1,1,4));
	getter_func(getInitialPos,vec3(3841.55,3769.58,22.2065));
	getter_func(getInitialDir,0.6);

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
		if (callSelf(getClassName) == "RCook") then {
			["CookerCap",_mob,INV_HEAD] call createItemInInventory;
		};
		private _cloth = ["CookerCloth",_mob,INV_CLOTH] call createItemInInventory;
		private _keyOwn = ["kitchen","barpublic"];
		regKeyInUniform(_cloth,_keyOwn,"Ключ от бара");
		callFuncParams(_cloth,initMoney,randInt(1,6));
	};
	
endclass

class(RCookNovice) extends(RCook)
	var(name,"Поварешка");
	var(desc,"Помощник кухаря при местном баре.");
	var(count,1);
	getter_func(getInitialPos,vec3(3843.56,3769.97,22.14));
	getter_func(getInitialDir,272.168);

	getter_func(getSkills,vec4(randInt(7,10),randInt(7,9),randInt(9,11),randInt(10,11)));
	func(getOtherSkills) {[
		skillrand(cooking,2,5) arg
		skillrand(fight,1,2) arg
		skillrand(farming,1,4) arg
		skillrand(knife,1,4)
	]};

	func(canVisibleAfterStart)
	{
		objParams_1(_cliObj);
		getVar("RCook" call gm_getRoleObject,count) == 0
		&& super()
	};
endclass

class(RFarmer) extends(IRStationRole)
	var(name,"Гриблан");
	var(desc,"Вырастите грибы"+comma+"подоите мельтешат и грибланьте.");
	var(count,1);
	var(reputationNeed,rolerep(1,1,2));
	getter_func(getInitialPos,vec3(3858.93,3760.46,21.745));
	getter_func(getInitialDir,271);

	getter_func(getSkills,vec4(randInt(7,9),randInt(7,9),randInt(7,9),randInt(7,9)));
	func(getOtherSkills) {[
		skillrand(throw,1,4) arg
		skillrand(fight,1,2) arg
		skillrand(farming,4,8) arg
		skillrand(alchemy,1,5)
	]};

	func(getEquipment)
	{
		objParams_1(_mob);
		private _cloth = ["GriblanCloth",_mob,INV_CLOTH] call createItemInInventory;
		private _keyOwn = ["griblanka"];
		regKeyInUniform(_cloth,_keyOwn,"Грибланский ключ");
		regKeyInUniform(_cloth,["pump"],"Ключ от насосной");
		callFuncParams(_cloth,initMoney,randInt(1,5));
	};

endclass

/*class(RMedButcher) extends(IRStationRole)
	var(name,"Мясник");
	var(desc,"Заведует кухней при кабаке под предводительством Барника.");
	var(count,1);
endclass*/

class(RMedHealer) extends(IRStationRole)
	var(name,"Лекарь");
	var(desc,"Врачуйте тела жителей.");
	var(count,2);
	var(reputationNeed,rolerep(1,3,7));
	getter_func(getInitialPos,vec3(3799.43,3749.08,27.2053));
	getter_func(getInitialDir,273);

	getter_func(getSkills,vec4(randInt(7,9),randInt(10,13),randInt(11,13),10));
	func(getOtherSkills) {[
		skillrand(healing,4,8) arg
		skillrand(fight,1,2) arg
		skillrand(surgery,4,8) arg
		skillrand(chemistry,2,6)
	]};

	func(getEquipment)
	{
		objParams_1(_mob);
		private _cloth = ["DoctorCloth",_mob,INV_CLOTH] call createItemInInventory;
		private _keyOwn = ["medprivate","medmain","medpublic"];
		private _isLeadMedic = callSelf(getClassName) == "RMedHealer";
		if (_isLeadMedic) then {
			_keyOwn pushBack "medhome"
		};
		regKeyInUniform(_cloth,_keyOwn,ifcheck(_isLeadMedic,"Лекарский ключ","Малый лекарский ключ"));
		callFuncParams(_cloth,initMoney,randInt(2,7));
	};
endclass

class(RMedHealerNovice) extends(RMedHealer)
	var(name,"Младший лекарь");
	var(desc,"Помогайте своим учителям в нелегких врачебных делах.");
	getter_func(getInitialPos,vec3(3782.72,3752.13,27.1588));
	getter_func(getInitialDir,random 360);

	getter_func(getSkills,vec4(randInt(6,9),randInt(10,13),randInt(9,12),10));
	func(getOtherSkills) {[
		skillrand(healing,3,6) arg
		skillrand(fight,1,2) arg
		skillrand(surgery,3,6) arg
		skillrand(chemistry,2,4)
	]};

	func(canVisibleAfterStart)
	{
		objParams_1(_cliObj);
		getVar("RMedHealer" call gm_getRoleObject,count) == 0
		&& super()
	};
endclass

class(RWatchman) extends(IRStationRole)
	var(name,"Вахтер");
	var(desc,"Следит за всеми приходящими и уходящими из Грязноямска. Регистрирует жителей и следит за архивом.");
	var(count,1);
	var(reputationNeed,rolerep(1,7,5));
	getter_func(getInitialPos,vec3(3797.7,3782.94,24.502));
	getter_func(getInitialDir,273);

	getter_func(needDiscordRoles,["Gatekeeper"]);

	getter_func(getSkills,vec4(randInt(10,12),randInt(9,11),randInt(10,12),randInt(10,11)));
	func(getOtherSkills) {[
		skillrand(surgery,0,3) arg
		skillrand(healing,0,4) arg
		skillrand(repair,3,5) arg
		skillrand(fight,2,3) arg
		skillrand(pistol,2,4) arg
		skillrand(cavelore,3,6)
	]};

	func(getEquipment)
	{
		objParams_1(_mob);
		private _cloth = ["WatchmanCloth",_mob,INV_CLOTH] call createItemInInventory;
		private _keyOwn = ["gatepub","gatemain","gatepriv"];
		regKeyInUniform(_cloth,_keyOwn,"Ключ Вахтера");
		callFuncParams(_cloth,initMoney,randInt(2,7));
	};
endclass

class(RCleaner) extends(IRStationRole)
	var(name,"Уходник");
	var(desc,"Наводите чистоту и порядок в городе. Убирайте мусор с улиц и подтирайте жидкости.");
	var(count,1);
	var(reputationNeed,rolerep(1,1,2));
	getter_func(getInitialPos,vec3(3866.92,3740.38,19.8281));
	getter_func(getInitialDir,87);

	getter_func(getSkills,vec4(randInt(9,10),randInt(7,9),randInt(9,10),randInt(9,11)));
	func(getOtherSkills) {[
		skillrand(stealth,3,6) arg
		skillrand(fight,1,3) arg
		skillrand(theft,2,4)
	]};

	func(getEquipment)
	{
		objParams_1(_mob);
		private _cloth = ["CleanerCloth",_mob,INV_CLOTH] call createItemInInventory;
		regKeyInUniform(_cloth,["grave"],"Ключ Уходника");
		callFuncParams(_cloth,initMoney,randInt(0,3));
		["BrushCleaner",_mob,INV_HAND_R] call createItemInInventory;
	};
endclass

class(RMerchant) extends(IRStationRole)
	var(name,"Торгаш");
	var(desc,"Торговый наместник поселения");
	getter_func(isMainRole,true);
	var(count,1);
	var(reputationNeed,rolerep(1,4,8));
	getter_func(getInitialPos,vec3(3772.07,3783.38,27.7624));
	getter_func(getInitialDir,184);

	getter_func(getSkills,vec4(randInt(7,9),randInt(12,15),randInt(7,10),randInt(9,11)));
	func(getOtherSkills) {[
		skillrand(healing,0,4) arg
		skillrand(pistol,2,5) arg
		skillrand(fight,1,2) arg
		skillrand(knife,1,3)
	]};

	func(getEquipment)
	{
		objParams_1(_mob);
		private _cloth = ["MerchantCloth",_mob,INV_CLOTH] call createItemInInventory;
		regKeyInUniform(_cloth,["torg"],"Ключ Торгаша");
		callFuncParams(_cloth,initMoney,randInt(10,30));

		//create paper
		/*private _pipe = ["DeliveryPipe",[3772.38,3781.72,29.8349],10] call getGameObjectOnPosition;
		if !isNullReference(_pipe) then {
			private _pos = [3769.45,3782.49,28.4495];
			private _infopos = [3769.46,3783.03,28.4494];
			callFuncParams(_pipe,createMerchantHello,_pos arg _mob arg _infopos);
		};*/

		_i = ["Zvak",_mob,INV_HAND_L] call createItemInInventory;
		callFuncParams(_i,initCount,10);
		_i = ["Bryak",_mob,INV_HAND_R] call createItemInInventory;
		callFuncParams(_i,initCount,10);
	};
endclass

class(RGromila) extends(IRStationRole)
	var(name,"Громила");
	var(desc,"Решайте проблемы Торгаша силой и берегите его товары.");
	var(count,1);
	var(reputationNeed,rolerep(1,6,4));
	getter_func(getInitialPos,vec3(3767.77,3780,24.2999));
	getter_func(getInitialDir,88);

	getter_func(getSkills,vec4(randInt(12,13),randInt(8,9),randInt(11,12),randInt(10,12)));
	func(getOtherSkills) {[
		skillrand(fight,2,4) arg
		skillrand(baton,1,3) arg
		skillrand(stealth,2,4)
	]};

	func(getEquipment)
	{
		objParams_1(_mob);
		private _cloth = ["GromilaCloth",_mob,INV_CLOTH] call createItemInInventory;
		regKeyInUniform(_cloth,["torg"],"Ключ Громилы");
		callFuncParams(_cloth,initMoney,randInt(1,4));
	};
endclass

class(RCitizen) extends(IRStationRole)
	var(name,"Обывала");
	var(desc,"Ничем не примечательный житель Грязноямска.");
	var(count,13); //Должно совпадать с количеством домов
	var(reputationNeed,rolerep(1,0,0));
	getter_func(getInitialDir,random 360);

	getter_func(getSkills,vec4(randInt(8,11),randInt(8,11),randInt(8,11),randInt(8,11)));
	func(getOtherSkills) {[
		skillrand(fight,0,6) arg
		skillrand(throw,0,5) arg
		skillrand(stealth,0,5) arg
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
		setSelf(lastCloth,_cloth);
	};
	var(lastCloth,nullPtr);

	var(lastHome,[]); //сюда заносится объект дома с данными

	//выбирает рандомный дом и записывает его в lastHome
	func(pickHome)
	{
		objParams();
		private _homes = callSelf(Homes);
		if (count _homes == 0) exitwith {
			setSelf(lastHome,[]);
		};

		private _randIdx = randInt(0,count _homes - 1);
		setSelf(lastHome,_homes deleteAt _randIdx);
	};

	func(onAssigned)
	{
		objParams_2(_mob,_usr);

		if getSelf(firstPick) then {
			setSelf(firstPick,false);
		};
		callSelf(pickHome); //init next home

		private _cloth = getSelf(lastCloth);
		private _keyRef = getSelf(lastHome) select 1;
		if (!isNullVar(_keyRef)) then {
			regKeyInUniform(_cloth,[_keyRef],"Ключ от дома");
		};
		if !isNullVar(_cloth) then {
			callFuncParams(_cloth,initMoney,randInt(1,5));
		};

		callSuper(IRStationRole,onAssigned);

		getSelf(clients) pushBackUnique _usr;
	};

	func(getInitialPos)
	{
		objParams();
		if getSelf(firstPick) then {
			callSelf(pickHome);
		};
		assert(count getSelf(lastHome) > 0);
		getSelf(lastHome) select 0
	};

	var(firstPick,true);

	var(__homesRef,null);

	func(Homes)
	{
		objParams();
		if isNull(getSelf(__homesRef)) then {
			private _dat = [
				//нижний ряд центр
				[[3812.77,3753.24,24.5879],"home_1"],
				[[3813,3757.11,24.5983],"home_2"],
				//левая полоса 1 этаж
				[[3806.77,3764.15,24.5862],"home_3"],
				[[3811.38,3764.53,24.5898],"home_4"],
				[[3817.17,3764.14,24.6217],"home_5"],
				//левая полоса 2 этаж
				[[3806.18,3764.43,27.6529],"home_6"],
				[[3811.34,3764.21,27.6816],"home_7"],
				[[3817.07,3764.25,27.6816],"home_8"],
				//центр 2 этаж
				[[3810.26,3758.69,27.6289],"badhome_1"],
				[[3810.07,3757.16,27.651],"badhome_2"],
				[[3814.89,3756.64,27.5851],"badhome_3"],
				[[3813.75,3753.06,27.5879],"badhome_4"],
				[[3810.37,3751.65,27.589],"badhome_5"]
			];
			setSelf(__homesRef,_dat);
		};

		getSelf(__homesRef)
	};

	var_array(clients);

	func(canVisibleAfterStart)
	{
		objParams_1(_cliObj);
		private _existsHomes = !isNull(getSelf(__homesRef)) && {count getSelf(__homesRef) > 0};
		!array_exists(getSelf(clients),_cliObj)
		&& super()
		&& _existsHomes
	};

endclass

class(RBum) extends(BasicRole)
	var(name,"Бомжик");
	var(desc,"Пещерный недочеловек.");
	var(count,9);
	var(reputationNeed,rolerep(0,0,0));
	getter_func(getInitialDir,88);
	getter_func(getInitialPos,callSelf(pickPos); getSelf(lastPos));

	getter_func(getSkills,vec4(randInt(6,15),randInt(6,15),randInt(6,15),randInt(6,15)));
	func(getOtherSkills) {[
		skillrand(fight,1,6) arg
		skillrand(theft,1,4) arg
		skillrand(stealth,4,7)
	]};

	var(__posesList,null);
	var(lastPos,[]);

	getter_func(needDiscordRoles,["Dweller"]);

	func(canVisibleAfterStart)
	{
		objParams_1(_cliObj);
		private _hasBums = count callSelf(Poses) > 0;
		gm_roundDuration >=
		ifcheck(!callFuncParams(_cliObj,hasDiscordRole,"Forsaken"),1,t_asMin(5))
		&& _hasBums
	};

	func(getEquipment)
	{
		objParams_1(_mob);
		private _cloth = ["Castoffs" + str randInt(1,3),_mob,INV_CLOTH] call createItemInInventory;
		if prob(25) then {
			["HatOldUshanka",_mob,INV_HEAD] call createItemInInventory;
		};

		["Torch",_mob,INV_HAND_R] call createItemInInventory;
	};

	func(pickPos)
	{
		objParams();
		private _homes = callSelf(Poses);
		private _randIdx = randInt(0,count _homes - 1);
		setSelf(lastPos,_homes deleteAt _randIdx);
	};

	func(onAssigned)
	{
		objParams_2(_mob,_usr);

		callSuper(BasicRole,onAssigned);

		callFuncParams(_mob,setHunger,randInt(20,40));
	};

	func(Poses)
	{
		objParams();
		if isNull(getSelf(__posesList)) then {
			private _dat = [
				[3824,3850.29,24.0271],
				[3833.33,3868.98,24.204],
				[3817.43,3854.08,24.4883], //[3822.57,3883.1,23.9169],!broken pos
				[3839.97,3861.5,24.0861],
				[3832.68,3859.35,24.7087],
				[3850.02,3849.9,24.2201],
				[3840.46,3861.62,27.5295],
				[3828.9,3837.7,27.6718],
				[3850,3845.6,26.6419]
			];
			setSelf(__posesList,_dat);
		};
		getSelf(__posesList);
	};

endclass

class(RTestEmbark) extends(RHead)
	var(name,"Пещерник");
	var(desc,"Для тестов");
	//Они не готовы...
	getterconst_func(isEmbarkRole,true);

endclass

/// --------------------------
class(REaterStation) extends(RPreyEater)
	var(name,"Жрун");
	var(desc,"Ужасный монстр");
	
	getter_func(getSkills,vec4(randInt(13,16),randInt(10,12),randInt(12,15),randInt(9,11))); //["_st","_iq","_dx","_ht"];
	func(getOtherSkills) {[
		skillrand(fight,5,8) arg
		skillrand(stealth,3,7)
	]};
	getter_func(needDiscordRoles,["Dweller"]);
	var(count,9);
	func(onAssigned)
	{
		objParams_2(_mob,_usr);
		super();
		setVar(_mob,sniffDistance,200);
	};
	func(canVisibleAfterStart)
	{
		objParams_1(_cliObj);
		// #ifdef EDITOR
		// if (true) exitwith {true};
		// #endif
		if (isTypeOf(getVar(gm_currentMode,ideology),GMStationIdeologyCavecity)
			&& gm_roundDuration >= t_asMin(10)
		) exitwith {true};
		getVar(gm_currentMode,countDead) >= 6
	};
	func(getInitialPos)
	{
		objParams();
		if (getVar(gm_currentMode,countDead) >= 9) then {
			["rndloc"] call getRandomSpawnPosByName
		} else {
			["rndcave"] call getRandomSpawnPosByName
		};
		
	};
endclass

class(RNomadDirtpit) extends(BasicRole)

	func(constructor)
	{
		objParams();
		callSelfAfter(_firstInitNomadRole,2);
	};

	func(_firstInitNomadRole)
	{
		objParams();
		callSelf(nextNomadRole);
		if (isNull(getSelf(currentNomadRole)) || {isNullReference(getSelf(currentNomadRole))}) then {
			["Current nomad role not setupped %1",callSelf(getClassName)] call logError;
		};
	};

	var(name,"Кочевник");
	var(desc,"Вы перебрались в окрестности Грязноямска в поисках лучшей жизни. Может именно вам повезет попасть в прекрасный и чистый городок.");
	getter_func(canTakeInLobby,false);
	func(canVisibleAfterStart)
	{
		objParams_1(_cliObj);
		not_equals(["kochevniki" arg 0] call getSpawnPosByName,0) &&
		#ifdef EDITOR
		true
		#else
		gm_roundDuration >= 
		ifcheck(!callFuncParams(_cliObj,hasDiscordRole,"Forsaken"),t_asMin(1),t_asMin(10))
		#endif

		//Чтобы кочевник с дробовиком не заспавнился без него...
		&& callFunc(gm_currentMode,isPickedIdeology)
	};
	var(count,999);
	getter_func(needDiscordRoles,["Dweller"]);
	
	getter_func(getInitialPos,(["kochevniki"] call getSpawnPosByName)vectorAdd vec3(rand(-0.1,0.1),rand(-0.1,0.1),0));
	getter_func(getInitialDir,random 360);
		
	var(currentNomadRole,nullPtr); //объект роли 

	func(nextNomadRole)
	{
		objParams();
		private _next = pick[
		"RTEmbNomadHunter","RTEmbNomadHealer","RTEmbNomadCook","RTEmbNomadRatter","RTEmbNomadMushromer","RTEmbNomadSpirter"
		];
		setSelf(currentNomadRole,_next call gm_getRoleObject);
	};
	
	func(getEquipment)
	{
		objParams_1(_mob);
		callFuncParams(getSelf(currentNomadRole),getEquipment,_mob);
	};

	getter_func(getSkills,callFunc(getSelf(currentNomadRole),getSkills));
	getter_func(getOtherSkills,callFunc(getSelf(currentNomadRole),getOtherSkills));
	
	func(onDeadBasic)
	{
		objParams_2(_mob,_usr);
		super();
	};
	
	func(onAssigned)
	{
		objParams_2(_mob,_usr);
		callSelf(nextNomadRole);
		super();
		private _m = format["%1 - вот каким было моё призвание в пещерах!",getVar(getSelf(currentNomadRole),name)];
		callFuncParams(_mob,addFirstJoinMessage,_m);
		callFuncParams(getSelf(currentNomadRole),onAssigned,_mob arg _usr); //тут onAssigned переопределен RTEmbNomadBase
		callFuncParams(_mob,setHunger,randInt(40,60));
	};

endclass

//тип для шаблонизации снаряжения
class(RTEmbNomadBase) extends(BasicRole)
	var(name,"Бродяга");
	var(count,999999);
	getter_func(getSkills,vec4(randInt(13,16),randInt(10,12),randInt(12,15),randInt(9,11))); //["_st","_iq","_dx","_ht"];
	getter_func(getOtherSkills,[]);

	func(getEquipment)
	{
		objParams_1(_mob);
		if prob(60) then {
			[
			pick["HatOldUshanka","HatUshanka","WorkerCap","WorkerCoolCap","HatGrayOldUshanka"],
			_mob,INV_HEAD
			] call createItemInInventory;
		};
		private _c = ["NomadCloth" + str randInt(1,15),_mob,INV_CLOTH] call createItemInInventory;
		callFuncParams(_c,initMoney,randInt(1,8));
		["Torch",_mob] call createItemInInventory;
		_c
	};

	func(onAssigned)
	{
		objParams_2(_mob,_usr);
		//обязательное переопределение так выше вызывается базовый onAssigned
	};
	
endclass

class(RTEmbNomadHunter) extends(RTEmbNomadBase)
	var(name,"Охотник");
	getter_func(getSkills,vec4(randInt(10,12),randInt(9,10),randInt(10,12),randInt(9,11))); //["_st","_iq","_dx","_ht"];

	func(getOtherSkills) {[
		skillrand(fight,4,6) arg
		skillrand(shotgun,6,9) arg
		skillrand(stealth,2,4)
	]};

	func(getEquipment)
	{
		objParams_1(_mob);
		_cl = super();
		private _shot = ["Shotgun",_mob,INV_BACKPACK] call createItemInInventory;
		callFuncParams(_shot,createAmmoInMagazine,"AmmoShotgun");
		
		_ammo = ["AmmoShotgun",_cl] call createItemInContainer;
		callFuncParams(_ammo,initCount,randInt(5,10));
	};
endclass

class(RTEmbNomadHealer) extends(RTEmbNomadBase)
	var(name,"Пещерный лекарь");
	getter_func(getSkills,vec4(randInt(8,11),randInt(11,13),randInt(9,13),randInt(10,13))); //["_st","_iq","_dx","_ht"];

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
		
		_m = ["MedicalBag",_mob] call createItemInInventory;
		["NeedleWithThreads",_m] call createItemInContainer;
		["Syringe",_m] call createItemInContainer;
		["LiqPainkiller",_m] call createItemInContainer;
		["LiqTovimin",_m] call createItemInContainer;
		for "_i" from 0 to randInt(1,6) do {["Bandage",_m] call createItemInContainer;};
	};
endclass

class(RTEmbNomadMushromer) extends(RTEmbNomadBase)
	var(name,"Гриборуб");
	getter_func(getSkills,vec4(randInt(12,14),randInt(7,10),randInt(11,14),randInt(9,12)));
	func(getOtherSkills) {[
		skillrand(fight,1,3) arg
		skillrand(axe,2,6) arg 
		skillrand(throw,3,6)
	]};

	func(getEquipment)
	{
		objParams_1(_mob);
		_cloth = super();
		["CaveAxe",_mob,INV_BELT] call createItemInInventory;
		["Sigarette",_mob,INV_FACE] call createItemInInventory;
	};
endclass

class(RTEmbNomadRatter) extends(RTEmbNomadBase)
	var(name,"Ловец мельтешат");
	getter_func(getSkills,vec4(randInt(9,10),randInt(7,9),randInt(9,13),randInt(9,11)));
	func(getOtherSkills) {[
		skillrand(stealth,3,6) arg
		skillrand(fight,1,3) arg
		skillrand(theft,2,4)
	]};

	func(getEquipment)
	{
		objParams_1(_mob);
		private _cloth = super();
		["Trap",_mob] call createItemInInventory;
		private _bag = ["FabricBagBig1",_mob,INV_BACKPACK] call createItemInInventory;
		for "_i" from 1 to randInt(5,8) do {
			private _m = ["Melteshonok",_bag] call createItemInContainer;
			setVar(_m,name,"Вялый мельтешонок");
			setVar(_m,desc,"Засушенная тушка мельтешонка. Долго хранится.");
		};
		
	};
endclass

class(RTEmbNomadCook) extends(RTEmbNomadBase)
	var(name,"Готовщик");
	getter_func(getSkills,vec4(randInt(7,10),randInt(7,9),randInt(9,11),randInt(10,11)));
	func(getOtherSkills) {[
		skillrand(cooking,2,5) arg
		skillrand(fight,1,2) arg
		skillrand(farming,1,4) arg
		skillrand(knife,1,4)
	]};

	func(getEquipment)
	{
		objParams_1(_mob);
		private _cloth = super();
		["MatchBox",_cloth] call createItemInContainer;
		["KitchenKnife",_mob,INV_BELT] call createItemInInventory;

		["FryingPan",_mob] call createItemInInventory;
		private _bag = ["FabricBagBig2",_mob,INV_BACKPACK] call createItemInInventory;
		["CampfireCreator",_bag] call createItemInContainer;
		for "_i" from 1 to randInt(2,4) do {
			["Testo",_bag] call createItemInContainer;
			["Egg",_bag] call createItemInContainer;
		};
	};
endclass

class(RTEmbNomadSpirter) extends(RTEmbNomadBase)
	var(name,"Самогонщик");
	getter_func(getSkills,vec4(randInt(9,10),randInt(8,10),randInt(8,10),randInt(9,10)));
	func(getOtherSkills) {[
		skillrand(cooking,2,5) arg
		skillrand(fight,1,2) arg
		skillrand(knife,1,4)
	]};

	func(getEquipment)
	{
		objParams_1(_mob);
		private _cloth = super();
		
		for "_i" from 1 to 4 do {
			["SigaretteDisabled",_cloth] call createItemInContainer;
		};
		["Sigarette",_mob,INV_FACE] call createItemInInventory;

		private _case = ["Suitcase",_mob] call createItemInInventory;
		for "_i" from 1 to 5 do {
			private _s = ["SpirtBottle",_case] call createItemInContainer;
			setVar(_s,bottleName,"Самогон");
		};
	};
endclass