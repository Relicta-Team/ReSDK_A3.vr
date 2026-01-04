// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================


#include <..\GameMode.h>



class(RDetectiveModeRole) extends(BasicRole)
	var(name,"Роль");
	var(desc,"");
	getter_func(canTakeInLobby,true);
	getter_func(canVisibleAfterStart,true);
	var(count,1);
	getter_func(getSkills,vec4(randInt(11,13),randInt(8,10),randInt(11,13),randInt(10,12))); //["_st","_iq","_dx","_ht"];

	getterconst_func(canShownMurderInfo,true);

	//override need
	getter_func(getInitialPos,vec3(3676.76,3680.95,23.5646));
	getter_func(getInitialDir,273.718);

	func(printMurderInfo)
	{
		objParams_1(_mob);

		if !callSelf(canShownMurderInfo) exitWith {};

		/*private _code = {

			//убийце не нужно знать себя
			if equals(getVar(gm_currentMode,murder),_this) exitWith {};

			//Вероятность знания убийцы
			private _murderName = if prob(90) then {
				_allMobs = [];

				{
					//if (_x == "RDetective") then {continue}; //проверка в canShownMurderInfo
					_allMobs append getVar(_x call gm_getRoleObject,basicMobs);
				} forEach callFunc(gm_currentMode,getLobbyRoles);
				callFuncParams(pick _allMobs,getNameEx,"кто");
			} else {
				callFuncParams(getVar(gm_currentMode,murder),getNameEx,"кто");
			};
			_txt = format["Прошлой ночью был убит %1 помещика. Ты думаешь"+comma+" что убийца %2.",getVar(gm_currentMode,prevTarget) select 0,
				_murderName
			];

			callFuncParams(_this,localSay,_txt arg "info");
		}; invokeAfterDelayParams(_code,5,_mob);*/
	};

	func(onAssigned)
	{
		objParams_2(_mob,_usr);
		super();
		callSelfParams(printMurderInfo,_mob);
	};

	func(onDeadBasic)
	{
		objParams_2(_mob,_usr);
		super();
		modVar(gm_currentMode,duration, + 10);
	};

endclass

class(RPomeshik) extends(RDetectiveModeRole)
	var(name,"Помещик");
	var(desc,"Владелец поместья ''Хвостово''.");
	var(reputationNeed,rolerep(1,10,10));
	getter_func(getInitialPos,vec3(3676.76,3680.95,23.5646));
	getter_func(getInitialDir,273.718);
	getter_func(isMainRole,true);

	getter_func(getSkills,vec4(randInt(10,14),randInt(10,13),randInt(9,11),randInt(12,14))); //["_st","_iq","_dx","_ht"];
	func(getOtherSkills) {[
		skillrand(fight,0,3) arg
		skillrand(sword,1,3) arg
		skillrand(repair,2,4) arg
		skillrand(farming,4,7)
	]};

	//cloth GreatcoatBrown,back WoolCoat, head WorkerCoolCap
	func(getEquipment)
	{
		objParams_1(_mob);
		["WoolCoat",_mob,INV_BACK] call createItemInInventory;
		["WorkerCoolCap",_mob,INV_HEAD] call createItemInInventory;

		private _cloth = ["GreatcoatBrown",_mob,INV_CLOTH] call createItemInInventory;
		setVar(_cloth,name,"Одеяние помещика");
		regKeyInUniform(_cloth,["super"],"Ключ помещика");
		callFuncParams(_cloth,initMoney,randInt(1,20));

		private _fod = ["RDetItmFarmOwnerDoc",_mob,INV_HAND_R] call createItemInInventory;
		setVar(gm_currentMode,farmOwnerDoc,_fod);

		getVar(gm_currentMode,thiefTask) pushBack _fod;

	};
endclass

	class(RDetItmFarmOwnerDoc) extends(Paper)
		getter_func(canRead,false);
		var(name,"Документ владения Калековской Мельтешиной Фермой");
		var(desc,"Очень ценная бумага.");
		getter_func(getMainActionName,"Прочитать");
		func(onMainAction)
		{
			objParams_1(_usr);
			callFuncParams(_usr,localSay,"Там столько всего написано..." arg "mind");
		};
	endclass

