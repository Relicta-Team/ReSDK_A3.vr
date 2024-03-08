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
		TODO inherit from item (or item inherit from this)
	CounterKindTask - задача для работы с подсчетом значений
		- входные параметры: int - счетчик
	LocationKindTask - задача относящаяся к работе с локациями (прибытие и нахождение в локации)
		- входные параметры: позиция, дистанция, возможный triggerArea, ссылки на объекты
	RoleKindTask - задача на работу с ролями
	TODO ReagentTask - 
	TODO StatusEffectGetTask -
*/

//todo remove legacy task
#include "__old_tasks.sqf"

editor_attribute("ColorClass" arg "1370A2")
class(TaskBase) extends(IGameEvent)

	func(constructor)
	{
		assert_str(callSelf(getParentClassName)!="TaskBase","Abstract task cannot be created");
	};

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

	"
		name:Единоразовая проверка условий
		desc:При включении этой опции задача будет выполнять проверку для всех её владельцев. В выключенном состоянии проверка осуществляется только для первого владельца задачи. "+
		"Это свойство не влияет на вызов событий при выполнении или провале задачи - успех и провал выполняется ко всем владельцам задачи.
		prop:all
		return:bool:Проверка условий
		defval:false
	" node_var
	var(isTaskSingleCheck,false); //проверка только для первого владельца

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
		callSelf(updateMethodInternal);
	};
	func(updateMethodInternal)
	{
		objParams();
		private _singleCheck = getSelf(isTaskSingleCheck);
		{
			callSelfParams(onTaskCheck,_x);

			//останавливаем проверку после выполнения задачи
			if (getSelf(isDone) || getSelf(result)!=0) exitWith {};

			if (_singleCheck && _foreachindex <= 0) exitWith {};
		} foreach getSelf(owners);
	};

	"
		name:Дополнительные условия
		desc:Дополнительные условия, которые должны быть выполнены для проверки задачи. Первый параметр - вызывающий событие объект (Задача), второй параметр - владелец задачи (Моб).
		prop:all
		return:function[event=null=BasicTask^@Mob^]:Условие проверки задачи
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

		if (!callSelf(checkCompleteOnEnd) || _endroundCheck) then {
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
		desc:Вызывается при успешном выполнении задачи для каждого владцельца.
		prop:all
		return:function[event=null=BasicTask^@Mob^@int]:Обработчик успешного выполнения задачи
	" node_var
	var(_taskOnSuccessDeletage,{});
	"
		name:Обработчик провала задачи
		desc:Вызывается при провале задачи для каждого владельца.
		prop:all
		return:function[event=null=BasicTask^@Mob^@int]:Обработчик провала задачи
	" node_var
	var(_taskOnFailDeletage,{});

	"
		name:Копировать задачу
		desc:Создает копию задачи. Тэг и владельцы задачи не копируются.
		type:method
		lockoverride:1
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
	};

endclass

