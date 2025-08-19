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
File: [client\SyncMobData\SMD_init.sqf at line 973](../../../Src/client/SyncMobData/SMD_init.sqf#L973)
## VISIBILITY_MODE_GHOST

Type: constant

Description: 


Replaced value:
```sqf
1
```
File: [client\SyncMobData\SMD_init.sqf at line 974](../../../Src/client/SyncMobData/SMD_init.sqf#L974)
## VISIBILITY_MODE_STEALTH

Type: constant

Description: 


Replaced value:
```sqf
2
```
File: [client\SyncMobData\SMD_init.sqf at line 975](../../../Src/client/SyncMobData/SMD_init.sqf#L975)
## VISIBILITY_MODE_ADMIN

Type: constant

Description: 


Replaced value:
```sqf
3
```
File: [client\SyncMobData\SMD_init.sqf at line 976](../../../Src/client/SyncMobData/SMD_init.sqf#L976)
## VISIBILITY_MODE_CUSTOM

Type: constant

Description: 


Replaced value:
```sqf
4
```
File: [client\SyncMobData\SMD_init.sqf at line 977](../../../Src/client/SyncMobData/SMD_init.sqf#L977)
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
File: [client\SyncMobData\SMD_init.sqf at line 54](../../../Src/client/SyncMobData/SMD_init.sqf#L54)
## smd_handle_update

Type: Variable

Description: 


Initial value:
```sqf
-1
```
File: [client\SyncMobData\SMD_init.sqf at line 72](../../../Src/client/SyncMobData/SMD_init.sqf#L72)
## smd_internal_map_vis

Type: Variable

Description: 


Initial value:
```sqf
createHashMapFromArray [...
```
File: [client\SyncMobData\SMD_init.sqf at line 982](../../../Src/client/SyncMobData/SMD_init.sqf#L982)
## smd_isProcessed

Type: function

Description: 


File: [client\SyncMobData\SMD_init.sqf at line 74](../../../Src/client/SyncMobData/SMD_init.sqf#L74)
## smd_startUpdate

Type: function

Description: 


File: [client\SyncMobData\SMD_init.sqf at line 76](../../../Src/client/SyncMobData/SMD_init.sqf#L76)
## smd_stopUpdate

Type: function

Description: 


File: [client\SyncMobData\SMD_init.sqf at line 90](../../../Src/client/SyncMobData/SMD_init.sqf#L90)
## smd_unloadVST

Type: function

Description: 
- Param: _prevPlayer

File: [client\SyncMobData\SMD_init.sqf at line 114](../../../Src/client/SyncMobData/SMD_init.sqf#L114)
## smd_onUpdate

Type: function

Description: 


File: [client\SyncMobData\SMD_init.sqf at line 125](../../../Src/client/SyncMobData/SMD_init.sqf#L125)
## smd_syncVar

Type: function

Description: 
- Param: _mob
- Param: _varName
- Param: _findByFunctionName (optional, default false)

File: [client\SyncMobData\SMD_init.sqf at line 206](../../../Src/client/SyncMobData/SMD_init.sqf#L206)
## smd_onUpdateSetting

Type: function

Description: 
- Param: _mob
- Param: _varName
- Param: _func

File: [client\SyncMobData\SMD_init.sqf at line 222](../../../Src/client/SyncMobData/SMD_init.sqf#L222)
## smd_onChangeFace

Type: function

Description: 
- Param: _mob
- Param: _ctx

File: [client\SyncMobData\SMD_init.sqf at line 236](../../../Src/client/SyncMobData/SMD_init.sqf#L236)
## smd_onChangeFaceAnim

Type: function

Description: 
- Param: _mob
- Param: _ctx

File: [client\SyncMobData\SMD_init.sqf at line 263](../../../Src/client/SyncMobData/SMD_init.sqf#L263)
## smd_onChangeBodyParts

Type: function

Description: 
- Param: _mob
- Param: _ctx

File: [client\SyncMobData\SMD_init.sqf at line 270](../../../Src/client/SyncMobData/SMD_init.sqf#L270)
## smd_onChangeCustomAnim

Type: function

Description: 
- Param: _mob
- Param: _ctx

File: [client\SyncMobData\SMD_init.sqf at line 293](../../../Src/client/SyncMobData/SMD_init.sqf#L293)
## smd_onChangeCombat

Type: function

Description: 
- Param: _mob
- Param: _ctx

File: [client\SyncMobData\SMD_init.sqf at line 305](../../../Src/client/SyncMobData/SMD_init.sqf#L305)
## smd_onAttackOrDamage

Type: function

Description: 
- Param: _mob
- Param: _ctx

File: [client\SyncMobData\SMD_init.sqf at line 320](../../../Src/client/SyncMobData/SMD_init.sqf#L320)
## smd_setSlotDataProcessor

Type: function

Description: 
- Param: _mob
- Param: _mode

File: [client\SyncMobData\SMD_init.sqf at line 471](../../../Src/client/SyncMobData/SMD_init.sqf#L471)
## smd_internal_deleteAttachments_rec

Type: function

Description: 


File: [client\SyncMobData\SMD_init.sqf at line 506](../../../Src/client/SyncMobData/SMD_init.sqf#L506)
## smd_onChangeSlotData

Type: function

Description: 
- Param: _mob
- Param: _ctx

File: [client\SyncMobData\SMD_init.sqf at line 515](../../../Src/client/SyncMobData/SMD_init.sqf#L515)
## smd_isSMDObjectInSlot

Type: function

Description: 


File: [client\SyncMobData\SMD_init.sqf at line 621](../../../Src/client/SyncMobData/SMD_init.sqf#L621)
## smd_getSMDObjectSlotId

Type: function

Description: 


File: [client\SyncMobData\SMD_init.sqf at line 626](../../../Src/client/SyncMobData/SMD_init.sqf#L626)
## smd_onStun

Type: function

Description: 
- Param: _mob
- Param: _ctx

File: [client\SyncMobData\SMD_init.sqf at line 631](../../../Src/client/SyncMobData/SMD_init.sqf#L631)
## smd_isStunned

Type: function

Description: 


File: [client\SyncMobData\SMD_init.sqf at line 637](../../../Src/client/SyncMobData/SMD_init.sqf#L637)
## smd_onGrabbed

Type: function

Description: 
- Param: _mob
- Param: _ctx

File: [client\SyncMobData\SMD_init.sqf at line 640](../../../Src/client/SyncMobData/SMD_init.sqf#L640)
## smd_isPulling

Type: function

Description: 
- Param: _mob

File: [client\SyncMobData\SMD_init.sqf at line 670](../../../Src/client/SyncMobData/SMD_init.sqf#L670)
## smd_getPullingObjectPtr

Type: function

Description: 
- Param: _mob

File: [client\SyncMobData\SMD_init.sqf at line 676](../../../Src/client/SyncMobData/SMD_init.sqf#L676)
## smd_pullSetTransformValues

Type: function

Description: 
- Param: _mob
- Param: _t
- Param: _v
- Param: _networkSync (optional, default false)

File: [client\SyncMobData\SMD_init.sqf at line 682](../../../Src/client/SyncMobData/SMD_init.sqf#L682)
## smd_pullUpdateTransform

Type: function

Description: 
- Param: _mob
- Param: _mode
- Param: _val
- Param: _netSync (optional, default true)

File: [client\SyncMobData\SMD_init.sqf at line 690](../../../Src/client/SyncMobData/SMD_init.sqf#L690)
## smd_pullGetTransformInfo

Type: function

Description: 
- Param: _mob

File: [client\SyncMobData\SMD_init.sqf at line 709](../../../Src/client/SyncMobData/SMD_init.sqf#L709)
## smd_pullGetHeplerObject

Type: function

Description: 
- Param: _mob

File: [client\SyncMobData\SMD_init.sqf at line 718](../../../Src/client/SyncMobData/SMD_init.sqf#L718)
## smd_onPull

Type: function

Description: 
- Param: _mob
- Param: _ctx

File: [client\SyncMobData\SMD_init.sqf at line 724](../../../Src/client/SyncMobData/SMD_init.sqf#L724)
## smd_onVisiblility

Type: function

Description: 
- Param: _mob
- Param: _ctx

File: [client\SyncMobData\SMD_init.sqf at line 989](../../../Src/client/SyncMobData/SMD_init.sqf#L989)
## smd_onVisualStates

Type: function

Description: 
- Param: _mob
- Param: _ctx

File: [client\SyncMobData\SMD_init.sqf at line 1004](../../../Src/client/SyncMobData/SMD_init.sqf#L1004)
## smd_hasVisualState

Type: function

Description: 
- Param: _mob
- Param: _state

File: [client\SyncMobData\SMD_init.sqf at line 1028](../../../Src/client/SyncMobData/SMD_init.sqf#L1028)
## smd_onInterpolate

Type: function

Description: 
- Param: _mob
- Param: _data

File: [client\SyncMobData\SMD_init.sqf at line 1037](../../../Src/client/SyncMobData/SMD_init.sqf#L1037)
## smd_onAnimSpeed

Type: function

Description: 
- Param: _mob
- Param: _val

File: [client\SyncMobData\SMD_init.sqf at line 1046](../../../Src/client/SyncMobData/SMD_init.sqf#L1046)
## smd_getObjectInSlot

Type: function

Description: 
- Param: _mob
- Param: _slot

File: [client\SyncMobData\SMD_init.sqf at line 1052](../../../Src/client/SyncMobData/SMD_init.sqf#L1052)
## smd_getRedirectOnTwoHanded

Type: function

Description: 
- Param: _mob
- Param: _slot

File: [client\SyncMobData\SMD_init.sqf at line 1061](../../../Src/client/SyncMobData/SMD_init.sqf#L1061)
## smd_reloadMobsLighting

Type: function

Description: 


File: [client\SyncMobData\SMD_init.sqf at line 1069](../../../Src/client/SyncMobData/SMD_init.sqf#L1069)
## smd_createOffGeom

Type: function

Description: 
- Param: _user
- Param: _srcObj
- Param: _oGeom

File: [client\SyncMobData\SMD_init.sqf at line 1093](../../../Src/client/SyncMobData/SMD_init.sqf#L1093)
## smd_onChatMessage

Type: function

Description: 
- Param: _mob
- Param: _ctx

File: [client\SyncMobData\SMD_init.sqf at line 1122](../../../Src/client/SyncMobData/SMD_init.sqf#L1122)
## smd_onVoiceBlobInit

Type: function

Description: 
- Param: _mob
- Param: _ctx

File: [client\SyncMobData\SMD_init.sqf at line 1158](../../../Src/client/SyncMobData/SMD_init.sqf#L1158)
## smd_onIsPrintingSay

Type: function

Description: 
- Param: _mob
- Param: _ctx

File: [client\SyncMobData\SMD_init.sqf at line 1164](../../../Src/client/SyncMobData/SMD_init.sqf#L1164)
