// ======================================================
// Copyright (c) 2017-2024 the ReSDK_A3 project
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