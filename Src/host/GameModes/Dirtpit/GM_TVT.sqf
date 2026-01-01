// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\GameMode.h>

editor_attribute("CodeOnyGamemode")
class(GMTVTGame) extends(GMStationBase)
	getterconst_func(isPlayableGamemode,false);
	var(canAddAspect,false);
	getterconst_func(canPlayEvents,false);
	
	var(name,"Противостояние"); //Название истории
	var(desc,"Противостояние бойцов двух сторон."); //Описание краткое для голосований например
	var(descExtended,"Новая Армия воюет с забытым поселением.");
	
	getterconst_func(getLobbySoundName,"lobby\Faces_of_War.ogg");
	getterconst_func(getLobbyBackground,PATH_PICTURE("lobby\tvtlobby.paa"));
	getterconst_func(getReqPlayersMin,2);
	getterconst_func(getReqPlayersMax,8);
	getterconst_func(getLateRoles,[]);
	getterconst_func(getLobbyRoles,["RTVTRole"]);
	
	getter_func(conditionToStart,count getVar(("RTVTRole") call gm_getRoleObject,contenders_1) >= 2);
	getter_func(onFailReasonToStart,"Не менее двух человек для начала противостояния.");
	
	var(duration,60 * 30); //30 минут
	getter_func(isVoteSystemEnabled,false);
	var(deadSideCount,12); //сколько умрет для конца раунда
	
	var(deadNA,0);
	var(deadCity,0);
	var(mobsNA,[]);
	var(mobsCity,[]);
	var(posBaseNA,vec3(3815.9,3620.32,8.8033));
	var(posBaseCity,vec3(3876.97,3613,8.80255));
	
	var(gates,[]);
	var(gatesIsOpen,false);
	var(isStarted,false);
	var(side,!false); //флаг стороны. false город, true новая армия
	
	var_array(listBoxes);
	
	var(stage,0);// стадия системы. юзается как индекс
	
	func(checkFinish)
	{
		objParams();
		_dsCount = getSelf(deadSideCount);
		_mNa = getSelf(mobsNA);
		_mCit = getSelf(mobsCity);
		_isStarted = getSelf(isStarted);
		
		//Защита
		if (!_isStarted) exitWith {0};
		
		
		if (gm_roundDuration >= getSelf(duration)) exitWith {callSelfParams(handleCheckFinish,1)};
		#ifndef EDITOR
		if (getSelf(deadNA) >= _dsCount) exitWith {callSelfParams(handleCheckFinish,2)};
		if (getSelf(deadCity) >= _dsCount) exitWith {callSelfParams(handleCheckFinish,3)};
		
		if (count _mNa == 0 && _isStarted) exitWith {callSelfParams(handleCheckFinish,6)};
		if (count _mCit == 0 && _isStarted) exitWith {callSelfParams(handleCheckFinish,7)};
		#endif
		//Ниже проверки следующие:
		//Если на вражеской базе больше половины бойцов то победа стороны
		if (
			//na base
			{array_exists(_mCit,_x)} count (["Mob",[3810.31,3620.81,8.79989],13,true,true] call getMobsOnPosition) >= (ceil((count _mCit)/2))
			&& gm_roundDuration >= (60*5)
			) exitWith {callSelfParams(handleCheckFinish,4)};
		if (
			//city base
			{array_exists(_mNa,_x)} count (["Mob",[3881.15,3613.86,8.95672],15,true,true] call getMobsOnPosition) >= (ceil((count _mNa)/2))
			&& gm_roundDuration >= (60*5)
			) exitWith {callSelfParams(handleCheckFinish,5)};
		0
	};
	
	func(handleCheckFinish)
	{
		objParams_1(_num);
		if (getSelf(stage) >= 1) exitWith {_num};
		if (getSelf(stage) < 1) then {
			private _EXTERNAL_FLAG_FINISH_RES_GET_ = _num;
			private _t = "Стадия завершена!" + sbr+format["Потери НА: %1,%3 Потери Города: %2",getSelf(deadNA),getSelf(deadCity),sbr] + sbr + callSelf(getResultTextOnFinish);
			callSelfParams(sendEventMes,_t);
			setSelf(deadNA,0);
			setSelf(deadCity,0);
			setSelf(timer,round(60+5)); //время до старта
			setSelf(isStarted,false);
			callSelf(switchGates);
			callSelf(killAllMobs);
		};
		callSelf(updateStage);
		0
	};
	
	func(killAllMobs)
	{
		objParams();
		private _disposed = [];
		{
			_disposed pushBackUnique _x;
			callFuncParams(_x getvariable "LINK",Die,"newstage"); //unsafe getting virtual mob
		} foreach cm_allInGameMobs;
		{
			callFuncParams(_x,setDeadTimeout,1);
		} foreach cm_allClients;
		//unsafe context
		{
			callFuncParams(_x,setDeadTimeout,1);
		} foreach (values cm_disconnectedClients);
		
		invokeAfterDelayParams({ {callFuncParams(_x,setPos,vec3(200,200,0))}foreach _this},5,_disposed);
		//invokeAfterDelayParams({delete(_x)}foreach _this,1,_disposed);
	};
	
	func(updateStage)
	{
		objParams();
		
		if isNullVar(_INITIAL_STAGE_EXTERNAL_FLAG_) then {
			modSelf(stage,+1);
		};
		private _newstage = getSelf(stage);
		if (_newstage == 0) exitWith {
			
			private _t = "Стадия 1 - Бойня."+sbr+
			"Война неизбежна. Снарядить всех мечами и ножами. Победа будет за нами!";
			callSelfParams(sendEventMes,setstyle(_t,style_redbig));
		};
		if (_newstage == 1) exitWith {
			callSelf(spawnTraps);	
			setSelf(duration,60 * 40);
			gm_roundDuration = 1;
			
			private _t = "Стадия 2 - Окопово."+sbr+
			"Прошло какое-то время. Капканы расставлены, а винтовки заряжены.";
			callSelfParams(sendEventMes,setstyle(_t,style_redbig));
		};
	};
	
	
	func(getResultTextOnFinish)
	{
		objParams();
		private _fr = getSelf(finishResult);
		if !isNullVar(_EXTERNAL_FLAG_FINISH_RES_GET_) then {
			_fr = _EXTERNAL_FLAG_FINISH_RES_GET_;
		};
		call {
			if (_fr == 1) exitWith {"Время вышло. Никто не смог победить сегодня."};
			if (_fr == 2) exitWith {"Погибло слишком много бойцов Новой Армии. Победа поселения!"};
			if (_fr == 3) exitWith {"Погибло слишком много бойцов поселения. Победа Новой Армии!"};
			if (_fr == 4) exitWith {"Поселенцы выбили Новую Армию со своих позиций."};
			if (_fr == 5) exitWith {"Новая Армия захватила поселение."};
			if (_fr == 6) exitWith {"Все бойцы Новой Армии погибли до прихода подкрепления."};
			if (_fr == 7) exitWith {"Все поселенцы погибли до прихода подкрепления."};
			
			"Ну вот и всё.."
		};
	};
	
	func(preSetup)
	{
		objParams();
		super();
		//Получаем ворота
		{
			getSelf(gates) pushBack _x;
		} foreach (["GateCity",[3845.07,3616.21,9.20797],30,!false] call getGameObjectOnPosition);
		
	};
	var(timer,60*2);
	func(postSetup)
	{
		objParams();
		
		private _INITIAL_STAGE_EXTERNAL_FLAG_ = true;
		callSelf(updateStage);
		
		if (count (call cm_getAllClientsInGame) <= 4) then {
			setSelf(timer,60);
		};
		_mS = format["Врата откроются через %1 мин.",floor (getSelf(timer)/60)];
		callSelfParams(sendEventMes,_mS);

		callSelf(__spawnItems);
	};
	
	func(sendEventMes)
	{
		objParams_1(_m);
		[sbr+format["<t align='center'>%1</t>",_m]+sbr,"event"] call cm_sendOOSMessage;
	};
	
	func(switchGates)
	{
		objParams();
		{
			setVar(_x,lastActivationTime,0); //hardcoded reset values (защита блокировки дверей)
			callFunc(_x,onActivate);
		} foreach getSelf(gates);
		setSelf(gatesIsOpen,!getSelf(gatesIsOpen));
	};
	
	func(__spawnItems)
	{
		objParams();
		private _b = ["OldWoodenBox",[3876.64,3607.87,8.7706],273.159,false] call createStructure;
		setVar(_b,name,"Городские припасы");
		getSelf(listBoxes) pushBack _b;
		_b = ["OldWoodenBox",[3809.67,3622.19,8.81625],295,false] call createStructure;
		setVar(_b,name,"Припасы захватчиков");
		getSelf(listBoxes) pushBack _b;
	};
	
	func(spawnTraps)
	{
		objParams();
		
		//special campfires
		{
			["Campfire",_x,random 360,true] call createStructure;
		} foreach [
			[3829.44,3594.24,11.7521],
			[3862.2,3592.54,8.84373],
			[3832.49,3620.84,8.97056],
			[3823.11,3628.62,8.85325],
			[3835.52,3642.11,9.62458],
			[3859.77,3648.2,7.47604],
			[3843.89,3638.12,8.93728],
			[3860.1,3608.29,8.84777],
			[3856.99,3617.67,9.00212]
		];
		
		//shovels
		{
			for "_i" from 1 to randInt(3,4) do {
				["Shovel",_x vectorAdd [rand(-0.2,0.2),rand(-0.2,0.2),0],null,true] call createItemInWorld;
			};
		} foreach [
			[3818.56,3612.33,9.5045],
			[3871.17,3622.38,9.74768]
		];
		//torches
		{
			for "_i" from 1 to randInt(4,6) do {
				["TorchDisabled",_x vectorAdd [rand(-0.2,0.2),rand(-0.2,0.2),0],null,true] call createItemInWorld;
			};
			for "_i" from 1 to randInt(2,3) do {
				["AmmoBoxRifle",_x vectorAdd [rand(-0.3,0.3),rand(-0.3,0.3),0],null,true] call createItemInWorld;
			};
		} foreach [
			[3811.56,3613.49,9.55098],
			[3875.93,3620.99,9.80991]
		];
		//campfire creators
		{
			for "_i" from 1 to randInt(4,5) do {
				["CampfireCreator",_x vectorAdd [rand(-0.2,0.2),rand(-0.2,0.2),0],null,true] call createItemInWorld;
			};
		} foreach [
			[3870.75,3621.08,9.74768],
			[3819.42,3611.65,9.62676]
		];
		
		private _leftUp = [3834.61,3597.14,11.5921];
		private _rightDown = [3857.45,3638.05,9.33815];
		_z = 13.6277 + 0.3;
		for "_x" from (_leftUp select 0) to (_rightDown select 0) do {
			for "_y" from (_leftUp select 1) to (_rightDown select 1) do {
				if prob(45) then {
					["TrapEnabled",[_x+rand(-0.3,0.3),_y+rand(-0.3,0.3),_z],random 360,true] call createItemInWorld;
				};
				if prob(15) then {
					["Campfire",[_x+rand(-0.3,0.3),_y+rand(-0.3,0.3),_z],random 360,true] call createStructure;
				};
			};
		};
		
		_leftUp = [3840.62,3575.34,8.82503];
		_rightDown = [3861.62,3583.21,9.03352];
		_z = 8.9 + 0.3;
		
		for "_x" from (_leftUp select 0) to (_rightDown select 0) do {
			for "_y" from (_leftUp select 1) to (_rightDown select 1) do {
				if prob(40) then {
					["TrapEnabled",[_x+rand(-0.3,0.3),_y+rand(-0.3,0.3),_z],random 360,true] call createItemInWorld;
				};
			};
		};
		
		_leftUp = [3837.58,3650.51,9.2368];
		_rightDown = [3867.29,3658.33,9.05352];
		_z = 9 + 0.3;
		
		for "_x" from (_leftUp select 0) to (_rightDown select 0) do {
			for "_y" from (_leftUp select 1) to (_rightDown select 1) do {
				if prob(40) then {
					["TrapEnabled",[_x+rand(-0.3,0.3),_y+rand(-0.3,0.3),_z],random 360,true] call createItemInWorld;
				};
			};
		};
		
		//lower zone
		_leftUp = [3840.62,3575.34,8.82503];
		_rightDown = [3861.62,3583.21,9.03352];
		_z = 8.9 + 0.3;
		for "_x" from (_leftUp select 0) to (_rightDown select 0) do {
			for "_y" from (_leftUp select 1) to (_rightDown select 1) do {
				if prob(40) then {
					["TrapEnabled",[_x+rand(-0.3,0.3),_y+rand(-0.3,0.3),_z],random 360,true] call createItemInWorld;
				};
			};
		};
	};
	
	var(playedTime,0);
	
	func(onRoundCode)
	{
		objParams();
		super();
		this = gm_currentMode;
		
		
		if getSelf(isStarted) exitWith {
			if (getSelf(stage)<=0)exitWith{};
			modSelf(playedTime,+1);
			
			_tCheck = 5*60;
			#ifdef EDITOR
			_tCheck = 60;
			#endif
			if (getSelf(playedTime) % _tCheck == 0) then {
				//callSelfParams(sendEventMes,"Припасы подоспели...");
				{
					callFuncParams(_x,createItemInContainer,"MagazineFinisher" arg randInt(1,2));
					callFuncParams(_x,createItemInContainer,"AmmoBoxRifle" arg randInt(2,4));
					if prob(15) then {
						callFuncParams(_x,createItemInContainer,"RifleAuto" arg 1);
						callFuncParams(_x,createItemInContainer,"MagazineAuto" arg randInt(1,2));
					};
				} foreach getSelf(listBoxes);
			};
			
		};
		
		modSelf(timer,-1);
		if (getSelf(timer) in [60,30]) then {
			callSelfParams(sendEventMes,"Осталось " + str getSelf(timer) + " сек.")
		};
		if (getSelf(timer) <= 0) exitWith {
			callSelf(switchGates);
			callSelfParams(sendEventMes,"Врата открываются...");
			setSelf(isStarted,true);
		};
	};
	
	func(getCurRoleName)
	{
		objParams();
		ifcheck(getSelf(side),"Боец Новой Армии","Поселенец");
	};
	
	func(getCurRoleDesc)
	{
		objParams();
		ifcheck(getSelf(side),"Захватите поселение","Отбейте атаку");
	};
	
	func(getSpawnPos)
	{
		objParams();
		if getSelf(side) then {
			[3816.1,3621.31,8.80539] vectorAdd [randInt(-1,1),randInt(-1,1),0]
		} else {
			[3874.85,3613.54,8.95098] vectorAdd [randInt(-1,1),randInt(-1,1),0]
		}
	};
	
	func(getSpawnDir)
	{
		objParams();
		ifcheck(getSelf(side),93.9717,273.549)
	};
	
	func(getSkills)
	{
		objParams();
		vec4(randInt(10,16),randInt(9,13),randInt(12,15),randInt(13,15))
	};
	
	func(allocClothType)
	{
		objParams_1(_mob);
		private _tCloth = if getSelf(side) then {
			pick ["NewArmyStdCloth","GreatcoatBlack"];
		} else {
			pick ["VeteranCloth","ArmyCloth1"];
		};
		private _cloth = [_tCloth,_mob,INV_CLOTH] call createItemInInventory;
		if (getSelf(stage)>=1) then {
			private _armor = [pick["ArmorLite","ArmorMedium"],_mob,INV_ARMOR] call createItemInInventory;
			callFuncParams(_armor,createItemInContainer,"MagazineFinisherLoaded" arg 3);
			callFuncParams(_armor,createItemInContainer,"AmmoBoxRifle" arg 1);
		};
		_cloth
	};
	
	func(pickBackUniform)
	{
		objParams();
		if getSelf(side) then {
			""
		} else {
			pick ["","WoolCoat"]
		};
	};
	func(pickHeadUniform)
	{
		objParams();
		private _l = ["hatshemag","hatoldushanka","workercap","cookercap","","","",""];
		if (getSelf(stage)>=1) then {
			_l pushBack "CombatHat";
			_l pushBack "CombatHat";
			_l pushBack "CombatHat";			
		};
		pick _l
	};
	
	func(pickFaceUniform)
	{
		objParams();
		pick ((["ItemMask",false] call oop_getinhlist) + + ["","","","",""])
	};
	
	func(pickFirstWeapon)
	{
		objParams_2(_mob,_handWeaponIdx);
		private _stage = getSelf(stage);
		if (_stage == 0) exitWith {
			private _w = pick ["CaveAxe","CombatKnife","BattleAxe","ShortSword","HalfHandedSword","TwoHandedSword"];
			[_w,_mob,INV_BELT] call createItemInInventory;
		};
		if (_stage >= 1) exitWith {
			private _w = ["RifleFinisher",_mob,_handWeaponIdx] call createItemInInventory;
			callFuncParams(_w,createMagazine,"MagazineFinisherLoaded");
		};
	};
	
	func(setEquipment)
	{
		objParams_1(_mob);
		private _cloth = callSelfParams(allocClothType,_mob);
		private _probBack = callSelf(pickBackUniform);
		if not_equals(_probBack,"") then {
			[_probBack,_mob,INV_BACK] call createItemInInventory;
		};
		private _face = callSelf(pickFaceUniform);
		if not_equals(_face,"") then {[_face,_mob,INV_FACE] call createItemInInventory};
		private _head = callSelf(pickHeadUniform);
		if not_equals(_head,"") then {[_head,_mob,INV_HEAD] call createItemInInventory};
		
		
		if prob(50) then {
			private _itm = [pick["Candle","Torch"],_mob,INV_HAND_R] call createItemInInventory;
			setVar(_itm,fuelLeft,60*randInt(4,10));
		};
		
		private _cat = randInt(0,100);
		call {
			
			//Боец
			if inRange(_cat,0,65) exitWith {
				for "_i" from 0 to randInt(0,4) do {
					["SigaretteDisabled",_cloth] call createItemInContainer;
				};
				if prob(40) then {
					["MatchBox",_cloth] call createItemInContainer;
				};
				callSelfParams(pickFirstWeapon,_mob arg getVar(_mob,mainHand));
			};
			//Лекарь
			if inRange(_cat,66,75) exitWith {
				callSelfParams(pickFirstWeapon,_mob arg INV_HAND_R);
				_m = ["MedicalBag",_mob,INV_HAND_L] call createItemInInventory;
				["NeedleWithThreads",_m] call createItemInContainer;
				["Syringe",_m] call createItemInContainer;
				["LiqPainkiller",_m] call createItemInContainer;
				["LiqTovimin",_m] call createItemInContainer;
				
				for "_i" from 0 to randInt(-1,4) do {["Bandage",_m] call createItemInContainer;};
			};
			//Кукер
			if inRange(_cat,76,85) exitWith {
				callSelfParams(pickFirstWeapon,_mob arg getVar(_mob,mainHand));
				_m = ["FabricBagBig1",_mob,INV_BACKPACK] call createItemInInventory;
				["FryingPan",_m] call createItemInContainer;
				_itm = ["CampfireCreator",_m] call createItemInContainer;
				setVar(_itm,fuelLeft,60*randInt(10,20));
				for "_i" from 0 to randInt(-3,3) do {["Melteshonok",_m] call createItemInContainer;};
				for "_i" from 0 to randInt(-2,4) do {["Muka",_m] call createItemInContainer;};
				for "_i" from 0 to randInt(-2,2) do {["MilkBottle",_m] call createItemInContainer;};
				for "_i" from 0 to randInt(-2,4) do {["Egg",_m] call createItemInContainer;};
				for "_i" from 0 to randInt(-2,4) do {["Lepeshka",_m] call createItemInContainer;};
				for "_i" from 0 to randInt(-2,4) do {["MeatMinced",_m] call createItemInContainer;};
			};
			callSelfParams(pickFirstWeapon,_mob arg getVar(_mob,mainHand));
			//Разведчик
			_m = ["SmallBackpack",_mob,INV_BACKPACK] call createItemInInventory;
			_itm = ["CampfireCreator",_m] call createItemInContainer;
			setVar(_itm,fuelLeft,60*randInt(10,20));
			["MatchBox",_cloth] call createItemInContainer;
			["SpirtBottle",_m] call createItemInContainer;
			for "_i" from 0 to randInt(-1,3) do {["Paper",_m] call createItemInContainer;};
			["PenRed",_m] call createItemInContainer;
			["PenBlack",_m] call createItemInContainer;
			
		};
	};
	
	func(onSpawnedMob)
	{
		objParams_1(_mob);
		private _refarr = ifcheck(getSelf(side),getSelf(mobsNA),getSelf(mobsCity));
		_refarr pushBackUnique _mob;
		
		setSelf(side,!getSelf(side));
	};
	
	func(onKilledMob)
	{
		objParams_1(_mob);
		if array_exists(getSelf(mobsNA),_mob) then {
			getSelf(mobsNA) deleteAt (getSelf(mobsNA) find _mob);
			modSelf(deadNA,+1);
		} else {
			getSelf(mobsCity) deleteAt (getSelf(mobsCity) find _mob);
			modSelf(deadCity,+1);
		};
	};
	
endclass