class(RWifePomeshik) extends(RDetectiveModeRole)
	var(name,"Жена помещика");
	var(reputationNeed,rolerep(1,2,7));
	var(desc,"В эту трудную минуту твоему мужу нужна поддержка как никогда. Позаботься, чтобы твоего возлюбленного сегодня ничто не беспокоило.");
	getter_func(getInitialPos,vec3(3677.9,3684.88,23.6426));
	getter_func(getInitialDir,273.718);
	getter_func(getSkills,vec4(randInt(8,10),randInt(12,14),randInt(7,9),randInt(10,13))); //["_st","_iq","_dx","_ht"];
	func(getOtherSkills) {[
		skillrand(cooking,2,5) arg
		skillrand(farming,2,3)
	]};

	func(canVisibleAfterStart)
	{
		objParams_1(_cliObj);
		((getVar(_cliObj,charSettings) get "gender") == 1)
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
		setVar(_cloth,name,"Одеяние жены помещика");
		regKeyInUniform(_cloth,["super"],"Ключ помещика");
		callFuncParams(_cloth,initMoney,randInt(1,5));

		if equalTypes(getVar(gm_currentMode,thiefTask),[]) then {
			getVar(gm_currentMode,thiefTask) pushBack _cloth;
		};
	};
endclass

class(RPrikazchik) extends(RDetectiveModeRole)
	var(name,"Приказчик");
	var(desc,"Заместитель и помощник помещика. Организовывает работу прислужников и следит за порядком в поместье.");
	var(reputationNeed,rolerep(1,5,9));
	getter_func(getSkills,vec4(randInt(9,15),randInt(11,12),randInt(8,11),randInt(9,12))); //["_st","_iq","_dx","_ht"];
	func(getOtherSkills) {[
		skillrand(surgery,0,3) arg
		skillrand(healing,0,4) arg
		skillrand(fight,1,4)
	]};
	//room give
	getter_func(getInitialPos,getVar(gm_currentMode,listRooms) select (getVar(gm_currentMode,lastRoomNumber)-1) select 0);
	getter_func(getInitialDir,random 360);
	//cloth ZnatCloth
	func(getEquipment)
	{
		objParams_1(_mob);

		private _cloth = ["ZnatCloth",_mob,INV_CLOTH] call createItemInInventory;

		private _keyId = getVar(gm_currentMode,listRooms) select (getVar(gm_currentMode,lastRoomNumber)-1) select 1;
		regKeyInUniform(_cloth,["room" + str _keyId],"Ключ от комнаты "+ str _keyId);
		callFuncParams(_cloth,initMoney,randInt(1,5));
	};

	func(onAssigned)
	{
		objParams_2(_mob,_usr);
		super();
		private _idx = getVar(gm_currentMode,lastRoomNumber) - 1;
		getVar(gm_currentMode,listRooms) deleteAt _idx;
		setVar(gm_currentMode,lastRoomNumber,randInt(1,count getVar(gm_currentMode,listRooms)));
	};

endclass

