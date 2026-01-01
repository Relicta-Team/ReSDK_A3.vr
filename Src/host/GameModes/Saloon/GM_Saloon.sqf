// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\GameMode.h>

editor_attribute("CodeOnyGamemode")
class(GMSaloon) extends(GMBase)
	getterconst_func(isPlayableGamemode,false);
	var(name,"Переполох"); //Название истории
	var(desc,"Потасовка в небольшом районе большого города."); //Описание краткое для голосований например
	var(descExtended,"Криминальный мир Злачника - неблагоприятного района Канавы"+comma+" пытается установить свои порядки.");
	
	func(getUnsleepGameInfo)
	{
		objParams();
		super() + [
			"Пустые глазницы заброшенных, опустевших зданий, снующие в тусклом свете факелов тени, завалы битого кирпича, кисловатая вонь по углам и хриплые вопли вдалеке. То ли смех, то ли брань — как обычно, не разобрать. Вот что такое Злачник — изолированный район столицы Свободных Поселений. Когда-то давно тут вспыхнула эпидемия, район изолировали и его жители оказались в ловушке. Когда с эпидемией было покончено, власти Канавы пожелали восстановить контроль, но им дали отпор Руки — криминальная группировка, захватившая контроль над Злачником. Говорят, тут есть бар ""Дыра"", где очень хорошая и недорогая выпивка и кухня..."+sbr+sbr+"...Ваш живот заурчал, и вы просыпаетесь."
		]
	};

	
	func(getStartSong)
	{
		objParams_1(_usr);
		private _mob = callFunc(_usr,getActorMob);
		private _banditTheme = false;
		if !isNullReference(_mob) then {
			_banditTheme = isTypeOf(getVar(_mob,basicRole),RBanditMainSaloon) || 
			isTypeOf(getVar(_mob,basicRole),RBanditMiniSaloon)
		};
		if (_banditTheme) exitwith {
			"round\start_zlachnik_bandit"
		};
		"round\start_zlachnik"
	};
	func(getEndSong)
	{
		objParams_1(_usr);
		//if (getSelf(finishResult) > 0) exitwith {"round\kingpin"};
		"events\Floating"
	};

	getterconst_func(getLobbySoundName,"lobby\Dark_Water.ogg");
	getterconst_func(getLobbyBackground,PATH_PICTURE("lobby\zlachnik.paa"));
	getterconst_func(getReqPlayersMin,4);
	getterconst_func(getReqPlayersMax,15);
	func(getLobbyRoles)
	{
		[
		"RBarmenSaloon",
		"RGromilaSaloon",
		"RCookSaloon",
		"RCitizenSaloon",
		"RAssasinSaloon",
		"RTrampSaloon",
		"RBanditMainSaloon",
		"RBanditMiniSaloon",
		"RTorgSaloon"
		]
	};
	func(getLateRoles)
	{
		[
			"RSBSComannderSaloon",
			"RSBSRookieSaloon"
		]
	};
	
	getter_func(conditionToStart,count getVar(("RBarmenSaloon") call gm_getRoleObject,contenders_1) >= 1 && count getVar(("RBanditMainSaloon") call gm_getRoleObject,contenders_1) >= 1);
	getter_func(onFailReasonToStart,"Нужен владелец бара ""Дыра"" и пахан.");
	
	var(duration,60 * 60); //1 час
	getterconst_func(getMapName,"Saloon");
	
	var(task,nullPtr);
	var(taskList,["Saloon_Task_Portfel" arg "Saloon_Task_Docs" arg "Saloon_Task_Kill"]);
	
	var(protectedWalls,[]);//защитные стены убираются когда спавнится командир охров
	var(countDoors,0);
	func(preSetup)
	{
		objParams();
		
		#ifdef EDITOR
		getSelf(taskList) deleteAt (getSelf(taskList) find "Saloon_Task_Kill");
		#endif
		
		private _task = pick getSelf(taskList);
		_task = instantiate(_task);
		setSelf(task,_task);
		
		{
			if (getVar(_x,name) == "Защитная стена") then {
				getSelf(protectedWalls) pushBack _x;
			};
		} foreach (["Decor",[3369.11,3624.7,20.0977],20,true,true] call getGameObjectOnPosition);
		
		
		//door enter
		{
			setVar(_x,keyTypes,["bar" arg "barsuper"]);
		} foreach (["WoodenDoor",[3449.73,3604.19,18.0939],5,true,false] call getGameObjectOnPosition);
		//bar back
		private _back = (["WoodenDoor",[3470.95,3601.81,18.0835],5,!true,false] call getGameObjectOnPosition );
		setVar(_back,keyTypes,["barback" arg "barsuper"]);
		private _barowner = (["SteelBrownDoor",[3475.68,3604.31,22.7188],2,!true,false] call getGameObjectOnPosition );
		setVar(_barowner,keyTypes,["barowner" arg "barsuper"]);
		private _grom = (["SteelBrownDoor",[3477.43,3602.94,22.7188],2,!true,false] call getGameObjectOnPosition );
		setVar(_grom,keyTypes,["bargrom" arg "barsuper"]);
		
		{
			modSelf(countDoors, + 1);
			setVar(_x,keyTypes,["barsuper" arg "bardoor" + str getSelf(countDoors)]);
			setVar(_x,name,format["Комната %1" arg getSelf(countDoors)]);
			callFuncParams(_x,setDoorLock,true);
		} foreach (["SteelDoorThinSmall",[3468.55,3601.12,22.7446],20,true,false] call getGameObjectOnPosition );
		
		//key sunduk
		private _k = null;
		private _keysund = ["ContainerGreen",[3479.43,3609.61,22.7188],180,false] call createStructure;
		setVar(_keysund,name,"Ящик с ключами");
		for "_i" from 1 to getSelf(countDoors) do {
			for "_x" from 1 to 2 do {
				_k = ["Key",_keysund] call createItemInContainer;
				setVar(_k,keyOwner,["bardoor" + str _i]);
				setVar(_k,name,"Ключ от комнаты "+str _i);
			};
		};
		_k = ["Key",_keysund] call createItemInContainer;
		setVar(_k,name,"Ключ от кухни");
		setVar(_k,keyOwner,["barback"]);
		_k = ["Key",_keysund] call createItemInContainer;
		setVar(_k,name,"Ключ от входа в бар");
		setVar(_k,keyOwner,["bar"]);
	};
	
	var(banditBasePos,vec3(0,0,0));
	func(postSetup)
	{
		objParams();

		//start generator
		private _gen = ["PowerGenerator",[3421,3552.17,7.52494],4,false] call getGameObjectOnPosition;
		if !isNullReference(_gen) then {
			callFunc(_gen,beginUpdateGenerator);
		};
		setVar(_gen,energyleft,100000000);
		

		if (count cm_allClients >= 20) then {	
			setSelf(duration,60* (60*2));
		};
		
		callFunc(getSelf(task),onTaskInit);
		{
			if (getVar(_x,model) == "a3\structures_f_epa\civ\camping\woodentable_small_f.p3d") exitWith {
				setVar(_x,name,"Общак");
				setVar(_x,desc,"Бандитский общак группировки ""Руки"".");
				setSelf(banditBasePos,callFunc(_x,getModelPosition));
			};
		} foreach (["GameObject",[3365.13,3705.47,21.9511],2,!false,true] call getGameObjectOnPosition);
		
		private _extMagsLoc = [3365.29,3705.12,21.8288];
		for "_i" from 1 to randInt(2,4) do {
			private _m = ["MagazineFinisherLoadedExtendedSaloon",_extMagsLoc vectorAdd [rand(-.2,.2),rand(-.2,.2),0],null,false] call createItemInWorld;
		};
		
		_otherItemsLoc = [3364.92,3705.61,21.8288];
		for "_i" from 2 to 2 + randInt(1,5) do {
			[pick["BalaclavaMask","BalaclavaMask2"],_otherItemsLoc vectorAdd [rand(-.2,.2),rand(-.2,.2),rand(-0.01,0.01)],null,false] call createItemInWorld;
		};
		
		["Crowbar",_otherItemsLoc vectorAdd [rand(-.1,.1),rand(-.1,.1),0],null,false] call createItemInWorld;
		for "_i" from 1 to randInt(3,5) do {
			["Lockpick",_otherItemsLoc vectorAdd [rand(-.1,.1),rand(-.1,.1),rand(-0.01,0.01)],null,false] call createItemInWorld;
		};

		["CombatKnife",_otherItemsLoc vectorAdd [rand(-.1,.1),rand(-.1,.1),0],null,false] call createItemInWorld;
		for "_i" from 1 to randInt(2,6) do {
			["RopeItem",_otherItemsLoc vectorAdd [rand(-.1,.1),rand(-.1,.1),rand(-0.01,0.01)],null,false] call createItemInWorld;
		};
		
		//reg cages
		//2 floor
		getSelf(cages) pushBackUnique (
			["SteelGridDoor",[3365.11,3621.77,23.8667],3,false,true] call getGameObjectOnPosition
			);
		//1 floor	
		getSelf(cages) pushBackUnique (
			["SteelGridDoor",[3365.11,3621.77,21.8667],3,false,true] call getGameObjectOnPosition
			);
		
		
		//merchant store data
		private _yashsVerh = ["SquareWoodenBox",[3423.15,3676.05,20.3429],1,false,true] call getGameObjectOnPosition;
			for "_i" from 1 to randInt(1,3) do {["ArmorLite",_yashsVerh] call createItemInContainer};
			for "_i" from 1 to randInt(0,5) do {["CombatHat",_yashsVerh] call createItemInContainer};
			for "_i" from 1 to randInt(0,2) do {["ArmorMedium",_yashsVerh] call createItemInContainer};
			for "_i" from 1 to randInt(1,4) do {["NomadCloth" + str randInt(1,15),_yashsVerh] call createItemInContainer};
			for "_i" from 1 to randInt(1,6) do {[pick["HatOldUshanka","HatUshanka","WorkerCap","WorkerCoolCap","HatGrayOldUshanka"],_yashsVerh] call createItemInContainer};
		
		private _yashNiz = ["SquareWoodenBox",[3423.1,3676.12,19.3898],1,false,true] call getGameObjectOnPosition;
			for "_i" from 1 to randInt(1,2) do {["PaperHolder",_yashNiz] call createItemInContainer};
			for "_i" from 1 to randInt(0,2) do {["PenRed",_yashNiz] call createItemInContainer};
			for "_i" from 1 to randInt(0,2) do {["PenBlack",_yashNiz] call createItemInContainer};
			for "_i" from 1 to randInt(1,3) do {["TorchDisabled",_yashNiz] call createItemInContainer};
			for "_i" from 1 to randInt(1,3) do {["CandleDisabled",_yashNiz] call createItemInContainer};
			for "_i" from 1 to randInt(0,2) do {["CampfireCreator",_yashNiz] call createItemInContainer};
			for "_i" from 1 to randInt(0,10) do {["SigaretteDisabled",_yashNiz] call createItemInContainer};
		
		{
			delete(_x);
		} foreach (["FabricBagBig2",[3422.91,3675.35,19.3512],2,!false,true] call getGameObjectOnPosition);
		
		private _meshokleft = ["FabricBagBig2",[3422.91,3675.35,19.3512],357.047,false] call createItemInWorld;
			for "_i" from 1 to randInt(3,6) do {["Egg",_meshokleft] call createItemInContainer};
			for "_i" from 1 to randInt(1,2) do {["Meat",_meshokleft] call createItemInContainer};
			for "_i" from 1 to randInt(1,5) do {["Bread",_meshokleft] call createItemInContainer};
			
		private _meshokleft2 = ["FabricBagBig2",[3422.92,3674.8,19.3608],357.047,false] call createItemInWorld;
			for "_i" from 1 to randInt(1,4) do {
				private _item = ["SpirtBottle",_meshokleft2] call createItemInContainer;
				setVar(_item,bottleName,"Стальное пойло");
			};
			for "_i" from 1 to randInt(0,4) do {
				private _item = ["SpirtBottle",_meshokleft2] call createItemInContainer;
				setVar(_item,bottleName,"Серое пиво");
			};
			for "_i" from 1 to randInt(0,2) do {
				private _item = ["SpirtBottle",_meshokleft2] call createItemInContainer;
				setVar(_item,bottleName,"Грустная вода");
			};
			for "_i" from 1 to randInt(1,2) do {
				private _item = ["MilkBottle",_meshokleft2] call createItemInContainer;
				setVar(_item,bottleName,"Калековское молоко");
			};
		
		private _meshokright = ["FabricBagBig2",[3423.52,3675.42,19.3565],47.3366,false] call createItemInWorld;
			for "_i" from 1 to randInt(1,3) do {["PainkillerBox",_meshokright] call createItemInContainer};
			for "_i" from 1 to randInt(1,10) do {["Bandage",_meshokright] call createItemInContainer};
			for "_i" from 1 to randInt(1,4) do {["NeedleWithThreads",_meshokright] call createItemInContainer};
			
		private _meshokright2 = ["FabricBagBig2",[3423.54,3674.85,19.3608],357.047,false] call createItemInWorld;
			for "_i" from 1 to randInt(1,4) do {["Syringe",_meshokright2] call createItemInContainer};
			for "_i" from 1 to randInt(0,3) do {["LiqPainkiller",_meshokright2] call createItemInContainer};
			for "_i" from 1 to randInt(0,2) do {["LiqDemitolin",_meshokright2] call createItemInContainer};
		
		private _polki = ["IStruct",[3421.82,3676.4,19.402],1,false,true] call getGameObjectOnPosition;
		
		private _polkiLevels = [
			0.55,
			0.1,
			-0.35,
			-0.8
		];
		private _polkiX = 0.5;//rand(left-right)
		private _polkiY = 0.1;//rand(front-back)
		private _items = [
			["ShortSword",randInt(-1,2)],
			["RifleAuto",randInt(-1,1)],
			["RifleSVT",randInt(0,1)],
			["RifleFinisherSmall",randInt(0,3)],
			["DBShotgun",randInt(0,2)],
			["PistolPBM",randInt(0,3)],
			["AmmoBoxRifle",randInt(1,5)],
			["AmmoBoxShotgun",randInt(1,5)],
			["AmmoBoxShotgunMini",randInt(0,1)],
			["AmmoBoxPBM",randInt(1,5)],
			["MagazineAuto",randInt(1,3)],
			["MagazineSVT",randInt(1,3)],
			["MagazineFinisher",randInt(1,3)],
			["MagazinePBM",randInt(1,2)]
		];
		
		private _toSpawn = [];
		
		{
			_x params ["_cls","_cnt"];
			for "_i" from 1 to _cnt do {_toSpawn pushBack _cls};
		} foreach _items;
		private _items = array_shuffle(_items);
		
		private _worldObj = getVar(_polki,loc);
		private _dirRand = [90,270];
		{
			_dirRand = [90,270];
			if ("AmmoBox" in _x) then {
				_dirRand = [90];
			};
			[_x,
			_worldObj modelToWorld [rand(-_polkiX,_polkiX),rand(-_polkiY,_polkiY),pick _polkiLevels]
			,(pick _dirRand)+rand(-2,2),false] call createItemInWorld;
		} foreach _toSpawn;
		
	};
	
	var(cages,[]);//2 floor,1 floor
	func(isBlockedInSBSCage)
	{
		objParams_1(_bandit);
		private _pos = callFunc(_bandit,getPos);
		private _isInCange = _pos inArea [[3363.39,3618.31,23.8667],3.9,5.2,269.546,true,5];
		if !_isInCange exitWith {false};
		//["2floor","1floor"] select ((getPosATL player) select 2 <= 23
		getVar(getSelf(cages) select (_pos select 2 <= 23),isLocked)
	};
	
	func(checkFinish)
	{
		objParams();
		#ifdef EDITOR
		_r = callFunc(getSelf(task),checkFinish);
		if (_r == -2) exitWith {0};
		_r
		#else
		callFunc(getSelf(task),checkFinish);
		#endif
	};
	
	func(handleRandomPos)
	{
		objParams_1(_def);
		if (gm_roundDuration <= 2) exitWith {_def};
		pick [
			[3373.75,3674.44,23.5393],
			[3390.23,3672.52,23.2097],
			[3400.7,3676.27,23.0975],
			[3391.32,3640.42,24.3761],
			[3413.28,3642.9,22.1226],
			[3419.38,3644.09,22.3054],
			[3419.96,3649.81,22.3102],
			[3453.82,3677.13,22.9341],
			[3399.36,3682.16,21.3214]
		];
	};
	func(handleRandomDir)
	{
		objParams_1(_def);
		if (gm_roundDuration <= 2) exitWith {_def};
		random 360
	};
	
	func(getResultTextOnFinish)
	{
		objParams();
		private _post = format["<t align='left' color='#FAB475' font='PuristaMedium' size='1.5'>Задача бандитов: %1</t>",
		callFunc(getSelf(task),getDesc)];
		private _ft = callFuncParams(getSelf(task),getFinishDesc,getSelf(finishResult));
		private _txt = _ft + sbr + sbr + _post;
		if getVar(getSelf(task),needFreeBratok) then {
			if (count getVar(getSelf(task),bratki) == {
				!getVar(_x,isDead) && !callSelfParams(isBlockedInSBSCage,_x)
			} count getVar(getSelf(task),bratki)) then {
				modvar(_txt) + sbr + sbr + "Руки вырвали из плена своих братков!";
			} else {
				modvar(_txt) + sbr + sbr + "Бандитам не удалось спасти братков из плена.";
			};
		};
		_txt
	};
	func(getLeadingRolesInfo)
	{
		objParams();
		private _t = "<t align='left' color='#AF2CF5' font='PuristaMedium'>В главных ролях:" + sbr;
		{
			_t = _t + callSelfParams(getCreditsInfo,_x) + sbr;
		} foreach getSelf(keyRolesList);
		_t + "</t>"
	};
	
	var(allAliveBandits,[]);
	var(keyRolesList,[]); //просто список ключевых ролей
	var(countAliveBandits,0);//сколько живых бандитов
	var(deadMobs,0); //убито
	var(isSBSCommandirSpawned,false); //заспавнился ли командир сбс
