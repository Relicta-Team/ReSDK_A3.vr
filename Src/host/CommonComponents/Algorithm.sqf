// ======================================================
// Copyright (c) 2017-2024 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\engine.hpp>

// algorithm helpers

//enable static tests
//#define __ENABLE_ALGORITHM_TEST___

#ifndef _SQFVM
	#undef __ENABLE_ALGORITHM_TEST___
#endif


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