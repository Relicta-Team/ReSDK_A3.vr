// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include "..\..\host\engine.hpp"
#include "..\WidgetSystem\widgets.hpp"
#include "..\ClientRpc\clientRpc.hpp"

#include <Chat_onScreen.sqf>

namespace(chat,chat_)

_ui = getGUI;
_ctg = [_ui,WIDGETGROUP,[0,0,35,20]] call createWidget;
_background = [_ui,BACKGROUND,[0,0,100,100],_ctg] call createWidget;
_textfield = [_ui,TEXT,[0,0,100,100],_ctg] call createWidget;

_background setBackgroundColor [0,0,0,0.5];

//Ссылки на основные виджеты чата
decl(widget[]) chat_widgets = [_ctg,_background,_textfield,widgetNull];

// Буффер сообщений
decl(string[]) chat_messages_data = [];
// Максимальное количество сообщений в буфере/истории
decl(int) chat_maxmessages = 100;

// Размер истории чата (ширина)
decl(float) chat_size_x = 35;
// Размер истории чата (высота)
decl(float) chat_size_y = 20;

// Открыта ли история чата
decl(bool) chat_isHistoryOpen = false;
// Включено ли автоматическое скрытие чата
decl(bool) chat_isHideEnabled = true;
	// Время автоматического скрытия
	decl(float) chat_hideAfter = 3;
	// Был ли чат полностью скрыт
	decl(bool) chat_isFullHidden = false;
	// Внутреннее значение при расчете прозрачности во время скрытия
	decl(float) chat_hideValue = 0;
	// Время последнего скрытия
	decl(float) chat_hideTimestamp = -1;

const decl(string[])
chat_errorMessagePrefixes = ["Неа.","Никак!","Не получится.","Нет.","Отставить!","Не могу...",
"Провал.","Плохая идея -","Так глупо.","Ошибочка...","Никак нет!",
"Плохо.","Неудача.","Невезуха.","Сорвалось.","Промах.","Прокол.",
"Вот облом...","Фиаско.","Ужас.","Не получилось.","Печально...",
"Отмена.","БЛЯТЬ!","Вот дерьмо.","Чёрт.","Проклятье!","Ужасно!",
"Жесть!","Облом.","Звёзды не сложились...","Не вышло.","Мда...",
"Ой!","Упс...","Жаль...","Грустно...","Глупо всё это.","Досада.",
"Не судьба.","Этому не суждено сбыться."];

#include "functions.sqf"

startUpdate(chat_onUpdate,CHAT_HIDE_CHECK_UPDATE);

rpcAdd("chatPrint",chatprint);