endclass

class(Saloon_Task_Base) extends(IGamemodeSpecificClass)
	func(onTaskInit) {}; //событие инициализации задачи
	func(getDesc) {""}; //описание что надо сделать бандитам
	func(getFinishDesc) {objParams_1(_result); ""}; //описание если задача выполнена
	func(checkFinish) {0}; //проверка на финиш
	
	var(needFreeBratok,false); //если true то нужно освободить братка
	var(bratki,[]); //какие объекты братков живые
	
	func(isAllBanditsInCages)
	{
		objParams();
		{callFuncParams(gm_currentMode,isBlockedInSBSCage,_x)} count getVar(gm_currentMode,allAliveBandits) == count getVar(gm_currentMode,allAliveBandits)
		#ifdef EDITOR
		&& count getVar(gm_currentMode,allAliveBandits) > 0
		#endif
	};
endclass



class(Saloon_Task_Portfel) extends(Saloon_Task_Base)
	var(portfel,nullPtr);
	var(portfelClass,"Suitcase_Saloon");
	func(onTaskInit)
	{
		objParams();
		_port = [getSelf(portfelClass),[3470.12,3605.8,23.5769],88,false] call createItemInWorld;
		setSelf(portfel,_port);
	};
	getter_func(getDesc,"Надо грабануть владельца Дыры. У него есть целый чемодан со звяками. Нужно найти бабки и притащить их в общак. Общак в нашей хате.");
	func(getFinishDesc)
	{
		objParams_1(_result);
		if (_result == -1) exitWith {"Бандиты слишком долго мешкали. Из восточного района прибыл большой отряд ополченцев для наведения порядка в Злачнике."};
		if (_result == 1) exitWith {format["Бандиты принесли %1 в свой общак",callFunc(getSelf(portfel),getName)]};
		if (_result == -2) exitWith {"Все бандиты погибли"};
		if (_result == -3) exitWith {"Все бандиты под стражей"};
		if (_result == -4) exitWith {format["Торгаш заполучил %1",callFunc(getSelf(portfel),getName)]};
		if (_result == -5) exitWith {format["%2 увёл %1 у всех. Теперь он самый богатый человек в Злачнике!",callFunc(getSelf(portfel),getName),callFunc(getSelf(portfel),getStealerName)]};
		"Сегодня не произошло ничего интересного...";
	};
	func(checkFinish)
	{
		objParams();
		if (gm_roundDuration >= getVar(gm_currentMode,duration)) exitWith {-1};
		#ifndef EDITOR
		if (getVar(gm_currentMode,countAliveBandits) <= 0 && gm_roundDuration > 10) exitWith {-2};
		#endif
		_portf = getSelf(portfel);
		if isNullReference(_portf) exitWith {0};
		if (callFunc(_portf,isInWorld) && {(callFunc(_portf,getModelPosition) distance [3365.13,3705.47,21.9511]) <= 1}) exitWith {1};
		if callSelf(isAllBanditsInCages) exitWith {-3};
		if !getVar(_portf,isLockedSaloon) exitWith {-4};
		if callFunc(_portf,isStolenSaloon) exitWith {-5};
		#ifdef EDITOR
		if (getVar(gm_currentMode,countAliveBandits) <= 0 && gm_roundDuration > 10) exitWith {-2};
		#endif
		0
	};
