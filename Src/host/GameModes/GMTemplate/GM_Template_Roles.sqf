// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\GameMode.h>


class(GMTemplate_RAdventurer) extends(BasicRole)
	
	var(name,"Приключенец");
	var(desc,"Он здесь чтобы повеселиться.");

	//можно ли взять эту роль до начала игры
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
	getter_func(spawnLocation,"pos:base");

	//Массив базовых навыков:
	// Сила, Интеллект, Ловкость, Здоровье
	// Разделитель между навыками ;
	// Разделители между навыком, и значением (либо нижним и верхним значением) =-: и пробел
	getter_func(getSkills,"st=9; dx=10-12; iq=12-16; ht=10-12");

	//Массив дополнительных скиллов
	//Названия всех скиллов хранятся в хэш-карте: skills_internal_map_nameAssoc либо в skills_internal_list_otherSkillsSystemNames
	func(getOtherSkills) {
		"fight:1-5; shotgun:1-5; " +
		"stealth:1-5;"
	};

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
	getter_func(spawnLocation,"rpos:latespawn");
	getter_func(useRandomDirOnSpawn,true); //случайное направление от 0 до 360

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