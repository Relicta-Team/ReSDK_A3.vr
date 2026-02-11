// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\GameMode.h>

editor_attribute("CodeOnyGamemode")
class(GMDetective) extends(GMBase)

	var(name,"Поместье ''Хвостово''"); //Название истории
	var(desc,"Детективное приключение в роскошном поместье.");
	var(descExtended,"В поместье близ Калеково этой ночью произошло убийство родственника помещика. На место прибыл дознаватель из Калеково для расследования. Выход из поместья перекрыт. Убийца не скроется...");

	getterconst_func(getMapName,"Detective");
	getterconst_func(getLobbySoundName,"lobby\Floor_6_Please.ogg");
	getterconst_func(getLobbyBackground,PATH_PICTURE("lobby\lobbyrats.paa"));

	getterconst_func(getReqPlayersMin,4);
	getterconst_func(getReqPlayersMax,13);
	var(duration,60 * 50); //50 min

	func(getUnsleepGameInfo)
	{
		objParams();
		super() + [
			"Поместье Хвостово, что находится за пределами города Канава, всегда было предметом зависти. Помещик живет в роскоши, владеет мельтешиной фермой и крепостными. Многие желали бы стать там прислугой, и по древней традиции скрещивали пальцы, когда приказчик барина заглядывал на невольничий рынок. Казалось бы, ничто не в силах пошатнуть тишину и покой в благопристойном семействе помещика. Но чем выше ты поднимаешься — тем больнее упасть."+sbr+sbr+"От этой тревожной мысли вы просыпаетесь."
		]
	};

	func(conditionToStart)
	{
		objParams();
		count getVar(("RPomeshik") call gm_getRoleObject,contenders_1) > 0 &&
		count getVar(("RDetective") call gm_getRoleObject,contenders_1) > 0 &&
		{getVar(_x,isReady)} count (call cm_getAllClientsInLobby) >= 4
	};

	func(onFailReasonToStart)
	{
		objParams();
		"Не менее 4х человек. Должен быть помещик и детектив.";
	};

	func(checkFinish)
	{
		objParams();
		if (isNullReference(getSelf(murder)) || isNullReference(getSelf(target)) || isNullReference(getSelf(detective))) exitWith {0};
		if (gm_roundDuration >= getSelf(duration)) exitWith {-1};
		if getVar(getSelf(target),isDead) exitWith {2};
		if getVar(getSelf(murder),isDead) exitWith {-4};
		if getVar(getSelf(detective),isDead) exitWith {4};
		_outzone = (["Mob",[3632.34,3666.95,13.3361],2,true,true] call getMobsOnPosition);
		if (array_exists(_outzone,getSelf(murder)) &&
			{callFunc(getSelf(murder),isGrabbed)} &&
			{array_exists(getSelf(lawyers),getVar(getSelf(murder),grabber))}) exitWith {
				if (getSelf(grabTimer) <= 0) exitWith {5};
				modSelf(grabTimer, - 1);
				0;
			};
		0
	};

	func(getResultTextOnFinish)
	{
		objParams();
		callSelf(getTaskTextSuccessInfo);
	};

	func(getLeadingRolesInfo)
	{
		objParams();
		"<t align='left' color='#AF2CF5' font='PuristaMedium'>В главных ролях:" + sbr +
		callSelfParams(getCreditsInfo,getVar("RPomeshik" call gm_getRoleObject,basicMobs) select 0) + sbr +
		callSelfParams(getCreditsInfo,getSelf(detective)) + sbr +
		callSelfParams(getCreditsInfo,getSelf(murder)) + " (убийца)"+ sbr +
		callSelfParams(getCreditsInfo,getSelf(target)) + " (цель убийцы)"+ sbr +
		"</t>"
	};

	func(getTaskTextSuccessInfo)
	{
		objParams();
		private _tasks = sbr + format["<t align='left' color='#FAB475' font='PuristaMedium'>Задачи убицы (%1):",callFuncParams(getSelf(murder),getNameEx,"кто")];
		private _isDone = false;
		private _points = 0;
		{
			_x params ["_taskStr","_val","_pts"];
			if (_val) then {
				modvar(_points) + _pts;
			};
			_tasks = _tasks + sbr + format["    %1. %2 - <t color='#%4'>%3</t>",_forEachIndex + 1,_taskStr,ifcheck(_val,"Выполнено","Не выполнено"),ifcheck(_val,"417339","7E3E4F")];
		} foreach [
			["Цель мертва",getVar(getSelf(target),isDead),6],
			["Остаться в живых и не быть пойманным",!getVar(getSelf(murder),isDead) && !callFunc(getSelf(murder),isGrabbed),2],
			["Не дать себя раскрыть",!getSelf(murderFinded),3]
		];

		modvar(_tasks) + "</t>" + sbr;
		modvar(_tasks) + sbr + format["<t align='left' color='#FAB475' font='PuristaMedium'>Задачи дознавателя (%1):",callFuncParams(getSelf(detective),getNameEx,"кто")];

		{
			_x params ["_taskStr","_val","_pts"];
			if (_val) then {
				modvar(_points) + _pts;
			};
			_tasks = _tasks + sbr + format["    %1. %2 - <t color='#%4'>%3</t>",_forEachIndex + 1,_taskStr,ifcheck(_val,"Выполнено","Не выполнено"),ifcheck(_val,"417339","7E3E4F")];
		} foreach [
			["Раскрыть убийцу",getSelf(murderFinded),-3],
			["Остаться в живых",!getVar(getSelf(detective),isDead),-1],
			["Уничтожить или захватить убийцу",getVar(getSelf(murder),isDead) || callFunc(getSelf(murder),isGrabbed),-2]
		];

		modvar(_tasks) + "</t>" + sbr;

		if (_points <= 0) then {
			modvar(_tasks) + "<t size='1.5'>Победа дознавателя!</t>";
		} else {
			modvar(_tasks) + "<t size='1.5'>Победа убийцы!</t>";
		};

		private _trader = "RDetectiveTrader" call gm_getRoleObject;
		if (count getVar(_trader,basicMobs) > 0) then {
			_trader = getVar(_trader,basicMobs) select 0;
			if (callFuncParams(_trader,hasItem,getSelf(farmOwnerDoc)) && !getVar(_trader,isDead)) then {
				modvar(_tasks) + sbr + "<t align='left' color='#417339' font='PuristaMedium'>Торговый наместник смог заполучить документы владения КМФ.</t>";
			} else {
				modvar(_tasks) + sbr + "<t align='left' color='#7E3E4F' font='PuristaMedium'>Торговый наместник не смог выполнить задание.</t>";
			};
		};

		private _thief = "RDetectiveThief" call gm_getRoleObject;
		if (count getVar(_thief,basicMobs) > 0 && equalTypes(getSelf(thiefTask),nullPtr)) then {
			_thief = getVar(_thief,basicMobs) select 0;
			if isNullReference(getSelf(thiefTask)) exitWith {};

			if (!isNullReference(getSelf(thiefTask)) && {callFuncParams(_thief,hasItem,getSelf(thiefTask))}) then {
				modvar(_tasks) + sbr + "<t align='left' color='#417339' font='PuristaMedium'>Воришка выкрал " + callFunc(getSelf(thiefTask),getName)+".</t>";
			} else {
				modvar(_tasks) + sbr + "<t align='left' color='#7E3E4F' font='PuristaMedium'>Воришка не смог украсть необходимое.</t>";
			};
		};

		private _pom = "RPomeshik" call gm_getRoleObject;
		if (count getVar(_pom,basicMobs) > 0 && equalTypes(getSelf(thiefTask),nullPtr)) then {
			_pom = getVar(_pom,basicMobs) select 0;
			if callFuncParams(_pom,hasItem,getSelf(milkDoc)) then {
				modvar(_tasks) + sbr + "<t align='left' color='#417339' font='PuristaMedium'>Помещик сохранил документы с фермы.</t>";
			} else {
				modvar(_tasks) + sbr + "<t align='left' color='#7E3E4F' font='PuristaMedium'>Помещик не сохранил или не получил документы с фермы.</t>";
			};
		};

		_tasks
	};

	//список законников
	var(lawyers,[]);
	var(grabTimer,20);

	var(thiefTask,[]);

	var(milkDoc,nullPtr);

	/*
		Задачи следователя
			- вычислить убийцу
				для вычисления нужен итем аля забор крови танати
				1. у следака 2 штуки для поиска убийцы. Если народу меньше 5 человек то штука только одна
				2. он забирает немного крови
				3. если не угадал - антагу дается возможность выключения света, получения топора или яда.
			- не допустить еще смертей
		Задачи убийцы
			Убийца должен был убить другую цель. Смерть родственника была случайна.
			- убейте свою цель ИЛИ убейте следователя
			- не умрите
	*/

	func(getLateRoles)
	{
		/*
			Помощник дознавателя - на помощь приехал
			Близкий друг помещика - приехал повидаться со своим другом. Вечером уехал. Утром найден и возвращен назад.
			Молочник - был в момент убийства в поместье. найден и возвращен назад.
			Воришка - пока шумиха идет надо украсть документы на ферму, бряки.
		*/
		[
			"RDetectiveHelper",
			"RDetectiveFriend",
			"RDetectiveMilker",
			"RDetectiveThief"
		]
	};
	func(getLobbyRoles)
	{
		[
			/*
				Помещик - главный поместья. Имеет крупные мельтешиные фермы близ Калеково,
				Приказчик - помощник,
				Жена Помещика - жена,
				дознаватель - расследует,
				Прислужник - х2 дворецкий
				Торговый наместник - прибыл из Калеково выкупить ферму,
				Сторож - охранник поместья
			*/
			"RPomeshik",
			"RWifePomeshik",
			"RPrikazchik",
			"RDetective",
			"RButler",
			"RDetectiveTrader",
			"RStorozh"

		]
	};
	
	func(preSetup)
	{
		objParams();
		setSelf(lastPointerInt,call pointer_getLastPointer);
	};
	
	//get attach
	func(postSetup)
	{
		objParams();
		//init bank money
		private _bank = ["SteelGreenCabinet",[3674.6,3654.82,16.7455],4,false] call getGameObjectOnPosition;
		if !isNullReference(_bank) then {

			private _count = randInt(500,800);

			callFuncParams(_bank,initMoney,_count arg true);
		};

		private _mailbox = ["LongWeaponContainer",[3631.68,3663.9,14.2541],100,false] call getGameObjectOnPosition;
		if !isNullReference(_mailbox) then {
			_mailbox setVariable [PROTOTYPE_VAR_NAME,pt_RDetMailBox];
			setVar(_mailbox,name,"Почтовый ящик");
			setVar(_mailbox,desc,"Для отправки всякого в Калеково");
			setVar(_mailbox,canUseContainer,false);
		};

		//start generator
		private _gen = ["PowerGenerator",[3693.07,3656.79,0.836593],4,false] call getGameObjectOnPosition;
		if !isNullReference(_gen) then {
			setVar(_gen,energyleft,100000000);
			callFunc(_gen,beginUpdateGenerator);
		};

		//воровские штуки
		getVar(this,thiefTask) pushBack (["TwoHandedSword",[3675.64,3654.81,17.788],5,false] call getGameObjectOnPosition);
		getVar(this,thiefTask) pushBack (["GlassBottle",[3690.12,3665.13,23.619],5,false] call getGameObjectOnPosition);


		//секреты добавляем

		{
			if (getVar(_x,name) == "Странная стена" || {prob_new(20)}) then {
				_l pushback _x;
				setVar(_x,name,"Странная стена");
				//override
				_x setVariable [PROTOTYPE_VAR_NAME,pt_GMDetectiveStructHidden];
				callFunc(_x,onRelink);
			};
		} foreach (["LargeConcreteWallWithReinforcement",[3684.64,3667.82,23.5604],10000,true] call getGameObjectOnPosition);

		callSelf(pickMurder);
		//invokeAfterDelayParams({callFunc(_this,pickMurder)},2,this);
	};
	var(generator,nullPtr);

	func(onRoundCode)
	{
		objParams();
		super();
		this = gm_currentMode;
		setVar(getSelf(generator),energyleft,10000000);
	};


	var(lastRoomNumber,randInt(1,4));
	var(listRooms,[
		vec2(vec3(3681.8,3678.88,23.5439),1) arg
		vec2(vec3(3687.47,3678.71,23.5439),2) arg
		vec2(vec3(3689.28,3673.05,23.5604),3) arg
		vec2(vec3(3689.88,3669,23.5604),4)
	]);

	var(murder,nullPtr);
	var(target,nullPtr);
	var(detective,nullPtr);

	var(murderFinded,false);
	
	var(suspicions,[]); //кто под подозрением
	
	var(allEvidences,[]);//все объекты улик.

	var(killInfo,nullPtr); //getReason(), getProcess()
	var(killPlace,nullPtr);
	getter_func(getMurderPos,getVar(getSelf(killPlace),murderLoc));
	getter_func(getMurderPosName,getVar(getSelf(killPlace),murderLocName));
	getter_func(getMurderKillProcess,callFunc(getSelf(killInfo),getProcess));
	getter_func(getMurderKillReason,callFunc(getSelf(killInfo),getReason));
	
	var(prevTarget,["родственник" arg "родственника"]);

	func(processEvidence)
	{
		objParams_1(_mob);
		private _o = pick getSelf(allEvidences);
		getSelf(allEvidences) deleteAt (getSelf(allEvidences) find _o);
		callFuncParams(_o,handleEvidence,_mob);
		
		getVar(_mob,evidencesList) pushBackUnique _o;
		
	};

	func(pickMurder)
	{
		objParams();

		//select prev target
		private _historyTarget = [
			["сын","сына"],
			["дочь","дочь"],
			["отец","отца"],
			["мать","мать"],
			["тесть","тестя"],
			["теща","тещю"],
			["шурин","шурина"],
			["свояченица","свояченицу"]
		];

		setSelf(prevTarget,pick _historyTarget);
		
		//generate history
		
		//инфо об убийстве и вложенная причина
		setSelf(killInfo,instantiate(pick getObjectsTypeOf(GMDet_KillInfo))); //getReason, getProcess
		
		//все улики
		private _evids = [];
		{
			_evids pushBack instantiate(_x);
		} foreach getObjectsTypeOf(GMDet_Evidence);
		setSelf(allEvidences,array_shuffle(_evids));
		
		//локация где было убийство
		private _murderInfoList = getObjectsTypeOf(GMDet_MurderInfo);
		private _murdLoc = pick _murderInfoList;//лока убийства
		private _possibleLoc = _murderInfoList - [_murdLoc];//все остальные возможные 
		
		_murdLoc = instantiate(_murdLoc);
		setSelf(killPlace,_murdLoc);
		private _bpOff = getVar(_murdLoc,bloodPoolRandOffset);
		if equalTypes(_bpOff,0) then {_bpOff = [_bpOff,_bpOff]};
		_bpOff params [["_blX",0],["_blY",0],["_blZ",0]];
		[
			"BloodPoolBig",
			getVar(_murdLoc,murderLoc) vectorAdd [rand(-_blX,_blX),rand(-_blY,_blY),rand(-_blZ,_blZ)],null,false
		] call createItemInWorld;
		
		//set detective

		private _all = [];
		{
			if (_x in ["RDetective"]) then {continue};
			_mList = getVar(_x call gm_getRoleObject,basicMobs);
			_all append _mList;
		} foreach callSelf(getLobbyRoles);
		setSelf(murder,pick _all);
		_all deleteAt (_all find getSelf(murder));
		#ifdef EDITOR
		setSelf(target,getSelf(murder));
		#else
		setSelf(target,pick _all);
		#endif
		private _t = "";
		#ifdef EDITOR
		_all pushBack getSelf(murder);
		#endif
		{
			_t = format["Прошлой ночью произошло убийство. Жертва - %2 помещика.%1Место убийства - %5.%1В момент убийства ты %4 в %3",
				sbr,
				getSelf(prevTarget) select 0,
				lowerize(getFieldBaseValue(pick _possibleLoc,"murderLocName")),
				pick["пытаешься отдохнуть","спишь","ужинаешь","занимаешься своими обязанностями","выпиваешь","задабриваешь себя","бездельничаешь","куришь"],
				lowerize(getVar(_murdLoc,murderLocName))
			];
			callFuncParams(_x,addFirstJoinMessage,"<t size='1.5'>"+_t+"</t>");
		} foreach _all;
		setSelf(suspicions,_all);
		
		private _txt = format["<t align='center' color='#ff0000' size='1.5'>Ты - убийца. Прошлой ночью ты ошибся и убил %4 в %5. Но твоей целью был другой человек...%3Устрани %1 (%2). Ты хочешь убить свою цель по следующей причине - %6.</t>",callFuncParams(getSelf(target),getNameEx,"кого"),getVar(getVar(getSelf(target),basicRole),name),sbr,
			getSelf(prevTarget) select 1,
			lowerize(getVar(_murdLoc,murderLocName)),
			callSelf(getMurderKillReason)
		];
		callFuncParams(getSelf(murder),addFirstJoinMessage, _txt);
		_txt = "<t size='1.4'>Я помню как спрятал в поместье вещи, которые помогут мне убить цель. Нужно искать белые странные стены...</t>";
		callFuncParams(getSelf(murder),addFirstJoinMessage, _txt);
		
		setVar(getSelf(murder),stealth,randInt(15,18));
		setVar(getSelf(murder),lockpicking,randInt(14,17));
		//callFuncParams(getSelf(murder),updateSkillLevel,"stealth" arg randInt(8,11));
		//callFuncParams(getSelf(murder),updateSkillLevel,"lockpicking" arg randInt(7,10));
	};
	var(lastPointerInt,0);
	var(leftItems,array_shuffle(["GMDetectiveItemGlassVenomBottle" arg "GMDetectiveItemKeyUniversal" arg "GMDetectiveItemWeaponMurder"]));

	//приезжий знает кто убил
	func(doKnownLateMobMurder)
	{
		objParams_1(_mob);

		if prob(10) then {

			private _mes = format["<t color='#ff0000' size='1.3'>Ты знаешь, что убийца %1. </t>%2<t = color='#E67C7C'А что делать с этой информацией решать тебе...</t>",callFuncParams(getVar(gm_currentMode,murder),getNameEx,"кто"),sbr];
			callFuncParams(_mob,addFirstJoinMessage,_mes)
		} else {

		};
	};

	var(farmOwnerDoc,nullPtr);

	func(checkMurder)
	{
		objParams_2(_mobcheck,_usr);
		
		if getSelf(murderFinded) exitWith {};
		
		//private _code = {
		//	objParams_2(_mobcheck,_usr);
			if equals(_mobcheck,getSelf(murder)) then {
				/*private _txt = format["<t align='center' color='#00ff00' size='1.3'>%1 убийца! Останови его любой ценой. </t>",callFuncParams(_mobcheck,getNameEx,"кто")];
				callFuncParams(_usr,localSay,_txt arg "event");

				if getSelf(murderFinded) exitWith {};

				//убийцу раскрыли. даём ему статы
				callFuncParams(getSelf(murder),addTimeBouns,"st" arg +4 arg 99999);
				callFuncParams(getSelf(murder),addTimeBouns,"ht" arg +2 arg 99999);
				callFuncParams(getSelf(murder),localSay,"Они знают, что ты убийца... Быстрее!" arg "mind");*/

				setSelf(murderFinded,true);

			} else {
				private _txt = format["<t align='center' color='#ff0000' size='1.3'>%1 не убийца.</t>",callFuncParams(_mobcheck,getNameEx,"кто")];
				callFuncParams(_usr,localSay,_txt arg "event");
			};
		//};
		
		//invokeAfterDelayParams(_code,randInt(10,30),_this);
	};

