// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
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
		name:Получить класснейм родителя
		namelib:Получить имя класса родителя
		desc:Получает имя родительского класса, от которого унаследован объект. Не рекомендуется использовать этот узел для объектов типа object.
		type:get
		lockoverride:1
		return:classname:Имя класса
	" node_met
	func(getParentClassName)
	{
		objParams();
		this getVariable PROTOTYPE_VAR_NAME getVariable "__motherClass"
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

	getterconst_func(defaultUpdateDelay,1);

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
			if (!isImplementFunc(this,onUpdate)) exitWith {};

			setSelf(__handleUpdateNative__,startUpdateParams({(_this select 0)params["_p" arg "_c"]; _p call _c},callSelf(defaultUpdateDelay),[this arg getSelfFunc(onUpdate)]));
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

	//отладочные сообщения автоссылок
	//#define DEBUG_DISPOSE_OBJECTS

	func(destructor)
	{
		objParams();
		callSelfParams(setUpdate,false);
		
		if (!callSelf(enableAutoRefGC)) exitWith {};

		//implementation for GC half-referenced objects
		private _refList = getSelfFunc(__autoref_list);
		
		#ifdef DEBUG_DISPOSE_OBJECTS
			warningformat("Disposing %1 with refs %2",this arg _refList);
		#endif

		if (!isNullVar(_refList)) then {
			private _ptr = nullPtr;
			private _Tarray = [];
			{
				_ptr = getSelfReflect(_x); //may be object reference or array

				#ifdef DEBUG_DISPOSE_OBJECTS
					warningformat("	>>> %3(%2) %1",_ptr arg typename _ptr arg _x);
				#endif

				call {
					if equalTypes(_ptr,_Tarray) exitWith { //cleanup array
						{
							#ifdef DEBUG_DISPOSE_OBJECTS
								warningformat("			- dcheck PRE %1",_x);
							#endif
							if (!isNullReference(_x)) then {
								//!обращаю внимание, что при удалении объекта, который в деструкторах удаляется из _ptr - этот _ptr будет смещен и появятся утечки
								delete(_x);
							};
							#ifdef DEBUG_DISPOSE_OBJECTS
								warningformat("			- dcheck POST %1",_x);
							#endif
							
							false
						} count _ptr;

						#ifdef DEBUG_DISPOSE_OBJECTS
							warningformat("		- %3(%2) arr_del: %1",_ptr arg _x arg this);
						#endif

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

				#ifdef DEBUG_DISPOSE_OBJECTS
					;warningformat("	<<< %3::%1 end dispose: %2",_x arg _ptr arg this);
				#endif

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
