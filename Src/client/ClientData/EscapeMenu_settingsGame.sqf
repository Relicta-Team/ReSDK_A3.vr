// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include "..\..\host\lang.hpp"
namespace(clientData,cd_)

enum(EscapeSettingDataIndex,SETTING_INDEX_)
#define SETTING_INDEX_NAME 0
#define SETTING_INDEX_DESC 1
#define SETTING_INDEX_TYPE 2
#define SETTING_INDEX_RANGE 3
#define SETTING_INDEX_VARNAME 4
#define SETTING_INDEX_CURRENT 5
#define SETTING_INDEX_DEFVALUE 6
#define SETTING_INDEX_SERIALIZED 7
#define SETTING_INDEX_EVENTONAPPLY 8
#define SETTING_INDEX_EVENTONABORT 9
#define SETTING_INDEX_EVENTONCHANGE 10
enumend

inline_macro
#define setting(name,desc,type,range,variable,event_on_apply,event_on_abort,event_on_change) [name,desc,type,range,#variable,variable,variable,variable,event_on_apply,event_on_abort,event_on_change]
//Тоже что и setting но использует общее событие
inline_macro
#define settingTEvent(name,desc,type,range,variable,__EVNT__) [name,desc,type,range,#variable,variable,variable,variable,__EVNT__,__EVNT__,__EVNT__]

inline_macro
#define nextRegion(nameof) [nameof]
macro_const(cd_COUNT_REGION_SETTINGS)
#define COUNT_REGION_SETTINGS 1
macro_const(cd_COLOR_BACKGROUND_REGION_NAME)
#define COLOR_BACKGROUND_REGION_NAME [0.2,0.2,0.2,0.9]

enum(EscapeSettingDataType,type)
#define typeInputFloat 0
#define typeSwitcher 1
#define typeSlider 2
#define typeBool 3
enumend

inline_macro
#define centerize(val) "<t align='center'>" + val + "</t>"

macro_const(cd_boolRange)
#define boolRange [centerize("нет"),centerize("да")]
inline_macro
#define defRange(min,max) ([min,max] call cd_internal_defRange)

decl(float[](float;float))
cd_internal_defRange = { params ["_mi","_ma"]; [_mi,_ma] };

//отключенное событие просто будет устанавливать переменную по имени из SETTING_INDEX_VARNAME
macro_const(cd_NO_EVENT_ON_APPLY)
#define NO_EVENT_ON_APPLY ""

#define value cd_esc_settings_internal_curChangedValue

decl(any)
cd_esc_settings_internal_curChangedValue = 0;

// !!! only debug !!!
decl(float) somedebugvar1 = 1;
decl(float) somedebugvar2 = 1;
decl(bool) testbool = false;

