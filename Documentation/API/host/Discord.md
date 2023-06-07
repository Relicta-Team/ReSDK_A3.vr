# Accounts.sqf

## dsm_accounts_canUse

Type: function

Description: 


File: [host\Discord\Accounts.sqf at line 11](../../../Src/host/Discord/Accounts.sqf#L11)
## dsm_accounts_checkSync

Type: function

Description: вызывается из лс сообщений у бота. запрос токена авторизации
- Param: _nick
- Param: _hash
- Param: _chanId
- Param: _discordUserId

File: [host\Discord\Accounts.sqf at line 26](../../../Src/host/Discord/Accounts.sqf#L26)
## dsm_accounts_register

Type: function

Description: выполняет привязку дискорда к учетке и проивзодит синхронизацию ролей
- Param: _client
- Param: _token

File: [host\Discord\Accounts.sqf at line 69](../../../Src/host/Discord/Accounts.sqf#L69)
## dsm_accounts_loadDiscordId

Type: function

Description: загрузка привязки дискорда. Вызывается когда клиент загружается из БД
- Param: _client
- Param: _nick

File: [host\Discord\Accounts.sqf at line 119](../../../Src/host/Discord/Accounts.sqf#L119)
## dsm_accounts_handleRegisterArriveInCity

Type: function

Description: Вызывается когда клиента регистрируют в городе
- Param: _cli

File: [host\Discord\Accounts.sqf at line 136](../../../Src/host/Discord/Accounts.sqf#L136)
## dsm_accounts_requestUpdateRoles

Type: function

Description: запрос в менеджер на обновление ролей
- Param: _name
- Param: _discordUserId

File: [host\Discord\Accounts.sqf at line 160](../../../Src/host/Discord/Accounts.sqf#L160)
## dsm_accounts_addToRole

Type: function

Description: 
- Param: _discordUserId
- Param: _roleName

File: [host\Discord\Accounts.sqf at line 165](../../../Src/host/Discord/Accounts.sqf#L165)
## dsm_accounts_removeFromRole

Type: function

Description: 
- Param: _discordUserId
- Param: _roleName

File: [host\Discord\Accounts.sqf at line 170](../../../Src/host/Discord/Accounts.sqf#L170)
## dsm_acconunts_setNickname

Type: function

Description: установка никнейма для дискорд клиента
- Param: _discordUserId
- Param: _nickname

File: [host\Discord\Accounts.sqf at line 176](../../../Src/host/Discord/Accounts.sqf#L176)
# Discord.sqf

## DISCORD_ENABLE_EXTENDED_TRANSPORT

Type: constant

Description: 


Replaced value:
```sqf

```
File: [host\Discord\Discord.sqf at line 13](../../../Src/host/Discord/Discord.sqf#L13)
## DISCORD_MAX_MESSAGES_COUNT_PERDELAY

Type: constant

> Exists if **DISCORD_ENABLE_EXTENDED_TRANSPORT** defined

Description: 


Replaced value:
```sqf
5
```
File: [host\Discord\Discord.sqf at line 18](../../../Src/host/Discord/Discord.sqf#L18)
## discord_reset_stackcount()

Type: constant

> Exists if **DISCORD_ENABLE_EXTENDED_TRANSPORT** defined

Description: 
- Param: 

Replaced value:
```sqf
disc_messagesLeftPerSec = DISCORD_MAX_MESSAGES_COUNT_PERDELAY
```
File: [host\Discord\Discord.sqf at line 23](../../../Src/host/Discord/Discord.sqf#L23)
## DISCORD_UPDATE_DELAY

Type: constant

> Exists if **DISCORD_ENABLE_EXTENDED_TRANSPORT** defined

Description: задержка между сообщениями


Replaced value:
```sqf
5.001
```
File: [host\Discord\Discord.sqf at line 26](../../../Src/host/Discord/Discord.sqf#L26)
## disc_onUpdate

Type: function

> Exists if **DISCORD_ENABLE_EXTENDED_TRANSPORT** defined

Description: 


File: [host\Discord\Discord.sqf at line 43](../../../Src/host/Discord/Discord.sqf#L43)
## DiscordEmbedBuilder_fnc_buildSqf

Type: function

Description: 
- Param: _token
- Param: _mes
- Param: _name
- Param: _ico
- Param: _flg

File: [host\Discord\Discord.sqf at line 76](../../../Src/host/Discord/Discord.sqf#L76)
## disc_logger_provider

Type: function

Description: 
- Param: _message

File: [host\Discord\Discord.sqf at line 84](../../../Src/host/Discord/Discord.sqf#L84)
## disc_adminlog_provider

Type: function

Description: 
- Param: _message

File: [host\Discord\Discord.sqf at line 112](../../../Src/host/Discord/Discord.sqf#L112)
## discLog

Type: function

Description: 
- Param: _message

File: [host\Discord\Discord.sqf at line 123](../../../Src/host/Discord/Discord.sqf#L123)
## discError

Type: function

Description: 
- Param: _message

File: [host\Discord\Discord.sqf at line 129](../../../Src/host/Discord/Discord.sqf#L129)
## discWarning

Type: function

Description: 
- Param: _message

File: [host\Discord\Discord.sqf at line 135](../../../Src/host/Discord/Discord.sqf#L135)
## discServerNotif

Type: function

Description: 
- Param: _message
- Param: _header (optional, default "Оповещение")
- Param: _preMessage (optional, default "")

File: [host\Discord\Discord.sqf at line 141](../../../Src/host/Discord/Discord.sqf#L141)
## discUserLog

Type: function

Description: 
- Param: _message
- Param: _name

File: [host\Discord\Discord.sqf at line 161](../../../Src/host/Discord/Discord.sqf#L161)
# ServerManager.sqf

## DSM_DISABLE

Type: constant

Description: 


Replaced value:
```sqf

```
File: [host\Discord\ServerManager.sqf at line 6](../../../Src/host/Discord/ServerManager.sqf#L6)
## DSM_CALLBACKNAME

Type: constant

Description: 


Replaced value:
```sqf
"dsm_ext"
```
File: [host\Discord\ServerManager.sqf at line 14](../../../Src/host/Discord/ServerManager.sqf#L14)
## DSM_CHANNEL_CHANGELOG

Type: constant

> Exists if **EDITOR** defined

Description: 


Replaced value:
```sqf
"781280820912062556"
```
File: [host\Discord\ServerManager.sqf at line 17](../../../Src/host/Discord/ServerManager.sqf#L17)
## DSM_CHANNEL_CHANGELOG

Type: constant

> Exists if **EDITOR** not defined

Description: 


Replaced value:
```sqf
"847850893076201522"
```
File: [host\Discord\ServerManager.sqf at line 19](../../../Src/host/Discord/ServerManager.sqf#L19)
## dsm_stdCall

Type: function

Description: 
- Param: _func
- Param: _args (optional, default [])

File: [host\Discord\ServerManager.sqf at line 27](../../../Src/host/Discord/ServerManager.sqf#L27)
## dsm_isErrorReturn

Type: function

Description: 


File: [host\Discord\ServerManager.sqf at line 32](../../../Src/host/Discord/ServerManager.sqf#L32)
## dsm_deserializeStringList

Type: function

Description: 


File: [host\Discord\ServerManager.sqf at line 36](../../../Src/host/Discord/ServerManager.sqf#L36)
## dsm_sendToChannel

Type: function

Description: 
- Param: _chanId
- Param: _content

File: [host\Discord\ServerManager.sqf at line 40](../../../Src/host/Discord/ServerManager.sqf#L40)
## dsm_sendOnline

Type: function

Description: 
- Param: _num

File: [host\Discord\ServerManager.sqf at line 48](../../../Src/host/Discord/ServerManager.sqf#L48)
## dsm_onOnlineUpdate

Type: function

Description: 


File: [host\Discord\ServerManager.sqf at line 53](../../../Src/host/Discord/ServerManager.sqf#L53)
## dsm_initialize

Type: function

Description: 


File: [host\Discord\ServerManager.sqf at line 57](../../../Src/host/Discord/ServerManager.sqf#L57)
## dsm_deinitialize

Type: function

Description: 


File: [host\Discord\ServerManager.sqf at line 92](../../../Src/host/Discord/ServerManager.sqf#L92)
## dsm_callbackHandle

Type: function

Description: 
- Param: _name
- Param: _function
- Param: _data

File: [host\Discord\ServerManager.sqf at line 98](../../../Src/host/Discord/ServerManager.sqf#L98)
## dsm_isLoaded

Type: function

Description: 


File: [host\Discord\ServerManager.sqf at line 156](../../../Src/host/Discord/ServerManager.sqf#L156)
## dsm_callServerCommand

Type: function

Description: 
- Param: _cmd
- Param: _executorName

File: [host\Discord\ServerManager.sqf at line 165](../../../Src/host/Discord/ServerManager.sqf#L165)
