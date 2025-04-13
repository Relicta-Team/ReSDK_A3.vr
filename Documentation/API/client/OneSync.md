# OneSync_Falling.sqf

## OS_FALLING_UPDATE_FREQUENCY

Type: constant

Description: 


Replaced value:
```sqf
0
```
File: [client\OneSync\OneSync_Falling.sqf at line 12](../../../Src/client/OneSync/OneSync_Falling.sqf#L12)
## os_falling_handle

Type: Variable

Description: 


Initial value:
```sqf
-1
```
File: [client\OneSync\OneSync_Falling.sqf at line 15](../../../Src/client/OneSync/OneSync_Falling.sqf#L15)
## os_falling_startPos

Type: Variable

Description: 


Initial value:
```sqf
vec3(0,0,0)
```
File: [client\OneSync\OneSync_Falling.sqf at line 21](../../../Src/client/OneSync/OneSync_Falling.sqf#L21)
## os_falling_isOnGround

Type: Variable

Description: 


Initial value:
```sqf
false
```
File: [client\OneSync\OneSync_Falling.sqf at line 23](../../../Src/client/OneSync/OneSync_Falling.sqf#L23)
## os_falling_isEnabled

Type: function

Description: 


File: [client\OneSync\OneSync_Falling.sqf at line 18](../../../Src/client/OneSync/OneSync_Falling.sqf#L18)
## os_falling_setEnable

Type: function

Description: 
- Param: _mode

File: [client\OneSync\OneSync_Falling.sqf at line 26](../../../Src/client/OneSync/OneSync_Falling.sqf#L26)
## os_falling_onUpdate

Type: function

Description: 


File: [client\OneSync\OneSync_Falling.sqf at line 44](../../../Src/client/OneSync/OneSync_Falling.sqf#L44)
## os_falling_beginFalling

Type: function

Description: 
- Param: _mob

File: [client\OneSync\OneSync_Falling.sqf at line 80](../../../Src/client/OneSync/OneSync_Falling.sqf#L80)
## os_falling_handleFall

Type: function

Description: 
- Param: _distFall

File: [client\OneSync\OneSync_Falling.sqf at line 87](../../../Src/client/OneSync/OneSync_Falling.sqf#L87)
# OneSync_init.sqf

## os_list_services

Type: Variable

Description: 


Initial value:
```sqf
["falling","light","steps" /*,"mobcollision" Коллизия сломана*/]
```
File: [client\OneSync\OneSync_init.sqf at line 42](../../../Src/client/OneSync/OneSync_init.sqf#L42)
## os_isActive

Type: Variable

Description: 


Initial value:
```sqf
false
```
File: [client\OneSync\OneSync_init.sqf at line 45](../../../Src/client/OneSync/OneSync_init.sqf#L45)
## os_start

Type: function

Description: 


File: [client\OneSync\OneSync_init.sqf at line 48](../../../Src/client/OneSync/OneSync_init.sqf#L48)
## os_stop

Type: function

Description: 


File: [client\OneSync\OneSync_init.sqf at line 67](../../../Src/client/OneSync/OneSync_init.sqf#L67)
# OneSync_light.sqf

## OS_LIGHT_UPDATE_DELAY

Type: constant

Description: 


Replaced value:
```sqf
0.2
```
File: [client\OneSync\OneSync_light.sqf at line 15](../../../Src/client/OneSync/OneSync_light.sqf#L15)
## OS_LIGHT_DATASEND_DELAY

Type: constant

Description: 


Replaced value:
```sqf
1
```
File: [client\OneSync\OneSync_light.sqf at line 18](../../../Src/client/OneSync/OneSync_light.sqf#L18)
## os_light_handle_onupdate

Type: Variable

Description: 


Initial value:
```sqf
-1
```
File: [client\OneSync\OneSync_light.sqf at line 21](../../../Src/client/OneSync/OneSync_light.sqf#L21)
## os_light_lastTimeSendInfo

Type: Variable

Description: 


Initial value:
```sqf
0
```
File: [client\OneSync\OneSync_light.sqf at line 23](../../../Src/client/OneSync/OneSync_light.sqf#L23)
## os_light_list_noProcessedLights

Type: Variable

Description: 


Initial value:
```sqf
[] //vec2 (light,intensity)
```
File: [client\OneSync\OneSync_light.sqf at line 25](../../../Src/client/OneSync/OneSync_light.sqf#L25)
## os_light_setEnable

Type: function

Description: 
- Param: _mode

File: [client\OneSync\OneSync_light.sqf at line 28](../../../Src/client/OneSync/OneSync_light.sqf#L28)
## os_light_getLighting

Type: function

Description: 


File: [client\OneSync\OneSync_light.sqf at line 44](../../../Src/client/OneSync/OneSync_light.sqf#L44)
## os_light_onUpdate

Type: function

Description: 


File: [client\OneSync\OneSync_light.sqf at line 59](../../../Src/client/OneSync/OneSync_light.sqf#L59)
## os_light_registerAsNoProcessedLight

Type: function

Description: 
- Param: _lt
- Param: _intensity

File: [client\OneSync\OneSync_light.sqf at line 74](../../../Src/client/OneSync/OneSync_light.sqf#L74)
# OneSync_mobcollision.sqf

## OS_MOBCOLLISION_DISTANCE_CHECK

Type: constant

Description: 


Replaced value:
```sqf
2
```
File: [client\OneSync\OneSync_mobcollision.sqf at line 13](../../../Src/client/OneSync/OneSync_mobcollision.sqf#L13)
## OS_MOBCOLLISION_BLOCKMOVE

Type: constant

Description: 


Replaced value:
```sqf
0.7
```
File: [client\OneSync\OneSync_mobcollision.sqf at line 16](../../../Src/client/OneSync/OneSync_mobcollision.sqf#L16)
## OS_MOBCOLLISION_SCALE_ATTACHER

Type: constant

Description: 


Replaced value:
```sqf
0.03
```
File: [client\OneSync\OneSync_mobcollision.sqf at line 19](../../../Src/client/OneSync/OneSync_mobcollision.sqf#L19)
## os_mobcollision_handleupdate

Type: Variable

Description: 


Initial value:
```sqf
-1
```
File: [client\OneSync\OneSync_mobcollision.sqf at line 22](../../../Src/client/OneSync/OneSync_mobcollision.sqf#L22)
## os_mobcollision_lastTarg

Type: Variable

Description: 


Initial value:
```sqf
objnull
```
File: [client\OneSync\OneSync_mobcollision.sqf at line 26](../../../Src/client/OneSync/OneSync_mobcollision.sqf#L26)
## os_mobcollision_bbObj

Type: Variable

Description: 


Initial value:
```sqf
objnull
```
File: [client\OneSync\OneSync_mobcollision.sqf at line 28](../../../Src/client/OneSync/OneSync_mobcollision.sqf#L28)
## os_mobcollision_setEnable

Type: function

Description: 
- Param: _mode

File: [client\OneSync\OneSync_mobcollision.sqf at line 31](../../../Src/client/OneSync/OneSync_mobcollision.sqf#L31)
## os_mobcollision_createBB

Type: function

Description: 


File: [client\OneSync\OneSync_mobcollision.sqf at line 51](../../../Src/client/OneSync/OneSync_mobcollision.sqf#L51)
## os_mobcollision_linkTo

Type: function

Description: 


File: [client\OneSync\OneSync_mobcollision.sqf at line 65](../../../Src/client/OneSync/OneSync_mobcollision.sqf#L65)
## os_mobcollision_onUpdate

Type: function

Description: 


File: [client\OneSync\OneSync_mobcollision.sqf at line 76](../../../Src/client/OneSync/OneSync_mobcollision.sqf#L76)
# OneSync_steps.sqf

## OS_STEPS_DEFAULT_SOUND_KEY

Type: constant

Description: 


Replaced value:
```sqf
("SLIGHT_DAM_STONE" call lightSys_getConfigIdByName)
```
File: [client\OneSync\OneSync_steps.sqf at line 21](../../../Src/client/OneSync/OneSync_steps.sqf#L21)
## distLTG

Type: constant

> Exists if **EDITOR** defined

Description: 


Replaced value:
```sqf
(_leg distance _ground )
```
File: [client\OneSync\OneSync_steps.sqf at line 266](../../../Src/client/OneSync/OneSync_steps.sqf#L266)
## lastDist

Type: constant

> Exists if **EDITOR** defined

Description: 


Replaced value:
```sqf
(_ground getVariable ["lastdistance",distLTG])
```
File: [client\OneSync\OneSync_steps.sqf at line 267](../../../Src/client/OneSync/OneSync_steps.sqf#L267)
## isNegativize

Type: constant

> Exists if **EDITOR** defined

Description: 


Replaced value:
```sqf
(distLTG < lastDist)
```
File: [client\OneSync\OneSync_steps.sqf at line 268](../../../Src/client/OneSync/OneSync_steps.sqf#L268)
## isPositivize

Type: constant

> Exists if **EDITOR** defined

Description: 


Replaced value:
```sqf
(distLTG > lastDist)
```
File: [client\OneSync\OneSync_steps.sqf at line 269](../../../Src/client/OneSync/OneSync_steps.sqf#L269)
## os_steps_handle

Type: Variable

Description: 


Initial value:
```sqf
-1
```
File: [client\OneSync\OneSync_steps.sqf at line 13](../../../Src/client/OneSync/OneSync_steps.sqf#L13)
## os_steps_currentSoundName

Type: Variable

Description: 


Initial value:
```sqf
""
```
File: [client\OneSync\OneSync_steps.sqf at line 16](../../../Src/client/OneSync/OneSync_steps.sqf#L16)
## os_steps_currentSoundCount

Type: Variable

Description: 


Initial value:
```sqf
0
```
File: [client\OneSync\OneSync_steps.sqf at line 18](../../../Src/client/OneSync/OneSync_steps.sqf#L18)
## os_steps_map_objToMaterialPtr

Type: Variable

Description: 


Initial value:
```sqf
createHashMap //key - strPtr, value - materials_map_stepData:key
```
File: [client\OneSync\OneSync_steps.sqf at line 28](../../../Src/client/OneSync/OneSync_steps.sqf#L28)
## os_steps_lastPtr

Type: Variable

Description: 


Initial value:
```sqf
stringEmpty
```
File: [client\OneSync\OneSync_steps.sqf at line 30](../../../Src/client/OneSync/OneSync_steps.sqf#L30)
## os_steps_canUseRequests

Type: Variable

Description: 


Initial value:
```sqf
false
```
File: [client\OneSync\OneSync_steps.sqf at line 32](../../../Src/client/OneSync/OneSync_steps.sqf#L32)
## os_steps_lastpos

Type: Variable

Description: 


Initial value:
```sqf
vec3(0,0,0)
```
File: [client\OneSync\OneSync_steps.sqf at line 35](../../../Src/client/OneSync/OneSync_steps.sqf#L35)
## os_steps_const_foots

Type: Variable

Description: 


Initial value:
```sqf
["rightfoot","leftfoot"]
```
File: [client\OneSync\OneSync_steps.sqf at line 38](../../../Src/client/OneSync/OneSync_steps.sqf#L38)
## os_steps_const_foots_inversed

Type: Variable

Description: 


Initial value:
```sqf
["leftfoot","rightfoot"]
```
File: [client\OneSync\OneSync_steps.sqf at line 40](../../../Src/client/OneSync/OneSync_steps.sqf#L40)
## os_steps_debug_arrows

Type: Variable

> Exists if **EDITOR** defined

Description: 


Initial value:
```sqf
["Sign_Sphere10cm_F" createVehicle [0,0,0],"Sign_Sphere10cm_F" createVehicle [0,0,0]]
```
File: [client\OneSync\OneSync_steps.sqf at line 238](../../../Src/client/OneSync/OneSync_steps.sqf#L238)
## os_steps_debug_arrowsGround

Type: Variable

Description: 


Initial value:
```sqf
["Sign_Sphere10cm_F" createVehicle [0,0,0],"Sign_Sphere10cm_F" createVehicle [0,0,0]]
```
File: [client\OneSync\OneSync_steps.sqf at line 240](../../../Src/client/OneSync/OneSync_steps.sqf#L240)
## os_steps_enable_debugInfo

Type: Variable

Description: 


Initial value:
```sqf
false
```
File: [client\OneSync\OneSync_steps.sqf at line 243](../../../Src/client/OneSync/OneSync_steps.sqf#L243)
## os_steps_getStepData

Type: function

Description: 


File: [client\OneSync\OneSync_steps.sqf at line 25](../../../Src/client/OneSync/OneSync_steps.sqf#L25)
## os_steps_setEnable

Type: function

Description: 
- Param: _mode

File: [client\OneSync\OneSync_steps.sqf at line 43](../../../Src/client/OneSync/OneSync_steps.sqf#L43)
## os_steps_handleStepData

Type: function

Description: 
- Param: _ptr

File: [client\OneSync\OneSync_steps.sqf at line 56](../../../Src/client/OneSync/OneSync_steps.sqf#L56)
## os_steps_getObjectOnFoot

Type: function

Description: 


File: [client\OneSync\OneSync_steps.sqf at line 87](../../../Src/client/OneSync/OneSync_steps.sqf#L87)
## os_steps_onGetStepData

Type: function

Description: 
- Param: _wobjPtr
- Param: _sdPtr

File: [client\OneSync\OneSync_steps.sqf at line 95](../../../Src/client/OneSync/OneSync_steps.sqf#L95)
## os_steps_updateLastPos

Type: function

Description: 


File: [client\OneSync\OneSync_steps.sqf at line 105](../../../Src/client/OneSync/OneSync_steps.sqf#L105)
## os_steps_getFootPos

Type: function

Description: 


File: [client\OneSync\OneSync_steps.sqf at line 110](../../../Src/client/OneSync/OneSync_steps.sqf#L110)
## os_steps_getFootPosVec

Type: function

Description: 


File: [client\OneSync\OneSync_steps.sqf at line 115](../../../Src/client/OneSync/OneSync_steps.sqf#L115)
## os_steps_resetTriggers

Type: function

Description: 


File: [client\OneSync\OneSync_steps.sqf at line 120](../../../Src/client/OneSync/OneSync_steps.sqf#L120)
## os_steps_resetAllVariables

Type: function

Description: 


File: [client\OneSync\OneSync_steps.sqf at line 125](../../../Src/client/OneSync/OneSync_steps.sqf#L125)
## os_steps_getTrigger

Type: function

Description: 


File: [client\OneSync\OneSync_steps.sqf at line 134](../../../Src/client/OneSync/OneSync_steps.sqf#L134)
## os_steps_setTrigger

Type: function

Description: 


File: [client\OneSync\OneSync_steps.sqf at line 139](../../../Src/client/OneSync/OneSync_steps.sqf#L139)
## os_steps_getLastCall

Type: function

Description: 


File: [client\OneSync\OneSync_steps.sqf at line 144](../../../Src/client/OneSync/OneSync_steps.sqf#L144)
## os_steps_setLastCall

Type: function

Description: 


File: [client\OneSync\OneSync_steps.sqf at line 149](../../../Src/client/OneSync/OneSync_steps.sqf#L149)
## os_steps_onUpdate

Type: function

Description: 


File: [client\OneSync\OneSync_steps.sqf at line 155](../../../Src/client/OneSync/OneSync_steps.sqf#L155)
## os_steps_doFootStep

Type: function

Description: 


File: [client\OneSync\OneSync_steps.sqf at line 221](../../../Src/client/OneSync/OneSync_steps.sqf#L221)
## os_steps_onUpdateSoundData

Type: function

Description: 
- Param: _pattern
- Param: _count

File: [client\OneSync\OneSync_steps.sqf at line 229](../../../Src/client/OneSync/OneSync_steps.sqf#L229)
## os_steps_debug_renderInfo

Type: function

> Exists if **EDITOR** defined

Description: 


File: [client\OneSync\OneSync_steps.sqf at line 246](../../../Src/client/OneSync/OneSync_steps.sqf#L246)
