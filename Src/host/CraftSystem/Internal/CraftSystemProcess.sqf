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