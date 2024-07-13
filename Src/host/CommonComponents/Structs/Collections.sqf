// ======================================================
// Copyright (c) 2017-2024 the ReSDK_A3 project
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
	
	def(push) {params ["_el"]; self getv(_enum) pushBack _el};
	def(pop) {
		private _len = self callv(length);
		if (_len == 0) exitWith {null};
		self getv(_enum) deleteAt (_len-1)
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
			_kvList pushBack [_x,_y select 1];
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
		keys (self getv(_enum))
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
		if (_key in _map) then {
			//update
			(_map get _key) set [1,_val];
		} else {
			//add
			private _ordIdx = (self getv(_order)) pushBack _key;
			_map set [_key,_ordIdx];
		};
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
			private _curKey = _order select _iOffs;
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


//for this dict keys can be any type (objects,locations,widgets etc...)
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
		private _keyStr = hashValue _key;
		_map set [_keyStr,[_key,_val]];
	}

	def(remove)
	{
		params ["_key"];
		private _map = self getv(_enum);
		private _keyStr = hashValue _key;
		if !(_keyStr in _map) exitWith {false};
		_map deleteAt _keyStr;
		true
	}

	def(contains)
	{
		params ["_key"];
		(hashValue _key) in (self getv(_enum));
	}

	def(str)
	{
		str (self callv(getEnumerator))
	}

	def(getKeys)
	{
		(values (self getv(_enum))) apply {_x select 0}
	}

	def(getValues)
	{
		(values (self getv(_enum))) apply {_x select 1}
	}
endstruct