class(RDetective) extends(RDetectiveModeRole)
	var(name,"Дознаватель");
	var(desc,"Прислан из Калеково для расследования. При нём портфель с материалами дела а в зубах тлеющая сигарета.");
	var(reputationNeed,rolerep(1,10,10));
	getter_func(isMainRole,true);

	var(classMan,"Mob_Detective");
	var(classWoman,"MobWoman_Detective");
	
	getter_func(getInitialPos,vec3(3632,3667.2,13.3369));
	getter_func(getInitialDir,92.3);
	getter_func(getSkills,vec4(randInt(12,14),randInt(10,12),randInt(11,13),randInt(9,11))); //["_st","_iq","_dx","_ht"];
	func(getOtherSkills) {[
		skillrand(sword,2,5) arg
		skillrand(fight,3,6) arg
		skillrand(pistol,2,6) arg
		skillrand(stealth,3,5)
	]};

	getterconst_func(canShownMurderInfo,false);

	//cloth GreatcoatBlack - rename, head HoodChemicalProt
	func(getEquipment)
	{
		objParams_1(_mob);

		private _cloth = ["GreatcoatBlack",_mob,INV_CLOTH] call createItemInInventory;

		setVar(_cloth,name,"Шинель дознавателя");
		for "_i" from 1 to 2 do {
			["SigaretteDisabled",_cloth] call createItemInContainer;
		};
		["MatchBox",_cloth] call createItemInContainer;
		callFuncParams(_cloth,initMoney,randInt(1,20));

		["HoodChemicalProt",_mob,INV_HEAD] call createItemInInventory;
		["Sigarette",_mob,INV_FACE] call createItemInInventory;

		//["ShortSword",_mob,INV_BELT] call createItemInInventory;
		private _pistol = ["Revolver",_mob,INV_BELT] call createItemInInventory;
		setVar(_pistol,name,"""Глас Истины""");
		callFuncParams(_pistol,createAmmoInMagazine,"AmmoRevolver");

		_brif = ["Briefcase",_mob,INV_HAND_R] call createItemInInventory;

		for "_i" from 1 to randInt(1,2) do {
			private _ammo = ["AmmoRevolver",_brif] call createItemInContainer;
			callFuncParams(_ammo,initCount,randInt(8,20));
		};

		["PenBlack",_brif] call createItemInContainer;
		for "_i" from 1 to 3 do {
			["Paper",_brif] call createItemInContainer;
		};

	/*	private _countPlayers = count (call cm_getAllClientsInGame);//
		private _countCheckers = (round(_countPlayers/3))max 1;
		for "_i" from 1 to _countCheckers do {
			["RDetectCheckMurder",_brif] call createItemInContainer;
		};*/


		_paper = ["RDetectWorkDoc",_brif] call createItemInContainer;
		_code = {
			params ["_paper","_mob"];
			_dataText = format["Уважаемый %1. Вы должны прибыть в поместье 'Хвостово', где вчера произошло убийство %2 помещика. Осмотрите место убийства, опросите подозреваемых и выясните кто убийца. Вашей задачей будет передать убийцу честному суду Калеково. Не устраивайте самосуд и по возможности доставьте его живым.",
				callFuncParams(_mob,getNameEx,"кто"),
				getVar(gm_currentMode,prevTarget) select 0
			];
			setVar(_paper,content,_dataText);
		};
		invokeAfterDelayParams(_code,2,[_paper arg _mob]);
		
	};

	func(onAssigned)
	{
		objParams_2(_mob,_usr);
		super();
		//set detective mob
		setVar(gm_currentMode,detective,_mob);
		getVar(gm_currentMode,lawyers) pushBackUnique _mob;
	};
