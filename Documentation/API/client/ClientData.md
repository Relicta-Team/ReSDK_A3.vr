# ClientData.hpp

## SKILL_BASE

Type: constant

Description: dependences for gurps.hpp


Replaced value:
```sqf
0
```
File: [client\ClientData\ClientData.hpp at line 8](../../../Src/client/ClientData/ClientData.hpp#L8)
## SKILL_MOD

Type: constant

Description: 


Replaced value:
```sqf
1
```
File: [client\ClientData\ClientData.hpp at line 9](../../../Src/client/ClientData/ClientData.hpp#L9)
## VIDEO_SETTINGS_MAX

Type: constant

Description: 


Replaced value:
```sqf
1
```
File: [client\ClientData\ClientData.hpp at line 12](../../../Src/client/ClientData/ClientData.hpp#L12)
## VIDEO_SETTINGS_MIN

Type: constant

Description: 


Replaced value:
```sqf
0
```
File: [client\ClientData\ClientData.hpp at line 13](../../../Src/client/ClientData/ClientData.hpp#L13)
# ClientData.sqf

## sk_nan

Type: constant

Description: 


Replaced value:
```sqf
[0,0]
```
File: [client\ClientData\ClientData.sqf at line 44](../../../Src/client/ClientData/ClientData.sqf#L44)
## printerr(code,text)

Type: constant

Description: 
- Param: code
- Param: text

Replaced value:
```sqf
if (_code == code) exitWith {[text] call (getDisplay getVariable ["printError",{}])}
```
File: [client\ClientData\ClientData.sqf at line 491](../../../Src/client/ClientData/ClientData.sqf#L491)
## cd_clientName

Type: Variable

Description: уникальное имя клиента


Initial value:
```sqf
""
```
File: [client\ClientData\ClientData.sqf at line 41](../../../Src/client/ClientData/ClientData.sqf#L41)
## cd_charName

Type: Variable

Description: 


Initial value:
```sqf
"Обитатель Сети"
```
File: [client\ClientData\ClientData.sqf at line 42](../../../Src/client/ClientData/ClientData.sqf#L42)
## cd_skillNames

Type: Variable

Description: 


Initial value:
```sqf
["СЛ","ИН","ЛВ","ЗД","ВНС","ВОЛЯ","ВОС","ЖЗ"]
```
File: [client\ClientData\ClientData.sqf at line 45](../../../Src/client/ClientData/ClientData.sqf#L45)
## cd_skills

Type: Variable

Description: 


Initial value:
```sqf
[sk_nan,sk_nan,sk_nan,sk_nan,sk_nan,sk_nan,sk_nan,sk_nan] //массив со скиллами
```
File: [client\ClientData\ClientData.sqf at line 46](../../../Src/client/ClientData/ClientData.sqf#L46)
## cd_stamina_cur

Type: Variable

Description: stamina vars


Initial value:
```sqf
100
```
File: [client\ClientData\ClientData.sqf at line 49](../../../Src/client/ClientData/ClientData.sqf#L49)
## cd_stamina_max

Type: Variable

Description: 


Initial value:
```sqf
100
```
File: [client\ClientData\ClientData.sqf at line 50](../../../Src/client/ClientData/ClientData.sqf#L50)
## cd_curSelection

Type: Variable

Description: текущая зона взаимодействия


Initial value:
```sqf
TARGET_ZONE_TORSO
```
File: [client\ClientData\ClientData.sqf at line 80](../../../Src/client/ClientData/ClientData.sqf#L80)
## cd_specialAction

Type: Variable

Description: 


Initial value:
```sqf
SPECIAL_ACTION_NO
```
File: [client\ClientData\ClientData.sqf at line 81](../../../Src/client/ClientData/ClientData.sqf#L81)
## cd_curDefType

Type: Variable

Description: комбат штуки


Initial value:
```sqf
DEF_TYPE_DODGE
```
File: [client\ClientData\ClientData.sqf at line 84](../../../Src/client/ClientData/ClientData.sqf#L84)
## cd_curCombatStyle

Type: Variable

Description: 


Initial value:
```sqf
COMBAT_STYLE_ATTACK
```
File: [client\ClientData\ClientData.sqf at line 85](../../../Src/client/ClientData/ClientData.sqf#L85)
## cd_curAttackType

Type: Variable

Description: 


Initial value:
```sqf
ATTACK_TYPE_THRUST
```
File: [client\ClientData\ClientData.sqf at line 86](../../../Src/client/ClientData/ClientData.sqf#L86)
## cd_activeHand

Type: Variable

Description: 


Initial value:
```sqf
INV_HAND_L
```
File: [client\ClientData\ClientData.sqf at line 88](../../../Src/client/ClientData/ClientData.sqf#L88)
## cd_lca_r

Type: Variable

Description: last combat action colorizer


Initial value:
```sqf
0
```
File: [client\ClientData\ClientData.sqf at line 90](../../../Src/client/ClientData/ClientData.sqf#L90)
## cd_lca_l

Type: Variable

Description: 


Initial value:
```sqf
0
```
File: [client\ClientData\ClientData.sqf at line 91](../../../Src/client/ClientData/ClientData.sqf#L91)
## cd_cameraSetting

Type: Variable

Description: 


Initial value:
```sqf
CAMERA_MODE_ARCADE
```
File: [client\ClientData\ClientData.sqf at line 93](../../../Src/client/ClientData/ClientData.sqf#L93)
## cd_videoSettings

Type: Variable

Description: 


Initial value:
```sqf
VIDEO_SETTINGS_MAX //пользовательские настройки графики
```
File: [client\ClientData\ClientData.sqf at line 96](../../../Src/client/ClientData/ClientData.sqf#L96)
## cd_internal_lastTPPos

Type: Variable

Description: 


Initial value:
```sqf
vec3(0,0,0)
```
File: [client\ClientData\ClientData.sqf at line 216](../../../Src/client/ClientData/ClientData.sqf#L216)
## cd_internal_lastTPDir

Type: Variable

Description: 


Initial value:
```sqf
null
```
File: [client\ClientData\ClientData.sqf at line 217](../../../Src/client/ClientData/ClientData.sqf#L217)
## cd_internal_tpHandle

Type: Variable

Description: 


Initial value:
```sqf
-1
```
File: [client\ClientData\ClientData.sqf at line 218](../../../Src/client/ClientData/ClientData.sqf#L218)
## cd_internal_hasTPError

Type: Variable

Description: 


Initial value:
```sqf
false
```
File: [client\ClientData\ClientData.sqf at line 219](../../../Src/client/ClientData/ClientData.sqf#L219)
## cd_internal_lastTPObj

Type: Variable

Description: 


Initial value:
```sqf
objnull
```
File: [client\ClientData\ClientData.sqf at line 220](../../../Src/client/ClientData/ClientData.sqf#L220)
## cd_internal_startLoadTime

Type: Variable

Description: 


Initial value:
```sqf
0
```
File: [client\ClientData\ClientData.sqf at line 221](../../../Src/client/ClientData/ClientData.sqf#L221)
## cd_setVideoSettings

Type: function

Description: пользовательские настройки графики
- Param: _value

File: [client\ClientData\ClientData.sqf at line 97](../../../Src/client/ClientData/ClientData.sqf#L97)
## cd_openAuth

Type: function

Description: Открытие окна регистрации клиента
- Param: _mes

File: [client\ClientData\ClientData.sqf at line 380](../../../Src/client/ClientData/ClientData.sqf#L380)
## repl_doLocal

Type: function

Description: 
- Param: _method
- Param: _ctx

File: [client\ClientData\ClientData.sqf at line 557](../../../Src/client/ClientData/ClientData.sqf#L557)
# ClientDataUnconscious.sqf

## __UNCONSCIOUS_DELAY__

Type: constant

Description: Задержка между проверками. Каждые 100 мс


Replaced value:
```sqf
0.1
```
File: [client\ClientData\ClientDataUnconscious.sqf at line 14](../../../Src/client/ClientData/ClientDataUnconscious.sqf#L14)
## cd_isUnconscious

Type: Variable

Description: 


Initial value:
```sqf
false //в бессознанке
```
File: [client\ClientData\ClientDataUnconscious.sqf at line 16](../../../Src/client/ClientData/ClientDataUnconscious.sqf#L16)
## cd_internal_uncState

Type: Variable

Description: в бессознанке


Initial value:
```sqf
false //внутрення переменная перехода состояния
```
File: [client\ClientData\ClientDataUnconscious.sqf at line 17](../../../Src/client/ClientData/ClientDataUnconscious.sqf#L17)
## cd_onUnconsciousEvent

Type: function

Description: например замутить персонажа, закрыть все дисплеи и тд.
- Param: _isUncState

File: [client\ClientData\ClientDataUnconscious.sqf at line 30](../../../Src/client/ClientData/ClientDataUnconscious.sqf#L30)
# ClientData_ConnectionManager.sqf

## PREPARE_PLAYER_POS_TIMEOUT

Type: constant

Description: 


Replaced value:
```sqf
120
```
File: [client\ClientData\ClientData_ConnectionManager.sqf at line 8](../../../Src/client/ClientData/ClientData_ConnectionManager.sqf#L8)
## SWITCH_PLAYER_TIMEOUT

Type: constant

Description: 


Replaced value:
```sqf
30
```
File: [client\ClientData\ClientData_ConnectionManager.sqf at line 10](../../../Src/client/ClientData/ClientData_ConnectionManager.sqf#L10)
## client_state

Type: Variable

Description: 


Initial value:
```sqf
"init"
```
File: [client\ClientData\ClientData_ConnectionManager.sqf at line 14](../../../Src/client/ClientData/ClientData_ConnectionManager.sqf#L14)
## client_getState

Type: function

Description: 


File: [client\ClientData\ClientData_ConnectionManager.sqf at line 15](../../../Src/client/ClientData/ClientData_ConnectionManager.sqf#L15)
## client_setState

Type: function

Description: 


File: [client\ClientData\ClientData_ConnectionManager.sqf at line 16](../../../Src/client/ClientData/ClientData_ConnectionManager.sqf#L16)
## client_isInGame

Type: function

Description: 


File: [client\ClientData\ClientData_ConnectionManager.sqf at line 17](../../../Src/client/ClientData/ClientData_ConnectionManager.sqf#L17)
## client_isInLobby

Type: function

Description: 


File: [client\ClientData\ClientData_ConnectionManager.sqf at line 18](../../../Src/client/ClientData/ClientData_ConnectionManager.sqf#L18)
## cd_processConnection

Type: function

Description: Внутренний интрфейс подключения к мобу или безголовому клиенту
- Param: _isLinkTo
- Param: _mob
- Param: _prepareNextMode

File: [client\ClientData\ClientData_ConnectionManager.sqf at line 55](../../../Src/client/ClientData/ClientData_ConnectionManager.sqf#L55)
## cd_connectToMob

Type: function

Description: Подключаемся к мобу
- Param: _mob
- Param: _nextAction (optional, default -1)

File: [client\ClientData\ClientData_ConnectionManager.sqf at line 175](../../../Src/client/ClientData/ClientData_ConnectionManager.sqf#L175)
# ClientData_customAnims.sqf

## cd_customAnim

Type: Variable

Description: 


Initial value:
```sqf
CUSTOM_ANIM_NONE
```
File: [client\ClientData\ClientData_customAnims.sqf at line 8](../../../Src/client/ClientData/ClientData_customAnims.sqf#L8)
## cd_isCustomAnimEnabled

Type: function

Description: 


File: [client\ClientData\ClientData_customAnims.sqf at line 10](../../../Src/client/ClientData/ClientData_customAnims.sqf#L10)
## cd_handleRestCustomAnim

Type: function

Description: 


File: [client\ClientData\ClientData_customAnims.sqf at line 14](../../../Src/client/ClientData/ClientData_customAnims.sqf#L14)
# ClientData_forceWalk.sqf

## cd_fw_forceWalk

Type: Variable

Description: системный флаг блокировки бега (когда персонаж без ноги)


Initial value:
```sqf
false
```
File: [client\ClientData\ClientData_forceWalk.sqf at line 18](../../../Src/client/ClientData/ClientData_forceWalk.sqf#L18)
## cd_fw_hasBreakBone

Type: Variable

Description: сломанные кости на ногах записываются сюда


Initial value:
```sqf
false
```
File: [client\ClientData\ClientData_forceWalk.sqf at line 20](../../../Src/client/ClientData/ClientData_forceWalk.sqf#L20)
## cd_sp_enabled

Type: Variable

Description: sprint sync


Initial value:
```sqf
true
```
File: [client\ClientData\ClientData_forceWalk.sqf at line 31](../../../Src/client/ClientData/ClientData_forceWalk.sqf#L31)
## cd_sp_lockedSetting

Type: Variable

Description: 


Initial value:
```sqf
false
```
File: [client\ClientData\ClientData_forceWalk.sqf at line 32](../../../Src/client/ClientData/ClientData_forceWalk.sqf#L32)
## cd_fw_isForceWalk

Type: function

Description: 


File: [client\ClientData\ClientData_forceWalk.sqf at line 21](../../../Src/client/ClientData/ClientData_forceWalk.sqf#L21)
## cd_fw_syncForceWalk

Type: function

Description: 
- Param: _mob

File: [client\ClientData\ClientData_forceWalk.sqf at line 22](../../../Src/client/ClientData/ClientData_forceWalk.sqf#L22)
## cd_sp_canSprint

Type: function

Description: 


File: [client\ClientData\ClientData_forceWalk.sqf at line 33](../../../Src/client/ClientData/ClientData_forceWalk.sqf#L33)
# EscapeMenu.sqf

## ESC_MENU_SIZE_X

Type: constant

Description: 


Replaced value:
```sqf
20
```
File: [client\ClientData\EscapeMenu.sqf at line 8](../../../Src/client/ClientData/EscapeMenu.sqf#L8)
## ESC_MENU_SIZE_Y

Type: constant

Description: 


Replaced value:
```sqf
30
```
File: [client\ClientData\EscapeMenu.sqf at line 9](../../../Src/client/ClientData/EscapeMenu.sqf#L9)
## ESC_MENU_DEFAULT_BUTTON_BIAS_X

Type: constant

Description: 


Replaced value:
```sqf
5
```
File: [client\ClientData\EscapeMenu.sqf at line 10](../../../Src/client/ClientData/EscapeMenu.sqf#L10)
## ESC_MENU_DEFAULT_BUTTON_BIAS_Y

Type: constant

Description: 


Replaced value:
```sqf
5
```
File: [client\ClientData\EscapeMenu.sqf at line 11](../../../Src/client/ClientData/EscapeMenu.sqf#L11)
## ESC_MENU_BACKGROUND_COLOR_T3

Type: constant

Description: 


Replaced value:
```sqf
0.4
```
File: [client\ClientData\EscapeMenu.sqf at line 13](../../../Src/client/ClientData/EscapeMenu.sqf#L13)
## handleSettings(closerEv,OpenerEv)

Type: constant

Description: 
- Param: closerEv
- Param: OpenerEv

Replaced value:
```sqf
addOpenerAndActivator(OpenerEv); addCloseEventToSetting(closerEv)
```
File: [client\ClientData\EscapeMenu.sqf at line 15](../../../Src/client/ClientData/EscapeMenu.sqf#L15)
## addOpenerAndActivator(id)

Type: constant

Description: 
- Param: id

Replaced value:
```sqf
getDisplay createDisplay  "RscDisplayInterrupt"; ctrlActivate (findDisplay 49 displayCtrl id)
```
File: [client\ClientData\EscapeMenu.sqf at line 16](../../../Src/client/ClientData/EscapeMenu.sqf#L16)
## addCloseEventToSetting(id)

Type: constant

Description: 
- Param: id

Replaced value:
```sqf
(findDisplay id) displayAddEventHandler ["Unload",{(findDisplay 49) closeDisplay 0}]
```
File: [client\ClientData\EscapeMenu.sqf at line 17](../../../Src/client/ClientData/EscapeMenu.sqf#L17)
## ces_video

Type: constant

Description: 


Replaced value:
```sqf
5
```
File: [client\ClientData\EscapeMenu.sqf at line 18](../../../Src/client/ClientData/EscapeMenu.sqf#L18)
## set_ca_video

Type: constant

Description: 


Replaced value:
```sqf
301
```
File: [client\ClientData\EscapeMenu.sqf at line 19](../../../Src/client/ClientData/EscapeMenu.sqf#L19)
## ces_audio

Type: constant

Description: 


Replaced value:
```sqf
6
```
File: [client\ClientData\EscapeMenu.sqf at line 20](../../../Src/client/ClientData/EscapeMenu.sqf#L20)
## set_ca_audio

Type: constant

Description: 


Replaced value:
```sqf
302
```
File: [client\ClientData\EscapeMenu.sqf at line 21](../../../Src/client/ClientData/EscapeMenu.sqf#L21)
## ces_input

Type: constant

Description: 


Replaced value:
```sqf
4
```
File: [client\ClientData\EscapeMenu.sqf at line 22](../../../Src/client/ClientData/EscapeMenu.sqf#L22)
## set_ca_input

Type: constant

Description: 


Replaced value:
```sqf
303
```
File: [client\ClientData\EscapeMenu.sqf at line 23](../../../Src/client/ClientData/EscapeMenu.sqf#L23)
## getEscapeCtg

Type: constant

Description: 


Replaced value:
```sqf
(esc_widgets select 0)
```
File: [client\ClientData\EscapeMenu.sqf at line 29](../../../Src/client/ClientData/EscapeMenu.sqf#L29)
## getSettingsCtg

Type: constant

Description: 


Replaced value:
```sqf
(esc_settings_widgets select 0)
```
File: [client\ClientData\EscapeMenu.sqf at line 194](../../../Src/client/ClientData/EscapeMenu.sqf#L194)
## getSettingsList

Type: constant

Description: 


Replaced value:
```sqf
(esc_settings_widgets select 1)
```
File: [client\ClientData\EscapeMenu.sqf at line 195](../../../Src/client/ClientData/EscapeMenu.sqf#L195)
## getSettingsAccept

Type: constant

Description: 


Replaced value:
```sqf
(esc_settings_widgets select 2)
```
File: [client\ClientData\EscapeMenu.sqf at line 196](../../../Src/client/ClientData/EscapeMenu.sqf#L196)
## getSettingsAbort

Type: constant

Description: 


Replaced value:
```sqf
(esc_settings_widgets select 3)
```
File: [client\ClientData\EscapeMenu.sqf at line 197](../../../Src/client/ClientData/EscapeMenu.sqf#L197)
## ESC_GET_ALL_SETTINGS_TO_FADE

Type: constant

Description: 


Replaced value:
```sqf
[getSettingsAbort,getSettingsAccept,getSettingsList,getSettingsCtg]
```
File: [client\ClientData\EscapeMenu.sqf at line 199](../../../Src/client/ClientData/EscapeMenu.sqf#L199)
## SETTINGS_SIZE_X

Type: constant

Description: 


Replaced value:
```sqf
60
```
File: [client\ClientData\EscapeMenu.sqf at line 201](../../../Src/client/ClientData/EscapeMenu.sqf#L201)
## SETTINGS_SIZE_Y

Type: constant

Description: 


Replaced value:
```sqf
60
```
File: [client\ClientData\EscapeMenu.sqf at line 202](../../../Src/client/ClientData/EscapeMenu.sqf#L202)
## SETTINGS_MENU_BACKGROUND_COLOR_T3

Type: constant

Description: 


Replaced value:
```sqf
ESC_MENU_BACKGROUND_COLOR_T3
```
File: [client\ClientData\EscapeMenu.sqf at line 203](../../../Src/client/ClientData/EscapeMenu.sqf#L203)
## esc_isMenuOpened

Type: Variable

Description: 


Initial value:
```sqf
false
```
File: [client\ClientData\EscapeMenu.sqf at line 25](../../../Src/client/ClientData/EscapeMenu.sqf#L25)
## esc_widgets

Type: Variable

Description: 


Initial value:
```sqf
[widgetNull]
```
File: [client\ClientData\EscapeMenu.sqf at line 26](../../../Src/client/ClientData/EscapeMenu.sqf#L26)
## esc_buttonsData

Type: Variable

Description: 


Initial value:
```sqf
[...
```
File: [client\ClientData\EscapeMenu.sqf at line 32](../../../Src/client/ClientData/EscapeMenu.sqf#L32)
## esc_settings_widgets

Type: Variable

Description: 


Initial value:
```sqf
[widgetNull,widgetNull,widgetNull,widgetNull]
```
File: [client\ClientData\EscapeMenu.sqf at line 210](../../../Src/client/ClientData/EscapeMenu.sqf#L210)
## esc_settings_names

Type: Variable

Description: Порядок настроек строго фиксирован и связан с ServerClient::clientSettings


Initial value:
```sqf
[...
```
File: [client\ClientData\EscapeMenu.sqf at line 212](../../../Src/client/ClientData/EscapeMenu.sqf#L212)
## esc_settings_curIndex

Type: Variable

Description: 


Initial value:
```sqf
-1
```
File: [client\ClientData\EscapeMenu.sqf at line 218](../../../Src/client/ClientData/EscapeMenu.sqf#L218)
## cd_settingsVersion

Type: Variable

Description: 


Initial value:
```sqf
1.0
```
File: [client\ClientData\EscapeMenu.sqf at line 220](../../../Src/client/ClientData/EscapeMenu.sqf#L220)
## esc_openMenu

Type: function

Description: 
- Param: _isOpenedInLobby (optional, default false)

File: [client\ClientData\EscapeMenu.sqf at line 43](../../../Src/client/ClientData/EscapeMenu.sqf#L43)
## esc_confirmExit

Type: function

Description: подтверждение выхода


File: [client\ClientData\EscapeMenu.sqf at line 102](../../../Src/client/ClientData/EscapeMenu.sqf#L102)
## esc_closeMenu

Type: function

Description: 


File: [client\ClientData\EscapeMenu.sqf at line 165](../../../Src/client/ClientData/EscapeMenu.sqf#L165)
## esc_settings_open

Type: function

Description: 


File: [client\ClientData\EscapeMenu.sqf at line 222](../../../Src/client/ClientData/EscapeMenu.sqf#L222)
## esc_settings_close

Type: function

Description: 
- Param: _isSaved (optional, default false)

File: [client\ClientData\EscapeMenu.sqf at line 283](../../../Src/client/ClientData/EscapeMenu.sqf#L283)
## esc_settings_clearSettingList

Type: function

Description: 


File: [client\ClientData\EscapeMenu.sqf at line 309](../../../Src/client/ClientData/EscapeMenu.sqf#L309)
# EscapeMenu_settingsGame.sqf

## SETTING_INDEX_NAME

Type: constant

Description: 


Replaced value:
```sqf
0
```
File: [client\ClientData\EscapeMenu_settingsGame.sqf at line 7](../../../Src/client/ClientData/EscapeMenu_settingsGame.sqf#L7)
## SETTING_INDEX_DESC

Type: constant

Description: 


Replaced value:
```sqf
1
```
File: [client\ClientData\EscapeMenu_settingsGame.sqf at line 8](../../../Src/client/ClientData/EscapeMenu_settingsGame.sqf#L8)
## SETTING_INDEX_TYPE

Type: constant

Description: 


Replaced value:
```sqf
2
```
File: [client\ClientData\EscapeMenu_settingsGame.sqf at line 9](../../../Src/client/ClientData/EscapeMenu_settingsGame.sqf#L9)
## SETTING_INDEX_RANGE

Type: constant

Description: 


Replaced value:
```sqf
3
```
File: [client\ClientData\EscapeMenu_settingsGame.sqf at line 10](../../../Src/client/ClientData/EscapeMenu_settingsGame.sqf#L10)
## SETTING_INDEX_VARNAME

Type: constant

Description: 


Replaced value:
```sqf
4
```
File: [client\ClientData\EscapeMenu_settingsGame.sqf at line 11](../../../Src/client/ClientData/EscapeMenu_settingsGame.sqf#L11)
## SETTING_INDEX_CURRENT

Type: constant

Description: 


Replaced value:
```sqf
5
```
File: [client\ClientData\EscapeMenu_settingsGame.sqf at line 12](../../../Src/client/ClientData/EscapeMenu_settingsGame.sqf#L12)
## SETTING_INDEX_DEFVALUE

Type: constant

Description: 


Replaced value:
```sqf
6
```
File: [client\ClientData\EscapeMenu_settingsGame.sqf at line 13](../../../Src/client/ClientData/EscapeMenu_settingsGame.sqf#L13)
## SETTING_INDEX_SERIALIZED

Type: constant

Description: 


Replaced value:
```sqf
7
```
File: [client\ClientData\EscapeMenu_settingsGame.sqf at line 14](../../../Src/client/ClientData/EscapeMenu_settingsGame.sqf#L14)
## SETTING_INDEX_EVENTONAPPLY

Type: constant

Description: 


Replaced value:
```sqf
8
```
File: [client\ClientData\EscapeMenu_settingsGame.sqf at line 15](../../../Src/client/ClientData/EscapeMenu_settingsGame.sqf#L15)
## SETTING_INDEX_EVENTONABORT

Type: constant

Description: 


Replaced value:
```sqf
9
```
File: [client\ClientData\EscapeMenu_settingsGame.sqf at line 16](../../../Src/client/ClientData/EscapeMenu_settingsGame.sqf#L16)
## SETTING_INDEX_EVENTONCHANGE

Type: constant

Description: 


Replaced value:
```sqf
10
```
File: [client\ClientData\EscapeMenu_settingsGame.sqf at line 17](../../../Src/client/ClientData/EscapeMenu_settingsGame.sqf#L17)
## setting(name,desc,type,range,variable,event_on_apply,event_on_abort,event_on_change)

Type: constant

Description: Тоже что и setting но использует общее событие
- Param: name
- Param: desc
- Param: type
- Param: range
- Param: variable
- Param: event_on_apply
- Param: event_on_abort
- Param: event_on_change

Replaced value:
```sqf
[name,desc,type,range,#variable,variable,variable,variable,event_on_apply,event_on_abort,event_on_change]
```
File: [client\ClientData\EscapeMenu_settingsGame.sqf at line 19](../../../Src/client/ClientData/EscapeMenu_settingsGame.sqf#L19)
## settingTEvent(name,desc,type,range,variable,__EVNT__)

Type: constant

Description: Тоже что и setting но использует общее событие
- Param: name
- Param: desc
- Param: type
- Param: range
- Param: variable
- Param: __EVNT__

Replaced value:
```sqf
[name,desc,type,range,#variable,variable,variable,variable,__EVNT__,__EVNT__,__EVNT__]
```
File: [client\ClientData\EscapeMenu_settingsGame.sqf at line 21](../../../Src/client/ClientData/EscapeMenu_settingsGame.sqf#L21)
## nextRegion(nameof)

Type: constant

Description: 
- Param: nameof

Replaced value:
```sqf
[nameof]
```
File: [client\ClientData\EscapeMenu_settingsGame.sqf at line 23](../../../Src/client/ClientData/EscapeMenu_settingsGame.sqf#L23)
## COUNT_REGION_SETTINGS

Type: constant

Description: 


Replaced value:
```sqf
1
```
File: [client\ClientData\EscapeMenu_settingsGame.sqf at line 24](../../../Src/client/ClientData/EscapeMenu_settingsGame.sqf#L24)
## COLOR_BACKGROUND_REGION_NAME

Type: constant

Description: 


Replaced value:
```sqf
[0.2,0.2,0.2,0.9]
```
File: [client\ClientData\EscapeMenu_settingsGame.sqf at line 25](../../../Src/client/ClientData/EscapeMenu_settingsGame.sqf#L25)
## typeInputFloat

Type: constant

Description: 


Replaced value:
```sqf
0
```
File: [client\ClientData\EscapeMenu_settingsGame.sqf at line 27](../../../Src/client/ClientData/EscapeMenu_settingsGame.sqf#L27)
## typeSwitcher

Type: constant

Description: 


Replaced value:
```sqf
1
```
File: [client\ClientData\EscapeMenu_settingsGame.sqf at line 28](../../../Src/client/ClientData/EscapeMenu_settingsGame.sqf#L28)
## typeSlider

Type: constant

Description: 


Replaced value:
```sqf
2
```
File: [client\ClientData\EscapeMenu_settingsGame.sqf at line 29](../../../Src/client/ClientData/EscapeMenu_settingsGame.sqf#L29)
## typeBool

Type: constant

Description: 


Replaced value:
```sqf
3
```
File: [client\ClientData\EscapeMenu_settingsGame.sqf at line 30](../../../Src/client/ClientData/EscapeMenu_settingsGame.sqf#L30)
## centerize(val)

Type: constant

Description: 
- Param: val

Replaced value:
```sqf
"<t align='center'>" + val + "</t>"
```
File: [client\ClientData\EscapeMenu_settingsGame.sqf at line 32](../../../Src/client/ClientData/EscapeMenu_settingsGame.sqf#L32)
## booleanText

Type: constant

Description: 


Replaced value:
```sqf
[centerize("нет"),centerize("да")]
```
File: [client\ClientData\EscapeMenu_settingsGame.sqf at line 33](../../../Src/client/ClientData/EscapeMenu_settingsGame.sqf#L33)
## boolRange

Type: constant

Description: 


Replaced value:
```sqf
booleanText
```
File: [client\ClientData\EscapeMenu_settingsGame.sqf at line 34](../../../Src/client/ClientData/EscapeMenu_settingsGame.sqf#L34)
## defRange(min,max)

Type: constant

Description: 
- Param: min
- Param: max

Replaced value:
```sqf
[min,max]
```
File: [client\ClientData\EscapeMenu_settingsGame.sqf at line 35](../../../Src/client/ClientData/EscapeMenu_settingsGame.sqf#L35)
## NO_EVENT_ON_APPLY

Type: constant

Description: отключенное событие просто будет устанавливать переменную по имени из SETTING_INDEX_VARNAME


Replaced value:
```sqf
""
```
File: [client\ClientData\EscapeMenu_settingsGame.sqf at line 38](../../../Src/client/ClientData/EscapeMenu_settingsGame.sqf#L38)
## value

Type: constant

Description: 


Replaced value:
```sqf
__eventValue
```
File: [client\ClientData\EscapeMenu_settingsGame.sqf at line 40](../../../Src/client/ClientData/EscapeMenu_settingsGame.sqf#L40)
## setting_element_size_x

Type: constant

Description: 


Replaced value:
```sqf
10
```
File: [client\ClientData\EscapeMenu_settingsGame.sqf at line 144](../../../Src/client/ClientData/EscapeMenu_settingsGame.sqf#L144)
## somedebugvar1

Type: Variable

Description: !!! only debug !!!


Initial value:
```sqf
1
```
File: [client\ClientData\EscapeMenu_settingsGame.sqf at line 43](../../../Src/client/ClientData/EscapeMenu_settingsGame.sqf#L43)
## somedebugvar2

Type: Variable

Description: 


Initial value:
```sqf
1
```
File: [client\ClientData\EscapeMenu_settingsGame.sqf at line 44](../../../Src/client/ClientData/EscapeMenu_settingsGame.sqf#L44)
## testbool

Type: Variable

Description: 


Initial value:
```sqf
false
```
File: [client\ClientData\EscapeMenu_settingsGame.sqf at line 45](../../../Src/client/ClientData/EscapeMenu_settingsGame.sqf#L45)
## cd_settingsGame

Type: Variable

Description: 


Initial value:
```sqf
[...
```
File: [client\ClientData\EscapeMenu_settingsGame.sqf at line 48](../../../Src/client/ClientData/EscapeMenu_settingsGame.sqf#L48)
## esc_settings_game_unloading

Type: function

Description: событие выгрузки текущих настроек
- Param: _mode

File: [client\ClientData\EscapeMenu_settingsGame.sqf at line 83](../../../Src/client/ClientData/EscapeMenu_settingsGame.sqf#L83)
## esc_settings_loader_game

Type: function

Description: 


File: [client\ClientData\EscapeMenu_settingsGame.sqf at line 140](../../../Src/client/ClientData/EscapeMenu_settingsGame.sqf#L140)
## esc_settings_eventOnInput

Type: function

Description: событие ввода
- Param: _bt
- Param: _key

File: [client\ClientData\EscapeMenu_settingsGame.sqf at line 233](../../../Src/client/ClientData/EscapeMenu_settingsGame.sqf#L233)
## esc_settings_eventOnSwitcher

Type: function

Description: событие переключателя
- Param: _bt

File: [client\ClientData\EscapeMenu_settingsGame.sqf at line 250](../../../Src/client/ClientData/EscapeMenu_settingsGame.sqf#L250)
## esc_settings_eventOnSlider

Type: function

Description: событие слайдера
- Param: _bt
- Param: _newValue

File: [client\ClientData\EscapeMenu_settingsGame.sqf at line 273](../../../Src/client/ClientData/EscapeMenu_settingsGame.sqf#L273)
## esc_settings_eventOnBool

Type: function

Description: событие бинарного условия
- Param: _bt

File: [client\ClientData\EscapeMenu_settingsGame.sqf at line 287](../../../Src/client/ClientData/EscapeMenu_settingsGame.sqf#L287)
## esc_settings_event_onSyncGame

Type: function

Description: событие синхронизирует все внешние изменения клавиш


File: [client\ClientData\EscapeMenu_settingsGame.sqf at line 309](../../../Src/client/ClientData/EscapeMenu_settingsGame.sqf#L309)
# EscapeMenu_settingsGraphics.sqf

## setting_element_size_x

Type: constant

Description: 


Replaced value:
```sqf
10
```
File: [client\ClientData\EscapeMenu_settingsGraphics.sqf at line 13](../../../Src/client/ClientData/EscapeMenu_settingsGraphics.sqf#L13)
## esc_settings_loader_graphic

Type: function

Description: TODO: change render distance for smd_allInGameMobs


File: [client\ClientData\EscapeMenu_settingsGraphics.sqf at line 10](../../../Src/client/ClientData/EscapeMenu_settingsGraphics.sqf#L10)
# EscapeMenu_settingsKeyboard.sqf

## setting_element_size_x

Type: constant

Description: 


Replaced value:
```sqf
10
```
File: [client\ClientData\EscapeMenu_settingsKeyboard.sqf at line 12](../../../Src/client/ClientData/EscapeMenu_settingsKeyboard.sqf#L12)
## __handled_event_type__

Type: constant

Description: 


Replaced value:
```sqf
"KeyUp"
```
File: [client\ClientData\EscapeMenu_settingsKeyboard.sqf at line 131](../../../Src/client/ClientData/EscapeMenu_settingsKeyboard.sqf#L131)
## esc_settings_loader_keyboard

Type: function

Description: 


File: [client\ClientData\EscapeMenu_settingsKeyboard.sqf at line 8](../../../Src/client/ClientData/EscapeMenu_settingsKeyboard.sqf#L8)
## esc_settings_onUpdateKeybinds

Type: function

Description: 
- Param: _enableAllButtons (optional, default false)

File: [client\ClientData\EscapeMenu_settingsKeyboard.sqf at line 55](../../../Src/client/ClientData/EscapeMenu_settingsKeyboard.sqf#L55)
## esc_settings_keyboard_changeButton

Type: function

Description: Событие при изменении кнопки
- Param: _button
- Param: _code
- Param: _shift
- Param: _control
- Param: _alt

File: [client\ClientData\EscapeMenu_settingsKeyboard.sqf at line 103](../../../Src/client/ClientData/EscapeMenu_settingsKeyboard.sqf#L103)
## esc_settings_event_onSyncKeyboard

Type: function

Description: событие синхронизирует все внешние изменения клавиш


File: [client\ClientData\EscapeMenu_settingsKeyboard.sqf at line 195](../../../Src/client/ClientData/EscapeMenu_settingsKeyboard.sqf#L195)
# EyeHandler.sqf

## check_state(str,action)

Type: constant

Description: 
- Param: str
- Param: action

Replaced value:
```sqf
if equals('str',_changeStateReason) exitWith {action}
```
File: [client\ClientData\EyeHandler.sqf at line 23](../../../Src/client/ClientData/EyeHandler.sqf#L23)
## cd_eyeState

Type: Variable

Description: 


Initial value:
```sqf
1 // 0 - ok > 0 - closed
```
File: [client\ClientData\EyeHandler.sqf at line 8](../../../Src/client/ClientData/EyeHandler.sqf#L8)
## cd_isEyesClosed

Type: function

Description: 0 - ok; > 0 - closed


File: [client\ClientData\EyeHandler.sqf at line 10](../../../Src/client/ClientData/EyeHandler.sqf#L10)
# SendCommand.sqf

## SC_SIZE_W

Type: constant

Description: 


Replaced value:
```sqf
40
```
File: [client\ClientData\SendCommand.sqf at line 8](../../../Src/client/ClientData/SendCommand.sqf#L8)
## SC_SIZE_H

Type: constant

Description: 


Replaced value:
```sqf
30
```
File: [client\ClientData\SendCommand.sqf at line 9](../../../Src/client/ClientData/SendCommand.sqf#L9)
## CD_MAX_COMMANDS_HISTORY_COUNT

Type: constant

Description: 


Replaced value:
```sqf
100
```
File: [client\ClientData\SendCommand.sqf at line 10](../../../Src/client/ClientData/SendCommand.sqf#L10)
## localCommand(name)

Type: constant

Description: 
- Param: name

Replaced value:
```sqf
_cd_map_dataCode = []; cd_commands_localCommandsList set [name,_cd_map_dataCode]; _cd_map_dataCode pushBack
```
File: [client\ClientData\SendCommand.sqf at line 294](../../../Src/client/ClientData/SendCommand.sqf#L294)
## arguments

Type: constant

Description: 


Replaced value:
```sqf
_args
```
File: [client\ClientData\SendCommand.sqf at line 296](../../../Src/client/ClientData/SendCommand.sqf#L296)
## cd_commandHistoryBuffer

Type: Variable

> Exists if **EDITOR** not defined

Description: 


Initial value:
```sqf
[]
```
File: [client\ClientData\SendCommand.sqf at line 20](../../../Src/client/ClientData/SendCommand.sqf#L20)
## cd_commands_localCommandsList

Type: Variable

Description: 


Initial value:
```sqf
createHashMap
```
File: [client\ClientData\SendCommand.sqf at line 292](../../../Src/client/ClientData/SendCommand.sqf#L292)
## cd_openSendCommandWindow

Type: function

Description: Открывает окно отправки сообщения на сервер
- Param: _isLobbyContext (optional, default false)

File: [client\ClientData\SendCommand.sqf at line 24](../../../Src/client/ClientData/SendCommand.sqf#L24)
## cd_closeSendCommandWindow

Type: function

Description: 


File: [client\ClientData\SendCommand.sqf at line 256](../../../Src/client/ClientData/SendCommand.sqf#L256)
## cd_openAhelp

Type: function

Description: 


File: [client\ClientData\SendCommand.sqf at line 271](../../../Src/client/ClientData/SendCommand.sqf#L271)
# VersionViewer.sqf

## versionviewer_timeout_init_clientname

Type: constant

Description: 


Replaced value:
```sqf
30
```
File: [client\ClientData\VersionViewer.sqf at line 9](../../../Src/client/ClientData/VersionViewer.sqf#L9)
## versionviewer_size_x

Type: constant

Description: 


Replaced value:
```sqf
14
```
File: [client\ClientData\VersionViewer.sqf at line 11](../../../Src/client/ClientData/VersionViewer.sqf#L11)
## versionviewer_size_y

Type: constant

Description: 


Replaced value:
```sqf
10
```
File: [client\ClientData\VersionViewer.sqf at line 12](../../../Src/client/ClientData/VersionViewer.sqf#L12)
## cd_vv_widgets

Type: Variable

Description: 


Initial value:
```sqf
[_ctg,_back,_txt]
```
File: [client\ClientData\VersionViewer.sqf at line 26](../../../Src/client/ClientData/VersionViewer.sqf#L26)
## cd_vv_syncVisual

Type: function

Description: 
- Param: _cliName (optional, default cd_clientName)

File: [client\ClientData\VersionViewer.sqf at line 28](../../../Src/client/ClientData/VersionViewer.sqf#L28)
