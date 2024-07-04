// ======================================================
// Copyright (c) 2017-2024 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include "..\engine.hpp"
#include "..\struct.hpp"

//! not supported
/*
	mmr_pool = []; //memory pool for struct references
	mmr_allocator_s = null;

	_initStruct = { //need calling on structure initialization
		mmr_allocator_s = struct_new(DefaultAllocator);
	};

	struct(DefaultAllocator)
		def(_i) 0 //this is next given pointer for next allocation
		//allocate object in memory address and return pointer/address of object
		def(allocate)
		{
			params ["_o"];
			private _icur = self getv(_i);
			//check limit
			if (_icur >= 999999) exitWith {
				setLastError("Memory limit reached");
			};

			mmr_pool set [_icur,_o];
			self setv(_i,_icur);
		}

		def(deallocate)
		{
			params ["_ptr"];
			mmr_pool set [_ptr, null];
		}
	endstruct
*/

// Safe reference. Used for bypass crossreferences and possible memory leaks
sref_cont = createHashMap;
sref_i = 0;
struct(SafeRef)
	def(iptr) null //integer pointer is just a number

	def(init)
	{
		params ['_obj'];
		private _curi = sref_i;
		self setv(iptr, _curi);
		sref_cont set [_curi,_obj];
		sref_i = _curi + 1;		
	}
	def(releaseRef)
	{
		sref_cont deleteAt (self getv(iptr));
	}
	def(getPtr) {self getv(iptr)}
	def(getValue) {sref_cont get (self getv(iptr))}

	def(del)
	{
		self callv(releaseRef);
	}

	def(str)
	{
		format["ref:%1<%2>",self getv(iptr),self callv(getValue)]
	}
endstruct


struct(_SmartPointerBase)
	def(_v) null

	//_ptr callv(get)
	def(get)
	{
		self getv(_v)
	}

	def(deleted)
	{
		private _v = self getv(_v);
		if isNullVar(_v) exitWith {true};
		if equalTypes(_v,objNull) exitWith {!isNullReference(_v)};
		false
	}

	def(dispose)
	{
		private _v = self getv(_v);
		if !(self callv(deleted)) then {
			call {
				if equalTypes(_v,objNull) exitWith {deletevehicle _x};
				assert_str(false,"Not supported type for removing");
			};
			self setv(_v,null);
		};
	}
endstruct

/*
	AutoPtr - is smart pointer. He will delete source on last reference is removed
	Now 
	Usage:
		if (true) then {
			private _model = "VehicleConfigExample" createVehicle [0,0,0];
			private _obj = struct_newp(AutoPtr,_model);
			logformat("Autoptr value is %1",_obj callv(get));
		};
		assert(isNullReference(_model))
*/
struct(AutoPtr) base(_SmartPointerBase)
	def(_v) null
	def(init)
	{
		params ["_data"];
		self setv(_v,_data)
	}
	
	def(del)
	{
		callv(dispose)
	}

endstruct

/*
	Collections
*/
struct(IEnumerable)
	def(_enum) null
	def(getEnumerator) { self getv(_enum) }
	
	def(length) {count (self getv(_enum))}
	def(clear) {self getv(_enum) resize 0}

	def(str)
	{
		str(self getv(_enum))
	}
endstruct

//stack structure
struct(Stack) base(IEnumerable)
	def(init)
	{
		params [["_list",[]]];
		self setv(_enum,_list);
	}
	
	def(push) {params ["_el"]; self getv(_enum) pushBack _el};
	def(pop) {
		if (self callv(length) == 0) exitWith {null};
		self getv(_enum) deleteAt -1
	}
endstruct

//list structure
struct(List) base(IEnumerable)
	def(init)
	{
		params [["_list",[]]];
		self setv(_enum,_list);
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

endstruct

/*
	PROFILING
*/
prof_map_zones = createHashMap;

//this can be used for hotreload fixing
struct(ProfilerSystem)
	def(zone) createHashMap

endstruct

struct(ProfileZone)
	def(_name) "Anon_Scope";
	def(_line) 0;
	def(_time) 0;
	def(_isScoped) false;
	def(init)
	{
		params ["_name","_line",["_isScoped"]];
		self setv(_name,_name);
		self setv(_line,_line);
		self setv(_isScoped,_isScoped);
		//TODO work scoped: add to stack

		self setv(_time,tickTime);
	}

	def(del)
	{
		private _delta = tickTime - (self getv(_time));
		//TODO set result
	}
endstruct