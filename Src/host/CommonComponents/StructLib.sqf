// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
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
	def(_locked) false; //блокирующий режим

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
			if (self getv(_locked)) exitWith {};
			_args call _x;
		} foreach (self getv(_events));
		
		if (self getv(_locked)) then {
			self setv(_locked,false);
		};
	};

	def(setLocked)
	{
		params["_mode"];
		self setv(_locked,_mode);
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
			if (self getv(_locked)) exitWith {};
			_objArgs call _x;
		} foreach (self getv(_events));

		if (self getv(_locked)) then {
			self setv(_locked,false);
		};
	};

endstruct

/*
	Version struct
*/
struct(Version)
	def(major) 0;
	def(minor) 0;
	def(patch) 0;
	def(build) 0;

	/*
		_vBase - string, array, number
	*/
	def(init)
	{
		params ["_vBase","_min","_pat","_bld"];
		if isNullVar(_vBase) then {
			_vBase = "0.0";
		};

		if equalTypes(_vBase,"") then {
			private _numArr = (_vBase splitString ",. ") apply {parseNumber(_x)};
			self callp(__setVersion,_numArr);
		} else {
			if equalTypes(_vBase,[]) then {
				self callp(__setVersion,_vBase);
			} else {
				assert(equalTypes(_vBase,0));
				self callp(__setVersion,[_vBase arg _min arg _pat arg _bld]);
			};
		};
	}

	def(__setVersion)
	{
		params ["_d"];
		
		private _mapping = ["major","minor","path","build"];
		{
			private _xval = _x;
			if isNullVar(_xval) then {
				_xval = 0;
			};
			assert(equalTypes(_xval,0));
			self set [_mapping select _foreachindex,_xval];
		} foreach _d;
	}

	def(str)
	{
		private _vArr = [self getv(major),self getv(minor)];
		
		_vArr pushBack (self getv(patch));
		_vArr pushBack (self getv(build));

		(_vArr apply {str _x}) joinString ".";
	}

	/*
		private _v = struct_new(Version,"1.3");
		_v callp(compare,struct_newp(Version,"1.0"))
		Положительные числа - вызывающий объект новее, отрицательные - переданный аргумент новее
		0 - если версии равны

	*/
	def(compare)
	{
		params ["_over"];
		
		if (equalTypes(_over,"") || {equalTypes(_over,[])}) then {
			_over = struct_newp(Version,_over);
		};
		
		private _ret = 0;
		call {
			if ((self getv(major)) < (_over getv(major))) exitWith {_ret = -1};
			if ((self getv(major)) > (_over getv(major))) exitWith {_ret = 1};
			if ((self getv(minor)) < (_over getv(minor))) exitWith {_ret = -1};
			if ((self getv(minor)) > (_over getv(minor))) exitWith {_ret = 1};
			if ((self getv(patch)) < (_over getv(patch))) exitWith {_ret = -1};
			if ((self getv(patch)) > (_over getv(patch))) exitWith {_ret = 1};
			if ((self getv(build)) < (_over getv(build))) exitWith {_ret = -1};
			if ((self getv(build)) > (_over getv(build))) exitWith {_ret = 1};
		};

		_ret
	}

	// def(checkOp)
	// {
	// 	// #define __opstr(val) #val
	// 	// #define OP_(sym) [__opstr(sym),{(_this select 0) sym (_this select 1)}]

	// 	// private _smap = createHashMapFromArray [
	// 	// 	OP_(==),
	// 	// 	OP_(!=),
	// 	// 	OP_(>),
	// 	// 	OP_(<),
	// 	// 	OP_(>=),
	// 	// 	OP_(<=)
	// 	// ];

	// 	// #undef __opstr
	// 	// #undef OP_
	// 	false
	// }

endstruct

/*
	Internal type for inline structs ( struct api 1.7+)
*/
struct(InlineStructBase__)
	def(init)
	{
		//no params for inline struct
	}

	def(str)
	{
		format["[INLINE_STRUCT]%1",self callv(str)]; //for compatibility inline methods
	}
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
		params ["_cfgPath","_pos","_simple",["_local",true]];
		
		if !(self callp(isValidModelPath,_cfgPath)) exitWith {
			setLastError(format["Invalid mesh: %1" arg _cfgPath]);
		};

		if isNullVar(_simple) then {
			_simple = self callp(__isSimpleModelPath,_cfgPath);
		};

		self setv(__localFlag,_local);
		self setv(_vars,createHashMap);
		self callp(_setMesh,_cfgPath arg _pos arg _simple);
	}

	def(__isSimpleModelPath)
	{
		params ["_cfgPath"];
		(".p3d" in _cfgPath || ("\" in _cfgPath))
	}

	def(_setMesh)
	{
		params ["_cfgPath",["_pos",[0,0,0]],["_simple",false]];
		if (_simple) then {
			private _mesh = createMesh([_cfgPath arg [0 arg 0 arg 0] arg self getv(__localFlag)]);
			assert_str(!isNullReference(_mesh),"Cannot create mesh: " + _cfgPath);
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
		self callv(removeMesh);
	}

	def(str)
	{
		format["Mesh[%1]",self getv(_mesh)]
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

	def(getMesh) {self getv(_mesh)}
	def(setMesh) { 
		params ["_model"];
		private _oldtransform = self callv(getTransform);
		deleteVehicle (self getv(_mesh));
		self callp(_setMesh,_model arg null arg self callv(isSimple) arg self getv(__localFlag));
		self callp(setTransform,_oldtransform);
	}
	def(removeMesh)
	{
		deleteVehicle (self getv(_mesh))
	}

	def(setCollisionWith)
	{
		params ["_to","_mode"];
		if (_mode) then {
			(self getv(_mesh)) enableCollisionWith _to;
		} else {
			(self getv(_mesh)) disableCollisionWith _to;
		};
	}

	def(setPos) { params ["_pos"]; (self getv(_mesh)) setPosAtl _pos; }
	def(getPos) { getPosAtl (self getv(_mesh)) }

	def(setDir) { params ["_dir"]; (self getv(_mesh)) setDir _dir; }
	def(getDir) { getDir (self getv(_mesh)) }

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

#include "Structs\Updates.sqf"