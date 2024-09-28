// ======================================================
// Copyright (c) 2017-2024 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

csys_requestOpenMenu = {
	params ["_objSrc","_usr"];
	
	if !callFunc(_objSrc,canUseAsCraftSpace) exitWith {};
	private _allowedCateg = callFunc(_objSrc,getAllowedCraftCategories);
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
	rpcSendToObject(_usrptr,"onCraftLoadCateg",[_cat,_list]);
	
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

//попытка крафта через меню
csys_tryCraft_internal = {
	params ["_usr","_srcPtr","_recipeID"];
	private _robj = csys_map_allCraftRefs get _recipeID;
	/*
		Собираем предметы в радиусе последней точки интеракции
	*/
	private _eps = callFunc(_usr,getLastInteractEndPos);
	private _objList = ["IDestructible",_eps,_robj getv(collect_distance),true,true] call getGameObjectOnPosition;
	private _refDict = csys_map_allCraftRefs;
	private _leftComponents = array_copy(_robj getv(components));
	private _classname = null;
	private _objIngredient = null;
	private _preparedList = [];
	{
		_objIngredient = _x;
		{
			if (_x callp(isValidIngredient,_objIngredient)) exitWith {

			};
		} foreach _leftComponents;
		false
	} count _objList;
	
	private _previewObj = _robj callv(hasPreviewCraft);
};