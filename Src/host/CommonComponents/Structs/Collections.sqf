// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

/*
	Collections

		Stack - LIFO
		Queue - FIFO
		List - Custom list implementation with small features
		OrderedDict - Hashmap with ordered keys
		OrderedSet - Hashset with ordered keys
*/
struct(IEnumerable)
	def(_enum) null

	//возвращает итератор
	def(getEnumerator) { self getv(_enum) }
	
	def(length) {count (self getv(_enum))}
	def(clear) {(self getv(_enum)) resize 0}

	def(str)
	{
		str(self getv(_enum))
	}
endstruct

//stack structure FIFO
struct(Stack) base(IEnumerable)
	def(init)
	{
		params [["_list",[]]];
		self setv(_enum,_list);
	}
	
	def(push) {params ["_el"]; (self getv(_enum)) pushBack _el};
	def(pop) {
		private _len = self callv(length);
		if (_len == 0) exitWith {null};
		(self getv(_enum)) deleteAt (_len-1)
	}
endstruct

//queue structure FILO
struct(Queue) base(IEnumerable)
	def(init)
	{
		params [["_list",[]]];
		self setv(_enum,_list);
	}
	
	def(enqueue) {params ["_el"]; self getv(_enum) pushBack _el};
	def(dequeue) {
		if (self callv(length) == 0) exitWith {null};
		self getv(_enum) deleteAt 0
	}
endstruct

//list structure
struct(List) base(IEnumerable)
	def(_copyEnum) false; //копирование последовательности
	def(init)
	{
		params [["_list",[]],["_copyEnum",false]];
		self setv(_enum,_list);
		self setv(_copyEnum,_copyEnum);
	}

	def(addItem)
	{
		params ["_item"];
		self getv(_enum) pushBack _item
	}
	def(removeItem)
	{
		params ["_item"];
		private _pitms = self getv(_enum);
		private _i = _pitms findif {equals(_x,_item)};
		if (_i>=0) then {
			_pitms deleteAt _i;
		};
	}

	def(removeAt)
	{
		params ["_index"];
		if (_index < 0) then {
			_index = (count (self getv(_enum))-1) + _index;
		};
		self getv(_enum) deleteAt _index;
	}

	def(itemAt)
	{
		params ["_index"];
		(self getv(_enum)) select _index
	}

	//setitem by index
	def(setItem)
	{
		params ["_index","_item"];
		private _lst = self getv(_enum);
		if !inRange(_index,0,count _lst) exitWith {false};
		_lst set [_index,_item];
		true
	}

	def(getEnumerator)
	{
		ifcheck(self getv(_copyEnum),array_copy(self getv(_enum)),self getv(_enum))
	}

endstruct

struct(OrderedDict) base(IEnumerable)
	def(_order) null; //keyorders
	def(_enum) null; //key:str, value:pair<index,value>

	def(getEnumerator)
	{
		private _kvList = [];
		private _map = self getv(_enum);
		{
			_kvList pushBack [_x,_map get _x select 1];
		} foreach (self getv(_order));
		_kvList
	}

	def(clear)
	{
		private _map = self getv(_enum);
		(self getv(_order)) resize 0;
		{
			_map deleteAt _x;
		} foreach _map;
	}

	def(init)
	{
		params [["_list",[]]];
		self setv(_order,[]);
		self setv(_enum,createHashMap);
		{
			self call ["add",_x];
			false
		} count _list;
	}

	def(add)
	{
		params ["_key","_val"];
		private _map = self getv(_enum);
		if (_key in _map) then {
			//update
			(_map get _key) set [1,_val];
		} else {
			//add
			private _ordIdx = (self getv(_order)) pushBack _key;
			_map set [_key,[_ordIdx,_val]];
		};
	}

	def(get)
	{
		params ["_key",["_default",null]];
		private _map = self getv(_enum);
		if (_key in _map) then {
			(_map get _key) select 1
		} else {
			_default
		};
	}

	def(getAtIndex)
	{
		params ["_index",["_default",null]];
		private _ord = self getv(_order);
		if !inRange(_index,0,count _ord) exitWith {false};
		private _k = _ord select _index;
		self callp(get,_k arg _default);
	}

	def(remove)
	{
		params ["_key"];
		private _map = self getv(_enum);
		if !(_key in _map) exitWith {false};
		private _ord = self getv(_order);
		private _ordIdx = (_map get _key) select 0;
		_ord deleteAt _ordIdx;
		_map deleteAt _key;
		private _curKey = null;
		//apply offsets to other keys
		for "_iOffs" from _ordIdx to (count _map - 1) do {
			private _curKey = _order select _iOffs;
			(_map get _curKey) set [0,_iOffs];
		};
		true
	}

	def(contains)
	{
		params ["_key"];
		_key in (self getv(_enum));
	}

	def(str)
	{
		str (self callv(getEnumerator))
	}

	def(getKeys)
	{
		array_copy(self getv(_order))
	}

	def(getValues)
	{
		private _valList = [];
		private _map = self getv(_enum);
		{
			_valList pushBack (_map get _x select 1);
			false
		} count (self getv(_order));
		_valList
	}

