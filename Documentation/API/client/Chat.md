# Chat.hpp

## getChatAllText()

Type: constant

Description: Получение всех сообщений сгруппированных в цельную строку с переносом строки
- Param: 

Replaced value:
```sqf
(chat_messages_data joinString "<br/>")
```
File: [client\Chat\Chat.hpp at line 8](../../../Src/client/Chat/Chat.hpp#L8)
# chat_init.sqf

## chat_widgets

Type: Variable

Description: Ссылки на основные виджеты чата


Initial value:
```sqf
[_ctg,_background,_textfield,widgetNull]
```
File: [client\Chat\chat_init.sqf at line 24](../../../Src/client/Chat/chat_init.sqf#L24)
## chat_messages_data

Type: Variable

Description: Буффер сообщений


Initial value:
```sqf
[]
```
File: [client\Chat\chat_init.sqf at line 27](../../../Src/client/Chat/chat_init.sqf#L27)
## chat_maxmessages

Type: Variable

Description: Максимальное количество сообщений в буфере/истории


Initial value:
```sqf
100
```
File: [client\Chat\chat_init.sqf at line 29](../../../Src/client/Chat/chat_init.sqf#L29)
## chat_size_x

Type: Variable

Description: Размер истории чата (ширина)


Initial value:
```sqf
35
```
File: [client\Chat\chat_init.sqf at line 32](../../../Src/client/Chat/chat_init.sqf#L32)
## chat_size_y

Type: Variable

Description: Размер истории чата (высота)


Initial value:
```sqf
20
```
File: [client\Chat\chat_init.sqf at line 34](../../../Src/client/Chat/chat_init.sqf#L34)
## chat_isHistoryOpen

Type: Variable

Description: Открыта ли история чата


Initial value:
```sqf
false
```
File: [client\Chat\chat_init.sqf at line 37](../../../Src/client/Chat/chat_init.sqf#L37)
## chat_isHideEnabled

Type: Variable

Description: Включено ли автоматическое скрытие чата


Initial value:
```sqf
true
```
File: [client\Chat\chat_init.sqf at line 39](../../../Src/client/Chat/chat_init.sqf#L39)
## chat_hideAfter

Type: Variable

Description: Время автоматического скрытия


Initial value:
```sqf
3
```
File: [client\Chat\chat_init.sqf at line 41](../../../Src/client/Chat/chat_init.sqf#L41)
## chat_isFullHidden

Type: Variable

Description: Был ли чат полностью скрыт


Initial value:
```sqf
false
```
File: [client\Chat\chat_init.sqf at line 43](../../../Src/client/Chat/chat_init.sqf#L43)
## chat_hideValue

Type: Variable

Description: Внутреннее значение при расчете прозрачности во время скрытия


Initial value:
```sqf
0
```
File: [client\Chat\chat_init.sqf at line 45](../../../Src/client/Chat/chat_init.sqf#L45)
## chat_hideTimestamp

Type: Variable

Description: Время последнего скрытия


Initial value:
```sqf
-1
```
File: [client\Chat\chat_init.sqf at line 47](../../../Src/client/Chat/chat_init.sqf#L47)
# Chat_onScreen.sqf

## mlp(v)

Type: constant

Description: 
- Param: v

Replaced value:
```sqf
'v'
```
File: [client\Chat\Chat_onScreen.sqf at line 8](../../../Src/client/Chat/Chat_onScreen.sqf#L8)
## chatos_mobSelections

Type: Variable

Description: Список селекшонов мобов


Initial value:
```sqf
[...
```
File: [client\Chat\Chat_onScreen.sqf at line 11](../../../Src/client/Chat/Chat_onScreen.sqf#L11)
## chatos_guiCtg

Type: Variable

Description: Ссылка на контрольную группу текстового чата


Initial value:
```sqf
[widgetNull]
```
File: [client\Chat\Chat_onScreen.sqf at line 36](../../../Src/client/Chat/Chat_onScreen.sqf#L36)
## chatos_renderedWidgets

Type: Variable

Description: 


Initial value:
```sqf
createHashMap
```
File: [client\Chat\Chat_onScreen.sqf at line 38](../../../Src/client/Chat/Chat_onScreen.sqf#L38)
## chatos_renderedWidgetsPrint

Type: Variable

Description: 


Initial value:
```sqf
createHashMap
```
File: [client\Chat\Chat_onScreen.sqf at line 39](../../../Src/client/Chat/Chat_onScreen.sqf#L39)
## chatos_postMessageVisibleDelay

Type: Variable

Description: 


Initial value:
```sqf
2.5
```
File: [client\Chat\Chat_onScreen.sqf at line 41](../../../Src/client/Chat/Chat_onScreen.sqf#L41)
## chatos_list_blobMobs

Type: Variable

Description: 


Initial value:
```sqf
[]
```
File: [client\Chat\Chat_onScreen.sqf at line 240](../../../Src/client/Chat/Chat_onScreen.sqf#L240)
## chatos_onUpdate

Type: function

Description: 


File: [client\Chat\Chat_onScreen.sqf at line 43](../../../Src/client/Chat/Chat_onScreen.sqf#L43)
## chatos_inlinecode

Type: function

Description: 
- Param: _xpos
- Param: _ypos

File: [client\Chat\Chat_onScreen.sqf at line 126](../../../Src/client/Chat/Chat_onScreen.sqf#L126)
## chatos_getMobMessages

Type: function

Description: get message buffer


File: [client\Chat\Chat_onScreen.sqf at line 152](../../../Src/client/Chat/Chat_onScreen.sqf#L152)
## chatos_getTimeText

Type: function

Description: 
- Param: _mob
- Param: _text

File: [client\Chat\Chat_onScreen.sqf at line 156](../../../Src/client/Chat/Chat_onScreen.sqf#L156)
## chatos_canSeeObject

Type: function

Description: standart check
- Param: _obj

File: [client\Chat\Chat_onScreen.sqf at line 169](../../../Src/client/Chat/Chat_onScreen.sqf#L169)
## chatos_actBlob

Type: function

Description: 
- Param: _mob
- Param: _mes
- Param: _distance
- Param: _voiceType
- Param: _basePitch
- Param: _baseSpeed
- Param: _pertick (optional, default 0.5)

File: [client\Chat\Chat_onScreen.sqf at line 242](../../../Src/client/Chat/Chat_onScreen.sqf#L242)
## chatos_onUpdateBlobTask

Type: function

Description: 
- Param: _nextcall
- Param: _speed
- Param: _thisArgs
- Param: _deleteAfter
- Param: _startTime

File: [client\Chat\Chat_onScreen.sqf at line 261](../../../Src/client/Chat/Chat_onScreen.sqf#L261)
## chatos_onUpdatePrintingSay

Type: function

Description: 


File: [client\Chat\Chat_onScreen.sqf at line 295](../../../Src/client/Chat/Chat_onScreen.sqf#L295)
## chatos_isMobPrinting

Type: function

Description: 


File: [client\Chat\Chat_onScreen.sqf at line 323](../../../Src/client/Chat/Chat_onScreen.sqf#L323)
## chatos_event_onSpeak

Type: function

Description: 
- Param: _mob
- Param: _isspeaking

File: [client\Chat\Chat_onScreen.sqf at line 333](../../../Src/client/Chat/Chat_onScreen.sqf#L333)
## chatos_onSay

Type: function

Description: 


File: [client\Chat\Chat_onScreen.sqf at line 341](../../../Src/client/Chat/Chat_onScreen.sqf#L341)
# functions.sqf

## HIST_SIZE_H

Type: constant

Description: 


Replaced value:
```sqf
70
```
File: [client\Chat\functions.sqf at line 169](../../../Src/client/Chat/functions.sqf#L169)
## chatGettextwidget

Type: function

Description: Получает виджет, содержащий текстовое поле чата


File: [client\Chat\functions.sqf at line 13](../../../Src/client/Chat/functions.sqf#L13)
## chatgetbackgroundwidget

Type: function

Description: Получает виджет, содержащий задний фон чата


File: [client\Chat\functions.sqf at line 16](../../../Src/client/Chat/functions.sqf#L16)
## chatgetwidget

Type: function

Description: Получает основную контрольную группу, содержающу виджеты чата


File: [client\Chat\functions.sqf at line 19](../../../Src/client/Chat/functions.sqf#L19)
## chat_syncsize

Type: function

Description: Синхронизирует размеры виджетов чата
- Param: _x
- Param: _y
- Param: _w
- Param: _h

File: [client\Chat\functions.sqf at line 22](../../../Src/client/Chat/functions.sqf#L22)
## chatprint

Type: function

Description: Выводит текст в чат
- Param: _text
- Param: _type (optional, default "default")

File: [client\Chat\functions.sqf at line 39](../../../Src/client/Chat/functions.sqf#L39)
## chat_onRenderLobby

Type: function

Description: Отрисовывает чат в лобби. Копирует информацию из основного GUI чата в чат лобби


File: [client\Chat\functions.sqf at line 147](../../../Src/client/Chat/functions.sqf#L147)
## chatshowhistory

Type: function

Description: Открывает окно истории чата


File: [client\Chat\functions.sqf at line 166](../../../Src/client/Chat/functions.sqf#L166)
## chatPrintSmart

Type: function

Description: NOT USED
- Param: _txt
- Param: _ch
- Param: _src
- Param: _targ

File: [client\Chat\functions.sqf at line 200](../../../Src/client/Chat/functions.sqf#L200)
## chat_resetFadeTimer

Type: function

Description: Восстанавливает файдер чата


File: [client\Chat\functions.sqf at line 207](../../../Src/client/Chat/functions.sqf#L207)
## chat_restoreVisible

Type: function

Description: Восстанавливает видимость. Параметр _now в случае true восстанавливает видимость чата моментально
- Param: _now

File: [client\Chat\functions.sqf at line 213](../../../Src/client/Chat/functions.sqf#L213)
## chat_onUpdate

Type: function

Description: Обновляет чат


File: [client\Chat\functions.sqf at line 228](../../../Src/client/Chat/functions.sqf#L228)
## chat_applyColorTheme

Type: function

Description: Применяет цветовую тему к виджетам чата


File: [client\Chat\functions.sqf at line 249](../../../Src/client/Chat/functions.sqf#L249)
# helpers.hpp

## ENM_TIPS_ERROR

Type: constant

Description: Префикс при печате сообщений типа "error"


Replaced value:
```sqf
["Неа.","Никак!","Не получится.","Нет.","Отставить!","Не могу...", \
"Провал.","Плохая идея -","Так глупо.","Ошибочка...","Никак нет!", \
"Плохо.","Неудача.","Невезуха.","Сорвалось.","Промах.","Прокол.", \
"Вот облом...","Фиаско.","Ужас.","Не получилось.","Печально...", \
"Отмена.","БЛЯТЬ!","Вот дерьмо.","Чёрт.","Проклятье!","Ужасно!", \
"Жесть!","Облом.","Звёзды не сложились...","Не вышло.","Мда...", \
"Ой!","Упс...","Жаль...","Грустно...","Глупо всё это.","Досада.", \
"Не судьба.","Этому не суждено сбыться."]
```
File: [client\Chat\helpers.hpp at line 7](../../../Src/client/Chat/helpers.hpp#L7)
## getTextField

Type: constant

Description: Макрос для получения ссылки на текстовое поле


Replaced value:
```sqf
(call chatGettextwidget)
```
File: [client\Chat\helpers.hpp at line 17](../../../Src/client/Chat/helpers.hpp#L17)
## getBackground

Type: constant

Description: Макрос для получения ссылки на бекграунд


Replaced value:
```sqf
(call chatgetbackgroundwidget)
```
File: [client\Chat\helpers.hpp at line 19](../../../Src/client/Chat/helpers.hpp#L19)
## getHistoryField

Type: constant

Description: Макрос для получения ссылки на окно истории


Replaced value:
```sqf
(chat_widgets select 3)
```
File: [client\Chat\helpers.hpp at line 21](../../../Src/client/Chat/helpers.hpp#L21)
## CHAT_HIDE_CHECK_UPDATE

Type: constant

Description: Время, через которое выполняется проверка скрытия окна чата


Replaced value:
```sqf
0.1
```
File: [client\Chat\helpers.hpp at line 24](../../../Src/client/Chat/helpers.hpp#L24)
## CHAT_ONE_STEP_FADE_SIMULATION

Type: constant

Description: 


Replaced value:
```sqf
0.09
```
File: [client\Chat\helpers.hpp at line 25](../../../Src/client/Chat/helpers.hpp#L25)
# nativeChatHandler.sqf

## chat_native_checktimeDelay

Type: constant

Description: need initialization after client connect


Replaced value:
```sqf
60
```
File: [client\Chat\nativeChatHandler.sqf at line 25](../../../Src/client/Chat/nativeChatHandler.sqf#L25)
## chat_native_lastTimestamp

Type: Variable

Description: regular update tickStamp (for disable launcher)


Initial value:
```sqf
tickTime + chat_native_checktimeDelay
```
File: [client\Chat\nativeChatHandler.sqf at line 43](../../../Src/client/Chat/nativeChatHandler.sqf#L43)
## chat_native_handleDebug

Type: function

Description: 


File: [client\Chat\nativeChatHandler.sqf at line 57](../../../Src/client/Chat/nativeChatHandler.sqf#L57)