class(GameObjectKindTask) extends(TaskBase)

	"
		name:Объектная задача
		desc:Задача, относящаяся к игровым объектам. Например: получение, сохранение и т.д.
		path:Игровая логика.Задачи.Объектные
	" node_class

	var(name,"GameObject task");

	"
		name:Глобальные ссылки
		desc:Список глобальных ссылок на игровые объекты, обрабатываемые задачей.
		prop:all
		return:array[string]:Массив глобальных ссылок
		defval:[]
	" node_var
	var(__globalRefs,[]);
	"
		name:Список объектов
		desc:Список ссылок на игровые объекты, обрабатываемые задачей.
		prop:all
		return:array[GameObject]:Массив ссылок на игровые объекты
	" node_var
	var(__objRefs,[]); //сюда добавляются глобальные ссылки
	"
		name:Список типов
		desc:Список типов объектов, обрабатываемых задачей.
		prop:all
		return:array[classname]:Массив типов
	" node_var
	var(__typeList,[]);

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
			assert_str(!isNullReference(_refto),format vec2("Null reference: %1",_x));
			_lvals pushBack _refto;
		} foreach getSelf(__globalRefs);

		getSelf(__objRefs) append _lvals;
	};

	func(__validateInputs)
	{
		objParams();
		{
			assert_str(!isNullReference(_x),"Null reference game object");
			assert_str(isTypeOf(_x,GameObject),format vec2("Invalid global reference. Object must be of type GameObject, not %1",callFunc(_x,getClassName)));
		} forEach getSelf(__objRefs);

		{
			assert_str(isTypeNameOf(_x,GameObject),format vec2("Invalid typename %1, must be of type GameObject",_x));
		} foreach getSelf(__typeList);
	};

	func(processObjectCheck)
	{
		objParams_3(_owner,_funcref,_functypes);

		private _foundNull = false;
		private _counter = 0;
		{
			if isNullReference(_x) then {
				_foundNull = true;
				continue;
			};
			_counter = _counter + ([_owner,_x] call _funcref);
		} foreach getSelf(__objRefs);

		{
			_counter = _counter + ([_owner,_x] call _functypes);
		} foreach getSelf(__typeList);

		if (getSelf(failTaskOnItemDestroy) && _foundNull) then {
			callSelfParams(setTaskResult,getSelf(failResultOnItemDestroy));
		};
		
		private _custom = [this,_owner] call getSelf(_customCondition);

		if (_counter >= ((count getSelf(__typeList)) + (count getSelf(__objRefs))) && _custom) then {
			callSelfParams(setTaskResult,1);
		};
	};

	"
		name:Провал при удалении
		desc:При включении этой опции задача будет автоматически провалена если один или несколько игровых объектов, относящихся к этой задаче были удалены или уничтожены.
		prop:all
		return:bool:Провалить задачу при удалении игровых объектов
	" node_var
	var(failTaskOnItemDestroy,false);

	"
		name:Результат провала при удалении
		desc:Результат провалки задачи, устанавливаемый при удалении одного или нескольких задачей в конце раунда.
		prop:all
		return:int:Результат провалки задачи
		defval:-100
	" node_var
	var(failResultOnItemDestroy,-100);

	"
		name:Имена игровых объектов
		desc:Возвращает массив имен игровых объектов, относящихся к выполнению задачи
		type:get
		lockoverride:1
		return:array[string]:Массив имен игровых объектов
	" node_met
	func(getObjectNames)
	{
		objParams();
		private _names = [];
		private _allItems = createHashMap;
		private _cur = null;
		private _curCount = 0;

		//first pass: get count of each item
		{
			_cur = callFunc(_x,getName);
			if isNullReference(_cur) then {continue};
			_allItems set [_cur,(_allItems getOrDefault [_cur,0]) + 1];
		} foreach getSelf(__objRefs);

		{
			_cur = getFieldBaseValueWithMethod(_x,"name","getName");
			_allItems set [_cur,(_allItems getOrDefault [_cur,0]) + 1];
		} foreach getSelf(__objRefs);

		//second pass: get names of items with count postfix
		{
			_cur = callFunc(_x,getName);
			if !(_cur in _allItems) then {continue};

			_curCount = _allItems get _cur;

			if (_curCount > 1) then {
				_names pushBack format["%1 (x%2)",_cur,_curCount];
				_allItems deleteAt _cur;
			} else {
				_names pushBack _cur;
			};
		} foreach getSelf(__objRefs);

		{
			_cur = getFieldBaseValueWithMethod(_x,"name","getName");
			if !(_cur in _allItems) then {continue};

			_curCount = _allItems get _cur;

			if (_curCount > 1) then {
				_names pushBack format["%1 (x%2)",_cur,_curCount];
				_allItems deleteAt _cur;
			} else {
				_names pushBack _cur;
			};
		} foreach getSelf(__typeList);
		assert_str(count _allItems == 0,"Logic error: Unknown game object in task: " + str _allItems);
		_names
	};


