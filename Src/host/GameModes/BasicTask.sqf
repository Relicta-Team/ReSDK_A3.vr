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
	Задачи делятся на 2 категории:
	 - проверяемые в конце раунда
	 - проверяемые до успешного выполнения

	Список задач:

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

class(TaskParamsProvider)
	"
		name:Параметры задачи
		desc:Специальный объект, предоставляющий указание параметров для разных типов задач.
		path:Игровая логика.Задачи
	" node_class

	var(itemRefList,[]);
	var(itemGRefList,[]);
	var(itemTypeList,[]);
	
endclass

editor_attribute("ColorClass" arg "1370A2")
class(TBase) extends(IGameEvent)

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
		name:Получить описание задачи
		desc:Функция получения системного описания задачи. По умолчанию возвращает значение свойства описания задачи
		type:get
		lockoverride:1
		return:string:Описание задачи
	" node_met
	getter_func(getDesc,getSelf(getDesc));

	"
		name:Получить ролевое описание задачи
		desc:Функция получения ролевого описания задачи. По умолчанию возвращает значение свойства ролевого описания задачи
		type:get
		lockoverride:1
		return:string:Ролевое описание задачи
	" node_met
	getter_func(getDescRoleplay,getSelf(descRoleplay));
	
	autoref var(_handle,-1); //хандлер для цикла

	var(mob,nullPtr); //владелец этой задачи
	
	"
		name:Задача завершена
		desc:Возвращает ИСТИНУ, если задача завершила выполнение. Провал задачи также считается завершением.
		prop:get
		return:bool:Завершено ли выполнение задачи
		defval:false
	" node_var
	var(isDone,false); //завершена ли задача
	"
		name:Результат задачи
		desc:Возвращает числовое значение результата задачи. Если результат равен нулю, то считается что задача не выполнена.
		prop:get
		return:int:Результат выполнения задачи
		defval:0
	" node_var
	var(result,0); //всё что отлично от 0 является результатом задачи. Принимается правило, что отрицательные значения - провал, положительные - успех
	
	// Если false проверка успеха каждые checkDelay сек а при выполнении условия остановка проверки
	// В ином случае проверка будет осуществлена только в конце раунда
	"
		name:Проверка задачи в конце раунда
		desc:Значение, отвечающее за то когда будет проверен результат выполнения задачи. Если ИСТИНА - задача проверяется с момента получения до выполнения. Если ЛОЖЬ - полученная задача будет проверена только в конце раунда.
	" node_var
	getterconst_func(checkOnlyAfterEndRound,false);

	"
		name:Частота проверки задачи
		desc:Время, через которое выполняется проверка условия выполнения задачи
		type:const
		return:int:Частота проверки условия задачи
		defval:2
	" node_var
	getterconst_func(checkDelay,2);

	// Останавливает процесс проверки результата по выполнению задачи. Работает вкупе с checkOnlyAfterEndRound
	//TODO: rename stopOnSuccess -> stopOnDone
	getter_func(stopOnSuccess,false);
	
	// показывает результат выполнения задачи в конце раунда.
	// По сути является глобальной задачей
	//TODO: implement
	var(showTaskResultOnEndRound,false);

	//возвращает текст результата задачи при активном флаге showTaskResultOnEndRound
	func(taskResultMessage)
	{
		objParams();
		""
	}; 

	//событие вызывается при добавлении задачи на персонажа
	func(onTaskAdded)
	{
		objParams_1(_mob);

		setSelf(mob,_mob);

		taskSystem_allTasks pushBack this;

		callSelfParams(setTag,getSelf(tag));

		if callSelf(checkOnlyAfterEndRound) then {
			taskSystem_checkedOnEndRound pushBack this;
		} else {
			setSelf(_handle,startUpdateParams(getSelfFunc(updateMethod),callSelf(checkDelay),this));
		};
		#ifdef editor_task_test 
			traceformat("[TASK_SYSTEM]: Added %1 to %2",callSelf(getClassName) arg callFuncParams(_mob,getNameEx,"кто"));
		#endif
	};

	func(destructor)
	{
		objParams();
		if (getSelf(tag) != "") then {
			private _tasklist = taskSystem_map_tags getOrDefault [getSelf(tag),[]];
			array_remove(_tasklist,this)
		};
	};

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

	//обработчик входных параметров при создании задачи. 
	func(handleTaskAddedParams)
	{
		objParams_1(_ctx);
	};

	func(processTaskParamsProvider)
	{
		objParams_1(_tpar);
		if (equalTypes(_tpar,nullPtr) && {isTypeOf(_tpar,TaskParamsProvider)}) exitWith {
			private _params = callSelfParams(unpackTaskParamsProvider,_tpar);
			delete(_tpar);
			_params
		};
		_tpar
	};

	func(unpackTaskParamsProvider)
	{
		objParams_1(_t);
		null
	};

	//внутренняя реализация и обработка условий каждые checkDelay секунд
	func(updateMethod)
	{
		updateParams();
		#ifdef editor_task_test 
			traceformat("[TASK_SYSTEM]: Check task -> %1 :: %2",callSelf(getClassName) arg callFuncParams(getSelf(mob),getNameEx,"кто"));
		#endif
		callSelf(checkCondition);
	};

	//завершаем задачу
	func(taskDone)
	{
		objParams_1(_result);
		if (_result == 0) exitWith {
			errorformat("%1::taskDone() - cant stop task. Zero result",callSelf(getClassName));
		};
		
		#ifdef editor_task_test 
			traceformat("[TASK_SYSTEM]: Task done -> %1 :: %2 (as result %3)",callSelf(getClassName) arg callFuncParams(getSelf(mob),getNameEx,"кто") arg _result);
		#endif

		setSelf(result,_result);
		setSelf(isDone,true);

		// поскольку задача остановлена при завершении то сразу выводим результат
		if (_result > 0) then {
			callSelf(onSuccess);
		} else {
			callSelf(onFail);
		};

		if callSelf(stopOnSuccess) then {
			stopUpdate(getSelf(_handle));
			setSelf(_handle,-1);
		};
	};

	/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * \
	|								USER FUNCTIONALITY									|
	\ * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

	/*
		Мы можем создавать задачи двумя способами:
		Унаследовав определенный тип и изменив методы:
			onSuccess,onFail
		либо добавить события к созданному стандартному классу задачи:

	
	*/

	// user event listeners
	var(onFail,[]);
	var(onSuccess,[]);
	
	// проверка условий
	// любое значение возратимое от нуля считается завершением
	// вызовите из этого контекста taskDone чтобы завершить задачу
	func(checkCondition)
	{
		objParams();
		
	};

	// событие при успешном выполнении
	func(onSuccess)
	{
		objParams();
		//? Клиент только текущий подключенный к мобу. Плохо выйдет когда игрок выполнил задачу будучи другим человеком или не находясь на сервере...
		private _params = [this,getSelf(mob),getVar(getSelf(mob),client)];
		_params params ["","_mob","_usr"];
		{
			this call _x;
		} foreach getSelf(onSuccess);
	};

	// событие при провале
	func(onFail)
	{
		objParams();
		private _params = [this,getSelf(mob),getVar(getSelf(mob),client)];
		_params params ["","_mob","_usr"];
		{
			this call _x;
		} foreach getSelf(onFail);
	};

