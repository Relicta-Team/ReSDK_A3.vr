// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include "..\..\host\engine.hpp"
#include "..\..\host\keyboard.hpp"
#include "widgets.hpp"

#include <..\..\host\lang.hpp>

namespace(WidgetSystem.Templates,widget_)


// Создать виджет типа закрывающая дисплей кнопка
decl(widget(display;string;vector4;widget))
createWidget_closeButton = {
	params ["_display",["_text","Закрыть"],"_pos","_parent"];

	_closeButton = [_display,TEXT,_pos,_parent] call createWidget;

	_closeButton setBackgroundColor [0.651,0.161,0.161,0.6];
	[_closeButton,format ["<t align='center'>%1</t>",_text]] call widgetSetText;

	_closeButton ctrlAddEventHandler ["MouseButtonUp",{
		nextFrame({call displayClose});
	}];

	_closeButton ctrlAddEventHandler ["MouseEnter", {(_this select 0) setBackgroundColor [0.651,0.161,0.161,0.8]}];
	_closeButton ctrlAddEventHandler ["MouseExit", {(_this select 0) setBackgroundColor [0.651,0.161,0.161,0.6]}];

	_closeButton
};

// Размер верхней части окна (драг-зоны)
macro_const(widget_height_window_dragger)
#define HEIGHT_WINDOW_DRAGGER 3

// Создать виджет типа окно
decl(widget(display;string;vector4;widget))
createWidget_window = {
	params ["_display","_type","_pos","_parent"];

	private _ctg = [_display,_type,_pos,_parent] call createWidget;
	private _background = [_display,BACKGROUND,[0,0,100,100],_ctg] call createWidget;
	_ctg setvariable ["background",_background];

	//create header
	_pos params ["_tx","_ty","_tw","_th"];

	private _titleGroup = [_display,WIDGETGROUP,[_tx,_ty - HEIGHT_WINDOW_DRAGGER,_tw,HEIGHT_WINDOW_DRAGGER]] call createWidget;
	_ctg setvariable ["tg",_titleGroup];
	private _title = [_display,TEXT,[0,0,100 - 10,100],_titleGroup] call createWidget;
	_title setvariable ["connected",_ctg];

	_titleGroup
};

//указывать ширину не нужно...
decl(widget(display;string;vector4;widget))
createWidget_square = {
	params ["_display","_type","_pos","_parent"];

	private _nsize = transformSizeByAR(_pos select 3);
	_pos set [2,_nsize];

	private _wid = [_display,_type,_pos,_parent] call createWidget;

	_wid setvariable ["isSquare",true];

	_wid
};


// theme creator

// NOT USED
// createCtWidget = {
// 	params ["_name","_params"];
// 	_params call (missionNamespace getVariable ("createWidget_"+_name))
// };

// ========================== api ==========================

// createWidget_backImpl = {
// 	params ["_d","_pos","_ctg"];
// 	[_d,BACKGROUND,_pos,_ctg] call createWidget;
// };

// // Бэкграунд
// createWidget_back = {
// 	params ["_d","_pos","_parent"];
// 	private _w = [_d,_pos,_ctg] call createWidget_backImpl;
// 	_w setBackgroundColor (["back"] call ct_getValue);
// 	_w
// };

// // Бэкграунд
// createWidget_back2 = {
// 	params ["_d","_pos","_parent"];
// 	private _w = [_d,_pos,_ctg] call createWidget_backImpl;
// 	_w setBackgroundColor (["back2"] call ct_getValue);
// 	_w
// };

// // Заголовок
// createWidget_title = {
// 	params ["_d","_pos","_parent",["_text",""]];
// 	private _tit = [_d,TEXT,_pos,_parent] call createWidget;
// 	_tit setBackgroundColor (["title"] call ct_getValue);
// 	[_tit,format["<t color='#%1'>%2</t>",["title_text"] call ct_getValue],_text] call widgetSetText;
// 	_tit
// };

// // Кнопка
// createWidget_button = {
// 	params ["_d","_pos","_ctg","_txt"];
// 	private _bt = [_d,BUTTON,_pos,_ctg] call createWidget;
// 	_bt ctrlSetTextColor (["button_text"] call ct_getValue);
// 	_bt setBackgroundColor (["button"] call ct_getValue);
// 	_bt ctrlAddEventHandler ["MouseEnter",{(_this select 0) setBackgroundColor (["button_active"] call ct_getValue)}];
// 	_bt ctrlAddEventHandler ["MouseExit",{(_this select 0) setBackgroundColor (["button"] call ct_getValue)}];
// 	_bt
// };
