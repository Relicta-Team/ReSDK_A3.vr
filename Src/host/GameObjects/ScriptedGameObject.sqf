// ======================================================
// Copyright (c) 2017-2024 the ReSDK_A3 project
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
	//TODO functions
	//auto add script to all objects - когда создается первый объект такого скрипта он апллаится ко всем объектам указанного типа

	// ------------------------------------------- logic -------------------------------------------

	func(assignScript)
	{
		objParams_1(_src);

		assert_str(!isNullVar(_src),"Internal param error; Script source is null");
		assert_str(!isNullReference(_src),"Source object is null reference");
		assert_str(isTypeOf(_src,IDestructible),"Script must be assigned to IDestructible instance");
		assert_str(!isTypeOf(_src,BasicMob),"Script cannot be assigned to mob or entity");

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

		callSelfParams(onScriptAssigned,_src);
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

	//Действия персонажа к объекту

	"
		name:При основном действии
		namelib:При основном действии
		desc:Срабатывает при исполнении персонажем основного действия с объектом (при нажатии кнопки ""Е"").
		type:event
		out:BasicMob:Персонаж:Тот, кто выполняет действие по отношению к объекту.
		return:bool:Результат выполнения основного действия. Возвращает @[bool ИСТИНУ], если основное действие успешно выполнено.
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
		return:bool:Результат выполнения основного действия. Возвращает @[bool ИСТИНУ], если основное действие успешно выполнено.
	" node_met
	func(callBaseMainAction)
	{
		params ['this'];

		private _r = callFuncParams(_usr,mainAction,getSelf(src));
		if isNullVar(_r) then {_r = true};
		if not_equalTypes(_r,true) then {_r = true};
		_r
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
		private _r = callFuncParams(_usr,extraAction,getSelf(src));
		if isNullVar(_r) then {_r = true};
		if not_equalTypes(_r,true) then {_r = true};
		_r
	};


	"
		name:При взаимодействии предметом
		namelib:При взаимодействии предметом
		desc:Срабатывает при исполнении персонажем взаимодействия с объектом с помощью предмета в активной руке. (ЛКМ по объекту с предметом в руке)
		type:event
		out:Item:Предмет:Предмет, которым выполняется взаимодействие с объектом.
		out:BasicMob:Персонаж:Тот, кто выполняет действие по отношению к объекту.
		return:bool:Результат выполнения действия. Возвращает @[bool ИСТИНУ], если действие успешно выполнено.
	" node_met
	func(_onInteractWithWrapper)
	{
		objParams_2(_with,_usr);
		callSelfParams(callBaseInteractWith,_with,_usr);
	};

	func(onInteractWith)
	{
		objParams_2(_with,_usr);
		callSelfParams(_onInteractWithWrapper,_with,_usr);
	};

	"
		name:Взаимодействие предметом
		desc:Базовая логика взаимодействия с помощью предмета, определенная в игровом объекте.
		type:method
		lockoverride:1
		in:Item:Предмет:Предмет, которым выполняется взаимодействие с объектом.
		in:BasicMob:Персонаж:Тот, кто выполняет действие по отношению к объекту.
		return:bool:Результат выполнения действия. Возвращает @[bool ИСТИНУ], если действие успешно выполнено.
	" node_met
	func(callBaseInteractWith)
	{
		params ['this'];
		private _r = callFuncParams(getSelf(src),onInteractWith,_with,_usr);
		if isNullVar(_r) then {_r = true};
		if not_equalTypes(_r,true) then {_r = true};
		_r
	};

	"
		name:При нажатии по объекту
		namelib:При нажатии по объекту
		desc:Срабатывает при нажатии ЛКМ пустой рукой по объекту в мире.
		type:event
		out:BasicMob:Персонаж:Тот, кто выполняет действие по отношению к объекту.
		return:bool:Результат выполнения действия. Возвращает @[bool ИСТИНУ], если действие успешно выполнено.
	" node_met
	func(_onClickWrapper)
	{
		objParams_1(_usr);
		callSelfParams(callBaseClick,_usr);
	};

	func(onClick)
	{
		objParams_1(_usr);
		callSelfParams(_onClickWrapper,_usr);
	};

	"
		name:Нажатие по объекту
		desc:Базовая логика нажатия по объекту, определенная в игровом объекте.
		type:method
		lockoverride:1
		in:BasicMob:Персонаж:Тот, кто выполняет действие по отношению к объекту.
		return:bool:Результат выполнения действия. Возвращает @[bool ИСТИНУ], если действие успешно выполнено.
	" node_met
	func(callBaseClick)
	{
		params ['this'];
		private _r = callFuncParams(getSelf(src),onClick,_usr);
		if isNullVar(_r) then {_r = true};
		if not_equalTypes(_r,true) then {_r = true};
		_r
	};



endclass

/* TODO replace to item script
	"
		name:При нажатии по предмету в инвентаре
		namelib:При нажатии по предмету в инвентаре
		desc:Срабатывает при нажатии персонажем по предмету в слоте собственного инвентаря.
		type:event
		out:BasicMob:Персонаж:Тот, кто выполняет действие по отношению к объекту.
		return:bool:Результат выполнения действия. Возвращает @[bool ИСТИНУ], если действие успешно выполнено.
	" node_met
	func(onItemClick)
	{
		objParams_1(_usr);
		callSelfParams(callBaseItemClick,_usr);
	};

	"
		name:Нажатие по предмету в инвентаре
		desc:Базовая логика нажатия по предмету, определенная в игровом объекте.
		type:method
		lockoverride:1
		in:BasicMob:Персонаж:Тот, кто выполняет действие по отношению к объекту.
		return:bool:Результат выполнения действия. Возвращает @[bool ИСТИНУ], если действие успешно выполнено.
	" node_met
	func(callBaseItemClick)
	{
		params ['this'];
		private _r = callFuncParams(getSelf(src),onItemClick,_usr);
		if isNullVar(_r) then {_r = true};
		if not_equalTypes(_r,true) then {_r = true};
		_r
	};

	"
		name:При нажатии по предмету в активной руке
		namelib:При нажатии по предмету в активной руке
		desc:Срабатывает при нажатии персонажем по предмету в активной руке через инвентарь.
		type:event
		out:BasicMob:Персонаж:Тот, кто выполняет действие по отношению к объекту.
		return:bool:Результат выполнения действия. Возвращает @[bool ИСТИНУ], если действие успешно выполнено.
	" node_met
	func(onItemSelfClick)
	{
		objParams_1(_usr);
		callSelfParams(callBaseItemSelfClick,_usr);
	};

	"
		name:Нажатие по предмету в активной руке
		desc:Базовая логика нажатия по предмету, определенная в игровом объекте.
		type:method
		lockoverride:1
		in:BasicMob:Персонаж:Тот, кто выполняет действие по отношению к объекту.
		return:bool:Результат выполнения действия. Возвращает @[bool ИСТИНУ], если действие успешно выполнено.
	" node_met
	func(callBaseItemSelfClick)
	{
		params ['this'];
		private _r = callFuncParams(getSelf(src),onItemSelfClick,_usr);
		if isNullVar(_r) then {_r = true};
		if not_equalTypes(_r,true) then {_r = true};
		_r
	};
*/