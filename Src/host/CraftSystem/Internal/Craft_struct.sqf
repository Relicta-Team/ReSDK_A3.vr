// ======================================================
// Copyright (c) 2017-2024 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================


#include <..\..\engine.hpp>
#include <..\..\struct.hpp>
#include <..\..\oop.hpp>
#include "Craft.h"

// because keyword used in struct field
#undef class

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

struct(CraftRecipeComponent)
	def(class) null;
	def(isMultiSelector) false;
	def(count) 1;
	def(hp) null; //required helath of ingredient
	def(checkTypeOf) true;
	def(optional) false;
	def(destroy) true;
	def(conditionEvent) {true};
	def(metaTag) ""; //!reserved

	def(init)
	{
		params ["_class"];
		if equalTypes(_class,[]) then {
			self setv(isMultiSelector,true);
		};
		self setv(class,_class);
	}

	def(str)
	{
		format["%3%1%4 x%2",ifcheck(self getv(isMultiSelector),self getv(class) joinString "|",self getv(class)),self getv(count),ifcheck(self getv(checkTypeOf),"^",""),ifcheck(self getv(optional),"?","")]
	}

	def(getComponentTextData)
	{
		private _textData = if (self getv(isMultiSelector)) then {
			private _itms = (self getv(class)) apply {getFieldBaseValueWithMethod(_x,"name","getName")};
			private _iListUni = [];
			{
				if !array_exists(_iListUni,_x) then {
					_iListUni pushBack _x;
				};
			} foreach _itms;
			private _itmsTxt = _iListUni joinString " или ";
			_itmsTxt
		} else {
			private _itmsTxt = getFieldBaseValueWithMethod(self getv(class),"name","getName");
			_itmsTxt
		};

		if (self getv(count) > 1) then {
			modvar(_textData) + (format[" (x%1)",self getv(count)]);
		};
		if (self getv(optional)) then {
			modvar(_textData) + " (необяз.)"
		};

		_textData
	}

	def(_ingredientRegister)
	{
		params ["_storageRef","_recipeRef"];
		private _classList = self getv(class);
		if !(self getv(isMultiSelector)) then {
			_classList = [_classList];
		};

		private _checkTypeOf = self getv(checkTypeOf);
		//private _isOptional = self getv(optional);
		private _store = _storageRef;

		private _registererFunc = {
			_x = tolower _x;
			if !(_x in _store) then {
				_store set [_x,[_recipeRef]];
			} else {
				(_store get _x) pushBack _recipeRef;
			};
		};

		{
			if (_checkTypeOf) then {
				_registererFunc foreach getAllObjectsTypeOfStr(_x);
			};

			call _registererFunc;
			false
		} count _classList;
	}

	def(isValidIngredient)
	{
		params ["_ingredient"];
		
	}

endstruct

struct(CraftRecipeResult)
	def(class) null;
	def(count) null; //type CraftDynamicCountRange__
	def(radius) 0;
	def(modifiers) null;

	def(init)
	{
		params ["_class","_count"];
		self setv(class,_class);
		self setv(count,struct_newp(CraftDynamicCountRange__,_count));
		self setv(modifiers,[]);
	}

	def(str)
	{
		format["%1 %2",self getv(class),(self getv(count))];
	}
endstruct

struct(CraftRecipeResultModifier)
	def(name) null;
	def(params) [];
	def(__raised) false;

	def(init)
	{
		params ["_paramData"];
		if equalTypes(_paramData,"") exitWith {
			self setv(name,_paramData);
		};

		private _pname = _paramData get "name";
		if not_equalTypes(_pname,"") exitWith {self setv(__raised,true)};

		private _val = _paramData get "value";
		if !isNullVar(_val) exitWith {
			self setv(params,[_val]);	
		};
		_val = _paramData get "parameters";
		if !isNullVar(_val) exitWith {
			self setv(params,[_val]);
		};
	}

	def(str)
	{
		format["%1(%2)",struct_typename(self),self getv(name)]
	}
