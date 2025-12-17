# smd.h

## smd_update_delay

Type: constant

Description: 


Replaced value:
```sqf
0
```
File: [client\SyncMobData\smd.h at line 12](../../../Src/client/SyncMobData/smd.h#L12)
## smd_local_prefix

Type: constant

Description: 


Replaced value:
```sqf
"__local_"
```
File: [client\SyncMobData\smd.h at line 16](../../../Src/client/SyncMobData/smd.h#L16)
# SMD_init.sqf

## VISIBILITY_MODE_DEFAULT

Type: constant

Description: 


Replaced value:
```sqf
0
```
File: [client\SyncMobData\SMD_init.sqf at line 993](../../../Src/client/SyncMobData/SMD_init.sqf#L993)
## VISIBILITY_MODE_GHOST

Type: constant

Description: 


Replaced value:
```sqf
1
```
File: [client\SyncMobData\SMD_init.sqf at line 994](../../../Src/client/SyncMobData/SMD_init.sqf#L994)
## VISIBILITY_MODE_STEALTH

Type: constant

Description: 


Replaced value:
```sqf
2
```
File: [client\SyncMobData\SMD_init.sqf at line 995](../../../Src/client/SyncMobData/SMD_init.sqf#L995)
## VISIBILITY_MODE_ADMIN

Type: constant

Description: 


Replaced value:
```sqf
3
```
File: [client\SyncMobData\SMD_init.sqf at line 996](../../../Src/client/SyncMobData/SMD_init.sqf#L996)
## VISIBILITY_MODE_CUSTOM

Type: constant

Description: 


Replaced value:
```sqf
4
```
File: [client\SyncMobData\SMD_init.sqf at line 997](../../../Src/client/SyncMobData/SMD_init.sqf#L997)
## smd_list_variables

Type: Variable

Description: 


Initial value:
```sqf
[...
```
File: [client\SyncMobData\SMD_init.sqf at line 32](../../../Src/client/SyncMobData/SMD_init.sqf#L32)
## smd_list_allSlots

Type: Variable

Description: adding inventory slots


Initial value:
```sqf
INV_LIST_ALL apply ...
```
File: [client\SyncMobData\SMD_init.sqf at line 58](../../../Src/client/SyncMobData/SMD_init.sqf#L58)
## smd_handle_update

Type: Variable

Description: 


Initial value:
```sqf
-1
```
File: [client\SyncMobData\SMD_init.sqf at line 76](../../../Src/client/SyncMobData/SMD_init.sqf#L76)
## smd_internal_map_vis

Type: Variable

Description: 


Initial value:
```sqf
createHashMapFromArray [...
```
File: [client\SyncMobData\SMD_init.sqf at line 1002](../../../Src/client/SyncMobData/SMD_init.sqf#L1002)
## smd_isProcessed

Type: function

Description: 


File: [client\SyncMobData\SMD_init.sqf at line 78](../../../Src/client/SyncMobData/SMD_init.sqf#L78)
## smd_startUpdate

Type: function

Description: 


File: [client\SyncMobData\SMD_init.sqf at line 80](../../../Src/client/SyncMobData/SMD_init.sqf#L80)
## smd_stopUpdate

Type: function

Description: 


File: [client\SyncMobData\SMD_init.sqf at line 94](../../../Src/client/SyncMobData/SMD_init.sqf#L94)
## smd_unloadVST

Type: function

Description: 
- Param: _prevPlayer

File: [client\SyncMobData\SMD_init.sqf at line 118](../../../Src/client/SyncMobData/SMD_init.sqf#L118)
## smd_onUpdate

Type: function

Description: 


File: [client\SyncMobData\SMD_init.sqf at line 129](../../../Src/client/SyncMobData/SMD_init.sqf#L129)
## smd_syncVar

Type: function

Description: 
- Param: _mob
- Param: _varName
- Param: _findByFunctionName (optional, default false)

File: [client\SyncMobData\SMD_init.sqf at line 210](../../../Src/client/SyncMobData/SMD_init.sqf#L210)
## smd_onUpdateSetting

Type: function

Description: 
- Param: _mob
- Param: _varName
- Param: _func

File: [client\SyncMobData\SMD_init.sqf at line 226](../../../Src/client/SyncMobData/SMD_init.sqf#L226)
## smd_onChangeFace

Type: function

Description: 
- Param: _mob
- Param: _ctx

File: [client\SyncMobData\SMD_init.sqf at line 240](../../../Src/client/SyncMobData/SMD_init.sqf#L240)
## smd_onChangeFaceAnim

Type: function

Description: 
- Param: _mob
- Param: _ctx

File: [client\SyncMobData\SMD_init.sqf at line 267](../../../Src/client/SyncMobData/SMD_init.sqf#L267)
## smd_onChangeBodyParts

Type: function

Description: 
- Param: _mob
- Param: _ctx

File: [client\SyncMobData\SMD_init.sqf at line 274](../../../Src/client/SyncMobData/SMD_init.sqf#L274)
## smd_onChangeCustomAnim

Type: function

Description: 
- Param: _mob
- Param: _ctx

File: [client\SyncMobData\SMD_init.sqf at line 297](../../../Src/client/SyncMobData/SMD_init.sqf#L297)
## smd_onChangeCombat

Type: function

Description: 
- Param: _mob
- Param: _ctx

File: [client\SyncMobData\SMD_init.sqf at line 309](../../../Src/client/SyncMobData/SMD_init.sqf#L309)
## smd_onAttackOrDamage

Type: function

Description: 
- Param: _mob
- Param: _ctx

File: [client\SyncMobData\SMD_init.sqf at line 324](../../../Src/client/SyncMobData/SMD_init.sqf#L324)
## smd_setSlotDataProcessor

Type: function

Description: 
- Param: _mob
- Param: _mode

File: [client\SyncMobData\SMD_init.sqf at line 475](../../../Src/client/SyncMobData/SMD_init.sqf#L475)
## smd_internal_deleteAttachments_rec

Type: function

Description: 


File: [client\SyncMobData\SMD_init.sqf at line 510](../../../Src/client/SyncMobData/SMD_init.sqf#L510)
## smd_onChangeSlotData

Type: function

Description: 
- Param: _mob
- Param: _ctx

File: [client\SyncMobData\SMD_init.sqf at line 519](../../../Src/client/SyncMobData/SMD_init.sqf#L519)
## smd_isSMDObjectInSlot

Type: function

Description: 


File: [client\SyncMobData\SMD_init.sqf at line 641](../../../Src/client/SyncMobData/SMD_init.sqf#L641)
## smd_getSMDObjectSlotId

Type: function

Description: 


File: [client\SyncMobData\SMD_init.sqf at line 646](../../../Src/client/SyncMobData/SMD_init.sqf#L646)
## smd_onStun

Type: function

Description: 
- Param: _mob
- Param: _ctx

File: [client\SyncMobData\SMD_init.sqf at line 651](../../../Src/client/SyncMobData/SMD_init.sqf#L651)
## smd_isStunned

Type: function

Description: 


File: [client\SyncMobData\SMD_init.sqf at line 657](../../../Src/client/SyncMobData/SMD_init.sqf#L657)
## smd_onGrabbed

Type: function

Description: 
- Param: _mob
- Param: _ctx

File: [client\SyncMobData\SMD_init.sqf at line 660](../../../Src/client/SyncMobData/SMD_init.sqf#L660)
## smd_isPulling

Type: function

Description: 
- Param: _mob

File: [client\SyncMobData\SMD_init.sqf at line 690](../../../Src/client/SyncMobData/SMD_init.sqf#L690)
## smd_getPullingObjectPtr

Type: function

Description: 
- Param: _mob

File: [client\SyncMobData\SMD_init.sqf at line 696](../../../Src/client/SyncMobData/SMD_init.sqf#L696)
## smd_pullSetTransformValues

Type: function

Description: 
- Param: _mob
- Param: _t
- Param: _v
- Param: _networkSync (optional, default false)

File: [client\SyncMobData\SMD_init.sqf at line 702](../../../Src/client/SyncMobData/SMD_init.sqf#L702)
## smd_pullUpdateTransform

Type: function

Description: 
- Param: _mob
- Param: _mode
- Param: _val
- Param: _netSync (optional, default true)

File: [client\SyncMobData\SMD_init.sqf at line 710](../../../Src/client/SyncMobData/SMD_init.sqf#L710)
## smd_pullGetTransformInfo

Type: function

Description: 
- Param: _mob

File: [client\SyncMobData\SMD_init.sqf at line 729](../../../Src/client/SyncMobData/SMD_init.sqf#L729)
## smd_pullGetHeplerObject

Type: function

Description: 
- Param: _mob

File: [client\SyncMobData\SMD_init.sqf at line 738](../../../Src/client/SyncMobData/SMD_init.sqf#L738)
## smd_onPull

Type: function

Description: 
- Param: _mob
- Param: _ctx

File: [client\SyncMobData\SMD_init.sqf at line 744](../../../Src/client/SyncMobData/SMD_init.sqf#L744)
## smd_onVisiblility

Type: function

Description: 
- Param: _mob
- Param: _ctx

File: [client\SyncMobData\SMD_init.sqf at line 1009](../../../Src/client/SyncMobData/SMD_init.sqf#L1009)
## smd_onVisualStates

Type: function

Description: 
- Param: _mob
- Param: _ctx

File: [client\SyncMobData\SMD_init.sqf at line 1024](../../../Src/client/SyncMobData/SMD_init.sqf#L1024)
## smd_hasVisualState

Type: function

Description: 
- Param: _mob
- Param: _state

File: [client\SyncMobData\SMD_init.sqf at line 1048](../../../Src/client/SyncMobData/SMD_init.sqf#L1048)
## smd_onInterpolate

Type: function

Description: 
- Param: _mob
- Param: _data

File: [client\SyncMobData\SMD_init.sqf at line 1057](../../../Src/client/SyncMobData/SMD_init.sqf#L1057)
## smd_onAnimSpeed

Type: function

Description: 
- Param: _mob
- Param: _val

File: [client\SyncMobData\SMD_init.sqf at line 1066](../../../Src/client/SyncMobData/SMD_init.sqf#L1066)
## smd_onDecals

Type: function

Description: 
- Param: _mob
- Param: _ctx

File: [client\SyncMobData\SMD_init.sqf at line 1072](../../../Src/client/SyncMobData/SMD_init.sqf#L1072)
## smd_getObjectInSlot

Type: function

Description: 
- Param: _mob
- Param: _slot

File: [client\SyncMobData\SMD_init.sqf at line 1079](../../../Src/client/SyncMobData/SMD_init.sqf#L1079)
## smd_getRedirectOnTwoHanded

Type: function

Description: 
- Param: _mob
- Param: _slot

File: [client\SyncMobData\SMD_init.sqf at line 1088](../../../Src/client/SyncMobData/SMD_init.sqf#L1088)
## smd_reloadMobsLighting

Type: function

Description: 


File: [client\SyncMobData\SMD_init.sqf at line 1096](../../../Src/client/SyncMobData/SMD_init.sqf#L1096)
## smd_createOffGeom

Type: function

Description: 
- Param: _user
- Param: _srcObj
- Param: _oGeom

File: [client\SyncMobData\SMD_init.sqf at line 1120](../../../Src/client/SyncMobData/SMD_init.sqf#L1120)
## smd_onChatMessage

Type: function

Description: 
- Param: _mob
- Param: _ctx

File: [client\SyncMobData\SMD_init.sqf at line 1149](../../../Src/client/SyncMobData/SMD_init.sqf#L1149)
## smd_onVoiceBlobInit

Type: function

Description: 
- Param: _mob
- Param: _ctx

File: [client\SyncMobData\SMD_init.sqf at line 1185](../../../Src/client/SyncMobData/SMD_init.sqf#L1185)
## smd_onIsPrintingSay

Type: function

Description: 
- Param: _mob
- Param: _ctx

File: [client\SyncMobData\SMD_init.sqf at line 1191](../../../Src/client/SyncMobData/SMD_init.sqf#L1191)