endstruct

struct(OrderedSet) base(IEnumerable)
	def(_order) null; //keyorders
	def(_enum) null; //key:str, index

	def(getEnumerator)
	{
		array_copy(self getv(_order))
	}

	def(clear)
	{
		private _map = self getv(_enum);
		(self getv(_order)) resize 0;
		{
			_map deleteAt _x;
		} foreach _map;
	}

	def(init)
	{
		params [["_list",[]]];
		self setv(_order,[]);
		self setv(_enum,createHashMap);
		{
			self callp(add,_x);
			false
		} count _list;
	}

	def(add)
	{
		params ["_key"];
		private _map = self getv(_enum);
		if !(_key in _map) then {
			//add
			private _ordIdx = (self getv(_order)) pushBack _key;
			_map set [_key,_ordIdx];
		};
	}

	def(getAtIndex)
	{
		params ["_index"];
		private _ord = self getv(_order);
		if !inRange(_index,0,count _ord) exitWith {false};
		_ord select _index
	}

	def(remove)
	{
		params ["_key"];
		private _map = self getv(_enum);
		if !(_key in _map) exitWith {false};
		private _ord = self getv(_order);
		private _ordIdx = (_map get _key);
		
		_ord deleteAt _ordIdx;
		_map deleteAt _key;
		private _curKey = null;
		//apply offsets to other keys
		for "_iOffs" from _ordIdx to (count _map - 1) do {
			private _curKey = _ord select _iOffs;
			_map set [_curKey,_iOffs]
		};
		true
	}

	def(contains)
	{
		params ["_key"];
		_key in (self getv(_enum));
	}
endstruct

//constant hashable type
stdf_const_types = [
	[],
	false,
	{},
	configFile,
	grpNull,
	missionnamespace,
	0,
	objNull,
	blufor,
	""
];
stdf_const_containerTypes = [
	locationNull,
	controlNull,
	displayNull
];
stdf_genHash = {
	hashValue(tickTime + deltaTime + (random(10000)))
};
stdf_varnameCnt = ".@hash_container__";

//hashing function
;sftd_hashFunc = {
	params ["_val"];
	if (_val isEqualTypeAny stdf_const_types) then {
		hashValue _val;
	} else {
		if (_val isEqualTypeAny stdf_const_containerTypes) exitWith {
			private _hash = _val getvariable stdf_varnameCnt;
			if isNullVar(_hash) then {
				_hash = call stdf_genHash;
				_val setVariable [stdf_varnameCnt,_hash];
			};
			_hash
		};
		if equalTypes(_val,hashMapNull) exitWith {

		};
		if isNullVar(_val) exitWith {
			setLastError("Cannot hashing null value");
		};
		setLastError("Unhashable type " + typename _val);
	}
};

//for this dict keys can be any type (objects,locations,widgets etc...)
//! currently not supported completly (only hashvalue-like types)
struct(SafeTypeDict) base(IEnumerable)
	def(_enum) null; //key:str, value:[anytype,val]
	def(getEnumerator)
	{
		private _kvList = [];
		private _map = self getv(_enum);
		{
			_kvList pushBack [_y select 0,_y select 1];
		} foreach (self getv(_enum));
		_kvList
	}

	def(clear)
	{
		private _map = self getv(_enum);
		(self getv(_order)) resize 0;
		{
			_map deleteAt _x;
		} foreach _map;
	}

	def(init)
	{
		params [["_list",[]]];
		{
			self call ["add",_x];
			false
		} count _list;
	}

	def(add)
	{
		params ["_key","_val"];
		private _map = self getv(_enum);
		private _keyStr = [_key] call sftd_hashFunc;
		_map set [_keyStr,[_key,_val]];
	}

	def(remove)
	{
		params ["_key"];
		private _map = self getv(_enum);
		private _keyStr = [_key] call sftd_hashFunc;
		if !(_keyStr in _map) exitWith {false};
		_map deleteAt _keyStr;
		true
	}

	def(contains)
	{
		params ["_key"];
		([_key] call sftd_hashFunc) in (self getv(_enum));
	}

	def(str)
	{
		str (self callv(getEnumerator))
	}

	def(getKeys)
	{
		//todo hash conversion to value
		(values (self getv(_enum))) apply {_x select 0}
	}

	def(getValues)
	{
		(values (self getv(_enum))) apply {_x select 1}
	}
endstruct