endclass

#define __mbx__(message) ["[TASKS][%1]: %2",callSelf(getClassName) arg message] call messageBox;

#ifndef EDITOR
	#define __mbx__(message)
#endif

#define taskError(message) errorformat("[TASKS][%1]: %2",callSelf(getClassName) arg message); __mbx__(message) nextFrameParams({delete(_this)},this)


//условная задача
class(ConditionalTask) extends(TBase)
	
	var(name,"Выполнить задачу");
	var(desc,"Требуется выполнение задачи");
	var(descRoleplay,"Требуется выполнение задачи");

	// обрабатываемй объект задачи
	var(handledObject,nullPtr);
	var(condition,null);

	func(handleTaskAddedParams)
	{
		objParams_1(_ctx);
		
		_ctx = callSelfParams(processTaskParamsProvider,_ctx);

		if (isNullVar(_ctx) && !isNull(getSelf(condition))) then {
			_ctx = getSelf(condition);
		};

		if equalTypes(_ctx,[]) then {
			setSelf(handledObject,_ctx select 0);
			_ctx = _ctx select 1;
		};
		setSelf(condition,_ctx);
	};

	getter_func(stopOnSuccess,true);

	func(checkCondition)
	{
		objParams();

		private _taskObject = this;
		//unsafe switch context
		this = getSelf(handledObject);
		if (this call getVar(_taskObject,condition)) then {
			this = _taskObject;
			callSelfParams(taskDone,1);
		};

	};

