// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

csys_requestOpenMenu = {
	params ["_objSrc","_usr",["_onlyPreviewMode",false]];
	
	//todo fix logic
	//if !callFunc(_objSrc,canUseAsCraftSpace) exitWith {};
	private _allowedCateg = callFunc(_objSrc,getAllowedCraftCategories);
	if (isNullVar(_allowedCateg) || not_equalTypes(_allowedCateg,[])) exitWith {
		errorformat("csys::requestOpenMenu() - caught unhandled error after calling: %1::getAllowedCraftCategories()",callFunc(_objSrc,getClassName));
	};
	
	if (count _allowedCateg == 0) then {
		_allowedCateg = CRAFT_CONST_CATEGORY_LIST_IDS;
	};
	private _allowedCategReal = [];
	{
		private _recipes = [_x,_usr,_objSrc,_onlyPreviewMode] call csys_getRecipesForUser;
		if (count _recipes > 0) then {
			_allowedCategReal pushBack _x;
		};
	} foreach _allowedCateg;

	private _firstCat = ifcheck(count _allowedCategReal > 0,_allowedCategReal select 0,_allowedCateg select 0);
	
	#ifdef SP_MODE
	if (count _allowedCategReal == 0) exitWith {};
	#endif

	assert_str(array_exists(_allowedCategReal,_firstCat),"First category is not in allowed categories: " + format ["first cat %1; allowed list %2" arg _firstCat arg _allowedCategReal]);

	private _data = [
		getVar(_objSrc,pointer),
		getVar(_usr,pointer),
		_allowedCategReal,
		[_firstCat,_usr,_objSrc,_onlyPreviewMode] call csys_getRecipesForUser
	];
	if (_onlyPreviewMode) then {
		_data pushBack true;
	};
	
	callFuncParams(_usr,sendInfo,"openCraftMenu" arg _data);	
};

//возвращает массив данных: vec2(recipeId,name + needs + optdesc)
csys_getRecipesForUser = {
	params ["_catId","_usr","_src",["_onlyPreview",false]];
	private _crafts = ifcheck(_onlyPreview,csys_map_systems_storage,csys_map_storage) getOrDefault [_catId,[]];
	private _recipes = [];
	{
		
		if (_x callp(canSeeRecipe,_usr arg _src)) then {
			_recipes pushBack (_x callv(getRecipeMenuData));
		};
	} foreach _crafts;
	_recipes
};

//запрос загрузки новой категории
csys_requestLoadCateg = {
	params ["_usrptr","_srcPtr","_cat",["_isPreview",false]];
	
	unrefObject(this,_usrptr,errorformat("csys::tryCraft() - Mob object has no exists virtual object - %1",_usrptr); rpcSendToObject(_usrptr,"onCraftLoadCateg",["PTR_ERR"]));

	private _obj = pointer_get(_srcPtr);
	if !pointer_isValidResult(_obj) exitWith {errorformat("csys::tryCraft() - target reference has no exists in pointers table - %1",_srcptr);false};

	private _list = [_cat,this,_obj,_isPreview] call csys_getRecipesForUser;
	rpcSendToObject(_usrptr,"onCraftLoadCateg",[_cat arg _list]);
	
}; rpcAdd("processLoadCatCraft",csys_requestLoadCateg);

csys_tryCraft = {
	params ["_usrptr","_srcptr","_recipeID"];
	
	unrefObject(this,_usrptr,errorformat("csys::tryCraft() - Mob object has no exists virtual object - %1",_usrptr);false);
	private _obj = pointer_get(_srcptr);
	if !pointer_isValidResult(_obj) exitWith {errorformat("csys::tryCraft() - target reference has no exists in pointers table - %1",_srcptr);false};
	
	if !(_recipeID in csys_map_allCraftRefs) exitWith {
		errorformat("csys::tryCraft() - Cant find recipe id - %1",_recipeID);
		false
	};
	
	[this,null,_recipeID] call csys_processCraftMain;
	
}; rpcAdd("tryCraft",csys_tryCraft);

#ifdef CRAFT_DEBUG_VISUAL_ON_ATTEMPT
csys_internal_editor_list_prepobjects = [];
#endif