endclass
	
	class(Suitcase_Saloon) extends(Suitcase)
		var(canUseContainer,false); //нельзя открыть
		var(name,pick["Бабосы" arg "Лавэ" arg "Лавандос" arg "Бабло"]);
		var(desc,"Тяжеленный чемодан закрыт на маленький замочек. Внутри что-то звенит.");
		var(weight,6.3);
		var(isLockedSaloon,true);
		/*func(canPickup)
		{
			objParams();
			super() && _isCanRole
		};
		func(onCantPickup)
		{
			objParams_1(_usr);
		};*/
		getter_func(canUseMainAction,isTypeOf(getVar(_usr,basicRole),RTorgSaloon) && super());
		getter_func(getMainActionName,"Вскрыть");
		func(onMainAction)
		{
			objParams_1(_usr);
			if (callSelf(getModelPosition) distance2d [3418.95,3672.32,19.4215] >= 5) then {
				callFuncParams(_usr,mindSay,"Чтобы вскрыть этот замок надо тащить чемодан ко мне в магазин. Все необходимые инструменты для вскрытия там есть!");
			} else {
				callFuncParams(_usr,mindSay,"Я с лёгкостью вскрываю замок!");
				setSelf(isLockedSaloon,false);
			};
			
		};
		var(timerCount,0); //timer incremented
		var(timerCountMax,15);//maxtime
		func(isStolenSaloon)
		{
			objParams();
			
			private _usr = callSelf(getSourceLoc);
			if !callFunc(_usr,isMob) exitWith {false};
			if (callFunc(_usr,getPos) select 2 >= 3) exitWith {setSelf(timerCount,0);false};
			if getVar(getVar(_usr,basicRole),canStealMoneyBank) then {
				private _name = callFuncParams(_usr,getNameEx,"кто");
				if (getSelf(__bufferedStealerName)!=_name) then {
					//reset values if owner changed
					setSelf(__bufferedStealerName,_name);
					setSelf(timerCount,0);
				};
				modSelf(timerCount, + 1);
				(getSelf(timerCount) >= getSelf(timerCountMax))
			} else {
				false
			};
		};
		var(__bufferedStealerName,"Воришка");
		func(getStealerName)
		{
			objParams();
			getSelf(__bufferedStealerName);
		};
		
	endclass

