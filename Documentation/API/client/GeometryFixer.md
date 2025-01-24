# GeometryFixer.h

## GEOMETRY_FIXER_DISTANCE_SAVE_POSITION

Type: constant

Description: 


Replaced value:
```sqf
1
```
File: [client\GeometryFixer\GeometryFixer.h at line 14](../../../Src/client/GeometryFixer/GeometryFixer.h#L14)
## GEOMETRY_FIXER_DISTANCE_TO_RESET_POSITION

Type: constant

Description: 


Replaced value:
```sqf
1
```
File: [client\GeometryFixer\GeometryFixer.h at line 18](../../../Src/client/GeometryFixer/GeometryFixer.h#L18)
## GEOMETRY_FIXER_UPDATE_DELAY

Type: constant

Description: 


Replaced value:
```sqf
0
```
File: [client\GeometryFixer\GeometryFixer.h at line 22](../../../Src/client/GeometryFixer/GeometryFixer.h#L22)
## GEOMETRY_FIXER_FALLING_TIMEOUT

Type: constant

Description: 


Replaced value:
```sqf
0.6
```
File: [client\GeometryFixer\GeometryFixer.h at line 26](../../../Src/client/GeometryFixer/GeometryFixer.h#L26)
## __falling_animation_prefix__

Type: constant

Description: 


Replaced value:
```sqf
"afal"
```
File: [client\GeometryFixer\GeometryFixer.h at line 32](../../../Src/client/GeometryFixer/GeometryFixer.h#L32)
## __handler_falling_animation(state_value)

Type: constant

Description: 
- Param: state_value

Replaced value:
```sqf
((state_value select [0,4]) == __falling_animation_prefix__)
```
File: [client\GeometryFixer\GeometryFixer.h at line 34](../../../Src/client/GeometryFixer/GeometryFixer.h#L34)
## isInFallingAnimation(mob)

Type: constant

Description: 
- Param: mob

Replaced value:
```sqf
__handler_falling_animation(animationState mob)
```
File: [client\GeometryFixer\GeometryFixer.h at line 37](../../../Src/client/GeometryFixer/GeometryFixer.h#L37)
## isOnGround(mob)

Type: constant

Description: 
- Param: mob

Replaced value:
```sqf
(isTouchingGround mob)
```
File: [client\GeometryFixer\GeometryFixer.h at line 39](../../../Src/client/GeometryFixer/GeometryFixer.h#L39)
## getLastSavedPos()

Type: constant

Description: 
- Param: 

Replaced value:
```sqf
(gf_lastPositions select 2)
```
File: [client\GeometryFixer\GeometryFixer.h at line 42](../../../Src/client/GeometryFixer/GeometryFixer.h#L42)
## getSavedPosAtIndex(idx)

Type: constant

Description: 
- Param: idx

Replaced value:
```sqf
(gf_lastPositions select idx)
```
File: [client\GeometryFixer\GeometryFixer.h at line 44](../../../Src/client/GeometryFixer/GeometryFixer.h#L44)
## getDistance(from,to)

Type: constant

Description: 
- Param: from
- Param: to

Replaced value:
```sqf
(from distance to)
```
File: [client\GeometryFixer\GeometryFixer.h at line 46](../../../Src/client/GeometryFixer/GeometryFixer.h#L46)
# GeometryFixer_functions.sqf

## LAST_WALL_CRUSH_DELAY

Type: constant

Description: 


Replaced value:
```sqf
1
```
File: [client\GeometryFixer\GeometryFixer_functions.sqf at line 200](../../../Src/client/GeometryFixer/GeometryFixer_functions.sqf#L200)
## gf_lastNormalPos

Type: Variable

> Exists if **GEOMETRYFIXER_GEOSAVER_DISABLED** defined

Description: 


Initial value:
```sqf
vec3(0,0,0)
```
File: [client\GeometryFixer\GeometryFixer_functions.sqf at line 71](../../../Src/client/GeometryFixer/GeometryFixer_functions.sqf#L71)
## gf_lastPosWallLock

Type: Variable

Description: 


Initial value:
```sqf
vec3(0,0,0)
```
File: [client\GeometryFixer\GeometryFixer_functions.sqf at line 196](../../../Src/client/GeometryFixer/GeometryFixer_functions.sqf#L196)
## gf_lastWallCrushingTime

Type: Variable

Description: 


Initial value:
```sqf
0
```
File: [client\GeometryFixer\GeometryFixer_functions.sqf at line 198](../../../Src/client/GeometryFixer/GeometryFixer_functions.sqf#L198)
## gf_start

Type: function

Description: 


File: [client\GeometryFixer\GeometryFixer_functions.sqf at line 11](../../../Src/client/GeometryFixer/GeometryFixer_functions.sqf#L11)
## gf_stop

Type: function

Description: 


File: [client\GeometryFixer\GeometryFixer_functions.sqf at line 23](../../../Src/client/GeometryFixer/GeometryFixer_functions.sqf#L23)
## gf_onUpdate

Type: function

Description: 


File: [client\GeometryFixer\GeometryFixer_functions.sqf at line 32](../../../Src/client/GeometryFixer/GeometryFixer_functions.sqf#L32)
## gf_processGeometry

Type: function

> Exists if **GEOMETRYFIXER_GEOSAVER_DISABLED** defined

Description: 
- Param: _curpos

File: [client\GeometryFixer\GeometryFixer_functions.sqf at line 77](../../../Src/client/GeometryFixer/GeometryFixer_functions.sqf#L77)
## gf_processRoadway

Type: function

Description: 
- Param: _curpos

File: [client\GeometryFixer\GeometryFixer_functions.sqf at line 181](../../../Src/client/GeometryFixer/GeometryFixer_functions.sqf#L181)
## gf_processWallLock

Type: function

Description: 


File: [client\GeometryFixer\GeometryFixer_functions.sqf at line 203](../../../Src/client/GeometryFixer/GeometryFixer_functions.sqf#L203)
## gf_collisionProcess

Type: function

Description: 


File: [client\GeometryFixer\GeometryFixer_functions.sqf at line 264](../../../Src/client/GeometryFixer/GeometryFixer_functions.sqf#L264)
# GeometryFixer_init.sqf

## GEOMETRYFIXER_GEOSAVER_DISABLED

Type: constant

Description: 


Replaced value:
```sqf

```
File: [client\GeometryFixer\GeometryFixer_init.sqf at line 15](../../../Src/client/GeometryFixer/GeometryFixer_init.sqf#L15)
## GEOMETRYFIXER_ROADWAY_DISABLED

Type: constant

Description: 


Replaced value:
```sqf

```
File: [client\GeometryFixer\GeometryFixer_init.sqf at line 18](../../../Src/client/GeometryFixer/GeometryFixer_init.sqf#L18)
## GEOMETRYFIXER_COLLISION_ALLOWED

Type: constant

Description: 


Replaced value:
```sqf

```
File: [client\GeometryFixer\GeometryFixer_init.sqf at line 21](../../../Src/client/GeometryFixer/GeometryFixer_init.sqf#L21)
## gf_lastPositions

Type: Variable

Description: 


Initial value:
```sqf
[vec3(0,0,0),vec3(0,0,0),vec3(0,0,0)]
```
File: [client\GeometryFixer\GeometryFixer_init.sqf at line 27](../../../Src/client/GeometryFixer/GeometryFixer_init.sqf#L27)
## gf_lastBufferedFallingPos

Type: Variable

Description: 


Initial value:
```sqf
vec3(0,0,0)
```
File: [client\GeometryFixer\GeometryFixer_init.sqf at line 29](../../../Src/client/GeometryFixer/GeometryFixer_init.sqf#L29)
## gf_handle_update

Type: Variable

Description: 


Initial value:
```sqf
-1
```
File: [client\GeometryFixer\GeometryFixer_init.sqf at line 32](../../../Src/client/GeometryFixer/GeometryFixer_init.sqf#L32)
## gf_isCatchedFalling

Type: Variable

Description: 


Initial value:
```sqf
false
```
File: [client\GeometryFixer\GeometryFixer_init.sqf at line 34](../../../Src/client/GeometryFixer/GeometryFixer_init.sqf#L34)
## gf_lastFallingTime

Type: Variable

Description: 


Initial value:
```sqf
0
```
File: [client\GeometryFixer\GeometryFixer_init.sqf at line 36](../../../Src/client/GeometryFixer/GeometryFixer_init.sqf#L36)
## gf_indexLastPos

Type: Variable

Description: 


Initial value:
```sqf
2
```
File: [client\GeometryFixer\GeometryFixer_init.sqf at line 38](../../../Src/client/GeometryFixer/GeometryFixer_init.sqf#L38)
## gf_objRoadway

Type: Variable

Description: 


Initial value:
```sqf
createSimpleObject ["ml_shabut\vr_geo\geopolsm.p3d",[0,0,0],true]
```
File: [client\GeometryFixer\GeometryFixer_init.sqf at line 41](../../../Src/client/GeometryFixer/GeometryFixer_init.sqf#L41)
## gf_isLockedInputByWall

Type: Variable

Description: 


Initial value:
```sqf
false
```
File: [client\GeometryFixer\GeometryFixer_init.sqf at line 44](../../../Src/client/GeometryFixer/GeometryFixer_init.sqf#L44)
## gf_isLockedInputByActor

Type: Variable

Description: 


Initial value:
```sqf
false
```
File: [client\GeometryFixer\GeometryFixer_init.sqf at line 46](../../../Src/client/GeometryFixer/GeometryFixer_init.sqf#L46)
## gf_lastposArrows

Type: Variable

> Exists if **GEOMETRY_FIXER_TRACE_POSITIONS** defined

Description: 


Initial value:
```sqf
["Sign_Arrow_F" createVehicleLocal [0,0,0],"Sign_Arrow_F" createVehicleLocal [0,0,0],"Sign_Arrow_F" createVehicleLocal [0,0,0]]
```
File: [client\GeometryFixer\GeometryFixer_init.sqf at line 50](../../../Src/client/GeometryFixer/GeometryFixer_init.sqf#L50)
## gf_lbfpArrow

Type: Variable

Description: 


Initial value:
```sqf
"Sign_Arrow_F" createVehicleLocal [0,0,0]
```
File: [client\GeometryFixer\GeometryFixer_init.sqf at line 52](../../../Src/client/GeometryFixer/GeometryFixer_init.sqf#L52)
## gf_campos

Type: Variable

Description: 


Initial value:
```sqf
"Sign_Arrow_F" createVehicleLocal [0,0,0]
```
File: [client\GeometryFixer\GeometryFixer_init.sqf at line 55](../../../Src/client/GeometryFixer/GeometryFixer_init.sqf#L55)
## gf_camtarget

Type: Variable

Description: 


Initial value:
```sqf
"Sign_Arrow_F" createVehicleLocal [0,0,0]
```
File: [client\GeometryFixer\GeometryFixer_init.sqf at line 57](../../../Src/client/GeometryFixer/GeometryFixer_init.sqf#L57)
## gf_proneFrom

Type: Variable

Description: 


Initial value:
```sqf
"Sign_Arrow_F" createVehicleLocal [0,0,0]
```
File: [client\GeometryFixer\GeometryFixer_init.sqf at line 60](../../../Src/client/GeometryFixer/GeometryFixer_init.sqf#L60)
## gf_proneTo

Type: Variable

Description: 


Initial value:
```sqf
"Sign_Arrow_F" createVehicleLocal [0,0,0]
```
File: [client\GeometryFixer\GeometryFixer_init.sqf at line 62](../../../Src/client/GeometryFixer/GeometryFixer_init.sqf#L62)
## gf_proneSafePos

Type: Variable

Description: 


Initial value:
```sqf
"Sign_Arrow_F" createVehicleLocal [0,0,0]
```
File: [client\GeometryFixer\GeometryFixer_init.sqf at line 64](../../../Src/client/GeometryFixer/GeometryFixer_init.sqf#L64)
