// ======================================================
// Copyright (c) 2017-2023 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <GameMode.h>

class(ScriptedGamemode) extends(GMBase)
	
	"
		name:Пользовательский режим
		desc:Базовый игровой режим от котрого создаются пользовательские режимы
		path:Игровая логика.Режимы
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
		code:func(@thisName) { @thisParams;@genvar.out.4.internal(_countInGame)@genvar.out.5.internal(_countProbFullAntags) @out.1 };
		return:string:Название класса полного антагониста. Если возвращается пустая строка - значит игрок не станет антагонистом и его роль не переопределится.
		type:event
		out:ServerClient^:Клиент:Объект проверяемого клиента, зашедший в игру на старте раунда.
			opt:mul=1
		out:int:Номер клиента:Порядковый номер проверяемого клиента. Отсчет ведется с 1. Для первого клиента это значение будет 1, для второго - 2 и т.д.
		out:int:Всего игроков:Отражает количество игроков, зашедших в игру на старте раунда. Данное число удобно, когда нам нужно определить антагониста от процентного соотношения всех игроков.
			opt:gen_param=0
		out:int:Полных антагонистов:Отражает количество игроков, которые выбрали полных антагонистов. Если никто не выбрал полных антагонистов - на полных антагонистов будут проверены все, исключая игроков, чьи роли не могут быть полными антагонистами.
			opt:gen_param=0
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
		code:func(@thisName) { @thisParams;@genvar.out.4.internal(_countInGame)@genvar.out.5.internal(_countProbHiddenAntags); @out.1};
		return:string:Название класса скрытого антагониста. Если возвращается пустая строка - значит игрок не станет скрытым антагонистом и его роль не переопределится.
		type:event
		out:ServerClient^:Клиент:Объект проверяемого клиента, зашедший в игру на старте раунда.
			opt:mul=1
		out:int:Номер клиента:Порядковый номер проверяемого клиента. Отсчет ведется с 1. Для первого клиента это значение будет 1, для второго - 2 и т.д.
		out:int:Всего игроков:Отражает количество игроков, зашедших в игру на старте раунда. Данное число удобно, когда нам нужно вычислить антагониста от процентного соотношения всех игроков.
			opt:gen_param=0
		out:int:Скрытых антагонистов:Отражает количество игроков, которые выбрали скрытых антагонистов. Если никто не выбрал скрытых антагонистов - на скрытых антагонистов будут проверены все, исключая игроков, чьи роли не могут быть скрытыми антагонистами.
			opt:gen_param=0
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
		//TODO возврат структуры bool,string
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

	"
		name:Кандидаты на роль
		namelib:Получить количество кандидатов на роль
		desc:Возвращает количество клиентов, которые выбрали указанную роль. Функция предназначена для подсчета игроков, занявших указанную роль до начала раунда.
		type:method
		lockoverride:1
		in:classname:Роль:Название роли
		return:int:Количество кандидатов, занявших эту роль.
	" node_met
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
				private _robj = 0;
				private _curClass = tolower callSelf(getClassName);
				private _refLobbyList = getSelf(__roles_lobby);
				{
					_robj = _x call gm_getRoleObject;
					if !isNullReference(_robj) then {
						if isImplementFunc(_robj,__allowedToGamemodes) then {
							private _gmlist = callFunc(_robj,__allowedToGamemodes);
							if (array_count(_gmlist) > 0) then {
								_gmlist = _gmlist apply {tolower _x};
								if (_curClass in _gmlist) then {
									_refLobbyList pushBackUnique _x;
								};
							};
						};
					};
				} foreach getAllObjectsTypeOf(BasicRole);

				setSelf(__initialized_roles_lobby,true);
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