endclass

//задача получения предмета. выполнено когда сущность имеет в наличии предмет
class(ItemGetTask) extends(TBase)

	var(name,"Добыть предмет");
	var(desc,"Нужно заполучить определенные вещи: %1");
	var(descRoleplay,"Мне очень нужно достать кое-что: %1");

	getter_func(getDesc,format[getSelf(getDesc) arg callSelf(itemToClassName)]);
	getter_func(getDescRoleplay,format[getSelf(descRoleplay) arg callSelf(itemToClassName)]);

	func(itemToClassName)
	{
		objParams();
		private _t = [];
		private _itm = null;
		{
			_itm = _x select 0;
			_t pushBack ifcheck(equalTypes(_itm,""), getFieldBaseValueWithMethod(_itm,"name","getName"),callFunc(_itm,getName))
		} foreach getSelf(__serializedItems);
		_t joinString ", "
	};

	/*
		Может быть:
			строкой - имя класса, префикс typeof: означает, что проверяет наследников
			массивом строк - префикс typeof: означает, что проверяет наследников
			ссылкой на объект 
			массивом ссылок на объект
			глобалрефом - требует префикс ref: (получаются системой через getObjectByRef)
			массивом глобалрефов

			массивом из строк,глобалрефов или сырых ссылок
	*/
	//! Небезопасный контекст списка предметов. Рекомендуется добавлять только через интерфейс добавления задачи
	var(item,null);// может быть листом строк или названием класса

	var(__serializedItems,[]); //vec2 name, inherited

	getter_func(stopOnSuccess,true);

	func(handleTaskAddedParams)
	{
		objParams_1(_ctx);
		
		_ctx = callSelfParams(processTaskParamsProvider,_ctx);

		if (isNullVar(_ctx) && isNull(getSelf(item))) exitwith {
			taskError("items data not setted");
		};

		//validate null context param
		if isNullVar(_ctx) then {_ctx = [];};

		if not_equalTypes(_ctx,[]) then {
			_ctx = [_ctx];
		};

		if !isNull(getSelf(item)) then {
			_ctx = _ctx + ifcheck(equalTypes([],getSelf(item)),getSelf(item),[getSelf(item)]);
		};

		private _serialized = getSelf(__serializedItems);

		{
			if equalTypes(_x,"") then {
				private _typename = _x;
				private _inherited = false;
				if ([_typename,"typeof:",false] call stringStartWith) then {
					_inherited = true;
					_typename = [_typename,"^typeof\:",""] call regex_replace;
				};
				if ([_typename,"ref:",false] call stringStartWith) then {
					_inherited = true;
					_typename = [_typename,"^ref\:",""] call regex_replace;
					_typename = _typename call getObjectByRef;
				};

				_serialized pushBack vec2(_typename,_inherited);
				continue;
			};
			if equalTypes(_x,nullPtr) then {
				_serialized pushBack vec2(_x,false);
				continue;
			};
		} foreach _ctx;
	};

	func(checkCondition)
	{
		objParams();
		private _m = getSelf(mob);
		private _itmList = getSelf(__serializedItems);
		private _inh = getSelf(inherited);
		private _itemsCount = 0;
		{
			_x params ["_it","_inh"];
			if callFuncParams(_m,hasItem,_it arg _inh) then {
				INC(_itemsCount);
			};
		} foreach _itmList;

		if (count _itmList == _itemsCount) then {
			callSelfParams(taskDone,1);
		} else {
			if callSelf(checkOnlyAfterEndRound) then {
				callSelfParams(taskDone,-1);
			};
		};
	};

