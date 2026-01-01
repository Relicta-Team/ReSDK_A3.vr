// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include "..\TestFramework.h"

/*

		Stack - LIFO
		Queue - FIFO
		List - Custom list implementation with small features
		OrderedDict - Hashmap with ordered keys
		OrderedSet - Hashset with ordered keys
		!SafeTypeDict - not implemented
*/

TEST(StackBaseLogic)
{
	private _s = struct_new(Stack);

	//base value check
	private _cref = _s callv(getEnumerator);
	ASSERT_STR(_cref isequalType [],"Unexpected type - " + (str _cref));

	for "_i" from 1 to 10 do {
		_s callp(push,_i);
	};

	ASSERT_EQ(_s callv(length),10);
	ASSERT_EQ(_cref select 0,1);
	ASSERT_EQ(_cref select 9,10);

	for "_i" from 1 to 5 do {
		ASSERT_EQ(_s callv(pop),10+1-_i);
	};
	
	ASSERT_EQ(_s callv(length),5);

	//low level modify
	private _ptrCollection = _s callv(getEnumerator);
	_ptrCollection pushBack 123;
	ASSERT_EQ(_s callv(pop),123);

	_s callv(clear);
	ASSERT_EQ(_s callv(length),0);
}

TEST(StackWithParams)
{
	private _paramsRef = [2 arg 3 arg 4 arg 5];
	private _s = struct_newp(Stack,_paramsRef);
	_s callv(pop);
	_val4 = _s callv(pop);
	ASSERT_EQ(_val4,4);

	_s callv(clear);
	ASSERT_EQ(_s callv(length),0);

	ASSERT(_paramsRef isEqualRef (_s callv(getEnumerator)));
}

TEST(QueueBaseLogic)
{
	private _q = struct_new(Queue);
	for "_i" from 1 to 10 do {
		_q callp(enqueue,_i);
	};

	ASSERT_EQ(_q callv(length),10);

	private _val1 = _q callv(dequeue);
	ASSERT_EQ(_val1,1);
	//second check
	private _val2 = _q callv(dequeue);
	ASSERT_EQ(_val2,2);

	private _listCheck = [3,4,5,6,7,8,9,10];
	ASSERT_EQ(_q callv(getEnumerator),_listCheck);

	//lowlewely modify
	private _ptrCollection = _q callv(getEnumerator);
	_ptrCollection deleteAt 0; //latest del
	ASSERT_EQ(_q callv(dequeue),4);

	_q callv(clear);
	ASSERT_EQ(_q callv(length),0);
}

TEST(QueueWithParams)
{
	private _paramsRef = [1 arg 2 arg 3 arg 4 arg 5];
	private _q = struct_newp(Queue,_paramsRef);
	_val1 = _q callv(dequeue);
	_val2 = _q callv(dequeue);
	ASSERT_EQ(_val1,1);
	ASSERT_EQ(_val2,2);

	_q callv(clear);
	ASSERT_EQ(_q callv(length),0);

	ASSERT(_paramsRef isEqualRef (_q callv(getEnumerator)));
}

TEST(ListBaseLogic)
{
	private _l = struct_new(List);
	_l callp(addItem,"test");
	_l callp(addItem,"dest");
	_l callp(addItem,"last");

	ASSERT_EQ(_l callv(length),3);

	_l callp(removeItem,"test");
	ASSERT_EQ(_l callv(length),2);

	ASSERT_EQ(_l callp(itemAt,0),"dest");

	//change value
	ASSERT(_l callp(setItem,0 arg "dest_updated"));
	ASSERT_EQ(_l callp(itemAt,0),"dest_updated");

	private _last = _l callp(removeAt,1);
	ASSERT_EQ(_last,"last");
	ASSERT_EQ(_l callv(length),1);

	_l callv(clear);
	ASSERT_EQ(_l callv(length),0);
	
}

TEST(ListParametersUnsafeCopy)
{
	private _l_unsafecopy = struct_newp(List,[1 arg 2 arg 3]);
	private _contentPtr = _l_unsafecopy callv(getEnumerator);
	_contentPtr pushBack 4;
	ASSERT_EQ(_l_unsafecopy callv(length),4);
	ASSERT_EQ(_l_unsafecopy callp(itemAt,3),4);

	_l_unsafecopy callv(clear);
	ASSERT_EQ(_l_unsafecopy callv(length),0);
}

