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
	getterconst_func(getLocationDisplayName,"Злачник");
	
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
			for "_i" from 1 to randInt(1,6) do {[pick["HatUshankaUp2","HatUshanka","WorkerCap","WorkerCap2","HatUshankaUp"],_yashsVerh] call createItemInContainer};
		
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
		"RBrigadirSaloon",
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
	getterconst_func(getLocationDisplayName,"Злачник");
	
	var(task,nullPtr);
	//var(taskList,["Saloon_Task_PortfelV2"]);
	var(taskList,["Saloon_Task_PortfelV2" arg "Saloon_Task_DocsV2" arg "Saloon_Task_KillV2" arg "Saloon_Task_RoofV2"]);
	var(isEscapeSequenceStarted,false);
	var(isEscapeSequenceFinished,false);
	var_array(escapedPeopleNames);
	getterconst_func(getEscapeFinishCode,9001);

	var(protectedWalls,[]);//защитные стены убираются когда спавнится командир охров
	var(countDoors,0);
	func(preSetup)
	{
		objParams();
		
		#ifdef EDITOR
		getSelf(taskList) deleteAt (getSelf(taskList) find "Saloon_Task_KillV2");
		#endif

		private _taskClass = ifcheck(!isNull(gm_saloon_forcedTask) && {gm_saloon_forcedTask != ""},gm_saloon_forcedTask,pick getSelf(taskList));
		setSelf(task,instantiate(_taskClass));
		
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

		// Свет в этой части Злачника должен быть отключён со старта раунда.
		private _lightShield = "PlantLightShield" call getObjectByRef;
		assert_str(!isNullReference(_lightShield),"Global reference 'PlantLightShield' not found");
		if !isNullReference(_lightShield) then {
			callFunc(_lightShield,__disableAllWires);
		};

		private _exitShield = "ElectricalShieldSaloonExit" call getObjectByRef;
		private _insertBlock = "HolotapeInsertBlock" call getObjectByRef;
		private _exitGate1 = "SaloonExitGate1" call getObjectByRef;
		private _exitGate2 = "SaloonExitGate2" call getObjectByRef;
		assert_str(!isNullReference(_exitShield),"Global reference 'ElectricalShieldSaloonExit' not found");
		assert_str(!isNullReference(_insertBlock),"Global reference 'HolotapeInsertBlock' not found");
		assert_str(!isNullReference(_exitGate1),"Global reference 'SaloonExitGate1' not found");
		assert_str(!isNullReference(_exitGate2),"Global reference 'SaloonExitGate2' not found");
		if !isNullReference(_exitShield) then {
			callFunc(_exitShield,__disableAllWires);
		};
		{
			if !isNullReference(_x) then {
				if getVar(_x,isLocked) then {
					callFuncParams(_x,setDoorLock,false arg false);
				};
				if getVar(_x,isOpen) then {
					callFuncParams(_x,setDoorOpen,false arg true);
				};
				callFuncParams(_x,setDoorLock,true arg false);
			};
		} foreach [_exitGate1,_exitGate2];
		if !isNullReference(_insertBlock) then {
			private _scriptCreated = ["SaloonHolotapeInsertScript",_insertBlock] call createGameObjectScript;
			assert_str(_scriptCreated,"Cannot assign SaloonHolotapeInsertScript to HolotapeInsertBlock");
		};
		

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
			for "_i" from 1 to randInt(1,6) do {[pick["HatUshankaUp2","HatUshanka","WorkerCap","WorkerCap2","HatUshankaUp"],_yashsVerh] call createItemInContainer};
		
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

	func(getRoofMoneyValue)
	{
		objParams_1(_moneyObj);
		if !isTypeOf(_moneyObj,Money) exitWith {0};
		private _stackCount = getVar(_moneyObj,stackCount);
		if isTypeOf(_moneyObj,Bryak) exitWith {_stackCount * 10};
		_stackCount
	};

	func(collectRoofStartMoneyValue)
	{
		objParams();
		private _total = 0;
		{
			modVar(_total,+ callSelfParams(getRoofMoneyValue,_x));
		} foreach (["Money",true] call getAllItemsTypeOf);
		_total
	};

	func(isMobInSBSCageArea)
	{
		objParams_1(_mob);
		if isNullReference(_mob) exitWith {false};
		(callFunc(_mob,getPos)) inArea [[3362.780,3654.742,33.725],4.6,2.2,0,true,5];
	};

	func(isMobInEscapeArea)
	{
		objParams_1(_mob);
		if isNullReference(_mob) exitWith {false};
		(callFunc(_mob,getPos)) inArea [[3346.00,3763.80,27.21],5,6,0,true,100];
	};

	func(startEscapeSequence)
	{
		objParams();
		if getSelf(isEscapeSequenceStarted) exitWith {false};

		private _exitShield = "ElectricalShieldSaloonExit" call getObjectByRef;
		private _insertBlock = "HolotapeInsertBlock" call getObjectByRef;
		private _exitGate1 = "SaloonExitGate1" call getObjectByRef;
		private _exitGate2 = "SaloonExitGate2" call getObjectByRef;
		if (isNullReference(_exitShield) || {isNullReference(_insertBlock)} || {isNullReference(_exitGate1)} || {isNullReference(_exitGate2)}) exitWith {
			error("GMSaloonV2::startEscapeSequence() - One or more escape objects are missing");
			false
		};

		setSelf(isEscapeSequenceStarted,true);
		callFunc(_exitShield,__enableAllWires);
		if getVar(_exitGate1,isLocked) then {
			callFuncParams(_exitGate1,setDoorLock,false arg false);
		};
		callFuncParams(_exitGate1,setDoorOpen,true arg true);
		callSelf(playEscapeAlarm);
		callSelfAfter(finishEscapeSequence,45);
		true
	};

	func(playEscapeAlarm)
	{
		objParams();
		if (!getSelf(isEscapeSequenceStarted) || getSelf(isEscapeSequenceFinished)) exitWith {};
		private _insertBlock = "HolotapeInsertBlock" call getObjectByRef;
		if isNullReference(_insertBlock) exitWith {};
		private _alarmPosition = callFunc(_insertBlock,getModelPosition) vectorAdd [0,0,5];
		callFuncParams(_insertBlock,playSound,"UNCATEGORIZED\cool_alarm.ogg" arg 1 arg 6000 arg 0.2 arg _alarmPosition arg true);
		callSelfAfter(playEscapeAlarm,8);
	};

	func(finishEscapeSequence)
	{
		objParams();
		if (!getSelf(isEscapeSequenceStarted) || getSelf(isEscapeSequenceFinished)) exitWith {};
		private _exitGate1 = "SaloonExitGate1" call getObjectByRef;
		private _exitGate2 = "SaloonExitGate2" call getObjectByRef;

		if !isNullReference(_exitGate1) then {
			callFuncParams(_exitGate1,setDoorOpen,false arg true);
			callFuncParams(_exitGate1,setDoorLock,true arg false);
		};

		private _escapedNames = [];
		private _rewardedClients = [];
		{
			if (!isNullReference(_x) && {!getVar(_x,isDead)} && {callSelfParams(isMobInEscapeArea,_x)}) then {
				_escapedNames pushBackUnique (callFuncParams(_x,getNameEx,"кто"));
				private _client = callFunc(_x,getLastPlayerClient);
				if (!isNullReference(_client) && {!(_client in _rewardedClients)}) then {
					_rewardedClients pushBack _client;
					callFuncParams(_client,addPoints,1 arg true);
				};
			};
		} foreach system_internal_list_allJoiners;
		setSelf(escapedPeopleNames,_escapedNames);

		if !isNullReference(_exitGate2) then {
			if getVar(_exitGate2,isLocked) then {
				callFuncParams(_exitGate2,setDoorLock,false arg false);
			};
			callFuncParams(_exitGate2,setDoorOpen,true arg true);
		};
		setSelf(isEscapeSequenceFinished,true);
	};
	
	func(checkFinish)
	{
		objParams();
		if getSelf(isEscapeSequenceFinished) exitWith {callSelf(getEscapeFinishCode)};
		if getSelf(isEscapeSequenceStarted) exitWith {0};
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
		if (getSelf(finishResult) == callSelf(getEscapeFinishCode)) exitWith {
			private _escapedNames = getSelf(escapedPeopleNames);
			if (count _escapedNames == 0) exitWith {"Ворота открылись, но никому не удалось покинуть Злачник."};
			"Эти люди дорого заплатили за возможность покинуть Злачник: " + (_escapedNames joinString ", ") + "." + " Они даже не могут себе представить, чем это обернётся.." + "."
		};
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

class(SaloonHolotapeInsertScript) extends(ScriptedGameObject)
	var(isActivated,false);
	func(_onInteractWithWrapper)
	{
		objParams_4(_with,_usr,_combat,_inventory);
		if !isTypeOf(_with,Holotape) exitWith {
			callSelf(callBaseInteractWith);
		};
		if getSelf(isActivated) exitWith {
			callFuncParams(_usr,localSay,"Кассета уже вставлена." arg "error");
		};
		if !isTypeOf(gm_currentMode,GMSaloonV2) exitWith {
			callFuncParams(_usr,localSay,"Ничего не происходит." arg "error");
		};
		if !callFunc(gm_currentMode,startEscapeSequence) exitWith {
			callFuncParams(_usr,localSay,"Механизм не отвечает." arg "error");
		};

		setSelf(isActivated,true);
		callFuncParams(_usr,meSay,"вставляет кассету в устройство");
		delete(_with);
	};
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



class(Saloon_Task_RoofV2) extends(Saloon_Task_BaseV2)
	var(debtValue,0);
	var(banditMainMob,nullPtr);
	var(barmenMob,nullPtr);
	var(banditMainStash,nullPtr);
	var(barmenStash,nullPtr);
	var(banditMainClueText,"");
	var(barmenClueText,"");
	var(militiaBriefSent,false);
	var(finishCode,0);
	var(cageCountdown,-1);

	func(onTaskInit)
	{
		objParams();

		private _banditMainMob = getSelf(banditMainMob);
		private _barmenMob = getSelf(barmenMob);

		private _totalValue = callFunc(gm_currentMode,collectRoofStartMoneyValue);
		private _debtValue = floor(_totalValue * 0.4);
		if (_debtValue <= 0) then {_debtValue = 25};
		setSelf(debtValue,_debtValue);

		private _stashPoints = [
			[vec3(3463.77,3589.05,25) arg 15 arg "Схрон в железном сарае. Если смотреть на входную дверь бара, надо направляться направо, сарай находится в конце улицы."] arg
			[vec3(3408,3684.39,25) arg 182 arg "Недалеко от горящей бочки, на углу двора. Надо перешагнуть через лестницу справа от бочки."] arg
			[vec3(3427.48,3631.08,29.6) arg 12 arg "Схрон в разрушенном здании напротив бара. На втором этаже вверх по лестнице."] arg
			[vec3(3390.30,3649.57,27.7) arg 332 arg "Схрон в разрушенном здании напротив здания ополчения."] arg
			[vec3(3430.07,3677.04,29.88) arg 7 arg "Схрон в разрушенном здании напротив лекарской. На втором этаже."]
		];
		_stashPoints = array_shuffle(_stashPoints);

		private _banditMainPoint = _stashPoints deleteAt 0;
		private _barmenPoint = _stashPoints deleteAt 0;
		_banditMainPoint params ["_banditMainPos","_banditMainDir","_banditMainText"];
		_barmenPoint params ["_barmenPos","_barmenDir","_barmenText"];

		private _banditMainStash = ["RoofStash_SaloonV2" arg _banditMainPos arg _banditMainDir arg false] call createStructure;
		private _barmenStash = ["RoofStash_SaloonV2" arg _barmenPos arg _barmenDir arg false] call createStructure;
		setSelf(banditMainStash,_banditMainStash);
		setSelf(barmenStash,_barmenStash);
		setSelf(banditMainClueText,_banditMainText);
		setSelf(barmenClueText,_barmenText);

		if !isNullReference(_banditMainMob) then {
			private _msgBanditMain = format[
				"<t color='#FFB347'>За прошлую смену группировка задолжала %1 звяков ополченцам за крышу. Уже в эту смену ополченцы будут разыскивать нас и любой ценой добьются своего, ведь нам не раз удавалось с ними 'договориться' и избежать ответственности за все прошлые проступки... Долговой схрон: %2. Нужно где-то раздобыть звяки и отнести в положенное место. Ведь мы хотим дальше заниматься вседозволенным и прикрываться законом.</t>",
				_debtValue,
				_banditMainText
			];
			callFuncParams(_banditMainMob,addFirstJoinMessage,_msgBanditMain);
		};
		if !isNullReference(_barmenMob) then {
			private _msgBarmen = format[
				"<t color='#FFB347'>За прошлую смену бар 'Дыра' задолжал %1 звяков ополченцам за крышу. Уже в эту смену ополченцы придут в бар и любой ценой добьются своего, ведь нам не раз удавалось с ними 'договориться' и избежать ответственности. Долговой схрон: %2. Нужно где-то раздобыть звяки и отнести в положенное место. Иначе как мы будем продолжать работу, ведь ополченцы должны прийти уже в эту смену и поинтересоваться откуда у нас новые партии алкоголя и где лицензия на его продажу?</t>",
				_debtValue,
				_barmenText
			];
			callFuncParams(_barmenMob,addFirstJoinMessage,_msgBarmen);
		};

	};

	getter_func(getDesc,"Пора платить по счетам.");

	func(getFinishDesc)
	{
		objParams_1(_result);
		if (_result == 5) exitWith {"Ополченцы закрыли и Барника, и Пахана в клетках. В Злачнике затишье."};
		if (_result == 1) exitWith {"Пахан пережил разборку. Барник погиб, и теперь весь Злачник будет жить по воле 'Руки'."};
		if (_result == 2) exitWith {"Барник пережил разборку. Пахан погиб и его место освободилось - надолго ли?"};
		if (_result == 3) exitWith {"Ополченцы закрыли Барника в клетке. Пахан выстоял и теперь весь Злачник будет жить по воле 'Руки'."};
		if (_result == 4) exitWith {"Ополченцы закрыли Пахана в клетке. Барник выстоял и его бар ждет лучшие времена."};
		if (_result == -1) exitWith {"Начальник ополчения мёртв, платить крышу больше некому. В Злачнике начинается новый порядок."};
		if (_result == -2) exitWith {"Удивительно спокойная и тихая смена в злачнике."};
		if (_result == -3) exitWith {"Пахан и Барник мертвы. Ополченцы не получили звяки."};
		"Сегодня не произошло ничего интересного...";
	};

	func(checkFinish)
	{
		objParams();
		private _finishCode = getSelf(finishCode);
		if (_finishCode != 0) exitWith {_finishCode};

		private _banditMainMob = getSelf(banditMainMob);
		private _barmenMob = getSelf(barmenMob);

		private _timeGatePassed = gm_roundDuration >= 3600;
		private _banditMainDead = !isNullReference(_banditMainMob) && {getVar(_banditMainMob,isDead)};
		private _barmenDead = !isNullReference(_barmenMob) && {getVar(_barmenMob,isDead)};
		if (_timeGatePassed && _banditMainDead && _barmenDead) exitWith {-3};
		if (_timeGatePassed && _barmenDead) exitWith {1};
		if (_timeGatePassed && _banditMainDead) exitWith {2};

		private _barmenInCage = !isNullReference(_barmenMob) && {callFuncParams(gm_currentMode,isMobInSBSCageArea,_barmenMob)} && {!getVar(_barmenMob,isDead)};
		private _banditInCage = !isNullReference(_banditMainMob) && {callFuncParams(gm_currentMode,isMobInSBSCageArea,_banditMainMob)} && {!getVar(_banditMainMob,isDead)};

		// Запускаем таймер когда хоть кто-то оказался в клетке
		private _countdown = getSelf(cageCountdown);
		if ((_barmenInCage || _banditInCage) && {_countdown < 0}) then {
			setSelf(cageCountdown, 0);
			_countdown = 0;
		};
		if (_countdown >= 0) then {
			modSelf(cageCountdown, + 1);
		};
		// По истечении 30 сек - фиксируем кто в клетке на этот момент
		if (getSelf(cageCountdown) >= 30) exitWith {
			setSelf(cageCountdown, -1);
			private _r = 0;
			if (_barmenInCage && _banditInCage) then {_r = 5};
			if (_barmenInCage && !_banditInCage) then {_r = 3};
			if (_banditInCage && !_barmenInCage) then {_r = 4};
			_r
		};

		if (gm_roundDuration >= getVar(gm_currentMode,duration)) exitWith {-2};
		0
	};

	func(requestFinish)
	{
		objParams_1(_finishResult);
		private _currentFinishCode = getSelf(finishCode);
		if (_currentFinishCode != 0 && {_finishResult != -3}) exitWith {};
		setSelf(finishCode,_finishResult);
	};
endclass

	class(RoofStash_SaloonV2) extends(SquareWoodenBox)
		var(name,"Деревянная коробка");
		var(desc,"Крупная и пахнет странно");
		getter_func(isMovable,true);
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
		if getVar(_portf,isOpenedByTrader) exitWith {-4};
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
		var(isOpenedByTrader,false);
		/*func(canPickup)
		{
			objParams();
			super() && _isCanRole
		};
		func(onCantPickup)
		{
			objParams_1(_usr);
		};*/
		getter_func(canUseMainAction,(!getSelf(isLockedSaloon) || isTypeOf(getVar(_usr,basicRole),RTorgSaloon)) && super());
		getter_func(getMainActionName,ifcheck(getSelf(isLockedSaloon),"Вскрыть","Открыть"));
		func(onMainAction)
		{
			objParams_1(_usr);
			if !getSelf(isLockedSaloon) exitWith {
				callSuper(Container,onMainAction);
			};

			if (callSelf(getModelPosition) distance2d [3426.21,3714.96,27.6805] >= 5) then {
				callFuncParams(_usr,mindSay,"Чтобы вскрыть этот замок надо тащить чемодан ко мне в магазин. Все необходимые инструменты для вскрытия там есть!");
			} else {
				callFuncParams(_usr,mindSay,"Я с лёгкостью вскрываю замок!");
				setSelf(isOpenedByTrader,true);
				setSelf(isLockedSaloon,false);
			};
		};
		func(onInteractWith)
		{
			objParams_2(_with,_usr);
			if (getSelf(isLockedSaloon) && {isTypeOf(_with,Lockpick) || isTypeOf(_with,Crowbar)}) exitWith {
				if !isTypeOf(getVar(_usr,basicRole),RBrigadirSaloon) exitWith {
					private _m = pick["Я не понимаю, как вскрыть этот замок.","Не знаю как открывать его.","Не получается открыть.","Не получилось, соскакивает.","Не могу разобраться как.","Не выходит вскрыть."];
					callFuncParams(_usr,mindSay,_m);
				};

				callFuncParams(_usr,meSay,"начинает вскрывать замок на чемодане");
				callFuncParams(_usr,startProgress,this arg "target.onSuitcaseBreaking" arg 10 arg INTERACT_PROGRESS_TYPE_FULL arg _with);
			};

			callSuper(Container,onInteractWith);
		};
		func(onSuitcaseBreaking)
		{
			objParams_2(_usr,_tool);
			if !getSelf(isLockedSaloon) exitWith {};
			if !isTypeOf(getVar(_usr,basicRole),RBrigadirSaloon) exitWith {};
			if isNullReference(_tool) exitWith {};
			if !(isTypeOf(_tool,Lockpick) || isTypeOf(_tool,Crowbar)) exitWith {};
			if not_equals(callFunc(_usr,getItemInActiveHandRedirect),_tool) exitWith {};

			setSelf(isLockedSaloon,false);
			setSelf(canUseContainer,true);
			setSelf(desc,"Вскрытый чемодан. Внутри лежат бряки.");
			callSelfParams(initMoney,(randInt(19,22) * 10) arg true);
			callFuncParams(_usr,meSay,"вскрывает чемодан");
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
