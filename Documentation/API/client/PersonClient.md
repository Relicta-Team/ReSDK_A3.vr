# PersonClient_init.sqf

## personCli_rttCamera

Type: Variable

Description: рендер таргет камера


Initial value:
```sqf
"camera" camCreate [0,0,0] //камера для рендеринга
```
File: [client\PersonClient\PersonClient_init.sqf at line 21](../../../Src/client/PersonClient/PersonClient_init.sqf#L21)
## personCli_rttLight

Type: Variable

Description: источник освещения для камеры


Initial value:
```sqf
objNull
```
File: [client\PersonClient\PersonClient_init.sqf at line 23](../../../Src/client/PersonClient/PersonClient_init.sqf#L23)
## personCli_dummyObjFloor

Type: Variable

Description: 


Initial value:
```sqf
objNull
```
File: [client\PersonClient\PersonClient_init.sqf at line 25](../../../Src/client/PersonClient/PersonClient_init.sqf#L25)
## personCli_updateNeed

Type: Variable

Description: Переменная рассылается сервером
 Вариант использования обработчика entityCreated рассматривался но возможно это вызовет куда большие проблемы нагрузки на клиент


Initial value:
```sqf
false
```
File: [client\PersonClient\PersonClient_init.sqf at line 31](../../../Src/client/PersonClient/PersonClient_init.sqf#L31)
## personCli_const_list_allSettings

Type: Variable

Description: список доступных опций персоны для изменения


Initial value:
```sqf
[...
```
File: [client\PersonClient\PersonClient_init.sqf at line 135](../../../Src/client/PersonClient/PersonClient_init.sqf#L135)
## personCli_const_cPosList

Type: Variable

Description: дистанция от камеры до цели (используется только для персонажных объектов (все кроме obj))


Initial value:
```sqf
[[0,6,0],[0,4,0],[0,3,0],[0,2.5,0],[0,2,0],[0,1,0]]
```
File: [client\PersonClient\PersonClient_init.sqf at line 174](../../../Src/client/PersonClient/PersonClient_init.sqf#L174)
## personCli_const_cPosTargetList

Type: Variable

Description: таргет позиция камеры для персонажных объектов (все кроме obj)


Initial value:
```sqf
[[0.1,0,-0.3],[0,0.05,-0.11],[0,-0.2,-0.05],[-0.05,-0.05,0.10],[-0.07,-0.1,0.1],[0,0,0]]
```
File: [client\PersonClient\PersonClient_init.sqf at line 176](../../../Src/client/PersonClient/PersonClient_init.sqf#L176)
## personCli_const_cFlag

Type: Variable

Description: флаги для определения типа визуализации


Initial value:
```sqf
["cloth","armor","backpack","mask","helmet","obj"]
```
File: [client\PersonClient\PersonClient_init.sqf at line 178](../../../Src/client/PersonClient/PersonClient_init.sqf#L178)
## personCli_const_cSelections

Type: Variable

Description: кости персонажа для определения позиции визуализации


Initial value:
```sqf
["spine2","spine3","spine3","head","head",null]
```
File: [client\PersonClient\PersonClient_init.sqf at line 180](../../../Src/client/PersonClient/PersonClient_init.sqf#L180)
## personCli_internal_refLock

Type: Variable

Description: 


Initial value:
```sqf
refcreate(false)
```
File: [client\PersonClient\PersonClient_init.sqf at line 267](../../../Src/client/PersonClient/PersonClient_init.sqf#L267)
## personCli_internal_const_listEmptyTexmat

Type: Variable

Description: 


Initial value:
```sqf
["","","",""] //пустой константный массив для сравнения
```
File: [client\PersonClient\PersonClient_init.sqf at line 268](../../../Src/client/PersonClient/PersonClient_init.sqf#L268)
## personCli_internal_threadHandle

Type: Variable

Description: 


Initial value:
```sqf
startUpdate(personCli_onUpdate,0)
```
File: [client\PersonClient\PersonClient_init.sqf at line 276](../../../Src/client/PersonClient/PersonClient_init.sqf#L276)
## personCli_getAllMobs

Type: function

Description: получает всех мобов


File: [client\PersonClient\PersonClient_init.sqf at line 34](../../../Src/client/PersonClient/PersonClient_init.sqf#L34)
## personCli_onUpdate

Type: function

Description: тред регулярного обновления и синхронизации видимости


File: [client\PersonClient\PersonClient_init.sqf at line 39](../../../Src/client/PersonClient/PersonClient_init.sqf#L39)
## personCli_getLocalMob

Type: function

Description: получает локальную персону для клиента


File: [client\PersonClient\PersonClient_init.sqf at line 47](../../../Src/client/PersonClient/PersonClient_init.sqf#L47)
## personCli_getLocalObject

Type: function

Description: 


File: [client\PersonClient\PersonClient_init.sqf at line 51](../../../Src/client/PersonClient/PersonClient_init.sqf#L51)
## personCli_syncLocalVisibility

Type: function

Description: синхронизация видимости. мы видим только свою локальную персону.


File: [client\PersonClient\PersonClient_init.sqf at line 66](../../../Src/client/PersonClient/PersonClient_init.sqf#L66)
## personCli_setStat

Type: function

Description: установка опции локального клиента
- Param: _stateName
- Param: _val (optional, default "")

File: [client\PersonClient\PersonClient_init.sqf at line 77](../../../Src/client/PersonClient/PersonClient_init.sqf#L77)
## personCli_clearInventory

Type: function

Description: очищает инвентарь, лицо и все объекты на сцене


File: [client\PersonClient\PersonClient_init.sqf at line 145](../../../Src/client/PersonClient/PersonClient_init.sqf#L145)
## personCli_setCameraPos

Type: function

Description: установка позиции камеры. _applyLightPos - синхронизировать ли позицию света
- Param: _pos
- Param: _applyLightPos (optional, default true)

File: [client\PersonClient\PersonClient_init.sqf at line 161](../../../Src/client/PersonClient/PersonClient_init.sqf#L161)
## personCli_cloneCharVisualFromPlayer

Type: function

Description: 


File: [client\PersonClient\PersonClient_init.sqf at line 169](../../../Src/client/PersonClient/PersonClient_init.sqf#L169)
## personCli_prepCamera

Type: function

Description: 
- Param: _fov (optional, default 0.16)
- Param: _specFlag (optional, default "cloth")
- Param: _pureVisual (optional, default true)

File: [client\PersonClient\PersonClient_init.sqf at line 188](../../../Src/client/PersonClient/PersonClient_init.sqf#L188)
## personCli_setPictureRenderTarget

Type: function

Description: установка текстуры рендерт таргета
- Param: _pic

File: [client\PersonClient\PersonClient_init.sqf at line 271](../../../Src/client/PersonClient/PersonClient_init.sqf#L271)
