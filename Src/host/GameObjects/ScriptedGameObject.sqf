// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include "..\engine.hpp"
#include "..\oop.hpp"


class(ScriptedGameObject) extends(object)
	"
		name:Скрипт игрового объекта
		desc:Базовый скрипт игрового объекта для реализации пользовательской логики.
		path:Игровые объекты.Скриптовые
	" node_class

	"
		name:Название скрипта
		desc:Внутреннее название скрипта для игрового объекта.
		prop:all
		classprop:1
		return:string:Название скрипта
		defval:Скрипт игрового объекта
	" node_var
	var(name,"Скрипт игрового объекта");

	"
		name:Владелец скрипта
		desc:Игровой объект, к которому привязан скрипт.
		prop:get
		return:IDestructible^:Игровой объект.
	" node_var
	var(src,nullPtr);

	"
		name:Ограничения типов
		desc:Какие типы игровых объектов могут владеть этим скриптом. "+
		"При указании класса для ограничения используется наследование. Например, указав класс Item все типы, унаследованные от него (например, свеча) могут так же использовать этот скрипт.
		type:const
		classprop:1
		return:array[classname]:Список ролей, доступных в режиме.
		defval:[""IDestructible""]
		restr:IDestructible
	" node_met
	getter_func(getRestrictions,["IDestructible"]);

	// ------------------------------ common setup -------------------------------
	//auto add script to all objects - когда создается первый объект такого скрипта он апллаится ко всем объектам указанного типа
	"
		name:Применить ко всем объектам
		desc:Создает экземпляры скрипта для всех игровых объектов, являющихся типами (или их наследниками), указанных в ограничениях типов. Применение происходит когда хотя бы один игровой объект получил созданный скрипт, либо скрипт указан в объектах карты.
		type:const
		classprop:1
		return:bool:Автоприменение скрипта
		defval:false
	" node_met
	getterconst_func(addScriptToAllObjects,false);

	// ------------------------------------------- logic -------------------------------------------

	func(assignScript)
	{
		objParams_1(_src);

		assert_str(!isNullVar(_src),"Internal param error; Script source is null");
		assert_str(!isNullReference(_src),"Source object is null reference");
		assert_str(isTypeOf(_src,IDestructible),"Script must be assigned to IDestructible instance");
		assert_str(!isTypeOf(_src,BasicMob),"Script cannot be assigned to mob or entity");

		assert_str(isNullReference(getVar(_src,__script)),"Script already assigned to object " + str _src);

		if isNullReference(_src) exitWith {};
		if !isTypeOf(_src,IDestructible) exitWith {};
		if isTypeOf(_src,BasicMob) exitWith {};
		private _canUse = false;
		private _restrList = callSelf(getRestrictions);
		{
			if isTypeStringOf(_src,_x) exitWith {
				_canUse = true;
			};
		} foreach _restrList;

		if (!_canUse) exitWith {
			setLastError("Script " + callSelf(getClassName) + " cannot be assigned to game object " + callFunc(_src,getClassName));
		};
		

		setVar(_src,__script,this);
		setSelf(src,_src);

		if getSelf(tickMode) then {
			setSelf(tickMode,false); //bypass validation inside setTickMode
			callSelfParams(setTickMode,true);
		};

		callSelfParams(onScriptAssigned,_src);

		callSelf(_handleParameters);
	};

	"
		name:Скрипт присвоен
		desc:Выполняется когда скрипт присваивается игровому объекту.
		type:event
		out:IDestructible^:Объект:Игровой объект, к которому привязан скрипт.
	" node_met
	func(onScriptAssigned)
	{
		objParams_1(_obj);
	};

region(Updates)
	"
		name:В каждую секунду
		desc:Событие, вызываемое каждую секунду.
		type:event
	" node_met
	func(_onTickWrapper)
	{
		objParams();
	};

	func(onTick)
	{
		updateParams();
		callSelf(_onTickWrapper);
	};

	"
		name:Переключить ежесекундное событие
		desc:Запускает или останавливает ежесекундное событие ""В каждую секунду"".
		type:method
		lockoverride:1
		in:bool:Включить:Если указана @[bool ИСТИНА], то событие будет запущено. В ином случае - остановлено. При попытке включения уже рабочего процесса обновления или выключения нерабочего - ничего не произойдёт.
	" node_met
	func(setTickMode)
	{
		objParams_1(_tickMode);
		if equals(_tickMode,getSelf(tickMode)) exitWith {};
		
		if (_tickMode) then {
			setSelf(__tickHandle__,startSelfUpdate(onTick))
		} else {
			stopUpdate(getSelf(__tickHandle__));
			setSelf(__tickHandle__,-1);
		};

		setSelf(tickMode,_tickMode);
	};

	"
		name:Выполнять ежесекундное событие
		desc:Отвечает за то, будет ли выполняться событие ""В каждую секунду"".
		prop:get
		classprop:1
		defval:false
		return:bool
	" node_var
	var(tickMode,false);

	var(__tickHandle__,-1);


	//Действия персонажа к объекту