class(Saloon_Task_Docs) extends(Saloon_Task_Base)
	var(docs,nullPtr);
	var(destroyedPapers,false);
	func(onTaskInit)
	{
		objParams();
		private _list = [];
		{
			_list pushBack (["OfficeCabinet_Saloon",_x select 0,_x select 1,false] call createStructure);
		} foreach [
			[[3476.7,3610.44,22.7394],0],
			[[3476.0,3610.44,22.7394],0],
			[[3475.0,3610.44,22.7394],0],
			[[3474.6,3609.74,22.7394],270],
			[[3474.6,3609.04,22.7394],270],
			[[3474.6,3608.24,22.7394],270]
		];
		setVar(pick _list,isContainsBlank,true);
	};
	getter_func(getDesc,"Надо подмять под себя бар Дыра и заполучить бумаги на владение данным заведением любой ценой.");
	func(getFinishDesc)
	{
		objParams_1(_result);
		if (_result == -1) exitWith {"Бандиты слишком долго мешкали. Из восточного района прибыл большой отряд ополченцев для наведения порядка в Злачнике."};
		if (_result == 1) exitWith {format["Бандиты принесли %1 в свой общак",callFunc(getSelf(docs),getName)]};
		if (_result == -2) exitWith {"Все бандиты погибли"};
		if (_result == -3) exitWith {"Бумаги владения баром были уничтожены..."};
		if (_result == -4) exitWith {"Все бандиты под стражей"};
		"Сегодня не произошло ничего интересного...";
	};
	func(checkFinish)
	{
		objParams();
		if (gm_roundDuration >= getVar(gm_currentMode,duration)) exitWith {-1};
		if (getVar(gm_currentMode,countAliveBandits) <= 0 && gm_roundDuration > 10) exitWith {-2};
		if (getSelf(destroyedPapers)) exitWith {-3};
		_portf = getSelf(docs);
		if isNullReference(_portf) exitWith {0};
		if (callFunc(_portf,isInWorld) && {(callFunc(_portf,getModelPosition) distance [3365.13,3705.47,21.9511]) <= 1}) exitWith {1};
		if callSelf(isAllBanditsInCages) exitWith {-4};
		0
	};
endclass

	class(OfficeCabinet_Saloon) extends(OfficeCabinet)
		var(canUseContainer,false);
		var(isContainsBlank,false);
		var(name,"Шкаф с бумагами");
		var(desc,"И чего же тут только нет...");
		func(onMainAction)
		{
			objParams_1(_usr);
			callFuncParams(_usr,startProgress,this arg "target.onSearchingBlank" arg rand(3,5) arg INTERACT_PROGRESS_TYPE_FULL);
		};
		
		func(onSearchingBlank)
		{
			objParams_1(_usr);
			if getSelf(isContainsBlank) then {
				setSelf(isContainsBlank,false);
				private _docs = ["PaperSaloonOwnerBar",_usr] call createItemInInventory;
				callFuncParams(_usr,localSay,setstyle("ЭТО БУМАГИ НА ВЛАДЕНИЕ БАРОМ!",style_redbig));
				setVar(getVar(gm_currentMode,task),docs,_docs);
			} else {
				callFuncParams(_usr,mindSay,"Нет ничего интересного...");
			};
		};
	endclass

	class(PaperSaloonOwnerBar) extends(Paper)
		var(name,"Бумаги владения баром Дыра");
		var(desc,"Держатель этих документов является законным владельцем бара Дыра в северном районе Канавы.");
		getter_func(canWrite,false);
		getter_func(canRead,false);
		func(doBurn)
		{
			objParams_2(_srcFire,_usr);
			setVar(getVar(gm_currentMode,task),destroyedPapers,true);
			super();
		};
	endclass

