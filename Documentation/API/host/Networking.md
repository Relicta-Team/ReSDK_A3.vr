# Network.hpp

## netSendVar(var,val,own)

Type: constant

Description: 
- Param: var
- Param: val
- Param: own

Replaced value:
```sqf
[var,val,own] call net_send
```
File: [host\Networking\Network.hpp at line 8](../../../Src/host/Networking/Network.hpp#L8)
## netSendVarToObject(var,val,objs)

Type: constant

Description: 
- Param: var
- Param: val
- Param: objs

Replaced value:
```sqf
[var,val,objs] call net_sendToObject
```
File: [host\Networking\Network.hpp at line 10](../../../Src/host/Networking/Network.hpp#L10)
## netSetGlobal(var,val)

Type: constant

> Exists if **ENABLE_LAG_NETWORK** defined

Description: 
- Param: var
- Param: val

Replaced value:
```sqf
invokeAfterDelayParams({missionNamespace setVariable ['var' arg _this arg true]},__LAG_NETWORK_GET_LAG__,val)
```
File: [host\Networking\Network.hpp at line 13](../../../Src/host/Networking/Network.hpp#L13)
## nsind(ind)

Type: constant

> Exists if **ENABLE_LAG_NETWORK** defined

Description: 
- Param: ind

Replaced value:
```sqf
(_this select ind)
```
File: [host\Networking\Network.hpp at line 14](../../../Src/host/Networking/Network.hpp#L14)
## netSyncObjVar(obj,var,val)

Type: constant

> Exists if **ENABLE_LAG_NETWORK** defined

Description: 
- Param: obj
- Param: var
- Param: val

Replaced value:
```sqf
invokeAfterDelayParams({nsind(0) setvariable [nsind(1) arg nsind(2) arg true]},__LAG_NETWORK_GET_LAG__,[obj arg var arg val])
```
File: [host\Networking\Network.hpp at line 15](../../../Src/host/Networking/Network.hpp#L15)
## netSetGlobal(var,val)

Type: constant

> Exists if **ENABLE_LAG_NETWORK** not defined

Description: 
- Param: var
- Param: val

Replaced value:
```sqf
missionNamespace setVariable ['var',val,true]
```
File: [host\Networking\Network.hpp at line 17](../../../Src/host/Networking/Network.hpp#L17)
## netSyncObjVar(obj,var,val)

Type: constant

> Exists if **ENABLE_LAG_NETWORK** not defined

Description: 
- Param: obj
- Param: var
- Param: val

Replaced value:
```sqf
obj setvariable [var,val,true]
```
File: [host\Networking\Network.hpp at line 18](../../../Src/host/Networking/Network.hpp#L18)
# Network.sqf

## netlog(mes,fmt)

Type: constant

> Exists if **net_log** defined

Description: 
- Param: mes
- Param: fmt

Replaced value:
```sqf
["(RPC)		<FastSend> " + mes,fmt] call systemLog;
```
File: [host\Networking\Network.sqf at line 12](../../../Src/host/Networking/Network.sqf#L12)
## netlog(mes,fmt)

Type: constant

> Exists if **net_log** not defined

Description: 
- Param: mes
- Param: fmt

Replaced value:
```sqf

```
File: [host\Networking\Network.sqf at line 14](../../../Src/host/Networking/Network.sqf#L14)
## net_send

Type: function

Description: 
- Param: _var
- Param: _val
- Param: _owner

File: [host\Networking\Network.sqf at line 25](../../../Src/host/Networking/Network.sqf#L25)
## net_sendToObject

Type: function

Description: 
- Param: _var
- Param: _val
- Param: _targ

File: [host\Networking\Network.sqf at line 63](../../../Src/host/Networking/Network.sqf#L63)
