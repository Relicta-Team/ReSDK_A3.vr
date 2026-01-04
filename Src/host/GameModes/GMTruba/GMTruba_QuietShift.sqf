// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\GameMode.h>

editor_attribute("CodeOnyGamemode")
class(GMTruba_QuietShift) extends(GMBase) //GMBase - базовый режим, от которого унаследованы все возможные режимы.
	
    // -----------------------------------------------------------------//
    // ------------------ Базовые настройки режима ---------------------//
    // -----------------------------------------------------------------//

    // Текстовые данные режима GMTruba_QuietShift
	var(name,"Тихая смена в Трубе");
	var(desc,"Город Труба");
	var(descExtended,"Всё закончилось.");

	var(deadThreshold,10);//порог смертности для завершения раунда
	
	var(leaderTruba,nullPtr);
	var(leaderScars,nullPtr);

	// Длительность игры в режиме GMTruba_QuietShift.
	var(duration,t_asMin(120)); // 30 минут
    
    // Имя карты, которая будет создана в режиме GMTruba_QuietShift
	getterconst_func(getMapName,"truba");

    // ------- Настройки для случайности режима -------
    // Настройки случайности используются, когда администратор не установил режим и он выбирается автоматически
    // в зависимости от количества игроков и настроек, указанных ниже.

	//Вероятность режима при случайном выборе
	getterconst_func(getProbability,100);
	//минимальное и максимальное колчиество людей для случайного выбора режима
	getterconst_func(getReqPlayersMin,1);
	getterconst_func(getReqPlayersMax,5);


    // ------- Настройки для лобби -------

	// Путь до композиции, проигрываемой в лобби (в формате .ogg)
	getterconst_func(getLobbySoundName,"lobby\First_Steps.ogg");
	// Путь до изображения заднего фона в лобби (в формате .paa)
	getterconst_func(getLobbyBackground,PATH_PICTURE("lobby\lobby.paa"));

	// Список ролей (имён классов) для режима GMTruba_QuietShift, доступных до старта раунда.
	func(getLobbyRoles)
	{
		[
			// Роли поселения
			"RChief",
			"RChiefSon",
			"RStorekeeper",
			"RKitchener",
			"RKitchenerHelper",
			"RCaveDoctor",
			"RGuard",
			"RFarmerTruba",

			// Доп. роли поселения
			"RGuardHelper",
			"RCaveDoctorHelper",
			"RCleanerTruba",
			"RLighter",

			// Роли Рубцов
			"RLordTruba",
			"RRoistererTruba",
			"RFistTruba",
			"RBatonTruba"
		]
	};

	// Список ролей (имён классов), доступных после начала раунда.
	// Сюда так же добавляются роли из getLobbyRoles, у которых 
	// установлен canVisibleAfterStart в значение true
	func(getLateRoles)
	{
		[
			// Доп. роли поселения
			"RWorkerTruba",
			"RScoutTruba",
			
			// Доп. роли Рубцов
			"RLazyTruba",

			// Жруны
			"REaterTruba"
		]
	};

    // ---- Доп. настройки для GMTruba_QuietShift ----
    getterconst_func(isVotable,true); // Можно ли проголосовать за режим с включенной системой голосования

    // Включает систему аспектов раунда. Пример аспекта: "все двери на станции украли"
    var(canAddAspect,false);

    // Можно ли запускать события "Влияния Реликты"
    getterconst_func(canPlayEvents,true);

    //Минимальное и максимальное время между запусками "Влияния Реликты"
    getter_func(getMinPlayEventTime,t_asMin(30));
	getter_func(getMaxPlayEventTime,t_asMin(50));

	// -----------------------------------------------------------------//
    // ------------------------ События режима -------------------------//
    // -----------------------------------------------------------------//

	// Условие старта раунда.
	// Если код возвращает true то раунд будет запущен
	func(conditionToStart)
	{
		objParams();
        /*
            Как правило здесь описываются условия типа: 
                если на "GMTruba_QuietShift_BasicRole1" встало 2 игрока и на "GMTruba_QuietShift_BasicRole2" встал 1 игрок,
                то раунд можно запускать.
                В лююбых других случаях раунд не стартуер.
            
            Для получения количества игроков, вставших на роли используйте функцию getCandidatesCount

            callSelfParams(getCandidatesCount,"GMTruba_QuietShift_BasicRole") >= 1 
            && callSelfParams(getCandidatesCount,"GMTruba_QuietShift_BasicRole2") >= 1
            
        */
		callSelfParams(getCandidatesCount,"RChief") >= 1
		&& callSelfParams(getCandidatesCount,"RChiefSon") >= 1
		&& callSelfParams(getCandidatesCount,"RStorekeeper") >= 1
		&& callSelfParams(getCandidatesCount,"RKitchener") >= 1
		&& callSelfParams(getCandidatesCount,"RLordTruba") >= 1
	};

	// Возвращает строку причины невозможности запуска режима
	func(onFailReasonToStart)
	{
		objParams();
		if (
			callSelfParams(getCandidatesCount,"RChief") == 0 ||
			callSelfParams(getCandidatesCount,"RChiefSon") == 0 ||
			callSelfParams(getCandidatesCount,"RStorekeeper") == 0 ||
			callSelfParams(getCandidatesCount,"RKitchener") == 0 ||
			callSelfParams(getCandidatesCount,"RLordTruba") == 0
		) exitWith {"Для запуска раунда должен быть Вождь, Сын Вождя, Кладовой, Кухарь и Владыка."};
		"Хуй знает почему не вышло";
		// if (callSelfParams(getCandidatesCount,"GMTruba_QuietShift_BasicRole") == 0) then {"Нужен вождь"} else {"Любая другая причина"};
        // Как правило здесь используются проверки из conditionToStart() 
        // для точного определения причины невозможности старта раунда
	};

	//                          !работает только на сервере!
	// Из этого массива выбирается одно случайное сообщение и показывается при первом пробуждении персонажа
	// Установите getterconst_func(getUnsleepGameInfo,null); если вам не нужен показ этих сообщений
	func(getUnsleepGameInfo)
	{
		objParams();
		null
	};
    // Сколько сообщений будет показано из getUnsleepGameInfo
    getter_func(getUnsleepMessagesCount,1);

	// Вызывается когда режим GMTruba_QuietShift выбран (до старта раунда с загруженной картой)
    func(preSetup)
    {
        objParams();
        //Получаем объект нашего гриба по глобальной ссылке
        private _mref = "HealMushroom" call getObjectByRef;
            //собираем все блевантоны в радиусе 30 метров
            private _list = ["Blevanton",callFunc(_mref,getPos),30,true] call getGameObjectOnPosition;
            {
                private _cur = callFunc(_x,getFilledSpace);
                callFuncParams(_x,removeReagents,_cur);
                callFuncParams(_x,addReagent,"Tamidin" arg _cur);
            } foreach _list;

		["ConvertorForGenerator","onInteractWith",{
			objParams_2(_with,_usr);
			if isTypeOf(_with,Tumannik) then {
				private _fill = callFunc(_with,getFilledSpace);
				callFuncParams(_with,removeReagents,_fill);
				callFuncParams(_with,addReagent,"Ipamitin" arg randInt(1,2));
			};
		},"begin"] call oop_injectToMethod;
    };

	// Вызывается после начала раунда когда все клиенты зашли в игру
	func(postSetup)
	{
		objParams();

		//start generator
		private _gen = "PowerGenerator G:/dJ+UfrEAiE" call getObjectByRef;
		if !isNullReference(_gen) then {
			setVar(_gen,energyleft, 244*60*5); // Энергии осталось на 5 минут
			callFunc(_gen,beginUpdateGenerator);
		};

		{
			private _trubaButton = _x call getObjectByRef;
			callFuncParams(_trubaButton,setEnable,false);
		}foreach[
		"PowerSwitcher G:0vc4AH3Oo4A", 
		"PowerSwitcher G:cinaXUzLPTY", 
		"PowerSwitcher G:ZVqY6L9rsN4"
		]

	};

	// Проверка режима. Выполняется каждую секунду
	// Возвращаемое значение должно быть числом
	// Любое число, не равное 0 означает конец режима
	func(checkFinish)
	{
		objParams();
		if (getSelf(countDead) >= getSelf(deadThreshold)) exitWith {1};
		if (gm_roundDuration >= getSelf(duration)) exitWith {2};
		if (getVar(getSelf(leaderTruba),isDead) && getVar(getSelf(leaderScars),isDead)) exitWith {3};
		0
	};
	
	func(getResultTextOnFinish)
	{
		objParams();

		if (getSelf(finishResult) == 1) exitWith {
			"В эту смену погибло слишком много... Во истину кровавая смена в истории Трубы."
		};

		if (getSelf(finishResult) == 2) exitWith {
			"Смена снова прошла относительно тихо, ничего и не случилось вроде..."
		};

		if (getSelf(finishResult) == 3) exitWith {
			"Вождь и Владыка погибли. В трубе настали тяжёлые времена..."
		};		
		
		"Неизвестная причина."
	};
	
	// Событие при завершении раунда в режиме GMTruba_QuietShift
	func(onFinish)
	{
		objParams();
		
		// Вызываем базовый метод onFinish,
		// определенный в GMBase.
		// Нужен для вывода собщения конца раунда и текста, определенного в getResultTextOnFinish
		super(); 
	};





    // -----------------------------------------------------------------//
    // -------------------- Работа с антагонистами ---------------------//
    // -----------------------------------------------------------------//
    
    /*
        Разница между скрытми и полными антагонистами довольно проста:
        - Полные антагонисты - это игроки, которые заходили за одну роль, но при входе в игру получат совершенно другую роль,
        присущую полному антагонисту. (Прим.: Грязноямск. Человек заходит за барника но появляется как Истязатель.)
        - Скрытые антагонисты - это игроки, которые получают особую цель, находясь на своей роли, за которую они заходили.
    */


    // Минимальное количество полных и скрытых антагонистов для нормальной игры
	getterconst_func(getMinFullAntags,1);
	getterconst_func(getMinHiddenAntags,1);

    // Срабатывает при старте раунда и возвращает строковое имя класса полного антагониста.
    /*
        Функция вызывается для каждого из игроков, зашедших в раунд.
        Переменная _index для первого игрока принимает значение 1, для второго 2 и т.д.

        Если функция возвращает пустую строку - игрок не получает полного антагониста.
        В ином случае его роль при входе в игру заменяется на имя класса, вычисленное логикой функции.

        Внутри этой функции доступны 2 специальных переменных:
            _countInGame - количество игроков, зашедших в раунд
            _countProbFullAntags - сколько людей зашедших в раунд выбрали в лобби "Полных антагонистов"
    */
    func(getAntagRoleFull)
	{
		objParams_2(_usr,_index);
        /*
            Параметры:
                _usr - объект клиента
                _index - порядковый номер проверяемого игрока
        */
        /*
            Самый банальный расчет:
            Если _index <= 2, то роль игрока заменяется на "GMTruba_QuietShift_RoleSuperAntag"
            или роль не заменится (вернет пустую строку)
            
            (_index <= 2) - означает, что в игре может быть до двух антагонистов
            
            if (_index <= 2) then {
                "GMTruba_QuietShift_RoleSuperAntag"
            } else {
                ""
            };
        */
        // Определите тут пользовательский алгоритм распределения полных антагов,
        // если они могут быть в режиме GMTruba_QuietShift
		""
	};

    // Обработчик скрытых антагонистов
    /*
        Функция вызывается для каждого из игроков, зашедших в раунд.
        Переменная _index для первого игрока принимает значение 1, для второго 2 и т.д.

         Внутри этой функции доступны 2 специальных переменных:
            _countInGame - количество игроков, зашедших в раунд
            _countProbHiddenAntags - сколько людей зашедших в раунд выбрали в лобби "Скрытых антагонистов"
    */
    func(handleAntagRoleHidden)
	{
		objParams_3(_usr,_mob,_index);
        /*
            Параметры:
                _usr - объект клиента
                _mob - игровой персонаж
                _index - порядковый номер проверяемого игрока
        */
	};

endclass