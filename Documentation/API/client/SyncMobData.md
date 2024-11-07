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
File: [client\SyncMobData\SMD_init.sqf at line 729](../../../Src/client/SyncMobData/SMD_init.sqf#L729)
## VISIBILITY_MODE_GHOST

Type: constant

Description: 


Replaced value:
```sqf
1
```
File: [client\SyncMobData\SMD_init.sqf at line 730](../../../Src/client/SyncMobData/SMD_init.sqf#L730)
## VISIBILITY_MODE_STEALTH

Type: constant

Description: 


Replaced value:
```sqf
2
```
File: [client\SyncMobData\SMD_init.sqf at line 731](../../../Src/client/SyncMobData/SMD_init.sqf#L731)
## VISIBILITY_MODE_ADMIN

Type: constant

Description: 


Replaced value:
```sqf
3
```
File: [client\SyncMobData\SMD_init.sqf at line 732](../../../Src/client/SyncMobData/SMD_init.sqf#L732)
## VISIBILITY_MODE_CUSTOM

Type: constant

Description: 


Replaced value:
```sqf
4
```
File: [client\SyncMobData\SMD_init.sqf at line 733](../../../Src/client/SyncMobData/SMD_init.sqf#L733)
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
File: [client\SyncMobData\SMD_init.sqf at line 46](../../../Src/client/SyncMobData/SMD_init.sqf#L46)
## smd_handle_update

Type: Variable

Description: updater code


Initial value:
```sqf
-1
```
File: [client\SyncMobData\SMD_init.sqf at line 63](../../../Src/client/SyncMobData/SMD_init.sqf#L63)
## pulling_canPull

Type: Variable

Description: 


Initial value:
```sqf
false
```
File: [client\SyncMobData\SMD_init.sqf at line 560](../../../Src/client/SyncMobData/SMD_init.sqf#L560)
## smd_internal_map_vis

Type: Variable

Description: todo change to bitflags


Initial value:
```sqf
createHashMapFromArray [...
```
File: [client\SyncMobData\SMD_init.sqf at line 735](../../../Src/client/SyncMobData/SMD_init.sqf#L735)
## smd_isProcessed

Type: function

Description: 


File: [client\SyncMobData\SMD_init.sqf at line 64](../../../Src/client/SyncMobData/SMD_init.sqf#L64)
## smd_startUpdate

Type: function

Description: 


File: [client\SyncMobData\SMD_init.sqf at line 65](../../../Src/client/SyncMobData/SMD_init.sqf#L65)
## smd_stopUpdate

Type: function

Description: завершение обновления системы SMD


File: [client\SyncMobData\SMD_init.sqf at line 78](../../../Src/client/SyncMobData/SMD_init.sqf#L78)
## smd_unloadVST

Type: function

Description: выгрузка визуальных эффектов с привязкой к старому локальному игроку
- Param: _prevPlayer

File: [client\SyncMobData\SMD_init.sqf at line 101](../../../Src/client/SyncMobData/SMD_init.sqf#L101)
## smd_onUpdate

Type: function

Description: Обработчик обновления, вызываемый в каждом кадре


File: [client\SyncMobData\SMD_init.sqf at line 111](../../../Src/client/SyncMobData/SMD_init.sqf#L111)
## smd_syncVar

Type: function

Description: Выполняет принудительную синхрозинацию переменной по её названию или названию функции
- Param: _mob
- Param: _varName
- Param: _findByFunctionName (optional, default false)

File: [client\SyncMobData\SMD_init.sqf at line 122](../../../Src/client/SyncMobData/SMD_init.sqf#L122)
## smd_onUpdateSetting

Type: function

Description: Обновление настроек SMD
- Param: _mob
- Param: _varName
- Param: _func

File: [client\SyncMobData\SMD_init.sqf at line 137](../../../Src/client/SyncMobData/SMD_init.sqf#L137)
## smd_onChangeFace

Type: function

Description: событие смены лица
- Param: _mob
- Param: _ctx

File: [client\SyncMobData\SMD_init.sqf at line 150](../../../Src/client/SyncMobData/SMD_init.sqf#L150)
## smd_onChangeFaceAnim

Type: function

Description: Лицевая анимация
- Param: _mob
- Param: _ctx

File: [client\SyncMobData\SMD_init.sqf at line 176](../../../Src/client/SyncMobData/SMD_init.sqf#L176)
## smd_onChangeBodyParts

Type: function

Description: Изменения наличия частей тела
- Param: _mob
- Param: _ctx

File: [client\SyncMobData\SMD_init.sqf at line 182](../../../Src/client/SyncMobData/SMD_init.sqf#L182)
## smd_onChangeCustomAnim

Type: function

Description: Изменение и синхрозинация анимации персонажа
- Param: _mob
- Param: _ctx

File: [client\SyncMobData\SMD_init.sqf at line 204](../../../Src/client/SyncMobData/SMD_init.sqf#L204)
## smd_onChangeCombat

Type: function

Description: Изменение статуса боевого режима
- Param: _mob
- Param: _ctx

File: [client\SyncMobData\SMD_init.sqf at line 215](../../../Src/client/SyncMobData/SMD_init.sqf#L215)
## smd_onAttackOrDamage

Type: function

Description: smd_attdam
- Param: _mob
- Param: _ctx

File: [client\SyncMobData\SMD_init.sqf at line 229](../../../Src/client/SyncMobData/SMD_init.sqf#L229)
## smd_setSlotDataProcessor

Type: function

Description: 
- Param: _mob
- Param: _mode

File: [client\SyncMobData\SMD_init.sqf at line 368](../../../Src/client/SyncMobData/SMD_init.sqf#L368)
## smd_internal_deleteAttachments_rec

Type: function

Description: 


File: [client\SyncMobData\SMD_init.sqf at line 402](../../../Src/client/SyncMobData/SMD_init.sqf#L402)
## smd_onChangeSlotData

Type: function

Description: событие смены предмета в слоте
- Param: _mob
- Param: _ctx

File: [client\SyncMobData\SMD_init.sqf at line 410](../../../Src/client/SyncMobData/SMD_init.sqf#L410)
## smd_isSMDObjectInSlot

Type: function

Description: проверяет является ли объект смд слотом


File: [client\SyncMobData\SMD_init.sqf at line 516](../../../Src/client/SyncMobData/SMD_init.sqf#L516)
## smd_onStun

Type: function

Description: 
- Param: _mob
- Param: _ctx

File: [client\SyncMobData\SMD_init.sqf at line 520](../../../Src/client/SyncMobData/SMD_init.sqf#L520)
## smd_isStunned

Type: function

Description: проверяет застанен ли персонаж


File: [client\SyncMobData\SMD_init.sqf at line 524](../../../Src/client/SyncMobData/SMD_init.sqf#L524)
## smd_onGrabbed

Type: function

Description: 
- Param: _mob
- Param: _ctx

File: [client\SyncMobData\SMD_init.sqf at line 527](../../../Src/client/SyncMobData/SMD_init.sqf#L527)
## smd_isPulling

Type: function

Description: 
- Param: _mob

File: [client\SyncMobData\SMD_init.sqf at line 556](../../../Src/client/SyncMobData/SMD_init.sqf#L556)
## smd_onPull

Type: function

Description: 
- Param: _mob
- Param: _ctx

File: [client\SyncMobData\SMD_init.sqf at line 561](../../../Src/client/SyncMobData/SMD_init.sqf#L561)
## smd_onVisiblility

Type: function

Description: 
- Param: _mob
- Param: _ctx

File: [client\SyncMobData\SMD_init.sqf at line 741](../../../Src/client/SyncMobData/SMD_init.sqf#L741)
## smd_onVisualStates

Type: function

Description: 
- Param: _mob
- Param: _ctx

File: [client\SyncMobData\SMD_init.sqf at line 755](../../../Src/client/SyncMobData/SMD_init.sqf#L755)
## smd_hasVisualState

Type: function

Description: check if unit have visual state [player,VST_HUMAN_STEALTH] call smd_hasVisualState;
- Param: _mob
- Param: _state

File: [client\SyncMobData\SMD_init.sqf at line 778](../../../Src/client/SyncMobData/SMD_init.sqf#L778)
## smd_onInterpolate

Type: function

Description: 
- Param: _mob
- Param: _data

File: [client\SyncMobData\SMD_init.sqf at line 786](../../../Src/client/SyncMobData/SMD_init.sqf#L786)
## smd_onAnimSpeed

Type: function

Description: 
- Param: _mob
- Param: _val

File: [client\SyncMobData\SMD_init.sqf at line 794](../../../Src/client/SyncMobData/SMD_init.sqf#L794)
## smd_getObjectInSlot

Type: function

Description: 
- Param: _mob
- Param: _slot

File: [client\SyncMobData\SMD_init.sqf at line 799](../../../Src/client/SyncMobData/SMD_init.sqf#L799)
## smd_getRedirectOnTwoHanded

Type: function

Description: 
- Param: _mob
- Param: _slot

File: [client\SyncMobData\SMD_init.sqf at line 807](../../../Src/client/SyncMobData/SMD_init.sqf#L807)
## smd_reloadMobsLighting

Type: function

Description: 


File: [client\SyncMobData\SMD_init.sqf at line 814](../../../Src/client/SyncMobData/SMD_init.sqf#L814)
## smd_createOffGeom

Type: function

Description: 
- Param: _user
- Param: _srcObj
- Param: _oGeom

File: [client\SyncMobData\SMD_init.sqf at line 837](../../../Src/client/SyncMobData/SMD_init.sqf#L837)
## smd_onChatMessage

Type: function

Description: 
- Param: _mob
- Param: _ctx

File: [client\SyncMobData\SMD_init.sqf at line 865](../../../Src/client/SyncMobData/SMD_init.sqf#L865)
## smd_onVoiceBlobInit

Type: function

Description: ["_voiceType","_basePitch","_baseSpeed"]
- Param: _mob
- Param: _ctx

File: [client\SyncMobData\SMD_init.sqf at line 900](../../../Src/client/SyncMobData/SMD_init.sqf#L900)
## smd_onIsPrintingSay

Type: function

Description: 
- Param: _mob
- Param: _ctx

File: [client\SyncMobData\SMD_init.sqf at line 905](../../../Src/client/SyncMobData/SMD_init.sqf#L905)
