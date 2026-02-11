// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

/*
	extenr vars:
		loot_internal_editor_reloadLooting()
		loot_editor_isLoadedLib()
		loot_internal_editor_previewBuffer = [];
*/

init_function(systools_lootCheck_headerInit)
{
	#include "..\..\host\LootSystem\LootSystem_init.sqf"
}

function(systools_openLootCheck)
{
	if (call isDisplayOpened) exitWith {};
	private _d = [[],[]] call displayOpen;

	systools_internal_lootcheck_widgets = [widgetNull,widgetNull,widgetNull]; //input, error, text

	private _ctgSizeW = 60;
	private _ctgSizeH = 80;
	private _ctg = [_d,WIDGETGROUP,[50-(_ctgSizeW/2),50-(_ctgSizeH/2),_ctgSizeW,_ctgSizeH]] call createWidget;
	private _back = [_d,BACKGROUND,WIDGET_FULLSIZE,_ctg] call createWidget;
	_back setBackgroundColor [0.2,0.2,0.2,0.8];

	private _head = [_d,TEXT,[0,0,50,10],_ctg] call createWidget;
	[_head,format["<t align='left'>Введите название шаблона:</t>"]] call widgetSetText;

	private _input = [_d,INPUT,[50,0,50,10],_ctg] call createWidget;
	systools_internal_lootcheck_widgets set [0,_input];

	private _errtext = [_d,TEXT,[0,10,70,10],_ctg] call createWidget;
	[_errtext,"..."] call widgetSetText;
	systools_internal_lootcheck_widgets set [1,_errtext];

	private _breload = [_d,BUTTON,[70,10,30,10],_ctg] call createWidget;
	_breload ctrlSetText "Перезагрузить шаблоны";
	_breload ctrlAddEventHandler ["MouseButtonUp",{
		call loot_internal_editor_reloadLooting;
		["Библиотека лута перезагружена"] call systools_lootCheck_print;
	}];
	
	private _backInfo = [_d,BACKGROUND,[0,20,100,60],_ctg] call createWidget;
	_backInfo setBackgroundColor [0.5,0.5,0.5,0.8];

	private _ctgInfo = [_d,WIDGETGROUP_H,[0,20,100,60],_ctg] call createWidget;
	private _output = [_d,TEXT,WIDGET_FULLSIZE,_ctgInfo] call createWidget;
	systools_internal_lootcheck_widgets set [2,_output];

	private _bt = [_d,BUTTON,[50-(60/2),80,60,10],_ctg] call createWidget;
	_bt ctrlSetText "ГЕНЕРАЦИЯ";
	_bt setBackgroundColor ("#45C910" call color_HTMLtoRGBA);
	_bt ctrlAddEventHandler ["MouseButtonUp",{
		nextFrame(systools_lootCheck_generate);
	}];

	_btCls = [null,[0,95,100,5],_ctg] call createWidget_closeButton;
	_btCls ctrlsettext "Выход";
	_btCls ctrlAddEventHandler ["MouseButtonUp",{
		systools_internal_lootcheck_widgets = null;
		[true,true] call displayClose;
	}];
}

function(systools_lootCheck_print)
{
	params ["_m"];
	if isNull(systools_internal_lootcheck_widgets) exitWith {};
	private _w = systools_internal_lootcheck_widgets select 1;
	if isNullReference(_w) exitWith {};

	[_w,_m] call widgetSetText;
	[_m] call printLog;
}

function(systools_lootCheck_generate)
{
	if !(call loot_editor_isLoadedLib) then {
		["Generating loot info..."] call systools_lootCheck_print;
		call loot_internal_editor_reloadLooting;
	};

	if !(call loot_editor_isLoadedLib) exitWith {
		["Loot loading failed"] call systools_lootCheck_print;
	};

	private _val = ctrltext (systools_internal_lootcheck_widgets select 0);
	if (_val == "") exitWith {
		["Не указан шаблон"] call systools_lootCheck_print;
	};

	private _obj = [_val] call loot_editor_getTemplateByInput;
	if isNullVar(_obj) exitWith {
		[format["Шаблон не найден: %1",_val]] call systools_lootCheck_print;
	};
	loot_internal_editor_previewBuffer = [];
	_obj callp(processSpawnLoot,nullPtr arg true);

	["Генерация завершена"] call systools_lootCheck_print;

	private _r = loot_internal_editor_previewBuffer joinString sbr;
	private _wid = systools_internal_lootcheck_widgets select 2;
	[_wid,_r] call widgetSetText;

	private _hNew = _wid call widgetGetTextHeight;
	(_wid call widgetGetPosition) params ["_x","_y","_w"];
	[_wid,[_x,_y,_w,_hNew]] call widgetSetPosition;
}