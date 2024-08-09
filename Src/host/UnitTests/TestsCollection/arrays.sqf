// ======================================================
// Copyright (c) 2017-2024 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include "..\TestFramework.h"

FIXTURE_SETUP(ArrayFixture)
{
	arr = [2,4,18,-3];
}

FIXTURE_TEARDOWN(ArrayFixture)
{
	arr = null;
}

TEST_F(ArrayFixture,MacroCheck)
{
	ASSERT(array_exists(arr,18));
	ASSERT(!array_exists(arr,-3.000002));

	private _arr2 = array_copy(arr);
	ASSERT(_arr2 isnotequalref arr);
	_arr2 set [0,10000];
	ASSERT_NE(_arr2 select 0,arr select 0);

	ASSERT_STR(BIS_fnc_arrayShuffle,"Core function 'BIS_fnc_arrayShuffle' not found");
	private _narr = array_shuffle(_arr2);
	ASSERT_EQ(count _arr2,count _narr);
	traceformat("Orig arr: %1",_arr2);
	traceformat("Shuffled arr: %1",_narr);
	ASSERT(_arr2 isnotequalref _narr); //native shuffle function creates new array

	private _lastEl = array_remlast(arr);
	ASSERT_EQ(_lastEl,-3);
	ASSERT_EQ(array_selectlast(arr),18);

	//modify array
	SETARR(arr,0,500);
	ASSERT_EQ(GETARR(arr,0),500);
	MODARR(arr,0, + 12);
	ASSERT_EQ(arr select 0,512);

	array_remove(arr,512);
	array_remove(arr,18);
	array_remove(arr,4);

	ASSERT(array_isempty(arr));

	
}

TEST_F(ArrayFixture,API_Functions)
{
	[arr,25] call pushFront;
	ASSERT_EQ(arr select 0,25);
	ASSERT_EQ(array_selectlast(arr),-3);

	[arr,4] arrayDeleteItem;
	ASSERT_EQ(arr select 2,18);
	
	//out of range
	ASSERT(!([arr,-2] call arrayIsValidIndex));
	ASSERT(!([arr,-1] call arrayIsValidIndex));
	ASSERT(!([arr,count arr] call arrayIsValidIndex));
	//valid range
	ASSERT(([arr,count arr - 2] call arrayIsValidIndex));

	// shuffle original
	private _cpy = array_copy(arr)
	private _cpyRef = [_cpy] call arrayShuffleOrig;
	ASSERT(_cpy isequalref _cpyRef);

	//Swap values; There array is: [25,2,18,-3]
	[arr,0,(count arr) - 1] call arraySwap;
	ASSERT_EQ(arr select 0,-3);
}


FIXTURE_SETUP(HashmapFixture)
{
	some_hashmap = createHashMapFromArray [["test",0],["best",1],["dest",2]];
}

FIXTURE_TEARDOWN(HashmapFixture)
{
	some_hashmap = null;
}

TEST_F(HashmapFixture,MacroCheck)
{
	//TODO implement
}