endclass

//задача сохранения предмета. выполнено когда раунд заканчивается и в эквипе юнита есть предмет
class(ItemSaveTask) extends(ItemGetTask)
	var(name,"Добыть предмет");
	var(desc,"Нужно заполучить определенные вещи и сохранить их до конца раунда: %1");
	var(descRoleplay,"Мне очень нужно достать и сохранить до конца смены: %1");

	getter_func(stopOnSuccess,false);
	getterconst_func(checkOnlyAfterEndRound,true);
endclass

//задача на сохранение жизни цели до конца раунда
class(TargetSaveTask) extends(TBase)
	var(name,"Сохранить жизнь");
	var(desc,"Нужно обеспечить безопасность для %1 до конца раунда");
	var(descRoleplay,"Мне нужно сохранить жизнь %1 до конца смены");
	
	getter_func(getDesc,format[getSelf(getDesc) arg callFuncParams(getSelf(target),getNameEx,"кто")]);
	getter_func(getDescRoleplay,format[getSelf(descRoleplay) arg callFuncParams(getSelf(target),getNameEx,"кому")]);

	getter_func(stopOnSuccess,false);
	getterconst_func(checkOnlyAfterEndRound,true);

	var(target,nullPtr);

	func(handleTaskAddedParams)
	{
		objParams_1(_ctx);

		_ctx = callSelfParams(processTaskParamsProvider,_ctx);

		if (isNullVar(_ctx) && isNullReference(getSelf(target))) exitwith {
			taskError("Null context");
		};

		if !isNullVar(_ctx) then {
			setSelf(target,_ctx);
		};
	};

	func(checkCondition)
	{
		objParams();
		if getVar(getSelf(target),isDead) then {
			callSelfParams(taskDone,-1);
		} else {
			callSelfParams(taskDone,1);
		};
	};

endclass

//сохранение собственной жизни до конца раунда
class(SelfSafeTask) extends(TargetSaveTask)
	var(name,"Выжить");
	var(desc,"Нужно дожить до конца раунда");
	var(descRoleplay,"Мне нужно дожить до конца этой смены");

	func(handleTaskAddedParams)
	{
		objParams_1(_ctx);

		_ctx = callSelfParams(processTaskParamsProvider,_ctx);

		setSelf(target,getSelf(mob));
	};
endclass

//задача на смерть цели. выполнено когда удовлетворяет условию
class(TargetDeadTask) extends(TargetSaveTask)
	var(name,"Смерть");
	var(desc,"Цель - %1. Она должна умереть любым способом.");
	var(descRoleplay,"Нужно разобраться кое с кем. %1 не суждено дожить до конца смены.");
	getter_func(stopOnSuccess,true);
	getterconst_func(checkOnlyAfterEndRound,false);
	func(checkCondition)
	{
		objParams();
		if getVar(getSelf(target),isDead) then {
			callSelfParams(taskDone,1);
		//} else {
			//This will be checked on end round
			//callSelfParams(taskDone,-1);
		};
	};
endclass

//TODO: TargetKillTask - отличается от TargetDeadTask тем что убийцей должен быть обязательно владелец задачи