TEST(ListParametersSafeCopy)
{
	_l_safecopy = struct_newp(List,[1 arg 2 arg 3] arg true);
	private _contentCopy = _l_safecopy callv(getEnumerator);

	//safecopy increase size check
	_contentCopy pushBack 4;
	ASSERT_EQ(_l_safecopy callv(length),3);
	ASSERT_EQ(count _contentCopy,4);
	ASSERT_EQ(_l_safecopy callp(itemAt,2),3);

	//safecopy clear check
	_contentCopy = _l_safecopy callv(getEnumerator);
	_l_safecopy callv(clear);
	ASSERT_EQ(count _contentCopy,3);
	ASSERT_EQ(_l_safecopy callv(length),0);
}


TEST(OrderedDictBase)
{
	private _o = struct_new(OrderedDict);
	for "_i" from 1 to 5 do {
		_o callp(add, str _i arg _i);
	};

	//content checking
	ASSERT_EQ(_o callv(length),5);
	ASSERT(_o callp(contains,"3"));

	//onupdate content checking
	ASSERT(_o callp(remove,"3"));
	ASSERT_EQ(_o callv(length),4);
	ASSERT(!(_o callp(contains,"3")));

	ASSERT_EQ(_o callp(get,"2"),2);
	ASSERT_EQ(_o callp(getAtIndex,1),2);
	
	private _orderedKeys = ["1","2","4","5"];
	private _dictKeys = _o callv(getKeys);
	{
		ASSERT_EQ(_dictKeys select _forEachIndex,_x);
	} foreach _orderedKeys;

	private _orderedValues = [1,2,4,5];
	private _dictValues = _o callv(getValues);
	{
		ASSERT_EQ(_dictValues select _forEachIndex,_x);
	} foreach _orderedValues;

	{
		private _kvp = [
			_orderedKeys select _forEachIndex,
			_orderedValues select _forEachIndex
		];
		ASSERT_EQ(_x,_kvp);
	} foreach (_o callv(getEnumerator));

	//enumerator copy check
	private _enumRef = _o callv(getEnumerator);
	_o callv(clear);
	ASSERT_EQ(count _enumRef,4);
	ASSERT_EQ(_o callv(length),0);
}


TEST(OrderedDictParameters)
{
	private _list = [];
	for "_i" from 1 to 100 do {
		_list pushBack [str _i,_i];
	};

	private _o = struct_newp(OrderedDict,_list);
	private _keys = _o callv(getKeys);
	private _vals = _o callv(getValues);

	//content count checking
	ASSERT_EQ(_o callv(length),count _keys);
	ASSERT_EQ(_o callv(length),count _vals);
	ASSERT_EQ(count _keys,count _vals);

	//order checking
	for "_inum" from 1 to 100 do {
		private _i = _inum - 1;
		
		ASSERT_EQ(_keys select _i,str _inum);
		ASSERT_EQ(_vals select _i,_inum);
	};
}

TEST(OrderedSetBase)
{
	private _o = struct_new(OrderedSet);
	for "_i" from 1 to 5 do {
		_o callp(add, "val_" + (str _i));
	};

	//content checking
	ASSERT_EQ(_o callv(length),5);
	ASSERT(_o callp(contains,"val_3"));

	//onupdate content checking
	ASSERT(_o callp(remove,"val_3"));
	ASSERT_EQ(_o callv(length),4);
	ASSERT(!(_o callp(contains,"val_3")));

	ASSERT_EQ(_o callp(getAtIndex,1),"val_2");


	private _orderedKeys = ["val_1","val_2","val_4","val_5"];
	private _values = _o callv(getEnumerator);
	{
		ASSERT_EQ(_values select _forEachIndex,_x);
	} foreach _orderedKeys;


	//enumerator copy check
	private _enumRef = _o callv(getEnumerator);
	_o callv(clear);
	ASSERT_EQ(count _enumRef,4);
	ASSERT_EQ(_o callv(length),0);
}


TEST(OrderedSetParameters)
{
	private _list = [];
	for "_i" from 1 to 100 do {
		_list pushBack "val_" + (str _i);
	};

	private _o = struct_newp(OrderedSet,_list);
	private _values = _o callv(getEnumerator);

	//content count checking
	ASSERT_EQ(_o callv(length),count _values);
	ASSERT_EQ(count _values,100);

	//order checking
	for "_inum" from 1 to 100 do {
		private _i = _inum - 1;
		ASSERT_EQ(_values select _i,"val_" + (str _inum));
	};
}

