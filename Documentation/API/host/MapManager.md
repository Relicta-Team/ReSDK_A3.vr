# DynamicMapLoader.sqf

## deserializeHashData(val)

Type: constant

Description: 
- Param: val

Replaced value:
```sqf
(call (call compile val))
```
File: [host\MapManager\DynamicMapLoader.sqf at line 198](../../../Src/host/MapManager/DynamicMapLoader.sqf#L198)
## sizeof_float

Type: constant

Description: 


Replaced value:
```sqf
5
```
File: [host\MapManager\DynamicMapLoader.sqf at line 199](../../../Src/host/MapManager/DynamicMapLoader.sqf#L199)
## dml_const_zOffset

Type: Variable

Description: 


Initial value:
```sqf
6.04903
```
File: [host\MapManager\DynamicMapLoader.sqf at line 79](../../../Src/host/MapManager/DynamicMapLoader.sqf#L79)
## dml_const_enum_instancerNames

Type: Variable

Description: 


Initial value:
```sqf
["InitItem","InitStruct","InitDecor"]
```
File: [host\MapManager\DynamicMapLoader.sqf at line 168](../../../Src/host/MapManager/DynamicMapLoader.sqf#L168)
## dml_const_tab

Type: Variable

Description: 


Initial value:
```sqf
toString [9]
```
File: [host\MapManager\DynamicMapLoader.sqf at line 169](../../../Src/host/MapManager/DynamicMapLoader.sqf#L169)
## dml_internal_eulerToVec

Type: function

Description: https://github.com/CBATeam/CBA_A3/issues/1352#issuecomment-665343452
- Param: _rotation

File: [host\MapManager\DynamicMapLoader.sqf at line 60](../../../Src/host/MapManager/DynamicMapLoader.sqf#L60)
## dml_loadMap

Type: function

Description: загрузчик карты
- Param: _path

File: [host\MapManager\DynamicMapLoader.sqf at line 82](../../../Src/host/MapManager/DynamicMapLoader.sqf#L82)
## dml_parseMap

Type: function

Description: подготовка загрузочных инструкций
- Param: _mapPath

File: [host\MapManager\DynamicMapLoader.sqf at line 92](../../../Src/host/MapManager/DynamicMapLoader.sqf#L92)
## dml_prepareMapBuffer

Type: function

Description: 
- Param: _cfg
- Param: _bmap

File: [host\MapManager\DynamicMapLoader.sqf at line 114](../../../Src/host/MapManager/DynamicMapLoader.sqf#L114)
## dml_internal_addMapHeaders

Type: function

Description: 
- Param: _bmap

File: [host\MapManager\DynamicMapLoader.sqf at line 132](../../../Src/host/MapManager/DynamicMapLoader.sqf#L132)
## reditor_binding_fc

Type: function

Description: 
- Param: _o

File: [host\MapManager\DynamicMapLoader.sqf at line 139](../../../Src/host/MapManager/DynamicMapLoader.sqf#L139)
## reditor_binding_gv

Type: function

Description: 
- Param: _o

File: [host\MapManager\DynamicMapLoader.sqf at line 148](../../../Src/host/MapManager/DynamicMapLoader.sqf#L148)
## reditor_binding_sv

Type: function

Description: 
- Param: _o

File: [host\MapManager\DynamicMapLoader.sqf at line 153](../../../Src/host/MapManager/DynamicMapLoader.sqf#L153)
## reditor_binding_gref

Type: function

Description: 
- Param: _o

File: [host\MapManager\DynamicMapLoader.sqf at line 158](../../../Src/host/MapManager/DynamicMapLoader.sqf#L158)
## dml_internal_handleObj

Type: function

Description: 
- Param: _mapDat
- Param: _bmap

File: [host\MapManager\DynamicMapLoader.sqf at line 171](../../../Src/host/MapManager/DynamicMapLoader.sqf#L171)
# map_manager.sqf

## mapmanager_minMapVersion

Type: Variable

Description: 


Initial value:
```sqf
5
```
File: [host\MapManager\map_manager.sqf at line 13](../../../Src/host/MapManager/map_manager.sqf#L13)
## mapmanager_savemap

Type: function

Description: 


File: [host\MapManager\map_manager.sqf at line 15](../../../Src/host/MapManager/map_manager.sqf#L15)
## MapManager_loadmap

Type: function

Description: deprecated loader
- Param: _mappath

File: [host\MapManager\map_manager.sqf at line 46](../../../Src/host/MapManager/map_manager.sqf#L46)
## mapManager_collectAllGameObjects

Type: function

Description: 


File: [host\MapManager\map_manager.sqf at line 67](../../../Src/host/MapManager/map_manager.sqf#L67)
## mapManager_load

Type: function

Description: ["Map1"] call mapManager_load; (allUnits select (allUnits findif {isPlayer _x}) setposatl [3714.46,3722.83,40.1354])
- Param: _path

File: [host\MapManager\map_manager.sqf at line 117](../../../Src/host/MapManager/map_manager.sqf#L117)
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
# GryaznoyamskV2.sqf

## reditor_binding_fc

Type: function

Description: 
- Param: _o

File: [host\MapManager\Maps\GryaznoyamskV2.sqf at line 3](../../../Src/host/MapManager/Maps/GryaznoyamskV2.sqf#L3)
## reditor_binding_gv

Type: function

Description: 
- Param: _o

File: [host\MapManager\Maps\GryaznoyamskV2.sqf at line 12](../../../Src/host/MapManager/Maps/GryaznoyamskV2.sqf#L12)
## reditor_binding_sv

Type: function

Description: 
- Param: _o

File: [host\MapManager\Maps\GryaznoyamskV2.sqf at line 17](../../../Src/host/MapManager/Maps/GryaznoyamskV2.sqf#L17)
## reditor_binding_gref

Type: function

Description: 
- Param: _o

File: [host\MapManager\Maps\GryaznoyamskV2.sqf at line 22](../../../Src/host/MapManager/Maps/GryaznoyamskV2.sqf#L22)
# Holiday.sqf

## reditor_binding_fc

Type: function

Description: 
- Param: _o

File: [host\MapManager\Maps\Holiday.sqf at line 3](../../../Src/host/MapManager/Maps/Holiday.sqf#L3)
## reditor_binding_gv

Type: function

Description: 
- Param: _o

File: [host\MapManager\Maps\Holiday.sqf at line 12](../../../Src/host/MapManager/Maps/Holiday.sqf#L12)
## reditor_binding_sv

Type: function

Description: 
- Param: _o

File: [host\MapManager\Maps\Holiday.sqf at line 17](../../../Src/host/MapManager/Maps/Holiday.sqf#L17)
## reditor_binding_gref

Type: function

Description: 
- Param: _o

File: [host\MapManager\Maps\Holiday.sqf at line 22](../../../Src/host/MapManager/Maps/Holiday.sqf#L22)
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
# sp_guide.sqf

## reditor_binding_fc

Type: function

Description: 
- Param: _o

File: [host\MapManager\Maps\sp_guide.sqf at line 3](../../../Src/host/MapManager/Maps/sp_guide.sqf#L3)
## reditor_binding_gv

Type: function

Description: 
- Param: _o

File: [host\MapManager\Maps\sp_guide.sqf at line 12](../../../Src/host/MapManager/Maps/sp_guide.sqf#L12)
## reditor_binding_sv

Type: function

Description: 
- Param: _o

File: [host\MapManager\Maps\sp_guide.sqf at line 17](../../../Src/host/MapManager/Maps/sp_guide.sqf#L17)
## reditor_binding_gref

Type: function

Description: 
- Param: _o

File: [host\MapManager\Maps\sp_guide.sqf at line 22](../../../Src/host/MapManager/Maps/sp_guide.sqf#L22)
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
