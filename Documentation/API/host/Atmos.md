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
File: [host\Atmos\Atmos_debug.sqf at line 13](../../../Src/host/Atmos/Atmos_debug.sqf#L13)
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
File: [host\Atmos\Atmos_debug.sqf at line 27](../../../Src/host/Atmos/Atmos_debug.sqf#L27)
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
File: [host\Atmos\Atmos_debug.sqf at line 31](../../../Src/host/Atmos/Atmos_debug.sqf#L31)
## atmos_debug_spheresCenter

Type: Variable

Description: 


Initial value:
```sqf
createHashMap
```
File: [host\Atmos\Atmos_debug.sqf at line 246](../../../Src/host/Atmos/Atmos_debug.sqf#L246)
## atmos_debug_createSphere

Type: function

Description: 
- Param: _r
- Param: _g
- Param: _b

File: [host\Atmos\Atmos_debug.sqf at line 16](../../../Src/host/Atmos/Atmos_debug.sqf#L16)
## atmos_debug_testAll

Type: function

Description: 


File: [host\Atmos\Atmos_debug.sqf at line 21](../../../Src/host/Atmos/Atmos_debug.sqf#L21)
## atmos_debug_renderUpdate

Type: function

Description: 


File: [host\Atmos\Atmos_debug.sqf at line 47](../../../Src/host/Atmos/Atmos_debug.sqf#L47)
## atmos_debug_renderVisual

Type: function

Description: 


File: [host\Atmos\Atmos_debug.sqf at line 52](../../../Src/host/Atmos/Atmos_debug.sqf#L52)
## atmos_debug_enableRender

Type: function

Description: 


File: [host\Atmos\Atmos_debug.sqf at line 125](../../../Src/host/Atmos/Atmos_debug.sqf#L125)
## atmos_debug_currentHelper

Type: function

Description: 


File: [host\Atmos\Atmos_debug.sqf at line 130](../../../Src/host/Atmos/Atmos_debug.sqf#L130)
## atmos_debug_renderCurrentUpdate

Type: function

Description: 


File: [host\Atmos\Atmos_debug.sqf at line 168](../../../Src/host/Atmos/Atmos_debug.sqf#L168)
## atmos_debug_cleanupCurrentHelper

Type: function

Description: 


File: [host\Atmos\Atmos_debug.sqf at line 232](../../../Src/host/Atmos/Atmos_debug.sqf#L232)
# Atmos_init.sqf

## ASP_USE_NAMED_REGION

Type: constant

Description: 


Replaced value:
```sqf

```
File: [host\Atmos\Atmos_init.sqf at line 262](../../../Src/host/Atmos/Atmos_init.sqf#L262)
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
File: [host\Atmos\Atmos_init.sqf at line 265](../../../Src/host/Atmos/Atmos_init.sqf#L265)
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
File: [host\Atmos\Atmos_init.sqf at line 267](../../../Src/host/Atmos/Atmos_init.sqf#L267)
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
## atmos_areaPtrRefPool

Type: Variable

Description: 


Initial value:
```sqf
["AtmosAreaRefPool"] call SafeReference_CreatePool
```
File: [host\Atmos\Atmos_init.sqf at line 38](../../../Src/host/Atmos/Atmos_init.sqf#L38)
## atmos_imap_process_t

Type: Variable

Description: 


Initial value:
```sqf
createHashMapFromArray [...
```
File: [host\Atmos\Atmos_init.sqf at line 246](../../../Src/host/Atmos/Atmos_init.sqf#L246)
## atmos_internal_handleUpdate

Type: Variable

Description: ----- main update handle -------


Initial value:
```sqf
startUpdate(atmos_internal_onUpdate,ATMOS_MAIN_THREAD_UPDATE_DELAY)
```
File: [host\Atmos\Atmos_init.sqf at line 353](../../../Src/host/Atmos/Atmos_init.sqf#L353)
## atmos_cv_ca

Type: Variable

Description: small optimizations


Initial value:
```sqf
["canActivity"]
```
File: [host\Atmos\Atmos_init.sqf at line 257](../../../Src/host/Atmos/Atmos_init.sqf#L257)
## atmos_cv_goch

Type: Variable

Description: 


Initial value:
```sqf
["getObjectsInChunk"]
```
File: [host\Atmos\Atmos_init.sqf at line 258](../../../Src/host/Atmos/Atmos_init.sqf#L258)
## atmos_cv_oa

Type: Variable

Description: 


Initial value:
```sqf
["onActivity"]
```
File: [host\Atmos\Atmos_init.sqf at line 259](../../../Src/host/Atmos/Atmos_init.sqf#L259)
## atmos_cv_tupd

Type: Variable

Description: 


Initial value:
```sqf
["onTemperatureUpdate"]
```
File: [host\Atmos\Atmos_init.sqf at line 260](../../../Src/host/Atmos/Atmos_init.sqf#L260)
## atmos_getChunkAtChId

Type: function

Description: returns chunk by id, creates new if not exists
- Param: _chId

File: [host\Atmos\Atmos_init.sqf at line 41](../../../Src/host/Atmos/Atmos_init.sqf#L41)
## atmos_getChunkAtChIdUnsafe

Type: function

Description: returns chunk by id
- Param: _chId

File: [host\Atmos\Atmos_init.sqf at line 58](../../../Src/host/Atmos/Atmos_init.sqf#L58)
## atmos_getAreaAtAid

Type: function

Description: returns area by id
- Param: _aid

File: [host\Atmos\Atmos_init.sqf at line 66](../../../Src/host/Atmos/Atmos_init.sqf#L66)
## atmos_rpc_requestGetArea

Type: function

Description: обработка запроса зоны от клиента
- Param: _cli
- Param: _ar
- Param: _lastUpd

File: [host\Atmos\Atmos_init.sqf at line 77](../../../Src/host/Atmos/Atmos_init.sqf#L77)
## atmos_internal_generatePacket

Type: function

Description: 
- Param: _packet
- Param: _chObjList
- Param: _lastUpd

File: [host\Atmos\Atmos_init.sqf at line 101](../../../Src/host/Atmos/Atmos_init.sqf#L101)
## atmos_rpc_validateExpiredChunks

Type: function

Description: 
- Param: _cli
- Param: _ar
- Param: _listIds

File: [host\Atmos\Atmos_init.sqf at line 110](../../../Src/host/Atmos/Atmos_init.sqf#L110)
## atmos_onUpdateAreaByChunk

Type: function

Description: 
- Param: _chObj

File: [host\Atmos\Atmos_init.sqf at line 132](../../../Src/host/Atmos/Atmos_init.sqf#L132)
## atmos_transferBuffer

Type: function

> Exists if **ATMOS_USE_UPDATE_BUFFER** defined

Description: 
- Param: _aDat

File: [host\Atmos\Atmos_init.sqf at line 167](../../../Src/host/Atmos/Atmos_init.sqf#L167)
## atmos_onUnsubscribeClientListening

Type: function

Description: 
- Param: _cli
- Param: _aId

File: [host\Atmos\Atmos_init.sqf at line 191](../../../Src/host/Atmos/Atmos_init.sqf#L191)
## atmos_unsubscribeClientListeningSrv

Type: function

Description: 
- Param: _cli

File: [host\Atmos\Atmos_init.sqf at line 207](../../../Src/host/Atmos/Atmos_init.sqf#L207)
## atmos_createProcess

Type: function

Description: create new process inside chunk
- Param: _pos
- Param: _procType
- Param: _manualCreate (optional, default false)
- Param: _paramsInit (optional, default null)

File: [host\Atmos\Atmos_init.sqf at line 220](../../../Src/host/Atmos/Atmos_init.sqf#L220)
## atmos_internal_onUpdate

Type: function

Description: 


File: [host\Atmos\Atmos_init.sqf at line 270](../../../Src/host/Atmos/Atmos_init.sqf#L270)
## atmos_internal_generateChunkGetCode

Type: function

Description: what this?..
- Param: _bch

File: [host\Atmos\Atmos_init.sqf at line 358](../../../Src/host/Atmos/Atmos_init.sqf#L358)
# Atmos_raycasts.sqf

## ATMOS_EXTENDED_INTERSECTION_COUNT

Type: constant

Description: расширенное количество отбрасываемых лучей


Replaced value:
```sqf

```
File: [host\Atmos\Atmos_raycasts.sqf at line 158](../../../Src/host/Atmos/Atmos_raycasts.sqf#L158)
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
File: [host\Atmos\Atmos_raycasts.sqf at line 271](../../../Src/host/Atmos/Atmos_raycasts.sqf#L271)
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
File: [host\Atmos\Atmos_raycasts.sqf at line 278](../../../Src/host/Atmos/Atmos_raycasts.sqf#L278)
## exitMethod

Type: constant

> Exists if **ATMOS_DEBUG_DRAW_INTERSECT_INFO** defined

Description: 


Replaced value:
```sqf
then
```
File: [host\Atmos\Atmos_raycasts.sqf at line 284](../../../Src/host/Atmos/Atmos_raycasts.sqf#L284)
## setupValue(v)

Type: constant

> Exists if **ATMOS_DEBUG_DRAW_INTERSECT_INFO** defined

Description: 
- Param: v

Replaced value:
```sqf
if (!_valueSetupGet) then {v}
```
File: [host\Atmos\Atmos_raycasts.sqf at line 285](../../../Src/host/Atmos/Atmos_raycasts.sqf#L285)
## ATMOS_DEBUG_DRAW_INTERSECT_SPHERE

Type: constant

> Exists if **ATMOS_DEBUG_DRAW_INTERSECT_INFO** not defined

Description: 


Replaced value:
```sqf

```
File: [host\Atmos\Atmos_raycasts.sqf at line 288](../../../Src/host/Atmos/Atmos_raycasts.sqf#L288)
## exitMethod

Type: constant

> Exists if **ATMOS_DEBUG_DRAW_INTERSECT_INFO** not defined

Description: 


Replaced value:
```sqf
exitWith
```
File: [host\Atmos\Atmos_raycasts.sqf at line 289](../../../Src/host/Atmos/Atmos_raycasts.sqf#L289)
## setupValue(v)

Type: constant

> Exists if **ATMOS_DEBUG_DRAW_INTERSECT_INFO** not defined

Description: 
- Param: v

Replaced value:
```sqf
v
```
File: [host\Atmos\Atmos_raycasts.sqf at line 290](../../../Src/host/Atmos/Atmos_raycasts.sqf#L290)
## NORMALIZE_VEC(l,r,i)

Type: constant

Description: 
- Param: l
- Param: r
- Param: i

Replaced value:
```sqf
ifcheck((l select i)>(r select i),vec2(r select i call atmos_coordToId,l select i call atmos_coordToId),vec2(l select i call atmos_coordToId,r select i call atmos_coordToId))
```
File: [host\Atmos\Atmos_raycasts.sqf at line 366](../../../Src/host/Atmos/Atmos_raycasts.sqf#L366)
## atmos_const_lineVectors

Type: Variable

Description: 


Initial value:
```sqf
call atmos_getVectorsChunkInfo
```
File: [host\Atmos\Atmos_raycasts.sqf at line 89](../../../Src/host/Atmos/Atmos_raycasts.sqf#L89)
## atmos_getVectorsChunkInfo

Type: function

Description: генератор лучей для отлова объектов в границах чанка


File: [host\Atmos\Atmos_raycasts.sqf at line 15](../../../Src/host/Atmos/Atmos_raycasts.sqf#L15)
## atmos_chunkGetNearObjects

Type: function

Description: получает все объекты, находящиеся в чанке (объекты находящиеся частично в чанке так же будут получены)
- Param: _fromCh
- Param: _fromChObj

File: [host\Atmos\Atmos_raycasts.sqf at line 92](../../../Src/host/Atmos/Atmos_raycasts.sqf#L92)
## atmos_getObjectsInChunk

Type: function

Description: собирает объекты попавшие в границы чанка. бросает (count atmos_const_lineVectors) на каждой грани для поиска объектов
- Param: _fromCh

File: [host\Atmos\Atmos_raycasts.sqf at line 130](../../../Src/host/Atmos/Atmos_raycasts.sqf#L130)
## atmos_getIntersectPosList

Type: function

Description: возвращает точки входа и конца пересечений. данная функция используется для запроса пересечений
- Param: _chId
- Param: _side
- Param: _fromPos (optional, default true)

File: [host\Atmos\Atmos_raycasts.sqf at line 161](../../../Src/host/Atmos/Atmos_raycasts.sqf#L161)
## atmos_getIntersectInfo

Type: function

Description: 
- Param: _fromCh
- Param: _side
- Param: _searchMode (optional, default ATMOS_SEARCH_MODE_GET_COUNT)
- Param: _refOutPos

File: [host\Atmos\Atmos_raycasts.sqf at line 254](../../../Src/host/Atmos/Atmos_raycasts.sqf#L254)
## atmos_getObjectOwnedChunks

Type: function

Description: 
- Param: _obj
- Param: _retChObj (optional, default false)
- Param: _retOnlyExists (optional, default false)

File: [host\Atmos\Atmos_raycasts.sqf at line 351](../../../Src/host/Atmos/Atmos_raycasts.sqf#L351)
# Atmos_shared.sqf

## atmos_chunkPosToId

Type: function

Description: convert world postion to virtual chunk id
- Param: _x
- Param: _y
- Param: _z

File: [host\Atmos\Atmos_shared.sqf at line 9](../../../Src/host/Atmos/Atmos_shared.sqf#L9)
## atmos_coordToId

Type: function

Description: 


File: [host\Atmos\Atmos_shared.sqf at line 19](../../../Src/host/Atmos/Atmos_shared.sqf#L19)
## atmos_chunkIdToPos

Type: function

Description: returns center atl pos of chunk
- Param: _iX
- Param: _iY
- Param: _iZ

File: [host\Atmos\Atmos_shared.sqf at line 22](../../../Src/host/Atmos/Atmos_shared.sqf#L22)
## atmos_getAreaIdByPos

Type: function

Description: returns area id by world position
- Param: _x
- Param: _y
- Param: _z

File: [host\Atmos\Atmos_shared.sqf at line 33](../../../Src/host/Atmos/Atmos_shared.sqf#L33)
## atmos_getPosByAreaId

Type: function

Description: returns world pos by areaid
- Param: _x
- Param: _y
- Param: _z

File: [host\Atmos\Atmos_shared.sqf at line 43](../../../Src/host/Atmos/Atmos_shared.sqf#L43)
## atmos_getLocalChunkIdInArea

Type: function

Description: Получение локального айди чанка для зоны
- Param: _chunkX
- Param: _chunkY
- Param: _chunkZ

File: [host\Atmos\Atmos_shared.sqf at line 53](../../../Src/host/Atmos/Atmos_shared.sqf#L53)
## atmos_localChunkIdToGlobal

Type: function

Description: Возвращает айди чанка по зоне
- Param: _arId
- Param: _locChId

File: [host\Atmos\Atmos_shared.sqf at line 69](../../../Src/host/Atmos/Atmos_shared.sqf#L69)
## atmos_chunkIdToAreaId

Type: function

Description: Преобразование айдичанка в айдизону
- Param: _iX
- Param: _iY
- Param: _iZ

File: [host\Atmos\Atmos_shared.sqf at line 94](../../../Src/host/Atmos/Atmos_shared.sqf#L94)
## atmos_getAroundAreas

Type: function

Description: 
- Param: _curAr

File: [host\Atmos\Atmos_shared.sqf at line 115](../../../Src/host/Atmos/Atmos_shared.sqf#L115)
## atmos_encodeChId

Type: function

Description: ! only for local chunk pos
- Param: _x
- Param: _y
- Param: _z

File: [host\Atmos\Atmos_shared.sqf at line 137](../../../Src/host/Atmos/Atmos_shared.sqf#L137)
## atmos_decodeChId

Type: function

Description: ! returns local chunk pos
- Param: _id

File: [host\Atmos\Atmos_shared.sqf at line 143](../../../Src/host/Atmos/Atmos_shared.sqf#L143)
## atmos_decodeChIdAt

Type: function

Description: 
- Param: _id
- Param: _posIdx

File: [host\Atmos\Atmos_shared.sqf at line 152](../../../Src/host/Atmos/Atmos_shared.sqf#L152)
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
