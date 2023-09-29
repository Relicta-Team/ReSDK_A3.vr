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
File: [host\Client\client.sqf at line 405](../../../Src/host/Client/client.sqf#L405)
## getRoleByClass(val)

Type: constant

Description: 
- Param: val

Replaced value:
```sqf
(missionNamespace getVariable ["role_"+(val),nullPtr])
```
File: [host\Client\client.sqf at line 555](../../../Src/host/Client/client.sqf#L555)
## serverclient_internal_string_changelogs

Type: Variable

Description: 


Initial value:
```sqf
""
```
File: [host\Client\client.sqf at line 1073](../../../Src/host/Client/client.sqf#L1073)
## serverclient_internal_map_sysmes

Type: Variable

Description: system message internal funcs


Initial value:
```sqf
createHashMapFromArray [...
```
File: [host\Client\client.sqf at line 1077](../../../Src/host/Client/client.sqf#L1077)
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