//задача на дислокацию. считается выполненным когда сущность приходит в позицию
class(LocationTask) extends(TBase)
	var(name,"Добраться");
	var(desc,"Нужно добраться до определенного места");
	var(descRoleplay,"Мне нужно добраться до одного места");

	getter_func(stopOnSuccess,true);

	var(pos,null); //TODO: use pos, rpos (string), globalref
	var(maxDistance,1);

	// соглашение о передаче параметров:
	/* 
		vec3() - pos only
		[vec3(),num] - pos and distance
	*/
	func(handleTaskAddedParams)
	{
		objParams_1(_ctx);
		
		_ctx = callSelfParams(processTaskParamsProvider,_ctx);
		
		if (isNullVar(_ctx) && !isNull(getSelf(pos))) then {
			_ctx = getSelf(pos);
		};

		if (isNullVar(_ctx)) exitwith {taskError("null position or type error")};
		
		private _position = null;

		if equalTypes(_ctx,[]) then {
			if (count _ctx == 3) then {
				_position = _ctx;
			} else {
				_position = _ctx select 0;
				setSelf(maxDistance,_ctx select 1);
			};
		} else {
			_position = _ctx;
		};


		if equalTypes(_position,[]) exitwith {
			setSelf(pos,_position);
		};

		//convert position
		call {
			if equalTypes(_position,nullPtr) exitwith {
				_position = callFunc(_position,getPos);
			};
			if ([_position,"pos:"] call stringStartWith) exitWith {
				_position = [(_position splitString ":") select 1] call getSpawnPosByName;
			};
			if ([_position,"ref:"] call stringStartWith) then {
				_position = ((_position splitString ":") select 1);
			};

			_position = callFunc(_position call getObjectByRef,getPos);
		};

		setSelf(pos,_position);
	};

	func(checkCondition)
	{
		objParams();
		if ((callFunc(getSelf(mob),getPos) distance getSelf(pos)) <= getSelf(maxDistance)) then {
			callSelfParams(taskDone,1);
		};
	};
endclass

//задача скопить денег. считается выполненным когда нужная сумма собрана
//TODO MoneySaveTask
class(MoneyGetTask) extends(TBase)
	var(name,"Заработать");
	var(desc,"Нужно заработать %1");
	var(descRoleplay,"Мне нужно накопить %1");

	getter_func(getDesc,format[getSelf(getDesc) arg callSelf(getMoneyText)]);
	getter_func(getDescRoleplay,format[getSelf(descRoleplay) arg callSelf(getMoneyText)]);
	
	getter_func(stopOnSuccess,true);

	func(getMoneyText)
	{
		objParams();
		[getSelf(amount),["звяк","звяка","звяков"],true] call toNumeralString
	};

	var(amount,0);

	func(handleTaskAddedParams)
	{
		objParams_1(_ctx);

		_ctx = callSelfParams(processTaskParamsProvider,_ctx);

		if (isNullVar(_ctx) && !isNull(getSelf(amount))) then {
			_ctx = getSelf(amount);
		};

		if (isNullVar(_ctx) || {not_equalTypes(_ctx,0)} || {_ctx <= 0}) exitwith {
			taskError("null context or wrong type (or not uint)");
		};

		setSelf(amount,_ctx);
	};

	func(checkCondition)
	{
		objParams();
		private _mon = [getSelf(mob),"Zvak",true] call getAllItemsInInventory;
		private _collected = 0;
		private _stackCount = 0;
		{
			_stackCount = getVar(_x,stackCount);
			if isTypeOf(_x,Bryak) then {
				// увеличиваем цену в 10 раз
				modvar(_stackCount) * 10;
			};

			modvar(_collected) + _stackCount;
		} foreach _mon;

		if (_collected >= getSelf(amount)) then {
			callSelfParams(taskDone,1);
		};
	};
endclass