region(Main action)
	"
		name:При основном действии
		namelib:При основном действии
		desc:Срабатывает при исполнении персонажем основного действия с объектом (при нажатии кнопки ""Е""). "+
		"Основное действие выполняется, если персонаж может его выполнить. "+
		"Для этого он должен быть в сознании и у него должна быть рука, которой производится действие.
		type:event
		out:BasicMob:Персонаж:Тот, кто выполняет действие по отношению к объекту.
	" node_met
	func(_onMainActionWrapper)
	{
		objParams_1(_usr);
		callSelfParams(callBaseMainAction,_usr);
	};

	func(onMainAction)
	{
		objParams_1(_usr);
		callSelfParams(_onMainActionWrapper,_usr);
	};
	
	"
		name:Основное действие
		desc:Базовая логика основного действия, определенная в игровом объекте.
		type:method
		lockoverride:1
	" node_met
	func(callBaseMainAction)
	{
		params ['this'];
		assert_str(!isNullVar(_usr),"Internal error on call base main action - user not defined");
		callFuncParams(getSelf(src),onMainAction,_usr);
	};

	"
		name:Текст основного действия
		desc:Название основного действия, выводимого в окне при нажатии ""ПКМ"" по объекту.
		prop:all
		classprop:1
		return:string:Текст основного действия
		defval:Основное действие
	" node_var
	var(mainActionName,"Основное действие");

	"
		name:Получить текст основного действия
		desc:Данный узел предоставляет возможность гибкой настройки отображаемого названия основного действия при нажатии ""ПКМ"". Например, с помощью этого узла можно выводить ""Включить лампочку"" или ""Выключить лампочку"" в зависимости от состояния игрового объекта, на который назначен скрипт (в этом примере таким объектом является лампочка). "+
		"По умолчанию возвращает значение свойства ""Текст основного действия"".
		type:event
		out:BasicMob:Персонаж:Тот, кто запрашивает текст основного действия.
		return:string:Текст основного действия
	" node_met
	func(_getMainActionNameWrapper)
	{
		objParams_1(_usr);
		getSelf(mainActionName)
	};

	func(getMainActionName)
	{
		objParams_1(_usr);
		callSelfParams(_getMainActionNameWrapper,_usr);
	};

	"
		name:Текст основного действия объекта
		desc:Возвращает текстовое название основного действия, предоставляемое логикой игрового объекта и выводимого в окне при нажатии ""ПКМ"" по объекту.
		type:method
		lockoverride:1
		return:string:Текст основного действия игрового объекта
	" node_met
	func(callBaseGetMainActionName)
	{
		objParams();
		private _r = callFunc(getSelf(src),getMainActionName);
		if isNullVar(_r) then {_r = ""};
		if not_equalTypes(_r,"") then {_r = ""};
		_r
	};
region(Extra action)
	"
		name:При особом действии
		namelib:При особом действии
		desc:Срабатывает при исполнении персонажем особого действия с объектом (при нажатии кнопки ""F"" с включенным спец.действием).
		type:event
		out:BasicMob:Персонаж:Тот, кто выполняет действие по отношению к объекту.
		out:enum.SpecialActionType:Тип действия:Тип специального действия
	" node_met
	func(_onExtraActionWrapper)
	{
		objParams_2(_usr,_act);
		callSelfParams(callBaseExtraAction,_usr arg _act);
	};

	func(onExtraAction)
	{
		objParams_2(_usr,_act);
		if isNullVar(_act) then {
			_act = getVar(_usr,specialAction);
		};
		callSelfParams(_onExtraActionWrapper,_usr arg _act);
	};

	"
		name:Особое действие
		desc:Базовая логика особого действия, определенная в игровом объекте.
		type:method
		lockoverride:1
	" node_met
	func(callBaseExtraAction)
	{
		params ['this'];
		assert_str(!isNullVar(_usr),"Internal error on call base extra action - user not defined");
		callFuncParams(_usr,extraAction,getSelf(src));
	};

