// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
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
		for "_i" from 1 to _iterCount do {
			
			if ((_i% 1000000)==0)then{
				logformat("Progress: %1\%2",_i tofixed 0 arg _iterCount tofixed 0);
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


// TEST(RandomProbConvert)
// {
// 	private _iterCount = 1000000;
// 	private _probfnc = {random[0,50,100]};
// 	private _newprobfnc = {random 100};
// 	private _matcher = createHashmap;
// 	private _matcher2 = createHashmap;
	
// 	//fill container
// 	for"_i" from 0 to 100 do {
// 		_matcher set [_i,0];
// 		_matcher2 set [_i,0];
// 	};

// 	private _pval = 0;
// 	for "_s_iter" from 1 to _iterCount do {
// 		_pval = floor call _probfnc;
// 		_matcher set [_pval,(_matcher get _pval) + 1];
// 		_pval = floor call _newprobfnc;
// 		_matcher2 set [_pval,(_matcher2 get _pval) + 1];
// 	};

// 	//check
// 	logformat("Iter count: %1",_iterCount);
// 	for "_i" from 0 to 100 do {
// 		private _cv = _matcher get _i;
// 		private _cv2 = _matcher2 get _i;
// 		logformat("  Num %1",_i);
// 			logformat("     gauss: %1 %2%%",_cv arg _cv*100/_iterCount);
// 			logformat("    linear: %1 %2%%",_cv2 arg _cv2*100/_iterCount);
// 	};
// }

#ifdef CMD__ENABLE_CONVERSION_GAUSS_TO_LINEAR
#define pow(x,y) (x^y)
#define prob_old_to_new(val) ([val] call convf)

;convf = {
	params ["_val"];	
	_val = round _val;
	private _tvals = convertionTable get _val;
	if (count _tvals == 0) exitWith {
		errorformat("UNKNOWN VALUE: %1",_val);
		0
	};
	private _accVal = 0;
	{_accVal = _accVal + _x}foreach _tvals;
	_accVal / (count _tvals)//getting middle value
};
convertionTable = null;
createConvTable = {
	private _pPath = "src\Editor\Bin\RndConvTable.txt";//"src\host\UnitTests\TestsCollection\convTable.c";
	if fileExists(_pPath) exitWith {
		convertionTable = createHashMapFromArray (call compile LOADFILE(_pPath));
		//logformat("CONVTABLE: %1",convertionTable);
		convertionTable
	};
	ASSERT_STR(false,"In this version random convert table placed in " + _pPath);
	if(true)exitWith{};
	log("CREATING CONVERTION TABLE");
	private _itCnt = 100000;
	private _MRANGE = 100;
	private _dictOld = createHashMap;
	private _dictNew = createHashMap;
	private _convTable = createHashMap;
	private _oldProbFn = { private _val = floor (_this select 0); (random [0,50,100])<_val};
	private _newProbFn = { private _val = floor (_this select 0); random 100 < (_val)};
	for "_i" from 0 to _MRANGE do {
		_dictOld set [_i,0];
		_dictNew set [_i,0];
		_convTable set [_i,[]];
	};
	_prev = 0;
	for "_i" from 0 to _MRANGE do {
		logformat("GEN %1",_i);
		private _cv = _i;
		for "_j" from 1 to _itCnt do {
			if ([_cv] call _oldProbFn) then {
				_dictOld set [_cv,(_dictOld get _cv) + 1];
			};
			if ([_cv] call _newProbFn) then {
				_dictNew set [_cv,(_dictNew get _cv) + 1];
			}
		};

		_dictNew set [_cv,(_dictNew get _cv) * 100 / _itCnt];
		_dictOld set [_cv,(_dictOld get _cv) * 100 / _itCnt];

		_diffi = abs ((_dictOld get _cv)-(_dictNew get _cv));
		logformat("  PREC: %1 %2 (absm:%3); chng:%4",_dictOld get _cv arg _dictNew get _cv arg _diffi arg abs(_diffi - _prev));
		_prev = _diffi;
	};

	for "_i" from 0 to _MRANGE do {
		private _curPrec = _dictOld get _i;
		{
			if inRange(_curPrec,_y-0.8,_y+0.8) then {
				(_convTable get _i)pushBack _x;
			}	
		} foreach _dictNew;
	};
	convertionTable = _convTable;
	
	for"_i" from 0 to _MRANGE do {
		//logformat("Num %1: %2",_i arg convertionTable get _i);
		if (count (_convTable get _i)==0) exitWith {
			errorformat("EMPTY TABLE FOR NUM %1",_i);
			_convTable = null;
		};
	};

	private _dat = [];
	logformat("Path to save table %1",_pPath);
	for "_i" from 0 to _MRANGE do {
		if isNullVar(_convTable) exitWith {};
		_dat pushBack [_i,_convTable get _i];
	};
	if (count _dat == 101) then {
		if ([_pPath, "["+(_dat joinString (","+endl))+"]",true] call file_write) then {
			logformat("TABLE SAVED TO %1",_pPath);
		} else {
			logformat("ERROR SAVING TABLE TO %1",_pPath);
		};
	} else {
		errorformat("TABLE SIZE IS %1",count _dat);
	};

	_convTable
};

TEST(RandomProbConvert_Concept)
{
	ASSERT(!isNull(file_write));
	ASSERT(!isNull(call createConvTable));

	ASSERT(!isNull(convertionTable));
	ASSERT(count convertionTable == 101);
	
	private _iterCount = 100000;
	private _oldProbFn = { private _val = floor (_this select 0); (random [0,50,100])<_val};
	private _newProbFn = { private _val = floor (_this select 0); random 100 < prob_old_to_new(_val)};
	private _oldResults = createHashMap;
	private _newResults = createHashMap;

	for "_i" from 0 to 100 do {
		_oldResults set [_i tofixed 0, 0];
		_newResults set [_i tofixed 0, 0];
	};

	private _errors = 0;
	for"_p" from 0 to 100 do {
		private _cv = _p;
		private _strCv = _cv tofixed 0;
		for"_j" from 1 to _iterCount do {
			if ([_cv] call _oldProbFn) then {
				_oldResults set [_strCv,(_oldResults get _strCv) + 1];
			};
			if ([_cv] call _newProbFn) then {
				_newResults set [_strCv,(_newResults get _strCv) + 1];
			};
		};

		_old = _oldResults get _strCv;
		_new = _newResults get _strCv;
		logformat("Pass %1",_p);
			logformat("    Old: %1 %2%%",_old arg _old * 100 / _iterCount);
			logformat("    New: %1 %2%%",_new arg _new * 100 / _iterCount);
			if (abs(_old-_new)>1000) then {
				errorformat("      Diff: %1",abs(_old-_new));
				INC(_errors);
			} else {
				logformat("      Diff: %1",abs(_old-_new));
			};
		if (_errors > 0) exitWith{};
	};
	
	ASSERT_EQ(_errors,0);
	log("end check");
};

#endif


TEST(GurpsRandom)
{
	#include <..\..\GURPS\gurps.hpp>

	ASSERT_STR(!isNull(gurps_rollstd),"gurps_rollstd is null");

	private _count = 1000000;
	private _tmap = [];//amount results
	private _smap = createHashMap;//dice success
	
	//fill maps
	{_smap set [_x,0];} foreach [DICE_SUCCESS,DICE_CRITSUCCESS,DICE_FAIL,DICE_CRITFAIL];
	_tmap resize 17;//max rolls - offset
	_tmap = _tmap apply {0};

	for "_skill" from 1 to 20 do {
		//cleanup vals
		_tmap = _tmap apply {0};
		{_smap set [_x,0]} foreach _smap;

		logformat("Check skill value: %1",_skill);
		for"_i" from 1 to _count do {
		
			unpackRollResult(_skill call gurps_rollstd,_am,_smkey,_3d6roll);

			_smap set [_smkey,(_smap get _smkey) + 1];
			private _amStart = _3d6roll-3;
			_tmap set [_amStart,(_tmap select _amStart) + 1];
		};

		private _tda = _smap toArray false;
		_tda sort false;
		_tda = (_tda apply {_x params ["_k","_v"];format["%1=%2", getRollTypeText(_k), _v * 100 / _count]}) joinString ", ";
		logformat("    Throws: %1",_tda);
		{
			private _lval = _x * 100 / _count;
			#ifdef DEBUG
			logformat("      VAL %1=%2",_foreachIndex+3 arg _lval);
			#endif
		} foreach _tmap;
	};
}

TEST(randomizationVectorsCorrectResults)
{
	//use randomRadius, randomPosition, randomGaussian
	//check if the results are distributed evenly

	private _rrad = [[0,0,0],10] call randomRadius;
	ASSERT_STR(!isNullVar(_rrad),"null result");
	ASSERT_STR(equalTypes(_rrad,[]),"randomRadius result is not array");
	ASSERT_STR(count _rrad == 3,"randomRadius result is not 3 elements");
	ASSERT_STR(inRange(_rrad select 2,0,10),"randomRadius result is not in range");

	private _rpos = [[0,0,0],10] call randomPosition;
	ASSERT_STR(!isNullVar(_rpos),"null result");
	ASSERT_STR(equalTypes(_rpos,[]),"randomPosition result is not array");
	ASSERT_STR(count _rpos == 3,"randomPosition result is not 3 elements");
	ASSERT_STR(inRange(_rpos select 2,0,10),"randomPosition result is not in range");

	private _rgau = [[0,0,0],10] call randomGaussian;
	ASSERT_STR(!isNullVar(_rgau),"null result");
	ASSERT_STR(equalTypes(_rgau,[]),"randomGaussian result is not array");
	ASSERT_STR(count _rgau == 3,"randomGaussian result is not 3 elements");
	ASSERT_STR(inRange(_rgau select 2,0,10),"randomGaussian result is not in range");
	
}

TEST(testGetPosListCenter)
{
	private _list = [[0,0,0],[1,1,1],[2,2,2]];
	private _center = [_list] call getPosListCenter;
	ASSERT_STR(!isNullVar(_center),"null result");
	ASSERT_STR(equalTypes(_center,[]),"getPosListCenter result is not array");
	ASSERT_STR(count _center == 3,"getPosListCenter result is not 3 elements");
	ASSERT_STR(inRange(_center select 2,0,2),"getPosListCenter result is not in range");

	ASSERT_EQ(_center,vec3(1,1,1));

	private _list2 = [[0,0,0],[1,1,1],[2,2,2],[3,3,3]];
	private _center2 = [_list2] call getPosListCenter;
	ASSERT_STR(!isNullVar(_center2),"null result");
	ASSERT_STR(equalTypes(_center2,[]),"getPosListCenter result is not array");
	ASSERT_STR(count _center2 == 3,"getPosListCenter result is not 3 elements");
	ASSERT_STR(inRange(_center2 select 2,0,3),"getPosListCenter result is not in range");
	ASSERT_EQ(_center2,vec3(1.5,1.5,1.5));
}