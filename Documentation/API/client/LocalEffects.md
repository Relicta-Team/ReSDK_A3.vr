# LocalEffects_init.sqf

## sanitizeCfgName(var)

Type: constant

Description: 
- Param: var

Replaced value:
```sqf
tolower var
```
File: [client\LocalEffects\LocalEffects_init.sqf at line 34](../../../Src/client/LocalEffects/LocalEffects_init.sqf#L34)
## effectExists(checked)

Type: constant

Description: 
- Param: checked

Replaced value:
```sqf
(checked in locef_allActiveEffects)
```
File: [client\LocalEffects\LocalEffects_init.sqf at line 36](../../../Src/client/LocalEffects/LocalEffects_init.sqf#L36)
## locef_allEffectsCfg

Type: Variable

Description: 


Initial value:
```sqf
createHashMap //списки конфигураций эффектов
```
File: [client\LocalEffects\LocalEffects_init.sqf at line 29](../../../Src/client/LocalEffects/LocalEffects_init.sqf#L29)
## locef_allActiveEffects

Type: Variable

Description: 


Initial value:
```sqf
createHashMap //key:name, value:struct_t.LocEffBase
```
File: [client\LocalEffects\LocalEffects_init.sqf at line 31](../../../Src/client/LocalEffects/LocalEffects_init.sqf#L31)
## locef_isInitialized

Type: Variable

Description: 


Initial value:
```sqf
false
```
File: [client\LocalEffects\LocalEffects_init.sqf at line 39](../../../Src/client/LocalEffects/LocalEffects_init.sqf#L39)
## locef_initConfigs

Type: function

Description: 


File: [client\LocalEffects\LocalEffects_init.sqf at line 42](../../../Src/client/LocalEffects/LocalEffects_init.sqf#L42)
## locef_remove

Type: function

Description: 
- Param: _eventName

File: [client\LocalEffects\LocalEffects_init.sqf at line 58](../../../Src/client/LocalEffects/LocalEffects_init.sqf#L58)
## locef_update

Type: function

Description: 
- Param: _eventName
- Param: _context (optional, default [])

File: [client\LocalEffects\LocalEffects_init.sqf at line 71](../../../Src/client/LocalEffects/LocalEffects_init.sqf#L71)
## locef_removeAll

Type: function

Description: 


File: [client\LocalEffects\LocalEffects_init.sqf at line 99](../../../Src/client/LocalEffects/LocalEffects_init.sqf#L99)
## locef_createTempObject

Type: function

Description: 


File: [client\LocalEffects\LocalEffects_init.sqf at line 106](../../../Src/client/LocalEffects/LocalEffects_init.sqf#L106)