endclass

	["pr","chEvDet","onDetectiveCheckEvidence"] call ie_actions_regNew;
	["pr","mindDet","onDetectiveMind"] call ie_actions_regNew;
	private _initDetective = {
		func(constructor)
		{
			objParams();
			callSelfParams(addAction,"Восприятие" arg "Поиск улик" arg "pr_chEvDet");
			callSelfParams(addAction,"Восприятие" arg "Обдумать" arg "pr_mindDet");
		};
		var(evidenceFinded,0);//сколько нашёл улик
		var(lastEvidenceTime,0);
		var(evidencesList,[]);//какие объекты улик нашёл наш чел

		#ifdef EDITOR
		var(timeoutBeforeNextEvidence,10);
		#else
		var(timeoutBeforeNextEvidence,60*3);
		#endif
		
		var(pointersSearched,hashSet_createEmpty());//по каким указателям он искал
		
		//Поиск улик
		func(onDetectiveCheckEvidence)
		{
			objParams();
			callSelf(generateLastInteractOnServer);
			private _target = callSelf(getLastInteractTarget);
			if isNullReference(_target) exitWith {
				callSelfParams(mindSay,"Нужно что-то искать");
			};
			if callFunc(_target,isMob) exitWith {
				callSelfParams(localSay,"Нужно осматривать предметы"+comma+"а не людей..." arg "error");
			};
			private _evTime = getSelf(timeoutBeforeNextEvidence);
			if (getSelf(lastEvidenceTime)+_evTime >= tickTime) exitWith {
				private _m = format["Надо обдумать и подождать %1",[round((getSelf(lastEvidenceTime)+_evTime)-tickTime),["секунду","секунды","секунд"],true] call toNumeralString];
				callSelfParams(localSay,_m arg "error");
			};
			if (callSelf(getLastInteractDistance) > 2) exitWith {
				callSelfParams(localSay,"Слишком далеко" arg "error");
			};
			callSelfParams(startSelfProgress,"onDetectiveCheckEvidenceProcess" arg rand(1,2) arg INTERACT_PROGRESS_TYPE_FULL);
		};
		var(const_timePerEvidence,vec4(randInt(9,12),randInt(10,15),randInt(13,20),randInt(17,25)));
		func(onDetectiveCheckEvidenceProcess)
		{
			objParams();
			
			private _target = callSelf(getLastInteractTarget);
			if isNullReference(_target) exitWith {};
			
			if (parseNumber getVar(_target,pointer) > getVar(gm_currentMode,lastPointerInt)) exitWith {
				callSelfParams(localSay,"Это не улика..." arg "error");
			};
			
			private _curEvid = getSelf(evidenceFinded);
			if (_curEvid >= 4) exitWith {
				callSelfParams(localSay,"У меня есть все нужные улики для раскрытия убийцы..." arg "error");
			};
			
			if hashSet_exists(getSelf(pointersSearched),getVar(_target,pointer)) exitWith {
				callSelfParams(localSay,"Уже обыскано мной..." arg "error");
			};
			
			hashSet_add(getSelf(pointersSearched),getVar(_target,pointer));
			
			#ifdef EDITOR
				#define evidCheck(lvl,time,othrcond) (_curEvid == lvl && gm_roundDuration >= (time) && othrcond)
			#else
				#define evidCheck(lvl,time,othrcond) (_curEvid == lvl && gm_roundDuration >= ((time)*60) && othrcond)
			#endif
			private _constVal = getSelf(const_timePerEvidence);
			if evidCheck(0,_constVal select 0,true) exitWith {
				if (callSelf(getLastInteractEndPos) distance callFunc(gm_currentMode,getMurderPos) > 10) exitWith {
					callSelfParams(localSay,"Сначало нужно изучить место убийства..." arg "error");
				};
				
				callFuncParams(gm_currentMode,processEvidence,this);
				modSelf(evidenceFinded,+1);
				setSelf(lastEvidenceTime,tickTime);
				
				callFuncParams(getVar(gm_currentMode,murder),addTimeBouns,"st" arg +1 arg 99999);
			};
			if evidCheck(1,_constVal select 1,true) exitWith {
				
				callFuncParams(gm_currentMode,processEvidence,this);
				modSelf(evidenceFinded,+1);
				setSelf(lastEvidenceTime,tickTime);
				
				callFuncParams(getVar(gm_currentMode,murder),addTimeBouns,"ht" arg +1 arg 99999);
			};
			if evidCheck(2,_constVal select 2,true) exitWith {
				
				callFuncParams(gm_currentMode,processEvidence,this);
				modSelf(evidenceFinded,+1);
				setSelf(lastEvidenceTime,tickTime);
				
				callFuncParams(getVar(gm_currentMode,murder),addTimeBouns,"ht" arg +2 arg 99999);
			};
			if evidCheck(3,_constVal select 3,true) exitWith {
				
				callFuncParams(gm_currentMode,processEvidence,this);
				modSelf(evidenceFinded,+1);
				setSelf(lastEvidenceTime,tickTime);
				callSelfParams(mindSay,"У меня достаточно улик. Надо обдумать кто может быть убийцей...");
				
				callFuncParams(getVar(gm_currentMode,murder),addTimeBouns,"st" arg +2 arg 99999);
			};
			
			callSelfParams(mindSay,"Тут ничего подозрительного. Нужно искать дальше...");
		};
		
		//Подумать кто убийца
		func(onDetectiveMind)
		{
			objParams();
			if (getSelf(evidenceFinded) == 0) exitWith {
				callSelfParams(mindSay,"Мне нужно найти улики...");
			};
			callSelfParams(mindSay,pick["Хм..." arg "Ага..." arg "Так..." arg "Значит у нас получается..." arg "Кажется я понимаю..."]);
			callSelfParams(startSelfProgress,"onDetectiveMindProcess" arg rand(5,10) arg INTERACT_PROGRESS_TYPE_LAZY);
		};
		func(onDetectiveMindProcess)
		{
			objParams();
			
			private _t = "<t size='1.2' color='#E6054C'>Вот что я имею:";
			
			
			if (getSelf(evidenceFinded) >= 4) then {
				
				{
					modvar(_t) + sbr+ format["%1 - %2",capitalize(getVar(_x,evidenceInfo)),getVar(_x,reasonEvidence)];
				} foreach getSelf(evidencesList);
				
				modvar(_t) + sbr + format[
					"Убийство было в %1 - %2.%4%4<t size='1.9'>Убийца - %5</t>",//Мотив убийцы - %3%4
					lowerize(callFunc(gm_currentMode,getMurderPosName)),
					callFunc(gm_currentMode,getMurderKillProcess),
					callFunc(gm_currentMode,getMurderKillReason),
					sbr,
					callFuncParams(getVar(gm_currentMode,murder),getNameEx,"кто")
				];
				
				
				callFuncParams(gm_currentMode,checkMurder,getVar(gm_currentMode,murder) arg this);
			} else {
				_t = "<t size='1.2' color='#E6054C'>Найденные улики: " + ((getSelf(evidencesList)apply{getVar(_x,evidenceInfo)}) joinString ", ")+".";
				
				modvar(_t) + sbr + "Я пока не знаю кто убийца. Под подозрением: ";
				private _shlistroles = array_copy(array_shuffle(getVar(gm_currentMode,suspicions)));
				if (count _shlistroles == 0) exitWith {
					modvar(_t) + "никого...";
				};
				_evFactor = floor linearConversion[3,1,getSelf(evidenceFinded),1,count _shlistroles];
				private _lm = [];
				for "_i" from 0 to _evFactor do {
					_lm pushBack (_shlistroles select _i);
				};
				modvar(_t) + ((_lm apply {callFuncParams(_x,getNameEx,"кто")}) joinString ", ")+".";
			};
			
			
			modvar(_t)+"</t>";
			callSelfParams(mindSay,_t);
		};
	};

	class(Mob_Detective) extends(Mob)
		call _initDetective;
	endclass
	
	class(MobWoman_Detective) extends(MobWoman)
		call _initDetective;
	endclass

	class(RDetectWorkDoc) extends(Paper)
		var(name,"Материалы дела");
		getter_func(canWrite,false);

	endclass

	class(RDetectCheckMurder) extends(Paper)
		var(name,"Бланк анализа подозреваемого");
		var(desc,"На этой бумаге подозреваемый ставит свой отпечаток и после этого бланк нужно в Калеково почтой.");
		getter_func(canWrite,false);
		getter_func(canRead,false);
		var(checkedMurder,nullPtr);

		func(getDescFor)
		{
			objParams_1(_usr);
			super() + ifcheck(!isNullReference(getSelf(checkedMurder)), sbr + "Там видно отпечаток " + callFuncParams(getSelf(checkedMurder),getNameEx,"кого"),"");
		};
		getter_func(getMainActionName,"Поставить отпечаток");
		func(onMainAction)
		{
			objParams_1(_usr);

			private _withCls = callFunc(getVar(_usr,basicRole),getClassName);
			if (_withCls == "RDetective" || _withCls == "RDetectiveHelper") exitWith {
				callFuncParams(_usr,localSay,"Это плохая идея..." arg "error");
			};
			if (isNullReference(getSelf(checkedMurder)) || {not_equals(getSelf(checkedMurder),_usr)}) then {
				callFuncParams(_usr,meSay,"ставит отпечаток на бланке.");
				setSelf(checkedMurder,_usr);
			} else {
				callFuncParams(_usr,localSay,"Так не пойдёт." arg "error");
			};

		};

	endclass

	class(RDetMailBox) extends(LongWeaponContainer)
		var(name,"Почтовый ящик");
		var(desc,"Для отправки всякого в Калеково");
		var(canUseContainer,false);

		func(onInteractWith)
		{
			objParams_2(_with,_usr);
			if isTypeOf(_with,RDetectCheckMurder) exitWith {
				if isNull(getVar(_with,checkedMurder)) exitWith {};
				if isNullReference(getVar(_with,checkedMurder)) exitWith {
					callFuncParams(_usr,localSay,"Подозреваемый не поставил отпечаток..." arg "error");
				};
				callFuncParams(_usr,meSay,"засовывает бланк в ящик.");
				callFuncParams(gm_currentMode,checkMurder,getVar(_with,checkedMurder) arg _usr);
				delete(_with);
			};
		};
	endclass