endclass

class(GMDetectiveStructHidden) extends(LargeConcreteWallWithReinforcement)
	var(isSpawnedItem,false);
	func(onRelink)
	{
		objParams();
		setSelf(isSpawnedItem,false);
	};
	func(onClick)
	{
		objParams_1(_usr);
		if not_equals(_usr,getVar(gm_currentMode,murder)) exitWith {};

		if getSelf(isSpawnedItem) exitWith {
			callFuncParams(_usr,localSay,"Там ничего нет..." arg "mind");
		};
		if (count getVar(gm_currentMode,leftItems) == 0) exitWith {};
		setSelf(isSpawnedItem,true);

		[getVar(gm_currentMode,leftItems) deleteAt 0,_usr] call createItemInInventory;
	};

endclass

class(GMDetectiveItemGlassVenomBottle) extends(GlassBottle)

	getterconst_func(contentReagents,[vec2("VenomDead",30)]);

endclass

class(GMDetectiveItemKeyUniversal) extends(Key)
	var(keyOwner,["super"]);
endclass

class(GMDetectiveItemWeaponMurder) extends(SawedOff)
	var(name,"Терпилыч");
	var(basicDamage,vec2(2,4));
	func(constructor)
	{
		objParams();
		callSelfParams(createAmmoInMagazine,"AmmoShotgun" arg 2);
	};
