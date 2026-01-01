// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include "..\..\host\lang.hpp"
namespace(EscapeMenu,esc_)

#include <..\WidgetSystem\widgets.hpp>

macro_const(esc_menu_size_x)
#define ESC_MENU_SIZE_X 20
macro_const(esc_menu_size_y)
#define ESC_MENU_SIZE_Y 30
macro_const(esc_menu_default_button_bias_x)
#define ESC_MENU_DEFAULT_BUTTON_BIAS_X 5
macro_const(esc_menu_default_button_bias_y)
#define ESC_MENU_DEFAULT_BUTTON_BIAS_Y 5

macro_const(esc_menu_background_color_t3)
#define ESC_MENU_BACKGROUND_COLOR_T3 0.4

inline_macro
#define handleSettings(closerEv,OpenerEv) ([closerEv,OpenerEv] call esc_internal_handleSettings)
	inline_macro
	#define addOpenerAndActivator(id) getDisplay createDisplay  "RscDisplayInterrupt"; ctrlActivate (findDisplay 49 displayCtrl id)
	inline_macro
	#define addCloseEventToSetting(id) (findDisplay id) displayAddEventHandler ["Unload",{(findDisplay 49) closeDisplay 0}]
macro_const(esc_menu_ces_video)
#define ces_video 5
	macro_const(esc_menu_set_ca_video)
	#define set_ca_video 301
macro_const(esc_menu_ces_audio)
#define ces_audio 6
	macro_const(esc_menu_set_ca_audio)
	#define set_ca_audio 302
macro_const(esc_menu_ces_input)
#define ces_input 4
	macro_const(esc_menu_set_ca_input)
	#define set_ca_input 303
decl(bool)
esc_isMenuOpened = false;
decl(widget[])
esc_widgets = [widgetNull];

macro_func(esc_getEscapeCtg,widget())
#define getEscapeCtg (esc_widgets select 0)

decl(void(int;int))
esc_internal_handleSettings = {
	params ["_closerEv","_openerEv"];
	addOpenerAndActivator(_openerEv); 
	addCloseEventToSetting(_closerEv);
	if (_closerEv == ces_video) then {
		(findDisplay _closerEv) displayAddEventHandler ["Unload",{
			(findDisplay 49) closeDisplay 0;
			//fix #599
			[true] call pp_reload;
		}];
	};
};

decl(any[])
esc_buttonsData = [
	["Продолжить","Преставление продолжается...",{nextFrame(esc_closeMenu)}],
	["Настройки реликты","Специализированные настройки для реликты:\nУправление, звук, уровень графики",{
		nextFrame(esc_settings_open);
		}],
	["Управление","Назначение клавиш управления для Arma 3",{handleSettings(ces_input,set_ca_input)}],
	["Графика","Установка настройек графики для Arma 3",{handleSettings(ces_video,set_ca_video)}],
	["Звук","Изменение настроек звука для Arma 3",{handleSettings(ces_audio,set_ca_audio)}],
	["Выход","Спектакль окончен",{nextFrame(esc_confirmExit)}]
];

decl(void(bool))
esc_openMenu = {
	params [["_isOpenedInLobby",false]];

	if (esc_isMenuOpened) exitWith {};
	
	if (!(call widget_antiGammaCheck)) exitWith {
        error("Brightness or gamma is out of the acceptable range. Set the brightness and gamma value to 1");
        //endMission "LOSER";
        rpcCall("clientDisconnect",vec2("Вы были отключены от сервера","На сервере запрещается изменение яркости и гаммы. " + widget_antiGamma_lastError));
    };
	
	esc_isMenuOpened = true;
	[50,50] call mouseSetPosition;

	private _d = if (_isOpenedInLobby) then {getDisplay} else {call displayOpen};
	

	
	private _ctg = [_d,WIDGETGROUP,
		[50 - ESC_MENU_SIZE_X/2,
		50 - ESC_MENU_SIZE_Y/2,
		ESC_MENU_SIZE_X,
		ESC_MENU_SIZE_Y]
	] call createWidget;
	
	if (_isOpenedInLobby) then {
		_d setVariable ["escapeMenu_isOpenedInLobbyContext",true];
		_d setVariable ["escapeMenu_lobbyModeCtg",_ctg];
		[true] call lobby_sysSetEnable;
	};	

	private _back = [_d,BACKGROUND,WIDGET_FULLSIZE,_ctg] call createWidget;
	_back setBackgroundColor [ESC_MENU_BACKGROUND_COLOR_T3,ESC_MENU_BACKGROUND_COLOR_T3,ESC_MENU_BACKGROUND_COLOR_T3,0.85];

	private _countButtons = count esc_buttonsData;
	private _sizeH = (100 - (_countButtons * ESC_MENU_DEFAULT_BUTTON_BIAS_Y)) / _countButtons;
	private _sizeW = 90 - ESC_MENU_DEFAULT_BUTTON_BIAS_X*2;
	private _butt = widgetNull;

	for "_y" from 1 to _countButtons do {
		_butt = [_d,BUTTON,[
			50 - _sizeW/2,
			_sizeH * _y + ESC_MENU_DEFAULT_BUTTON_BIAS_Y/2 * (_y-3),
			_sizeW,
			_sizeH
		],_ctg] call createWidget;
		(esc_buttonsData select (_y-1)) params ["_text","_desc","_code"];

		//[_butt,_text] call widgetSetText;
		_butt ctrlSetText _text;
		_butt ctrlSetTooltip _desc;
		_butt ctrlAddEventHandler ["MouseButtonUp",_code];

	};

	esc_widgets = [_ctg];
};