decl(any[])
cd_settingsGame = [
/*	nextRegion("Основные"),
	setting("Скрывать чат","Скрывает чат если нет новых сообщений",typeBool,boolRange,chat_isHideEnabled,NO_EVENT_ON_APPLY),
	setting("Время до скрытия чата","Через сколько секунд будет скрыт чат",typeInputFloat,defRange(0,60 * 5),chat_fadetime,NO_EVENT_ON_APPLY),
	nextRegion("Дополнительные"),
	setting("Тройная настройка","С 3 возможными режимами",typeSwitcher,[1 arg 10 arg 100],somedebugvar1,NO_EVENT_ON_APPLY),
	setting("Слайдерная настройка: %1","крути-верти!",typeSlider,defRange(1,10),somedebugvar2,NO_EVENT_ON_APPLY)*/
	nextRegion("Звук"),
	//nextRegion("	- не реализовано"), 
	setting("Музыка в лобби","Проигрывает музыку в лобби",typeBool,boolRange,lobby_isMusicEnabled,{lobby_isMusicEnabled = value; [lobby_isMusicEnabled] call lobby_handleMusic;}, {}, {}),
	nextRegion("Чат"),
	settingTEvent("Ширина","Ширина окна чата в процентах:\n\nМинимум: 20%\nМаксимум: 100%",typeSlider,defRange(20,100),chat_size_x,{[true] call chat_restoreVisible; chat_size_x = value; call chat_syncsize}),
	settingTEvent("Высота","Высота окна чата в процентах:\n\nМинимум: 15%\nМаксимум: 100%",typeSlider,defRange(15,100),chat_size_y,{[true] call chat_restoreVisible; chat_size_y = value; call chat_syncsize}),
	settingTEvent("Скрывать чат","Скрывает чат если нет новых сообщений по таймеру",typeBool,boolRange,chat_isHideEnabled,{chat_isHideEnabled = value; [false] call chat_restoreVisible;}),
	settingTEvent("Время до скрытия чата","Через сколько секунд будет скрыт чат\nесли нет новых сообщений\n\nМинимум: 1 сек\nМаксимум: 5 мин",typeInputFloat,defRange(1,60 * 5),chat_hideAfter,{chat_hideAfter = value; [false] call chat_restoreVisible;}),
	
	nextRegion("Интерфейс"),
	setting("Инвентарь по удержанию","Переключает режим открытия инвентаря с нажатия на удержание",typeBool,boolRange,inventory_isHoldMode,{inventory_isHoldMode= value ;}, {}, {}),
	//setting("Отключить интерфейс","Полностью выключает отображение GUI элементов",typeBool,boolRange,testbool,{  }, {}, {}),
	
	setting("Скрывать иконки рук","Скрывает иконки рук по таймеру при закрытом инвентаре",typeBool,boolRange,inventory_canHideHands,{[value] call inventory_setHideHands;}, {}, {}),
	setting("Время до скрытия иконок рук","Через сколько секунд будут скрыты иконки рук\n\nМинимум: 1 сек\nМаксимум: 60 сек",typeInputFloat,defRange(1,60),inventory_hideafter,{inventory_hideafter= value;[true]call inventory_restoreHide;}, {}, {}),
	
	//setting("Сохранять позицию мыши в инвентаре","Сохраняет позицию мыши при повторном открытии инвентаря",typeBool,boolRange,testbool,{}, {}, {}),
	
	//NON USABLE
	//setting("Скрывать статусы","Скрывает статусы по таймеру",typeBool,boolRange,hud_canHide,{hud_canHide= value;call hud_updateTimestamp;[false arg false]call hud_hide_reset;}, {}, {}),
	//setting("Время до скрытия статусов","Через сколько секунд будут скрыты иконки рук\n\nМинимум: 1 сек\nМаксимум: 60 сек",typeInputFloat,defRange(1,60),hud_hideAfter,{hud_hideAfter=value; call hud_updateTimestamp;}, {}, {}),
	
	nextRegion("Отладка"),
	setting("Включить отображение отладчика","Активирует окно с основной системной информацией",typeBool,boolRange,clistat_isEnabled,{[value] call clistat_setLogVars;}, {}, {}),
	setting("Перезагрузить освещение (ОТКЛЮЧЕНО)","Перезагружает все источники света",typeBool,boolRange,testbool,{ }, {}, {})
];

