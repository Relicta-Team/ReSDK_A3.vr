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
File: [client\SyncMobData\SMD_init.sqf at line 963](../../../Src/client/SyncMobData/SMD_init.sqf#L963)
## VISIBILITY_MODE_GHOST

Type: constant

Description: 


Replaced value:
```sqf
1
```
File: [client\SyncMobData\SMD_init.sqf at line 964](../../../Src/client/SyncMobData/SMD_init.sqf#L964)
## VISIBILITY_MODE_STEALTH

Type: constant

Description: 


Replaced value:
```sqf
2
```
File: [client\SyncMobData\SMD_init.sqf at line 965](../../../Src/client/SyncMobData/SMD_init.sqf#L965)
## VISIBILITY_MODE_ADMIN

Type: constant

Description: 


Replaced value:
```sqf
3
```
File: [client\SyncMobData\SMD_init.sqf at line 966](../../../Src/client/SyncMobData/SMD_init.sqf#L966)
## VISIBILITY_MODE_CUSTOM

Type: constant

Description: 


Replaced value:
```sqf
4
```
File: [client\SyncMobData\SMD_init.sqf at line 967](../../../Src/client/SyncMobData/SMD_init.sqf#L967)
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
File: [client\SyncMobData\SMD_init.sqf at line 972](../../../Src/client/SyncMobData/SMD_init.sqf#L972)
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

File: [client\SyncMobData\SMD_init.sqf at line 461](../../../Src/client/SyncMobData/SMD_init.sqf#L461)
## smd_internal_deleteAttachments_rec

Type: function

Description: 


File: [client\SyncMobData\SMD_init.sqf at line 496](../../../Src/client/SyncMobData/SMD_init.sqf#L496)
## smd_onChangeSlotData

Type: function

Description: 
- Param: _mob
- Param: _ctx

File: [client\SyncMobData\SMD_init.sqf at line 505](../../../Src/client/SyncMobData/SMD_init.sqf#L505)
## smd_isSMDObjectInSlot

Type: function

Description: 


File: [client\SyncMobData\SMD_init.sqf at line 611](../../../Src/client/SyncMobData/SMD_init.sqf#L611)
## smd_getSMDObjectSlotId

Type: function

Description: 


File: [client\SyncMobData\SMD_init.sqf at line 616](../../../Src/client/SyncMobData/SMD_init.sqf#L616)
## smd_onStun

Type: function

Description: 
- Param: _mob
- Param: _ctx

File: [client\SyncMobData\SMD_init.sqf at line 621](../../../Src/client/SyncMobData/SMD_init.sqf#L621)
## smd_isStunned

Type: function

Description: 


File: [client\SyncMobData\SMD_init.sqf at line 627](../../../Src/client/SyncMobData/SMD_init.sqf#L627)
## smd_onGrabbed

Type: function

Description: 
- Param: _mob
- Param: _ctx

File: [client\SyncMobData\SMD_init.sqf at line 630](../../../Src/client/SyncMobData/SMD_init.sqf#L630)
## smd_isPulling

Type: function

Description: 
- Param: _mob

File: [client\SyncMobData\SMD_init.sqf at line 660](../../../Src/client/SyncMobData/SMD_init.sqf#L660)
## smd_getPullingObjectPtr

Type: function

Description: 
- Param: _mob

File: [client\SyncMobData\SMD_init.sqf at line 666](../../../Src/client/SyncMobData/SMD_init.sqf#L666)
## smd_pullSetTransformValues

Type: function

Description: 
- Param: _mob
- Param: _t
- Param: _v
- Param: _networkSync (optional, default false)

File: [client\SyncMobData\SMD_init.sqf at line 672](../../../Src/client/SyncMobData/SMD_init.sqf#L672)
## smd_pullUpdateTransform

Type: function

Description: 
- Param: _mob
- Param: _mode
- Param: _val
- Param: _netSync (optional, default true)

File: [client\SyncMobData\SMD_init.sqf at line 680](../../../Src/client/SyncMobData/SMD_init.sqf#L680)
## smd_pullGetTransformInfo

Type: function

Description: 
- Param: _mob

File: [client\SyncMobData\SMD_init.sqf at line 699](../../../Src/client/SyncMobData/SMD_init.sqf#L699)
## smd_pullGetHeplerObject

Type: function

Description: 
- Param: _mob

File: [client\SyncMobData\SMD_init.sqf at line 708](../../../Src/client/SyncMobData/SMD_init.sqf#L708)
## smd_onPull

Type: function

Description: 
- Param: _mob
- Param: _ctx

File: [client\SyncMobData\SMD_init.sqf at line 714](../../../Src/client/SyncMobData/SMD_init.sqf#L714)
## smd_onVisiblility

Type: function

Description: 
- Param: _mob
- Param: _ctx

File: [client\SyncMobData\SMD_init.sqf at line 979](../../../Src/client/SyncMobData/SMD_init.sqf#L979)
## smd_onVisualStates

Type: function

Description: 
- Param: _mob
- Param: _ctx

File: [client\SyncMobData\SMD_init.sqf at line 994](../../../Src/client/SyncMobData/SMD_init.sqf#L994)
## smd_hasVisualState

Type: function

Description: 
- Param: _mob
- Param: _state

File: [client\SyncMobData\SMD_init.sqf at line 1018](../../../Src/client/SyncMobData/SMD_init.sqf#L1018)
## smd_onInterpolate

Type: function

Description: 
- Param: _mob
- Param: _data

File: [client\SyncMobData\SMD_init.sqf at line 1027](../../../Src/client/SyncMobData/SMD_init.sqf#L1027)
## smd_onAnimSpeed

Type: function

Description: 
- Param: _mob
- Param: _val

File: [client\SyncMobData\SMD_init.sqf at line 1036](../../../Src/client/SyncMobData/SMD_init.sqf#L1036)
## smd_getObjectInSlot

Type: function

Description: 
- Param: _mob
- Param: _slot

File: [client\SyncMobData\SMD_init.sqf at line 1042](../../../Src/client/SyncMobData/SMD_init.sqf#L1042)
## smd_getRedirectOnTwoHanded

Type: function

Description: 
- Param: _mob
- Param: _slot

File: [client\SyncMobData\SMD_init.sqf at line 1051](../../../Src/client/SyncMobData/SMD_init.sqf#L1051)
## smd_reloadMobsLighting

Type: function

Description: 


File: [client\SyncMobData\SMD_init.sqf at line 1059](../../../Src/client/SyncMobData/SMD_init.sqf#L1059)
## smd_createOffGeom

Type: function

Description: 
- Param: _user
- Param: _srcObj
- Param: _oGeom

File: [client\SyncMobData\SMD_init.sqf at line 1083](../../../Src/client/SyncMobData/SMD_init.sqf#L1083)
## smd_onChatMessage

Type: function

Description: 
- Param: _mob
- Param: _ctx

File: [client\SyncMobData\SMD_init.sqf at line 1112](../../../Src/client/SyncMobData/SMD_init.sqf#L1112)
## smd_onVoiceBlobInit

Type: function

Description: 
- Param: _mob
- Param: _ctx

File: [client\SyncMobData\SMD_init.sqf at line 1148](../../../Src/client/SyncMobData/SMD_init.sqf#L1148)
## smd_onIsPrintingSay

Type: function

Description: 
- Param: _mob
- Param: _ctx

File: [client\SyncMobData\SMD_init.sqf at line 1154](../../../Src/client/SyncMobData/SMD_init.sqf#L1154)
