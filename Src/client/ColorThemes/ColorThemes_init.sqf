// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\host\engine.hpp>
#include <..\WidgetSystem\widgets.hpp>

namespace(ColorThemes,ct_)

macro_const(ct_default_color)
#define defVec4 vec4(1,1,1,1)
macro_const(ct_default_colorHtml)
#define defHTML "ffffff"

decl(map)
ct_internal_currentRegTheme = createHashMap;

decl(map)
ct_map_colors = createHashMapFromArray [
	//common widgets
	["back",defVec4], //Задний фон
	["back2",defVec4], //Дополнительный бэкграунд
	["title",defVec4], //заголовок
	["title_text",defHTML], //цвет текста
	["button",defVec4], //Кнопка
	["button_text",defVec4], //цвет текста кнопки
	["button_active",defVec4], //При наведении на кнопку

	//chat
	["chat_back",defVec4], //Задник чата

	//Inventory constants
	["inv_slot_back",defVec4], //Бэк слота
	["inv_slot_act",defVec4], //Подсветка активной руки
	["inv_self_back",defVec4], //бэк селф иконки
	["inv_self_text",defHTML], //текст селф иконки
	//container
	["cont_back",defVec4], //бэк контейнера
	["cont_title",defVec4], //заголовок контейнера
	["cont_title_text",defHTML], //цвет заголовочного текста
	["cont_slot_back",defVec4], //цвет слота контейнера
	["cont_slot_backempt",defVec4], //пустой слот контейнера
	//verbs
	["verb_back",defVec4], //бэк меню
	["verb_title",defVec4], //бэк заголовка
	["verb_title_text",defHTML], //цвет текста заголовка
	["verb_button",defVec4], //цвет кнопки
	//stamina
	["sta_back",defVec4], //бэк стамины
	["sta_strip",defVec4], //полоска стамины
	["sta_back_low",defVec4], //Цвет при низком значении стамины
	//cursor
	["cursor",defVec4], //курсор в центре экрана
	//progress
	["prog_start",defVec4], //точка начала цвета прогресс бара
	["prog_end",defVec4], //конечная точка цвета прогресс бара

	["endTheme",defVec4]
];
decl(map)
ct_map_defaultColors = +ct_map_colors;

//Лист с темами
decl(map)
ct_map_themes = createHashMap;
decl(void(string))
ct_load = {
	params ["_themeName"];

	_themeName = toLower _themeName;

	if (!array_exists(ct_map_themes,_themeName)) exitWith {
		errorformat("ct::load() - Theme %1 does not exists",_themeName);
	};

	//Помещаем ссылку
	ct_map_colors = ct_map_themes get _themeName;
	//Копируем несуществующие значения
	ct_map_colors merge [ct_map_defaultColors,false];

	call ct_applyTheme;
};

//Восстанавливает тему по-умолчанию
decl(void())
ct_reset = {
	NOTIMPLEMENTED(ct::reset);
};

//Применяет установленную тему из ct_map_colors
decl(void())
ct_applyTheme = {

	private _nextFrameCall = false;

	// if inventory opened - close it
	if (isInventoryOpen) then {
		call closeInventory;
		_nextFrameCall = true;
	};

	private _codeCall = {
		// inventory slots (hands)
		call inventory_applyColorTheme;
		// chat
		call chat_applyColorTheme;
		// stamina
		call stamina_applyColorTheme;
		// pointer
		call interaction_aim_applyColorTheme;
		// progress
		call interact_progress_applyColorTheme;
	};


	if (_nextFrameCall) then {
		nextFrame(_codeCall);
	} else {
		call _codeCall;
	};
};
decl(any(string;string;int))
ct_internal_copy = {
	params ["_name","_key","_line"];
 	if !(_name in ct_map_themes) exitWith {
		errorformat("CT:COPY - Unknown theme %1 at %2",_this arg _line);
		[1,0,1,0]
	};
	ct_map_themes get _name getOrDefault [_key,[0,1,1,1]]
};

#include <Themes\loader.hpp>

{
	_tVal = _y;
	{
		if equalTypes(_y,[]) then {
			if (count _y == 2) then {
				if equalTypes(_y select 1,{}) then {
					_tVal set [_x,(_y select 0) call (_y select 1)];
				};
			};
		};
	} foreach _tVal;
} foreach ct_map_themes;

//Возвращает цвет с карты
decl(any(string))
ct_getValue = {
	params ["_name"];
	ct_map_colors getOrDefault [toLower _name,[1,0,0,1]];
};

