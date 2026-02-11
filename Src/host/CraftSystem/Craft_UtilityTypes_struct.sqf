// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

struct(CraftDynamicPrecVal__)
	def(isPrecentage) false;
	def(val) 0;
	def(init)
	{
		params ["_val"];
		private _isPrec = equalTypes(_val,"");
		self setv(isPrecentage,_isPrec);
		
		self setv(val, ifcheck(_isPrec,parseNumberSafe(_val),_val) );
	}

	def(validate)
	{
		params ["_maxVal","_checkVal",["_greaterThan",true]];
		private _funcValid = ifcheck(_greaterThan,{(_this select 0) >= (_this select 1)},{(_this select 0) <= (_this select 1)});
		
		if (self getv(isPrecentage)) then {
			[_checkVal,precentage(_maxVal,self getv(val))] call _funcValid;
		} else {
			[_checkVal,self getv(val)] call _funcValid;
		};
	}

	def(str) { format["%1%2",self getv(val),ifcheck(self getv(isPrecentage),"%","")] }
endstruct

struct(CraftDynamicCountRange__)
	def(isRangeBased) false;
	def(val) null;
	def(init)
	{
		params ["_v"];
		if equalTypes(_v,0) then {
			self setv(isRangeBased,false);
			self setv(val,_v);
		} else {
			assert_str(equalTypes(_v,hashMapNull),"Invalid type");
			assert("min" in _v);
			assert("max" in _v);
			self setv(isRangeBased,true);
			self setv(val,vec2(_v get "min",_v get "max"));
		};
	}
	def(getValue)
	{
		if (self getv(isRangeBased)) then {
			(self getv(val)) params ["_min","_max"];
			rand(_min,_max)
		} else {
			self getv(val)
		};
	}

	def(str)
	{
		format["Count:%1",ifcheck(self getv(isRangeBased), ((self getv(val)) apply {str _x}) joinString "-", self getv(val)  )]
	}
endstruct