# NOEngineClient.h

## PACKET_LIFETIME

Type: constant

Description: 


Replaced value:
```sqf
15
```
File: [client\NOEngineClient\NOEngineClient.h at line 14](../../../Src/client/NOEngineClient/NOEngineClient.h#L14)
## pushPacketId(id)

Type: constant

Description: 
- Param: id

Replaced value:
```sqf
noe_client_packets pushBack id
```
File: [client\NOEngineClient\NOEngineClient.h at line 17](../../../Src/client/NOEngineClient/NOEngineClient.h#L17)
## popPacketId(id)

Type: constant

Description: 
- Param: id

Replaced value:
```sqf
call{ private _idx = noe_client_packets find id; \
	if (_idx!=-1) then { \
		noe_client_packets deleteAt _idx; \
		noe_client_packetsChunks deleteAt (str id); \
		true} else {false}}
```
File: [client\NOEngineClient\NOEngineClient.h at line 19](../../../Src/client/NOEngineClient/NOEngineClient.h#L19)
## chunk_loadingState

Type: constant

Description: 


Replaced value:
```sqf
0
```
File: [client\NOEngineClient\NOEngineClient.h at line 28](../../../Src/client/NOEngineClient/NOEngineClient.h#L28)
## chunk_lastupdate

Type: constant

Description: 


Replaced value:
```sqf
1  
```
File: [client\NOEngineClient\NOEngineClient.h at line 29](../../../Src/client/NOEngineClient/NOEngineClient.h#L29)
## chunk_objectsData

Type: constant

Description: 


Replaced value:
```sqf
2
```
File: [client\NOEngineClient\NOEngineClient.h at line 30](../../../Src/client/NOEngineClient/NOEngineClient.h#L30)
## chunk_name

Type: constant

Description: 


Replaced value:
```sqf
3
```
File: [client\NOEngineClient\NOEngineClient.h at line 31](../../../Src/client/NOEngineClient/NOEngineClient.h#L31)
## chunk_progress

Type: constant

Description: 


Replaced value:
```sqf
4
```
File: [client\NOEngineClient\NOEngineClient.h at line 32](../../../Src/client/NOEngineClient/NOEngineClient.h#L32)
## chunk_lastdelete

Type: constant

Description: 


Replaced value:
```sqf
5
```
File: [client\NOEngineClient\NOEngineClient.h at line 33](../../../Src/client/NOEngineClient/NOEngineClient.h#L33)
## CHUNK_STATE_NOT_LOADED

Type: constant

Description: 


Replaced value:
```sqf
0
```
File: [client\NOEngineClient\NOEngineClient.h at line 37](../../../Src/client/NOEngineClient/NOEngineClient.h#L37)
## CHUNK_STATE_AWAIT_RESPONSE

Type: constant

Description: 


Replaced value:
```sqf
1
```
File: [client\NOEngineClient\NOEngineClient.h at line 38](../../../Src/client/NOEngineClient/NOEngineClient.h#L38)
## CHUNK_STATE_LOADED

Type: constant

Description: 


Replaced value:
```sqf
2
```
File: [client\NOEngineClient\NOEngineClient.h at line 39](../../../Src/client/NOEngineClient/NOEngineClient.h#L39)
## CHUNK_PROGRESS_NOTLOADED

Type: constant

Description: 


Replaced value:
```sqf
0
```
File: [client\NOEngineClient\NOEngineClient.h at line 43](../../../Src/client/NOEngineClient/NOEngineClient.h#L43)
## CHUNK_PROGRESS_PROCESSED

Type: constant

Description: 


Replaced value:
```sqf
1
```
File: [client\NOEngineClient\NOEngineClient.h at line 44](../../../Src/client/NOEngineClient/NOEngineClient.h#L44)
## CHUNK_PROGRESS_LOADED

Type: constant

Description: 


Replaced value:
```sqf
2
```
File: [client\NOEngineClient\NOEngineClient.h at line 45](../../../Src/client/NOEngineClient/NOEngineClient.h#L45)
## allocChunk(data)

Type: constant

Description: 
- Param: data

Replaced value:
```sqf
[CHUNK_STATE_NOT_LOADED,0,createHashMap,data,CHUNK_PROGRESS_NOTLOADED,0]
```
File: [client\NOEngineClient\NOEngineClient.h at line 50](../../../Src/client/NOEngineClient/NOEngineClient.h#L50)
## registerChunk(ch,pos,buf)

Type: constant

Description: 
- Param: ch
- Param: pos
- Param: buf

Replaced value:
```sqf
ch set [pos,buf]
```
File: [client\NOEngineClient\NOEngineClient.h at line 53](../../../Src/client/NOEngineClient/NOEngineClient.h#L53)
## getChunkStorage(type)

Type: constant

Description: 
- Param: type

Replaced value:
```sqf
(noe_client_cs get type)
```
File: [client\NOEngineClient\NOEngineClient.h at line 56](../../../Src/client/NOEngineClient/NOEngineClient.h#L56)
## getChunk(chs,pos)

Type: constant

Description: 
- Param: chs
- Param: pos

Replaced value:
```sqf
(chs get (pos))
```
File: [client\NOEngineClient\NOEngineClient.h at line 56](../../../Src/client/NOEngineClient/NOEngineClient.h#L56)
## getChunkData(pos,type)

Type: constant

Description: 
- Param: pos
- Param: type

Replaced value:
```sqf
getChunk(getChunkStorage(type),str pos)
```
File: [client\NOEngineClient\NOEngineClient.h at line 62](../../../Src/client/NOEngineClient/NOEngineClient.h#L62)
## initChunkData(type,pos,alloc)

Type: constant

Description: 
- Param: type
- Param: pos
- Param: alloc

Replaced value:
```sqf
getChunkStorage(type) set [str pos,alloc]
```
File: [client\NOEngineClient\NOEngineClient.h at line 64](../../../Src/client/NOEngineClient/NOEngineClient.h#L64)
## chunk_setLoadingState(chunk,state)

Type: constant

Description: 
- Param: chunk
- Param: state

Replaced value:
```sqf
(chunk) set [chunk_loadingState,state]
```
File: [client\NOEngineClient\NOEngineClient.h at line 67](../../../Src/client/NOEngineClient/NOEngineClient.h#L67)
## chunk_getLoadingState(chunk)

Type: constant

Description: 
- Param: chunk

Replaced value:
```sqf
((chunk) select chunk_loadingState)
```
File: [client\NOEngineClient\NOEngineClient.h at line 69](../../../Src/client/NOEngineClient/NOEngineClient.h#L69)
## chunk_getLastTicktimeUpdate(chunk)

Type: constant

Description: 
- Param: chunk

Replaced value:
```sqf
((chunk) select chunk_lastupdate)
```
File: [client\NOEngineClient\NOEngineClient.h at line 72](../../../Src/client/NOEngineClient/NOEngineClient.h#L72)
## chunk_setLastTicktimeUpdate(chunk,time)

Type: constant

Description: 
- Param: chunk
- Param: time

Replaced value:
```sqf
(chunk) set [chunk_lastupdate,time]
```
File: [client\NOEngineClient\NOEngineClient.h at line 74](../../../Src/client/NOEngineClient/NOEngineClient.h#L74)
## chunk_getObjectsData(chunk)

Type: constant

Description: 
- Param: chunk

Replaced value:
```sqf
((chunk) select chunk_objectsData)
```
File: [client\NOEngineClient\NOEngineClient.h at line 77](../../../Src/client/NOEngineClient/NOEngineClient.h#L77)
## chunk_objectData_ptr

Type: constant

Description: указатель на модель


Replaced value:
```sqf
0
```
File: [client\NOEngineClient\NOEngineClient.h at line 81](../../../Src/client/NOEngineClient/NOEngineClient.h#L81)
## chunk_objectData_transform

Type: constant

Description: полные данные объекта


Replaced value:
```sqf
1
```
File: [client\NOEngineClient\NOEngineClient.h at line 83](../../../Src/client/NOEngineClient/NOEngineClient.h#L83)
## chunk_getName(chunk)

Type: constant

Description: 
- Param: chunk

Replaced value:
```sqf
((chunk) select chunk_name)
```
File: [client\NOEngineClient\NOEngineClient.h at line 87](../../../Src/client/NOEngineClient/NOEngineClient.h#L87)
## chunk_getProgress(chunk)

Type: constant

Description: 
- Param: chunk

Replaced value:
```sqf
((chunk) select chunk_progress)
```
File: [client\NOEngineClient\NOEngineClient.h at line 90](../../../Src/client/NOEngineClient/NOEngineClient.h#L90)
## chunk_setProgress(chunk,state)

Type: constant

Description: 
- Param: chunk
- Param: state

Replaced value:
```sqf
(chunk) set [chunk_progress,state]
```
File: [client\NOEngineClient\NOEngineClient.h at line 92](../../../Src/client/NOEngineClient/NOEngineClient.h#L92)
## chunk_getLastTicktimeDelete(chunk)

Type: constant

Description: 
- Param: chunk

Replaced value:
```sqf
((chunk) select chunk_lastdelete)
```
File: [client\NOEngineClient\NOEngineClient.h at line 95](../../../Src/client/NOEngineClient/NOEngineClient.h#L95)
## chunk_setLastTicktimeDelete(chunk,time)

Type: constant

Description: 
- Param: chunk
- Param: time

Replaced value:
```sqf
(chunk) set [chunk_lastdelete,time]
```
File: [client\NOEngineClient\NOEngineClient.h at line 97](../../../Src/client/NOEngineClient/NOEngineClient.h#L97)
## chunk_parseNameToPosAndType(ch)

Type: constant

Description: 
- Param: ch

Replaced value:
```sqf
(parseSimpleArray (ch))
```
File: [client\NOEngineClient\NOEngineClient.h at line 100](../../../Src/client/NOEngineClient/NOEngineClient.h#L100)
## newODataStorage(data)

Type: constant

Description: 
- Param: data

Replaced value:
```sqf
[objnull,data]
```
File: [client\NOEngineClient\NOEngineClient.h at line 103](../../../Src/client/NOEngineClient/NOEngineClient.h#L103)
## stdDelayDelete()

Type: constant

Description: 
- Param: 

Replaced value:
```sqf
uiSleep (2 / diag_fps)
```
File: [client\NOEngineClient\NOEngineClient.h at line 107](../../../Src/client/NOEngineClient/NOEngineClient.h#L107)
# NOEngineClientInit.sqf

## variable_name_prevchunk

Type: constant

Description: _t = tickTime;


Replaced value:
```sqf
"pch"
```
File: [client\NOEngineClient\NOEngineClientInit.sqf at line 169](../../../Src/client/NOEngineClient/NOEngineClientInit.sqf#L169)
## noe_debug_allthreads

Type: Variable

Description: 


Initial value:
```sqf
null
```
File: [client\NOEngineClient\NOEngineClientInit.sqf at line 46](../../../Src/client/NOEngineClient/NOEngineClientInit.sqf#L46)
## noe_debug_allthreads

Type: Variable

> Exists if **NOE_CLIENT_THREAD_DEBUG** defined

Description: 


Initial value:
```sqf
[]
```
File: [client\NOEngineClient\NOEngineClientInit.sqf at line 49](../../../Src/client/NOEngineClient/NOEngineClientInit.sqf#L49)
## noe_client_cs

Type: Variable

Description: 


Initial value:
```sqf
createHashMap
```
File: [client\NOEngineClient\NOEngineClientInit.sqf at line 53](../../../Src/client/NOEngineClient/NOEngineClientInit.sqf#L53)
## noe_client_allChunkTypes

Type: Variable

Description: 


Initial value:
```sqf
[CHUNK_TYPE_ITEM,CHUNK_TYPE_STRUCTURE,CHUNK_TYPE_DECOR]
```
File: [client\NOEngineClient\NOEngineClientInit.sqf at line 55](../../../Src/client/NOEngineClient/NOEngineClientInit.sqf#L55)
## noe_client_packetId

Type: Variable

Description: 


Initial value:
```sqf
0
```
File: [client\NOEngineClient\NOEngineClientInit.sqf at line 68](../../../Src/client/NOEngineClient/NOEngineClientInit.sqf#L68)
## noe_client_packets

Type: Variable

Description: 


Initial value:
```sqf
[]
```
File: [client\NOEngineClient\NOEngineClientInit.sqf at line 70](../../../Src/client/NOEngineClient/NOEngineClientInit.sqf#L70)
## noe_client_packetsChunks

Type: Variable

Description: 


Initial value:
```sqf
createHashMap
```
File: [client\NOEngineClient\NOEngineClientInit.sqf at line 72](../../../Src/client/NOEngineClient/NOEngineClientInit.sqf#L72)
## noe_client_allPointers

Type: Variable

Description: 


Initial value:
```sqf
createHashMap
```
File: [client\NOEngineClient\NOEngineClientInit.sqf at line 75](../../../Src/client/NOEngineClient/NOEngineClientInit.sqf#L75)
## noe_client_set_lockedPropUpdates

Type: Variable

Description: 


Initial value:
```sqf
createHashMap //список блокировки обновления визуального состояния объекта
```
File: [client\NOEngineClient\NOEngineClientInit.sqf at line 78](../../../Src/client/NOEngineClient/NOEngineClientInit.sqf#L78)
## noe_client_handlers

Type: Variable

Description: 


Initial value:
```sqf
[]
```
File: [client\NOEngineClient\NOEngineClientInit.sqf at line 81](../../../Src/client/NOEngineClient/NOEngineClientInit.sqf#L81)
## noe_client_generateStorage

Type: function

Description: 


File: [client\NOEngineClient\NOEngineClientInit.sqf at line 59](../../../Src/client/NOEngineClient/NOEngineClientInit.sqf#L59)
## noe_client_startListening

Type: function

Description: 


File: [client\NOEngineClient\NOEngineClientInit.sqf at line 85](../../../Src/client/NOEngineClient/NOEngineClientInit.sqf#L85)
## noe_client_isEnabled

Type: function

Description: 


File: [client\NOEngineClient\NOEngineClientInit.sqf at line 94](../../../Src/client/NOEngineClient/NOEngineClientInit.sqf#L94)
## noe_client_stopListening

Type: function

Description: 
- Param: _mob

File: [client\NOEngineClient\NOEngineClientInit.sqf at line 97](../../../Src/client/NOEngineClient/NOEngineClientInit.sqf#L97)
## noe_client_unloadAllChunks

Type: function

Description: 
- Param: _mob

File: [client\NOEngineClient\NOEngineClientInit.sqf at line 120](../../../Src/client/NOEngineClient/NOEngineClientInit.sqf#L120)
## noe_client_onUpdate

Type: function

Description: 
- Param: _mob
- Param: _chunkType

File: [client\NOEngineClient\NOEngineClientInit.sqf at line 158](../../../Src/client/NOEngineClient/NOEngineClientInit.sqf#L158)
# NOEngineClient_AtmosOptimizer.sqf

## aopt_cli_enableSystem

Type: Variable

Description: 


Initial value:
```sqf
!false
```
File: [client\NOEngineClient\NOEngineClient_AtmosOptimizer.sqf at line 14](../../../Src/client/NOEngineClient/NOEngineClient_AtmosOptimizer.sqf#L14)
## aopt_cli_handler

Type: Variable

Description: 


Initial value:
```sqf
-1
```
File: [client\NOEngineClient\NOEngineClient_AtmosOptimizer.sqf at line 17](../../../Src/client/NOEngineClient/NOEngineClient_AtmosOptimizer.sqf#L17)
## aopt_cli_thd

Type: Variable

Description: aopt_cli_handler = startUpdate(aopt_cli_process,0.1);


Initial value:
```sqf
threadNull
```
File: [client\NOEngineClient\NOEngineClient_AtmosOptimizer.sqf at line 19](../../../Src/client/NOEngineClient/NOEngineClient_AtmosOptimizer.sqf#L19)
## aopt_cli_lastUpd

Type: Variable

Description: 


Initial value:
```sqf
0
```
File: [client\NOEngineClient\NOEngineClient_AtmosOptimizer.sqf at line 21](../../../Src/client/NOEngineClient/NOEngineClient_AtmosOptimizer.sqf#L21)
## aopt_cli_prevCallTime

Type: Variable

Description: 


Initial value:
```sqf
0
```
File: [client\NOEngineClient\NOEngineClient_AtmosOptimizer.sqf at line 23](../../../Src/client/NOEngineClient/NOEngineClient_AtmosOptimizer.sqf#L23)
## aopt_cli_culledCnt

Type: Variable

Description: criticalSectionEnd


Initial value:
```sqf
0 //отсеченные по видимости на буфере глубины
```
File: [client\NOEngineClient\NOEngineClient_AtmosOptimizer.sqf at line 26](../../../Src/client/NOEngineClient/NOEngineClient_AtmosOptimizer.sqf#L26)
## aopt_cli_gbuffCull

Type: Variable

Description: 


Initial value:
```sqf
0 //отсеченные по видимости на буфере геометрии
```
File: [client\NOEngineClient\NOEngineClient_AtmosOptimizer.sqf at line 28](../../../Src/client/NOEngineClient/NOEngineClient_AtmosOptimizer.sqf#L28)
## aopt_cli_debug_listobs

Type: Variable

Description: 


Initial value:
```sqf
[]
```
File: [client\NOEngineClient\NOEngineClient_AtmosOptimizer.sqf at line 246](../../../Src/client/NOEngineClient/NOEngineClient_AtmosOptimizer.sqf#L246)
## aopt_cli_debug_thread

Type: Variable

Description: 


Initial value:
```sqf
threadNull
```
File: [client\NOEngineClient\NOEngineClient_AtmosOptimizer.sqf at line 248](../../../Src/client/NOEngineClient/NOEngineClient_AtmosOptimizer.sqf#L248)
## aopt_cli_thd

Type: Variable

> Exists if **NET_ATMOS_OPTIMIZATION_RENDER** defined

Description: 


Initial value:
```sqf
threadStart(threadNew(_looped))
```
File: [client\NOEngineClient\NOEngineClient_AtmosOptimizer.sqf at line 308](../../../Src/client/NOEngineClient/NOEngineClient_AtmosOptimizer.sqf#L308)
## aopt_cli_process

Type: function

Description: 


File: [client\NOEngineClient\NOEngineClient_AtmosOptimizer.sqf at line 31](../../../Src/client/NOEngineClient/NOEngineClient_AtmosOptimizer.sqf#L31)
## aopt_cli_processZPass

Type: function

Description: 
- Param: _cameraPos
- Param: _cameraDir
- Param: _objects

File: [client\NOEngineClient\NOEngineClient_AtmosOptimizer.sqf at line 119](../../../Src/client/NOEngineClient/NOEngineClient_AtmosOptimizer.sqf#L119)
## aopt_cli_checkOverlapWithZone

Type: function

Description: 
- Param: _screenBoxA
- Param: _screenBoxB

File: [client\NOEngineClient\NOEngineClient_AtmosOptimizer.sqf at line 203](../../../Src/client/NOEngineClient/NOEngineClient_AtmosOptimizer.sqf#L203)
## aopt_cli_checkFullOverlap

Type: function

Description: 
- Param: _screenBoxA
- Param: _screenBoxB

File: [client\NOEngineClient\NOEngineClient_AtmosOptimizer.sqf at line 220](../../../Src/client/NOEngineClient/NOEngineClient_AtmosOptimizer.sqf#L220)
## aopt_cli_testItsc

Type: function

Description: 


File: [client\NOEngineClient\NOEngineClient_AtmosOptimizer.sqf at line 251](../../../Src/client/NOEngineClient/NOEngineClient_AtmosOptimizer.sqf#L251)
# NOEngineClient_chunkDebug.sqf

## upside

Type: constant

Description: 


Replaced value:
```sqf
_size
```
File: [client\NOEngineClient\NOEngineClient_chunkDebug.sqf at line 16](../../../Src/client/NOEngineClient/NOEngineClient_chunkDebug.sqf#L16)
## remap_ch(x,y)

Type: constant

> Exists if **enableDebugDraw** defined

Description: 
- Param: x
- Param: y

Replaced value:
```sqf
[(getPosATL player) vectorAdd [x*_dist,y*_dist],_x] call noe_posToChunk
```
File: [client\NOEngineClient\NOEngineClient_chunkDebug.sqf at line 151](../../../Src/client/NOEngineClient/NOEngineClient_chunkDebug.sqf#L151)
## startSectorIndex

Type: constant

Description: 


Replaced value:
```sqf
1
```
File: [client\NOEngineClient\NOEngineClient_chunkDebug.sqf at line 172](../../../Src/client/NOEngineClient/NOEngineClient_chunkDebug.sqf#L172)
## sectorSize

Type: constant

Description: 


Replaced value:
```sqf
1
```
File: [client\NOEngineClient\NOEngineClient_chunkDebug.sqf at line 174](../../../Src/client/NOEngineClient/NOEngineClient_chunkDebug.sqf#L174)
## noe_debug_canDrawInfo

Type: Variable

Description: 


Initial value:
```sqf
!isNull(enableDebugDrawInfo)
```
File: [client\NOEngineClient\NOEngineClient_chunkDebug.sqf at line 26](../../../Src/client/NOEngineClient/NOEngineClient_chunkDebug.sqf#L26)
## noe_debug_drawChunkSides_player

Type: function

Description: 
- Param: _chunk
- Param: _type
- Param: _color

File: [client\NOEngineClient\NOEngineClient_chunkDebug.sqf at line 29](../../../Src/client/NOEngineClient/NOEngineClient_chunkDebug.sqf#L29)
## noe_debug_drawChunkInfo

Type: function

Description: 
- Param: _chunk
- Param: _type
- Param: _color

File: [client\NOEngineClient\NOEngineClient_chunkDebug.sqf at line 62](../../../Src/client/NOEngineClient/NOEngineClient_chunkDebug.sqf#L62)
## noe_debug_enableDebugDrawChunks

Type: function

Description: 


File: [client\NOEngineClient\NOEngineClient_chunkDebug.sqf at line 122](../../../Src/client/NOEngineClient/NOEngineClient_chunkDebug.sqf#L122)
## noe_debug_sector_redraw

Type: function

Description: 
- Param: _x
- Param: _y
- Param: _z

File: [client\NOEngineClient\NOEngineClient_chunkDebug.sqf at line 177](../../../Src/client/NOEngineClient/NOEngineClient_chunkDebug.sqf#L177)
## noe_debug_drawSectorSides_player

Type: function

Description: 
- Param: _chunk
- Param: _color

File: [client\NOEngineClient\NOEngineClient_chunkDebug.sqf at line 188](../../../Src/client/NOEngineClient/NOEngineClient_chunkDebug.sqf#L188)
## noe_debug_enableDebugDrawSectorsChunks

Type: function

Description: 


File: [client\NOEngineClient\NOEngineClient_chunkDebug.sqf at line 218](../../../Src/client/NOEngineClient/NOEngineClient_chunkDebug.sqf#L218)
# NOEngineClient_Components.sqf

## noe_client_threadList

Type: Variable

Description: 


Initial value:
```sqf
[]
```
File: [client\NOEngineClient\NOEngineClient_Components.sqf at line 51](../../../Src/client/NOEngineClient/NOEngineClient_Components.sqf#L51)
## noe_client_isChunkCreated

Type: function

Description: 
- Param: _chunk
- Param: _type

File: [client\NOEngineClient\NOEngineClient_Components.sqf at line 16](../../../Src/client/NOEngineClient/NOEngineClient_Components.sqf#L16)
## noe_client_GetChunkLastUpdate

Type: function

Description: 


File: [client\NOEngineClient\NOEngineClient_Components.sqf at line 23](../../../Src/client/NOEngineClient/NOEngineClient_Components.sqf#L23)
## noe_client_getPosChunkToData

Type: function

Description: 
- Param: _chunk
- Param: _type

File: [client\NOEngineClient\NOEngineClient_Components.sqf at line 29](../../../Src/client/NOEngineClient/NOEngineClient_Components.sqf#L29)
## noe_client_loadObjects

Type: function

Description: 
- Param: _chunkObject
- Param: _spawnObjList

File: [client\NOEngineClient\NOEngineClient_Components.sqf at line 56](../../../Src/client/NOEngineClient/NOEngineClient_Components.sqf#L56)
## noe_client_isObjectsLoadingDone

Type: function

Description: 
- Param: _chunk

File: [client\NOEngineClient\NOEngineClient_Components.sqf at line 127](../../../Src/client/NOEngineClient/NOEngineClient_Components.sqf#L127)
## noe_client_isPlayerPositionChunksLoaded

Type: function

Description: 


File: [client\NOEngineClient\NOEngineClient_Components.sqf at line 134](../../../Src/client/NOEngineClient/NOEngineClient_Components.sqf#L134)
# NOEngineClient_Interpolation.sqf

## noe_client_defaultInterpTime

Type: Variable

Description: 


Initial value:
```sqf
0.15
```
File: [client\NOEngineClient\NOEngineClient_Interpolation.sqf at line 11](../../../Src/client/NOEngineClient/NOEngineClient_Interpolation.sqf#L11)
## noe_client_interp_processObjInterp

Type: function

Description: 
- Param: _srcObj
- Param: _fromPos
- Param: _fromTransf
- Param: _toPos
- Param: _toTransf
- Param: _time
- Param: _scaleMode (optional, default 0)
- Param: _stdMode (optional, default 0)
- Param: _emuMode (optional, default false)

File: [client\NOEngineClient\NOEngineClient_Interpolation.sqf at line 14](../../../Src/client/NOEngineClient/NOEngineClient_Interpolation.sqf#L14)
## noe_client_interp_start

Type: function

Description: 
- Param: _owner
- Param: _paramsT

File: [client\NOEngineClient\NOEngineClient_Interpolation.sqf at line 144](../../../Src/client/NOEngineClient/NOEngineClient_Interpolation.sqf#L144)
## noe_client_interp_determineTransform

Type: function

Description: 
- Param: _owner
- Param: _data

File: [client\NOEngineClient\NOEngineClient_Interpolation.sqf at line 284](../../../Src/client/NOEngineClient/NOEngineClient_Interpolation.sqf#L284)
## noe_client_interp_interpNet

Type: function

Description: 
- Param: _f
- Param: _t
- Param: _opt

File: [client\NOEngineClient\NOEngineClient_Interpolation.sqf at line 310](../../../Src/client/NOEngineClient/NOEngineClient_Interpolation.sqf#L310)
# NOEngineClient_localAtmos.sqf

## ACLI_TYPE_FIRE

Type: constant

Description: 


Replaced value:
```sqf
["SLIGHT_ATMOS_FIRE_1" call lightSys_getConfigIdByName,"SLIGHT_ATMOS_FIRE_2" call lightSys_getConfigIdByName,"SLIGHT_ATMOS_FIRE_3" call lightSys_getConfigIdByName]
```
File: [client\NOEngineClient\NOEngineClient_localAtmos.sqf at line 17](../../../Src/client/NOEngineClient/NOEngineClient_localAtmos.sqf#L17)
## ACLI_DATA_OBJECTS

Type: constant

Description: 


Replaced value:
```sqf
0
```
File: [client\NOEngineClient\NOEngineClient_localAtmos.sqf at line 20](../../../Src/client/NOEngineClient/NOEngineClient_localAtmos.sqf#L20)
## ACLI_DATA_METAINFO

Type: constant

Description: 


Replaced value:
```sqf
1
```
File: [client\NOEngineClient\NOEngineClient_localAtmos.sqf at line 21](../../../Src/client/NOEngineClient/NOEngineClient_localAtmos.sqf#L21)
## ACLI_DATA_CHUNK_ID

Type: constant

Description: 


Replaced value:
```sqf
2
```
File: [client\NOEngineClient\NOEngineClient_localAtmos.sqf at line 22](../../../Src/client/NOEngineClient/NOEngineClient_localAtmos.sqf#L22)
## __ACLI_NEW_BUFFER_OBJECTS

Type: constant

Description: 


Replaced value:
```sqf
[objNull,objNull]
```
File: [client\NOEngineClient\NOEngineClient_localAtmos.sqf at line 26](../../../Src/client/NOEngineClient/NOEngineClient_localAtmos.sqf#L26)
## __ACLI_NEW_BUFFER_METAINFO

Type: constant

Description: 


Replaced value:
```sqf
0
```
File: [client\NOEngineClient\NOEngineClient_localAtmos.sqf at line 28](../../../Src/client/NOEngineClient/NOEngineClient_localAtmos.sqf#L28)
## __ACLI_NEW_DATA

Type: constant

Description: 


Replaced value:
```sqf
[__ACLI_NEW_BUFFER_OBJECTS,__ACLI_NEW_BUFFER_METAINFO,_chid]
```
File: [client\NOEngineClient\NOEngineClient_localAtmos.sqf at line 30](../../../Src/client/NOEngineClient/NOEngineClient_localAtmos.sqf#L30)
## ACLI_NEW_CHUNK

Type: constant

Description: 


Replaced value:
```sqf
__ACLI_NEW_DATA
```
File: [client\NOEngineClient\NOEngineClient_localAtmos.sqf at line 32](../../../Src/client/NOEngineClient/NOEngineClient_localAtmos.sqf#L32)
## acli_map_chunks

Type: Variable

Description: 


Initial value:
```sqf
createHashMap
```
File: [client\NOEngineClient\NOEngineClient_localAtmos.sqf at line 35](../../../Src/client/NOEngineClient/NOEngineClient_localAtmos.sqf#L35)
## acli_bool_requestUpdate

Type: Variable

Description: 


Initial value:
```sqf
false
```
File: [client\NOEngineClient\NOEngineClient_localAtmos.sqf at line 37](../../../Src/client/NOEngineClient/NOEngineClient_localAtmos.sqf#L37)
## acli_bool_enableSystem

Type: Variable

Description: 


Initial value:
```sqf
false //turn off is won't work
```
File: [client\NOEngineClient\NOEngineClient_localAtmos.sqf at line 39](../../../Src/client/NOEngineClient/NOEngineClient_localAtmos.sqf#L39)
## acli_internal_onUpdate_handle

Type: Variable

Description: 


Initial value:
```sqf
ifcheck(acli_bool_enableSystem,startUpdate(acli_lazyCheck,1),-1)
```
File: [client\NOEngineClient\NOEngineClient_localAtmos.sqf at line 176](../../../Src/client/NOEngineClient/NOEngineClient_localAtmos.sqf#L176)
## acli_handleAddObj

Type: function

Description: 
- Param: _obj
- Param: _cfgId

File: [client\NOEngineClient\NOEngineClient_localAtmos.sqf at line 42](../../../Src/client/NOEngineClient/NOEngineClient_localAtmos.sqf#L42)
## acli_getChunk

Type: function

Description: 
- Param: _chid

File: [client\NOEngineClient\NOEngineClient_localAtmos.sqf at line 93](../../../Src/client/NOEngineClient/NOEngineClient_localAtmos.sqf#L93)
## acli_getChunkUnsafe

Type: function

Description: 
- Param: _chid

File: [client\NOEngineClient\NOEngineClient_localAtmos.sqf at line 105](../../../Src/client/NOEngineClient/NOEngineClient_localAtmos.sqf#L105)
## acli_lazyCheck

Type: function

Description: 


File: [client\NOEngineClient\NOEngineClient_localAtmos.sqf at line 125](../../../Src/client/NOEngineClient/NOEngineClient_localAtmos.sqf#L125)
## acli_getAroundChIDList

Type: function

Description: 
- Param: _chid

File: [client\NOEngineClient\NOEngineClient_localAtmos.sqf at line 179](../../../Src/client/NOEngineClient/NOEngineClient_localAtmos.sqf#L179)
## acli_chunkPosToId

Type: function

Description: 
- Param: _x
- Param: _y
- Param: _z

File: [client\NOEngineClient\NOEngineClient_localAtmos.sqf at line 191](../../../Src/client/NOEngineClient/NOEngineClient_localAtmos.sqf#L191)
## acli_chunkIdToPos

Type: function

Description: 
- Param: _iX
- Param: _iY
- Param: _iZ

File: [client\NOEngineClient\NOEngineClient_localAtmos.sqf at line 203](../../../Src/client/NOEngineClient/NOEngineClient_localAtmos.sqf#L203)
# NOEngineClient_NetAtmos.hpp

## NAT_LOADING_SLIST_STATES

Type: constant

Description: 


Replaced value:
```sqf
["err","not_loading","await_resp","loading","ok"]
```
File: [client\NOEngineClient\NOEngineClient_NetAtmos.hpp at line 18](../../../Src/client/NOEngineClient/NOEngineClient_NetAtmos.hpp#L18)
## NAT_LOADING_STATE_ERROR

Type: constant

Description: 


Replaced value:
```sqf
-1
```
File: [client\NOEngineClient\NOEngineClient_NetAtmos.hpp at line 21](../../../Src/client/NOEngineClient/NOEngineClient_NetAtmos.hpp#L21)
## NAT_LOADING_STATE_NOT_LOADED

Type: constant

Description: 


Replaced value:
```sqf
0
```
File: [client\NOEngineClient\NOEngineClient_NetAtmos.hpp at line 22](../../../Src/client/NOEngineClient/NOEngineClient_NetAtmos.hpp#L22)
## NAT_LOADING_STATE_AWAIT_RESPONE

Type: constant

Description: 


Replaced value:
```sqf
1
```
File: [client\NOEngineClient\NOEngineClient_NetAtmos.hpp at line 23](../../../Src/client/NOEngineClient/NOEngineClient_NetAtmos.hpp#L23)
## NAT_LOADING_STATE_LOADING

Type: constant

Description: 


Replaced value:
```sqf
2
```
File: [client\NOEngineClient\NOEngineClient_NetAtmos.hpp at line 24](../../../Src/client/NOEngineClient/NOEngineClient_NetAtmos.hpp#L24)
## NAT_LOADING_STATE_LOADED

Type: constant

Description: 


Replaced value:
```sqf
3
```
File: [client\NOEngineClient\NOEngineClient_NetAtmos.hpp at line 25](../../../Src/client/NOEngineClient/NOEngineClient_NetAtmos.hpp#L25)
## NAT_CHUNKDAT_CFG

Type: constant

Description: 


Replaced value:
```sqf
0
```
File: [client\NOEngineClient\NOEngineClient_NetAtmos.hpp at line 30](../../../Src/client/NOEngineClient/NOEngineClient_NetAtmos.hpp#L30)
## NAT_CHUNKDAT_OBJECT

Type: constant

Description: 


Replaced value:
```sqf
1
```
File: [client\NOEngineClient\NOEngineClient_NetAtmos.hpp at line 31](../../../Src/client/NOEngineClient/NOEngineClient_NetAtmos.hpp#L31)
## NAT_CHUNKDAT_NEW(cfg)

Type: constant

Description: 
- Param: cfg

Replaced value:
```sqf
[cfg,nil]
```
File: [client\NOEngineClient\NOEngineClient_NetAtmos.hpp at line 35](../../../Src/client/NOEngineClient/NOEngineClient_NetAtmos.hpp#L35)
## NAT_ATMOS_EFFTYPE_FIRE

Type: constant

Description: 


Replaced value:
```sqf
0
```
File: [client\NOEngineClient\NOEngineClient_NetAtmos.hpp at line 38](../../../Src/client/NOEngineClient/NOEngineClient_NetAtmos.hpp#L38)
## NAT_ATMOS_EFFTYPE_SMOKE

Type: constant

Description: 


Replaced value:
```sqf
1
```
File: [client\NOEngineClient\NOEngineClient_NetAtmos.hpp at line 39](../../../Src/client/NOEngineClient/NOEngineClient_NetAtmos.hpp#L39)
## NET_ATMOS_OPTIMIZATION_RENDER

Type: constant

Description: 


Replaced value:
```sqf

```
File: [client\NOEngineClient\NOEngineClient_NetAtmos.hpp at line 44](../../../Src/client/NOEngineClient/NOEngineClient_NetAtmos.hpp#L44)
## ENABLE_OPTIMIZATION

Type: constant

Description: 


Replaced value:
```sqf

```
File: [client\NOEngineClient\NOEngineClient_NetAtmos.hpp at line 51](../../../Src/client/NOEngineClient/NOEngineClient_NetAtmos.hpp#L51)
# NOEngineClient_NetAtmos.sqf

## NOE_NETATMOS_UPDATE_DELAY

Type: constant

Description: 


Replaced value:
```sqf
1
```
File: [client\NOEngineClient\NOEngineClient_NetAtmos.sqf at line 15](../../../Src/client/NOEngineClient/NOEngineClient_NetAtmos.sqf#L15)
## noe_client_nat_handleUpdate

Type: Variable

Description: 


Initial value:
```sqf
-1
```
File: [client\NOEngineClient\NOEngineClient_NetAtmos.sqf at line 20](../../../Src/client/NOEngineClient/NOEngineClient_NetAtmos.sqf#L20)
## noe_client_nat_areas

Type: Variable

Description: 


Initial value:
```sqf
createHashMap
```
File: [client\NOEngineClient\NOEngineClient_NetAtmos.sqf at line 26](../../../Src/client/NOEngineClient/NOEngineClient_NetAtmos.sqf#L26)
## noe_client_nat_prevArea

Type: Variable

Description: update last area


Initial value:
```sqf
null
```
File: [client\NOEngineClient\NOEngineClient_NetAtmos.sqf at line 28](../../../Src/client/NOEngineClient/NOEngineClient_NetAtmos.sqf#L28)
## noe_client_nat_ltCfg_initialized

Type: Variable

Description: 


Initial value:
```sqf
false
```
File: [client\NOEngineClient\NOEngineClient_NetAtmos.sqf at line 31](../../../Src/client/NOEngineClient/NOEngineClient_NetAtmos.sqf#L31)
## noe_client_nat_ltCfg_fire

Type: Variable

Description: 


Initial value:
```sqf
[]
```
File: [client\NOEngineClient\NOEngineClient_NetAtmos.sqf at line 34](../../../Src/client/NOEngineClient/NOEngineClient_NetAtmos.sqf#L34)
## noe_client_nat_ltCfg_smoke

Type: Variable

Description: 


Initial value:
```sqf
[]
```
File: [client\NOEngineClient\NOEngineClient_NetAtmos.sqf at line 36](../../../Src/client/NOEngineClient/NOEngineClient_NetAtmos.sqf#L36)
## noe_client_nat_const_nearList

Type: Variable

Description: 


Initial value:
```sqf
[...
```
File: [client\NOEngineClient\NOEngineClient_NetAtmos.sqf at line 402](../../../Src/client/NOEngineClient/NOEngineClient_NetAtmos.sqf#L402)
## noe_client_nat_isEnabled

Type: function

Description: 


File: [client\NOEngineClient\NOEngineClient_NetAtmos.sqf at line 18](../../../Src/client/NOEngineClient/NOEngineClient_NetAtmos.sqf#L18)
## noe_client_nat_initializeLtCfg

Type: function

Description: 


File: [client\NOEngineClient\NOEngineClient_NetAtmos.sqf at line 39](../../../Src/client/NOEngineClient/NOEngineClient_NetAtmos.sqf#L39)
## noe_client_nat_setEnabled

Type: function

Description: 
- Param: _mode

File: [client\NOEngineClient\NOEngineClient_NetAtmos.sqf at line 53](../../../Src/client/NOEngineClient/NOEngineClient_NetAtmos.sqf#L53)
## noe_client_nat_onUpdate

Type: function

Description: 


File: [client\NOEngineClient\NOEngineClient_NetAtmos.sqf at line 100](../../../Src/client/NOEngineClient/NOEngineClient_NetAtmos.sqf#L100)
## noe_client_nat_getArea

Type: function

Description: 
- Param: _areaId

File: [client\NOEngineClient\NOEngineClient_NetAtmos.sqf at line 142](../../../Src/client/NOEngineClient/NOEngineClient_NetAtmos.sqf#L142)
## noe_client_nat_getAreaUnsafe

Type: function

Description: 
- Param: _areaId

File: [client\NOEngineClient\NOEngineClient_NetAtmos.sqf at line 152](../../../Src/client/NOEngineClient/NOEngineClient_NetAtmos.sqf#L152)
## noe_client_nat_requestLoad

Type: function

Description: 
- Param: _areaObj

File: [client\NOEngineClient\NOEngineClient_NetAtmos.sqf at line 160](../../../Src/client/NOEngineClient/NOEngineClient_NetAtmos.sqf#L160)
## noe_client_nat_requestDelExpired

Type: function

Description: 
- Param: _areaObj
- Param: _newTick

File: [client\NOEngineClient\NOEngineClient_NetAtmos.sqf at line 172](../../../Src/client/NOEngineClient/NOEngineClient_NetAtmos.sqf#L172)
## noe_client_nat_onLoadArea

Type: function

Description: 
- Param: _packet

File: [client\NOEngineClient\NOEngineClient_NetAtmos.sqf at line 186](../../../Src/client/NOEngineClient/NOEngineClient_NetAtmos.sqf#L186)
## noe_client_nat_decodePacket

Type: function

Description: 
- Param: _buff
- Param: _addList
- Param: _remList

File: [client\NOEngineClient\NOEngineClient_NetAtmos.sqf at line 252](../../../Src/client/NOEngineClient/NOEngineClient_NetAtmos.sqf#L252)
## noe_client_nat_loadArea

Type: function

Description: 
- Param: _aObj
- Param: _arrChDat (optional, default [])
- Param: _isUpdateFlag (optional, default false)

File: [client\NOEngineClient\NOEngineClient_NetAtmos.sqf at line 276](../../../Src/client/NOEngineClient/NOEngineClient_NetAtmos.sqf#L276)
## noe_client_nat_procLoad

Type: function

Description: 
- Param: _aObj

File: [client\NOEngineClient\NOEngineClient_NetAtmos.sqf at line 290](../../../Src/client/NOEngineClient/NOEngineClient_NetAtmos.sqf#L290)
## noe_client_nat_procUnload

Type: function

Description: 
- Param: _aObj

File: [client\NOEngineClient\NOEngineClient_NetAtmos.sqf at line 304](../../../Src/client/NOEngineClient/NOEngineClient_NetAtmos.sqf#L304)
## noe_client_nat_procAddEff

Type: function

Description: 
- Param: _aObj
- Param: _ltob

File: [client\NOEngineClient\NOEngineClient_NetAtmos.sqf at line 318](../../../Src/client/NOEngineClient/NOEngineClient_NetAtmos.sqf#L318)
## noe_client_nat_procDelEff

Type: function

Description: 
- Param: _aObj
- Param: _ltob

File: [client\NOEngineClient\NOEngineClient_NetAtmos.sqf at line 328](../../../Src/client/NOEngineClient/NOEngineClient_NetAtmos.sqf#L328)
## noe_client_nat_procUpdEff

Type: function

Description: 
- Param: _aObj
- Param: _ltob

File: [client\NOEngineClient\NOEngineClient_NetAtmos.sqf at line 355](../../../Src/client/NOEngineClient/NOEngineClient_NetAtmos.sqf#L355)
## noe_client_nat_deleteChunks

Type: function

Description: 
- Param: _aObj
- Param: _arrChIds

File: [client\NOEngineClient\NOEngineClient_NetAtmos.sqf at line 374](../../../Src/client/NOEngineClient/NOEngineClient_NetAtmos.sqf#L374)
## noe_client_nat_unloadArea

Type: function

Description: 
- Param: _areaObj

File: [client\NOEngineClient\NOEngineClient_NetAtmos.sqf at line 383](../../../Src/client/NOEngineClient/NOEngineClient_NetAtmos.sqf#L383)
## noe_client_nat_unsubscribeArea

Type: function

Description: 
- Param: _areaObj

File: [client\NOEngineClient\NOEngineClient_NetAtmos.sqf at line 394](../../../Src/client/NOEngineClient/NOEngineClient_NetAtmos.sqf#L394)
## noe_client_nat_nearId

Type: function

Description: 
- Param: _id
- Param: _xyz

File: [client\NOEngineClient\NOEngineClient_NetAtmos.sqf at line 410](../../../Src/client/NOEngineClient/NOEngineClient_NetAtmos.sqf#L410)
## noe_client_getAtmosVirtualLight

Type: function

Description: 
- Param: _pos

File: [client\NOEngineClient\NOEngineClient_NetAtmos.sqf at line 426](../../../Src/client/NOEngineClient/NOEngineClient_NetAtmos.sqf#L426)
## noe_client_getAtmosArea

Type: function

Description: 
- Param: _pos

File: [client\NOEngineClient\NOEngineClient_NetAtmos.sqf at line 439](../../../Src/client/NOEngineClient/NOEngineClient_NetAtmos.sqf#L439)
# NOEngineClient_NetAtmosPerBlockOptimize.sqf

## nat_pbo_threadHandle

Type: Variable

Description: 


Initial value:
```sqf
threadNull
```
File: [client\NOEngineClient\NOEngineClient_NetAtmosPerBlockOptimize.sqf at line 12](../../../Src/client/NOEngineClient/NOEngineClient_NetAtmosPerBlockOptimize.sqf#L12)
## nat_pbo_lastUpd

Type: Variable

Description: 


Initial value:
```sqf
0
```
File: [client\NOEngineClient\NOEngineClient_NetAtmosPerBlockOptimize.sqf at line 15](../../../Src/client/NOEngineClient/NOEngineClient_NetAtmosPerBlockOptimize.sqf#L15)
## nat_pbo_prevCallTime

Type: Variable

Description: 


Initial value:
```sqf
0
```
File: [client\NOEngineClient\NOEngineClient_NetAtmosPerBlockOptimize.sqf at line 17](../../../Src/client/NOEngineClient/NOEngineClient_NetAtmosPerBlockOptimize.sqf#L17)
## nat_pbo_boundingOffsetMin

Type: Variable

Description: 


Initial value:
```sqf
vec3(-ATMOS_SIZE_HALF,-ATMOS_SIZE_HALF,-ATMOS_SIZE_HALF)
```
File: [client\NOEngineClient\NOEngineClient_NetAtmosPerBlockOptimize.sqf at line 20](../../../Src/client/NOEngineClient/NOEngineClient_NetAtmosPerBlockOptimize.sqf#L20)
## nat_pbo_boundingOffsetMax

Type: Variable

Description: 


Initial value:
```sqf
vec3(ATMOS_SIZE_HALF,ATMOS_SIZE_HALF,ATMOS_SIZE_HALF)
```
File: [client\NOEngineClient\NOEngineClient_NetAtmosPerBlockOptimize.sqf at line 22](../../../Src/client/NOEngineClient/NOEngineClient_NetAtmosPerBlockOptimize.sqf#L22)
## nat_pbo_threadHandle

Type: Variable

> Exists if **ENABLE_PERBLOCK_ZPASS_CULLING** defined

Description: 


Initial value:
```sqf
threadStart(threadNew(_looped))
```
File: [client\NOEngineClient\NOEngineClient_NetAtmosPerBlockOptimize.sqf at line 70](../../../Src/client/NOEngineClient/NOEngineClient_NetAtmosPerBlockOptimize.sqf#L70)
## nat_pbo_renderThread

Type: function

Description: 


File: [client\NOEngineClient\NOEngineClient_NetAtmosPerBlockOptimize.sqf at line 25](../../../Src/client/NOEngineClient/NOEngineClient_NetAtmosPerBlockOptimize.sqf#L25)
## nat_pbo_cullProc

Type: function

Description: 
- Param: _vlight
- Param: _isVisible

File: [client\NOEngineClient\NOEngineClient_NetAtmosPerBlockOptimize.sqf at line 62](../../../Src/client/NOEngineClient/NOEngineClient_NetAtmosPerBlockOptimize.sqf#L62)
# NOEngineClient_NetAtmos_structs.sqf

## ENABLE_RANDOMIZATION_COLOR

Type: constant

Description: 


Replaced value:
```sqf

```
File: [client\NOEngineClient\NOEngineClient_NetAtmos_structs.sqf at line 73](../../../Src/client/NOEngineClient/NOEngineClient_NetAtmos_structs.sqf#L73)
# NOEngineClient_NOGEOM_ext.sqf

## NGOExt_create

Type: function

Description: 
- Param: _obj
- Param: _vec
- Param: _imode (optional, default false)

File: [client\NOEngineClient\NOEngineClient_NOGEOM_ext.sqf at line 25](../../../Src/client/NOEngineClient/NOEngineClient_NOGEOM_ext.sqf#L25)
## NGOExt_createSoftlink

Type: function

Description: 
- Param: _srcWorldObj
- Param: _target

File: [client\NOEngineClient\NOEngineClient_NOGEOM_ext.sqf at line 50](../../../Src/client/NOEngineClient/NOEngineClient_NOGEOM_ext.sqf#L50)
## NGOExt_registerRef

Type: function

Description: 
- Param: _obj
- Param: _ptr

File: [client\NOEngineClient\NOEngineClient_NOGEOM_ext.sqf at line 61](../../../Src/client/NOEngineClient/NOEngineClient_NOGEOM_ext.sqf#L61)
## NGOExt_createDummyObject

Type: function

Description: 
- Param: _src
- Param: _objType
- Param: _imode (optional, default true)
- Param: _simple (optional, default true)

File: [client\NOEngineClient\NOEngineClient_NOGEOM_ext.sqf at line 68](../../../Src/client/NOEngineClient/NOEngineClient_NOGEOM_ext.sqf#L68)
## noe_client_ngo_check

Type: function

Description: 
- Param: _obj
- Param: _model

File: [client\NOEngineClient\NOEngineClient_NOGEOM_ext.sqf at line 87](../../../Src/client/NOEngineClient/NOEngineClient_NOGEOM_ext.sqf#L87)
## noe_client_isNGO

Type: function

Description: 


File: [client\NOEngineClient\NOEngineClient_NOGEOM_ext.sqf at line 132](../../../Src/client/NOEngineClient/NOEngineClient_NOGEOM_ext.sqf#L132)
## noe_client_getNGOSource

Type: function

Description: 


File: [client\NOEngineClient\NOEngineClient_NOGEOM_ext.sqf at line 136](../../../Src/client/NOEngineClient/NOEngineClient_NOGEOM_ext.sqf#L136)
## noe_client_getObjectNGOSkip

Type: function

Description: 
- Param: _obj

File: [client\NOEngineClient\NOEngineClient_NOGEOM_ext.sqf at line 139](../../../Src/client/NOEngineClient/NOEngineClient_NOGEOM_ext.sqf#L139)
## noe_client_getPtrInfoNGOSkip

Type: function

Description: 
- Param: _obj
- Param: _worldRef

File: [client\NOEngineClient\NOEngineClient_NOGEOM_ext.sqf at line 151](../../../Src/client/NOEngineClient/NOEngineClient_NOGEOM_ext.sqf#L151)
# NOEngineClient_ObjectManager.sqf

## NOE_CLIENT_DELETEOBJS_COUNT

Type: constant

Description: 


Replaced value:
```sqf
50
```
File: [client\NOEngineClient\NOEngineClient_ObjectManager.sqf at line 285](../../../Src/client/NOEngineClient/NOEngineClient_ObjectManager.sqf#L285)
## NOE_CLIENT_DELETEOBJS_DELAY

Type: constant

Description: 


Replaced value:
```sqf
0.2
```
File: [client\NOEngineClient\NOEngineClient_ObjectManager.sqf at line 288](../../../Src/client/NOEngineClient/NOEngineClient_ObjectManager.sqf#L288)
## noe_client_spawnObject

Type: function

Description: 
- Param: _ref
- Param: _isSimple
- Param: _model
- Param: _pos
- Param: _dir
- Param: _vec
- Param: _light (optional, default 0)
- Param: _anim (optional, default null)
- Param: _radio (optional, default null)

File: [client\NOEngineClient\NOEngineClient_ObjectManager.sqf at line 11](../../../Src/client/NOEngineClient/NOEngineClient_ObjectManager.sqf#L11)
## noe_client_updateObject

Type: function

Description: 
- Param: _ref
- Param: _isSimple
- Param: _model
- Param: _pos
- Param: _dir
- Param: _vec
- Param: _light (optional, default 0)
- Param: _anim (optional, default null)
- Param: _radio (optional, default null)

File: [client\NOEngineClient\NOEngineClient_ObjectManager.sqf at line 83](../../../Src/client/NOEngineClient/NOEngineClient_ObjectManager.sqf#L83)
## noe_client_despawnObjectsInChunk

Type: function

Description: 
- Param: _chunk
- Param: _type
- Param: _chunkObject

File: [client\NOEngineClient\NOEngineClient_ObjectManager.sqf at line 174](../../../Src/client/NOEngineClient/NOEngineClient_ObjectManager.sqf#L174)
## noe_client_doRemoveObjects

Type: function

Description: 
- Param: _chunkObject
- Param: _listPtr

File: [client\NOEngineClient\NOEngineClient_ObjectManager.sqf at line 218](../../../Src/client/NOEngineClient/NOEngineClient_ObjectManager.sqf#L218)
## noe_client_remObjsAlg

Type: function

Description: 
- Param: _odel

File: [client\NOEngineClient\NOEngineClient_ObjectManager.sqf at line 291](../../../Src/client/NOEngineClient/NOEngineClient_ObjectManager.sqf#L291)
## noe_client_doUpdateObjects

Type: function

Description: 
- Param: _chunkObject
- Param: _updObjList

File: [client\NOEngineClient\NOEngineClient_ObjectManager.sqf at line 305](../../../Src/client/NOEngineClient/NOEngineClient_ObjectManager.sqf#L305)
## noe_client_debug_findChunkObjectByPointer

Type: function

Description: 
- Param: _pointer
- Param: _retAsData (optional, default false)

File: [client\NOEngineClient\NOEngineClient_ObjectManager.sqf at line 329](../../../Src/client/NOEngineClient/NOEngineClient_ObjectManager.sqf#L329)
## noe_client_getObjPtr

Type: function

Description: 
- Param: _obj
- Param: _checkNGO (optional, default true)

File: [client\NOEngineClient\NOEngineClient_ObjectManager.sqf at line 361](../../../Src/client/NOEngineClient/NOEngineClient_ObjectManager.sqf#L361)
# NOEngineClient_Rendering.sqf

## vectorFromDir(pos,dir,dist)

Type: constant

Description: 
- Param: pos
- Param: dir
- Param: dist

Replaced value:
```sqf
((pos) vectorAdd [sin (_eyedir + (dir)) * dist,cos (_eyedir + (dir)) * dist,0])
```
File: [client\NOEngineClient\NOEngineClient_Rendering.sqf at line 17](../../../Src/client/NOEngineClient/NOEngineClient_Rendering.sqf#L17)
## RayCastCount(obj)

Type: constant

Description: 
- Param: obj

Replaced value:
```sqf
(count(lineIntersectsSurfaces [eyePos player, getPosASL obj, player, obj, true, 20,"GEOM","VIEW",false]))
```
File: [client\NOEngineClient\NOEngineClient_Rendering.sqf at line 38](../../../Src/client/NOEngineClient/NOEngineClient_Rendering.sqf#L38)
## setHideMode(mode)

Type: constant

Description: 
- Param: mode

Replaced value:
```sqf
\
		prevStateIsHidden set [_x,mode]; \
		{ \
			(_y select chunk_objectData_ptr) hideObject mode; \
		} foreach chunk_getObjectsData(_chunk);
```
File: [client\NOEngineClient\NOEngineClient_Rendering.sqf at line 40](../../../Src/client/NOEngineClient/NOEngineClient_Rendering.sqf#L40)
## setHidePrevMode(mode)

Type: constant

Description: 
- Param: mode

Replaced value:
```sqf
\
		_chunkPrev = [_curPrev,_x] call noe_client_getPosChunkToData; \
		{ \
			(_y select chunk_objectData_ptr) hideObject mode; \
		} foreach chunk_getObjectsData(_chunkPrev); \
		
```
File: [client\NOEngineClient\NOEngineClient_Rendering.sqf at line 47](../../../Src/client/NOEngineClient/NOEngineClient_Rendering.sqf#L47)
## state(num)

Type: constant

Description: 
- Param: num

Replaced value:
```sqf
trace('State num')
```
File: [client\NOEngineClient\NOEngineClient_Rendering.sqf at line 53](../../../Src/client/NOEngineClient/NOEngineClient_Rendering.sqf#L53)
## objLeft

Type: Variable

Description: RENDERING (not optimized). Need rewrite


Initial value:
```sqf
"Sign_Arrow_F" createVehicle [0,0,0]
```
File: [client\NOEngineClient\NOEngineClient_Rendering.sqf at line 10](../../../Src/client/NOEngineClient/NOEngineClient_Rendering.sqf#L10)
## objRight

Type: Variable

Description: 


Initial value:
```sqf
"Sign_Arrow_F" createVehicle [0,0,0]
```
File: [client\NOEngineClient\NOEngineClient_Rendering.sqf at line 11](../../../Src/client/NOEngineClient/NOEngineClient_Rendering.sqf#L11)
## objTemp

Type: Variable

Description: 


Initial value:
```sqf
"Sign_Arrow_F" createVehicle [0,0,0]
```
File: [client\NOEngineClient\NOEngineClient_Rendering.sqf at line 12](../../../Src/client/NOEngineClient/NOEngineClient_Rendering.sqf#L12)
## objMode

Type: Variable

Description: 


Initial value:
```sqf
0
```
File: [client\NOEngineClient\NOEngineClient_Rendering.sqf at line 13](../../../Src/client/NOEngineClient/NOEngineClient_Rendering.sqf#L13)
## prevPosObj

Type: Variable

Description: 


Initial value:
```sqf
[[0,0],[0,0],[0,0]]
```
File: [client\NOEngineClient\NOEngineClient_Rendering.sqf at line 14](../../../Src/client/NOEngineClient/NOEngineClient_Rendering.sqf#L14)
## prevStateIsHidden

Type: Variable

Description: 


Initial value:
```sqf
[false,false,false]
```
File: [client\NOEngineClient\NOEngineClient_Rendering.sqf at line 15](../../../Src/client/NOEngineClient/NOEngineClient_Rendering.sqf#L15)
# NOEngineClient_TransportLevel.sqf

## debug_calltraceOnErrorConvert

Type: constant

Description: 


Replaced value:
```sqf

```
File: [client\NOEngineClient\NOEngineClient_TransportLevel.sqf at line 306](../../../Src/client/NOEngineClient/NOEngineClient_TransportLevel.sqf#L306)
## callwarn(macroname)

Type: constant

> Exists if **debug_calltraceOnErrorConvert** defined

Description: 
- Param: macroname

Replaced value:
```sqf
warningformat("__DEBUG__::%1() - count tokens %2" + endl + "Data: %3",macroname arg count _tokens arg _tokens);
```
File: [client\NOEngineClient\NOEngineClient_TransportLevel.sqf at line 310](../../../Src/client/NOEngineClient/NOEngineClient_TransportLevel.sqf#L310)
## callwarn(ma)

Type: constant

> Exists if **debug_calltraceOnErrorConvert** not defined

Description: 
- Param: ma

Replaced value:
```sqf

```
File: [client\NOEngineClient\NOEngineClient_TransportLevel.sqf at line 312](../../../Src/client/NOEngineClient/NOEngineClient_TransportLevel.sqf#L312)
## tokenIndex

Type: constant

Description: 


Replaced value:
```sqf
_pos
```
File: [client\NOEngineClient\NOEngineClient_TransportLevel.sqf at line 316](../../../Src/client/NOEngineClient/NOEngineClient_TransportLevel.sqf#L316)
## moveNext()

Type: constant

Description: 
- Param: 

Replaced value:
```sqf
MOD(tokenIndex,+1); if (tokenIndex > (_lastIndex)) then { error("NOEngineClient::byteArrToObjStruct() - Out of range"); callwarn("next") RETURN(false);}
```
File: [client\NOEngineClient\NOEngineClient_TransportLevel.sqf at line 318](../../../Src/client/NOEngineClient/NOEngineClient_TransportLevel.sqf#L318)
## moveTo(val)

Type: constant

Description: 
- Param: val

Replaced value:
```sqf
MOD(tokenIndex,+val); if (tokenIndex > (_lastIndex)) then { error("NOEngineClient::byteArrToObjStruct() - Out of range"); callwarn("move") RETURN(false); }
```
File: [client\NOEngineClient\NOEngineClient_TransportLevel.sqf at line 320](../../../Src/client/NOEngineClient/NOEngineClient_TransportLevel.sqf#L320)
## getToken(ch)

Type: constant

Description: 
- Param: ch

Replaced value:
```sqf
(_tokens select ch)
```
File: [client\NOEngineClient\NOEngineClient_TransportLevel.sqf at line 322](../../../Src/client/NOEngineClient/NOEngineClient_TransportLevel.sqf#L322)
## canMove(idx)

Type: constant

Description: 
- Param: idx

Replaced value:
```sqf
(idx <= (count _tokens - 1) && idx >= 0)
```
File: [client\NOEngineClient\NOEngineClient_TransportLevel.sqf at line 324](../../../Src/client/NOEngineClient/NOEngineClient_TransportLevel.sqf#L324)
## getTokenSafe(idx)

Type: constant

Description: 
- Param: idx

Replaced value:
```sqf
if canMove(idx) then {getToken(idx)} else {"0x0"}
```
File: [client\NOEngineClient\NOEngineClient_TransportLevel.sqf at line 326](../../../Src/client/NOEngineClient/NOEngineClient_TransportLevel.sqf#L326)
## getCurToken()

Type: constant

Description: 
- Param: 

Replaced value:
```sqf
getToken(tokenIndex)
```
File: [client\NOEngineClient\NOEngineClient_TransportLevel.sqf at line 328](../../../Src/client/NOEngineClient/NOEngineClient_TransportLevel.sqf#L328)
## isTrue(val)

Type: constant

Description: 
- Param: val

Replaced value:
```sqf
not_equals(val,_strZero)
```
File: [client\NOEngineClient\NOEngineClient_TransportLevel.sqf at line 337](../../../Src/client/NOEngineClient/NOEngineClient_TransportLevel.sqf#L337)
## noe_client_debug_requestLoadChunk

Type: function

Description: 


File: [client\NOEngineClient\NOEngineClient_TransportLevel.sqf at line 16](../../../Src/client/NOEngineClient/NOEngineClient_TransportLevel.sqf#L16)
## noe_client_requestLoadChunk

Type: function

Description: 
- Param: _chunk
- Param: _type
- Param: _chunkObject

File: [client\NOEngineClient\NOEngineClient_TransportLevel.sqf at line 29](../../../Src/client/NOEngineClient/NOEngineClient_TransportLevel.sqf#L29)
## noe_client_requestDeleteUpdater

Type: function

Description: 
- Param: _chunkObject
- Param: _time

File: [client\NOEngineClient\NOEngineClient_TransportLevel.sqf at line 40](../../../Src/client/NOEngineClient/NOEngineClient_TransportLevel.sqf#L40)
## noe_client_onUpdateChunk

Type: function

Description: 


File: [client\NOEngineClient\NOEngineClient_TransportLevel.sqf at line 58](../../../Src/client/NOEngineClient/NOEngineClient_TransportLevel.sqf#L58)
## noe_client_onUpdateObject

Type: function

Description: 


File: [client\NOEngineClient\NOEngineClient_TransportLevel.sqf at line 110](../../../Src/client/NOEngineClient/NOEngineClient_TransportLevel.sqf#L110)
## noe_client_getOrignalObjectData

Type: function

Description: 
- Param: _ptr
- Param: _retAsHash (optional, default true)

File: [client\NOEngineClient\NOEngineClient_TransportLevel.sqf at line 152](../../../Src/client/NOEngineClient/NOEngineClient_TransportLevel.sqf#L152)
## noe_client_resetObjectTransform

Type: function

Description: 
- Param: _ptr

File: [client\NOEngineClient\NOEngineClient_TransportLevel.sqf at line 164](../../../Src/client/NOEngineClient/NOEngineClient_TransportLevel.sqf#L164)
## noe_client_setObjectTransform

Type: function

Description: 
- Param: _obj
- Param: _type
- Param: _val

File: [client\NOEngineClient\NOEngineClient_TransportLevel.sqf at line 212](../../../Src/client/NOEngineClient/NOEngineClient_TransportLevel.sqf#L212)
## noe_client_generatePacketId

Type: function

Description: 
- Param: _chunkObject
- Param: _lifetime (optional, default PACKET_LIFETIME)

File: [client\NOEngineClient\NOEngineClient_TransportLevel.sqf at line 237](../../../Src/client/NOEngineClient/NOEngineClient_TransportLevel.sqf#L237)
## noe_client_byteArrToObjStruct

Type: function

Description: 
- Param: _tokens
- Param: _struct
- Param: _remStruct

File: [client\NOEngineClient\NOEngineClient_TransportLevel.sqf at line 282](../../../Src/client/NOEngineClient/NOEngineClient_TransportLevel.sqf#L282)
## noe_client_unsubscribeChunkListening

Type: function

Description: 
- Param: _chunk
- Param: _type

File: [client\NOEngineClient\NOEngineClient_TransportLevel.sqf at line 537](../../../Src/client/NOEngineClient/NOEngineClient_TransportLevel.sqf#L537)
## noe_client_unsubscribeChunkListeningFull

Type: function

Description: 
- Param: _chunk
- Param: _type

File: [client\NOEngineClient\NOEngineClient_TransportLevel.sqf at line 543](../../../Src/client/NOEngineClient/NOEngineClient_TransportLevel.sqf#L543)
