# GeometryFixer.h

## GEOMETRY_FIXER_DISTANCE_SAVE_POSITION

Type: constant

Description: расстояние сохранения позиций


Replaced value:
```sqf
1
```
File: [client\GeometryFixer\GeometryFixer.h at line 10](../../../Src/client/GeometryFixer/GeometryFixer.h#L10)
## GEOMETRY_FIXER_DISTANCE_TO_RESET_POSITION

Type: constant

Description: Если за отведённое время в падении расстояние с начала падения не дальше этого то вернём персонажа назад


Replaced value:
```sqf
1
```
File: [client\GeometryFixer\GeometryFixer.h at line 13](../../../Src/client/GeometryFixer/GeometryFixer.h#L13)
## GEOMETRY_FIXER_UPDATE_DELAY

Type: constant

Description: Частота обновления проверки геометрии


Replaced value:
```sqf
0
```
File: [client\GeometryFixer\GeometryFixer.h at line 16](../../../Src/client/GeometryFixer/GeometryFixer.h#L16)
## GEOMETRY_FIXER_FALLING_TIMEOUT

Type: constant

Description: 


Replaced value:
```sqf
0.6
```
File: [client\GeometryFixer\GeometryFixer.h at line 18](../../../Src/client/GeometryFixer/GeometryFixer.h#L18)
## __falling_animation_prefix__

Type: constant

Description: #define GEOMETRY_FIXER_COUNT_FALLING_CHECK 4


Replaced value:
```sqf
"afal"
```
File: [client\GeometryFixer\GeometryFixer.h at line 23](../../../Src/client/GeometryFixer/GeometryFixer.h#L23)
## __handler_falling_animation(state_value)

Type: constant

Description: 
- Param: state_value

Replaced value:
```sqf
((state_value select [0,4]) == __falling_animation_prefix__)
```
File: [client\GeometryFixer\GeometryFixer.h at line 24](../../../Src/client/GeometryFixer/GeometryFixer.h#L24)
## isInFallingAnimation(mob)

Type: constant

Description: 
- Param: mob

Replaced value:
```sqf
__handler_falling_animation(animationState mob)
```
File: [client\GeometryFixer\GeometryFixer.h at line 26](../../../Src/client/GeometryFixer/GeometryFixer.h#L26)
## isOnGround(mob)

Type: constant

Description: 
- Param: mob

Replaced value:
```sqf
(isTouchingGround mob)
```
File: [client\GeometryFixer\GeometryFixer.h at line 27](../../../Src/client/GeometryFixer/GeometryFixer.h#L27)
## getLastSavedPos()

Type: constant

Description: 
- Param: 

Replaced value:
```sqf
(gf_lastPositions select 2)
```
File: [client\GeometryFixer\GeometryFixer.h at line 28](../../../Src/client/GeometryFixer/GeometryFixer.h#L28)
## getSavedPosAtIndex(idx)

Type: constant

Description: 
- Param: idx

Replaced value:
```sqf
(gf_lastPositions select idx)
```
File: [client\GeometryFixer\GeometryFixer.h at line 29](../../../Src/client/GeometryFixer/GeometryFixer.h#L29)
## getDistance(from,to)

Type: constant

Description: 
- Param: from
- Param: to

Replaced value:
```sqf
(from distance to)
```
File: [client\GeometryFixer\GeometryFixer.h at line 30](../../../Src/client/GeometryFixer/GeometryFixer.h#L30)
# GeometryFixer_functions.sqf

## LAST_WALL_CRUSH_DELAY

Type: constant

Description: 


Replaced value:
```sqf
1
```
File: [client\GeometryFixer\GeometryFixer_functions.sqf at line 191](../../../Src/client/GeometryFixer/GeometryFixer_functions.sqf#L191)
## gf_lastNormalPos

Type: Variable

> Exists if **GEOMETRYFIXER_GEOSAVER_DISABLED** defined

Description: 


Initial value:
```sqf
vec3(0,0,0)
```
File: [client\GeometryFixer\GeometryFixer_functions.sqf at line 66](../../../Src/client/GeometryFixer/GeometryFixer_functions.sqf#L66)
## gf_lastPosWallLock

Type: Variable

Description: 


Initial value:
```sqf
vec3(0,0,0)
```
File: [client\GeometryFixer\GeometryFixer_functions.sqf at line 188](../../../Src/client/GeometryFixer/GeometryFixer_functions.sqf#L188)
## gf_lastWallCrushingTime

Type: Variable

Description: 


Initial value:
```sqf
0
```
File: [client\GeometryFixer\GeometryFixer_functions.sqf at line 190](../../../Src/client/GeometryFixer/GeometryFixer_functions.sqf#L190)
## gf_start

Type: function

Description: 


File: [client\GeometryFixer\GeometryFixer_functions.sqf at line 8](../../../Src/client/GeometryFixer/GeometryFixer_functions.sqf#L8)
## gf_stop

Type: function

Description: 


File: [client\GeometryFixer\GeometryFixer_functions.sqf at line 19](../../../Src/client/GeometryFixer/GeometryFixer_functions.sqf#L19)
## gf_onUpdate

Type: function

Description: 


File: [client\GeometryFixer\GeometryFixer_functions.sqf at line 28](../../../Src/client/GeometryFixer/GeometryFixer_functions.sqf#L28)
## gf_processGeometry

Type: function

> Exists if **GEOMETRYFIXER_GEOSAVER_DISABLED** defined

Description: функционал сломан и не поддерживатеся на данный момент


File: [client\GeometryFixer\GeometryFixer_functions.sqf at line 71](../../../Src/client/GeometryFixer/GeometryFixer_functions.sqf#L71)
## gf_processRoadway

Type: function

Description: GEOMETRYFIXER_GEOSAVER_DISABLED


File: [client\GeometryFixer\GeometryFixer_functions.sqf at line 174](../../../Src/client/GeometryFixer/GeometryFixer_functions.sqf#L174)
## gf_processWallLock

Type: function

Description: 


File: [client\GeometryFixer\GeometryFixer_functions.sqf at line 193](../../../Src/client/GeometryFixer/GeometryFixer_functions.sqf#L193)
## gf_collisionProcess

Type: function

Description: выключает локальную коллизию моба на клиенте полностью


File: [client\GeometryFixer\GeometryFixer_functions.sqf at line 253](../../../Src/client/GeometryFixer/GeometryFixer_functions.sqf#L253)
# GeometryFixer_init.sqf

## GEOMETRYFIXER_GEOSAVER_DISABLED

Type: constant

Description: отключает лагалку ебаную (только для геометрии)


Replaced value:
```sqf

```
File: [client\GeometryFixer\GeometryFixer_init.sqf at line 12](../../../Src/client/GeometryFixer/GeometryFixer_init.sqf#L12)
## GEOMETRYFIXER_ROADWAY_DISABLED

Type: constant

Description: отключает лифт (требуется фикс)


Replaced value:
```sqf

```
File: [client\GeometryFixer\GeometryFixer_init.sqf at line 14](../../../Src/client/GeometryFixer/GeometryFixer_init.sqf#L14)
## GEOMETRYFIXER_COLLISION_ALLOWED

Type: constant

Description: отключает армовскую коллизию сущностей


Replaced value:
```sqf

```
File: [client\GeometryFixer\GeometryFixer_init.sqf at line 16](../../../Src/client/GeometryFixer/GeometryFixer_init.sqf#L16)
## gf_lastPositions

Type: Variable

Description: 


Initial value:
```sqf
[vec3(0,0,0),vec3(0,0,0),vec3(0,0,0)]
```
File: [client\GeometryFixer\GeometryFixer_init.sqf at line 21](../../../Src/client/GeometryFixer/GeometryFixer_init.sqf#L21)
## gf_lastBufferedFallingPos

Type: Variable

Description: 


Initial value:
```sqf
vec3(0,0,0)
```
File: [client\GeometryFixer\GeometryFixer_init.sqf at line 22](../../../Src/client/GeometryFixer/GeometryFixer_init.sqf#L22)
## gf_handle_update

Type: Variable

Description: gf_lastFallingCheckCount = 0;


Initial value:
```sqf
-1
```
File: [client\GeometryFixer\GeometryFixer_init.sqf at line 24](../../../Src/client/GeometryFixer/GeometryFixer_init.sqf#L24)
## gf_isCatchedFalling

Type: Variable

Description: 


Initial value:
```sqf
false
```
File: [client\GeometryFixer\GeometryFixer_init.sqf at line 25](../../../Src/client/GeometryFixer/GeometryFixer_init.sqf#L25)
## gf_lastFallingTime

Type: Variable

Description: 


Initial value:
```sqf
0
```
File: [client\GeometryFixer\GeometryFixer_init.sqf at line 26](../../../Src/client/GeometryFixer/GeometryFixer_init.sqf#L26)
## gf_indexLastPos

Type: Variable

Description: 


Initial value:
```sqf
2
```
File: [client\GeometryFixer\GeometryFixer_init.sqf at line 28](../../../Src/client/GeometryFixer/GeometryFixer_init.sqf#L28)
## gf_objRoadway

Type: Variable

Description: 


Initial value:
```sqf
createSimpleObject ["ml_shabut\vr_geo\geopolsm.p3d",[0,0,0],true]
```
File: [client\GeometryFixer\GeometryFixer_init.sqf at line 30](../../../Src/client/GeometryFixer/GeometryFixer_init.sqf#L30)
## gf_isLockedInputByWall

Type: Variable

Description: 


Initial value:
```sqf
false
```
File: [client\GeometryFixer\GeometryFixer_init.sqf at line 32](../../../Src/client/GeometryFixer/GeometryFixer_init.sqf#L32)
## gf_isLockedInputByActor

Type: Variable

Description: 


Initial value:
```sqf
false
```
File: [client\GeometryFixer\GeometryFixer_init.sqf at line 33](../../../Src/client/GeometryFixer/GeometryFixer_init.sqf#L33)
## gf_lastposArrows

Type: Variable

> Exists if **GEOMETRY_FIXER_TRACE_POSITIONS** defined

Description: 


Initial value:
```sqf
["Sign_Arrow_F" createVehicleLocal [0,0,0],"Sign_Arrow_F" createVehicleLocal [0,0,0],"Sign_Arrow_F" createVehicleLocal [0,0,0]]
```
File: [client\GeometryFixer\GeometryFixer_init.sqf at line 36](../../../Src/client/GeometryFixer/GeometryFixer_init.sqf#L36)
## gf_lbfpArrow

Type: Variable

Description: 


Initial value:
```sqf
"Sign_Arrow_F" createVehicleLocal [0,0,0]
```
File: [client\GeometryFixer\GeometryFixer_init.sqf at line 37](../../../Src/client/GeometryFixer/GeometryFixer_init.sqf#L37)
## gf_campos

Type: Variable

Description: 


Initial value:
```sqf
"Sign_Arrow_F" createVehicleLocal [0,0,0]
```
File: [client\GeometryFixer\GeometryFixer_init.sqf at line 39](../../../Src/client/GeometryFixer/GeometryFixer_init.sqf#L39)
## gf_camtarget

Type: Variable

Description: 


Initial value:
```sqf
"Sign_Arrow_F" createVehicleLocal [0,0,0]
```
File: [client\GeometryFixer\GeometryFixer_init.sqf at line 40](../../../Src/client/GeometryFixer/GeometryFixer_init.sqf#L40)
## gf_proneFrom

Type: Variable

Description: 


Initial value:
```sqf
"Sign_Arrow_F" createVehicleLocal [0,0,0]
```
File: [client\GeometryFixer\GeometryFixer_init.sqf at line 42](../../../Src/client/GeometryFixer/GeometryFixer_init.sqf#L42)
## gf_proneTo

Type: Variable

Description: 


Initial value:
```sqf
"Sign_Arrow_F" createVehicleLocal [0,0,0]
```
File: [client\GeometryFixer\GeometryFixer_init.sqf at line 43](../../../Src/client/GeometryFixer/GeometryFixer_init.sqf#L43)
## gf_proneSafePos

Type: Variable

Description: 


Initial value:
```sqf
"Sign_Arrow_F" createVehicleLocal [0,0,0]
```
File: [client\GeometryFixer\GeometryFixer_init.sqf at line 44](../../../Src/client/GeometryFixer/GeometryFixer_init.sqf#L44)
