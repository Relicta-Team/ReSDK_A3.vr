// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include "..\..\host\lang.hpp"

namespace(InteractMenu,interactMenu_)

decl(bool)
interactMenu_disableGlobal = false;

//активно ли интеракт меню
decl(bool)
interactMenu_isLoadedMenu = false;

decl(widget[])
interactMenu_skillWidgets = [];

_interactMenu_skillWidgets = [];
_interactMenu_skillWidgets resize 8;
interactMenu_skillWidgets = _interactMenu_skillWidgets apply {widgetNull};
decl(string[])
interactMenu_skillNames = ["СЛ","ИН","ЛВ","ЗД","ВНС","ВОЛЯ","ВОС","ЖЗ"];

macro_func(interactMenu_getIntentIconPath,string(string))
#define INT_PATH(pt) (PATH_PICTURE_FOLDER + "interact\" + pt + ".paa" )

decl(string[])
interactMenu_intentPath = [INT_PATH("help"),INT_PATH("grab"),INT_PATH("harm")];

decl(widget[])
interactMenu_intentWidgets = [widgetNull,widgetNull,widgetNull];
decl(widget[])
interactMenu_activeIntent = [widgetNull]; //ссылка на виджет активного
decl(float[][])
interactMenu_intentActiveColors = [
	[0.1,0.729,0.1,1], //help
	[0.878,0.8,0.149,1], //grab
	[0.71,0.035,0.035,1] //harm
];

decl(widget[])
interactMenu_selectionWidgets = [];

_sels = [];
_sels resize 13;
interactMenu_selectionWidgets = _sels apply {widgetNull};
decl(widget[])
interactMenu_activeSelectionWidget = [widgetNull]; //виджет активной зоны

//специальные действия на F
decl(any[][])
interactMenu_specialActions = [
	["Пинать",SPECIAL_ACTION_KICK,ACTION_SWITCHABLE],
	["Красть",SPECIAL_ACTION_STEAL,ACTION_SWITCHABLE],
	["Схватить",SPECIAL_ACTION_GRAB,ACTION_SWITCHABLE],
	["Прятаться",SPECIAL_ACTION_STEALTH,ACTION_PLAYING],
	["Кусать",SPECIAL_ACTION_BITE,ACTION_SWITCHABLE],
	["Глаза",SPECIAL_ACTION_EYES,ACTION_PLAYING],
	["Прыгать",SPECIAL_ACTION_JUMP,ACTION_SWITCHABLE],
	["Сон",SPECIAL_ACTION_SLEEP,ACTION_PLAYING],
	["Бросок",SPECIAL_ACTION_THROW,ACTION_SWITCHABLE],
	["Дыхание",SPECIAL_ACTION_BREATH,ACTION_PLAYING]
	//todo карабканье
];
//фразы для худа
decl(any[][])
interactMenu_specialActions_map_hud = createHashMapFromArray [
	[SPECIAL_ACTION_KICK,"[Спец] Пинать"],
	[SPECIAL_ACTION_GRAB,"[Спец] Хватать"],
	[SPECIAL_ACTION_BITE,"[Спец] Кусать"],
	[SPECIAL_ACTION_JUMP,"[Спец] Прыгать"],
	[SPECIAL_ACTION_STEAL,"[Спец] Красть"],
	[SPECIAL_ACTION_THROW,"[Спец] Бросать"]
];

decl(widget[])
interactMenu_curActiveSpecAct = [widgetNull];

decl(widegt[])
interactMenu_specActWidgets = [];

//мапа для специальных действий
_nmap = [];
_nmap resize (count interactMenu_specialActions);
interactMenu_specActWidgets = _nmap apply {widgetNull};
