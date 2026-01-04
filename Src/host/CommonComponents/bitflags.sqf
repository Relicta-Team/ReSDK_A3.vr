// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================



bitwise_and = {
	params [["_num1", 0, [0]], ["_num2", 0, [0]], "_num1rem", "_num2rem"];

	private _res = 0;

	for "_i" from 0 to 23 do 
	{
	if (_num1 isEqualTo 0 || _num2 isEqualTo 0) exitWith {};

	_num1rem = _num1 % 2; 
	_num2rem = _num2 % 2;

	if (_num1rem isEqualTo 1 && _num2rem isEqualTo 1) then {_res = _res + 2 ^ _i};

	_num1 = (_num1 - _num1rem) / 2; 
	_num2 = (_num2 - _num2rem) / 2;
	};

	_res
};

bitwise_or = {
	params [["_num1", 0, [0]], ["_num2", 0, [0]], "_num1rem", "_num2rem"];

	private _res = 0;

	for "_i" from 0 to 23 do 
	{
	_num1rem = _num1 % 2; 
	_num2rem = _num2 % 2;

	if (_num1rem isEqualTo 1 || _num2rem isEqualTo 1) then {_res = _res + 2 ^ _i};

	_num1 = (_num1 - _num1rem) / 2; 
	_num2 = (_num2 - _num2rem) / 2;
	};

	_res
};

bitwise_xor = {
	params [["_num1", 0, [0]], ["_num2", 0, [0]], "_num1rem", "_num2rem"];

	private _res = 0;

	for "_i" from 0 to 23 do 
	{
	_num1rem = _num1 % 2; 
	_num2rem = _num2 % 2;

	if !(_num1rem isEqualTo _num2rem) then {_res = _res + 2 ^ _i};

	_num1 = (_num1 - _num1rem) / 2; 
	_num2 = (_num2 - _num2rem) / 2;
	};

	_res
};

bitwise_not = {
	params [["_num", 0, [0]], "_numrem"];

	private _res = 0;

	for "_i" from 0 to 23 do 
	{
	_numrem = _num % 2;

	if (_numrem isEqualTo 0) then {_res = _res + 2 ^ _i};

	_num = (_num - _numrem) / 2;
	};

	_res
};

bit_set = {
	params ["_flagset", "_flags"];

	[_flagset, _flags] call bitwise_or;
};

bit_unset = {
	params ["_flagset", "_flags"];

	[_flagset, _flags call bitwise_not] call bitwise_and
};

bit_flip = {
	params ["_flagset", "_flags"];

	[_flagset, _flags] call bitwise_xor
};

bit_check = {
	params ["_flagset", "_flags"];

	([_flagset, _flags] call bitwise_and) > 0
};

bit_toArray = {
	params [["_flags", 0], "_flag"];

	private _result = [];

	for "_i" from 0 to 23 do 
	{
		_flag = 2 ^ _i;

		if (_flag > _flags) exitWith {};

		_result pushBack ([_flags, _flag] call bitwise_and);
	};

	_result - [0]
};	