//событие выгрузки текущих настроек
decl(void(bool))
esc_settings_game_unloading = {
	private _mode = _this;
	if (_mode) then {
		
		private _serverSettings = [];
		
		_evc = null;
		{
			if (count _x == COUNT_REGION_SETTINGS) then {continue};
			
			// уже установленные настройки не применяются
			if equals(_x select SETTING_INDEX_CURRENT,_x select SETTING_INDEX_SERIALIZED) then {continue};
			
			_evc = _x select SETTING_INDEX_EVENTONAPPLY;
			if not_equals(_evc,"") then {
				value = _x select SETTING_INDEX_CURRENT;
				if equalTypes(_evc,"") then {
					call (missionNamespace getvariable [_evc,{}]);
				} else {
					call _evc;
				};
			} else {
				missionNamespace setVariable [_x select SETTING_INDEX_VARNAME,_x select SETTING_INDEX_CURRENT];
			};	
			
			private _data = [tolower (_x select SETTING_INDEX_VARNAME),_x select SETTING_INDEX_CURRENT];
			_serverSettings pushBack _data;
			if equals(_x select SETTING_INDEX_CURRENT,_x select SETTING_INDEX_DEFVALUE) then {
				_data pushBack true;
			};
			
		} foreach cd_settingsGame;
		
		//Отсылаем серверу настройки игры
		if (count _serverSettings > 0) then {
			rpcSendToServer("syncGameSettings",[_serverSettings arg clientOwner]);
		};
		
		{
			if (count _x == COUNT_REGION_SETTINGS) then {continue};
			(cd_settingsGame select _forEachIndex) set [SETTING_INDEX_SERIALIZED,_x select SETTING_INDEX_CURRENT];
		} foreach cd_settingsGame;
	} else {
		{
			if (count _x == COUNT_REGION_SETTINGS) then {continue};
			
			//Если настройка отличается от сериализованной вызываем событие onabort
			if not_equals(_x select SETTING_INDEX_CURRENT,_x select SETTING_INDEX_SERIALIZED) then {
				value = _x select SETTING_INDEX_SERIALIZED;
				call (_x select SETTING_INDEX_EVENTONABORT);
			};
			
			(cd_settingsGame select _forEachIndex) set [SETTING_INDEX_CURRENT,_x select SETTING_INDEX_SERIALIZED]
		} foreach cd_settingsGame;
	};
};
decl(void())
esc_settings_loader_game = {

	if (esc_settings_curIndex == 2) exitWith {};

	#define setting_element_size_x 10

	private _ctg = getSettingsList;

	private _setList = count cd_settingsGame;
	private _d = getDisplay;

	call esc_settings_clearSettingList;

	_data = [];

	//_applyType: 0 simple text (ctrlSetText), 1 call widgetSetText , 2 slider
	_allocType = {
		params ["_t"];
		call {
			if (_t == typeInputFloat) exitWith {[INPUT,["KeyDown",esc_settings_eventOnInput],3]};
			if (_t == typeSwitcher) exitWith {[BUTTON,["MouseButtonUp",esc_settings_eventOnSwitcher],0]};
			if (_t == typeSlider) exitWith {[SLIDERWNEW,["SliderPosChanged",esc_settings_eventOnSlider],2]};
			if (_t == typeBool) exitWith {[TEXT,["MouseButtonUp",esc_settings_eventOnBool],1]};
		}
	};

	for "_i" from 0 to _setList - 1 do {
		_setReg = (cd_settingsGame select _i);
		if (count _setReg == COUNT_REGION_SETTINGS) then {
			_minz = (20 * setting_element_size_x / 100);
			_dbt = [_d,TEXT,[0,setting_element_size_x * _i + _minz,100,setting_element_size_x -_minz*2],_ctg] call createWidget;
			[_dbt, centerize((_setReg select 0))] call widgetSetText;
			
			_dbt setBackgroundColor COLOR_BACKGROUND_REGION_NAME;
			_data pushBack [_dbt,widgetNull];
			continue;
		};	
		_setReg params ["_name","_desc","_type","_range","_var","_cur","_defval","_sv"];
		_dbt = [_d,TEXT,[0,setting_element_size_x * _i,50,setting_element_size_x],_ctg] call createWidget;
		_dbt ctrlSetTooltip _desc;
		[_dbt,_name] call widgetSetText;
		_dbt setvariable ["srcText",_name];

		([_type] call _allocType) params ["_wtype","_evtype","_applyType"];

		_dat = [_d,_wtype,[50,setting_element_size_x * _i,50,setting_element_size_x],_ctg] call createWidget;
		_dat ctrlAddEventHandler _evtype;


		_dat setvariable ["index",_i];
		_dat setvariable ["range",_range];
		_dat setVariable ["src",_dbt];
		
		__f_init = true;
		
		call {
			//float input
			if (_applyType == 3) exitWith {
				_value = _cur;
				if not_equalTypes(_value,"") then {_value = str _value};
				_dat ctrlSetText _value;
			};
			//bool
			if (_applyType == 1) exitWith {
				_dat setvariable ["curvalue",!_cur];
				[_dat] call esc_settings_eventOnBool;
			};
			//slider
			if (_applyType == 2) exitWith {
				_dat sliderSetRange _range;
				_value = _cur;
				_dat sliderSetPosition _value;
				[_dat,_value] call esc_settings_eventOnSlider;
			};
			//switcher
			if (_applyType == 0) exitWith {
				_value = _cur;
				_dat setVariable ["curIdx",_range find _value];
				if not_equalTypes(_value,"") then {_value = str _value};
				_dat ctrlSetText _value;
			};
		};


		_data pushBack [_dbt,_dat];

	};

	_ctg setvariable ["listData",_data];

};

