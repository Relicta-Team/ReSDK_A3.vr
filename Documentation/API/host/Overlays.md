# overlay.hpp

## OVERLAY_LAYER_HEAD

Type: constant

Description: слои отображения


Replaced value:
```sqf
0
```
File: [host\Overlays\overlay.hpp at line 7](../../../Src/host/Overlays/overlay.hpp#L7)
## OVERLAY_LAYER_FACE

Type: constant

Description: 


Replaced value:
```sqf
1
```
File: [host\Overlays\overlay.hpp at line 8](../../../Src/host/Overlays/overlay.hpp#L8)
## OVERLAY_LAYER_BODY

Type: constant

Description: 


Replaced value:
```sqf
2
```
File: [host\Overlays\overlay.hpp at line 9](../../../Src/host/Overlays/overlay.hpp#L9)
## OVERLAY_LAYER_ARMOR

Type: constant

Description: 


Replaced value:
```sqf
3
```
File: [host\Overlays\overlay.hpp at line 10](../../../Src/host/Overlays/overlay.hpp#L10)
## OVERLAY_LAYER_BACKPACK

Type: constant

Description: 


Replaced value:
```sqf
4
```
File: [host\Overlays\overlay.hpp at line 11](../../../Src/host/Overlays/overlay.hpp#L11)
## OVERLAY_LAYER_LIST_ALL

Type: constant

Description: 


Replaced value:
```sqf
[OVERLAY_LAYER_HEAD,OVERLAY_LAYER_FACE,OVERLAY_LAYER_BODY,OVERLAY_LAYER_ARMOR,OVERLAY_LAYER_BACKPACK]
```
File: [host\Overlays\overlay.hpp at line 13](../../../Src/host/Overlays/overlay.hpp#L13)
## OVERLAY_GROUP_KEY_CURRENT

Type: constant

Description: 


Replaced value:
```sqf
"currentOverlay"
```
File: [host\Overlays\overlay.hpp at line 15](../../../Src/host/Overlays/overlay.hpp#L15)
## OVERLAY_PRIORITY_BASE

Type: constant

Description: 


Replaced value:
```sqf
0
```
File: [host\Overlays\overlay.hpp at line 23](../../../Src/host/Overlays/overlay.hpp#L23)
## OVERLAY_PRIORITY_NORMAL

Type: constant

Description: 


Replaced value:
```sqf
1
```
File: [host\Overlays\overlay.hpp at line 24](../../../Src/host/Overlays/overlay.hpp#L24)
## OVERLAY_PRIORITY_EXTERNAL

Type: constant

Description: 


Replaced value:
```sqf
2
```
File: [host\Overlays\overlay.hpp at line 25](../../../Src/host/Overlays/overlay.hpp#L25)
# overlays_init.sqf

## overlay_makeLayerGroup

Type: function

Description: создает группу слоя для отображения


File: [host\Overlays\overlays_init.sqf at line 24](../../../Src/host/Overlays/overlays_init.sqf#L24)
## overlay_register

Type: function

Description: Добавляет оверлей в слой отображения
- Param: _mob
- Param: _overlay

File: [host\Overlays\overlays_init.sqf at line 36](../../../Src/host/Overlays/overlays_init.sqf#L36)
## overlay_unregister

Type: function

Description: Удаляет объект из слоя отображения
- Param: _mob
- Param: _overlay

File: [host\Overlays\overlays_init.sqf at line 67](../../../Src/host/Overlays/overlays_init.sqf#L67)
## overlay_internal_getVisibleLayer

Type: function

Description: 
- Param: _layerGroup

File: [host\Overlays\overlays_init.sqf at line 86](../../../Src/host/Overlays/overlays_init.sqf#L86)
## overlay_updateVisual

Type: function

Description: Обновляет визуальное отображение для данного слоя
- Param: _mob
- Param: _layerId

File: [host\Overlays\overlays_init.sqf at line 107](../../../Src/host/Overlays/overlays_init.sqf#L107)
## overlay_resetEquipmentByLayerId

Type: function

Description: 
- Param: _mob
- Param: _layerId

File: [host\Overlays\overlays_init.sqf at line 151](../../../Src/host/Overlays/overlays_init.sqf#L151)
