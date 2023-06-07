# Client.hpp

## ACCESS_PLAYER

Type: constant
Description: ======================================================


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
# ClientController.hpp

## CONNECTION_ACTION_PREPARECLIENT

Type: constant
Description: ======================================================


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
Description: ======================================================
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
Description: 5 секунд на инициализацию


Replaced value:
```sqf
120
```
File: [host\ClientManager\ClientManager.h at line 13](../../../Src/host/ClientManager/ClientManager.h#L13)
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
File: [host\ClientManager\functions.sqf at line 59](../../../Src/host/ClientManager/functions.sqf#L59)
## __compare_equality_soft

Type: constant
Description: 


Replaced value:
```sqf
==
```
File: [host\ClientManager\functions.sqf at line 60](../../../Src/host/ClientManager/functions.sqf#L60)
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
	private _rez = cm_allClients findif {getVar(_x,var) isequalto _id}; \
	if (_rez == -1) exitWith { \
		if (!_checkInDisconnected) exitWith {nullPtr}; \
		private _listDisc = values cm_disconnectedClients; \
		_rez = _listDisc findif {getVar(_x,var) comparer _id}; \
		if (_rez == -1) exitWith {nullPtr}; \
		_listDisc select _rez; \
	}; \
	cm_allClients select _rez}
```
File: [host\ClientManager\functions.sqf at line 61](../../../Src/host/ClientManager/functions.sqf#L61)
## __mapped(t1,t2)

Type: constant
Description: 
- Param: t1
- Param: t2

Replaced value:
```sqf
cm_accessMap set [t1,t2]; cm_accessMap_inverted set [t2,t1];
```
File: [host\ClientManager\functions.sqf at line 108](../../../Src/host/ClientManager/functions.sqf#L108)
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
File: [host\ClientManager\functions.sqf at line 113](../../../Src/host/ClientManager/functions.sqf#L113)
## by_func

Type: function
Description: 
- Param: _id
- Param: _checkInDisconnected (optional, default false)

File: [host\ClientManager\functions.sqf at line 61](../../../Src/host/ClientManager/functions.sqf#L61)
## cm_findClientByAccessLevel

Type: function
Description: cm_findClientByAccess
- Param: _id

File: [host\ClientManager\functions.sqf at line 79](../../../Src/host/ClientManager/functions.sqf#L79)
## cm_getAllClientsByAccessLevel

Type: function
Description: Получить клиентов по уровню доступа
- Param: _lvl
- Param: _thisAndHight (optional, default false)

File: [host\ClientManager\functions.sqf at line 87](../../../Src/host/ClientManager/functions.sqf#L87)
## cm_getAccessByUid

Type: function
Description: ! DEPRECATED - не используется


File: [host\ClientManager\functions.sqf at line 101](../../../Src/host/ClientManager/functions.sqf#L101)
## cm_accessTypeToNum

Type: function
Description: Получить уровень по строке
- Param: _accessString

File: [host\ClientManager\functions.sqf at line 127](../../../Src/host/ClientManager/functions.sqf#L127)
## cm_accessNumToType

Type: function
Description: Получить уровень по числу
- Param: _accessNum

File: [host\ClientManager\functions.sqf at line 132](../../../Src/host/ClientManager/functions.sqf#L132)
## cm_getNickColorByAccess

Type: function
Description: 
- Param: _access

File: [host\ClientManager\functions.sqf at line 147](../../../Src/host/ClientManager/functions.sqf#L147)
## cm_getMessageColorByAccess

Type: function
Description: 
- Param: _access

File: [host\ClientManager\functions.sqf at line 148](../../../Src/host/ClientManager/functions.sqf#L148)
## cm_idToName

Type: function
Description: конвертация айди в имя клиента
- Param: _id

File: [host\ClientManager\functions.sqf at line 156](../../../Src/host/ClientManager/functions.sqf#L156)
## cm_idToUid

Type: function
Description: 
- Param: _id

File: [host\ClientManager\functions.sqf at line 163](../../../Src/host/ClientManager/functions.sqf#L163)
## cm_isRegisteredClient

Type: function
Description: зарегистрирован в памяти или нет


File: [host\ClientManager\functions.sqf at line 171](../../../Src/host/ClientManager/functions.sqf#L171)
## cm_serverCommand

Type: function
Description: 
- Param: _command

File: [host\ClientManager\functions.sqf at line 176](../../../Src/host/ClientManager/functions.sqf#L176)
## cm_serverLock

Type: function
Description: 


File: [host\ClientManager\functions.sqf at line 194](../../../Src/host/ClientManager/functions.sqf#L194)
## cm_serverUnlock

Type: function
Description: 


File: [host\ClientManager\functions.sqf at line 204](../../../Src/host/ClientManager/functions.sqf#L204)
## cm_serverKickById

Type: function
Description: 


File: [host\ClientManager\functions.sqf at line 213](../../../Src/host/ClientManager/functions.sqf#L213)
## pre_oncheat

Type: function
Description: Системная функция при обнаружении подозрительной активности
- Param: _owner
- Param: _ctxCheat
- Param: _uid

File: [host\ClientManager\functions.sqf at line 237](../../../Src/host/ClientManager/functions.sqf#L237)
## cm_getAllClientsInLobby

Type: function
Description: Получает всех клиентов в лобби


File: [host\ClientManager\functions.sqf at line 283](../../../Src/host/ClientManager/functions.sqf#L283)
## cm_getAllClientsInGame

Type: function
Description: Получает всех клиентов в игре


File: [host\ClientManager\functions.sqf at line 296](../../../Src/host/ClientManager/functions.sqf#L296)
## cm_registerMobInGame

Type: function
Description: регистрирует моба как ingameMob
- Param: _mobObj
- Param: _client
- Param: _vMob

File: [host\ClientManager\functions.sqf at line 309](../../../Src/host/ClientManager/functions.sqf#L309)
## cm_unregisterMobInGame

Type: function
Description: снимаем регистрацию моба с игры
- Param: _mobObj
- Param: _removeObj (optional, default true)

File: [host\ClientManager\functions.sqf at line 319](../../../Src/host/ClientManager/functions.sqf#L319)
## cm_checkClientInJIPMemory

Type: function
Description: Проверяет наличие ранее подключенного клиента
- Param: _uid
- Param: _owner

File: [host\ClientManager\functions.sqf at line 330](../../../Src/host/ClientManager/functions.sqf#L330)
## cm_sendOOSMessage

Type: function
Description: Отправляет всем клиентам сообщение в чат
- Param: _text
- Param: _type (optional, default null)
- Param: _groups (optional, default "")

File: [host\ClientManager\functions.sqf at line 359](../../../Src/host/ClientManager/functions.sqf#L359)
## cm_sendLobbyMessage

Type: function
Description: Отправляет сообщение всем клиентам в лобби
- Param: _text
- Param: _type (optional, default null)
- Param: _groups (optional, default "")

File: [host\ClientManager\functions.sqf at line 370](../../../Src/host/ClientManager/functions.sqf#L370)
# Common.sqf

## system_internal_generateJoinedRoles

Type: function
Description: 


File: [host\ClientManager\cmds\Common.sqf at line 164](../../../Src/host/ClientManager/cmds/Common.sqf#L164)
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
# ServerControl.sqf

## gm_startFromLobbyCondition

Type: function
Description: 


File: [host\ClientManager\cmds\ServerControl.sqf at line 224](../../../Src/host/ClientManager/cmds/ServerControl.sqf#L224)
