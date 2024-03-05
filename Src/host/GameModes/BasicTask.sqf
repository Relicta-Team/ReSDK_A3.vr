// ======================================================
// Copyright (c) 2017-2024 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <GameMode.h>

#include <CommonTasks\PublicTasks.sqf>

taskSystem_allTasks = [];
taskSystem_checkedOnEndRound = [];

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
	CounterKindTask - задача для работы с подсчетом значений
		- входные параметры: int - счетчик
	LocationKindTask - задача относящаяся к работе с локациями (прибытие и нахождение в локации)
		- входные параметры: позиция, дистанция, возможный triggerArea, ссылки на объекты
	RoleKindTask - задача на работу с ролями
	TODO ReagentTask - 
	TODO StatusEffectGetTask -


	Список задач:
	!TODO global refactoring required
	ItemGetTask - получение предмета
	ItemSaveTask - сохранение предмета
	TargetSaveTask - сохранение цели до конца раунда (не должна умереть)
	SelfSafeTask - владелец цели не долен умереть
	TargetDeadTask - цель дожна умереть
	LocationTask - посетить определнную локацию (позицию)
	MoneyGetTask - получить определенное количество денег
	RoleGetTask - получить определенную роль
	StatusEffectGetTask - получить определенный статус эффект
	ReagentTask - получить определенный реагент
*/

//todo remove legacy task
#include "__old_tasks.sqf"

