// ======================================================
// Copyright (c) 2017-2025 the ReSDK_A3 project
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