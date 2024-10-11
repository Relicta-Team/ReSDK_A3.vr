# DynamicMapLoader.sqf

## deserializeHashData(val)

Type: constant

Description: 
- Param: val

Replaced value:
```sqf
(call (call compile val))
```
File: [host\MapManager\DynamicMapLoader.sqf at line 193](../../../Src/host/MapManager/DynamicMapLoader.sqf#L193)
## sizeof_float

Type: constant

Description: 


Replaced value:
```sqf
5
```
File: [host\MapManager\DynamicMapLoader.sqf at line 194](../../../Src/host/MapManager/DynamicMapLoader.sqf#L194)
## dml_const_enum_instancerNames

Type: Variable

Description: 


Initial value:
```sqf
["InitItem","InitStruct","InitDecor"]
```
File: [host\MapManager\DynamicMapLoader.sqf at line 167](../../../Src/host/MapManager/DynamicMapLoader.sqf#L167)
## dml_const_tab

Type: Variable

Description: 


Initial value:
```sqf
toString [9]
```
File: [host\MapManager\DynamicMapLoader.sqf at line 168](../../../Src/host/MapManager/DynamicMapLoader.sqf#L168)
## dml_internal_eulerToVec

Type: function

Description: https://github.com/CBATeam/CBA_A3/issues/1352#issuecomment-665343452
- Param: _rotation

File: [host\MapManager\DynamicMapLoader.sqf at line 59](../../../Src/host/MapManager/DynamicMapLoader.sqf#L59)
## dml_loadMap

Type: function

Description: загрузчик карты
- Param: _path

File: [host\MapManager\DynamicMapLoader.sqf at line 79](../../../Src/host/MapManager/DynamicMapLoader.sqf#L79)
## dml_parseMap

Type: function

Description: подготовка загрузочных инструкций
- Param: _mapPath

File: [host\MapManager\DynamicMapLoader.sqf at line 94](../../../Src/host/MapManager/DynamicMapLoader.sqf#L94)
## dml_prepareMapBuffer

Type: function

Description: 
- Param: _cfg
- Param: _bmap

File: [host\MapManager\DynamicMapLoader.sqf at line 116](../../../Src/host/MapManager/DynamicMapLoader.sqf#L116)
## dml_internal_addMapHeaders

Type: function

Description: 
- Param: _bmap

File: [host\MapManager\DynamicMapLoader.sqf at line 134](../../../Src/host/MapManager/DynamicMapLoader.sqf#L134)
## reditor_binding_fc

Type: function

Description: 
- Param: _o

File: [host\MapManager\DynamicMapLoader.sqf at line 140](../../../Src/host/MapManager/DynamicMapLoader.sqf#L140)
## reditor_binding_gv

Type: function

Description: 
- Param: _o

File: [host\MapManager\DynamicMapLoader.sqf at line 149](../../../Src/host/MapManager/DynamicMapLoader.sqf#L149)
## reditor_binding_sv

Type: function

Description: 
- Param: _o

File: [host\MapManager\DynamicMapLoader.sqf at line 154](../../../Src/host/MapManager/DynamicMapLoader.sqf#L154)
## reditor_binding_gref

Type: function

Description: 
- Param: _o

File: [host\MapManager\DynamicMapLoader.sqf at line 159](../../../Src/host/MapManager/DynamicMapLoader.sqf#L159)
## dml_internal_handleObj

Type: function

Description: 
- Param: _mapDat
- Param: _bmap

File: [host\MapManager\DynamicMapLoader.sqf at line 170](../../../Src/host/MapManager/DynamicMapLoader.sqf#L170)
# map_manager.sqf

## mapmanager_savemap

Type: function

Description: 


File: [host\MapManager\map_manager.sqf at line 13](../../../Src/host/MapManager/map_manager.sqf#L13)
## MapManager_loadmap

Type: function

Description: deprecated loader
- Param: _mappath

File: [host\MapManager\map_manager.sqf at line 44](../../../Src/host/MapManager/map_manager.sqf#L44)
## mapManager_collectAllGameObjects

Type: function

Description: 


File: [host\MapManager\map_manager.sqf at line 65](../../../Src/host/MapManager/map_manager.sqf#L65)
## mapManager_load

Type: function

Description: ["Map1"] call mapManager_load; (allUnits select (allUnits findif {isPlayer _x}) setposatl [3714.46,3722.83,40.1354])
- Param: _path

File: [host\MapManager\map_manager.sqf at line 115](../../../Src/host/MapManager/map_manager.sqf#L115)
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
# Army.sqf

## reditor_binding_fc

Type: function

Description: 
- Param: _o

File: [host\MapManager\Maps\Army.sqf at line 3](../../../Src/host/MapManager/Maps/Army.sqf#L3)
## reditor_binding_gv

Type: function

Description: 
- Param: _o

File: [host\MapManager\Maps\Army.sqf at line 12](../../../Src/host/MapManager/Maps/Army.sqf#L12)
## reditor_binding_sv

Type: function

Description: 
- Param: _o

File: [host\MapManager\Maps\Army.sqf at line 17](../../../Src/host/MapManager/Maps/Army.sqf#L17)
## reditor_binding_gref

Type: function

Description: 
- Param: _o

File: [host\MapManager\Maps\Army.sqf at line 22](../../../Src/host/MapManager/Maps/Army.sqf#L22)
# Barony.sqf

## reditor_binding_fc

Type: function

Description: 
- Param: _o

File: [host\MapManager\Maps\Barony.sqf at line 3](../../../Src/host/MapManager/Maps/Barony.sqf#L3)
## reditor_binding_gv

Type: function

Description: 
- Param: _o

File: [host\MapManager\Maps\Barony.sqf at line 12](../../../Src/host/MapManager/Maps/Barony.sqf#L12)
## reditor_binding_sv

Type: function

Description: 
- Param: _o

File: [host\MapManager\Maps\Barony.sqf at line 17](../../../Src/host/MapManager/Maps/Barony.sqf#L17)
## reditor_binding_gref

Type: function

Description: 
- Param: _o

File: [host\MapManager\Maps\Barony.sqf at line 22](../../../Src/host/MapManager/Maps/Barony.sqf#L22)
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
# Theatre.sqf

## reditor_binding_fc

Type: function

Description: 
- Param: _o

File: [host\MapManager\Maps\Theatre.sqf at line 3](../../../Src/host/MapManager/Maps/Theatre.sqf#L3)
## reditor_binding_gv

Type: function

Description: 
- Param: _o

File: [host\MapManager\Maps\Theatre.sqf at line 12](../../../Src/host/MapManager/Maps/Theatre.sqf#L12)
## reditor_binding_sv

Type: function

Description: 
- Param: _o

File: [host\MapManager\Maps\Theatre.sqf at line 17](../../../Src/host/MapManager/Maps/Theatre.sqf#L17)
## reditor_binding_gref

Type: function

Description: 
- Param: _o

File: [host\MapManager\Maps\Theatre.sqf at line 22](../../../Src/host/MapManager/Maps/Theatre.sqf#L22)
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
