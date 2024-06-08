# Atmos.h

## ATMOS_SIZE

Type: constant

Description: size one chunk in meters and half (only constexpr)


Replaced value:
```sqf
1
```
File: [host\Atmos\Atmos.h at line 4](../../../Src/host/Atmos/Atmos.h#L4)
## ATMOS_SIZE_HALF

Type: constant

Description: 


Replaced value:
```sqf
0.5
```
File: [host\Atmos\Atmos.h at line 5](../../../Src/host/Atmos/Atmos.h#L5)
## ATMOS_START_INDEX

Type: constant

Description: начальное число с которого начинается отсчёт позиций


Replaced value:
```sqf
1
```
File: [host\Atmos\Atmos.h at line 8](../../../Src/host/Atmos/Atmos.h#L8)
## ATMOS_MAIN_THREAD_UPDATE_DELAY

Type: constant

Description: частота обновления основного треда


Replaced value:
```sqf
1
```
File: [host\Atmos\Atmos.h at line 11](../../../Src/host/Atmos/Atmos.h#L11)
## ATMOS_SPREAD_MAX_COUNT

Type: constant

Description: left, right, top, bottom, front, back


Replaced value:
```sqf
6
```
File: [host\Atmos\Atmos.h at line 14](../../../Src/host/Atmos/Atmos.h#L14)
## ATMOS_POS_INSIDE_CHUNK(_p,_chunkPos)

Type: constant

Description: 
- Param: _p
- Param: _chunkPos

Replaced value:
```sqf
((_p) inArea [_chunkPos, ATMOS_SIZE, ATMOS_SIZE, 0, true, ATMOS_SIZE])
```
File: [host\Atmos\Atmos.h at line 16](../../../Src/host/Atmos/Atmos.h#L16)
# Atmos_ChunkStruct.sqf

## atmos_createChunk

Type: function

Description: 
- Param: _pos

File: [host\Atmos\Atmos_ChunkStruct.sqf at line 6](../../../Src/host/Atmos/Atmos_ChunkStruct.sqf#L6)
## atmos_createProcess

Type: function

Description: create atmos effect (fire,smoke etc)
- Param: _pos
- Param: _processClass

File: [host\Atmos\Atmos_ChunkStruct.sqf at line 11](../../../Src/host/Atmos/Atmos_ChunkStruct.sqf#L11)
# Atmos_init.sqf

## atmos_map_chunks

Type: Variable

Description: 


Initial value:
```sqf
createHashMap //key:str(chunkloc) -> value(object:AtmosChunk)
```
File: [host\Atmos\Atmos_init.sqf at line 10](../../../Src/host/Atmos/Atmos_init.sqf#L10)
## atmos_handle_update

Type: Variable

Description: key:str(chunkloc) -> value(object:AtmosChunk)


Initial value:
```sqf
-1
```
File: [host\Atmos\Atmos_init.sqf at line 11](../../../Src/host/Atmos/Atmos_init.sqf#L11)
## atmos_hasIntersect

Type: function

Description: 
- Param: _fromCh
- Param: _toCh

File: [host\Atmos\Atmos_init.sqf at line 13](../../../Src/host/Atmos/Atmos_init.sqf#L13)
## atmos_updateAll

Type: function

Description: 


File: [host\Atmos\Atmos_init.sqf at line 23](../../../Src/host/Atmos/Atmos_init.sqf#L23)
## atmos_chunkPosToId

Type: function

Description: convert world postion to virtual chunk id
- Param: _x
- Param: _y
- Param: _z

File: [host\Atmos\Atmos_init.sqf at line 130](../../../Src/host/Atmos/Atmos_init.sqf#L130)
## atmos_chunkIdToPos

Type: function

Description: 
- Param: _iX
- Param: _iY
- Param: _iZ

File: [host\Atmos\Atmos_init.sqf at line 140](../../../Src/host/Atmos/Atmos_init.sqf#L140)
## atmos_chunkIdGetAround

Type: function

Description: 
- Param: _chunk
- Param: _addCurrent (optional, default false)

File: [host\Atmos\Atmos_init.sqf at line 172](../../../Src/host/Atmos/Atmos_init.sqf#L172)
## atmos_init

Type: function

Description: run thread updater


File: [host\Atmos\Atmos_init.sqf at line 196](../../../Src/host/Atmos/Atmos_init.sqf#L196)
