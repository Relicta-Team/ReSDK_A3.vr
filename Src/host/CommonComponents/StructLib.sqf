// ======================================================
// Copyright (c) 2017-2024 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include "..\engine.hpp"
#include "..\oop.hpp"
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

/*
	Context struct

	Example:

		_ctx = struct_new(Context);
		_ctx callp(setValue,"test" arg 1)

		_ctx call {
			private _ctx = _this;
			if (_ctx callp(compare,"test" arg 1)) then {
				["Called"] call messageBox;
			};
		};
*/
struct(ContextParamData)
	def(_@created) 0;
	def(_@defaults) null;
	def(_@caseSense) true;

	def(init)
	{
		params [["_arrContent",[]],["_caseSense",true]];
		private _mapCurKeys = keys self;
		
		self setv(_@defaults,_mapCurKeys);

		private _map = self;
		{
			_x params ["_k","_v"];
			if (!_caseSense) then {
				_k = tolower _k;
			};
			_map set _x;
		} count _arrContent;
		
		self setv(_@caseSense,_caseSense);
		self setv(_@created,tickTime);
	}

	def(getKeys)
	{
		private _kList = [];
		private _lowerize = !(self getv(_@caseSense));
		{
			if (_lowerize) then {
				_x = tolower _x;
			};
			_kList pushBack _x;
			false;
		} count (keys self);

		_kList
	}

	def(getValue)
	{
		params ["_key","_default"];
		if !(self getv(_@caseSense)) then {_key = tolower _key;};

		if isNullVar(_default) then {
			self get _key
		} else {
			self getOrDefault [_key,_default]
		};
	}

	def(setValue)
	{
		params ["_key","_value"];
		if !(self getv(_@caseSense)) then {_key = tolower _key;};

		self set [_key,_value];
	}

	def(hasValue)
	{
		params ["_key"];
		if !(self getv(_@caseSense)) then {_key = tolower _key;};

		_key in self;
	}

	def(compare)
	{
		params ["_key","_value"];
		if !(self callp(hasValue))exitWith {false};
		equals(self callp(getValue,_key),_value);
	}
endstruct

//TODO implement
struct(Model)
	def(_mesh) objNull;
	def(_vars) null;//for variables inside simple object
	def(isSimple) {isSimpleObject (self getv(_mesh))} 
	def(init)
	{
		params ["_cfgPath","_pos",["_simple",false],["_local",true]];
		
		if !(self callp(isValidModelPath,_cfgPath)) exitWith {};
		
		if (_simple) then {
			self setv(_vars,createHashMap);
			private _mesh = createSimpleObject [_cfgPath,[0,0,0],_local];
			assert(!isNullReference(_mesh));
			self setv(_mesh,_mesh);
			self callp(setPos,_pos);
		} else {

		};
	}

	def(del)
	{
		deleteVehicle (self getv(_mesh))
	}

	def(isValidModelPath)
	{
		params ["_cfgPath"];
	}

	def(isVisible) {}
	def(setVisible) {}
	def(getMesh) {}
	def(setMesh) { params ["_model"];}

	def(setPos) {}
	def(getPos) {}
	def(modelToWorld) {}
	def(setTransform) {}
	def(getTransform) {}

	//variable management
	def(setVar) {}
	def(getVar) {}
	def(hasVar) {}
	def(allVars) {}
endstruct

#include "Structs\Core.sqf"

#include "Structs\Pointers.sqf"

#include "Structs\Collections.sqf"

#include "Structs\Profiling.sqf"