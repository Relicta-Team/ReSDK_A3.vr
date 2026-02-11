// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <GameMode.h>

//all public tasks here...
#include <CommonTasks\PublicTasks.sqf>

taskSystem_allTasks = [];
taskSystem_checkedOnEndRound = [];
taskSystem_increment = 0;

taskSystem_map_tags = createHashMap; //map of all tagged tasks

//register tasksystem functions
#include "taskSystem_functions.sqf"


#ifdef EDITOR
	#define editor_task_test
#endif

/* 
	Обновлённая система задач

	Задачи делятся на 2 категории:
	 - проверяемые в конце раунда
	 - проверяемые до успешного выполнения

	У задачи всегда есть состояние: выполнено/не выполнено.
	Задачи проверяемые в конце раунда выполняются по условию true
		Провалены если условие не выполнено к концу раунда
	Задачи, выполняемые до успешного выполнения, считаются успешно завершенными когда условие выполнено (после выполнения проверка останавливается)
		Провалены если режим закончился или сработали условия провала (объект уничтожен, владелец задачи уничтожен и т.д.)


	Интерфейсы:
	ItemKindTask - задача относящаяся к работе с игровыми предметами
		- входные параметры: ссылка объекта, глобальнаяссылка, массив ссылок или глобальных ссылок, тип, массив типов
	MobKindTask - задача относящаяся к работе с сущностями
		- входные параметры: ссылка объекта
	GameObjectKindTask - задача относящаяся к работе с игровыми объектами
		- входные параметры: ссылка объекта, глобальная ссылка, ... (как в ItemKindTask)
		TODO inherit from item (or item inherit from this)
	CounterKindTask - задача для работы с подсчетом значений
		- входные параметры: int - счетчик
	LocationKindTask - задача относящаяся к работе с локациями (прибытие и нахождение в локации)
		- входные параметры: позиция, дистанция, возможный triggerArea, ссылки на объекты
	RoleKindTask - задача на работу с ролями
	TODO ReagentTask - 
	TODO StatusEffectGetTask -
*/

