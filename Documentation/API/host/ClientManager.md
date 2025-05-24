# Client.hpp

## ACCESS_PLAYER

Type: constant

Description: 


Replaced value:
```sqf
0
```
File: [host\ClientManager\Client.hpp at line 7](../../../Src/host/ClientManager/Client.hpp#L7)
## ACCESS_FORSAKEN

Type: constant

Description: 


Replaced value:
```sqf
1
```
File: [host\ClientManager\Client.hpp at line 8](../../../Src/host/ClientManager/Client.hpp#L8)
## ACCESS_ADMIN

Type: constant

Description: 


Replaced value:
```sqf
10
```
File: [host\ClientManager\Client.hpp at line 9](../../../Src/host/ClientManager/Client.hpp#L9)
## ACCESS_OWNERS

Type: constant

Description: 


Replaced value:
```sqf
100
```
File: [host\ClientManager\Client.hpp at line 10](../../../Src/host/ClientManager/Client.hpp#L10)
## ACCESS_LIST_NODE_BINDING

Type: constant

Description: 


Replaced value:
```sqf
['ACCESS_PLAYER:Игрок:', \
    'ACCESS_FORSAKEN:Покинутый:', \
    'ACCESS_ADMIN:Администратор:', \
    'ACCESS_OWNERS:Владелец:']
```
File: [host\ClientManager\Client.hpp at line 13](../../../Src/host/ClientManager/Client.hpp#L13)
# ClientController.hpp

## CONNECTION_ACTION_PREPARECLIENT

Type: constant

Description: 


Replaced value:
```sqf
1
```
File: [host\ClientManager\ClientController.hpp at line 8](../../../Src/host/ClientManager/ClientController.hpp#L8)
## CONNECTION_ACTION_OPENLOBBY

Type: constant

Description: 


Replaced value:
```sqf
2
```
File: [host\ClientManager\ClientController.hpp at line 9](../../../Src/host/ClientManager/ClientController.hpp#L9)
## CONNECTION_ACTION_OPENLOBBY_AND_DELMOB

Type: constant

Description: 


Replaced value:
```sqf
3
```
File: [host\ClientManager\ClientController.hpp at line 10](../../../Src/host/ClientManager/ClientController.hpp#L10)
## CONNECTION_ACTION_AWAITSWITCH

Type: constant

Description: 


Replaced value:
```sqf
4
```
File: [host\ClientManager\ClientController.hpp at line 11](../../../Src/host/ClientManager/ClientController.hpp#L11)
# ClientController.sqf

## cm_switchLocality

Type: function

Description: 
- Param: _unit
- Param: _player

File: [host\ClientManager\ClientController.sqf at line 12](../../../Src/host/ClientManager/ClientController.sqf#L12)
## cm_setOwner

Type: function

Description: rpcAdd("switchLocality",_switchLocality);


File: [host\ClientManager\ClientController.sqf at line 29](../../../Src/host/ClientManager/ClientController.sqf#L29)
## cm_switchToMob

Type: function

Description: 
- Param: _oldMob
- Param: _newMob
- Param: _destroyOld (optional, default false)

File: [host\ClientManager\ClientController.sqf at line 71](../../../Src/host/ClientManager/ClientController.sqf#L71)
# ClientManager.h

## log_client(mes)

Type: constant

Description: 
- Param: mes

Replaced value:
```sqf
logformat("[SERVER::MAIN]:    %1",mes)
```
File: [host\ClientManager\ClientManager.h at line 8](../../../Src/host/ClientManager/ClientManager.h#L8)
## logger_client(mes,fmt)

Type: constant

Description: 
- Param: mes
- Param: fmt

Replaced value:
```sqf
logformat("[SERVER::MAIN]:    %1",format[mes arg fmt]); [mes arg fmt] call systemLog
```
File: [host\ClientManager\ClientManager.h at line 10](../../../Src/host/ClientManager/ClientManager.h#L10)
## TIME_TO_INIT_CLIENT

Type: constant

Description: время на инициализацию (доп 30 секунд на предзагрузку и накладные расходы выполнения)


Replaced value:
```sqf
60*3 + 30
```
File: [host\ClientManager\ClientManager.h at line 13](../../../Src/host/ClientManager/ClientManager.h#L13)
# ClientManager.sqf

## client_handler_onConnect

Type: Variable

> Exists if **EMULATE_CLIENT_INSP** not defined

Description: 


Initial value:
```sqf
addMissionEventHandler ["PlayerConnected",_event_onClientConnected]
```
File: [host\ClientManager\ClientManager.sqf at line 55](../../../Src/host/ClientManager/ClientManager.sqf#L55)
## client_handler_onDisconnect

Type: Variable

Description: 


Initial value:
```sqf
addMissionEventHandler ["PlayerDisconnected",_event_onClientDisconnected] //HandleDisconnect - не удовлетворяет требованиям
```
File: [host\ClientManager\ClientManager.sqf at line 56](../../../Src/host/ClientManager/ClientManager.sqf#L56)
## cm_onClientAuthSuccess

Type: function

Description: called on client auth success
- Param: _owner
- Param: _gameToken
- Param: _discId
- Param: _atok
- Param: _reftok
- Param: _expDT

File: [host\ClientManager\ClientManager.sqf at line 60](../../../Src/host/ClientManager/ClientManager.sqf#L60)
## cm_handleBanClient

Type: function

Description: handle ban client on auth
- Param: _owner
- Param: _disId

File: [host\ClientManager\ClientManager.sqf at line 86](../../../Src/host/ClientManager/ClientManager.sqf#L86)
## cm_getDiscordIdByOwner

Type: function

Description: 
- Param: _owner

File: [host\ClientManager\ClientManager.sqf at line 118](../../../Src/host/ClientManager/ClientManager.sqf#L118)
# CommandsExec.sqf

## PUBLIC_COMMAND

Type: constant

Description: 


Replaced value:
```sqf
-99999
```
File: [host\ClientManager\CommandsExec.sqf at line 8](../../../Src/host/ClientManager/CommandsExec.sqf#L8)
## __validate_cmd(cmdname)

Type: constant

Description: 
- Param: cmdname

Replaced value:
```sqf
if (cmdname in cm_commands_map) exitWith {errorformat("Duplicate command %1 (%3 at %2)",cmdname arg __LINE__ arg __FILE__); ["Duplicate command %1 (%3 at %2)",cmdname arg __LINE__ arg __FILE__] call logCritical; appExit(APPEXIT_REASON_DOUBLEDEF)}
```
File: [host\ClientManager\CommandsExec.sqf at line 70](../../../Src/host/ClientManager/CommandsExec.sqf#L70)
## addCommand(name,owners)

Type: constant

Description: 
- Param: name
- Param: owners

Replaced value:
```sqf
_cm_map_dataCode = [[owners],""]; __validate_cmd(name); cm_commands_map set [name,_cm_map_dataCode]; _cm_map_dataCode pushBack
```
File: [host\ClientManager\CommandsExec.sqf at line 71](../../../Src/host/ClientManager/CommandsExec.sqf#L71)
## addCommandWithDescription(name,owners,desc)

Type: constant

Description: 
- Param: name
- Param: owners
- Param: desc

Replaced value:
```sqf
_cm_map_dataCode = [[owners],desc]; __validate_cmd(name); cm_commands_map set [name,_cm_map_dataCode]; _cm_map_dataCode pushBack
```
File: [host\ClientManager\CommandsExec.sqf at line 72](../../../Src/host/ClientManager/CommandsExec.sqf#L72)
## IS_LOCAL_COMMAND()

Type: constant

Description: 
- Param: 

Replaced value:
```sqf
rpcSendToClient(_owner,"onLocalCommandCalled",[_command arg _arguments])
```
File: [host\ClientManager\CommandsExec.sqf at line 73](../../../Src/host/ClientManager/CommandsExec.sqf#L73)
## caller

Type: constant

Description: 


Replaced value:
```sqf
_owner
```
File: [host\ClientManager\CommandsExec.sqf at line 74](../../../Src/host/ClientManager/CommandsExec.sqf#L74)
## args

Type: constant

Description: 


Replaced value:
```sqf
_arguments
```
File: [host\ClientManager\CommandsExec.sqf at line 75](../../../Src/host/ClientManager/CommandsExec.sqf#L75)
## checkIfMobExists()

Type: constant

Description: 
- Param: 

Replaced value:
```sqf
if (!_canAccessMob) exitWith {false};
```
File: [host\ClientManager\CommandsExec.sqf at line 76](../../../Src/host/ClientManager/CommandsExec.sqf#L76)
## thisClient

Type: constant

Description: 


Replaced value:
```sqf
_client
```
File: [host\ClientManager\CommandsExec.sqf at line 77](../../../Src/host/ClientManager/CommandsExec.sqf#L77)
## cm_commands_map

Type: Variable

Description: 


Initial value:
```sqf
createHashMap
```
File: [host\ClientManager\CommandsExec.sqf at line 68](../../../Src/host/ClientManager/CommandsExec.sqf#L68)
## cm_processClientCommand

Type: function

Description: 
- Param: _playerObject
- Param: _text
- Param: _isClient (optional, default false)

File: [host\ClientManager\CommandsExec.sqf at line 16](../../../Src/host/ClientManager/CommandsExec.sqf#L16)
# functions.sqf

## __compare_equality_hard

Type: constant

Description: 


Replaced value:
```sqf
isequalto
```
File: [host\ClientManager\functions.sqf at line 67](../../../Src/host/ClientManager/functions.sqf#L67)
## __compare_equality_soft

Type: constant

Description: 


Replaced value:
```sqf
==
```
File: [host\ClientManager\functions.sqf at line 68](../../../Src/host/ClientManager/functions.sqf#L68)
## protoFind(by_func,var,comparer)

Type: constant

Description: 
- Param: by_func
- Param: var
- Param: comparer

Replaced value:
```sqf
cm_findClientBy##by_func = { \
	params ["_id",["_checkInDisconnected",false]]; \
	private _rez = cm_allClients findif {getVar(_x,var) comparer _id}; \
	if (_rez == -1) exitWith { \
		if (!_checkInDisconnected) exitWith {nullPtr}; \
		private _listDisc = values cm_disconnectedClients; \
		_rez = _listDisc findif {getVar(_x,var) comparer _id}; \
		if (_rez == -1) exitWith {nullPtr}; \
		_listDisc select _rez; \
	}; \
	cm_allClients select _rez}
```
File: [host\ClientManager\functions.sqf at line 69](../../../Src/host/ClientManager/functions.sqf#L69)
## __mapped(t1,t2)

Type: constant

Description: 
- Param: t1
- Param: t2

Replaced value:
```sqf
cm_accessMap set [t1,t2]; cm_accessMap_inverted set [t2,t1];
```
File: [host\ClientManager\functions.sqf at line 116](../../../Src/host/ClientManager/functions.sqf#L116)
## __colorMap(access,nick,mes)

Type: constant

Description: маппинг цвета ника и сообщений по доступу
- Param: access
- Param: nick
- Param: mes

Replaced value:
```sqf
cm_map_nickColor set [access,nick]; cm_map_messagesColor set [access,mes];
```
File: [host\ClientManager\functions.sqf at line 121](../../../Src/host/ClientManager/functions.sqf#L121)
## cm_owners

Type: Variable

Description: 


Initial value:
```sqf
["76561198094364528"] //me
```
File: [host\ClientManager\functions.sqf at line 37](../../../Src/host/ClientManager/functions.sqf#L37)
## cm_admins

Type: Variable

Description: админы           пони					румын


Initial value:
```sqf
["76561198057042311","76561197994426107"]
```
File: [host\ClientManager\functions.sqf at line 40](../../../Src/host/ClientManager/functions.sqf#L40)
## cm_forsakens

Type: Variable

Description: игроки              квадрат              krakatuk          борзый             ходовой


Initial value:
```sqf
["76561198096453655","76561198072294284","76561198156220735","76561198156220735",...
```
File: [host\ClientManager\functions.sqf at line 43](../../../Src/host/ClientManager/functions.sqf#L43)
## cm_accessMap

Type: Variable

Description: 


Initial value:
```sqf
createHashMap
```
File: [host\ClientManager\functions.sqf at line 117](../../../Src/host/ClientManager/functions.sqf#L117)
## cm_accessMap_inverted

Type: Variable

Description: 


Initial value:
```sqf
createHashMap
```
File: [host\ClientManager\functions.sqf at line 118](../../../Src/host/ClientManager/functions.sqf#L118)
## cm_map_nickColor

Type: Variable

Description: 


Initial value:
```sqf
createHashMap
```
File: [host\ClientManager\functions.sqf at line 122](../../../Src/host/ClientManager/functions.sqf#L122)
## cm_map_messagesColor

Type: Variable

Description: 


Initial value:
```sqf
createHashMap
```
File: [host\ClientManager\functions.sqf at line 123](../../../Src/host/ClientManager/functions.sqf#L123)
## by_func

Type: function

Description: 
- Param: _id
- Param: _checkInDisconnected (optional, default false)

File: [host\ClientManager\functions.sqf at line 69](../../../Src/host/ClientManager/functions.sqf#L69)
## cm_findClientByAccessLevel

Type: function

Description: cm_findClientByAccess
- Param: _id

File: [host\ClientManager\functions.sqf at line 87](../../../Src/host/ClientManager/functions.sqf#L87)
## cm_getAllClientsByAccessLevel

Type: function

Description: Получить клиентов по уровню доступа
- Param: _lvl
- Param: _thisAndHight (optional, default false)

File: [host\ClientManager\functions.sqf at line 95](../../../Src/host/ClientManager/functions.sqf#L95)
## cm_getAccessByUid

Type: function

Description: ! DEPRECATED - не используется


File: [host\ClientManager\functions.sqf at line 109](../../../Src/host/ClientManager/functions.sqf#L109)
## cm_accessTypeToNum

Type: function

Description: Получить уровень по строке
- Param: _accessString

File: [host\ClientManager\functions.sqf at line 135](../../../Src/host/ClientManager/functions.sqf#L135)
## cm_accessNumToType

Type: function

Description: Получить уровень по числу
- Param: _accessNum

File: [host\ClientManager\functions.sqf at line 140](../../../Src/host/ClientManager/functions.sqf#L140)
## cm_getNickColorByAccess

Type: function

Description: 
- Param: _access

File: [host\ClientManager\functions.sqf at line 155](../../../Src/host/ClientManager/functions.sqf#L155)
## cm_getMessageColorByAccess

Type: function

Description: 
- Param: _access

File: [host\ClientManager\functions.sqf at line 156](../../../Src/host/ClientManager/functions.sqf#L156)
## cm_idToName

Type: function

Description: конвертация айди в имя клиента
- Param: _id

File: [host\ClientManager\functions.sqf at line 164](../../../Src/host/ClientManager/functions.sqf#L164)
## cm_idToDisId

Type: function

Description: 
- Param: _id

File: [host\ClientManager\functions.sqf at line 171](../../../Src/host/ClientManager/functions.sqf#L171)
## cm_isClientExist

Type: function

Description: зарегистрирован в памяти или нет


File: [host\ClientManager\functions.sqf at line 179](../../../Src/host/ClientManager/functions.sqf#L179)
## cm_serverCommand

Type: function

Description: 
- Param: _command

File: [host\ClientManager\functions.sqf at line 184](../../../Src/host/ClientManager/functions.sqf#L184)
## cm_serverLock

Type: function

Description: 


File: [host\ClientManager\functions.sqf at line 202](../../../Src/host/ClientManager/functions.sqf#L202)
## cm_serverUnlock

Type: function

Description: 


File: [host\ClientManager\functions.sqf at line 212](../../../Src/host/ClientManager/functions.sqf#L212)
## cm_serverKickById

Type: function

Description: 


File: [host\ClientManager\functions.sqf at line 221](../../../Src/host/ClientManager/functions.sqf#L221)
## pre_oncheat

Type: function

Description: Системная функция при обнаружении подозрительной активности
- Param: _owner
- Param: _ctxCheat

File: [host\ClientManager\functions.sqf at line 245](../../../Src/host/ClientManager/functions.sqf#L245)
## pre_notifClientAssert

Type: function

Description: 
- Param: _message
- Param: _owner

File: [host\ClientManager\functions.sqf at line 283](../../../Src/host/ClientManager/functions.sqf#L283)
## cm_getAllClientsInLobby

Type: function

Description: Получает всех клиентов в лобби


File: [host\ClientManager\functions.sqf at line 302](../../../Src/host/ClientManager/functions.sqf#L302)
## cm_getAllClientsInGame

Type: function

Description: Получает всех клиентов в игре


File: [host\ClientManager\functions.sqf at line 315](../../../Src/host/ClientManager/functions.sqf#L315)
## cm_registerMobInGame

Type: function

Description: регистрирует моба как ingameMob
- Param: _mobObj
- Param: _client
- Param: _vMob

File: [host\ClientManager\functions.sqf at line 328](../../../Src/host/ClientManager/functions.sqf#L328)
## cm_unregisterMobInGame

Type: function

Description: снимаем регистрацию моба с игры
- Param: _mobObj
- Param: _removeObj (optional, default true)

File: [host\ClientManager\functions.sqf at line 338](../../../Src/host/ClientManager/functions.sqf#L338)
## cm_checkClientInJIPMemory

Type: function

Description: Проверяет наличие ранее подключенного клиента
- Param: _disId
- Param: _owner

File: [host\ClientManager\functions.sqf at line 349](../../../Src/host/ClientManager/functions.sqf#L349)
## cm_sendOOSMessage

Type: function

Description: Отправляет всем клиентам сообщение в чат
- Param: _text
- Param: _type (optional, default null)
- Param: _groups (optional, default "")

File: [host\ClientManager\functions.sqf at line 380](../../../Src/host/ClientManager/functions.sqf#L380)
## cm_sendLobbyMessage

Type: function

Description: Отправляет сообщение всем клиентам в лобби
- Param: _text
- Param: _type (optional, default null)
- Param: _groups (optional, default "")

File: [host\ClientManager\functions.sqf at line 395](../../../Src/host/ClientManager/functions.sqf#L395)
# OnConnected.sqf

## cm_maxClients

Type: Variable

Description: 


Initial value:
```sqf
(count allPlayers) max cm_maxClients
```
File: [host\ClientManager\OnConnected.sqf at line 9](../../../Src/host/ClientManager/OnConnected.sqf#L9)
# Access.sqf

## commands_internal_list_charsettings

Type: Variable

Description: 


Initial value:
```sqf
[...
```
File: [host\ClientManager\cmds\Access.sqf at line 431](../../../Src/host/ClientManager/cmds/Access.sqf#L431)
## commands_internal_convertSettingsToRuName

Type: function

Description: 
- Param: _setlist

File: [host\ClientManager\cmds\Access.sqf at line 439](../../../Src/host/ClientManager/cmds/Access.sqf#L439)
# Common.sqf

## system_internal_list_allJoiners

Type: Variable

Description: 


Initial value:
```sqf
[]
```
File: [host\ClientManager\cmds\Common.sqf at line 165](../../../Src/host/ClientManager/cmds/Common.sqf#L165)
## system_internal_string_generatedJoinedString

Type: Variable

Description: 


Initial value:
```sqf
""
```
File: [host\ClientManager\cmds\Common.sqf at line 166](../../../Src/host/ClientManager/cmds/Common.sqf#L166)
## system_internal_generateJoinedRoles

Type: function

Description: 


File: [host\ClientManager\cmds\Common.sqf at line 167](../../../Src/host/ClientManager/cmds/Common.sqf#L167)
# Reflect.sqf

## isvar(x)

Type: constant

Description: 
- Param: x

Replaced value:
```sqf
if (_varName == #x) exitWith
```
File: [host\ClientManager\cmds\Reflect.sqf at line 28](../../../Src/host/ClientManager/cmds/Reflect.sqf#L28)
## printerr(cause)

Type: constant

Description: 
- Param: cause

Replaced value:
```sqf
errorformat("[Command::spawnitem]: " + cause + " - (%1 = %2)",_varName arg _varValue)
```
File: [host\ClientManager\cmds\Reflect.sqf at line 29](../../../Src/host/ClientManager/cmds/Reflect.sqf#L29)
