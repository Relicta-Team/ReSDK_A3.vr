// ======================================================
// Copyright (c) 2017-2023 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================


#define INIT_USER_DATA

craft_data_count = 0;

#ifndef EDITOR
#undef INIT_USER_DATA
#endif

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


#ifdef INIT_USER_DATA
	
	craft_editor_userdata_header = "#include <..\engine.hpp>" + endl +
	"#include <..\oop.hpp>" + endl +
	"#include <..\text.hpp>" + endl +
	"#include <..\CraftSystem\Craft.hpp>" + endl+endl+"// GENERATED_FILE: Craft System"+ endl;
	
	craft_editor_userdata = 
	" craft_recipes = createHashMap; craft_client_allRecipes = createHashMap;" + endl + "craft_newRecipe = " + str 
	{
		params ["_id",["_name","Что-то..."],"_listNeed","_desc"];
		craft_client_allRecipes set [_id,[_id,_name,_listNeed,_desc]];
	} + ";";
	
#endif

{
	_obj = instantiate(_x);
	
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
		
#ifdef INIT_USER_DATA
		
		_name = "";
		if (getSelf(name) != "") then {
			_name = str getSelf(name);
		} else {
			if (getSelf(resultItem) == "") exitWith {
				errorformat("CRITICAL EXCEPTION AT CRAFT-INIT_DATA: %1",getSelf(resultItem));
				appExit(APPEXIT_REASON_COMPILATIOEXCEPTION)
			};
			_name = typeGetDefaultFieldValueSerialized(typeGetFromString(getSelf(resultItem)),name);
		};
		
		_req = "";
		_listreq = [];
		{
			_x params ["_name","_count"];
			_itm = instantiate(_name);
			_listreq pushBack str format["%1%2",callFunc(_itm,getName),if (_count > 1) then {format[" (x%1)",_count]} else {""}];
		} forEach getSelf(reqItems);
		
		craft_editor_userdata = craft_editor_userdata + endl +
		format["[%1,%2,[%3],%4] call craft_newRecipe;",getSelf(recipeID),_name,(_listreq joinString ","),str getSelf(desc)]
		
		
#endif
		
	} else {
		delete(_obj);
	};
	
} forEach (["Craft_base_crft",true] call oop_getinhlist);

#ifdef INIT_USER_DATA
	call compile craft_editor_userdata;
#endif

