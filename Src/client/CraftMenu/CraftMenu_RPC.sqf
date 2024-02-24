// ======================================================
// Copyright (c) 2017-2024 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================


_openCraftMenu = {
	params ["_src","_usr","_categories","_listFirstCat"];
	
	craft_cxtRpcSourcePtr = _src;	
	//[[1],[1]] call craft_open;
	[_categories,_listFirstCat] call craft_open;
	
}; rpcAdd("openCraftMenu",_openCraftMenu);


_onCraftLoadCateg = {
	params ["_categ","_list"];
	
	if (!isCraftOpen) exitWith {};
	
	if equalTypes(_categ,"") exitWith {
		craft_loadCateg_isLoading = false;
		["Ошибка при загрузке категории: " + _categ,"system"] call chatPrint;
	};
	
	craft_loadCateg_isLoading = false;
	[_categ,_list] call craft_onLoadCategory;
	
}; rpcAdd("onCraftLoadCateg",_onCraftLoadCateg);