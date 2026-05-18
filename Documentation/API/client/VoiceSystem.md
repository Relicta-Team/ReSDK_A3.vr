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
File: [client\VoiceSystem\ReVoice\API.sqf at line 10](../../../Src/client/VoiceSystem/ReVoice/API.sqf#L10)
## REDITOR_VOICE_DEBUG_RENDER

Type: constant

> Exists if **REDITOR_VOICE_DEBUG** defined

Description: 


Replaced value:
```sqf

```
File: [client\VoiceSystem\ReVoice\API.sqf at line 11](../../../Src/client/VoiceSystem/ReVoice/API.sqf#L11)
## revoice_debug_only(debug_expr)

Type: constant

> Exists if **REDITOR_VOICE_DEBUG** not defined

Description: 
- Param: debug_expr

Replaced value:
```sqf

```
File: [client\VoiceSystem\ReVoice\API.sqf at line 13](../../../Src/client/VoiceSystem/ReVoice/API.sqf#L13)
## VOICE_UPDATE_EFFECTS_DELAY

Type: constant

Description: частота вычисления позиционных эффектов. для лучшего импакта рекомендую в будущем снизить до 0.2


Replaced value:
```sqf
0.5
```
File: [client\VoiceSystem\ReVoice\API.sqf at line 19](../../../Src/client/VoiceSystem/ReVoice/API.sqf#L19)
## __postargs

Type: constant

Description: 


Replaced value:
```sqf
_ignore1,_ignore2,true,1,"VIEW","GEOM",true
```
File: [client\VoiceSystem\ReVoice\API.sqf at line 765](../../../Src/client/VoiceSystem/ReVoice/API.sqf#L765)
## vs_internal_diag_wid

Type: Variable

Description: 


Initial value:
```sqf
null
```
File: [client\VoiceSystem\ReVoice\API.sqf at line 153](../../../Src/client/VoiceSystem/ReVoice/API.sqf#L153)
## vs_internal_diag_enabled

Type: Variable

Description: 


Initial value:
```sqf
null
```
File: [client\VoiceSystem\ReVoice\API.sqf at line 154](../../../Src/client/VoiceSystem/ReVoice/API.sqf#L154)
## vs_internal_diag_handleUpdate

Type: Variable

Description: 


Initial value:
```sqf
null
```
File: [client\VoiceSystem\ReVoice\API.sqf at line 155](../../../Src/client/VoiceSystem/ReVoice/API.sqf#L155)
## vs_init

Type: function

Description: 


File: [client\VoiceSystem\ReVoice\API.sqf at line 21](../../../Src/client/VoiceSystem/ReVoice/API.sqf#L21)
## vs_isConnectedVoice

Type: function

Description: подключен ли к голосовому серверу


File: [client\VoiceSystem\ReVoice\API.sqf at line 61](../../../Src/client/VoiceSystem/ReVoice/API.sqf#L61)
## vs_connectVoice

Type: function

Description: 
- Param: _addr
- Param: _port
- Param: _user
- Param: _pass

File: [client\VoiceSystem\ReVoice\API.sqf at line 65](../../../Src/client/VoiceSystem/ReVoice/API.sqf#L65)
## vs_connectToVoiceSystem

Type: function

Description: вызывается когда клиент джоинится в игру


File: [client\VoiceSystem\ReVoice\API.sqf at line 71](../../../Src/client/VoiceSystem/ReVoice/API.sqf#L71)
## vs_disconnectVoice

Type: function

Description: низкоуровневая функция остановки войса. Вызывается при кике или отключении от сервера


File: [client\VoiceSystem\ReVoice\API.sqf at line 92](../../../Src/client/VoiceSystem/ReVoice/API.sqf#L92)
## vs_disconnectVoiceSystem

Type: function

Description: функция "правильного" завершения системы. Вызывается при выходе в лобби или перезагрузке войса


File: [client\VoiceSystem\ReVoice\API.sqf at line 97](../../../Src/client/VoiceSystem/ReVoice/API.sqf#L97)
## vs_isSpeaking

Type: function

Description: разговаривает ли


File: [client\VoiceSystem\ReVoice\API.sqf at line 109](../../../Src/client/VoiceSystem/ReVoice/API.sqf#L109)
## vs_getMicDevices

Type: function

Description: получить микрофоны


File: [client\VoiceSystem\ReVoice\API.sqf at line 114](../../../Src/client/VoiceSystem/ReVoice/API.sqf#L114)
## vs_setMicDevice

Type: function

Description: установить устройство записи
- Param: _id

File: [client\VoiceSystem\ReVoice\API.sqf at line 118](../../../Src/client/VoiceSystem/ReVoice/API.sqf#L118)
## vs_getPlaybackDevices

Type: function

Description: получить устройство воспроизведения


File: [client\VoiceSystem\ReVoice\API.sqf at line 123](../../../Src/client/VoiceSystem/ReVoice/API.sqf#L123)
## vs_setPlaybackDevice

Type: function

Description: установить устройство воспроизведения
- Param: _id

File: [client\VoiceSystem\ReVoice\API.sqf at line 127](../../../Src/client/VoiceSystem/ReVoice/API.sqf#L127)
## vs_getAllClients

Type: function

Description: 
- Param: _r
- Param: _rcode

File: [client\VoiceSystem\ReVoice\API.sqf at line 132](../../../Src/client/VoiceSystem/ReVoice/API.sqf#L132)
## vs_getVoiceDiagnostics

Type: function

Description: 


File: [client\VoiceSystem\ReVoice\API.sqf at line 141](../../../Src/client/VoiceSystem/ReVoice/API.sqf#L141)
## vs_getVoiceNetworkDiagnostics

Type: function

Description: 


File: [client\VoiceSystem\ReVoice\API.sqf at line 145](../../../Src/client/VoiceSystem/ReVoice/API.sqf#L145)
## vs_getVoiceListenerDiagnostics

Type: function

Description: 


File: [client\VoiceSystem\ReVoice\API.sqf at line 149](../../../Src/client/VoiceSystem/ReVoice/API.sqf#L149)
## vs_setDiagnosticMenuVisible

Type: function

Description: 
- Param: _mode

File: [client\VoiceSystem\ReVoice\API.sqf at line 157](../../../Src/client/VoiceSystem/ReVoice/API.sqf#L157)
## vs_getLastLogs

Type: function

Description: 


File: [client\VoiceSystem\ReVoice\API.sqf at line 203](../../../Src/client/VoiceSystem/ReVoice/API.sqf#L203)
## vs_getLogPath

Type: function

Description: 


File: [client\VoiceSystem\ReVoice\API.sqf at line 207](../../../Src/client/VoiceSystem/ReVoice/API.sqf#L207)
## vs_getPersonalVoiceChannel

Type: function

Description: 


File: [client\VoiceSystem\ReVoice\API.sqf at line 211](../../../Src/client/VoiceSystem/ReVoice/API.sqf#L211)
## vs_resetVoiceListeners

Type: function

Description: 


File: [client\VoiceSystem\ReVoice\API.sqf at line 215](../../../Src/client/VoiceSystem/ReVoice/API.sqf#L215)
## vs_ensurePersonalVoiceChannel

Type: function

Description: 


File: [client\VoiceSystem\ReVoice\API.sqf at line 225](../../../Src/client/VoiceSystem/ReVoice/API.sqf#L225)
## vs_clearVoiceListeners

Type: function

Description: 
- Param: _r
- Param: _rcode

File: [client\VoiceSystem\ReVoice\API.sqf at line 232](../../../Src/client/VoiceSystem/ReVoice/API.sqf#L232)
## vs_markVoiceListenerRadioRequired

Type: function

Description: 
- Param: _names

File: [client\VoiceSystem\ReVoice\API.sqf at line 238](../../../Src/client/VoiceSystem/ReVoice/API.sqf#L238)
## vs_collectVoiceListenerRadioRequired

Type: function

Description: 


File: [client\VoiceSystem\ReVoice\API.sqf at line 249](../../../Src/client/VoiceSystem/ReVoice/API.sqf#L249)
## vs_collectNearbyVoiceListeners

Type: function

Description: 


File: [client\VoiceSystem\ReVoice\API.sqf at line 269](../../../Src/client/VoiceSystem/ReVoice/API.sqf#L269)
## vs_setVoiceListeners

Type: function

Description: 
- Param: _names

File: [client\VoiceSystem\ReVoice\API.sqf at line 332](../../../Src/client/VoiceSystem/ReVoice/API.sqf#L332)
## vs_processVoiceListeners

Type: function

Description: 


File: [client\VoiceSystem\ReVoice\API.sqf at line 344](../../../Src/client/VoiceSystem/ReVoice/API.sqf#L344)
## vs_setMasterVoiceVolume

Type: function

Description: 
- Param: _vol

File: [client\VoiceSystem\ReVoice\API.sqf at line 377](../../../Src/client/VoiceSystem/ReVoice/API.sqf#L377)
## vs_getMasterVoiceVolume

Type: function

Description: 


File: [client\VoiceSystem\ReVoice\API.sqf at line 383](../../../Src/client/VoiceSystem/ReVoice/API.sqf#L383)
## vs_setTestVolumeMode

Type: function

Description: 
- Param: _mode

File: [client\VoiceSystem\ReVoice\API.sqf at line 387](../../../Src/client/VoiceSystem/ReVoice/API.sqf#L387)
## vs_startHandleProcessPlayerPos

Type: function

Description: 


File: [client\VoiceSystem\ReVoice\API.sqf at line 401](../../../Src/client/VoiceSystem/ReVoice/API.sqf#L401)
## vs_stopHandleProcessPlayerPos

Type: function

Description: 


File: [client\VoiceSystem\ReVoice\API.sqf at line 410](../../../Src/client/VoiceSystem/ReVoice/API.sqf#L410)
## vs_onProcessPlayerPosition

Type: function

Description: main system loop


File: [client\VoiceSystem\ReVoice\API.sqf at line 417](../../../Src/client/VoiceSystem/ReVoice/API.sqf#L417)
## vs_checkConnection

Type: function

Description: проверка подключения системы


File: [client\VoiceSystem\ReVoice\API.sqf at line 439](../../../Src/client/VoiceSystem/ReVoice/API.sqf#L439)
## vs_syncLocalPlayer

Type: function

Description: синхронизация позиции локального юзера


File: [client\VoiceSystem\ReVoice\API.sqf at line 459](../../../Src/client/VoiceSystem/ReVoice/API.sqf#L459)
## vs_debug_generateClients

Type: function

> Exists if **EDITOR** defined

Description: 


File: [client\VoiceSystem\ReVoice\API.sqf at line 482](../../../Src/client/VoiceSystem/ReVoice/API.sqf#L482)
## vs_syncRemotePlayers

Type: function

Description: 


File: [client\VoiceSystem\ReVoice\API.sqf at line 499](../../../Src/client/VoiceSystem/ReVoice/API.sqf#L499)
## vs_handleUserSpeakInternal

Type: function

Description: 
- Param: _mob
- Param: _state

File: [client\VoiceSystem\ReVoice\API.sqf at line 590](../../../Src/client/VoiceSystem/ReVoice/API.sqf#L590)
## vs_onUserSpeak

Type: function

Description: событие когда другой клиент говорит или перестает говорить
- Param: _mob
- Param: _isSpeaking

File: [client\VoiceSystem\ReVoice\API.sqf at line 607](../../../Src/client/VoiceSystem/ReVoice/API.sqf#L607)
## vs_handleSpeak

Type: function

Description: 
- Param: _mode

File: [client\VoiceSystem\ReVoice\API.sqf at line 616](../../../Src/client/VoiceSystem/ReVoice/API.sqf#L616)
## vs_speakReleaseAll

Type: function

Description: 


File: [client\VoiceSystem\ReVoice\API.sqf at line 632](../../../Src/client/VoiceSystem/ReVoice/API.sqf#L632)
## vs_releaseAllVoipButtons

Type: function

Description: 


File: [client\VoiceSystem\ReVoice\API.sqf at line 636](../../../Src/client/VoiceSystem/ReVoice/API.sqf#L636)
## vs_setLocalPlayerVoiceDistance

Type: function

Description: 
- Param: _d

File: [client\VoiceSystem\ReVoice\API.sqf at line 641](../../../Src/client/VoiceSystem/ReVoice/API.sqf#L641)
## vs_initMob

Type: function

Description: иницилизация сущности
- Param: _mob
- Param: _nick

File: [client\VoiceSystem\ReVoice\API.sqf at line 647](../../../Src/client/VoiceSystem/ReVoice/API.sqf#L647)
## vs_setLowpassEffect

Type: function

Description: effects extension
- Param: _mob
- Param: _cut (optional, default 22000)
- Param: _res (optional, default 10)

File: [client\VoiceSystem\ReVoice\API.sqf at line 665](../../../Src/client/VoiceSystem/ReVoice/API.sqf#L665)
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

File: [client\VoiceSystem\ReVoice\API.sqf at line 670](../../../Src/client/VoiceSystem/ReVoice/API.sqf#L670)
## vs_internal_setTargetEffectValues

Type: function

Description: 
- Param: _mob
- Param: _lowpass
- Param: _reverb

File: [client\VoiceSystem\ReVoice\API.sqf at line 675](../../../Src/client/VoiceSystem/ReVoice/API.sqf#L675)
## vs_internal_clearEffectValues

Type: function

Description: сбрасывает все значения эффектов
- Param: _mob
- Param: _clearUpdateMark (optional, default false)

File: [client\VoiceSystem\ReVoice\API.sqf at line 688](../../../Src/client/VoiceSystem/ReVoice/API.sqf#L688)
## vs_internal_applyEffects

Type: function

Description: 
- Param: _mob

File: [client\VoiceSystem\ReVoice\API.sqf at line 700](../../../Src/client/VoiceSystem/ReVoice/API.sqf#L700)
## vs_calcReverbEffect

Type: function

Description: получает настройки реверба для текущего моба (~0.976563ms per call)
- Param: _target
- Param: _targetAsPos (optional, default false)
- Param: _soundId (optional, default -1)
- Param: _dist (optional, default 0)

File: [client\VoiceSystem\ReVoice\API.sqf at line 733](../../../Src/client/VoiceSystem/ReVoice/API.sqf#L733)
## vs_calcLowpassEffect

Type: function

Description: 
- Param: _target
- Param: _targetAsPos (optional, default false)
- Param: _soundId (optional, default -1)

File: [client\VoiceSystem\ReVoice\API.sqf at line 929](../../../Src/client/VoiceSystem/ReVoice/API.sqf#L929)
## vs_processSpeakingLangs

Type: function

Description: Калькулирует понимание речи персонажа
- Param: _unit
- Param: _curVol

File: [client\VoiceSystem\ReVoice\API.sqf at line 1065](../../../Src/client/VoiceSystem/ReVoice/API.sqf#L1065)
# AudioSystem.sqf

## VS_AUDIO_NEXT_EFFECT_UPDATE

Type: constant

Description: Реализация аудиосистемы на основе ReVoice с использованием fmod


Replaced value:
```sqf
1
```
File: [client\VoiceSystem\ReVoice\AudioSystem.sqf at line 10](../../../Src/client/VoiceSystem/ReVoice/AudioSystem.sqf#L10)
## vs_audio_updateHandle

Type: Variable

Description: 


Initial value:
```sqf
-1
```
File: [client\VoiceSystem\ReVoice\AudioSystem.sqf at line 20](../../../Src/client/VoiceSystem/ReVoice/AudioSystem.sqf#L20)
## vs_audio_updateLoopedHandle

Type: Variable

Description: 


Initial value:
```sqf
-1
```
File: [client\VoiceSystem\ReVoice\AudioSystem.sqf at line 21](../../../Src/client/VoiceSystem/ReVoice/AudioSystem.sqf#L21)
## vs_audio_loopedSoundsData

Type: Variable

Description: 


Initial value:
```sqf
[] //looped sounds
```
File: [client\VoiceSystem\ReVoice\AudioSystem.sqf at line 201](../../../Src/client/VoiceSystem/ReVoice/AudioSystem.sqf#L201)
## vs_audio_followedData

Type: Variable

Description: looped sounds


Initial value:
```sqf
[] //followed sounds
```
File: [client\VoiceSystem\ReVoice\AudioSystem.sqf at line 202](../../../Src/client/VoiceSystem/ReVoice/AudioSystem.sqf#L202)
## vs_audio_loadLib

Type: function

Description: 


File: [client\VoiceSystem\ReVoice\AudioSystem.sqf at line 23](../../../Src/client/VoiceSystem/ReVoice/AudioSystem.sqf#L23)
## vs_audio_unloadLib

Type: function

Description: 


File: [client\VoiceSystem\ReVoice\AudioSystem.sqf at line 27](../../../Src/client/VoiceSystem/ReVoice/AudioSystem.sqf#L27)
## vs_audio_getAllSoundsIds

Type: function

Description: получает все работающие звуки в игре


File: [client\VoiceSystem\ReVoice\AudioSystem.sqf at line 32](../../../Src/client/VoiceSystem/ReVoice/AudioSystem.sqf#L32)
## vs_audio_isSoundExists

Type: function

Description: 


File: [client\VoiceSystem\ReVoice\AudioSystem.sqf at line 37](../../../Src/client/VoiceSystem/ReVoice/AudioSystem.sqf#L37)
## vs_audio_stopSound

Type: function

Description: 


File: [client\VoiceSystem\ReVoice\AudioSystem.sqf at line 41](../../../Src/client/VoiceSystem/ReVoice/AudioSystem.sqf#L41)
## vs_audio_stopAllSounds

Type: function

Description: 


File: [client\VoiceSystem\ReVoice\AudioSystem.sqf at line 45](../../../Src/client/VoiceSystem/ReVoice/AudioSystem.sqf#L45)
## vs_audio_releaseAllSounds

Type: function

Description: 


File: [client\VoiceSystem\ReVoice\AudioSystem.sqf at line 51](../../../Src/client/VoiceSystem/ReVoice/AudioSystem.sqf#L51)
## vs_audio_init

Type: function

Description: 


File: [client\VoiceSystem\ReVoice\AudioSystem.sqf at line 56](../../../Src/client/VoiceSystem/ReVoice/AudioSystem.sqf#L56)
## vs_audio_setMasterSoundVolume

Type: function

Description: 


File: [client\VoiceSystem\ReVoice\AudioSystem.sqf at line 91](../../../Src/client/VoiceSystem/ReVoice/AudioSystem.sqf#L91)
## vs_audio_getMasterSoundVolume

Type: function

Description: 


File: [client\VoiceSystem\ReVoice\AudioSystem.sqf at line 94](../../../Src/client/VoiceSystem/ReVoice/AudioSystem.sqf#L94)
## vs_audio_playSound3d

Type: function

Description: 
- Param: _source
- Param: _soundPath
- Param: _distance
- Param: _pitch (optional, default 1)
- Param: _offset (optional, default 0)
- Param: _vol (optional, default 1)
- Param: _useEffects (optional, default true)
- Param: _loop (optional, default false)

File: [client\VoiceSystem\ReVoice\AudioSystem.sqf at line 121](../../../Src/client/VoiceSystem/ReVoice/AudioSystem.sqf#L121)
## vs_audio_playSound3dDynamicLooped

Type: function

Description: 
- Param: _file
- Param: _src
- Param: _pitch (optional, default 1)
- Param: _dist (optional, default 10)
- Param: _preendbuf (optional, default 0)
- Param: _vol (optional, default 1)

File: [client\VoiceSystem\ReVoice\AudioSystem.sqf at line 181](../../../Src/client/VoiceSystem/ReVoice/AudioSystem.sqf#L181)
## vs_audio_onUpdate

Type: function

Description: followed sounds
- Param: _id
- Param: _obj
- Param: _offset
- Param: _distance
- Param: _nextEffectUpd

File: [client\VoiceSystem\ReVoice\AudioSystem.sqf at line 204](../../../Src/client/VoiceSystem/ReVoice/AudioSystem.sqf#L204)
## vs_audio_onUpdateLooped

Type: function

Description: 
- Param: _src
- Param: _shndl
- Param: _preend
- Param: _sdata

File: [client\VoiceSystem\ReVoice\AudioSystem.sqf at line 241](../../../Src/client/VoiceSystem/ReVoice/AudioSystem.sqf#L241)
## vs_audio_playSound2d

Type: function

Description: 
- Param: _soundPath
- Param: _pitch (optional, default 1)
- Param: _offset (optional, default 0)
- Param: _vol (optional, default 1)
- Param: _useEffects (optional, default true)
- Param: _loop (optional, default false)

File: [client\VoiceSystem\ReVoice\AudioSystem.sqf at line 288](../../../Src/client/VoiceSystem/ReVoice/AudioSystem.sqf#L288)
## vs_audio_internal_getSourceObj

Type: function

Description: 


File: [client\VoiceSystem\ReVoice\AudioSystem.sqf at line 293](../../../Src/client/VoiceSystem/ReVoice/AudioSystem.sqf#L293)
## vs_audio_setSoundPos

Type: function

Description: 
- Param: _id
- Param: _pos

File: [client\VoiceSystem\ReVoice\AudioSystem.sqf at line 298](../../../Src/client/VoiceSystem/ReVoice/AudioSystem.sqf#L298)
## vs_audio_setPaused

Type: function

Description: 
- Param: _id
- Param: _paused

File: [client\VoiceSystem\ReVoice\AudioSystem.sqf at line 305](../../../Src/client/VoiceSystem/ReVoice/AudioSystem.sqf#L305)
## vs_audio_setLowpassEffect

Type: function

Description: 
- Param: _id
- Param: _cut (optional, default 22000)
- Param: _res (optional, default 10)

File: [client\VoiceSystem\ReVoice\AudioSystem.sqf at line 310](../../../Src/client/VoiceSystem/ReVoice/AudioSystem.sqf#L310)
## vs_audio_setReverbEffect

Type: function

Description: 
- Param: _id
- Param: _dec (optional, default 1200)
- Param: _edel (optional, default 20)
- Param: _ldel (optional, default 40)
- Param: _hcut (optional, default 8000)
- Param: _wet (optional, default -80)
- Param: _dry (optional, default 0)

File: [client\VoiceSystem\ReVoice\AudioSystem.sqf at line 315](../../../Src/client/VoiceSystem/ReVoice/AudioSystem.sqf#L315)
## vs_audio_getSoundParams

Type: function

Description: Returns [progress 0..1, current time seconds, duration seconds].
- Param: _id

File: [client\VoiceSystem\ReVoice\AudioSystem.sqf at line 321](../../../Src/client/VoiceSystem/ReVoice/AudioSystem.sqf#L321)
## vs_audio_setLoopPoints

Type: function

Description: 
- Param: _id
- Param: _startMs
- Param: _endMs

File: [client\VoiceSystem\ReVoice\AudioSystem.sqf at line 327](../../../Src/client/VoiceSystem/ReVoice/AudioSystem.sqf#L327)
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
## REQ_GET_MASTER_VOICE_VOLUME

Type: constant

Description: 


Replaced value:
```sqf
"getMasterVoiceVolume"
```
File: [client\VoiceSystem\ReVoice\ReVoice.h at line 21](../../../Src/client/VoiceSystem/ReVoice/ReVoice.h#L21)
## REQ_GET_VOICE_DIAGNOSTICS

Type: constant

Description: 


Replaced value:
```sqf
"getVoiceDiagnostics"
```
File: [client\VoiceSystem\ReVoice\ReVoice.h at line 22](../../../Src/client/VoiceSystem/ReVoice/ReVoice.h#L22)
## REQ_GET_VOICE_NETWORK_DIAGNOSTICS

Type: constant

Description: 


Replaced value:
```sqf
"getVoiceNetworkDiagnostics"
```
File: [client\VoiceSystem\ReVoice\ReVoice.h at line 23](../../../Src/client/VoiceSystem/ReVoice/ReVoice.h#L23)
## REQ_GET_VOICE_LISTENER_DIAGNOSTICS

Type: constant

Description: 


Replaced value:
```sqf
"getVoiceListenerDiagnostics"
```
File: [client\VoiceSystem\ReVoice\ReVoice.h at line 24](../../../Src/client/VoiceSystem/ReVoice/ReVoice.h#L24)
## REQ_GET_PERSONAL_VOICE_CHANNEL

Type: constant

Description: 


Replaced value:
```sqf
"getPersonalVoiceChannel"
```
File: [client\VoiceSystem\ReVoice\ReVoice.h at line 25](../../../Src/client/VoiceSystem/ReVoice/ReVoice.h#L25)
## REQ_GET_LAST_LOGS

Type: constant

Description: 


Replaced value:
```sqf
"getLastLogs"
```
File: [client\VoiceSystem\ReVoice\ReVoice.h at line 26](../../../Src/client/VoiceSystem/ReVoice/ReVoice.h#L26)
## REQ_GET_LOG_PATH

Type: constant

Description: 


Replaced value:
```sqf
"getLogPath"
```
File: [client\VoiceSystem\ReVoice\ReVoice.h at line 27](../../../Src/client/VoiceSystem/ReVoice/ReVoice.h#L27)
## CMD_CONNECT_VOICE

Type: constant

Description: =============== api command ===========================


Replaced value:
```sqf
"connectVoice"
```
File: [client\VoiceSystem\ReVoice\ReVoice.h at line 30](../../../Src/client/VoiceSystem/ReVoice/ReVoice.h#L30)
## CMD_GET_MIC_DEVICES

Type: constant

Description: 


Replaced value:
```sqf
"getMicDevices"
```
File: [client\VoiceSystem\ReVoice\ReVoice.h at line 32](../../../Src/client/VoiceSystem/ReVoice/ReVoice.h#L32)
## CMD_SET_MIC_DEVICE

Type: constant

Description: 


Replaced value:
```sqf
"setMicDevice"
```
File: [client\VoiceSystem\ReVoice\ReVoice.h at line 33](../../../Src/client/VoiceSystem/ReVoice/ReVoice.h#L33)
## CMD_GET_PLAYBACK_DEVICES

Type: constant

Description: 


Replaced value:
```sqf
"getPlaybackDevices"
```
File: [client\VoiceSystem\ReVoice\ReVoice.h at line 34](../../../Src/client/VoiceSystem/ReVoice/ReVoice.h#L34)
## CMD_SET_PLAYBACK_DEVICE

Type: constant

Description: 


Replaced value:
```sqf
"setPlaybackDevice"
```
File: [client\VoiceSystem\ReVoice\ReVoice.h at line 35](../../../Src/client/VoiceSystem/ReVoice/ReVoice.h#L35)
## CMD_SET_MASTER_VOICE_VOLUME

Type: constant

Description: 


Replaced value:
```sqf
"setMasterVoiceVolume"
```
File: [client\VoiceSystem\ReVoice\ReVoice.h at line 37](../../../Src/client/VoiceSystem/ReVoice/ReVoice.h#L37)
## CMD_SET_TEST_VOICE_ENABLED

Type: constant

Description: 


Replaced value:
```sqf
"setTestVoiceEnabled"
```
File: [client\VoiceSystem\ReVoice\ReVoice.h at line 38](../../../Src/client/VoiceSystem/ReVoice/ReVoice.h#L38)
## CMD_GET_ALL_CLIENTS

Type: constant

Description: 


Replaced value:
```sqf
"getAllClients"
```
File: [client\VoiceSystem\ReVoice\ReVoice.h at line 40](../../../Src/client/VoiceSystem/ReVoice/ReVoice.h#L40)
## CMD_SYNC_LOCAL_PLAYER

Type: constant

Description: 


Replaced value:
```sqf
"syncLocalPlayer"
```
File: [client\VoiceSystem\ReVoice\ReVoice.h at line 42](../../../Src/client/VoiceSystem/ReVoice/ReVoice.h#L42)
## CMD_SYNC_REMOTE_PLAYER

Type: constant

Description: 


Replaced value:
```sqf
"syncRemotePlayer"
```
File: [client\VoiceSystem\ReVoice\ReVoice.h at line 43](../../../Src/client/VoiceSystem/ReVoice/ReVoice.h#L43)
## CMD_ENSURE_PERSONAL_VOICE_CHANNEL

Type: constant

Description: 


Replaced value:
```sqf
"ensurePersonalVoiceChannel"
```
File: [client\VoiceSystem\ReVoice\ReVoice.h at line 44](../../../Src/client/VoiceSystem/ReVoice/ReVoice.h#L44)
## CMD_SET_VOICE_LISTENERS

Type: constant

Description: 


Replaced value:
```sqf
"setVoiceListeners"
```
File: [client\VoiceSystem\ReVoice\ReVoice.h at line 45](../../../Src/client/VoiceSystem/ReVoice/ReVoice.h#L45)
## CMD_CLEAR_VOICE_LISTENERS

Type: constant

Description: 


Replaced value:
```sqf
"clearVoiceListeners"
```
File: [client\VoiceSystem\ReVoice\ReVoice.h at line 46](../../../Src/client/VoiceSystem/ReVoice/ReVoice.h#L46)
## CMD_SETLOWPASS

Type: constant

Description: 


Replaced value:
```sqf
"setLowpass"
```
File: [client\VoiceSystem\ReVoice\ReVoice.h at line 48](../../../Src/client/VoiceSystem/ReVoice/ReVoice.h#L48)
## CMD_SETREVERB

Type: constant

Description: 


Replaced value:
```sqf
"setReverb"
```
File: [client\VoiceSystem\ReVoice\ReVoice.h at line 49](../../../Src/client/VoiceSystem/ReVoice/ReVoice.h#L49)
## CMD_RADIO_ADD

Type: constant

Description: radio commands


Replaced value:
```sqf
"addRadio"
```
File: [client\VoiceSystem\ReVoice\ReVoice.h at line 52](../../../Src/client/VoiceSystem/ReVoice/ReVoice.h#L52)
## CMD_RADIO_REMOVE

Type: constant

Description: 


Replaced value:
```sqf
"removeRadio"
```
File: [client\VoiceSystem\ReVoice\ReVoice.h at line 53](../../../Src/client/VoiceSystem/ReVoice/ReVoice.h#L53)
## CMD_RADIO_SUBSCRIBE_RADIOSTREAM

Type: constant

Description: 


Replaced value:
```sqf
"subscribeRadio"
```
File: [client\VoiceSystem\ReVoice\ReVoice.h at line 55](../../../Src/client/VoiceSystem/ReVoice/ReVoice.h#L55)
## CMD_RADIO_APPLY_WAVE_FILTER

Type: constant

Description: 


Replaced value:
```sqf
"applyRadioWaveFilter"
```
File: [client\VoiceSystem\ReVoice\ReVoice.h at line 56](../../../Src/client/VoiceSystem/ReVoice/ReVoice.h#L56)
## CMD_SYNC_REMOTE_RADIO

Type: constant

Description: 


Replaced value:
```sqf
"syncRemoteRadio"
```
File: [client\VoiceSystem\ReVoice\ReVoice.h at line 57](../../../Src/client/VoiceSystem/ReVoice/ReVoice.h#L57)
## CMD_SYNC_REMOTE_RADIO_LOWPASS

Type: constant

Description: 


Replaced value:
```sqf
"syncRemoteRadioLowpass"
```
File: [client\VoiceSystem\ReVoice\ReVoice.h at line 58](../../../Src/client/VoiceSystem/ReVoice/ReVoice.h#L58)
## CMD_SYNC_REMOTE_RADIO_REVERB

Type: constant

Description: 


Replaced value:
```sqf
"syncRemoteRadioReverb"
```
File: [client\VoiceSystem\ReVoice\ReVoice.h at line 59](../../../Src/client/VoiceSystem/ReVoice/ReVoice.h#L59)
## REQ_AUDIO_GET_ALL_SOUNDS_IDS

Type: constant

Description: requests


Replaced value:
```sqf
"audioGetAllSoundsIds"
```
File: [client\VoiceSystem\ReVoice\ReVoice.h at line 65](../../../Src/client/VoiceSystem/ReVoice/ReVoice.h#L65)
## REQ_AUDIO_GET_MASTER_SOUND_VOLUME

Type: constant

Description: 


Replaced value:
```sqf
"audioGetMasterSoundVolume"
```
File: [client\VoiceSystem\ReVoice\ReVoice.h at line 66](../../../Src/client/VoiceSystem/ReVoice/ReVoice.h#L66)
## REQ_AUDIO_RELEASE_ALL_SOUNDS

Type: constant

Description: 


Replaced value:
```sqf
"audioReleaseAllSounds"
```
File: [client\VoiceSystem\ReVoice\ReVoice.h at line 67](../../../Src/client/VoiceSystem/ReVoice/ReVoice.h#L67)
## CMD_AUDIO_LOADLIB

Type: constant

Description: commands


Replaced value:
```sqf
"audioLoadLib"
```
File: [client\VoiceSystem\ReVoice\ReVoice.h at line 70](../../../Src/client/VoiceSystem/ReVoice/ReVoice.h#L70)
## CMD_AUDIO_UNLOADLIB

Type: constant

Description: 


Replaced value:
```sqf
"audioUnloadLib"
```
File: [client\VoiceSystem\ReVoice\ReVoice.h at line 71](../../../Src/client/VoiceSystem/ReVoice/ReVoice.h#L71)
## CMD_AUDIO_PLAY_SOUND

Type: constant

Description: 


Replaced value:
```sqf
"audioPlaySound"
```
File: [client\VoiceSystem\ReVoice\ReVoice.h at line 72](../../../Src/client/VoiceSystem/ReVoice/ReVoice.h#L72)
## CMD_AUDIO_IS_SOUND_EXISTS

Type: constant

Description: 


Replaced value:
```sqf
"audioIsSoundExists"
```
File: [client\VoiceSystem\ReVoice\ReVoice.h at line 73](../../../Src/client/VoiceSystem/ReVoice/ReVoice.h#L73)
## CMD_AUDIO_STOP_SOUND

Type: constant

Description: 


Replaced value:
```sqf
"audioStopSound"
```
File: [client\VoiceSystem\ReVoice\ReVoice.h at line 74](../../../Src/client/VoiceSystem/ReVoice/ReVoice.h#L74)
## CMD_AUDIO_SET_MASTER_SOUND_VOLUME

Type: constant

Description: 


Replaced value:
```sqf
"audioSetMasterSoundVolume"
```
File: [client\VoiceSystem\ReVoice\ReVoice.h at line 75](../../../Src/client/VoiceSystem/ReVoice/ReVoice.h#L75)
## CMD_AUDIO_SET_SOUND_POS

Type: constant

Description: 


Replaced value:
```sqf
"audioSetSoundPos"
```
File: [client\VoiceSystem\ReVoice\ReVoice.h at line 76](../../../Src/client/VoiceSystem/ReVoice/ReVoice.h#L76)
## CMD_AUDIO_SET_PAUSED

Type: constant

Description: 


Replaced value:
```sqf
"audioSetSoundPaused"
```
File: [client\VoiceSystem\ReVoice\ReVoice.h at line 77](../../../Src/client/VoiceSystem/ReVoice/ReVoice.h#L77)
## CMD_AUDIO_SETLOWPASS

Type: constant

Description: 


Replaced value:
```sqf
"audioSetLowpass"
```
File: [client\VoiceSystem\ReVoice\ReVoice.h at line 78](../../../Src/client/VoiceSystem/ReVoice/ReVoice.h#L78)
## CMD_AUDIO_SETREVERB

Type: constant

Description: 


Replaced value:
```sqf
"audioSetReverb"
```
File: [client\VoiceSystem\ReVoice\ReVoice.h at line 79](../../../Src/client/VoiceSystem/ReVoice/ReVoice.h#L79)
## CMD_AUDIO_SET_LOOP_POINTS

Type: constant

Description: 


Replaced value:
```sqf
"audioSetLoopPoints"
```
File: [client\VoiceSystem\ReVoice\ReVoice.h at line 80](../../../Src/client/VoiceSystem/ReVoice/ReVoice.h#L80)
## CMD_AUDIO_GET_SOUND_PARAMS

Type: constant

Description: 


Replaced value:
```sqf
"audioGetSoundParams"
```
File: [client\VoiceSystem\ReVoice\ReVoice.h at line 81](../../../Src/client/VoiceSystem/ReVoice/ReVoice.h#L81)
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
"stable_v5_with_subscribers"
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
## vs_voiceListenersEnabled

Type: Variable

Description: 


Initial value:
```sqf
true
```
File: [client\VoiceSystem\ReVoice\ReVoice_init.sqf at line 23](../../../Src/client/VoiceSystem/ReVoice/ReVoice_init.sqf#L23)
## vs_voiceListenerReady

Type: Variable

Description: 


Initial value:
```sqf
false
```
File: [client\VoiceSystem\ReVoice\ReVoice_init.sqf at line 24](../../../Src/client/VoiceSystem/ReVoice/ReVoice_init.sqf#L24)
## vs_voiceListenerMaxTargets

Type: Variable

Description: 


Initial value:
```sqf
10
```
File: [client\VoiceSystem\ReVoice\ReVoice_init.sqf at line 25](../../../Src/client/VoiceSystem/ReVoice/ReVoice_init.sqf#L25)
## vs_voiceListenerEnterDistance

Type: Variable

Description: 


Initial value:
```sqf
vs_max_voice_volume
```
File: [client\VoiceSystem\ReVoice\ReVoice_init.sqf at line 26](../../../Src/client/VoiceSystem/ReVoice/ReVoice_init.sqf#L26)
## vs_voiceListenerExitDistance

Type: Variable

Description: 


Initial value:
```sqf
vs_max_voice_volume + 10
```
File: [client\VoiceSystem\ReVoice\ReVoice_init.sqf at line 27](../../../Src/client/VoiceSystem/ReVoice/ReVoice_init.sqf#L27)
## vs_voiceListenerLingerTime

Type: Variable

Description: 


Initial value:
```sqf
10
```
File: [client\VoiceSystem\ReVoice\ReVoice_init.sqf at line 28](../../../Src/client/VoiceSystem/ReVoice/ReVoice_init.sqf#L28)
## vs_voiceListenerUpdateDelay

Type: Variable

Description: 


Initial value:
```sqf
2
```
File: [client\VoiceSystem\ReVoice\ReVoice_init.sqf at line 29](../../../Src/client/VoiceSystem/ReVoice/ReVoice_init.sqf#L29)
## vs_voiceListenerUpdateJitter

Type: Variable

Description: 


Initial value:
```sqf
0.5
```
File: [client\VoiceSystem\ReVoice\ReVoice_init.sqf at line 30](../../../Src/client/VoiceSystem/ReVoice/ReVoice_init.sqf#L30)
## vs_voiceListenerRetryDelay

Type: Variable

Description: 


Initial value:
```sqf
1
```
File: [client\VoiceSystem\ReVoice\ReVoice_init.sqf at line 31](../../../Src/client/VoiceSystem/ReVoice/ReVoice_init.sqf#L31)
## vs_voiceListenerRadioTtl

Type: Variable

Description: 


Initial value:
```sqf
2
```
File: [client\VoiceSystem\ReVoice\ReVoice_init.sqf at line 32](../../../Src/client/VoiceSystem/ReVoice/ReVoice_init.sqf#L32)
## vs_voiceListenerNextUpdate

Type: Variable

Description: 


Initial value:
```sqf
0
```
File: [client\VoiceSystem\ReVoice\ReVoice_init.sqf at line 33](../../../Src/client/VoiceSystem/ReVoice/ReVoice_init.sqf#L33)
## vs_voiceListenerNextEnsure

Type: Variable

Description: 


Initial value:
```sqf
0
```
File: [client\VoiceSystem\ReVoice\ReVoice_init.sqf at line 34](../../../Src/client/VoiceSystem/ReVoice/ReVoice_init.sqf#L34)
## vs_voiceListenerLastPayload

Type: Variable

Description: 


Initial value:
```sqf
""
```
File: [client\VoiceSystem\ReVoice\ReVoice_init.sqf at line 35](../../../Src/client/VoiceSystem/ReVoice/ReVoice_init.sqf#L35)
## vs_voiceListenerTargets

Type: Variable

Description: 


Initial value:
```sqf
[]
```
File: [client\VoiceSystem\ReVoice\ReVoice_init.sqf at line 36](../../../Src/client/VoiceSystem/ReVoice/ReVoice_init.sqf#L36)
## vs_voiceListenerExpires

Type: Variable

Description: 


Initial value:
```sqf
createHashMap
```
File: [client\VoiceSystem\ReVoice\ReVoice_init.sqf at line 37](../../../Src/client/VoiceSystem/ReVoice/ReVoice_init.sqf#L37)
## vs_voiceListenerRadioRequired

Type: Variable

Description: 


Initial value:
```sqf
createHashMap
```
File: [client\VoiceSystem\ReVoice\ReVoice_init.sqf at line 38](../../../Src/client/VoiceSystem/ReVoice/ReVoice_init.sqf#L38)
## vs_voipVolCurrent

Type: Variable

Description: 


Initial value:
```sqf
clamp(vs_voipVolCurrent,0,10)
```
File: [client\VoiceSystem\ReVoice\ReVoice_init.sqf at line 44](../../../Src/client/VoiceSystem/ReVoice/ReVoice_init.sqf#L44)
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
File: [client\VoiceSystem\ReVoice\Speaker.sqf at line 322](../../../Src/client/VoiceSystem/ReVoice/Speaker.sqf#L322)
## vs_isTalkingOnRadio

Type: Variable

Description: 


Initial value:
```sqf
false
```
File: [client\VoiceSystem\ReVoice\Speaker.sqf at line 323](../../../Src/client/VoiceSystem/ReVoice/Speaker.sqf#L323)
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

File: [client\VoiceSystem\ReVoice\Speaker.sqf at line 273](../../../Src/client/VoiceSystem/ReVoice/Speaker.sqf#L273)
## vs_getNearReceiverRadioObjects

Type: function

Description: возвращает ближайшие радио которые могут слышать игрока


File: [client\VoiceSystem\ReVoice\Speaker.sqf at line 298](../../../Src/client/VoiceSystem/ReVoice/Speaker.sqf#L298)
## vs_handleMicRadioObjects

Type: function

Description: обработчик общения по рации. вызывается внутри апи обычного войса
- Param: _mode

File: [client\VoiceSystem\ReVoice\Speaker.sqf at line 326](../../../Src/client/VoiceSystem/ReVoice/Speaker.sqf#L326)
## vs_processUpdateMicRadioObjects

Type: function

Description: процесс обновления списка объектов для записи


File: [client\VoiceSystem\ReVoice\Speaker.sqf at line 344](../../../Src/client/VoiceSystem/ReVoice/Speaker.sqf#L344)
## vs_onClientDisconnected

Type: function

Description: высвобождает ресурсы клиента, который отключился от сервера с включенным войсом по радио
- Param: _clientName

File: [client\VoiceSystem\ReVoice\Speaker.sqf at line 374](../../../Src/client/VoiceSystem/ReVoice/Speaker.sqf#L374)
## vs_debug_TestMobSpeaking

Type: function

> Exists if **EDITOR** defined

Description: 


File: [client\VoiceSystem\ReVoice\Speaker.sqf at line 389](../../../Src/client/VoiceSystem/ReVoice/Speaker.sqf#L389)
