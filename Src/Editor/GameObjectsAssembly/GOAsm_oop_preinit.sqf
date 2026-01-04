// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================


//системная копипаста...

//for deleting object
oop_deleteObject = {
	private this = _this;
	if ISNULL(this) exitWith {};
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

// object istypeof gameobject (from base to childs)
//now oop_getinhlist use cache and will be faster
//TODO replace by oop_isTypeOfBase
oop_isTypeOf = {
	params ["_searched","_type"];
	if (_type == _searched) exitwith {true};

	private _findedClass = false;
	private _list = [_type,true] call oop_getinhlist;
	{
		if (_x == _searched) exitwith {_findedClass = true};
	} foreach _list;
	_findedClass
};

// дочерний является подтипом родительского item istypeofbase gameobject, torch istypeofbase item
oop_isTypeOfBase = {
	params ["_class","_base"];
	if (_class == _base) exitwith {true};
	(tolower _base) in ([_class,"__inhlist_map"] call oop_getTypeValue)
};

oop_isImplementClass = {
	params ["_classname"];
	isImplementClass(_classname)
};

//получает имя родительского класса
oop_getMotherClassName = {
	params ["_type"];
	private _ret = missionnamespace getvariable ["pt_"+_type,"@NULL@"];
	if (_ret == "@NULL@") exitwith {null};
	_ret
};

//получить значение системного поля типа, например __decl_info__
oop_getTypeValue = {
	params ["_typeName","_value"];
	_value = tolower _value;
	(missionnamespace getvariable ["pt_"+_typeName,LOCATIONNULL]) getvariable _value
};

oop_getinhlist = {
	params ["_typename","_recurs","_refarr"];
	private _isFirstCall = isNullVar(_refarr);
	private _type = missionNamespace getVariable ["pt_"+_typename,0];
	if equals(_type,0) exitWith {
		errorformat("oop::getInhlist() - Cant find type %1 in memory",_typename);
		[]
	};
	private _hasCache = !isNull(_type getvariable "$cache_childs_all");
	if (_isFirstCall && {_hasCache} && {_recurs}) exitWith {
		array_copy(_type getvariable "$cache_childs_all")
	};


	private _childs = +(_type getVariable "__childList");

	private _chRet = if (_recurs) then {
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

	if (_isFirstCall && {!_hasCache} && {_recurs}) then {
		_type setvariable ["$cache_childs_all",array_copy(_chRet)];
	};

	_chRet
};

oop_getAllObjectsOfType = {
	params ["_typename",["_includeThis",false],["_retAsStrings",false]];
	private _result = [_typename,true] call oop_getinhlist;
	if (count _result == 0) exitwith {[]};
	if (_includeThis) then {
		_result pushBack _typename;
	};
	
	if (_retAsStrings) exitwith {_result};

	{
		_result set [_foreachindex,missionNamespace getvariable ["pt_"+_x,nullPtr]];
	} foreach _result;

	_result
};

//Небезопасный контекст получения значения переменной от типа
//_doCompile - возвращает десериализованное дефолтное значение типа
//_altMethodNameIfNil - возвращает альтернативный метод геттера по которому будет осуществлён поиск и получение значения
oop_getFieldBaseValue = {
	params ["_typename","_field",["_doCompile",false],["_altMethodNameIfNil",""]];

	private _type = missionNamespace getVariable ["pt_"+_typename,nullPtr];
	if isNullReference(_type) exitWith {
		errorformat("oop::getFieldBaseValue() - Cant find field '%2+%3' in type '%1'",_typename arg _field arg _altMethodNameIfNil);
		null;
	};

	private _valStr = _type getVariable '__allfields_map' getOrDefault [tolower _field,""];
	if (_doCompile) then {
		private _val = call compile _valStr;
		if (isNullVar(_val) && {not_equals(_altMethodNameIfNil,"")}) then {
			_val = locationNull call (_type getVariable [_altMethodNameIfNil,{"ERROR_RUNTIME_METHOD_GET_VALUE"}])
		};

		_valStr = _val;
	};

	_valStr
};

oop_reflect_hasClass = {
	!isNullReference(missionnamespace getVariable vec2("pt_"+_this,nullPtr))
};

oop_reflect_hasField = {
	params ["_strType","_name"];
	private _type = missionnamespace getVariable ["pt_"+_strType,nullPtr];
	if isNullReference(_type) exitWith {false};
	(_name) in (_type getvariable "__allfields_map")
};

oop_reflect_hasMethod = {
	params ["_strType","_name"];
	private _type = missionnamespace getVariable ["pt_"+_strType,nullPtr];
	if isNullReference(_type) exitWith {false};
	(tolower _name) in (_type getvariable "__allmethods")
};


oop_reflect_getAllMethods = {
	private _type = missionnamespace getVariable ["pt_"+_this,nullPtr];
	if isNullReference(_type) exitWith {[]};
	_type getvariable "__allmethods";
};


oop_reflect_getAllFields = {
	private _type = missionnamespace getVariable ["pt_"+_this,nullPtr];
	if isNullReference(_type) exitWith {[]};
	_type getvariable "__allfields";
};