#include <..\GameMode.h>


class(@GAMEMODE_NAME@_BaseRole) extends(BasicRole)
    
     // -----------------------------------------------------------------//
    // -------------------- Базовые настройки роли ---------------------//
    // -----------------------------------------------------------------//
	var(name,"Имя роли");
	var(desc,"Описание роли.");

	// Можно ли взять эту роль до начала игры
	getter_func(canTakeInLobby,true);
	//можно ли взять эту роль после старта, если эта роль 
	getter_func(canVisibleAfterStart,false);
	//Это для того, чтобы не просило сменить лицо и имя при следующих заходах
	getter_func(canStoreNameAndFaceForValidate,false);

	//сколько человек может зайти за эту роль
	var(count,2);
	
	// при true после смерти клиента сразу вернет в лобби вместо возможности зайти в призрака
	var(returnInLobbyAfterDead,true);

	//Указываем позицию и направление при заходе за эту роль
	getter_func(getInitialPos,"base" call getSpawnPosByName);
	getter_func(getInitialDir,"base" call getSpawnDirByName);

	// Массив базовых атрибутов в определенном порядке:
	// Сила, Интеллект, Ловкость, Здоровье
    // Макрос randInt() выбирает случайное целое число между левым и правым аргументом
	getter_func(getSkills,vec4(randInt(13,15),randInt(10,12),randInt(12,16),randInt(10,12)));

	//Список дополнительных навыков
    /*
        В примере ниже перечислены все возможные навыки, доступные на текущий момент.
        Макрос skillrand() принимает 3 значения:
            1 - название навыка
            2 - минимальный возможный уровень навыка
            3 - максимальный возможный уровень навыка
        
        Например:
            skillrand("fight",2,5) - означает, что персона получит навык владения
            рукопашным боем уровня от 2 до 5 (выбирается случайно)
    */
	func(getOtherSkills) {[
		
		skillrand("fight",0,0), //навык рукопашного боя
		skillrand("shield",0,0), //навык владения щитами
		skillrand("fencing",0,0), //навык владения фехтовальным оружием
		skillrand("axe",0,0), //навык владения топорами
		skillrand("baton",0,0), //навык валдения дубиной
		skillrand("spear",0,0), //навык владения копьем
		skillrand("sword",0,0), //навык владения мечами
		skillrand("knife",0,0), //навык владения ножами
		skillrand("whip",0,0), //навык владения кнутами

		skillrand("pistol",0,0), //навык владения пистолетами
		skillrand("rifle",0,0), //навык владения винтовками
		skillrand("shotgun",0,0), //навык владения дробовиками
		skillrand("crossbow",0,0), //навык стрельбы из лука

		skillrand("throw",0,0), //навык метания

		skillrand("chemistry",0,0), //навык работы с химией
		skillrand("alchemy",0,0), //навык работы с пещерной химией

		skillrand("engineering",0,0), //навык строительства
		skillrand("traps",0,0), //навык работы с ловушками
		skillrand("repair",0,0), //навык ремонта
		skillrand("blacksmithing",0,0), //навык кузнецкого ремесла
		skillrand("craft",0,0), //навык создания различных предметов

		skillrand("theft",0,0), //навык воровства
		skillrand("stealth",0,0), //навык скрытности
		skillrand("agility",0,0), //навык акробатики
		skillrand("lockpicking",0,0), //навык взлома

		skillrand("healing",0,0), //навык первой помощи
		skillrand("surgery",0,0), //навык хирургии

		skillrand("cavelore",0,0), //навык знания пещер

		skillrand("cooking",0,0), //навык готовки
		skillrand("farming",0,0) //навык фермерства
	]};

	//Функция в которой персонаж получает свой инвентарь
	func(getEquipment)
	{
		objParams_1(_mob);
		
		//создаем в инвентаре на слоте одежды... одежду
		private _cloth = ["NomadCloth12",_mob,INV_CLOTH] call createItemInInventory;
		setVar(_cloth,name,"Одежда приключенца");
		
		//так как одежда контейнер, то внутри неё тоже можно создавать предметы
		//создадим от 2 до 5 бинтов (рандомно).
		for "_i" from 1 to randInt(2,5) do {
			private _ban = ["Bandage",_cloth] call createItemInContainer;
			//если в одежде не осталось места то вернется nullPtr
			//Через isNullReference делаем проверку создался ли бинт
			if !isNullReference(_ban) then {
				setVar(_ban,name,"Бинтик " + str _i);
			};
		};

		//Создаем оружие на слоте спины
		private _shot = ["Shotgun",_mob,INV_BACK] call createItemInInventory;
		//вызываем метод, создающий патроны в "магазине" дробовика
		callFuncParams(_shot,createAmmoInMagazine,"AmmoShotgun");
	};

	func(onDeadBasic)
	{
		objParams_2(_mob,_usr);

		//Установка таймера призраку (в секундах)
		//работает если returnInLobbyAfterDead возвращает false
		callFuncParams(_usr,setDeadTimeout,30);
	};
	
	func(onAssigned)
	{
		//_mob - персонаж, _usr - клиент
		objParams_2(_mob,_usr);
		
		//тут вызывается код когда клиент уже подключился за эту роль

		//Установим голод в случайном диапазоне от 50 до 70
		callFuncParams(_mob,setHunger,randInt(50,70));
		//Выводим сообщение клиенту
		callFuncParams(_usr,localSay,"Привет " + callFuncParams(_mob,getNameEx,"кому") + "!!!" arg "log");

		private _t = "Задача:" + sbr // sbr - определен в <text.hpp> и имеет значение "<br/>"
			+ "- Найти свечу и принести на стол в центре карты";
		//вызываем метод ShowMessageBox через 3 секунды 
		callFuncAfterParams(_mob,ShowMessageBox,3,"Text" arg _t);
	};
	
endclass

class(GMTemplate_RAdventurerLate) extends(GMTemplate_RAdventurer)
	
	var(name,"Опоздавший приключенец");
	var(desc,"Немного не успел");

	getter_func(canVisibleAfterStart,true);

	//Одна из добавленных точек с названием latespawn
	getter_func(getInitialPos,"latespawn" call getRandomSpawnPosByName);
	getter_func(getInitialDir,random 360); //случайное направление от 0 до 360

	var(count,5);

	func(getEquipment)
	{
		objParams_1(_mob);
		
		//вызываем базовый метод, определенный в GMTemplate_RAdventurer
		super();

		//Создаем факел в руках персонажа. 
			//Сначала проверяет в активной руке
			//Если она занята, то вторую руку. 
			//Если и она занята то спавнит предмет под персонажем
		["Torch",_mob] call createItemInInventory;
	};

endclass