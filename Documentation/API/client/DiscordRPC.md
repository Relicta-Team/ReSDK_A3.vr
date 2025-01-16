# DiscordRPC.h

## extname

Type: constant

Description: 


Replaced value:
```sqf
"DiscordRichPresence"
```
File: [client\DiscordRPC\DiscordRPC.h at line 12](../../../Src/client/DiscordRPC/DiscordRPC.h#L12)
## updateState()

Type: constant

Description: 
- Param: 

Replaced value:
```sqf
extname callExtension ["UpdatePresence",[]]
```
File: [client\DiscordRPC\DiscordRPC.h at line 15](../../../Src/client/DiscordRPC/DiscordRPC.h#L15)
## setTask(_v,_vl)

Type: constant

Description: 
- Param: _v
- Param: _vl

Replaced value:
```sqf
extname callExtension [_v,[_vl]]
```
File: [client\DiscordRPC\DiscordRPC.h at line 18](../../../Src/client/DiscordRPC/DiscordRPC.h#L18)
## getAppToken()

Type: constant

Description: 
- Param: 

Replaced value:
```sqf
"817839824006414337"
```
File: [client\DiscordRPC\DiscordRPC.h at line 21](../../../Src/client/DiscordRPC/DiscordRPC.h#L21)
## initApplication()

Type: constant

Description: 
- Param: 

Replaced value:
```sqf
extname callExtension ["init",[getAppToken()]]
```
File: [client\DiscordRPC\DiscordRPC.h at line 24](../../../Src/client/DiscordRPC/DiscordRPC.h#L24)
## encodeString(val)

Type: constant

Description: 
- Param: val

Replaced value:
```sqf
(val call discrpc_encodeRu)
```
File: [client\DiscordRPC\DiscordRPC.h at line 27](../../../Src/client/DiscordRPC/DiscordRPC.h#L27)
# DiscordRPC_init.sqf

## discrpc_list_ruLetters

Type: Variable

Description: 


Initial value:
```sqf
createHashMap //в кодировке 1251
```
File: [client\DiscordRPC\DiscordRPC_init.sqf at line 17](../../../Src/client/DiscordRPC/DiscordRPC_init.sqf#L17)
## discrpc_allowedTaskTypes

Type: Variable

Description: 


Initial value:
```sqf
[...
```
File: [client\DiscordRPC\DiscordRPC_init.sqf at line 23](../../../Src/client/DiscordRPC/DiscordRPC_init.sqf#L23)
## discrpc_send

Type: function

Description: 


File: [client\DiscordRPC\DiscordRPC_init.sqf at line 38](../../../Src/client/DiscordRPC/DiscordRPC_init.sqf#L38)
## discrpc_init

Type: function

Description: 
- Param: _applicationID
- Param: _defaultDetails
- Param: _defaultState
- Param: _defaultLargeImageKey
- Param: _defaultLargeImageText
- Param: _defaultSmallImageKey
- Param: _defaultSmallImageText
- Param: _showTimeElapsed

File: [client\DiscordRPC\DiscordRPC_init.sqf at line 70](../../../Src/client/DiscordRPC/DiscordRPC_init.sqf#L70)
## discrpc_reload

Type: function

Description: 


File: [client\DiscordRPC\DiscordRPC_init.sqf at line 112](../../../Src/client/DiscordRPC/DiscordRPC_init.sqf#L112)
## discrpc_unload

Type: function

Description: 


File: [client\DiscordRPC\DiscordRPC_init.sqf at line 117](../../../Src/client/DiscordRPC/DiscordRPC_init.sqf#L117)
## discrpc_encodeRu

Type: function

Description: 
- Param: _ruStr

File: [client\DiscordRPC\DiscordRPC_init.sqf at line 123](../../../Src/client/DiscordRPC/DiscordRPC_init.sqf#L123)
## discrpc_getLetterByLocale

Type: function

> Exists if **USE_LOCALES** defined

Description: 
- Param: _l

File: [client\DiscordRPC\DiscordRPC_init.sqf at line 142](../../../Src/client/DiscordRPC/DiscordRPC_init.sqf#L142)
## discrpc_setStatus

Type: function

Description: 
- Param: _strStatus

File: [client\DiscordRPC\DiscordRPC_init.sqf at line 157](../../../Src/client/DiscordRPC/DiscordRPC_init.sqf#L157)
## discrpc_setIngameStatus

Type: function

Description: 


File: [client\DiscordRPC\DiscordRPC_init.sqf at line 177](../../../Src/client/DiscordRPC/DiscordRPC_init.sqf#L177)
## discrpc_setInLobbyStatus

Type: function

Description: 
- Param: _mainRole (optional, default "")

File: [client\DiscordRPC\DiscordRPC_init.sqf at line 187](../../../Src/client/DiscordRPC/DiscordRPC_init.sqf#L187)
## discrpc_setPlayingStatus

Type: function

Description: 
- Param: _charName

File: [client\DiscordRPC\DiscordRPC_init.sqf at line 206](../../../Src/client/DiscordRPC/DiscordRPC_init.sqf#L206)
## discrpc_editor_init

Type: function

Description: 


File: [client\DiscordRPC\DiscordRPC_init.sqf at line 224](../../../Src/client/DiscordRPC/DiscordRPC_init.sqf#L224)
## discrpc_editor_updateState

Type: function

Description: 


File: [client\DiscordRPC\DiscordRPC_init.sqf at line 241](../../../Src/client/DiscordRPC/DiscordRPC_init.sqf#L241)
