# DiscordRPC.h

## allowtrace

Type: constant
Description: 


Replaced value:
```sqf

```
File: [client\DiscordRPC\DiscordRPC.h at line 7](../../../src/client/DiscordRPC/DiscordRPC.h#L7)
## extname

Type: constant
Description: #define allowtrace


Replaced value:
```sqf
"DiscordRichPresence"
```
File: [client\DiscordRPC\DiscordRPC.h at line 9](../../../src/client/DiscordRPC/DiscordRPC.h#L9)
## updateState()

Type: constant
Description: 
- Param: 

Replaced value:
```sqf
extname callExtension ["UpdatePresence",[]]
```
File: [client\DiscordRPC\DiscordRPC.h at line 11](../../../src/client/DiscordRPC/DiscordRPC.h#L11)
## setTask(_v,_vl)

Type: constant
Description: 
- Param: _v
- Param: _vl

Replaced value:
```sqf
extname callExtension [_v,[_vl]]
```
File: [client\DiscordRPC\DiscordRPC.h at line 13](../../../src/client/DiscordRPC/DiscordRPC.h#L13)
## getAppToken()

Type: constant
Description: 
- Param: 

Replaced value:
```sqf
"817839824006414337"
```
File: [client\DiscordRPC\DiscordRPC.h at line 15](../../../src/client/DiscordRPC/DiscordRPC.h#L15)
## initApplication()

Type: constant
Description: 
- Param: 

Replaced value:
```sqf
extname callExtension ["init",[getAppToken()]]
```
File: [client\DiscordRPC\DiscordRPC.h at line 17](../../../src/client/DiscordRPC/DiscordRPC.h#L17)
## encodeString(val)

Type: constant
Description: 
- Param: val

Replaced value:
```sqf
(val call discrpc_encodeRu)
```
File: [client\DiscordRPC\DiscordRPC.h at line 19](../../../src/client/DiscordRPC/DiscordRPC.h#L19)
## USE_LOCALES

Type: constant
Description: 


Replaced value:
```sqf

```
File: [client\DiscordRPC\DiscordRPC.h at line 22](../../../src/client/DiscordRPC/DiscordRPC.h#L22)
# DiscordRPC_init.sqf

## discrpc_send

Type: function
Description: отправляет новую информацию в rpc и обновляет статус клиента


File: [client\DiscordRPC\DiscordRPC_init.sqf at line 33](../../../src/client/DiscordRPC/DiscordRPC_init.sqf#L33)
## discrpc_init

Type: function
Description: инициализатор. вызывается при подключении к серверу и устанавливает статус клиента
- Param: _applicationID
- Param: _defaultDetails
- Param: _defaultState
- Param: _defaultLargeImageKey
- Param: _defaultLargeImageText
- Param: _defaultSmallImageKey
- Param: _defaultSmallImageText
- Param: _showTimeElapsed

File: [client\DiscordRPC\DiscordRPC_init.sqf at line 64](../../../src/client/DiscordRPC/DiscordRPC_init.sqf#L64)
## discrpc_reload

Type: function
Description: 


File: [client\DiscordRPC\DiscordRPC_init.sqf at line 105](../../../src/client/DiscordRPC/DiscordRPC_init.sqf#L105)
## discrpc_unload

Type: function
Description: 


File: [client\DiscordRPC\DiscordRPC_init.sqf at line 109](../../../src/client/DiscordRPC/DiscordRPC_init.sqf#L109)
## discrpc_encodeRu

Type: function
Description: кодирует русские символы из utf8 в win-1252
- Param: _ruStr

File: [client\DiscordRPC\DiscordRPC_init.sqf at line 114](../../../src/client/DiscordRPC/DiscordRPC_init.sqf#L114)
## discrpc_getLetterByLocale

Type: function
> Exists if **USE_LOCALES** defined
Description: 
- Param: _l

File: [client\DiscordRPC\DiscordRPC_init.sqf at line 132](../../../src/client/DiscordRPC/DiscordRPC_init.sqf#L132)
## discrpc_setStatus

Type: function
Description: установить статус клиента. Доступные статусы ingame,lobby
- Param: _strStatus

File: [client\DiscordRPC\DiscordRPC_init.sqf at line 146](../../../src/client/DiscordRPC/DiscordRPC_init.sqf#L146)
## discrpc_setIngameStatus

Type: function
Description: вызывается когда клиент подключился


File: [client\DiscordRPC\DiscordRPC_init.sqf at line 165](../../../src/client/DiscordRPC/DiscordRPC_init.sqf#L165)
## discrpc_setInLobbyStatus

Type: function
Description: вызывается когда клиент в лобби
- Param: _mainRole (optional, default "")

File: [client\DiscordRPC\DiscordRPC_init.sqf at line 174](../../../src/client/DiscordRPC/DiscordRPC_init.sqf#L174)
## discrpc_setPlayingStatus

Type: function
Description: вызывается когда клиент в игре
- Param: _charName

File: [client\DiscordRPC\DiscordRPC_init.sqf at line 192](../../../src/client/DiscordRPC/DiscordRPC_init.sqf#L192)
## discrpc_editor_init

Type: function
Description: 


File: [client\DiscordRPC\DiscordRPC_init.sqf at line 209](../../../src/client/DiscordRPC/DiscordRPC_init.sqf#L209)
## discrpc_editor_updateState

Type: function
Description: 


File: [client\DiscordRPC\DiscordRPC_init.sqf at line 225](../../../src/client/DiscordRPC/DiscordRPC_init.sqf#L225)
