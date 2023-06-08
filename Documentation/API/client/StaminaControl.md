# Stamina.hpp

## stamina_bias_x

Type: constant

Description: #define stamina_debug


Replaced value:
```sqf
1
```
File: [client\StaminaControl\Stamina.hpp at line 10](../../../Src/client/StaminaControl/Stamina.hpp#L10)
## stamina_bias_y

Type: constant

Description: 


Replaced value:
```sqf
1
```
File: [client\StaminaControl\Stamina.hpp at line 11](../../../Src/client/StaminaControl/Stamina.hpp#L11)
## stamina_size_h

Type: constant

Description: 


Replaced value:
```sqf
2
```
File: [client\StaminaControl\Stamina.hpp at line 13](../../../Src/client/StaminaControl/Stamina.hpp#L13)
## stamina_size_w

Type: constant

Description: 


Replaced value:
```sqf
20
```
File: [client\StaminaControl\Stamina.hpp at line 14](../../../Src/client/StaminaControl/Stamina.hpp#L14)
## stamina_border_size_x

Type: constant

Description: 


Replaced value:
```sqf
1
```
File: [client\StaminaControl\Stamina.hpp at line 16](../../../Src/client/StaminaControl/Stamina.hpp#L16)
## stamina_border_size_y

Type: constant

Description: 


Replaced value:
```sqf
15
```
File: [client\StaminaControl\Stamina.hpp at line 17](../../../Src/client/StaminaControl/Stamina.hpp#L17)
## stamina_mainbar_size_h

Type: constant

Description: 


Replaced value:
```sqf
50
```
File: [client\StaminaControl\Stamina.hpp at line 19](../../../Src/client/StaminaControl/Stamina.hpp#L19)
## getMainBar

Type: constant

Description: 


Replaced value:
```sqf
(stamina_widgets select 0)
```
File: [client\StaminaControl\Stamina.hpp at line 21](../../../Src/client/StaminaControl/Stamina.hpp#L21)
## getBackroundBar

Type: constant

Description: 


Replaced value:
```sqf
(stamina_widgets select 1)
```
File: [client\StaminaControl\Stamina.hpp at line 22](../../../Src/client/StaminaControl/Stamina.hpp#L22)
## getCtgBar

Type: constant

Description: 


Replaced value:
```sqf
(stamina_widgets select 2)
```
File: [client\StaminaControl\Stamina.hpp at line 23](../../../Src/client/StaminaControl/Stamina.hpp#L23)
## getLowValueBar

Type: constant

Description: 


Replaced value:
```sqf
(stamina_widgets select 3)
```
File: [client\StaminaControl\Stamina.hpp at line 24](../../../Src/client/StaminaControl/Stamina.hpp#L24)
## stamina_widgetUpdate

Type: constant

Description: 


Replaced value:
```sqf
0.12
```
File: [client\StaminaControl\Stamina.hpp at line 26](../../../Src/client/StaminaControl/Stamina.hpp#L26)
## stamina_fadetime_mainctg

Type: constant

Description: 


Replaced value:
```sqf
0.5
```
File: [client\StaminaControl\Stamina.hpp at line 28](../../../Src/client/StaminaControl/Stamina.hpp#L28)
# Stamina.sqf

## stamina_init

Type: function

Description: 
- Param: _wid
- Param: _ctg

File: [client\StaminaControl\Stamina.sqf at line 11](../../../Src/client/StaminaControl/Stamina.sqf#L11)
## stamina_onUpdate

Type: function

Description: 


File: [client\StaminaControl\Stamina.sqf at line 59](../../../Src/client/StaminaControl/Stamina.sqf#L59)
## stamina_setValue

Type: function

Description: 
- Param: _val

File: [client\StaminaControl\Stamina.sqf at line 63](../../../Src/client/StaminaControl/Stamina.sqf#L63)
## stamina_convCurToPrec

Type: function

Description: 


File: [client\StaminaControl\Stamina.sqf at line 71](../../../Src/client/StaminaControl/Stamina.sqf#L71)
## stamina_syncVisual

Type: function

Description: 


File: [client\StaminaControl\Stamina.sqf at line 75](../../../Src/client/StaminaControl/Stamina.sqf#L75)
## stamina_applyColorTheme

Type: function

Description: 


File: [client\StaminaControl\Stamina.sqf at line 80](../../../Src/client/StaminaControl/Stamina.sqf#L80)
# Stamina_init.sqf

## stamina_widgets

Type: Variable

Description: 


Initial value:
```sqf
[]
```
File: [client\StaminaControl\Stamina_init.sqf at line 13](../../../Src/client/StaminaControl/Stamina_init.sqf#L13)
## stamina_mainHandle

Type: Variable

Description: 


Initial value:
```sqf
-1
```
File: [client\StaminaControl\Stamina_init.sqf at line 14](../../../Src/client/StaminaControl/Stamina_init.sqf#L14)
## stamina_heartbeatHandle

Type: Variable

Description: 


Initial value:
```sqf
-1
```
File: [client\StaminaControl\Stamina_init.sqf at line 15](../../../Src/client/StaminaControl/Stamina_init.sqf#L15)
## stamina_lastVal

Type: Variable

Description: 


Initial value:
```sqf
-1
```
File: [client\StaminaControl\Stamina_init.sqf at line 16](../../../Src/client/StaminaControl/Stamina_init.sqf#L16)
## stamina_lastFullTime

Type: Variable

Description: 


Initial value:
```sqf
-1 //отметка времени последнего полного заполнения стамины
```
File: [client\StaminaControl\Stamina_init.sqf at line 17](../../../Src/client/StaminaControl/Stamina_init.sqf#L17)
## ison

Type: Variable

> Exists if **stamina_debug** defined

Description: 


Initial value:
```sqf
true
```
File: [client\StaminaControl\Stamina_init.sqf at line 24](../../../Src/client/StaminaControl/Stamina_init.sqf#L24)
