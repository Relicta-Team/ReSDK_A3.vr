// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include "..\..\host\engine.hpp"
#include "..\..\host\struct.hpp"
#include <..\..\host\text.hpp>
#include "..\WidgetSystem\widgets.hpp"
#include <..\ClientRpc\clientRpc.hpp>
#include <..\..\host\CraftSystem\Craft.hpp>
#include <..\..\host\keyboard.hpp>
#include "CraftMenu_RPC.sqf"
#include "Craft_preview.sqf"

namespace(Craft,craft_)

macro_const(craft_wind_size_x)
#define CRAFT_WIND_SIZE_X 60
macro_const(craft_wind_size_y)
#define CRAFT_WIND_SIZE_Y 80

macro_const(craft_size_category_button)
#define SIZE_CATEGORY_BUTTON 10

macro_const(craft_size_recipe_text)
#define SIZE_RECIPE_TEXT 8

macro_func(craft_getRecipesWidget,widget())
#define getRecipesWidget() (craft_widgets select 0)
macro_func(craft_setRecipesWidget,void(widget))
#define setRecipesWidget(_refer) (craft_widgets set [0,_refer])

macro_func(craft_getRecipeInfoWidget,widget())
#define getRecipeInfoWidget() (craft_widgets select 1)
macro_func(craft_setRecipeInfoWidget,void(widget))
#define setRecipeInfoWidget(_refer) (craft_widgets set [1,_refer])

macro_func(craft_getCraftButton,widget())
#define getCraftButton() (craft_widgets select 2)
macro_func(craft_setCraftButton,void(widget))
#define setCraftButton(_refer) (craft_widgets set [2,_refer])

decl(string)
craft_cxtRpcSourcePtr = "";

decl(bool)
craft_isMenuOpen = false;

decl(widget[])
craft_widgets = [widgetNull,widgetNull,widgetNull];
decl(bool)
craft_isActiveCraftButton = false;
decl(map)
craft_attributes = createHashMap;
decl(int)
craft_lastPressedRecipeID = -1;
decl(bool)
craft_loadCateg_isLoading = false;
decl(float)
craft_loadCateg_lastLoadingTime = 0;

//режим предпросмотра рецептов (без кнопки крафта)
decl(bool)
craft_isPreviewOnlyMode = false;

