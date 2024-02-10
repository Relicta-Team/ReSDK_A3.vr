# client.sqf

## use_client_connection_log

Type: constant

Description: логирование подключения клиента


Replaced value:
```sqf

```
File: [host\Client\client.sqf at line 18](../../../Src/host/Client/client.sqf#L18)
## debug(var,fmt)

Type: constant

> Exists if **use_client_connection_log** defined

Description: 
- Param: var
- Param: fmt

Replaced value:
```sqf
logformat("[ServerClient::DEBUG]: " + (format[" (client:%1<%2>) " arg getSelf(id) arg getSelf(name)]) + var,fmt);
```
File: [host\Client\client.sqf at line 21](../../../Src/host/Client/client.sqf#L21)
## debug(var,fmt)

Type: constant

> Exists if **use_client_connection_log** not defined

Description: 
- Param: var
- Param: fmt

Replaced value:
```sqf

```
File: [host\Client\client.sqf at line 23](../../../Src/host/Client/client.sqf#L23)
## hashPair(key,val)

Type: constant

Description: (Client::charSettings) mainhand rule: 0 left, 1 right
- Param: key
- Param: val

Replaced value:
```sqf
[#key,val]
```
File: [host\Client\client.sqf at line 505](../../../Src/host/Client/client.sqf#L505)
## getRoleByClass(val)

Type: constant

Description: 
- Param: val

Replaced value:
```sqf
(missionNamespace getVariable ["role_"+(val),nullPtr])
```
File: [host\Client\client.sqf at line 699](../../../Src/host/Client/client.sqf#L699)
## serverclient_internal_string_changelogs

Type: Variable

Description: 


Initial value:
```sqf
""
```
File: [host\Client\client.sqf at line 1261](../../../Src/host/Client/client.sqf#L1261)
## serverclient_internal_map_sysmes

Type: Variable

Description: system message internal funcs


Initial value:
```sqf
createHashMapFromArray [...
```
File: [host\Client\client.sqf at line 1265](../../../Src/host/Client/client.sqf#L1265)
# sysmes.h

## sysmes(mname)

Type: constant

Description: 
- Param: mname

Replaced value:
```sqf
}],[ mname ,{
```
File: [host\Client\sysmes.h at line 8](../../../Src/host/Client/sysmes.h#L8)
