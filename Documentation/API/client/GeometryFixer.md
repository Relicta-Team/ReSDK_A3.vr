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

> <font size="5">Exists if **GEOMETRYFIXER_GEOSAVER_DISABLED** defined</font>

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

Description: не самое оптимизированное решеие. нужно собрать через ближние объекты


File: [client\GeometryFixer\GeometryFixer_functions.sqf at line 253](../../../Src/client/GeometryFixer/GeometryFixer_functions.sqf#L253)
## gf_cp_internal_isMovingTo

Type: function

Description: 
- Param: _targ

File: [client\GeometryFixer\GeometryFixer_functions.sqf at line 284](../../../Src/client/GeometryFixer/GeometryFixer_functions.sqf#L284)
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
