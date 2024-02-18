// ======================================================
// Copyright (c) 2017-2023 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include "..\oop.hpp"
#include "..\engine.hpp"

#define basic() _mother = TYPE_SUPER_BASE;

//basic object for all oop system
editor_attribute("HiddenClass")
class(object) basic()
	"
		name:Объект
		desc:Базовый объект, от которого унаследованы абсолютно все другие объекты. Является корневым типом в объектной системе.
		path:Объекты.Библиотека
	"
	node_class

	"
		name:Получить класснейм
		namelib:Получить имя класса объекта
		desc:Получает класснейм объекта.
		type:get
		lockoverride:1
		return:classname:Имя класса
	" node_met
	func(getClassName)
	{
		objParams();
		this getVariable PROTOTYPE_VAR_NAME getVariable "classname"
	};

	"
		name:Получить класс
		namelib:Получить класс объекта
		desc:Получает класс объекта. Класс объекта - это специальный тип, содержащий информацию о самом классе а не о его экземплярах.
		type:get
		lockoverride:1
		return:class:Объект типа (класс)
	" node_met
	getter_func(getType,typeGetFromObject(this));

	"
		name:При создании
		namelib:При создании (Конструктор объекта)
		desc:Конструктор объекта. Вызывается как самое первое событие при создании объекта.
		type:event
	" node_met
	func(constructor)
	{
		INC(oop_cao);
		INC(oop_cco);
	};

	"
		name:При удалении
		namelib:При удалении (Деструктор объекта)
		desc:Деструктор объекта. Вызывается при удалении объекта непосредственно перед удалением.
		type:event
	" node_met
	func(destructor)
	{
		DEC(oop_cao);
	};

endclass

class(Type) extends(object)
	"
		name:Класс
		desc:Предоставляет интерфейс для работы с типами объектов.
		path:Объекты.Библиотека
	"
	node_class

	var(_srcType,nullPtr); //TODO auto alloc type objects

	func(getMember)
	{
		objParams_1(_name);
		typeGetVar(getSelf(_srcType),_name);
	};

	func(setMember)
	{
		objParams_2(_name,val);
		typeSetVar(getSelf(_srcType),_name,_val)
	};

	func(hasMember)
	{
		objParams_1(_name);
		typeHasVar(getSelf(_srcType),_name);
	};

	func(getVarDefaultValue)
	{
		params ['this',"_name",["_serialized",true]];
		private _srcObj = getSelf(_srcType);
		ifcheck(_serialized,typeGetDefaultFieldValueSerialized(_srcObj,_name),typeGetDefaultFieldValue(_srcObj,_name))
	};

endclass

class(ManagedObject) extends(object)
	"
		name:Управляемый объект
		desc:Управляемый системой объект, поддерживающий логику обновления (симуляции) и горячую перезагрузку полей
		path:Объекты.Библиотека
	"
	node_class
	var(__handleUpdateNative__,-1);

	getter_func(isUpdateActive,getSelf(__handleUpdateNative__)!=-1);
	
	// Указывает будет ли запущена функция обновления при создании объекта
	getterconst_func(startUpdateOnConstruct,false);

	//включена ли подсистема автоочистки autoref переменных
	getter_func(enableAutoRefGC,true);

	func(constructor)
	{
		objParams();
		if (callSelf(startUpdateOnConstruct)) then {
			callSelfParams(setUpdate,true);
		};
	};

	//set update mode
	func(setUpdate)
	{
		objParams_1(_mode);
		if (callSelf(isUpdateActive) == _mode) exitWith {};
		if (_mode) then {
			setSelf(__handleUpdateNative__,startUpdateParams(getSelfFunc(onUpdate),1,[this]));
			INC(oop_upd);
		} else {
			private _hnd = getSelf(__handleUpdateNative__);
			if (_hnd > -1) then {
				stopUpdate(_hnd);
				setSelf(__handleUpdateNative__,-1);
				DEC(oop_upd);
			};
		};
	};

	func(destructor)
	{
		objParams();
		callSelfParams(setUpdate,false);
		
		if (!callSelf(enableAutoRefGC)) exitWith {};

		//implementation for GC half-referenced objects
		private _refList = getSelfFunc(__autoref_list);

		if (!isNullVar(_refList)) then {
			private _ptr = nullPtr;
			private _Tarray = [];
			{
				_ptr = getSelfReflect(_x); //may be object reference or array

				call {
					if equalTypes(_ptr,_Tarray) exitWith { //cleanup array
						{
							if (!isNullReference(_x)) then {
								delete(_x);
							}
						} foreach _ptr;

						_ptr resize 1;
						_ptr set [0,"<AUTOREF_NAN>"];
					};
					if equalTypes(_ptr,nullPtr) exitWith { //cleanup object links
						if (!isNullReference(_ptr)) then {
							delete(_ptr);
						}
					};
					if equalTypes(_ptr,0) exitWith { //stop threads threads
						if (_ptr > -1) then {
							stopUpdate(_ptr);
						}
					};
				}

			} foreach _refList;
		};
	};

	//-----------------------------------------
	// HotReload helpers
	//-----------------------------------------

	//событие, вызываемое при перезагрузке класса объекта
	func(onReloadClass)
	{
		objParams();
		//TODO implement with refcount
	};

endclass

//Объект с системой подсчёта ссылок созданных экземпляров
//TODO refactoing with type object
editor_attribute("HiddenClass")
class(RefCounterObject)

	func(getRefList)
	{
		objParams();
		private _t = typeGetFromObject(this);
		if !typeHasVar(_t,__references) then {
			typeSetVar(_t,__references,[]);
		};
		typeGetVar(_t,__references)
	};
	
	//Внешнее получение по типу
	func(getRefListFromType)
	{
		objParams_1(_typeObj);
		
		if !typeHasVar(_typeObj,__references) then {
			typeSetVar(_typeObj,__references,[]);
		};
		typeGetVar(_typeObj,__references)
	};

	func(constructor)
	{
		objParams();
		callSelf(getRefList) pushBack this;
	};
	
	func(destructor)
	{
		objParams();
		private _refs = callSelf(getRefList);
		_refs deleteAt (_refs find this);
	};

endclass

class(NetObject) basic()

	func(getClassName)
	{
		objParams();
		this getVariable PROTOTYPE_VAR_NAME getVariable "classname"
	};

endclass
