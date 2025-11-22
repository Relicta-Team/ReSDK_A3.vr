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

## revoice_debug_only(debug_expr)

Type: constant

> Exists if **REDITOR_VOICE_DEBUG** defined

Description: 
- Param: debug_expr

Replaced value:
```sqf
debug_expr;
```
File: [client\VoiceSystem\ReVoice\API.sqf at line 9](../../../Src/client/VoiceSystem/ReVoice/API.sqf#L9)
## REDITOR_VOICE_DEBUG_RENDER

Type: constant

> Exists if **REDITOR_VOICE_DEBUG** defined

Description: 


Replaced value:
```sqf

```
File: [client\VoiceSystem\ReVoice\API.sqf at line 10](../../../Src/client/VoiceSystem/ReVoice/API.sqf#L10)
## revoice_debug_only(debug_expr)

Type: constant

> Exists if **REDITOR_VOICE_DEBUG** not defined

Description: 
- Param: debug_expr

Replaced value:
```sqf

```
File: [client\VoiceSystem\ReVoice\API.sqf at line 12](../../../Src/client/VoiceSystem/ReVoice/API.sqf#L12)
## VOICE_UPDATE_EFFECTS_DELAY

Type: constant

Description: частота вычисления позиционных эффектов. для лучшего импакта рекомендую в будущем снизить до 0.2


Replaced value:
```sqf
0.5
```
File: [client\VoiceSystem\ReVoice\API.sqf at line 18](../../../Src/client/VoiceSystem/ReVoice/API.sqf#L18)
## __postargs

Type: constant

Description: 


Replaced value:
```sqf
_ignore1,_target,true,1,"VIEW","GEOM",true
```
File: [client\VoiceSystem\ReVoice\API.sqf at line 484](../../../Src/client/VoiceSystem/ReVoice/API.sqf#L484)
## vs_init

Type: function

Description: 


File: [client\VoiceSystem\ReVoice\API.sqf at line 20](../../../Src/client/VoiceSystem/ReVoice/API.sqf#L20)
## vs_isConnectedVoice

Type: function

Description: подключен ли к голосовому серверу


File: [client\VoiceSystem\ReVoice\API.sqf at line 60](../../../Src/client/VoiceSystem/ReVoice/API.sqf#L60)
## vs_connectVoice

Type: function

Description: 
- Param: _addr
- Param: _port
- Param: _user
- Param: _pass

File: [client\VoiceSystem\ReVoice\API.sqf at line 64](../../../Src/client/VoiceSystem/ReVoice/API.sqf#L64)
## vs_connectToVoiceSystem

Type: function

Description: вызывается когда клиент джоинится в игру


File: [client\VoiceSystem\ReVoice\API.sqf at line 70](../../../Src/client/VoiceSystem/ReVoice/API.sqf#L70)
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


File: [client\VoiceSystem\ReVoice\API.sqf at line 103](../../../Src/client/VoiceSystem/ReVoice/API.sqf#L103)
## vs_getMicDevices

Type: function

Description: получить микрофоны


File: [client\VoiceSystem\ReVoice\API.sqf at line 108](../../../Src/client/VoiceSystem/ReVoice/API.sqf#L108)
## vs_setMicDevice

Type: function

Description: установить устройство записи
- Param: _id

File: [client\VoiceSystem\ReVoice\API.sqf at line 112](../../../Src/client/VoiceSystem/ReVoice/API.sqf#L112)
## vs_getPlaybackDevices

Type: function

Description: получить устройство воспроизведения


File: [client\VoiceSystem\ReVoice\API.sqf at line 117](../../../Src/client/VoiceSystem/ReVoice/API.sqf#L117)
## vs_setPlaybackDevice

Type: function

Description: установить устройство воспроизведения
- Param: _id

File: [client\VoiceSystem\ReVoice\API.sqf at line 121](../../../Src/client/VoiceSystem/ReVoice/API.sqf#L121)
## vs_getAllClients

Type: function

Description: 
- Param: _r
- Param: _rcode

File: [client\VoiceSystem\ReVoice\API.sqf at line 126](../../../Src/client/VoiceSystem/ReVoice/API.sqf#L126)
## vs_setMasterVoiceVolume

Type: function

Description: 
- Param: _vol

File: [client\VoiceSystem\ReVoice\API.sqf at line 135](../../../Src/client/VoiceSystem/ReVoice/API.sqf#L135)
## vs_startHandleProcessPlayerPos

Type: function

Description: 


File: [client\VoiceSystem\ReVoice\API.sqf at line 141](../../../Src/client/VoiceSystem/ReVoice/API.sqf#L141)
## vs_stopHandleProcessPlayerPos

Type: function

Description: 


File: [client\VoiceSystem\ReVoice\API.sqf at line 150](../../../Src/client/VoiceSystem/ReVoice/API.sqf#L150)
## vs_onProcessPlayerPosition

Type: function

Description: main system loop


File: [client\VoiceSystem\ReVoice\API.sqf at line 157](../../../Src/client/VoiceSystem/ReVoice/API.sqf#L157)
## vs_checkConnection

Type: function

Description: проверка подключения системы


File: [client\VoiceSystem\ReVoice\API.sqf at line 178](../../../Src/client/VoiceSystem/ReVoice/API.sqf#L178)
## vs_syncLocalPlayer

Type: function

Description: синхронизация позиции локального юзера


File: [client\VoiceSystem\ReVoice\API.sqf at line 198](../../../Src/client/VoiceSystem/ReVoice/API.sqf#L198)
## vs_debug_generateClients

Type: function

> Exists if **EDITOR** defined

Description: 


File: [client\VoiceSystem\ReVoice\API.sqf at line 221](../../../Src/client/VoiceSystem/ReVoice/API.sqf#L221)
## vs_syncRemotePlayers

Type: function

Description: 


File: [client\VoiceSystem\ReVoice\API.sqf at line 238](../../../Src/client/VoiceSystem/ReVoice/API.sqf#L238)
## vs_handleUserSpeakInternal

Type: function

Description: 
- Param: _mob
- Param: _state

File: [client\VoiceSystem\ReVoice\API.sqf at line 329](../../../Src/client/VoiceSystem/ReVoice/API.sqf#L329)
## vs_onUserSpeak

Type: function

Description: событие когда другой клиент говорит или перестает говорить
- Param: _mob
- Param: _isSpeaking

File: [client\VoiceSystem\ReVoice\API.sqf at line 346](../../../Src/client/VoiceSystem/ReVoice/API.sqf#L346)
## vs_handleSpeak

Type: function

Description: 
- Param: _mode

File: [client\VoiceSystem\ReVoice\API.sqf at line 355](../../../Src/client/VoiceSystem/ReVoice/API.sqf#L355)
## vs_speakReleaseAll

Type: function

Description: 


File: [client\VoiceSystem\ReVoice\API.sqf at line 371](../../../Src/client/VoiceSystem/ReVoice/API.sqf#L371)
## vs_setLocalPlayerVoiceDistance

Type: function

Description: 
- Param: _d

File: [client\VoiceSystem\ReVoice\API.sqf at line 375](../../../Src/client/VoiceSystem/ReVoice/API.sqf#L375)
## vs_initMob

Type: function

Description: иницилизация сущности
- Param: _mob
- Param: _nick

File: [client\VoiceSystem\ReVoice\API.sqf at line 381](../../../Src/client/VoiceSystem/ReVoice/API.sqf#L381)
## vs_setLowpassEffect

Type: function

Description: effects extension
- Param: _mob
- Param: _cut (optional, default 22000)
- Param: _res (optional, default 10)

File: [client\VoiceSystem\ReVoice\API.sqf at line 399](../../../Src/client/VoiceSystem/ReVoice/API.sqf#L399)
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

File: [client\VoiceSystem\ReVoice\API.sqf at line 404](../../../Src/client/VoiceSystem/ReVoice/API.sqf#L404)
## vs_internal_setTargetEffectValues

Type: function

Description: 
- Param: _mob
- Param: _lowpass
- Param: _reverb

File: [client\VoiceSystem\ReVoice\API.sqf at line 409](../../../Src/client/VoiceSystem/ReVoice/API.sqf#L409)
## vs_internal_clearEffectValues

Type: function

Description: сбрасывает все значения эффектов
- Param: _mob
- Param: _clearUpdateMark (optional, default false)

File: [client\VoiceSystem\ReVoice\API.sqf at line 422](../../../Src/client/VoiceSystem/ReVoice/API.sqf#L422)
## vs_internal_applyEffects

Type: function

Description: 
- Param: _mob

File: [client\VoiceSystem\ReVoice\API.sqf at line 434](../../../Src/client/VoiceSystem/ReVoice/API.sqf#L434)
## vs_calcReverbEffect

Type: function

Description: получает настройки реверба для текущего моба (~0.976563ms per call)
- Param: _target

File: [client\VoiceSystem\ReVoice\API.sqf at line 467](../../../Src/client/VoiceSystem/ReVoice/API.sqf#L467)
## vs_calcLowpassEffect

Type: function

Description: 
- Param: _target

File: [client\VoiceSystem\ReVoice\API.sqf at line 644](../../../Src/client/VoiceSystem/ReVoice/API.sqf#L644)
## vs_processSpeakingLangs

Type: function

Description: Калькулирует понимание речи персонажа
- Param: _unit
- Param: _curVol

File: [client\VoiceSystem\ReVoice\API.sqf at line 770](../../../Src/client/VoiceSystem/ReVoice/API.sqf#L770)
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

## apiCmd

Type: constant

Description: usage: apiCmd ["test",[arg1,arg2]]


Replaced value:
```sqf
"revoicer" callExtension 
```
File: [client\VoiceSystem\ReVoice\ReVoice.h at line 7](../../../Src/client/VoiceSystem/ReVoice/ReVoice.h#L7)
## apiRequest(p)

Type: constant

Description: 
- Param: p

Replaced value:
```sqf
("revoicer" callExtension (p))
```
File: [client\VoiceSystem\ReVoice\ReVoice.h at line 8](../../../Src/client/VoiceSystem/ReVoice/ReVoice.h#L8)
## REQ_GET_VERSION

Type: constant

Description: ================ api requests ==========================


Replaced value:
```sqf
"getVersion"
```
File: [client\VoiceSystem\ReVoice\ReVoice.h at line 11](../../../Src/client/VoiceSystem/ReVoice/ReVoice.h#L11)
## REQ_IS_CONNECTED_VOICE

Type: constant

Description: 


Replaced value:
```sqf
"isConnectedVoice"
```
File: [client\VoiceSystem\ReVoice\ReVoice.h at line 12](../../../Src/client/VoiceSystem/ReVoice/ReVoice.h#L12)
## REQ_GET_LAST_HEARTBEAT

Type: constant

Description: 


Replaced value:
```sqf
"getLastHeartbeat"
```
File: [client\VoiceSystem\ReVoice\ReVoice.h at line 13](../../../Src/client/VoiceSystem/ReVoice/ReVoice.h#L13)
## REQ_DISCONNECT_VOICE

Type: constant

Description: 


Replaced value:
```sqf
"disconnectVoice"
```
File: [client\VoiceSystem\ReVoice\ReVoice.h at line 14](../../../Src/client/VoiceSystem/ReVoice/ReVoice.h#L14)
## REQ_IS_SPEAKING

Type: constant

Description: 


Replaced value:
```sqf
"isSpeaking"
```
File: [client\VoiceSystem\ReVoice\ReVoice.h at line 16](../../../Src/client/VoiceSystem/ReVoice/ReVoice.h#L16)
## REQ_SPEAK_START

Type: constant

Description: 


Replaced value:
```sqf
"speakStart"
```
File: [client\VoiceSystem\ReVoice\ReVoice.h at line 17](../../../Src/client/VoiceSystem/ReVoice/ReVoice.h#L17)
## REQ_SPEAK_STOP

Type: constant

Description: 


Replaced value:
```sqf
"speakStop"
```
File: [client\VoiceSystem\ReVoice\ReVoice.h at line 18](../../../Src/client/VoiceSystem/ReVoice/ReVoice.h#L18)
## REQ_SPEAK_RELEASEALL

Type: constant

Description: 


Replaced value:
```sqf
"speakReleaseAll"
```
File: [client\VoiceSystem\ReVoice\ReVoice.h at line 19](../../../Src/client/VoiceSystem/ReVoice/ReVoice.h#L19)
## CMD_CONNECT_VOICE

Type: constant

Description: =============== api command ===========================


Replaced value:
```sqf
"connectVoice"
```
File: [client\VoiceSystem\ReVoice\ReVoice.h at line 22](../../../Src/client/VoiceSystem/ReVoice/ReVoice.h#L22)
## CMD_GET_MIC_DEVICES

Type: constant

Description: 


Replaced value:
```sqf
"getMicDevices"
```
File: [client\VoiceSystem\ReVoice\ReVoice.h at line 24](../../../Src/client/VoiceSystem/ReVoice/ReVoice.h#L24)
## CMD_SET_MIC_DEVICE

Type: constant

Description: 


Replaced value:
```sqf
"setMicDevice"
```
File: [client\VoiceSystem\ReVoice\ReVoice.h at line 25](../../../Src/client/VoiceSystem/ReVoice/ReVoice.h#L25)
## CMD_GET_PLAYBACK_DEVICES

Type: constant

Description: 


Replaced value:
```sqf
"getPlaybackDevices"
```
File: [client\VoiceSystem\ReVoice\ReVoice.h at line 26](../../../Src/client/VoiceSystem/ReVoice/ReVoice.h#L26)
## CMD_SET_PLAYBACK_DEVICE

Type: constant

Description: 


Replaced value:
```sqf
"setPlaybackDevice"
```
File: [client\VoiceSystem\ReVoice\ReVoice.h at line 27](../../../Src/client/VoiceSystem/ReVoice/ReVoice.h#L27)
## CMD_SET_MASTER_VOICE_VOLUME

Type: constant

Description: 


Replaced value:
```sqf
"setMasterVoiceVolume"
```
File: [client\VoiceSystem\ReVoice\ReVoice.h at line 29](../../../Src/client/VoiceSystem/ReVoice/ReVoice.h#L29)
## CMD_GET_ALL_CLIENTS

Type: constant

Description: 


Replaced value:
```sqf
"getAllClients"
```
File: [client\VoiceSystem\ReVoice\ReVoice.h at line 31](../../../Src/client/VoiceSystem/ReVoice/ReVoice.h#L31)
## CMD_SYNC_LOCAL_PLAYER

Type: constant

Description: 


Replaced value:
```sqf
"syncLocalPlayer"
```
File: [client\VoiceSystem\ReVoice\ReVoice.h at line 33](../../../Src/client/VoiceSystem/ReVoice/ReVoice.h#L33)
## CMD_SYNC_REMOTE_PLAYER

Type: constant

Description: 


Replaced value:
```sqf
"syncRemotePlayer"
```
File: [client\VoiceSystem\ReVoice\ReVoice.h at line 34](../../../Src/client/VoiceSystem/ReVoice/ReVoice.h#L34)
## CMD_SETLOWPASS

Type: constant

Description: 


Replaced value:
```sqf
"setLowpass"
```
File: [client\VoiceSystem\ReVoice\ReVoice.h at line 36](../../../Src/client/VoiceSystem/ReVoice/ReVoice.h#L36)
## CMD_SETREVERB

Type: constant

Description: 


Replaced value:
```sqf
"setReverb"
```
File: [client\VoiceSystem\ReVoice\ReVoice.h at line 37](../../../Src/client/VoiceSystem/ReVoice/ReVoice.h#L37)
## CMD_RADIO_ADD

Type: constant

Description: radio commands


Replaced value:
```sqf
"addRadio"
```
File: [client\VoiceSystem\ReVoice\ReVoice.h at line 40](../../../Src/client/VoiceSystem/ReVoice/ReVoice.h#L40)
## CMD_RADIO_REMOVE

Type: constant

Description: 


Replaced value:
```sqf
"removeRadio"
```
File: [client\VoiceSystem\ReVoice\ReVoice.h at line 41](../../../Src/client/VoiceSystem/ReVoice/ReVoice.h#L41)
## CMD_RADIO_SUBSCRIBE_RADIOSTREAM

Type: constant

Description: 


Replaced value:
```sqf
"subscribeRadio"
```
File: [client\VoiceSystem\ReVoice\ReVoice.h at line 43](../../../Src/client/VoiceSystem/ReVoice/ReVoice.h#L43)
## CMD_RADIO_APPLY_WAVE_FILTER

Type: constant

Description: 


Replaced value:
```sqf
"applyRadioWaveFilter"
```
File: [client\VoiceSystem\ReVoice\ReVoice.h at line 44](../../../Src/client/VoiceSystem/ReVoice/ReVoice.h#L44)
## CMD_SYNC_REMOTE_RADIO

Type: constant

Description: 


Replaced value:
```sqf
"syncRemoteRadio"
```
File: [client\VoiceSystem\ReVoice\ReVoice.h at line 45](../../../Src/client/VoiceSystem/ReVoice/ReVoice.h#L45)
## CMD_SYNC_REMOTE_RADIO_LOWPASS

Type: constant

Description: 


Replaced value:
```sqf
"syncRemoteRadioLowpass"
```
File: [client\VoiceSystem\ReVoice\ReVoice.h at line 46](../../../Src/client/VoiceSystem/ReVoice/ReVoice.h#L46)
## CMD_SYNC_REMOTE_RADIO_REVERB

Type: constant

Description: 


Replaced value:
```sqf
"syncRemoteRadioReverb"
```
File: [client\VoiceSystem\ReVoice\ReVoice.h at line 47](../../../Src/client/VoiceSystem/ReVoice/ReVoice.h#L47)
# ReVoice_init.sqf

## VOICE_DISABLE_IN_SINGLEPLAYERMODE

Type: constant

Description: 


Replaced value:
```sqf

```
File: [client\VoiceSystem\ReVoice\ReVoice_init.sqf at line 13](../../../Src/client/VoiceSystem/ReVoice/ReVoice_init.sqf#L13)
## vs_apiversion

Type: Variable

Description: 


Initial value:
```sqf
"stable_v3"
```
File: [client\VoiceSystem\ReVoice\ReVoice_init.sqf at line 15](../../../Src/client/VoiceSystem/ReVoice/ReVoice_init.sqf#L15)
## vs_localName

Type: Variable

Description: 


Initial value:
```sqf
"" //sended from server on player connected
```
File: [client\VoiceSystem\ReVoice\ReVoice_init.sqf at line 17](../../../Src/client/VoiceSystem/ReVoice/ReVoice_init.sqf#L17)
## vs_canProcess

Type: Variable

Description: sended from server on player connected


Initial value:
```sqf
false
```
File: [client\VoiceSystem\ReVoice\ReVoice_init.sqf at line 18](../../../Src/client/VoiceSystem/ReVoice/ReVoice_init.sqf#L18)
## vs_max_voice_volume

Type: Variable

Description: 


Initial value:
```sqf
60
```
File: [client\VoiceSystem\ReVoice\ReVoice_init.sqf at line 19](../../../Src/client/VoiceSystem/ReVoice/ReVoice_init.sqf#L19)
## vs_horizontal_tab

Type: Variable

Description: 


Initial value:
```sqf
toString [9] //для запросов
```
File: [client\VoiceSystem\ReVoice\ReVoice_init.sqf at line 20](../../../Src/client/VoiceSystem/ReVoice/ReVoice_init.sqf#L20)
## vs_isEnabledText

Type: Variable

Description: для запросов


Initial value:
```sqf
false
```
File: [client\VoiceSystem\ReVoice\ReVoice_init.sqf at line 21](../../../Src/client/VoiceSystem/ReVoice/ReVoice_init.sqf#L21)
# Speaker.sqf

## REVOICE_SPEAKER_MAKEDATA(_p,_wave)

Type: constant

Description: 
- Param: _p
- Param: _wave

Replaced value:
```sqf
[_p,_wave]
```
File: [client\VoiceSystem\ReVoice\Speaker.sqf at line 51](../../../Src/client/VoiceSystem/ReVoice/Speaker.sqf#L51)
## REVOICE_SPEAKER_GETPTR(_data)

Type: constant

Description: 
- Param: _data

Replaced value:
```sqf
((_data) select 0)
```
File: [client\VoiceSystem\ReVoice\Speaker.sqf at line 52](../../../Src/client/VoiceSystem/ReVoice/Speaker.sqf#L52)
## REVOICE_SPEAKER_GETWAVEPOWER(_data)

Type: constant

Description: 
- Param: _data

Replaced value:
```sqf
((_data) select 1)
```
File: [client\VoiceSystem\ReVoice\Speaker.sqf at line 53](../../../Src/client/VoiceSystem/ReVoice/Speaker.sqf#L53)
## vs_transmithDistance

Type: Variable

Description: ! deprecated section


Initial value:
```sqf
1000
```
File: [client\VoiceSystem\ReVoice\Speaker.sqf at line 7](../../../Src/client/VoiceSystem/ReVoice/Speaker.sqf#L7)
## vs_curTransmithType

Type: Variable

Description: 


Initial value:
```sqf
0 //режим передачи
```
File: [client\VoiceSystem\ReVoice\Speaker.sqf at line 8](../../../Src/client/VoiceSystem/ReVoice/Speaker.sqf#L8)
## vs_transmithTypes

Type: Variable

Description: режим передачи


Initial value:
```sqf
["digital","digital_lr","airborne"]
```
File: [client\VoiceSystem\ReVoice\Speaker.sqf at line 9](../../../Src/client/VoiceSystem/ReVoice/Speaker.sqf#L9)
## vs_allRadioSpeakers

Type: Variable

Description: список всех спикеров (рации\динамики). ключ - указатель на объект, значение - структура radioData


Initial value:
```sqf
createHashMap
```
File: [client\VoiceSystem\ReVoice\Speaker.sqf at line 12](../../../Src/client/VoiceSystem/ReVoice/Speaker.sqf#L12)
## vs_allInventoryRadios

Type: Variable

Description: рации в руках игроков


Initial value:
```sqf
createHashMap //ключ - указатель на объект, значение - структура radioData
```
File: [client\VoiceSystem\ReVoice\Speaker.sqf at line 14](../../../Src/client/VoiceSystem/ReVoice/Speaker.sqf#L14)
## vs_map_waveSpeakers

Type: Variable

Description: локальная мапа кто говорит в частоты


Initial value:
```sqf
createHashMap // 
```
File: [client\VoiceSystem\ReVoice\Speaker.sqf at line 17](../../../Src/client/VoiceSystem/ReVoice/Speaker.sqf#L17)
## vs_localReceivers

Type: Variable

Description: 


Initial value:
```sqf
[]
```
File: [client\VoiceSystem\ReVoice\Speaker.sqf at line 321](../../../Src/client/VoiceSystem/ReVoice/Speaker.sqf#L321)
## vs_isTalkingOnRadio

Type: Variable

Description: 


Initial value:
```sqf
false
```
File: [client\VoiceSystem\ReVoice\Speaker.sqf at line 322](../../../Src/client/VoiceSystem/ReVoice/Speaker.sqf#L322)
## vs_addRadioStream

Type: function

Description: vs_netSpeakers = [];
- Param: _ptr
- Param: _cfgName (optional, default RADIO_TYPE_WALKIETALKIE)

File: [client\VoiceSystem\ReVoice\Speaker.sqf at line 23](../../../Src/client/VoiceSystem/ReVoice/Speaker.sqf#L23)
## vs_removeRadioStream

Type: function

Description: 
- Param: _ptr

File: [client\VoiceSystem\ReVoice\Speaker.sqf at line 29](../../../Src/client/VoiceSystem/ReVoice/Speaker.sqf#L29)
## vs_radioSpeakProcess

Type: function

Description: 
- Param: _obj
- Param: _mode

File: [client\VoiceSystem\ReVoice\Speaker.sqf at line 35](../../../Src/client/VoiceSystem/ReVoice/Speaker.sqf#L35)
## vs_onRadioSpeakStarted

Type: function

Description: вызывается когда какой-то игрок начал говорить в частоту
- Param: _actorName
- Param: _ptr
- Param: _freq
- Param: _wavePower

File: [client\VoiceSystem\ReVoice\Speaker.sqf at line 56](../../../Src/client/VoiceSystem/ReVoice/Speaker.sqf#L56)
## vs_onRadioSpeakStopped

Type: function

Description: вызывается когда какой-то игрок закончил говорить в частоту
- Param: _actorName
- Param: _ptr
- Param: _freq

File: [client\VoiceSystem\ReVoice\Speaker.sqf at line 69](../../../Src/client/VoiceSystem/ReVoice/Speaker.sqf#L69)
## vs_getObjectRadioData

Type: function

Description: 
- Param: _obj

File: [client\VoiceSystem\ReVoice\Speaker.sqf at line 86](../../../Src/client/VoiceSystem/ReVoice/Speaker.sqf#L86)
## vs_loadWorldRadio

Type: function

Description: noe functions
- Param: _obj
- Param: _radioData
- Param: _ptr
- Param: _isInHand (optional, default false)

File: [client\VoiceSystem\ReVoice\Speaker.sqf at line 92](../../../Src/client/VoiceSystem/ReVoice/Speaker.sqf#L92)
## vs_prepRadioDataInternal

Type: function

Description: 
- Param: _obj
- Param: _radioData
- Param: _ptr

File: [client\VoiceSystem\ReVoice\Speaker.sqf at line 121](../../../Src/client/VoiceSystem/ReVoice/Speaker.sqf#L121)
## vs_unloadWorldRadio

Type: function

Description: 
- Param: _obj
- Param: _isInHand (optional, default false)
- Param: _removeStream (optional, default true)

File: [client\VoiceSystem\ReVoice\Speaker.sqf at line 146](../../../Src/client/VoiceSystem/ReVoice/Speaker.sqf#L146)
## vs_isWorldRadioObject

Type: function

Description: 
- Param: _obj

File: [client\VoiceSystem\ReVoice\Speaker.sqf at line 178](../../../Src/client/VoiceSystem/ReVoice/Speaker.sqf#L178)
## vs_processRadios

Type: function

Description: 


File: [client\VoiceSystem\ReVoice\Speaker.sqf at line 183](../../../Src/client/VoiceSystem/ReVoice/Speaker.sqf#L183)
## vs_handleRadioRetranslateStreamInternal

Type: function

Description: активирует ретрансляцию радио с клиентов на указанный источник. автоматически подписывается на событие радиопередачи
- Param: _rdata
- Param: _usersMap

File: [client\VoiceSystem\ReVoice\Speaker.sqf at line 210](../../../Src/client/VoiceSystem/ReVoice/Speaker.sqf#L210)
## vs_handleRadioSpeakInternal

Type: function

Description: синхронизируем позицию радио и эффекты
- Param: _rdata

File: [client\VoiceSystem\ReVoice\Speaker.sqf at line 272](../../../Src/client/VoiceSystem/ReVoice/Speaker.sqf#L272)
## vs_getNearReceiverRadioObjects

Type: function

Description: возвращает ближайшие радио которые могут слышать игрока


File: [client\VoiceSystem\ReVoice\Speaker.sqf at line 297](../../../Src/client/VoiceSystem/ReVoice/Speaker.sqf#L297)
## vs_handleMicRadioObjects

Type: function

Description: обработчик общения по рации. вызывается внутри апи обычного войса
- Param: _mode

File: [client\VoiceSystem\ReVoice\Speaker.sqf at line 325](../../../Src/client/VoiceSystem/ReVoice/Speaker.sqf#L325)
## vs_processUpdateMicRadioObjects

Type: function

Description: процесс обновления списка объектов для записи


File: [client\VoiceSystem\ReVoice\Speaker.sqf at line 343](../../../Src/client/VoiceSystem/ReVoice/Speaker.sqf#L343)
## vs_onClientDisconnected

Type: function

Description: высвобождает ресурсы клиента, который отключился от сервера с включенным войсом по радио
- Param: _clientName

File: [client\VoiceSystem\ReVoice\Speaker.sqf at line 373](../../../Src/client/VoiceSystem/ReVoice/Speaker.sqf#L373)
## vs_debug_TestMobSpeaking

Type: function

> Exists if **EDITOR** defined

Description: 


File: [client\VoiceSystem\ReVoice\Speaker.sqf at line 388](../../../Src/client/VoiceSystem/ReVoice/Speaker.sqf#L388)
