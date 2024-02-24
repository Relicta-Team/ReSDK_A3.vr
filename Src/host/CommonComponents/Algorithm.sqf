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

#ifdef __ENABLE_ALGORITHM_TEST___
    
	assert(all_of([true arg true arg true]) isequalto true);
	assert(any_of([true arg true arg true]) isequalto true);
	assert(none_of([true arg true arg true]) isequalto false);
	
	assert(all_of([true arg true arg false]) isequalto false);
	assert(any_of([true arg true arg false]) isequalto true);
	assert(none_of([true arg true arg false]) isequalto false);
	
	assert(all_of([false arg false arg false]) isequalto false);
	assert(any_of([false arg false arg false]) isequalto false);
	assert(none_of([false arg false arg false]) isequalto true);

	assert(all_of([]) isequalto true);
	assert(any_of([]) isequalto false);
	assert(none_of([]) isequalto true);

#endif