TEST(EventHandlers)
{
	private _scopedVar = 1;
	private _ev = struct_newp(EventHandler,"TestEvent");
	ASSERT_EQ(_ev callv(getEventName),"TestEvent");
	private _function = {
		params ["_v"];
		_scopedVar = _scopedVar + _v;
	};

	_ev callp(add,_function); //3
	_ev callp(add,_function); //5
	private _lastId = _ev callp(add,_function); //7
	ASSERT_EQ(count (_ev getv(_events)),3);

	traceformat("Event handler %1",str _ev);

	_ev callp(callEvent,2);
	ASSERT_EQ(_scopedVar,7);

	_ev callp(remove,_lastId);
	ASSERT_EQ(count (_ev getv(_events)),2);

	_ev callp(remove,_function);
	ASSERT_EQ(count (_ev getv(_events)),1);

	_ev callv(removeAll);
	ASSERT_EQ(count (_ev getv(_events)),0);
}

TEST(ObjectEventHandlers)
{
	private _obj = new(object);

	private _ev = struct_newp(ObjectEventHandler,"TestEvent" arg _obj);
	ASSERT_EQ(_ev getv(_src),_obj);

	private _fn = {
		objParams_1(_val);
		traceformat("Args was %1",_this)
		ASSERT_EQ(this,_obj);
		ASSERT_EQ(_val,321);
	};

	_ev callp(add,_fn);

	traceformat("Object Event handler %1",str _ev);

	_ev callp(callEvent,321);

	delete(_obj);
}

TEST(LockingEventHandlers)
{
	private _ev = struct_newp(EventHandler,"LockableEvent");
	private _gvar = 0;
	private _f = {
		INC(_gvar);
		if (_gvar == 5) then {
			self callp(setLocked,true);
		};
	};

	for "_i" from 1 to 10 do {_ev callp(add,_f);};

	_ev callp(setLocked,true);
	_ev callp(callEvent,null);
	ASSERT_EQ(_ev getv(_locked),false);
	ASSERT_EQ(_gvar,0);

	_ev callp(callEvent,null);
	ASSERT_EQ(_ev getv(_locked),false);
	ASSERT_EQ(_gvar,5);

	//also for object evh
	_gvar = 0;

	private _obj = new(object);
	private _ev = struct_newp(ObjectEventHandler,"LockableEvent" arg _obj);

	for "_i" from 1 to 10 do {_ev callp(add,_f);};

	_ev callp(setLocked,true);
	_ev callp(callEvent,null);
	ASSERT_EQ(_ev getv(_locked),false);
	ASSERT_EQ(_gvar,0);

	_ev callp(callEvent,null);
	ASSERT_EQ(_ev getv(_locked),false);
	ASSERT_EQ(_gvar,5);

	delete(_obj);
}

TEST(StructExitWith)
{
	private _tdecl = [
		["#type","TestStruct"],
		["#str",{_self get "#type"}],
		["return_bool",{
			true
		}],
		["intval",9876],
		["func", {
			params ["_par"]; 
			if (_self call ["return_bool"]) exitWith {
				private _iv = _self get "intval";
				(format["val is %1",_self get "intval"])
				+ " +strval:"+(str _iv);
			}; 
			5678
		}]
	];
	private _obj = createhashmapobject [_tdecl,[]];
	traceformat("type: %1",_obj)
	private _rval = _obj call ["func",["test"]];
	traceformat("rval: %1",_rval)
	ASSERT_EQ(_rval,"val is 9876 +strval:9876");
}

TEST(InlineStruct)
{
	private _obj = inline_struct(AnonType)
		def(test_num) 123
		def(test_func)
		{
			self getv(test_num);
		}
		def(test_str) "hello"
	inline_endstruct;

	ASSERT_EQ(_obj getv(test_str),"hello");

	ASSERT_EQ(_obj callv(test_func),123);
}

