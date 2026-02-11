// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include "..\..\host\lang.hpp"
namespace(clientData,cd_)

decl(void())
esc_settings_loader_keyboard = {
	
	if (esc_settings_curIndex == 0) exitWith {};
		
	#define setting_element_size_x 10
	
	private _ctg = getSettingsList;
	
	private _setList = count cd_settingsKeyboard;
	private _d = getDisplay;
	
	call esc_settings_clearSettingList;
	
	private _data = [];
	
	for "_i" from 0 to _setList - 1 do {
		(cd_settingsKeyboard select _i) params ["_name","_desc","_cur","_def","_var"];
		_bt = [_d,BUTTON,[0,setting_element_size_x * _i,50,setting_element_size_x],_ctg] call createWidget;
		_txt = [_d,TEXT,[50,setting_element_size_x * _i,50,setting_element_size_x],_ctg] call createWidget;
		
		// initial text replaced to esc_settings_onUpdateKeybinds
		
		_bt setvariable ["isChangeProgress",false];
		_bt setvariable ["index",_i];
		_data pushBack [_bt,_txt];
		_bt ctrlAddEventHandler ["MouseButtonUp",esc_settings_keyboard_changeButton];
	};
	
	_bt = [_d,BUTTON,[0,setting_element_size_x * _setList + (setting_element_size_x/3),100,setting_element_size_x],_ctg] call createWidget;
	_data pushBack [_bt,widgetNull];
	_bt setvariable ["isChangeProgress",false];
	_bt ctrlAddEventHandler ["MouseButtonUp",{
		{
			cd_settingsKeyboard select _forEachIndex set [KEYBIND_INDEX_CURRENT,+(_x select KEYBIND_INDEX_DEFAULT)];//no copy ref list
		} foreach cd_settingsKeyboard;
		
		[false] call esc_settings_onUpdateKeybinds;
	}];
	_bt ctrlSetText "Сбросить управление на стандартное";
	_bt ctrlSetTooltip "Нажимать с осторожностью";
	
	
	_ctg setvariable ["listData",_data];
	
	[false] call esc_settings_onUpdateKeybinds;
};

decl(void(bool))
esc_settings_onUpdateKeybinds = {
	params [["_enableAllButtons",false]];
	
	_modifKeysCtrl = [KEY_RCONTROL,KEY_LCONTROL];
	_modifKeysShift = [KEY_LSHIFT,KEY_RSHIFT];
	_modifKeysAlt = [KEY_LALT,KEY_RALT];
	
	{
		_x params ["_bt","_txt"];
		if (_forEachIndex < (count cd_settingsKeyboard)) then {
			(cd_settingsKeyboard select _forEachIndex) params ["_name","_desc","_cur","_def","_var"];
			
			_bt ctrlSetText _name;
			_cur params ["_code","_shift","_ctrl","_alt","_isMouse"];
			_plus = [];
			/*
			//if (_key in [KEY_RCONTROL,KEY_LCONTROL] && _ctrl) then {_ctrl = false};
			//if (_key in [KEY_LSHIFT,KEY_RSHIFT] && _shift) then {_shift = false};
			//if (_key in [KEY_LALT,KEY_RALT] && _alt) then {_alt = false};
			
			*/
			if (!array_exists(_modifKeysShift,_code) && _shift) then {_plus pushBack "Shift"};
			if (!array_exists(_modifKeysCtrl,_code) && _ctrl) then {_plus pushBack "Control"};
			if (!array_exists(_modifKeysAlt,_code) && _alt) then {_plus pushBack "Alt"};
			if (count _plus > 0) then {_plus = [""] + _plus};
			
			[_txt,format["%3%1 %2",([_code] call input_getAllKeyNames) joinString " или ",_plus joinString " + ",["","Мышь: "] select _isMouse]] call widgetSetText;
			_bt ctrlSetTooltip _desc;
		};
		
		if (_enableAllButtons) then {
			_bt setVariable ["isChangeProgress",false];
			{
				_x ctrlEnable true;
				_x setFade 0;
				_x commit 0.5;
			} foreach _x;
		};
	} foreach (getSettingsList getvariable "listData");
	
	if (_enableAllButtons) then {
		{
			_x ctrlEnable true;
		} forEach ESC_GET_ALL_SETTINGS_TO_FADE;
	};
};