endclass

//Улики
region(evidences)
	class(GMDet_Evidence) extends(IGamemodeSpecificClass)
		var(canCreateOnDetective,false); //создаётся на детективе объект
		var(evidenceInfo,"");//объект который создаётся или текст что за улика
		func(onCreateEvidenceOnDetective)
		{
			objParams_1(_det);
			if getSelf(canCreateOnDetective) then {
				[getSelf(evidenceInfo),_det] call createItemInInventory;
			} else {
				nullPtr
			};
		};
		func(onPostUpdateEvidenceInfo)
		{
			objParams_1(_item);
			if !isNullReference(_item) then {
				setSelf(evidenceInfo,callFunc(_item,getName));
			} else {
				setSelf(evidenceInfo,"Улика");
			};
		};
		var(reasonEvidence,"Просто улика...");//что означает эта улика
		
		//строка что удалось найти %1 название улики
		func(getEvidenceMessage)
		{
			objParams();
			"Мне удалось найти улику!"
		};
		
		func(handleEvidence)
		{
			objParams_1(_det);
			if getSelf(canCreateOnDetective) then {
				private _item = callSelfParams(onCreateEvidenceOnDetective,_det);
				callSelfParams(onPostUpdateEvidenceInfo,_item);	
			};
			private _m = format[callSelf(getEvidenceMessage),getSelf(evidenceInfo),callFunc(callFunc(_det,getLastInteractTarget),getName)];
			callFuncParams(_det,mindSay,"<t size='1.6'>"+_m+"</t>");
		};
		
	endclass

	class(GMDet_Evidence_Loskut) extends(GMDet_Evidence)
		var(canCreateOnDetective,false);
		var(evidenceInfo,"кусок ткани");
		getter_func(getEvidenceMessage,"Мне удалось найти %1! Оторванный кусок от чьей-то одежды.");
		var(reasonEvidence,"Убийца напал на жертву в другой одежде.");
	endclass
	
	class(GMDet_Evidence_Sledi) extends(GMDet_Evidence)
		var(canCreateOnDetective,false);
		var(evidenceInfo,"следы от обуви");
		getter_func(getEvidenceMessage,"Мне удалось найти %1! Чьи же они?");
		var(reasonEvidence,"Перед убийством убийца был во дворе"+comma+", видимо готовя всё для преступления.");
	endclass
	
	class(GMDet_Evidence_Carapini) extends(GMDet_Evidence)
		var(canCreateOnDetective,false);
		var(evidenceInfo,"царапины");
		getter_func(getEvidenceMessage,"Мне удалось найти %1 на %2! Возможно следы от ногтей.");
		var(reasonEvidence,"Жертва пыталась уползти"+comma+" но убийца тащил её.");
	endclass
	
	class(GMDet_Evidence_Volos) extends(GMDet_Evidence)
		var(canCreateOnDetective,false);
		var(evidenceInfo,"клок волос");
		getter_func(getEvidenceMessage,"Мне удалось найти %1! Чьи они?");
		var(reasonEvidence,"Это волосы жертвы. Убийца схватил за волосы жертву.");
	endclass
	
	class(GMDet_Evidence_Bottle) extends(GMDet_Evidence)
		var(canCreateOnDetective,true);
		var(evidenceInfo,"GlassBottle");
		getter_func(getEvidenceMessage,"Мне удалось найти %1! Что она здесь делает?");
		var(reasonEvidence,"Убийца решил напоить жертву"+comma+" чтобы с ней было легче справиться.");
		func(onCreateEvidenceOnDetective)
		{
			objParams_1(_det);
			private _item = super();
			setVar(_item,name,"Бутылка");
			_item
		};
	endclass
	
	class(GMDet_Evidence_GlassPiece) extends(GMDet_Evidence)
		var(canCreateOnDetective,false);
		var(evidenceInfo,"осколок стекла");
		var(reasonEvidence,"Когда убийца напал на жертву"+comma+"у неё в руке был бокал. От испуга жертва уронила его и бокал разбился.");
		getter_func(getEvidenceMessage,"Мне удалось найти %1! Возможно убийца кинул в жертву что-то стеклянное.");
	endclass
	
	class(GMDet_Evidence_CombatPlace) extends(GMDet_Evidence)
		var(canCreateOnDetective,false);
		var(evidenceInfo,"следы боя");
		var(reasonEvidence,"Жертва сопротивлялась"+comma+" но убийца оказался сильнее.");
		getter_func(getEvidenceMessage,"Мне удалось найти %1! Тут велась борьба.");
	endclass
	
	class(GMDet_Evidence_BrokenPaper) extends(GMDet_Evidence)
		var(canCreateOnDetective,true);
		var(evidenceInfo,"GMDet_Item_BrokenPaper");
		getter_func(getEvidenceMessage,"Мне удалось найти %1! Он обгорел.");
		var(reasonEvidence,"Жертва знала убийцу"+comma+" но боялась чего-то и решила просто донести на него. Убийца попытался сжечь листок.");
		func(onCreateEvidenceOnDetective)
		{
			objParams_1(_det);
			private _item = super();
			setVar(_item,name,"Обгоревший листок");
			setVar(_item,desc,"Кто-то хорошо постарался - написанное на этой бумаге уже не разобрать.");
			_item
		};
	endclass
		
		class(GMDet_Item_BrokenPaper) extends(Paper)
			getter_func(canRead,false);
			getter_func(canWrite,false);
		endclass
	
	class(GMDet_Evidence_MurderWeapon) extends(GMDet_Evidence)
		var(canCreateOnDetective,true);
		var(evidenceInfo,pick ["KitchenKnife" arg "WorkingAxe" arg "Crowbar"]);
		var(reasonEvidence,"Убийца попытался избавиться от орудия убийства. У него это не получилось.");
		func(onCreateEvidenceOnDetective)
		{
			objParams_1(_det);
			private _item = super();
			setVar(_item,name,"Орудие убийства");
			_item
		};
		getter_func(getEvidenceMessage,"Мне удалось найти орудие убийства!?");
	endclass
	
	class(GMDet_Evidence_Saja) extends(GMDet_Evidence)
		var(canCreateOnDetective,false);
		var(evidenceInfo,"сажа");
		var(reasonEvidence,"Какие-то из улик убийца пытался сжечь и измазался в саже.");
		getter_func(getEvidenceMessage,"Это %1 на %2! Почему здесь?");
	endclass
	
	class(GMDet_Evidence_BloodPodteki) extends(GMDet_Evidence)
		var(canCreateOnDetective,false);
		var(evidenceInfo,"капли крови");
		var(reasonEvidence,"Кровь убийцы. Жертве удалось ранить его.");
		getter_func(getEvidenceMessage,"Это %1 на %2! Чья же это кровь?");
	endclass
	
	class(GMDet_Evidence_Derevashki) extends(GMDet_Evidence)
		var(canCreateOnDetective,false);
		var(evidenceInfo,"щепки");
		var(reasonEvidence,"Убийца ударил чем-то деревянным жертву сзади по голове.");
		getter_func(getEvidenceMessage,"Это %1! Тут что-то сломалось.");
	endclass
	
	class(GMDet_Evidence_Otpechatki) extends(GMDet_Evidence)
		var(canCreateOnDetective,false);
		var(evidenceInfo,"отпечатки");
		var(reasonEvidence,"Убийца оставил отпечатки на месте убийства.");
		getter_func(getEvidenceMessage,"Это %1 на %2! Чьи они?");
	endclass
	
	class(GMDet_Evidence_StrangeZidkost) extends(GMDet_Evidence)
		var(canCreateOnDetective,false);
		var(evidenceInfo,"странная жидкость");
		var(reasonEvidence,"Убийца хотел отравить жертву чем-то"+comma+" но что-то ему помешало.");
		getter_func(getEvidenceMessage,"Это %1 на %2! Что же это?");
	endclass
	
