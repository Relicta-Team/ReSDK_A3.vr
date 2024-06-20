# ServerInteractionInit.sqf

## SI_RAYCAST_DISTANCE

Type: constant

Description: 


Replaced value:
```sqf
2000
```
File: [host\ServerInteraction\ServerInteractionInit.sqf at line 74](../../../Src/host/ServerInteraction/ServerInteractionInit.sqf#L74)
## SH_DEBUG_SHOTGUN

Type: constant

Description: #define SI_THROW_DEBUG


Replaced value:
```sqf

```
File: [host\ServerInteraction\ServerInteractionInit.sqf at line 253](../../../Src/host/ServerInteraction/ServerInteractionInit.sqf#L253)
## debug_t(data)

Type: constant

> Exists if **SI_THROW_DEBUG** defined

Description: 
- Param: data

Replaced value:
```sqf
traceformat("[THROW_DEBUG]: %1",data)
```
File: [host\ServerInteraction\ServerInteractionInit.sqf at line 259](../../../Src/host/ServerInteraction/ServerInteractionInit.sqf#L259)
## debug_line(p,v,clr)

Type: constant

> Exists if **SI_THROW_DEBUG** defined

Description: 
- Param: p
- Param: v
- Param: clr

Replaced value:
```sqf
__D_IL_OBJ = "Sign_Arrow_F" createVehicle [0,0,0]; si_debug_listVectors pushBack __D_IL_OBJ; \
__D_IL_OBJ setPosAtl p; __D_IL_OBJ setVectorUp v; __D_IL_OBJ setObjectTexture [0,format["#(rgb,8,8,3)color(%1,%2,%3,1)",clr select 0,clr select 1,clr select 2]];
```
File: [host\ServerInteraction\ServerInteractionInit.sqf at line 260](../../../Src/host/ServerInteraction/ServerInteractionInit.sqf#L260)
## debug_t(data)

Type: constant

> Exists if **SI_THROW_DEBUG** not defined

Description: 
- Param: data

Replaced value:
```sqf

```
File: [host\ServerInteraction\ServerInteractionInit.sqf at line 265](../../../Src/host/ServerInteraction/ServerInteractionInit.sqf#L265)
## debug_line(p,v,clr)

Type: constant

> Exists if **SI_THROW_DEBUG** not defined

Description: 
- Param: p
- Param: v
- Param: clr

Replaced value:
```sqf

```
File: [host\ServerInteraction\ServerInteractionInit.sqf at line 266](../../../Src/host/ServerInteraction/ServerInteractionInit.sqf#L266)
## logshotgun(txt,vars)

Type: constant

> Exists if **SH_DEBUG_SHOTGUN** defined

Description: 
- Param: txt
- Param: vars

Replaced value:
```sqf
errorformat("[SH_DEBUG_SHOTGUN]: %1 %2",txt arg [vars]);
```
File: [host\ServerInteraction\ServerInteractionInit.sqf at line 472](../../../Src/host/ServerInteraction/ServerInteractionInit.sqf#L472)
## logshotgun(txt,vars)

Type: constant

> Exists if **SH_DEBUG_SHOTGUN** not defined

Description: 
- Param: txt
- Param: vars

Replaced value:
```sqf

```
File: [host\ServerInteraction\ServerInteractionInit.sqf at line 474](../../../Src/host/ServerInteraction/ServerInteractionInit.sqf#L474)
## si_internal_rayObject

Type: Variable

Description: Общий объект рэйкаста. Арма у нас в одном потоке так что боятся нечего


Initial value:
```sqf
"Sign_Sphere10cm_F" createVehicleLocal[0,0,0]
```
File: [host\ServerInteraction\ServerInteractionInit.sqf at line 69](../../../Src/host/ServerInteraction/ServerInteractionInit.sqf#L69)
## si_throwTasks

Type: Variable

Description: Список задач летящих объектов


Initial value:
```sqf
[] //obj, vecpos, vecdir, dist, precdown, downlevel, speed
```
File: [host\ServerInteraction\ServerInteractionInit.sqf at line 256](../../../Src/host/ServerInteraction/ServerInteractionInit.sqf#L256)
## si_debug_listVectors

Type: Variable

> Exists if **SI_THROW_DEBUG** defined

Description: 


Initial value:
```sqf
[]
```
File: [host\ServerInteraction\ServerInteractionInit.sqf at line 263](../../../Src/host/ServerInteraction/ServerInteractionInit.sqf#L263)
## si_throwModes

Type: Variable

Description: список алгоритмов полета объектов. каждый элемент - структура из 2 сегментов кода


Initial value:
```sqf
[...
```
File: [host\ServerInteraction\ServerInteractionInit.sqf at line 601](../../../Src/host/ServerInteraction/ServerInteractionInit.sqf#L601)
## si_throwingProcess

Type: function

Description: 
- Param: _mob
- Param: _item
- Param: _startPoint

File: [host\ServerInteraction\ServerInteractionInit.sqf at line 33](../../../Src/host/ServerInteraction/ServerInteractionInit.sqf#L33)
## si_rayCast

Type: function

Description: Возвращает визуальный объект
- Param: _rayPosStart
- Param: _rayVector
- Param: _retVirtual (optional, default false)
- Param: _bias (optional, default 0.001)
- Param: _refposret (optional, default [])
- Param: _ignored1 (optional, default objNull)
- Param: _normal (optional, default [])

File: [host\ServerInteraction\ServerInteractionInit.sqf at line 72](../../../Src/host/ServerInteraction/ServerInteractionInit.sqf#L72)
## si_handleObjectReturnCheckVirtual

Type: function

Description: системная функция обработки и модификации параметра (конвертация из мирового объекта в виртуальный)
- Param: _obj

File: [host\ServerInteraction\ServerInteractionInit.sqf at line 140](../../../Src/host/ServerInteraction/ServerInteractionInit.sqf#L140)
## si_getIntersectData

Type: function

Description: При изменении данной функции исправь реализацию в interact::th::getItscData()
- Param: _p1
- Param: _p2
- Param: _ig1 (optional, default objnull)
- Param: _ig2 (optional, default objnull)

File: [host\ServerInteraction\ServerInteractionInit.sqf at line 176](../../../Src/host/ServerInteraction/ServerInteractionInit.sqf#L176)
## si_getIntersectObjects

Type: function

Description: 
- Param: _p1
- Param: _p2
- Param: _ig1 (optional, default objNUll)
- Param: _ig2 (optional, default objNUll)
- Param: _countObjs (optional, default 10)
- Param: _retUnique (optional, default true)
- Param: _retAsVObj (optional, default false)
- Param: _retIPos (optional, default false)

File: [host\ServerInteraction\ServerInteractionInit.sqf at line 204](../../../Src/host/ServerInteraction/ServerInteractionInit.sqf#L204)
## si_addThrowTask

Type: function

Description: 
- Param: _gobj
- Param: _vecPos
- Param: _vecDir
- Param: _distance
- Param: _precdown
- Param: _leveldown
- Param: _speed
- Param: _refThis
- Param: _throwMode (optional, default SI_TM_THROW)
- Param: _addPenaltySupressFire

File: [host\ServerInteraction\ServerInteractionInit.sqf at line 269](../../../Src/host/ServerInteraction/ServerInteractionInit.sqf#L269)
## si_onFlyWorldActionLoad

Type: function

Description: например взрыв летящей гранаты
- Param: _tempObj

File: [host\ServerInteraction\ServerInteractionInit.sqf at line 391](../../../Src/host/ServerInteraction/ServerInteractionInit.sqf#L391)
## si_onThrowingEnd

Type: function

Description: 
- Param: _tempObj
- Param: _barrierObj

File: [host\ServerInteraction\ServerInteractionInit.sqf at line 407](../../../Src/host/ServerInteraction/ServerInteractionInit.sqf#L407)
## si_onBulletAct

Type: function

Description: 
- Param: _tempObj
- Param: _barrierObj

File: [host\ServerInteraction\ServerInteractionInit.sqf at line 436](../../../Src/host/ServerInteraction/ServerInteractionInit.sqf#L436)
# ServerInteractionShared.sqf

## addInteractSecondPassObj(path)

Type: constant

Description: 
- Param: path

Replaced value:
```sqf
interact_map_secondPass set [tolower path,false]
```
File: [host\ServerInteraction\ServerInteractionShared.sqf at line 11](../../../Src/host/ServerInteraction/ServerInteractionShared.sqf#L11)
## isNotSecondPassObject(obj)

Type: constant

Description: Проверка
- Param: obj

Replaced value:
```sqf
(interact_map_secondPass getOrDefault [toLower(getModelInfo (obj) select 1),true])
```
File: [host\ServerInteraction\ServerInteractionShared.sqf at line 15](../../../Src/host/ServerInteraction/ServerInteractionShared.sqf#L15)
## interact_map_secondPass

Type: Variable

Description: Публичные данные


Initial value:
```sqf
createHashMap
```
File: [host\ServerInteraction\ServerInteractionShared.sqf at line 10](../../../Src/host/ServerInteraction/ServerInteractionShared.sqf#L10)
## interact_throwlist

Type: Variable

Description: 


Initial value:
```sqf
[]
```
File: [host\ServerInteraction\ServerInteractionShared.sqf at line 17](../../../Src/host/ServerInteraction/ServerInteractionShared.sqf#L17)
## interact_th_map_codeAssoc

Type: Variable

Description: 


Initial value:
```sqf
createHashMapFromArray [["th",0],["sh",1]]
```
File: [host\ServerInteraction\ServerInteractionShared.sqf at line 218](../../../Src/host/ServerInteraction/ServerInteractionShared.sqf#L218)
## interact_th_delegates

Type: Variable

Description: mode -> vec2: success fly, intersection


Initial value:
```sqf
[...
```
File: [host\ServerInteraction\ServerInteractionShared.sqf at line 221](../../../Src/host/ServerInteraction/ServerInteractionShared.sqf#L221)
## interact_shassoc_idx

Type: Variable

Description: 


Initial value:
```sqf
0
```
File: [host\ServerInteraction\ServerInteractionShared.sqf at line 296](../../../Src/host/ServerInteraction/ServerInteractionShared.sqf#L296)
## interact_map_shassoc_keyint

Type: Variable

Description: 


Initial value:
```sqf
createHashMap
```
File: [host\ServerInteraction\ServerInteractionShared.sqf at line 297](../../../Src/host/ServerInteraction/ServerInteractionShared.sqf#L297)
## interact_map_shassoc_keystr

Type: Variable

Description: 


Initial value:
```sqf
createHashMap
```
File: [host\ServerInteraction\ServerInteractionShared.sqf at line 298](../../../Src/host/ServerInteraction/ServerInteractionShared.sqf#L298)
## interact_th_getItscData

Type: function

Description: Это псевдоним функции si::getIntersectData()
- Param: _p1
- Param: _p2
- Param: _ig1 (optional, default objnull)
- Param: _ig2 (optional, default objnull)

File: [host\ServerInteraction\ServerInteractionShared.sqf at line 20](../../../Src/host/ServerInteraction/ServerInteractionShared.sqf#L20)
## interact_th_getRelRadiusPos

Type: function

Description: копия с noe_visual_getRelRadiusPos. Константа DROP_RADIUS 0.6 на текущий момент
- Param: _posI
- Param: _dirPos (optional, default random 360)
- Param: _dropRad (optional, default 0.6)

File: [host\ServerInteraction\ServerInteractionShared.sqf at line 48](../../../Src/host/ServerInteraction/ServerInteractionShared.sqf#L48)
## interact_th_onThrowingEnd

Type: function

Description: Событие остановки света
- Param: _obj
- Param: _targ

File: [host\ServerInteraction\ServerInteractionShared.sqf at line 54](../../../Src/host/ServerInteraction/ServerInteractionShared.sqf#L54)
## interact_th_calculateStartPoint

Type: function

Description: internal impl. of calculating start point of projectile


File: [host\ServerInteraction\ServerInteractionShared.sqf at line 72](../../../Src/host/ServerInteraction/ServerInteractionShared.sqf#L72)
## interact_th_addTask

Type: function

Description: 
- Param: _mode
- Param: _ctx

File: [host\ServerInteraction\ServerInteractionShared.sqf at line 80](../../../Src/host/ServerInteraction/ServerInteractionShared.sqf#L80)
## interact_th__clith

Type: function

Description: 


File: [host\ServerInteraction\ServerInteractionShared.sqf at line 155](../../../Src/host/ServerInteraction/ServerInteractionShared.sqf#L155)
# ServerInteractionTests.sqf

## SI_DEBUG_TRACELINE

Type: constant

Description: 


Replaced value:
```sqf

```
File: [host\ServerInteraction\ServerInteractionTests.sqf at line 8](../../../Src/host/ServerInteraction/ServerInteractionTests.sqf#L8)
## si_debug_tracelineobjs

Type: Variable

> Exists if **SI_DEBUG_TRACELINE** defined

Description: 


Initial value:
```sqf
[]
```
File: [host\ServerInteraction\ServerInteractionTests.sqf at line 12](../../../Src/host/ServerInteraction/ServerInteractionTests.sqf#L12)
## si_debug_obj

Type: Variable

> Exists if **EDITOR** defined

Description: 


Initial value:
```sqf
createSimpleObject ["Sign_Sphere10cm_F",[0,0,0],true]
```
File: [host\ServerInteraction\ServerInteractionTests.sqf at line 97](../../../Src/host/ServerInteraction/ServerInteractionTests.sqf#L97)
## si_debug_task

Type: Variable

Description: 


Initial value:
```sqf
-1
```
File: [host\ServerInteraction\ServerInteractionTests.sqf at line 98](../../../Src/host/ServerInteraction/ServerInteractionTests.sqf#L98)
## si_debug_olist

Type: Variable

Description: 


Initial value:
```sqf
[]
```
File: [host\ServerInteraction\ServerInteractionTests.sqf at line 103](../../../Src/host/ServerInteraction/ServerInteractionTests.sqf#L103)
## si_makeline

Type: function

Description: Алгоритм не подходит
- Param: _m
- Param: _distance
- Param: _precdown
- Param: _ld

File: [host\ServerInteraction\ServerInteractionTests.sqf at line 19](../../../Src/host/ServerInteraction/ServerInteractionTests.sqf#L19)
## si_debug_throwDebug

Type: function

> Exists if **EDITOR** defined

Description: 


File: [host\ServerInteraction\ServerInteractionTests.sqf at line 53](../../../Src/host/ServerInteraction/ServerInteractionTests.sqf#L53)
## si_debug_tester_internal

Type: function

> Exists if **EDITOR** defined

Description: DEPRECATED


File: [host\ServerInteraction\ServerInteractionTests.sqf at line 58](../../../Src/host/ServerInteraction/ServerInteractionTests.sqf#L58)
## si_debug_interptest

Type: function

> Exists if **EDITOR** defined

Description: 
- Param: _sp
- Param: _ep
- Param: _maxheight (optional, default 10)

File: [host\ServerInteraction\ServerInteractionTests.sqf at line 105](../../../Src/host/ServerInteraction/ServerInteractionTests.sqf#L105)
## si_debug_projectile

Type: function

> Exists if **EDITOR** defined

Description: 
- Param: _basepos
- Param: _vectordrect
- Param: _distance
- Param: _precdown
- Param: _ld

File: [host\ServerInteraction\ServerInteractionTests.sqf at line 125](../../../Src/host/ServerInteraction/ServerInteractionTests.sqf#L125)
## si_debug_testCamerapos

Type: function

> Exists if **EDITOR** defined

Description: 


File: [host\ServerInteraction\ServerInteractionTests.sqf at line 153](../../../Src/host/ServerInteraction/ServerInteractionTests.sqf#L153)
## si_debug_mousepostest

Type: function

> Exists if **EDITOR** defined

Description: 


File: [host\ServerInteraction\ServerInteractionTests.sqf at line 176](../../../Src/host/ServerInteraction/ServerInteractionTests.sqf#L176)
## si_debug_createthrowtask

Type: function

> Exists if **EDITOR** defined

Description: ACTUAL
- Param: _model
- Param: _vecPos
- Param: _vecDir
- Param: _distance
- Param: _precdown
- Param: _leveldown
- Param: _duration

File: [host\ServerInteraction\ServerInteractionTests.sqf at line 196](../../../Src/host/ServerInteraction/ServerInteractionTests.sqf#L196)
## si_debug_setpby

Type: function

> Exists if **EDITOR** defined

Description: common funcs


File: [host\ServerInteraction\ServerInteractionTests.sqf at line 245](../../../Src/host/ServerInteraction/ServerInteractionTests.sqf#L245)
# ServerInteraction_Collision.sqf

## si_collision_onUpdate_handle

Type: Variable

Description: 


Initial value:
```sqf
startUpdate(...
```
File: [host\ServerInteraction\ServerInteraction_Collision.sqf at line 23](../../../Src/host/ServerInteraction/ServerInteraction_Collision.sqf#L23)
## si_collision_onUpdate

Type: function

Description: 


File: [host\ServerInteraction\ServerInteraction_Collision.sqf at line 11](../../../Src/host/ServerInteraction/ServerInteraction_Collision.sqf#L11)
# ServerInteraction_ThrowModes.sqf

## SI_TM_THROW

Type: constant

Description: 


Replaced value:
```sqf
0
```
File: [host\ServerInteraction\ServerInteraction_ThrowModes.sqf at line 6](../../../Src/host/ServerInteraction/ServerInteraction_ThrowModes.sqf#L6)
## SI_TM_SHOOT

Type: constant

Description: 


Replaced value:
```sqf
1
```
File: [host\ServerInteraction\ServerInteraction_ThrowModes.sqf at line 7](../../../Src/host/ServerInteraction/ServerInteraction_ThrowModes.sqf#L7)