region(Common interactions)

	// --------------- generic interactions -----------------------

region(InteractWith)
	"
		name:При взаимодействии предметом
		desc:Срабатывает при взаимодействии персонажа с объектом при помощью другого предмета. 
		type:event
		out:Item:Предмет:Предмет, используемый для взаимодействия с владельцем этого скрипта.
		out:BasicMob:Персонаж:Персонаж, выполняющий взаимодействие.
		out:bool:Боевой режим:Возвращает истину, если взаимодействие произведено в боевом режиме.
		out:bool:В инвентаре:Возвращает истину, если взаимодействие применено к объекту, находящемуся в инвентаре.
	" node_met
	func(_onInteractWithWrapper)
	{
		objParams_4(_with,_usr,_combat,_inventory);
		callSelf(callBaseInteractWith);
	};

	func(onInteractWith)
	{
		objParams_4(_with,_usr,_combat,_inventory);
		callSelfParams(_onInteractWithWrapper,_with arg _usr arg _combat arg _inventory);
	};

	"
		name:Взаимодействие предметом
		desc:Основная логика взаимодействия с объектом с помощью предмета.
		type:method
		lockoverride:1
	" node_met
	func(callBaseInteractWith)
	{
		params ['this'];
		callSelf(callBaseClickTarget);
	};

region(redirected interact)
	//Этот раздел предназначен для вызова действий на объекте (работает по аналогии с interactTo)
	// interactTo (_target,_usr,_combat,_inventory) - нелогично

	// "
	// 	name:При взаимодействии с целью
	// 	desc:Вызывается при взаимодействии с целью с помощью предмета в активной руке (""ЛКМ"" с предметом по цели). Для работы этой точки входа вместо ""При взаимодействии с целью"" включите свойство ""Перенаправлять взаимодействие"".
	// 	type:event
	// 	out:GameObject:Цель:Игровой объект, к которому применено действие.
	// 	out:BasicMob:Персонаж:Тот, кто инициировал действие по отношению к цели.
	// " node_met
	// func(_interactToWrapper)
	// {
	// 	objParams_2(_target,_usr);
	// };

	// func(interactTo)
	// {
	// 	objParams_2(_target,_usr);
	// 	callSelfParams(_interactToWrapper,_target arg _usr);
	// };

	// func(callBaseInteractTo)
	// {
	// 	objParams();
	// 	callSelf(callBaseClickTarget);
	// };

region(Verbs visible)

	"
		name:Можно видеть ПКМ действия
		desc:Обработчик видимости базовых действий, получаемых из ПКМ меню объекта.
		type:event
		out:BasicMob:Персонаж:Персонаж, выполняющий нажатие.
		out:string:Действие:Тип действия. Например ""pickup"", ""twohands"" и т.д. Полный список зарегистрированных ПКМ действий можно посмотреть в ""src\\host\\VerbSystem\\verbsDefine.sqf""
		return:bool:Будет ли видно действие в ПКМ меню
	" node_met
	func(_canSeeVerb)
	{
		objParams_2(_usr,_verbClass);
		true
	};
	func(canSeeVerb)
	{
		objParams_2(_usr,_verbClass);
		callSelfParams(_canSeeVerb,_usr arg _verbClass)
	};

region(OnClick)
	"
		name:При нажатии
		desc:Срабатывает при взаимодействии персонажа по объекту пустой рукой (при нажатии ""ЛКМ"").
		type:event
		out:BasicMob:Персонаж:Персонаж, выполняющий нажатие.
		out:bool:Боевой режим:Возвращает истину, если нажатие произведено в боевом режиме.
		out:bool:В инвентаре:Возвращает истину, если нажатие произведено по предмету в инвентаре.
	" node_met
	func(_onClickWrapper)
	{
		objParams_3(_usr,_isCombatAction,_isInventoryAction);
		callSelf(callBaseOnClick);
	};

	func(onClick)
	{
		objParams_3(_usr,_isCombatAction,_isInventoryAction);
		callSelfParams(_onClickWrapper,_usr arg _isCombatAction arg _isInventoryAction );
	};

	"
		name:Нажатие
		desc:Основная логика нажатия на объект.
		type:method
		lockoverride:1
	" node_met
	func(callBaseOnClick)
	{
		params ['this'];
		callSelf(callBaseClickTarget);
	};

