// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================



function(golib_main_init)
{
	golib_vis_catData = [
		["Объекты",golib_vis_loadObjList],
		["Шаблоны",golib_vis_loadTemplatesList]
	];
	
	//call golib_om_generatelAssoc;
	if (isNIL{core_model2cfg}) then {
		call compile preprocessFileLineNumbers "src\M2C.sqf";
	};
	
	call golib_vis_onCreateExpand;
}