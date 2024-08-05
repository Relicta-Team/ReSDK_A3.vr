// ======================================================
// Copyright (c) 2017-2024 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include "..\engine.hpp"
#include "..\oop.hpp"
#include "..\struct.hpp"

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
			private _mesh = createSimpleObject [_cfgPath,[0,0,0],self getv(__localFlag)];
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