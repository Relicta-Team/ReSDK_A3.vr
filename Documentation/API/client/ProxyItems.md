# ConfigProxyItemsLoader.h

## __confiBuffer

Type: constant

Description: 


Replaced value:
```sqf
proxIt_configData
```
File: [client\ProxyItems\ConfigProxyItemsLoader.h at line 8](../../../Src/client/ProxyItems/ConfigProxyItemsLoader.h#L8)
## model(path)

Type: constant

Description: model(axe) ]; _cb sv [axe, [5,5,2,6]
- Param: path

Replaced value:
```sqf
]; __confiBuffer setVariable [path call proxIt_prepName, createHashMapFromArray
```
File: [client\ProxyItems\ConfigProxyItemsLoader.h at line 13](../../../Src/client/ProxyItems/ConfigProxyItemsLoader.h#L13)
# ProxyItems.sqf

## proxIt_configData

Type: Variable

Description: 


Initial value:
```sqf
createObj
```
File: [client\ProxyItems\ProxyItems.sqf at line 12](../../../Src/client/ProxyItems/ProxyItems.sqf#L12)
## proxIt_vec

Type: Variable

Description: 


Initial value:
```sqf
[0,0,0]
```
File: [client\ProxyItems\ProxyItems.sqf at line 14](../../../Src/client/ProxyItems/ProxyItems.sqf#L14)
## proxIt_def

Type: Variable

Description: 


Initial value:
```sqf
[proxIt_vec,proxIt_vec]
```
File: [client\ProxyItems\ProxyItems.sqf at line 16](../../../Src/client/ProxyItems/ProxyItems.sqf#L16)
## proxIt_list_selections

Type: Variable

Description: 


Initial value:
```sqf
["spine3","spine3","head","rightshoulder","spine3","head","lefthand","pelvis","righthand"]
```
File: [client\ProxyItems\ProxyItems.sqf at line 18](../../../Src/client/ProxyItems/ProxyItems.sqf#L18)
## proxIt_canUseRProx

Type: Variable

Description: 


Initial value:
```sqf
false // переопределяется если скомпилирован RProx
```
File: [client\ProxyItems\ProxyItems.sqf at line 21](../../../Src/client/ProxyItems/ProxyItems.sqf#L21)
## proxIt_prepName

Type: function

Description: 
- Param: _modelPath

File: [client\ProxyItems\ProxyItems.sqf at line 25](../../../Src/client/ProxyItems/ProxyItems.sqf#L25)
## proxIt_updateModel

Type: function

Description: 
- Param: _mob
- Param: _object
- Param: _newselection

File: [client\ProxyItems\ProxyItems.sqf at line 49](../../../Src/client/ProxyItems/ProxyItems.sqf#L49)
## proxIt_loadConfig

Type: function

Description: 
- Param: _mob
- Param: _modelPathOrClass
- Param: _selectionId

File: [client\ProxyItems\ProxyItems.sqf at line 77](../../../Src/client/ProxyItems/ProxyItems.sqf#L77)
# RProx.sqf

## rprox_const_vec

Type: Variable

Description: 


Initial value:
```sqf
[0,0,0]
```
File: [client\ProxyItems\RProx.sqf at line 18](../../../Src/client/ProxyItems/RProx.sqf#L18)
## rprox_const_vdu

Type: Variable

Description: 


Initial value:
```sqf
[rprox_const_vec,rprox_const_vec]
```
File: [client\ProxyItems\RProx.sqf at line 20](../../../Src/client/ProxyItems/RProx.sqf#L20)
## rprox_const_selections

Type: Variable

Description: 


Initial value:
```sqf
["spine3","spine3","head","rightshoulder","spine3","head","lefthand","pelvis","righthand"]
```
File: [client\ProxyItems\RProx.sqf at line 22](../../../Src/client/ProxyItems/RProx.sqf#L22)
## rprox_map_configs

Type: Variable

Description: 


Initial value:
```sqf
createHashMap //ключ - путь до модели (без префикса \), значение - карта селекшонов
```
File: [client\ProxyItems\RProx.sqf at line 25](../../../Src/client/ProxyItems/RProx.sqf#L25)
## rprox_loadConfig

Type: function

Description: 
- Param: _mob
- Param: _modelPathOrClass
- Param: _selectionId

File: [client\ProxyItems\RProx.sqf at line 29](../../../Src/client/ProxyItems/RProx.sqf#L29)
## rprox_hasConfigForModel

Type: function

Description: 
- Param: _modOrCfg

File: [client\ProxyItems\RProx.sqf at line 75](../../../Src/client/ProxyItems/RProx.sqf#L75)
## rprox_updateModel

Type: function

Description: 
- Param: _mob
- Param: _object
- Param: _newselection

File: [client\ProxyItems\RProx.sqf at line 85](../../../Src/client/ProxyItems/RProx.sqf#L85)
## rprox_init

Type: function

Description: 


File: [client\ProxyItems\RProx.sqf at line 92](../../../Src/client/ProxyItems/RProx.sqf#L92)
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