class(Saloon_Task_Kill) extends(Saloon_Task_Base)
	var(target,nullPtr);
	
	func(onTaskInit)
	{
		objParams();
		private _listMobs = getVar("RBarmenSaloon" call gm_getRoleObject,basicMobs);
		// #ifdef EDITOR
		// _role = 'EDITOR_STARTUP_ROLE';
		// _listMobs = getVar(_role call gm_getRoleObject,basicMobs);
		// #endif
		setSelf(target,pick _listMobs);
	};
	
	getter_func(getDesc,"Надо вальнуть владельца бара Дыра и вернуться в схрон всей братве.");
	func(getFinishDesc)
	{
		objParams_1(_result);
		if (_result == 1) exitWith {"Бандиты разобрались с владельцем и скрылись. Теперь вся округа будет знать, что они настроены серьёзно."};
		if (_result == -1) exitWith {"Бандиты слишком долго мешкали. Из восточного района прибыл большой отряд ополченцев для наведения порядка в Злачнике."};
		if (_result == -2) exitWith {"Все бандиты погибли."};
		if (_result == -3) exitWith {"Все бандиты под стражей"};
		"Сегодня не произошло ничего интересного...";
	};
	func(checkFinish)
	{
		objParams();
		if (gm_roundDuration >= getVar(gm_currentMode,duration)) exitWith {-1};
		if (getVar(gm_currentMode,countAliveBandits) <= 0 && gm_roundDuration > 10) exitWith {-2};
		_targ = getSelf(target);
		if isNullReference(_targ) exitWith {0};
		_isDead = getVar(getSelf(target),isDead);
		if (!_isDead) exitWith {0};
		_allbandits = getVar(gm_currentMode,allAliveBandits);
		if (
			{array_exists(_allbandits,_x)} count (["Mob",getVar(gm_currentMode,banditBasePos),5,true,true] call getMobsOnPosition) >= (count _allbandits)
		) exitWith {1};
		if callSelf(isAllBanditsInCages) exitWith {-3};
		0
	};
endclass



//---------- Злачник 2 ----------//

#include <..\GameMode.h>

