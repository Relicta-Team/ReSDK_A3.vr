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
File: [host\Database\SQLite\SQLite_functions.sqf at line 176](../../../Src/host/Database/SQLite/SQLite_functions.sqf#L176)
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


File: [host\Database\SQLite\SQLite_functions.sqf at line 142](../../../Src/host/Database/SQLite/SQLite_functions.sqf#L142)
## db_getCommonVal

Type: function

Description: 
- Param: _varName
- Param: _returnType (optional, default "string")

File: [host\Database\SQLite\SQLite_functions.sqf at line 149](../../../Src/host/Database/SQLite/SQLite_functions.sqf#L149)
## db_setCommonVal

Type: function

Description: 
- Param: _varName
- Param: _value
- Param: _inString (optional, default true)

File: [host\Database\SQLite\SQLite_functions.sqf at line 157](../../../Src/host/Database/SQLite/SQLite_functions.sqf#L157)
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

File: [host\Database\SQLite\SQLite_functions.sqf at line 173](../../../Src/host/Database/SQLite/SQLite_functions.sqf#L173)
# SQLite_init.sqf

## db_version

Type: Variable

Description: !версия базы данных (не расширения)


Initial value:
```sqf
"3.0"
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
File: [host\Database\SQLite\SQLite_manager.sqf at line 775](../../../Src/host/Database/SQLite/SQLite_manager.sqf#L775)
## __logrepsync(txtval,fmt)

Type: constant

> Exists if **EDITOR** not defined

Description: 
- Param: txtval
- Param: fmt

Replaced value:
```sqf

```
File: [host\Database\SQLite\SQLite_manager.sqf at line 777](../../../Src/host/Database/SQLite/SQLite_manager.sqf#L777)
## db_closeConnection

Type: function

Description: Закрывает базу данных


File: [host\Database\SQLite\SQLite_manager.sqf at line 8](../../../Src/host/Database/SQLite/SQLite_manager.sqf#L8)
## db_isClientRegistered

Type: function

Description: 
- Param: this

File: [host\Database\SQLite\SQLite_manager.sqf at line 13](../../../Src/host/Database/SQLite/SQLite_manager.sqf#L13)
## db_isDiscordIdRegistered

Type: function

Description: 
- Param: _disId

File: [host\Database\SQLite\SQLite_manager.sqf at line 18](../../../Src/host/Database/SQLite/SQLite_manager.sqf#L18)
## db_checkBan

Type: function

Description: Проверяет юид в бан-листе. Если забанен выводит сообщение. Если срок бана истёк - разбаниваем клиента
- Param: _disId
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

File: [host\Database\SQLite\SQLite_manager.sqf at line 97](../../../Src/host/Database/SQLite/SQLite_manager.sqf#L97)
## db_banJobByName

Type: function

Description: При изменении кода: все ошибочные возвраты должны иметь часть строки "ERROR:"
- Param: _banner (optional, default "AUTOMATIC")
- Param: _name
- Param: _role (optional, default "")
- Param: _reason (optional, default "")
- Param: _modif (optional, default [])

File: [host\Database\SQLite\SQLite_manager.sqf at line 139](../../../Src/host/Database/SQLite/SQLite_manager.sqf#L139)
## db_unbanJobByName

Type: function

Description: 
- Param: _banner
- Param: _name
- Param: _role (optional, default "")

File: [host\Database\SQLite\SQLite_manager.sqf at line 175](../../../Src/host/Database/SQLite/SQLite_manager.sqf#L175)
## db_isNickRegistered

Type: function

Description: 
- Param: _nick

File: [host\Database\SQLite\SQLite_manager.sqf at line 208](../../../Src/host/Database/SQLite/SQLite_manager.sqf#L208)
## db_disIdToNick

Type: function

Description: конвертация uid в никнейм из базы данных
- Param: _disId
- Param: _errorNick (optional, default "")

File: [host\Database\SQLite\SQLite_manager.sqf at line 214](../../../Src/host/Database/SQLite/SQLite_manager.sqf#L214)
## db_NickToDisId

Type: function

Description: 
- Param: _nick
- Param: _errorDisId (optional, default "")

File: [host\Database\SQLite\SQLite_manager.sqf at line 221](../../../Src/host/Database/SQLite/SQLite_manager.sqf#L221)
## db_getClientLockedSettings

Type: function

Description: 
- Param: _nick

File: [host\Database\SQLite\SQLite_manager.sqf at line 228](../../../Src/host/Database/SQLite/SQLite_manager.sqf#L228)
## db_updateClientLockedSettings

Type: function

Description: 
- Param: _nick
- Param: _lockedSettings (optional, default "")

File: [host\Database\SQLite\SQLite_manager.sqf at line 235](../../../Src/host/Database/SQLite/SQLite_manager.sqf#L235)
## db_registerAccount

Type: function

Description: Регистрация аккаунта по айди и имени
- Param: _disId
- Param: _name

File: [host\Database\SQLite\SQLite_manager.sqf at line 250](../../../Src/host/Database/SQLite/SQLite_manager.sqf#L250)
## db_registerStats

Type: function

Description: 
- Param: _disId
- Param: _arrCity (optional, default 0)

File: [host\Database\SQLite\SQLite_manager.sqf at line 259](../../../Src/host/Database/SQLite/SQLite_manager.sqf#L259)
## db_registerAuthTokenData

Type: function

Description: 
- Param: _disId
- Param: _gameToken
- Param: _atok
- Param: _reftok
- Param: _expDT

File: [host\Database\SQLite\SQLite_manager.sqf at line 266](../../../Src/host/Database/SQLite/SQLite_manager.sqf#L266)
## db_updateValuesOnConnect

Type: function

Description: Обновление коунтера подключений и даты последнего коннекта
- Param: _disId

File: [host\Database\SQLite\SQLite_manager.sqf at line 290](../../../Src/host/Database/SQLite/SQLite_manager.sqf#L290)
## db_checkAccessOnFirstSession

Type: function

Description: 
- Param: _dt

File: [host\Database\SQLite\SQLite_manager.sqf at line 297](../../../Src/host/Database/SQLite/SQLite_manager.sqf#L297)
## db_checkAccountLifetime

Type: function

Description: ! только для системных вызовов
- Param: _cli
- Param: _values

File: [host\Database\SQLite\SQLite_manager.sqf at line 309](../../../Src/host/Database/SQLite/SQLite_manager.sqf#L309)
## db_isConnectedFirstTimeToday

Type: function

Description: 
- Param: _dt

File: [host\Database\SQLite\SQLite_manager.sqf at line 323](../../../Src/host/Database/SQLite/SQLite_manager.sqf#L323)
## db_getAllBannedRoles

Type: function

Description: 
- Param: _disId

File: [host\Database\SQLite\SQLite_manager.sqf at line 332](../../../Src/host/Database/SQLite/SQLite_manager.sqf#L332)
## db_getAllBannedRolesWithDescription

Type: function

Description: 


File: [host\Database\SQLite\SQLite_manager.sqf at line 348](../../../Src/host/Database/SQLite/SQLite_manager.sqf#L348)
## db_saveClient

Type: function

Description: };
- Param: this

File: [host\Database\SQLite\SQLite_manager.sqf at line 386](../../../Src/host/Database/SQLite/SQLite_manager.sqf#L386)
## db_loadClient

Type: function

Description: };
- Param: this

File: [host\Database\SQLite\SQLite_manager.sqf at line 447](../../../Src/host/Database/SQLite/SQLite_manager.sqf#L447)
## db_updateClientSettings

Type: function

Description: При обновлении никнейма, доступа и прочих данных
- Param: this
- Param: _doSyncData (optional, default false)

File: [host\Database\SQLite\SQLite_manager.sqf at line 567](../../../Src/host/Database/SQLite/SQLite_manager.sqf#L567)
## db_handleReputation

Type: function

Description: 
- Param: this

File: [host\Database\SQLite\SQLite_manager.sqf at line 595](../../../Src/host/Database/SQLite/SQLite_manager.sqf#L595)
## db_saveReputationTests

Type: function

Description: в TestQuestions записывается результирующая строука: Q: Q1_text\nA: Q1_ans\n (e.t.c...)
- Param: this
- Param: _result
- Param: _mode

File: [host\Database\SQLite\SQLite_manager.sqf at line 626](../../../Src/host/Database/SQLite/SQLite_manager.sqf#L626)
## db_saveReputation

Type: function

Description: обычное сохранение репы
- Param: this

File: [host\Database\SQLite\SQLite_manager.sqf at line 658](../../../Src/host/Database/SQLite/SQLite_manager.sqf#L658)
## db_createGamemodeSession

Type: function

Description: создаем сессию и возвращаем её айди
- Param: _gmName

File: [host\Database\SQLite\SQLite_manager.sqf at line 667](../../../Src/host/Database/SQLite/SQLite_manager.sqf#L667)
## db_onGamemodeSessionStart

Type: function

Description: вызывается когда сессия началась


File: [host\Database\SQLite\SQLite_manager.sqf at line 690](../../../Src/host/Database/SQLite/SQLite_manager.sqf#L690)
## db_onGamemodeSessionEnd

Type: function

Description: вызывается когда сессия закончилась


File: [host\Database\SQLite\SQLite_manager.sqf at line 700](../../../Src/host/Database/SQLite/SQLite_manager.sqf#L700)
## db_registerNewVote

Type: function

Description: 
- Param: _id
- Param: _charTStruct
- Param: _clientList

File: [host\Database\SQLite\SQLite_manager.sqf at line 718](../../../Src/host/Database/SQLite/SQLite_manager.sqf#L718)
## db_registerVoteClient

Type: function

Description: 
- Param: _id
- Param: _name

File: [host\Database\SQLite\SQLite_manager.sqf at line 728](../../../Src/host/Database/SQLite/SQLite_manager.sqf#L728)
## db_processVoteClient

Type: function

Description: 
- Param: _name
- Param: _vote
- Param: _autoSync (optional, default true)

File: [host\Database\SQLite\SQLite_manager.sqf at line 736](../../../Src/host/Database/SQLite/SQLite_manager.sqf#L736)
## db_onSyncReputations

Type: function

Description: 


File: [host\Database\SQLite\SQLite_manager.sqf at line 769](../../../Src/host/Database/SQLite/SQLite_manager.sqf#L769)
## db_hasNeedClientVote

Type: function

Description: 
- Param: _name
- Param: _reputation (optional, default "")
- Param: _refInfo

File: [host\Database\SQLite\SQLite_manager.sqf at line 982](../../../Src/host/Database/SQLite/SQLite_manager.sqf#L982)
## db_da_isSynced

Type: function

Description: ! not used
- Param: _nick
- Param: _refId
- Param: _loadArrived (optional, default false)

File: [host\Database\SQLite\SQLite_manager.sqf at line 1054](../../../Src/host/Database/SQLite/SQLite_manager.sqf#L1054)
## db_da_isSyncedAsDiscordId

Type: function

Description: ! not used
- Param: _id

File: [host\Database\SQLite\SQLite_manager.sqf at line 1074](../../../Src/host/Database/SQLite/SQLite_manager.sqf#L1074)
## db_da_updateArrivedInCity

Type: function

Description: ! not used
- Param: _nick

File: [host\Database\SQLite\SQLite_manager.sqf at line 1082](../../../Src/host/Database/SQLite/SQLite_manager.sqf#L1082)
## db_da_register

Type: function

Description: ! not used
- Param: _nick
- Param: _discordid

File: [host\Database\SQLite\SQLite_manager.sqf at line 1097](../../../Src/host/Database/SQLite/SQLite_manager.sqf#L1097)
## db_da_updateStatArrivedInCity

Type: function

Description: обновляем статистику посещения города
- Param: _client

File: [host\Database\SQLite\SQLite_manager.sqf at line 1106](../../../Src/host/Database/SQLite/SQLite_manager.sqf#L1106)
## db_port_oldAccountRegistered

Type: function

Description: port handler, if true - successed port from old account
- Param: _did

File: [host\Database\SQLite\SQLite_manager.sqf at line 1121](../../../Src/host/Database/SQLite/SQLite_manager.sqf#L1121)
