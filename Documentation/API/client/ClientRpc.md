# clientRpc.hpp

## __rpcmode_client

Type: constant
Description: ======================================================


Replaced value:
```sqf

```
File: [client\ClientRpc\clientRpc.hpp at line 7](../../../Src/client/ClientRpc/clientRpc.hpp#L7)
## rpcAdd(name,code)

Type: constant
Description: #endif
- Param: name
- Param: code

Replaced value:
```sqf
[name,code] call client_addEvent
```
File: [client\ClientRpc\clientRpc.hpp at line 13](../../../Src/client/ClientRpc/clientRpc.hpp#L13)
## rpcAddGlobal(name,code)

Type: constant
Description: 
- Param: name
- Param: code

Replaced value:
```sqf
[name,code] call rpc_addEventGlobal
```
File: [client\ClientRpc\clientRpc.hpp at line 15](../../../Src/client/ClientRpc/clientRpc.hpp#L15)
## rpcRemove(name,id)

Type: constant
Description: 
- Param: name
- Param: id

Replaced value:
```sqf
[name,id] call client_removeEvent
```
File: [client\ClientRpc\clientRpc.hpp at line 17](../../../Src/client/ClientRpc/clientRpc.hpp#L17)
## rpcRemoveGlobal(name,id)

Type: constant
Description: 
- Param: name
- Param: id

Replaced value:
```sqf
[name,id] call rpc_removeEventGlobal
```
File: [client\ClientRpc\clientRpc.hpp at line 19](../../../Src/client/ClientRpc/clientRpc.hpp#L19)
## rpcCall(name,args)

Type: constant
Description: 
- Param: name
- Param: args

Replaced value:
```sqf
[name,args] call client_callEvent
```
File: [client\ClientRpc\clientRpc.hpp at line 21](../../../Src/client/ClientRpc/clientRpc.hpp#L21)
## rpcSendToServer(name,args)

Type: constant
Description: 
- Param: name
- Param: args

Replaced value:
```sqf
[name,args] call client_sendToServer
```
File: [client\ClientRpc\clientRpc.hpp at line 23](../../../Src/client/ClientRpc/clientRpc.hpp#L23)
# clientrpc_init.sqf

## log_client_rpc

Type: constant
Description: 


Replaced value:
```sqf

```
File: [client\ClientRpc\clientrpc_init.sqf at line 8](../../../Src/client/ClientRpc/clientrpc_init.sqf#L8)
## rpc_log(event,args)

Type: constant
> Exists if **log_client_rpc** defined
Description: 
- Param: event
- Param: args

Replaced value:
```sqf
'debug_console' callExtension format['[NET::LOG::CLIENT]:    <%1> send %3 bytes to SERVER with %2',event,args,args call oop_getTypeSizeFull]
```
File: [client\ClientRpc\clientrpc_init.sqf at line 19](../../../Src/client/ClientRpc/clientrpc_init.sqf#L19)
## rpc_simple(data)

Type: constant
> Exists if **log_client_rpc** defined
Description: 
- Param: data

Replaced value:
```sqf
'debug_console' callExtension format['[NET::LOG]:    %1',data]
```
File: [client\ClientRpc\clientrpc_init.sqf at line 20](../../../Src/client/ClientRpc/clientrpc_init.sqf#L20)
## rpc_log(event,args)

Type: constant
> Exists if **log_client_rpc** not defined
Description: 
- Param: event
- Param: args

Replaced value:
```sqf

```
File: [client\ClientRpc\clientrpc_init.sqf at line 22](../../../Src/client/ClientRpc/clientrpc_init.sqf#L22)
## client_addEvent

Type: function
Description: 
- Param: _eventName
- Param: _eventCode

File: [client\ClientRpc\clientrpc_init.sqf at line 25](../../../Src/client/ClientRpc/clientrpc_init.sqf#L25)
## client_removeEvent

Type: function
Description: 
- Param: _eventName
- Param: _eventId

File: [client\ClientRpc\clientrpc_init.sqf at line 30](../../../Src/client/ClientRpc/clientrpc_init.sqf#L30)
## rpc_removeEventGlobal

Type: function
Description: 
- Param: _eventName
- Param: _eventId

File: [client\ClientRpc\clientrpc_init.sqf at line 35](../../../Src/client/ClientRpc/clientrpc_init.sqf#L35)
## client_callEvent

Type: function
Description: 
- Param: _eventName
- Param: _args

File: [client\ClientRpc\clientrpc_init.sqf at line 40](../../../Src/client/ClientRpc/clientrpc_init.sqf#L40)
## client_sendToServer

Type: function
Description: 
- Param: _eventName
- Param: _eventargs

File: [client\ClientRpc\clientrpc_init.sqf at line 45](../../../Src/client/ClientRpc/clientrpc_init.sqf#L45)