class(ReNode_AbstractEnum) extends(object)
	"
		name:Абстрактное перечисление
		desc:Абстрактный тип для работы перечислений
		path:Системные объекты
	" node_class
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
		type:const
		return:array[classname]:Список названий режимов, в которых доступна данная роль
	" node_met
	getterconst_func(__allowedToGamemodes,[]);

	"
		name:Имя роли
		desc:Отображаемое имя роли.
		prop:get
		classprop:1
		return:string:Имя роли
	" node_var
	var(name,"");
	"
		name:Описание роли
		desc:Описание роли для лобби.
		prop:get
		classprop:1
		return:string:Описание роли
	" node_var
	var(desc,"");
	"
		name:Игровое описание роли
		namelib:Описание роли в игре
		desc:Описание роли для игры. Если не определено то для игру будет взято описание из ""Описание роли"".
		prop:get
		classprop:1
		return:string:Описание роли для игры
	" node_var
	var(descInGame,null); //shown after client start in role. if null - copy from desc, empty string - no shown

	//Классы объектов персонажей выдаваемых при спавне
	var(classMan,"Mob");
	var(classWoman,"MobWoman");
	
	"
		name:Ключевая роль
		desc:Внутрення информация о ключевой роли. Ключевые роли не могут быть полными или скрытыми антагонистами.
		type:const
		return:bool:Является ли эта роль ключевой.
		defval:false
	" node_met
	getter_func(isMainRole,false); //ключевые роли управляют условием начала старта. Так же они заносятся в 

	"
		name:В лобби после смерти
		namelib:Возврат в лобби после смерти
		desc:Опция отвечает за автоматический возврат в лобби после смерти персонажа. Если она включена - возвращает игрока в лобби сразу после смерти, иначе позволяет покинуть тело и в роли призрака наблюдать за остальными.
		prop:get
		return:bool:Нужно ли вернуть владельца роли в лобби после смерти
		defval:true
	" node_met
	//после смерти сразу возвращает в лобби. должно быть выключено
	var(returnInLobbyAfterDead,false);
	
	"
		name:Требование смены лица
		desc:Требование смены лица при смерти. Если включено (ИСТИНА), то после смерти при попытке зайти за новую роль с предыдущим лицом и именем игрока не пустит в игру. "+
		"Чаще всего для ролей монстров включено, а для обычных людей выключено.
		type:const
		return:bool:Требовать смену лица и имени при заходе за новую роль после смерти за предыдущего персонажа.
		defval:true
	" node_met
	getter_func(canStoreNameAndFaceForValidate,true);

	"
		name:Количество заходов
		namelib:Количество заходов за роль
		desc:Это число отвечает за количество возможных заходов за роль. Когда каждый игрок заходит за эту роль, то количество уменьшается на 1.
		prop:get
		return:int:Количество заходов
		defval:1
	" node_var
	var(count,1);

	/*
		строка имеет разделитель между навыками:	;
		между именем навыка и значением:	=-: и пробел
			Пример определения двух навыков
			"st:3;dx:5"
			"st=3;dx:5"
			"ST:3-5; Dx=5"
			"st=3-5; DX = 5-6"

		Стандартизированный вид:
			разделитель навыков:	;
			разделитель названия навыка и значения:	=
			разделитель минимального и максимального значения навыка:	-
	*/
	"
		name:Базовые атрибуты
		desc:Определение диапазона четырех базовых атрибутов.
		prop:get
		classprop:1
		return:struct.BaseSkillsDef:Базовые атрибуты
		defval:[[10,10],[10,10],[10,10],[10,10]]
	" node_var
	var(_currentBaseSkills,vec4(vec2(10,10),vec2(10,10),vec2(10,10),vec2(10,10)));
	"
		name:Определение базовых атрибутов
		namelib:Событие определения базовых атрибутов
		desc:Данное событие позволяет переопределить логику получения базовых атрибутов для роли.
		type:event
		return:struct.BaseSkillsDef:Базовые атрибуты
	" node_met
	func(_getSkillsWrapper)
	{
		objParams();
		getSelf(_currentGetSkills);
	};

	func(getSkills)
	{
		objParams();
		private _vec4Base = callSelf(_getSkillsWrapper);
		private _fmtError = format["Class %1 (%2)",callSelf(getClassname),getSelf(name)];
		private _sb = [];
		{
			(_vec4Base select _foreachIndex) params ["_min","_max"];
			assert_str(_min <= _max,format["Skill '%1' error - min > max; %2" arg  _x arg _f]);
			assert_str(_min <= 0,format["Minimum value for skill '%1' must be > 0; %2" arg _x arg _f]);
			assert_str(_max <= 0,format["Maximum value for skill '%1' must be > 0; %2" arg _x arg _f]);
			
			_sb pushBack [_x + "=" + ifcheck(_min == _max,str _min,(_vec4Base select _foreachIndex) joinString "-")];
		} foreach ["st","iq","dx","ht"];
		
		_sb joinString ";"
	};

	//настройки дополнительных навыков определяются так же как и в getSkills при использовании через строку
	//список всех навыков в skills_internal_list_otherSkillsSystemNames
	
	"
		name:Навыки
		desc:Определение дополнительных навыков.
		prop:get
		classprop:1
		return:array[struct.SkillDef]:Базовые атрибуты
		defval:[]
	" node_var
	var(_currentOtherSkills,[]);

	"
		name:Навыки
		namelib:Событие определения навыков
		desc:Данное событие позволяет переопределить логику получения дополнительных навыков для роли.
		type:event
		return:array[struct.SkillDef]:Массив навыков
	" node_met
	func(_getOtherSkillsWrapper)
	{
		objParams();
		getSelf(_currentOtherSkills);
	};
	
	func(getOtherSkills)
	{
		objParams();
		private _oskills = callFunc(_getOtherSkillsWrapper);
		private _ret = [];
		private _minIndex = skills_nodes_allowedMinSkillDefIndex;
		private _skDataList = skills_nodes_listKinds;//list(vec2(string,string))
		private _existsSkills = [];
		{
			_x params ['_skIndex',"_skRange"];
			
			assert_str(!array_exists(_existsSkills,_skIndex),"Duplicate skill: " + ((_skDataList select _skIndex) joinString " - "));
			assert_str(_skIndex < _minIndex,"Unsupported skill: " + ((_skDataList select _skIndex) joinString " - "));

			_ret pushBack [(_skDataList select _skIndex) select 0,_skRange];
			_existsSkills pushBack _skIndex;
		} foreach _oskills;
		_ret;
	};


	"
		name:Видимость роли после старта
		desc:Будет ли видна эта роль в списке ролей после старта. С помощью входного параметра ""Клиент"" можно настроить ограничения для конкретных клиентов.
		type:event
		out:ServerClient^:Клиент:Объект клиента, который запрашивает видимость роли.
		return:bool:Видимость роли после старта
	" node_met
	func(canVisibleAfterStart)
	{
		objParams_1(_cliObj);
		true
	};

	//Можно ли взять роль в лобби. Второй параметр означает будет ли выводиться сообщение в вызываемом контексте
	"
		name:Видимость роли в лобби
		desc:Будет ли видна эта роль в списке ролей до старта раунда из лобби. С помощью входного параметра ""Клиент"" можно настроить ограничения для конкретных клиентов.
		type:event
		out:ServerClient^:Клиент:Объект клиента, который запрашивает видимость роли.
		out:bool:Вывод ошибок:Этот параметр принимает значение ИСТИНА, когда запрос осуществляется с возможностью вывода ошибки. Например, если настроить ограничение на пол для роли, то при включенном флаге можно отправить клиенту сообщение о том, что пол его персонажа не подходит.
		return:bool:Видимость роли в лобби
	" node_met
	func(canTakeInLobby)
	{
		objParams_2(_cliObj,_canPrintErrors);
		true
	};

	"
		name:Нужные роли дискорда
		desc:Список названий ролей из [discord.relicta.ru дискорда], которые необходимы клиенту для возможности взятия этой роли. Если список пуст - роль могут взять все. Если указано несколько ролей, то клиенту требуется хотя бы одна роль из этого списка.
		type:const
		return:array[string]:Список ролей дискорда
		defval=[]
	" node_met
	getter_func(needDiscordRoles,[]);

	//TODO access enum
	getter_func(roleAccess,[]);

	"
		name:Полный антагонист
		namelib:Может быть полным антагонистом
		desc:Отвечает за то, может ли клиент, взявший эту роль быть полным антагонистом. Эта проверка всегда включает внешнюю проверку на ключевую роль. "+
		"Полным антагонистам выполняется замена роли, а выбор этих ролей происходит в логике игрового режима.
		type:event
		out:ServerClient^:Клиент:Объект клиента, который проверяется на полного антагониста
		return:bool:Полный антагонист
	" node_met
	func(canBeFullAntag)
	{
		objParams_1(_client);
		true
	};

	"
		name:Скрытый антагонист
		namelib:Может быть скрытым антагонистом
		desc:Отвечает за то, может ли клиент, взявший эту роль быть скрытым антагонистом. Эта проверка всегда включает внешнюю проверку на ключевую роль. "+
		"Скрытые антагонисты получают свои особые задачи без смены роли, в отличии от полных антагонистов. Выбор таких ролей происходит в логике игрового режима.
		type:event
		out:ServerClient^:Клиент:Объект клиента, который проверяется на скрытого антагониста
		return:bool:Скрытый антагонист
	" node_met
	func(canBeHiddenAntag)
	{
		objParams_1(_client);
		true
	};

	//safe copy mobs
	"
		name:Базовые владельцы роли
		desc:Возвращает список сущностей мобов, игроки которых зашли за эту роль.
		type:method
		exec:pure
		lockoverride:1
		return:array[BasicMob^]:Список мобов, зашедших за эту роль
	" node_met
	getter_func(getBasicMobs,array_copy(getSelf(basicMobs)));
	
	"
		name:Владельцы роли
		desc:Возвращает список сущностей мобов, которые владеют этой ролью в данный момент. От базовых владельцев этот список может отличаться, так как некоторые персонажи во время игры могут быть назначены на другие роли.
		type:method
		exec:pure
		lockoverride:1
		return:array[BasicMob^]:Список мобов, владеющих этой ролью
	" node_met
	getter_func(getMobs,array_copy(getSelf(mobs)));
	
	"
		name:Позиция появления
		namelib:Событие точки появления роли
		desc:Позиция появления роли (спавна персонажа). Может быть точкой спавна или рандомной точкой спавна.
		type:event
		return:struct.SpawnPoint:Точка спавна:Рандомная или конечная точка спавна, на которой появится персонаж при заходе за эту роль.
	" node_met
	func(_spawnLocationWrapper)
	{
		objParams();
		getSelf(_currentSpawnLocation)
	};

	func(spawnLocation)
	{
		objParams();
		private _slocStruct = callSelf(_spawnLocationWrapper);
		assert_str(!isNullVar(_slocStruct),"Null return spawn location");
		assert_str(_slocStruct select 1 != "","Empty string point name");
		
		_slocStruct params ["_spType","_spName"];

		(["pos","rpos"] select _spType)+":"+_spName
	};

	"
		name:Точка спавна
		desc:Позиция спавна персонажа. Можно настроить кастомную логику выбора точки спавна с помощью события точки появления.
		prop:get
		classprop:1
		return:struct.SpawnPoint:Точка спавна
		defval:[0,'']
	" node_var
	var(_currentSpawnLocation,[0 arg ""]);

	"
		name:Случайное направление спавна
		desc:Указывает будет ли включено случайное направление при спавне персонажа. ИСТИНА - персонаж будет появляться на точке всегда со случайным направлением. ЛОЖЬ - направление при появлении будет учитываться из направления точки спавна.
		type:const
		return:bool:Истина, если нужно использовать случайное направление при спавне.
		defval:false
	" node_met
	getter_func(useRandomDirOnSpawn,false);

	// --------- connection object --------

	"
		name:Точка привязки
		desc:Позиция спавна персонажа. Можно настроить кастомную логику выбора точки спавна с помощью события точки появления.
		prop:get
		classprop:1
		return:struct.SpawnLocationConnection:Точка привязки рядом с позицией спавна
		defval:[0,'','GameObject',-1]
	" node_var
	var(_currentConnectedTo,[0 arg "" arg "GameObject" arg -1]);

	"
		name:Точка привязки
		namelib:Событие точки привязки
		desc:Событие для настройки расширенной логики определения точки привязки.
		type:event
		return:struct.SpawnLocationConnection:Точка привязки:Искомый объект привязки.
	" node_met
	func(_connectedToWrapper)
	{
		objParams();
		getSelf(_currentConnectedTo);
	};
	func(connectedTo)
	{
		objParams();
		private _conStruct = callSelf(_connectedToWrapper);
		_conStruct params ["_ctype","_ref","_type","_optDist"];
		if equals(_ctype,2) exitWith {null}; //do not connect to 
		private _retString = ifcheck(_ctype==0,"ref:"+_ref,"type:"+_type);
		if (_optDist >= 0) then {_retString = format["%1:%2",_retString,_optDist]};
		_retString
	};
	//-------------------------------------------------

	"
		name:Выдача снаряжения
		namelib:Событие выдачи снаряжения
		desc:Событие, которое вызывается единожды при заходе клиента за роль. Используйте его для реализации выдачи снаряжения персонажу.
		type:event
		out:BasicMob^:Моб:Объект моба, которому будет выдано снаряжение
	" node_met
	func(getEquipment)
	{
		objParams_1(_mob);
	};
	
	"
		name:При назначении
		namelib:Событие при назначении за роль
		desc:Событие, которое вызывается единожды при заходе клиента за роль. Оно вызывается когда клиент уже подключился к сущности и получил экипировку (если таковая создавалась).
		type:event
		out:BasicMob^:Моб:Объект моба, для которого вызывалось данное событие.
		out:ServerClient^:Клиент:Объект клиента (владельца моба), для которого вызвалось данное событие.
		out:bool:Позднее назначение:Этот порт отвечает за позднее назначение (после старта раунда). Когда возвращает ИСТИНУ - клиент зашёл на старте раунда, а когда ЛОЖЬ - уже после старта раунда.
	" node_met
	func(onAssigned_impl)
	{
		objParams_3(_mob,_usr,_lateAssign);
	};
	
		func(onAssigned)
		{
			objParams_2(_mob,_usr);
			private _lateAssign = callSelf(isLateAssigned);
			callSelfParams(onAssigned_impl,_mob arg _usr arg _lateAssign);
		};

	// "
	// 	name:Выдача награды
	// 	namelib:Выдача награды (НЕ РЕАЛИЗОВАН)
	// 	desc:Эта функция предназначена для выдачи очков или штрафов за выполнение определенной игровой логики режима или роли.
	// 	type:method
	// 	lockoverride:1
	// " node_met
	// func(addPoints)
	// {
	// 	objParams_3(_mob,_usr,_pts);
	// 	super();
	// };

	"
		name:При смерти
		namelib:Событие при смерти на роли
		desc:Вызывается когда персонаж умирает, будучи назначенным на эту роль. Клиент мог зайти за другую роль и быть назначенным на другую роль, для которой и вызовется данное событие.
		type:event
		out:BasicMob^:Моб:Объект моба, для которого вызывалось данное событие.
		out:ServerClient^:Клиент:Объект клиента (владельца моба), для которого вызвалось данное событие. Может быть null ссылкой, если моб умер, когда за него не играл клиент.
	" node_met
	func(onDead)
	{
		objParams_2(_mob,_usr);
	};

	"
		name:При смерти за роль
		namelib:Событие при смерти за роль
		desc:Вызывается когда персонаж заходил за эту роль и умер. Событие вызывается для той роли, за которую клиент заходил из лобби или за роль полного антагониста, если он его получил.
		type:event
		out:BasicMob^:Моб:Объект моба, для которого вызывалось данное событие.
		out:ServerClient^:Клиент:Объект клиента (владельца моба), для которого вызвалось данное событие. Может быть null ссылкой, если моб умер, когда за него не играл клиент.
	" node_met
	func(onDeadBasic)
	{
		objParams_2(_mob,_usr);
	};

	//вызывается при конце игры за текущую роль (если человек выжил за нее)
	//В большинстве случаев используется onEndgameBasic
	//! Внимание ! При модификации очков клиента второй параметр _onlyOnGame должен быть ТОЛЬКО false ServerCleint::addPoints()
	//! Так как данные методы вызываются когда стейт игры уже изменился на GAME_STATE_END
	"
		name:При конце раунда
		namelib:Событие при конце раунда на роли
		desc:Вызывается для персонажа, который имеет эту роль в данный момент в момент конца раунда. Событие вызывается только для мобов, за которых играют клиенты в момент завершения раунда.
		type:event
		out:BasicMob^:Моб:Объект моба, для которого вызывалось данное событие.
		out:ServerClient^:Клиент:Объект клиента (владельца моба), для которого вызвалось данное событие.
	" node_met
	func(onEndgame)
	{
		objParams_2(_mob,_usr);
	};

	"
		name:При конце раунда за роль
		namelib:Событие при конце раунда за роль
		desc:Вызывается когда персонаж заходил за эту роль и выжил до конца раунда на ней. Событие вызывается для той роли, за которую клиент заходил из лобби или за роль полного антагониста, если он его получил.
		type:event
		out:BasicMob^:Моб:Объект моба, для которого вызывалось данное событие.
		out:ServerClient^:Клиент:Объект клиента (владельца моба), для которого вызвалось данное событие.
	" node_met
	func(onEndgameBasic)
	{
		objParams_2(_mob,_usr);
	};

endclass