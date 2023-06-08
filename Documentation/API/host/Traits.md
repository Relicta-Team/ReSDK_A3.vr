# TraitsInit.sqf

## traits_viceGlobalList

Type: Variable

Description: 


File: [host\Traits\TraitsInit.sqf at line 11](../../../Src/host/Traits/TraitsInit.sqf#L11)
## traits_viceMap

Type: Variable

Description: 


File: [host\Traits\TraitsInit.sqf at line 12](../../../Src/host/Traits/TraitsInit.sqf#L12)
## traits_getViceDescByClass

Type: function

Description: 
- Param: _viceClass

File: [host\Traits\TraitsInit.sqf at line 17](../../../Src/host/Traits/TraitsInit.sqf#L17)
# vices.h

## addVice(class,name,desc)

Type: constant

Description: Добавляет новый порок. Предыдущий порок записывается
- Param: class
- Param: name
- Param: desc

Replaced value:
```sqf
if (!isNullVar(_ptr)) then {_ptr set [2,_lastViceCode]; _ptr = null; _lastViceCode = null;}; \
_lastViceIndex = traits_viceGlobalList pushBack [class,name]; _ptr = [name,desc,{}]; traits_viceMap set [class,_ptr]; _lastViceCode = 
```
File: [host\Traits\vices.h at line 8](../../../Src/host/Traits/vices.h#L8)
## addViceTemplate(class,name,desc)

Type: constant

Description: 
- Param: class
- Param: name
- Param: desc

Replaced value:
```sqf
addVice(class,name,desc) {};
```
File: [host\Traits\vices.h at line 11](../../../Src/host/Traits/vices.h#L11)
