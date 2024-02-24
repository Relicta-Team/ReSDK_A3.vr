// ======================================================
// Copyright (c) 2017-2024 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

/*
	! Внимание !
	При изменениях в этом файле выполните сборку на платформе чтобы удостовериться,
	что этот код работает.
	При проверке серверной части виртуальной машиной эта секция кода будет проигнорирована
*/
#ifndef __VM_VALIDATE
craft_data_count = 0;


#define this _obj
craft_data_categories = createHashMap; //value is array
craft_data_allRecipes = createHashMap;

craft_data_catIndexes = CRAFT_CATEGORY_LIST_ALL apply {CRAFT_CATEGORY_COUNT_STD * _x};

//Получает рецепты с категории
craft_data_getRecipes = {
	params ["_cat","_usr"]; //_usr is system var
	private _list = [];
	
	{
		this = _x;
		if callSelf(hasVisible) then {_list pushBack getSelf(recipeId)};
	} foreach (craft_data_categories get _cat);
	_list
};

{
	this = instantiate(_x);
	
	if not_equals(getSelf(reqItems),[]) then {
		INC(craft_data_count);
		_recipeID =  (craft_data_catIndexes select getSelf(categoryID)) + 1;
		craft_data_catIndexes set [getSelf(categoryID),_recipeID];
		setSelf(recipeId,_recipeID);
		craft_data_allRecipes set [_recipeID,this];
		if !(getSelf(categoryID) in craft_data_categories) then {
			craft_data_categories set [getSelf(categoryID),[]];
		};
		_list = craft_data_categories get getSelf(categoryID);
		_list pushBack this;
		
	} else {
		delete(this);
	};
	
} forEach (["Craft_base",true] call oop_getinhlist);


_convReqToString = {
	params ["_typeList"];
	private _formatList = [];
	{
		_x params ["_type","_count"];
		private _name = getFieldBaseValueWithMethod(_type,"name","getName");
		_formatList pushBack (format["%1%2",_name,ifcheck(_count<=1,""," (x" + str _count + ")")]);
	} foreach _typeList;
	_formatList
};

//[5001,"Бибки",["Тесто","Яичко"],""] call craft_newRecipe;
craft_internal_client_mapRecipes = createHashMap;
{
	//craft_client_allRecipes set [_id,[_id,_name,_listNeed,_desc]];
	private _id = _x;
	private this = _y;
	craft_internal_client_mapRecipes set [getSelf(recipeID),[
		getSelf(recipeID),
		getSelf(name),
		[getSelf(reqItems)] call _convReqToString,
		getSelf(desc)
	]]
} foreach craft_data_allRecipes;

netSetGlobal(craft_client_allRecipes,craft_internal_client_mapRecipes);
#endif