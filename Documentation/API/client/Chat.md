# Chat.hpp

## getChatAllText()

Type: constant

Description: 
- Param: 

Replaced value:
```sqf
(chat_messages_data joinString "<br/>")
```
File: [client\Chat\Chat.hpp at line 8](../../../Src/client/Chat/Chat.hpp#L8)
# chat_init.sqf

## chat_unit_tests

Type: constant

Description: 


Replaced value:
```sqf

```
File: [client\Chat\chat_init.sqf at line 14](../../../Src/client/Chat/chat_init.sqf#L14)
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
## chatos_onUpdate

Type: function

Description: 


File: [client\Chat\Chat_onScreen.sqf at line 41](../../../Src/client/Chat/Chat_onScreen.sqf#L41)
## chatos_inlinecode

Type: function

Description: 
- Param: _xpos
- Param: _ypos

File: [client\Chat\Chat_onScreen.sqf at line 124](../../../Src/client/Chat/Chat_onScreen.sqf#L124)
## chatos_getMobMessages

Type: function

Description: get message buffer


File: [client\Chat\Chat_onScreen.sqf at line 150](../../../Src/client/Chat/Chat_onScreen.sqf#L150)
## chatos_getTimeText

Type: function

Description: 
- Param: _mob
- Param: _text

File: [client\Chat\Chat_onScreen.sqf at line 154](../../../Src/client/Chat/Chat_onScreen.sqf#L154)
## chatos_canSeeObject

Type: function

Description: standart check
- Param: _obj

File: [client\Chat\Chat_onScreen.sqf at line 167](../../../Src/client/Chat/Chat_onScreen.sqf#L167)
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

File: [client\Chat\Chat_onScreen.sqf at line 240](../../../Src/client/Chat/Chat_onScreen.sqf#L240)
## chatos_onUpdateBlobTask

Type: function

Description: 
- Param: _nextcall
- Param: _speed
- Param: _thisArgs
- Param: _deleteAfter
- Param: _startTime

File: [client\Chat\Chat_onScreen.sqf at line 259](../../../Src/client/Chat/Chat_onScreen.sqf#L259)
## chatos_onUpdatePrintingSay

Type: function

Description: 


File: [client\Chat\Chat_onScreen.sqf at line 293](../../../Src/client/Chat/Chat_onScreen.sqf#L293)
## chatos_isMobPrinting

Type: function

Description: 


File: [client\Chat\Chat_onScreen.sqf at line 321](../../../Src/client/Chat/Chat_onScreen.sqf#L321)
## chatos_event_onSpeak

Type: function

Description: 
- Param: _mob
- Param: _isspeaking

File: [client\Chat\Chat_onScreen.sqf at line 331](../../../Src/client/Chat/Chat_onScreen.sqf#L331)
## chatos_onSay

Type: function

Description: 


File: [client\Chat\Chat_onScreen.sqf at line 339](../../../Src/client/Chat/Chat_onScreen.sqf#L339)
# functions.sqf

## HIST_SIZE_H

Type: constant

Description: 


Replaced value:
```sqf
70
```
File: [client\Chat\functions.sqf at line 120](../../../Src/client/Chat/functions.sqf#L120)
## chatGettextwidget

Type: function

Description: 


File: [client\Chat\functions.sqf at line 13](../../../Src/client/Chat/functions.sqf#L13)
## chatgetbackgroundwidget

Type: function

Description: 


File: [client\Chat\functions.sqf at line 15](../../../Src/client/Chat/functions.sqf#L15)
## chatgetwidget

Type: function

Description: 


File: [client\Chat\functions.sqf at line 17](../../../Src/client/Chat/functions.sqf#L17)
## chat_syncsize

Type: function

Description: 
- Param: _x
- Param: _y
- Param: _w
- Param: _h

File: [client\Chat\functions.sqf at line 19](../../../Src/client/Chat/functions.sqf#L19)
## chatprint

Type: function

Description: 
- Param: _text
- Param: _type (optional, default "default")

File: [client\Chat\functions.sqf at line 35](../../../Src/client/Chat/functions.sqf#L35)
## chat_onRenderLobby

Type: function

Description: 


File: [client\Chat\functions.sqf at line 98](../../../Src/client/Chat/functions.sqf#L98)
## chatshowhistory

Type: function

Description: 


File: [client\Chat\functions.sqf at line 117](../../../Src/client/Chat/functions.sqf#L117)
## chatPrintSmart

Type: function

Description: 
- Param: _txt
- Param: _ch
- Param: _src
- Param: _targ

File: [client\Chat\functions.sqf at line 150](../../../Src/client/Chat/functions.sqf#L150)
## chat_resetFadeTimer

Type: function

Description: 


File: [client\Chat\functions.sqf at line 156](../../../Src/client/Chat/functions.sqf#L156)
## chat_restoreVisible

Type: function

Description: 
- Param: _now

File: [client\Chat\functions.sqf at line 161](../../../Src/client/Chat/functions.sqf#L161)
## chat_onUpdate

Type: function

Description: 


File: [client\Chat\functions.sqf at line 175](../../../Src/client/Chat/functions.sqf#L175)
## chat_applyColorTheme

Type: function

Description: 


File: [client\Chat\functions.sqf at line 195](../../../Src/client/Chat/functions.sqf#L195)
# helpers.hpp

## ENM_TIPS_ERROR

Type: constant

Description: 


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
File: [client\Chat\helpers.hpp at line 6](../../../Src/client/Chat/helpers.hpp#L6)
## getTextField

Type: constant

Description: 


Replaced value:
```sqf
(call chatGettextwidget)
```
File: [client\Chat\helpers.hpp at line 15](../../../Src/client/Chat/helpers.hpp#L15)
## getBackground

Type: constant

Description: 


Replaced value:
```sqf
(call chatgetbackgroundwidget)
```
File: [client\Chat\helpers.hpp at line 16](../../../Src/client/Chat/helpers.hpp#L16)
## getHistoryField

Type: constant

Description: 


Replaced value:
```sqf
(chat_widgets select 3)
```
File: [client\Chat\helpers.hpp at line 17](../../../Src/client/Chat/helpers.hpp#L17)
## CHAT_HIDE_CHECK_UPDATE

Type: constant

Description: 


Replaced value:
```sqf
0.1
```
File: [client\Chat\helpers.hpp at line 19](../../../Src/client/Chat/helpers.hpp#L19)
## CHAT_ONE_STEP_FADE_SIMULATION

Type: constant

Description: 


Replaced value:
```sqf
0.09
```
File: [client\Chat\helpers.hpp at line 20](../../../Src/client/Chat/helpers.hpp#L20)
# nativeChatHandler.sqf

## chat_native_checktimeDelay

Type: constant

Description: need initialization after client connect


Replaced value:
```sqf
60
```
File: [client\Chat\nativeChatHandler.sqf at line 25](../../../Src/client/Chat/nativeChatHandler.sqf#L25)
## chat_native_handleDebug

Type: function

Description: 


File: [client\Chat\nativeChatHandler.sqf at line 57](../../../Src/client/Chat/nativeChatHandler.sqf#L57)