//подтверждение выхода
decl(void())
esc_confirmExit = {
	
	if (isLobbyOpen) exitWith {
		rpcCall("clientDisconnect",null);
	};	
	
	_ctg = getEscapeCtg;

	_ctg ctrlEnable false;
	_ctg setFade 1;
	_ctg commit 0.2;

	_d = getDisplay;

	private _ctgIn = [_d,WIDGETGROUP,
		[50 - 30/2,
		50 - 15/2,
		30,
		15]
	] call createWidget;

	private _back = [_d,BACKGROUND,WIDGET_FULLSIZE,_ctgIn] call createWidget;
	_back setBackgroundColor [ESC_MENU_BACKGROUND_COLOR_T3,ESC_MENU_BACKGROUND_COLOR_T3,ESC_MENU_BACKGROUND_COLOR_T3,0.85];
	_txt = [_d,TEXT,[0,0,100,30],_ctgIn] call createWidget;
	#ifdef SP_MODE
	[_txt,"<t align='center' size='0.8'>Вы уверены? Вы сможете начать заново с любой из пройденных вами глав.</t>"] call widgetSetText;
	#else
	[_txt,"<t align='center' size='0.8'>Вы уверены? Ваш персонаж останется в мире и с ним может произойти всё что угодно.</t>"] call widgetSetText;
	#endif

	_accept = [_d,BUTTON,[5,35,40,60],_ctgIn] call createWidget;
	_back = [_d,BUTTON,[55,35,40,60],_ctgIn] call createWidget;

	_accept ctrlSetText "Да";
	_back ctrlSetText "Нет";

	_accept setvariable ["ctg",_ctgIn];
	_back setvariable ["ctg",_ctgIn];

	_accept ctrlAddEventHandler ["MouseButtonUp",{

		_ctg = (_this select 0) getvariable ["ctg",widgetNull];

		_args = [_ctg,true];
		nextFrameParams(deleteWidget,_args);

		_postCode = {

			rpcCall("clientDisconnect",null);
		};
		[true,1.5] call setBlackScreenGUI;
		invokeAfterDelay(_postCode,1.6);
	}];

	_back ctrlAddEventHandler ["MouseButtonUp",{
		_ctg = (_this select 0) getvariable ["ctg",widgetNull];

		[_ctg,true] call deleteWidget;

		_ctg = getEscapeCtg;

		_ctg ctrlEnable true;
		_ctg setFade 0;
		_ctg commit 0.2;
	}];
};

decl(void())
esc_closeMenu = {
	
	if (!(call widget_antiGammaCheck)) exitWith {
		error("Brightness or gamma is out of the acceptable range. Set the brightness and gamma value to 1");
		//endMission "LOSER";
		rpcCall("clientDisconnect",vec2("Вы были отключены от сервера","На сервере запрещается изменение яркости и гаммы. " + widget_antiGamma_lastError));
	};
	
	esc_isMenuOpened = false;

	input_catchedEscape = false; //handler catcher
	
	if (getDisplay getVariable ["escapeMenu_isOpenedInLobbyContext",false]) exitWith {
		getDisplay setVariable ["escapeMenu_isOpenedInLobbyContext",false];
		[getDisplay getVariable ["escapeMenu_lobbyModeCtg",widgetNull]] call deleteWidget;
		[false] call lobby_sysSetEnable;
	};
	
	call displayClose;
};

/*
================================================================================
		REGION: SETTINGS
================================================================================
*/
#include <..\InputSystem\inputKeyHandlers.hpp>
#include <..\..\host\keyboard.hpp>

macro_func(esc_getSettingsCtg,widget())
#define getSettingsCtg (esc_settings_widgets select 0)
macro_func(esc_getSettingsList,widget())
#define getSettingsList (esc_settings_widgets select 1)
macro_func(esc_getSettingsAccept,widget())
#define getSettingsAccept (esc_settings_widgets select 2)
macro_func(esc_getSettingsAbort,widget())
#define getSettingsAbort (esc_settings_widgets select 3)

macro_func(esc_getAllSettingsToFade,widget[]())
#define ESC_GET_ALL_SETTINGS_TO_FADE [getSettingsAbort,getSettingsAccept,getSettingsList,getSettingsCtg]

macro_const(esc_settings_size_x)
#define SETTINGS_SIZE_X 60
macro_const(esc_settings_size_y)
#define SETTINGS_SIZE_Y 60
macro_const(esc_settings_menu_background_color_t3)
#define SETTINGS_MENU_BACKGROUND_COLOR_T3 ESC_MENU_BACKGROUND_COLOR_T3