region(ItemClick)
	"
		name:При нажатии в активной руке
		desc:Срабатывает при нажатии персонажа по предмету в инвентаре, находящемуся в активной руке.
		type:event
		out:Item:Предмет:Предмет, по которому выполняется нажатие (Он же владелец скрипта).
		out:BasicMob:Персонаж:Персонаж, выполняющий нажатие.
		out:bool:Боевой режим:Возвращает истину, если нажатие произведено в боевом режиме.
	" node_met
	func(_onItemSelfClickWrapper)
	{
		objParams_3(_src,_usr,_combat);
		callSelf(callBaseItemSelfClick);
	};

	func(onItemSelfClick)
	{
		objParams_2(_usr,_combat);
		private _src = getSelf(src);
		callSelfParams(_onItemSelfClickWrapper,_src arg _usr arg _combat);
	};

	"
		name:Нажатие в активной руке
		desc:Основная логика нажатия по предмету в активной руке.
		type:method
		lockoverride:1
	" node_met
	func(callBaseItemSelfClick)
	{
		params ['this'];
		callSelf(callBaseClickTarget);
	};

	func(callBaseClickTarget)
	{
		objParams();
		assert_str(!isNullVar(_usr),"Internal error - user reference not defined");
		assert_str(!isNullReference(_usr),"Internal error - user reference null");
		assert_str(!isNullVar(_targ),"Internal error - target reference not defined");
		private __SKIP_CLICK_TARGET_FLAG__ = true;
		callFuncParams(_usr,clickTarget,_targ);
	};

region(Scripted parameters)
	var(_parameters,[]);//value is [float,bool,string]
	var(_cachedParameters,null);

	"
		name:Имеет параметр
		desc:Проверяет был ли зарегистрирован параметр с указанным именем в скрипте.
		type:get
		lockoverride:1
		in:string:Название:Название параметра.
		return:bool:Есть ли параметр
	" node_met
	func(hasParameter)
	{
		objParams_1(_name);
		if !callSelf(scriptParamsCacheLoaded) then {
			callSelf(_prepareParameters);
		};
		_name in getSelf(_cachedParameters);
	};

	getter_func(scriptParamsCacheLoaded,!isNull(getSelf(_cachedParameters)));

	"
		name:При параметре
		desc:Обработчик значения параметров переданных скрипту.
		type:event
		out:string:Название:Название параметра.
		out:float:Как число:Значение параметра как дробное число.
		out:bool:Как булево:Значение параметра как булево.
		out:string:Как строка:Значение параметра как строка.
	" node_met
	func(onParameter)
	{
		objParams_4(_name,_float,_bool,_str);
	};

	func(_handleParameters)
	{
		objParams();
		callSelf(_prepareParameters);
		private _name = null;
		private _val = null;
		private _cache = getSelf(_cachedParameters);
		{
			_name = _x select 0;
			_val = _cache get _name;
			_val params ["_float","_bool","_str"];
			callSelfParams(onParameter,_name arg _float arg _bool arg _str);
		} foreach getSelf(_parameters);
	};

	func(_prepareParameters)
	{
		objParams();
		if !isNull(getSelf(_cachedParameters)) exitWith {};

		private _asNum = 0;
		private _asStr = "";
		private _asBool = false;

		private _valToBool = {
			private _val = _this;
			//regex match
			//bool check
			if ([_val,"\s*(true|yes)\s*"] call regex_isMatch) exitWith {true};
			if ([_val,"\s*(false|no)\s*"] call regex_isMatch) exitWith {false};
			//int check
			if ([_val,"\s*-?\d+(\.\d+)?\s*"] call regex_isMatch) exitWith {
				parseNumberSafe(_val) != 0
			};
			not_equals(_val,stringEmpty)
		};
		private _mapCache = createHashMap;

		{
			_x params ["_k","_v"];
			_asNum = parseNumberSafe(_v);
			_asStr = _v;
			_asBool = _v call _valToBool;
			
			_mapCache set [_k,[_asNum,_asBool,_asStr]];

		} foreach getSelf(_parameters);

		setSelf(_cachedParameters,_mapCache);
	};

endclass