region(Murder info)

	class(GMDet_MurderInfo) extends(IGamemodeSpecificClass)
		var(murderLoc,vec3(0,0,0)); //где было убийство
		var(murderLocName,"Поместье"); //строковое название
		var(bloodPoolRandOffset,vec3(0,0,0));//рандомизация лужи крови. может быть vec2
	endclass

	class(GMDet_MurderInfo_Tualet) extends(GMDet_MurderInfo)
		var(murderLoc,vec3(3635.91,3686.03,13.4821));
		var(murderLocName,"Туалет");
		var(bloodPoolRandOffset,1.5);
	endclass
	
	class(GMDet_MurderInfo_Molitvennik) extends(GMDet_MurderInfo)
		var(murderLoc,vec3(3648.71,3652.98,14.6356));
		var(murderLocName,"Молитвенник");
		var(bloodPoolRandOffset,1);
	endclass

	class(GMDet_MurderInfo_PomKoridor) extends(GMDet_MurderInfo)
		var(murderLoc,vec3(3665.15,3665.39,16.5075));
		var(murderLocName,"Коридор поместья");
		var(bloodPoolRandOffset,2);
	endclass
	
	class(GMDet_MurderInfo_LowLestnica) extends(GMDet_MurderInfo)
		var(murderLoc,vec3(3680.03,3664.66,16.9075));
		var(murderLocName,"Лестница в главном зале");
		var(bloodPoolRandOffset,2);
	endclass
	
	class(GMDet_MurderInfo_LightSklad) extends(GMDet_MurderInfo)
		var(murderLoc,vec3(3674.73,3677.88,16.8297));
		var(murderLocName,"Склад инструментов");
		var(bloodPoolRandOffset,2);
	endclass
	
	class(GMDet_MurderInfo_FoodSklad) extends(GMDet_MurderInfo)
		var(murderLoc,vec3(3682,3684.49,16.7764));
		var(murderLocName,"Склад продовольствия");
		var(bloodPoolRandOffset,3);
	endclass
	
	class(GMDet_MurderInfo_MainHall) extends(GMDet_MurderInfo)
		var(murderLoc,vec3(3682.34,3676.97,16.8639));
		var(murderLocName,"Главный зал");
		var(bloodPoolRandOffset,5);
	endclass
	
	class(GMDet_MurderInfo_StolovHead) extends(GMDet_MurderInfo)
		var(murderLoc,vec3(3698.17,3668.11,18.2465));
		var(murderLocName,"Столовая знати");
		var(bloodPoolRandOffset,3);
	endclass
	
	class(GMDet_MurderInfo_SlugiHouse) extends(GMDet_MurderInfo)
		var(murderLoc,vec3(3681.86,3654.9,17.1317));
		var(murderLocName,"Комната прислуги");
		var(bloodPoolRandOffset,2);
	endclass
	
	class(GMDet_MurderInfo_SlugiStolov) extends(GMDet_MurderInfo)
		var(murderLoc,vec3(3681.97,3654.41,20.3213));
		var(murderLocName,"Столовая прислуги");
		var(bloodPoolRandOffset,2);
	endclass
	
	class(GMDet_MurderInfo_Zal2etaz) extends(GMDet_MurderInfo)
		var(murderLoc,vec3(3683.7,3669.9,23.559));
		var(murderLocName,"Зал второго этажа");
		var(bloodPoolRandOffset,3);
	endclass

	class(GMDet_MurderInfo_Koridor2etaz) extends(GMDet_MurderInfo)
		var(murderLoc,vec3(3691.55,3663.94,23.559));
		var(murderLocName,"Коридор второго этажа");
		var(bloodPoolRandOffset,2);
	endclass
	
	class(GMDet_MurderInfo_Koridor2etaz_2) extends(GMDet_MurderInfo_Koridor2etaz)
		var(murderLoc,vec3(3697.01,3670.93,23.559));
		var(bloodPoolRandOffset,2);
	endclass
	
	class(GMDet_MurderInfo_Biblio) extends(GMDet_MurderInfo)
		var(murderLoc,vec3(3694.4,3679.21,23.5577));
		var(murderLocName,"Библиотека");
		var(bloodPoolRandOffset,3);
	endclass
	
	class(GMDet_MurderInfo_Kuhnya) extends(GMDet_MurderInfo)
		var(murderLoc,vec3(3705,3669.51,18.2704));
		var(murderLocName,"Кухня");
	endclass
	
	class(GMDet_MurderInfo_ZadDvor) extends(GMDet_MurderInfo)
		var(murderLoc,vec3(3710.02,3644.8,17.0672));
		var(murderLocName,"Задний двор");
		var(bloodPoolRandOffset,4);
	endclass

	class(GMDet_MurderInfo_Besedka) extends(GMDet_MurderInfo)
		var(murderLoc,vec3(3715.12,3634.4,17.0928));
		var(murderLocName,"Недостроенная беседка");
		var(bloodPoolRandOffset,1);
	endclass
	
	class(GMDet_MurderInfo_Ferma) extends(GMDet_MurderInfo)
		var(murderLoc,vec3(3714.04,3662.49,16.8946));
		var(murderLocName,"Ферма на заднем дворе");
		var(bloodPoolRandOffset,2);
	endclass

	class(GMDet_MurderInfo_KomnataOtdiha) extends(GMDet_MurderInfo)
		var(murderLoc,vec3(3698,3656.92,18.3174));
		var(murderLocName,"Комната отдыха");
	endclass
	
	class(GMDet_MurderInfo_BragaSklad) extends(GMDet_MurderInfo)
		var(murderLoc,vec3(3705.88,3670.77,12.9483));
		var(murderLocName,"Бражный склад в подвале");
		var(bloodPoolRandOffset,1);
	endclass
	
	class(GMDet_MurderInfo_ShitovayaPodval) extends(GMDet_MurderInfo)
		var(murderLoc,vec3(3696.36,3658.19,12.2953));
		var(murderLocName,"Щитовая в подвале");
		var(bloodPoolRandOffset,2);
	endclass
	
	class(GMDet_MurderInfo_SwitchersPodval) extends(GMDet_MurderInfo)
		var(murderLoc,vec3(3694.82,3651.62,12.3468));
		var(murderLocName,"Лестница в подвал");
		var(bloodPoolRandOffset,1);
	endclass
	
	class(GMDet_MurderInfo_PomeshBalkon) extends(GMDet_MurderInfo)
		var(murderLoc,vec3(3664.96,3665.77,23.5503));
		var(murderLocName,"Балкон помещика");
		var(bloodPoolRandOffset,1);
	endclass
	
	class(GMDet_MurderInfo_PomeshOffice) extends(GMDet_MurderInfo)
		var(murderLoc,vec3(3674.88,3671.68,23.5632));
		var(murderLocName,"Рабочий кабинет помещика");
		var(bloodPoolRandOffset,2);
	endclass