decl(void(string;any[];bool))
craft_open = {
	__nextframedata_ = _this;
	params ["_visibleCat","_listRecipes",["_onlyPreview",false]];
	if (count _visibleCat == 0) exitWith {
		error("craft::open() - visible categories list empty");
	};	
	
	// taked from lobbyOpen() function
	if (isInventoryOpen) then {
		if (inventory_isOpenContainer) then {
			call inventory_closeContainer;
		};
		call inventory_resetPositionHandWidgets;call closeInventory_handle;
	};
	if (interact_isOpenMousemode) then {call interact_closeMouseMode_handle};
	if (isDisplayOpen) exitWith {
		nextFrameParams(craft_open,__nextframedata_);
	};
	__nextframedata_ = null;
	
	private _d = call displayOpen;
	
	craft_isMenuOpen = true;
	craft_isActiveCraftButton = true;
	craft_lastPressedRecipeID = -1;
	craft_loadCateg_isLoading = false;
	craft_loadCateg_lastLoadingTime = 0;

	craft_isPreviewOnlyMode = _onlyPreview;
	
	_ctg = [_d,WIDGETGROUP_H,[50 - CRAFT_WIND_SIZE_X/2,50-CRAFT_WIND_SIZE_Y/2,CRAFT_WIND_SIZE_X,CRAFT_WIND_SIZE_Y]] call createWidget;
	_back = [_d,BACKGROUND,[0,0,100,100],_ctg] call createWidget;
	_back setBackgroundColor [0,0,0,0.7];
	
	_closeButton = [_d,nil,[0,95,100,5],_ctg] call createWidget_closeButton;
	
	_closeButton ctrlAddEventHandler ["MouseButtonUp",craft_onClose];
	
	//creating categories
	_ctgCatList = [_d,WIDGETGROUP_H,[0,0,23,95],_ctg] call createWidget;
	
	_countCat = count _visibleCat;
	
	if (_countCat > 1) then {
		for "_i" from 0 to _countCat - 1 do {
			_x = _visibleCat select _i;
			_t = [_d,BUTTON,[0,SIZE_CATEGORY_BUTTON * _i,100,SIZE_CATEGORY_BUTTON],_ctgCatList] call createWidget;
			_t ctrlSetText CRAFT_CATEGORY_TO_NAME(_x);
			_t ctrlAddEventHandler ["MouseButtonUp",{
				params ["_ct","_bt"];
				if (_bt == MOUSE_LEFT) then {
					[_ct getVariable "cat"] call craft_onLoadCategory;
				};	
			}];
			_t setVariable ["cat",_x];	
		};
	};


/*	//tests
	for "_i" from 0 to 100 do {
		_t = [_d,BUTTON,[0,SIZE_CATEGORY_BUTTON * _i,100,SIZE_CATEGORY_BUTTON],_ctgCatList] call createWidget;
		_t ctrlSetText str (_i + randInt(0,1000));
	};*/	
	
	//creating itemlist
	_itemlist = [_d,WIDGETGROUP_H,[if(_countCat==1)then{0}else{25},0,40,95],_ctg] call createWidget;
	setRecipesWidget(_itemlist);
	_itemlist setVariable ["recipeWidgets",[]];
	_itemList setVariable ["sourceDisplay",_d];
	
	//creating text info filed
	_leftsize = 25 + 40;
	_info = [_d,TEXT,[_leftsize,0,100 - _leftsize,70],_ctg] call createWidget;
	_info setBackgroundColor [0.01,0.25,0.17,0.4];
	setRecipeInfoWidget(_info);
	
	//creating craft button
	if (!_onlyPreview) then {
		_btsize = 100 - _leftsize;
		_bt = [_d,BUTTONMENU,[_leftsize + 5,75,_btsize - 10,15],_ctg] call createWidget;
		_bt ctrlSetText "Создать";
		setCraftButton(_bt);
		[false] call craft_setActiveCraftButton;
		_bt ctrlAddEventHandler ["MouseButtonUp",{
			params ["_ct","_bt"];
			if (_bt == MOUSE_LEFT) then {
				call craft_onPressCraft;
				nextFrame(craft_close);
			};
		}];
	};
	
	// load first category
	[_visibleCat select 0,_listRecipes] call craft_onLoadCategory;
	
	//tests load cat
/*	for "_i" from 0 to 1000 do {
		_t = [_d,TEXT,[0,SIZE_RECIPE_TEXT * _i,100,SIZE_RECIPE_TEXT],_itemlist] call createWidget;
		[_t,format["<t color='#f73467'>Сборка предмета такого-то %1</t>",randInt(0,1000)]] call widgetSetText;
	};	*/
};