endclass

//Унаследовано от базовой задачи а не от GameObjectKindTask, потому что __objRefs имеет несовместимый тип
//! Если это единственная причина почему нельзя использовать наследование то лучше разделить ссылки на предметы и объекты на отдельные хранилища
class(ItemKindTask) extends(TaskBase)

	"
		name:Предметная задача
		desc:Задача, относящаяся к игровым предметам. Например: получение, сохранение и т.д.
		path:Игровая логика.Задачи.Предметные
	" node_class

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
	var(__objRefs,[]); //сюда добавляются глобальные ссылки
	"
		name:Список типов
		desc:Список типов, обрабатываемых задачей.
		prop:all
		return:array[classname]:Массив типов
	" node_var
	var(__typeList,[]);

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

		{
			assert_str(isTypeNameOf(_x,Item),format vec2("Invalid typename %1, must be of type Item",_x));
		} foreach getSelf(__typeList);
	};

	func(processObjectCheck)
	{
		objParams_3(_owner,_funcref,_functypes);

		private _foundNull = false;
		private _counter = 0;
		{
			if isNullReference(_x) then {
				_foundNull = true;
				continue;
			};

			_counter = _counter + ([_owner,_x] call _funcref);
		} foreach getSelf(__objRefs);

		{
			_counter = _counter + ([_owner,_x] call _functypes);
		} foreach getSelf(__typeList);

		if (getSelf(failTaskOnItemDestroy) && _foundNull) exitWith {
			callSelfParams(setTaskResult,getSelf(failResultOnItemDestroy));
		};

		private _custom = [this,_owner] call getSelf(_customCondition);

		if (_counter >= ((count getSelf(__typeList)) + (count getSelf(__objRefs))) && _custom) then {
			callSelfParams(setTaskResult,1);
		};
	};

	"
		name:Провал при удалении предметов
		namelib:Провалить задачу при удалении предметов
		desc:При включении этой опции задача будет автоматически провалена если один или несколько предметов, относящихся к этой задаче были удалены или уничтожены.
		prop:all
		return:bool:Провалить задачу при удалении предметов
	" node_var
	var(failTaskOnItemDestroy,false);

	"
		name:Результат провала при удалении предметов
		namelib:Результат провала при удалении предметов
		desc:Результат провала задачи, устанавливаемый при удалении одного или нескольких предметов, относящихся к этой задаче.
		prop:all
		return:int:Результат провала при удалении предметов
	" node_var
	var(failResultOnItemDestroy,-100);

	"
		name:Список предметов
		desc:Список названий предметов, необходимых для выполнения задачи
		type:get
		lockoverride:1
		return:array[string]:Список названий предметов	
	" node_met
	func(getRequiredItemsNames)
	{
		objParams();
		private _names = [];
		private _allItems = createHashMap;
		private _cur = null;
		private _curCount = 0;

		//first pass: get count of each item
		{
			_cur = callFunc(_x,getName);
			if isNullReference(_cur) then {continue};
			_allItems set [_cur,(_allItems getOrDefault [_cur,0]) + 1];
		} foreach getSelf(__objRefs);

		{
			_cur = getFieldBaseValueWithMethod(_x,"name","getName");
			_allItems set [_cur,(_allItems getOrDefault [_cur,0]) + 1];
		} foreach getSelf(__objRefs);

		//second pass: get names of items with count postfix
		{
			_cur = callFunc(_x,getName);
			if !(_cur in _allItems) then {continue};

			_curCount = _allItems get _cur;

			if (_curCount > 1) then {
				_names pushBack format["%1 (x%2)",_cur,_curCount];
				_allItems deleteAt _cur;
			} else {
				_names pushBack _cur;
			};
		} foreach getSelf(__objRefs);

		{
			_cur = getFieldBaseValueWithMethod(_x,"name","getName");
			if !(_cur in _allItems) then {continue};

			_curCount = _allItems get _cur;

			if (_curCount > 1) then {
				_names pushBack format["%1 (x%2)",_cur,_curCount];
				_allItems deleteAt _cur;
			} else {
				_names pushBack _cur;
			};
		} foreach getSelf(__typeList);
		assert_str(count _allItems == 0,"Logic error: Unknown item in task: " + str _allItems);
		_names
	};

	_tDelegate = {
		private _names = callSelf(getRequiredItemsNames);
		private _origDesc = getSelf(descRoleplay);

		if (count _names == 0) exitWith {
			format[_origDesc,"","ничего"];
		};
		private _itmCnt = "предметы";
		if (count _names == 1) then {_itmCnt="предмет"};
		private _arr = [_origDesc,_itmCnt,_names joinString ", "];
		
		if isTypeOf(this,TaskItemPlace) then {
			_arr pushBack (getSelf(placeName));
		};

		format _arr
	};
	var_exprval(_taskDescDelegate,_tDelegate);

