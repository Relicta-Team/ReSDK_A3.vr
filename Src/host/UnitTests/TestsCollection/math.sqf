// ======================================================
// Copyright (c) 2017-2024 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include "..\TestFramework.h"


TEST(MathMacroBase)
{
	private _val = 5;
	INC(_val);
	ASSERT_EQ(_val,6);

	DEC(_val);
	ASSERT_EQ(_val,5);

	MOD(_val, + 3);
	ASSERT_EQ(_val,8);

	modvar(_val) - 3;
	ASSERT_EQ(_val,5);

	ASSERT(inRange(_val,4,5));

	ASSERT_EQ(boolToInt(false),0);

	ASSERT_EQ(precentage(5,50),2.5);

	ASSERT_EQ(clamp(0.00001,1,2),1);
	ASSERT_EQ(clamp(99999999999999,-5,5),5);

	ASSERT_EQ(clampangle(-30,0,359),360-30);
	ASSERT_EQ(clampangle(400,0,359),400-360);

	ASSERT_EQ(parseNumberSafe("9999999999999999999999999999999999999999999999999999999999999999999999999999999999"),0);
	ASSERT_EQ(parseNumberSafe("-9999999999999999999999999999999999999999999999999999999999999999999999999999999999"),0);
	ASSERT_EQ(parseNumberSafe('INFINITY'),0);
	ASSERT_EQ(parseNumberSafe("NOT-A-NUMBER"),0);
}

TEST(RandomRanged)
{
	private _count = 1000000;
	private _func = {
		params ["_act","_count",["_rndMode",0]];
		if (_rndMode == 0) exitWith {
			private _acc = 0;
			for "_i" from 1 to _count do {
				modvar(_acc) + (call _act);
			};
			_acc / _count;
		};
		if (_rndMode == 1) exitWith {
			private _arr = [];
			for "_i" from 1 to _count do {
				_arr pushBack (call _act);
			};
			_arr
		};
		0
	};

	//range-based random check
	private _rndResult = [{[-5,5] call randomFloat},_count,0] call _func;
	ASSERT_EQ(abs parsenumber(_rndResult tofixed 0),0);
	_rndResult = [{[0,5] call randomFloat},_count,0] call _func;
	ASSERT_EQ(parsenumber(_rndResult tofixed 1),2.5);

	//value check
	_rndResult = [{[0,5] call randomInt},_count,1] call _func;
	for "_i" from 0 to 5 do {
		ASSERT_STR(_i in _rndResult,"Value not in range: " + str _i);
	};

	//pick
	private _elementsList = [25,42,177,346,92,-29392489,13,1,999999999999];
	_rndResult = [{pick _elementsList},_count,1] call _func;
	{
		ASSERT_STR(_x in _rndResult,"Value not picked: " + str _x);
	} foreach _elementsList;

	//new prob
	_rndResult = [{prob_new(10)},_count,1] call _func;
	private _midCount = (_count / 2)/5;
	private _rng = _midCount / 100;
	private _trueCount = {_x} count _rndResult;
	traceformat("Iterations of prob: %1",_count tofixed 0);
	traceformat("True count: %1",_trueCount);
	traceformat("Medium value: %1",_midCount);
	traceformat("Range offset: %1",_rng);
	ASSERT(inRange(_trueCount,_midCount-_rng,_midCount+_rng));
}