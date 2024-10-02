// ======================================================
// Copyright (c) 2017-2024 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

csys_requestOpenMenu = {
	params ["_objSrc","_usr"];
	
	//if !callFunc(_objSrc,canUseAsCraftSpace) exitWith {};
	private _allowedCateg = CRAFT_CONST_CATEGORY_LIST_IDS;
	if (isNullVar(_allowedCateg) || not_equalTypes(_allowedCateg,[]) || count _allowedCateg == 0) exitWith {
		errorformat("csys::requestOpenMenu() - catched unhandled error after calling: %1::getAllowedCraftCategories()",callFunc(_objSrc,getClassName));
	};	
	
	private _data = [
		getVar(_objSrc,pointer),
		getVar(_usr,pointer),
		_allowedCateg,
		[_allowedCateg select 0,_usr] call csys_getRecipesForUser
	];
	
	callFuncParams(_usr,sendInfo,"openCraftMenu" arg _data);	
};

//возвращает массив данных: vec2(recipeId,name + needs + optdesc)
csys_getRecipesForUser = {
	params ["_catId","_usr"];
	private _crafts = csys_map_storage getOrDefault [_catId,[]];
	private _recipes = [];
	{
		
		if (_x callp(canSeeRecipe,_usr)) then {
			_recipes pushBack (_x callv(getRecipeMenuData));
		};
	} foreach _crafts;
	_recipes
};

//запрос загрузки новой категории
csys_requestLoadCateg = {
	params ["_usrptr","_cat"];
	
	unrefObject(this,_usrptr,errorformat("csys::tryCraft() - Mob object has no exists virtual object - %1",_usrptr); rpcSendToObject(_usrptr,"onCraftLoadCateg",["PTR_ERR"]));
	private _list = [_cat,this] call csys_getRecipesForUser;
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
	
	[this,_obj,_recipeID] call csys_tryCraft_internal;
	
}; rpcAdd("tryCraft",csys_tryCraft);

#ifdef CRAFT_DEBUG_VISUAL_ON_ATTEMPT
csys_internal_editor_list_prepobjects = [];
#endif

//попытка крафта через меню
csys_tryCraft_internal = {
	params ["_usr","_srcPtr","_recipeID"];
	private _robj = csys_map_allCraftRefs get _recipeID;
	/*
		Собираем предметы в радиусе последней точки интеракции
	*/

	traceformat("Attempt try craft: %1",_robj);

	if isNullVar(_robj) exitWith {false};
	
	//generate server interact
	callFunc(_usr,generateLastInteractOnServer);

	private _eps = callFunc(_usr,getLastInteractEndPos);
	private _objList = ["IDestructible",_eps,_robj getv(opt_collect_distance),true,true] call getGameObjectOnPosition;
	//sort by distance
	_objList = [_objList,{callFunc(_x,getPos) distance _eps}] call sortBy;

	private _refDict = csys_map_allCraftRefs;
	private _leftComponents = array_copy(_robj getv(components)) apply {_x callv(createIngredientTempValidator)};
	private _classname = null;
	private _objIngredient = null;
	
	#ifdef CRAFT_DEBUG_VISUAL_ON_ATTEMPT
	{deletevehicle _x} foreach csys_internal_editor_list_prepobjects;
	csys_internal_editor_list_prepobjects = [];
	#endif

	traceformat("Collected objects: %1",_objList)

	{
		_objIngredient = _x;

		#ifdef CRAFT_DEBUG_VISUAL_ON_ATTEMPT
		private _itm = "Sign_Arrow_F" createVehicle [0,0,0];
		csys_internal_editor_list_prepobjects pushBack _itm;
		_itm setposatl ((getposatl getVar(_objIngredient,loc)) vectoradd [0,0,0]);
		#endif

		{
			//skips ready
			if (_x callv(isReadyIngredient)) then {continue};

			if (_x callp(isValidIngredient,_objIngredient)) exitWith {
				_x callp(handleValidIngredient,_objIngredient);
			};
		} foreach _leftComponents;
		false
	} count _objList;

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
	};
	if (!_canCraft) exitWith _onCannotCraft;

	private _durationCheck = _robj getv(opt_craft_duration);
	assert(equalTypes(_durationCheck,{}));

	private _myRta = getVar(_usr,rta);
	assert(!isNullVar(_myRta));

	private _duration = _myRta call _durationCheck;

	private _ctx = ["_robj","_leftComponents","_eps","_onCannotCraft"];
	private _postCrafted = {

		//validate
		if !all_of(_leftComponents apply {_x callv(canCraftFromIngredient)}) exitWith _onCannotCraft;

		private _refSuccess = refcreate(0);

		//skills check
		private _canCraftBySkills = _robj callp(checkCraftSkills,this arg _refSuccess);
		refunpack(_refSuccess); //params: vec2(skillname(str),success_amount(int))

		//craft context
		private _craftCtx = createHashMapFromArray [
			["position",_eps],
			["user",this],
			["recipe",_robj],
			["used_skill",_refSuccess select 0],
			["success_amount",getRollAmount(_refSuccess select 1)],
			["roll_result",getRollType(_refSuccess select 1)],
			["amount_3d6",getRollDiceAmount(_refSuccess select 1)],
			["components_copy",_leftComponents]
		];

		if (!_canCraftBySkills) exitWith {
			//cannot craft because lowskill
			if !(self getv(fail_enable)) exitWith {
				private _message = pick ["Знаний не хватает.","Не умею, не могу.","Не понимаю как делать","Что-то не понятно ничего.","Не могу сделать.","Не знаю как делать."];
				callFuncParams(_usr,localSay,_message arg "error");
			};

			_robj callp(onFailProcess,_craftCtx);
		};

		private _previewObj = _robj callv(hasPreviewCraft);

		//removing components
		{
			_x callv(onComponentUsed);
		} foreach _leftComponents;

		//create object
		_robj getv(result) callp(onCrafted,_craftCtx);

	};
	callFuncParams(_usr,doAfter,_postCrafted arg _duration arg _ctx arg INTERACT_PROGRESS_TYPE_FULL);
};