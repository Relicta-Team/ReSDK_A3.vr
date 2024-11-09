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

#ifdef DEBUG
TEST(TestRandInt_Bug_544)
{
	private _min = 3;
	private _max = 4;
	
	private _rng = [
	//   * lower
	//   |  * upper
	//   |  |   * iterations count
	//   |  |   |
	//   v  v   v
        [3, 4,  10000000],
        [3, 5,  10000000],
        [3, 15, 10000000]
	];

	private _errFnd = [];

	for "_itp" from 0 to (count _rng)-1 do {
		private _rngCur = _rng select _itp;
		traceformat("Start random int test: %1",_rngCur);
		_rngCur params ["_lower","_upper","_count"];
		private _rval = 0;
		for "_i" from 1 to _count do {
			_rval = randInt(_lower,_upper);
			if !inRange(_rval,_lower,_upper) then {
				errorformat("Failed number %1 on iteration %2",_rval arg _i tofixed 0);
				_errFnd pushBack [_rval];
			};
		};

		if(count _errFnd != 0)exitWith {};
	};

	ASSERT_STR((count _errFnd)==0,"Errors in random was found: " + str _errFnd);

}
#endif

#ifdef CMD__RANDINT_ENABLE_LARGE_TESTCASE
TEST(TestRandInt_Bug_544_large_tests)
{
	logformat("Starting large randint test")
	logformat("Product ver: %1",productversion);
	private _berrV = _localErrorCount;
	_itt = 1;
	while {_itt <= 50 || _localErrorCount == _berrV} do {
		logformat("ITERATION: %1",_itt);
		INC(_itt);
		
		private _iterCount = 15000000;
		private _min = 3;
		private _max = 15;
		private _val = 0;
		private _errCnt = [];
		private _cnt1 = 0;
		private _cnt2 = 0;

		private _allow = [];
		private _ctr = [];
		for "_i" from _min to _max do {_allow pushBack _i; _ctr pushBack 0};
		private _bounds = [_min,_max];
		private _pcall = 0;
		for "_i" from 1 to _iterCount do {
			_pcall = (precentage(_iterCount,_i);
			if (_pcall% 10)==0)then{
				logformat("Progress: %1",_pcall);
			};
			//_val = randInt(_min,_max);
			_beg = _min;
			_end = _max;
			_rndvl = random 1;
			
			//case1 - !false
			//_rndvl = random (_max-_min);
			//_val = (_min + (floor _rndvl));

			//case2 - check
			_val = (floor linearConversion [0,1.000001,_rndvl,(_beg)min(_end),(_end)max(_beg)+1]);
			
			//case3 -!false
			// _result = (_rndvl * (1 + _max - _min)) + _min;
			// _val = floor _result;

			
			if !(_val in _allow) then {
				errorformat("Failed number %1 on iteration %2; rndval: %3",_val arg _i tofixed 1 arg _rndvl tofixed 10);
				_errCnt pushBack [_val,_i]
			};
			_curIdx__ = _allow find _val;
			_ctr set [_curIdx__,(_ctr select (_curIdx__)) + 1];
			if (_val in _bounds) then {
				array_remove(_bounds,_val);
			};
		};
		logformat("catch count: %1",_ctr apply {_x tofixed 1});
		ASSERT_STR(count _bounds == 0,"Not all bounds getted: " + str _bounds);

		if (count _errCnt > 0) then {
			ASSERT_STR(false,"Failed number; First: " + (str(_errCnt select 0)) + "; errcnt: " + (str count _errCnt));
		};
	};
}
#endif