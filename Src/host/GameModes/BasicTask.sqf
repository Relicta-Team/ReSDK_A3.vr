// ======================================================
// Copyright (c) 2017-2023 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <GameMode.h>

#include <CommonTasks\PublicTasks.sqf>

taskSystem_allTasks = [];
taskSystem_checkedOnEndRound = [];

taskSystem_map_tags = []; //map of all tagged tasks

taskSystem_getAllTasksByTag = {
	taskSystem_map_tags getOrDefault [_this,[]];
};

taskSystem_getFirstTaskByTag = {
	private _taskList = taskSystem_map_tags getOrDefault [_this,[]];
	if (count _taskList == 0) exitWith {nullPtr};
	_taskList select 0
};

#ifdef EDITOR
	#define editor_task_test
#endif

/* 
	Задачи делятся на 2 категории:
	 - проверяемые в конце раунда
	 - проверяемые до успешного выполнения
*/

editor_attribute("ColorClass" arg "1370A2")
class(TBase) extends(IGameEvent)
	var(tag,"");//системный тэг задачи
	
	var(name,"Задача");
	var(desc,"Сделать дело");
	var(descRoleplay,"Нужно сделать дело...");

	getter_func(getDesc,getSelf(getDesc));
	getter_func(getDescRoleplay,getSelf(descRoleplay));
	
	autoref var(_handle,-1); //хандлер для цикла

	var(mob,nullPtr); //владелец этой задачи
	
	var(isDone,false); //завершена ли задача
	var(result,0); //всё что отлично от 0 является результатом задачи. Принимается правило, что отрицательные значения - провал, положительные - успех
	
	// Если false проверка успеха каждые checkDelay сек а при выполнении условия остановка проверки
	// В ином случае проверка будет осуществлена только в конце раунда
	getterconst_func(checkOnlyAfterEndRound,false);
	getterconst_func(checkDelay,2);

	// Останавливает процесс проверки результата по выполнению задачи. Работает вкупе с checkOnlyAfterEndRound
	//TODO: rename stopOnSuccess -> stopOnDone
	getter_func(stopOnSuccess,false);
	
	// показывает результат выполнения задачи в конце раунда.
	// По сути является глобальной задачей
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
		if callSelf(checkOnlyAfterEndRound) then {
			taskSystem_checkedOnEndRound pushBack this;
		} else {
			setSelf(_handle,startUpdateParams(getSelfFunc(updateMethod),callSelf(checkDelay),this));
		};
		#ifdef editor_task_test 
			traceformat("[TASK_SYSTEM]: Added %1 to %2",callSelf(getClassName) arg callFuncParams(_mob,getNameEx,"кто"));
		#endif
	};

	func(setTag)
	{
		objParams_1(_tagName);
		private _oldTag = getSelf(tag);
		if array_exists(taskSystem_map_tags,_oldTag) then {
			private _tasksByTag = (taskSystem_map_tags get _oldTag);
			_tasksByTag deleteAt (_tasksByTag find this);
		};

		setSelf(tag,_tagName);
		(taskSystem_map_tags get _tagName) pushBack this;
	};

	//обработчик входных параметров при создании задачи. 
	func(handleTaskAddedParams)
	{
		objParams_1(_ctx);
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

		if callSelf(stopOnSuccess) then {

			// поскольку задача остановлена при завершении то сразу выводим результат
			if (_result > 0) then {
				callSelfParams(onSuccess,_result);
			} else {
				callSelfParams(onFail,_result);
			};

			setSelf(isDone,true);

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
			getReward,checkCondition,onSuccess,onFail
		либо добавить события к созданному стандартному классу задачи:

	
	*/

	// user event listeners
	var(onReward,[]);
	var(onFail,[]);
	var(onSuccess,[]);
	
	var(onCheckCondition,[]);

	// Событие при получении награды за выполненную задачу
	func(getReward)
	{
		objParams();
		{
			this call _x;
		} foreach getSelf(onReward);
	};
	
	// проверка условий
	// любое значение возратимое от нуля считается завершением
	// вызовите из этого контекста taskDone чтобы завершить задачу
	func(checkCondition)
	{
		objParams();
		{
			this call _x;
		} foreach getSelf(onCheckCondition);
	};

	// событие при успешном выполнении
	func(onSuccess)
	{
		objParams_1(_val);
		{
			[this,_val] call _x;
		} foreach getSelf(onSuccess);
	};

	// событие при провале
	func(onFail)
	{
		objParams_1(_val);
		{
			[this,_val] call _x;
		} foreach getSelf(onFail);
	};

endclass



#define taskError(message) errorformat("[TASKS][%1]: %2",callSelf(getClassName) arg message); nextFrameParams({delete(_this)},this)

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
		{
			_t pushBack ifcheck(equalTypes(_x,""), getFieldBaseValueWithMethod(_x,"name","getName"),callFunc(_x,getName))
		} foreach getSelf(item);
		_t joinString ", "
	};

	var(item,null);// может быть листом строк или названием класса
	var(inherited,true); //true если предмет наследуется. false сравнивает по названию класса

	//var(_isSingleItem,false); //системная переменная, указывающая что предмет проверяется в еденичном экземпляре

	getter_func(stopOnSuccess,true);

	func(handleTaskAddedParams)
	{
		objParams_1(_ctx);
		
		if (isNullVar(_ctx) && isNull(getSelf(item))) exitwith {
			taskError("items data not setted");
		};

		private _defaultInherited = getSelf(inherited);
		if equalTypes(_ctx,"") then {
			setSelf(item,[_ctx]);
			setSelf(inherited,[_defaultInherited]);
		} else {
			private _items = [];
			private _inherited = [];
			if (count _ctx == 2 && {
					(
						equalTypes(_ctx select 0,"") ||
						equalTypes(_ctx select 0,nullPtr)
					) && 
					equalTypes(_ctx select 1,false)
				}) exitWith {
				_items pushBack (_ctx select 0);
				_inherited pushBack (_ctx select 1);
				setSelf(item,_items);
				setSelf(inherited,_inherited);
			};

			{
				if equalTypes(_x,[]) then {
					_items pushBack (_x select 0);
					_inherited pushBack (_x select 1);
				} else {
					_items pushBack _x;
					_inherited pushback _defaultInherited;
				};
			} foreach _ctx;

			setSelf(item,_items);
			setSelf(inherited,_inherited);
		};
	};

	func(checkCondition)
	{
		objParams();
		private _m = getSelf(mob);
		private _itm = getSelf(item);
		private _inh = getSelf(inherited);
		private _itemsCount = 0;
		{
			if callFuncParams(_m,hasItem,_x arg _inh select _foreachindex) then {
				INC(_itemsCount);
			};
		} foreach _itm;

		if (count _itm == _itemsCount) then {
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

		if isNullVar(_ctx) exitwith {
			taskError("Null context");
		};

		setSelf(target,_ctx);
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
		setSelf(target,getSelf(mob));
	};
endclass

//задача на смерть цели. выполнено когда удовлетворяет условию
class(TargetDeadTask) extends(TargetSaveTask)
	var(name,"Смерть");
	var(desc,"Цель - %1. Она должна умереть любым способом.");
	var(descRoleplay,"Нужно разобраться кое с кем. Цель %1 не должна выжить.");
	getter_func(stopOnSuccess,true);
	getterconst_func(checkOnlyAfterEndRound,false);
	func(checkCondition)
	{
		objParams();
		if getVar(getSelf(target),isDead) then {
			callSelfParams(taskDone,1);
		} else {
			callSelfParams(taskDone,-1);
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

	var(pos,vec3(0,0,0));
	var(maxDistance,1);

	// соглашение о передаче параметров:
	/* 
		vec3() - pos only
		[vec3(),num] - pos and distance
	*/
	func(handleTaskAddedParams)
	{
		objParams_1(_ctx);
		
		if (isNullVar(_ctx) || {not_equalTypes(_ctx,[])}) exitwith {taskError("null position or type error")};
		
		if (count _ctx == 3) then {
			setSelf(pos,_ctx);
		} else {
			setSelf(pos,_ctx select 0);
			setSelf(maxDistance,_ctx select 1);
		};
	};

	func(checkCondition)
	{
		objParams();
		if ((callFunc(getSelf(mob),getPos) distance getSelf(pos)) <= getSelf(maxDistance)) then {
			callSelfParams(taskDone,1);
		};
	};
endclass

//кастомная задача. контекст является кодом с параметрами, которые обрабатываются самостоятельно
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
		objParams_1(_val);
		call getSelf(eventOnSuccess);
	};

	func(onFail)
	{
		objParams_1(_val);
		call getSelf(eventOnFail);
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
		if (isNullVar(_ctx) || {not_equalTypes(_ctx,0)} || {_ctx <= 0}) exitwith {
			taskError("null context or wrong type (or not uint)");
		};

		setSelf(amount,_ctx);
	};

	func(checkCondition)
	{
		objParams();
		private _mon = [getSelf(mob),"Zvak",true] call getAllItemInInventory;
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