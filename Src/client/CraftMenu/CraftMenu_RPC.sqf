// ======================================================
// Copyright (c) 2017-2025 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================


_openCraftMenu = {
	params ["_src","_usr","_categories","_listFirstCat",["_onlyPreview",false]];
	
	craft_cxtRpcSourcePtr = _src;	
	//[[1],[1]] call craft_open;
	[_categories,_listFirstCat,_onlyPreview] call craft_open;
	
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


_craft_preview = {
	params ["_pos","_model"];
	private _txt = [
		"Режим предпросмотра: ",
		"  ЛКМ для применения позиции, ПКМ для отмены.",
		"  Колесо мыши - вращение (+shift быстрее)",
		"  Колесо мыши + alt - расстояние"
	] joinString sbr;
	["<t size='1.4'>"+_txt+"</t>","system"] call chatPrint;
	[_model,_pos] call craft_startPreview;
}; rpcAdd("craft_preview",_craft_preview);