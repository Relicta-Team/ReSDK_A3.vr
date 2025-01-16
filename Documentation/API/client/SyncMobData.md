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
File: [client\SyncMobData\SMD_init.sqf at line 855](../../../Src/client/SyncMobData/SMD_init.sqf#L855)
## VISIBILITY_MODE_GHOST

Type: constant

Description: 


Replaced value:
```sqf
1
```
File: [client\SyncMobData\SMD_init.sqf at line 856](../../../Src/client/SyncMobData/SMD_init.sqf#L856)
## VISIBILITY_MODE_STEALTH

Type: constant

Description: 


Replaced value:
```sqf
2
```
File: [client\SyncMobData\SMD_init.sqf at line 857](../../../Src/client/SyncMobData/SMD_init.sqf#L857)
## VISIBILITY_MODE_ADMIN

Type: constant

Description: 


Replaced value:
```sqf
3
```
File: [client\SyncMobData\SMD_init.sqf at line 858](../../../Src/client/SyncMobData/SMD_init.sqf#L858)
## VISIBILITY_MODE_CUSTOM

Type: constant

Description: 


Replaced value:
```sqf
4
```
File: [client\SyncMobData\SMD_init.sqf at line 859](../../../Src/client/SyncMobData/SMD_init.sqf#L859)
## smd_list_variables

Type: Variable

Description: ассоциативный список переменная слежения, метод выполнения при изменении состояния


Initial value:
```sqf
[...
```
File: [client\SyncMobData\SMD_init.sqf at line 27](../../../Src/client/SyncMobData/SMD_init.sqf#L27)
## smd_list_allSlots

Type: Variable

Description: adding inventory slots


Initial value:
```sqf
INV_LIST_ALL apply ...
```
File: [client\SyncMobData\SMD_init.sqf at line 48](../../../Src/client/SyncMobData/SMD_init.sqf#L48)
## smd_handle_update

Type: Variable

Description: updater code


Initial value:
```sqf
-1
```
File: [client\SyncMobData\SMD_init.sqf at line 65](../../../Src/client/SyncMobData/SMD_init.sqf#L65)
## smd_internal_map_vis

Type: Variable

Description: todo change to bitflags


Initial value:
```sqf
createHashMapFromArray [...
```
File: [client\SyncMobData\SMD_init.sqf at line 861](../../../Src/client/SyncMobData/SMD_init.sqf#L861)
## smd_isProcessed

Type: function

Description: 


File: [client\SyncMobData\SMD_init.sqf at line 66](../../../Src/client/SyncMobData/SMD_init.sqf#L66)
## smd_startUpdate

Type: function

Description: 


File: [client\SyncMobData\SMD_init.sqf at line 67](../../../Src/client/SyncMobData/SMD_init.sqf#L67)
## smd_stopUpdate

Type: function

Description: завершение обновления системы SMD


File: [client\SyncMobData\SMD_init.sqf at line 80](../../../Src/client/SyncMobData/SMD_init.sqf#L80)
## smd_unloadVST

Type: function

Description: выгрузка визуальных эффектов с привязкой к старому локальному игроку
- Param: _prevPlayer

File: [client\SyncMobData\SMD_init.sqf at line 103](../../../Src/client/SyncMobData/SMD_init.sqf#L103)
## smd_onUpdate

Type: function

Description: Обработчик обновления, вызываемый в каждом кадре


File: [client\SyncMobData\SMD_init.sqf at line 113](../../../Src/client/SyncMobData/SMD_init.sqf#L113)
## smd_syncVar

Type: function

Description: Выполняет принудительную синхрозинацию переменной по её названию или названию функции
- Param: _mob
- Param: _varName
- Param: _findByFunctionName (optional, default false)

File: [client\SyncMobData\SMD_init.sqf at line 124](../../../Src/client/SyncMobData/SMD_init.sqf#L124)
## smd_onUpdateSetting

Type: function

Description: Обновление настроек SMD
- Param: _mob
- Param: _varName
- Param: _func

File: [client\SyncMobData\SMD_init.sqf at line 139](../../../Src/client/SyncMobData/SMD_init.sqf#L139)
## smd_onChangeFace

Type: function

Description: событие смены лица
- Param: _mob
- Param: _ctx

File: [client\SyncMobData\SMD_init.sqf at line 152](../../../Src/client/SyncMobData/SMD_init.sqf#L152)
## smd_onChangeFaceAnim

Type: function

Description: Лицевая анимация
- Param: _mob
- Param: _ctx

File: [client\SyncMobData\SMD_init.sqf at line 178](../../../Src/client/SyncMobData/SMD_init.sqf#L178)
## smd_onChangeBodyParts

Type: function

Description: Изменения наличия частей тела
- Param: _mob
- Param: _ctx

File: [client\SyncMobData\SMD_init.sqf at line 184](../../../Src/client/SyncMobData/SMD_init.sqf#L184)
## smd_onChangeCustomAnim

Type: function

Description: Изменение и синхрозинация анимации персонажа
- Param: _mob
- Param: _ctx

File: [client\SyncMobData\SMD_init.sqf at line 206](../../../Src/client/SyncMobData/SMD_init.sqf#L206)
## smd_onChangeCombat

Type: function

Description: Изменение статуса боевого режима
- Param: _mob
- Param: _ctx

File: [client\SyncMobData\SMD_init.sqf at line 217](../../../Src/client/SyncMobData/SMD_init.sqf#L217)
## smd_onAttackOrDamage

Type: function

Description: smd_attdam
- Param: _mob
- Param: _ctx

File: [client\SyncMobData\SMD_init.sqf at line 231](../../../Src/client/SyncMobData/SMD_init.sqf#L231)
## smd_setSlotDataProcessor

Type: function

Description: 
- Param: _mob
- Param: _mode

File: [client\SyncMobData\SMD_init.sqf at line 370](../../../Src/client/SyncMobData/SMD_init.sqf#L370)
## smd_internal_deleteAttachments_rec

Type: function

Description: 


File: [client\SyncMobData\SMD_init.sqf at line 404](../../../Src/client/SyncMobData/SMD_init.sqf#L404)
## smd_onChangeSlotData

Type: function

Description: событие смены предмета в слоте
- Param: _mob
- Param: _ctx

File: [client\SyncMobData\SMD_init.sqf at line 412](../../../Src/client/SyncMobData/SMD_init.sqf#L412)
## smd_isSMDObjectInSlot

Type: function

Description: проверяет является ли объект смд слотом


File: [client\SyncMobData\SMD_init.sqf at line 518](../../../Src/client/SyncMobData/SMD_init.sqf#L518)
## smd_getSMDObjectSlotId

Type: function

Description: 


File: [client\SyncMobData\SMD_init.sqf at line 522](../../../Src/client/SyncMobData/SMD_init.sqf#L522)
## smd_onStun

Type: function

Description: 
- Param: _mob
- Param: _ctx

File: [client\SyncMobData\SMD_init.sqf at line 526](../../../Src/client/SyncMobData/SMD_init.sqf#L526)
## smd_isStunned

Type: function

Description: проверяет застанен ли персонаж


File: [client\SyncMobData\SMD_init.sqf at line 530](../../../Src/client/SyncMobData/SMD_init.sqf#L530)
## smd_onGrabbed

Type: function

Description: 
- Param: _mob
- Param: _ctx

File: [client\SyncMobData\SMD_init.sqf at line 533](../../../Src/client/SyncMobData/SMD_init.sqf#L533)
## smd_isPulling

Type: function

Description: 
- Param: _mob

File: [client\SyncMobData\SMD_init.sqf at line 562](../../../Src/client/SyncMobData/SMD_init.sqf#L562)
## smd_getPullingObjectPtr

Type: function

Description: 
- Param: _mob

File: [client\SyncMobData\SMD_init.sqf at line 566](../../../Src/client/SyncMobData/SMD_init.sqf#L566)
## smd_pullSetTransformValues

Type: function

Description: 
- Param: _mob
- Param: _t
- Param: _v
- Param: _networkSync (optional, default false)

File: [client\SyncMobData\SMD_init.sqf at line 571](../../../Src/client/SyncMobData/SMD_init.sqf#L571)
## smd_pullUpdateTransform

Type: function

Description: can be call only on local client
- Param: _mob
- Param: _mode
- Param: _val
- Param: _netSync (optional, default true)

File: [client\SyncMobData\SMD_init.sqf at line 577](../../../Src/client/SyncMobData/SMD_init.sqf#L577)
## smd_pullGetTransformInfo

Type: function

Description: 
- Param: _mob

File: [client\SyncMobData\SMD_init.sqf at line 594](../../../Src/client/SyncMobData/SMD_init.sqf#L594)
## smd_pullGetHeplerObject

Type: function

Description: 
- Param: _mob

File: [client\SyncMobData\SMD_init.sqf at line 602](../../../Src/client/SyncMobData/SMD_init.sqf#L602)
## smd_onPull

Type: function

Description: 
- Param: _mob
- Param: _ctx

File: [client\SyncMobData\SMD_init.sqf at line 607](../../../Src/client/SyncMobData/SMD_init.sqf#L607)
## smd_onVisiblility

Type: function

Description: 
- Param: _mob
- Param: _ctx

File: [client\SyncMobData\SMD_init.sqf at line 867](../../../Src/client/SyncMobData/SMD_init.sqf#L867)
## smd_onVisualStates

Type: function

Description: 
- Param: _mob
- Param: _ctx

File: [client\SyncMobData\SMD_init.sqf at line 881](../../../Src/client/SyncMobData/SMD_init.sqf#L881)
## smd_hasVisualState

Type: function

Description: check if unit have visual state [player,VST_HUMAN_STEALTH] call smd_hasVisualState;
- Param: _mob
- Param: _state

File: [client\SyncMobData\SMD_init.sqf at line 904](../../../Src/client/SyncMobData/SMD_init.sqf#L904)
## smd_onInterpolate

Type: function

Description: 
- Param: _mob
- Param: _data

File: [client\SyncMobData\SMD_init.sqf at line 912](../../../Src/client/SyncMobData/SMD_init.sqf#L912)
## smd_onAnimSpeed

Type: function

Description: 
- Param: _mob
- Param: _val

File: [client\SyncMobData\SMD_init.sqf at line 920](../../../Src/client/SyncMobData/SMD_init.sqf#L920)
## smd_getObjectInSlot

Type: function

Description: 
- Param: _mob
- Param: _slot

File: [client\SyncMobData\SMD_init.sqf at line 925](../../../Src/client/SyncMobData/SMD_init.sqf#L925)
## smd_getRedirectOnTwoHanded

Type: function

Description: 
- Param: _mob
- Param: _slot

File: [client\SyncMobData\SMD_init.sqf at line 933](../../../Src/client/SyncMobData/SMD_init.sqf#L933)
## smd_reloadMobsLighting

Type: function

Description: 


File: [client\SyncMobData\SMD_init.sqf at line 940](../../../Src/client/SyncMobData/SMD_init.sqf#L940)
## smd_createOffGeom

Type: function

Description: 
- Param: _user
- Param: _srcObj
- Param: _oGeom

File: [client\SyncMobData\SMD_init.sqf at line 963](../../../Src/client/SyncMobData/SMD_init.sqf#L963)
## smd_onChatMessage

Type: function

Description: 
- Param: _mob
- Param: _ctx

File: [client\SyncMobData\SMD_init.sqf at line 991](../../../Src/client/SyncMobData/SMD_init.sqf#L991)
## smd_onVoiceBlobInit

Type: function

Description: ["_voiceType","_basePitch","_baseSpeed"]
- Param: _mob
- Param: _ctx

File: [client\SyncMobData\SMD_init.sqf at line 1026](../../../Src/client/SyncMobData/SMD_init.sqf#L1026)
## smd_onIsPrintingSay

Type: function

Description: 
- Param: _mob
- Param: _ctx

File: [client\SyncMobData\SMD_init.sqf at line 1031](../../../Src/client/SyncMobData/SMD_init.sqf#L1031)
