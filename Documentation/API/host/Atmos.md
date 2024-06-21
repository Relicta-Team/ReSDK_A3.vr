# Atmos.h

## ATMOS_START_INDEX

Type: constant

Description: начальное число с которого начинается отсчёт позиций


Replaced value:
```sqf
1
```
File: [host\Atmos\Atmos.h at line 7](../../../Src/host/Atmos/Atmos.h#L7)
## ATMOS_MAIN_THREAD_UPDATE_DELAY

Type: constant

Description: частота обновления основного треда


Replaced value:
```sqf
0.1
```
File: [host\Atmos\Atmos.h at line 10](../../../Src/host/Atmos/Atmos.h#L10)
## ATMOS_POS_INSIDE_CHUNK(_p,_chunkPos)

Type: constant

Description: 
- Param: _p
- Param: _chunkPos

Replaced value:
```sqf
((_p) inArea [_chunkPos, ATMOS_SIZE_HALF, ATMOS_SIZE_HALF, 0, true, ATMOS_SIZE_HALF])
```
File: [host\Atmos\Atmos.h at line 12](../../../Src/host/Atmos/Atmos.h#L12)
# Atmos.hpp

## ATMOS_SIZE

Type: constant

Description: size one chunk in meters and half (only constexpr in prod. required)


Replaced value:
```sqf
1
```
File: [host\Atmos\Atmos.hpp at line 17](../../../Src/host/Atmos/Atmos.hpp#L17)
## ATMOS_SIZE_HALF

Type: constant

Description: 


Replaced value:
```sqf
0.5
```
File: [host\Atmos\Atmos.hpp at line 18](../../../Src/host/Atmos/Atmos.hpp#L18)
## ATMOS_SIZE_HALF_OFFSET

Type: constant

Description: 


Replaced value:
```sqf
0.1
```
File: [host\Atmos\Atmos.hpp at line 19](../../../Src/host/Atmos/Atmos.hpp#L19)
## ATMOS_PROPAGATION_SIDE_MAX_COUNT

Type: constant

Description: left, right, top, bottom, front, back


Replaced value:
```sqf
6
```
File: [host\Atmos\Atmos.hpp at line 22](../../../Src/host/Atmos/Atmos.hpp#L22)
## ATMOS_ADDITIONAL_RANGE_XY

Type: constant

Description: 


Replaced value:
```sqf
rand(-0.25, 0.25)
```
File: [host\Atmos\Atmos.hpp at line 24](../../../Src/host/Atmos/Atmos.hpp#L24)
## ATMOS_ADDITIONAL_RANGE_Z

Type: constant

Description: 


Replaced value:
```sqf
rand(-0.1, 0.1)
```
File: [host\Atmos\Atmos.hpp at line 25](../../../Src/host/Atmos/Atmos.hpp#L25)
## ATMOS_SEARCH_MODE_GET_COUNT

Type: constant

Description: Получение количества пересечений


Replaced value:
```sqf
0
```
File: [host\Atmos\Atmos.hpp at line 29](../../../Src/host/Atmos/Atmos.hpp#L29)
## ATMOS_SEARCH_MODE_FIRST_INTERSECT

Type: constant

Description: поиск до первого пересечения


Replaced value:
```sqf
1
```
File: [host\Atmos\Atmos.hpp at line 31](../../../Src/host/Atmos/Atmos.hpp#L31)
## ATMOS_SEARCH_MODE_NO_INTERSECT

Type: constant

Description: поиск до первого отсутствия пересечения


Replaced value:
```sqf
2
```
File: [host\Atmos\Atmos.hpp at line 33](../../../Src/host/Atmos/Atmos.hpp#L33)
## ATMOS_SEARCH_MODE_GET_VOBJECTS

Type: constant

Description: получение виртуальных объектов на пересечении


Replaced value:
```sqf
3
```
File: [host\Atmos\Atmos.hpp at line 35](../../../Src/host/Atmos/Atmos.hpp#L35)
## ATMOS_SPREAD_MODE_NORMAL

Type: constant

Description: functions spread ptr


Replaced value:
```sqf
0
```
File: [host\Atmos\Atmos.hpp at line 39](../../../Src/host/Atmos/Atmos.hpp#L39)
## ATMOS_SPREAD_MODE_XY_ANGLES

Type: constant

Description: 


Replaced value:
```sqf
1
```
File: [host\Atmos\Atmos.hpp at line 40](../../../Src/host/Atmos/Atmos.hpp#L40)
## ATMOS_SPREAD_MODE_NO_Z

Type: constant

Description: 


Replaced value:
```sqf
2
```
File: [host\Atmos\Atmos.hpp at line 41](../../../Src/host/Atmos/Atmos.hpp#L41)
# Atmos_ChunkStruct.sqf

## ATMOS_DEBUG_TRY_IGNITE

Type: constant

Description: 


Replaced value:
```sqf
atmos_debug_ignite_ptr
```
File: [host\Atmos\Atmos_ChunkStruct.sqf at line 55](../../../Src/host/Atmos/Atmos_ChunkStruct.sqf#L55)
## ignite_info(v)

Type: constant

> Exists if **ATMOS_DEBUG_TRY_IGNITE** defined

Description: 
- Param: v

Replaced value:
```sqf
if equals(atmos_debug_ignite_ptr,getVar(_obj,pointer)) then {logformat("atmos::tryIgnite() [%1] - %2",_obj arg v)};
```
File: [host\Atmos\Atmos_ChunkStruct.sqf at line 61](../../../Src/host/Atmos/Atmos_ChunkStruct.sqf#L61)
## ignite_info(v)

Type: constant

> Exists if **ATMOS_DEBUG_TRY_IGNITE** not defined

Description: 
- Param: v

Replaced value:
```sqf

```
File: [host\Atmos\Atmos_ChunkStruct.sqf at line 64](../../../Src/host/Atmos/Atmos_ChunkStruct.sqf#L64)
## atmos_debug_ignite_ptr

Type: Variable

> Exists if **ATMOS_DEBUG_TRY_IGNITE** defined

Description: 


Initial value:
```sqf
""
```
File: [host\Atmos\Atmos_ChunkStruct.sqf at line 62](../../../Src/host/Atmos/Atmos_ChunkStruct.sqf#L62)
## atmos_getChunkAtChId

Type: function

Description: Atmos chunk management
- Param: _chId

File: [host\Atmos\Atmos_ChunkStruct.sqf at line 13](../../../Src/host/Atmos/Atmos_ChunkStruct.sqf#L13)
## atmos_getChunkAtChIdUnsafe

Type: function

Description: 
- Param: _chId

File: [host\Atmos\Atmos_ChunkStruct.sqf at line 27](../../../Src/host/Atmos/Atmos_ChunkStruct.sqf#L27)
## atmos_createProcess

Type: function

Description: create atmos effect (fire,smoke etc)
- Param: _pos
- Param: _processClass
- Param: _manualCreate (optional, default false)
- Param: _initialGas (optional, default ['"GasBase"', '1'])

File: [host\Atmos\Atmos_ChunkStruct.sqf at line 34](../../../Src/host/Atmos/Atmos_ChunkStruct.sqf#L34)
## atmos_tryIgnite

Type: function

Description: попытка зажечь область при нахождении предметов рядом
- Param: _obj

File: [host\Atmos\Atmos_ChunkStruct.sqf at line 68](../../../Src/host/Atmos/Atmos_ChunkStruct.sqf#L68)
# Atmos_debug.sqf

## ATMOS_DEBUG_CREATE_SPHERE(_r,_g,_b)

Type: constant

Description: #define ATMOS_MANAGED_ACTIVITY
- Param: _r
- Param: _g
- Param: _b

Replaced value:
```sqf
call {private _s = "Sign_Sphere10cm_F" createVehicleLocal [0,0,0]; \
_s setObjectTexture [0,format(["#(rgb,8,8,3)color(%1,%2,%3,1)",_r,_g,_b])]; _s}
```
File: [host\Atmos\Atmos_debug.sqf at line 21](../../../Src/host/Atmos/Atmos_debug.sqf#L21)
## atmos_debug_handleDebugDraw

Type: Variable

> Exists if **EDITOR** defined

Description: 


Initial value:
```sqf
-1
```
File: [host\Atmos\Atmos_debug.sqf at line 182](../../../Src/host/Atmos/Atmos_debug.sqf#L182)
## atmos_debug_onupdate_handle_internal

Type: Variable

> Exists if **ATMOS_DEBUG_ON_UPDATE** defined

Description: 


Initial value:
```sqf
startUpdate(atmos_debug_onupdate_internal,0)
```
File: [host\Atmos\Atmos_debug.sqf at line 190](../../../Src/host/Atmos/Atmos_debug.sqf#L190)
## atmos_debug_handle_getObjInChunk

Type: Variable

> Exists if **ATMOS_DEBUG_DRAW_CHUNKOBJECTS** defined

Description: 


Initial value:
```sqf
startUpdate(atmos_debug_onupdate_getObjInChunk,0)
```
File: [host\Atmos\Atmos_debug.sqf at line 194](../../../Src/host/Atmos/Atmos_debug.sqf#L194)
## atmos_debug_drawCurrentZone

Type: function

Description: 


File: [host\Atmos\Atmos_debug.sqf at line 25](../../../Src/host/Atmos/Atmos_debug.sqf#L25)
## atmos_debug_drawObjectInfo

Type: function

Description: 
- Param: _aObj

File: [host\Atmos\Atmos_debug.sqf at line 126](../../../Src/host/Atmos/Atmos_debug.sqf#L126)
## atmos_debug_onupdate_internal

Type: function

Description: 


File: [host\Atmos\Atmos_debug.sqf at line 136](../../../Src/host/Atmos/Atmos_debug.sqf#L136)
## atmos_debug_onupdate_getObjInChunk

Type: function

Description: 


File: [host\Atmos\Atmos_debug.sqf at line 146](../../../Src/host/Atmos/Atmos_debug.sqf#L146)
# Atmos_init.sqf

## ATMOS_DEBUG_DRAW_INTERSECT_SPHERE

Type: constant

> Exists if **ATMOS_DEBUG_DRAW_INTERSECT_INFO** defined

Description: 


Replaced value:
```sqf
_qResult = ([_x arg _destPosList select _foreachIndex] call si_getIntersectData); \
		if !isNullReference(_qResult select 0) then { \
			__ATMOS_DEBUG_SPHERE_INIT(1,0,0) \
		} else { \
			__ATMOS_DEBUG_SPHERE_INIT(0,1,0) \
		};
```
File: [host\Atmos\Atmos_init.sqf at line 247](../../../Src/host/Atmos/Atmos_init.sqf#L247)
## __ATMOS_DEBUG_SPHERE_INIT(r,g,b)

Type: constant

> Exists if **ATMOS_DEBUG_DRAW_INTERSECT_INFO** defined

Description: 
- Param: r
- Param: g
- Param: b

Replaced value:
```sqf
private _s = ATMOS_DEBUG_CREATE_SPHERE(r,g,ifcheck(_foreachIndex==0,1,b)); atmos_debug_list_giiSpheres pushBack _s; \
			_s setposatl _x; _s setvariable ["__index",_foreachIndex]; \
			_s = ATMOS_DEBUG_CREATE_SPHERE(r,g,b); atmos_debug_list_giiSpheres pushBack _s; \
			_s setposatl ifcheck((_qResult select 1)isequalto vec3(0,0,0),_destPosList select _foreachIndex,_qResult select 1); \
			_s setvariable ["__index",_foreachIndex];
```
File: [host\Atmos\Atmos_init.sqf at line 254](../../../Src/host/Atmos/Atmos_init.sqf#L254)
## exitMethod

Type: constant

> Exists if **ATMOS_DEBUG_DRAW_INTERSECT_INFO** defined

Description: 


Replaced value:
```sqf
then
```
File: [host\Atmos\Atmos_init.sqf at line 260](../../../Src/host/Atmos/Atmos_init.sqf#L260)
## setupValue(v)

Type: constant

> Exists if **ATMOS_DEBUG_DRAW_INTERSECT_INFO** defined

Description: 
- Param: v

Replaced value:
```sqf
if (!_valueSetupGet) then {v}
```
File: [host\Atmos\Atmos_init.sqf at line 261](../../../Src/host/Atmos/Atmos_init.sqf#L261)
## ATMOS_DEBUG_DRAW_INTERSECT_SPHERE

Type: constant

> Exists if **ATMOS_DEBUG_DRAW_INTERSECT_INFO** not defined

Description: 


Replaced value:
```sqf

```
File: [host\Atmos\Atmos_init.sqf at line 264](../../../Src/host/Atmos/Atmos_init.sqf#L264)
## exitMethod

Type: constant

> Exists if **ATMOS_DEBUG_DRAW_INTERSECT_INFO** not defined

Description: 


Replaced value:
```sqf
exitWith
```
File: [host\Atmos\Atmos_init.sqf at line 265](../../../Src/host/Atmos/Atmos_init.sqf#L265)
## setupValue(v)

Type: constant

> Exists if **ATMOS_DEBUG_DRAW_INTERSECT_INFO** not defined

Description: 
- Param: v

Replaced value:
```sqf
v
```
File: [host\Atmos\Atmos_init.sqf at line 266](../../../Src/host/Atmos/Atmos_init.sqf#L266)
## ATMOS_EXTENDED_INTERSECTION_COUNT

Type: constant

Description: 


Replaced value:
```sqf

```
File: [host\Atmos\Atmos_init.sqf at line 320](../../../Src/host/Atmos/Atmos_init.sqf#L320)
## atmos_map_chunks

Type: Variable

Description: 


Initial value:
```sqf
createHashMap //key:str(chunkloc) -> value(object:AtmosChunk)
```
File: [host\Atmos\Atmos_init.sqf at line 48](../../../Src/host/Atmos/Atmos_init.sqf#L48)
## atmos_handle_update

Type: Variable

Description: key:str(chunkloc) -> value(object:AtmosChunk)


Initial value:
```sqf
-1
```
File: [host\Atmos\Atmos_init.sqf at line 49](../../../Src/host/Atmos/Atmos_init.sqf#L49)
## atmos_const_lineVectors

Type: Variable

Description: 


Initial value:
```sqf
call atmos_getVectorsChunkInfo
```
File: [host\Atmos\Atmos_init.sqf at line 184](../../../Src/host/Atmos/Atmos_init.sqf#L184)
## atmos_const_aroundChunks

Type: Variable

Description: 


Initial value:
```sqf
[...
```
File: [host\Atmos\Atmos_init.sqf at line 549](../../../Src/host/Atmos/Atmos_init.sqf#L549)
## atmos_const_list_ptrFuncsGetChunks

Type: Variable

Description: 


Initial value:
```sqf
[...
```
File: [host\Atmos\Atmos_init.sqf at line 594](../../../Src/host/Atmos/Atmos_init.sqf#L594)
## atmos_chunkGetNearObjects

Type: function

Description: получает все объекты, находящиеся в чанке
- Param: _fromCh

File: [host\Atmos\Atmos_init.sqf at line 52](../../../Src/host/Atmos/Atmos_init.sqf#L52)
## atmos_getVectorsChunkInfo

Type: function

Description: 


File: [host\Atmos\Atmos_init.sqf at line 107](../../../Src/host/Atmos/Atmos_init.sqf#L107)
## atmos_getObjectsInChunk

Type: function

Description: 
- Param: _fromCh

File: [host\Atmos\Atmos_init.sqf at line 188](../../../Src/host/Atmos/Atmos_init.sqf#L188)
## atmos_getIntersectInfo

Type: function

Description: возвращает информацию по пересечениям в соседнем чанке
- Param: _fromCh
- Param: _side
- Param: _searchMode (optional, default ATMOS_SEARCH_MODE_GET_COUNT)
- Param: _refOutPos

File: [host\Atmos\Atmos_init.sqf at line 230](../../../Src/host/Atmos/Atmos_init.sqf#L230)
## atmos_getIntersectPosList

Type: function

Description: возвращает точки входа и конца пересечений
- Param: _chId
- Param: _side
- Param: _fromPos (optional, default true)

File: [host\Atmos\Atmos_init.sqf at line 323](../../../Src/host/Atmos/Atmos_init.sqf#L323)
## atmos_onUpdate

Type: function

Description: 


File: [host\Atmos\Atmos_init.sqf at line 433](../../../Src/host/Atmos/Atmos_init.sqf#L433)
## atmos_chunkPosToId

Type: function

Description: convert world postion to virtual chunk id
- Param: _x
- Param: _y
- Param: _z

File: [host\Atmos\Atmos_init.sqf at line 483](../../../Src/host/Atmos/Atmos_init.sqf#L483)
## atmos_chunkIdToPos

Type: function

Description: returns center atl pos of chunk
- Param: _iX
- Param: _iY
- Param: _iZ

File: [host\Atmos\Atmos_init.sqf at line 494](../../../Src/host/Atmos/Atmos_init.sqf#L494)
## atmos_chunkIdGetAround

Type: function

Description: 
- Param: _chunk
- Param: _addCurrent (optional, default false)

File: [host\Atmos\Atmos_init.sqf at line 526](../../../Src/host/Atmos/Atmos_init.sqf#L526)
## atmos_list_getAroundChunksManaged

Type: function

Description: 


File: [host\Atmos\Atmos_init.sqf at line 558](../../../Src/host/Atmos/Atmos_init.sqf#L558)
## atmos_list_getAroundXYChunksManaged

Type: function

Description: 


File: [host\Atmos\Atmos_init.sqf at line 570](../../../Src/host/Atmos/Atmos_init.sqf#L570)
## atmos_list_getAroundNoZChunksManaged

Type: function

Description: 


File: [host\Atmos\Atmos_init.sqf at line 585](../../../Src/host/Atmos/Atmos_init.sqf#L585)
## atmos_getNextRandAroundChunks

Type: function

Description: возвращает случайные стороны
- Param: _count (optional, default 1)
- Param: _colType (optional, default ATMOS_SPREAD_MODE_NORMAL)

File: [host\Atmos\Atmos_init.sqf at line 601](../../../Src/host/Atmos/Atmos_init.sqf#L601)
## atmos_init

Type: function

Description: run thread updater


File: [host\Atmos\Atmos_init.sqf at line 618](../../../Src/host/Atmos/Atmos_init.sqf#L618)
