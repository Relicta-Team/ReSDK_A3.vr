# ConfigProxyItems.h

## __confiBuffer

Type: constant
Description: ======================================================


Replaced value:
```sqf
proxIt_configData
```
File: [client\ProxyItems\ConfigProxyItems.h at line 7](../../../src/client/ProxyItems/ConfigProxyItems.h#L7)
## model(path)

Type: constant
Description: model(axe) ]; _cb sv [axe, [5,5,2,6]
- Param: path

Replaced value:
```sqf
]; _pit_loaded = _pit_loaded + 1; __confiBuffer setVariable [path call proxIt_prepName, createHashMapFromArray
```
File: [client\ProxyItems\ConfigProxyItems.h at line 12](../../../src/client/ProxyItems/ConfigProxyItems.h#L12)
# ProxyItems.sqf

## proxIt_prepName

Type: function
Description: Подготавливает имя если указан класснейм
- Param: _modelPath

File: [client\ProxyItems\ProxyItems.sqf at line 15](../../../src/client/ProxyItems/ProxyItems.sqf#L15)
## proxIt_updateModel

Type: function
Description: 
- Param: _mob
- Param: _object
- Param: _newselection

File: [client\ProxyItems\ProxyItems.sqf at line 38](../../../src/client/ProxyItems/ProxyItems.sqf#L38)
## proxIt_loadConfig

Type: function
Description: 
- Param: _mob
- Param: _modelPathOrClass
- Param: _selectionId

File: [client\ProxyItems\ProxyItems.sqf at line 59](../../../src/client/ProxyItems/ProxyItems.sqf#L59)
