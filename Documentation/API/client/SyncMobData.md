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
File: [client\SyncMobData\SMD_init.sqf at line 974](../../../Src/client/SyncMobData/SMD_init.sqf#L974)
## VISIBILITY_MODE_GHOST

Type: constant

Description: 


Replaced value:
```sqf
1
```
File: [client\SyncMobData\SMD_init.sqf at line 975](../../../Src/client/SyncMobData/SMD_init.sqf#L975)
## VISIBILITY_MODE_STEALTH

Type: constant

Description: 


Replaced value:
```sqf
2
```
File: [client\SyncMobData\SMD_init.sqf at line 976](../../../Src/client/SyncMobData/SMD_init.sqf#L976)
## VISIBILITY_MODE_ADMIN

Type: constant

Description: 


Replaced value:
```sqf
3
```
File: [client\SyncMobData\SMD_init.sqf at line 977](../../../Src/client/SyncMobData/SMD_init.sqf#L977)
## VISIBILITY_MODE_CUSTOM

Type: constant

Description: 


Replaced value:
```sqf
4
```
File: [client\SyncMobData\SMD_init.sqf at line 978](../../../Src/client/SyncMobData/SMD_init.sqf#L978)
## smd_list_variables

Type: Variable

Description: 


Initial value:
```sqf
[...
```
File: [client\SyncMobData\SMD_init.sqf at line 29](../../../Src/client/SyncMobData/SMD_init.sqf#L29)
## smd_list_allSlots

Type: Variable

Description: adding inventory slots


Initial value:
```sqf
INV_LIST_ALL apply ...
```
File: [client\SyncMobData\SMD_init.sqf at line 55](../../../Src/client/SyncMobData/SMD_init.sqf#L55)
## smd_handle_update

Type: Variable

Description: 


Initial value:
```sqf
-1
```
File: [client\SyncMobData\SMD_init.sqf at line 73](../../../Src/client/SyncMobData/SMD_init.sqf#L73)
## smd_internal_map_vis

Type: Variable

Description: 


Initial value:
```sqf
createHashMapFromArray [...
```
File: [client\SyncMobData\SMD_init.sqf at line 983](../../../Src/client/SyncMobData/SMD_init.sqf#L983)
## smd_isProcessed

Type: function

Description: 


File: [client\SyncMobData\SMD_init.sqf at line 75](../../../Src/client/SyncMobData/SMD_init.sqf#L75)
## smd_startUpdate

Type: function

Description: 


File: [client\SyncMobData\SMD_init.sqf at line 77](../../../Src/client/SyncMobData/SMD_init.sqf#L77)
## smd_stopUpdate

Type: function

Description: 


File: [client\SyncMobData\SMD_init.sqf at line 91](../../../Src/client/SyncMobData/SMD_init.sqf#L91)
## smd_unloadVST

Type: function

Description: 
- Param: _prevPlayer

File: [client\SyncMobData\SMD_init.sqf at line 115](../../../Src/client/SyncMobData/SMD_init.sqf#L115)
## smd_onUpdate

Type: function

Description: 


File: [client\SyncMobData\SMD_init.sqf at line 126](../../../Src/client/SyncMobData/SMD_init.sqf#L126)
## smd_syncVar

Type: function

Description: 
- Param: _mob
- Param: _varName
- Param: _findByFunctionName (optional, default false)

File: [client\SyncMobData\SMD_init.sqf at line 207](../../../Src/client/SyncMobData/SMD_init.sqf#L207)
## smd_onUpdateSetting

Type: function

Description: 
- Param: _mob
- Param: _varName
- Param: _func

File: [client\SyncMobData\SMD_init.sqf at line 223](../../../Src/client/SyncMobData/SMD_init.sqf#L223)
## smd_onChangeFace

Type: function

Description: 
- Param: _mob
- Param: _ctx

File: [client\SyncMobData\SMD_init.sqf at line 237](../../../Src/client/SyncMobData/SMD_init.sqf#L237)
## smd_onChangeFaceAnim

Type: function

Description: 
- Param: _mob
- Param: _ctx

File: [client\SyncMobData\SMD_init.sqf at line 264](../../../Src/client/SyncMobData/SMD_init.sqf#L264)
## smd_onChangeBodyParts

Type: function

Description: 
- Param: _mob
- Param: _ctx

File: [client\SyncMobData\SMD_init.sqf at line 271](../../../Src/client/SyncMobData/SMD_init.sqf#L271)
## smd_onChangeCustomAnim

Type: function

Description: 
- Param: _mob
- Param: _ctx

File: [client\SyncMobData\SMD_init.sqf at line 294](../../../Src/client/SyncMobData/SMD_init.sqf#L294)
## smd_onChangeCombat

Type: function

Description: 
- Param: _mob
- Param: _ctx

File: [client\SyncMobData\SMD_init.sqf at line 306](../../../Src/client/SyncMobData/SMD_init.sqf#L306)
## smd_onAttackOrDamage

Type: function

Description: 
- Param: _mob
- Param: _ctx

File: [client\SyncMobData\SMD_init.sqf at line 321](../../../Src/client/SyncMobData/SMD_init.sqf#L321)
## smd_setSlotDataProcessor

Type: function

Description: 
- Param: _mob
- Param: _mode

File: [client\SyncMobData\SMD_init.sqf at line 472](../../../Src/client/SyncMobData/SMD_init.sqf#L472)
## smd_internal_deleteAttachments_rec

Type: function

Description: 


File: [client\SyncMobData\SMD_init.sqf at line 507](../../../Src/client/SyncMobData/SMD_init.sqf#L507)
## smd_onChangeSlotData

Type: function

Description: 
- Param: _mob
- Param: _ctx

File: [client\SyncMobData\SMD_init.sqf at line 516](../../../Src/client/SyncMobData/SMD_init.sqf#L516)
## smd_isSMDObjectInSlot

Type: function

Description: 


File: [client\SyncMobData\SMD_init.sqf at line 622](../../../Src/client/SyncMobData/SMD_init.sqf#L622)
## smd_getSMDObjectSlotId

Type: function

Description: 


File: [client\SyncMobData\SMD_init.sqf at line 627](../../../Src/client/SyncMobData/SMD_init.sqf#L627)
## smd_onStun

Type: function

Description: 
- Param: _mob
- Param: _ctx

File: [client\SyncMobData\SMD_init.sqf at line 632](../../../Src/client/SyncMobData/SMD_init.sqf#L632)
## smd_isStunned

Type: function

Description: 


File: [client\SyncMobData\SMD_init.sqf at line 638](../../../Src/client/SyncMobData/SMD_init.sqf#L638)
## smd_onGrabbed

Type: function

Description: 
- Param: _mob
- Param: _ctx

File: [client\SyncMobData\SMD_init.sqf at line 641](../../../Src/client/SyncMobData/SMD_init.sqf#L641)
## smd_isPulling

Type: function

Description: 
- Param: _mob

File: [client\SyncMobData\SMD_init.sqf at line 671](../../../Src/client/SyncMobData/SMD_init.sqf#L671)
## smd_getPullingObjectPtr

Type: function

Description: 
- Param: _mob

File: [client\SyncMobData\SMD_init.sqf at line 677](../../../Src/client/SyncMobData/SMD_init.sqf#L677)
## smd_pullSetTransformValues

Type: function

Description: 
- Param: _mob
- Param: _t
- Param: _v
- Param: _networkSync (optional, default false)

File: [client\SyncMobData\SMD_init.sqf at line 683](../../../Src/client/SyncMobData/SMD_init.sqf#L683)
## smd_pullUpdateTransform

Type: function

Description: 
- Param: _mob
- Param: _mode
- Param: _val
- Param: _netSync (optional, default true)

File: [client\SyncMobData\SMD_init.sqf at line 691](../../../Src/client/SyncMobData/SMD_init.sqf#L691)
## smd_pullGetTransformInfo

Type: function

Description: 
- Param: _mob

File: [client\SyncMobData\SMD_init.sqf at line 710](../../../Src/client/SyncMobData/SMD_init.sqf#L710)
## smd_pullGetHeplerObject

Type: function

Description: 
- Param: _mob

File: [client\SyncMobData\SMD_init.sqf at line 719](../../../Src/client/SyncMobData/SMD_init.sqf#L719)
## smd_onPull

Type: function

Description: 
- Param: _mob
- Param: _ctx

File: [client\SyncMobData\SMD_init.sqf at line 725](../../../Src/client/SyncMobData/SMD_init.sqf#L725)
## smd_onVisiblility

Type: function

Description: 
- Param: _mob
- Param: _ctx

File: [client\SyncMobData\SMD_init.sqf at line 990](../../../Src/client/SyncMobData/SMD_init.sqf#L990)
## smd_onVisualStates

Type: function

Description: 
- Param: _mob
- Param: _ctx

File: [client\SyncMobData\SMD_init.sqf at line 1005](../../../Src/client/SyncMobData/SMD_init.sqf#L1005)
## smd_hasVisualState

Type: function

Description: 
- Param: _mob
- Param: _state

File: [client\SyncMobData\SMD_init.sqf at line 1029](../../../Src/client/SyncMobData/SMD_init.sqf#L1029)
## smd_onInterpolate

Type: function

Description: 
- Param: _mob
- Param: _data

File: [client\SyncMobData\SMD_init.sqf at line 1038](../../../Src/client/SyncMobData/SMD_init.sqf#L1038)
## smd_onAnimSpeed

Type: function

Description: 
- Param: _mob
- Param: _val

File: [client\SyncMobData\SMD_init.sqf at line 1047](../../../Src/client/SyncMobData/SMD_init.sqf#L1047)
## smd_onDecals

Type: function

Description: 
- Param: _mob
- Param: _ctx

File: [client\SyncMobData\SMD_init.sqf at line 1053](../../../Src/client/SyncMobData/SMD_init.sqf#L1053)
## smd_getObjectInSlot

Type: function

Description: 
- Param: _mob
- Param: _slot

File: [client\SyncMobData\SMD_init.sqf at line 1060](../../../Src/client/SyncMobData/SMD_init.sqf#L1060)
## smd_getRedirectOnTwoHanded

Type: function

Description: 
- Param: _mob
- Param: _slot

File: [client\SyncMobData\SMD_init.sqf at line 1069](../../../Src/client/SyncMobData/SMD_init.sqf#L1069)
## smd_reloadMobsLighting

Type: function

Description: 


File: [client\SyncMobData\SMD_init.sqf at line 1077](../../../Src/client/SyncMobData/SMD_init.sqf#L1077)
## smd_createOffGeom

Type: function

Description: 
- Param: _user
- Param: _srcObj
- Param: _oGeom

File: [client\SyncMobData\SMD_init.sqf at line 1101](../../../Src/client/SyncMobData/SMD_init.sqf#L1101)
## smd_onChatMessage

Type: function

Description: 
- Param: _mob
- Param: _ctx

File: [client\SyncMobData\SMD_init.sqf at line 1130](../../../Src/client/SyncMobData/SMD_init.sqf#L1130)
## smd_onVoiceBlobInit

Type: function

Description: 
- Param: _mob
- Param: _ctx

File: [client\SyncMobData\SMD_init.sqf at line 1166](../../../Src/client/SyncMobData/SMD_init.sqf#L1166)
## smd_onIsPrintingSay

Type: function

Description: 
- Param: _mob
- Param: _ctx

File: [client\SyncMobData\SMD_init.sqf at line 1172](../../../Src/client/SyncMobData/SMD_init.sqf#L1172)
