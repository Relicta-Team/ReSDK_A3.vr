// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\GameMode.h>

// Базовая роль для режима GMTruba. Рекомендуется именовать все дочерние роли для этого режима с постфиксом имени режима и префиксом R (Role)
// Пример: RCaveExplorer_GMTruba

class(GMTruba_BasicRole) extends(BasicRole) // BasicRole - базовая роль, от которой унаследованы все возможные роли.

	func(onDeadBasic)
	{
		objParams_2(_mob,_usr);
		callFuncParams(_usr,setDeadTimeout,300);
		// Установка таймера призраку (в секундах)
		// работает если returnInLobbyAfterDead возвращает false
	};
	
endclass

class(GMTruba_SettelmentsRole) extends(GMTruba_BasicRole) // Поселенцы
endclass

class(GMTruba_ScarsRole) extends(GMTruba_BasicRole) // Рубцы
endclass

// --- Основные роли поселения --- //

class(RChief) extends(GMTruba_SettelmentsRole)
	var(name,"Вождь");
	var(desc,"Ты вождь в пятом поколении. Твоя задача управлять поселением. 
	Поддерживай порядок" pcomma " устраивай сборы" pcomma " проводи молитвы. 
	Славься мудрый вождь!");
	getter_func(isMainRole,true); // Ключевая роль
	getter_func(spawnLocation,"pos:RChief");  // Позиция спавна
	getter_func(connectedTo,"ref:RChiefBed"); // Точка привязки (кровать или стул)
	getter_func(needDiscordRoles,["Forsaken"]);
	
	func(onAssigned)
	{
		objParams_2(_mob,_usr);
		super();
		setVar(gm_currentMode,leaderTruba,_mob);
	};

	// Навыки
	getter_func(getSkills,"st:11-14; dx:12-13; iq:12-13; ht:10-14");
	func(getOtherSkills) {
		"fight:3;" 
		+"shotgun:3;"
		+"healing:3;" 
		+"surgery:3;"
		+"cavelore:3"
	};

	// Функция выдачи экипировки
	func(getEquipment)
	{
		objParams_1(_mob);
		private _cloth = ["GreatcoatBrown",_mob,INV_CLOTH] call createItemInInventory; // Создание одежды на слоте одежды
		setVar(_cloth,name,"Одежда вождя");
		// ["Bandage",_cloth] call createItemInContainer; // Создание 1 предмета в одежде
		["HatOldUshanka",_mob,INV_HEAD] call createItemInInventory; // Шапка
		["WoolCoat",_mob,INV_BACK] call createItemInInventory; // Накидка
		private _shot = ["Shotgun",_mob,INV_BACKPACK] call createItemInInventory; // Оружие на слоте рюкзака
		callFuncParams(_shot,createAmmoInMagazine,"AmmoShotgun"); // Вызов метода, создающий патроны в "магазине" дробовика
		_ammo = ["AmmoShotgun",_cloth] call createItemInContainer; // Патроны в инвентаре
		callFuncParams(_ammo,initCount,randInt(10,16));

		private _keyOwn = ["RChiefKey"];
		regKeyInUniform(_cloth,_keyOwn,"Вождевой ключ");
	};
endclass

class(RChiefSon) extends(GMTruba_SettelmentsRole)
	var(name,"Сын вождя"); 
	var(desc,"Ты уже совсем вырос" pcomma " и скоро тебе придётся взять на себя бремя вождя.
	Помогай своему отцу в делах управления и прислушивайся к его советам.");
	getter_func(isMainRole,true);
	getter_func(spawnLocation,"pos:RChiefSon");
	getter_func(connectedTo,"ref:RChiefSonBed");
	getter_func(needDiscordRoles,["Forsaken"]);
	
	getter_func(getSkills,"st:10-12; dx:10-12; iq:10-12; ht:10-12");
	func(getOtherSkills) {
		"theft:3;"
		+ "stealth:3;"
	};	

	func(getEquipment) 
	{
		objParams_1(_mob);
		private _cloth = ["BanditCommanderSaloonCloth",_mob,INV_CLOTH] call createItemInInventory;
		setVar(_cloth,name,"Редкая кожаная куртка");
		setVar(_cloth,desc,"Описание");
		["WorkerCoolCap",_mob,INV_HEAD] call createItemInInventory;
		private _keyOwn = ["RChiefSonKey"];
		regKeyInUniform(_cloth,_keyOwn,"Ключ от дома");
	};
endclass

class(RStorekeeper) extends(GMTruba_SettelmentsRole)
	var(name,"Кладовой"); 
	var(desc,"Твоя работа - следить за складом и распределять припасы в поселении. 
	Внимательно следи за складом" pcomma " и веди учёт" pcomma " ведь эти хвосты опять захотят что-то украсть. 
	Вождь обязательно придёт всё тут проверить" pcomma " и не дай Живчик что-то потеряется...");
	getter_func(isMainRole,true);
	getter_func(spawnLocation,"pos:RStorekeeper");
	getter_func(connectedTo,"ref:RStorekeeperBed");
	getter_func(needDiscordRoles,["Forsaken"]);

	getter_func(getSkills,"st:9-12; dx:11-13; iq:8-11; ht:8-12");
	func(getOtherSkills) {
		"fight:3;" 
		+"shotgun:3;"
		+"healing:3;" 
		+"surgery:3;"
		+"cavelore:3"
	};

	func(getEquipment)
	{
		objParams_1(_mob);
		private _cloth = ["ZnatCloth",_mob,INV_CLOTH] call createItemInInventory;
		setVar(_cloth,name,"Хороший куртка");
		["HatRedSaloon",_mob,INV_HEAD] call createItemInInventory;
		private _keyOwn = ["RStorekeeperKey"];
		regKeyInUniform(_cloth,_keyOwn,"Складской ключ");
	};
endclass

class(RKitchener) extends(GMTruba_SettelmentsRole)
	var(name,"Кухарь"); 
	var(desc,"Твоя работа - управлять столовой. 
	Всю тяжёлую работу отдавай поварешке" pcomma " старайся держать кухню в порядке. Племя всё время хочет жрать.
	А ты" pcomma " кажется" pcomma " в прошлый раз так вообще всю нашу еду испортил! 
	Похоже" pcomma " тебе снова придётся идти к Кладовому" pcomma " ведь без припасов ты" pcomma " вероятно" pcomma " ничего толком и не сваришь.");
	getter_func(spawnLocation,"pos:RKitchener");
	getter_func(connectedTo,"ref:RKitchenerBed");
	
	getter_func(getSkills,"st:9-11; dx:9-11; iq:9-11; ht:9-11");
	func(getOtherSkills) {
		"cooking:5;"
	};

	func(getEquipment) 
	{
		objParams_1(_mob);
		private _cloth = ["CookerCloth",_mob,INV_CLOTH] call createItemInInventory;
		setVar(_cloth,name,"Одежда кухаря");
		["CookerCap",_mob,INV_HEAD] call createItemInInventory;
		private _keyOwn = ["RKitchenerKey"];
		regKeyInUniform(_cloth,_keyOwn,"Ключ от столовой");
	};
endclass

class(RKitchenerHelper) extends(GMTruba_SettelmentsRole)
	var(name,"Поварёшка"); 
	var(desc,"Твоя задача - варить жратву и слушать приказы Кухаря. 
	Если в эту смену ты снова решишь напиться браги" pcomma " то тебя вышвырнут в Рукав.
	Но тебе ведь не хочется этого" pcomma " верно?");
	getter_func(spawnLocation,"pos:RKitchenerHelper");
	getter_func(connectedTo,"ref:RKitchenerHelperBed");
	
	getter_func(getSkills,"st:9-11; dx:9-11; iq:9-11; ht:9-11");
	func(getOtherSkills) {
		"cooking:5;"
	};

	func(getEquipment)
	{
		objParams_1(_mob);
		private _cloth = ["NomadCloth12",_mob,INV_CLOTH] call createItemInInventory;
		setVar(_cloth,name,"Одежда поварёшки");
		["ButterPiece",_mob,INV_HAND_R] call createItemInInventory; // Создание предмета в руке
		["CookerCap",_mob,INV_HEAD] call createItemInInventory;
		private _keyOwn = ["RKitchenerKey"];
		regKeyInUniform(_cloth,_keyOwn,"Ключ от столовой");
	};
endclass

class(RCaveDoctor) extends(GMTruba_SettelmentsRole)
	var(name,"Пещерный лекарь"); 
	var(desc,"Ты" pcomma " видимо" pcomma " здесь для того" pcomma " чтобы делать вид" pcomma " будто ты знаешь хоть какой-то толк в лекарском деле. 
	Но в любом случае" pcomma "ты должен хотя бы постараться помочь всем этим бедолагам. Ведь кроме тебя это сделать некому.");
	getter_func(spawnLocation,"pos:RCaveDoctor");
	getter_func(connectedTo,"ref:RCaveDoctorBed");

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
		private _keyOwn = ["RCaveDoctorKey"];
		regKeyInUniform(_cloth,_keyOwn,"Лекарский ключ");
	};
endclass

class(RGuard) extends(GMTruba_SettelmentsRole)
	var(name,"Сторож"); 
	var(desc,"Твоя работа несложная" pcomma " но важная! Следи за воротами и порядком в Трубе.
	Если всё спокойно - можно лечь на пузо и пускать слюни" pcomma " а часть работы смело свалить на помощника.");
	getter_func(spawnLocation,"pos:RGuard");
	getter_func(connectedTo,"ref:RGuardBed");
	getter_func(needDiscordRoles,["Forsaken"]);
	
	getter_func(getSkills,"st:10-12; dx:11-13; iq:9-11; ht:9-11");
	func(getOtherSkills) {
		"fight:2;" 
		+"shotgun:2;"
	};
	
	func(getEquipment)
	{
		objParams_1(_mob);
		private _cloth = ["ArmyCloth1",_mob,INV_CLOTH] call createItemInInventory;
		setVar(_cloth,name,"Одежда сторожа");
		["SamokrutkaDisabled",_mob,INV_FACE] call createItemInInventory; // Сигарета во роте. Правильно говорить не в роте, а во рту
		["HatUshanka",_mob,INV_HEAD] call createItemInInventory;
		private _keyOwn = ["RGuardKey"];
		regKeyInUniform(_cloth,_keyOwn,"Ключ сторожа");
	};
endclass

class(RFarmerTruba) extends(GMTruba_SettelmentsRole)
	var(name,"Гриблан"); 
	var(desc,"Ты простой гриблан" pcomma " твоя работа - ухаживать за мельтешатами и выращивать грибы. 
	Твоя жизнь" pcomma " возможно" pcomma " не самая захватывающая" pcomma " но для тебя важно найти радость в этой тьме" pcomma " даже если это радость от браги и лени. 
	Что ж" pcomma " ты такой" pcomma " какой есть" pcomma " и кто-то же должен делать эту грязную работу" pcomma " правда?");
	getter_func(spawnLocation,"pos:RFarmerTruba");
	getter_func(connectedTo,"ref:RFarmerTrubaBed");

	getter_func(getSkills,"st:9-11; dx:9-11; iq:9-11; ht:9-11");
	func(getOtherSkills) {
		"farming:5;"
	};

	func(getEquipment)
	{
		objParams_1(_mob);
		private _cloth = ["GriblanCloth",_mob,INV_CLOTH] call createItemInInventory;
		setVar(_cloth,name,"Куртка гриблана");
		private _keyOwn = ["RFarmerTrubaKey"];
		regKeyInUniform(_cloth,_keyOwn,"Грибланский ключ");
	};
endclass

// ---- Дополнительные роли поселения ---- //
//Обдумать, кому из них давать доступ к игре только после начала раунда что бы долбаёбы занимали только полезные роли а не ебланские
class(RGuardHelper) extends(GMTruba_SettelmentsRole)
	var(name,"Помощник сторожа"); 
	var(desc,"Сторож не всегда может справиться в одиночку.
	Сделай всё возможное" pcomma " чтобы помочь ему" pcomma " и тебя похвалят.");
	getter_func(spawnLocation,"pos:RGuardHelper");
	getter_func(connectedTo,"ref:RGuardHelperBed");

	getter_func(getSkills,"st:10-11; dx:11-12; iq:9-11; ht:9-11");
	func(getOtherSkills) {
		"fight:1;" 
		+"shotgun:1;"
	};

	func(getEquipment)
	{
		objParams_1(_mob);
		private _cloth = ["NomadCloth9",_mob,INV_CLOTH] call createItemInInventory;
		setVar(_cloth,name,"Сторожские лохмотья");
		["HatUshanka",_mob,INV_HEAD] call createItemInInventory;
		private _keyOwn = ["RGuardKey"];
		regKeyInUniform(_cloth,_keyOwn,"Ключ как у сторожа");
	};
endclass

class(RCaveDoctorHelper) extends(GMTruba_SettelmentsRole)
	var(name,"Помощник лекаря"); 
	var(desc,"Две руки хорошо" pcomma " а четыре - лучше! Особенно когда их владелец знает" pcomma " что делает. 
	К тебе это вряд ли относится" pcomma " ведь ты пока только перенимаешь ремесло врачевания. 
	Но твоя  помощь лишней не будет точно!");
	getter_func(spawnLocation,"pos:RCaveDoctorHelper");
	getter_func(connectedTo,"ref:RCaveDoctorHelperBed");

	getter_func(getSkills,"st:7-8; dx:8-10; iq:10-12; ht:9-11");
	func(getOtherSkills) {
		"healing:3;" 
		+"surgery:3;"
		+"chemistry:3;"
	};

	func(getEquipment)
	{
		objParams_1(_mob);
		private _cloth = ["CitizenCloth13",_mob,INV_CLOTH] call createItemInInventory;
		setVar(_cloth,name,"Почти чистые обноски");
		["Rag",_cloth] call createItemInContainer;
		["Crutch",_mob,INV_BACK] call createItemInInventory;
		["Crutch",_mob,INV_BACKPACK] call createItemInInventory;
		["HatGrayOldUshanka",_mob,INV_HEAD] call createItemInInventory;
		private _keyOwn = ["RCaveDoctorKey"];
		regKeyInUniform(_cloth,_keyOwn,"Ключ как у лекаря");
	};
endclass

class(RLighter) extends(GMTruba_SettelmentsRole)
	var(name,"Светоч"); 
	var(desc,"Тебе дана задача следить за факелами" pcomma " светляками и кострами.
	Если хорошо сделаешь свою работу" pcomma " то сможешь хорошо поесть.");
	getter_func(spawnLocation,"pos:RLighter");
	getter_func(connectedTo,"ref:RLighterBed");
	
	getter_func(getSkills,"st:7-8; dx:7-8; iq:7-8; ht:7-8");
	func(getOtherSkills) {
		"cavelore:5;"
		+ "stealth:5;"
	};

	func(getEquipment)
	{
		objParams_1(_mob);
		private _cloth = ["CitizenCloth4",_mob,INV_CLOTH] call createItemInInventory;
		setVar(_cloth,name,"Рваньё");
		private _keyOwn = ["RLighterKey"];
		regKeyInUniform(_cloth,_keyOwn,"Ключ от подсобки");
	};
endclass

class(RCleanerTruba) extends(GMTruba_SettelmentsRole)
	var(name,"Уходник"); 
	var(desc,"Бери щётку в руки и начинай тут везде чистить" pcomma "потому что везде порядок нужен. 
	Пойди лекарю помоги" pcomma "и вообще" pcomma "пользу приноси!");
	getter_func(spawnLocation,"pos:RCleanerTruba");
	getter_func(connectedTo,"ref:RCleanerTrubaBed");
	
	getter_func(getSkills,"st:7-8; dx:7-8; iq:5-6; ht:7-8");

	func(getEquipment)
	{
		objParams_1(_mob);
		private _cloth = ["CitizenCloth11",_mob,INV_CLOTH] call createItemInInventory;
		setVar(_cloth,name,"Рваньё");
		private _keyOwn = ["RFarmerTrubaKey"];
		regKeyInUniform(_cloth,_keyOwn,"Ключ от ферм");
	};
endclass

class(RWorkerTruba) extends(GMTruba_SettelmentsRole)
	var(name,"Работник"); 
	var(desc,"Обыкновенный житель поселения. 
	Случись что" pcomma " за тебя никто не спохватится даже. 
	Но жрать то надо? Значит придётся работать.");
	var(count,2);

	func(spawnLocation) // Две разные кровати для одной роли
	{
		objParams();
		if(getSelf(count)==1) then{"pos:RWorkerTruba1"}
		else{"pos:RWorkerTruba2"};
	};

		func(connectedTo)
	{
		objParams();
		if(getSelf(count)==1) then{"ref:RWorkerTrubaBed1"}
		else{"ref:RWorkerTrubaBed2"};
		
	};

	getter_func(getSkills,"st:8-9; dx:8-9; iq:6-7; ht:7-8");

	func(getEquipment)
	{
		objParams_1(_mob);
		private _cloth = ["NomadCloth20",_mob,INV_CLOTH] call createItemInInventory;
		setVar(_cloth,name,"Рабочая одежда");
		private _keyOwn = ["RWorkerTrubaKey"];
		regKeyInUniform(_cloth,_keyOwn,"Ключ от комнаты");
	};
endclass

class(RScoutTruba) extends(GMTruba_SettelmentsRole)
	var(name,"Лазутчик");
	var(desc,"В прошлую смену вождь отправил тебя на вылазку в ближайшие пещеры за припасами. Сейчас ты уже на подходе обратно в поселение. Что же тебе удалось найти?");
	var(count,10);
	getter_func(spawnLocation,"rpos:RScoutTruba");

	getter_func(getSkills,"st:8-9; dx:8-9; iq:6-7; ht:7-8");

	func(getEquipment)
	{
		objParams_1(_mob);
		private _cloth = ["NomadCloth" + str randInt(1,15),_mob,INV_CLOTH] call createItemInInventory;
		setVar(_cloth,name,"Рабочая одежда");
		["CaveAxe",_mob,INV_BELT] call createItemInInventory;
		["Torch",_mob,INV_HAND_R] call createItemInInventory;

		private _bag = ["FabricBagBig1",_mob,INV_BACKPACK] call createItemInInventory;

		//Создат 7-8 объектов item1 или item2 (выбирается случайно)
		for "_i" from 1 to randInt(3,6) do {
		private _itemName = pick["Melteshonok","Egg","Zhivoglot","Yaichnik","Gnilokornik","Bone","CampfireCreator","MatchBox","Rag","Forceps"];
    	[_itemName,_bag] call createItemInContainer;
		};

		if prob(60) then {
			[
			pick["HatOldUshanka","HatUshanka","WorkerCap","WorkerCoolCap","HatGrayOldUshanka"],
			_mob,INV_HEAD
			] call createItemInInventory;
		};

	};

	func(canVisibleAfterStart)
	{
		objParams_1(_usr);
		gm_roundDuration >= t_asMin(10);
	};

endclass

// ---- Роли рубцов ---- //
class(RLordTruba) extends(GMTruba_ScarsRole)
	var(name,"Владыка"); 
	var(desc,"Несколько планов назад тебя и других" pcomma " таких же бедолаг" pcomma " изгнали в Рукав. 
	Тебе выпала ""удача"" возглавить сброд этих преступников.

	Прошло уже много смен" pcomma " и ты устал жить в этих невыносимых условиях. 
	Ты должен как-то доказать" pcomma " что все вы достойны жить в поселении.

	Надо как-то выкручиваться из этой ситуации" pcomma " как говорится: ""Живы будем - не порвём!""");
	getter_func(isMainRole,true);
	getter_func(spawnLocation,"pos:RLordTruba");
	getter_func(connectedTo,"ref:RLordTrubaBed");
	getter_func(needDiscordRoles,["Forsaken"]);

	func(onAssigned)
	{
		objParams_2(_mob,_usr);
		super();
		setVar(gm_currentMode,leaderScars,_mob);
	};

	getter_func(getSkills,"st:11-13; dx:11-13; iq:7-8; ht:8-12");
	func(getOtherSkills) {
		"fight:3;" 
		+"shotgun:1;"
		+"healing:3;" 
		+"surgery:1;"
		+"cavelore:3"
	};

	func(getEquipment)
	{
		objParams_1(_mob);
		private _cloth = ["BrigadirCloth",_mob,INV_CLOTH] call createItemInInventory;
		setVar(_cloth,name,"Везучая куртейка");
		["HatBandana",_mob,INV_HEAD] call createItemInInventory;
		["ToolStraigthPipe",_mob,INV_HAND_R] call createItemInInventory;
		private _OneShot = ["PistolOneShoot",_mob,INV_BELT] call createItemInInventory;
		callFuncParams(_OneShot,createAmmoInMagazine,"AmmoRevolver");
		_ammo = ["AmmoRevolver",_cloth] call createItemInContainer;
		callFuncParams(_ammo,initCount,randInt(5,8));

		private _keyOwn = ["RLordTrubaKey"];
		regKeyInUniform(_cloth,_keyOwn,"Ключ от калитки");
	};
endclass

class(RRoistererTruba) extends(GMTruba_ScarsRole)
	var(name,"Бражник"); 
	var(desc,"Любитель задобриться бражкой" pcomma " пещерный самогонщик. 
	Рецепт вкуснейшей" pcomma " тебе достался от деда" pcomma " она так манит пощекотать бурчак" pcomma " что невозможно устоять...
	
	Вари бражку" pcomma " выращивай грибочки" pcomma " крути грибные самокрутки" pcomma " следи за хозяйством в рукаве. ");
	getter_func(spawnLocation,"pos:RRoistererTruba");
	getter_func(connectedTo,"ref:RRoistererTrubaBed");

	getter_func(getSkills,"st:8-10; dx:8-11; iq:8-10; ht:8-12");
	func(getOtherSkills) {
		"healing:3;" 
		+"surgery:1;"
		+"cooking:5;"
		+"farming:5;"
	};

	func(getEquipment)
	{
		objParams_1(_mob);
		private _cloth = ["GreenWorkerCloth",_mob,INV_CLOTH] call createItemInInventory;
		setVar(_cloth,name,"Обноски");
		["WorkerCoolCap",_mob,INV_HEAD] call createItemInInventory;
		private _keyOwn = ["RLordTrubaKey"];
		regKeyInUniform(_cloth,_keyOwn,"Ключ от калитки");
	};
endclass

class(RFistTruba) extends(GMTruba_ScarsRole)
	var(name,"Кулак"); 
	var(desc,"Ты специалист в кулачных боях. Когда в племени устраивали бои за мельтешат" pcomma " ты всегда выигрывал. Но какая теперь разница?
	
	Твой начальник - Владыка. Подчиняйся его приказам и выполняй работу" pcomma " которую требуется выполнить.
	
	Делай нормально" pcomma " и получишь мясо три раза!");
	getter_func(spawnLocation,"pos:RFistTruba");
	getter_func(connectedTo,"ref:RFistTrubaBed");

	getter_func(getSkills,"st:8-10; dx:11-13; iq:7-8; ht:8-12");
	func(getOtherSkills) {
		"fight:5;" 
	};

	func(getEquipment)
	{
		objParams_1(_mob);
		private _cloth = ["ArmyCloth4",_mob,INV_CLOTH] call createItemInInventory;
		setVar(_cloth,name,"Сраные тряпки");
	};
endclass

class(RBatonTruba) extends(GMTruba_ScarsRole)
	var(name,"Дубина"); 
	var(desc,"Ты хорошо управляешься со своей дубиной" pcomma " и от тебя не так сильно воняет говнелином. 
	Но вот беда," pcomma " кажется" pcomma " у тебя больше ничего не получается. Хотя" pcomma " ты всегда можешь поднимать что-то тяжелое руками.
	
	Держись Кулака" pcomma " и выполняй работу" pcomma " которую тебе даёт Владыка" pcomma " и тогда обязательно всё наладится.");
	getter_func(spawnLocation,"pos:RBatonTruba");
	getter_func(connectedTo,"ref:RBatonTrubaBed");

	getter_func(getSkills,"st:8-10; dx:9-11; iq:7-8; ht:8-12");
	func(getOtherSkills) {
		"baton:10;" 
	};

	func(getEquipment)
	{
		objParams_1(_mob);
		private _cloth = ["ArmyCloth6",_mob,INV_CLOTH] call createItemInInventory;
		["Baton",_mob,INV_BELT] call createItemInInventory; // Предмет на поясе
		setVar(_cloth,name,"Лохмотья");
	};
endclass

// ---- Дополнительные роли рубцов ---- //
class(RLazyTruba) extends(GMTruba_ScarsRole)
	var(name,"Хвост"); 
	var(desc,"Владыка сказал" pcomma " что если ты не будешь доставлять проблем и будешь помогать по хозяйству" pcomma " то можешь жить в Рукве.");
	var(count,2);

	func(spawnLocation)
	{
		objParams();
		if(getSelf(count)==1) then{"pos:RLazyTruba1"}
		else{"pos:RLazyTruba2"};
	};

		func(connectedTo)
	{
		objParams();
		if(getSelf(count)==1) then{"ref:RLazyTrubaBed1"}
		else{"ref:RLazyTrubaBed2"};
	};

	getter_func(getSkills,"st:8-9; dx:8-9; iq:6-7; ht:7-8");

	func(getEquipment)
	{
		objParams_1(_mob);
		private _cloth = ["NomadCloth" + str randInt(1,15),_mob,INV_CLOTH] call createItemInInventory;
		setVar(_cloth,name,"Рабочая одежда");
	};
endclass

// ---- Роли жрунов ---- //

class(REaterTruba) extends(RPreyEater)
	var(name,"Жрун");
	var(desc,"Ужасный монстр");
	
	getter_func(getSkills,vec4(randInt(13,16),randInt(10,12),randInt(12,15),randInt(9,11))); //["_st","_iq","_dx","_ht"];
	func(getOtherSkills) {[
		skillrand(fight,5,8) arg
		skillrand(stealth,3,7)
	]};
	var(count,10);
	func(onAssigned)
	{
		objParams_2(_mob,_usr);
		super();
		setVar(_mob,sniffDistance,80);
	};

	func(canVisibleAfterStart)
	{
		objParams_1(_cliObj);
		getVar(gm_currentMode,countDead) >= 6
	};

	getter_func(spawnLocation,"rpos:REaterTruba");
endclass