class(RButler) extends(RDetectiveModeRole)
	var(name,"Прислужник");
	var(desc,"Выполняйте все наказы помещика. Ведь вы - его собственность.");
	var(reputationNeed,rolerep(1,2,5));
	var(count,4);
	getter_func(getSkills,vec4(randInt(7,13),randInt(6,10),randInt(6,14),randInt(7,10))); //["_st","_iq","_dx","_ht"];
	func(getOtherSkills) {[
		skillrand(cooking,0,7) arg
		skillrand(repair,0,6) arg
		skillrand(engineering,0,6) arg
		skillrand(farming,0,7)
	]};

	getter_func(getInitialPos,vec3(3684.31,3654.2,17.1444));
	getter_func(getInitialDir,275.4);

	//cloth WhiteRobeCloth
	func(getEquipment)
	{
		objParams_1(_mob);

		private _cloth = ["WhiteRobeCloth",_mob,INV_CLOTH] call createItemInInventory;
		setVar(_cloth,name,"Прислужная роба");
		regKeyInUniform(_cloth,["slugi"],"Ключ прислуги");
		callFuncParams(_cloth,initMoney,randInt(1,3));

	};
endclass

class(RDetectiveTrader) extends(RDetectiveModeRole)
	var(name,"Торговый наместник");
	var(desc,"Прибыл из Калековского Торгового Содружества прошлым циклом для покупки Калековской мельтешиной фермы у помещика. Получи бумаги владения фермой любым путем.");
	var(reputationNeed,rolerep(1,5,7));

	getter_func(getInitialPos,getVar(gm_currentMode,listRooms) select (getVar(gm_currentMode,lastRoomNumber)-1) select 0);
	getter_func(getInitialDir,random 360);
	getter_func(getSkills,vec4(randInt(10,13),randInt(11,12),randInt(10,14),randInt(9,12))); //["_st","_iq","_dx","_ht"];
	func(getOtherSkills) {[
		skillrand(stealth,2,4) arg
		skillrand(fight,0,4)
	]};

	//room give
	//cloth TorgashPalthCloth,head HatGrayOldUshanka
	//SteelMedicalBox
	func(getEquipment)
	{
		objParams_1(_mob);

		["HatGrayOldUshanka",_mob,INV_HEAD] call createItemInInventory;
		private _cloth = ["TorgashPalthCloth",_mob,INV_CLOTH] call createItemInInventory;
		setVar(_cloth,name,"Торговское клетчатое пальто");

		private _keyId = getVar(gm_currentMode,listRooms) select (getVar(gm_currentMode,lastRoomNumber)-1) select 1;
		regKeyInUniform(_cloth,["room" + str _keyId],"Ключ от комнаты "+ str _keyId);
		callFuncParams(_cloth,initMoney,randInt(1,5));

		for "_i" from 1 to 2 do {
			["SigaretteDisabled",_cloth] call createItemInContainer;
		};
		["MatchBox",_cloth] call createItemInContainer;

		_brif = ["Briefcase",_mob,INV_HAND_L] call createItemInInventory;
		callFuncParams(_brif,initMoney,randInt(800,1500) arg  true);
	};

	func(onAssigned)
	{
		objParams_2(_mob,_usr);
		super();
		private _idx = getVar(gm_currentMode,lastRoomNumber) - 1;
		getVar(gm_currentMode,listRooms) deleteAt _idx;
		setVar(gm_currentMode,lastRoomNumber,randInt(1,count getVar(gm_currentMode,listRooms)));
	};

