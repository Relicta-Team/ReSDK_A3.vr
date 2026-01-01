// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include "..\oop.hpp"
#include "..\engine.hpp"
#include "oop_logging.sqf"

#define NULLCLASS "<NAN_CLASS>"
["|-------------------------------------------------|"] call systemLog;
["|                                                 |"] call systemLog;
["|                                                 |"] call systemLog;
["|         OOPEngine module loading start          |"] call systemLog;
["|                                                 |"] call systemLog;
["|                                                 |"] call systemLog;
["|-------------------------------------------------|"] call systemLog;

call compile __pragma_prep_cli "src\host\OOP_engine\oop_attributes.sqf";

if (!isnil {p_table_allclassnames}) then {
	{
		missionnamespace setvariable ["pt_" + _x,nil];
	} foreach p_table_allclassnames;

	//removing all vObj
	{
		deleteLocation _x;
	} foreach (nearestLocations [[100,100,100],["CBA_NamespaceDummy"],10])
};

p_table_inheritance = [];
p_table_allclassnames = [];

//for deleting object
oop_deleteObject = {
	private this = _this;
	this setvariable ["__del_flag__",true];
	{
		this call (_x getvariable "destructor")
	} foreach (this getvariable "proto" getvariable "__dtors");

	deleteLocation this;
};

#define PTR_SIZE 8

//Получает размер объекта в байтах
oop_getobjsize = {

	private _size = PTR_SIZE;

	if (_this isEqualTo nullPtr) exitWith {_size}; //только указатель

	private _getTypeSize = oop_getTypeSize;

	{
		MOD(_size,+ ((_this getvariable _x) call _getTypeSize));
	} foreach allVariables _this;

	_size
};

oop_getTypeSize = {
	if (_this isequaltype nullPtr) exitWith {PTR_SIZE}; //4 for x32
	if (_this isEqualType true) exitWith {1};
	if (_this isEqualType 0) exitWith {4};
	if (_this isEqualType "") exitWith {count _this};
	if (_this isequalType []) exitWith {

		private _sts = oop_getSimpleTypeSize;
		private _size = PTR_SIZE;
		{
			MOD(_size,+ (_x call _sts));
		} foreach _this;

		_size
	};
	if (_this isEqualType {}) exitWith {
		PTR_SIZE
	};

	0
};

oop_getTypeSizeFull = {
	#ifdef SP_MODE
	if (true) exitWith {-1};
	#endif
	if (_this isequaltype nullPtr) exitWith {PTR_SIZE}; //4 for x32
	if (_this isEqualType true) exitWith {1};
	if (_this isEqualType 0) exitWith {4};
	if (_this isEqualType "") exitWith {count _this};
	if (_this isequalType []) exitWith {

		private _sts = oop_getTypeSizeFull;
		private _size = PTR_SIZE;
		{
			MOD(_size,+ (_x call _sts));
		} foreach _this;

		_size
	};
	if (_this isEqualType {}) exitWith {
		PTR_SIZE
	};

	0
};

oop_getSimpleTypeSize = {
	if (_this isequaltype nullPtr) exitWith {8}; //4 for x32
	if (_this isEqualType true) exitWith {1};
	if (_this isEqualType 0) exitWith {4};
	if (_this isEqualType "") exitWith {count _this};
	PTR_SIZE
};


/*
--------------------------------------------------------------------------------
	GROUP:	TYPES MANAGMENT
--------------------------------------------------------------------------------
*/
//проверка типа
oop_checkTypeSafe = {
	params ["_typename",["_defaultRet","object"]];
	
	if !isImplementClass(_typename) exitwith {
		assert_str(false,"Указанный тип не существует: " + _typename);
		_defaultRet
	};
	
	_typename
};

oop_getinhlist = {
	params ["_typename","_recurs","_refarr"];

	private _type = missionNamespace getVariable ["pt_"+_typename,0];
	if equals(_type,0) exitWith {
		errorformat("oop::getInhlist() - Cant find type %1 in memory",_typename);
		[]
	};

	private _childs = +(_type getVariable "__childList");

	if (_recurs) then {
		private _internalRefArr = defIsNull(_refarr,_childs);

		{
			{
				//log("finded " + _x + " -> " + str (
				_internalRefArr pushBackUnique _x
				//))
				} foreach ([_x,true,_internalRefArr] call oop_getinhlist);
		} foreach _childs;

		_childs
	} else {
		_childs
	};
};

