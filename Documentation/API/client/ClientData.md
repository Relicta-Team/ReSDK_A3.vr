# ClientData.hpp

## SKILL_BASE

Type: constant

Description: 


Replaced value:
```sqf
0
```
File: [client\ClientData\ClientData.hpp at line 10](../../../Src/client/ClientData/ClientData.hpp#L10)
## SKILL_MOD

Type: constant

Description: 


Replaced value:
```sqf
1
```
File: [client\ClientData\ClientData.hpp at line 11](../../../Src/client/ClientData/ClientData.hpp#L11)
## VIDEO_SETTINGS_MAX

Type: constant

Description: 


Replaced value:
```sqf
1
```
File: [client\ClientData\ClientData.hpp at line 15](../../../Src/client/ClientData/ClientData.hpp#L15)
## VIDEO_SETTINGS_MIN

Type: constant

Description: 


Replaced value:
```sqf
0
```
File: [client\ClientData\ClientData.hpp at line 16](../../../Src/client/ClientData/ClientData.hpp#L16)
# ClientData.sqf

## sk_nan

Type: constant

Description: 


Replaced value:
```sqf
[0,0]
```
File: [client\ClientData\ClientData.sqf at line 48](../../../Src/client/ClientData/ClientData.sqf#L48)
## printerr(code,text)

Type: constant

Description: 
- Param: code
- Param: text

Replaced value:
```sqf
if (_code == code) exitWith {[text] call (getDisplay getVariable ["printError",{}])}
```
File: [client\ClientData\ClientData.sqf at line 533](../../../Src/client/ClientData/ClientData.sqf#L533)
## cd_clientName

Type: Variable

Description: 


Initial value:
```sqf
""
```
File: [client\ClientData\ClientData.sqf at line 44](../../../Src/client/ClientData/ClientData.sqf#L44)
## cd_charName

Type: Variable

Description: 


Initial value:
```sqf
"Обитатель Сети"
```
File: [client\ClientData\ClientData.sqf at line 46](../../../Src/client/ClientData/ClientData.sqf#L46)
## cd_skillNames

Type: Variable

Description: 


Initial value:
```sqf
["СЛ","ИН","ЛВ","ЗД","ВНС","ВОЛЯ","ВОС","ЖЗ"]
```
File: [client\ClientData\ClientData.sqf at line 50](../../../Src/client/ClientData/ClientData.sqf#L50)
## cd_skills

Type: Variable

Description: 


Initial value:
```sqf
[sk_nan,sk_nan,sk_nan,sk_nan,sk_nan,sk_nan,sk_nan,sk_nan] //массив со скиллами
```
File: [client\ClientData\ClientData.sqf at line 52](../../../Src/client/ClientData/ClientData.sqf#L52)
## cd_stamina_cur

Type: Variable

Description: 


Initial value:
```sqf
100
```
File: [client\ClientData\ClientData.sqf at line 56](../../../Src/client/ClientData/ClientData.sqf#L56)
## cd_stamina_max

Type: Variable

Description: 


Initial value:
```sqf
100
```
File: [client\ClientData\ClientData.sqf at line 58](../../../Src/client/ClientData/ClientData.sqf#L58)
## cd_curSelection

Type: Variable

Description: 


Initial value:
```sqf
TARGET_ZONE_TORSO
```
File: [client\ClientData\ClientData.sqf at line 90](../../../Src/client/ClientData/ClientData.sqf#L90)
## cd_specialAction

Type: Variable

Description: 


Initial value:
```sqf
SPECIAL_ACTION_NO
```
File: [client\ClientData\ClientData.sqf at line 92](../../../Src/client/ClientData/ClientData.sqf#L92)
## cd_curDefType

Type: Variable

Description: combat


Initial value:
```sqf
DEF_TYPE_DODGE
```
File: [client\ClientData\ClientData.sqf at line 96](../../../Src/client/ClientData/ClientData.sqf#L96)
## cd_curCombatStyle

Type: Variable

Description: 


Initial value:
```sqf
COMBAT_STYLE_NO
```
File: [client\ClientData\ClientData.sqf at line 98](../../../Src/client/ClientData/ClientData.sqf#L98)
## cd_curAttackType

Type: Variable

Description: 


Initial value:
```sqf
ATTACK_TYPE_THRUST
```
File: [client\ClientData\ClientData.sqf at line 100](../../../Src/client/ClientData/ClientData.sqf#L100)
## cd_activeHand

Type: Variable

Description: 


Initial value:
```sqf
INV_HAND_L
```
File: [client\ClientData\ClientData.sqf at line 102](../../../Src/client/ClientData/ClientData.sqf#L102)
## cd_lca_r

Type: Variable

Description: 


Initial value:
```sqf
0
```
File: [client\ClientData\ClientData.sqf at line 105](../../../Src/client/ClientData/ClientData.sqf#L105)
## cd_lca_l

Type: Variable

Description: 


Initial value:
```sqf
0
```
File: [client\ClientData\ClientData.sqf at line 107](../../../Src/client/ClientData/ClientData.sqf#L107)
## cd_internal_lastTPPos

Type: Variable

Description: 


Initial value:
```sqf
vec3(0,0,0)
```
File: [client\ClientData\ClientData.sqf at line 246](../../../Src/client/ClientData/ClientData.sqf#L246)
## cd_internal_lastTPDir

Type: Variable

Description: 


Initial value:
```sqf
null
```
File: [client\ClientData\ClientData.sqf at line 248](../../../Src/client/ClientData/ClientData.sqf#L248)
## cd_internal_tpHandle

Type: Variable

Description: 


Initial value:
```sqf
-1
```
File: [client\ClientData\ClientData.sqf at line 250](../../../Src/client/ClientData/ClientData.sqf#L250)
## cd_internal_hasTPError

Type: Variable

Description: 


Initial value:
```sqf
false
```
File: [client\ClientData\ClientData.sqf at line 252](../../../Src/client/ClientData/ClientData.sqf#L252)
## cd_internal_lastTPObj

Type: Variable

Description: 


Initial value:
```sqf
objnull
```
File: [client\ClientData\ClientData.sqf at line 254](../../../Src/client/ClientData/ClientData.sqf#L254)
## cd_internal_startLoadTime

Type: Variable

Description: 


Initial value:
```sqf
0
```
File: [client\ClientData\ClientData.sqf at line 256](../../../Src/client/ClientData/ClientData.sqf#L256)
## cd_OnSkillsUpdate

Type: function

Description: 
- Param: _id
- Param: _val

File: [client\ClientData\ClientData.sqf at line 62](../../../Src/client/ClientData/ClientData.sqf#L62)
## cd_setVideoSettings

Type: function

Description: 
- Param: _value

File: [client\ClientData\ClientData.sqf at line 114](../../../Src/client/ClientData/ClientData.sqf#L114)
## cd_onPrepareClient

Type: function

Description: 
- Param: _atlPos
- Param: _vision

File: [client\ClientData\ClientData.sqf at line 136](../../../Src/client/ClientData/ClientData.sqf#L136)
## cd_tpLoad

Type: function

Description: 
- Param: _pos
- Param: _dir

File: [client\ClientData\ClientData.sqf at line 259](../../../Src/client/ClientData/ClientData.sqf#L259)
## cd_syncObjTransform

Type: function

Description: 
- Param: _src
- Param: _pos
- Param: _dir

File: [client\ClientData\ClientData.sqf at line 374](../../../Src/client/ClientData/ClientData.sqf#L374)
## cd_clientDisconnect

Type: function

Description: 
- Param: _args

File: [client\ClientData\ClientData.sqf at line 385](../../../Src/client/ClientData/ClientData.sqf#L385)
## cd_authproc

Type: function

Description: 


File: [client\ClientData\ClientData.sqf at line 413](../../../Src/client/ClientData/ClientData.sqf#L413)
## cd_openAuth

Type: function

Description: 
- Param: _mes

File: [client\ClientData\ClientData.sqf at line 420](../../../Src/client/ClientData/ClientData.sqf#L420)
## cd_authResult

Type: function

Description: 
- Param: _code
- Param: _nick

File: [client\ClientData\ClientData.sqf at line 526](../../../Src/client/ClientData/ClientData.sqf#L526)
## cd_switchMove_anim

Type: function

Description: 


File: [client\ClientData\ClientData.sqf at line 557](../../../Src/client/ClientData/ClientData.sqf#L557)
## cd_switchMove_force_anim

Type: function

Description: 


File: [client\ClientData\ClientData.sqf at line 562](../../../Src/client/ClientData/ClientData.sqf#L562)
## cd_playMove_anim

Type: function

Description: 


File: [client\ClientData\ClientData.sqf at line 569](../../../Src/client/ClientData/ClientData.sqf#L569)
## cd_setMimic_anim

Type: function

Description: 


File: [client\ClientData\ClientData.sqf at line 575](../../../Src/client/ClientData/ClientData.sqf#L575)
## cd_switchAction_anim

Type: function

Description: 


File: [client\ClientData\ClientData.sqf at line 580](../../../Src/client/ClientData/ClientData.sqf#L580)
## cd_syncongrabrot_setvdirup

Type: function

Description: 
- Param: _m

File: [client\ClientData\ClientData.sqf at line 585](../../../Src/client/ClientData/ClientData.sqf#L585)
## cd_camshake_proc

Type: function

Description: 


File: [client\ClientData\ClientData.sqf at line 594](../../../Src/client/ClientData/ClientData.sqf#L594)
## cd_replicate_replloc

Type: function

Description: 
- Param: _method
- Param: _ctx

File: [client\ClientData\ClientData.sqf at line 599](../../../Src/client/ClientData/ClientData.sqf#L599)
## repl_doLocal

Type: function

Description: 
- Param: _method
- Param: _ctx

File: [client\ClientData\ClientData.sqf at line 608](../../../Src/client/ClientData/ClientData.sqf#L608)
# ClientDataGamemode.sqf

## cd_onChangeGameState

Type: function

Description: 
- Param: _oldState
- Param: _newState

File: [client\ClientData\ClientDataGamemode.sqf at line 10](../../../Src/client/ClientData/ClientDataGamemode.sqf#L10)
# ClientDataUnconscious.sqf

## __UNCONSCIOUS_DELAY__

Type: constant

Description: 


Replaced value:
```sqf
0.1
```
File: [client\ClientData\ClientDataUnconscious.sqf at line 18](../../../Src/client/ClientData/ClientDataUnconscious.sqf#L18)
## cd_isUnconscious

Type: Variable

Description: 


Initial value:
```sqf
false //в бессознанке
```
File: [client\ClientData\ClientDataUnconscious.sqf at line 21](../../../Src/client/ClientData/ClientDataUnconscious.sqf#L21)
## cd_internal_uncState

Type: Variable

Description: 


Initial value:
```sqf
false //внутрення переменная перехода состояния
```
File: [client\ClientData\ClientDataUnconscious.sqf at line 23](../../../Src/client/ClientData/ClientDataUnconscious.sqf#L23)
## cd_onUnconsciousCode

Type: function

Description: 


File: [client\ClientData\ClientDataUnconscious.sqf at line 26](../../../Src/client/ClientData/ClientDataUnconscious.sqf#L26)
## cd_onUnconsciousEvent

Type: function

Description: 
- Param: _isUncState

File: [client\ClientData\ClientDataUnconscious.sqf at line 39](../../../Src/client/ClientData/ClientDataUnconscious.sqf#L39)
# ClientData_ConnectionManager.sqf

## PREPARE_PLAYER_POS_TIMEOUT

Type: constant

Description: 


Replaced value:
```sqf
120
```
File: [client\ClientData\ClientData_ConnectionManager.sqf at line 11](../../../Src/client/ClientData/ClientData_ConnectionManager.sqf#L11)
## SWITCH_PLAYER_TIMEOUT

Type: constant

Description: 


Replaced value:
```sqf
30
```
File: [client\ClientData\ClientData_ConnectionManager.sqf at line 14](../../../Src/client/ClientData/ClientData_ConnectionManager.sqf#L14)
## client_state

Type: Variable

Description: 


Initial value:
```sqf
"init"
```
File: [client\ClientData\ClientData_ConnectionManager.sqf at line 19](../../../Src/client/ClientData/ClientData_ConnectionManager.sqf#L19)
## client_getState

Type: function

Description: 


File: [client\ClientData\ClientData_ConnectionManager.sqf at line 21](../../../Src/client/ClientData/ClientData_ConnectionManager.sqf#L21)
## client_setState

Type: function

Description: 


File: [client\ClientData\ClientData_ConnectionManager.sqf at line 23](../../../Src/client/ClientData/ClientData_ConnectionManager.sqf#L23)
## client_isInGame

Type: function

Description: 


File: [client\ClientData\ClientData_ConnectionManager.sqf at line 25](../../../Src/client/ClientData/ClientData_ConnectionManager.sqf#L25)
## client_isInLobby

Type: function

Description: 


File: [client\ClientData\ClientData_ConnectionManager.sqf at line 27](../../../Src/client/ClientData/ClientData_ConnectionManager.sqf#L27)
## cd_prepPlayerPos

Type: function

Description: 
- Param: _pos
- Param: _mob

File: [client\ClientData\ClientData_ConnectionManager.sqf at line 31](../../../Src/client/ClientData/ClientData_ConnectionManager.sqf#L31)
## cd_processConnection

Type: function

Description: 
- Param: _isLinkTo
- Param: _mob
- Param: _prepareNextMode

File: [client\ClientData\ClientData_ConnectionManager.sqf at line 66](../../../Src/client/ClientData/ClientData_ConnectionManager.sqf#L66)
## cd_connectToMob

Type: function

Description: 
- Param: _mob
- Param: _nextAction (optional, default -1)

File: [client\ClientData\ClientData_ConnectionManager.sqf at line 190](../../../Src/client/ClientData/ClientData_ConnectionManager.sqf#L190)
## cd_onPlayingEnd

Type: function

Description: 
- Param: _mob
- Param: _nextAction (optional, default -1)

File: [client\ClientData\ClientData_ConnectionManager.sqf at line 197](../../../Src/client/ClientData/ClientData_ConnectionManager.sqf#L197)
# ClientData_customAnims.sqf

## cd_customAnim

Type: Variable

Description: 


Initial value:
```sqf
CUSTOM_ANIM_ACTION_NONE
```
File: [client\ClientData\ClientData_customAnims.sqf at line 12](../../../Src/client/ClientData/ClientData_customAnims.sqf#L12)
## cd_isCustomAnimEnabled

Type: function

Description: 


File: [client\ClientData\ClientData_customAnims.sqf at line 15](../../../Src/client/ClientData/ClientData_customAnims.sqf#L15)
## cd_handleRestCustomAnim

Type: function

Description: 


File: [client\ClientData\ClientData_customAnims.sqf at line 20](../../../Src/client/ClientData/ClientData_customAnims.sqf#L20)
# ClientData_forceWalk.sqf

## cd_fw_forceWalk

Type: Variable

Description: 


Initial value:
```sqf
false
```
File: [client\ClientData\ClientData_forceWalk.sqf at line 24](../../../Src/client/ClientData/ClientData_forceWalk.sqf#L24)
## cd_fw_hasBreakBone

Type: Variable

Description: 


Initial value:
```sqf
false
```
File: [client\ClientData\ClientData_forceWalk.sqf at line 27](../../../Src/client/ClientData/ClientData_forceWalk.sqf#L27)
## cd_sp_enabled

Type: Variable

Description: 


Initial value:
```sqf
true
```
File: [client\ClientData\ClientData_forceWalk.sqf at line 41](../../../Src/client/ClientData/ClientData_forceWalk.sqf#L41)
## cd_sp_lockedSetting

Type: Variable

Description: 


Initial value:
```sqf
false
```
File: [client\ClientData\ClientData_forceWalk.sqf at line 43](../../../Src/client/ClientData/ClientData_forceWalk.sqf#L43)
## cd_sp_grabbingMob

Type: Variable

Description: 


Initial value:
```sqf
false
```
File: [client\ClientData\ClientData_forceWalk.sqf at line 45](../../../Src/client/ClientData/ClientData_forceWalk.sqf#L45)
## cd_onSyncLegsBoneState

Type: function

Description: 
- Param: _unit
- Param: _hasBreak

File: [client\ClientData\ClientData_forceWalk.sqf at line 13](../../../Src/client/ClientData/ClientData_forceWalk.sqf#L13)
## cd_fw_isForceWalk

Type: function

Description: 


File: [client\ClientData\ClientData_forceWalk.sqf at line 29](../../../Src/client/ClientData/ClientData_forceWalk.sqf#L29)
## cd_fw_syncForceWalk

Type: function

Description: 
- Param: _mob

File: [client\ClientData\ClientData_forceWalk.sqf at line 31](../../../Src/client/ClientData/ClientData_forceWalk.sqf#L31)
## cd_sp_canSprint

Type: function

Description: 


File: [client\ClientData\ClientData_forceWalk.sqf at line 47](../../../Src/client/ClientData/ClientData_forceWalk.sqf#L47)
## cd_spr_sync

Type: function

Description: 


File: [client\ClientData\ClientData_forceWalk.sqf at line 50](../../../Src/client/ClientData/ClientData_forceWalk.sqf#L50)
# EscapeMenu.sqf

## ESC_MENU_SIZE_X

Type: constant

Description: 


Replaced value:
```sqf
20
```
File: [client\ClientData\EscapeMenu.sqf at line 12](../../../Src/client/ClientData/EscapeMenu.sqf#L12)
## ESC_MENU_SIZE_Y

Type: constant

Description: 


Replaced value:
```sqf
30
```
File: [client\ClientData\EscapeMenu.sqf at line 14](../../../Src/client/ClientData/EscapeMenu.sqf#L14)
## ESC_MENU_DEFAULT_BUTTON_BIAS_X

Type: constant

Description: 


Replaced value:
```sqf
5
```
File: [client\ClientData\EscapeMenu.sqf at line 16](../../../Src/client/ClientData/EscapeMenu.sqf#L16)
## ESC_MENU_DEFAULT_BUTTON_BIAS_Y

Type: constant

Description: 


Replaced value:
```sqf
5
```
File: [client\ClientData\EscapeMenu.sqf at line 18](../../../Src/client/ClientData/EscapeMenu.sqf#L18)
## ESC_MENU_BACKGROUND_COLOR_T3

Type: constant

Description: 


Replaced value:
```sqf
0.4
```
File: [client\ClientData\EscapeMenu.sqf at line 21](../../../Src/client/ClientData/EscapeMenu.sqf#L21)
## handleSettings(closerEv,OpenerEv)

Type: constant

Description: 
- Param: closerEv
- Param: OpenerEv

Replaced value:
```sqf
([closerEv,OpenerEv] call esc_internal_handleSettings)
```
File: [client\ClientData\EscapeMenu.sqf at line 24](../../../Src/client/ClientData/EscapeMenu.sqf#L24)
## addOpenerAndActivator(id)

Type: constant

Description: 
- Param: id

Replaced value:
```sqf
getDisplay createDisplay  "RscDisplayInterrupt"; ctrlActivate (findDisplay 49 displayCtrl id)
```
File: [client\ClientData\EscapeMenu.sqf at line 26](../../../Src/client/ClientData/EscapeMenu.sqf#L26)
## addCloseEventToSetting(id)

Type: constant

Description: 
- Param: id

Replaced value:
```sqf
(findDisplay id) displayAddEventHandler ["Unload",{(findDisplay 49) closeDisplay 0}]
```
File: [client\ClientData\EscapeMenu.sqf at line 28](../../../Src/client/ClientData/EscapeMenu.sqf#L28)
## ces_video

Type: constant

Description: 


Replaced value:
```sqf
5
```
File: [client\ClientData\EscapeMenu.sqf at line 30](../../../Src/client/ClientData/EscapeMenu.sqf#L30)
## set_ca_video

Type: constant

Description: 


Replaced value:
```sqf
301
```
File: [client\ClientData\EscapeMenu.sqf at line 32](../../../Src/client/ClientData/EscapeMenu.sqf#L32)
## ces_audio

Type: constant

Description: 


Replaced value:
```sqf
6
```
File: [client\ClientData\EscapeMenu.sqf at line 34](../../../Src/client/ClientData/EscapeMenu.sqf#L34)
## set_ca_audio

Type: constant

Description: 


Replaced value:
```sqf
302
```
File: [client\ClientData\EscapeMenu.sqf at line 36](../../../Src/client/ClientData/EscapeMenu.sqf#L36)
## ces_input

Type: constant

Description: 


Replaced value:
```sqf
4
```
File: [client\ClientData\EscapeMenu.sqf at line 38](../../../Src/client/ClientData/EscapeMenu.sqf#L38)
## set_ca_input

Type: constant

Description: 


Replaced value:
```sqf
303
```
File: [client\ClientData\EscapeMenu.sqf at line 40](../../../Src/client/ClientData/EscapeMenu.sqf#L40)
## getEscapeCtg

Type: constant

Description: 


Replaced value:
```sqf
(esc_widgets select 0)
```
File: [client\ClientData\EscapeMenu.sqf at line 47](../../../Src/client/ClientData/EscapeMenu.sqf#L47)
## getSettingsCtg

Type: constant

Description: 


Replaced value:
```sqf
(esc_settings_widgets select 0)
```
File: [client\ClientData\EscapeMenu.sqf at line 230](../../../Src/client/ClientData/EscapeMenu.sqf#L230)
## getSettingsList

Type: constant

Description: 


Replaced value:
```sqf
(esc_settings_widgets select 1)
```
File: [client\ClientData\EscapeMenu.sqf at line 232](../../../Src/client/ClientData/EscapeMenu.sqf#L232)
## getSettingsAccept

Type: constant

Description: 


Replaced value:
```sqf
(esc_settings_widgets select 2)
```
File: [client\ClientData\EscapeMenu.sqf at line 234](../../../Src/client/ClientData/EscapeMenu.sqf#L234)
## getSettingsAbort

Type: constant

Description: 


Replaced value:
```sqf
(esc_settings_widgets select 3)
```
File: [client\ClientData\EscapeMenu.sqf at line 236](../../../Src/client/ClientData/EscapeMenu.sqf#L236)
## ESC_GET_ALL_SETTINGS_TO_FADE

Type: constant

Description: 


Replaced value:
```sqf
[getSettingsAbort,getSettingsAccept,getSettingsList,getSettingsCtg]
```
File: [client\ClientData\EscapeMenu.sqf at line 239](../../../Src/client/ClientData/EscapeMenu.sqf#L239)
## SETTINGS_SIZE_X

Type: constant

Description: 


Replaced value:
```sqf
60
```
File: [client\ClientData\EscapeMenu.sqf at line 242](../../../Src/client/ClientData/EscapeMenu.sqf#L242)
## SETTINGS_SIZE_Y

Type: constant

Description: 


Replaced value:
```sqf
60
```
File: [client\ClientData\EscapeMenu.sqf at line 244](../../../Src/client/ClientData/EscapeMenu.sqf#L244)
## SETTINGS_MENU_BACKGROUND_COLOR_T3

Type: constant

Description: 


Replaced value:
```sqf
ESC_MENU_BACKGROUND_COLOR_T3
```
File: [client\ClientData\EscapeMenu.sqf at line 246](../../../Src/client/ClientData/EscapeMenu.sqf#L246)
## esc_isMenuOpened

Type: Variable

Description: 


Initial value:
```sqf
false
```
File: [client\ClientData\EscapeMenu.sqf at line 42](../../../Src/client/ClientData/EscapeMenu.sqf#L42)
## esc_widgets

Type: Variable

Description: 


Initial value:
```sqf
[widgetNull]
```
File: [client\ClientData\EscapeMenu.sqf at line 44](../../../Src/client/ClientData/EscapeMenu.sqf#L44)
## esc_buttonsData

Type: Variable

Description: 


Initial value:
```sqf
[...
```
File: [client\ClientData\EscapeMenu.sqf at line 64](../../../Src/client/ClientData/EscapeMenu.sqf#L64)
## esc_settings_widgets

Type: Variable

Description: 


Initial value:
```sqf
[widgetNull,widgetNull,widgetNull,widgetNull]
```
File: [client\ClientData\EscapeMenu.sqf at line 253](../../../Src/client/ClientData/EscapeMenu.sqf#L253)
## esc_settings_names

Type: Variable

Description: 


Initial value:
```sqf
[...
```
File: [client\ClientData\EscapeMenu.sqf at line 256](../../../Src/client/ClientData/EscapeMenu.sqf#L256)
## esc_settings_curIndex

Type: Variable

Description: 


Initial value:
```sqf
-1
```
File: [client\ClientData\EscapeMenu.sqf at line 263](../../../Src/client/ClientData/EscapeMenu.sqf#L263)
## cd_settingsVersion

Type: Variable

Description: 


Initial value:
```sqf
1.0
```
File: [client\ClientData\EscapeMenu.sqf at line 266](../../../Src/client/ClientData/EscapeMenu.sqf#L266)
## esc_internal_handleSettings

Type: function

Description: 
- Param: _closerEv
- Param: _openerEv

File: [client\ClientData\EscapeMenu.sqf at line 50](../../../Src/client/ClientData/EscapeMenu.sqf#L50)
## esc_openMenu

Type: function

Description: 
- Param: _isOpenedInLobby (optional, default false)

File: [client\ClientData\EscapeMenu.sqf at line 76](../../../Src/client/ClientData/EscapeMenu.sqf#L76)
## esc_confirmExit

Type: function

Description: 


File: [client\ClientData\EscapeMenu.sqf at line 136](../../../Src/client/ClientData/EscapeMenu.sqf#L136)
## esc_closeMenu

Type: function

Description: 


File: [client\ClientData\EscapeMenu.sqf at line 200](../../../Src/client/ClientData/EscapeMenu.sqf#L200)
## esc_settings_open

Type: function

Description: 


File: [client\ClientData\EscapeMenu.sqf at line 269](../../../Src/client/ClientData/EscapeMenu.sqf#L269)
## esc_settings_close

Type: function

Description: 
- Param: _isSaved (optional, default false)

File: [client\ClientData\EscapeMenu.sqf at line 331](../../../Src/client/ClientData/EscapeMenu.sqf#L331)
## esc_settings_clearSettingList

Type: function

Description: 


File: [client\ClientData\EscapeMenu.sqf at line 358](../../../Src/client/ClientData/EscapeMenu.sqf#L358)
# EscapeMenu_settingsGame.sqf

## SETTING_INDEX_NAME

Type: constant

Description: 


Replaced value:
```sqf
0
```
File: [client\ClientData\EscapeMenu_settingsGame.sqf at line 10](../../../Src/client/ClientData/EscapeMenu_settingsGame.sqf#L10)
## SETTING_INDEX_DESC

Type: constant

Description: 


Replaced value:
```sqf
1
```
File: [client\ClientData\EscapeMenu_settingsGame.sqf at line 11](../../../Src/client/ClientData/EscapeMenu_settingsGame.sqf#L11)
## SETTING_INDEX_TYPE

Type: constant

Description: 


Replaced value:
```sqf
2
```
File: [client\ClientData\EscapeMenu_settingsGame.sqf at line 12](../../../Src/client/ClientData/EscapeMenu_settingsGame.sqf#L12)
## SETTING_INDEX_RANGE

Type: constant

Description: 


Replaced value:
```sqf
3
```
File: [client\ClientData\EscapeMenu_settingsGame.sqf at line 13](../../../Src/client/ClientData/EscapeMenu_settingsGame.sqf#L13)
## SETTING_INDEX_VARNAME

Type: constant

Description: 


Replaced value:
```sqf
4
```
File: [client\ClientData\EscapeMenu_settingsGame.sqf at line 14](../../../Src/client/ClientData/EscapeMenu_settingsGame.sqf#L14)
## SETTING_INDEX_CURRENT

Type: constant

Description: 


Replaced value:
```sqf
5
```
File: [client\ClientData\EscapeMenu_settingsGame.sqf at line 15](../../../Src/client/ClientData/EscapeMenu_settingsGame.sqf#L15)
## SETTING_INDEX_DEFVALUE

Type: constant

Description: 


Replaced value:
```sqf
6
```
File: [client\ClientData\EscapeMenu_settingsGame.sqf at line 16](../../../Src/client/ClientData/EscapeMenu_settingsGame.sqf#L16)
## SETTING_INDEX_SERIALIZED

Type: constant

Description: 


Replaced value:
```sqf
7
```
File: [client\ClientData\EscapeMenu_settingsGame.sqf at line 17](../../../Src/client/ClientData/EscapeMenu_settingsGame.sqf#L17)
## SETTING_INDEX_EVENTONAPPLY

Type: constant

Description: 


Replaced value:
```sqf
8
```
File: [client\ClientData\EscapeMenu_settingsGame.sqf at line 18](../../../Src/client/ClientData/EscapeMenu_settingsGame.sqf#L18)
## SETTING_INDEX_EVENTONABORT

Type: constant

Description: 


Replaced value:
```sqf
9
```
File: [client\ClientData\EscapeMenu_settingsGame.sqf at line 19](../../../Src/client/ClientData/EscapeMenu_settingsGame.sqf#L19)
## SETTING_INDEX_EVENTONCHANGE

Type: constant

Description: 


Replaced value:
```sqf
10
```
File: [client\ClientData\EscapeMenu_settingsGame.sqf at line 20](../../../Src/client/ClientData/EscapeMenu_settingsGame.sqf#L20)
## setting(name,desc,type,range,variable,event_on_apply,event_on_abort,event_on_change)

Type: constant

Description: 
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
File: [client\ClientData\EscapeMenu_settingsGame.sqf at line 24](../../../Src/client/ClientData/EscapeMenu_settingsGame.sqf#L24)
## settingTEvent(name,desc,type,range,variable,__EVNT__)

Type: constant

Description: 
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
File: [client\ClientData\EscapeMenu_settingsGame.sqf at line 27](../../../Src/client/ClientData/EscapeMenu_settingsGame.sqf#L27)
## nextRegion(nameof)

Type: constant

Description: 
- Param: nameof

Replaced value:
```sqf
[nameof]
```
File: [client\ClientData\EscapeMenu_settingsGame.sqf at line 30](../../../Src/client/ClientData/EscapeMenu_settingsGame.sqf#L30)
## COUNT_REGION_SETTINGS

Type: constant

Description: 


Replaced value:
```sqf
1
```
File: [client\ClientData\EscapeMenu_settingsGame.sqf at line 32](../../../Src/client/ClientData/EscapeMenu_settingsGame.sqf#L32)
## COLOR_BACKGROUND_REGION_NAME

Type: constant

Description: 


Replaced value:
```sqf
[0.2,0.2,0.2,0.9]
```
File: [client\ClientData\EscapeMenu_settingsGame.sqf at line 34](../../../Src/client/ClientData/EscapeMenu_settingsGame.sqf#L34)
## typeInputFloat

Type: constant

Description: 


Replaced value:
```sqf
0
```
File: [client\ClientData\EscapeMenu_settingsGame.sqf at line 37](../../../Src/client/ClientData/EscapeMenu_settingsGame.sqf#L37)
## typeSwitcher

Type: constant

Description: 


Replaced value:
```sqf
1
```
File: [client\ClientData\EscapeMenu_settingsGame.sqf at line 38](../../../Src/client/ClientData/EscapeMenu_settingsGame.sqf#L38)
## typeSlider

Type: constant

Description: 


Replaced value:
```sqf
2
```
File: [client\ClientData\EscapeMenu_settingsGame.sqf at line 39](../../../Src/client/ClientData/EscapeMenu_settingsGame.sqf#L39)
## typeBool

Type: constant

Description: 


Replaced value:
```sqf
3
```
File: [client\ClientData\EscapeMenu_settingsGame.sqf at line 40](../../../Src/client/ClientData/EscapeMenu_settingsGame.sqf#L40)
## centerize(val)

Type: constant

Description: 
- Param: val

Replaced value:
```sqf
"<t align='center'>" + val + "</t>"
```
File: [client\ClientData\EscapeMenu_settingsGame.sqf at line 44](../../../Src/client/ClientData/EscapeMenu_settingsGame.sqf#L44)
## boolRange

Type: constant

Description: 


Replaced value:
```sqf
[centerize("нет"),centerize("да")]
```
File: [client\ClientData\EscapeMenu_settingsGame.sqf at line 47](../../../Src/client/ClientData/EscapeMenu_settingsGame.sqf#L47)
## defRange(min,max)

Type: constant

Description: 
- Param: min
- Param: max

Replaced value:
```sqf
([min,max] call cd_internal_defRange)
```
File: [client\ClientData\EscapeMenu_settingsGame.sqf at line 49](../../../Src/client/ClientData/EscapeMenu_settingsGame.sqf#L49)
## NO_EVENT_ON_APPLY

Type: constant

Description: 


Replaced value:
```sqf
""
```
File: [client\ClientData\EscapeMenu_settingsGame.sqf at line 56](../../../Src/client/ClientData/EscapeMenu_settingsGame.sqf#L56)
## value

Type: constant

Description: 


Replaced value:
```sqf
cd_esc_settings_internal_curChangedValue
```
File: [client\ClientData\EscapeMenu_settingsGame.sqf at line 58](../../../Src/client/ClientData/EscapeMenu_settingsGame.sqf#L58)
## setting_element_size_x

Type: constant

Description: 


Replaced value:
```sqf
10
```
File: [client\ClientData\EscapeMenu_settingsGame.sqf at line 166](../../../Src/client/ClientData/EscapeMenu_settingsGame.sqf#L166)
## cd_esc_settings_internal_curChangedValue

Type: Variable

Description: 


Initial value:
```sqf
0
```
File: [client\ClientData\EscapeMenu_settingsGame.sqf at line 61](../../../Src/client/ClientData/EscapeMenu_settingsGame.sqf#L61)
## cd_settingsGame

Type: Variable

Description: 


Initial value:
```sqf
[...
```
File: [client\ClientData\EscapeMenu_settingsGame.sqf at line 69](../../../Src/client/ClientData/EscapeMenu_settingsGame.sqf#L69)
## cd_internal_defRange

Type: function

Description: 
- Param: _mi
- Param: _ma

File: [client\ClientData\EscapeMenu_settingsGame.sqf at line 52](../../../Src/client/ClientData/EscapeMenu_settingsGame.sqf#L52)
## esc_settings_game_unloading

Type: function

Description: 
- Param: _mode

File: [client\ClientData\EscapeMenu_settingsGame.sqf at line 105](../../../Src/client/ClientData/EscapeMenu_settingsGame.sqf#L105)
## esc_settings_loader_game

Type: function

Description: 


File: [client\ClientData\EscapeMenu_settingsGame.sqf at line 162](../../../Src/client/ClientData/EscapeMenu_settingsGame.sqf#L162)
## esc_settings_eventOnInput

Type: function

Description: 
- Param: _bt
- Param: _key

File: [client\ClientData\EscapeMenu_settingsGame.sqf at line 256](../../../Src/client/ClientData/EscapeMenu_settingsGame.sqf#L256)
## esc_settings_eventOnSwitcher

Type: function

Description: 
- Param: _bt

File: [client\ClientData\EscapeMenu_settingsGame.sqf at line 274](../../../Src/client/ClientData/EscapeMenu_settingsGame.sqf#L274)
## esc_settings_eventOnSlider

Type: function

Description: 
- Param: _bt
- Param: _newValue

File: [client\ClientData\EscapeMenu_settingsGame.sqf at line 298](../../../Src/client/ClientData/EscapeMenu_settingsGame.sqf#L298)
## esc_settings_eventOnBool

Type: function

Description: 
- Param: _bt

File: [client\ClientData\EscapeMenu_settingsGame.sqf at line 313](../../../Src/client/ClientData/EscapeMenu_settingsGame.sqf#L313)
## esc_settings_event_onSyncGame

Type: function

Description: 


File: [client\ClientData\EscapeMenu_settingsGame.sqf at line 336](../../../Src/client/ClientData/EscapeMenu_settingsGame.sqf#L336)
## cd_onLoadGameSettings

Type: function

Description: 
- Param: _list

File: [client\ClientData\EscapeMenu_settingsGame.sqf at line 344](../../../Src/client/ClientData/EscapeMenu_settingsGame.sqf#L344)
# EscapeMenu_settingsGraphics.sqf

## setting_element_size_x

Type: constant

Description: 


Replaced value:
```sqf
10
```
File: [client\ClientData\EscapeMenu_settingsGraphics.sqf at line 14](../../../Src/client/ClientData/EscapeMenu_settingsGraphics.sqf#L14)
## esc_settings_loader_graphic

Type: function

Description: 


File: [client\ClientData\EscapeMenu_settingsGraphics.sqf at line 11](../../../Src/client/ClientData/EscapeMenu_settingsGraphics.sqf#L11)
# EscapeMenu_settingsKeyboard.sqf

## setting_element_size_x

Type: constant

Description: 


Replaced value:
```sqf
10
```
File: [client\ClientData\EscapeMenu_settingsKeyboard.sqf at line 14](../../../Src/client/ClientData/EscapeMenu_settingsKeyboard.sqf#L14)
## __handled_event_type__

Type: constant

Description: 


Replaced value:
```sqf
"KeyUp"
```
File: [client\ClientData\EscapeMenu_settingsKeyboard.sqf at line 135](../../../Src/client/ClientData/EscapeMenu_settingsKeyboard.sqf#L135)
## esc_settings_loader_keyboard

Type: function

Description: 


File: [client\ClientData\EscapeMenu_settingsKeyboard.sqf at line 10](../../../Src/client/ClientData/EscapeMenu_settingsKeyboard.sqf#L10)
## esc_settings_onUpdateKeybinds

Type: function

Description: 
- Param: _enableAllButtons (optional, default false)

File: [client\ClientData\EscapeMenu_settingsKeyboard.sqf at line 58](../../../Src/client/ClientData/EscapeMenu_settingsKeyboard.sqf#L58)
## esc_settings_keyboard_changeButton

Type: function

Description: 
- Param: _button
- Param: _code
- Param: _shift
- Param: _control
- Param: _alt

File: [client\ClientData\EscapeMenu_settingsKeyboard.sqf at line 107](../../../Src/client/ClientData/EscapeMenu_settingsKeyboard.sqf#L107)
## esc_settings_event_onSyncKeyboard

Type: function

Description: 


File: [client\ClientData\EscapeMenu_settingsKeyboard.sqf at line 200](../../../Src/client/ClientData/EscapeMenu_settingsKeyboard.sqf#L200)
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
File: [client\ClientData\EyeHandler.sqf at line 27](../../../Src/client/ClientData/EyeHandler.sqf#L27)
## cd_eyeState

Type: Variable

Description: 


Initial value:
```sqf
1 // 0 - ok > 0 - closed
```
File: [client\ClientData\EyeHandler.sqf at line 10](../../../Src/client/ClientData/EyeHandler.sqf#L10)
## cd_isEyesClosed

Type: function

Description: 


File: [client\ClientData\EyeHandler.sqf at line 13](../../../Src/client/ClientData/EyeHandler.sqf#L13)
## cd_onChangeEyeState

Type: function

Description: 
- Param: _newState
- Param: _changeStateReason

File: [client\ClientData\EyeHandler.sqf at line 16](../../../Src/client/ClientData/EyeHandler.sqf#L16)
# SendCommand.sqf

## SC_SIZE_W

Type: constant

Description: 


Replaced value:
```sqf
40
```
File: [client\ClientData\SendCommand.sqf at line 12](../../../Src/client/ClientData/SendCommand.sqf#L12)
## SC_SIZE_H

Type: constant

Description: 


Replaced value:
```sqf
30
```
File: [client\ClientData\SendCommand.sqf at line 14](../../../Src/client/ClientData/SendCommand.sqf#L14)
## CD_MAX_COMMANDS_HISTORY_COUNT

Type: constant

Description: 


Replaced value:
```sqf
100
```
File: [client\ClientData\SendCommand.sqf at line 17](../../../Src/client/ClientData/SendCommand.sqf#L17)
## localCommand(name)

Type: constant

Description: 
- Param: name

Replaced value:
```sqf
_cd_map_dataCode = []; cd_commands_localCommandsList set [name,_cd_map_dataCode]; _cd_map_dataCode pushBack
```
File: [client\ClientData\SendCommand.sqf at line 315](../../../Src/client/ClientData/SendCommand.sqf#L315)
## arguments

Type: constant

Description: 


Replaced value:
```sqf
cd_internal_cmd_thisArguments
```
File: [client\ClientData\SendCommand.sqf at line 318](../../../Src/client/ClientData/SendCommand.sqf#L318)
## cd_commandHistoryBuffer

Type: Variable

Description: 


Initial value:
```sqf
[]
```
File: [client\ClientData\SendCommand.sqf at line 20](../../../Src/client/ClientData/SendCommand.sqf#L20)
## cd_commandHistoryBuffer

Type: Variable

> Exists if **EDITOR** not defined

Description: 


Initial value:
```sqf
[]
```
File: [client\ClientData\SendCommand.sqf at line 31](../../../Src/client/ClientData/SendCommand.sqf#L31)
## cd_commands_localCommandsList

Type: Variable

Description: 


Initial value:
```sqf
createHashMap
```
File: [client\ClientData\SendCommand.sqf at line 312](../../../Src/client/ClientData/SendCommand.sqf#L312)
## cd_openSendCommandWindow

Type: function

Description: 
- Param: _isLobbyContext (optional, default false)

File: [client\ClientData\SendCommand.sqf at line 36](../../../Src/client/ClientData/SendCommand.sqf#L36)
## cd_closeSendCommandWindow

Type: function

Description: 


File: [client\ClientData\SendCommand.sqf at line 269](../../../Src/client/ClientData/SendCommand.sqf#L269)
## cd_openAhelp

Type: function

Description: 


File: [client\ClientData\SendCommand.sqf at line 285](../../../Src/client/ClientData/SendCommand.sqf#L285)
## cd_onLocalCmdCall

Type: function

Description: 
- Param: _cmd
- Param: _args (optional, default 0)

File: [client\ClientData\SendCommand.sqf at line 299](../../../Src/client/ClientData/SendCommand.sqf#L299)
# VersionViewer.sqf

## versionviewer_timeout_init_clientname

Type: constant

Description: 


Replaced value:
```sqf
30
```
File: [client\ClientData\VersionViewer.sqf at line 13](../../../Src/client/ClientData/VersionViewer.sqf#L13)
## versionviewer_size_x

Type: constant

Description: 


Replaced value:
```sqf
14
```
File: [client\ClientData\VersionViewer.sqf at line 16](../../../Src/client/ClientData/VersionViewer.sqf#L16)
## versionviewer_size_y

Type: constant

Description: 


Replaced value:
```sqf
10
```
File: [client\ClientData\VersionViewer.sqf at line 18](../../../Src/client/ClientData/VersionViewer.sqf#L18)
## cd_vv_widgets

Type: Variable

Description: 


Initial value:
```sqf
[_ctg,_back,_txt]
```
File: [client\ClientData\VersionViewer.sqf at line 33](../../../Src/client/ClientData/VersionViewer.sqf#L33)
## cd_vv_syncVisual

Type: function

Description: 
- Param: _cliName (optional, default cd_clientName)

File: [client\ClientData\VersionViewer.sqf at line 36](../../../Src/client/ClientData/VersionViewer.sqf#L36)
