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
File: [client\SyncMobData\SMD_init.sqf at line 553](../../../Src/client/SyncMobData/SMD_init.sqf#L553)
## VISIBILITY_MODE_GHOST

Type: constant

Description: 


Replaced value:
```sqf
1
```
File: [client\SyncMobData\SMD_init.sqf at line 554](../../../Src/client/SyncMobData/SMD_init.sqf#L554)
## VISIBILITY_MODE_STEALTH

Type: constant

Description: 


Replaced value:
```sqf
2
```
File: [client\SyncMobData\SMD_init.sqf at line 555](../../../Src/client/SyncMobData/SMD_init.sqf#L555)
## VISIBILITY_MODE_ADMIN

Type: constant

Description: 


Replaced value:
```sqf
3
```
File: [client\SyncMobData\SMD_init.sqf at line 556](../../../Src/client/SyncMobData/SMD_init.sqf#L556)
## VISIBILITY_MODE_CUSTOM

Type: constant

Description: 


Replaced value:
```sqf
4
```
File: [client\SyncMobData\SMD_init.sqf at line 557](../../../Src/client/SyncMobData/SMD_init.sqf#L557)
## smd_list_variables

Type: Variable

Description: ассоциативный список переменная слежения, метод выполнения при изменении состояния


Initial value:
```sqf
[...
```
File: [client\SyncMobData\SMD_init.sqf at line 25](../../../Src/client/SyncMobData/SMD_init.sqf#L25)
## smd_list_allSlots

Type: Variable

Description: adding inventory slots


Initial value:
```sqf
INV_LIST_ALL apply ...
```
File: [client\SyncMobData\SMD_init.sqf at line 45](../../../Src/client/SyncMobData/SMD_init.sqf#L45)
## smd_handle_update

Type: Variable

Description: updater code


Initial value:
```sqf
-1
```
File: [client\SyncMobData\SMD_init.sqf at line 62](../../../Src/client/SyncMobData/SMD_init.sqf#L62)
## smd_internal_map_vis

Type: Variable

Description: todo change to bitflags


Initial value:
```sqf
createHashMapFromArray [...
```
File: [client\SyncMobData\SMD_init.sqf at line 559](../../../Src/client/SyncMobData/SMD_init.sqf#L559)
## smd_isProcessed

Type: function

Description: 


File: [client\SyncMobData\SMD_init.sqf at line 63](../../../Src/client/SyncMobData/SMD_init.sqf#L63)
## smd_startUpdate

Type: function

Description: 


File: [client\SyncMobData\SMD_init.sqf at line 64](../../../Src/client/SyncMobData/SMD_init.sqf#L64)
## smd_stopUpdate

Type: function

Description: завершение обновления системы SMD


File: [client\SyncMobData\SMD_init.sqf at line 77](../../../Src/client/SyncMobData/SMD_init.sqf#L77)
## smd_unloadVST

Type: function

Description: выгрузка визуальных эффектов с привязкой к старому локальному игроку
- Param: _prevPlayer

File: [client\SyncMobData\SMD_init.sqf at line 100](../../../Src/client/SyncMobData/SMD_init.sqf#L100)
## smd_onUpdate

Type: function

Description: Обработчик обновления, вызываемый в каждом кадре


File: [client\SyncMobData\SMD_init.sqf at line 110](../../../Src/client/SyncMobData/SMD_init.sqf#L110)
## smd_syncVar

Type: function

Description: Выполняет принудительную синхрозинацию переменной по её названию или названию функции
- Param: _mob
- Param: _varName
- Param: _findByFunctionName (optional, default false)

File: [client\SyncMobData\SMD_init.sqf at line 121](../../../Src/client/SyncMobData/SMD_init.sqf#L121)
## smd_onUpdateSetting

Type: function

Description: Обновление настроек SMD
- Param: _mob
- Param: _varName
- Param: _func

File: [client\SyncMobData\SMD_init.sqf at line 136](../../../Src/client/SyncMobData/SMD_init.sqf#L136)
## smd_onChangeFace

Type: function

Description: событие смены лица
- Param: _mob
- Param: _ctx

File: [client\SyncMobData\SMD_init.sqf at line 149](../../../Src/client/SyncMobData/SMD_init.sqf#L149)
## smd_onChangeFaceAnim

Type: function

Description: Лицевая анимация
- Param: _mob
- Param: _ctx

File: [client\SyncMobData\SMD_init.sqf at line 175](../../../Src/client/SyncMobData/SMD_init.sqf#L175)
## smd_onChangeBodyParts

Type: function

Description: Изменения наличия частей тела
- Param: _mob
- Param: _ctx

File: [client\SyncMobData\SMD_init.sqf at line 181](../../../Src/client/SyncMobData/SMD_init.sqf#L181)
## smd_onChangeCustomAnim

Type: function

Description: Изменение и синхрозинация анимации персонажа
- Param: _mob
- Param: _ctx

File: [client\SyncMobData\SMD_init.sqf at line 203](../../../Src/client/SyncMobData/SMD_init.sqf#L203)
## smd_onChangeCombat

Type: function

Description: Изменение статуса боевого режима
- Param: _mob
- Param: _ctx

File: [client\SyncMobData\SMD_init.sqf at line 214](../../../Src/client/SyncMobData/SMD_init.sqf#L214)
## smd_onAttackOrDamage

Type: function

Description: smd_attdam
- Param: _mob
- Param: _ctx

File: [client\SyncMobData\SMD_init.sqf at line 228](../../../Src/client/SyncMobData/SMD_init.sqf#L228)
## smd_setSlotDataProcessor

Type: function

Description: 
- Param: _mob
- Param: _mode

File: [client\SyncMobData\SMD_init.sqf at line 367](../../../Src/client/SyncMobData/SMD_init.sqf#L367)
## smd_internal_deleteAttachments_rec

Type: function

Description: 


File: [client\SyncMobData\SMD_init.sqf at line 401](../../../Src/client/SyncMobData/SMD_init.sqf#L401)
## smd_onChangeSlotData

Type: function

Description: событие смены предмета в слоте
- Param: _mob
- Param: _ctx

File: [client\SyncMobData\SMD_init.sqf at line 409](../../../Src/client/SyncMobData/SMD_init.sqf#L409)
## smd_isSMDObjectInSlot

Type: function

Description: проверяет является ли объект смд слотом


File: [client\SyncMobData\SMD_init.sqf at line 515](../../../Src/client/SyncMobData/SMD_init.sqf#L515)
## smd_onStun

Type: function

Description: 
- Param: _mob
- Param: _ctx

File: [client\SyncMobData\SMD_init.sqf at line 519](../../../Src/client/SyncMobData/SMD_init.sqf#L519)
## smd_isStunned

Type: function

Description: проверяет застанен ли персонаж


File: [client\SyncMobData\SMD_init.sqf at line 523](../../../Src/client/SyncMobData/SMD_init.sqf#L523)
## smd_onGrabbed

Type: function

Description: 
- Param: _mob
- Param: _ctx

File: [client\SyncMobData\SMD_init.sqf at line 526](../../../Src/client/SyncMobData/SMD_init.sqf#L526)
## smd_onVisiblility

Type: function

Description: 
- Param: _mob
- Param: _ctx

File: [client\SyncMobData\SMD_init.sqf at line 565](../../../Src/client/SyncMobData/SMD_init.sqf#L565)
## smd_onVisualStates

Type: function

Description: 
- Param: _mob
- Param: _ctx

File: [client\SyncMobData\SMD_init.sqf at line 579](../../../Src/client/SyncMobData/SMD_init.sqf#L579)
## smd_hasVisualState

Type: function

Description: check if unit have visual state [player,VST_HUMAN_STEALTH] call smd_hasVisualState;
- Param: _mob
- Param: _state

File: [client\SyncMobData\SMD_init.sqf at line 602](../../../Src/client/SyncMobData/SMD_init.sqf#L602)
## smd_onInterpolate

Type: function

Description: 
- Param: _mob
- Param: _data

File: [client\SyncMobData\SMD_init.sqf at line 610](../../../Src/client/SyncMobData/SMD_init.sqf#L610)
## smd_onAnimSpeed

Type: function

Description: 
- Param: _mob
- Param: _val

File: [client\SyncMobData\SMD_init.sqf at line 618](../../../Src/client/SyncMobData/SMD_init.sqf#L618)
## smd_getObjectInSlot

Type: function

Description: 
- Param: _mob
- Param: _slot

File: [client\SyncMobData\SMD_init.sqf at line 623](../../../Src/client/SyncMobData/SMD_init.sqf#L623)
## smd_getRedirectOnTwoHanded

Type: function

Description: 
- Param: _mob
- Param: _slot

File: [client\SyncMobData\SMD_init.sqf at line 631](../../../Src/client/SyncMobData/SMD_init.sqf#L631)
## smd_reloadMobsLighting

Type: function

Description: 


File: [client\SyncMobData\SMD_init.sqf at line 638](../../../Src/client/SyncMobData/SMD_init.sqf#L638)
## smd_onChatMessage

Type: function

Description: 
- Param: _mob
- Param: _ctx

File: [client\SyncMobData\SMD_init.sqf at line 661](../../../Src/client/SyncMobData/SMD_init.sqf#L661)
## smd_onVoiceBlobInit

Type: function

Description: ["_voiceType","_basePitch","_baseSpeed"]
- Param: _mob
- Param: _ctx

File: [client\SyncMobData\SMD_init.sqf at line 696](../../../Src/client/SyncMobData/SMD_init.sqf#L696)
## smd_onIsPrintingSay

Type: function

Description: 
- Param: _mob
- Param: _ctx

File: [client\SyncMobData\SMD_init.sqf at line 701](../../../Src/client/SyncMobData/SMD_init.sqf#L701)