//задача на получение роли
//Считается выполненной когда сущность владеет ролью
class(RoleGetTask) extends(TBase)
	var(name,"Получить должность");
	var(desc,"Требуется занять роль %1");
	var(descRoleplay,"Мне нужно занять должность - %1");
	var(roleClass,"");
	getter_func(getDesc,format[getSelf(getDesc) arg callSelf(getRoleText)]);
	getter_func(getDescRoleplay,format[getSelf(descRoleplay) arg callSelf(getRoleText)]);
	func(getRoleText)
	{
		objParams();
		private _robj = getSelf(roleClass) call gm_getRoleObject;
		if isNullReference(_robj) exitwith {"НЕИЗВЕСТНО"};
		getVar(_robj,name)
	};

	getter_func(stopOnSuccess,true);
	func(handleTaskAddedParams)
	{
		objParams_1(_ctx);
		
		_ctx = callSelfParams(processTaskParamsProvider,_ctx);

		if (isNullVar(_ctx) && getSelf(roleClass)!="") then {
			_ctx = getSelf(roleClass);
		};	

		if (isNullVar(_ctx) || {isNullReference(_ctx call gm_getRoleObject)}) exitwith {
			taskError("null context or wrong role type ");
		};

		setSelf(roleClass,_ctx);
	};

	func(checkCondition)
	{
		objParams();
		if (callFunc(getVar(getSelf(mob),role),getClassName) == getSelf(roleClass)) then {
			callSelfParams(taskDone,1);
		};
	};
endclass

//задача на полуение статус эффекта
class(StatusEffectGetTask) extends(TBase)
	getterconst_func(checkDelay,1); //статус эффекты достаточно быстро улетучиваются и проверка нужна каждый цикл симуляции

	var(statusEffectName,"");

	var(name,"Получить эффект");
	var(desc,"Требуется получить эффект %1");
	var(descRoleplay,"Мне нужно получить %1");
	getter_func(getDesc,format[getSelf(getDesc) arg callSelf(getEffectText)]);
	getter_func(getDescRoleplay,format[getSelf(descRoleplay) arg callSelf(getEffectText)]);
	func(getEffectText)
	{
		objParams();
		getFieldBaseValue(getSelf(statusEffectName),"name")
	};

	getter_func(stopOnSuccess,true);
	func(handleTaskAddedParams)
	{
		objParams_1(_ctx);
		
		_ctx = callSelfParams(processTaskParamsProvider,_ctx);

		if (isNullVar(_ctx) || {isNullReference(typeGetFromString(_ctx))}) exitwith {
			taskError("null context or wrong status effect type");
		};

		setSelf(statusEffectName,_ctx);
	};

	func(checkCondition)
	{
		objParams();
		if callFuncParams(getSelf(mob),hasStatusEffect,getSelf(statusEffectName)) then {
			callSelfParams(taskDone,1);
		};
	};
endclass

//задача на получение реагента
class(ReagentTask) extends(TBase)
	getterconst_func(checkDelay,1); //с реагентами ситуация как и в случае StatusEffectTask
endclass



//кастомная задача. контекст является кодом с параметрами, которые обрабатываются самостоятельно
//! OBSOLETED. Do not use this in new code
class(CustomTask) extends(TBase)

	func(constructor)
	{
		objParams();
	};

	var(checkOnlyAfterEndRound,false);
	var(checkDelay,2);
	var(stopOnSuccess,false);

	var(eventCheckCondition,{});
	var(eventHandleTaskAddedParams,{});
	var(eventOnSuccess,{});
	var(eventOnFail,{});

	getterconst_func(checkOnlyAfterEndRound,getSelf(checkOnlyAfterEndRound));
	getterconst_func(checkDelay,getSelf(checkDelay));
	getter_func(stopOnSuccess,getSelf(stopOnSuccess));
	func(handleTaskAddedParams)
	{
		objParams_1(_ctx);
		
		vec2(this,_ctx) call getSelf(eventHandleTaskAddedParams);
	};

	func(checkCondition)
	{
		objParams();
		this call getSelf(eventCheckCondition);
	};

	func(onSuccess)
	{
		objParams();
		call getSelf(eventOnSuccess);
	};

	func(onFail)
	{
		objParams();
		call getSelf(eventOnFail);
	};
endclass