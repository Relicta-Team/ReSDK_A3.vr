# SQLite.h

## dbRequest

Type: constant

Description: 


Replaced value:
```sqf
"sqlitenet" callExtension 
```
File: [host\Database\SQLite\SQLite.h at line 8](../../../Src/host/Database/SQLite/SQLite.h#L8)
## DB_PATH

Type: constant

> Exists if **EDITOR** defined

Description: 


Replaced value:
```sqf
((["WorkspaceHelper","getworkdir",[],true] call rescript_callCommand) + "\@EditorContent\db\GameMain.db")
```
File: [host\Database\SQLite\SQLite.h at line 11](../../../Src/host/Database/SQLite/SQLite.h#L11)
## DB_PATH

Type: constant

> Exists if **EDITOR** not defined

Description: 


Replaced value:
```sqf
"C:\Games\Arma3\A3Master\@server\db\GameMain.db"
```
File: [host\Database\SQLite\SQLite.h at line 13](../../../Src/host/Database/SQLite/SQLite.h#L13)
## DB_PATH

Type: constant

> Exists if **RBUILDER** defined

Description: 


Replaced value:
```sqf
((call ReBridge_getWorkspace) + ("\@server\db\GameMain.db"))
```
File: [host\Database\SQLite\SQLite.h at line 17](../../../Src/host/Database/SQLite/SQLite.h#L17)
# SQLite_functions.sqf

## CATCH_REQUEST_ERROR

Type: constant

Description: отлов ошибки с any полями бд


Replaced value:
```sqf

```
File: [host\Database\SQLite\SQLite_functions.sqf at line 8](../../../Src/host/Database/SQLite/SQLite_functions.sqf#L8)
## VALIDATE_LAST_ERROR

Type: constant

Description: проверка последней ошибки


Replaced value:
```sqf

```
File: [host\Database\SQLite\SQLite_functions.sqf at line 10](../../../Src/host/Database/SQLite/SQLite_functions.sqf#L10)
## applyficator(val)

Type: constant

Description: 
- Param: val

Replaced value:
```sqf
(if (val < 10) then {"0" + str val} else {str val})
```
File: [host\Database\SQLite\SQLite_functions.sqf at line 173](../../../Src/host/Database/SQLite/SQLite_functions.sqf#L173)
## db_open

Type: function

Description: 


File: [host\Database\SQLite\SQLite_functions.sqf at line 12](../../../Src/host/Database/SQLite/SQLite_functions.sqf#L12)
## db_close

Type: function

Description: 


File: [host\Database\SQLite\SQLite_functions.sqf at line 16](../../../Src/host/Database/SQLite/SQLite_functions.sqf#L16)
## db_isOpened

Type: function

Description: 


File: [host\Database\SQLite\SQLite_functions.sqf at line 22](../../../Src/host/Database/SQLite/SQLite_functions.sqf#L22)
## db_getlasterror

Type: function

Description: 


File: [host\Database\SQLite\SQLite_functions.sqf at line 26](../../../Src/host/Database/SQLite/SQLite_functions.sqf#L26)
## db_flushlasterror

Type: function

Description: 


File: [host\Database\SQLite\SQLite_functions.sqf at line 30](../../../Src/host/Database/SQLite/SQLite_functions.sqf#L30)
## db_isEnabledStdoutLog

Type: function

Description: 


File: [host\Database\SQLite\SQLite_functions.sqf at line 34](../../../Src/host/Database/SQLite/SQLite_functions.sqf#L34)
## db_switchStdoutLog

Type: function

Description: 


File: [host\Database\SQLite\SQLite_functions.sqf at line 38](../../../Src/host/Database/SQLite/SQLite_functions.sqf#L38)
## db_checkSystemReturn

Type: function

Description: true если системный возврат
- Param: _output
- Param: _printtoconsole (optional, default true)

File: [host\Database\SQLite\SQLite_functions.sqf at line 43](../../../Src/host/Database/SQLite/SQLite_functions.sqf#L43)
## db_query

Type: function

Description: 
- Param: _request
- Param: _retTypes (optional, default "")
- Param: _singleReturn (optional, default false)

File: [host\Database\SQLite\SQLite_functions.sqf at line 103](../../../Src/host/Database/SQLite/SQLite_functions.sqf#L103)
## db_getVersion

Type: function

Description: versioning


File: [host\Database\SQLite\SQLite_functions.sqf at line 139](../../../Src/host/Database/SQLite/SQLite_functions.sqf#L139)
## db_getCommonVal

Type: function

Description: 
- Param: _varName
- Param: _returnType (optional, default "string")

File: [host\Database\SQLite\SQLite_functions.sqf at line 146](../../../Src/host/Database/SQLite/SQLite_functions.sqf#L146)
## db_setCommonVal

Type: function

Description: 
- Param: _varName
- Param: _value
- Param: _inString (optional, default true)

File: [host\Database\SQLite\SQLite_functions.sqf at line 154](../../../Src/host/Database/SQLite/SQLite_functions.sqf#L154)
## db_dateTimeFormatForComparsion

Type: function

Description: Форматирует массив даты-времени в строку, пригодную для сравнения с datetime() в sqlite
- Param: _y (optional, default 1)
- Param: _mt (optional, default 1)
- Param: _d (optional, default 1)
- Param: _h (optional, default 0)
- Param: _m (optional, default 0)
- Param: _s (optional, default 0)
- Param: _ms (optional, default 0)

File: [host\Database\SQLite\SQLite_functions.sqf at line 170](../../../Src/host/Database/SQLite/SQLite_functions.sqf#L170)
# SQLite_init.sqf

## db_version

Type: Variable

Description: !версия базы данных (не расширения)


Initial value:
```sqf
"2.0"
```
File: [host\Database\SQLite\SQLite_init.sqf at line 14](../../../Src/host/Database/SQLite/SQLite_init.sqf#L14)
## db_canUseQueryLogToStdout

Type: Variable

Description: true будет выводить каждый запрос в дебаг консоль


Initial value:
```sqf
false
```
File: [host\Database\SQLite\SQLite_init.sqf at line 16](../../../Src/host/Database/SQLite/SQLite_init.sqf#L16)
## db_init

Type: function

Description: Основная функция инициализации базы данных


File: [host\Database\SQLite\SQLite_init.sqf at line 19](../../../Src/host/Database/SQLite/SQLite_init.sqf#L19)
# SQLite_manager.sqf

## __logrepsync(txtval,fmt)

Type: constant

> Exists if **EDITOR** defined

Description: 
- Param: txtval
- Param: fmt

Replaced value:
```sqf
[(format[txtval arg fmt]) call {if not_equalTypes(_this,"") then {str _this} else {str parseText _this}},"log"] call chatPrint;
```
File: [host\Database\SQLite\SQLite_manager.sqf at line 727](../../../Src/host/Database/SQLite/SQLite_manager.sqf#L727)
## __logrepsync(txtval,fmt)

Type: constant

> Exists if **EDITOR** not defined

Description: 
- Param: txtval
- Param: fmt

Replaced value:
```sqf

```
File: [host\Database\SQLite\SQLite_manager.sqf at line 729](../../../Src/host/Database/SQLite/SQLite_manager.sqf#L729)
## db_closeConnection

Type: function

Description: Закрывает базу данных


File: [host\Database\SQLite\SQLite_manager.sqf at line 8](../../../Src/host/Database/SQLite/SQLite_manager.sqf#L8)
## db_isClientRegistered

Type: function

Description: 
- Param: this

File: [host\Database\SQLite\SQLite_manager.sqf at line 13](../../../Src/host/Database/SQLite/SQLite_manager.sqf#L13)
## db_isUIDRegistered

Type: function

Description: 
- Param: _uid

File: [host\Database\SQLite\SQLite_manager.sqf at line 18](../../../Src/host/Database/SQLite/SQLite_manager.sqf#L18)
## db_checkBan

Type: function

Description: Проверяет юид в бан-листе. Если забанен выводит сообщение. Если срок бана истёк - разбаниваем клиента
- Param: _uid
- Param: _refData

File: [host\Database\SQLite\SQLite_manager.sqf at line 24](../../../Src/host/Database/SQLite/SQLite_manager.sqf#L24)
## db_unbanByName

Type: function

Description: 
- Param: _name
- Param: _whoWantUnban

File: [host\Database\SQLite\SQLite_manager.sqf at line 53](../../../Src/host/Database/SQLite/SQLite_manager.sqf#L53)
## db_banByName

Type: function

Description: 
- Param: _banner (optional, default "AUTOMATIC")
- Param: _name
- Param: _reason (optional, default "")
- Param: _modif (optional, default [])

File: [host\Database\SQLite\SQLite_manager.sqf at line 93](../../../Src/host/Database/SQLite/SQLite_manager.sqf#L93)
## db_banJobByName

Type: function

Description: При изменении кода: все ошибочные возвраты должны иметь часть строки "ERROR:"
- Param: _banner (optional, default "AUTOMATIC")
- Param: _name
- Param: _role (optional, default "")
- Param: _reason (optional, default "")
- Param: _modif (optional, default [])

File: [host\Database\SQLite\SQLite_manager.sqf at line 135](../../../Src/host/Database/SQLite/SQLite_manager.sqf#L135)
## db_unbanJobByName

Type: function

Description: 
- Param: _banner
- Param: _name
- Param: _role (optional, default "")

File: [host\Database\SQLite\SQLite_manager.sqf at line 171](../../../Src/host/Database/SQLite/SQLite_manager.sqf#L171)
## db_isNickRegistered

Type: function

Description: 
- Param: _nick

File: [host\Database\SQLite\SQLite_manager.sqf at line 204](../../../Src/host/Database/SQLite/SQLite_manager.sqf#L204)
## db_uidToNick

Type: function

Description: конвертация uid в никнейм из базы данных
- Param: _uid
- Param: _errorNick (optional, default "")

File: [host\Database\SQLite\SQLite_manager.sqf at line 210](../../../Src/host/Database/SQLite/SQLite_manager.sqf#L210)
## db_NickToUid

Type: function

Description: 
- Param: _nick
- Param: _errorUid (optional, default "")

File: [host\Database\SQLite\SQLite_manager.sqf at line 217](../../../Src/host/Database/SQLite/SQLite_manager.sqf#L217)
## db_getClientLockedSettings

Type: function

Description: 
- Param: _nick

File: [host\Database\SQLite\SQLite_manager.sqf at line 224](../../../Src/host/Database/SQLite/SQLite_manager.sqf#L224)
## db_updateClientLockedSettings

Type: function

Description: 
- Param: _nick
- Param: _lockedSettings (optional, default "")

File: [host\Database\SQLite\SQLite_manager.sqf at line 231](../../../Src/host/Database/SQLite/SQLite_manager.sqf#L231)
## db_registerAccount

Type: function

Description: Регистрация аккаунта по юиду и имени
- Param: _uid
- Param: _name

File: [host\Database\SQLite\SQLite_manager.sqf at line 246](../../../Src/host/Database/SQLite/SQLite_manager.sqf#L246)
## db_updateValuesOnConnect

Type: function

Description: Обновление коунтера подключений и даты последнего коннекта
- Param: _uid

File: [host\Database\SQLite\SQLite_manager.sqf at line 256](../../../Src/host/Database/SQLite/SQLite_manager.sqf#L256)
## db_checkAccessOnFirstSession

Type: function

Description: 
- Param: _dt

File: [host\Database\SQLite\SQLite_manager.sqf at line 263](../../../Src/host/Database/SQLite/SQLite_manager.sqf#L263)
## db_checkAccountLifetime

Type: function

Description: ! только для системных вызовов
- Param: _cli
- Param: _values

File: [host\Database\SQLite\SQLite_manager.sqf at line 275](../../../Src/host/Database/SQLite/SQLite_manager.sqf#L275)
## db_isConnectedFirstTimeToday

Type: function

Description: 
- Param: _dt

File: [host\Database\SQLite\SQLite_manager.sqf at line 289](../../../Src/host/Database/SQLite/SQLite_manager.sqf#L289)
## db_getAllBannedRoles

Type: function

Description: 
- Param: _uid

File: [host\Database\SQLite\SQLite_manager.sqf at line 298](../../../Src/host/Database/SQLite/SQLite_manager.sqf#L298)
## db_getAllBannedRolesWithDescription

Type: function

Description: 


File: [host\Database\SQLite\SQLite_manager.sqf at line 313](../../../Src/host/Database/SQLite/SQLite_manager.sqf#L313)
## db_registerClient

Type: function

Description: регистрация аккаунта по объекту
- Param: this

File: [host\Database\SQLite\SQLite_manager.sqf at line 342](../../../Src/host/Database/SQLite/SQLite_manager.sqf#L342)
## db_saveClient

Type: function

Description: 
- Param: this

File: [host\Database\SQLite\SQLite_manager.sqf at line 351](../../../Src/host/Database/SQLite/SQLite_manager.sqf#L351)
## db_loadClient

Type: function

Description: };
- Param: this

File: [host\Database\SQLite\SQLite_manager.sqf at line 412](../../../Src/host/Database/SQLite/SQLite_manager.sqf#L412)
## db_updateClientSettings

Type: function

Description: При обновлении никнейма, доступа и прочих данных
- Param: this
- Param: _doSyncData (optional, default false)

File: [host\Database\SQLite\SQLite_manager.sqf at line 523](../../../Src/host/Database/SQLite/SQLite_manager.sqf#L523)
## db_handleReputation

Type: function

Description: 
- Param: this

File: [host\Database\SQLite\SQLite_manager.sqf at line 551](../../../Src/host/Database/SQLite/SQLite_manager.sqf#L551)
## db_saveReputationTests

Type: function

Description: в TestQuestions записывается результирующая строука: Q: Q1_text\nA: Q1_ans\n (e.t.c...)
- Param: this
- Param: _result
- Param: _mode

File: [host\Database\SQLite\SQLite_manager.sqf at line 582](../../../Src/host/Database/SQLite/SQLite_manager.sqf#L582)
## db_saveReputation

Type: function

Description: обычное сохранение репы
- Param: this

File: [host\Database\SQLite\SQLite_manager.sqf at line 614](../../../Src/host/Database/SQLite/SQLite_manager.sqf#L614)
## db_createGamemodeSession

Type: function

Description: создаем сессию и возвращаем её айди
- Param: _gmName

File: [host\Database\SQLite\SQLite_manager.sqf at line 623](../../../Src/host/Database/SQLite/SQLite_manager.sqf#L623)
## db_onGamemodeSessionStart

Type: function

Description: вызывается когда сессия началась


File: [host\Database\SQLite\SQLite_manager.sqf at line 642](../../../Src/host/Database/SQLite/SQLite_manager.sqf#L642)
## db_onGamemodeSessionEnd

Type: function

Description: вызывается когда сессия закончилась


File: [host\Database\SQLite\SQLite_manager.sqf at line 652](../../../Src/host/Database/SQLite/SQLite_manager.sqf#L652)
## db_registerNewVote

Type: function

Description: 
- Param: _id
- Param: _charTStruct
- Param: _clientList

File: [host\Database\SQLite\SQLite_manager.sqf at line 670](../../../Src/host/Database/SQLite/SQLite_manager.sqf#L670)
## db_registerVoteClient

Type: function

Description: 
- Param: _id
- Param: _name

File: [host\Database\SQLite\SQLite_manager.sqf at line 680](../../../Src/host/Database/SQLite/SQLite_manager.sqf#L680)
## db_processVoteClient

Type: function

Description: 
- Param: _name
- Param: _vote
- Param: _autoSync (optional, default true)

File: [host\Database\SQLite\SQLite_manager.sqf at line 688](../../../Src/host/Database/SQLite/SQLite_manager.sqf#L688)
## db_onSyncReputations

Type: function

Description: 


File: [host\Database\SQLite\SQLite_manager.sqf at line 721](../../../Src/host/Database/SQLite/SQLite_manager.sqf#L721)
## db_hasNeedClientVote

Type: function

Description: 
- Param: _name
- Param: _reputation (optional, default "")
- Param: _refInfo

File: [host\Database\SQLite\SQLite_manager.sqf at line 934](../../../Src/host/Database/SQLite/SQLite_manager.sqf#L934)
## db_da_isSynced

Type: function

Description: ======================================
- Param: _nick
- Param: _refId
- Param: _loadArrived (optional, default false)

File: [host\Database\SQLite\SQLite_manager.sqf at line 1005](../../../Src/host/Database/SQLite/SQLite_manager.sqf#L1005)
## db_da_isSyncedAsDiscordId

Type: function

Description: 
- Param: _id

File: [host\Database\SQLite\SQLite_manager.sqf at line 1024](../../../Src/host/Database/SQLite/SQLite_manager.sqf#L1024)
## db_da_updateArrivedInCity

Type: function

Description: 
- Param: _nick

File: [host\Database\SQLite\SQLite_manager.sqf at line 1031](../../../Src/host/Database/SQLite/SQLite_manager.sqf#L1031)
## db_da_register

Type: function

Description: 
- Param: _nick
- Param: _discordid

File: [host\Database\SQLite\SQLite_manager.sqf at line 1045](../../../Src/host/Database/SQLite/SQLite_manager.sqf#L1045)
