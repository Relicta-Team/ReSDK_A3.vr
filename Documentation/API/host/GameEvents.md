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
## gameEvents_sys_getAllEventTypes

Type: function
Description: key(string) classname, value(int) count


File: [host\GameEvents\loader.hpp at line 17](../../../Src/host/GameEvents/loader.hpp#L17)
