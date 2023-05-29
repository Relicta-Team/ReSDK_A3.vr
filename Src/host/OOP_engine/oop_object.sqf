// ======================================================
// Copyright (c) 2017-2023 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include "..\oop.hpp"
#include "..\engine.hpp"

#define basic() _mother = TYPE_SUPER_BASE;

//basic object for all oop system
class(object) basic()

	func(getClassName)
	{
		objParams();
		this getVariable PROTOTYPE_VAR_NAME getVariable "classname"
	};

	func(constructor)
	{
		INC(oop_cao);
		INC(oop_cco);
	};

	func(destructor)
	{
		DEC(oop_cao);
	};

endclass

class(ManagedObject) extends(object)

	var(handleUpdate,-1);
	
	// Указывает может ли быть использована функция обновления
	getterconst_func(hasUpdate,false);
	// Указывает есть ли какие-нибудь действия в методе обновления
	var_bool(haveUpdateActions);
	getter_func(doUpdateAction,setSelf(haveUpdateActions,true));
	getter_func(resetUpdateAction,setSelf(haveUpdateActions,false));

	func(constructor)
	{
		if (callSelf(hasUpdate)) then {
			setSelf(handleUpdate,startUpdateParams(getSelfFunc(onUpdate),1,[this]));
			INC(oop_upd);
		};
	};

	getter_func(enableAutoRefGC,true);

	func(destructor)
	{
		if (callSelf(hasUpdate)) then {
			private _hnd = getSelf(handleUpdate);
			if (_hnd > -1) then {stopUpdate(_hnd)};
			DEC(oop_upd);
		};
		
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
							if (!isNullObject(_x)) then {
								delete(_x);
							}
						} foreach _ptr;

						_ptr resize 1;
						_ptr set [0,"<AUTOREF_NAN>"];
					};
					if equalTypes(_ptr,nullPtr) exitWith { //cleanup object links
						if (!isNullObject(_ptr)) then {
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

endclass

//Объект с системой подсчёта ссылок созданных экземпляров
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
