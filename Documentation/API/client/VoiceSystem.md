# VoiceSystem_Control.sqf

## voice_changer_border_size_x

Type: constant

Description: 


Replaced value:
```sqf
1
```
File: [client\VoiceSystem\VoiceSystem_Control.sqf at line 23](../../../Src/client/VoiceSystem/VoiceSystem_Control.sqf#L23)
## voice_changer_border_size_y

Type: constant

Description: 


Replaced value:
```sqf
15
```
File: [client\VoiceSystem\VoiceSystem_Control.sqf at line 25](../../../Src/client/VoiceSystem/VoiceSystem_Control.sqf#L25)
## voice_changer_size_h

Type: constant

Description: 


Replaced value:
```sqf
7
```
File: [client\VoiceSystem\VoiceSystem_Control.sqf at line 28](../../../Src/client/VoiceSystem/VoiceSystem_Control.sqf#L28)
## voice_changer_size_w

Type: constant

Description: 


Replaced value:
```sqf
20
```
File: [client\VoiceSystem\VoiceSystem_Control.sqf at line 30](../../../Src/client/VoiceSystem/VoiceSystem_Control.sqf#L30)
## voice_changer_bias_x

Type: constant

Description: 


Replaced value:
```sqf
1
```
File: [client\VoiceSystem\VoiceSystem_Control.sqf at line 33](../../../Src/client/VoiceSystem/VoiceSystem_Control.sqf#L33)
## voice_changer_bias_y

Type: constant

Description: 


Replaced value:
```sqf
1
```
File: [client\VoiceSystem\VoiceSystem_Control.sqf at line 35](../../../Src/client/VoiceSystem/VoiceSystem_Control.sqf#L35)
## vec4(a,b,c,d)

Type: constant

Description: 
- Param: a
- Param: b
- Param: c
- Param: d

Replaced value:
```sqf
[a,b,c,d]
```
File: [client\VoiceSystem\VoiceSystem_Control.sqf at line 38](../../../Src/client/VoiceSystem/VoiceSystem_Control.sqf#L38)
## vs_getWidgetText

Type: constant

Description: 


Replaced value:
```sqf
(vs_voiceVolumeWidgets select 0)
```
File: [client\VoiceSystem\VoiceSystem_Control.sqf at line 44](../../../Src/client/VoiceSystem/VoiceSystem_Control.sqf#L44)
## vs_getWidgetProgress

Type: constant

Description: 


Replaced value:
```sqf
(vs_voiceVolumeWidgets select 1)
```
File: [client\VoiceSystem\VoiceSystem_Control.sqf at line 46](../../../Src/client/VoiceSystem/VoiceSystem_Control.sqf#L46)
## vs_getWidgetGroup

Type: constant

Description: 


Replaced value:
```sqf
(vs_voiceVolumeWidgets select 3)
```
File: [client\VoiceSystem\VoiceSystem_Control.sqf at line 48](../../../Src/client/VoiceSystem/VoiceSystem_Control.sqf#L48)
## vs_voiceDelayFadein

Type: constant

Description: 


Replaced value:
```sqf
4
```
File: [client\VoiceSystem\VoiceSystem_Control.sqf at line 52](../../../Src/client/VoiceSystem/VoiceSystem_Control.sqf#L52)
## vs_voiceAmountFade

Type: constant

Description: 


Replaced value:
```sqf
0.025
```
File: [client\VoiceSystem\VoiceSystem_Control.sqf at line 56](../../../Src/client/VoiceSystem/VoiceSystem_Control.sqf#L56)
## vs_voiceVolumeWidgets

Type: Variable

Description: _bg3 ctrlEnable true;


Initial value:
```sqf
[]
```
File: [client\VoiceSystem\VoiceSystem_Control.sqf at line 41](../../../Src/client/VoiceSystem/VoiceSystem_Control.sqf#L41)
## vs_curVoiceMode

Type: Variable

Description: 


Initial value:
```sqf
0
```
File: [client\VoiceSystem\VoiceSystem_Control.sqf at line 59](../../../Src/client/VoiceSystem/VoiceSystem_Control.sqf#L59)
## vs_canFadeVoiceVolumeWidget

Type: Variable

Description: 


Initial value:
```sqf
true
```
File: [client\VoiceSystem\VoiceSystem_Control.sqf at line 62](../../../Src/client/VoiceSystem/VoiceSystem_Control.sqf#L62)
## vs_voiceVolume_lastUpdate

Type: Variable

Description: 


Initial value:
```sqf
0
```
File: [client\VoiceSystem\VoiceSystem_Control.sqf at line 65](../../../Src/client/VoiceSystem/VoiceSystem_Control.sqf#L65)
## vs_voiceVolumeList

Type: Variable

Description: 


Initial value:
```sqf
[...
```
File: [client\VoiceSystem\VoiceSystem_Control.sqf at line 68](../../../Src/client/VoiceSystem/VoiceSystem_Control.sqf#L68)
## vs_getMaxVolume

Type: function

Description: 


File: [client\VoiceSystem\VoiceSystem_Control.sqf at line 77](../../../Src/client/VoiceSystem/VoiceSystem_Control.sqf#L77)
## vs_changeVoiceVolume

Type: function

Description: 
- Param: _mode

File: [client\VoiceSystem\VoiceSystem_Control.sqf at line 83](../../../Src/client/VoiceSystem/VoiceSystem_Control.sqf#L83)
## vs_voiceVolumeOnUpdate

Type: function

Description: 


File: [client\VoiceSystem\VoiceSystem_Control.sqf at line 111](../../../Src/client/VoiceSystem/VoiceSystem_Control.sqf#L111)
## vs_initChangeVoiceCtrl

Type: function

Description: 


File: [client\VoiceSystem\VoiceSystem_Control.sqf at line 135](../../../Src/client/VoiceSystem/VoiceSystem_Control.sqf#L135)
# VoiceSystem_init.sqf

## USE_REVOICE_BACKEND

Type: constant

Description: 


Replaced value:
```sqf

```
File: [client\VoiceSystem\VoiceSystem_init.sqf at line 6](../../../Src/client/VoiceSystem/VoiceSystem_init.sqf#L6)
## VOICE_USE_NEW_ALGORITM_VOICE_INTERSECTION

Type: constant

Description: 


Replaced value:
```sqf

```
File: [client\VoiceSystem\VoiceSystem_init.sqf at line 16](../../../Src/client/VoiceSystem/VoiceSystem_init.sqf#L16)
## vs_useReVoice

Type: Variable

> Exists if **USE_REVOICE_BACKEND** defined

Description: 


Initial value:
```sqf
true
```
File: [client\VoiceSystem\VoiceSystem_init.sqf at line 19](../../../Src/client/VoiceSystem/VoiceSystem_init.sqf#L19)
## vs_useReVoice

Type: Variable

Description: 


Initial value:
```sqf
false
```
File: [client\VoiceSystem\VoiceSystem_init.sqf at line 21](../../../Src/client/VoiceSystem/VoiceSystem_init.sqf#L21)
# VoiceSystem_publicInterface.sqf

## VOICE_DISABLE_IN_SINGLEPLAYERMODE

Type: constant

Description: 


Replaced value:
```sqf

```
File: [client\VoiceSystem\VoiceSystem_publicInterface.sqf at line 17](../../../Src/client/VoiceSystem/VoiceSystem_publicInterface.sqf#L17)
## VOICE_DEBUG

Type: constant

Description: 


Replaced value:
```sqf

```
File: [client\VoiceSystem\VoiceSystem_publicInterface.sqf at line 21](../../../Src/client/VoiceSystem/VoiceSystem_publicInterface.sqf#L21)
## VS_ERROR_CONNECTION_TIMEOUT

Type: constant

Description: 


Replaced value:
```sqf
30
```
File: [client\VoiceSystem\VoiceSystem_publicInterface.sqf at line 25](../../../Src/client/VoiceSystem/VoiceSystem_publicInterface.sqf#L25)
## VS_ERROR_NOTINGAMECHANNEL_TIMEOUT

Type: constant

Description: 


Replaced value:
```sqf
15
```
File: [client\VoiceSystem\VoiceSystem_publicInterface.sqf at line 27](../../../Src/client/VoiceSystem/VoiceSystem_publicInterface.sqf#L27)
## VS_INTERCOM_MAXDISTANCE_TRANSMITH

Type: constant

Description: 


Replaced value:
```sqf
1.25
```
File: [client\VoiceSystem\VoiceSystem_publicInterface.sqf at line 30](../../../Src/client/VoiceSystem/VoiceSystem_publicInterface.sqf#L30)
## itermes(me,data)

Type: constant

Description: 
- Param: me
- Param: data

Replaced value:
```sqf

```
File: [client\VoiceSystem\VoiceSystem_publicInterface.sqf at line 691](../../../Src/client/VoiceSystem/VoiceSystem_publicInterface.sqf#L691)
## getRadioVar(obj,var)

Type: constant

Description: 
- Param: obj
- Param: var

Replaced value:
```sqf
(obj getvariable '__radio_##var')
```
File: [client\VoiceSystem\VoiceSystem_publicInterface.sqf at line 893](../../../Src/client/VoiceSystem/VoiceSystem_publicInterface.sqf#L893)
## vs_canProcess

Type: Variable

Description: 


Initial value:
```sqf
true //при выключенном режиме процессинг радио не будет происходить
```
File: [client\VoiceSystem\VoiceSystem_publicInterface.sqf at line 33](../../../Src/client/VoiceSystem/VoiceSystem_publicInterface.sqf#L33)
## vs_intercom_maxdist

Type: Variable

Description: 


Initial value:
```sqf
VS_INTERCOM_MAXDISTANCE_TRANSMITH
```
File: [client\VoiceSystem\VoiceSystem_publicInterface.sqf at line 36](../../../Src/client/VoiceSystem/VoiceSystem_publicInterface.sqf#L36)
## vs_nickName

Type: Variable

Description: 


Initial value:
```sqf
"No_player"
```
File: [client\VoiceSystem\VoiceSystem_publicInterface.sqf at line 39](../../../Src/client/VoiceSystem/VoiceSystem_publicInterface.sqf#L39)
## vs_isEnabledText

Type: Variable

Description: 


Initial value:
```sqf
false
```
File: [client\VoiceSystem\VoiceSystem_publicInterface.sqf at line 42](../../../Src/client/VoiceSystem/VoiceSystem_publicInterface.sqf#L42)
## vs_underwaterRadioDepth

Type: Variable

Description: 


Initial value:
```sqf
-3
```
File: [client\VoiceSystem\VoiceSystem_publicInterface.sqf at line 45](../../../Src/client/VoiceSystem/VoiceSystem_publicInterface.sqf#L45)
## vs_dd_volume_level

Type: Variable

Description: 


Initial value:
```sqf
7
```
File: [client\VoiceSystem\VoiceSystem_publicInterface.sqf at line 52](../../../Src/client/VoiceSystem/VoiceSystem_publicInterface.sqf#L52)
## vs_init

Type: function

Description: 


File: [client\VoiceSystem\VoiceSystem_publicInterface.sqf at line 94](../../../Src/client/VoiceSystem/VoiceSystem_publicInterface.sqf#L94)
## vs_sendVersionInfo

Type: function

Description: Sends information about the current TFAR version.


File: [client\VoiceSystem\VoiceSystem_publicInterface.sqf at line 133](../../../Src/client/VoiceSystem/VoiceSystem_publicInterface.sqf#L133)
## vs_isPluginEnabled

Type: function

Description: 


File: [client\VoiceSystem\VoiceSystem_publicInterface.sqf at line 139](../../../Src/client/VoiceSystem/VoiceSystem_publicInterface.sqf#L139)
## vs_getCurrentTSChannel

Type: function

Description: Получает строковое название канала


File: [client\VoiceSystem\VoiceSystem_publicInterface.sqf at line 144](../../../Src/client/VoiceSystem/VoiceSystem_publicInterface.sqf#L144)
## vs_isIngameTSChannel

Type: function

Description: 


File: [client\VoiceSystem\VoiceSystem_publicInterface.sqf at line 148](../../../Src/client/VoiceSystem/VoiceSystem_publicInterface.sqf#L148)
## vs_getCurrentTSServer

Type: function

Description: получает строковое название сервера


File: [client\VoiceSystem\VoiceSystem_publicInterface.sqf at line 153](../../../Src/client/VoiceSystem/VoiceSystem_publicInterface.sqf#L153)
## vs_isSpeaking

Type: function

Description: Говорит ли юнит в данный момент


File: [client\VoiceSystem\VoiceSystem_publicInterface.sqf at line 158](../../../Src/client/VoiceSystem/VoiceSystem_publicInterface.sqf#L158)
## vs_onProcessPlayerPosition

Type: function

Description: Process some player positions on each call and sends it to the plugin.


File: [client\VoiceSystem\VoiceSystem_publicInterface.sqf at line 163](../../../Src/client/VoiceSystem/VoiceSystem_publicInterface.sqf#L163)
## vs_startHandleProcessPlayerPos

Type: function

Description: 


File: [client\VoiceSystem\VoiceSystem_publicInterface.sqf at line 289](../../../Src/client/VoiceSystem/VoiceSystem_publicInterface.sqf#L289)
## vs_stopHandleProcessPlayerPos

Type: function

Description: останавливает процессинг


File: [client\VoiceSystem\VoiceSystem_publicInterface.sqf at line 299](../../../Src/client/VoiceSystem/VoiceSystem_publicInterface.sqf#L299)
## vs_sendFrequencyInfo

Type: function

Description: отсылает частоты раций у игрока в плагин


File: [client\VoiceSystem\VoiceSystem_publicInterface.sqf at line 307](../../../Src/client/VoiceSystem/VoiceSystem_publicInterface.sqf#L307)
## vs_calculateInteraction

Type: function

Description: 
- Param: _curVoice
- Param: _unit

File: [client\VoiceSystem\VoiceSystem_publicInterface.sqf at line 408](../../../Src/client/VoiceSystem/VoiceSystem_publicInterface.sqf#L408)
## vs_processSpeakerRadios

Type: function

Description: Обрабатывает все радио спикерные


File: [client\VoiceSystem\VoiceSystem_publicInterface.sqf at line 413](../../../Src/client/VoiceSystem/VoiceSystem_publicInterface.sqf#L413)
## vs_sendPlayerInfo

Type: function

Description: Notifies the plugin about a player


File: [client\VoiceSystem\VoiceSystem_publicInterface.sqf at line 508](../../../Src/client/VoiceSystem/VoiceSystem_publicInterface.sqf#L508)
## vs_preparePositionCoordinates

Type: function

Description: Prepares the position coordinates of the passed unit.


File: [client\VoiceSystem\VoiceSystem_publicInterface.sqf at line 571](../../../Src/client/VoiceSystem/VoiceSystem_publicInterface.sqf#L571)
## vs_processSpeakingLangs

Type: function

Description: Калькулирует понимание речи персонажа
- Param: _unit
- Param: _curVol

File: [client\VoiceSystem\VoiceSystem_publicInterface.sqf at line 655](../../../Src/client/VoiceSystem/VoiceSystem_publicInterface.sqf#L655)
## vs_calcVoiceIntersection

Type: function

Description: Просчитывает гашение звука от препятствий
- Param: _unit
- Param: _curVol

File: [client\VoiceSystem\VoiceSystem_publicInterface.sqf at line 683](../../../Src/client/VoiceSystem/VoiceSystem_publicInterface.sqf#L683)
## vs_internal_getObjBBXData

Type: function

Description: возвращает высоту объекта и площадь
- Param: _obj

File: [client\VoiceSystem\VoiceSystem_publicInterface.sqf at line 802](../../../Src/client/VoiceSystem/VoiceSystem_publicInterface.sqf#L802)
## vs_debug_voiceIntersection

Type: function

> Exists if **DEBUG** defined

Description: 
- Param: _unit
- Param: _posesASL

File: [client\VoiceSystem\VoiceSystem_publicInterface.sqf at line 816](../../../Src/client/VoiceSystem/VoiceSystem_publicInterface.sqf#L816)
## vs_getNearInGameMobs

Type: function

Description: Получает ближайших мобов


File: [client\VoiceSystem\VoiceSystem_publicInterface.sqf at line 837](../../../Src/client/VoiceSystem/VoiceSystem_publicInterface.sqf#L837)
## vs_releaseAllTangents

Type: function

Description: вырубает локальному плееру все рации


File: [client\VoiceSystem\VoiceSystem_publicInterface.sqf at line 887](../../../Src/client/VoiceSystem/VoiceSystem_publicInterface.sqf#L887)
# VoiceSystem_Transmith.sqf

## VS_TRANSMITHINFO_DEFAULT

Type: constant

Description: 


Replaced value:
```sqf
[objNUll,["","",""]]
```
File: [client\VoiceSystem\VoiceSystem_Transmith.sqf at line 75](../../../Src/client/VoiceSystem/VoiceSystem_Transmith.sqf#L75)
## vs_tangent_pressed

Type: Variable

Description: 


Initial value:
```sqf
false
```
File: [client\VoiceSystem\VoiceSystem_Transmith.sqf at line 14](../../../Src/client/VoiceSystem/VoiceSystem_Transmith.sqf#L14)
## vs_transmithDistance

Type: Variable

Description: 


Initial value:
```sqf
1000
```
File: [client\VoiceSystem\VoiceSystem_Transmith.sqf at line 17](../../../Src/client/VoiceSystem/VoiceSystem_Transmith.sqf#L17)
## vs_curTransmithType

Type: Variable

Description: 


Initial value:
```sqf
0 //режим передачи
```
File: [client\VoiceSystem\VoiceSystem_Transmith.sqf at line 20](../../../Src/client/VoiceSystem/VoiceSystem_Transmith.sqf#L20)
## vs_transmithTypes

Type: Variable

Description: 


Initial value:
```sqf
["digital","digital_lr","airborne"]
```
File: [client\VoiceSystem\VoiceSystem_Transmith.sqf at line 22](../../../Src/client/VoiceSystem/VoiceSystem_Transmith.sqf#L22)
## vs_hasTransmithProcess

Type: Variable

Description: 


Initial value:
```sqf
false
```
File: [client\VoiceSystem\VoiceSystem_Transmith.sqf at line 77](../../../Src/client/VoiceSystem/VoiceSystem_Transmith.sqf#L77)
## vs_lastTransmithInfo

Type: Variable

Description: 


Initial value:
```sqf
VS_TRANSMITHINFO_DEFAULT //object and radiocode
```
File: [client\VoiceSystem\VoiceSystem_Transmith.sqf at line 79](../../../Src/client/VoiceSystem/VoiceSystem_Transmith.sqf#L79)
## vs_processingRadiosList

Type: Variable

Description: 


Initial value:
```sqf
[] //какие радио слышит клиент из ушей
```
File: [client\VoiceSystem\VoiceSystem_Transmith.sqf at line 145](../../../Src/client/VoiceSystem/VoiceSystem_Transmith.sqf#L145)
## vs_startTransmith

Type: function

Description: 
- Param: _freqAndCode
- Param: _dist (optional, default vs_transmithDistance)
- Param: _curT (optional, default "digital")

File: [client\VoiceSystem\VoiceSystem_Transmith.sqf at line 26](../../../Src/client/VoiceSystem/VoiceSystem_Transmith.sqf#L26)
## vs_stopTransmith

Type: function

Description: 
- Param: _freqAndCode
- Param: _dist (optional, default vs_transmithDistance)
- Param: _curT (optional, default "digital")

File: [client\VoiceSystem\VoiceSystem_Transmith.sqf at line 53](../../../Src/client/VoiceSystem/VoiceSystem_Transmith.sqf#L53)
## vs_doStopTransmith

Type: function

Description: 


File: [client\VoiceSystem\VoiceSystem_Transmith.sqf at line 83](../../../Src/client/VoiceSystem/VoiceSystem_Transmith.sqf#L83)
## vs_handleTransmith

Type: function

Description: 
- Param: _mode

File: [client\VoiceSystem\VoiceSystem_Transmith.sqf at line 94](../../../Src/client/VoiceSystem/VoiceSystem_Transmith.sqf#L94)
## vs_canUseIntercomObject

Type: function

Description: 
- Param: _obj
- Param: _pos

File: [client\VoiceSystem\VoiceSystem_Transmith.sqf at line 125](../../../Src/client/VoiceSystem/VoiceSystem_Transmith.sqf#L125)
## vs_handleProcessedTransmith

Type: function

Description: 
- Param: _obj
- Param: _tData

File: [client\VoiceSystem\VoiceSystem_Transmith.sqf at line 132](../../../Src/client/VoiceSystem/VoiceSystem_Transmith.sqf#L132)
## vs_addProcessingRadio

Type: function

Description: 
- Param: _obj
- Param: _rParams

File: [client\VoiceSystem\VoiceSystem_Transmith.sqf at line 150](../../../Src/client/VoiceSystem/VoiceSystem_Transmith.sqf#L150)
## vs_removeProcessingRadio

Type: function

Description: 
- Param: _obj

File: [client\VoiceSystem\VoiceSystem_Transmith.sqf at line 176](../../../Src/client/VoiceSystem/VoiceSystem_Transmith.sqf#L176)
## vs_clearProcessingRadio

Type: function

Description: 


File: [client\VoiceSystem\VoiceSystem_Transmith.sqf at line 195](../../../Src/client/VoiceSystem/VoiceSystem_Transmith.sqf#L195)
## vs_onProcessingRadios

Type: function

Description: 


File: [client\VoiceSystem\VoiceSystem_Transmith.sqf at line 199](../../../Src/client/VoiceSystem/VoiceSystem_Transmith.sqf#L199)
# VoiceSystem_uncategorized.sqf

## vs_internalCalcTerrainInterception

Type: function

Description: 
- Param: _actor

File: [client\VoiceSystem\VoiceSystem_uncategorized.sqf at line 52](../../../Src/client/VoiceSystem/VoiceSystem_uncategorized.sqf#L52)
## TFAR_fnc_canSpeak

Type: function

Description: 


File: [client\VoiceSystem\VoiceSystem_uncategorized.sqf at line 54](../../../Src/client/VoiceSystem/VoiceSystem_uncategorized.sqf#L54)
## TFAR_fnc_canUseLRRadio

Type: function

Description: 


File: [client\VoiceSystem\VoiceSystem_uncategorized.sqf at line 87](../../../Src/client/VoiceSystem/VoiceSystem_uncategorized.sqf#L87)
## TFAR_fnc_canUseSWRadio

Type: function

Description: 


File: [client\VoiceSystem\VoiceSystem_uncategorized.sqf at line 129](../../../Src/client/VoiceSystem/VoiceSystem_uncategorized.sqf#L129)
## TFAR_fnc_currentDirection

Type: function

Description: 


File: [client\VoiceSystem\VoiceSystem_uncategorized.sqf at line 171](../../../Src/client/VoiceSystem/VoiceSystem_uncategorized.sqf#L171)
## TFAR_fnc_currentUnit

Type: function

Description: 


File: [client\VoiceSystem\VoiceSystem_uncategorized.sqf at line 215](../../../Src/client/VoiceSystem/VoiceSystem_uncategorized.sqf#L215)
## TFAR_fnc_defaultPositionCoordinates

Type: function

Description: 


File: [client\VoiceSystem\VoiceSystem_uncategorized.sqf at line 239](../../../Src/client/VoiceSystem/VoiceSystem_uncategorized.sqf#L239)
## TFAR_fnc_eyeDepth

Type: function

Description: 


File: [client\VoiceSystem\VoiceSystem_uncategorized.sqf at line 288](../../../Src/client/VoiceSystem/VoiceSystem_uncategorized.sqf#L288)
## TFAR_fnc_getNearPlayers

Type: function

Description: 


File: [client\VoiceSystem\VoiceSystem_uncategorized.sqf at line 292](../../../Src/client/VoiceSystem/VoiceSystem_uncategorized.sqf#L292)
# VoiceSystem_WorldRadioComponent.sqf

## _eyePosAgl

Type: constant

Description: 


Replaced value:
```sqf
_ep
```
File: [client\VoiceSystem\VoiceSystem_WorldRadioComponent.sqf at line 99](../../../Src/client/VoiceSystem/VoiceSystem_WorldRadioComponent.sqf#L99)
## _currentVolume

Type: constant

Description: 


Replaced value:
```sqf
_cv
```
File: [client\VoiceSystem\VoiceSystem_WorldRadioComponent.sqf at line 101](../../../Src/client/VoiceSystem/VoiceSystem_WorldRadioComponent.sqf#L101)
## vs_allWorldRadios

Type: Variable

Description: 


Initial value:
```sqf
[]
```
File: [client\VoiceSystem\VoiceSystem_WorldRadioComponent.sqf at line 11](../../../Src/client/VoiceSystem/VoiceSystem_WorldRadioComponent.sqf#L11)
## vs_loadWorldRadio

Type: function

Description: 
- Param: _obj
- Param: _radioData
- Param: _ptr
- Param: _isHeadpones (optional, default false)

File: [client\VoiceSystem\VoiceSystem_WorldRadioComponent.sqf at line 15](../../../Src/client/VoiceSystem/VoiceSystem_WorldRadioComponent.sqf#L15)
## vs_unloadWorldRadio

Type: function

Description: 
- Param: _obj

File: [client\VoiceSystem\VoiceSystem_WorldRadioComponent.sqf at line 56](../../../Src/client/VoiceSystem/VoiceSystem_WorldRadioComponent.sqf#L56)
## vs_isWorldRadioObject

Type: function

Description: 


File: [client\VoiceSystem\VoiceSystem_WorldRadioComponent.sqf at line 93](../../../Src/client/VoiceSystem/VoiceSystem_WorldRadioComponent.sqf#L93)
## vs_processWorldRadios

Type: function

Description: 


File: [client\VoiceSystem\VoiceSystem_WorldRadioComponent.sqf at line 97](../../../Src/client/VoiceSystem/VoiceSystem_WorldRadioComponent.sqf#L97)
## vs_calcSpeakerIntersection

Type: function

Description: 
- Param: _obj
- Param: _curVol

File: [client\VoiceSystem\VoiceSystem_WorldRadioComponent.sqf at line 135](../../../Src/client/VoiceSystem/VoiceSystem_WorldRadioComponent.sqf#L135)
# API.sqf

## apiCmd

Type: constant

Description: usage: apiCmd ["test",[arg1,arg2]]


Replaced value:
```sqf
"revoicer" callExtension 
```
File: [client\VoiceSystem\ReVoice\API.sqf at line 7](../../../Src/client/VoiceSystem/ReVoice/API.sqf#L7)
## apiRequest(p)

Type: constant

Description: 
- Param: p

Replaced value:
```sqf
("revoicer" callExtension (p))
```
File: [client\VoiceSystem\ReVoice\API.sqf at line 8](../../../Src/client/VoiceSystem/ReVoice/API.sqf#L8)
## revoice_debug_only(debug_expr)

Type: constant

> Exists if **REDITOR_VOICE_DEBUG** defined

Description: 
- Param: debug_expr

Replaced value:
```sqf
debug_expr;
```
File: [client\VoiceSystem\ReVoice\API.sqf at line 11](../../../Src/client/VoiceSystem/ReVoice/API.sqf#L11)
## REDITOR_VOICE_DEBUG_RENDER

Type: constant

> Exists if **REDITOR_VOICE_DEBUG** defined

Description: 


Replaced value:
```sqf

```
File: [client\VoiceSystem\ReVoice\API.sqf at line 12](../../../Src/client/VoiceSystem/ReVoice/API.sqf#L12)
## revoice_debug_only(debug_expr)

Type: constant

> Exists if **REDITOR_VOICE_DEBUG** not defined

Description: 
- Param: debug_expr

Replaced value:
```sqf

```
File: [client\VoiceSystem\ReVoice\API.sqf at line 14](../../../Src/client/VoiceSystem/ReVoice/API.sqf#L14)
## VOICE_UPDATE_EFFECTS_DELAY

Type: constant

Description: частота вычисления позиционных эффектов. для лучшего импакта рекомендую в будущем снизить до 0.2


Replaced value:
```sqf
0.5
```
File: [client\VoiceSystem\ReVoice\API.sqf at line 20](../../../Src/client/VoiceSystem/ReVoice/API.sqf#L20)
## __postargs

Type: constant

Description: 


Replaced value:
```sqf
_ignore1,_mob,true,1,"VIEW","GEOM",true
```
File: [client\VoiceSystem\ReVoice\API.sqf at line 469](../../../Src/client/VoiceSystem/ReVoice/API.sqf#L469)
## vs_init

Type: function

Description: 


File: [client\VoiceSystem\ReVoice\API.sqf at line 22](../../../Src/client/VoiceSystem/ReVoice/API.sqf#L22)
## vs_isConnectedVoice

Type: function

Description: подключен ли к голосовому серверу


File: [client\VoiceSystem\ReVoice\API.sqf at line 62](../../../Src/client/VoiceSystem/ReVoice/API.sqf#L62)
## vs_connectVoice

Type: function

Description: 
- Param: _addr
- Param: _port
- Param: _user
- Param: _pass

File: [client\VoiceSystem\ReVoice\API.sqf at line 66](../../../Src/client/VoiceSystem/ReVoice/API.sqf#L66)
## vs_connectToVoiceSystem

Type: function

Description: вызывается когда клиент джоинится в игру


File: [client\VoiceSystem\ReVoice\API.sqf at line 72](../../../Src/client/VoiceSystem/ReVoice/API.sqf#L72)
## vs_disconnectVoice

Type: function

Description: низкоуровневая функция остановки войса. Вызывается при кике или отключении от сервера


File: [client\VoiceSystem\ReVoice\API.sqf at line 86](../../../Src/client/VoiceSystem/ReVoice/API.sqf#L86)
## vs_disconnectVoiceSystem

Type: function

Description: функция "правильного" завершения системы. Вызывается при выходе в лобби или перезагрузке войса


File: [client\VoiceSystem\ReVoice\API.sqf at line 91](../../../Src/client/VoiceSystem/ReVoice/API.sqf#L91)
## vs_isSpeaking

Type: function

Description: разговаривает ли


File: [client\VoiceSystem\ReVoice\API.sqf at line 100](../../../Src/client/VoiceSystem/ReVoice/API.sqf#L100)
## vs_getMicDevices

Type: function

Description: получить микрофоны


File: [client\VoiceSystem\ReVoice\API.sqf at line 105](../../../Src/client/VoiceSystem/ReVoice/API.sqf#L105)
## vs_setMicDevice

Type: function

Description: установить устройство записи
- Param: _id

File: [client\VoiceSystem\ReVoice\API.sqf at line 109](../../../Src/client/VoiceSystem/ReVoice/API.sqf#L109)
## vs_getPlaybackDevices

Type: function

Description: получить устройство воспроизведения


File: [client\VoiceSystem\ReVoice\API.sqf at line 114](../../../Src/client/VoiceSystem/ReVoice/API.sqf#L114)
## vs_setPlaybackDevice

Type: function

Description: установить устройство воспроизведения
- Param: _id

File: [client\VoiceSystem\ReVoice\API.sqf at line 118](../../../Src/client/VoiceSystem/ReVoice/API.sqf#L118)
## vs_getAllClients

Type: function

Description: 
- Param: _r
- Param: _rcode

File: [client\VoiceSystem\ReVoice\API.sqf at line 123](../../../Src/client/VoiceSystem/ReVoice/API.sqf#L123)
## vs_setMasterVoiceVolume

Type: function

Description: 
- Param: _vol

File: [client\VoiceSystem\ReVoice\API.sqf at line 132](../../../Src/client/VoiceSystem/ReVoice/API.sqf#L132)
## vs_startHandleProcessPlayerPos

Type: function

Description: 


File: [client\VoiceSystem\ReVoice\API.sqf at line 138](../../../Src/client/VoiceSystem/ReVoice/API.sqf#L138)
## vs_stopHandleProcessPlayerPos

Type: function

Description: 


File: [client\VoiceSystem\ReVoice\API.sqf at line 147](../../../Src/client/VoiceSystem/ReVoice/API.sqf#L147)
## vs_onProcessPlayerPosition

Type: function

Description: main system loop


File: [client\VoiceSystem\ReVoice\API.sqf at line 154](../../../Src/client/VoiceSystem/ReVoice/API.sqf#L154)
## vs_checkConnection

Type: function

Description: проверка подключения системы


File: [client\VoiceSystem\ReVoice\API.sqf at line 173](../../../Src/client/VoiceSystem/ReVoice/API.sqf#L173)
## vs_syncLocalPlayer

Type: function

Description: синхронизация позиции локального юзера


File: [client\VoiceSystem\ReVoice\API.sqf at line 193](../../../Src/client/VoiceSystem/ReVoice/API.sqf#L193)
## vs_debug_generateClients

Type: function

> Exists if **EDITOR** defined

Description: 


File: [client\VoiceSystem\ReVoice\API.sqf at line 216](../../../Src/client/VoiceSystem/ReVoice/API.sqf#L216)
## vs_syncRemotePlayers

Type: function

Description: 


File: [client\VoiceSystem\ReVoice\API.sqf at line 233](../../../Src/client/VoiceSystem/ReVoice/API.sqf#L233)
## vs_handleUserSpeakInternal

Type: function

Description: 
- Param: _mob
- Param: _state

File: [client\VoiceSystem\ReVoice\API.sqf at line 324](../../../Src/client/VoiceSystem/ReVoice/API.sqf#L324)
## vs_onUserSpeak

Type: function

Description: событие когда другой клиент говорит или перестает говорить
- Param: _mob
- Param: _isSpeaking

File: [client\VoiceSystem\ReVoice\API.sqf at line 341](../../../Src/client/VoiceSystem/ReVoice/API.sqf#L341)
## vs_handleSpeak

Type: function

Description: 
- Param: _mode

File: [client\VoiceSystem\ReVoice\API.sqf at line 350](../../../Src/client/VoiceSystem/ReVoice/API.sqf#L350)
## vs_speakReleaseAll

Type: function

Description: 


File: [client\VoiceSystem\ReVoice\API.sqf at line 362](../../../Src/client/VoiceSystem/ReVoice/API.sqf#L362)
## vs_setLocalPlayerVoiceDistance

Type: function

Description: 
- Param: _d

File: [client\VoiceSystem\ReVoice\API.sqf at line 366](../../../Src/client/VoiceSystem/ReVoice/API.sqf#L366)
## vs_initMob

Type: function

Description: иницилизация сущности
- Param: _mob
- Param: _nick

File: [client\VoiceSystem\ReVoice\API.sqf at line 372](../../../Src/client/VoiceSystem/ReVoice/API.sqf#L372)
## vs_setLowpassEffect

Type: function

Description: effects extension
- Param: _mob
- Param: _cut (optional, default 22000)
- Param: _res (optional, default 10)

File: [client\VoiceSystem\ReVoice\API.sqf at line 390](../../../Src/client/VoiceSystem/ReVoice/API.sqf#L390)
## vs_setReverbEffect

Type: function

Description: 
- Param: _mob
- Param: _dec (optional, default 1200)
- Param: _edel (optional, default 20)
- Param: _ldel (optional, default 40)
- Param: _hcut (optional, default 8000)
- Param: _wet (optional, default -80)
- Param: _dry (optional, default 0)

File: [client\VoiceSystem\ReVoice\API.sqf at line 395](../../../Src/client/VoiceSystem/ReVoice/API.sqf#L395)
## vs_internal_setTargetEffectValues

Type: function

Description: 
- Param: _mob
- Param: _lowpass
- Param: _reverb

File: [client\VoiceSystem\ReVoice\API.sqf at line 400](../../../Src/client/VoiceSystem/ReVoice/API.sqf#L400)
## vs_internal_clearEffectValues

Type: function

Description: сбрасывает все значения эффектов
- Param: _mob
- Param: _clearUpdateMark (optional, default false)

File: [client\VoiceSystem\ReVoice\API.sqf at line 413](../../../Src/client/VoiceSystem/ReVoice/API.sqf#L413)
## vs_internal_applyEffects

Type: function

Description: 
- Param: _mob

File: [client\VoiceSystem\ReVoice\API.sqf at line 425](../../../Src/client/VoiceSystem/ReVoice/API.sqf#L425)
## vs_calcReverbEffect

Type: function

Description: получает настройки реверба для текущего моба (~0.976563ms per call)
- Param: _mob

File: [client\VoiceSystem\ReVoice\API.sqf at line 458](../../../Src/client/VoiceSystem/ReVoice/API.sqf#L458)
## vs_calcLowpassEffect

Type: function

Description: 
- Param: _mob

File: [client\VoiceSystem\ReVoice\API.sqf at line 619](../../../Src/client/VoiceSystem/ReVoice/API.sqf#L619)
## vs_processSpeakingLangs

Type: function

Description: Калькулирует понимание речи персонажа
- Param: _unit
- Param: _curVol

File: [client\VoiceSystem\ReVoice\API.sqf at line 741](../../../Src/client/VoiceSystem/ReVoice/API.sqf#L741)
# Input.sqf

## voice_changer_border_size_x

Type: constant

Description: 


Replaced value:
```sqf
1
```
File: [client\VoiceSystem\ReVoice\Input.sqf at line 10](../../../Src/client/VoiceSystem/ReVoice/Input.sqf#L10)
## voice_changer_border_size_y

Type: constant

Description: 


Replaced value:
```sqf
15
```
File: [client\VoiceSystem\ReVoice\Input.sqf at line 12](../../../Src/client/VoiceSystem/ReVoice/Input.sqf#L12)
## voice_changer_size_h

Type: constant

Description: 


Replaced value:
```sqf
7
```
File: [client\VoiceSystem\ReVoice\Input.sqf at line 15](../../../Src/client/VoiceSystem/ReVoice/Input.sqf#L15)
## voice_changer_size_w

Type: constant

Description: 


Replaced value:
```sqf
20
```
File: [client\VoiceSystem\ReVoice\Input.sqf at line 17](../../../Src/client/VoiceSystem/ReVoice/Input.sqf#L17)
## voice_changer_bias_x

Type: constant

Description: 


Replaced value:
```sqf
1
```
File: [client\VoiceSystem\ReVoice\Input.sqf at line 20](../../../Src/client/VoiceSystem/ReVoice/Input.sqf#L20)
## voice_changer_bias_y

Type: constant

Description: 


Replaced value:
```sqf
1
```
File: [client\VoiceSystem\ReVoice\Input.sqf at line 22](../../../Src/client/VoiceSystem/ReVoice/Input.sqf#L22)
## vec4(a,b,c,d)

Type: constant

Description: 
- Param: a
- Param: b
- Param: c
- Param: d

Replaced value:
```sqf
[a,b,c,d]
```
File: [client\VoiceSystem\ReVoice\Input.sqf at line 25](../../../Src/client/VoiceSystem/ReVoice/Input.sqf#L25)
## vs_getWidgetText

Type: constant

Description: 


Replaced value:
```sqf
(vs_voiceVolumeWidgets select 0)
```
File: [client\VoiceSystem\ReVoice\Input.sqf at line 31](../../../Src/client/VoiceSystem/ReVoice/Input.sqf#L31)
## vs_getWidgetProgress

Type: constant

Description: 


Replaced value:
```sqf
(vs_voiceVolumeWidgets select 1)
```
File: [client\VoiceSystem\ReVoice\Input.sqf at line 33](../../../Src/client/VoiceSystem/ReVoice/Input.sqf#L33)
## vs_getWidgetGroup

Type: constant

Description: 


Replaced value:
```sqf
(vs_voiceVolumeWidgets select 3)
```
File: [client\VoiceSystem\ReVoice\Input.sqf at line 35](../../../Src/client/VoiceSystem/ReVoice/Input.sqf#L35)
## vs_voiceDelayFadein

Type: constant

Description: 


Replaced value:
```sqf
4
```
File: [client\VoiceSystem\ReVoice\Input.sqf at line 39](../../../Src/client/VoiceSystem/ReVoice/Input.sqf#L39)
## vs_voiceAmountFade

Type: constant

Description: 


Replaced value:
```sqf
0.025
```
File: [client\VoiceSystem\ReVoice\Input.sqf at line 43](../../../Src/client/VoiceSystem/ReVoice/Input.sqf#L43)
## vs_voiceVolumeWidgets

Type: Variable

Description: _bg3 ctrlEnable true;


Initial value:
```sqf
[]
```
File: [client\VoiceSystem\ReVoice\Input.sqf at line 28](../../../Src/client/VoiceSystem/ReVoice/Input.sqf#L28)
## vs_curVoiceMode

Type: Variable

Description: 


Initial value:
```sqf
0
```
File: [client\VoiceSystem\ReVoice\Input.sqf at line 46](../../../Src/client/VoiceSystem/ReVoice/Input.sqf#L46)
## vs_canFadeVoiceVolumeWidget

Type: Variable

Description: 


Initial value:
```sqf
true
```
File: [client\VoiceSystem\ReVoice\Input.sqf at line 49](../../../Src/client/VoiceSystem/ReVoice/Input.sqf#L49)
## vs_voiceVolume_lastUpdate

Type: Variable

Description: 


Initial value:
```sqf
0
```
File: [client\VoiceSystem\ReVoice\Input.sqf at line 52](../../../Src/client/VoiceSystem/ReVoice/Input.sqf#L52)
## vs_voiceVolumeList

Type: Variable

Description: 


Initial value:
```sqf
[...
```
File: [client\VoiceSystem\ReVoice\Input.sqf at line 55](../../../Src/client/VoiceSystem/ReVoice/Input.sqf#L55)
## vs_internal_statusWidgets

Type: Variable

Description: 


Initial value:
```sqf
[]
```
File: [client\VoiceSystem\ReVoice\Input.sqf at line 122](../../../Src/client/VoiceSystem/ReVoice/Input.sqf#L122)
## vs_getMaxVolume

Type: function

Description: 


File: [client\VoiceSystem\ReVoice\Input.sqf at line 64](../../../Src/client/VoiceSystem/ReVoice/Input.sqf#L64)
## vs_changeVoiceVolume

Type: function

Description: 
- Param: _mode

File: [client\VoiceSystem\ReVoice\Input.sqf at line 70](../../../Src/client/VoiceSystem/ReVoice/Input.sqf#L70)
## vs_voiceVolumeOnUpdate

Type: function

Description: 


File: [client\VoiceSystem\ReVoice\Input.sqf at line 99](../../../Src/client/VoiceSystem/ReVoice/Input.sqf#L99)
## vs_initChangeVoiceCtrl

Type: function

Description: 


File: [client\VoiceSystem\ReVoice\Input.sqf at line 125](../../../Src/client/VoiceSystem/ReVoice/Input.sqf#L125)
## vs_addDisplayInputHandlers

Type: function

Description: 
- Param: _d

File: [client\VoiceSystem\ReVoice\Input.sqf at line 208](../../../Src/client/VoiceSystem/ReVoice/Input.sqf#L208)
# ReVoice.h

## REQ_GET_VERSION

Type: constant

Description: ================ api requests ==========================


Replaced value:
```sqf
"getVersion"
```
File: [client\VoiceSystem\ReVoice\ReVoice.h at line 7](../../../Src/client/VoiceSystem/ReVoice/ReVoice.h#L7)
## REQ_IS_CONNECTED_VOICE

Type: constant

Description: 


Replaced value:
```sqf
"isConnectedVoice"
```
File: [client\VoiceSystem\ReVoice\ReVoice.h at line 8](../../../Src/client/VoiceSystem/ReVoice/ReVoice.h#L8)
## REQ_GET_LAST_HEARTBEAT

Type: constant

Description: 


Replaced value:
```sqf
"getLastHeartbeat"
```
File: [client\VoiceSystem\ReVoice\ReVoice.h at line 9](../../../Src/client/VoiceSystem/ReVoice/ReVoice.h#L9)
## REQ_DISCONNECT_VOICE

Type: constant

Description: 


Replaced value:
```sqf
"disconnectVoice"
```
File: [client\VoiceSystem\ReVoice\ReVoice.h at line 10](../../../Src/client/VoiceSystem/ReVoice/ReVoice.h#L10)
## REQ_IS_SPEAKING

Type: constant

Description: 


Replaced value:
```sqf
"isSpeaking"
```
File: [client\VoiceSystem\ReVoice\ReVoice.h at line 12](../../../Src/client/VoiceSystem/ReVoice/ReVoice.h#L12)
## REQ_SPEAK_START

Type: constant

Description: 


Replaced value:
```sqf
"speakStart"
```
File: [client\VoiceSystem\ReVoice\ReVoice.h at line 13](../../../Src/client/VoiceSystem/ReVoice/ReVoice.h#L13)
## REQ_SPEAK_STOP

Type: constant

Description: 


Replaced value:
```sqf
"speakStop"
```
File: [client\VoiceSystem\ReVoice\ReVoice.h at line 14](../../../Src/client/VoiceSystem/ReVoice/ReVoice.h#L14)
## REQ_SPEAK_RELEASEALL

Type: constant

Description: 


Replaced value:
```sqf
"speakReleaseAll"
```
File: [client\VoiceSystem\ReVoice\ReVoice.h at line 15](../../../Src/client/VoiceSystem/ReVoice/ReVoice.h#L15)
## CMD_CONNECT_VOICE

Type: constant

Description: =============== api command ===========================


Replaced value:
```sqf
"connectVoice"
```
File: [client\VoiceSystem\ReVoice\ReVoice.h at line 18](../../../Src/client/VoiceSystem/ReVoice/ReVoice.h#L18)
## CMD_GET_MIC_DEVICES

Type: constant

Description: 


Replaced value:
```sqf
"getMicDevices"
```
File: [client\VoiceSystem\ReVoice\ReVoice.h at line 20](../../../Src/client/VoiceSystem/ReVoice/ReVoice.h#L20)
## CMD_SET_MIC_DEVICE

Type: constant

Description: 


Replaced value:
```sqf
"setMicDevice"
```
File: [client\VoiceSystem\ReVoice\ReVoice.h at line 21](../../../Src/client/VoiceSystem/ReVoice/ReVoice.h#L21)
## CMD_GET_PLAYBACK_DEVICES

Type: constant

Description: 


Replaced value:
```sqf
"getPlaybackDevices"
```
File: [client\VoiceSystem\ReVoice\ReVoice.h at line 22](../../../Src/client/VoiceSystem/ReVoice/ReVoice.h#L22)
## CMD_SET_PLAYBACK_DEVICE

Type: constant

Description: 


Replaced value:
```sqf
"setPlaybackDevice"
```
File: [client\VoiceSystem\ReVoice\ReVoice.h at line 23](../../../Src/client/VoiceSystem/ReVoice/ReVoice.h#L23)
## CMD_SET_MASTER_VOICE_VOLUME

Type: constant

Description: 


Replaced value:
```sqf
"setMasterVoiceVolume"
```
File: [client\VoiceSystem\ReVoice\ReVoice.h at line 25](../../../Src/client/VoiceSystem/ReVoice/ReVoice.h#L25)
## CMD_GET_ALL_CLIENTS

Type: constant

Description: 


Replaced value:
```sqf
"getAllClients"
```
File: [client\VoiceSystem\ReVoice\ReVoice.h at line 27](../../../Src/client/VoiceSystem/ReVoice/ReVoice.h#L27)
## CMD_SYNC_LOCAL_PLAYER

Type: constant

Description: 


Replaced value:
```sqf
"syncLocalPlayer"
```
File: [client\VoiceSystem\ReVoice\ReVoice.h at line 29](../../../Src/client/VoiceSystem/ReVoice/ReVoice.h#L29)
## CMD_SYNC_REMOTE_PLAYER

Type: constant

Description: 


Replaced value:
```sqf
"syncRemotePlayer"
```
File: [client\VoiceSystem\ReVoice\ReVoice.h at line 30](../../../Src/client/VoiceSystem/ReVoice/ReVoice.h#L30)
## CMD_SETLOWPASS

Type: constant

Description: 


Replaced value:
```sqf
"setLowpass"
```
File: [client\VoiceSystem\ReVoice\ReVoice.h at line 32](../../../Src/client/VoiceSystem/ReVoice/ReVoice.h#L32)
## CMD_SETREVERB

Type: constant

Description: 


Replaced value:
```sqf
"setReverb"
```
File: [client\VoiceSystem\ReVoice\ReVoice.h at line 33](../../../Src/client/VoiceSystem/ReVoice/ReVoice.h#L33)
# ReVoice_init.sqf

## VOICE_DISABLE_IN_SINGLEPLAYERMODE

Type: constant

Description: 


Replaced value:
```sqf

```
File: [client\VoiceSystem\ReVoice\ReVoice_init.sqf at line 12](../../../Src/client/VoiceSystem/ReVoice/ReVoice_init.sqf#L12)
## vs_apiversion

Type: Variable

Description: 


Initial value:
```sqf
"beta_v1"
```
File: [client\VoiceSystem\ReVoice\ReVoice_init.sqf at line 14](../../../Src/client/VoiceSystem/ReVoice/ReVoice_init.sqf#L14)
## vs_localName

Type: Variable

Description: 


Initial value:
```sqf
"" //sended from server on player connected
```
File: [client\VoiceSystem\ReVoice\ReVoice_init.sqf at line 16](../../../Src/client/VoiceSystem/ReVoice/ReVoice_init.sqf#L16)
## vs_canProcess

Type: Variable

Description: sended from server on player connected


Initial value:
```sqf
false
```
File: [client\VoiceSystem\ReVoice\ReVoice_init.sqf at line 17](../../../Src/client/VoiceSystem/ReVoice/ReVoice_init.sqf#L17)
## vs_max_voice_volume

Type: Variable

Description: 


Initial value:
```sqf
60
```
File: [client\VoiceSystem\ReVoice\ReVoice_init.sqf at line 18](../../../Src/client/VoiceSystem/ReVoice/ReVoice_init.sqf#L18)
## vs_horizontal_tab

Type: Variable

Description: 


Initial value:
```sqf
toString [9] //для запросов
```
File: [client\VoiceSystem\ReVoice\ReVoice_init.sqf at line 19](../../../Src/client/VoiceSystem/ReVoice/ReVoice_init.sqf#L19)
## vs_isEnabledText

Type: Variable

Description: для запросов


Initial value:
```sqf
false
```
File: [client\VoiceSystem\ReVoice\ReVoice_init.sqf at line 20](../../../Src/client/VoiceSystem/ReVoice/ReVoice_init.sqf#L20)
# Speaker.sqf

## vs_transmithDistance

Type: Variable

Description: 


Initial value:
```sqf
1000
```
File: [client\VoiceSystem\ReVoice\Speaker.sqf at line 6](../../../Src/client/VoiceSystem/ReVoice/Speaker.sqf#L6)
## vs_curTransmithType

Type: Variable

Description: 


Initial value:
```sqf
0 //режим передачи
```
File: [client\VoiceSystem\ReVoice\Speaker.sqf at line 7](../../../Src/client/VoiceSystem/ReVoice/Speaker.sqf#L7)
## vs_transmithTypes

Type: Variable

Description: режим передачи


Initial value:
```sqf
["digital","digital_lr","airborne"]
```
File: [client\VoiceSystem\ReVoice\Speaker.sqf at line 8](../../../Src/client/VoiceSystem/ReVoice/Speaker.sqf#L8)