endclass


class(TaskItemGet) extends(ItemKindTask)
	"
		name:Задача получения предметов
		desc:Задача, относящаяся к получение предметов персонажем.
		path:Игровая логика.Задачи.Предметные
	" node_class

	var(name,"Добыча");
	var(desc,"Получить предметы");
	var(descRoleplay,"Мне нужно получить %1: %2");
	
	func(onTaskCheck)
	{
		objParams_1(_owner);
		//params ["_owner","_typeOrReference"]
		
		private _fnRefs = {
			params ["_owner","_it"];
			callFuncParams(_owner,hasItem,_it arg true)
		};
		private _fnTypes = {
			params ["_owner","_it"];
			callFuncParams(_owner,hasItem,_it arg true)
		};

		callSelfParams(processObjectCheck,_owner arg _fnRefs arg _fnTypes);
	};

endclass

class(TaskItemSave) extends(TaskItemGet)
	"
		name:Задача сохранения предметов
		desc:Задача, относящаяся к сохранению предметов персонажем. Под сохранением подразумевается, что перечисленные предметы находятся в инвентаре персонажа до конца раунда.
		path:Игровая логика.Задачи.Предметные
	" node_class

	var(name,"Сохранение");
	var(desc,"Сохранить предметы до конца раунда");
	var(descRoleplay,"Мне нужно сохранить %1: %2");

	getterconst_func(checkCompleteOnEnd,true);
endclass


class(TaskItemPlace) extends(ItemKindTask)
	"
		name:Задача доставки предметов
		desc:Задача, относящаяся к доставке предметов. Для выполнения задачи необходимо доставить предметы в указанную точку.
		path:Игровая логика.Задачи.Предметные
	" node_class

	var(name,"Доставка");
	var(desc,"Поместить предметы в места");
	var(descRoleplay,"Мне нужно поместить %1 в %3: %2");
	
	"
		name:Название месте
		desc:Название места, в которое нужно поместить предметы. Выводится в описании задачи
		prop:all
		return:string:Название места
		defval:Неизвестное место
	" node_var
	var(placeName,"Неизвестное место");

	"
		name:Местоположение предметов
		desc:Требуемое местоположение предметов для успешного выполнения задачи.
		prop:all
		return:vector3:Местоположение
	" node_var
	var(location,vec3(0,0,0));

	"
		name:Радиус
		desc:Радиус, в котором нужно поместить предметы относительно указанного местоположения.
		prop:all
		return:float:Радиус
		defval:1
	" node_var
	var(radius,1);
	
	func(onTaskCheck)
	{
		objParams_1(_owner);
		//params ["_owner","_typeOrReference"]
		private _origPos = getSelf(location);
		private _rad = getSelf(radius);
		private _alreadyCollected = []; //убираем повторы объектов

		private _fnRefs = {
			params ["_owner","_it"];
			(calFunc(_it,getPos) distance _origPos) <= _rad
		};
		private _fnTypes = {
			params ["_owner","_it"];
			private _olist = [_it,_origPos,_rad,true] call getAllItemsOnPosition;
			if (count _olist == 0) exitWith {false};
			private _fsearch = nullPtr;
			{
				if !array_exists(_alreadyCollected,_x) exitWith {
					_alreadyCollected pushBack _x;
					_fsearch = _x;
				};
			} foreach _olist;

			!isNullReference(_fsearch) && {(callFunc(_fsearch,getPos) distance _origPos) <= _rad}
		};

		callSelfParams(processObjectCheck,_owner arg _fnRefs arg _fnTypes);
	};

