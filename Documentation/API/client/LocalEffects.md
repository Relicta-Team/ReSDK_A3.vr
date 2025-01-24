# LocalEffects.h

## EFFECT_EVENT_INDEX_CREATE

Type: constant

Description: 


Replaced value:
```sqf
0
```
File: [client\LocalEffects\LocalEffects.h at line 8](../../../Src/client/LocalEffects/LocalEffects.h#L8)
## EFFECT_EVENT_INDEX_DESTROY

Type: constant

Description: 


Replaced value:
```sqf
1
```
File: [client\LocalEffects\LocalEffects.h at line 9](../../../Src/client/LocalEffects/LocalEffects.h#L9)
## EFFECT_EVENT_INDEX_UPDATE

Type: constant

Description: 


Replaced value:
```sqf
2
```
File: [client\LocalEffects\LocalEffects.h at line 10](../../../Src/client/LocalEffects/LocalEffects.h#L10)
## effect(class)

Type: constant

Description: 
- Param: class

Replaced value:
```sqf
_data = [{},{},{}]; _lasteff = tolower 'class';_lasteffstruct = [_lasteff,_data]; [{
```
File: [client\LocalEffects\LocalEffects.h at line 12](../../../Src/client/LocalEffects/LocalEffects.h#L12)
## destroy

Type: constant

Description: 


Replaced value:
```sqf
}]; _data set [EFFECT_EVENT_INDEX_DESTROY,{ 
```
File: [client\LocalEffects\LocalEffects.h at line 14](../../../Src/client/LocalEffects/LocalEffects.h#L14)
## create

Type: constant

Description: 


Replaced value:
```sqf
}]; _data set [EFFECT_EVENT_INDEX_CREATE,{
```
File: [client\LocalEffects\LocalEffects.h at line 16](../../../Src/client/LocalEffects/LocalEffects.h#L16)
## update

Type: constant

Description: 


Replaced value:
```sqf
}]; _data set [EFFECT_EVENT_INDEX_UPDATE,{
```
File: [client\LocalEffects\LocalEffects.h at line 18](../../../Src/client/LocalEffects/LocalEffects.h#L18)
## end

Type: constant

Description: 


Replaced value:
```sqf
}]; locef_allEffectsCfg set _lasteffstruct;
```
File: [client\LocalEffects\LocalEffects.h at line 20](../../../Src/client/LocalEffects/LocalEffects.h#L20)
## thisEventName

Type: constant

Description: 


Replaced value:
```sqf
_name
```
File: [client\LocalEffects\LocalEffects.h at line 22](../../../Src/client/LocalEffects/LocalEffects.h#L22)
## thisContext

Type: constant

Description: 


Replaced value:
```sqf
_ctx
```
File: [client\LocalEffects\LocalEffects.h at line 24](../../../Src/client/LocalEffects/LocalEffects.h#L24)
## jumpto(index)

Type: constant

Description: 
- Param: index

Replaced value:
```sqf
call(locef_allEffectsCfg get thisEventName select index)
```
File: [client\LocalEffects\LocalEffects.h at line 26](../../../Src/client/LocalEffects/LocalEffects.h#L26)
## updateContext(newdata)

Type: constant

Description: 
- Param: newdata

Replaced value:
```sqf
locef_allActiveEffects set [thisEventName,newdata]
```
File: [client\LocalEffects\LocalEffects.h at line 28](../../../Src/client/LocalEffects/LocalEffects.h#L28)
# LocalEffects_init.sqf

## sanitizeCfgName(var)

Type: constant

Description: key:name, value:context data (list)
- Param: var

Replaced value:
```sqf
var = tolower var
```
File: [client\LocalEffects\LocalEffects_init.sqf at line 26](../../../Src/client/LocalEffects/LocalEffects_init.sqf#L26)
## effectExists(checked)

Type: constant

Description: 
- Param: checked

Replaced value:
```sqf
(checked in locef_allActiveEffects)
```
File: [client\LocalEffects\LocalEffects_init.sqf at line 27](../../../Src/client/LocalEffects/LocalEffects_init.sqf#L27)
## callEffectEvent(name,indx)

Type: constant

Description: 
- Param: name
- Param: indx

Replaced value:
```sqf
call (locef_allEffectsCfg get (name) select indx)
```
File: [client\LocalEffects\LocalEffects_init.sqf at line 29](../../../Src/client/LocalEffects/LocalEffects_init.sqf#L29)
## locef_allEffectsCfg

Type: Variable

Description: 


Initial value:
```sqf
createHashMap //списки конфигураций эффектов
```
File: [client\LocalEffects\LocalEffects_init.sqf at line 23](../../../Src/client/LocalEffects/LocalEffects_init.sqf#L23)
## locef_allActiveEffects

Type: Variable

Description: списки конфигураций эффектов


Initial value:
```sqf
createHashMap //key:name, value:context data (list)
```
File: [client\LocalEffects\LocalEffects_init.sqf at line 24](../../../Src/client/LocalEffects/LocalEffects_init.sqf#L24)
## locef_remove

Type: function

Description: };


File: [client\LocalEffects\LocalEffects_init.sqf at line 38](../../../Src/client/LocalEffects/LocalEffects_init.sqf#L38)
## locef_update

Type: function

Description: 
- Param: thisEventName
- Param: _context (optional, default [])

File: [client\LocalEffects\LocalEffects_init.sqf at line 48](../../../Src/client/LocalEffects/LocalEffects_init.sqf#L48)
## locef_removeAll

Type: function

Description: 


File: [client\LocalEffects\LocalEffects_init.sqf at line 61](../../../Src/client/LocalEffects/LocalEffects_init.sqf#L61)
## locef_createTempObject

Type: function

Description: 


File: [client\LocalEffects\LocalEffects_init.sqf at line 67](../../../Src/client/LocalEffects/LocalEffects_init.sqf#L67)
# LocalEffects_list.sqf

## vst_human_stealth_allowStepsounds

Type: Variable

Description: 


Initial value:
```sqf
false
```
File: [client\LocalEffects\LocalEffects_list.sqf at line 52](../../../Src/client/LocalEffects/LocalEffects_list.sqf#L52)
