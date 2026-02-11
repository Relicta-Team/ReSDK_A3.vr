// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\oop.hpp>
#include <..\engine.hpp>
#include <..\GameObjects\GameConstants.hpp>


#define newAttribute(name) _oop_attr_last_name = 'name'; oop_attr_##name = { params ['_thisClass',["_attributeParams",[]]];

#define thisClass _thisClass
#define thisParams _attributeParams
#define hasParams not_equals(thisParams,[])
#define getClassName (thisClass getVariable 'classname')
#define getMember(name) (thisClass getVariable 'name')
#define getMemberReflect(name) (thisClass getVariable (name))
#define hasMember(name) !isNull(getMember(name))
#define setMember(name,value) thisClass setVariable ['name',value]
#define setMemberReflect(name,value) thisClass setVariable [name,value]
#define endAttribute }; ["(OOP) Attribute '" + _oop_attr_last_name + "' loaded."] call logInfo;

/*
	OOP Attribute system

	Используется для управления типами на этапе компиляции; поддерживает рефлексию

	Пример

	class(SomeClass) attribute(PrintHelloworld)

	endclass

	newAttribute(PrintHelloworld)

		//override method
		_ctor = str getMember(constructor); //get ctor code as string
		_ctor = "call " + _ctor + "; " + 'log("Hello world! " + callSelf(getClassName))';
		setMember(constructor,compile _ctor); //update ctor

	endAttribute


	class(ChildClass) extends(SomeClass)

	endclass

	....
	func(Main)
	{
		objParams();

		_o1 = new(SomeClass); //after creating printing in console: Hello world! SomeClass
		_o2 = new(ChildClass); //after creating printing in console: Hello world! ChildClass
	}


*/

newAttribute(weapModule)

	private _className = getVar(thisClass,classname);

	missionNamespace setVariable ["wm_" + _className,instantiate(_classname)];

endAttribute

rolesystem_internal_net_idx = 0; //internal var
newAttribute(Role)
	private _className = getVar(thisClass,classname);
	private _obj = instantiate(_className);
	setVar(_obj,roleIdx,rolesystem_internal_net_idx);
	INC(rolesystem_internal_net_idx);
	missionNamespace setVariable ["role_"+_className,_obj];
endAttribute

newAttribute(Story)
	private _className = getVar(thisClass,classname);
	private _obj = instantiate(_className);
	missionNamespace setVariable ["story_"+_className,_obj];
endAttribute

newAttribute(initGlobalSingleton)

	if (count thisParams != 1) exitWith {
		errorformat("Cant init attribute <initGlobalSingleton> in class %1. Wrong count arguments %2",getClassName arg thisParams);
		appExit(APPEXIT_REASON_COMPILATIOEXCEPTION);
	};

	private _strRef = thisParams select 0;

	if not_equalTypes(_strRef,"") exitWith {
		errorformat("Cant init attribute <initGlobalSingleton> in class %1. Wrong type: %2 -> expected: string",getClassName arg toLower typename _strRef);
		appExit(APPEXIT_REASON_COMPILATIOEXCEPTION);
	};

	missionNamespace setVariable [_strRef,instantiate(getClassName)]

endAttribute


newAttribute(hasField)

	if !hasParams exitWith {
		_iserror = true; //throws compiling exception
		errorformat("Attribute %1 has no input params",getClassName);
		appExit(APPEXIT_REASON_COMPILATIOEXCEPTION);
	};

	private _fieldList = getMember(__allfields);
	{
		if not_equalTypes(_x,"") exitWith {
			_iserror = true;
			errorformat("Attribute %1 - runtime exception. Wrong param type - %2",getClassName arg tolower typename _x);
		};
		/*
		TODO: serialize members info for reflection (probably more memory uses)
			Use vars:
				_exist_fields, _exists_methods
			in src\host\OOP_engine\oop_init.sqf at line 28
			! replaced by oop_loadTypes

		*/
		if (!((tolower _x) in _fieldList)) exitWith {
			errorformat("Attribute<hasField> - Field %1 not defined in class %2",_x arg getClassName);
			appExit(APPEXIT_REASON_COMPILATIOEXCEPTION);
		};
	} foreach thisParams;

endAttribute

