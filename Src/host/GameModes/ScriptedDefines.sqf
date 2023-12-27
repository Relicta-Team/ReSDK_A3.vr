// ======================================================
// Copyright (c) 2017-2023 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <GameMode.h>

class(ScriptedGamemode) extends(GMBase)
	
	"
		name:Пользовательский режим
		desc:Базовый игровой режим от котрого создаются пользовательские режимы
		path:Игровая логика.Режим
	"
	node_class
	
	"
		name:Название режима
		desc:Название режима, показываемое в конце раунда и при выборе администратором
		prop:get
		classprop:1
		defval:Режим
	" node_var
	var(name,"Режим");

	"
		name:Внутреннее описание режима
		desc:Внутреннее описание режима
		prop:get
		classprop:1
		defval:Описание
	" node_var
	var(desc,"Описание");

	"
		name:Описание режима
		desc:Описание режима, показываемое в конце раунда
		classprop:1
	" node_var
	var(descExtended,"");

	"
		name:Использовать аспекты
		desc:Указывает, будет ли работать система аспектов для этого режима
		prop:get
		classprop:1
		defval:true
	" node_var
	var(canAddAspect,true);

	"
		name:Длительность режима
		desc:Длительность режима в секундах.
		classprop:1
		defval:3600
	" node_var
	var(duration,60*60);

	"
		name:Получить тип полного антагониста
		namelib:Обработчик полных антагонистов
		desc:Возвращает строковое название класса полного (уникального) антагониста, которое переопределит роль зашедшего игрока. Срабатывает при старте раунда для игроков, которые выбрали полных или любых антагонистов и чьи роли могут стать полными антагонистами.\n"+
		"
		code:func(@thisName) { @thisParams; @genvar.out.4 = _countInGame; @genvar.out.5 = _countProbFullAntags; @out.1 };
		return:string:Название класса полного антагониста. Если возвращается пустая строка - значит игрок не станет антагонистом и его роль не переопределится.
		type:event
		out:ServerClient^:Клиент:Объект проверяемого клиента, зашедший в игру на старте раунда.
			opt:mul=1
		out:int:Номер клиента:Порядковый номер проверяемого клиента. Отсчет ведется с 1. Для первого клиента это значение будет 1, для второго - 2 и т.д.
		out:int:Всего игроков:Отражает количество игроков, зашедших в игру на старте раунда. Данное число удобно, когда нам нужно определить антагониста от процентного соотношения всех игроков.
		out:int:Полных антагонистов:Отражает количество игроков, которые выбрали полных антагонистов. Если никто не выбрал полных антагонистов - на полных антагонистов будут проверены все, исключая игроков, чьи роли не могут быть полными антагонистами.
	" node_met
	func(getAntagRoleFull)
	{
		objParams_2(_client,_index);
		""
	};

	"
		name:Получить тип скрытого антагониста
		namelib:Обработчик скрытых антагонистов
		desc:Возвращает строковое название класса скрытого антагониста, которое переопределит роль зашедшего игрока. "+
			"Срабатывает при старте раунда, когда все игроки распределены по ролям и загрузились в игру.
		code:func(@thisName) { @thisParams; @genvar.out.4 = _countInGame; @genvar.out.5 = _countProbHiddenAntags; @out.1};
		return:string:Название класса скрытого антагониста. Если возвращается пустая строка - значит игрок не станет скрытым антагонистом и его роль не переопределится.
		type:event
		out:ServerClient^:Клиент:Объект проверяемого клиента, зашедший в игру на старте раунда.
			opt:mul=1
		out:int:Номер клиента:Порядковый номер проверяемого клиента. Отсчет ведется с 1. Для первого клиента это значение будет 1, для второго - 2 и т.д.
		out:int:Всего игроков:Отражает количество игроков, зашедших в игру на старте раунда. Данное число удобно, когда нам нужно вычислить антагониста от процентного соотношения всех игроков.
		out:int:Скрытых антагонистов:Отражает количество игроков, которые выбрали скрытых антагонистов. Если никто не выбрал скрытых антагонистов - на скрытых антагонистов будут проверены все, исключая игроков, чьи роли не могут быть скрытыми антагонистами.
	" node_met
	func(handleAntagRoleHidden)
	{
		objParams_3(_client,_mob,_index);
	};

	"
		name:Результат конца раунда
		namelib:Получить результат конца раунда
		desc:Результат конца раунда это число, которое отражает исход раунда. Обычно положительные числа являются положительным исходом, а отрицательные - негативным.\n"+
		"Любое значение, отличное от 0 немедленно завершит раунд.
		prop:get
	" node_var
	var(finishResult,0);

	"
		name:При выборе режима
		namelib:Событие при выборе режима
		desc:Данное событие вызывается когда режим был выбран. На этом этапе карта загрузилась, но режим ещё не стартовал.
		type:event
	" node_met
	func(preSetup)
	{
		objParams();
	};

	"
		name:При начале раунда
		namelib:Событие при начале раунда
		desc:Данное событие вызывается когда раунд начался и все готовые игроки зашли в игру.
		type:event
	" node_met
	func(postSetup)
	{
		objParams();
	};

	"
		name:Проверка конца раунда
		namelib:Обработка конца раунда
		desc:Данное событие срабатывает раз в секунду после начала раунда. Чтобы завершить раунд с нужным исходом, используйте узел 'Получить результат конца раунда'.\n"+
		"Для установки нужного конца раунда используйте узел 'Установить результат конца раунда'.
		type:event
		code:func(@thisName) {@thisParams; @out.1; getSelf(finishResult)};
	" node_met
	func(checkFinish)
	{
		objParams();
		0
	};

	"
		name:Установить результат конца раунда
		namelib:Завершить раунд
		desc:Устанавливает результат конца раунда. Любое число, отличное от 0 является концом раунда. Соответственно 0 означает, что раунд будет продолжаться\n"+
		"Если результат уже установлен, то эта функция перезапишет его.
		in:int:Результат:Результат конца раунда
		lockoverride:1
	" node_met
	func(setFinishResult)
	{
		objParams_1(_index);
		setSelf(finishResult,_index);
	};

	"
		name:При завершении раунда
		namelib:Событие при завершении раунда
		desc:Данное событие срабатывает когда раунд завершается. Для вызова логики рестарта раунда и вывода сообщений со статистикой используйте узел 'Вызов базового метода'
		type:event
	" node_met
	func(onFinish)
	{
		objParams();
		super();
	};

	"
		name:Имя карты
		namelib:Получить имя карты
		desc:Отвечает за имя загружаемой в режим карты. Если это пустая строка, то карта не будет загружена
		type:const
		return:string:Название карты (без расширения)
		defval:Minimap
	" node_met
	getterconst_func(getMapName,"Minimap");

	"
		name:Лобби-тема
		namelib:Получить путь до музыки в лобби
		desc:Отвечает за музыку, которая играет в лобби у всех игроков. Если это пустая строка, то лобби-тема не будет загружена.
		type:const
		defcode:func(@thisName) {@propvalue};
		return:string:Путь до лобби-темы
		defval:lobby\First_Steps.ogg
	" node_met
	//имя лобби звука
	getterconst_func(getLobbySoundName,"lobby\First_Steps.ogg");

	"
		name:Лобби-бэкграунд
		namelib:Получить путь до бэкграунда лобби
		desc:Отвечает за задний фон, отображаемый в лобби для данного режима. Фоны распологаются в папке 'ReSDK\\Resources\\ui\\lobby'
		type:const
		defcode:func(@thisName) {PATH_PICTURE(@propvalue)};
		return:string:Путь до лобби-темы
		defval:lobby\lobby.paa
	" node_met
	getterconst_func(getLobbyBackground,PATH_PICTURE("lobby\lobby.paa"));

	"
		name:Условие запуска раунда
		namelib:Условие запуска раунда
		desc:Данное условие выполняется когда таймер истек. Оно нужно например для проверки были ли заняты определенные роли. "+
		"По умолчанию если нет никаких проверок раунд будет сразу запущен. Для установки запрета на старт используйте узел 'Запрет запуска раунда'.
		code:func(@thisName) {@thisParams; @out.1; getSelf(__canStartRound)};
		type:event
	" node_met
	func(conditionToStart)
	{
		objParams();
		getSelf(__canStartRound);
	};
	
	"
		name:Запрет запуска раунда
		namelib:Запрет запуска раунда
		desc:Сообщает, что раунд нельзя запустить по указанной причине.
		type:method
		in:string:Причина:Описание причины невозможности запуска раунда
		lockoverride:1
	" node_met
	func(setCannotStartRoundReason)
	{
		objParams_1(_reason);
		setSelf(__canStartRound,false);
		setSelf(__cannotStartReason,_reason);
	};

	"
		name:В каждую секунду
		namelib:Вызвать раз в секунду
		desc:Вызывает функцию раз в секунду после начала раунда и работает пока раунд не завершится.
		type:event
	" node_met
	func(onTick)
	{
		objParams();
	};

	"
		name:Этот режим игровой
		namelib:Явяется ли режим игровым
		desc:Проверка является ли режим игровым. По умочанию истина. Если выключить этот флаг, то режим будет доступен только в редакторе.
		type:const
		return:bool:Истина, если режим игровый
		defval:true
	" node_met
	getterconst_func(isPlayableGamemode,true);

	func(getCandidatesCount)
	{
		objParams_1(_roleName);
		super();
	};

	region(backend code)

		func(onRoundCode)
		{
			super();
			callSelf(onTick);
		};

		var(__canStartRound,true);
		var(__cannotStartReason,"");

		func(onFailReasonToStart)
		{
			objParams();
			setSelf(__canStartRound,true);
			if equals(getSelf(__cannotStartReason),"") exitWith {
				"Раунд не запущен."
			};
			getSelf(__cannotStartReason);
		};

		//В эти списки добавляются доступные роли
		var(__roles_lobby,[]);
		var(__roles_late,[]);
		var(__initialized_roles_lobby,false);
		var(__initialized_roles_late,false);

		func(getLobbyRoles)
		{
			objParams();
			if !getSelf(__initialized_roles_lobby) then {

			};
			array_copy(getSelf(__roles_lobby));
		};

		func(getLateRoles)
		{
			objParams();
			array_copy(getSelf(__roles_late));
		};

	endregion
endclass


class(ScriptedRole) extends(BasicRole)

	"
		name:Пользовательская роль
		desc:Базовая игровая роль, от которой создаются пользовательские роли.
		path:Игровая логика.Роли
	"
	node_class

	"
		name:Доступна в режимах
		namelib:Доступ роли на режимы
		desc:Отвечает за имя загружаемой в режим карты. Если это пустая строка, то карта не будет загружена
		prop:none
		classprop:1
		return:array[string]:Список режимов, в которых доступна данная роль
	" node_var
	var(__allowedToGamemodes,[]);

endclass