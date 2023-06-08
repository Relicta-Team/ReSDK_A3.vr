# loader.hpp

## interface_class(name)

Type: constant

Description: all events inherited from BaseProgressInfluenceEvent
- Param: name

Replaced value:
```sqf
gameEvents_internal_list_interfaces pushBack (tolower #name); class(name)
```
File: [host\GameEvents\loader.hpp at line 13](../../../Src/host/GameEvents/loader.hpp#L13)
## gameEvents_internal_list_interfaces

Type: Variable

Description: 


Initial value:
```sqf
[]
```
File: [host\GameEvents\loader.hpp at line 15](../../../Src/host/GameEvents/loader.hpp#L15)
## gameEvents_internal_map_createdEvents

Type: Variable

Description: 


Initial value:
```sqf
createHashMap //key(string) classname, value(int) count 
```
File: [host\GameEvents\loader.hpp at line 16](../../../Src/host/GameEvents/loader.hpp#L16)
## gameEvents_sys_getAllEventTypes

Type: function

Description: key(string) classname, value(int) count


File: [host\GameEvents\loader.hpp at line 17](../../../Src/host/GameEvents/loader.hpp#L17)