editor_attribute("CodeOnyGamemode")
class(GMSaloonV2) extends(GMBase)
	
	var(name,"Переполох"); //Название истории
	var(desc,"Потасовка в небольшом районе большого города."); //Описание краткое для голосований например
	var(descExtended,"Криминальный мир Злачника - неблагоприятного района Канавы"+comma+" пытается установить свои порядки.");
	
	func(getUnsleepGameInfo)
	{
		objParams();
		super() + [
			"Пустые глазницы заброшенных, опустевших зданий, снующие в тусклом свете факелов тени, завалы битого кирпича, кисловатая вонь по углам и хриплые вопли вдалеке. То ли смех, то ли брань — как обычно, не разобрать. Вот что такое Злачник — изолированный район столицы Свободных Поселений. Когда-то давно тут вспыхнула эпидемия, район изолировали и его жители оказались в ловушке. Когда с эпидемией было покончено, власти Канавы пожелали восстановить контроль, но им дали отпор Руки — криминальная группировка, захватившая контроль над Злачником. Говорят, тут есть бар ""Дыра"", где очень хорошая и недорогая выпивка и кухня..."+sbr+sbr+"...Ваш живот заурчал, и вы просыпаетесь."
		]
	};

	
	func(getStartSong)
	{
		objParams_1(_usr);
		private _mob = callFunc(_usr,getActorMob);
		private _banditTheme = false;
		if !isNullReference(_mob) then {
			_banditTheme = isTypeOf(getVar(_mob,basicRole),RBanditMainSaloon) || 
			isTypeOf(getVar(_mob,basicRole),RBanditMiniSaloon)
		};
		if (_banditTheme) exitwith {
			"round\start_zlachnik_bandit"
		};
		"round\start_zlachnik"
	};
	func(getEndSong)
	{
		objParams_1(_usr);
		//if (getSelf(finishResult) > 0) exitwith {"round\kingpin"};
		"events\Floating"
	};

	getterconst_func(getLobbySoundName,"lobby\Dark_Water.ogg");
	getterconst_func(getLobbyBackground,PATH_PICTURE("lobby\zlachnik.paa"));
	getterconst_func(getReqPlayersMin,4);
	getterconst_func(getReqPlayersMax,15);
	func(getLobbyRoles)
	{
		[
		"RBarmenSaloon",
		"RGromilaSaloon",
		"RCookSaloon",
		"RCitizenSaloon",
		"RAssasinSaloon",
		"RTrampSaloon",
		"RBanditMainSaloon",
		"RBanditMiniSaloon",
		"RTorgSaloon",
		"RDoctorSaloon"
		]
	};
	func(getLateRoles)
	{
		[
			"RSBSComannderSaloon",
			"RSBSRookieSaloon"
		]
	};
	
	getter_func(conditionToStart,count getVar(("RBarmenSaloon") call gm_getRoleObject,contenders_1) >= 1 && count getVar(("RBanditMainSaloon") call gm_getRoleObject,contenders_1) >= 1);
	getter_func(onFailReasonToStart,"Нужен владелец бара ""Дыра"" и пахан.");
	
	var(duration,t_asMin(90)); //1.5 часа
	getterconst_func(getMapName,"SaloonV2");
	
	var(task,nullPtr);
	//var(taskList,["Saloon_Task_PortfelV2"]);
	var(taskList,["Saloon_Task_PortfelV2" arg "Saloon_Task_DocsV2" arg "Saloon_Task_KillV2"]);

	var(protectedWalls,[]);//защитные стены убираются когда спавнится командир охров
	var(countDoors,0);
	func(preSetup)
	{
		objParams();
		
		#ifdef EDITOR
		getSelf(taskList) deleteAt (getSelf(taskList) find "Saloon_Task_KillV2");
		#endif
		
		private _task = pick getSelf(taskList);
		_task = instantiate(_task);
		setSelf(task,_task);
		
		{
			if (getVar(_x,name) == "Защитная стена") then {
				getSelf(protectedWalls) pushBack _x;
			};
		} foreach (["BrickThinWallSmall",[3366.75,3659.66,28.4624],20,true,true] call getGameObjectOnPosition);
	};
	
	var(banditBasePos,vec3(0,0,0));
	func(postSetup)
	{
		objParams();
		
		//start generator
		private _gen = ["PowerGenerator",[3411.22,3514.37,0],4,false] call getGameObjectOnPosition;
		if !isNullReference(_gen) then {
			callFunc(_gen,beginUpdateGenerator);
		};
		setVar(_gen,energyleft,100000000);
		

		if (count cm_allClients >= 20) then {	
			setSelf(duration,60* (60*2));
		};

		callFunc(getSelf(task),onTaskInit);
		{
			if (getVar(_x,model) == "a3\structures_f_epa\civ\camping\woodentable_small_f.p3d") exitWith {
				setVar(_x,name,"Общак");
				setVar(_x,desc,"Бандитский общак группировки ""Руки"".");
				setSelf(banditBasePos,callFunc(_x,getModelPosition));
			};
		} foreach (["GameObject",[3366.69,3743.81,27.6037],2,!false,true] call getGameObjectOnPosition);
		
		private _extMagsLoc = [3366.96,3744.33,28.4683];
		for "_i" from 1 to randInt(2,4) do {
			private _m = ["MagazineFinisherLoadedExtendedSaloon",_extMagsLoc vectorAdd [rand(-.2,.2),rand(-.2,.2),0],null,false] call createItemInWorld;
		};
		
		_otherItemsLoc = [3366.6,3743.93,28.4683];
		for "_i" from 2 to 2 + randInt(1,5) do {
			[pick["BalaclavaMask","BalaclavaMask2"],_otherItemsLoc vectorAdd [rand(-.2,.2),rand(-.2,.2),rand(-0.01,0.01)],null,false] call createItemInWorld;
		};
		
		["Crowbar",_otherItemsLoc vectorAdd [rand(-.1,.1),rand(-.1,.1),0],null,false] call createItemInWorld;
		for "_i" from 1 to randInt(3,5) do {
			["Lockpick",_otherItemsLoc vectorAdd [rand(-.1,.1),rand(-.1,.1),rand(-0.01,0.01)],null,false] call createItemInWorld;
		};

		["CombatKnife",_otherItemsLoc vectorAdd [rand(-.1,.1),rand(-.1,.1),0],null,false] call createItemInWorld;
		for "_i" from 1 to randInt(2,6) do {
			["RopeItem",_otherItemsLoc vectorAdd [rand(-.1,.1),rand(-.1,.1),rand(-0.01,0.01)],null,false] call createItemInWorld;
		};	


		//reg cages
		//2 floor
		getSelf(cages) pushBackUnique (
			["SteelGridDoor",[3362.69,3657.16,34],3,false,true] call getGameObjectOnPosition
			);
		//1 floor	
		getSelf(cages) pushBackUnique (
			["SteelGridDoor",[3363.45,3657.02,28.6],3,false,true] call getGameObjectOnPosition
			);

		//merchant store data
		private _yashsVerh = ["SquareWoodenBox",[3429.86,3718.16,27.6708],1,false,true] call getGameObjectOnPosition;
		assert_str(!isNullReference(_yashsVerh),"_yashsVerh is null reference");

			for "_i" from 1 to randInt(1,3) do {["ArmorLite",_yashsVerh] call createItemInContainer};
			for "_i" from 1 to randInt(0,5) do {["CombatHat",_yashsVerh] call createItemInContainer};
			for "_i" from 1 to randInt(0,2) do {["ArmorMedium",_yashsVerh] call createItemInContainer};
			for "_i" from 1 to randInt(1,4) do {["NomadCloth" + str randInt(1,15),_yashsVerh] call createItemInContainer};
			for "_i" from 1 to randInt(1,6) do {[pick["HatOldUshanka","HatUshanka","WorkerCap","WorkerCoolCap","HatGrayOldUshanka"],_yashsVerh] call createItemInContainer};
		
		private _yashNiz = ["SquareWoodenBox",[3426.2,3716.2,27.6826],1,false,true] call getGameObjectOnPosition;
		assert_str(!isNullReference(_yashNiz),"_yashNiz is null reference");

			for "_i" from 1 to randInt(1,2) do {["PaperHolder",_yashNiz] call createItemInContainer};
			for "_i" from 1 to randInt(0,2) do {["PenRed",_yashNiz] call createItemInContainer};
			for "_i" from 1 to randInt(0,2) do {["PenBlack",_yashNiz] call createItemInContainer};
			for "_i" from 1 to randInt(1,3) do {["TorchDisabled",_yashNiz] call createItemInContainer};
			for "_i" from 1 to randInt(1,3) do {["CandleDisabled",_yashNiz] call createItemInContainer};
			for "_i" from 1 to randInt(0,2) do {["CampfireCreator",_yashNiz] call createItemInContainer};
			for "_i" from 1 to randInt(0,10) do {["SigaretteDisabled",_yashNiz] call createItemInContainer};
		
		private _meshokleft = ["FabricBagBig2",[3428.48,3709.7,31.0566],1,false] call getGameObjectOnPosition;
		assert_str(!isNullReference(_meshokleft),"_meshokleft is null reference");

			for "_i" from 1 to randInt(3,6) do {["Egg",_meshokleft] call createItemInContainer};
			for "_i" from 1 to randInt(1,2) do {["Meat",_meshokleft] call createItemInContainer};
			for "_i" from 1 to randInt(1,5) do {["Bread",_meshokleft] call createItemInContainer};
			
		private _meshokleft2 = ["FabricBagBig2",[3425.11,3713.55,31.0538],1,false] call getGameObjectOnPosition;
		assert_str(!isNullReference(_meshokleft2),"_meshokleft2 is null reference");

			for "_i" from 1 to randInt(1,4) do {
				private _item = ["SpirtBottle",_meshokleft2] call createItemInContainer;
				setVar(_item,bottleName,"Стальное пойло");
			};
			for "_i" from 1 to randInt(0,4) do {
				private _item = ["SpirtBottle",_meshokleft2] call createItemInContainer;
				setVar(_item,bottleName,"Серое пиво");
			};
			for "_i" from 1 to randInt(0,2) do {
				private _item = ["SpirtBottle",_meshokleft2] call createItemInContainer;
				setVar(_item,bottleName,"Грустная вода");
			};
			for "_i" from 1 to randInt(1,2) do {
				private _item = ["MilkBottle",_meshokleft2] call createItemInContainer;
				setVar(_item,bottleName,"Калековское молоко");
			};
		
		private _meshokright = ["FabricBagBig2",[3425.88,3716.19,28.6364],1,false] call getGameObjectOnPosition;
		assert_str(!isNullReference(_meshokright),"_meshokright is null reference");

			for "_i" from 1 to randInt(1,3) do {["PainkillerBox",_meshokright] call createItemInContainer};
			for "_i" from 1 to randInt(1,10) do {["Bandage",_meshokright] call createItemInContainer};
			for "_i" from 1 to randInt(1,4) do {["NeedleWithThreads",_meshokright] call createItemInContainer};
			
		private _meshokright2 = ["FabricBagBig2",[3430.05,3716.14,31.0536],1,false] call getGameObjectOnPosition;
		assert_str(!isNullReference(_meshokright2),"_meshokright2 is null reference");

			for "_i" from 1 to randInt(1,4) do {["Syringe",_meshokright2] call createItemInContainer};
			for "_i" from 1 to randInt(0,3) do {["LiqPainkiller",_meshokright2] call createItemInContainer};
			for "_i" from 1 to randInt(0,2) do {["LiqDemitolin",_meshokright2] call createItemInContainer};
		
		private _polki = ["Shelves",[3428.01,3718.45,27.683],1,false,true] call getGameObjectOnPosition;
		assert_str(!isNullReference(_polki),"_polki is null reference");
		
		private _polkiLevels = [
			0.55,
			0.1,
			-0.35,
			-0.8
		];
		private _polkiX = 0.5;//rand(left-right)
		private _polkiY = 0.1;//rand(front-back)
		private _items = [
			["ShortSword",randInt(-1,2)],
			["RifleAuto",randInt(-1,1)],
			["RifleSVT",randInt(0,1)],
			["RifleFinisherSmall",randInt(0,3)],
			["DBShotgun",randInt(0,2)],
			["PistolPBM",randInt(0,3)],
			["AmmoBoxRifle",randInt(1,5)],
			["AmmoBoxShotgun",randInt(1,5)],
			["AmmoBoxShotgunMini",randInt(0,1)],
			["AmmoBoxPBM",randInt(1,5)],
			["MagazineAuto",randInt(1,3)],
			["MagazineSVT",randInt(1,3)],
			["MagazineFinisher",randInt(1,3)],
			["MagazinePBM",randInt(1,2)]
		];
		
		private _toSpawn = [];
		
		{
			_x params ["_cls","_cnt"];
			for "_i" from 1 to _cnt do {_toSpawn pushBack _cls};
		} foreach _items;
		private _items = array_shuffle(_items);
		
		private _worldObj = getVar(_polki,loc);
		private _dirRand = [90,270];
		{
			_dirRand = [90,270];
			if ("AmmoBox" in _x) then {
				_dirRand = [90];
			};
			[_x,
			_worldObj modelToWorld [rand(-_polkiX,_polkiX),rand(-_polkiY,_polkiY),pick _polkiLevels]
			,(pick _dirRand)+rand(-2,2),false] call createItemInWorld;
		} foreach _toSpawn;
		
	};
	
	var(cages,[]);//2 floor,1 floor
	func(isBlockedInSBSCage)
	{
		objParams_1(_bandit);
		private _pos = callFunc(_bandit,getPos);
		private _isInCange = _pos inArea [[3362.780,3654.742,33.725],4.6,2.2,0,true,5];
		if !_isInCange exitWith {false};
		//["2floor","1floor"] select ((getPosATL player) select 2 <= 23
		getVar(getSelf(cages) select (_pos select 2 <= 31.9),isLocked)
	};
	
	func(checkFinish)
	{
		objParams();
		#ifdef EDITOR
		_r = callFunc(getSelf(task),checkFinish);
		if (_r == -2) exitWith {0};
		_r
		#else
		callFunc(getSelf(task),checkFinish);
		#endif
	};
	
	
	func(getResultTextOnFinish)
	{
		objParams();
		private _post = format["<t align='left' color='#FAB475' font='PuristaMedium' size='1.5'>Задача бандитов: %1</t>",
		callFunc(getSelf(task),getDesc)];
		private _ft = callFuncParams(getSelf(task),getFinishDesc,getSelf(finishResult));
		private _txt = _ft + sbr + sbr + _post;
		if getVar(getSelf(task),needFreeBratok) then {
			if (count getVar(getSelf(task),bratki) == {
				!getVar(_x,isDead) && !callSelfParams(isBlockedInSBSCage,_x)
			} count getVar(getSelf(task),bratki)) then {
				modvar(_txt) + sbr + sbr + "Руки вырвали из плена своих братков!";
			} else {
				modvar(_txt) + sbr + sbr + "Бандитам не удалось спасти братков из плена.";
			};
		};
		_txt
	};
	func(getLeadingRolesInfo)
	{
		objParams();
		private _t = "<t align='left' color='#AF2CF5' font='PuristaMedium'>В главных ролях:" + sbr;
		{
			_t = _t + callSelfParams(getCreditsInfo,_x) + sbr;
		} foreach getSelf(keyRolesList);
		_t + "</t>"
	};
	
	var(allAliveBandits,[]);
	var(keyRolesList,[]); //просто список ключевых ролей
	var(countAliveBandits,0);//сколько живых бандитов
	var(deadMobs,0); //убито
	var(isSBSCommandirSpawned,false); //заспавнился ли командир сбс