TEST(SafeReferences)
{
	private _pool = ["UnitTest_SafeReference_Container"] call SafeReference_CreatePool;
	
	private _itm1 = struct_newp(SafeReference,"first val"); //default pool
	traceformat("item 1: %1",_itm1)
	ASSERT_EQ(_itm1 callv(getValue),"first val");
	ASSERT_EQ(_itm1 callv(getPtr),1);

	_itm1 callv(releaseRef); //manual release reference
	ASSERT_EQ(_itm1 callv(getPtr),0); //ref set to zero on release

	private _itm1_next = struct_newp(SafeReference,"first val in same pool");
	traceformat("item 1 next: %1",_itm1_next)
	ASSERT_EQ(_itm1_next callv(getValue),"first val in same pool");
	ASSERT_EQ(_itm1_next callv(getPtr),2);

	private _itm2 = struct_newp(SafeReference,"second val" arg _pool); //custom pool
	traceformat("item 2: %1",_itm2)
	ASSERT_EQ(_itm2 callv(getValue),"second val");
	ASSERT_EQ(_itm2 callv(getPtr),1); //other pool, first pointer is one

	ASSERT_STR(!(_itm2 callp(isEqualPoolType,_itm1_next)),"Pool types are equals");

	//cleanup
	_itm2 = null; _itm1_next = null;
	
	private _externalVar = "basic value";
	private _itm3 = null;
	//anon scope
	call {
		private _tObj = createhashmapobject [
			[
				["#type","ExampleType"],
				["#delete",{
					_externalVar = "overriden value";
				}]
			]
		];
		_itm3 = struct_newp(SafeReference,_tObj arg _pool);
		ASSERT_EQ(_itm3 callv(getValue),_tObj);
		ASSERT_EQ(_itm3 callv(getPtr),2);
	};
	
	ASSERT_EQ(_externalVar,"basic value");
	
	//removing ref and check external var
	_itm3 = null; //refcount is 0 - delete object
	ASSERT_EQ(_externalVar,"overriden value");
}


//TODO done hashing for all reference type objects
// FIXTURE_SETUP(SafeTypeDict)
// {
// 	objectList = [];
// 	for "_i" from 1 to 20 do {
// 		private _obj = createObj;
// 		_obj setName (format["TestObject_%1",_i]);
// 		objectList pushBack _obj;
// 	};
// }

// FIXTURE_TEARDOWN(SafeTypeDict)
// {
// 	{
// 		deleteObj _x;
// 	} foreach objectList;
// }

// TEST_F(SafeTypeDict,HashingCheck)
// {
// 	private _dict = struct_new(SafeTypeDict);
// 	{
// 		_dict callp(add,_x arg _forEachIndex);
// 	} foreach objectList;

// 	ASSERT_EQ(_dict callv(length),count objectList);
// }


TEST(ObjectStructBase)
{
	
}

#ifdef USE_SCRIPTED_PROFILING

;scripted_profile_test_function_example = {
	PROFILE_NAME("base_prof")

	for "_i" from 1 to 123 do {
		PROFILE_SCOPE_NAME("scoped_prof")
	};

	for "_i" from 1 to 10 do {
		//another scoped prof
		PROFILE_SCOPE_NAME("scoped_prof")
	};
};

TEST(ScriptedProfilerTests)
{
	/*
		We must clear all profiler data because this code called after possible exists profiler zones
	*/
	call profiler_clearResults;


	call scripted_profile_test_function_example;
	call scripted_profile_test_function_example;

	private _pobjects = [true] call profiler_getResults;

	ASSERT_EQ(count _pobjects,3);
	private _bprofIndex = _pobjects findif {(_x getv(_pzName) )== "base_prof"};
	ASSERT_NE(_bprofIndex,-1);
	private _bprof = _pobjects select _bprofIndex;
	ASSERT_EQ(_bprof getv(call_count),1 * 2);

	private _sprofobjects = _pobjects select {(_x getv(_pzName)) == "scoped_prof"};
	ASSERT_EQ(count _sprofobjects,2);
	private _obj123Index = _sprofobjects findif {(_x getv(call_count))==(123 * 2)};
	ASSERT_NE(_obj123Index,-1);
	private _obj123 = _sprofobjects deleteAt _obj123Index;
	
	ASSERT_EQ(count _sprofobjects,1);
	private _lastObj = _sprofobjects select 0;
	ASSERT_EQ(_lastObj getv(call_count),(10 * 2));

	//clear results
	call profiler_clearResults;
	_pobjects = [false] call profiler_getResults;
	ASSERT_EQ(count _pobjects,0);

	scripted_profile_test_function_example = null;
};
#endif