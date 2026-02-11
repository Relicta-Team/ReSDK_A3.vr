// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

//! кастомная задача для обратной совместимости
editor_attribute("NodeClass") //internal attribute - no collect to renode
class(TaskCustom) extends(TaskBase)
	var(checkCompleteOnEnd,false);
	getter_func(checkCompleteOnEnd,getSelf(checkCompleteOnEnd));

	func(onTaskCheck)
	{
		objParams_1(_owner);
		if ([this,_owner] call getSelf(_customCondition)) then {
			callSelfParams(setTaskResult,1);
		};
	};

endclass


class(GameObjectKindTask) extends(TaskBase)

	"
		name:Объектная задача
		desc:Задача, относящаяся к игровым объектам. Например\: получение, сохранение и т.д.
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

	var(__requireValidation,true); //флаг требования валидации. Ресетится когда передаются новые глобальные ссылки

	func(__convertGlobalRefsToObjects)
	{
		objParams();
		private _lvals = [];
		private _refto = null;
		{
			_refto = [_x] call getObjectByRef;
			assert_str(!isNullReference(_refto),format vec2("Null reference: %1; Global reference '%1' not found or object was deleted",_x));
			_lvals pushBack _refto;
		} foreach getSelf(__globalRefs);

		if (count _lvals > 0) then {
			getSelf(__objRefs) append _lvals;
			setSelf(__requireValidation,true);
			setSelf(__globalRefs,[]); //reset globalrefs
		};

	};

	//type checkers and outputs
	getterconst_func(__onerr_requiredTypeStr,"GameObject");
	func(checkTypeReference) { objParams_1(_o); isTypeOf(_o,GameObject) };
	func(checkTypeName) { objParams_1(_o); isTypeNameOf(_o,GameObject) };

	func(__validateInputs)
	{
		objParams();
		{
			assert_str(!isNullReference(_x),"Null reference " + callSelf(__onerr_requiredTypeStr));
			
			if !callSelfParams(checkTypeReference,_x) then {
				assert_str(false,format vec2("Invalid global reference. Object must be of type %2, not %1",callFunc(_x,getClassName) arg callSelf(__onerr_requiredTypeStr)));
			};
		} forEach getSelf(__objRefs);

		{
			if !callSelfParams(checkTypeName,_x) then {
				assert_str(false,format vec2("Invalid typename %1, must be of type %2",_x arg callSelf(__onerr_requiredTypeStr)));
			};
		} foreach getSelf(__typeList);

		setSelf(__requireValidation,false);
	};

	func(processObjectCheck)
	{
		objParams_3(_owner,_funcref,_functypes);

		//validation process
		if (count getSelf(__globalRefs) > 0) then {
			callSelf(__convertGlobalRefsToObjects);
		};
		if getSelf(__requireValidation) then {
			callSelf(__validateInputs);
		};

		private _foundNull = false;
		private _counter = 0;
		{
			if isNullReference(_x) then {
				_foundNull = true;
				continue;
			};
			if ([_owner,_x] call _funcref) then {
				_counter = _counter + 1;
			};
		} foreach getSelf(__objRefs);

		{
			if ([_owner,_x] call _functypes) then {
				_counter = _counter + 1;
			};
		} foreach getSelf(__typeList);

		if (getSelf(failTaskOnItemDestroy) && _foundNull) then {
			callSelfParams(setTaskResult,getSelf(failResultOnItemDestroy));
		};
		
		private _custom = [this,_owner] call getSelf(_customCondition);
		if (_counter >= ((count getSelf(__typeList)) + (count getSelf(__objRefs))) && _custom) then {
			callSelfParams(setTaskResult,1);
		};
	};

	func(onTaskCheck)
	{
		objParams_1(_owner);
		//params ["_owner","_typeOrReference"]
		
		if ([this,_owner] call getSelf(_customCondition)) then {
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
			if isNullReference(_x) then {continue};
			_cur = callFunc(_x,getName);
			if isNullVar(_cur) then {continue};
			_allItems set [_cur,(_allItems getOrDefault [_cur,0]) + 1];
		} foreach getSelf(__objRefs);

		{
			_cur = getFieldBaseValueWithMethod(_x,"name","getName");
			_allItems set [_cur,(_allItems getOrDefault [_cur,0]) + 1];
		} foreach getSelf(__typeList);

		//second pass: get names of items with count postfix
		{
			_cur = callFunc(_x,getName);
			if !(_cur in _allItems) then {continue};

			_curCount = _allItems get _cur;

			if (_curCount > 1) then {
				_names pushBack format["%1 (x%2)",_cur,_curCount];
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
			} else {
				_names pushBack _cur;
			};
			
		} foreach getSelf(__typeList);
		
		_names
	};
	
endclass