newAttribute(checkConstValue)
	FHEADER;

	if !hasParams exitWith {
		errorformat("Attribute %1 has no input params",getClassName);
		appExit(APPEXIT_REASON_COMPILATIOEXCEPTION);
	};

	if (count thisParams != 2) exitWith {
		errorformat("Attribute %1 wrong params count - %2 (expected 2)",getClassName arg count thisParams);
		appExit(APPEXIT_REASON_COMPILATIOEXCEPTION);
	};

	private _funcName = thisParams select 0;
	private _excludedClasses = thisParams select 1;

	if equalTypes(_excludedClasses,[]) then {
		if (getClassName in _excludedClasses) exitWith {RETURN(true)};
	} else {
		if equals(getClassName,_excludedClasses) exitWith {RETURN(true)};
	};

	private _codeData = getMemberReflect(_funcName);
	if isNullVar(_codeData) exitWith {
		errorformat("Function %2 does not exists in type %1",getClassName arg _funcName);
		appExit(APPEXIT_REASON_COMPILATIOEXCEPTION);
	};
	private _output = call _codeData;
	if isNullVar(_output) exitWith {
		errorformat("Function %2 returns null value in type %1",getClassName arg _funcName);
		appExit(APPEXIT_REASON_COMPILATIOEXCEPTION);
	};

endAttribute


newAttribute(GenerateWeaponModule)
	
	private _weight = getFieldBaseValue(getClassName,"weight");
	private _size = getFieldBaseValue(getClassName,"size");
	private _obj = instantiate("GeneratedWeapHandyItem");
	if isNullVar(_obj) exitWith {
		errorformat("Attribute<GenerateWeaponModule> - Cant instance weapon module of %1 - null var: (%2)",getClassName arg pt_GeneratedWeapHandyItem);
		appExit(APPEXIT_REASON_COMPILATIOEXCEPTION);
	};
	
	//initialize propertyes
	private _parryBonus = 0;
	private _canParry = WEAPON_PARRY_UNABLE;
	private _dmgBonus = 0; //for pair ATTACK_TYPE_SWING
	
	/*
		TODO: доделать...
		
		
		правила:
		размер влияет на урон и парирование
			крошечные, маленькие, огромные - не для парирования. урон -2,-3
			средние - парирование
			крупные и большие - несбалансированное
		
		//размерность НЕ МЕНЯТЬ ЗНАЧЕНИЯ НУМЕРАТОРА
		//размер предмета (1 крошечные предметы: спичка,пуля,колечко; 2 маленькие предметы: камень, ручка, шприц
		//3 средние предметы: книга,пистолет,фляжка,одежда; 4 крупные предметы: чайник,ведерко,дубинка;
		// 5 большие предметы: винтовка,канистра; 6 огромные: складной стул, гранатомёт )
		#define ITEM_SIZE_TINY 1
		#define ITEM_SIZE_SMALL 2
		#define ITEM_SIZE_MEDIUM 3
		#define ITEM_SIZE_LARGE 4
		#define ITEM_SIZE_BIG 5
		#define ITEM_SIZE_HUGE 6
	*/
	_parryBonus = round linearConversion[ITEM_SIZE_TINY,ITEM_SIZE_HUGE,_size,-4,4,true];
	//_dmgBonus = 1;//linearConversion[0.1,50,_weight,0,5,true];
	_dmgBonus = round linearConversion[ITEM_SIZE_TINY,ITEM_SIZE_HUGE,_size,-2,2,true];
	call {

		if (_size == ITEM_SIZE_TINY) exitWith {
			_canParry = WEAPON_PARRY_UNABLE;
			//_dmgBonus = -20;
		};
		if (_size == ITEM_SIZE_SMALL) exitWith {
			_canParry = WEAPON_PARRY_UNABLE;
			
			//	_dmgBonus = floor(_dmgBonus * -10);
			
		};
		if (_size == ITEM_SIZE_MEDIUM) exitWith {
			_canParry = WEAPON_PARRY_ENABLE;
			
			//	_dmgBonus = floor(_dmgBonus * -5);
			
		};
		if (_size == ITEM_SIZE_LARGE) exitWith {
			_canParry = WEAPON_PARRY_UNBALANCED;
			//_dmgBonus = round(_dmgBonus * -3);
		};
		if (_size == ITEM_SIZE_BIG) exitWith {
			_canParry = WEAPON_PARRY_UNABLE;
			//_dmgBonus = round(_dmgBonus * -2);
		};
		if (_size == ITEM_SIZE_HUGE) exitWith {
			_canParry = WEAPON_PARRY_UNABLE;
			//_dmgBonus = round(_dmgBonus * -1);
		};
	};
	
	setVar(_obj,parryCapability,_canParry);
	setVar(_obj,parryBonus,_parryBonus);
	getVar(_obj,dmgBonus) set [ATTACK_TYPE_SWING,_dmgBonus];
	
	_wmName = "wm_"+ getClassName + "generated";
	missionNamespace setVariable [_wmName,_obj];
	setMember(getGeneratedWeaponModule,compile(_wmName));
	logformat("INITIALIZED CLASS %1 with wm: %2 %3 %4",getClassName arg _wmName arg _obj arg pt_GeneratedWeapHandyItem);
endAttribute


newAttribute(staticInit)
	private _func = getMember(staticInit);
	if isNullVar(_func) exitWith {
		setLastError("Cant find staticInit function in class " + getClassName);
	};

	[getClassName,thisClass] call _func
endAttribute