endclass

class(RStorozh) extends(RDetectiveModeRole)
	var(name,"Сторож");
	var(desc,"Ещё в прошлом цикле охранял вход в поместье. Сегодня же будешь охранять постояльцев внутри друг от друга.");
	getter_func(getSkills,vec4(randInt(11,13),randInt(8,10),randInt(8,12),randInt(8,10))); //["_st","_iq","_dx","_ht"];
	var(reputationNeed,rolerep(1,8,6));
	func(getOtherSkills) {[
		skillrand(surgery,0,2) arg
		skillrand(healing,0,3) arg
		skillrand(baton,1,3) arg
		skillrand(fight,2,4)
	]};

	getter_func(getInitialPos,vec3(3633.65,3672.38,13.4181));
	getter_func(getInitialDir,356.511);
	//cloth CitizenCloth4, head HatUshanka

	func(getEquipment)
	{
		objParams_1(_mob);

		["HatUshanka",_mob,INV_HEAD] call createItemInInventory;
		["SigaretteDisabled",_mob,INV_FACE] call createItemInInventory;
		private _cloth = ["CitizenCloth4",_mob,INV_CLOTH] call createItemInInventory;
		setVar(_cloth,name,"Сторожские лохмотья");
		regKeyInUniform(_cloth,["ohr"],"Ключ сторожа");
		callFuncParams(_cloth,initMoney,randInt(1,2));

		["DBShotgun",_mob] call createItemInInventory;

		_am = ["AmmoShotgunNonLethal",_mob] call createItemInInventory;
		callFuncParams(_am,initCount,randInt(4,8));
	};