#include "EscapeMenu_settingsKeyboard.sqf"
#include "EscapeMenu_settingsGame.sqf"
#include "EscapeMenu_settingsGraphics.sqf"

decl(widget[])
esc_settings_widgets = [widgetNull,widgetNull,widgetNull,widgetNull];
//Порядок настроек строго фиксирован и связан с ServerClient::clientSettings
decl(any[])
esc_settings_names = [
	//Название,событие нажатия, событие загрузки,
	["Управление",esc_settings_loader_keyboard,esc_settings_event_onSyncKeyboard],
	["Графика",esc_settings_loader_graphic,{}],
	["Игра",esc_settings_loader_game,esc_settings_event_onSyncGame]
];
decl(int)
esc_settings_curIndex = -1;

decl(float)
cd_settingsVersion = 1.0;

decl(void())
esc_settings_open = {

	#ifdef EDITOR
		//serialize info in editor mode
		call editorDebug_serializePlayerSettings;
	#endif

	_ctg = getEscapeCtg;
	_ctg ctrlEnable false;
	_ctg setFade 1;
	_ctg commit 0.2;

	//Настройки в виде списка. Управление, графика, прочие мелкие пункты (например камера или скрытие войса)
	private _d = getDisplay;

	_ctg = [_d,WIDGETGROUP,
		[50 - SETTINGS_SIZE_X/2,50 - SETTINGS_SIZE_Y/2,SETTINGS_SIZE_X,SETTINGS_SIZE_Y]
	] call createWidget;
	
	_back = [_d,BACKGROUND,WIDGET_FULLSIZE,_ctg] call createWidget;
	_back setBackgroundColor [SETTINGS_MENU_BACKGROUND_COLOR_T3,SETTINGS_MENU_BACKGROUND_COLOR_T3,SETTINGS_MENU_BACKGROUND_COLOR_T3,0.8];

	_btCount = count esc_settings_names;
	_btX = 100 / _btCount;

	for "_i" from 0 to (_btCount-1) do {
		_b = [_d,BUTTON,[(_btX * _i),0,_btX,10],_ctg] call createWidget;
		_b ctrlSetText (esc_settings_names select _i select 0);
		_b ctrlAddEventHandler ["MouseButtonUp",esc_settings_names select _i select 1];
		call (esc_settings_names select _i select 2);
	};

	_back = [_d,BACKGROUND,[1,10+1,98,80-1],_ctg] call createWidget;
	_back setBackgroundColor [SETTINGS_MENU_BACKGROUND_COLOR_T3,SETTINGS_MENU_BACKGROUND_COLOR_T3,SETTINGS_MENU_BACKGROUND_COLOR_T3,0.9];
	_back ctrlEnable false;
	_ctgIn = [_d,WIDGETGROUP_H,[1,10+1,98,80-1],_ctg] call createWidget;

	_accept = [_d,BUTTON,[1,91,48,8],_ctg] call createWidget;
	_abort = [_d,BUTTON,[51,91,48,8],_ctg] call createWidget;

	_accept ctrlSetText "Применить";
	_abort ctrlSetText "Отмена";

	_accept ctrlAddEventHandler ["MouseButtonUp",{
		call input_updateAllKeyBinds;
		[true] call esc_settings_close;
	}];
	_abort ctrlAddEventHandler ["MouseButtonUp",{
		[false] call esc_settings_close;
	}];
	
	if (_d getVariable ["escapeMenu_isOpenedInLobbyContext",false]) then {
		ctrlSetFocus _abort;
	};	

	esc_settings_widgets = [_ctg,_ctgIn,_accept,_abort];

	esc_settings_curIndex = -1;
	call esc_settings_loader_keyboard;
};

decl(void(bool))
esc_settings_close = {
	params [["_isSaved",false]];
	
	[getSettingsCtg,true] call deleteWidget;

	_ctg = getEscapeCtg;
	_ctg ctrlEnable true;
	_ctg setFade 0;
	_ctg commit 0.2;
	
	if (_isSaved) then {
		//saving inputs
		{
			(cd_settingsKeyboard select _forEachIndex) set [KEYBIND_INDEX_SERIALIZED,_x select KEYBIND_INDEX_CURRENT]
		} foreach cd_settingsKeyboard;
		
	} else {
		//drop inputs
		{
			(cd_settingsKeyboard select _forEachIndex) set [KEYBIND_INDEX_CURRENT,_x select KEYBIND_INDEX_SERIALIZED]
		} foreach cd_settingsKeyboard;
	};
	
	_isSaved call esc_settings_game_unloading;
};

decl(void())
esc_settings_clearSettingList = {
	private _ctg = getSettingsList;
	{
		if equalTypes(_x,[]) then {
			{[_x] call deleteWidget} foreach _x;
		} else {
			[_x] call deleteWidget;
		};
	} foreach (_ctg getvariable ["listData",[]]);
};
