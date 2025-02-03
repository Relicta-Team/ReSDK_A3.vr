# clientRpc.hpp

## __rpcmode_client

Type: constant

Description: 


Replaced value:
```sqf

```
File: [client\ClientRpc\clientRpc.hpp at line 11](../../../Src/client/ClientRpc/clientRpc.hpp#L11)
## rpcAdd(name,code)

Type: constant

Description: 
- Param: name
- Param: code

Replaced value:
```sqf
[name,code] call client_addEvent
```
File: [client\ClientRpc\clientRpc.hpp at line 17](../../../Src/client/ClientRpc/clientRpc.hpp#L17)
## rpcAddGlobal(name,code)

Type: constant

Description: 
- Param: name
- Param: code

Replaced value:
```sqf
[name,code] call rpc_addEventGlobal
```
File: [client\ClientRpc\clientRpc.hpp at line 19](../../../Src/client/ClientRpc/clientRpc.hpp#L19)
## rpcRemove(name,id)

Type: constant

Description: 
- Param: name
- Param: id

Replaced value:
```sqf
[name,id] call client_removeEvent
```
File: [client\ClientRpc\clientRpc.hpp at line 21](../../../Src/client/ClientRpc/clientRpc.hpp#L21)
## rpcRemoveGlobal(name,id)

Type: constant

Description: 
- Param: name
- Param: id

Replaced value:
```sqf
[name,id] call rpc_removeEventGlobal
```
File: [client\ClientRpc\clientRpc.hpp at line 23](../../../Src/client/ClientRpc/clientRpc.hpp#L23)
## rpcCall(name,args)

Type: constant

Description: 
- Param: name
- Param: args

Replaced value:
```sqf
[name,args] call client_callEvent
```
File: [client\ClientRpc\clientRpc.hpp at line 25](../../../Src/client/ClientRpc/clientRpc.hpp#L25)
## rpcSendToServer(name,args)

Type: constant

Description: 
- Param: name
- Param: args

Replaced value:
```sqf
[name,args] call client_sendToServer
```
File: [client\ClientRpc\clientRpc.hpp at line 27](../../../Src/client/ClientRpc/clientRpc.hpp#L27)
# clientrpc_init.sqf

## log_client_rpc

Type: constant

Description: 


Replaced value:
```sqf

```
File: [client\ClientRpc\clientrpc_init.sqf at line 11](../../../Src/client/ClientRpc/clientrpc_init.sqf#L11)
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
File: [client\ClientRpc\clientrpc_init.sqf at line 23](../../../Src/client/ClientRpc/clientrpc_init.sqf#L23)
## rpc_simple(data)

Type: constant

> Exists if **log_client_rpc** defined

Description: 
- Param: data

Replaced value:
```sqf
'debug_console' callExtension format['[NET::LOG]:    %1',data]
```
File: [client\ClientRpc\clientrpc_init.sqf at line 25](../../../Src/client/ClientRpc/clientrpc_init.sqf#L25)
## rpc_log(event,args)

Type: constant

> Exists if **log_client_rpc** not defined

Description: 
- Param: event
- Param: args

Replaced value:
```sqf

```
File: [client\ClientRpc\clientrpc_init.sqf at line 27](../../../Src/client/ClientRpc/clientrpc_init.sqf#L27)
## client_addEvent

Type: function

Description: 
- Param: _eventName
- Param: _eventCode

File: [client\ClientRpc\clientrpc_init.sqf at line 32](../../../Src/client/ClientRpc/clientrpc_init.sqf#L32)
## client_removeEvent

Type: function

Description: 
- Param: _eventName
- Param: _eventId

File: [client\ClientRpc\clientrpc_init.sqf at line 39](../../../Src/client/ClientRpc/clientrpc_init.sqf#L39)
## rpc_removeEventGlobal

Type: function

Description: 
- Param: _eventName
- Param: _eventId

File: [client\ClientRpc\clientrpc_init.sqf at line 46](../../../Src/client/ClientRpc/clientrpc_init.sqf#L46)
## client_callEvent

Type: function

Description: 
- Param: _eventName
- Param: _args

File: [client\ClientRpc\clientrpc_init.sqf at line 53](../../../Src/client/ClientRpc/clientrpc_init.sqf#L53)
## client_sendToServer

Type: function

Description: 
- Param: _eventName
- Param: _eventargs

File: [client\ClientRpc\clientrpc_init.sqf at line 60](../../../Src/client/ClientRpc/clientrpc_init.sqf#L60)