decl(void(string;any[]))
craft_onLoadCategory = {
	params ["_cat","_listRecipes"]; //_listRecipes vec2(recipeId,name +\n+ needs +\n+ optdesc)
	
	if isNullVar(_listRecipes) exitWith {
		if (craft_loadCateg_isLoading) exitWith {
			["Загрузка. Подождите...","system"] call chatPrint;
		};
		
		craft_loadCateg_isLoading = true;
		private _data = [player,craft_cxtRpcSourcePtr,_cat];
		if (craft_isPreviewOnlyMode) then {
			_data pushBack true;
		};
		rpcSendToServer("processLoadCatCraft",_data);
	};	
	
	_list = getRecipesWidget();
	_d = _list getVariable "sourceDisplay";
	_listWidgets = _list getVariable "recipeWidgets";
	{
		[_x] call deleteWidget;
	} foreach _listWidgets;
	_listWidgets resize 0;
	_idx = 0;
	
	_dat = [_cat,_list,_d,_listWidgets];
	
	//for test
	// #ifdef DEBUG
	// if (count _listRecipes > 0) then {
	// 	_listRecipes = array_copy(_listRecipes);
	// 	for "_i" from 1 to 500 do {
	// 		__first = array_copy(_listRecipes select 0);
	// 		_its = (__first select 1) splitString endl;
	// 		_its set [0,(_its select 0) + " " + (str _i)];
	// 		__first set [1, _its joinString endl];
	// 		_listRecipes pushBack __first;
	// 	};
	// };
	// #endif

	{
		_x params ["_id","_recipeInfo"];
		(_recipeInfo splitString endl) params ["_name","_needs",["_optDesc",""]];

		_t = [_d,TEXT,[0,SIZE_RECIPE_TEXT * _idx,100,SIZE_RECIPE_TEXT],_list] call createWidget;
		INC(_idx);
		_listWidgets pushBack _t;
		
		_recipe = craft_client_allRecipes get _x;
		
		[_t,format["<t align='center'>%1</t>",_name]] call widgetSetText;
		_t ctrlSetBackgroundColor [0.2,0.2,0.2,0.4];
		
		_t ctrlAddEventHandler ["MouseButtonUp",{
			params ["_ct","_bt"];
			if (_bt == MOUSE_LEFT) then {
				[_ct] call craft_onSelectRecipe;
			};	
		}];
		_t setVariable ["systemID",_id];
		_t setVariable ["name",_name];
		_t setVariable ["needs",_needs];
		_t setVariable ["optDesc",_optDesc];
		_t setVariable ["index",_foreachindex];
		
		
		
	} foreach _listRecipes;
	call craft_clearRecipeInfo;
};	
decl(void(widget))
craft_onSelectRecipe = {
	params ["_wid"];
	private _id = _wid getVariable "systemID";
	private _name = _wid getVariable "name";
	private _needs = _wid getVariable "needs";
	private _optDesc = _wid getVariable "optDesc";

	craft_lastPressedRecipeID = _id;
	
	_recipe = craft_client_allRecipes get _systemId;
	
	_txt = getRecipeInfoWidget();
	
	[_txt,format["%1:" +
	sbr +
	sbr +
	"%2" + 
	sbr +
	"%3",_name,_needs,_optDesc]] call widgetSetText;
	
	[true] call craft_setActiveCraftButton;
};	

decl(void())
craft_clearRecipeInfo = {
	craft_lastPressedRecipeID = -1;
	_txt = getRecipeInfoWidget();
	[_txt,format["Выберите рецепт"]] call widgetSetText;
	[false] call craft_setActiveCraftButton;
};	

decl(void(bool))
craft_setActiveCraftButton = {
	params ["_mode"];
	if (_mode == craft_isActiveCraftButton) exitWith {};
	craft_isActiveCraftButton = _mode;
	private _bt = getCraftButton();
	if (_mode) then {
		_bt setFade 0;
		_bt ctrlEnable true;
		_bt commit 0.1;
	} else {
		_bt setFade 0.7;
		_bt ctrlEnable false;
		_bt commit 0.1;
	};	
};

decl(void())
craft_onPressCraft = {
	if (!craft_isActiveCraftButton || craft_lastPressedRecipeID == -1 || craft_cxtRpcSourcePtr == "") exitWith {
		errorformat("craft::onPressCraft() - condition error: <%1:%2:%3>",!craft_isActiveCraftButton arg craft_lastPressedRecipeID == -1 arg craft_cxtRpcSourcePtr == "");
	};
	
	rpcSendToServer("tryCraft",vec3(player,craft_cxtRpcSourcePtr,craft_lastPressedRecipeID));
};

decl(void())
craft_onClose = {
	craft_isMenuOpen = false;
};

decl(void())
craft_close = {
	call craft_onClose;
	call displayClose;
};