// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include "..\..\host\lang.hpp"

namespace(Craft,craft_)

decl(void(any;any;any[];any[];bool))
craft_openCraftMenuRequest = {
	params ["_src","_usr","_categories","_listFirstCat",["_onlyPreview",false]];
	
	craft_cxtRpcSourcePtr = _src;	
	//[[1],[1]] call craft_open;
	[_categories,_listFirstCat,_onlyPreview] call craft_open;
	
}; rpcAdd("openCraftMenu",craft_openCraftMenuRequest);

decl(void(any;any[]))
craft_onCraftLoadCateg = {
	params ["_categ","_list"];
	
	if (!craft_isMenuOpen) exitWith {};
	
	if equalTypes(_categ,"") exitWith {
		craft_loadCateg_isLoading = false;
		["Ошибка при загрузке категории: " + _categ,"system"] call chatPrint;
	};
	
	craft_loadCateg_isLoading = false;
	[_categ,_list] call craft_onLoadCategory;
	
}; rpcAdd("onCraftLoadCateg",craft_onCraftLoadCateg);

decl(void(vector3;mesh))
craft_craftPreviewProcess = {
	params ["_pos","_model"];
	private _txt = [
		"Режим предпросмотра: ",
		"  ЛКМ для применения позиции, ПКМ для отмены.",
		"  Колесо мыши - вращение (+shift быстрее)",
		"  Колесо мыши + alt - расстояние"
	] joinString sbr;
	["<t size='1.4'>"+_txt+"</t>","system"] call chatPrint;
	[_model,_pos] call craft_startPreview;
}; rpcAdd("craft_preview",craft_craftPreviewProcess);