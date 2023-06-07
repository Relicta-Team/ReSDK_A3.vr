# smd.h

## smd_update_delay

Type: constant

Description: частота обновления потока


Replaced value:
```sqf
0
```
File: [client\SyncMobData\smd.h at line 8](../../../Src/client/SyncMobData/smd.h#L8)
## smd_local_prefix

Type: constant

Description: префикс для локальной переменной на мобе, необходимой для сранвнеия значений


Replaced value:
```sqf
"__local_"
```
File: [client\SyncMobData\smd.h at line 11](../../../Src/client/SyncMobData/smd.h#L11)
# SMD_init.sqf

## VISIBILITY_MODE_DEFAULT

Type: constant

Description: TODO replace to header


Replaced value:
```sqf
0
```
File: [client\SyncMobData\SMD_init.sqf at line 545](../../../Src/client/SyncMobData/SMD_init.sqf#L545)
## VISIBILITY_MODE_GHOST

Type: constant

Description: 


Replaced value:
```sqf
1
```
File: [client\SyncMobData\SMD_init.sqf at line 546](../../../Src/client/SyncMobData/SMD_init.sqf#L546)
## VISIBILITY_MODE_STEALTH

Type: constant

Description: 


Replaced value:
```sqf
2
```
File: [client\SyncMobData\SMD_init.sqf at line 547](../../../Src/client/SyncMobData/SMD_init.sqf#L547)
## VISIBILITY_MODE_ADMIN

Type: constant

Description: 


Replaced value:
```sqf
3
```
File: [client\SyncMobData\SMD_init.sqf at line 548](../../../Src/client/SyncMobData/SMD_init.sqf#L548)
## VISIBILITY_MODE_CUSTOM

Type: constant

Description: 


Replaced value:
```sqf
4
```
File: [client\SyncMobData\SMD_init.sqf at line 549](../../../Src/client/SyncMobData/SMD_init.sqf#L549)
## smd_isProcessed

Type: function

Description: 


File: [client\SyncMobData\SMD_init.sqf at line 61](../../../Src/client/SyncMobData/SMD_init.sqf#L61)
## smd_startUpdate

Type: function

Description: 


File: [client\SyncMobData\SMD_init.sqf at line 62](../../../Src/client/SyncMobData/SMD_init.sqf#L62)
## smd_stopUpdate

Type: function

Description: 


File: [client\SyncMobData\SMD_init.sqf at line 74](../../../Src/client/SyncMobData/SMD_init.sqf#L74)
## smd_unloadVST

Type: function

Description: выгрузка визуальных эффектов с привязкой к старому локальному игроку
- Param: _prevPlayer

File: [client\SyncMobData\SMD_init.sqf at line 97](../../../Src/client/SyncMobData/SMD_init.sqf#L97)
## smd_onUpdate

Type: function

Description: 


File: [client\SyncMobData\SMD_init.sqf at line 106](../../../Src/client/SyncMobData/SMD_init.sqf#L106)
## smd_syncVar

Type: function

Description: Выполняет принудительную синхрозинацию переменной по её названию или названию функции
- Param: _mob
- Param: _varName
- Param: _findByFunctionName (optional, default false)

File: [client\SyncMobData\SMD_init.sqf at line 117](../../../Src/client/SyncMobData/SMD_init.sqf#L117)
## smd_onUpdateSetting

Type: function

Description: 
- Param: _mob
- Param: _varName
- Param: _func

File: [client\SyncMobData\SMD_init.sqf at line 131](../../../Src/client/SyncMobData/SMD_init.sqf#L131)
## smd_onChangeFace

Type: function

Description: событие смены лица
- Param: _mob
- Param: _ctx

File: [client\SyncMobData\SMD_init.sqf at line 144](../../../Src/client/SyncMobData/SMD_init.sqf#L144)
## smd_onChangeFaceAnim

Type: function

Description: Лицевая анимация
- Param: _mob
- Param: _ctx

File: [client\SyncMobData\SMD_init.sqf at line 170](../../../Src/client/SyncMobData/SMD_init.sqf#L170)
## smd_onChangeBodyParts

Type: function

Description: 
- Param: _mob
- Param: _ctx

File: [client\SyncMobData\SMD_init.sqf at line 176](../../../Src/client/SyncMobData/SMD_init.sqf#L176)
## smd_onChangeCustomAnim

Type: function

Description: 
- Param: _mob
- Param: _ctx

File: [client\SyncMobData\SMD_init.sqf at line 197](../../../Src/client/SyncMobData/SMD_init.sqf#L197)
## smd_onChangeCombat

Type: function

Description: 
- Param: _mob
- Param: _ctx

File: [client\SyncMobData\SMD_init.sqf at line 207](../../../Src/client/SyncMobData/SMD_init.sqf#L207)
## smd_onAttackOrDamage

Type: function

Description: smd_attdam
- Param: _mob
- Param: _ctx

File: [client\SyncMobData\SMD_init.sqf at line 221](../../../Src/client/SyncMobData/SMD_init.sqf#L221)
## smd_setSlotDataProcessor

Type: function

Description: 
- Param: _mob
- Param: _mode

File: [client\SyncMobData\SMD_init.sqf at line 360](../../../Src/client/SyncMobData/SMD_init.sqf#L360)
## smd_internal_deleteAttachments_rec

Type: function

Description: 


File: [client\SyncMobData\SMD_init.sqf at line 394](../../../Src/client/SyncMobData/SMD_init.sqf#L394)
## smd_onChangeSlotData

Type: function

Description: событие смены предмета в слоте
- Param: _mob
- Param: _ctx

File: [client\SyncMobData\SMD_init.sqf at line 402](../../../Src/client/SyncMobData/SMD_init.sqf#L402)
## smd_isSMDObjectInSlot

Type: function

Description: 


File: [client\SyncMobData\SMD_init.sqf at line 507](../../../Src/client/SyncMobData/SMD_init.sqf#L507)
## smd_onStun

Type: function

Description: 
- Param: _mob
- Param: _ctx

File: [client\SyncMobData\SMD_init.sqf at line 511](../../../Src/client/SyncMobData/SMD_init.sqf#L511)
## smd_isStunned

Type: function

Description: проверяет застанен ли персонаж


File: [client\SyncMobData\SMD_init.sqf at line 515](../../../Src/client/SyncMobData/SMD_init.sqf#L515)
## smd_onGrabbed

Type: function

Description: 
- Param: _mob
- Param: _ctx

File: [client\SyncMobData\SMD_init.sqf at line 518](../../../Src/client/SyncMobData/SMD_init.sqf#L518)
## smd_onVisiblility

Type: function

Description: 
- Param: _mob
- Param: _ctx

File: [client\SyncMobData\SMD_init.sqf at line 557](../../../Src/client/SyncMobData/SMD_init.sqf#L557)
## smd_onVisualStates

Type: function

Description: 
- Param: _mob
- Param: _ctx

File: [client\SyncMobData\SMD_init.sqf at line 571](../../../Src/client/SyncMobData/SMD_init.sqf#L571)
## smd_hasVisualState

Type: function

Description: check if unit have visual state [player,VST_HUMAN_STEALTH] call smd_hasVisualState;
- Param: _mob
- Param: _state

File: [client\SyncMobData\SMD_init.sqf at line 594](../../../Src/client/SyncMobData/SMD_init.sqf#L594)
## smd_getObjectInSlot

Type: function

Description: 
- Param: _mob
- Param: _slot

File: [client\SyncMobData\SMD_init.sqf at line 602](../../../Src/client/SyncMobData/SMD_init.sqf#L602)
## smd_getRedirectOnTwoHanded

Type: function

Description: 
- Param: _mob
- Param: _slot

File: [client\SyncMobData\SMD_init.sqf at line 610](../../../Src/client/SyncMobData/SMD_init.sqf#L610)
## smd_reloadMobsLighting

Type: function

Description: 


File: [client\SyncMobData\SMD_init.sqf at line 617](../../../Src/client/SyncMobData/SMD_init.sqf#L617)
## smd_onChatMessage

Type: function

Description: 
- Param: _mob
- Param: _ctx

File: [client\SyncMobData\SMD_init.sqf at line 640](../../../Src/client/SyncMobData/SMD_init.sqf#L640)
## smd_onVoiceBlobInit

Type: function

Description: ["_voiceType","_basePitch","_baseSpeed"]
- Param: _mob
- Param: _ctx

File: [client\SyncMobData\SMD_init.sqf at line 675](../../../Src/client/SyncMobData/SMD_init.sqf#L675)
## smd_onIsPrintingSay

Type: function

Description: 
- Param: _mob
- Param: _ctx

File: [client\SyncMobData\SMD_init.sqf at line 680](../../../Src/client/SyncMobData/SMD_init.sqf#L680)
