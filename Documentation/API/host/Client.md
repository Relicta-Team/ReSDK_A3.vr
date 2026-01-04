# client.sqf

## use_client_connection_log

Type: constant

Description: логирование подключения клиента


Replaced value:
```sqf

```
File: [host\Client\client.sqf at line 19](../../../Src/host/Client/client.sqf#L19)
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
File: [host\Client\client.sqf at line 22](../../../Src/host/Client/client.sqf#L22)
## debug(var,fmt)

Type: constant

> Exists if **use_client_connection_log** not defined

Description: 
- Param: var
- Param: fmt

Replaced value:
```sqf

```
File: [host\Client\client.sqf at line 24](../../../Src/host/Client/client.sqf#L24)
## hashPair(key,val)

Type: constant

Description: (Client::charSettings) mainhand rule: 0 left, 1 right
- Param: key
- Param: val

Replaced value:
```sqf
[#key,val]
```
File: [host\Client\client.sqf at line 533](../../../Src/host/Client/client.sqf#L533)
## getRoleByClass(val)

Type: constant

Description: 
- Param: val

Replaced value:
```sqf
(missionNamespace getVariable ["role_"+(val),nullPtr])
```
File: [host\Client\client.sqf at line 727](../../../Src/host/Client/client.sqf#L727)
## serverclient_internal_string_changelogs

Type: Variable

Description: 


Initial value:
```sqf
""
```
File: [host\Client\client.sqf at line 1302](../../../Src/host/Client/client.sqf#L1302)
## serverclient_internal_map_sysmes

Type: Variable

Description: system message internal funcs


Initial value:
```sqf
createHashMapFromArray [...
```
File: [host\Client\client.sqf at line 1306](../../../Src/host/Client/client.sqf#L1306)
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