endclass

class(Saloon_Task_BaseV2) extends(IGamemodeSpecificClass)
	func(onTaskInit) {}; //событие инициализации задачи
	func(getDesc) {""}; //описание что надо сделать бандитам
	func(getFinishDesc) {objParams_1(_result); ""}; //описание если задача выполнена
	func(checkFinish) {0}; //проверка на финиш
	
	var(needFreeBratok,false); //если true то нужно освободить братка
	var(bratki,[]); //какие объекты братков живые
	
	func(isAllBanditsInCages)
	{
		objParams();
		{callFuncParams(gm_currentMode,isBlockedInSBSCage,_x)} count getVar(gm_currentMode,allAliveBandits) == count getVar(gm_currentMode,allAliveBandits)
		#ifdef EDITOR
		&& count getVar(gm_currentMode,allAliveBandits) > 0
		#endif
	};
endclass



class(Saloon_Task_PortfelV2) extends(Saloon_Task_BaseV2)
	var(portfel,nullPtr);
	var(portfelClass,"Suitcase_SaloonV2");
	func(onTaskInit)
	{
		objParams();
		_port = [getSelf(portfelClass),[3484.31,3648.24,30.0941],0,false] call createItemInWorld;
		setSelf(portfel,_port);
	};
	getter_func(getDesc,"Надо грабануть владельца Дыры. У него есть целый чемодан со звяками. Нужно найти бабки и притащить их в общак. Общак в нашей хате.");
	func(getFinishDesc)
	{
		objParams_1(_result);
		if (_result == -1) exitWith {"Бандиты слишком долго мешкали. Из восточного района прибыл большой отряд ополченцев для наведения порядка в Злачнике."};
		if (_result == 1) exitWith {format["Бандиты принесли %1 в свой общак",callFunc(getSelf(portfel),getName)]};
		if (_result == -2) exitWith {"Все бандиты погибли"};
		if (_result == -3) exitWith {"Все бандиты под стражей"};
		if (_result == -4) exitWith {format["Торгаш заполучил %1",callFunc(getSelf(portfel),getName)]};
		if (_result == -5) exitWith {format["%2 увёл %1 у всех. Теперь он самый богатый человек в Злачнике!",callFunc(getSelf(portfel),getName),callFunc(getSelf(portfel),getStealerName)]};
		"Сегодня не произошло ничего интересного...";
	};
	func(checkFinish)
	{
		objParams();
		if (gm_roundDuration >= getVar(gm_currentMode,duration)) exitWith {-1};
		#ifndef EDITOR
		if (getVar(gm_currentMode,countAliveBandits) <= 0 && gm_roundDuration > 10) exitWith {-2};
		#endif
		_portf = getSelf(portfel);
		if isNullReference(_portf) exitWith {0};
		if (callFunc(_portf,isInWorld) && {(callFunc(_portf,getModelPosition) distance [3366.69,3743.81,27.6037]) <= 2}) exitWith {1};
		if callSelf(isAllBanditsInCages) exitWith {-3};
		if !getVar(_portf,isLockedSaloon) exitWith {-4};
		if callFunc(_portf,isStolenSaloon) exitWith {-5};
		#ifdef EDITOR
		if (getVar(gm_currentMode,countAliveBandits) <= 0 && gm_roundDuration > 10) exitWith {-2};
		#endif
		0
	};
