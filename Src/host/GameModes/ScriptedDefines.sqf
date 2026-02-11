// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <GameMode.h>

editor_attribute("InterfaceClass")
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
		desc:Возвращает @[classname класс] полного (уникального) антагониста, которое переопределит роль зашедшего игрока. Срабатывает при старте раунда для игроков, которые выбрали полных или любых антагонистов и чьи роли могут стать полными антагонистами.\n"+
		"
		code:func(@thisName) { @thisParams;@genvar.out.5.internal(_countInGame)@genvar.out.6.internal(_countProbFullAntags) @out.1 };
		return:classname:Название класса полного антагониста.
		type:event
		out:ServerClient^:Клиент:Объект проверяемого клиента, зашедший в игру на старте раунда.
			opt:mul=1
		out:int:Номер клиента:Порядковый номер проверяемого клиента. Отсчет ведется с 1. Для первого клиента это значение будет 1, для второго - 2 и т.д.
		out:classname:Текущая роль:Имя класса роли, с которой проверяется данный клиент. Верните это значение для ролей игроков, которые не должны стать антагонистами.
		out:int:Всего игроков:Отражает количество игроков, зашедших в игру на старте раунда. Данное число удобно, когда нам нужно определить антагониста от процентного соотношения всех игроков.
			opt:gen_param=0
		out:int:Полных антагонистов:Отражает количество игроков, которые выбрали полных антагонистов. Если никто не выбрал полных антагонистов - на полных антагонистов будут проверены все, исключая игроков, чьи роли не могут быть полными антагонистами.
			opt:gen_param=0
	" node_met
	func(_getAntagRoleFullWrapper)
	{
		objParams_3(_client,_index,_curRole);
		_curRole
	};
	func(getAntagRoleFull)
	{
		objParams_2(_client,_index);
		private _curRoleName = callFunc(_struct select 1,getClassName);
		private _result = callSelfParams(_getAntagRoleFullWrapper,_client arg _index arg _curRoleName);
		if (isNullVar(_result) || {_result == ""}) exitWith {""};
		if equals(_result,_curRoleName) exitWith {""};
		assert_str(isTypeNameOf(_result,ScriptedRole),"Роль должна быть унаследована от скриптовой пользовательской роли");
		_result
	};

	"
		name:Обработчик скрытых антагонистов
		namelib:Обработчик скрытых антагонистов
		desc:Обработчик скрытых антагонистов (персонажей, которые получают задачи оставаясь на своей роли).\n"+
			"Срабатывает при старте раунда, когда все игроки распределены по ролям и загрузились в игру. "+
		"В этом обработчике вы самостоятельно решаете кто станет скрытым антагонистом и как вы будете их хранить.
		code:func(@thisName) { @thisParams;@genvar.out.5.internal(_countInGame)@genvar.out.6.internal(_countProbHiddenAntags); @out.1};
		type:event
		out:ServerClient^:Клиент:Объект проверяемого клиента, зашедший в игру на старте раунда.
			opt:mul=1
		out:Mob^:Моб:Объект проверяемого моба, зашедшего в игру на старте раунда.
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
		desc:Результат конца раунда это число, которое отражает исход раунда. Обычно положительные (больше 0) числа являются положительным исходом, а отрицательные (меньше 0) - негативным.\n"+
		"Любое значение, отличное от 0 немедленно завершит раунд.
		prop:all
		return:struct.GamemodeFinishResult:Результат конца раунда
	" node_var
	var(_currentFinishResult,vec2(0,""));

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
		desc:Данное событие срабатывает раз в секунду после начала раунда.\n"+
		"Для установки нужного конца раунда используйте узел 'Завершить раунд'.
		type:event
	" node_met
	func(_checkFinishWrapper)
	{
		objParams();
	};

	"
		name:Завершить раунд
		namelib:Установить результат конца раунда (завершить раунд)
		desc:Устанавливает результат раунда и описание результата.
		in:int:Исход:Число, отражающее один из концов раунда.
		in:string:Описание:Текстовое описание, которое будет выведено при завершении раунда.
	" node_met
	func(setEndgameScriptedMode)
	{
		objParams_2(_irez,_desc);
		if (_irez == 0) exitwith {};
		setSelf(_currentFinishResult,vec2(_irez,_desc));
	};

	"
		name:Автопроверка длительности режима
		desc:При включении этой опции режим будет автоматически сверять текущее время игры с длительностью режима. Когда время игры превысит длительность режима - раунд будет завершен автоматически."+
		"Результат конца раунда при автоматическом завершении по таймеру будет -999.\nПри отключении данной опции вы должны реализовать проверку по длительности самостоятельно, иначе раунд никогда не завершится.
		classprop:1
		prop:get
		return:bool
		defval:false
	" node_var
	var(__stdCheckDuration,false);

	func(checkFinish)
	{
		objParams();
		callSelf(_checkFinishWrapper);
		getSelf(_currentFinishResult) params ["_fr","_fdes"];
		if (_fr == 0 && {getSelf(__stdCheckDuration)}) then {
			if (gm_roundDuration >= getSelf(duration)) then {
				_fr = -999;
				_fdes = "Смена завершена.";
				callSelfParams(setEndgameScriptedMode,_fr arg _fdes);

			};
		};
		if (_fr != 0) exitWith {
			setSelf(__rtf_buf,_fdes);
			_fr
		};
		0
	};
	var(__rtf_buf,"ОШИБКА РЕЗУЛЬТАТА");
	getter_func(getResultTextOnFinish,getSelf(__rtf_buf));

	"
		name:При завершении раунда
		namelib:Событие при завершении раунда
		desc:Данное событие срабатывает когда раунд завершается. Для вызова логики рестарта раунда и вывода сообщений со статистикой используйте узел 'Вызов базового метода'
		type:event
	" node_met
	func(_onFinishWrapper)
	{
		objParams();
	};

	func(onFinish)
	{
		objParams();
		super();
		callSelf(_onFinishWrapper);
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
		"По умолчанию если нет никаких проверок раунд будет сразу запущен.
		type:event
		return:struct.ConditionToStartGamemode:Воможность запуска раунда
	" node_met
	func(_conditionToStartWrapper)
	{
		objParams();
		getSelf(__startRoundStructure)
	};

	func(conditionToStart)
	{
		objParams();
		private _sCond = callSelf(_conditionToStartWrapper);
		assert_str(!isNullVar(_sCond),"Неопределенная структура запуска раунда");
		getSelf(__startRoundStructure) set [1,_sCond select 1];
		_sCond select 0
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
		type:get
		lockoverride:1
		in:classname:Роль:Название роли
			opt:def=ScriptedRole
		return:int:Количество кандидатов, занявших эту роль.
	" node_met
	func(getCandidatesCount)
	{
		objParams_1(_roleName);
		super();
	};

	"
		name:Получить роль
		desc:Получает объект роли.
		in:classname:Тип роли:Тип роли, которую необходимо получить.
			opt:def=ScriptedRole:typeset_out=Результат
		return:ScriptedRole:@[ScriptedRole^ Объект роли] или любой тип, являющийся её (прямым или косвенным) наследником.
	" node_met
	func(getRole)
	{
		objParams_1(_classname);
		private _robj = _classname call gm_getRoleObject;
		assert_str(!isNullReference(_robj),format vec2("Role object %1 not found",_classname));
		_robj
	};


	"
		name:Доступные роли
		desc:Список ролей, доступных для этого режима. Сюда входят как роли, доступные в лобби, так и роли, видимые после старта раунда. Настройка видимости роли на разных стадиях игры настраивается внутри самих ролей.
		type:const
		return:array[classname]:Список ролей, доступных в режиме.
		defval:[]
		restr:ScriptedRole
	" node_met
	func(_getRolesWrapper)
	{
		objParams();
		[]
	};
	
	var(___roleFirstInit__,false);

	func(_getRolesWrapperInternal)
	{
		objParams_1(_getMode);
		private _rlist = callSelf(_getRolesWrapper);
		private _robj = nullPtr;
		private _lobby = [];
		private _late = [];
		private _isFirstInit = !getSelf(___roleFirstInit__);
		if (_isFirstInit) then {
			setSelf(___roleFirstInit__,true);
		};
		{
			_robj = _x call gm_getRoleObject;
			
			if !isNullReference(_robj) then {
				if (_isFirstInit) then {
					callFuncParams(_robj,onRegisteredInGamemode,this);
				};
				if callFunc(_robj,_canTakeInLobbyConst) then {
					_lobby pushBackUnique _x;
				};
				if callFunc(_robj,_canVisibleAfterStartConst) then {
					_late pushBackUnique _x;
				};
			};
		} foreach _rlist;

		ifcheck(_getMode==0,_lobby,_late)
	};


	if (is3DEN) then {
		func(getLobbyRoles)
		{
			["___SCRITED_GAMEMODE___"] //специальное имя для взятия ролей из скриптового режима
		};

		func(getLateRoles)
		{
			[]
		};
	} else {
		getter_func(getLobbyRoles,callSelfParams(_getRolesWrapperInternal,0));
		getter_func(getLateRoles,callSelfParams(_getRolesWrapperInternal,1));
	};

	"
		name:Время игры
		namelib:Текущее время игры
		desc:Возвращает время, прошедшее с начала раунда в секундах. Если раунд ещё не начался возвращает 0
		type:get
		lockoverride:1
		return:int:Текущая длительность игры
	" node_met
	getter_func(_getDurationWrapper,gm_roundDuration);

	"
		name:Умершие мобы
		desc:Получает количество умерших сущностей с начала раунда
		prop:get
		return:int:Количество умерших мобов
	" node_var
	var(countDead,0);

	region(backend code)

		func(onRoundCode)
		{
			super();
			this = gm_currentMode;
			callSelf(onTick);
		};

		var(__startRoundStructure,vec2(false,"Неопределенная причина. Определите событие условия запуска раунда."));

		func(onFailReasonToStart)
		{
			objParams();
			getSelf(__startRoundStructure) select 1
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


editor_attribute("InterfaceClass")
class(ScriptedRole) extends(BasicRole)

	"
		name:Пользовательская роль
		desc:Базовая игровая роль, от которой создаются пользовательские роли.
		path:Игровая логика.Роли
	"
	node_class

	"
		name:Имя роли
		desc:Отображаемое имя роли.
		prop:get
		classprop:1
		return:string:Имя роли
		defval:Роль
	" node_var
	var(name,"Роль");

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
		desc:Описание роли для игры. Если не переопределено или пустая строка, то для игры будет взято описание из ""Описание роли"".
		prop:get
		classprop:1
		return:string:Описание роли для игры
	" node_var
	var(descInGame,"");

	"
		name:Класс мужского персонажа
		desc:Класс мужского типа персонажа.
		prop:get
		classprop:1
		return:classname:Класс для мужского персонажа
		defval:Mob
		restr:Mob
	" node_var
	var(classMan,"Mob");

	"
		name:Класс женского персонажа
		desc:Класс женского типа персонажа.
		prop:get
		classprop:1
		return:classname:Класс для женского персонажа
		defval:MobWoman
		restr:Mob
	" node_var
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
		name:Может быть полным антагонистом
		desc:Определяет, может ли роль быть полным антагонистом.
		prop:get
		classprop:1
		return:bool:Может ли роль быть полным антагонистом
		defval:true
	" node_var
	var(__canBeFullAntag,true);
	"
		name:Может быть скрытым антагонистом
		desc:Определяет, может ли роль быть скрытым антагонистом.
		prop:get
		classprop:1
		return:bool:Может ли роль быть скрытым антагонистом
		defval:true
	" node_var
	var(__canBeHiddenAntag,true);

	"
		name:В лобби после смерти
		namelib:Возврат в лобби после смерти (разрешить призрака)
		desc:Опция отвечает за автоматический возврат в лобби после смерти персонажа. Если она включена - возвращает игрока в лобби сразу после смерти, иначе позволяет покинуть тело и в роли призрака наблюдать за остальными.
		prop:get
		classprop:1
		return:bool:Нужно ли вернуть владельца роли в лобби после смерти
		defval:false
	" node_var
	//после смерти сразу возвращает в лобби. должно быть выключено
	var(returnInLobbyAfterDead,false);
	
	"
		name:Таймаут смерти
		desc:Время в секундах, после которого призрак сможет вернуться обратно в лобби. Работает только если выключена опция ""В лобби после смерти"".
		prop:all
		classprop:1
		return:int:Таймаут:Время в секундах, через которое призрак сможет вернуться в лобби.
		defval:10
	" node_var
	var(_deadTimeout,10);

	"
		name:Получить таймаут смерти
		desc:Данное событие предназначено для гибкой настройки получения таймаута смерти. Событие вызывается в момент смерти персонажа, который владеет этой ролью.
		type:event
		out:BasicMob^:Моб:Объект моба, для которого вызывалось данное событие.
		out:ServerClient^:Клиент:Объект клиента (владельца моба), для которого вызвалось данное событие. Может быть null ссылкой, если моб умер, когда за него не играл клиент в момент смерти.
		return:int:Время ожидания для призрака в секундах, после которого он сможет вернуться в лобби.
	" node_met
	func(_getDeadTimeout)
	{
		objParams_2(_mob,_usr);
		getSelf(_deadTimeout);
	};

	"
		name:Требование смены лица
		desc:Требование смены лица при смерти. Если включено (@[bool ИСТИНА]), то после смерти при попытке зайти за новую роль с предыдущим лицом и именем игрока не пустит в игру. "+
		"Чаще всего для ролей монстров включено, а для обычных людей выключено.
		type:const
		return:bool:Требовать смену лица и имени при заходе за новую роль после смерти за предыдущего персонажа.
		defval:true
	" node_met
	getter_func(canStoreNameAndFaceForValidate,true);

	"
		name:Количество заходов
		namelib:Количество заходов за роль
		desc:Это число отвечает за количество возможных заходов за роль. Когда каждый игрок заходит за эту роль, то количество уменьшается на 1. Когда это число становится равным нулю, то больше не получится зайти за эту роль.
		prop:get
		return:int:Количество заходов
		classprop:1
		defval:1
	" node_var
	var(count,1);

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
		getSelf(_currentBaseSkills);
	};

	func(getSkills)
	{
		objParams();
		private _vec4Base = callSelf(_getSkillsWrapper);
		private _fmtError = format["Class %1 (%2)",callSelf(getClassname),getSelf(name)];
		private _sb = [];
		{
			(_vec4Base select _foreachIndex) params ["_min","_max"];
			private _f = (_vec4Base select _foreachIndex);
			assert_str(_min <= _max,format["Skill '%1' error - min > max; %2" arg  _x arg _f]);
			assert_str(_min > 0,format["Minimum value for skill '%1' must be > 0; %2" arg _x arg _f]);
			assert_str(_max > 0,format["Maximum value for skill '%1' must be > 0; %2" arg _x arg _f]);
			
			_sb pushBack (_x + "=" + ifcheck(_min == _max,str _min,(_vec4Base select _foreachIndex) joinString "-"));
		} foreach ["st","iq","dx","ht"];
		
		_sb joinString ";"
	};


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
	
	#include "ScriptedSkillsDecl.hpp"

	func(getOtherSkills)
	{
		objParams();
		private _oskills = callSelf(_getOtherSkillsWrapper);
		private _ret = [];
		assert_str(!isNull(skills_nodes_listKinds) && !isNull(skills_nodes_allowedMinSkillDefIndex),"Internal skill constans getting error");
		private _minIndex = skills_nodes_allowedMinSkillDefIndex;
		private _skDataList = skills_nodes_listKinds;//list(vec2(string,string))
		private _existsSkills = [];
		{
			_x params ['_skIndex',"_skRange"];
			
			assert_str(!array_exists(_existsSkills,_skIndex),"Duplicate skill: " + ((_skDataList select _skIndex) joinString " - "));
			assert_str(_skIndex >= _minIndex,"Unsupported skill: " + ((_skDataList select _skIndex) joinString " - "));

			_ret pushBack [(_skDataList select _skIndex) select 0,_skRange];
			_existsSkills pushBack _skIndex;
		} foreach _oskills;
		_ret;
	};


	"
		name:Доступность роли в лобби
		desc:Будет ли доступна эта роль запрашиваемому клиенту из лобби до старта игры. С помощью выходного параметра ""Клиент"" можно настроить ограничения для конкретных клиентов.
		type:event
		out:ServerClient^:Клиент:Объект клиента, который запрашивает видимость роли.
		out:bool:Вывод ошибок:Этот параметр принимает значение @[bool ИСТИНА], когда запрос осуществляется с возможностью вывода ошибки. Например, если настроить ограничение на пол для роли, то при включенном флаге можно отправить клиенту сообщение о том, что пол его персонажа не подходит.
		return:bool:Доступность роли в лобби
	" node_met
	func(canTakeInLobby)
	{
		objParams_2(_cliObj,_canPrintErrors);
		callSelf(_canTakeInLobbyConst);
	};

	"
		name:Видимость в лобби
		namelib:Видно ли роль в лобби (Видимость в лобби)
		desc:Указывает будет ли отображаться эта роль в списке ролей до старта раунда.
		type:const
		return:bool:Видимость роли в лобби
		defval:true
	" node_met
	getterconst_func(_canTakeInLobbyConst,true);

	"
		name:Доступность роли после старта
		desc:Будет ли доступна эта роль запрашиваемому клиенту из лобби после старта раунда. С помощью выходного параметра ""Клиент"" можно настроить ограничения для конкретных клиентов.
		type:event
		out:ServerClient^:Клиент:Объект клиента, который запрашивает видимость роли.
		return:bool:Видимость роли после старта
	" node_met
	func(canVisibleAfterStart)
	{
		objParams_1(_cliObj);
		callSelf(_canVisibleAfterStartConst);
	};

	"
		name:Видимость в игре
		namelib:Видно ли роль в игре (Видимость в игре)
		desc:Указывает будет ли отображаться эта роль в списке ролей после старта раунда.
		type:const
		return:bool:Возможность взятия роли в игре
		defval:true
	" node_met
	getterconst_func(_canVisibleAfterStartConst,true);

	"
		name:Нужные роли дискорда
		desc:Список названий ролей из [discord.relicta.ru дискорда], которые необходимы клиенту для возможности взятия этой роли. Если список пуст - роль могут взять все. Если указано несколько ролей, то клиенту требуется хотя бы одна роль из этого списка.
		type:const
		return:array[string]:Список ролей дискорда
		defval:[]
	" node_met
	getter_func(needDiscordRoles,[]);

	//TODO access enum
	getter_func(roleAccess,[]);

	"
		name:Полный антагонист
		namelib:Может быть полным антагонистом
		desc:Отвечает за то, может ли клиент, взявший эту роль быть полным антагонистом. "+
		"Данный узел позволяет реализовать специальную логику по решению будет ли эта роль полным антагонистом. Эта проверка всегда включает внешнюю проверку на ключевую роль - в этом событии не требуется проверять является ли роль ключевой. "+
		"Полным антагонистам выполняется замена роли, а выбор этих ролей происходит в логике игрового режима.
		type:event
		out:ServerClient^:Клиент:Объект клиента, который проверяется на полного антагониста.
		return:bool:Полный антагонист
	" node_met
	func(canBeFullAntag)
	{
		objParams_1(_client);
		getSelf(__canBeFullAntag)
	};

	"
		name:Скрытый антагонист
		namelib:Может быть скрытым антагонистом
		desc:Отвечает за то, может ли клиент, взявший эту роль быть скрытым антагонистом. "+
		"Данный узел позволяет реализовать специальную логику по решению будет ли эта роль скрытым антагонистом. Эта проверка всегда включает внешнюю проверку на ключевую роль. "+
		"Скрытые антагонисты получают свои особые задачи без смены роли, в отличии от полных антагонистов. Выбор таких ролей происходит в логике игрового режима.
		type:event
		out:ServerClient^:Клиент:Объект клиента, который проверяется на скрытого антагониста.
		return:bool:Скрытый антагонист
	" node_met
	func(canBeHiddenAntag)
	{
		objParams_1(_client);
		getSelf(__canBeHiddenAntag)
	};

	//safe copy mobs
	"
		name:Базовые владельцы роли
		desc:Возвращает список сущностей мобов, игроки которых заходили за эту роль.
		type:get
		lockoverride:1
		return:array[BasicMob^]:Список мобов, зашедших за эту роль
	" node_met
	getter_func(getBasicMobs,array_copy(getSelf(basicMobs)));
	
	// "
	// 	name:Владельцы роли
	// 	desc:Возвращает список сущностей мобов, которые владеют этой ролью в данный момент. От базовых владельцев этот список может отличаться, так как некоторые персонажи во время игры могут быть назначены на другие роли.
	// 	type:get
	// 	lockoverride:1
	// 	return:array[BasicMob^]:Список мобов, владеющих этой ролью
	// " node_met
	// getter_func(getMobs,array_copy(getSelf(mobs)));
	
	"
		name:Позиция появления
		namelib:Событие позиции появления роли
		desc:Позиция появления роли (спавна персонажа). Может быть точкой спавна или рандомной точкой спавна. Данное событие предназначено для гибкой настройки выбора стартовой точки появления персонажа.
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
		assert_str(equalTypes(_slocStruct,[]),"Invalid spawn location datatype");
		assert_str(equalTypes(_slocStruct select 0,0) && equalTypes(_slocStruct select 1,""),"Invalid spawn location data");
		assert_str((_slocStruct select 1) != "","Empty string point name");
		
		_slocStruct params ["_spType","_spName"];

		(["pos","rpos"] select _spType)+":"+_spName
	};

	"
		name:Точка спавна
		desc:Позиция спавна персонажа. Данное свойство отвечает за начальное появление персонажа при заходе за роль.
		prop:get
		classprop:1
		return:struct.SpawnPoint:Точка спавна
		defval:[0,'']
	" node_var
	var(_currentSpawnLocation,[0 arg ""]);

	"
		name:Случайное направление спавна
		desc:Указывает будет ли включено случайное направление при спавне персонажа. @[bool ИСТИНА] - персонаж будет появляться на точке всегда со случайным направлением. @[bool ЛОЖЬ] - направление при появлении будет учитываться из направления точки спавна.
		type:const
		return:bool:Истина, если нужно использовать случайное направление при спавне.
		defval:false
	" node_met
	getter_func(useRandomDirOnSpawn,false);

	// --------- connection object --------

	"
		name:Точка привязки
		desc:Точка привязки персонажа. Это свойство позволяет выбрать объект, на котором появится персонаж (кровати, стулья).
		prop:get
		classprop:1
		return:struct.SpawnLocationConnection:Точка привязки рядом с позицией спавна
		defval:[0,'','GameObject',-1]
	" node_var
	var(_currentConnectedTo,[0 arg "" arg "GameObject" arg -1]);

	"
		name:Точка привязки
		namelib:Событие точки привязки
		desc:Данное событие предназначено для гибкой настройки логики определения точки привязки.
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
		desc:Событие, которое вызывается единожды при заходе клиента за роль и используется для реализации выдачи снаряжения персонажу.
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
		out:bool:Позднее назначение:Этот порт отвечает за позднее назначение (после старта раунда). Когда возвращает @[bool ИСТИНУ] - клиент зашёл на старте раунда, а когда @[bool ЛОЖЬ] - уже после старта раунда.
	" node_met
	func(_onAssignedWrapper)
	{
		objParams_3(_mob,_usr,_lateAssign);
	};
	
		func(onAssigned)
		{
			objParams_2(_mob,_usr);
			private _lateAssign = callSelf(isLateAssigned);
			callSelfParams(_onAssignedWrapper,_mob arg _usr arg _lateAssign);
		};

	//!NOT USED
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

	// "
	// 	name:При смерти
	// 	namelib:Событие при смерти на роли
	// 	desc:Вызывается когда персонаж умирает, будучи назначенным на эту роль. Клиент мог зайти за другую роль и быть назначенным на другую роль, для которой и вызовется данное событие.
	// 	type:event
	// 	out:BasicMob^:Моб:Объект моба, для которого вызывалось данное событие.
	// 	out:ServerClient^:Клиент:Объект клиента (владельца моба), для которого вызвалось данное событие. Может быть null ссылкой, если моб умер, когда за него не играл клиент.
	// " node_met
	// func(onDead)
	// {
	// 	objParams_2(_mob,_usr);
	// };

	"
		name:При смерти за роль
		namelib:Событие при смерти за роль
		desc:Вызывается когда персонаж заходил за эту роль и умер. Событие вызывается для той роли, за которую клиент заходил из лобби или за роль полного антагониста, если он его получил.
		type:event
		out:BasicMob^:Моб:Объект моба, для которого вызывалось данное событие.
		out:ServerClient^:Клиент:Объект клиента (владельца моба), для которого вызвалось данное событие. Может быть null ссылкой, если моб умер, когда за него не играл клиент в момент смерти.
	" node_met
	func(_onDeadBasicWrapper)
	{
		objParams_2(_mob,_usr);
	};
	func(onDeadBasic)
	{
		objParams_2(_mob,_usr);
		callFuncParams(_usr,setDeadTimeout,callSelfParams(_getDeadTimeout,_mob arg _usr));
		callSelfParams(_onDeadBasicWrapper,_mob arg _usr);
	};

	//вызывается при конце игры за текущую роль (если человек выжил за нее)
	//В большинстве случаев используется onEndgameBasic
	//! Внимание ! При модификации очков клиента второй параметр _onlyOnGame должен быть ТОЛЬКО false ServerCleint::addPoints()
	//! Так как данные методы вызываются когда стейт игры уже изменился на GAME_STATE_END
	// "
	// 	name:При конце раунда
	// 	namelib:Событие при конце раунда на роли
	// 	desc:Вызывается для персонажа, который имеет эту роль в данный момент в момент конца раунда. Событие вызывается только для мобов, за которых играют клиенты в момент завершения раунда.
	// 	type:event
	// 	out:BasicMob^:Моб:Объект моба, для которого вызывалось данное событие.
	// 	out:ServerClient^:Клиент:Объект клиента (владельца моба), для которого вызвалось данное событие.
	// " node_met
	// func(onEndgame)
	// {
	// 	objParams_2(_mob,_usr);
	// };

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

	"
		name:Получить текущий режим
		desc:Получает объект текущего режима. Данный узел позволяет осуществлять доступ к режиму из ролей, тем самым изменяя его. Однако не рекомендуется изменять состояние игры внутри ролей.
		type:const
		classprop:0
		return:ScriptedGamemode:Текущий режим
	" node_met
	getterconst_func(getCurrentGamemode,gm_currentMode);


	func(constructor)
	{
		objParams();
	};

	func(onRegisteredInGamemode)
	{
		objParams_1(_gmObj);
		if (!is3DEN) then {
			{
				assert_str(_x!="",format vec2("Empty string in property needDiscordRoles for class %1",callSelf(getClassName)));
				
			} foreach callSelf(needDiscordRoles);
		};
	};

endclass

class(ScriptedEater) extends(ScriptedRole)
	"
		name:Жрун
		desc:Базовая роль монстра типа ""Жрун"".
		path:Игровая логика.Роли
	" node_class

	var(name,"Жрун");

	var(returnInLobbyAfterDead,true);
	getter_func(canStoreNameAndFaceForValidate,false);
	
	getterconst_func(_canTakeInLobbyConst,true);
	getter_func(_canVisibleAfterStartConst,true);
	var(count,1);
	var(classMan,"GMPreyMobEater");
	var(classWoman,"GMPreyMobEater");
	
	func(getEquipment)
	{
		objParams_1(_mob);
		["Castoffs" + str randInt(1,3),_mob,INV_CLOTH] call createItemInInventory;
	};
	
	func(onAssigned)
	{
		objParams_2(_mob,_usr);
		super();
		callFuncParams(_mob,setMobFace,"");//reset face
		callFuncParams(_mob,generateNaming,callFunc(_mob,getRandomNamePrefix) arg "жрун");
	};
	func(onDeadBasic)
	{
		objParams_2(_mob,_usr);
		super();
		callFuncParams(_usr,setDeadTimeout,30);
	};
endclass