// ======================================================
// Copyright (c) 2017-2023 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include "..\..\host\engine.hpp"
#include "..\WidgetSystem\widgets.hpp"
#include "..\ClientRpc\clientRpc.hpp"

#include <Chat.hpp>
#include <Chat_onScreen.sqf>


//#define chat_unit_tests

_ui = getGUI;
_ctg = [_ui,WIDGETGROUP,[0,0,35,20]] call createWidget;
_background = [_ui,BACKGROUND,[0,0,100,100],_ctg] call createWidget;
_textfield = [_ui,TEXT,[0,0,100,100],_ctg] call createWidget;

_background setBackgroundColor [0,0,0,0.5];

//											chat history field
chat_widgets = [_ctg,_background,_textfield,widgetNull];

chat_messages_data = [];
chat_maxmessages = 100;

chat_size_x = 35;
chat_size_y = 20;

chat_isHistoryOpen = false;

chat_isHideEnabled = true;
	chat_hideAfter = 3;
	chat_isFullHidden = false;
	chat_hideValue = 0;
	chat_hideTimestamp = -1;

#include "functions.sqf"

startUpdate(chat_onUpdate,CHAT_HIDE_CHECK_UPDATE);

rpcAdd("cps",chatPrintSmart);
rpcAdd("chatPrint",chatprint);


#ifdef chat_unit_tests

	_isFastPrints = true;

	_allmes = ["Тестовое сообещние","Принт","Привер мир!"];
	_alltypes = ["emote","log","action","info","event","system","error","default"];

	_code = {
		(_this select 0) params ["_mes_all","_tp_all"];

		[pick _mes_all,pick _tp_all] call chatprint;

	};

	if (_isFastPrints) then {
		for "_i" from 1 to 100 do {
			[pick _allmes,pick(_alltypes)] call chatprint;
		};


	} else {

		for "_i" from 1 to 100 do {
			[pick(_allmes),pick(_alltypes)] call chatprint;
		};

		startUpdateParams(_code,5.5,[_allmes arg _alltypes]);
	};


#endif
