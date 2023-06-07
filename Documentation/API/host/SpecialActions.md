# SpecialActions.h

## thisAction

Type: constant
Description: 


Replaced value:
```sqf
_thisAct
```
File: [host\SpecialActions\SpecialActions.h at line 9](../../../src/host/SpecialActions/SpecialActions.h#L9)
## src

Type: constant
Description: 


Replaced value:
```sqf
_src
```
File: [host\SpecialActions\SpecialActions.h at line 10](../../../src/host/SpecialActions/SpecialActions.h#L10)
## SA_ADD(enum)

Type: constant
Description: 
- Param: enum

Replaced value:
```sqf
__index_act = enum; __code_act = { params ['this','src']; private thisAction = enum;
```
File: [host\SpecialActions\SpecialActions.h at line 12](../../../src/host/SpecialActions/SpecialActions.h#L12)
## SA_END(effectOnPress)

Type: constant
Description: 
- Param: effectOnPress

Replaced value:
```sqf
effectOnPress }; missionNamespace setVariable [format["specact_%1",__index_act],__code_act];
```
File: [host\SpecialActions\SpecialActions.h at line 14](../../../src/host/SpecialActions/SpecialActions.h#L14)
## SA_EF_CANCEL_AFTER_USE

Type: constant
Description: указываем что это действие должно сняться как активное после использования


Replaced value:
```sqf
callSelfParams(sendInfo,"callbackCancel_specAct" arg thisAction);
```
File: [host\SpecialActions\SpecialActions.h at line 18](../../../src/host/SpecialActions/SpecialActions.h#L18)
## SA_EF_NO

Type: constant
Description: без эффектов


Replaced value:
```sqf

```
File: [host\SpecialActions\SpecialActions.h at line 20](../../../src/host/SpecialActions/SpecialActions.h#L20)
# SpecialActions.hpp

## __FLAG(flag)

Type: constant
Description: специальный макрос для флагов
- Param: flag

Replaced value:
```sqf
+ flag
```
File: [host\SpecialActions\SpecialActions.hpp at line 7](../../../src/host/SpecialActions/SpecialActions.hpp#L7)
## SPECIAL_ACTION_NO

Type: constant
Description: Действия помеченные как переключаемые или проигрываемые опредлены тут: src\client\Interactions\interactMenu_defines.sqf


Replaced value:
```sqf
-1
```
File: [host\SpecialActions\SpecialActions.hpp at line 13](../../../src/host/SpecialActions/SpecialActions.hpp#L13)
## SPECIAL_ACTION_KICK

Type: constant
Description: 


Replaced value:
```sqf
0
```
File: [host\SpecialActions\SpecialActions.hpp at line 15](../../../src/host/SpecialActions/SpecialActions.hpp#L15)
## SPECIAL_ACTION_GRAB

Type: constant
Description: 


Replaced value:
```sqf
1
```
File: [host\SpecialActions\SpecialActions.hpp at line 16](../../../src/host/SpecialActions/SpecialActions.hpp#L16)
## SPECIAL_ACTION_BITE

Type: constant
Description: 


Replaced value:
```sqf
2
```
File: [host\SpecialActions\SpecialActions.hpp at line 17](../../../src/host/SpecialActions/SpecialActions.hpp#L17)
## SPECIAL_ACTION_JUMP

Type: constant
Description: 


Replaced value:
```sqf
3
```
File: [host\SpecialActions\SpecialActions.hpp at line 18](../../../src/host/SpecialActions/SpecialActions.hpp#L18)
## SPECIAL_ACTION_STEAL

Type: constant
Description: 


Replaced value:
```sqf
4
```
File: [host\SpecialActions\SpecialActions.hpp at line 19](../../../src/host/SpecialActions/SpecialActions.hpp#L19)
## SPECIAL_ACTION_STEALTH

Type: constant
Description: 


Replaced value:
```sqf
5
```
File: [host\SpecialActions\SpecialActions.hpp at line 20](../../../src/host/SpecialActions/SpecialActions.hpp#L20)
## SPECIAL_ACTION_EYES

Type: constant
Description: 


Replaced value:
```sqf
6
```
File: [host\SpecialActions\SpecialActions.hpp at line 21](../../../src/host/SpecialActions/SpecialActions.hpp#L21)
## SPECIAL_ACTION_SLEEP

Type: constant
Description: 


Replaced value:
```sqf
7
```
File: [host\SpecialActions\SpecialActions.hpp at line 22](../../../src/host/SpecialActions/SpecialActions.hpp#L22)
## SPECIAL_ACTION_THROW

Type: constant
Description: 


Replaced value:
```sqf
8
```
File: [host\SpecialActions\SpecialActions.hpp at line 23](../../../src/host/SpecialActions/SpecialActions.hpp#L23)
## SPECIAL_ACTION_BREATH

Type: constant
Description: 


Replaced value:
```sqf
9
```
File: [host\SpecialActions\SpecialActions.hpp at line 24](../../../src/host/SpecialActions/SpecialActions.hpp#L24)
