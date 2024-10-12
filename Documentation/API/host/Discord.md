# Accounts.sqf

## dsm_accounts_isEnabled

Type: Variable

Description: ! Внимание! На рантайме если перелкючать этот флаг, то нужно принудительно вызывать dsm_accounts_loadDiscordId на каждом клиенте в сессии


Initial value:
```sqf
true
```
File: [host\Discord\Accounts.sqf at line 9](../../../Src/host/Discord/Accounts.sqf#L9)
## dsm_accounts_enableRoleAccessCheck

Type: Variable

Description: рантайм система проверки ролей дискорда и ограничения игровых ролей


Initial value:
```sqf
true
```
File: [host\Discord\Accounts.sqf at line 12](../../../Src/host/Discord/Accounts.sqf#L12)
## dsm_accounts_mapRegister

Type: Variable

Description: 


Initial value:
```sqf
createHashMap //карта регистрации. ключи - токены, значения - данные для регистрации
```
File: [host\Discord\Accounts.sqf at line 18](../../../Src/host/Discord/Accounts.sqf#L18)
## dsm_accounts_userRequester

Type: Variable

Description: карта регистрации. ключи - токены, значения - данные для регистрации


Initial value:
```sqf
createHashMap //карта юзеров. защита от дублей токенов
```
File: [host\Discord\Accounts.sqf at line 19](../../../Src/host/Discord/Accounts.sqf#L19)
## dsm_accounts_nickRequester

Type: Variable

Description: карта юзеров. защита от дублей токенов


Initial value:
```sqf
createHashMap
```
File: [host\Discord\Accounts.sqf at line 20](../../../Src/host/Discord/Accounts.sqf#L20)
## dsm_accounts_tokenLifetime

Type: Variable

Description: 


Initial value:
```sqf
60 * 5
```
File: [host\Discord\Accounts.sqf at line 22](../../../Src/host/Discord/Accounts.sqf#L22)
## dsm_accounts_arriveInCityCountNeed

Type: Variable

Description: сколько раз нужно зарегаться в городе, чтобы получить роль форсеки


Initial value:
```sqf
5
```
File: [host\Discord\Accounts.sqf at line 25](../../../Src/host/Discord/Accounts.sqf#L25)
## dsm_accounts_list_arriveSessionUnique

Type: Variable

Description: 


Initial value:
```sqf
[]
```
File: [host\Discord\Accounts.sqf at line 137](../../../Src/host/Discord/Accounts.sqf#L137)
## dsm_accounts_canUse

Type: function

Description: 


File: [host\Discord\Accounts.sqf at line 14](../../../Src/host/Discord/Accounts.sqf#L14)
## dsm_accounts_checkSync

Type: function

Description: вызывается из лс сообщений у бота. запрос токена авторизации
- Param: _nick
- Param: _hash
- Param: _chanId
- Param: _discordUserId

File: [host\Discord\Accounts.sqf at line 29](../../../Src/host/Discord/Accounts.sqf#L29)
## dsm_accounts_register

Type: function

Description: выполняет привязку дискорда к учетке и проивзодит синхронизацию ролей
- Param: _client
- Param: _token

File: [host\Discord\Accounts.sqf at line 72](../../../Src/host/Discord/Accounts.sqf#L72)
## dsm_accounts_loadDiscordId

Type: function

Description: загрузка привязки дискорда. Вызывается когда клиент загружается из БД
- Param: _client
- Param: _nick

File: [host\Discord\Accounts.sqf at line 122](../../../Src/host/Discord/Accounts.sqf#L122)
## dsm_accounts_handleRegisterArriveInCity

Type: function

Description: Вызывается когда клиента регистрируют в городе
- Param: _cli

File: [host\Discord\Accounts.sqf at line 139](../../../Src/host/Discord/Accounts.sqf#L139)
## dsm_accounts_requestUpdateRoles

Type: function

Description: запрос в менеджер на обновление ролей
- Param: _name
- Param: _discordUserId

File: [host\Discord\Accounts.sqf at line 163](../../../Src/host/Discord/Accounts.sqf#L163)
## dsm_accounts_addToRole

Type: function

Description: 
- Param: _discordUserId
- Param: _roleName

File: [host\Discord\Accounts.sqf at line 168](../../../Src/host/Discord/Accounts.sqf#L168)
## dsm_accounts_removeFromRole

Type: function

Description: 
- Param: _discordUserId
- Param: _roleName

File: [host\Discord\Accounts.sqf at line 173](../../../Src/host/Discord/Accounts.sqf#L173)
## dsm_acconunts_setNickname

Type: function

Description: установка никнейма для дискорд клиента
- Param: _discordUserId
- Param: _nickname

File: [host\Discord\Accounts.sqf at line 179](../../../Src/host/Discord/Accounts.sqf#L179)
# Discord.sqf

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
## disc_stack_logger

Type: Variable

> Exists if **DISCORD_ENABLE_EXTENDED_TRANSPORT** defined

Description: 


Initial value:
```sqf
[]
```
File: [host\Discord\Discord.sqf at line 20](../../../Src/host/Discord/Discord.sqf#L20)
## disc_lastLoggerTime

Type: Variable

Description: 


Initial value:
```sqf
tickTime
```
File: [host\Discord\Discord.sqf at line 21](../../../Src/host/Discord/Discord.sqf#L21)
## disc_messagesLeftPerSec

Type: Variable

Description: 


Initial value:
```sqf
DISCORD_MAX_MESSAGES_COUNT_PERDELAY
```
File: [host\Discord\Discord.sqf at line 22](../../../Src/host/Discord/Discord.sqf#L22)
## disc_handle_update

Type: Variable

Description: 


Initial value:
```sqf
-1
```
File: [host\Discord\Discord.sqf at line 24](../../../Src/host/Discord/Discord.sqf#L24)
## disc_token_admin

Type: Variable

Description: 


Initial value:
```sqf
"Admin"
```
File: [host\Discord\Discord.sqf at line 30](../../../Src/host/Discord/Discord.sqf#L30)
## disc_token_logger

Type: Variable

Description: 


Initial value:
```sqf
"Logger"
```
File: [host\Discord\Discord.sqf at line 31](../../../Src/host/Discord/Discord.sqf#L31)
## disc_icon_logger

Type: Variable

Description: 


Initial value:
```sqf
"https://flammlin.com/wp-content/uploads/2020/03/logfile_file.png"
```
File: [host\Discord\Discord.sqf at line 32](../../../Src/host/Discord/Discord.sqf#L32)
## disc_icon_serverNotif

Type: Variable

Description: 


Initial value:
```sqf
"https://cdn.discordapp.com/emojis/467665814540124170.png?v=1"
```
File: [host\Discord\Discord.sqf at line 40](../../../Src/host/Discord/Discord.sqf#L40)
## disc_handle_update

Type: Variable

> Exists if **DISCORD_ENABLE_EXTENDED_TRANSPORT** defined

Description: 


Initial value:
```sqf
startUpdate(disc_onUpdate,DISCORD_UPDATE_DELAY)
```
File: [host\Discord\Discord.sqf at line 71](../../../Src/host/Discord/Discord.sqf#L71)
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
## DiscordEmbedBuilder_fnc_buildSqf

Type: function

> Exists if **RBUILDER** defined

Description: 
- Param: _token
- Param: _mes
- Param: _name
- Param: _ico
- Param: _flg

File: [host\Discord\Discord.sqf at line 168](../../../Src/host/Discord/Discord.sqf#L168)
# ServerManager.sqf

## DSM_CALLBACKNAME

Type: constant

Description: 


Replaced value:
```sqf
"dsm_ext"
```
File: [host\Discord\ServerManager.sqf at line 16](../../../Src/host/Discord/ServerManager.sqf#L16)
## DSM_CHANNEL_CHANGELOG

Type: constant

> Exists if **EDITOR** defined

Description: 


Replaced value:
```sqf
"781280820912062556"
```
File: [host\Discord\ServerManager.sqf at line 19](../../../Src/host/Discord/ServerManager.sqf#L19)
## DSM_CHANNEL_CHANGELOG

Type: constant

> Exists if **EDITOR** not defined

Description: 


Replaced value:
```sqf
"847850893076201522"
```
File: [host\Discord\ServerManager.sqf at line 21](../../../Src/host/Discord/ServerManager.sqf#L21)
## dsm_onlineUpdateHandle

Type: Variable

Description: #define DSM_DISABLE


Initial value:
```sqf
-1
```
File: [host\Discord\ServerManager.sqf at line 8](../../../Src/host/Discord/ServerManager.sqf#L8)
## dsm_isFirstLoad

Type: Variable

Description: 


Initial value:
```sqf
false
```
File: [host\Discord\ServerManager.sqf at line 12](../../../Src/host/Discord/ServerManager.sqf#L12)
## dsm_connectedToManager

Type: Variable

Description: 


Initial value:
```sqf
false
```
File: [host\Discord\ServerManager.sqf at line 14](../../../Src/host/Discord/ServerManager.sqf#L14)
## dsm_internal_virtualClient

Type: Variable

Description: ================================= server command executer =============================


Initial value:
```sqf
nullPtr
```
File: [host\Discord\ServerManager.sqf at line 174](../../../Src/host/Discord/ServerManager.sqf#L174)
## dsm_stdCall

Type: function

Description: 
- Param: _func
- Param: _args (optional, default [])

File: [host\Discord\ServerManager.sqf at line 29](../../../Src/host/Discord/ServerManager.sqf#L29)
## dsm_isErrorReturn

Type: function

Description: 


File: [host\Discord\ServerManager.sqf at line 34](../../../Src/host/Discord/ServerManager.sqf#L34)
## dsm_deserializeStringList

Type: function

Description: 


File: [host\Discord\ServerManager.sqf at line 38](../../../Src/host/Discord/ServerManager.sqf#L38)
## dsm_sendToChannel

Type: function

Description: 
- Param: _chanId
- Param: _content

File: [host\Discord\ServerManager.sqf at line 42](../../../Src/host/Discord/ServerManager.sqf#L42)
## dsm_sendOnline

Type: function

Description: 
- Param: _num

File: [host\Discord\ServerManager.sqf at line 50](../../../Src/host/Discord/ServerManager.sqf#L50)
## dsm_onOnlineUpdate

Type: function

Description: 


File: [host\Discord\ServerManager.sqf at line 55](../../../Src/host/Discord/ServerManager.sqf#L55)
## dsm_initialize

Type: function

Description: 


File: [host\Discord\ServerManager.sqf at line 59](../../../Src/host/Discord/ServerManager.sqf#L59)
## dsm_deinitialize

Type: function

Description: 


File: [host\Discord\ServerManager.sqf at line 103](../../../Src/host/Discord/ServerManager.sqf#L103)
## dsm_callbackHandle

Type: function

Description: 
- Param: _name
- Param: _function
- Param: _data

File: [host\Discord\ServerManager.sqf at line 109](../../../Src/host/Discord/ServerManager.sqf#L109)
## dsm_isLoaded

Type: function

Description: 


File: [host\Discord\ServerManager.sqf at line 167](../../../Src/host/Discord/ServerManager.sqf#L167)
## dsm_callServerCommand

Type: function

Description: 
- Param: _cmd
- Param: _executorName

File: [host\Discord\ServerManager.sqf at line 176](../../../Src/host/Discord/ServerManager.sqf#L176)
