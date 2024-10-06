// ======================================================
// Copyright (c) 2017-2024 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================


#include <..\engine.hpp>
#include <..\struct.hpp>
#include <..\oop.hpp>
#include <..\GURPS\gurps.hpp>
#include "Craft.h"

// because keyword used in struct field
#undef class

#include "Craft_UtilityTypes_struct.sqf"
#include "Craft_Componets_struct.sqf"
#include "Craft_Result_struct.sqf"

struct(ICraftRecipeBase)
	def(name) "";
	def(desc) "";
	def(c_type) "";
	def(categoryId) -1; //айди категории

	def(craftId) -1 //глобальный айди крафта

	def(getType) { self getv(c_type) };

	def(hasPreviewCraft) { (self getv(c_type)) == "building" }

	def(isInteractCraft) { (self getv(c_type))=="interact" }

	def(sourceFile) "";
	def(sourceItem) -1;

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

		self setv(sourceFile,csys_internal_lastLoadedFile);
		self setv(sourceItem,csys_internal_configNumber);
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
	def(forceVisible) false; //видимость рецепта при нехватке навыков
	def(skills) null; //hashmap of skills with values
	def(components) null; //dict of components
	def(result) null; //CraftRecipeResult

	//обработка требований
	def(_parseRequired)
	{
		params ["_req","_refResult"];
		
		CRAFT_PARSER_HEAD;
		
		GETVAL_BOOL(_req, vec2("force_visible",self getv(forceVisible)));
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

		if (count _filledSkills > 0) then {
			self setv(skills,_filledSkills);
		};
		
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
			
			self callp(_parseComponent,_x arg _content arg _ingredientList arg _refErr)

		} foreach _content;
		FAIL_CHECK_EMPTY;
	};

	def(_parseComponent)
	{
		params ["_curObj","_content","_ingredientListOrRef","_refErr"];
		CRAFT_PARSER_HEAD;

		private _cls = _curObj get "class";
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
		
		_ingredient = ifcheck(self callv(isInteractCraft),struct_newp(CraftRecipeInteractorComponent,_cls),struct_newp(CraftRecipeComponent,_cls));

		GETVAL_INT(_curObj, vec2("count",1));
		FAIL_CHECK_REFSET(_refErr);
		if !inRange(value,1,100) exitWith {
			refset(_refErr,"Invalid count: " + (str value));
		};
		_ingredient setv(count,value);

		private _hpval = _curObj get "hp";
		if !isNullVar(_hpval) then {
			private _hpObj = struct_newp(CraftDynamicPrecVal__, _hpval);
			_ingredient setv(hp,_hpObj);
		};

		GETVAL_BOOL(_curObj, vec2("check_type_of",_ingredient getv(checkTypeOf)));
		FAIL_CHECK_REFSET(_refErr);
		_ingredient setv(checkTypeOf,value);

		GETVAL_BOOL(_curObj, vec2("optional",_ingredient getv(optional)));
		FAIL_CHECK_REFSET(_refErr);
		_ingredient setv(optional,value);

		GETVAL_BOOL(_curObj, vec2("destroy",_ingredient getv(destroy)));
		FAIL_CHECK_REFSET(_refErr);
		_ingredient setv(destroy,value);

		GETVAL_STR(_curObj, vec2("condition",null));
		FAIL_CHECK_REFSET;
		if !isNullVar(value) then {
			private _code = [value] call csys_generateInsturctions;
			if isNullVar(_code) exitWith {
				FAIL_CHECK_REFSET(_refErr);
			};
			_ingredient setv(conditionEvent,_code);
		};

		
		GETVAL_STR(_curObj , vec2("meta_tag",null));
		FAIL_CHECK_REFSET;
		_ingredient setv(metaTag,value);

		if (self callv(isInteractCraft)) exitWith {
			refset(_ingredientListOrRef,_ingredient);
		};

		//push ingredient
		_ingredientList pushBack _ingredient;
	}


	def(fail_enable) false;
	def(fail_type) null;
	def(fail_count) null; //CraftDynamicCountRange__

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

	def(opt_collect_distance) 0.8
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

	//валидация по навыкам
	def(checkCraftSkills)
	{
		params ["_usr","_successAmountRef"];
		private _skills = self getv(skills);
		private _result = false;
		private _maxSuccessAmount = -1000;
		call {
			if isNullVar(_skills) exitWith {_result = true};
			{
				private _requiredSkillName = _x;
				private _requiredSkillValue = _y;

				private _rollValidate = callFuncParams(_usr,checkSkill,_x arg 0);
				if DICE_ISSUCCESS(getRollType(_rollValidate)) then {
					private _successAmount = getRollAmount(_rollValidate);
					traceformat("Skill check success: %1 -> %2",_x arg _rollValidate)
					
					//используем максимально сильный успех чтобы выудить максимальный бонус
					if (_successAmount > _maxSuccessAmount) then {
						refset(_successAmountRef,vec2(_requiredSkillName,_rollValidate));
					};
					_result = true;
				};
			} foreach _skills;
		};
		if equals(refget(_successAmountRef),0) then {
			refset(_successAmountRef,vec2("craft",customRollResult(-15,DICE_CRITFAIL,3)));
		};

		_result
	}

	//TODO сделать разные варианты провала (урон, поломка, уменьшение состояния)
	def(onFailProcess)
	{
		params ["_ctx"];
		private _ccpy = _ctx get "components_copy";
		private _pos = _ctx get "position";

		private _maxDistanceRange = 0.05;
		private _allHP = 0;
		private _ctrItms = 0;

		//delete all ingredients
		{
			//exclude optionals
			if (_x getv(optional)) then {continue};

			{
				_x params ["_itm","_real"];

				if ((getVar(_itm,getPos) distance _pos) > _maxDistanceRange) then {
					_maxDistanceRange = getVar(_itm,getPos) distance _pos;
				};

				if (getVar(_itm,hp) > 0) then {
					modvar(_allHP) + getVar(_itm,hp);
					INC(_ctrItms);
				};

				[_itm] call deleteGameObject;
			} foreach (_x getv(_foundItems));
		} foreach _ccpy;
		
		//creating fail items
		private _type = self getv(fail_type);
		assert(_type);
		private _createCount = self getv(fail_count) callv(getValue);

		private _perDebrisHP = floor(_allHP / _ctrItms);

		for "_i" from 1 to _createCount do {
			private _realPos = [_pos,_maxDistanceRange] call randomRadius;
			private _newObj = [_type,_realPos] call createGameObjectInWorld;
			setVar(_newObj,hp,_perDebrisHP + randInt(-4,2));
			setVar(_newObj,ht,randInt(1,4));
		};

		private _m = format["пытается сделать %1%2",self getv(name),
			pick[
				", но всё запарывает.",
				", но ничего не получается.",
				" и всё портит.",
				" и проваливает попытку."
			]
		];
		callFuncParams(_ctx get "user",meSay,_m);
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

	def(getPreviewModel)
	{
		private _output = null;
		private _r = self getv(result);
		call {
			if isNullVar(_r) exitWith {};
			_output = _r callv(getModelPath);
		};
		_output
	}

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

	def(str)
	{
		format["%1:%2[%3]=(%4)",
			self getv(c_type),
			self getv(craftId),
			self getv(name),
			[([self getv(hand_item),self getv(target)] joinString " => "),"""",""] call regex_replace
		]
	}

	def(onRecipeReady)
	{
		callbase(onRecipeReady);
		(self getv(target)) callp(_ingredientRegister,csys_map_allInteractiveCrafts arg self);
	}

	def_null(hand_item) //CraftRecipeComponent
	def_null(target) //CraftRecipeComponent

	def(_parseRequiredComponents)
	{
		params ["_cdict","_refErr"];
		CRAFT_PARSER_HEAD;

		GETVAL_DICT(_cdict, vec2("components",null));
		FAIL_CHECK_REFSET(_refErr);
		if (isNullVar(value) || {count value == 0}) exitWith {
			refset(_refErr,"Components must be defined");
		};

		self callp(_parseRequiredComponents_Internal,value arg _refErr);
	};

	def(_parseRequiredComponents_Internal)
	{
		params ["_content","_refErr"];
		CRAFT_PARSER_HEAD;
		traceformat("COMPONENTS CHECK %1",_content)
		
		//parse hand item
		GETVAL_DICT(_content, vec2("hand_item",null));
		FAIL_CHECK_REFSET(_refErr);

		private _refResult = refcreate(null);
		self callp(_parseComponent,value arg _content arg _refResult arg _refErr);
		if isNull(refget(_refResult)) exitWith {
			refset(_refErr,"hand_item property not found");
		};
		self setv(hand_item,refget(_refResult));
		self getv(hand_item) setv(componentCategory,"hand_item");

		//parse target item
		GETVAL_DICT(_content, vec2("target",null));
		FAIL_CHECK_REFSET(_refErr);

		_refResult = refcreate(null);
		self callp(_parseComponent,value arg _content arg _refResult arg _refErr);
		if isNull(refget(_refResult)) exitWith {
			refset(_refErr,"target property not found");
		};
		self setv(target,refget(_refResult));
		self getv(target) setv(componentCategory,"target");
		
		FAIL_CHECK_EMPTY;
	}

endstruct