endclass
	
	class(Suitcase_SaloonV2) extends(Suitcase)
		var(canUseContainer,false); //нельзя открыть
		var(name,pick["Бабосы" arg "Лавэ" arg "Лавандос" arg "Бабло"]);
		var(desc,"Тяжеленный чемодан закрыт на маленький замочек. Внутри что-то звенит.");
		var(weight,6.3);
		var(isLockedSaloon,true);
		/*func(canPickup)
		{
			objParams();
			super() && _isCanRole
		};
		func(onCantPickup)
		{
			objParams_1(_usr);
		};*/
		getter_func(canUseMainAction,isTypeOf(getVar(_usr,basicRole),RTorgSaloon) && super());
		getter_func(getMainActionName,"Вскрыть");
		func(onMainAction)
		{
			objParams_1(_usr);
			if (callSelf(getModelPosition) distance2d [3426.21,3714.96,27.6805] >= 5) then {
				callFuncParams(_usr,mindSay,"Чтобы вскрыть этот замок надо тащить чемодан ко мне в магазин. Все необходимые инструменты для вскрытия там есть!");
			} else {
				callFuncParams(_usr,mindSay,"Я с лёгкостью вскрываю замок!");
				setSelf(isLockedSaloon,false);
			};
			
		};
		var(timerCount,0); //timer incremented
		var(timerCountMax,15);//maxtime
		func(isStolenSaloon)
		{
			objParams();
			
			private _usr = callSelf(getSourceLoc);
			if !callFunc(_usr,isMob) exitWith {false};
			if (callFunc(_usr,getPos) select 2 >= 10) exitWith {setSelf(timerCount,0);false};
			if getVar(getVar(_usr,basicRole),canStealMoneyBank) then {
				private _name = callFuncParams(_usr,getNameEx,"кто");
				if (getSelf(__bufferedStealerName)!=_name) then {
					//reset values if owner changed
					setSelf(__bufferedStealerName,_name);
					setSelf(timerCount,0);
				};
				modSelf(timerCount, + 1);
				(getSelf(timerCount) >= getSelf(timerCountMax))
			} else {
				false
			};
		};
		var(__bufferedStealerName,"Воришка");
		func(getStealerName)
		{
			objParams();
			getSelf(__bufferedStealerName);
		};
		
	endclass

class(Saloon_Task_DocsV2) extends(Saloon_Task_BaseV2)
	var(docs,nullPtr);
	var(destroyedPapers,false);
	func(onTaskInit)
	{
		objParams();
		private _list = [];
		{
			_list pushBack (["OfficeCabinet_SaloonV2",_x select 0,_x select 1,false] call createStructure);
		} foreach [
			[[3479.79,3651.01,30.08],0],
			[[3480.59,3651.01,30.08],0],
			[[3482.08,3651,30.08],0],
			[[3482.88,3651,30.08],0],
			[[3486.59,3650.49,30.08],90],
			[[3486.59,3649.69,30.08],90],
			[[3486.59,3645.88,30.08],90]
		];
		setVar(pick _list,isContainsBlank,true);
	};
	getter_func(getDesc,"Надо подмять под себя бар Дыра и заполучить бумаги на владение данным заведением любой ценой.");
	func(getFinishDesc)
	{
		objParams_1(_result);
		if (_result == -1) exitWith {"Бандиты слишком долго мешкали. Из восточного района прибыл большой отряд ополченцев для наведения порядка в Злачнике."};
		if (_result == 1) exitWith {format["Бандиты принесли %1 в свой общак",callFunc(getSelf(docs),getName)]};
		if (_result == -2) exitWith {"Все бандиты погибли"};
		if (_result == -3) exitWith {"Бумаги владения баром были уничтожены..."};
		if (_result == -4) exitWith {"Все бандиты под стражей"};
		"Сегодня не произошло ничего интересного...";
	};
	func(checkFinish)
	{
		objParams();
		if (gm_roundDuration >= getVar(gm_currentMode,duration)) exitWith {-1};
		if (getVar(gm_currentMode,countAliveBandits) <= 0 && gm_roundDuration > 10) exitWith {-2};
		if callSelf(isAllBanditsInCages) exitWith {-4};
		if (getSelf(destroyedPapers)) exitWith {-3};
		_portf = getSelf(docs);
		if isNullReference(_portf) exitWith {0};
		if (callFunc(_portf,isInWorld) && {(callFunc(_portf,getModelPosition) distance [3366.69,3743.81,27.6037]) <= 2}) exitWith {1};
		0
	};
endclass

	class(OfficeCabinet_SaloonV2) extends(OfficeCabinet)
		var(canUseContainer,false);
		var(isContainsBlank,false);
		var(name,"Шкаф с бумагами");
		var(desc,"И чего же тут только нет...");
		func(onMainAction)
		{
			objParams_1(_usr);
			callFuncParams(_usr,startProgress,this arg "target.onSearchingBlank" arg rand(3,5) arg INTERACT_PROGRESS_TYPE_FULL);
		};
		
		func(onSearchingBlank)
		{
			objParams_1(_usr);
			if getSelf(isContainsBlank) then {
				setSelf(isContainsBlank,false);
				private _docs = ["PaperSaloonOwnerBarV2",_usr] call createItemInInventory;
				callFuncParams(_usr,localSay,setstyle("ЭТО БУМАГИ НА ВЛАДЕНИЕ БАРОМ!",style_redbig));
				setVar(getVar(gm_currentMode,task),docs,_docs);
			} else {
				callFuncParams(_usr,mindSay,"Нет ничего интересного...");
			};
		};
	endclass

	class(PaperSaloonOwnerBarV2) extends(Paper)
		var(name,"Бумаги владения баром Дыра");
		var(desc,"Держатель этих документов является законным владельцем бара Дыра в северном районе Канавы.");
		getter_func(canWrite,false);
		getter_func(canRead,false);
		func(doBurn)
		{
			objParams_2(_srcFire,_usr);
			setVar(getVar(gm_currentMode,task),destroyedPapers,true);
			super();
		};
	endclass

class(Saloon_Task_KillV2) extends(Saloon_Task_BaseV2)
	var(target,nullPtr);
	
	func(onTaskInit)
	{
		objParams();
		private _listMobs = getVar("RBarmenSaloon" call gm_getRoleObject,basicMobs);
		// #ifdef EDITOR
		// _role = 'EDITOR_STARTUP_ROLE';
		// _listMobs = getVar(_role call gm_getRoleObject,basicMobs);
		// #endif
		setSelf(target,pick _listMobs);
	};
	
	getter_func(getDesc,"Надо вальнуть владельца бара Дыра и вернуться в схрон всей братве.");
	func(getFinishDesc)
	{
		objParams_1(_result);
		if (_result == 1) exitWith {"Бандиты разобрались с владельцем и скрылись. Теперь вся округа будет знать, что они настроены серьёзно."};
		if (_result == -1) exitWith {"Бандиты слишком долго мешкали. Из восточного района прибыл большой отряд ополченцев для наведения порядка в Злачнике."};
		if (_result == -2) exitWith {"Все бандиты погибли."};
		if (_result == -3) exitWith {"Все бандиты под стражей"};
		"Сегодня не произошло ничего интересного...";
	};
	func(checkFinish)
	{
		objParams();
		if (gm_roundDuration >= getVar(gm_currentMode,duration)) exitWith {-1};
		if (getVar(gm_currentMode,countAliveBandits) <= 0 && gm_roundDuration > 10) exitWith {-2};
		_targ = getSelf(target);
		if isNullReference(_targ) exitWith {0};
		_isDead = getVar(getSelf(target),isDead);
		if (!_isDead) exitWith {0};
		_allbandits = getVar(gm_currentMode,allAliveBandits);
		if (
			{array_exists(_allbandits,_x)} count (["Mob",getVar(gm_currentMode,banditBasePos),5,true,true] call getMobsOnPosition) >= (count _allbandits)
		) exitWith {1};
		if callSelf(isAllBanditsInCages) exitWith {-3};
		0
	};
endclass
