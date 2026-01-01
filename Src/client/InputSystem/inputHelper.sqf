// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\WidgetSystem\widgets.hpp>
#include <..\..\host\text.hpp>

#include "..\..\host\lang.hpp"

namespace(InputHelper,inputHelper_)

//Помощь по управлению
macro_const(inputHelper_widget_size_w)
#define INPUTHELPER_WIDGET_SIZE_W 30
macro_const(inputHelper_widget_size_h)
#define INPUTHELPER_WIDGET_SIZE_H 13

decl(bool)
inputHelper_enabled = true;

decl(int)
inputHelper_handleUpdate = -1;
decl(widget[])
inputHelper_widgets = [];
decl(float)
inputHelper_firstRunTaskId = 0;

decl(bool)
inputHelper_isSuccessCurrentTask = false; //системная переменная для выполнения внутренней задачи

//Базовые задачи это первый вход
decl(any[])
inputHelper_basicTask = [
	["","",{isLobbyOpen || call client_isInGame},{

	}],
	["Нажмите %1, чтобы перейти в режим взаимодействия","input_act_inventory",{isInventoryOpen},{INC(inputHelper_firstRunTaskId);}],
	["Нажмите %1, чтобы осмотреть объект"]
];

decl(void())
inputHelper_init = {
	if (!inputHelper_enabled) exitWith {};

	private _onUpdate = {

		(inputHelper_basicTask select inputHelper_firstRunTaskId) params ["_txt","_button","_condition","_state"];
		if (call _condition) then {
			call _state;
		};

		_doDel = false;
		{
			_tDel = (_x getVariable "deleteMark");
			_canDel = if equalTypes(_tDel,0) then {tickTime > _tDel} else _tDel;
			if (_canDel) then {
				[_x] call deleteWidget;
				_doDel = true;
			} else {
				[_x getVariable "txt",format[_txt,[_button]call input_getKeyNameByInputName]] call widgetSetText;
			};
		} foreach inputHelper_widgets;

		if (_doDel) then {
			inputHelper_widgets = inputHelper_widgets - [widgetNull];
			call inputHelper_internal_sortWidgets;
		};
	};
	inputHelper_handleUpdate = startUpdate(_onUpdate,0);
};

decl(void(string;any))
inputHelper_showNotification = {
	params ["_text","_timeOrCode"];
	if (!inputHelper_enabled) exitWith {};
	private _ctg = [getGUI,
		WIDGETGROUP
		[100,100,INPUTHELPER_WIDGET_SIZE_W,INPUTHELPER_WIDGET_SIZE_H]
	] call createWidget;
	_ctg setVariable ["deleteMark",_timeOrCode];

	private _b = [getGUI,BACKGROUND,WIDGET_FULLSIZE,_ctg] call createWidget;
	_b setBackgroundColor [.2,.2,.2,0.6];

	private _txt = [getGUI,TEXT,WIDGET_FULLSIZE,_ctg] call createWidget;
	_ctg setVariable ["txt",_txt];

	inputHelper_widgets pushBack _ctg;

	call inputHelper_internal_sortWidgets;
};

decl(void())
inputHelper_internal_sortWidgets = {
	private _refWid = inputHelper_widgets;
	for "_i" from 0 to (count _refWid) -1 do {
		_ctg = _refWid select _i;
		[_ctg,
			[
				100 - INPUTHELPER_WIDGET_SIZE_W,
				_i * INPUTHELPER_WIDGET_SIZE_H,
				INPUTHELPER_WIDGET_SIZE_W,
				INPUTHELPER_WIDGET_SIZE_H
			],
		0.1
		] call widgetSetPosition;
	};
};
