// ======================================================
// Copyright (c) 2017-2025 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================


//без фейдов быстро появляем лобби
#define FAST_INIT_LOBBY

#define lobby_log_enable

#define CHAT_SIZE_X 30

#define READY_BUTTON_SIZE_X 14

#define READY_BUTTON_COLOR_OFF [0.5,0,0,1]
#define READY_BUTTON_COLOR_ON [0,0.5,0,1]

#define CHARSETMENU_SIZE_X 40

#define widgetList lobby_widgetList

#define getBackground (widgetList select 0)
#define setBackground(wid) widgetList set [0,wid]

#define getTextField (widgetList select 1)
#define setTextField(wid) widgetList set [1,wid]

#define getTextFieldWg (widgetList select 2)
#define setTextFieldWg(wid) widgetList set [2,wid]

#define getMainCtg (widgetList select 3)
#define setMainCtg(wid) widgetList set [3,wid]

#define getButtonSend (widgetList select 4)
#define setButtonSend(wid) widgetList set [4,wid]

#define getInputChat (widgetList select 5)
#define setInputChat(wid) widgetList set [5,wid]

#define getReadyButton (widgetList select 6)
#define setReadyButton(wid) widgetList set [6,wid]

#define getSettingCtg (widgetList select 7)
#define setSettingCtg(wid) widgetList set [7,wid]

#define setMainWid(var,val) getMainCtg setVariable [var,val]
#define getMainWid(var) (getMainCtg getVariable (var))

#define setMainProp(var,val) getMainCtg setVariable ["prop_"+var,val]
#define getMainProp(var) (getMainCtg getVariable ("prop_"+var))

//Получает текущую настройку
#define getCurrentCharData(val) (lobby_charData getvariable val)

//settings helpers

#define wid _wid
#define key _key

#define onPressParams() params ["_wid","_key"]
#define addWidToList(wid) lobby_openedCharSetWidList pushBack wid
#define addCloseEvent(wid) wid ctrlAddEventHandler ["MouseButtonUp",{nextFrameParams(lobby_onCloseSetting,_this)}];
#define addOnPressEvent(wid,code) wid ctrlAddEventHandler ["MouseButtonUp",{nextFrameParams(code,_this)}]

//common 
#define DELAY_TO_PICKRANDOMNAME 2
#define DELAY_TO_PICKGENDER 1
#define DELAY_TO_PICKMAINHAND 1
#define DELAY_TO_PICKFAMILY 1

#define DELAY_TO_READY 0.5
#define DELAY_TO_NOT_READY 0.9

#define RANDFACE_UPD_TIME 0.2

#ifdef lobby_log_enable 
	#define loblog(mes,ft) systemchat format[mes,ft]
#else
	#define loblog(mes,ft)
#endif