//Событие при изменении кнопки
decl(void(widget;int;bool;bool;bool))
esc_settings_keyboard_changeButton = {
	params ["_button","_code","_shift","_control","_alt"];
	
	if (_button getvariable "isChangeProgress") exitWith {};
	
	_button setvariable ["isChangeProgress",true];
	
	{
		if !((_x select 0) getvariable "isChangeProgress") then {
			{
				_x ctrlEnable false;
				_x setFade 0.7;
				_x commit 0.5;
			} foreach _x;
		} else {
			[(_x select 1),"Нажмите любую клавишу - Esc для отмены"] call widgetSetText;
		};	
	} foreach (getSettingsList getvariable "listData");
	
	//also disable main buttons
	{
		_x ctrlEnable false;
	} forEach ESC_GET_ALL_SETTINGS_TO_FADE;
	
	//now enable handler input
	_d = getDisplay;
	_d setvariable ["input_internal_lastChangedButton",_button];
	
	#define __handled_event_type__ "KeyUp"

	
	_datHandlers  = [];
	
	_handle = _d displayAddEventHandler [__handled_event_type__,{
		params ["_d","_key","_shift","_ctrl","_alt"];
		
		_button = _d getvariable ["input_internal_lastChangedButton" arg widgetNull];
		
		if isNullReference(_button) exitWith {};
		//validate wrong buttons DO NOT ENABLE
		//if (_key in [KEY_RCONTROL,KEY_LCONTROL] && _ctrl) then {_ctrl = false};
		//if (_key in [KEY_LSHIFT,KEY_RSHIFT] && _shift) then {_shift = false};
		//if (_key in [KEY_LALT,KEY_RALT] && _alt) then {_alt = false};
		
		_curState = [_key,_shift,_ctrl,_alt,false];
		_curIndex = _button getvariable "index";
		//validate key assoc
		{
			_checked = _x select KEYBIND_INDEX_CURRENT;
			if equals(_checked,_curState) exitWith {
				_prev = cd_settingsKeyboard select _curIndex select KEYBIND_INDEX_CURRENT;
				cd_settingsKeyboard select _forEachIndex set [KEYBIND_INDEX_CURRENT,+_prev];
			};
		} foreach cd_settingsKeyboard;
		
		_d setvariable ["input_internal_lastChangedButton",widgetNull];
		
		_args = [_curIndex,_curState];
		
		_postCode = {
			params ["_index","_data"];
			_d = getDisplay;
			{_d displayRemoveEventHandler _x} foreach (_d getvariable "input_internal_lastKeyChangerHandle");
			_d setvariable ["input_internal_lastKeyChangerHandle",null];
			
			cd_settingsKeyboard select _index set [KEYBIND_INDEX_CURRENT,+_data];
			
			[true] call esc_settings_onUpdateKeybinds;
			
		};
		nextFrameParams(_postCode,_args);
	}];
	_escHandle = _d displayAddEventHandler ["KeyDown",{
		params ["_d","_key"];
		if (_key == KEY_ESCAPE) then {
			_postCode = {
				_d = getDisplay;
				{_d displayRemoveEventHandler _x} foreach (_d getvariable "input_internal_lastKeyChangerHandle");
				_d setvariable ["input_internal_lastKeyChangerHandle",null];
				[true] call esc_settings_onUpdateKeybinds;
			};
			nextFrame(_postCode);
		};
	}];
	
	_datHandlers pushBack [__handled_event_type__,_handle];
	_datHandlers pushBack ["KeyDown",_escHandle];
	
	_d setvariable ["input_internal_lastKeyChangerHandle",_datHandlers];	
};

//событие синхронизирует все внешние изменения клавиш
decl(void())
esc_settings_event_onSyncKeyboard = {
	{
		cd_settingsKeyboard select _forEachIndex set [KEYBIND_INDEX_CURRENT,+(missionNamespace getVariable (_x select KEYBIND_INDEX_VARNAME))]
	} foreach cd_settingsKeyboard;
};