editor_attribute("ColorClass" arg "1370A2")
class(TaskBase) extends(IGameEvent)

	func(constructor)
	{
		objParams();
		private _nf = {
			objParams();
			if (count getSelf(owners) == 0) exitWith {
				_etext = format["Задача %1 (%2) не была назначена ни одному из владельцев.",getSelf(name),callSelf(getClassName)];
				setLastError(_etext);
			};
			[format["(TaskBase::constructor): Task %1 [%3:%2] created",
				callSelf(getClassName),getSelf(__id),getSelf(tag)
				]
			] call gameLog;
		}; nextFrameParams(_nf,this);

		INC(taskSystem_increment);
	};

	func(destructor)
	{
		objParams();
		private _ctx = format["%1 (%2)",getSelf(name),callSelf(getClassName)];
		setLastError("Ручное удаление задачи не допускается: " + _ctx);

		callSelf(terminateUpdateProcess);
		array_remove(taskSystem_allTasks,this);
	};

	"
		name:Задача
		desc:Базовая игровая задача для персонажа
		path:Игровая логика.Задачи.Общее
	" node_class

	"
		name:Тэг задачи
		desc:Тэг созданной задачи. По умолчанию пустая строка. Для установки тэга задачи воспользуйтесь узлом 'Установить тэг задачи'
		prop:get
	" node_var
	var(tag,"");//системный тэг задачи

	var(__id,taskSystem_increment);

	//Установить тэг задачи
	"
		name:Установить тэг задачи
		desc:Устанавливает тэг задачи. Может быть несколько задач с одинаковым тэгом.
		type:method
		lockoverride:1
		in:string:Тэг:Новый тэг задачи
	" node_met
	func(setTag)
	{
		objParams_1(_tagName);
		private _oldTag = getSelf(tag);
		if array_exists(taskSystem_map_tags,_oldTag) then {
			private _tasksByTag = (taskSystem_map_tags get _oldTag);
			_tasksByTag deleteAt (_tasksByTag find this);
		};

		if array_exists(taskSystem_map_tags,_tagName) then {
			(taskSystem_map_tags get _tagName) pushBack this;
		} else {
			taskSystem_map_tags set [_tagName,[this]];
		};

		[format["(TaskBase::setTag): Task %1 [%3:%2] tag changed from %4 to %5",
				callSelf(getClassName),getSelf(__id),getSelf(tag),
				_oldTag,_tagName
				]
			] call gameLog;

		setSelf(tag,_tagName);
	};
	
	"
		name:Название задачи
		desc:Имя объекта задачи.
		prop:all
		defval:Задача
	" node_var
	var(name,"Задача");

	"
		name:Описание задачи
		desc:Системное (внутреннее) описание задачи, видимое например в редакторе.
		prop:all
		defval:Сделать дело
	" node_var
	var(desc,"Сделать дело");

	"
		name:Ролевое описание задачи
		desc:Ролевое описание задачи
		prop:all
		defval:Нужно сделать дело...
	" node_var
	var(descRoleplay,"Нужно сделать дело...");

	"
		name:Обработчик описания задачи
		desc:Вызываемая функция вывода описания задачи. Обычно в этой функции вычисляются форматируемые значения (например, список объектов). Чтобы посмотреть исходную строку выведите в консоли 'Ролевое описание задачи'."+
		"\nПараметры функции-действия\:"+
		"\n - @[TaskBase^ Задача] - объект задачи, который производит проверку (вызов функции)"+
		"\n - @[Mob^ Владелец] - владелец задачи, который запрашивает описание"+
		"\n Возврат\: @[string Описание] - текст описания задачи. 
		prop:all
		return:function[event=string=TaskBase^@Mob^]:Описание задачи
	" node_var
	var(_taskDescDelegate,{getSelf(descRoleplay)});
	func(getTaskDescription)
	{
		objParams_1(_usr); //user - who requested description
		[this,_usr] call getSelf(_taskDescDelegate)
	};

	"
		name:Пользовательское описание
		desc:При включении данной опции в воспоминаниях вместо стандартного ""НАЗВАНИЯ:ОПИСАНИЯ"" задачи будет выводиться текст, возвращаемый обработчиком описания задачи. "+
		"Обратите внимание, что если обработчик возвращает пустую строку, то текст задачи не будет выводиться в воспоминаниях для моба, который запросил это описание.
		prop:all
		return:bool:Использовать пользовательское описание задачи
		defval:false
	" node_var
	var(customTaskInfo,false);

	"
		name:Единоразовая проверка условий
		desc:При установке этой опции в @[bool ИСТИНУ] задача будет выполнять проверку только для первого владельца этой задачи."+
		"В противном случае проверка выполнения задачи будет осщуествляться для всех её владельцев. Обратите внимание, что в выключенном состоянии единоразовой проверки задача может завершиться, если сработало условие выполнения хотя-бы для одного из её владельцев (эту логику можно переопределить)."+
		"\nЭто свойство не влияет на вызов событий при выполнении или провале задачи - успех и провал выполняется ко всем владельцам задачи.
		prop:all
		return:bool:Проверка условий
		defval:false
	" node_var
	var(isTaskSingleCheck,false); //проверка только для первого владельца

	var(owners,[]); //кто владеет данной задачей

	"
		name:Владельцы задачи
		desc:Получает копию списка владельцев задачи.
		type:get
		lockoverride:1
		return:array[Mob^]:Владельцы задачи
	" node_met
	getter_func(getOwners,array_copy(getSelf(owners)));

	"
		name:Задача завершена
		desc:Возвращает @[bool ИСТИНУ], если задача завершила выполнение. Провал задачи также считается завершением. Задачи, проверяемые только в конце раунда завершаются когда раунд закончится.
		prop:get
		return:bool:Завершено ли выполнение задачи
		defval:false
	" node_var
	var(isDone,false); //метка активности задачи

	//флаг, отвечающий за то является ли задача выполняемой до конца раунда или по условию в прогрессе
	getterconst_func(checkCompleteOnEnd,false);

	"
		name:Частота проверки задачи
		desc:Время в секундах, через которое выполняется проверка условия выполнения задачи. Проверка выполняется до тех пор, пока задача не будет завершена с положительным или отрицательным исходом. Не рекомендуется устанавливать это значение меньше чем 1."+
		"\nОбратите внимание, что вы не сможете изменить частоту проверки после добавления задачи владельцу.
		prop:all
		return:int:Частота проверки условия задачи
		defval:2
	" node_var
	var(checkDelay,2);

	"
		name:Результат задачи
		desc:Возвращает числовое значение результата задачи. Если результат равен нулю, то считается что задача не выполнена. В системе задач считается, что положительные результаты это успешное выполнение, а отрицательные - провал выполнения.
		prop:get
		return:int:Результат выполнения задачи
		defval:0
	" node_var
	var(result,0); //всё что отлично от 0 является результатом задачи. Принимается правило, что отрицательные значения - провал, положительные - успех
	
	func(onRegisterInTarget)
	{
		objParams_1(_mob);

		[format["(TaskBase::onRegisterInTarget): Task %1 [%3:%2] added to %4",
			callSelf(getClassName),getSelf(__id),getSelf(tag),
				[_mob] call logger_formatMob
			]
		] call gameLog;

		if getSelf(taskRegistered) exitWith {
			getSelf(owners) pushBackUnique _mob;
		};

		setSelf(taskRegistered,true);

		taskSystem_allTasks pushBack this;
		callSelfParams(setTag,getSelf(tag));

		getSelf(owners) pushBackUnique _mob;

		callSelf(onTaskRegistered);

		if callSelf(checkCompleteOnEnd) then {
			taskSystem_checkedOnEndRound pushBack this;
		} else {
			setSelf(_taskHandle__,startUpdateParams(getSelfFunc(updateMethod),getSelf(checkDelay),this));
		};
	};

	// Флаг, указывающий, что задача уже зарегистрирована
	var(taskRegistered,false);

	func(onTaskRegistered)
	{
		objParams();
		//virtual function
	};

	var(_taskHandle__,-1);

	func(terminateUpdateProcess)
	{
		objParams();
		if (getSelf(_taskHandle__)!=-1) then {
			stopUpdate(getSelf(_taskHandle__));
			setSelf(_taskHandle__,-1);
		};
	};

	func(updateMethod)
	{
		updateParams();
		callSelf(updateMethodInternal);
	};
	func(updateMethodInternal)
	{
		objParams();
		private _singleCheck = getSelf(isTaskSingleCheck);
		private _failOnDead = getSelf(failTaskOnDeadOwner);
		private _ownerLen = count getSelf(owners);
		if (_failOnDead && {{getVar(_x,isDead)}count getSelf(owners) >= ifcheck(_singleCheck,1,_ownerLen)}) exitWith {
			if (getSelf(isDone) || getSelf(result)!=0) exitWith {};	
			callSelfParams(setTaskResult,-5);
		};

		{
			callSelfParams(onTaskCheck,_x);

			//останавливаем проверку после выполнения задачи
			if (getSelf(isDone) || getSelf(result)!=0) exitWith {};

			if (_singleCheck && _foreachindex <= 0) exitWith {};
		} foreach getSelf(owners);
	};

	"
		name:Дополнительные условия
		desc:Дополнительные условия, которые должны быть выполнены для проверки задачи. При успешном завершении задачи вызывается событие, определенное в обработчике успешного выполнения задачи."+
		"\nПараметры функции-действия\:"+
		"\n - @[TaskBase^ Задача] - объект задачи, который производит проверку (вызов функции)"+
		"\n - @[Mob^ Владелец] - владелец задачи, которому она назначена"+
		"\n Возврат\: @[bool Булево] - результат проверки условия. Если условие @[bool ИСТИНА], то задача помечается как успешно завершенная.
		prop:all
		return:function[event=bool=TaskBase^@Mob^]:Условие проверки задачи
	" node_var
	var(_customCondition,{true});

	func(onTaskCheck)
	{
		objParams_1(_owner);

	};

	"
		name:Установить результат задачи
		desc:Устанавливает результат задачи. Если результат не равен нулю, то задача завершается с указанным результатом. Положительный результат считается успешным выполнением задачи, а отрицательный - провалом. "+
		"Если задача помечена как выполненная - ничего не произойдёт.
		type:method
		lockoverride:1
		in:int:Результат:Результат выполнения задачи
	" node_met
	func(setTaskResult)
	{
		params ['this',"_tr",["_endroundCheck",false]];

		if getSelf(isDone) exitWith {}; //task already done - exit
		setSelf(result,_tr);

		private _conditEnd = false;
		if callSelf(checkCompleteOnEnd) then {
			//задача проверяется в конце. результат выполняется если: раунд закончен или задача провалена
			_conditEnd = call gm_isRoundEnding || _tr < 0;
		} else {
			_conditEnd = true; //рантайм задачи завершаются при любом раскладе
		};

		if (_conditEnd || _endroundCheck) then {
			if (_tr != 0) then {
				callSelf(onTaskDone);
			};
		};
	};

	"
		name:Провал при смерти владельцев
		desc:Задача, в которой это значение @[bool ИСТИНА] - будет автоматически провалена с результатом -5, если погибли все её владельцы. Обратите внимание, что со значением @[bool ИСТИНА] узла 'Единоразовая проверка условий' для провала задачи должен погибнуть хотя бы один её владелец.
		prop:all
		return:bool:Провал при смерти владельцев
	" node_var
	var(failTaskOnDeadOwner,true);

	//вызывается автоматически при задаче с checkCompleteOnEnd, либо при пользовательской проверке на завершение
	func(onTaskDone)
	{
		objParams();
		setSelf(isDone,true);

		[format["(TaskBase::onTaskDone): Task %1 [%3:%2] done with result %4",
			callSelf(getClassName),getSelf(__id),getSelf(tag),
				getSelf(result)
			]
		] call gameLog;

		if !callSelf(checkCompleteOnEnd) then {
			callSelf(terminateUpdateProcess);
		};

		private _tr = getSelf(result);
		if (_tr > 0) then {
			{
				_x params ["_mob"];
				[this,_mob,_foreachindex] call getSelf(_taskOnSuccessDeletage);
			} foreach getSelf(owners);
		} else {
			{
				_x params ["_mob"];
				[this,_mob,_foreachindex] call getSelf(_taskOnFailDeletage);
			} foreach getSelf(owners);
		};
	};

	// обработчики успешного выполнения и провала
	"
		name:Обработчик успешного выполнения задачи
		desc:Вызывается при успешном выполнении задачи для каждого владцельца этой задачи."+
		"\nПараметры функции-действия\:"+
		"\n - @[TaskBase^ Объект задачи] - владелец функции-действия"+
		"\n - @[Mob^ Моб] - тот, кому назначена задача."+
		"\n - @[int Индекс] - номер владельца задачи. Первому мобу, которому была добавлена эта задача индекс будет равен 0, второму 1 и т.д.
		prop:all
		return:function[event=null=TaskBase^@Mob^@int]:Обработчик успешного выполнения задачи (функция-действие)
	" node_var
	var(_taskOnSuccessDeletage,{});
	"
		name:Обработчик провала задачи
		desc:Вызывается при провале задачи для каждого владельца этой задачи."+
		"\nПараметры функции-действия\:"+
		"\n - @[TaskBase^ Объект задачи] - владелец функции-действия"+
		"\n - @[Mob^ Моб] - тот, кому назначена задача."+
		"\n - @[int Индекс] - номер владельца задачи. Первому мобу, которому была добавлена эта задача индекс будет равен 0, второму 1 и т.д.
		prop:all
		return:function[event=null=TaskBase^@Mob^@int]:Обработчик провала задачи (функция-действие)
	" node_var
	var(_taskOnFailDeletage,{});

	"
		name:Копировать задачу
		desc:Создает копию задачи. Тэг и владельцы задачи не копируются.
		type:method
		lockoverride:1
		return:TaskBase:Копия задачи
	" node_met
	func(copyTask)
	{
		objParams();
		private _class = callSelf(getClassName);
		private _instance = instantiate(_class);
		private _fvals = (allVariables _instance) apply {tolower _x};
		private _excludedVars = ["_taskHandle__","owners","tag"] apply {tolower _x};
		private _fnamesUpdate = _fvals - _excludedVars;
		private _temp = null;
		{
			_temp = getSelfReflect(_x);
			if equalTypes(_temp,[]) then {
				_temp = array_copy(_temp);
			};
			setVarReflect(_instance,_x,_temp);
		} foreach _fnamesUpdate;

		_instance
	};

endclass
