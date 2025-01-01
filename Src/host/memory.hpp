// ======================================================
// Copyright (c) 2017-2025 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include "engine.hpp"

#define size_ptr 8
#define size_float 4
#define size_bool 1

#define size_array size_ptr
#define size_ptr_object size_ptr

/*if (_this isequaltype objnull) exitWith {size_ptr}; //4 for x32*/
#define sizeof(var) \
((var) call { \
	if (_this isEqualType true) exitWith {1}; \
	if (_this isEqualType 0) exitWith {4}; \
	if (_this isEqualType "") exitWith {count _this}; \
	size_ptr \
}) 



#define obj_sizeof(ref) \
((ref) call { \
	\
	private _size = size_ptr; \
	\
	if (_this in [locationnull,objnull]) exitWith {_size}; \
	\
	private _gtp = { \
		if (_this isEqualType true) exitWith {1}; \
		if (_this isEqualType 0) exitWith {4}; \
		if (_this isEqualType "") exitWith {count _this}; \
		if (_this isequalType []) exitWith { \
			\
			private _size = size_ptr; \
			{ \
				MOD(_size,+ sizeof(_x)); \
			} foreach _this; \
			\
			_size \
		}; \
		if (_this isEqualType {}) exitWith { \
			size_ptr \
		};\
		size_ptr \
	};\
	\
	{\
		MOD(_size,+ ((_this getvariable _x) call _gtp));\
	} foreach allVariables _this;\
	\
	_size\
})