_craft_onEndPreview = {
	params ["_usrptr","_isApply","_tfmOpt"];
	unrefObject(this,_usrptr,errorformat("csys::onCraftEndPreview() - Mob object has no exists virtual object - %1",_usrptr);false);
	
	[this,_isApply,_tfmOpt] call csys_onCraftEndPreview;

}; rpcAdd("craft_onEndPreview",_craft_onEndPreview);

csys_onCraftEndPreview = {
	params ['this',"_isApply","_tfmOpt"];

	private _pData = getSelf(___cachedCraftBuildPreview);
	setSelf(___cachedCraftBuildPreview,null);
	private _params = _pData select 0;
	private _postCreate = _pData select 1;
	private _craftCtx = _params select 1;
	if (_isApply) then {
		_craftCtx set ["position",_tfmOpt select 0];
		_craftCtx set ["direction",_tfmOpt select 1];
	};

	_params call _postCreate;
};

#ifdef EDITOR
csys_internal_editor_lastRecipe = null;
csys_internal_editor_lastIngredients = null;
#endif

/* 
	Универсальная функция процесса крафта
	крафт интерактора, стройки или меню. В том числе готовки.
*/
csys_processCraftMain = {
	/*
		(usr,[_item,_targ],null) - for interactor (return bool)
		(usr,null,id) - for default, building (void)
		(null,[objects_sorted],system) - for system (void)
	*/
	params ["_usr","_objectColleciton","_recipeIdOrSystem"];
	FHEADER;

	private _isInteract = isNullVar(_recipeIdOrSystem);
	private _isSystem = isNullVar(_usr);
	private _isDefault = !_isInteract && !_isSystem;

	private _recipe = null;
	private _modContext = null;
	private _craftContext = null;
	private _failContext = null;

	private _leftComponents = null;
	private _position = null;

	private _addModContext = {
		if isNullVar(_modContext) then {
			_modContext = createhashMap;
		};
		_modContext set _this;
	};
	private _addCraftContext = {
		if isNullVar(_craftContext) then {
			_craftContext = createhashMap;
		};
		_craftContext set _this;
	};
	private _addFailContext = {
		if isNullVar(_failContext) then {
			_failContext = createhashMap;
		};
		_failContext set _this;
	};

	if (_isInteract) then {
		_objectColleciton params ["_handItem","_targ"];
		traceformat("csys::processCraftMain() - %1 interacted from %2 to %3",_usr arg _handItem arg _targ)
		private _targClass = callFunc(_targ,getClassName);
		private _listCrafts = csys_map_allInteractiveCrafts get (tolower _targClass);
		if isNullVar(_listCrafts) exitWith {RETURN(false)};

		private _handItmIngr = null;
		private _targIngr = null;
		
		{
			_handItmIngr = _x getv(hand_item) callv(createIngredientTempValidator);
			_targIngr = _x getv(target) callv(createIngredientTempValidator);

			if (_handItmIngr callp(isValidIngredient,_handItem)) then {
				_handItmIngr callp(handleValidIngredient,_handItem);
			};

			if (_targIngr callp(isValidIngredient,_targ)) then {
				_targIngr callp(handleValidIngredient,_targ);
			};

			if (_handItmIngr callv(isReadyIngredient) && {_targIngr callv(isReadyIngredient)}) exitWith {
				_recipe = _x;
			};
		} foreach _listCrafts;

		private _error_message_provider = {
			params ["_ingrType"];
			traceformat("csys::handleInteractor() - error message because hp error on %1",_ingrType);
			private _msg = _ingrType getv(on_hp_error_messages);
			if (count _msg == 0) exitWith {};
			assert(equalTypes(_msg,[]));
			_msg = pick _msg;
			_msg = [_msg,
				createHashMapFromArray[
					["basename", callFuncParams(_ingrType getv(targetItem),getNameFor,_usr)]
					,["target", callFuncParams(_handItmIngr getv(targetItem),getNameFor,_usr)]
					,["hand_item", callFuncParams(_targIngr getv(targetItem),getNameFor,_usr)]
				]
			] call csys_format;
			_msg = [_msg] call csys_formatSelector;
			callFuncParams(_usr,localSay,_msg arg "error");

			RETURN(true);
		};

		if (_handItmIngr getv(hp_error_catched)) then {
			[_handItmIngr] call _error_message_provider;
		};

		if (_targIngr getv(hp_error_catched)) then {
			[_targIngr] call _error_message_provider;
		};

		if any_of([_handItmIngr arg _targIngr] apply {callFunc(_x getv(targetItem),isInSlot)}) exitWith {
			RETURN(false);
		};

		//запоминаем названия предметов для создания
		private _handItemName = callFuncParams(_handItem,getNameFor,_usr);
		private _targName = callFuncParams(_targ,getNameFor,_usr);
		["hand_item_name",_handItemName] call _addCraftContext;
		["target_name",_targName] call _addCraftContext;
		["create_in_hands",
			equals(callFunc(_targ,getSourceLoc),_usr) 
			&& {equals(callFunc(_handItem,getSourceLoc),_usr)}
		] call _addCraftContext;

		_leftComponents = [_handItmIngr,_targIngr];

		_position = callFunc(_targ,getPos);

	};

	if (_isDefault) then {
		//generate server interact
		callFunc(_usr,generateLastInteractOnServer);

		_recipe = csys_map_allCraftRefs get _recipeIdOrSystem;

		_position = callFunc(_usr,getLastInteractEndPos);
		private _objList = ["IDestructible",_position,_recipe getv(opt_collect_distance),true,true] call getGameObjectOnPosition;

		//sort by distance
		_objectColleciton = [_objList,{callFunc(_x,getPos) distance _eps}] call sortBy;
		_leftComponents = array_copy(_recipe getv(components)) apply {_x callv(createIngredientTempValidator)};

		{
			_objIngredient = _x;

			{
				//skips ready
				if (_x callv(isReadyIngredient)) then {continue};

				if (_x callp(isValidIngredient,_objIngredient)) exitWith {
					_x callp(handleValidIngredient,_objIngredient);
				};
			} foreach _leftComponents;
			false
		} count _objectColleciton;

		private _canCraft = all_of(_leftComponents apply {_x callv(canCraftFromIngredient)});
		private _onCannotCraft = {
			private _ingredient = "чего-то...";
			{
				if (!(_x callv(canCraftFromIngredient)) && {
					//опциональные не требуются обязательно
					!(_x getv(optional))
				}
				) exitWith {
					_ingredient = _x callv(getRequiredComponentName);
				};
			} foreach _leftComponents;
			callFuncParams(_usr,localSay,"Не хватает: " + _ingredient arg "error");
			RETURN(0);
		};
		if (!_canCraft) exitWith _onCannotCraft;
	};

	if (_isSystem) then {
		private _sysObj = _recipeIdOrSystem;
		private _possibleRecipes = _sysObj callp(_getRecipes,_objectColleciton);
		
		private _curRecipes = []; //vec2(recipe,components)
		
		{
			private _robj = _x;
			private _leftComponents = array_copy(_robj getv(components)) apply {_x callv(createIngredientTempValidator)};

			{
				private _objIngredient = _x;
				{
					//skips ready
					if (_x callv(isReadyIngredient)) then {continue};

					if (_x callp(isValidIngredient,_objIngredient)) exitWith {
						_x callp(handleValidIngredient,_objIngredient);
					};
				} foreach _leftComponents;
			} foreach _objectColleciton;

			private _canCraft = all_of(_leftComponents apply {_x callv(canCraftFromIngredient)});
			//traceformat("VALID RECIPE %1 : %2",_robj arg _leftComponents apply {_x callv(canCraftFromIngredient)})
			if (_canCraft) then {
				_curRecipes pushBack [_robj,_leftComponents];
			};

		} foreach _possibleRecipes;

		//traceformat("CAPTURED: %1 %2",_curRecipes arg _possibleRecipes)
		if (count _curRecipes > 1) then {
			[
				"Слишком много рецептов соответствуют этому набору ингредиентов."
				+"Соответствующие рецепты: %1"+endl+"Будет выбран первый рецепт.",
				(_curRecipes apply {format["Рецепт %1 в %2",(_x select 0) getv(sourceItem),(_x select 0) getv(sourceFile)]})
					joinString endl
			] call messageBox;
		};
		//assert_str(count _curRecipes <= 1,format vec3("Too many possible recipes (%2): %1",_curRecipes apply {_x select 1},count _curRecipes));
		if (count _curRecipes == 0) exitWith {
			RETURN(false)
		};

		//sort by more ingredients used
		// _curRecipes = [_curRecipes,{
		// 	private _ingrList = _x select 1;
		// 	private _amItmAll = 0;
		// 	{
		// 		modvar(_amItmAll) + (_x getv(count));
		// 	} foreach _ingrList;
		// 	_amItmAll
		// }] call sortBy;

		_recipe = _curRecipes select 0 select 0;
		_leftComponents = _curRecipes select 0 select 1;

		//found cooker
		private _possibleCrafters = createHashMap;//<hashUser,count>
		private _possibleCraftersPtr = createhashMap;//<hashUser,ptr>
		private _pUsr = null;
		private _hashUsr = null;
		{
			{
				_pUsr = callFunc(_x select 0,getLastTouched);
				if isNullReference(_pUsr) then {continue};

				_hashUsr = getVar(_pUsr,pointer);
				if !(_hashUsr in _possibleCrafters) then {
					_possibleCrafters set [_hashUsr,0];
					_possibleCraftersPtr set [_hashUsr,_pUsr];
				};

				_possibleCrafters set [_hashUsr,(_possibleCrafters get _hashUsr) + 1];
			} foreach (_x getv(_foundItems));
		} foreach _leftComponents;

		_possibleCrafters = _possibleCrafters toArray false;
		_possibleCrafters = [_possibleCrafters,{_x select 1}] call sortBy;
		
		if (count _possibleCrafters == 0) exitWith {
			setLastError("Possible crafters is empty");
		};

		//save cooker
		private _crafter = _possibleCraftersPtr get (_possibleCrafters select 0 select 0);
		_sysObj setv(usr,_crafter);
		_usr = _crafter;

		_position = _sysObj callp(getResultBasePosition,_leftComponents);
	};

	if isNullVar(_recipe) exitWith {false};
	
	#ifdef EDITOR
	csys_internal_editor_lastRecipe = _recipe;
	csys_internal_editor_lastIngredients = _leftComponents;
	#endif

	private _resultCount = round (_recipe getv(result) getv(count) callv(getValue));
	["result_count",_resultCount] call _addCraftContext;
	 
	//регистрируем контекст модификаторов
	["is_interact",_isInteract] call _addModContext;
	["user",_usr] call _addModContext;
	["ingredients",_leftComponents] call _addModContext;
	["result_count",_resultCount] call _addModContext;
	private _modCtxPrepared = [];
	// traceformat("Founded recipe %1",_recipe)
	// traceformat("with result %1",_recipe getv(result))
	// traceformat("Recipe mods: %1",_recipe getv(result) getv(modifiers))
	{
		_modCtxPrepared pushBack (_x callp(createModifierContext,_modContext));
	} foreach (_recipe getv(result) getv(modifiers));

	//регистрируем контекст провала
	private _failHandler = null;
	if ((_recipe getv(fail_handler_type)) != "") then {
		private _failHandlerType = _recipe getv(fail_handler_type);
		private _failHandlerParams = _recipe getv(fail_handler_params);
		_failHandler = [_failHandlerType,_failHandlerParams] call struct_alloc;
		_failHandler setv(position,_position);
		_failHandler callp(captureContext,_recipe arg _usr arg _leftComponents);
	};


	//skills check
	private _refSuccess = refcreate(0);
	private _canCraftBySkills = _recipe callp(checkCraftSkills,_usr arg _refSuccess);
	refunpack(_refSuccess); //params: vec2(skillname(str),success_amount(int))
	traceformat("CRAFT SKILL INFO: skill: %1; succam: %2; rz: %3; 3d6: %4",_refSuccess select 0 arg getRollAmount(_refSuccess select 1) arg getRollType(_refSuccess select 1) arg getRollDiceAmount(_refSuccess select 1));

	//register craft context
	["used_skill",_refSuccess select 0] call _addCraftContext;
	["success_amount",getRollAmount(_refSuccess select 1)] call _addCraftContext;
	["roll_result",getRollType(_refSuccess select 1)] call _addCraftContext;
	["amount_3d6",getRollDiceAmount(_refSuccess select 1)] call _addCraftContext;
	
	assert(!isNullVar(_position));
	["position",_position] call _addCraftContext;
	["user",_usr] call _addCraftContext;
	["recipe",_recipe] call _addCraftContext;
	["modifier_context_list",_modCtxPrepared] call _addCraftContext;
	// copy ingredients info structs (copy)
	["components_copy",_leftComponents] call _addCraftContext;

	["can_craft_by_skills",_canCraftBySkills] call _addCraftContext;

	private _durationCheck = _recipe getv(opt_craft_duration);
	assert(equalTypes(_durationCheck,{}));
	assert(!isNullVar(_usr));
	private _InternalCraftSkill = _craftContext get "used_skill";
	if ("_" in _InternalCraftSkill) then {
		_InternalCraftSkill = 1;
	} else {
		_InternalCraftSkill = callFuncReflect(_usr,"get" + _InternalCraftSkill);
		assert(!isNullVar(_InternalCraftSkill));
	};
	assert(equalTypes(_InternalCraftSkill,0));
	private _duration = _usr call _durationCheck;
	
	#ifdef CRAFT_DEBUG_DURATION_CREATING
	_duration = ifcheck(_isSystem,CRAFT_DEBUG_DURATION_CREATING,1) min _duration;
	#endif
	
	["duration",_duration] call _addCraftContext;


	private _ctx = ["_recipe","_leftComponents","_craftContext","_usr","_failHandler","_canCraftBySkills"];
	private _postCrafted = {
		assert(_leftComponents);

		private _canCraft = all_of(_leftComponents apply {_x callv(canCraftFromIngredient)});
		private _onCannotCraft = {
			private _ingredient = "чего-то...";
			{
				if (!(_x callv(canCraftFromIngredient)) && {
					//опциональные не требуются обязательно
					!(_x getv(optional))
				}
				) exitWith {
					_ingredient = _x callv(getRequiredComponentName);
				};
			} foreach _leftComponents;
			callFuncParams(_usr,localSay,"Не хватает: " + _ingredient arg "error");
			RETURN(false);
		};
		if (!_canCraft) exitWith _onCannotCraft;
		
		if (!_canCraftBySkills) exitWith {
			//cannot craft because lowskill
			if isNullVar(_failHandler) exitWith {
				private _message = pick ["Знаний не хватило.","Не умею, не могу.","Не понимаю как делать.","Слооооожно!","Что-то не понятно ничего.","Не могу сделать.","Не знаю как делать."];
				callFuncParams(_usr,localSay,_message arg "error");
			};

			_failHandler callp(onCatched,_recipe arg _craftContext)
		};

		//only after fail handler checks
		{
			_x callv(onComponentUsed);
		} foreach _leftComponents;
		
		private _postPlaced = {
			params ["_recipe","_craftContext"];
			_recipe getv(result) callp(onCrafted,_craftContext);
		};

		private _previewObj = _recipe callv(hasPreviewCraft);
		
		//custom handler
		if (_previewObj) then {

			private _previewModel = _recipe callv(getPreviewModel);
			private _position = _craftContext get "position";
			if isNullVar(_previewModel) exitWith {
				setLastError("Неопределенная модель для рецепта " + (str _recipe));
			};
			setVar(_usr,___cachedCraftBuildPreview,vec2(vec2(_recipe,_craftContext),_postPlaced));
			#ifdef EDITOR
				//задержка из-за предварительного захвата нажатия ЛКМ (фикс мгновенной расстановки)
				callFuncAfterParams(_usr,sendInfo,0.05,"craft_preview" arg [_position arg _previewModel] )
			#else
				callFuncParams(_usr,sendInfo,"craft_preview" arg [_position arg _previewModel] )
			#endif
		} else {
			[_recipe,_craftContext] call _postPlaced;
		};

	};

	if (_isInteract || _isDefault) exitWith {

		if (_duration > 0) then {
			callFuncParams(_usr,doAfter,_postCrafted arg _duration arg _ctx arg INTERACT_PROGRESS_TYPE_FULL);
		} else {
			call _postCrafted;
		};
		RETURN(true)
	};

	if (_isSystem) exitWith {
		_recipeIdOrSystem callp(captureCraft,_recipe arg _craftContext arg _failHandler);

		//after captured all info we can delete objects
		{
			_x callv(onComponentUsed);
		} foreach _leftComponents;

		true
	};

	setLastError("Unknown craft type");
	RETURN(false);
};