endclass

//late roles
class(RDetectiveHelper) extends(RDetectiveModeRole)
	var(name,"Помощник дознавателя");
	var(desc,"С небольшим опозданием прибыл в поместье для содействия старшему дознавателю.");
	getter_func(canTakeInLobby,false);
	var(reputationNeed,rolerep(0,7,7));
	#ifdef EDITOR
	getter_func(canVisibleAfterStart,gm_roundDuration >= 5);
	#else
	getter_func(canVisibleAfterStart,gm_roundDuration >= (60 * 2));
	#endif
	getter_func(getInitialPos,vec3(3632,3667.2,13.3369));
	getter_func(getInitialDir,92.3);
	getter_func(getSkills,vec4(randInt(10,13),randInt(10,11),randInt(10,12),randInt(9,10))); //["_st","_iq","_dx","_ht"];
	func(getOtherSkills) {[
		skillrand(sword,0,3) arg
		skillrand(fight,1,3) arg
		skillrand(pistol,0,4)
	]};
	getterconst_func(canShownMurderInfo,false);
	//cloth GreatcoatWhiteBrown

	func(getEquipment)
	{
		objParams_1(_mob);

		//["ShortSword",_mob,INV_BELT] call createItemInInventory;
		private _pistol = ["PistolPBM",_mob,INV_BELT] call createItemInInventory;
		callFuncParams(_pistol,createMagazine,"MagazinePBMLoaded_NonLethal");

		["HoodChemicalProt",_mob,INV_HEAD] call createItemInInventory;
		private _cloth = ["GreatcoatWhiteBrown",_mob,INV_CLOTH] call createItemInInventory;
		//["RDetectCheckMurder",_cloth] call createItemInContainer;

		callFuncParams(_cloth,initMoney,randInt(1,10));

		["PenBlack",_cloth] call createItemInContainer;
		for "_i" from 1 to 2 do {
			["Paper",_cloth] call createItemInContainer;
		};
		private _am = ["AmmoPBMNonLethal",_cloth] call createItemInContainer;
		if !isNullReference(_am) then {callFuncParams(_am,initCount,randInt(3,17))}
	};

	func(onAssigned)
	{
		objParams_2(_mob,_usr);
		super();

		getVar(gm_currentMode,lawyers) pushBackUnique _mob;
	};

endclass

class(RDetectiveFriend) extends(RDetectiveModeRole)
	var(name,"Близкий друг помещика");
	var(desc,"Незадолго до убийства приехал к помещику повидаться. С начала этого цикла попытался покинуть поместье. Допрошен и возвращен в поместье до выяснения обстоятельств.");
	var(reputationNeed,rolerep(0,1,0));
	getter_func(canTakeInLobby,false);
	getter_func(canVisibleAfterStart,gm_roundDuration >= (60 * 5));
	getter_func(getInitialPos,vec3(3632,3667.2,13.3369));
	getter_func(getInitialDir,92.3);
	getter_func(getSkills,vec4(randInt(6,15),randInt(8,13),randInt(6,14),randInt(7,12))); //["_st","_iq","_dx","_ht"];
	func(getOtherSkills) {[
		skillrand(healing,0,4) arg
		skillrand(farming,0,5) arg
		skillrand(cooking,0,6) arg
		skillrand(fight,0,3)
	]};
	getterconst_func(canShownMurderInfo,false);
	//cloth CitizenCloth11

	func(getEquipment)
	{
		objParams_1(_mob);

		private _cloth = ["CitizenCloth11",_mob,INV_CLOTH] call createItemInInventory;
		callFuncParams(_cloth,initMoney,randInt(1,20));
	};

	func(onAssigned)
	{
		objParams_2(_mob,_usr);
		super();
		callFuncParams(gm_currentMode,doKnownLateMobMurder,_mob);
	};

endclass