//событие ввода
decl(void(widget;int))
esc_settings_eventOnInput = {
	params ["_bt","_key"];

	_value = parseNumber((parseNumber( ctrlText _bt)) toFixed 4);
	(_bt getvariable "range") params ["_min","_max"];
	if (_value < _min) exitWith {_bt ctrlSetText str _min};
	if (_value > _max) exitWith {_bt ctrlSetText str _max};
	//if (str _value != ctrlText _value) exitWith {_bt ctrlSetText str _min}; //non-numbers
	
	cd_settingsGame select (_bt getvariable "index") set [SETTING_INDEX_CURRENT,_value];
	
	if !isNullVar(__f_init) exitWith {};
	value = _value;
	call (cd_settingsGame select (_bt getVariable "index") select SETTING_INDEX_EVENTONCHANGE);
};

//событие переключателя
decl(void(widget))
esc_settings_eventOnSwitcher = {
	params ["_bt"];
	_curIdx = _bt getVariable "curIdx";
	_rangeArr = _bt getVariable "range";

	INC(_curIdx);

	if (_curIdx >= count _rangeArr) then {_curIdx = 0};
	_newval = _rangeArr select _curIdx;
	if not_equalTypes(_newval,"") then {_newval = str _newval};
	
	_bt ctrlSetText _newval;

	_bt setVariable ["curIdx",_curIdx];
	
	cd_settingsGame select (_bt getvariable "index") set [SETTING_INDEX_CURRENT,_newval];
	
	if !isNullVar(__f_init) exitWith {};
	value = _newval;
	call (cd_settingsGame select (_bt getVariable "index") select SETTING_INDEX_EVENTONCHANGE);
};

// событие слайдера
decl(void(widget;float))
esc_settings_eventOnSlider = {
	params ["_bt", "_newValue"];

	_dbt = _bt getVariable "src";
	[_dbt,format[_dbt getvariable "srcText",_newValue]] call widgetSetText;
	
	cd_settingsGame select (_bt getvariable "index") set [SETTING_INDEX_CURRENT,_newValue];
	
	if !isNullVar(__f_init) exitWith {};
	value = _newValue;
	call (cd_settingsGame select (_bt getVariable "index") select SETTING_INDEX_EVENTONCHANGE);
};

// событие бинарного условия
decl(void(widget))
esc_settings_eventOnBool = {
	params ["_bt"];

	private _idx = _bt getvariable "index";
	
	_newCurValue = !(_bt getvariable "curvalue");
	_bt setvariable ["curvalue",_newCurValue];

	private _pickedText = (_bt getVariable "range") select _newCurValue;

	[_bt,_pickedText] call widgetSetText;


	cd_settingsGame select (_bt getvariable "index") set [SETTING_INDEX_CURRENT,_newCurValue];
	
	if !isNullVar(__f_init) exitWith {};
	value = _newCurValue;
	call (cd_settingsGame select _idx select SETTING_INDEX_EVENTONCHANGE);
};