region(Kill info)
	class(GMDet_KillInfo) extends(IGamemodeSpecificClass)
		
		func(getReason)
		{
			objParams();
			getVar(getSelf(killReason),reasonText);
		};
		
		func(getProcess)
		{
			objParams();
			getSelf(killProcessText);
		};
		
		var(killReason,nullPtr);//причина убийства
		var(killProcessText,"Убийство");//как убита
		
		func(constructor)
		{
			objParams();
			setSelf(killReason,instantiate(pick getObjectsTypeOf(GMDet_MurderReason)));
		};
	endclass
	
	class(GMDet_KillInfo_Melee_Knife) extends(GMDet_KillInfo)
		private _t = [
			"Жертва погибла от нанесённых травм ножом.",
			"Жертве перерезали горло.",
			"Жертве воткнули нож в сердце.",
			"Жертве воткнули нож в спину.",
			"Жертве воткнули нож в голову"
		];
		var_exprval(killProcessText,pick _t);
	endclass
	
	class(GMDet_KillInfo_Melee_Crowbar) extends(GMDet_KillInfo)
		_t = [
			"Жертва погибла от нанесённых травм ломом.",
			"Жертву проткнули насквозь длинным предметом.",
			"Жертве пронзили голову.",
			"Жертве снесли голову ломом."
		];
		var_exprval(killProcessText,pick _t);
	endclass

	class(GMDet_KillInfo_Melee_Axe) extends(GMDet_KillInfo)
		_t = [
			"Жертву разрубили топором напополам.",
			"Жертве отрубили голову топором.",
			"Жертву изрубили на куски топором."
		];
		var_exprval(killProcessText,pick _t);
	endclass
	
	class(GMDet_KillInfo_Venom) extends(GMDet_KillInfo)
		_t = [
			"Жертву отравили неизвестным веществом.",
			"Жертву отравили химикатами."
		];
		var_exprval(killProcessText,pick _t);
	endclass
	
	class(GMDet_KillInfo_Forced) extends(GMDet_KillInfo)
		private _t = [
			"Жертву избили до смерти.",
			"Жертву скинули с высоты.",
			"Жертве проломили голову тяжелым предметом.",
			"Жертве сломали шею.",
			"Жертву задушили."
		];
		var_exprval(killProcessText,pick _t);
	endclass

