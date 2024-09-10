// ======================================================
// Copyright (c) 2017-2024 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include "..\engine.hpp"
#include "..\oop.hpp"
#include "..\struct.hpp"

/*
	Event Handler struct

	Example:

		_anonHandler = struct_new(EventHandler);
		_ev = {
			params ["_a"];
			["param is %1",_a] call messageBox;
		};
		_anonHandler callp(addEvent,_ev);

		//....

		_anonHandler callp(callEvent,"exists");


*/
struct(EventHandler)
	def_null(_events)
	def(_eventName) "";

	def(str)
	{
		private _name = self getv(_eventName);
		if (_name != "") then {
			format["%1::%3(%2)",struct_typename(self),count (self getv(_events)),_name];
		} else {
			format["%1(%2)",struct_typename(self),count (self getv(_events))];
		};
	}

	def(setEventName)
	{
		params ["_eventName"];
		self setv(_eventName,_eventName);
	};

	def(getEventName) {self getv(_eventName)};

	def(init)
	{
		params [["_eventName",""]];
		self setv(_eventName,_eventName);

		self setv(_events,[]);
	};

	def(add)
	{
		params ["_code"];
		(self getv(_events)) pushBack _code;
	};

	def(remove)
	{
		params ["_codeORid"];
		if equalTypes(_codeORid,0) then {
			(self getv(_events)) deleteAt _codeORid;
		} else {
			array_remove((self getv(_events)),_codeORid);
		};
	};

	def(removeAll)
	{
		(self getv(_events)) resize 0;
	};

	def(callEvent)
	{
		private _args = _this;
		{
			_args call _x;
		} foreach (self getv(_events));
	};

endstruct

/*
	Object Event Handler

	Example:
		class(SampleObject)
			var(evh,struct_newp(ObjectEventHandler,"SampleEvent" arg this));
		endclass

		//...

		_obj = new(SampleObject);
		_event = {
			objParams_2(_a,_b);
			logformat("Object %1; Args: %2 %3",_obj arg _a arg _b);
		};
		getVar(_obj,evh) callp(addEvent,_event);


		getVar(_obj,evh) callp(callEvent,2 arg 5);
*/
struct(ObjectEventHandler) base(EventHandler)
	def(_src) nullPtr;

	def(init)
	{
		params [["_eventName",""],["_obj",nullPtr]];
		assert_str(!isNullReference(_obj),"Object cannot be null");
		self setv(_src,_obj);
		self setv(_eventName,_eventName);
	};

	def(callEvent)
	{
		private _args = _this;
		
		private _objArgs = 
		if (isNullVar(_args)) then {
			self getv(_src)
		} else {
			private _targs = [self getv(_src)];
			_targs append _args;
			_targs;
		};

		{
			_objArgs call _x;
		} foreach (self getv(_events));
	};

endstruct


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
		if !(self callv(hasValue))exitWith {false};
		equals(self callp(getValue,_key),_value);
	}
endstruct

struct(Transform)
	def(_pos) null;
	def(_orient) null;

	def(init)
	{
		params [["_pos",[0,0,0]],["_orient",[[0,0,1],[0,0,1]]]];
		self setv(_pos,_pos);
		self setv(_orient,_orient);
	}

	cast_def(Array)
	{
		[self getv(_pos),self getv(_orient)]
	}

	def(str)
	{
		format["Transform %1+%2",self getv(_pos),self getv(_orient)];
	}
endstruct

struct(Model)
	def(_mesh) objNull;
	def(_vars) null;//for variables inside simple object
	def(__localFlag) false;
	def(isSimple) {isSimpleObject (self getv(_mesh))} 
	def(init)
	{
		params ["_cfgPath","_pos",["_simple",false],["_local",true]];
		
		if !(self callp(isValidModelPath,_cfgPath)) exitWith {};
		self setv(__localFlag,_local);
		self setv(_vars,createHashMap);
		self callp(_setMesh,_cfgPath arg _pos arg _simple arg _local);
	}

	def(_setMesh)
	{
		params ["_cfgPath",["_pos",[0,0,0]],["_simple",false]];
		if (_simple) then {
			private _mesh = createMesh([_cfgPath arg [0 arg 0 arg 0] arg self getv(__localFlag)]);
			assert(!isNullReference(_mesh));
			self setv(_mesh,_mesh);
			self callp(setPos,_pos);
		} else {
			private _mesh = ifcheck(self getv(__localFlag),_cfgPath createVehicleLocal vec3(0,0,0),_cfgPath createVehicle vec3(0,0,0));
			assert(!isNullReference(_mesh));
			self setv(_mesh,_mesh);
			self callp(setPos,_pos);
		};
	}

	def(del)
	{
		deleteVehicle (self getv(_mesh))
	}

	def(isValidModelPath)
	{
		params ["_cfgPath"];
		true
	}

	def(isVisible) {
		!(isObjectHidden (self getv(_mesh)))
	}
	def(setVisible) {
		params ["_visible"];
		(self getv(_mesh)) hideObject (!_visible);
	}

	def(getMesh) {}
	def(setMesh) { 
		params ["_model"];
		private _oldtransform = self callv(getTransform);
		deleteVehicle (self getv(_mesh));
		self callp(_setMesh,_model arg null arg self callv(isSimple) arg self getv(__localFlag));
		self callp(setTransform,_oldtransform);
	}

	def(setPos) {
		params ["_pos"];
		(self getv(_mesh)) setPosAtl _pos;
	}
	def(getPos) {
		getPosAtl (self getv(_mesh))
	}
	def(modelToWorld) {
		params ["_offset",["_visual",false]];
		private _o = self getv(_mesh);
		if (_visual) then {
			_o modelToWorldVisual _offset;
		} else {
			_o modelToWorld _offset;
		};
	}
	def(setTransform) {
		params ["_transform"];

		private _o = self getv(_mesh);
		_o setVectorDirAndUp (_transform getv(_orient));
		_o setPosAtl (_transform getv(_pos));
	}
	def(getTransform) {
		private _o = self getv(_mesh);
		struct_newp(Transform,getPosAtl _o arg vec2(vectorDir _o,vectorUp _o))
	}

	//variable management
	def(setVar) {
		params ["_key","_value"];
		(self getv(_vars)) set [_key,_value];
	}
	def(getVar) {
		params ["_key"];
		(self getv(_vars)) get [_key];
	}
	def(hasVar) {
		params ["_key"];
		_key in (self getv(_vars));
	}
	def(allVars) {
		keys (self getv(_vars))
	}
endstruct

#include "Structs\Core.sqf"

#include "Structs\Pointers.sqf"

#include "Structs\Collections.sqf"

#include "Structs\Profiling.sqf"

#include "Structs\Allocator.sqf"