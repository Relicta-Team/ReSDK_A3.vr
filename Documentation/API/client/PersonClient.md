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
File: [client\PersonClient\PersonClient_init.sqf at line 134](../../../Src/client/PersonClient/PersonClient_init.sqf#L134)
## personCli_const_cPosList

Type: Variable

Description: дистанция от камеры до цели (используется только для персонажных объектов (все кроме obj))


Initial value:
```sqf
[[0,6,0],[0,4,0],[0,3,0],[0,2.5,0],[0,2,0],[0,1,0]]
```
File: [client\PersonClient\PersonClient_init.sqf at line 173](../../../Src/client/PersonClient/PersonClient_init.sqf#L173)
## personCli_const_cPosTargetList

Type: Variable

Description: таргет позиция камеры для персонажных объектов (все кроме obj)


Initial value:
```sqf
[[0.1,0,-0.3],[0,0.05,-0.11],[0,-0.2,-0.05],[-0.05,-0.05,0.10],[-0.07,-0.1,0.1],[0,0,0]]
```
File: [client\PersonClient\PersonClient_init.sqf at line 175](../../../Src/client/PersonClient/PersonClient_init.sqf#L175)
## personCli_const_cFlag

Type: Variable

Description: флаги для определения типа визуализации


Initial value:
```sqf
["cloth","armor","backpack","mask","helmet","obj"]
```
File: [client\PersonClient\PersonClient_init.sqf at line 177](../../../Src/client/PersonClient/PersonClient_init.sqf#L177)
## personCli_const_cSelections

Type: Variable

Description: кости персонажа для определения позиции визуализации


Initial value:
```sqf
["spine2","spine3","spine3","head","head",null]
```
File: [client\PersonClient\PersonClient_init.sqf at line 179](../../../Src/client/PersonClient/PersonClient_init.sqf#L179)
## personCli_internal_threadHandle

Type: Variable

Description: 


Initial value:
```sqf
startUpdate(personCli_onUpdate,0)
```
File: [client\PersonClient\PersonClient_init.sqf at line 249](../../../Src/client/PersonClient/PersonClient_init.sqf#L249)
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

File: [client\PersonClient\PersonClient_init.sqf at line 76](../../../Src/client/PersonClient/PersonClient_init.sqf#L76)
## personCli_clearInventory

Type: function

Description: очищает инвентарь, лицо и все объекты на сцене


File: [client\PersonClient\PersonClient_init.sqf at line 144](../../../Src/client/PersonClient/PersonClient_init.sqf#L144)
## personCli_setCameraPos

Type: function

Description: установка позиции камеры. _applyLightPos - синхронизировать ли позицию света
- Param: _pos
- Param: _applyLightPos (optional, default true)

File: [client\PersonClient\PersonClient_init.sqf at line 160](../../../Src/client/PersonClient/PersonClient_init.sqf#L160)
## personCli_cloneCharVisualFromPlayer

Type: function

Description: 


File: [client\PersonClient\PersonClient_init.sqf at line 168](../../../Src/client/PersonClient/PersonClient_init.sqf#L168)
## personCli_prepCamera

Type: function

Description: 
- Param: _fov (optional, default 0.16)
- Param: _specFlag (optional, default "cloth")
- Param: _pureVisual (optional, default true)

File: [client\PersonClient\PersonClient_init.sqf at line 187](../../../Src/client/PersonClient/PersonClient_init.sqf#L187)
## personCli_setPictureRenderTarget

Type: function

Description: установка текстуры рендерт таргета
- Param: _pic

File: [client\PersonClient\PersonClient_init.sqf at line 244](../../../Src/client/PersonClient/PersonClient_init.sqf#L244)
