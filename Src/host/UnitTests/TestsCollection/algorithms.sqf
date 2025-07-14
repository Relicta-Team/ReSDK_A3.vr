// ======================================================
// Copyright (c) 2017-2025 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include "..\TestFramework.h"
#define ENABLE_STATIC_FOR_DEBUG
#include "..\..\static_iter.hpp"

TEST(Algorithms_base)
{
	ASSERT_EQ(all_of([true arg true arg true]) , true);
	ASSERT_EQ(any_of([true arg true arg true]) , true);
	ASSERT_EQ(none_of([true arg true arg true]) , false);
	
	ASSERT_EQ(all_of([true arg true arg false]) , false);
	ASSERT_EQ(any_of([true arg true arg false]) , true);
	ASSERT_EQ(none_of([true arg true arg false]) , false);
	
	ASSERT_EQ(all_of([false arg false arg false]) , false);
	ASSERT_EQ(any_of([false arg false arg false]) , false);
	ASSERT_EQ(none_of([false arg false arg false]) , true);

	ASSERT_EQ(all_of([]) , true);
	ASSERT_EQ(any_of([]) , false);
	ASSERT_EQ(none_of([]) , true);

}

TEST(Algorithms_searching)
{
	private _list = [2,"true",false,"HELLO",0.000001,"xxxxxxxxxxxxxx",300];

	private _element = [
		_list,
		{equalTypes(_x,stringEmpty) && {count _x == 5}},
		"notfound"
	] call searchInList;

	ASSERT_EQ(_element,"HELLO");
	private _referenceDefault = false;
	private _defaultReturn = [_list,{equalTypes(_x,true) && {_x}},_referenceDefault] call searchInList;
	//ASSERT(_defaultReturn isnotequalref (_list select 2)); //this throws error because 2.18 use simplevm optimizations
	ASSERT_EQ(_defaultReturn,_referenceDefault);

	private _d = [10,0];
	private _bestResult = [
		[
			[43,0],
			[22,0],
			[11,0],
			[2,0],
			[45,0],
			[50,0]
		],
		{
			-(_x distance _d)
		}
	] call selectBest;

	ASSERT(_bestResult);
	ASSERT_EQ(_bestResult,vec2(11,0));
}

// TEST(Algorithms_sorting)
// {
 	//! in current version ReSDK does not support custom sorting algorithms
 	//! only used native "sort"
// }

TEST(Algorithms_static_for)
{
	//generate slow iter
	private _t = tickTime;
	private _arun = [];
	for "_i" from 1 to 100000 do {
		_arun pushback _i;
	};
	_tdelslow = tickTime - _t;

	private _astat2 = [];
	private _c = {
		static_for(_i,1,100000,{_astat2 pushback _i})
	};
	private _preinitCount = count statfor_map_generator;
	log("first call pre");
	call _c; //first call - generate static iter
	log("first call post");
	
	ASSERT_EQ(count statfor_map_generator,_preinitCount+1);

	_astat2 = [];
	_t = tickTime;
	log("second call pre");
	call _c; //second call - check performance
	log("second call post");
	_tdelfast = tickTime - _t;

	logformat("slow %1; fast %2",_tdelslow arg _tdelfast);

	ASSERT_EQ(count _astat2,100000);
	ASSERT_EQ(_astat2 select 0,1);
	ASSERT_EQ(_astat2 select 99999,100000);
	
}
