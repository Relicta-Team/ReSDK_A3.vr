# serverRpc.hpp

## __rpcmode_server

Type: constant

Description: 


Replaced value:
```sqf

```
File: [host\ServerRpc\serverRpc.hpp at line 7](../../../Src/host/ServerRpc/serverRpc.hpp#L7)
## rpcAdd(name,code)

Type: constant

Description: #endif
- Param: name
- Param: code

Replaced value:
```sqf
[name,code] call server_addEvent
```
File: [host\ServerRpc\serverRpc.hpp at line 13](../../../Src/host/ServerRpc/serverRpc.hpp#L13)
## rpcAddGlobal(name,code)

Type: constant

Description: 
- Param: name
- Param: code

Replaced value:
```sqf
[name,code] call rpc_addEventGlobal
```
File: [host\ServerRpc\serverRpc.hpp at line 15](../../../Src/host/ServerRpc/serverRpc.hpp#L15)
## rpcRemove(name,id)

Type: constant

Description: 
- Param: name
- Param: id

Replaced value:
```sqf
[name,id] call server_removeEvent
```
File: [host\ServerRpc\serverRpc.hpp at line 17](../../../Src/host/ServerRpc/serverRpc.hpp#L17)
## rpcRemoveGlobal(name,id)

Type: constant

Description: 
- Param: name
- Param: id

Replaced value:
```sqf
[name,id] call rpc_removeEventGlobal
```
File: [host\ServerRpc\serverRpc.hpp at line 19](../../../Src/host/ServerRpc/serverRpc.hpp#L19)
## rpcCall(name,args)

Type: constant

Description: 
- Param: name
- Param: args

Replaced value:
```sqf
[name,args] call server_callEvent
```
File: [host\ServerRpc\serverRpc.hpp at line 21](../../../Src/host/ServerRpc/serverRpc.hpp#L21)
## rpcSendToClient(owner,name,args)

Type: constant

Description: rpcSend(rpcTypeClient,0,"test",null)
- Param: owner
- Param: name
- Param: args

Replaced value:
```sqf
[owner,name,args] call server_sendtoclient
```
File: [host\ServerRpc\serverRpc.hpp at line 24](../../../Src/host/ServerRpc/serverRpc.hpp#L24)
## rpcSendToObject(owner,name,args)

Type: constant

Description: 
- Param: owner
- Param: name
- Param: args

Replaced value:
```sqf
[owner,name,args] call server_sendtoclientobject
```
File: [host\ServerRpc\serverRpc.hpp at line 25](../../../Src/host/ServerRpc/serverRpc.hpp#L25)
## rpcSendToAll(name,args)

Type: constant

Description: 
- Param: name
- Param: args

Replaced value:
```sqf
[name,args] call server_sendtoallclients
```
File: [host\ServerRpc\serverRpc.hpp at line 27](../../../Src/host/ServerRpc/serverRpc.hpp#L27)
## rpcSendGlobal(name,args)

Type: constant

Description: 
- Param: name
- Param: args

Replaced value:
```sqf
[name,args] call rpc_sendGlobal
```
File: [host\ServerRpc\serverRpc.hpp at line 29](../../../Src/host/ServerRpc/serverRpc.hpp#L29)
## getVObjectLink(ref)

Type: constant

Description: 
- Param: ref

Replaced value:
```sqf
(ref getvariable ['link',locationnull])
```
File: [host\ServerRpc\serverRpc.hpp at line 31](../../../Src/host/ServerRpc/serverRpc.hpp#L31)
## unrefObject(assignVar,ref,iferrordo)

Type: constant

Description: 
- Param: assignVar
- Param: ref
- Param: iferrordo

Replaced value:
```sqf
private assignVar = getVObjectLink(ref); if !isExistsObject(assignVar) exitWith {iferrordo}
```
File: [host\ServerRpc\serverRpc.hpp at line 33](../../../Src/host/ServerRpc/serverRpc.hpp#L33)
# serverRpc_init.sqf

## log_server_rpc

Type: constant

Description: 


Replaced value:
```sqf

```
File: [host\ServerRpc\serverRpc_init.sqf at line 8](../../../Src/host/ServerRpc/serverRpc_init.sqf#L8)
## DISABLED_RPC_LOG

Type: constant

Description: 


Replaced value:
```sqf
["onupdch","onupdob"]
```
File: [host\ServerRpc\serverRpc_init.sqf at line 18](../../../Src/host/ServerRpc/serverRpc_init.sqf#L18)
## canlog(eventname,code)

Type: constant

Description: 
- Param: eventname
- Param: code

Replaced value:
```sqf
if !((toLower eventname) in DISABLED_RPC_LOG) then {code}
```
File: [host\ServerRpc\serverRpc_init.sqf at line 19](../../../Src/host/ServerRpc/serverRpc_init.sqf#L19)
## debugprint_type

Type: constant

Description: 


Replaced value:
```sqf
"debug_console" callExtension
```
File: [host\ServerRpc\serverRpc_init.sqf at line 21](../../../Src/host/ServerRpc/serverRpc_init.sqf#L21)
## rpc_log(event,owner,args)

Type: constant

> Exists if **log_server_rpc** defined

Description: 
- Param: event
- Param: owner
- Param: args

Replaced value:
```sqf
canlog(event,debugprint_type format['[NET::LOG::SERVER]:    <%1> send %4 bytes to (%2) with %3' arg event arg owner arg args arg args call oop_getTypeSizeFull]; ["<%1> send %4 bytes to (%2) with %3" arg event arg owner arg args arg args call oop_getTypeSizeFull] call logInfo)
```
File: [host\ServerRpc\serverRpc_init.sqf at line 24](../../../Src/host/ServerRpc/serverRpc_init.sqf#L24)
## rpc_simple(data)

Type: constant

> Exists if **log_server_rpc** defined

Description: 
- Param: data

Replaced value:
```sqf
debugprint_type format['[NET::LOG]:    %1' arg data]; ["<RPC::Simple> %1" arg  data] call logInfo
```
File: [host\ServerRpc\serverRpc_init.sqf at line 25](../../../Src/host/ServerRpc/serverRpc_init.sqf#L25)
## rpc_log(event,owner,args)

Type: constant

> Exists if **log_server_rpc** not defined

Description: 
- Param: event
- Param: owner
- Param: args

Replaced value:
```sqf

```
File: [host\ServerRpc\serverRpc_init.sqf at line 27](../../../Src/host/ServerRpc/serverRpc_init.sqf#L27)
## rpc_simple(data)

Type: constant

> Exists if **log_server_rpc** not defined

Description: 
- Param: data

Replaced value:
```sqf

```
File: [host\ServerRpc\serverRpc_init.sqf at line 28](../../../Src/host/ServerRpc/serverRpc_init.sqf#L28)
## EMULATE_SERVERINDEBUG

Type: constant

Description: 


Replaced value:
```sqf

```
File: [host\ServerRpc\serverRpc_init.sqf at line 31](../../../Src/host/ServerRpc/serverRpc_init.sqf#L31)
## server_addEvent

Type: function

Description: 
- Param: _eventName
- Param: _eventCode

File: [host\ServerRpc\serverRpc_init.sqf at line 33](../../../Src/host/ServerRpc/serverRpc_init.sqf#L33)
## server_removeEvent

Type: function

Description: 
- Param: _eventName
- Param: _eventId

File: [host\ServerRpc\serverRpc_init.sqf at line 40](../../../Src/host/ServerRpc/serverRpc_init.sqf#L40)
## rpc_removeEventGlobal

Type: function

Description: 
- Param: _eventName
- Param: _eventId

File: [host\ServerRpc\serverRpc_init.sqf at line 45](../../../Src/host/ServerRpc/serverRpc_init.sqf#L45)
## server_callEvent

Type: function

Description: 
- Param: _eventName
- Param: _args

File: [host\ServerRpc\serverRpc_init.sqf at line 50](../../../Src/host/ServerRpc/serverRpc_init.sqf#L50)
## server_sendtoclient

Type: function

Description: 
- Param: _clientId
- Param: _eventName
- Param: _args

File: [host\ServerRpc\serverRpc_init.sqf at line 55](../../../Src/host/ServerRpc/serverRpc_init.sqf#L55)
## server_sendtoclientobject

Type: function

Description: 
- Param: _clientobj
- Param: _eventName
- Param: _args

File: [host\ServerRpc\serverRpc_init.sqf at line 74](../../../Src/host/ServerRpc/serverRpc_init.sqf#L74)
## server_sendtoallclients

Type: function

Description: 
- Param: _eventName
- Param: _args

File: [host\ServerRpc\serverRpc_init.sqf at line 119](../../../Src/host/ServerRpc/serverRpc_init.sqf#L119)
## rpc_sendGlobal

Type: function

Description: 
- Param: _eventName
- Param: _args

File: [host\ServerRpc\serverRpc_init.sqf at line 136](../../../Src/host/ServerRpc/serverRpc_init.sqf#L136)
## rpc_getClientEvent

Type: function

> Exists if **DEBUG** defined

Description: 
- Param: _name

File: [host\ServerRpc\serverRpc_init.sqf at line 159](../../../Src/host/ServerRpc/serverRpc_init.sqf#L159)
## rpc_getServerEvent

Type: function

> Exists if **DEBUG** defined

Description: 
- Param: _name

File: [host\ServerRpc\serverRpc_init.sqf at line 163](../../../Src/host/ServerRpc/serverRpc_init.sqf#L163)
