# NOEngine.h

## chunk_owners

Type: constant

Description: индексы инфомрации о чанке: массив владельцев, последняя метка обновления, список объектов


Replaced value:
```sqf
0
```
File: [host\NOEngine\NOEngine.h at line 10](../../../Src/host/NOEngine/NOEngine.h#L10)
## chunk_lastupdate

Type: constant

Description: 


Replaced value:
```sqf
1  
```
File: [host\NOEngine\NOEngine.h at line 11](../../../Src/host/NOEngine/NOEngine.h#L11)
## chunk_objectsData

Type: constant

Description: 


Replaced value:
```sqf
2
```
File: [host\NOEngine\NOEngine.h at line 12](../../../Src/host/NOEngine/NOEngine.h#L12)
## chunk_lastdelete

Type: constant

Description: 


Replaced value:
```sqf
3
```
File: [host\NOEngine\NOEngine.h at line 13](../../../Src/host/NOEngine/NOEngine.h#L13)
## allocChunk

Type: constant

Description: 


Replaced value:
```sqf
[[],tickTime,createHashMap,0]
```
File: [host\NOEngine\NOEngine.h at line 15](../../../Src/host/NOEngine/NOEngine.h#L15)
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
File: [host\NOEngine\NOEngine.h at line 17](../../../Src/host/NOEngine/NOEngine.h#L17)
## getChunkStorage(type)

Type: constant

Description: 
- Param: type

Replaced value:
```sqf
(noe_chunkTypes get type)
```
File: [host\NOEngine\NOEngine.h at line 19](../../../Src/host/NOEngine/NOEngine.h#L19)
## getChunk(chs,pos)

Type: constant

Description: 
- Param: chs
- Param: pos

Replaced value:
```sqf
(chs get (pos))
```
File: [host\NOEngine\NOEngine.h at line 19](../../../Src/host/NOEngine/NOEngine.h#L19)
## chunk_getOwners(chunk)

Type: constant

Description: 
- Param: chunk

Replaced value:
```sqf
((chunk) select chunk_owners)
```
File: [host\NOEngine\NOEngine.h at line 22](../../../Src/host/NOEngine/NOEngine.h#L22)
## chunk_isEmptyOwnerList(chunk)

Type: constant

Description: 
- Param: chunk

Replaced value:
```sqf
equals(chunk_getOwners(chunk),[])
```
File: [host\NOEngine\NOEngine.h at line 23](../../../Src/host/NOEngine/NOEngine.h#L23)
## chunk_getLastTicktimeUpdate(chunk)

Type: constant

Description: 
- Param: chunk

Replaced value:
```sqf
((chunk) select chunk_lastupdate)
```
File: [host\NOEngine\NOEngine.h at line 25](../../../Src/host/NOEngine/NOEngine.h#L25)
## chunk_setLastTicktimeUpdate(chunk,time)

Type: constant

Description: 
- Param: chunk
- Param: time

Replaced value:
```sqf
(chunk) set [chunk_lastupdate,time]
```
File: [host\NOEngine\NOEngine.h at line 26](../../../Src/host/NOEngine/NOEngine.h#L26)
## chunk_getObjectsData(chunk)

Type: constant

Description: 
- Param: chunk

Replaced value:
```sqf
((chunk) select chunk_objectsData)
```
File: [host\NOEngine\NOEngine.h at line 28](../../../Src/host/NOEngine/NOEngine.h#L28)
## chunk_getLastTicktimeDelete(chunk)

Type: constant

Description: Отметка последнего удаления
- Param: chunk

Replaced value:
```sqf
((chunk) select chunk_lastdelete)
```
File: [host\NOEngine\NOEngine.h at line 31](../../../Src/host/NOEngine/NOEngine.h#L31)
## chunk_setLastTicktimeDelete(chunk,time)

Type: constant

Description: 
- Param: chunk
- Param: time

Replaced value:
```sqf
(chunk) set [chunk_lastdelete,time]
```
File: [host\NOEngine\NOEngine.h at line 32](../../../Src/host/NOEngine/NOEngine.h#L32)
## __chunk_getClientSafe(refvar,own,methodName)

Type: constant

Description: безопасное получение клиента. выход из контекста если ошибка
- Param: refvar
- Param: own
- Param: methodName

Replaced value:
```sqf
refvar = own call cm_findClientById; \
if isNullReference(refvar) exitWith {errorformat("[%1]: cant find client by id %2",methodName arg own)}
```
File: [host\NOEngine\NOEngine.h at line 39](../../../Src/host/NOEngine/NOEngine.h#L39)
## __chunk_getStrName(ch,tp)

Type: constant

Description: 
- Param: ch
- Param: tp

Replaced value:
```sqf
(str [ch,tp])
```
File: [host\NOEngine\NOEngine.h at line 42](../../../Src/host/NOEngine/NOEngine.h#L42)
# NOEngine.hpp

## CHUNK_TYPE_ITEM

Type: constant

Description: 


Replaced value:
```sqf
0
```
File: [host\NOEngine\NOEngine.hpp at line 10](../../../Src/host/NOEngine/NOEngine.hpp#L10)
## CHUNK_TYPE_STRUCTURE

Type: constant

Description: 


Replaced value:
```sqf
1
```
File: [host\NOEngine\NOEngine.hpp at line 11](../../../Src/host/NOEngine/NOEngine.hpp#L11)
## CHUNK_TYPE_DECOR

Type: constant

Description: 


Replaced value:
```sqf
2
```
File: [host\NOEngine\NOEngine.hpp at line 12](../../../Src/host/NOEngine/NOEngine.hpp#L12)
## chunkSize_decor

Type: constant

Description: size for non-interactible objects


Replaced value:
```sqf
65
```
File: [host\NOEngine\NOEngine.hpp at line 19](../../../Src/host/NOEngine/NOEngine.hpp#L19)
## chunkSize_structure

Type: constant

Description: size for interactible objects


Replaced value:
```sqf
30
```
File: [host\NOEngine\NOEngine.hpp at line 22](../../../Src/host/NOEngine/NOEngine.hpp#L22)
## chunkSize_item

Type: constant

Description: size for small items


Replaced value:
```sqf
10
```
File: [host\NOEngine\NOEngine.hpp at line 25](../../../Src/host/NOEngine/NOEngine.hpp#L25)
## chunkZoneSize_decor

Type: constant

Description: 


Replaced value:
```sqf
3
```
File: [host\NOEngine\NOEngine.hpp at line 35](../../../Src/host/NOEngine/NOEngine.hpp#L35)
## chunkZoneSize_structure

Type: constant

Description: 


Replaced value:
```sqf
2
```
File: [host\NOEngine\NOEngine.hpp at line 36](../../../Src/host/NOEngine/NOEngine.hpp#L36)
## chunkZoneSize_item

Type: constant

Description: 


Replaced value:
```sqf
0
```
File: [host\NOEngine\NOEngine.hpp at line 37](../../../Src/host/NOEngine/NOEngine.hpp#L37)
## mainThreadUpdateDelay

Type: constant

Description: частота обновления основного треда


Replaced value:
```sqf
1.1
```
File: [host\NOEngine\NOEngine.hpp at line 41](../../../Src/host/NOEngine/NOEngine.hpp#L41)
## mainThreadUpdateMultiplier

Type: constant

Description: decor: delay + (mult *3)


Replaced value:
```sqf
0.3
```
File: [host\NOEngine\NOEngine.hpp at line 46](../../../Src/host/NOEngine/NOEngine.hpp#L46)
## chunkType_decor

Type: constant

Description: внутренние псевдонимы


Replaced value:
```sqf
CHUNK_TYPE_DECOR
```
File: [host\NOEngine\NOEngine.hpp at line 54](../../../Src/host/NOEngine/NOEngine.hpp#L54)
## chunkType_structure

Type: constant

Description: 


Replaced value:
```sqf
CHUNK_TYPE_STRUCTURE
```
File: [host\NOEngine\NOEngine.hpp at line 55](../../../Src/host/NOEngine/NOEngine.hpp#L55)
## chunkType_item

Type: constant

Description: 


Replaced value:
```sqf
CHUNK_TYPE_ITEM
```
File: [host\NOEngine\NOEngine.hpp at line 56](../../../Src/host/NOEngine/NOEngine.hpp#L56)
## getChunkSizeByType(type)

Type: constant

Description: Получает размер одного чанка по типу
- Param: type

Replaced value:
```sqf
([chunkSize_item,chunkSize_structure,chunkSize_decor] select type)
```
File: [host\NOEngine\NOEngine.hpp at line 59](../../../Src/host/NOEngine/NOEngine.hpp#L59)
## startChunkIndex

Type: constant

Description: начальное число с которого начинается отсчёт чанков


Replaced value:
```sqf
1
```
File: [host\NOEngine\NOEngine.hpp at line 62](../../../Src/host/NOEngine/NOEngine.hpp#L62)
# NOEngineInit.sqf

## variable_name_prevchunk

Type: constant

Description: _t = tickTime;


Replaced value:
```sqf
"pch"
```
File: [host\NOEngine\NOEngineInit.sqf at line 45](../../../Src/host/NOEngine/NOEngineInit.sqf#L45)
## noe_onUpdateArea

Type: Variable

> Exists if **EDITOR** defined

Description: 


Initial value:
```sqf
_noe_onUpdateArea
```
File: [host\NOEngine\NOEngineInit.sqf at line 136](../../../Src/host/NOEngine/NOEngineInit.sqf#L136)
## noe_init

Type: function

Description: инициализирует менеджер карты
- Param: _mob

File: [host\NOEngine\NOEngineInit.sqf at line 33](../../../Src/host/NOEngine/NOEngineInit.sqf#L33)
## noe_onMainThread

Type: function

Description: 
- Param: _mob
- Param: _chunkType

File: [host\NOEngine\NOEngineInit.sqf at line 41](../../../Src/host/NOEngine/NOEngineInit.sqf#L41)
## noe_internal_loadTrigger

Type: function

Description: 
- Param: _obj

File: [host\NOEngine\NOEngineInit.sqf at line 97](../../../Src/host/NOEngine/NOEngineInit.sqf#L97)
## noe_getChunk

Type: function

Description: 
- Param: _pos_vec2
- Param: _chunkType

File: [host\NOEngine\NOEngineInit.sqf at line 139](../../../Src/host/NOEngine/NOEngineInit.sqf#L139)
## noe_getChunkSizeDecor

Type: function

Description: ридонли свойства


File: [host\NOEngine\NOEngineInit.sqf at line 150](../../../Src/host/NOEngine/NOEngineInit.sqf#L150)
## noe_getChunkSizeStructure

Type: function

Description: 


File: [host\NOEngine\NOEngineInit.sqf at line 151](../../../Src/host/NOEngine/NOEngineInit.sqf#L151)
## noe_getChunkSizeItem

Type: function

Description: 


File: [host\NOEngine\NOEngineInit.sqf at line 152](../../../Src/host/NOEngine/NOEngineInit.sqf#L152)
# NOEngine_ChunkModel.sqf

## noe_chunkTypes

Type: Variable

Description: содержит список типов чанков


Initial value:
```sqf
createHashMap
```
File: [host\NOEngine\NOEngine_ChunkModel.sqf at line 13](../../../Src/host/NOEngine/NOEngine_ChunkModel.sqf#L13)
## noe_allChunkTypes

Type: Variable

Description: 


Initial value:
```sqf
[CHUNK_TYPE_ITEM,CHUNK_TYPE_STRUCTURE,CHUNK_TYPE_DECOR]
```
File: [host\NOEngine\NOEngine_ChunkModel.sqf at line 14](../../../Src/host/NOEngine/NOEngine_ChunkModel.sqf#L14)
## noe_getChunkObject

Type: function

Description: Получает объект чанка. Если нет - создаёт
- Param: _chpos
- Param: _cht

File: [host\NOEngine\NOEngine_ChunkModel.sqf at line 25](../../../Src/host/NOEngine/NOEngine_ChunkModel.sqf#L25)
# NOEngine_initializers.sqf

## objectInitializator(cht)

Type: constant

Description: 
- Param: cht

Replaced value:
```sqf
\
call _initCode; \
private _visObj = callSelfParams(InitModel,_pos arg _dir arg _vec); \
_chpos = [_pos,cht] call noe_posToChunk;\
private _chdata = [_chpos,cht] call noe_getChunkObject; \
private _updTime = tickTime; \
chunk_getObjectsData(_chdata) set [getVar(_visObj getvariable 'link',pointer),_visObj]; \
_visObj setVariable ["lastUpd",_updTime]; \
chunk_setLastTicktimeUpdate(_chdata,_updTime); \

```
File: [host\NOEngine\NOEngine_initializers.sqf at line 7](../../../Src/host/NOEngine/NOEngine_initializers.sqf#L7)
## initItem

Type: function

Description: 


File: [host\NOEngine\NOEngine_initializers.sqf at line 17](../../../Src/host/NOEngine/NOEngine_initializers.sqf#L17)
## initStruct

Type: function

Description: 


File: [host\NOEngine\NOEngine_initializers.sqf at line 31](../../../Src/host/NOEngine/NOEngine_initializers.sqf#L31)
## initDecor

Type: function

Description: 


File: [host\NOEngine\NOEngine_initializers.sqf at line 45](../../../Src/host/NOEngine/NOEngine_initializers.sqf#L45)
# NOEngine_NGO.hpp

## addNGO(path,vec__,resize__)

Type: constant

Description: макрос добавления объекта без геометрии. tolower (path) потому что снаружи все пути приходят в lowercase
- Param: path
- Param: vec__
- Param: resize__

Replaced value:
```sqf
noe_client_map_ngoext set [tolower (path),[vec__,resize__,"block_dirt"]]
```
File: [host\NOEngine\NOEngine_NGO.hpp at line 15](../../../Src/host/NOEngine/NOEngine_NGO.hpp#L15)
## addNGODecal(path,vec__,resize__,decal__)

Type: constant

Description: 
- Param: path
- Param: vec__
- Param: resize__
- Param: decal__

Replaced value:
```sqf
noe_client_map_ngoext set [tolower (path),[vec__,resize__,decal__]]
```
File: [host\NOEngine\NOEngine_NGO.hpp at line 16](../../../Src/host/NOEngine/NOEngine_NGO.hpp#L16)
## noe_client_map_ngoext

Type: Variable

Description: 


Initial value:
```sqf
createHashMap
```
File: [host\NOEngine\NOEngine_NGO.hpp at line 13](../../../Src/host/NOEngine/NOEngine_NGO.hpp#L13)
# NOEngine_NGOServer.sqf

## noe_server_ngo_check

Type: function

Description: Вызывается из GameObject::initModel()
- Param: _obj
- Param: _model

File: [host\NOEngine\NOEngine_NGOServer.sqf at line 24](../../../Src/host/NOEngine/NOEngine_NGOServer.sqf#L24)
## noe_server_isNGO

Type: function

Description: check if is ngo object


File: [host\NOEngine\NOEngine_NGOServer.sqf at line 71](../../../Src/host/NOEngine/NOEngine_NGOServer.sqf#L71)
## noe_server_getNGOSource

Type: function

Description: getting ngo


File: [host\NOEngine\NOEngine_NGOServer.sqf at line 74](../../../Src/host/NOEngine/NOEngine_NGOServer.sqf#L74)
# NOEngine_ObjectManager.sqf

## createItemInWorld

Type: function

Description: Создание предмета в 3д пространстве
- Param: _name_str
- Param: _pos
- Param: _dir (optional, default random 360)
- Param: _emulDrop (optional, default true)
- Param: _vec (optional, default ['0', '0', '1'])
- Param: _probStackSize (optional, default 1)

File: [host\NOEngine\NOEngine_ObjectManager.sqf at line 10](../../../Src/host/NOEngine/NOEngine_ObjectManager.sqf#L10)
## createItemInContainer

Type: function

Description: Создание предмета в контейнере
- Param: _name_str
- Param: _container
- Param: _probStackSize (optional, default 1)
- Param: _ignoreMode (optional, default "")

File: [host\NOEngine\NOEngine_ObjectManager.sqf at line 59](../../../Src/host/NOEngine/NOEngine_ObjectManager.sqf#L59)
## createItemInInventory

Type: function

Description: Создание предмета в инвентаре
- Param: _name_str
- Param: _mob
- Param: _slot
- Param: _probStackSize (optional, default 1)

File: [host\NOEngine\NOEngine_ObjectManager.sqf at line 120](../../../Src/host/NOEngine/NOEngine_ObjectManager.sqf#L120)
## createStructure

Type: function

Description: Создание структуры в мире
- Param: _name_str
- Param: _pos
- Param: _dir (optional, default random 360)
- Param: _emulDrop (optional, default true)
- Param: _vec (optional, default ['0', '0', '1'])

File: [host\NOEngine\NOEngine_ObjectManager.sqf at line 164](../../../Src/host/NOEngine/NOEngine_ObjectManager.sqf#L164)
## createDecoration

Type: function

Description: Создание декорации в мире
- Param: _name_str
- Param: _pos
- Param: _dir (optional, default random 360)
- Param: _emulDrop (optional, default true)
- Param: _vec (optional, default ['0', '0', '1'])

File: [host\NOEngine\NOEngine_ObjectManager.sqf at line 206](../../../Src/host/NOEngine/NOEngine_ObjectManager.sqf#L206)
## deleteDecor

Type: function

Description: Удаление декора
- Param: _dec

File: [host\NOEngine\NOEngine_ObjectManager.sqf at line 249](../../../Src/host/NOEngine/NOEngine_ObjectManager.sqf#L249)
## deleteStructure

Type: function

Description: Удаление структуры
- Param: _struct

File: [host\NOEngine\NOEngine_ObjectManager.sqf at line 264](../../../Src/host/NOEngine/NOEngine_ObjectManager.sqf#L264)
## deleteItem

Type: function

Description: Удаление предмета
- Param: _item

File: [host\NOEngine\NOEngine_ObjectManager.sqf at line 279](../../../Src/host/NOEngine/NOEngine_ObjectManager.sqf#L279)
## getGameObjectOnPosition

Type: function

Description: _retChild - опциональный параметр для возврата всех дочерних типов
- Param: _type
- Param: _vecPos
- Param: _dist (optional, default 3)
- Param: _retAsList (optional, default false)
- Param: _retChild (optional, default false)

File: [host\NOEngine\NOEngine_ObjectManager.sqf at line 309](../../../Src/host/NOEngine/NOEngine_ObjectManager.sqf#L309)
## getAllObjectsInWorldTypeOf

Type: function

Description: возвращает все объекты в мире. очень затратно по ресурсам
- Param: _type
- Param: _retChild (optional, default true)

File: [host\NOEngine\NOEngine_ObjectManager.sqf at line 349](../../../Src/host/NOEngine/NOEngine_ObjectManager.sqf#L349)
## getAllItemsTypeOf

Type: function

Description: Возвращает все итемы определенного типа
- Param: _type
- Param: _retChild (optional, default true)

File: [host\NOEngine\NOEngine_ObjectManager.sqf at line 356](../../../Src/host/NOEngine/NOEngine_ObjectManager.sqf#L356)
## getAllItemsInInventory

Type: function

Description: Получает все итемы в инвентаре сущности
- Param: _mob
- Param: _type
- Param: _retChild (optional, default true)

File: [host\NOEngine\NOEngine_ObjectManager.sqf at line 363](../../../Src/host/NOEngine/NOEngine_ObjectManager.sqf#L363)
## getAllItemsOnPosition

Type: function

Description: Собирает все игровые объекты на позиции возвращая их в листе. Включает предметы на мобах и в контейнерах
- Param: _type
- Param: _vecPos
- Param: _dist (optional, default 3)
- Param: _retChild (optional, default false)

File: [host\NOEngine\NOEngine_ObjectManager.sqf at line 392](../../../Src/host/NOEngine/NOEngine_ObjectManager.sqf#L392)
## getMobsOnPosition

Type: function

Description: Возвращает всех мобов в радиусе _dist на позиции _vecPos
- Param: _type
- Param: _vecPos
- Param: _dist (optional, default 3)
- Param: _retAsList (optional, default false)
- Param: _retChild (optional, default false)

File: [host\NOEngine\NOEngine_ObjectManager.sqf at line 455](../../../Src/host/NOEngine/NOEngine_ObjectManager.sqf#L455)
## getAllMobsInWorld

Type: function

Description: Возвращает список всех мобов в мире
- Param: _type
- Param: _retChild (optional, default false)

File: [host\NOEngine\NOEngine_ObjectManager.sqf at line 476](../../../Src/host/NOEngine/NOEngine_ObjectManager.sqf#L476)
## getObjectByRef

Type: function

Description: Получает игровой объект по ссылке
- Param: _name (optional, default "")
- Param: _def (optional, default nullPtr)

File: [host\NOEngine\NOEngine_ObjectManager.sqf at line 490](../../../Src/host/NOEngine/NOEngine_ObjectManager.sqf#L490)
## getZoneByName

Type: function

Description: получить зону по имени


File: [host\NOEngine\NOEngine_ObjectManager.sqf at line 496](../../../Src/host/NOEngine/NOEngine_ObjectManager.sqf#L496)
## noe_transform_position

Type: function

Description: TODO implement
- Param: _ptr
- Param: _newpos
- Param: _transformAsWPos (optional, default false)

File: [host\NOEngine\NOEngine_ObjectManager.sqf at line 501](../../../Src/host/NOEngine/NOEngine_ObjectManager.sqf#L501)
## noe_transform_direction

Type: function

Description: TODO implement


File: [host\NOEngine\NOEngine_ObjectManager.sqf at line 506](../../../Src/host/NOEngine/NOEngine_ObjectManager.sqf#L506)
## noe_transform_vector

Type: function

Description: TODO implement


File: [host\NOEngine\NOEngine_ObjectManager.sqf at line 510](../../../Src/host/NOEngine/NOEngine_ObjectManager.sqf#L510)
## noe_transform_all

Type: function

Description: TODO implement


File: [host\NOEngine\NOEngine_ObjectManager.sqf at line 514](../../../Src/host/NOEngine/NOEngine_ObjectManager.sqf#L514)
# NOEngine_ObjectRegisterModel.sqf

## noe_extended_log_reguister

Type: constant

Description: 


Replaced value:
```sqf

```
File: [host\NOEngine\NOEngine_ObjectRegisterModel.sqf at line 7](../../../Src/host/NOEngine/NOEngine_ObjectRegisterModel.sqf#L7)
## noe_log(data,txt)

Type: constant

> Exists if **noe_extended_log_reguister** defined

Description: 
- Param: data
- Param: txt

Replaced value:
```sqf
traceformat(data,txt);
```
File: [host\NOEngine\NOEngine_ObjectRegisterModel.sqf at line 9](../../../Src/host/NOEngine/NOEngine_ObjectRegisterModel.sqf#L9)
## noe_log(data,txt)

Type: constant

> Exists if **noe_extended_log_reguister** not defined

Description: 
- Param: data
- Param: txt

Replaced value:
```sqf

```
File: [host\NOEngine\NOEngine_ObjectRegisterModel.sqf at line 11](../../../Src/host/NOEngine/NOEngine_ObjectRegisterModel.sqf#L11)
## DROP_RADIUS

Type: constant

Description: 


Replaced value:
```sqf
0.6
```
File: [host\NOEngine\NOEngine_ObjectRegisterModel.sqf at line 128](../../../Src/host/NOEngine/NOEngine_ObjectRegisterModel.sqf#L128)
## RAY_SIZE_Z

Type: constant

Description: 


Replaced value:
```sqf
200
```
File: [host\NOEngine\NOEngine_ObjectRegisterModel.sqf at line 138](../../../Src/host/NOEngine/NOEngine_ObjectRegisterModel.sqf#L138)
## point(pos)

Type: constant

> Exists if **use_trace_ondrop** defined

Description: 
- Param: pos

Replaced value:
```sqf
arrow = "Sign_Arrow_F" createVehicle [0,0,0]; arrow pos;
```
File: [host\NOEngine\NOEngine_ObjectRegisterModel.sqf at line 146](../../../Src/host/NOEngine/NOEngine_ObjectRegisterModel.sqf#L146)
## col(_r,_g,_b)

Type: constant

> Exists if **use_trace_ondrop** defined

Description: 
- Param: _r
- Param: _g
- Param: _b

Replaced value:
```sqf

```
File: [host\NOEngine\NOEngine_ObjectRegisterModel.sqf at line 147](../../../Src/host/NOEngine/NOEngine_ObjectRegisterModel.sqf#L147)
## point(pos)

Type: constant

> Exists if **use_trace_ondrop** not defined

Description: 
- Param: pos

Replaced value:
```sqf

```
File: [host\NOEngine\NOEngine_ObjectRegisterModel.sqf at line 149](../../../Src/host/NOEngine/NOEngine_ObjectRegisterModel.sqf#L149)
## col(_r,_g,_b)

Type: constant

> Exists if **use_trace_ondrop** not defined

Description: 
- Param: _r
- Param: _g
- Param: _b

Replaced value:
```sqf

```
File: [host\NOEngine\NOEngine_ObjectRegisterModel.sqf at line 150](../../../Src/host/NOEngine/NOEngine_ObjectRegisterModel.sqf#L150)
## noe_registerObject

Type: function

Description: Данный файл служит для обновления или регистрации объектов в чанках
- Param: _chpos
- Param: _cht
- Param: _vis

File: [host\NOEngine\NOEngine_ObjectRegisterModel.sqf at line 16](../../../Src/host/NOEngine/NOEngine_ObjectRegisterModel.sqf#L16)
## noe_unregisterObject

Type: function

Description: выводим регистрацию объекта
- Param: _chpos
- Param: _cht
- Param: _ptr
- Param: _deleteVisual (optional, default true)

File: [host\NOEngine\NOEngine_ObjectRegisterModel.sqf at line 52](../../../Src/host/NOEngine/NOEngine_ObjectRegisterModel.sqf#L52)
## noe_unloadVisualObject

Type: function

Description: 
- Param: _visObj
- Param: _cht (optional, default -1)

File: [host\NOEngine\NOEngine_ObjectRegisterModel.sqf at line 87](../../../Src/host/NOEngine/NOEngine_ObjectRegisterModel.sqf#L87)
## noe_loadVisualObject

Type: function

Description: загружает визуальный объект в мир (предмет, структуру или декорацию)
- Param: _item
- Param: _posAtl
- Param: _dir (optional, default random 360)
- Param: _vup (optional, default vec3(0, expected types: 0)

File: [host\NOEngine\NOEngine_ObjectRegisterModel.sqf at line 102](../../../Src/host/NOEngine/NOEngine_ObjectRegisterModel.sqf#L102)
## noe_loadVisualObject_OnPutdown

Type: function

Description: загружает визуалку ИТЕМА при выкладывании
- Param: _vObj
- Param: _posData

File: [host\NOEngine\NOEngine_ObjectRegisterModel.sqf at line 115](../../../Src/host/NOEngine/NOEngine_ObjectRegisterModel.sqf#L115)
## noe_visual_getRelRadiusPos

Type: function

Description: 
- Param: _posI
- Param: _dirPos (optional, default random 360)
- Param: _dropRad (optional, default DROP_RADIUS)

File: [host\NOEngine\NOEngine_ObjectRegisterModel.sqf at line 130](../../../Src/host/NOEngine/NOEngine_ObjectRegisterModel.sqf#L130)
## noe_loadVisualObject_OnDrop

Type: function

Description: 
- Param: _vObj
- Param: _vMobOrPos
- Param: _dropRad (optional, default DROP_RADIUS)
- Param: _goDir (optional, default random 360)
- Param: _isSafePutdown (optional, default false)

File: [host\NOEngine\NOEngine_ObjectRegisterModel.sqf at line 135](../../../Src/host/NOEngine/NOEngine_ObjectRegisterModel.sqf#L135)
## noe_registerLightAtObject

Type: function

Description: регистрирует освещение на объекте. НЕ ИСПОЛЬЗОВАТЬ В ООП МЕТОДЕ initModel
- Param: _obj
- Param: _chunkType
- Param: _light
- Param: _useUpdate (optional, default true)

File: [host\NOEngine\NOEngine_ObjectRegisterModel.sqf at line 207](../../../Src/host/NOEngine/NOEngine_ObjectRegisterModel.sqf#L207)
## noe_unregisterLightAtObject

Type: function

Description: снимает регистрацию света
- Param: _obj
- Param: _chunkType
- Param: _useUpdate (optional, default true)

File: [host\NOEngine\NOEngine_ObjectRegisterModel.sqf at line 234](../../../Src/host/NOEngine/NOEngine_ObjectRegisterModel.sqf#L234)
## noe_updateObjectRadio

Type: function

Description: Обновляет информацию о радио. Небезопасный контекст. Возможно переполнение
- Param: _obj
- Param: _mode

File: [host\NOEngine\NOEngine_ObjectRegisterModel.sqf at line 260](../../../Src/host/NOEngine/NOEngine_ObjectRegisterModel.sqf#L260)
## noe_replicateObject

Type: function

Description: Реплицирует изменённое состояние объекта по сети
- Param: _obj
- Param: _chunkType
- Param: _doUpdateByteArr (optional, default false)

File: [host\NOEngine\NOEngine_ObjectRegisterModel.sqf at line 272](../../../Src/host/NOEngine/NOEngine_ObjectRegisterModel.sqf#L272)
## noe_updateObjectByteArr

Type: function

Description: Сохраняет данные об объекте в специальном массиве
- Param: _obj

File: [host\NOEngine\NOEngine_ObjectRegisterModel.sqf at line 336](../../../Src/host/NOEngine/NOEngine_ObjectRegisterModel.sqf#L336)
## noe_serializeChunkInfoToPacket

Type: function

Description: 
- Param: _chObj
- Param: _clientTick
- Param: _cbPacket

File: [host\NOEngine\NOEngine_ObjectRegisterModel.sqf at line 453](../../../Src/host/NOEngine/NOEngine_ObjectRegisterModel.sqf#L453)
## noe_serializeObjectInfoPacket

Type: function

Description: Сериализует в пакет информацию об объекте
- Param: _packet
- Param: _visObj

File: [host\NOEngine\NOEngine_ObjectRegisterModel.sqf at line 473](../../../Src/host/NOEngine/NOEngine_ObjectRegisterModel.sqf#L473)
## noe_prepareInfoToRemoveObject

Type: function

Description: подготовка пакета объекта для удаления
- Param: _packet
- Param: _ptr

File: [host\NOEngine\NOEngine_ObjectRegisterModel.sqf at line 480](../../../Src/host/NOEngine/NOEngine_ObjectRegisterModel.sqf#L480)
# NOEngine_Shared.sqf

## noe_posToChunk

Type: function

Description: Конвертирует мировые координаты в позицию чанка
- Param: _pos
- Param: _chunkType

File: [host\NOEngine\NOEngine_Shared.sqf at line 8](../../../Src/host/NOEngine/NOEngine_Shared.sqf#L8)
## noe_chunkToPos

Type: function

Description: Конвертирует позицию чанка в мировые координаты. Координата z всегда 0
- Param: _chunk
- Param: _chunkType

File: [host\NOEngine\NOEngine_Shared.sqf at line 22](../../../Src/host/NOEngine/NOEngine_Shared.sqf#L22)
## noe_collectAroundChunks

Type: function

Description: 
- Param: _mobClient
- Param: _loadList
- Param: _chunk
- Param: _chunkType

File: [host\NOEngine\NOEngine_Shared.sqf at line 32](../../../Src/host/NOEngine/NOEngine_Shared.sqf#L32)
# NOEngine_SharedTransportLevel.hpp

## __COUNT_ELEMENTS_DATA_TRANSPORT__

Type: constant

Description: 


Replaced value:
```sqf
6
```
File: [host\NOEngine\NOEngine_SharedTransportLevel.hpp at line 7](../../../Src/host/NOEngine/NOEngine_SharedTransportLevel.hpp#L7)
## simpleObj_true

Type: constant

Description: 


Replaced value:
```sqf
0.1
```
File: [host\NOEngine\NOEngine_SharedTransportLevel.hpp at line 9](../../../Src/host/NOEngine/NOEngine_SharedTransportLevel.hpp#L9)
## simpleObj_false

Type: constant

Description: 


Replaced value:
```sqf
0
```
File: [host\NOEngine\NOEngine_SharedTransportLevel.hpp at line 10](../../../Src/host/NOEngine/NOEngine_SharedTransportLevel.hpp#L10)
## wposObj_true

Type: constant

Description: 


Replaced value:
```sqf
0.01
```
File: [host\NOEngine\NOEngine_SharedTransportLevel.hpp at line 11](../../../Src/host/NOEngine/NOEngine_SharedTransportLevel.hpp#L11)
## wposObj_false

Type: constant

Description: 


Replaced value:
```sqf
0
```
File: [host\NOEngine\NOEngine_SharedTransportLevel.hpp at line 12](../../../Src/host/NOEngine/NOEngine_SharedTransportLevel.hpp#L12)
## vDirObj_true

Type: constant

Description: 


Replaced value:
```sqf
0.001
```
File: [host\NOEngine\NOEngine_SharedTransportLevel.hpp at line 13](../../../Src/host/NOEngine/NOEngine_SharedTransportLevel.hpp#L13)
## vDirObj_false

Type: constant

Description: 


Replaced value:
```sqf
0
```
File: [host\NOEngine\NOEngine_SharedTransportLevel.hpp at line 14](../../../Src/host/NOEngine/NOEngine_SharedTransportLevel.hpp#L14)
## lightObj_true

Type: constant

Description: 


Replaced value:
```sqf
0.0001
```
File: [host\NOEngine\NOEngine_SharedTransportLevel.hpp at line 15](../../../Src/host/NOEngine/NOEngine_SharedTransportLevel.hpp#L15)
## lightObj_false

Type: constant

Description: 


Replaced value:
```sqf
0
```
File: [host\NOEngine\NOEngine_SharedTransportLevel.hpp at line 16](../../../Src/host/NOEngine/NOEngine_SharedTransportLevel.hpp#L16)
## animObj_count(val)

Type: constant

Description: 
- Param: val

Replaced value:
```sqf
0.0000##val
```
File: [host\NOEngine\NOEngine_SharedTransportLevel.hpp at line 18](../../../Src/host/NOEngine/NOEngine_SharedTransportLevel.hpp#L18)
## animObj_true

Type: constant

Description: 


Replaced value:
```sqf
0.00001
```
File: [host\NOEngine\NOEngine_SharedTransportLevel.hpp at line 19](../../../Src/host/NOEngine/NOEngine_SharedTransportLevel.hpp#L19)
## animObj_false

Type: constant

Description: 


Replaced value:
```sqf
0
```
File: [host\NOEngine\NOEngine_SharedTransportLevel.hpp at line 20](../../../Src/host/NOEngine/NOEngine_SharedTransportLevel.hpp#L20)
## radioObj_true

Type: constant

Description: 


Replaced value:
```sqf
0.000001
```
File: [host\NOEngine\NOEngine_SharedTransportLevel.hpp at line 22](../../../Src/host/NOEngine/NOEngine_SharedTransportLevel.hpp#L22)
## radioObj_false

Type: constant

Description: 


Replaced value:
```sqf
0
```
File: [host\NOEngine\NOEngine_SharedTransportLevel.hpp at line 23](../../../Src/host/NOEngine/NOEngine_SharedTransportLevel.hpp#L23)
## transportFlagsToArray(fl)

Type: constant

Description: 
- Param: fl

Replaced value:
```sqf
(fl toFixed __COUNT_ELEMENTS_DATA_TRANSPORT__ splitString "")
```
File: [host\NOEngine\NOEngine_SharedTransportLevel.hpp at line 25](../../../Src/host/NOEngine/NOEngine_SharedTransportLevel.hpp#L25)
