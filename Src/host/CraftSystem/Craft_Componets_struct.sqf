// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

struct(CraftRecipeComponent)
	def(class) null;
	def(isMultiSelector) false;
	def(count) 1;
	def(name) "";
	def(hp) null; //required helath of ingredient
	def(checkTypeOf) true;
	def(optional) false;
	def(destroy) true;
	def(conditionEvent) {true};
	def(metaTag) "";

	//for craft processor
	def(_getLeftCount) {
		private _contains = (count(self getv(_foundItems)));
		private _needs = self getv(count);

		(_needs - _contains) max 0
	}
	def(_foundItems) null; //list of vec2(gameobject,loc)
	def(_isReadyIngredient) false;

	//метод получения объектов из ингредиент-типа
	def(getObjects)
	{
		(self getv(_foundItems)) apply {_x select 0};
	}

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

	def(getRequiredComponentName)
	{
		private _optName = self getv(name);

		if (self getv(isMultiSelector)) then {
			if not_equals(_optName,"") exitWith {_optName};

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
			if not_equals(_optName,"") exitWith {_optName};

			private _itmsTxt = getFieldBaseValueWithMethod(self getv(class),"name","getName");
			_itmsTxt
		}
	}

	def(getComponentTextData)
	{
		private _textData = self callv(getRequiredComponentName);

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

	//creating temp object for validation
	def(createIngredientTempValidator)
	{
		private _cpy = struct_copy(self);
		_cpy setv(_foundItems,[]);
		assert(_cpy getv(class));
		_cpy
	}

	def(__validateClass)
	{
		params ["_ingredient"];
		private _checkTypeOf = self getv(checkTypeOf);
		private _hasClass = false;
		if (self getv(isMultiSelector)) then {
			{
				if (_checkTypeOf) then {
					_hasClass = isTypeStringOf(_ingredient,_x);
				} else {
					_hasClass = callFunc(_ingredient,getClassName) == _x;
				};
				if (_hasClass) exitWith {};
			} foreach (self getv(class));
		} else {
			_hasClass = ifcheck(_checkTypeOf,isTypeStringOf(_ingredient,self getv(class)),callFunc(_ingredient,getClassName) == (self getv(class)));
		};

		_hasClass
	}

	def(__validateHP)
	{
		params ["_ingredient"];
		private _validHP = true;
		if !isNull(self getv(hp)) then {
			_validHP = false;
			private _hpObj = self getv(hp);
			private _maxHp = getVar(_ingredient,hpMax);
			private _curHp = getVar(_ingredient,hp);
			_validHP = _hpObj callp(validate,_maxHp arg _curHp);
		};
		_validHP
	}

	def(isValidIngredient)
	{
		params ["_ingredient"];
		private _valid = false;
		call {
			private _hasClass = self callp(__validateClass,_ingredient);
			if (!_hasClass) exitWith {};//no class found

			//condition lambda
			private _condCheck = [_ingredient] call (self getv(conditionEvent));
			if (!_condCheck) exitWith {};//condition failed

			//validate hp
			private _validHP = self callp(__validateHP,_ingredient);
			if (!_validHP) exitWith {};//hp check failed

			_valid = true;
		};
		
		_valid
	}

	//called on found valid ingredient
	def(handleValidIngredient)
	{
		params ["_ingredient"];
		private _fList = self getv(_foundItems);
		private _ingrLoc = if callFunc(_ingredient,isInWorld) then {getVar(_ingredient,loc)} else {_ingredient};
		_fList pushBack [_ingredient,_ingrLoc];

		if ((self callv(_getLeftCount)) == 0) then {
			self setv(_isReadyIngredient,true);
		};
	}

	def(isReadyIngredient)
	{
		self getv(_isReadyIngredient);
	}

	//валидация подготовленных ингредиентов. одни должны существовать и не менять меш (что происходит при перемещении)
	def(canCraftFromIngredient)
	{
		(self callv(isReadyIngredient)
		|| (self getv(optional))) && {
			all_of(self getv(_foundItems) apply {!isNullReference(_x select 0) && {!isNullReference(_x select 1)}})
		}
	}

	//вызывается для ингредиентов при успешном карфте
	def(onComponentUsed)
	{
		if (self getv(destroy)) then {
			{
				_x params ["_itm","_real"];
				[_itm] call deleteGameObject;
			} foreach (self getv(_foundItems));
		};
	}

endstruct

struct(CraftRecipeInteractorComponent) base(CraftRecipeComponent)
	def(destroy) null //by default components not destroyed

	def(componentCategory) ""//target|hand_item

	def(targetItem) nullPtr;

	def(getObjects) {[self getv(targetItem)]}

	def(_ingredientRegister)
	{
		params ["_storageRef","_recipeRef"];
		
		if ((self getv(componentCategory)) == "target") then {
			callbase(_ingredientRegister);
			if isNull(self getv(destroy)) then {
				self setv(destroy,true);
			};
		};
		if ((self getv(componentCategory)) == "hand_item") then {
			if isNull(self getv(destroy)) then {
				self setv(destroy,false);
			};
		};
	}

	//called on found valid ingredient
	def(handleValidIngredient)
	{
		params ["_ingredient"];
		self setv(targetItem,_ingredient);

		self setv(_isReadyIngredient,true);		
	}

	def(on_hp_error_messages) []
	def(hp_error_catched) false

	def(__validateHP)
	{
		params ["_ingredient"];
		private _validHP = true;
		if !isNull(self getv(hp)) then {
			_validHP = false;
			private _hpObj = self getv(hp);
			private _maxHp = getVar(_ingredient,hpMax);
			private _curHp = getVar(_ingredient,hp);
			
			_validHP = _hpObj callp(validate,_maxHp arg _curHp);
			if (!_validHP) then {
				self setv(hp_error_catched,true);
				_validHP = true; //override because need print hp error
			};
		};
		_validHP
	}

	def(isValidIngredient)
	{
		params ["_ingredient"];
		private _valid = false;
		call {
			private _hasClass = self callp(__validateClass,_ingredient);
			if (!_hasClass) exitWith {};//no class found

			//condition lambda
			private _condCheck = [_ingredient] call (self getv(conditionEvent));
			if (!_condCheck) exitWith {};//condition failed

			//validate hp
			private _validHP = self callp(__validateHP,_ingredient);
			if (!_validHP) exitWith {};//hp check failed

			_valid = true;
		};
		
		_valid
	}

	def(onComponentUsed)
	{
		if !isNull(self getv(destroy)) then {
			if (self getv(destroy)) then {
				[self getv(targetItem)] call deleteGameObject;
			
			};
		};
	}

endstruct