class(ItemKindTask) extends(GameObjectKindTask)

	"
		name:Предметная задача
		desc:Задача, относящаяся к игровым предметам. Например\: получение, сохранение и т.д.
		path:Игровая логика.Задачи.Объектные
	" node_class

	var(name,"Item task");

	getterconst_func(__onerr_requiredTypeStr,"Item");
	func(checkTypeReference) { objParams_1(_o); isTypeOf(_o,Item) };
	func(checkTypeName) { objParams_1(_o); isTypeNameOf(_o,Item) };

	func(getRequiredItemsNames)
	{
		objParams();
		private _names = [];
		{
			_names pushBack callFunc(_x,getName);
		} foreach getSelf(__objRefs);

		{
			_names pushBack getFieldBaseValueWithMethod(_x,"name","getName");
		} foreach getSelf(__typeList);
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
		path:Игровая логика.Задачи.Объектные
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
		path:Игровая логика.Задачи.Объектные
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
		path:Игровая логика.Задачи.Объектные
	" node_class

	var(name,"Доставка");
	var(desc,"Поместить предметы в места");
	var(descRoleplay,"Мне нужно поместить %1 в %3: %2");
	
	"
		name:Название места
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
		defval:10
	" node_var
	var(radius,10);
	
	func(onTaskCheck)
	{
		objParams_1(_owner);
		//params ["_owner","_typeOrReference"]
		private _origPos = getSelf(location);
		private _rad = getSelf(radius);
		private _alreadyCollected = []; //убираем повторы объектов

		private _fnRefs = {
			params ["_owner","_it"];
			(callFunc(_it,getPos) distance _origPos) <= _rad
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
		path:Игровая логика.Задачи.Количественные
	" node_class
	
	var(name,"Counter task");
	var(descRoleplay,"Нужно накопить %1");
	"
		name:Требуемое количество
		desc:Требуемое количество чего-либо (счетчик задачи)
		prop:all
		defval:1
	" node_var
	var(counter,1);

	"
		name:Количественные названия
		desc:Количественные названия чего-либо.
		prop:all
		defval:['предмет','предмета','предметов']
		return:struct.NumeralString
	" node_var
	var(numeralString,vec3("предмет","предмета","предметов"));

	func(getNumeralText)
	{
		objParams();
		[getSelf(counter),getSelf(numeralString),true] call toNumeralString
	};

	_tDelegate = {
		format[getSelf(descRoleplay),callSelf(getNumeralText)]
	};
	var_exprval(_taskDescDelegate,_tDelegate);
endclass

class(TaskMoneyGet) extends(CounterKindTask)
	var(name,"Заработать");
	var(descRoleplay,"Нужно накопить %1");

	var(numeralString,vec3("звяк","звяка","звяков"));

	func(onTaskCheck)
	{
		objParams_1(_owner);

		private _mon = callSelfParams(getCurrentCountValue,_owner);
		if (_mon >= getSelf(counter) && [this,_owner] call getSelf(_customCondition)) then {
			callSelfParams(setTaskResult,1);
		};
	};

	func(getCurrentCountValue)
	{
		objParams_1(_m);
		private _monObjs = [_m,"Zvak",true] call getAllItemsInInventory;
		private _collected = 0;
		private _stackCount = 0;
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
		path:Игровая логика.Задачи.Локационные
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
		path:Игровая логика.Задачи.Ролевые
	" node_class
	
	var(name,"Role task");

	"
		name:Тип роли
		desc:Тип роли задачи
		prop:all
		return:classname:Тип роли
		defval:ScriptedRole
		restr:ScriptedRole
	" node_var
	var(roleClass,"ScriptedRole");

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
		path:Игровая логика.Задачи.Ролевые
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
	"
		name:Убийство ролей
		desc:Задача на убийство ролей
		path:Игровая логика.Задачи.Ролевые
	" node_class
	var(name,"Убийство должностного лица");
	var(desc,"Убийство роли");
	var(descRoleplay,"Устранить - %1");

	func(onTaskCheck)
	{
		objParams_1(_owner);
		private _role = getSelf(roleClass);
		private _robj = nullPtr;
		private _found = false;

		private _arrRoles = [_role];
		if getSelf(checkChildRoles) then {
			_arrRoles = getAllObjectsTypeOfStr(_role);
			_arrRoles pushBackUnique _role;
		};
		
		{
			_robj = _x call gm_getRoleObject;
			if isNullReference(_robj) then {continue};

			{
				if getVar(_x,isDead) exitWith {_found = true;};
			} foreach getVar(_robj,basicMobs);

			if (!_found) then {
				{
					if getVar(_x,isDead) exitWith {_found = true};
				} foreach getVar(_robj,mobs);
			};

			if (_found) exitWith {};
		} foreach _arrRoles;

		if (_found && [this,_owner] call getSelf(_customCondition)) then {
			callSelfParams(setTaskResult,1);
		};		
	};
endclass