//Отладочная функция отборажения цветов
#ifdef DEBUG
decl(void(string))
ct_debug_viewColors = {
	params ["_themeName"];

	[_themeName] call ct_load;

	_d = call displayOpen;

	//create main background (full black)
	_back = [_d,BACKGROUND,WIDGET_FULLSIZE] call createWidget;
	_back setBackgroundColor [0,0,0,1];
	ct_debug_switcher = false;
	ct_debug_colors = [[0,0,0,1],[1,1,1,1]];
	_d setVariable ["__mainback",_back];

	_d displayAddEventHandler ["KeyUp",{
		params ["_d"];
		ct_debug_switcher = !ct_debug_switcher;
		(_d getVariable "__mainback") setBackgroundColor (ct_debug_colors select ct_debug_switcher)
	}];

	//common tests

	_ctg1 = [_d,WIDGETGROUP,[5,5,28,28]] call createWidget;

	_back = [_d,BACKGROUND,[0,0,80,100],_ctg] call createWidget;
	_back setBackgroundColor (["back"] call ct_getValue);

	_back2 = [_d,BACKGROUND,[0,50,80,50],_ctg] call createWidget;
	_back2 setBackgroundColor (["back2"] call ct_getValue);

	_back2 = [_d,BACKGROUND,[80,0,20,100],_ctg] call createWidget;
	_back2 setBackgroundColor (["back2"] call ct_getValue);

	_tit = [_d,TEXT,[0,0,100,20],_ctg] call createWidget;
	_tit setBackgroundColor (["title"] call ct_getValue);
	[_tit,format["<t color='#%1'>Тестовый заголовок 123456789!",["title_text"] call ct_getValue]] call widgetSetText;

	_bt = [_d,BUTTON,[5,30,90,5],_ctg] call createWidget;
	_bt ctrlSetTextColor (["button_text"] call ct_getValue);
	_bt setBackgroundColor (["button"] call ct_getValue);

	_bt ctrlAddEventHandler ["MouseEnter",{(_this select 0) setBackgroundColor (["button_active"] call ct_getValue)}];
	_bt ctrlAddEventHandler ["MouseExit",{(_this select 0) setBackgroundColor (["button"] call ct_getValue)}];


	//inventory zone
	_sizeH = 10;
	_sizeW = transformSizeByAR(_sizeH);
	_invIcon = [_d,TEXT,[28 + 5+2,5,_sizeW,_sizeH]] call createWidget;
	_invIcon setBackgroundColor (["inv_slot_back"] call ct_getValue);
	[_invIcon,"back"] call widgetSetText;

	_invIcon = [_d,TEXT,[28 + 5+2,5 + 5 + _sizeH,_sizeW,_sizeH]] call createWidget;
	_invIcon setBackgroundColor (["inv_slot_act"] call ct_getValue);
	[_invIcon,"act"] call widgetSetText;

	_self = [_d,TEXT,[28 + 5+2 + _sizeW+ 2,5,10,5]] call createWidget;
	_invIcon setBackgroundColor (["inv_self_back"] call ct_getValue);
	[_tit,format["<t color='#%1'>self",["inv_self_text"] call ct_getValue]] call widgetSetText;

	//create verbs
	_vCtg = [_d,WIDGETGROUP,[28 + 5+2 + _sizeW+ 2+2,5,15,30]] call createWidget;
	_title = [_d,TEXT,[0,0,100,10],_vCtg] call createWidget;
	_tit setBackgroundColor (["verb_title"] call ct_getValue);
	[_tit,format["<t color='#%1'>Заголовок окна",["verb_title_text"] call ct_getValue]] call widgetSetText;

	_ctgv = [_d,BACKGROUND,[0,10,100,90],_vCtg] call createWidget;
	_ctgv setBackgroundColor (["verb_back"] call ct_getValue);

	_ctgv = [_d,WIDGETGROUP_H,[0,10,100,90],_vCtg] call createWidget;
	for "_i" from 0 to 20 do {
		_b = [_d,BUTTON,[0,_i * 10,100,10],_ctgv] call createWidget;
		_b ctrlSetText ("Действие " + str (_i+1));
		_b setBackgroundColor (["verb_button"] call ct_getValue);
	};

	//container zone

	_contCtg = [_d,WIDGETGROUP,[5,28 + 5+ 2,30,30]] call createWidget;
	_back = [_d,BACKGROUND,[0,10,100,90],_contCtg] call createWidget;

	_tit = [_d,TEXT,[0,0,100,10],_contCtg] call createWidget;
	_tit setBackgroundColor (["cont_title"] call ct_getValue);
	[_tit,format["<t color='#%1'>Название контейнера",["cont_title_text"] call ct_getValue]] call widgetSetText;

	_bool = true;
	_sizeH = 4;
	_sizeW = transformSizeByAR(_sizeH);
	for "_i" from 0 to 5 do {
		for "_j" from 0 to 10 do {
			_cw = [_d,TEXT,[(_i * _sizeW + (transformSizeByAR(1.5) * _i))+20,_j * _sizeH + (1.5 * _j),_sizeW,_sizeH],_contCtg] call createWidget;
			if (_bool) then {
				_cw setBackgroundColor (["cont_slot_backempt"] call ct_getValue);
				[_invIcon,"empty"] call widgetSetText;
			} else {
				_cw setBackgroundColor (["cont_slot_back"] call ct_getValue);
				[_invIcon,"item"] call widgetSetText;
			};
			_bool = !_bool;
		};
	};

	// stamina
	_ctgSta = [_d,WIDGETGROUP,[5+ 30 + 2,28 + 5 + 2 + 30,20,5]] call createWidget;
	_back = [_d,BACKGROUND,[50,0,50,100],_ctgSta] call widgetSetText;
	_back setBackgroundColor (["sta_back"] call ct_getValue);

	_back = [_d,BACKGROUND,[0,0,50,100],_ctgSta] call createWidget;
	_back setBackgroundColor (["sta_back_low"] call ct_getValue);

	_strip = [_d,BACKGROUND,[5,5,90,90],_ctgSta] call createWidget;
	_strip setBackgroundColor (["sta_strip"] call ct_getValue);

	_cursor = [_d,PICTURE,[5+ 30 + 2,28 + 5 + 2 + 30  + 20 + 2,transformSizeByAR(8),8]] call createWidget;
	_cursor ctrlSetTextColor (["cursor"] call ct_getValue);

	[_cursor,PATH_PICTURE("aim_cursor.paa")] call widgetSetPicture;

};
#endif