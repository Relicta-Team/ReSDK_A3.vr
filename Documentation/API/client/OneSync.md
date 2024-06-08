# OneSync_Falling.sqf

## OS_FALLING_UPDATE_FREQUENCY

Type: constant

Description: Частота обновления службы падения


Replaced value:
```sqf
0
```
File: [client\OneSync\OneSync_Falling.sqf at line 8](../../../Src/client/OneSync/OneSync_Falling.sqf#L8)
## os_falling_handle

Type: Variable

Description: 


Initial value:
```sqf
-1
```
File: [client\OneSync\OneSync_Falling.sqf at line 10](../../../Src/client/OneSync/OneSync_Falling.sqf#L10)
## os_falling_startPos

Type: Variable

Description: 


Initial value:
```sqf
vec3(0,0,0)
```
File: [client\OneSync\OneSync_Falling.sqf at line 14](../../../Src/client/OneSync/OneSync_Falling.sqf#L14)
## os_falling_isOnGround

Type: Variable

Description: 


Initial value:
```sqf
false
```
File: [client\OneSync\OneSync_Falling.sqf at line 15](../../../Src/client/OneSync/OneSync_Falling.sqf#L15)
## os_falling_isEnabled

Type: function

Description: 


File: [client\OneSync\OneSync_Falling.sqf at line 12](../../../Src/client/OneSync/OneSync_Falling.sqf#L12)
## os_falling_setEnable

Type: function

Description: 
- Param: _mode

File: [client\OneSync\OneSync_Falling.sqf at line 17](../../../Src/client/OneSync/OneSync_Falling.sqf#L17)
## os_falling_onUpdate

Type: function

Description: код эквивалентен методу Mob::handle_falling()


File: [client\OneSync\OneSync_Falling.sqf at line 34](../../../Src/client/OneSync/OneSync_Falling.sqf#L34)
## os_falling_beginFalling

Type: function

Description: 
- Param: _mob

File: [client\OneSync\OneSync_Falling.sqf at line 69](../../../Src/client/OneSync/OneSync_Falling.sqf#L69)
## os_falling_handleFall

Type: function

Description: 
- Param: _distFall

File: [client\OneSync\OneSync_Falling.sqf at line 75](../../../Src/client/OneSync/OneSync_Falling.sqf#L75)
# OneSync_init.sqf

## os_list_services

Type: Variable

Description: 


Initial value:
```sqf
["falling","light","steps" /*,"mobcollision" Коллизия сломана*/]
```
File: [client\OneSync\OneSync_init.sqf at line 39](../../../Src/client/OneSync/OneSync_init.sqf#L39)
## os_isActive

Type: Variable

Description: 


Initial value:
```sqf
false
```
File: [client\OneSync\OneSync_init.sqf at line 41](../../../Src/client/OneSync/OneSync_init.sqf#L41)
## os_start

Type: function

Description: 


File: [client\OneSync\OneSync_init.sqf at line 43](../../../Src/client/OneSync/OneSync_init.sqf#L43)
## os_stop

Type: function

Description: 


File: [client\OneSync\OneSync_init.sqf at line 61](../../../Src/client/OneSync/OneSync_init.sqf#L61)
# OneSync_light.sqf

## OS_LIGHT_UPDATE_DELAY

Type: constant

Description: Компонент клиентского освещения


Replaced value:
```sqf
0.2
```
File: [client\OneSync\OneSync_light.sqf at line 10](../../../Src/client/OneSync/OneSync_light.sqf#L10)
## OS_LIGHT_DATASEND_DELAY

Type: constant

Description: влияет на частоту отправки сообщений. менять с осторожностью


Replaced value:
```sqf
1
```
File: [client\OneSync\OneSync_light.sqf at line 12](../../../Src/client/OneSync/OneSync_light.sqf#L12)
## os_light_handle_onupdate

Type: Variable

Description: 


Initial value:
```sqf
-1
```
File: [client\OneSync\OneSync_light.sqf at line 14](../../../Src/client/OneSync/OneSync_light.sqf#L14)
## os_light_lastTimeSendInfo

Type: Variable

Description: 


Initial value:
```sqf
0
```
File: [client\OneSync\OneSync_light.sqf at line 15](../../../Src/client/OneSync/OneSync_light.sqf#L15)
## os_light_list_noProcessedLights

Type: Variable

Description: 


Initial value:
```sqf
[]
```
File: [client\OneSync\OneSync_light.sqf at line 16](../../../Src/client/OneSync/OneSync_light.sqf#L16)
## os_light_setEnable

Type: function

Description: 
- Param: _mode

File: [client\OneSync\OneSync_light.sqf at line 18](../../../Src/client/OneSync/OneSync_light.sqf#L18)
## os_light_getLighting

Type: function

Description: 


File: [client\OneSync\OneSync_light.sqf at line 29](../../../Src/client/OneSync/OneSync_light.sqf#L29)
## os_light_onUpdate

Type: function

Description: 


File: [client\OneSync\OneSync_light.sqf at line 38](../../../Src/client/OneSync/OneSync_light.sqf#L38)
## os_light_registerAsNoProcessedLight

Type: function

Description: 
- Param: _lt

File: [client\OneSync\OneSync_light.sqf at line 52](../../../Src/client/OneSync/OneSync_light.sqf#L52)
# OneSync_mobcollision.sqf

## OS_MOBCOLLISION_DISTANCE_CHECK

Type: constant

Description: 


Replaced value:
```sqf
2
```
File: [client\OneSync\OneSync_mobcollision.sqf at line 9](../../../Src/client/OneSync/OneSync_mobcollision.sqf#L9)
## OS_MOBCOLLISION_BLOCKMOVE

Type: constant

Description: 


Replaced value:
```sqf
0.7
```
File: [client\OneSync\OneSync_mobcollision.sqf at line 10](../../../Src/client/OneSync/OneSync_mobcollision.sqf#L10)
## OS_MOBCOLLISION_SCALE_ATTACHER

Type: constant

Description: 


Replaced value:
```sqf
0.03
```
File: [client\OneSync\OneSync_mobcollision.sqf at line 12](../../../Src/client/OneSync/OneSync_mobcollision.sqf#L12)
## os_mobcollision_handleupdate

Type: Variable

Description: 


Initial value:
```sqf
-1
```
File: [client\OneSync\OneSync_mobcollision.sqf at line 14](../../../Src/client/OneSync/OneSync_mobcollision.sqf#L14)
## os_mobcollision_lastTarg

Type: Variable

Description: os_mobcollision_canMove = true;


Initial value:
```sqf
objnull
```
File: [client\OneSync\OneSync_mobcollision.sqf at line 17](../../../Src/client/OneSync/OneSync_mobcollision.sqf#L17)
## os_mobcollision_bbObj

Type: Variable

Description: 


Initial value:
```sqf
objnull
```
File: [client\OneSync\OneSync_mobcollision.sqf at line 18](../../../Src/client/OneSync/OneSync_mobcollision.sqf#L18)
## os_mobcollision_setEnable

Type: function

Description: 
- Param: _mode

File: [client\OneSync\OneSync_mobcollision.sqf at line 20](../../../Src/client/OneSync/OneSync_mobcollision.sqf#L20)
## os_mobcollision_createBB

Type: function

Description: 


File: [client\OneSync\OneSync_mobcollision.sqf at line 38](../../../Src/client/OneSync/OneSync_mobcollision.sqf#L38)
## os_mobcollision_linkTo

Type: function

Description: 


File: [client\OneSync\OneSync_mobcollision.sqf at line 50](../../../Src/client/OneSync/OneSync_mobcollision.sqf#L50)
## os_mobcollision_onUpdate

Type: function

Description: 


File: [client\OneSync\OneSync_mobcollision.sqf at line 60](../../../Src/client/OneSync/OneSync_mobcollision.sqf#L60)
# OneSync_steps.sqf

## distLTG

Type: constant

> Exists if **EDITOR** defined

Description: 


Replaced value:
```sqf
(_leg distance _ground )
```
File: [client\OneSync\OneSync_steps.sqf at line 172](../../../Src/client/OneSync/OneSync_steps.sqf#L172)
## lastDist

Type: constant

> Exists if **EDITOR** defined

Description: 


Replaced value:
```sqf
(_ground getVariable ["lastdistance",distLTG])
```
File: [client\OneSync\OneSync_steps.sqf at line 173](../../../Src/client/OneSync/OneSync_steps.sqf#L173)
## isNegativize

Type: constant

> Exists if **EDITOR** defined

Description: 


Replaced value:
```sqf
(distLTG < lastDist)
```
File: [client\OneSync\OneSync_steps.sqf at line 174](../../../Src/client/OneSync/OneSync_steps.sqf#L174)
## isPositivize

Type: constant

> Exists if **EDITOR** defined

Description: 


Replaced value:
```sqf
(distLTG > lastDist)
```
File: [client\OneSync\OneSync_steps.sqf at line 175](../../../Src/client/OneSync/OneSync_steps.sqf#L175)
## os_steps_handle

Type: Variable

Description: TODO возможно определять тип звука стоит от объекта на стороне сервера


Initial value:
```sqf
-1
```
File: [client\OneSync\OneSync_steps.sqf at line 9](../../../Src/client/OneSync/OneSync_steps.sqf#L9)
## os_steps_currentSoundName

Type: Variable

Description: 


Initial value:
```sqf
""
```
File: [client\OneSync\OneSync_steps.sqf at line 11](../../../Src/client/OneSync/OneSync_steps.sqf#L11)
## os_steps_currentSoundCount

Type: Variable

Description: 


Initial value:
```sqf
0
```
File: [client\OneSync\OneSync_steps.sqf at line 12](../../../Src/client/OneSync/OneSync_steps.sqf#L12)
## os_steps_lastpos

Type: Variable

Description: os_steps_soundsType = [];


Initial value:
```sqf
vec3(0,0,0)
```
File: [client\OneSync\OneSync_steps.sqf at line 16](../../../Src/client/OneSync/OneSync_steps.sqf#L16)
## os_steps_const_foots

Type: Variable

Description: 


Initial value:
```sqf
["rightfoot","leftfoot"]
```
File: [client\OneSync\OneSync_steps.sqf at line 18](../../../Src/client/OneSync/OneSync_steps.sqf#L18)
## os_steps_const_foots_inversed

Type: Variable

Description: 


Initial value:
```sqf
["leftfoot","rightfoot"]
```
File: [client\OneSync\OneSync_steps.sqf at line 19](../../../Src/client/OneSync/OneSync_steps.sqf#L19)
## os_steps_debug_arrows

Type: Variable

> Exists if **EDITOR** defined

Description: 


Initial value:
```sqf
["Sign_Sphere10cm_F" createVehicle [0,0,0],"Sign_Sphere10cm_F" createVehicle [0,0,0]]
```
File: [client\OneSync\OneSync_steps.sqf at line 147](../../../Src/client/OneSync/OneSync_steps.sqf#L147)
## os_steps_debug_arrowsGround

Type: Variable

Description: 


Initial value:
```sqf
["Sign_Sphere10cm_F" createVehicle [0,0,0],"Sign_Sphere10cm_F" createVehicle [0,0,0]]
```
File: [client\OneSync\OneSync_steps.sqf at line 148](../../../Src/client/OneSync/OneSync_steps.sqf#L148)
## os_steps_enable_debugInfo

Type: Variable

Description: 


Initial value:
```sqf
false
```
File: [client\OneSync\OneSync_steps.sqf at line 150](../../../Src/client/OneSync/OneSync_steps.sqf#L150)
## os_steps_setEnable

Type: function

Description: 
- Param: _mode

File: [client\OneSync\OneSync_steps.sqf at line 21](../../../Src/client/OneSync/OneSync_steps.sqf#L21)
## os_steps_updateLastPos

Type: function

Description: 


File: [client\OneSync\OneSync_steps.sqf at line 33](../../../Src/client/OneSync/OneSync_steps.sqf#L33)
## os_steps_getFootPos

Type: function

Description: 


File: [client\OneSync\OneSync_steps.sqf at line 37](../../../Src/client/OneSync/OneSync_steps.sqf#L37)
## os_steps_getFootPosVec

Type: function

Description: 


File: [client\OneSync\OneSync_steps.sqf at line 41](../../../Src/client/OneSync/OneSync_steps.sqf#L41)
## os_steps_resetTriggers

Type: function

Description: 


File: [client\OneSync\OneSync_steps.sqf at line 45](../../../Src/client/OneSync/OneSync_steps.sqf#L45)
## os_steps_resetAllVariables

Type: function

Description: 


File: [client\OneSync\OneSync_steps.sqf at line 49](../../../Src/client/OneSync/OneSync_steps.sqf#L49)
## os_steps_getTrigger

Type: function

Description: 


File: [client\OneSync\OneSync_steps.sqf at line 56](../../../Src/client/OneSync/OneSync_steps.sqf#L56)
## os_steps_setTrigger

Type: function

Description: 


File: [client\OneSync\OneSync_steps.sqf at line 60](../../../Src/client/OneSync/OneSync_steps.sqf#L60)
## os_steps_getLastCall

Type: function

Description: 


File: [client\OneSync\OneSync_steps.sqf at line 64](../../../Src/client/OneSync/OneSync_steps.sqf#L64)
## os_steps_setLastCall

Type: function

Description: 


File: [client\OneSync\OneSync_steps.sqf at line 68](../../../Src/client/OneSync/OneSync_steps.sqf#L68)
## os_steps_onUpdate

Type: function

Description: 


File: [client\OneSync\OneSync_steps.sqf at line 72](../../../Src/client/OneSync/OneSync_steps.sqf#L72)
## os_steps_doFootStep

Type: function

Description: 


File: [client\OneSync\OneSync_steps.sqf at line 132](../../../Src/client/OneSync/OneSync_steps.sqf#L132)
## os_steps_onUpdateSoundData

Type: function

Description: 
- Param: _pattern
- Param: _count

File: [client\OneSync\OneSync_steps.sqf at line 139](../../../Src/client/OneSync/OneSync_steps.sqf#L139)
## os_steps_debug_renderInfo

Type: function

> Exists if **EDITOR** defined

Description: 


File: [client\OneSync\OneSync_steps.sqf at line 152](../../../Src/client/OneSync/OneSync_steps.sqf#L152)
