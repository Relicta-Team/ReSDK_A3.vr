# map_manager.sqf

## mapmanager_savemap

Type: function

Description: 


File: [host\MapManager\map_manager.sqf at line 12](../../../Src/host/MapManager/map_manager.sqf#L12)
## MapManager_loadmap

Type: function

Description: deprecated loader
- Param: _mappath

File: [host\MapManager\map_manager.sqf at line 43](../../../Src/host/MapManager/map_manager.sqf#L43)
## mapManager_collectAllGameObjects

Type: function

Description: 


File: [host\MapManager\map_manager.sqf at line 64](../../../Src/host/MapManager/map_manager.sqf#L64)
## mapManager_load

Type: function

Description: ["Map1"] call mapManager_load; (allUnits select (allUnits findif {isPlayer _x}) setposatl [3714.46,3722.83,40.1354])
- Param: _path

File: [host\MapManager\map_manager.sqf at line 114](../../../Src/host/MapManager/map_manager.sqf#L114)
# ObjectManager.sqf

## doPhisicsLog

Type: constant

Description: 


Replaced value:
```sqf

```
File: [host\MapManager\ObjectManager.sqf at line 13](../../../Src/host/MapManager/ObjectManager.sqf#L13)
## simlog(data)

Type: constant

> Exists if **doPhisicsLog** defined

Description: 
- Param: data

Replaced value:
```sqf

```
File: [host\MapManager\ObjectManager.sqf at line 18](../../../Src/host/MapManager/ObjectManager.sqf#L18)
## simlogf(data,ft)

Type: constant

> Exists if **doPhisicsLog** defined

Description: 
- Param: data
- Param: ft

Replaced value:
```sqf
traceformat("[simulatePhysics]:	"+ data,ft)
```
File: [host\MapManager\ObjectManager.sqf at line 18](../../../Src/host/MapManager/ObjectManager.sqf#L18)
## simlogf(data,ft)

Type: constant

> Exists if **doPhisicsLog** not defined

Description: 
- Param: data
- Param: ft

Replaced value:
```sqf

```
File: [host\MapManager\ObjectManager.sqf at line 21](../../../Src/host/MapManager/ObjectManager.sqf#L21)
## simulatePhysicsOnVisualObject

Type: function

Description: Алгоритм симуляции падения объектов.
- Param: _src

File: [host\MapManager\ObjectManager.sqf at line 10](../../../Src/host/MapManager/ObjectManager.sqf#L10)
# detective.sqf

## reditor_binding_fc

Type: function

Description: 
- Param: _o

File: [host\MapManager\Maps\detective.sqf at line 3](../../../Src/host/MapManager/Maps/detective.sqf#L3)
## reditor_binding_gv

Type: function

Description: 
- Param: _o

File: [host\MapManager\Maps\detective.sqf at line 12](../../../Src/host/MapManager/Maps/detective.sqf#L12)
## reditor_binding_sv

Type: function

Description: 
- Param: _o

File: [host\MapManager\Maps\detective.sqf at line 17](../../../Src/host/MapManager/Maps/detective.sqf#L17)
## reditor_binding_gref

Type: function

Description: 
- Param: _o

File: [host\MapManager\Maps\detective.sqf at line 22](../../../Src/host/MapManager/Maps/detective.sqf#L22)
# Dorm.sqf

## reditor_binding_fc

Type: function

Description: 
- Param: _o

File: [host\MapManager\Maps\Dorm.sqf at line 3](../../../Src/host/MapManager/Maps/Dorm.sqf#L3)
## reditor_binding_gv

Type: function

Description: 
- Param: _o

File: [host\MapManager\Maps\Dorm.sqf at line 12](../../../Src/host/MapManager/Maps/Dorm.sqf#L12)
## reditor_binding_sv

Type: function

Description: 
- Param: _o

File: [host\MapManager\Maps\Dorm.sqf at line 17](../../../Src/host/MapManager/Maps/Dorm.sqf#L17)
## reditor_binding_gref

Type: function

Description: 
- Param: _o

File: [host\MapManager\Maps\Dorm.sqf at line 22](../../../Src/host/MapManager/Maps/Dorm.sqf#L22)
# Hunt.sqf

## reditor_binding_fc

Type: function

Description: 
- Param: _o

File: [host\MapManager\Maps\Hunt.sqf at line 3](../../../Src/host/MapManager/Maps/Hunt.sqf#L3)
## reditor_binding_gv

Type: function

Description: 
- Param: _o

File: [host\MapManager\Maps\Hunt.sqf at line 12](../../../Src/host/MapManager/Maps/Hunt.sqf#L12)
## reditor_binding_sv

Type: function

Description: 
- Param: _o

File: [host\MapManager\Maps\Hunt.sqf at line 17](../../../Src/host/MapManager/Maps/Hunt.sqf#L17)
## reditor_binding_gref

Type: function

Description: 
- Param: _o

File: [host\MapManager\Maps\Hunt.sqf at line 22](../../../Src/host/MapManager/Maps/Hunt.sqf#L22)
# Minimap.sqf

## reditor_binding_fc

Type: function

Description: 
- Param: _o

File: [host\MapManager\Maps\Minimap.sqf at line 3](../../../Src/host/MapManager/Maps/Minimap.sqf#L3)
## reditor_binding_gv

Type: function

Description: 
- Param: _o

File: [host\MapManager\Maps\Minimap.sqf at line 12](../../../Src/host/MapManager/Maps/Minimap.sqf#L12)
## reditor_binding_sv

Type: function

Description: 
- Param: _o

File: [host\MapManager\Maps\Minimap.sqf at line 17](../../../Src/host/MapManager/Maps/Minimap.sqf#L17)
## reditor_binding_gref

Type: function

Description: 
- Param: _o

File: [host\MapManager\Maps\Minimap.sqf at line 22](../../../Src/host/MapManager/Maps/Minimap.sqf#L22)
# Nora.sqf

## reditor_binding_fc

Type: function

Description: 
- Param: _o

File: [host\MapManager\Maps\Nora.sqf at line 3](../../../Src/host/MapManager/Maps/Nora.sqf#L3)
## reditor_binding_gv

Type: function

Description: 
- Param: _o

File: [host\MapManager\Maps\Nora.sqf at line 12](../../../Src/host/MapManager/Maps/Nora.sqf#L12)
## reditor_binding_sv

Type: function

Description: 
- Param: _o

File: [host\MapManager\Maps\Nora.sqf at line 17](../../../Src/host/MapManager/Maps/Nora.sqf#L17)
## reditor_binding_gref

Type: function

Description: 
- Param: _o

File: [host\MapManager\Maps\Nora.sqf at line 22](../../../Src/host/MapManager/Maps/Nora.sqf#L22)
# Okopovo.sqf

## reditor_binding_fc

Type: function

Description: 
- Param: _o

File: [host\MapManager\Maps\Okopovo.sqf at line 3](../../../Src/host/MapManager/Maps/Okopovo.sqf#L3)
## reditor_binding_gv

Type: function

Description: 
- Param: _o

File: [host\MapManager\Maps\Okopovo.sqf at line 12](../../../Src/host/MapManager/Maps/Okopovo.sqf#L12)
## reditor_binding_sv

Type: function

Description: 
- Param: _o

File: [host\MapManager\Maps\Okopovo.sqf at line 17](../../../Src/host/MapManager/Maps/Okopovo.sqf#L17)
## reditor_binding_gref

Type: function

Description: 
- Param: _o

File: [host\MapManager\Maps\Okopovo.sqf at line 22](../../../Src/host/MapManager/Maps/Okopovo.sqf#L22)
# Saloon.sqf

## reditor_binding_fc

Type: function

Description: 
- Param: _o

File: [host\MapManager\Maps\Saloon.sqf at line 3](../../../Src/host/MapManager/Maps/Saloon.sqf#L3)
## reditor_binding_gv

Type: function

Description: 
- Param: _o

File: [host\MapManager\Maps\Saloon.sqf at line 12](../../../Src/host/MapManager/Maps/Saloon.sqf#L12)
## reditor_binding_sv

Type: function

Description: 
- Param: _o

File: [host\MapManager\Maps\Saloon.sqf at line 17](../../../Src/host/MapManager/Maps/Saloon.sqf#L17)
## reditor_binding_gref

Type: function

Description: 
- Param: _o

File: [host\MapManager\Maps\Saloon.sqf at line 22](../../../Src/host/MapManager/Maps/Saloon.sqf#L22)
# SaloonV2.sqf

## reditor_binding_fc

Type: function

Description: 
- Param: _o

File: [host\MapManager\Maps\SaloonV2.sqf at line 3](../../../Src/host/MapManager/Maps/SaloonV2.sqf#L3)
## reditor_binding_gv

Type: function

Description: 
- Param: _o

File: [host\MapManager\Maps\SaloonV2.sqf at line 12](../../../Src/host/MapManager/Maps/SaloonV2.sqf#L12)
## reditor_binding_sv

Type: function

Description: 
- Param: _o

File: [host\MapManager\Maps\SaloonV2.sqf at line 17](../../../Src/host/MapManager/Maps/SaloonV2.sqf#L17)
## reditor_binding_gref

Type: function

Description: 
- Param: _o

File: [host\MapManager\Maps\SaloonV2.sqf at line 22](../../../Src/host/MapManager/Maps/SaloonV2.sqf#L22)
# Template.sqf

## reditor_binding_fc

Type: function

Description: 
- Param: _o

File: [host\MapManager\Maps\Template.sqf at line 3](../../../Src/host/MapManager/Maps/Template.sqf#L3)
## reditor_binding_gv

Type: function

Description: 
- Param: _o

File: [host\MapManager\Maps\Template.sqf at line 12](../../../Src/host/MapManager/Maps/Template.sqf#L12)
## reditor_binding_sv

Type: function

Description: 
- Param: _o

File: [host\MapManager\Maps\Template.sqf at line 17](../../../Src/host/MapManager/Maps/Template.sqf#L17)
## reditor_binding_gref

Type: function

Description: 
- Param: _o

File: [host\MapManager\Maps\Template.sqf at line 22](../../../Src/host/MapManager/Maps/Template.sqf#L22)
# Truba.sqf

## reditor_binding_fc

Type: function

Description: 
- Param: _o

File: [host\MapManager\Maps\Truba.sqf at line 3](../../../Src/host/MapManager/Maps/Truba.sqf#L3)
## reditor_binding_gv

Type: function

Description: 
- Param: _o

File: [host\MapManager\Maps\Truba.sqf at line 12](../../../Src/host/MapManager/Maps/Truba.sqf#L12)
## reditor_binding_sv

Type: function

Description: 
- Param: _o

File: [host\MapManager\Maps\Truba.sqf at line 17](../../../Src/host/MapManager/Maps/Truba.sqf#L17)
## reditor_binding_gref

Type: function

Description: 
- Param: _o

File: [host\MapManager\Maps\Truba.sqf at line 22](../../../Src/host/MapManager/Maps/Truba.sqf#L22)
