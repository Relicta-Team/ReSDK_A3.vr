// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include "..\..\host\lang.hpp"

namespace(Lobby,lobby_)

//без фейдов быстро появляем лобби
macro_def(lobby_fastInitEnable)
#define FAST_INIT_LOBBY

macro_def(lobby_enableLogging)
#define lobby_log_enable

macro_const(lobby_chatSizeX)
#define CHAT_SIZE_X 30

macro_const(lobby_readyButtonSizeX)
#define READY_BUTTON_SIZE_X 14

macro_const(lobby_readyButtonColorOff)
#define READY_BUTTON_COLOR_OFF [0.5,0,0,1]
macro_const(lobby_readyButtonColorOn)
#define READY_BUTTON_COLOR_ON [0,0.5,0,1]

macro_const(lobby_charSetMenuSizeX)
#define CHARSETMENU_SIZE_X 40

inline_macro
#define widgetList lobby_widgetList

macro_func(lobby_getBackgroundWidget,widget())
#define getBackground (widgetList select 0)
macro_func(lobby_setBackgroundWidget,void(widget))
#define setBackground(wid) widgetList set [0,wid]

macro_func(lobby_getTextField,widget())
#define getTextField (widgetList select 1)
macro_func(lobby_setTextField,void(widget))
#define setTextField(wid) widgetList set [1,wid]

macro_func(lobby_getTextFieldWg,widget())
#define getTextFieldWg (widgetList select 2)
macro_func(lobby_setTextFieldWg,void(widget))
#define setTextFieldWg(wid) widgetList set [2,wid]

macro_func(lobby_getMainCtg,widget())
#define getMainCtg (widgetList select 3)
macro_func(lobby_setMainCtg,void(widget))
#define setMainCtg(wid) widgetList set [3,wid]

macro_func(lobby_getButtonSend,widget())
#define getButtonSend (widgetList select 4)
macro_func(lobby_setButtonSend,void(widget))
#define setButtonSend(wid) widgetList set [4,wid]

macro_func(lobby_getInputChat,widget())
#define getInputChat (widgetList select 5)
macro_func(lobby_setInputChat,void(widget))
#define setInputChat(wid) widgetList set [5,wid]

macro_func(lobby_getReadyButton,widget())
#define getReadyButton (widgetList select 6)
macro_func(lobby_setReadyButton,void(widget))
#define setReadyButton(wid) widgetList set [6,wid]

macro_func(lobby_getSettingCtg,widget())
#define getSettingCtg (widgetList select 7)
macro_func(lobby_setSettingCtg,void(widget))
#define setSettingCtg(wid) widgetList set [7,wid]

macro_func(lobby_setMainWidget,void(string;widget))
#define setMainWid(var,val) getMainCtg setVariable [var,val]
macro_func(lobby_getMainWidget,widget(string))
#define getMainWid(var) (getMainCtg getVariable (var))

macro_func(lobby_setMainProp,void(string;any))
#define setMainProp(var,val) getMainCtg setVariable ["prop_"+var,val]
macro_func(lobby_getMainProp,any(string))
#define getMainProp(var) (getMainCtg getVariable ("prop_"+var))

//Получает текущую настройку
macro_func(lobby_getCurrentCharData,any(string))
#define getCurrentCharData(val) (lobby_charData getvariable val)

//settings helpers
inline_macro
#define wid _wid
inline_macro
#define key _key

inline_macro
#define onPressParams() params ["_wid","_key"]

macro_func(lobby_addWidgetToList,void(widget))
#define addWidToList(wid) lobby_openedCharSetWidList pushBack wid
macro_func(lobby_addCloseEvent,void(widget))
#define addCloseEvent(wid) wid ctrlAddEventHandler ["MouseButtonUp",{nextFrameParams(lobby_onCloseSetting,_this)}];
inline_macro
#define addOnPressEvent(wid,code) wid ctrlAddEventHandler ["MouseButtonUp",{nextFrameParams(code,_this)}]

//common 
enum(LobbyDelays,DELAY_TO_)
#define DELAY_TO_PICKRANDOMNAME 2
#define DELAY_TO_PICKGENDER 1
#define DELAY_TO_PICKMAINHAND 1
#define DELAY_TO_PICKFAMILY 1

#define DELAY_TO_READY 0.5
#define DELAY_TO_NOT_READY 0.9
enumend

macro_const(lobby_randFaceUpdateTime)
#define RANDFACE_UPD_TIME 0.2

#ifdef lobby_log_enable 
	#define loblog(mes,ft) systemchat format[mes,ft]
#else
	#define loblog(mes,ft)
#endif