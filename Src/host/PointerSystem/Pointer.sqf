// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include "..\engine.hpp"
#include "..\oop.hpp"
#include "pointers.hpp"



#ifdef POINTER_SYSTEM_EXPERIMENTAL
	pointerUniInx = 0;
	pointerList = createHashMap;
#else
	pointerList = createObj;
#endif

pointer_getLastPointer = {
	pointerUniInx
};

pointer_create = {
	private _ref = _this;

#ifdef POINTER_SYSTEM_EXPERIMENTAL
	// private _nptr = generatePtr;
	// _nptr = _nptr + str pointerUniInx;
	// if (pointerUniInx>=9)then{pointerUniInx=0}else{INC(pointerUniInx)};
	INC(pointerUniInx);
	private _nptr = str pointerUniInx;
#else
	private _nptr = generatePtr;
	_nptr = _nptr + (tickTime toFixed 0);
#endif

#ifdef POINTER_SYSTEM_EXPERIMENTAL
	pointerList set [_nptr,_ref];
#else
	pointerList setVariable [_nptr,_ref];
#endif

	// adding pointer id to object name in string representation
	#ifdef RBUILDER_OR_EDITOR
	_ref SETNAME (format["%1#%2",NAME _ref,_nptr]);
	#endif

	_nptr
};

pointer_del = {
	private _res = pointerList getOrDefault [_this,"nan"];
	if (_res isequalto "nan") exitWith {
		errorformat("pointer::delete() - Cant remove pointer %1. Pointer not found in memory pool",_res);
		false
	};
	pointerList deleteAt _this;
	true
};


pointer_isExists = {
#ifdef POINTER_SYSTEM_EXPERIMENTAL
	private _result = pointerList getOrDefault [_this,"nan"];
#else
	private _result = pointerList getvariable [_this,"nan"];
#endif

	if (_result isequalto "nan") exitWith {false};

	if (_result isequalto nullPtr) exitWith {false};

	true
};

//Полная очистка и пересоздание объекта
pointer_memoryClear = {
#ifdef POINTER_SYSTEM_EXPERIMENTAL

	{
		if (!isNullReference(_y)) then {
			delete(_y)
		};
	} foreach pointerList;

	pointerUniInx = 0;
	pointerList = createHashMap;

#else

	{
		if (!isNullReference(_x)) then {
			delete(_x)
		};
	} foreach allVariables pointerList;

	deleteLocation pointerList;

	pointerList = createObj;

#endif
	pointerList
};


#ifndef POINTER_SYSTEM_EXPERIMENTAL
	if (true) exitWith {};
#endif

#include "GarbageCollector.sqf"