endclass


//-----------------------------------------------------------

class(MobKindTask) extends(TaskBase)
	"
		name:Задача персонажей
		desc:Задача, относящаяся к сущностям (мобам)
		path:Игровая логика.Задачи.Персонажи
	" node_class
	
	var(name,"Mob task");

	"
		name:Цель
		desc:Цель задачи. Это моб, являющейся целью задачи. Например убийства, спасения и т.д.
		prop:all
		return:Mob^:Сущность - цель задачи
	" node_var
	var(target,nullPtr);

	func(onTaskCheck)
	{
		objParams_1(_owner);

		if isNullReference(getSelf(target)) exitWith {};
		if (callSelf(checkEntityState) && [this,_owner] call getSelf(_customCondition)) then {
			callSelfParams(setTaskResult,1);
		};
	};

	func(checkEntityState)
	{
		objParams();
		true
	};

	private _tDelegate = {
		objParams();
		private _targ = getSelf(target);
		format[getSelf(descRoleplay),callFuncParams(_targ,getNameEx,"кто"),callFuncParams(_targ,getNameEx,"вин")]
	};
	var_exprval(_taskDescDelegate,_tDelegate);
endclass

class(TaskMobKill) extends(MobKindTask)
	var(name,"Убийство");
	var(desc,"Убийство цели");
	var(descRoleplay,"Нужно устранить %2");

	func(checkEntityState)
	{
		objParams();
		getVar(getSelf(target),isDead)
	};
endclass

class(TaskMobSave) extends(MobKindTask)
	var(name,"Сохранить жизнь");
	var(desc,"Сохранить жизнь цели");
	var(descRoleplay,"Нужно сохранить жизнь %2");

	getterconst_func(checkCompleteOnEnd,true);

	func(checkEntityState)
	{
		objParams();
		!getVar(getSelf(target),isDead)
	};
endclass

class(TaskSelfSave) extends(TaskMobSave)
	var(name,"Выжить");
	var(desc,"Выживание");
	var(descRoleplay,"Нужно выжить");

	func(onTaskCheck)
	{
		objParams_1(_owner);
		setSelf(target,_owner);
		super();
	};

endclass

//---------

class(CounterKindTask) extends(TaskBase)
	"
		name:Количественная задача
		desc:Тип задачи, работающий с количеством чего-либо
		path:Игровая логика.Задачи
	" node_class
	
	var(name,"Counter task");

	"
		name:Требуемое количество
		desc:Требуемое количество чего-либо (счетчик задачи)
		prop:all
		defval:1
	" node_var
	var(counter,1);

	
	var(numeralString,vec3("предмет","предмета","предметов"));

	func(getNumeralText)
	{
		objParams();
		[getSelf(counter),getSelf(numeralString),true] call toNumeralString
	};
endclass

class(TaskMoneyGet) extends(CounterKindTask)
	
	var(numeralString,vec3("звяк","предмета","предметов"));

	func(onTaskCheck)
	{
		objParams_1(_owner);

		private _mon = callSelf(getCurrentCountValue);
		if (_mon >= getSelf(counter)) then {
			callSelfParams(setTaskResult,1);
		};
	};

	func(getCurrentCountValue)
	{
		objParams();
		private _monObjs = [getSelf(mob),"Zvak",true] call getAllItemsInInventory;
		private _collected = 0;
		{
			_stackCount = getVar(_x,stackCount);
			if isTypeOf(_x,Bryak) then {
				// увеличиваем цену в 10 раз
				modvar(_stackCount) * 10;
			};

			modvar(_collected) + _stackCount;
		} foreach _monObjs;

		_collected
	};