//событие синхронизирует все внешние изменения клавиш
decl(void())
esc_settings_event_onSyncGame = {
	{
		if (count _x == COUNT_REGION_SETTINGS) then {continue};
		cd_settingsGame select _forEachIndex set [SETTING_INDEX_CURRENT,missionNamespace getVariable (_x select SETTING_INDEX_VARNAME)]
	} foreach cd_settingsGame;
};

decl(void(...any[]))
cd_onLoadGameSettings = {
	private _list = _this;
	private _listAllowedVarNames = cd_settingsGame apply {if (count _x == COUNT_REGION_SETTINGS)then{"<__system:region__>"}else{tolower(_x select SETTING_INDEX_VARNAME)}};
	private _remList = [];
	
	{
		_x params ["_varName","_state"];
		_varName = tolower _varName;
		
		private _idxKeySeg = cd_settingsGame findif {count _x != COUNT_REGION_SETTINGS && {_varName == (_x select SETTING_INDEX_VARNAME)}};
		if (_idxKeySeg == -1) then {
			//Не должно выпадать
			errorformat("rpc::onLoadGameSettings() - Unexpected error at line %1",__LINE__);
			continue;
		};
		
		//Если такой настройки не существует по имени 
		// или значение является дефолтным значением
		// или значение является текущим, то нужно удалить из списка
		if (
			!array_exists(_listAllowedVarNames,_varName) || 
			{equals(cd_settingsGame select _idxKeySeg select SETTING_INDEX_DEFVALUE,_state)} ||
			{equals(cd_settingsGame select _idxKeySeg select SETTING_INDEX_CURRENT,_state)
			}
		) then {
			//errorformat("rpc::onLoadGameSettings() - %1:%2:%3 (state %4)",!array_exists(_listAllowedVarNames,_varName) arg equals(cd_settingsGame select _idxKeySeg select SETTING_INDEX_DEFVALUE,_state) arg equals(cd_settingsGame select _idxKeySeg select SETTING_INDEX_CURRENT,_state) arg _state);
			_remList pushBack [_varName,_state,true];
		} else {
			
			_evc = cd_settingsGame select _idxKeySeg select SETTING_INDEX_EVENTONAPPLY;
			if not_equals(_evc,"") then {
				value = _state;
				if equalTypes(_evc,"") then {
					call (missionNamespace getvariable [_evc,{}]);
				} else {
					call _evc;
				};
			} else {
				missionNamespace setVariable [_varName,_state];
			};

			cd_settingsGame select _idxKeySeg set [SETTING_INDEX_CURRENT,_state];
			cd_settingsGame select _idxKeySeg set [SETTING_INDEX_SERIALIZED,_state];
		};
		
	} foreach _list;
	
	//Ненайденные настройки выписываем с объекта сервер-клиента
	if (count _remList > 0) then {
		warningformat("rpc::onLoadGameSettings() - outdated keys found: %1",count _remList);
		rpcSendToServer("syncGameSettings",[_remList arg clientOwner]);
	};
}; rpcAdd("onLoadGameSettings",cd_onLoadGameSettings);


//validate variable settings
#ifdef DEBUG

{
	if (count _x == COUNT_REGION_SETTINGS) then {continue};
	
	_nulldef___ = isNull(_x select SETTING_INDEX_DEFVALUE);
	_nullcur__ = isNull(_x select SETTING_INDEX_CURRENT);
	_nullser__ = isNull(_x select SETTING_INDEX_SERIALIZED);
	if (_nulldef___ || _nullcur__ || _nullser__) exitWith {
		errorformat("[COMPILATION]: Validate game settings error: <%1, %2, %3> (EscapeMenu::settingGame at %4)",_nulldef___ arg _nullcur__ arg _nullser__ arg __LINE__);
		appExit(APPEXIT_REASON_COMPILATIOEXCEPTION);
	};
} foreach cd_settingsGame;


#endif