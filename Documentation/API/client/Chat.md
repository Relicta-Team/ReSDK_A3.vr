# chat_init.sqf

## chat_errorMessagePrefixes

Type: Variable

Description: 


Initial value:
```sqf
["Неа.","Никак!","Не получится.","Нет.","Отставить!","Не могу...",...
```
File: [client\Chat\chat_init.sqf at line 48](../../../Src/client/Chat/chat_init.sqf#L48)
# Chat_onScreen.sqf

## mlp(v)

Type: constant

Description: 
- Param: v

Replaced value:
```sqf
'v'
```
File: [client\Chat\Chat_onScreen.sqf at line 11](../../../Src/client/Chat/Chat_onScreen.sqf#L11)
## chatos_mobSelections

Type: Variable

Description: 


Initial value:
```sqf
[...
```
File: [client\Chat\Chat_onScreen.sqf at line 15](../../../Src/client/Chat/Chat_onScreen.sqf#L15)
## chatos_guiCtg

Type: Variable

Description: 


Initial value:
```sqf
[widgetNull]
```
File: [client\Chat\Chat_onScreen.sqf at line 41](../../../Src/client/Chat/Chat_onScreen.sqf#L41)
## chatos_renderedWidgets

Type: Variable

Description: 


Initial value:
```sqf
createHashMap
```
File: [client\Chat\Chat_onScreen.sqf at line 44](../../../Src/client/Chat/Chat_onScreen.sqf#L44)
## chatos_renderedWidgetsPrint

Type: Variable

Description: 


Initial value:
```sqf
createHashMap
```
File: [client\Chat\Chat_onScreen.sqf at line 46](../../../Src/client/Chat/Chat_onScreen.sqf#L46)
## chatos_postMessageVisibleDelay

Type: Variable

Description: 


Initial value:
```sqf
2.5
```
File: [client\Chat\Chat_onScreen.sqf at line 49](../../../Src/client/Chat/Chat_onScreen.sqf#L49)
## chatos_list_blobMobs

Type: Variable

Description: 


Initial value:
```sqf
[]
```
File: [client\Chat\Chat_onScreen.sqf at line 254](../../../Src/client/Chat/Chat_onScreen.sqf#L254)
## chatos_onUpdate

Type: function

Description: 


File: [client\Chat\Chat_onScreen.sqf at line 52](../../../Src/client/Chat/Chat_onScreen.sqf#L52)
## chatos_inlinecode

Type: function

Description: 
- Param: _xpos
- Param: _ypos

File: [client\Chat\Chat_onScreen.sqf at line 136](../../../Src/client/Chat/Chat_onScreen.sqf#L136)
## chatos_getMobMessages

Type: function

Description: 


File: [client\Chat\Chat_onScreen.sqf at line 163](../../../Src/client/Chat/Chat_onScreen.sqf#L163)
## chatos_getTimeText

Type: function

Description: 
- Param: _mob
- Param: _text

File: [client\Chat\Chat_onScreen.sqf at line 168](../../../Src/client/Chat/Chat_onScreen.sqf#L168)
## chatos_canSeeObject

Type: function

Description: 
- Param: _obj

File: [client\Chat\Chat_onScreen.sqf at line 182](../../../Src/client/Chat/Chat_onScreen.sqf#L182)
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

File: [client\Chat\Chat_onScreen.sqf at line 256](../../../Src/client/Chat/Chat_onScreen.sqf#L256)
## chatos_onUpdateBlobTask

Type: function

Description: 
- Param: _nextcall
- Param: _speed
- Param: _thisArgs
- Param: _deleteAfter
- Param: _startTime

File: [client\Chat\Chat_onScreen.sqf at line 276](../../../Src/client/Chat/Chat_onScreen.sqf#L276)
## chatos_onUpdatePrintingSay

Type: function

Description: 


File: [client\Chat\Chat_onScreen.sqf at line 311](../../../Src/client/Chat/Chat_onScreen.sqf#L311)
## chatos_isMobPrinting

Type: function

Description: 


File: [client\Chat\Chat_onScreen.sqf at line 340](../../../Src/client/Chat/Chat_onScreen.sqf#L340)
## chatos_event_onSpeak

Type: function

Description: 
- Param: _mob
- Param: _isspeaking

File: [client\Chat\Chat_onScreen.sqf at line 351](../../../Src/client/Chat/Chat_onScreen.sqf#L351)
## chatos_onSay

Type: function

Description: 


File: [client\Chat\Chat_onScreen.sqf at line 360](../../../Src/client/Chat/Chat_onScreen.sqf#L360)
# functions.sqf

## HIST_SIZE_H

Type: constant

Description: 


Replaced value:
```sqf
70
```
File: [client\Chat\functions.sqf at line 195](../../../Src/client/Chat/functions.sqf#L195)
## chatGettextwidget

Type: function

Description: 


File: [client\Chat\functions.sqf at line 15](../../../Src/client/Chat/functions.sqf#L15)
## chatgetbackgroundwidget

Type: function

Description: 


File: [client\Chat\functions.sqf at line 19](../../../Src/client/Chat/functions.sqf#L19)
## chatgetwidget

Type: function

Description: 


File: [client\Chat\functions.sqf at line 23](../../../Src/client/Chat/functions.sqf#L23)
## chatgethistorywidget

Type: function

Description: 


File: [client\Chat\functions.sqf at line 26](../../../Src/client/Chat/functions.sqf#L26)
## chat_getAllText

Type: function

Description: 


File: [client\Chat\functions.sqf at line 30](../../../Src/client/Chat/functions.sqf#L30)
## chat_syncsize

Type: function

Description: 
- Param: _x
- Param: _y
- Param: _w
- Param: _h

File: [client\Chat\functions.sqf at line 34](../../../Src/client/Chat/functions.sqf#L34)
## chatprint

Type: function

Description: 
- Param: _text
- Param: _type (optional, default "default")

File: [client\Chat\functions.sqf at line 52](../../../Src/client/Chat/functions.sqf#L52)
## chat_clearBuffer

Type: function

Description: 
- Param: _mes

File: [client\Chat\functions.sqf at line 160](../../../Src/client/Chat/functions.sqf#L160)
## chat_onRenderLobby

Type: function

Description: 


File: [client\Chat\functions.sqf at line 168](../../../Src/client/Chat/functions.sqf#L168)
## chatshowhistory

Type: function

Description: 


File: [client\Chat\functions.sqf at line 188](../../../Src/client/Chat/functions.sqf#L188)
## chat_resetFadeTimer

Type: function

Description: 


File: [client\Chat\functions.sqf at line 227](../../../Src/client/Chat/functions.sqf#L227)
## chat_restoreVisible

Type: function

Description: 
- Param: _now

File: [client\Chat\functions.sqf at line 234](../../../Src/client/Chat/functions.sqf#L234)
## chat_onUpdate

Type: function

Description: 


File: [client\Chat\functions.sqf at line 250](../../../Src/client/Chat/functions.sqf#L250)
## chat_applyColorTheme

Type: function

Description: 


File: [client\Chat\functions.sqf at line 272](../../../Src/client/Chat/functions.sqf#L272)
# helpers.hpp

## CHAT_HIDE_CHECK_UPDATE

Type: constant

Description: 


Replaced value:
```sqf
0.1
```
File: [client\Chat\helpers.hpp at line 8](../../../Src/client/Chat/helpers.hpp#L8)
## CHAT_ONE_STEP_FADE_SIMULATION

Type: constant

Description: 


Replaced value:
```sqf
0.09
```
File: [client\Chat\helpers.hpp at line 10](../../../Src/client/Chat/helpers.hpp#L10)
