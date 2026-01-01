// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\GameMode.h>

editor_attribute("CodeOnyGamemode")
class(GMTemplate) extends(GMBase)
	
	var(name,"Тестовый режим");
	var(desc,"Описание");
	var(descExtended,"Описание в конце игры.");

	// Длительность режима. Обратите внимание, что логика конца режима по времени должна быть обработана вручную
	var(duration,t_asMin(25)); //25 минут

	//Вероятность режима при случайном выборе
	getterconst_func(getProbability,50);
	//минимальное и максимальное колчиество людей для случайного выбора режима
	getterconst_func(getReqPlayersMin,1);
	getterconst_func(getReqPlayersMax,4);

	getterconst_func(isPlayableGamemode,false); //режим не доступен только в симуляции

	//данные режима
	//имя загружаемой карты
	getterconst_func(getMapName,"Template");
	//название лобби музыки
	getterconst_func(getLobbySoundName,"lobby\First_Steps.ogg");
	//бэкграунд лобби
	getterconst_func(getLobbyBackground,PATH_PICTURE("lobby\lobby.paa"));

	//Список ролей (имён классов) для этого режима.
	func(getLobbyRoles)
	{
		[
			"GMTemplate_RAdventurer"
		]
	};
	// Список ролей (имён классов), доступных после начала раунда.
	// Сюда так же добавляются роли из getLobbyRoles, у которых 
	// установлен canVisibleAfterStart в значение true
	func(getLateRoles)
	{
		[
			"GMTemplate_RAdventurerLate"
		]
	};

	//события режима

	//Условие старта раунда
	// Если код возвращает true то раунд будет запущен
	func(conditionToStart)
	{
		objParams();
		private _advRole = "GMTemplate_RAdventurer" call gm_getRoleObject;
		// Количество нажавших "Готов" с этой ролью больше 0
		count getVar(_advRole,contenders_1) > 0
	};

	// Возвращает строку причины невозможности запуска режима
	func(onFailReasonToStart)
	{
		objParams();
		"Нужно чтобы люди встали на роль"
	};

	//работает только на сервере
	//Из этого массива выбирается одно случайное сообщение и показывается при первом пробуждении
	// Установите getterconst_func(getUnsleepGameInfo,null); если вам не нужен показ этих сообщений
	func(getUnsleepGameInfo)
	{
		objParams();
		[
			"Вы добрались в пещеру. Что дальше?",
			"Вот вы и пришли в пещеру. Интересно, что получится найти здесь?"
		]
	};

	//Вызывается когда режим выбран (до старта раунда с загруженной картой)
	func(preSetup)
	{
		objParams();

		//Включаем свет у всех ламп вручную так как они не подключены к источнику энергии
		private _allLights = ["ElectronicDeviceLighting"] call getAllObjectsInWorldTypeOf;
		{
			callFuncParams(_x,lightSetMode,true);
		} foreach _allLights;
	};

	//Вызывается после начала раунда когда все клиенты зашли в игру
	func(postSetup)
	{
		objParams();
	};

	//Проверка режима. Выполняется каждую секунду
	//Возвращаемое значение должно быть числом
	//Любое число, не равное 0 означает конец режима
	func(checkFinish)
	{
		objParams();

		// Обработка конца режима по времени
		if (gm_roundDuration >= getSelf(duration)) exitWith {1};
		
		private _candle = "candle_target" call getObjectByRef;
		private _tableNeed = "table_target" call getObjectByRef;

		if (
			//расстояние от свечи и стола меньше либо равно 2 метрам
			callFunc(_candle,getPos) distance callFunc(_tableNeed,getPos) <= 2
			//и свеча лежит в мире (не в руках у кого-то)
			&& callFunc(_candle,isInWorld)
		) exitwith {2};

		0
	};
	
	func(getResultTextOnFinish)
	{
		objParams();

		if (getSelf(finishResult) == 1) exitWith {
			"Время режима закончилось"
		};
		if (getSelf(finishResult) == 2) exitwith {
			"Свечу принесли на базу"
		};
		
		"Неизвестная причина."
	};
	
	//Событие при завершении раунда
	func(onFinish)
	{
		objParams();
		
		// Вызываем базовый метод onFinish,
		// определенный в GMBase.
		// Нужен для вывода собщения конца раунда и текста, определенного в getResultTextOnFinish
		super(); 
	};
	
endclass