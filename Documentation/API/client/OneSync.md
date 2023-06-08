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

Description: "steps",


Initial value:
```sqf
["falling","light"/*,"mobcollision" Коллизия сломана*/]
```
File: [client\OneSync\OneSync_init.sqf at line 40](../../../Src/client/OneSync/OneSync_init.sqf#L40)
## os_isActive

Type: Variable

Description: 


Initial value:
```sqf
false
```
File: [client\OneSync\OneSync_init.sqf at line 42](../../../Src/client/OneSync/OneSync_init.sqf#L42)
## os_start

Type: function

Description: 


File: [client\OneSync\OneSync_init.sqf at line 44](../../../Src/client/OneSync/OneSync_init.sqf#L44)
## os_stop

Type: function

Description: 


File: [client\OneSync\OneSync_init.sqf at line 62](../../../Src/client/OneSync/OneSync_init.sqf#L62)
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

## os_steps_handle

Type: Variable

Description: TODO возможно определять тип звука стоит от объекта на стороне сервера


Initial value:
```sqf
-1
```
File: [client\OneSync\OneSync_steps.sqf at line 9](../../../Src/client/OneSync/OneSync_steps.sqf#L9)
## os_steps_currentSound

Type: Variable

Description: 


Initial value:
```sqf
"gen"
```
File: [client\OneSync\OneSync_steps.sqf at line 11](../../../Src/client/OneSync/OneSync_steps.sqf#L11)
## os_steps_reverbLevel

Type: Variable

Description: 


Initial value:
```sqf
1
```
File: [client\OneSync\OneSync_steps.sqf at line 12](../../../Src/client/OneSync/OneSync_steps.sqf#L12)
## os_steps_soundsType

Type: Variable

Description: 


Initial value:
```sqf
[]
```
File: [client\OneSync\OneSync_steps.sqf at line 14](../../../Src/client/OneSync/OneSync_steps.sqf#L14)
## os_steps_setEnable

Type: function

Description: 
- Param: _mode

File: [client\OneSync\OneSync_steps.sqf at line 16](../../../Src/client/OneSync/OneSync_steps.sqf#L16)
## os_steps_onUpdate

Type: function

Description: 


File: [client\OneSync\OneSync_steps.sqf at line 25](../../../Src/client/OneSync/OneSync_steps.sqf#L25)
## os_steps_getReverbLevel

Type: function

Description: 


File: [client\OneSync\OneSync_steps.sqf at line 29](../../../Src/client/OneSync/OneSync_steps.sqf#L29)
## os_steps_getStepObject

Type: function

Description: 


File: [client\OneSync\OneSync_steps.sqf at line 33](../../../Src/client/OneSync/OneSync_steps.sqf#L33)
