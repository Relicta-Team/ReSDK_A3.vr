// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\engine.hpp>

// algorithm helpers

//enable static tests
//#define __ENABLE_ALGORITHM_TEST___


allOf = {
	params ["_list"];
	!(false in _list)
};

anyOf = {
	params ["_list"];
	true in _list
};

noneOf = {
	params ["_list"];
	!(true in _list)
};

/*
	Function generator list
	Create list with values from _b to _e and apply function _fn
*/
generateList = {
	params ["_b",["_e",0],["_fn",{_this}]];
	//make array first
	private _glist = [];
	
	//find limits
	private _s = _b min _e;
	private _e = _e max _b;
	
	// get counters (example 2..5 -> 5-2 -> range 3, elements 4)
	// because 2,3,4,5 -> 4 iterations
	private _cnt = _e - _s + 1;

	_glist resize _cnt; //allocate array

	//fill array
	private __gtv = _s;
	{
		_glist set [_foreachindex,__gtv call _fn];
		INC(__gtv);
	} foreach _glist;

	_glist
};