class(RDetectiveMilker) extends(RDetectiveModeRole)
	var(name,"Молочник");
	var(desc,"У тебя важные документы и ты должен их передать помещику. Поспеши и не разочаруй своего работодателя.");
	getter_func(canTakeInLobby,false);
	var(reputationNeed,rolerep(0,0,6));
	#ifdef EDITOR
	getter_func(canVisibleAfterStart,true);
	#else
	getter_func(canVisibleAfterStart,gm_roundDuration >= (60 * 2));
	#endif
	getterconst_func(canShownMurderInfo,false);

	getter_func(getInitialPos,vec3(3632,3667.2,13.3369));
	getter_func(getInitialDir,92.3);
	getter_func(getSkills,vec4(randInt(9,12),randInt(8,10),randInt(8,13),randInt(8,10))); //["_st","_iq","_dx","_ht"];
	func(getOtherSkills) {[
		skillrand(farming,3,5) arg
		skillrand(cooking,0,2) arg
		skillrand(fight,0,4)
	]};
	//cloth CookerCloth - rename
	func(getEquipment)
	{
		objParams_1(_mob);

		private _cloth = ["CookerCloth",_mob,INV_CLOTH] call createItemInInventory;
		setVar(_cloth,name,"Одежда рабочего");
		callFuncParams(_cloth,initMoney,randInt(1,5));
		private _milkDoc = ["RDetectMilkDoc",_mob,INV_HAND_R] call createItemInInventory;
		setVar(gm_currentMode,milkDoc,_milkDoc);
		if equalTypes(getVar(gm_currentMode,thiefTask),[]) then {
			getVar(gm_currentMode,thiefTask) pushBack _milkDoc;
		};
	};

	func(onAssigned)
	{
		objParams_2(_mob,_usr);
		super();
		callFuncParams(gm_currentMode,doKnownLateMobMurder,_mob);
	};

endclass

	class(RDetectMilkDoc) extends(Paper)
		var(name,"Документы для помещика с КМФ");
		var(desc,"Лучше держать их при себе...");
		getter_func(canWrite,false);
		getter_func(canRead,false);
	endclass

class(RDetectiveThief) extends(RDetectiveModeRole)
	var(name,"Воришка");
	var(desc,"Не понятно как именно, но ты смог пробраться через оцепление в поместье. Будь невидимой тенью и укради кое-что...");
	getter_func(canTakeInLobby,false);
	getter_func(getSkills,vec4(randInt(10,13),randInt(8,11),randInt(13,16),randInt(8,12))); //["_st","_iq","_dx","_ht"];
	var(reputationNeed,rolerep(0,7,7));
	func(getOtherSkills) {[
		skillrand(theft,6,9) arg
		skillrand(stealth,7,10) arg
		skillrand(lockpicking,6,9)
	]};
	#ifdef EDITOR
	getter_func(canVisibleAfterStart,true);
	#else
	getter_func(canVisibleAfterStart,gm_roundDuration >= (60 * 10));
	#endif

	getterconst_func(canShownMurderInfo,false);

	getter_func(getInitialPos,vec3(3649.28,3649.22,13.8953));
	getter_func(getInitialDir,354.721);
	//cloth CookerCloth - rename
	func(getEquipment)
	{
		objParams_1(_mob);

		private _cloth = ["RDetClothThief",_mob,INV_CLOTH] call createItemInInventory;
		callFuncParams(_cloth,initMoney,randInt(1,2));
		["Crowbar",_mob] call createItemInInventory;
		regKeyInUniform(_cloth,["ohr"],"Дубликат ключа сторожа");
		["BalaclavaMask2",_mob,INV_FACE] call createItemInInventory;
		_back = ["SmallBackpack",_mob,INV_BACKPACK] call createItemInInventory;
		["Screwdriver",_back] call createItemInContainer;
		["Flashlight",_back] call createItemInContainer;
		["SmallBattery",_back] call createItemInContainer;
	};

	func(onAssigned)
	{
		objParams_2(_mob,_usr);
		super();
		callFuncParams(gm_currentMode,doKnownLateMobMurder,_mob);

		//pick task
		setVar(gm_currentMode,thiefTask,pick getVar(gm_currentMode,thiefTask));
		private _code = {
			callFuncParams(_this,localSay,"<t size='1.6'>Ты должен украсть " + callFuncParams(getVar(gm_currentMode,thiefTask),getNameFor,_this) + "</t>" arg "event");
		};
		invokeAfterDelayParams(_code,5,_mob);
	};
endclass

	class(RDetClothThief) extends(GromilaCloth)
		var(name,"Куртяйка");
		var(armaClass,"Skyline_Character_U_CivilC_03_F");
	endclass