endstruct


struct(ICraftRecipeBase)
	def(name) "";
	def(desc) "";
	def(c_type) "";
	def(categoryId) -1; //айди категории

	def(craftId) -1 //глобальный айди крафта

	def(getType) { self getv(c_type) };

	def(hasPreviewCraft) { (self getv(c_type)) == "building" }

	def(init)
	{
		if (struct_typename(self) == "ICraftRecipeBase") exitWith {
			setLastError("ICraftRecipeBase is abstract struct");
		};
	}

	//тут происходит присвоение идентификатора и сохранение в буферах
	def(onRecipeReady)
	{
		self setv(craftId,csys_global_counter);
		csys_map_allCraftRefs set [csys_global_counter,self];
		INC(csys_global_counter);
	}

	def(str)
	{
		format["%1:%2[%3]=(%4)",
			self getv(c_type),
			self getv(craftId),
			self getv(name),
			[((self getv(components)) joinString " + "),"""",""] call regex_replace
		]
	}

	def(canApplySystemSpecific) { (self getv(c_type)) == "system" }
	
	//internal vars
	def(__canGetNameFromResult) false; // при true название рецепта будет браться из результата
	def(forceVisible) false; //видимость рецепта при нехватке ингредиентов
	def(skills) null; //hashmap of skills with values
	def(components) null; //dict of components
	def(result) null;

	//обработка требований
	def(_parseRequired)
	{
		params ["_req","_refResult"];
		
		CRAFT_PARSER_HEAD;
		
		GETVAL_BOOL(_req, vec2("forceVisible",self getv(forceVisible)));
		FAIL_CHECK_REFSET(_refResult);
		if (value != (self getv(forceVisible))) then {
			self setv(forceVisible,value);
		};
	
		private _filledSkills = createHashMap;
		GETVAL_DICT(_req, vec2("skills",_filledSkills));
		FAIL_CHECK_REFSET(_refResult);
		
		assert(!isNull(skills_internal_list_otherSkillsSystemNames));
		private _validSkills = hashSet_create(skills_internal_list_otherSkillsSystemNames);
		//validation skills
		{
			_x = tolower _x;
			
			if !array_exists(_validSkills,_x) exitWith {
				refset(_refResult,"Invalid skill name: " + _x);
			};
			if (_y < 1 || (round _y != _y)) exitWith {
				refset(_refResult,"Invalid skill level: " + (str _y));
			};
			_filledSkills set [_x,_y];
		} foreach value;
		
		if (refget(_refResult) != "") exitWith {};

		self callp(_parseRequiredComponents,_req arg _refResult);
		//if (refget(_refResult) != "") exitWith {};
	};

	def(_parseRequiredComponents)
	{
		params ["_cdict","_refErr"];
		CRAFT_PARSER_HEAD;

		GETVAL_ARRAY(_cdict, vec2("components",[]));
		FAIL_CHECK_REFSET(_refErr);
		if (count value == 0) exitWith {
			refset(_refErr,"Components list is empty");
		};
		
		private _ingredientList = [];
		self setv(components,_ingredientList);

		self callp(_parseRequiredComponents_Internal,value arg _ingredientList arg _refErr);
	};

	def(_parseRequiredComponents_Internal)
	{
		params ["_content","_ingredientList","_refErr"];
		CRAFT_PARSER_HEAD;
		private _ingredient = null;
		traceformat("COMPONENTS CHECK %1",_content)
		{
			
			private _cls = _x get "class";
			private _exitClasscheck = false;
			if isNullVar(_cls) exitWith {
				message = "Property 'class' must be defined in components";
			};
			if not_equalTypes(_cls,[]) then {_cls = [_cls,true] call csys_prepareRangedString};

			{

				if not_equalTypes(_x,"") exitWith {
					_exitClasscheck = true;
					refset(_refErr,"Property 'class' wrong type; Expected string");
				};
				_x = [_x] call csys_prepareRangedString;
				_cls set [_foreachindex,_x];

				if !isImplementClass(_x) exitWith {
					_exitClasscheck = true;
					refset(_refErr,"Ingredient class not found: " + _x);
				};
				
			} foreach _cls;
			
			if (_exitClasscheck) exitWith {};
			if (count _cls == 1) then {
				_cls = _cls select 0;
			};
			
			_ingredient = struct_newp(CraftRecipeComponent,_cls);

			GETVAL_INT(_x, vec2("count",1));
			FAIL_CHECK_REFSET(_refErr);
			if !inRange(value,1,100) exitWith {
				refset(_refErr,"Invalid count: " + (str value));
			};
			_ingredient setv(count,value);

			private _hpval = _x get "hp";
			if !isNullVar(_hpval) then {
				private _hpObj = struct_newp(CraftDynamicPrecVal__, _hpval);
				_ingredient setv(hp,_hpObj);
			};

			GETVAL_BOOL(_x, vec2("check_type_of",_ingredient getv(checkTypeOf)));
			FAIL_CHECK_REFSET(_refErr);
			_ingredient setv(checkTypeOf,value);

			GETVAL_BOOL(_x, vec2("optional",_ingredient getv(optional)));
			FAIL_CHECK_REFSET(_refErr);
			_ingredient setv(optional,value);

			GETVAL_BOOL(_x, vec2("destroy",_ingredient getv(destroy)));
			FAIL_CHECK_REFSET(_refErr);
			_ingredient setv(destroy,value);

			GETVAL_STR(_x, vec2("condition",null));
			FAIL_CHECK_REFSET;
			if !isNullVar(value) then {
				private _code = [value] call csys_generateInsturctions;
				if isNullVar(_code) exitWith {
					FAIL_CHECK_REFSET(_refErr);
				};
				_ingredient setv(conditionEvent,_code);
			};

			
			GETVAL_STR(_x , vec2("meta_tag",null));
			FAIL_CHECK_REFSET;
			_ingredient setv(metaTag,value);

			//push ingredient
			_ingredientList pushBack _ingredient;

		} foreach _content;
		FAIL_CHECK_EMPTY;
	};



	def(fail_enable) true;
	def(fail_type) null;
	def(fail_count) null;

	def(_parseFailed)
	{
		params ["_fdict","_refResult"];
		if isNullVar(_fdict) exitWith {};
		CRAFT_PARSER_HEAD;

		GETVAL_BOOL(_fdict, vec2("enable",self getv(fail_enable)));
		FAIL_CHECK_REFSET(_refResult);
		self setv(fail_enable,value);
		if (!value) exitWith {};
		
		GETVAL_STR(_fdict, vec2("item",null));
		if (!isImplementClass(value) || {!isTypeNameStringOf(value,"Item")}) exitWith {
			refset(_refErr,"Failed item not found or not inherit of Item class: " + value);
		};
		self setv(fail_type,value);

		GETVAL(_fdict, vec2("count",1), [0 arg hashMapNull]);
		FAIL_CHECK_REFSET(_refResult);
		self setv(fail_count,struct_newp(CraftDynamicCountRange__,value));
	};

	def(opt_collect_distance) 1
	def(opt_craft_duration) {_this} //_this == usr.rta

	def(_parseOptions)
	{
		params ["_req","_refResult"];
		if isNullVar(_req) exitWith {};
		CRAFT_PARSER_HEAD;

		GETVAL_FLOAT(_req, vec2("collect_distance",self getv(opt_collect_distance)));
		FAIL_CHECK_REFSET(_refResult);
		self setv(opt_collect_distance,value);

		GETVAL_STR(_req, vec2("craft_duration",null));
		FAIL_CHECK_REFSET(_refResult);
		if !isNullVar(value) then {
			value = [value,"rta","_this"] call regex_replace;
			value = compile value;
			if !isNullVar(value) then {
				self setv(opt_craft_duration,value);
			};
		};
	}

	def(_parseResult)
	{
		params ["_req","_refResult"];
		CRAFT_PARSER_HEAD;

		GETVAL_STR(_req, vec2("class",null));
		FAIL_CHECK_REFSET(_refResult);
		if (!isImplementClass(value) || {!isTypeNameStringOf(value,"IDestructible")}) exitWith {
			refset(_refErr,"Result object not found or not inherit of IDestructible class: " + value);
		};
		private _class = value;

		GETVAL(_req, vec2("count",1), [0 arg hashMapNull]);
		FAIL_CHECK_REFSET(_refResult);
		private _robj = struct_newp(CraftRecipeResult,_class arg value);
		self setv(result,_robj);

		if (self getv(__canGetNameFromResult)) then {
			self setv(name,getFieldBaseValueWithMethod(_class,"name","getName"));
		};


		GETVAL_FLOAT(_req, vec2("radius",_robj getv(radius)));
		FAIL_CHECK_REFSET(_refResult);
		_robj setv(radius,value);

		GETVAL_ARRAY(_req, vec2("modifiers",_robj getv(modifiers)));
		FAIL_CHECK_REFSET(_refResult);
		private _mods = [];
		{
			private _m = struct_newp(CraftRecipeResultModifier,_x);
			if (_m getv(__raised)) exitWith {
				message = "Modifier error: " + (str _m);
			};
			_mods pushBack _m;
		} foreach value;
		FAIL_CHECK_REFSET(_refResult);
		_robj setv(modifiers,_mods);
	}

endstruct

struct(CraftRecipeDefault) base(ICraftRecipeBase)
	def(c_type) "default";
	def(onRecipeReady)
	{
		callbase(onRecipeReady);
		(csys_map_storage get (self getv(categoryId))) pushBack self;
	}

	def(canSeeRecipe)
	{
		params ["_usr"];
		private _canSee = false; //by default cannot see recipe (low skills)
		call {
			if (self getv(forceVisible)) exitWith {_canSee = true};

			private _skills = self getv(skills);
			if isNullVar(_skills) exitWith {_canSee = true};
			{
				assert(isImplementFuncStr(_usr,"get" + _x));
				if (callFuncReflect(_usr,"get" + _x) >= _y) exitWith {_canSee = true};
			} foreach _skills;
		};

		_canSee 
	}

	def(getRecipeMenuData)
	{
		private _buff = [self getv(craftId)];
		private _buffText = [self getv(name)];
		_buffText pushBack ((self getv(components) apply {_x callv(getComponentTextData)}) joinString " + ");
		if ((self getv(desc)) != "") then {
			_buffText pushBack (self getv(desc));
		};
		_buff pushBack (_buffText joinString endl);
		_buff
	}

endstruct

struct(CraftRecipeBuilding) base(CraftRecipeDefault)
	def(c_type) "building";
endstruct

struct(CraftRecipeSystem) base(ICraftRecipeBase)
	def(c_type) "system";
	def(systemSpecific) "undefined";

	def(onRecipeReady)
	{
		callbase(onRecipeReady);

		{
			_x callp(_ingredientRegister,csys_map_allSystemCrafts arg self);
		} foreach (self getv(components));
	}

endstruct

struct(CraftRecipeInteract) base(ICraftRecipeBase)
	def(c_type) "interact";

	def(onRecipeReady)
	{
		callbase(onRecipeReady);
		{
			_x callp(_ingredientRegister,csys_map_allInteractiveCrafts arg self);
		} foreach (self getv(components));
	}


	def(_parseRequiredComponents_Internal)
	{
		params ["_content","_ingredientList","_refErr"];
		CRAFT_PARSER_HEAD;
	}

endstruct