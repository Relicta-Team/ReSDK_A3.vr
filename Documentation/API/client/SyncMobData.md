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
File: [client\SyncMobData\SMD_init.sqf at line 851](../../../Src/client/SyncMobData/SMD_init.sqf#L851)
## VISIBILITY_MODE_GHOST

Type: constant

Description: 


Replaced value:
```sqf
1
```
File: [client\SyncMobData\SMD_init.sqf at line 852](../../../Src/client/SyncMobData/SMD_init.sqf#L852)
## VISIBILITY_MODE_STEALTH

Type: constant

Description: 


Replaced value:
```sqf
2
```
File: [client\SyncMobData\SMD_init.sqf at line 853](../../../Src/client/SyncMobData/SMD_init.sqf#L853)
## VISIBILITY_MODE_ADMIN

Type: constant

Description: 


Replaced value:
```sqf
3
```
File: [client\SyncMobData\SMD_init.sqf at line 854](../../../Src/client/SyncMobData/SMD_init.sqf#L854)
## VISIBILITY_MODE_CUSTOM

Type: constant

Description: 


Replaced value:
```sqf
4
```
File: [client\SyncMobData\SMD_init.sqf at line 855](../../../Src/client/SyncMobData/SMD_init.sqf#L855)
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
File: [client\SyncMobData\SMD_init.sqf at line 857](../../../Src/client/SyncMobData/SMD_init.sqf#L857)
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
## smd_onStun

Type: function

Description: 
- Param: _mob
- Param: _ctx

File: [client\SyncMobData\SMD_init.sqf at line 522](../../../Src/client/SyncMobData/SMD_init.sqf#L522)
## smd_isStunned

Type: function

Description: проверяет застанен ли персонаж


File: [client\SyncMobData\SMD_init.sqf at line 526](../../../Src/client/SyncMobData/SMD_init.sqf#L526)
## smd_onGrabbed

Type: function

Description: 
- Param: _mob
- Param: _ctx

File: [client\SyncMobData\SMD_init.sqf at line 529](../../../Src/client/SyncMobData/SMD_init.sqf#L529)
## smd_isPulling

Type: function

Description: 
- Param: _mob

File: [client\SyncMobData\SMD_init.sqf at line 558](../../../Src/client/SyncMobData/SMD_init.sqf#L558)
## smd_getPullingObjectPtr

Type: function

Description: 
- Param: _mob

File: [client\SyncMobData\SMD_init.sqf at line 562](../../../Src/client/SyncMobData/SMD_init.sqf#L562)
## smd_pullSetTransformValues

Type: function

Description: 
- Param: _mob
- Param: _t
- Param: _v
- Param: _networkSync (optional, default false)

File: [client\SyncMobData\SMD_init.sqf at line 567](../../../Src/client/SyncMobData/SMD_init.sqf#L567)
## smd_pullUpdateTransform

Type: function

Description: can be call only on local client
- Param: _mob
- Param: _mode
- Param: _val
- Param: _netSync (optional, default true)

File: [client\SyncMobData\SMD_init.sqf at line 573](../../../Src/client/SyncMobData/SMD_init.sqf#L573)
## smd_pullGetTransformInfo

Type: function

Description: 
- Param: _mob

File: [client\SyncMobData\SMD_init.sqf at line 590](../../../Src/client/SyncMobData/SMD_init.sqf#L590)
## smd_pullGetHeplerObject

Type: function

Description: 
- Param: _mob

File: [client\SyncMobData\SMD_init.sqf at line 598](../../../Src/client/SyncMobData/SMD_init.sqf#L598)
## smd_onPull

Type: function

Description: 
- Param: _mob
- Param: _ctx

File: [client\SyncMobData\SMD_init.sqf at line 603](../../../Src/client/SyncMobData/SMD_init.sqf#L603)
## smd_onVisiblility

Type: function

Description: 
- Param: _mob
- Param: _ctx

File: [client\SyncMobData\SMD_init.sqf at line 863](../../../Src/client/SyncMobData/SMD_init.sqf#L863)
## smd_onVisualStates

Type: function

Description: 
- Param: _mob
- Param: _ctx

File: [client\SyncMobData\SMD_init.sqf at line 877](../../../Src/client/SyncMobData/SMD_init.sqf#L877)
## smd_hasVisualState

Type: function

Description: check if unit have visual state [player,VST_HUMAN_STEALTH] call smd_hasVisualState;
- Param: _mob
- Param: _state

File: [client\SyncMobData\SMD_init.sqf at line 900](../../../Src/client/SyncMobData/SMD_init.sqf#L900)
## smd_onInterpolate

Type: function

Description: 
- Param: _mob
- Param: _data

File: [client\SyncMobData\SMD_init.sqf at line 908](../../../Src/client/SyncMobData/SMD_init.sqf#L908)
## smd_onAnimSpeed

Type: function

Description: 
- Param: _mob
- Param: _val

File: [client\SyncMobData\SMD_init.sqf at line 916](../../../Src/client/SyncMobData/SMD_init.sqf#L916)
## smd_getObjectInSlot

Type: function

Description: 
- Param: _mob
- Param: _slot

File: [client\SyncMobData\SMD_init.sqf at line 921](../../../Src/client/SyncMobData/SMD_init.sqf#L921)
## smd_getRedirectOnTwoHanded

Type: function

Description: 
- Param: _mob
- Param: _slot

File: [client\SyncMobData\SMD_init.sqf at line 929](../../../Src/client/SyncMobData/SMD_init.sqf#L929)
## smd_reloadMobsLighting

Type: function

Description: 


File: [client\SyncMobData\SMD_init.sqf at line 936](../../../Src/client/SyncMobData/SMD_init.sqf#L936)
## smd_createOffGeom

Type: function

Description: 
- Param: _user
- Param: _srcObj
- Param: _oGeom

File: [client\SyncMobData\SMD_init.sqf at line 959](../../../Src/client/SyncMobData/SMD_init.sqf#L959)
## smd_onChatMessage

Type: function

Description: 
- Param: _mob
- Param: _ctx

File: [client\SyncMobData\SMD_init.sqf at line 987](../../../Src/client/SyncMobData/SMD_init.sqf#L987)
## smd_onVoiceBlobInit

Type: function

Description: ["_voiceType","_basePitch","_baseSpeed"]
- Param: _mob
- Param: _ctx

File: [client\SyncMobData\SMD_init.sqf at line 1022](../../../Src/client/SyncMobData/SMD_init.sqf#L1022)
## smd_onIsPrintingSay

Type: function

Description: 
- Param: _mob
- Param: _ctx

File: [client\SyncMobData\SMD_init.sqf at line 1027](../../../Src/client/SyncMobData/SMD_init.sqf#L1027)
