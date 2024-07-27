# ConfigProxyItems.h

## __confiBuffer

Type: constant

Description: 


Replaced value:
```sqf
proxIt_configData
```
File: [client\ProxyItems\ConfigProxyItems.h at line 7](../../../Src/client/ProxyItems/ConfigProxyItems.h#L7)
## model(path)

Type: constant

Description: model(axe) ]; _cb sv [axe, [5,5,2,6]
- Param: path

Replaced value:
```sqf
]; _pit_loaded = _pit_loaded + 1; __confiBuffer setVariable [path call proxIt_prepName, createHashMapFromArray
```
File: [client\ProxyItems\ConfigProxyItems.h at line 12](../../../Src/client/ProxyItems/ConfigProxyItems.h#L12)
# ProxyItems.sqf

## proxIt_configData

Type: Variable

Description: 


Initial value:
```sqf
createObj
```
File: [client\ProxyItems\ProxyItems.sqf at line 9](../../../Src/client/ProxyItems/ProxyItems.sqf#L9)
## proxIt_vec

Type: Variable

Description: 


Initial value:
```sqf
[0,0,0]
```
File: [client\ProxyItems\ProxyItems.sqf at line 10](../../../Src/client/ProxyItems/ProxyItems.sqf#L10)
## proxIt_def

Type: Variable

Description: 


Initial value:
```sqf
[proxIt_vec,proxIt_vec]
```
File: [client\ProxyItems\ProxyItems.sqf at line 11](../../../Src/client/ProxyItems/ProxyItems.sqf#L11)
## proxIt_list_selections

Type: Variable

Description: 


Initial value:
```sqf
["spine3","spine3","head","rightshoulder","spine3","head","lefthand","pelvis","righthand"]
```
File: [client\ProxyItems\ProxyItems.sqf at line 12](../../../Src/client/ProxyItems/ProxyItems.sqf#L12)
## proxIt_canUseRProx

Type: Variable

Description: 


Initial value:
```sqf
false // переопределяется если скомпилирован RProx
```
File: [client\ProxyItems\ProxyItems.sqf at line 14](../../../Src/client/ProxyItems/ProxyItems.sqf#L14)
## proxIt_prepName

Type: function

Description: Подготавливает имя если указан класснейм
- Param: _modelPath

File: [client\ProxyItems\ProxyItems.sqf at line 17](../../../Src/client/ProxyItems/ProxyItems.sqf#L17)
## proxIt_updateModel

Type: function

Description: 
- Param: _mob
- Param: _object
- Param: _newselection

File: [client\ProxyItems\ProxyItems.sqf at line 40](../../../Src/client/ProxyItems/ProxyItems.sqf#L40)
## proxIt_loadConfig

Type: function

Description: 
- Param: _mob
- Param: _modelPathOrClass
- Param: _selectionId

File: [client\ProxyItems\ProxyItems.sqf at line 66](../../../Src/client/ProxyItems/ProxyItems.sqf#L66)
# RProx.sqf

## proxIt_canUseRProx

Type: Variable

Description: RProx is improvement proxy system for inventory slots


Initial value:
```sqf
true //переопределение
```
File: [client\ProxyItems\RProx.sqf at line 15](../../../Src/client/ProxyItems/RProx.sqf#L15)
## rprox_const_vec

Type: Variable

Description: переопределение


Initial value:
```sqf
[0,0,0]
```
File: [client\ProxyItems\RProx.sqf at line 17](../../../Src/client/ProxyItems/RProx.sqf#L17)
## rprox_const_vdu

Type: Variable

Description: 


Initial value:
```sqf
[rprox_const_vec,rprox_const_vec]
```
File: [client\ProxyItems\RProx.sqf at line 18](../../../Src/client/ProxyItems/RProx.sqf#L18)
## rprox_const_selections

Type: Variable

Description: 


Initial value:
```sqf
["spine3","spine3","head","rightshoulder","spine3","head","lefthand","pelvis","righthand"]
```
File: [client\ProxyItems\RProx.sqf at line 19](../../../Src/client/ProxyItems/RProx.sqf#L19)
## rprox_map_configs

Type: Variable

Description: 


Initial value:
```sqf
createHashMap //ключ - путь до модели (без префикса \), значение - карта селекшонов
```
File: [client\ProxyItems\RProx.sqf at line 21](../../../Src/client/ProxyItems/RProx.sqf#L21)
## rprox_loadConfig

Type: function

Description: загрузка модели на моба. Возвращает приаттаченный объект, objNull если не удалось создать
- Param: _mob
- Param: _modelPathOrClass
- Param: _selectionId

File: [client\ProxyItems\RProx.sqf at line 24](../../../Src/client/ProxyItems/RProx.sqf#L24)
## rprox_hasConfigForModel

Type: function

Description: 
- Param: _modOrCfg

File: [client\ProxyItems\RProx.sqf at line 69](../../../Src/client/ProxyItems/RProx.sqf#L69)
## rprox_updateModel

Type: function

Description: 
- Param: _mob
- Param: _object
- Param: _newselection

File: [client\ProxyItems\RProx.sqf at line 78](../../../Src/client/ProxyItems/RProx.sqf#L78)
## rprox_init

Type: function

Description: загрузчик конфигураций


File: [client\ProxyItems\RProx.sqf at line 84](../../../Src/client/ProxyItems/RProx.sqf#L84)
# RProx_def.h

## cfg(path)

Type: constant

Description: 
- Param: path

Replaced value:
```sqf
;_mvdata = [ path ]; _rprox_preload pushBack _mvdata; _mvdata pushBack 
```
File: [client\ProxyItems\RProx_def.h at line 6](../../../Src/client/ProxyItems/RProx_def.h#L6)