region(murder reason)
	//мотивы убийцы
	class(GMDet_MurderReason) extends(IGamemodeSpecificClass)
		var(reasonText,"");//причина убийства
	endclass
	
	class(GMDet_MurderReason_Love) extends(GMDet_MurderReason)
		var(reasonText,"Неразделённая любовь");
	endclass
	
	class(GMDet_MurderReason_Obida) extends(GMDet_MurderReason)
		var(reasonText,"Давняя обида");
	endclass
	
	class(GMDet_MurderReason_Revenge) extends(GMDet_MurderReason)
		var(reasonText,"Кровная месть");
	endclass
	
	class(GMDet_MurderReason_Money) extends(GMDet_MurderReason)
		var(reasonText,"Крупная сумма денег");
	endclass
	
	class(GMDet_MurderReason_Dolg) extends(GMDet_MurderReason)
		var(reasonText,"Денежные долги");
	endclass
	
	class(GMDet_MurderReason_NoAlko) extends(GMDet_MurderReason)
		var(reasonText,"Отказался выпить");
	endclass
	
	class(GMDet_MurderReason_Psih) extends(GMDet_MurderReason)
		var(reasonText,"Сумасшествие");
	endclass
	
	class(GMDet_MurderReason_TOM) extends(GMDet_MurderReason)
		var(reasonText,"ТОМность");
	endclass
	
	class(GMDet_MurderReason_KnowSecret) extends(GMDet_MurderReason)
		var(reasonText,"Знает какой-то секрет");
	endclass
	
	class(GMDet_MurderReason_Izdevka) extends(GMDet_MurderReason)
		var(reasonText,"Издевательства");
	endclass