oop_getinhlist_Node = {
	params ["_typename",["_global",false]];
};

//Небезопасный контекст получения значения переменной от типа
//_doCompile - возвращает десериализованное дефолтное значение типа
//_altMethodNameIfNil - возвращает альтернативный метод геттера по которому будет осуществлён поиск и получение значения
oop_getFieldBaseValue = {
	params ["_type","_field",["_doCompile",false],["_altMethodNameIfNil",""]];

	private _type = missionNamespace getVariable ["pt_"+_type,nullPtr];
	if isNullReference(_type) exitWith {
		errorformat("oop::getFieldBaseValue() - Cant find type '%1'",_type);
		null;
	};

	private _valStr = _type getVariable '__allfields_map' getOrDefault [tolower _field,""];
	if (_doCompile) then {
		private _val = call compile _valStr;
		if (isNullVar(_val) && {not_equals(_altMethodNameIfNil,"")}) then {
			_val = 0 call (_type getVariable _altMethodNameIfNil)
		};

		_valStr = _val;
	};

	_valStr
};

oop_getData = {
	private _obj = _this deleteAt 0;
	private _args = _this;
	if (count _args == 0) exitWith {["ERROR_NOVARS"]};
	if equals(_args select 0,"help") exitWith {"a.b - field, a.b() - method, a->b - indexer"};
	if isNullVar(_obj) exitWith {["ERROR_NULL_OBJ"]};
	private _ret = [];
	if equalTypes(_obj,nullPtr) exitWith {
		([_obj getVariable "pointer"]+_args)call oop_getData;
	};
	if equalTypes(_obj,objNUll) exitWith {
		private _prob = _obj getVariable "link";
		if !isNullVar(_prob) exitWith {
			([_prob]+_args)call oop_getData;
		};
		_prob = _obj getVariable "ref";
		if !isNullVar(_prob) exitWith {
			([_prob]+_args)call oop_getData;
		};
		["ERROR_NO_REF"]
	};
	if equals(_obj,"target") exitWith {
		if (isMultiplayer) exitWith {["ERROR_NOT_MP"]};
		private _t = call interact_cursorobject;
		([_t]+_args)call oop_getData;
	};
	if (_obj in pointerList) exitWith {
		_obj = pointerList get _obj;
		{
			private _val = _obj;
			{
				if ([_x,"\w+\(\)"] call regex_ismatch) then {
					_x = [_x,"\(\)",""] call regex_replace;
					_val = callFuncReflect(_val,_x);
				} else {
					if (_x select [0,1]==">") then {
						_x = _x select [1,count _x];
						if equalTypes(_val,[]) then {
							_val = _val select (call compile _x);
						} else {
							_val = _val get (call compile _x);
						};
					} else {
						_val = getVarReflect(_val,_x);
					};
				};
			} foreach (_x splitString ".-");
			_ret pushBack _val;
		} foreach _args;
		_ret
	};
	["ERROR_NO_OBJ"]
};

oop_injectToMethod = {
	params ["_type","_metname","_code",["_sect","end"],["_overrideChild",false]];
	traceformat("Start inject to %1::%2 at %3",_type arg _metname arg _sect)
	private _t = typeGetFromString(_type);
	if isNull(_t getVariable _metname) exitWith {
		errorformat("Cant inject code to %1::%2 - member not exists",_type arg _metname);
		false
	};
	
	if equalTypes(_code,{}) then {_code = toString _code};
	
	if (_overrideChild) then {
		{
			[_x,_metname,_code,_sect,false] call oop_injectToMethod;
		} foreach getAllObjectsTypeOfStr(_type);
	};
	
	private _base = toString(_t getVariable _metname);
	if (_sect == "begin") exitWith {
		_t setVariable [_metname,compile(_code+_base)];
		true
	};
	if (_sect == "end") exitWith {
		_t setVariable [_metname,compile(_base+_code)];
		true
	};
	if (_sect == "replace") exitWith {
		_t setVariable [_metname,compile(_code)];
		true
	};
	errorformat("Cant inject code to %1::%2 - unknown section %3",_type arg _metname arg _sect);
	false
};

//получить значение системного поля типа, например __decl_info__
oop_getTypeValue = {
	params ["_typeName","_value"];
	_value = tolower _value;
	(missionnamespace getvariable ["pt_"+_typeName,LOCATIONNULL]) getvariable _value
};