editor_attribute("ColorClass" arg "1370A2")
class(TaskBase) extends(IGameEvent)

	"
		name:Задача
		desc:Базовая игровая задача для персонажа
		path:Игровая логика.Задачи
	" node_class

	"
		name:Тэг задачи
		desc:Тэг созданной задачи. По умолчанию пустая строка
		prop:get
	" node_var
	var(tag,"");//системный тэг задачи

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

		setSelf(tag,_tagName);
	};
	
	"
		name:Название задачи
		desc:Название задачи
		prop:all
		defval:Задача
	" node_var
	var(name,"Задача");

	"
		name:Описание задачи
		desc:Системное описание задачи
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
		desc:Вызываемая функция вывода описания задачи
		prop:all
		return:function[event=string=BasicTask^]:Описание задачи
	" node_var
	var(_taskDescDelegate,{getSelf(descRoleplay)});
	func(getTaskDescription)
	{
		objParams();
		[this] call getSelf(_taskDescDelegate)
	};


	var(owners,[]); //кто владеет данной задачей

	"
		name:Владельцы задачи
		desc:Получает список владельцев задачи
		type:get
		lockoverride:1
		return:array[Mob^]:Владельцы задачи
	" node_met
	getter_func(getOwners,getSelf(owners));

	"
		name:Задача завершена
		desc:Возвращает ИСТИНУ, если задача завершила выполнение. Провал задачи также считается завершением. Задачи, проверяемые только в конце раунда завершаются когда раунд закончится.
		prop:get
		return:bool:Завершено ли выполнение задачи
		defval:false
	" node_var
	var(isDone,false); //метка активности задачи

	//флаг, отвечающий за то является ли задача выполняемой до конца раунда или по условию в прогрессе
	getterconst_func(checkCompleteOnEnd,false);

	"
		name:Частота проверки задачи
		desc:Время, через которое выполняется проверка условия выполнения задачи
		prop:get
		return:int:Частота проверки условия задачи
		defval:2
	" node_var
	var(checkDelay,2);

	"
		name:Результат задачи
		desc:Возвращает числовое значение результата задачи. Если результат равен нулю, то считается что задача не выполнена.
		prop:get
		return:int:Результат выполнения задачи
		defval:0
	" node_var
	var(result,0); //всё что отлично от 0 является результатом задачи. Принимается правило, что отрицательные значения - провал, положительные - успех
	
	func(onRegisterInTarget)
	{
		objParams_1(_mob);

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

	func(onTaskRegistered)
	{
		objParams();
		//virtual function
	};

	var(_taskHandle__,-1);

	func(destructor)
	{
		if (getSelf(_taskHandle__)!=-1) then {
			stopUpdate(getSelf(_taskHandle__));
			setSelf(_taskHandle__,-1);
		};
		array_remove(taskSystem_allTasks,this);
	};

	func(updateMethod)
	{
		updateParams();
		{
			callSelfParams(onTaskCheck,_x);
		} foreach getSelf(owners);
	};

	func(onTaskCheck)
	{
		objParams_1(_owner);
	};

	func(setTaskResult)
	{
		objParams_1(_tr);
		if getSelf(isDone) exitWith {}; //task already done - exit
		setSelf(result,_tr);
		if !callSelf(checkCompleteOnEnd) then {
			if (_tr != 0) then {
				callSelf(onTaskDone);
			};
		};
	};

	//вызывается автоматически при задаче с checkCompleteOnEnd, либо при пользовательской проверке на завершение
	func(onTaskDone)
	{
		objParams();
		setSelf(isDone,true);
		private _tr = getSelf(result);
		if (_tr > 0) then {
			{
				_x params ["_mob"];
				[this,_mob] call getSelf(_taskOnSuccessDeletage);
			} foreach getSelf(owners);
		} else {
			{
				_x params ["_mob"];
				[this,_mob] call getSelf(_taskOnFailDeletage);
			} foreach getSelf(owners);
		};
	};

	// обработчики успешного выполнения и провала
	"
		name:Обработчик успешного выполнения задачи
		desc:Вызывается при успешном выполнении задачи.
		prop:all
		return:function[event=null=BasicTask^@Mob^]:Обработчик успешного выполнения задачи
	" node_var
	var(_taskOnSuccessDeletage,{});
	"
		name:Обработчик провала задачи
		desc:Вызывается при провале задачи.
		prop:all
		return:function[event=null=BasicTask^@Mob^]:Обработчик провала задачи
	" node_var
	var(_taskOnFailDeletage,{});



endclass


class(ItemKindTask) extends(BasicTask)
	var(name,"Item task");

	"
		name:Глобальные ссылки
		desc:Список глобальных ссылок на игровые предметы, обрабатываемые задачей.
		prop:all
		return:array[string]:Массив глобальных ссылок
		defval:[]
	" node_var
	var(__globalRefs,[]);
	"
		name:Список предметов
		desc:Список ссылок на игровые объекты (предметы), обрабатываемые задачей.
		prop:all
		return:array[Item^]:Массив ссылок на игровые объекты
	" node_var
	var(__objRefs,[]);
	"
		name:Список типов
		desc:Список типов, обрабатываемых задачей.
		prop:all
		return:array[classname]:Массив типов
	" node_var
	var(__typeList,[]); //!набор типов. Как будем обрабатывать???

	func(onTaskRegistered)
	{
		objParams();
		//getting all references 
		callSelf(__convertGlobalRefsToObjects);
		callSelf(__validateInputs);
	};

	func(__convertGlobalRefsToObjects)
	{
		objParams();
		private _lvals = [];
		private _refto = null;
		{
			_refto = [_x] call getObjectByRef;
			assert_str(!isNullReference(_refto),format vec2("Invalid global reference: %1",_x));

			_lvals pushBack _refto;
		} foreach getSelf(__globalRefs);

		getSelf(__objRefs) append _lvals;
	};

	func(__validateInputs)
	{
		objParams();
		{
			assert_str(!isNullReference(_x),"Null reference item");
			assert_str(isTypeOf(_x,Item),format vec2("Invalid global reference. Object must be of type Item, not %1",callFunc(_x,getClassName)));
		} forEach getSelf(__objRefs);
	};

	func(processObjectCheck)
	{
		objParams_1(_funcref);
		{
			[_x] call _funcref;
		} foreach getSelf(__objRefs);
	};



endclass