endclass


class(LocationKindTask) extends(TaskBase)
	"
		name:Локационная задача
		desc:Задача, относящаяся к локациям
		path:Игровая логика.Задачи
	" node_class
	
	var(name,"Location task");

	"
		name:Позиция
		desc:Позиция задачи
		prop:all
		return:vector3:Позиция
	" node_var
	var(position,vec3(0,0,0));

	"
		name:Радиус
		desc:Радиус задачи
		prop:all
		defval:1
		return:float:Радиус
	" node_var
	var(radius,1);

endclass


class(TaskLocationEnter) extends(LocationKindTask)

	var(name,"Вход в локацию");
	var(desc,"Посетить локацию");

	
	func(onTaskCheck)
	{
		objParams_1(_owner);
		if (
			(callFunc(_owner,getPos) distance getSelf(position)) <= getSelf(radius)
			&& [this,_owner] call getSelf(_customCondition)
		) then {
			callSelfParams(setTaskResult,1);
		};
	};

endclass

class(RoleKindTask) extends(TaskBase)
	"
		name:Ролевая задача
		desc:Задача, относящаяся к ролям
		path:Игровая логика.Задачи
	" node_class
	
	var(name,"Role task");

	"
		name:Тип роли
		desc:Тип роли задачи
		prop:all
		return:classname:Тип роли
		restr:ScriptedRole
	" node_var
	var(roleClass,"");

	"
		name:Проверять дочерние роли
		desc:При включении этой опции будет учитываться не только указанный тип роли но и все дочерние роли, унаследованные от указанной роли.
		prop:all
		return:bool:Проверять дочерние роли
		defval:false
	" node_var
	var(checkChildRoles,false);

	_tDelegate = {
		private _role = getSelf(roleClass);
		private _robj = _role call gm_getRoleObject;
		assert_str(!isNullReference(_robj),"Role object not registered in gamemode " + str gm_currentMode);
		format[getSelf(descRoleplay),getVar(_robj,name)]
	};
	var_exprval(_taskDescDelegate,_tDelegate);

endclass

class(TaskGetRole) extends(RoleKindTask)
	"
		name:Получить роль
		desc:Задача на получение роли
		path:Игровая логика.Задачи
	" node_class
	
	var(name,"Получить роль");
	var(descRoleplay,"Получить роль - %1");

	func(onTaskCheck)
	{
		objParams_1(_owner);
		private _robj = getVar(_owner,role);

		if (
			ifcheck(getSelf(checkChildRoles),isTypeStringOf(_robj,getSelf(roleClass)),callFunc(_robj,getClassName) == getSelf(roleClass))
			&& [this,_owner] call getSelf(_customCondition)
		) then {
			callSelfParams(setTaskResult,1);
		};
	};
endclass

class(TaskRoleDead) extends(RoleKindTask)
	var(name,"Убийство ролей");
	var(desc,"Убийство ролей");
	var(descRoleplay,"Устранить - %1");

	"
		name:Нужно погибших на роли
		desc:Количество персонажей, занимавших роль, которые должны погибнуть
		prop:all
		return:int:Количество
		defval:1
	" node_var
	var(countDeadNeed,1);

	func(onTaskCheck)
	{
		objParams_1(_owner);
		private _role = getSelf(roleClass);
		private _robj = _role call gm_getRoleObject;
		if isNullReference(_robj) exitWith {};
		private _count = 0;
		{
			if callFunc(_x,isDead) then {
				INC(_count);
			};
		} foreach getVar(_robj,basicMobs);

		if (_count >= getSelf(countDeadNeed) && [this,_owner] call getSelf(_customCondition)) then {
			callSelfParams(setTaskResult,1);
		};
	};
endclass