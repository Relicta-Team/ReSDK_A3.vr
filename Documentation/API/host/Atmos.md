# Atmos.h

## ATMOS_USE_UPDATE_BUFFER

Type: constant

Description: 


Replaced value:
```sqf

```
File: [host\Atmos\Atmos.h at line 6](../../../Src/host/Atmos/Atmos.h#L6)
## ATMOS_TYPEID_FIRE

Type: constant

Description: 


Replaced value:
```sqf
0
```
File: [host\Atmos\Atmos.h at line 8](../../../Src/host/Atmos/Atmos.h#L8)
## ATMOS_TYPEID_GAS

Type: constant

Description: 


Replaced value:
```sqf
1
```
File: [host\Atmos\Atmos.h at line 9](../../../Src/host/Atmos/Atmos.h#L9)
## ATMOS_TYPEID_WATER

Type: constant

Description: 


Replaced value:
```sqf
2
```
File: [host\Atmos\Atmos.h at line 10](../../../Src/host/Atmos/Atmos.h#L10)
## ATMOS_MAIN_THREAD_UPDATE_DELAY

Type: constant

Description: частота обновления основного треда


Replaced value:
```sqf
0.1
```
File: [host\Atmos\Atmos.h at line 13](../../../Src/host/Atmos/Atmos.h#L13)
## ATMOS_POS_INSIDE_CHUNK(_p,_chunkPos)

Type: constant

Description: 
- Param: _p
- Param: _chunkPos

Replaced value:
```sqf
((_p) inArea [_chunkPos, ATMOS_SIZE_HALF, ATMOS_SIZE_HALF, 0, true, ATMOS_SIZE_HALF])
```
File: [host\Atmos\Atmos.h at line 15](../../../Src/host/Atmos/Atmos.h#L15)
## ATMOS_AREA_INDEX_CLIENTS

Type: constant

Description: subscribers for chunk update


Replaced value:
```sqf
0
```
File: [host\Atmos\Atmos.h at line 18](../../../Src/host/Atmos/Atmos.h#L18)
## ATMOS_AREA_INDEX_CHUNKS

Type: constant

Description: list of all chunks in area


Replaced value:
```sqf
1
```
File: [host\Atmos\Atmos.h at line 20](../../../Src/host/Atmos/Atmos.h#L20)
## ATMOS_AREA_INDEX_LASTUPDATE

Type: constant

Description: timestamp of last update area


Replaced value:
```sqf
2
```
File: [host\Atmos\Atmos.h at line 22](../../../Src/host/Atmos/Atmos.h#L22)
## ATMOS_AREA_INDEX_LASTDELETE

Type: constant

Description: timestamp of last delete inside area


Replaced value:
```sqf
3
```
File: [host\Atmos\Atmos.h at line 24](../../../Src/host/Atmos/Atmos.h#L24)
## ATMOS_AREA_INDEX_UPDATE_BUFFER

Type: constant

Description: буффер изменений для следующей отправки


Replaced value:
```sqf
4
```
File: [host\Atmos\Atmos.h at line 27](../../../Src/host/Atmos/Atmos.h#L27)
## ATMOS_AREA_INDEX_LASTSEND_BUFFER

Type: constant

Description: отметка последнего рассыла обновлений буфера


Replaced value:
```sqf
5
```
File: [host\Atmos\Atmos.h at line 29](../../../Src/host/Atmos/Atmos.h#L29)
## ATMOS_AREA_INDEX_AREAID

Type: constant

Description: 


Replaced value:
```sqf
6
```
File: [host\Atmos\Atmos.h at line 32](../../../Src/host/Atmos/Atmos.h#L32)
## ATMOS_AREA_NEW

Type: constant

Description: 


Replaced value:
```sqf
[[], [], 0, 0 , createHashMap, 0, _aid]
```
File: [host\Atmos\Atmos.h at line 34](../../../Src/host/Atmos/Atmos.h#L34)
## ATMOS_SEND_DELAY_BUFFER

Type: constant

Description: 


Replaced value:
```sqf
1
```
File: [host\Atmos\Atmos.h at line 37](../../../Src/host/Atmos/Atmos.h#L37)
# Atmos.hpp

## ATMOS_MODE_FORCE_OPTIMIZE

Type: constant

Description: prerelease optimize


Replaced value:
```sqf

```
File: [host\Atmos\Atmos.hpp at line 20](../../../Src/host/Atmos/Atmos.hpp#L20)
## ATMOS_MODE_SPREAD_FORCE_OPTIMIZE

Type: constant

Description: this value decremented on instance copy of object


Replaced value:
```sqf
6
```
File: [host\Atmos\Atmos.hpp at line 22](../../../Src/host/Atmos/Atmos.hpp#L22)
## ATMOS_START_INDEX

Type: constant

Description: начальное число с которого начинается отсчёт позиций


Replaced value:
```sqf
1
```
File: [host\Atmos\Atmos.hpp at line 25](../../../Src/host/Atmos/Atmos.hpp#L25)
## ATMOS_SIZE

Type: constant

Description: size one chunk in meters and half (only constexpr in prod. required)


Replaced value:
```sqf
1
```
File: [host\Atmos\Atmos.hpp at line 28](../../../Src/host/Atmos/Atmos.hpp#L28)
## ATMOS_SIZE_HALF

Type: constant

Description: 


Replaced value:
```sqf
0.5
```
File: [host\Atmos\Atmos.hpp at line 29](../../../Src/host/Atmos/Atmos.hpp#L29)
## ATMOS_SIZE_HALF_OFFSET

Type: constant

Description: 


Replaced value:
```sqf
0.1
```
File: [host\Atmos\Atmos.hpp at line 30](../../../Src/host/Atmos/Atmos.hpp#L30)
## ATMOS_AREA_SIZE

Type: constant

Description: одна зона = 10 чанков


Replaced value:
```sqf
10
```
File: [host\Atmos\Atmos.hpp at line 33](../../../Src/host/Atmos/Atmos.hpp#L33)
## ATMOS_RPC_SERVER_REQUEST_AREA

Type: constant

> Exists if **EDITOR** defined

Description: 


Replaced value:
```sqf
"atmos_request_area"
```
File: [host\Atmos\Atmos.hpp at line 36](../../../Src/host/Atmos/Atmos.hpp#L36)
## ATMOS_RPC_SERVER_DELETE_EXPIRED_CHUNKS

Type: constant

> Exists if **EDITOR** defined

Description: 


Replaced value:
```sqf
"atmos_delete_expired"
```
File: [host\Atmos\Atmos.hpp at line 37](../../../Src/host/Atmos/Atmos.hpp#L37)
## ATMOS_RPC_CLIENT_UPDATE_CHUNK

Type: constant

> Exists if **EDITOR** defined

Description: 


Replaced value:
```sqf
"atmos_update_chunk"
```
File: [host\Atmos\Atmos.hpp at line 38](../../../Src/host/Atmos/Atmos.hpp#L38)
## ATMOS_RPC_CLIENT_UNSUBSCRIBE_LISTEN_CHUNK

Type: constant

> Exists if **EDITOR** defined

Description: 


Replaced value:
```sqf
"atmos_unsub_area"
```
File: [host\Atmos\Atmos.hpp at line 39](../../../Src/host/Atmos/Atmos.hpp#L39)
## ATMOS_RPC_SERVER_REQUEST_AREA

Type: constant

> Exists if **EDITOR** not defined

Description: 


Replaced value:
```sqf
"salr"
```
File: [host\Atmos\Atmos.hpp at line 41](../../../Src/host/Atmos/Atmos.hpp#L41)
## ATMOS_RPC_SERVER_DELETE_EXPIRED_CHUNKS

Type: constant

> Exists if **EDITOR** not defined

Description: 


Replaced value:
```sqf
"sald"
```
File: [host\Atmos\Atmos.hpp at line 42](../../../Src/host/Atmos/Atmos.hpp#L42)
## ATMOS_RPC_CLIENT_UPDATE_CHUNK

Type: constant

> Exists if **EDITOR** not defined

Description: 


Replaced value:
```sqf
"cuar"
```
File: [host\Atmos\Atmos.hpp at line 43](../../../Src/host/Atmos/Atmos.hpp#L43)
## ATMOS_RPC_CLIENT_UNSUBSCRIBE_LISTEN_CHUNK

Type: constant

> Exists if **EDITOR** not defined

Description: 


Replaced value:
```sqf
"cdar"
```
File: [host\Atmos\Atmos.hpp at line 44](../../../Src/host/Atmos/Atmos.hpp#L44)
## ATMOS_PROPAGATION_SIDE_MAX_COUNT

Type: constant

Description: left, right, top, bottom, front, back


Replaced value:
```sqf
6
```
File: [host\Atmos\Atmos.hpp at line 48](../../../Src/host/Atmos/Atmos.hpp#L48)
## ATMOS_ADDITIONAL_RANGE_XY

Type: constant

Description: 


Replaced value:
```sqf
rand(-0.25, 0.25)
```
File: [host\Atmos\Atmos.hpp at line 50](../../../Src/host/Atmos/Atmos.hpp#L50)
## ATMOS_ADDITIONAL_RANGE_Z

Type: constant

Description: 


Replaced value:
```sqf
rand(-0.1, 0.1)
```
File: [host\Atmos\Atmos.hpp at line 51](../../../Src/host/Atmos/Atmos.hpp#L51)
## ATMOS_SEARCH_MODE_GET_COUNT

Type: constant

Description: Получение количества пересечений


Replaced value:
```sqf
0
```
File: [host\Atmos\Atmos.hpp at line 55](../../../Src/host/Atmos/Atmos.hpp#L55)
## ATMOS_SEARCH_MODE_FIRST_INTERSECT

Type: constant

Description: поиск до первого пересечения


Replaced value:
```sqf
1
```
File: [host\Atmos\Atmos.hpp at line 57](../../../Src/host/Atmos/Atmos.hpp#L57)
## ATMOS_SEARCH_MODE_NO_INTERSECT

Type: constant

Description: поиск до первого отсутствия пересечения


Replaced value:
```sqf
2
```
File: [host\Atmos\Atmos.hpp at line 59](../../../Src/host/Atmos/Atmos.hpp#L59)
## ATMOS_SEARCH_MODE_GET_VOBJECTS

Type: constant

Description: получение виртуальных объектов на пересечении


Replaced value:
```sqf
3
```
File: [host\Atmos\Atmos.hpp at line 61](../../../Src/host/Atmos/Atmos.hpp#L61)
## ATMOS_SPREAD_TYPE_NORMAL

Type: constant

Description: Типы распространения. Нормальный тип это 4 стороны от центра, +1z,-1z


Replaced value:
```sqf
0
```
File: [host\Atmos\Atmos.hpp at line 65](../../../Src/host/Atmos/Atmos.hpp#L65)
## ATMOS_SPREAD_TYPE_NORMAL_XY_ANGLES

Type: constant

Description: 


Replaced value:
```sqf
1
```
File: [host\Atmos\Atmos.hpp at line 66](../../../Src/host/Atmos/Atmos.hpp#L66)
## ATMOS_SPREAD_TYPE_NO_Z

Type: constant

Description: 


Replaced value:
```sqf
2
```
File: [host\Atmos\Atmos.hpp at line 67](../../../Src/host/Atmos/Atmos.hpp#L67)
# Atmos_debug.sqf

## ATMOS_DEBUG_CREATE_SPHERE(_r,_g,_b)

Type: constant

Description: 
- Param: _r
- Param: _g
- Param: _b

Replaced value:
```sqf
call {private _s = "Sign_Sphere10cm_F" createVehicleLocal [0,0,0]; \
_s setObjectTexture [0,format(["#(rgb,8,8,3)color(%1,%2,%3,1)",_r,_g,_b])]; _s}
```
File: [host\Atmos\Atmos_debug.sqf at line 12](../../../Src/host/Atmos/Atmos_debug.sqf#L12)
## TEST_CHECK(_v,_need)

Type: constant

Description: 
- Param: _v
- Param: _need

Replaced value:
```sqf
_pv = _v; if not_equals(_pv,_need) exitWith { \
		errorformat('TEST FAILED: _v -> Expected: %2 but got %1',_pv arg _need); \
		false \
	};
```
File: [host\Atmos\Atmos_debug.sqf at line 21](../../../Src/host/Atmos/Atmos_debug.sqf#L21)
## TEST_DIST(_v,_need,distreq)

Type: constant

Description: 
- Param: _v
- Param: _need
- Param: distreq

Replaced value:
```sqf
_pv = _v; if ((_pv distance _need)>distreq) exitWith { \
		errorformat('TEST FAILED: _v -> Expected distance: %1 but got %2',distreq arg _pv distance _need); \
		false \
	};
```
File: [host\Atmos\Atmos_debug.sqf at line 25](../../../Src/host/Atmos/Atmos_debug.sqf#L25)
## atmos_debug_spheresCenter

Type: Variable

Description: 


Initial value:
```sqf
createHashMap
```
File: [host\Atmos\Atmos_debug.sqf at line 131](../../../Src/host/Atmos/Atmos_debug.sqf#L131)
## atmos_debug_testAll

Type: function

Description: 


File: [host\Atmos\Atmos_debug.sqf at line 15](../../../Src/host/Atmos/Atmos_debug.sqf#L15)
## atmos_debug_renderUpdate

Type: function

Description: 


File: [host\Atmos\Atmos_debug.sqf at line 41](../../../Src/host/Atmos/Atmos_debug.sqf#L41)
## atmos_debug_renderVisual

Type: function

Description: 


File: [host\Atmos\Atmos_debug.sqf at line 46](../../../Src/host/Atmos/Atmos_debug.sqf#L46)
## atmos_debug_enableRender

Type: function

Description: 


File: [host\Atmos\Atmos_debug.sqf at line 119](../../../Src/host/Atmos/Atmos_debug.sqf#L119)
# Atmos_init.sqf

## ASP_USE_NAMED_REGION

Type: constant

Description: 


Replaced value:
```sqf

```
File: [host\Atmos\Atmos_init.sqf at line 259](../../../Src/host/Atmos/Atmos_init.sqf#L259)
## ASP_REGION_NAMED(t,x)

Type: constant

> Exists if **ASP_USE_NAMED_REGION** defined

Description: 
- Param: t
- Param: x

Replaced value:
```sqf
ASP_REGION(t + (str _x))
```
File: [host\Atmos\Atmos_init.sqf at line 262](../../../Src/host/Atmos/Atmos_init.sqf#L262)
## ASP_REGION_NAMED(t,x)

Type: constant

> Exists if **ASP_USE_NAMED_REGION** not defined

Description: 
- Param: t
- Param: x

Replaced value:
```sqf
ASP_REGION(t)
```
File: [host\Atmos\Atmos_init.sqf at line 264](../../../Src/host/Atmos/Atmos_init.sqf#L264)
## atmos_map_chunks

Type: Variable

Description: chunks references used for effector


Initial value:
```sqf
createHashMap //key:str(chunkloc) -> value(struct:AtmosChunk)
```
File: [host\Atmos\Atmos_init.sqf at line 28](../../../Src/host/Atmos/Atmos_init.sqf#L28)
## atmos_map_chunkAreas

Type: Variable

Description: area used for sync data


Initial value:
```sqf
createHashMap //key: str chunkArea, value (list<AtmosChunks>)
```
File: [host\Atmos\Atmos_init.sqf at line 31](../../../Src/host/Atmos/Atmos_init.sqf#L31)
## atmos_handle_update

Type: Variable

Description: key: str chunkArea, value (list<AtmosChunks>)


Initial value:
```sqf
-1
```
File: [host\Atmos\Atmos_init.sqf at line 32](../../../Src/host/Atmos/Atmos_init.sqf#L32)
## atmos_chunks_uniqIdx

Type: Variable

Description: 


Initial value:
```sqf
0
```
File: [host\Atmos\Atmos_init.sqf at line 33](../../../Src/host/Atmos/Atmos_init.sqf#L33)
## atmos_chunks

Type: Variable

Description: 


Initial value:
```sqf
0
```
File: [host\Atmos\Atmos_init.sqf at line 35](../../../Src/host/Atmos/Atmos_init.sqf#L35)
## atmos_areas

Type: Variable

Description: 


Initial value:
```sqf
0
```
File: [host\Atmos\Atmos_init.sqf at line 36](../../../Src/host/Atmos/Atmos_init.sqf#L36)
## atmos_imap_process_t

Type: Variable

Description: 


Initial value:
```sqf
createHashMapFromArray [...
```
File: [host\Atmos\Atmos_init.sqf at line 244](../../../Src/host/Atmos/Atmos_init.sqf#L244)
## atmos_internal_handleUpdate

Type: Variable

Description: ----- main update handle -------


Initial value:
```sqf
startUpdate(atmos_internal_onUpdate,ATMOS_MAIN_THREAD_UPDATE_DELAY)
```
File: [host\Atmos\Atmos_init.sqf at line 340](../../../Src/host/Atmos/Atmos_init.sqf#L340)
## atmos_cv_ca

Type: Variable

Description: small optimizations


Initial value:
```sqf
["canActivity"]
```
File: [host\Atmos\Atmos_init.sqf at line 255](../../../Src/host/Atmos/Atmos_init.sqf#L255)
## atmos_cv_goch

Type: Variable

Description: 


Initial value:
```sqf
["getObjectsInChunk"]
```
File: [host\Atmos\Atmos_init.sqf at line 256](../../../Src/host/Atmos/Atmos_init.sqf#L256)
## atmos_cv_oa

Type: Variable

Description: 


Initial value:
```sqf
["onActivity"]
```
File: [host\Atmos\Atmos_init.sqf at line 257](../../../Src/host/Atmos/Atmos_init.sqf#L257)
## atmos_getChunkAtChId

Type: function

Description: returns chunk by id, creates new if not exists
- Param: _chId

File: [host\Atmos\Atmos_init.sqf at line 39](../../../Src/host/Atmos/Atmos_init.sqf#L39)
## atmos_getChunkAtChIdUnsafe

Type: function

Description: returns chunk by id
- Param: _chId

File: [host\Atmos\Atmos_init.sqf at line 56](../../../Src/host/Atmos/Atmos_init.sqf#L56)
## atmos_getAreaAtAid

Type: function

Description: returns area by id
- Param: _aid

File: [host\Atmos\Atmos_init.sqf at line 64](../../../Src/host/Atmos/Atmos_init.sqf#L64)
## atmos_rpc_requestGetArea

Type: function

Description: обработка запроса зоны от клиента
- Param: _cli
- Param: _ar
- Param: _lastUpd

File: [host\Atmos\Atmos_init.sqf at line 75](../../../Src/host/Atmos/Atmos_init.sqf#L75)
## atmos_internal_generatePacket

Type: function

Description: 
- Param: _packet
- Param: _chObjList
- Param: _lastUpd

File: [host\Atmos\Atmos_init.sqf at line 99](../../../Src/host/Atmos/Atmos_init.sqf#L99)
## atmos_rpc_validateExpiredChunks

Type: function

Description: 
- Param: _cli
- Param: _ar
- Param: _listIds

File: [host\Atmos\Atmos_init.sqf at line 108](../../../Src/host/Atmos/Atmos_init.sqf#L108)
## atmos_onUpdateAreaByChunk

Type: function

Description: 
- Param: _chObj

File: [host\Atmos\Atmos_init.sqf at line 130](../../../Src/host/Atmos/Atmos_init.sqf#L130)
## atmos_transferBuffer

Type: function

> Exists if **ATMOS_USE_UPDATE_BUFFER** defined

Description: 
- Param: _aDat

File: [host\Atmos\Atmos_init.sqf at line 165](../../../Src/host/Atmos/Atmos_init.sqf#L165)
## atmos_onUnsubscribeClientListening

Type: function

Description: 
- Param: _cli
- Param: _aId

File: [host\Atmos\Atmos_init.sqf at line 189](../../../Src/host/Atmos/Atmos_init.sqf#L189)
## atmos_unsubscribeClientListeningSrv

Type: function

Description: 
- Param: _cli

File: [host\Atmos\Atmos_init.sqf at line 205](../../../Src/host/Atmos/Atmos_init.sqf#L205)
## atmos_createProcess

Type: function

Description: create new process inside chunk
- Param: _pos
- Param: _procType
- Param: _manualCreate (optional, default false)
- Param: _paramsInit (optional, default null)

File: [host\Atmos\Atmos_init.sqf at line 218](../../../Src/host/Atmos/Atmos_init.sqf#L218)
## atmos_internal_onUpdate

Type: function

Description: 


File: [host\Atmos\Atmos_init.sqf at line 267](../../../Src/host/Atmos/Atmos_init.sqf#L267)
## atmos_internal_generateChunkGetCode

Type: function

Description: what this?..
- Param: _bch

File: [host\Atmos\Atmos_init.sqf at line 345](../../../Src/host/Atmos/Atmos_init.sqf#L345)
# Atmos_raycasts.sqf

## ATMOS_EXTENDED_INTERSECTION_COUNT

Type: constant

Description: расширенное количество отбрасываемых лучей


Replaced value:
```sqf

```
File: [host\Atmos\Atmos_raycasts.sqf at line 157](../../../Src/host/Atmos/Atmos_raycasts.sqf#L157)
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
File: [host\Atmos\Atmos_raycasts.sqf at line 270](../../../Src/host/Atmos/Atmos_raycasts.sqf#L270)
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
File: [host\Atmos\Atmos_raycasts.sqf at line 277](../../../Src/host/Atmos/Atmos_raycasts.sqf#L277)
## exitMethod

Type: constant

> Exists if **ATMOS_DEBUG_DRAW_INTERSECT_INFO** defined

Description: 


Replaced value:
```sqf
then
```
File: [host\Atmos\Atmos_raycasts.sqf at line 283](../../../Src/host/Atmos/Atmos_raycasts.sqf#L283)
## setupValue(v)

Type: constant

> Exists if **ATMOS_DEBUG_DRAW_INTERSECT_INFO** defined

Description: 
- Param: v

Replaced value:
```sqf
if (!_valueSetupGet) then {v}
```
File: [host\Atmos\Atmos_raycasts.sqf at line 284](../../../Src/host/Atmos/Atmos_raycasts.sqf#L284)
## ATMOS_DEBUG_DRAW_INTERSECT_SPHERE

Type: constant

> Exists if **ATMOS_DEBUG_DRAW_INTERSECT_INFO** not defined

Description: 


Replaced value:
```sqf

```
File: [host\Atmos\Atmos_raycasts.sqf at line 287](../../../Src/host/Atmos/Atmos_raycasts.sqf#L287)
## exitMethod

Type: constant

> Exists if **ATMOS_DEBUG_DRAW_INTERSECT_INFO** not defined

Description: 


Replaced value:
```sqf
exitWith
```
File: [host\Atmos\Atmos_raycasts.sqf at line 288](../../../Src/host/Atmos/Atmos_raycasts.sqf#L288)
## setupValue(v)

Type: constant

> Exists if **ATMOS_DEBUG_DRAW_INTERSECT_INFO** not defined

Description: 
- Param: v

Replaced value:
```sqf
v
```
File: [host\Atmos\Atmos_raycasts.sqf at line 289](../../../Src/host/Atmos/Atmos_raycasts.sqf#L289)
## atmos_const_lineVectors

Type: Variable

Description: 


Initial value:
```sqf
call atmos_getVectorsChunkInfo
```
File: [host\Atmos\Atmos_raycasts.sqf at line 90](../../../Src/host/Atmos/Atmos_raycasts.sqf#L90)
## atmos_getVectorsChunkInfo

Type: function

Description: генератор лучей для отлова объектов в границах чанка


File: [host\Atmos\Atmos_raycasts.sqf at line 13](../../../Src/host/Atmos/Atmos_raycasts.sqf#L13)
## atmos_chunkGetNearObjects

Type: function

Description: получает все объекты, находящиеся в чанке (объекты находящиеся частично в чанке так же будут получены)
- Param: _fromCh

File: [host\Atmos\Atmos_raycasts.sqf at line 93](../../../Src/host/Atmos/Atmos_raycasts.sqf#L93)
## atmos_getObjectsInChunk

Type: function

Description: собирает объекты попавшие в границы чанка. бросает (count atmos_const_lineVectors) на каждой грани для поиска объектов
- Param: _fromCh

File: [host\Atmos\Atmos_raycasts.sqf at line 129](../../../Src/host/Atmos/Atmos_raycasts.sqf#L129)
## atmos_getIntersectPosList

Type: function

Description: возвращает точки входа и конца пересечений. данная функция используется для запроса пересечений
- Param: _chId
- Param: _side
- Param: _fromPos (optional, default true)

File: [host\Atmos\Atmos_raycasts.sqf at line 160](../../../Src/host/Atmos/Atmos_raycasts.sqf#L160)
## atmos_getIntersectInfo

Type: function

Description: 
- Param: _fromCh
- Param: _side
- Param: _searchMode (optional, default ATMOS_SEARCH_MODE_GET_COUNT)
- Param: _refOutPos

File: [host\Atmos\Atmos_raycasts.sqf at line 253](../../../Src/host/Atmos/Atmos_raycasts.sqf#L253)
# Atmos_shared.sqf

## atmos_chunkPosToId

Type: function

Description: convert world postion to virtual chunk id
- Param: _x
- Param: _y
- Param: _z

File: [host\Atmos\Atmos_shared.sqf at line 9](../../../Src/host/Atmos/Atmos_shared.sqf#L9)
## atmos_chunkIdToPos

Type: function

Description: returns center atl pos of chunk
- Param: _iX
- Param: _iY
- Param: _iZ

File: [host\Atmos\Atmos_shared.sqf at line 20](../../../Src/host/Atmos/Atmos_shared.sqf#L20)
## atmos_getAreaIdByPos

Type: function

Description: returns area id by world position
- Param: _x
- Param: _y
- Param: _z

File: [host\Atmos\Atmos_shared.sqf at line 31](../../../Src/host/Atmos/Atmos_shared.sqf#L31)
## atmos_getPosByAreaId

Type: function

Description: returns world pos by areaid
- Param: _x
- Param: _y
- Param: _z

File: [host\Atmos\Atmos_shared.sqf at line 41](../../../Src/host/Atmos/Atmos_shared.sqf#L41)
## atmos_getLocalChunkIdInArea

Type: function

Description: Получение локального айди чанка для зоны
- Param: _chunkX
- Param: _chunkY
- Param: _chunkZ

File: [host\Atmos\Atmos_shared.sqf at line 51](../../../Src/host/Atmos/Atmos_shared.sqf#L51)
## atmos_localChunkIdToGlobal

Type: function

Description: Возвращает айди чанка по зоне
- Param: _arId
- Param: _locChId

File: [host\Atmos\Atmos_shared.sqf at line 67](../../../Src/host/Atmos/Atmos_shared.sqf#L67)
## atmos_chunkIdToAreaId

Type: function

Description: Преобразование айдичанка в айдизону
- Param: _iX
- Param: _iY
- Param: _iZ

File: [host\Atmos\Atmos_shared.sqf at line 92](../../../Src/host/Atmos/Atmos_shared.sqf#L92)
## atmos_getAroundAreas

Type: function

Description: 
- Param: _curAr

File: [host\Atmos\Atmos_shared.sqf at line 113](../../../Src/host/Atmos/Atmos_shared.sqf#L113)
## atmos_encodeChId

Type: function

Description: ! only for local chunk pos
- Param: _x
- Param: _y
- Param: _z

File: [host\Atmos\Atmos_shared.sqf at line 135](../../../Src/host/Atmos/Atmos_shared.sqf#L135)
## atmos_decodeChId

Type: function

Description: ! returns local chunk pos
- Param: _id

File: [host\Atmos\Atmos_shared.sqf at line 141](../../../Src/host/Atmos/Atmos_shared.sqf#L141)
# Atmos_spreading.sqf

## ignite_info(v)

Type: constant

> Exists if **ATMOS_DEBUG_TRY_IGNITE** defined

Description: 
- Param: v

Replaced value:
```sqf
if equals(atmos_debug_ignite_ptr,getVar(_obj,pointer)) then {traceformat("atmos::tryIgnite() [%1] - %2",_obj arg v)};
```
File: [host\Atmos\Atmos_spreading.sqf at line 68](../../../Src/host/Atmos/Atmos_spreading.sqf#L68)
## ignite_info(v)

Type: constant

> Exists if **ATMOS_DEBUG_TRY_IGNITE** not defined

Description: 
- Param: v

Replaced value:
```sqf

```
File: [host\Atmos\Atmos_spreading.sqf at line 71](../../../Src/host/Atmos/Atmos_spreading.sqf#L71)
## atmos_const_list_ptrFuncGetSides

Type: Variable

Description: 


Initial value:
```sqf
[...
```
File: [host\Atmos\Atmos_spreading.sqf at line 43](../../../Src/host/Atmos/Atmos_spreading.sqf#L43)
## atmos_debug_ignite_ptr

Type: Variable

> Exists if **ATMOS_DEBUG_TRY_IGNITE** defined

Description: 


Initial value:
```sqf
""
```
File: [host\Atmos\Atmos_spreading.sqf at line 69](../../../Src/host/Atmos/Atmos_spreading.sqf#L69)
## atmos_spread_cross

Type: function

Description: 


File: [host\Atmos\Atmos_spreading.sqf at line 7](../../../Src/host/Atmos/Atmos_spreading.sqf#L7)
## atmos_spread_cross_ext

Type: function

Description: 


File: [host\Atmos\Atmos_spreading.sqf at line 19](../../../Src/host/Atmos/Atmos_spreading.sqf#L19)
## atmos_spread_std_no_z

Type: function

Description: 


File: [host\Atmos\Atmos_spreading.sqf at line 34](../../../Src/host/Atmos/Atmos_spreading.sqf#L34)
## atmos_getNextRandAroundChunks

Type: function

Description: Возвращает набор случайных сторон по запрошенному типу распространения
- Param: _count (optional, default 1)
- Param: _colType (optional, default ATMOS_SPREAD_TYPE_NORMAL)

File: [host\Atmos\Atmos_spreading.sqf at line 50](../../../Src/host/Atmos/Atmos_spreading.sqf#L50)
## atmos_tryIgnite

Type: function

Description: попытка зажечь область при нахождении предметов рядом
- Param: _obj

File: [host\Atmos\Atmos_spreading.sqf at line 74](../../../Src/host/Atmos/Atmos_spreading.sqf#L74)
# _Atmos_ChunkStruct_depr.sqf

## ATMOS_DEBUG_TRY_IGNITE

Type: constant

Description: 


Replaced value:
```sqf
atmos_debug_ignite_ptr
```
File: [host\Atmos\_Atmos_ChunkStruct_depr.sqf at line 63](../../../Src/host/Atmos/_Atmos_ChunkStruct_depr.sqf#L63)
## ignite_info(v)

Type: constant

> Exists if **ATMOS_DEBUG_TRY_IGNITE** defined

Description: 
- Param: v

Replaced value:
```sqf
if equals(atmos_debug_ignite_ptr,getVar(_obj,pointer)) then {logformat("atmos::tryIgnite() [%1] - %2",_obj arg v)};
```
File: [host\Atmos\_Atmos_ChunkStruct_depr.sqf at line 69](../../../Src/host/Atmos/_Atmos_ChunkStruct_depr.sqf#L69)
## ignite_info(v)

Type: constant

> Exists if **ATMOS_DEBUG_TRY_IGNITE** not defined

Description: 
- Param: v

Replaced value:
```sqf

```
File: [host\Atmos\_Atmos_ChunkStruct_depr.sqf at line 72](../../../Src/host/Atmos/_Atmos_ChunkStruct_depr.sqf#L72)
## atmos_debug_ignite_ptr

Type: Variable

> Exists if **ATMOS_DEBUG_TRY_IGNITE** defined

Description: 


Initial value:
```sqf
""
```
File: [host\Atmos\_Atmos_ChunkStruct_depr.sqf at line 70](../../../Src/host/Atmos/_Atmos_ChunkStruct_depr.sqf#L70)
## atmos_getChunkAtChId

Type: function

Description: Atmos chunk management
- Param: _chId

File: [host\Atmos\_Atmos_ChunkStruct_depr.sqf at line 13](../../../Src/host/Atmos/_Atmos_ChunkStruct_depr.sqf#L13)
## atmos_getChunkAtChIdUnsafe

Type: function

Description: 
- Param: _chId

File: [host\Atmos\_Atmos_ChunkStruct_depr.sqf at line 35](../../../Src/host/Atmos/_Atmos_ChunkStruct_depr.sqf#L35)
## atmos_createProcess

Type: function

Description: create atmos effect (fire,smoke etc)
- Param: _pos
- Param: _processClass
- Param: _manualCreate (optional, default false)
- Param: _initialGas (optional, default ['"GasBase"', '1'])

File: [host\Atmos\_Atmos_ChunkStruct_depr.sqf at line 42](../../../Src/host/Atmos/_Atmos_ChunkStruct_depr.sqf#L42)
## atmos_tryIgnite

Type: function

Description: попытка зажечь область при нахождении предметов рядом
- Param: _obj

File: [host\Atmos\_Atmos_ChunkStruct_depr.sqf at line 76](../../../Src/host/Atmos/_Atmos_ChunkStruct_depr.sqf#L76)
# _Atmos_debug_depr.sqf

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
File: [host\Atmos\_Atmos_debug_depr.sqf at line 21](../../../Src/host/Atmos/_Atmos_debug_depr.sqf#L21)
## atmos_debug_handleDebugDraw

Type: Variable

> Exists if **EDITOR** defined

Description: 


Initial value:
```sqf
-1
```
File: [host\Atmos\_Atmos_debug_depr.sqf at line 188](../../../Src/host/Atmos/_Atmos_debug_depr.sqf#L188)
## atmos_debug_onupdate_handle_internal

Type: Variable

> Exists if **ATMOS_DEBUG_ON_UPDATE** defined

Description: 


Initial value:
```sqf
startUpdate(atmos_debug_onupdate_internal,0)
```
File: [host\Atmos\_Atmos_debug_depr.sqf at line 196](../../../Src/host/Atmos/_Atmos_debug_depr.sqf#L196)
## atmos_debug_handle_getObjInChunk

Type: Variable

> Exists if **ATMOS_DEBUG_DRAW_CHUNKOBJECTS** defined

Description: 


Initial value:
```sqf
startUpdate(atmos_debug_onupdate_getObjInChunk,0)
```
File: [host\Atmos\_Atmos_debug_depr.sqf at line 200](../../../Src/host/Atmos/_Atmos_debug_depr.sqf#L200)
## atmos_debug_drawCurrentZone

Type: function

Description: 


File: [host\Atmos\_Atmos_debug_depr.sqf at line 25](../../../Src/host/Atmos/_Atmos_debug_depr.sqf#L25)
## atmos_debug_drawObjectInfo

Type: function

Description: 
- Param: _aObj

File: [host\Atmos\_Atmos_debug_depr.sqf at line 126](../../../Src/host/Atmos/_Atmos_debug_depr.sqf#L126)
## atmos_debug_onupdate_internal

Type: function

Description: 


File: [host\Atmos\_Atmos_debug_depr.sqf at line 142](../../../Src/host/Atmos/_Atmos_debug_depr.sqf#L142)
## atmos_debug_onupdate_getObjInChunk

Type: function

Description: 


File: [host\Atmos\_Atmos_debug_depr.sqf at line 152](../../../Src/host/Atmos/_Atmos_debug_depr.sqf#L152)
# _Atmos_init_depr.sqf

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
File: [host\Atmos\_Atmos_init_depr.sqf at line 255](../../../Src/host/Atmos/_Atmos_init_depr.sqf#L255)
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
File: [host\Atmos\_Atmos_init_depr.sqf at line 262](../../../Src/host/Atmos/_Atmos_init_depr.sqf#L262)
## exitMethod

Type: constant

> Exists if **ATMOS_DEBUG_DRAW_INTERSECT_INFO** defined

Description: 


Replaced value:
```sqf
then
```
File: [host\Atmos\_Atmos_init_depr.sqf at line 268](../../../Src/host/Atmos/_Atmos_init_depr.sqf#L268)
## setupValue(v)

Type: constant

> Exists if **ATMOS_DEBUG_DRAW_INTERSECT_INFO** defined

Description: 
- Param: v

Replaced value:
```sqf
if (!_valueSetupGet) then {v}
```
File: [host\Atmos\_Atmos_init_depr.sqf at line 269](../../../Src/host/Atmos/_Atmos_init_depr.sqf#L269)
## ATMOS_DEBUG_DRAW_INTERSECT_SPHERE

Type: constant

> Exists if **ATMOS_DEBUG_DRAW_INTERSECT_INFO** not defined

Description: 


Replaced value:
```sqf

```
File: [host\Atmos\_Atmos_init_depr.sqf at line 272](../../../Src/host/Atmos/_Atmos_init_depr.sqf#L272)
## exitMethod

Type: constant

> Exists if **ATMOS_DEBUG_DRAW_INTERSECT_INFO** not defined

Description: 


Replaced value:
```sqf
exitWith
```
File: [host\Atmos\_Atmos_init_depr.sqf at line 273](../../../Src/host/Atmos/_Atmos_init_depr.sqf#L273)
## setupValue(v)

Type: constant

> Exists if **ATMOS_DEBUG_DRAW_INTERSECT_INFO** not defined

Description: 
- Param: v

Replaced value:
```sqf
v
```
File: [host\Atmos\_Atmos_init_depr.sqf at line 274](../../../Src/host/Atmos/_Atmos_init_depr.sqf#L274)
## ATMOS_EXTENDED_INTERSECTION_COUNT

Type: constant

Description: 


Replaced value:
```sqf

```
File: [host\Atmos\_Atmos_init_depr.sqf at line 328](../../../Src/host/Atmos/_Atmos_init_depr.sqf#L328)
## atmos_map_chunks

Type: Variable

Description: 


Initial value:
```sqf
createHashMap //key:str(chunkloc) -> value(object:AtmosChunk)
```
File: [host\Atmos\_Atmos_init_depr.sqf at line 48](../../../Src/host/Atmos/_Atmos_init_depr.sqf#L48)
## atmos_handle_update

Type: Variable

Description: key:str(chunkloc) -> value(object:AtmosChunk)


Initial value:
```sqf
-1
```
File: [host\Atmos\_Atmos_init_depr.sqf at line 49](../../../Src/host/Atmos/_Atmos_init_depr.sqf#L49)
## atmos_const_lineVectors

Type: Variable

Description: 


Initial value:
```sqf
call atmos_getVectorsChunkInfo
```
File: [host\Atmos\_Atmos_init_depr.sqf at line 188](../../../Src/host/Atmos/_Atmos_init_depr.sqf#L188)
## atmos_const_aroundChunks

Type: Variable

Description: 


Initial value:
```sqf
[...
```
File: [host\Atmos\_Atmos_init_depr.sqf at line 557](../../../Src/host/Atmos/_Atmos_init_depr.sqf#L557)
## atmos_const_list_ptrFuncsGetChunks

Type: Variable

Description: 


Initial value:
```sqf
[...
```
File: [host\Atmos\_Atmos_init_depr.sqf at line 602](../../../Src/host/Atmos/_Atmos_init_depr.sqf#L602)
## atmos_chunkGetNearObjects

Type: function

Description: получает все объекты, находящиеся в чанке
- Param: _fromCh

File: [host\Atmos\_Atmos_init_depr.sqf at line 52](../../../Src/host/Atmos/_Atmos_init_depr.sqf#L52)
## atmos_getVectorsChunkInfo

Type: function

Description: 


File: [host\Atmos\_Atmos_init_depr.sqf at line 111](../../../Src/host/Atmos/_Atmos_init_depr.sqf#L111)
## atmos_getObjectsInChunk

Type: function

Description: 
- Param: _fromCh

File: [host\Atmos\_Atmos_init_depr.sqf at line 192](../../../Src/host/Atmos/_Atmos_init_depr.sqf#L192)
## atmos_getIntersectInfo

Type: function

Description: возвращает информацию по пересечениям в соседнем чанке
- Param: _fromCh
- Param: _side
- Param: _searchMode (optional, default ATMOS_SEARCH_MODE_GET_COUNT)
- Param: _refOutPos

File: [host\Atmos\_Atmos_init_depr.sqf at line 238](../../../Src/host/Atmos/_Atmos_init_depr.sqf#L238)
## atmos_getIntersectPosList

Type: function

Description: возвращает точки входа и конца пересечений
- Param: _chId
- Param: _side
- Param: _fromPos (optional, default true)

File: [host\Atmos\_Atmos_init_depr.sqf at line 331](../../../Src/host/Atmos/_Atmos_init_depr.sqf#L331)
## atmos_onUpdate

Type: function

Description: 


File: [host\Atmos\_Atmos_init_depr.sqf at line 441](../../../Src/host/Atmos/_Atmos_init_depr.sqf#L441)
## atmos_chunkPosToId

Type: function

Description: convert world postion to virtual chunk id
- Param: _x
- Param: _y
- Param: _z

File: [host\Atmos\_Atmos_init_depr.sqf at line 491](../../../Src/host/Atmos/_Atmos_init_depr.sqf#L491)
## atmos_chunkIdToPos

Type: function

Description: returns center atl pos of chunk
- Param: _iX
- Param: _iY
- Param: _iZ

File: [host\Atmos\_Atmos_init_depr.sqf at line 502](../../../Src/host/Atmos/_Atmos_init_depr.sqf#L502)
## atmos_chunkIdGetAround

Type: function

Description: 
- Param: _chunk
- Param: _addCurrent (optional, default false)

File: [host\Atmos\_Atmos_init_depr.sqf at line 534](../../../Src/host/Atmos/_Atmos_init_depr.sqf#L534)
## atmos_list_getAroundChunksManaged

Type: function

Description: 


File: [host\Atmos\_Atmos_init_depr.sqf at line 566](../../../Src/host/Atmos/_Atmos_init_depr.sqf#L566)
## atmos_list_getAroundXYChunksManaged

Type: function

Description: 


File: [host\Atmos\_Atmos_init_depr.sqf at line 578](../../../Src/host/Atmos/_Atmos_init_depr.sqf#L578)
## atmos_list_getAroundNoZChunksManaged

Type: function

Description: 


File: [host\Atmos\_Atmos_init_depr.sqf at line 593](../../../Src/host/Atmos/_Atmos_init_depr.sqf#L593)
## atmos_getNextRandAroundChunks

Type: function

Description: возвращает случайные стороны
- Param: _count (optional, default 1)
- Param: _colType (optional, default ATMOS_SPREAD_MODE_NORMAL)

File: [host\Atmos\_Atmos_init_depr.sqf at line 609](../../../Src/host/Atmos/_Atmos_init_depr.sqf#L609)
## atmos_init

Type: function

Description: run thread updater


File: [host\Atmos\_Atmos_init_depr.sqf at line 626](../../../Src/host/Atmos/_Atmos_init_depr.sqf#L626)
