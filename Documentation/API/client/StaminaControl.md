# Stamina.hpp

## stamina_bias_x

Type: constant

Description: 


Replaced value:
```sqf
1
```
File: [client\StaminaControl\Stamina.hpp at line 13](../../../Src/client/StaminaControl/Stamina.hpp#L13)
## stamina_bias_y

Type: constant

Description: 


Replaced value:
```sqf
1
```
File: [client\StaminaControl\Stamina.hpp at line 15](../../../Src/client/StaminaControl/Stamina.hpp#L15)
## stamina_size_h

Type: constant

Description: 


Replaced value:
```sqf
2
```
File: [client\StaminaControl\Stamina.hpp at line 18](../../../Src/client/StaminaControl/Stamina.hpp#L18)
## stamina_size_w

Type: constant

Description: 


Replaced value:
```sqf
20
```
File: [client\StaminaControl\Stamina.hpp at line 20](../../../Src/client/StaminaControl/Stamina.hpp#L20)
## stamina_border_size_x

Type: constant

Description: 


Replaced value:
```sqf
1
```
File: [client\StaminaControl\Stamina.hpp at line 23](../../../Src/client/StaminaControl/Stamina.hpp#L23)
## stamina_border_size_y

Type: constant

Description: 


Replaced value:
```sqf
15
```
File: [client\StaminaControl\Stamina.hpp at line 25](../../../Src/client/StaminaControl/Stamina.hpp#L25)
## stamina_mainbar_size_h

Type: constant

Description: 


Replaced value:
```sqf
50
```
File: [client\StaminaControl\Stamina.hpp at line 28](../../../Src/client/StaminaControl/Stamina.hpp#L28)
## getMainBar

Type: constant

Description: 


Replaced value:
```sqf
(stamina_widgets select 0)
```
File: [client\StaminaControl\Stamina.hpp at line 31](../../../Src/client/StaminaControl/Stamina.hpp#L31)
## getBackroundBar

Type: constant

Description: 


Replaced value:
```sqf
(stamina_widgets select 1)
```
File: [client\StaminaControl\Stamina.hpp at line 33](../../../Src/client/StaminaControl/Stamina.hpp#L33)
## getCtgBar

Type: constant

Description: 


Replaced value:
```sqf
(stamina_widgets select 2)
```
File: [client\StaminaControl\Stamina.hpp at line 35](../../../Src/client/StaminaControl/Stamina.hpp#L35)
## getLowValueBar

Type: constant

Description: 


Replaced value:
```sqf
(stamina_widgets select 3)
```
File: [client\StaminaControl\Stamina.hpp at line 37](../../../Src/client/StaminaControl/Stamina.hpp#L37)
## stamina_widgetUpdate

Type: constant

Description: 


Replaced value:
```sqf
0.12
```
File: [client\StaminaControl\Stamina.hpp at line 40](../../../Src/client/StaminaControl/Stamina.hpp#L40)
## stamina_fadetime_mainctg

Type: constant

Description: 


Replaced value:
```sqf
0.5
```
File: [client\StaminaControl\Stamina.hpp at line 43](../../../Src/client/StaminaControl/Stamina.hpp#L43)
# Stamina.sqf

## stamina_init

Type: function

Description: 
- Param: _wid
- Param: _ctg

File: [client\StaminaControl\Stamina.sqf at line 13](../../../Src/client/StaminaControl/Stamina.sqf#L13)
## stamina_onUpdate

Type: function

Description: 


File: [client\StaminaControl\Stamina.sqf at line 62](../../../Src/client/StaminaControl/Stamina.sqf#L62)
## stamina_setValue

Type: function

Description: 
- Param: _val

File: [client\StaminaControl\Stamina.sqf at line 99](../../../Src/client/StaminaControl/Stamina.sqf#L99)
## stamina_convCurToPrec

Type: function

Description: 


File: [client\StaminaControl\Stamina.sqf at line 107](../../../Src/client/StaminaControl/Stamina.sqf#L107)
## stamina_syncVisual

Type: function

Description: 


File: [client\StaminaControl\Stamina.sqf at line 112](../../../Src/client/StaminaControl/Stamina.sqf#L112)
## stamina_applyColorTheme

Type: function

Description: 


File: [client\StaminaControl\Stamina.sqf at line 118](../../../Src/client/StaminaControl/Stamina.sqf#L118)
# Stamina_init.sqf

## stamina_widgets

Type: Variable

Description: 


Initial value:
```sqf
[]
```
File: [client\StaminaControl\Stamina_init.sqf at line 16](../../../Src/client/StaminaControl/Stamina_init.sqf#L16)
## stamina_mainHandle

Type: Variable

Description: 


Initial value:
```sqf
-1
```
File: [client\StaminaControl\Stamina_init.sqf at line 18](../../../Src/client/StaminaControl/Stamina_init.sqf#L18)
## stamina_heartbeatHandle

Type: Variable

Description: 


Initial value:
```sqf
-1
```
File: [client\StaminaControl\Stamina_init.sqf at line 20](../../../Src/client/StaminaControl/Stamina_init.sqf#L20)
## stamina_lastVal

Type: Variable

Description: 


Initial value:
```sqf
-1
```
File: [client\StaminaControl\Stamina_init.sqf at line 22](../../../Src/client/StaminaControl/Stamina_init.sqf#L22)
## stamina_lastFullTime

Type: Variable

Description: 


Initial value:
```sqf
-1 //отметка времени последнего полного заполнения стамины
```
File: [client\StaminaControl\Stamina_init.sqf at line 24](../../../Src/client/StaminaControl/Stamina_init.sqf#L24)
