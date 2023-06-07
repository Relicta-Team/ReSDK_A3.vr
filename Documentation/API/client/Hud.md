# Hud_init.sqf

## HUD_SIZE_X

Type: constant

Description: 


Replaced value:
```sqf
10
```
File: [client\Hud\Hud_init.sqf at line 12](../../../Src/client/Hud/Hud_init.sqf#L12)
## STAT_SIZE_H

Type: constant

Description: 


Replaced value:
```sqf
4
```
File: [client\Hud\Hud_init.sqf at line 14](../../../Src/client/Hud/Hud_init.sqf#L14)
## canVisibleAttribute(data)

Type: constant

Description: 
- Param: data

Replaced value:
```sqf
(data != "")
```
File: [client\Hud\Hud_init.sqf at line 16](../../../Src/client/Hud/Hud_init.sqf#L16)
## getWidgetVar(_w,var)

Type: constant

Description: 
- Param: _w
- Param: var

Replaced value:
```sqf
(_w getvariable #var)
```
File: [client\Hud\Hud_init.sqf at line 18](../../../Src/client/Hud/Hud_init.sqf#L18)
## setWidgetVar(_w,var,val)

Type: constant

Description: 
- Param: _w
- Param: var
- Param: val

Replaced value:
```sqf
_w setVariable [#var,val]
```
File: [client\Hud\Hud_init.sqf at line 19](../../../Src/client/Hud/Hud_init.sqf#L19)
## LIGHT_NO

Type: constant

Description: 


Replaced value:
```sqf
0
```
File: [client\Hud\Hud_init.sqf at line 61](../../../Src/client/Hud/Hud_init.sqf#L61)
## LIGHT_LOW

Type: constant

Description: 


Replaced value:
```sqf
1
```
File: [client\Hud\Hud_init.sqf at line 62](../../../Src/client/Hud/Hud_init.sqf#L62)
## LIGHT_MEDIUM

Type: constant

Description: 


Replaced value:
```sqf
2
```
File: [client\Hud\Hud_init.sqf at line 63](../../../Src/client/Hud/Hud_init.sqf#L63)
## LIGHT_LARGE

Type: constant

Description: 


Replaced value:
```sqf
3
```
File: [client\Hud\Hud_init.sqf at line 64](../../../Src/client/Hud/Hud_init.sqf#L64)
## LIGHT_FULL

Type: constant

Description: 


Replaced value:
```sqf
4
```
File: [client\Hud\Hud_init.sqf at line 65](../../../Src/client/Hud/Hud_init.sqf#L65)
## hud_combStyle_onCombatUpdate

Type: function

Description: 


File: [client\Hud\Hud_init.sqf at line 73](../../../Src/client/Hud/Hud_init.sqf#L73)
## hud_combatMode_sync

Type: function

Description: 


File: [client\Hud\Hud_init.sqf at line 89](../../../Src/client/Hud/Hud_init.sqf#L89)
## hud_specAct_update

Type: function

Description: вызывается при обновлении спец.кнопок.


File: [client\Hud\Hud_init.sqf at line 100](../../../Src/client/Hud/Hud_init.sqf#L100)
## hud_updateTimestamp

Type: function

Description: 


File: [client\Hud\Hud_init.sqf at line 122](../../../Src/client/Hud/Hud_init.sqf#L122)
## hud_hide_reset

Type: function

Description: Восстановить худ
- Param: _enableLock (optional, default false)
- Param: _lockProcess (optional, default false)

File: [client\Hud\Hud_init.sqf at line 127](../../../Src/client/Hud/Hud_init.sqf#L127)
## hud_recalculateStat

Type: function

Description: 
- Param: _name

File: [client\Hud\Hud_init.sqf at line 140](../../../Src/client/Hud/Hud_init.sqf#L140)
## hud_cleanup

Type: function

Description: очистка худа - сброс всех переменных на стандартные значения


File: [client\Hud\Hud_init.sqf at line 147](../../../Src/client/Hud/Hud_init.sqf#L147)
## hud_init

Type: function

Description: 


File: [client\Hud\Hud_init.sqf at line 153](../../../Src/client/Hud/Hud_init.sqf#L153)
## hud_onUpdate

Type: function

Description: 


File: [client\Hud\Hud_init.sqf at line 208](../../../Src/client/Hud/Hud_init.sqf#L208)
