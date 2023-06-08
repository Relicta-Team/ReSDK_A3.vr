# GamemodeFunctions.sqf

## gamemode_testing_antags

Type: constant

Description: для добавления этого клиента в локалке


Replaced value:
```sqf

```
File: [host\GamemodeManager\GamemodeFunctions.sqf at line 8](../../../Src/host/GamemodeManager/GamemodeFunctions.sqf#L8)
## getRoleByClass(val)

Type: constant

Description: 
- Param: val

Replaced value:
```sqf
(missionNamespace getVariable ["role_"+(val),nullPtr])
```
File: [host\GamemodeManager\GamemodeFunctions.sqf at line 648](../../../Src/host/GamemodeManager/GamemodeFunctions.sqf#L648)
## gm_init

Type: function

Description: инициализирует или сбрасывает все переменные а так же запускает основной поток игры


File: [host\GamemodeManager\GamemodeFunctions.sqf at line 19](../../../Src/host/GamemodeManager/GamemodeFunctions.sqf#L19)
## gm_showVoteMessage

Type: function

Description: 
- Param: _client

File: [host\GamemodeManager\GamemodeFunctions.sqf at line 111](../../../Src/host/GamemodeManager/GamemodeFunctions.sqf#L111)
## gm_getCanVoteCondition

Type: function

Description: 


File: [host\GamemodeManager\GamemodeFunctions.sqf at line 126](../../../Src/host/GamemodeManager/GamemodeFunctions.sqf#L126)
## gm_voteProcess

Type: function

Description: 


File: [host\GamemodeManager\GamemodeFunctions.sqf at line 135](../../../Src/host/GamemodeManager/GamemodeFunctions.sqf#L135)
## gm_restart

Type: function

Description: Выполняет рестарт раунда


File: [host\GamemodeManager\GamemodeFunctions.sqf at line 166](../../../Src/host/GamemodeManager/GamemodeFunctions.sqf#L166)
## gm_getLobbySoundsCount

Type: function

Description: 


File: [host\GamemodeManager\GamemodeFunctions.sqf at line 185](../../../Src/host/GamemodeManager/GamemodeFunctions.sqf#L185)
## gm_setLobbySound

Type: function

Description: 
- Param: _number_name_rnd (optional, default "random")

File: [host\GamemodeManager\GamemodeFunctions.sqf at line 189](../../../Src/host/GamemodeManager/GamemodeFunctions.sqf#L189)
## gm_onChangeState

Type: function

Description: for checking gamemode states visit src\host\CommonComponents\Gamemode.sqf
- Param: _newState

File: [host\GamemodeManager\GamemodeFunctions.sqf at line 219](../../../Src/host/GamemodeManager/GamemodeFunctions.sqf#L219)
## gm_startMainThread

Type: function

Description: 


File: [host\GamemodeManager\GamemodeFunctions.sqf at line 235](../../../Src/host/GamemodeManager/GamemodeFunctions.sqf#L235)
## gm_startLobbyThread

Type: function

Description: 


File: [host\GamemodeManager\GamemodeFunctions.sqf at line 249](../../../Src/host/GamemodeManager/GamemodeFunctions.sqf#L249)
## gm_startEventHandle

Type: function

Description: 


File: [host\GamemodeManager\GamemodeFunctions.sqf at line 263](../../../Src/host/GamemodeManager/GamemodeFunctions.sqf#L263)
## gm_initGameMode

Type: function

Description: Инициализация режима. Выполняет основные сабсистемы раннера: загрузка карты, подгрузка ролей, перевод в стейт лобби
- Param: _name (optional, default "")

File: [host\GamemodeManager\GamemodeFunctions.sqf at line 284](../../../Src/host/GamemodeManager/GamemodeFunctions.sqf#L284)
## gm_loadGamemode

Type: function

Description: Загружает игровой режим. Запускает потоки лобби
- Param: _modeName
- Param: _gmName

File: [host\GamemodeManager\GamemodeFunctions.sqf at line 381](../../../Src/host/GamemodeManager/GamemodeFunctions.sqf#L381)
## gm_pickMode

Type: function

Description: 
- Param: _name (optional, default "")

File: [host\GamemodeManager\GamemodeFunctions.sqf at line 424](../../../Src/host/GamemodeManager/GamemodeFunctions.sqf#L424)
## gm_handleAntagsImpl

Type: function

Description: Новый алгоритм выбора антагониста. Осуществляется после назначения режима


File: [host\GamemodeManager\GamemodeFunctions.sqf at line 505](../../../Src/host/GamemodeManager/GamemodeFunctions.sqf#L505)
## gm_syncRolelistToAllClients

Type: function

Description: синхронизирует со всеми клиентами ролелист


File: [host\GamemodeManager\GamemodeFunctions.sqf at line 593](../../../Src/host/GamemodeManager/GamemodeFunctions.sqf#L593)
## gm_syncRolelistToClient

Type: function

Description: отсылает клиенту все доступные роли для лобби или игры
- Param: _cli

File: [host\GamemodeManager\GamemodeFunctions.sqf at line 601](../../../Src/host/GamemodeManager/GamemodeFunctions.sqf#L601)
## gm_addContenderToRole

Type: function

Description: Добавляет претендента в лист претендентов на выбранную роль (не забыв удалить при этом предыдущий приоритет)
- Param: _client
- Param: _roleClass
- Param: _priority
- Param: _oldRoleName (optional, default "none")
- Param: _doNeedSyncAfterSet (optional, default false)

File: [host\GamemodeManager\GamemodeFunctions.sqf at line 643](../../../Src/host/GamemodeManager/GamemodeFunctions.sqf#L643)
## gm_syncRoleContenders

Type: function

Description: синхронизирует со всеми клиентами информацию о занятых ролях
- Param: _idxContenders

File: [host\GamemodeManager\GamemodeFunctions.sqf at line 704](../../../Src/host/GamemodeManager/GamemodeFunctions.sqf#L704)
## gm_isPreStartRoleExist

Type: function

Description: Проверяет наличие роли в списке дефолтных ролей. Принимает ссылку на объект роли или строковое название
- Param: _roleClass

File: [host\GamemodeManager\GamemodeFunctions.sqf at line 762](../../../Src/host/GamemodeManager/GamemodeFunctions.sqf#L762)
## gm_isRoleExists

Type: function

Description: Осуществляет проверку наличия класса роли. Не учитывается статус роли количество и прочие факторы. Просто проверщик
- Param: _roleClass

File: [host\GamemodeManager\GamemodeFunctions.sqf at line 772](../../../Src/host/GamemodeManager/GamemodeFunctions.sqf#L772)
## gm_getRoleObject

Type: function

Description: 


File: [host\GamemodeManager\GamemodeFunctions.sqf at line 781](../../../Src/host/GamemodeManager/GamemodeFunctions.sqf#L781)
## gm_getGameModeObject

Type: function

Description: Получаем объект игрового режима


File: [host\GamemodeManager\GamemodeFunctions.sqf at line 784](../../../Src/host/GamemodeManager/GamemodeFunctions.sqf#L784)
## gm_prepDesc

Type: function

Description: Подготавливает описание роли, заменяя куски текста на \n
- Param: _sourceText

File: [host\GamemodeManager\GamemodeFunctions.sqf at line 787](../../../Src/host/GamemodeManager/GamemodeFunctions.sqf#L787)
## gm_printRoleNamesEx

Type: function

Description: 
- Param: _name

File: [host\GamemodeManager\GamemodeFunctions.sqf at line 801](../../../Src/host/GamemodeManager/GamemodeFunctions.sqf#L801)
# GamemodeManager.h

## IS_ENABLE_GAMEMODEMANAGER

Type: constant

> <font size="5">Exists if **EMULATE_CLIENT_INSP** defined</font>

Description: 


Replaced value:
```sqf

```
File: [host\GamemodeManager\GamemodeManager.h at line 11](../../../Src/host/GamemodeManager/GamemodeManager.h#L11)
## getRoleObject(val)

Type: constant

Description: 
- Param: val

Replaced value:
```sqf
(missionNamespace getVariable ["role_"+(val),nullPtr])
```
File: [host\GamemodeManager\GamemodeManager.h at line 17](../../../Src/host/GamemodeManager/GamemodeManager.h#L17)
## conDllCall

Type: constant

> <font size="5">Exists if **_SQFVM** defined</font>

Description: 


Replaced value:
```sqf
diag_log
```
File: [host\GamemodeManager\GamemodeManager.h at line 21](../../../Src/host/GamemodeManager/GamemodeManager.h#L21)
## gprint(mes)

Type: constant

Description: 
- Param: mes

Replaced value:
```sqf
conDllCall format["[GMM]:	%1 #0101",mes]
```
File: [host\GamemodeManager\GamemodeManager.h at line 24](../../../Src/host/GamemodeManager/GamemodeManager.h#L24)
## gprintformat(mes,fmt)

Type: constant

Description: 
- Param: mes
- Param: fmt

Replaced value:
```sqf
gprint(format[mes arg fmt]) 
```
File: [host\GamemodeManager\GamemodeManager.h at line 26](../../../Src/host/GamemodeManager/GamemodeManager.h#L26)
## DEFAULT_TIME_TO_START

Type: constant

Description: время в секундах до начала раунда


Replaced value:
```sqf
60
```
File: [host\GamemodeManager\GamemodeManager.h at line 29](../../../Src/host/GamemodeManager/GamemodeManager.h#L29)
## DEFAULT_TIME_TO_START

Type: constant

> <font size="5">Exists if **EDITOR** defined</font>

Description: время в секундах до начала раунда


Replaced value:
```sqf
5
```
File: [host\GamemodeManager\GamemodeManager.h at line 31](../../../Src/host/GamemodeManager/GamemodeManager.h#L31)
## PRE_LOBBY_AWAIT_TIME

Type: constant

Description: прелобби ожидание после которого пикнется режим


Replaced value:
```sqf
60*3
```
File: [host\GamemodeManager\GamemodeManager.h at line 35](../../../Src/host/GamemodeManager/GamemodeManager.h#L35)
## GM_STARTLOGIC_2_0

Type: constant

Description: 


Replaced value:
```sqf

```
File: [host\GamemodeManager\GamemodeManager.h at line 40](../../../Src/host/GamemodeManager/GamemodeManager.h#L40)
## SL20Func(name)

Type: constant

> <font size="5">Exists if **GM_STARTLOGIC_2_0** defined</font>

Description: 
- Param: name

Replaced value:
```sqf
name##_sl20
```
File: [host\GamemodeManager\GamemodeManager.h at line 43](../../../Src/host/GamemodeManager/GamemodeManager.h#L43)
## SL20Func(name)

Type: constant

> <font size="5">Exists if **GM_STARTLOGIC_2_0** not defined</font>

Description: 
- Param: name

Replaced value:
```sqf

```
File: [host\GamemodeManager\GamemodeManager.h at line 45](../../../Src/host/GamemodeManager/GamemodeManager.h#L45)
# GamemodeManager.hpp

## GAME_STATE_PRELOAD

Type: constant

Description: game state dependences in src\host\CommonComponents\Gamemode.sqf


Replaced value:
```sqf
0
```
File: [host\GamemodeManager\GamemodeManager.hpp at line 8](../../../Src/host/GamemodeManager/GamemodeManager.hpp#L8)
## GAME_STATE_LOBBY

Type: constant

Description: 


Replaced value:
```sqf
1
```
File: [host\GamemodeManager\GamemodeManager.hpp at line 9](../../../Src/host/GamemodeManager/GamemodeManager.hpp#L9)
## GAME_STATE_PLAY

Type: constant

Description: 


Replaced value:
```sqf
2
```
File: [host\GamemodeManager\GamemodeManager.hpp at line 10](../../../Src/host/GamemodeManager/GamemodeManager.hpp#L10)
## GAME_STATE_END

Type: constant

Description: 


Replaced value:
```sqf
3
```
File: [host\GamemodeManager\GamemodeManager.hpp at line 11](../../../Src/host/GamemodeManager/GamemodeManager.hpp#L11)
## ROLE_NAME

Type: constant

Description: #define addRole(roleclass,rolename,countSlots) [roleclass,rolename,countSlots,[]]


Replaced value:
```sqf
0
```
File: [host\GamemodeManager\GamemodeManager.hpp at line 15](../../../Src/host/GamemodeManager/GamemodeManager.hpp#L15)
## ROLE_DESC

Type: constant

Description: 


Replaced value:
```sqf
1
```
File: [host\GamemodeManager\GamemodeManager.hpp at line 16](../../../Src/host/GamemodeManager/GamemodeManager.hpp#L16)
## ROLE_COUNT

Type: constant

Description: 


Replaced value:
```sqf
2
```
File: [host\GamemodeManager\GamemodeManager.hpp at line 17](../../../Src/host/GamemodeManager/GamemodeManager.hpp#L17)
## ROLE_CONDITION_ADD_TO_LATE

Type: constant

Description: 


Replaced value:
```sqf
3
```
File: [host\GamemodeManager\GamemodeManager.hpp at line 18](../../../Src/host/GamemodeManager/GamemodeManager.hpp#L18)
## ROLE_CONTENDERS

Type: constant

Description: 


Replaced value:
```sqf
4
```
File: [host\GamemodeManager\GamemodeManager.hpp at line 19](../../../Src/host/GamemodeManager/GamemodeManager.hpp#L19)
## ROLE_INDEX

Type: constant

Description: Используется только в дефолтных ролях


Replaced value:
```sqf
5
```
File: [host\GamemodeManager\GamemodeManager.hpp at line 21](../../../Src/host/GamemodeManager/GamemodeManager.hpp#L21)
## __addRoleToLateGame(roleName)

Type: constant

Description: 
- Param: roleName

Replaced value:
```sqf
[roleName,__internal_isDefaultRole] call gm_addRoleToLateGame
```
File: [host\GamemodeManager\GamemodeManager.hpp at line 23](../../../Src/host/GamemodeManager/GamemodeManager.hpp#L23)
## __addRoleToLateGameWithArgs(args)

Type: constant

Description: 
- Param: args

Replaced value:
```sqf
args call gm_addRoleToLateGame
```
File: [host\GamemodeManager\GamemodeManager.hpp at line 24](../../../Src/host/GamemodeManager/GamemodeManager.hpp#L24)
## __arrayArgs_LateGameCondition

Type: constant

Description: 


Replaced value:
```sqf
[__internal_roleName,__internal_isDefaultRole]
```
File: [host\GamemodeManager\GamemodeManager.hpp at line 25](../../../Src/host/GamemodeManager/GamemodeManager.hpp#L25)
## LATERULE_AFTERSTART

Type: constant

Description: 


Replaced value:
```sqf
{__addRoleToLateGame(__internal_roleName)}
```
File: [host\GamemodeManager\GamemodeManager.hpp at line 27](../../../Src/host/GamemodeManager/GamemodeManager.hpp#L27)
## LATERULE_BYCONDITION(cond)

Type: constant

Description: 
- Param: cond

Replaced value:
```sqf
{if (cond) then {__addRoleToLateGame(__internal_roleName)}}
```
File: [host\GamemodeManager\GamemodeManager.hpp at line 28](../../../Src/host/GamemodeManager/GamemodeManager.hpp#L28)
## LATERULE_DISABLE

Type: constant

Description: 


Replaced value:
```sqf
LATERULE_BYCONDITION(false)
```
File: [host\GamemodeManager\GamemodeManager.hpp at line 29](../../../Src/host/GamemodeManager/GamemodeManager.hpp#L29)
## LATERULE_AFTERCONDITION(cond)

Type: constant

Description: 
- Param: cond

Replaced value:
```sqf
{asyncInvoke({cond},{__addRoleToLateGameWithArgs(_this)},__arrayArgs_LateGameCondition,-1,{})}
```
File: [host\GamemodeManager\GamemodeManager.hpp at line 30](../../../Src/host/GamemodeManager/GamemodeManager.hpp#L30)
## LATERULE_AFTERDELAY(delay)

Type: constant

Description: 
- Param: delay

Replaced value:
```sqf
{invokeAfterDelayParams({__addRoleToLateGameWithArgs(_this)},delay,__arrayArgs_LateGameCondition)}
```
File: [host\GamemodeManager\GamemodeManager.hpp at line 31](../../../Src/host/GamemodeManager/GamemodeManager.hpp#L31)
## setGameModeName(name)

Type: constant

Description: 
- Param: name

Replaced value:
```sqf
gm_gameModeName = name;
```
File: [host\GamemodeManager\GamemodeManager.hpp at line 34](../../../Src/host/GamemodeManager/GamemodeManager.hpp#L34)
## addPreStartRole(type)

Type: constant

Description: Добавить роль прегейма
- Param: type

Replaced value:
```sqf
__refroletype = missionNamespace getVariable [("role_")+ (type),nullPtr]; if isNullReference(__refroletype) then { \
errorformat("Cant load pre start role <%2> in game mode %1: Null reference",gm_gameModeName arg type); \
} else {gm_preStartRoles pushBackUnique __refroletype; \
if callFunc(__refroletype,isMainRole) then {gm_preStartMainRoles pushBackUnique __refroletype}}
```
File: [host\GamemodeManager\GamemodeManager.hpp at line 37](../../../Src/host/GamemodeManager/GamemodeManager.hpp#L37)
## addLateRole(type)

Type: constant

Description: добавить роль прогресса
- Param: type

Replaced value:
```sqf
__refroletype = missionNamespace getVariable [("role_")+ (type),nullPtr]; if isNullReference(__refroletype) then { \
errorformat("Cant load late role <%2> in game mode %1: Null reference",gm_gameModeName arg type); \
} else {gm_roundProgressRoles pushBackUnique __refroletype}
```
File: [host\GamemodeManager\GamemodeManager.hpp at line 43](../../../Src/host/GamemodeManager/GamemodeManager.hpp#L43)
# GamemodeManager.sqf

## gm_internal_forcestart

Type: function

> <font size="5">Exists if **RELEASE** not defined</font>

Description: 


File: [host\GamemodeManager\GamemodeManager.sqf at line 231](../../../Src/host/GamemodeManager/GamemodeManager.sqf#L231)
# Gamemode_deprecated.sqf

## gm_processAntags

Type: function

Description: ЗАКОМЕНТИРОВАН И НЕ ВЫЗЫВАЕТСЯ НА ДАННЫЙ МОМЕНТ


File: [host\GamemodeManager\Gamemode_deprecated.sqf at line 36](../../../Src/host/GamemodeManager/Gamemode_deprecated.sqf#L36)
## gm_processPostAntags

Type: function

Description: ! УСТАРЕВШИЙ МЕТОД - НЕ ВЫЗЫВАЕТСЯ


File: [host\GamemodeManager\Gamemode_deprecated.sqf at line 115](../../../Src/host/GamemodeManager/Gamemode_deprecated.sqf#L115)
# Gamemode_internal_auto.sqf

## gm_getTimeOffset

Type: function

Description: Получение смещения времени
- Param: _utcOffset (optional, default 0, expected types: ['0', []])
- Param: _utcTime (optional, default systemTime, expected types: [[]])

File: [host\GamemodeManager\Gamemode_internal_auto.sqf at line 7](../../../Src/host/GamemodeManager/Gamemode_internal_auto.sqf#L7)
# Gamemode_RoundManager.sqf

## gm_processSpawnRole_disabledFullAntags

Type: constant

Description: ! ПЕРЕД УБИРАНИЕМ ЭТОГО ФЛАГА ВНИМАТЕЛЬНО СМОТРЕТЬ УСЛОВИЯ. Нужна проверка возможности взятия роли


Replaced value:
```sqf

```
File: [host\GamemodeManager\Gamemode_RoundManager.sqf at line 470](../../../Src/host/GamemodeManager/Gamemode_RoundManager.sqf#L470)
## additionalData

Type: constant

Description: Эти данные управляют типом структуры. Сюда можно впихнуть выпавшее значение


Replaced value:
```sqf
[_x,_prior]
```
File: [host\GamemodeManager\Gamemode_RoundManager.sqf at line 574](../../../Src/host/GamemodeManager/Gamemode_RoundManager.sqf#L574)
## hashPair(key,val)

Type: constant

Description: 
- Param: key
- Param: val

Replaced value:
```sqf
[#key,val]
```
File: [host\GamemodeManager\Gamemode_RoundManager.sqf at line 620](../../../Src/host/GamemodeManager/Gamemode_RoundManager.sqf#L620)
## getClientSetting(var)

Type: constant

Description: 
- Param: var

Replaced value:
```sqf
(_cliSettings get #var)
```
File: [host\GamemodeManager\Gamemode_RoundManager.sqf at line 678](../../../Src/host/GamemodeManager/Gamemode_RoundManager.sqf#L678)
## gm_startRound

Type: function

Description: событие, запускаемое при старте раунда


File: [host\GamemodeManager\Gamemode_RoundManager.sqf at line 76](../../../Src/host/GamemodeManager/Gamemode_RoundManager.sqf#L76)
## gm_processSpawnRole

Type: function

Description: 
- Param: _client
- Param: _priority

File: [host\GamemodeManager\Gamemode_RoundManager.sqf at line 463](../../../Src/host/GamemodeManager/Gamemode_RoundManager.sqf#L463)
## gm_prepareReadyClients

Type: function

Description: Готовит структуру с приоритетами на роли


File: [host\GamemodeManager\Gamemode_RoundManager.sqf at line 554](../../../Src/host/GamemodeManager/Gamemode_RoundManager.sqf#L554)
## gm_initHashMapCharSettings

Type: function

Description: Установка настроек персонажа для рега в роль
- Param: _name
- Param: _val

File: [host\GamemodeManager\Gamemode_RoundManager.sqf at line 619](../../../Src/host/GamemodeManager/Gamemode_RoundManager.sqf#L619)
## gm_spawnClientToRole

Type: function

Description: Создать клиента в игре
- Param: _client (optional, default nullPtr)
- Param: _roleName (optional, default "")
- Param: _decrementRoleCount (optional, default true)
- Param: _mobsetup_map

File: [host\GamemodeManager\Gamemode_RoundManager.sqf at line 647](../../../Src/host/GamemodeManager/Gamemode_RoundManager.sqf#L647)
## gm_internal_assignToImpl

Type: function

Description: 
- Param: this
- Param: _mob
- Param: _usr

File: [host\GamemodeManager\Gamemode_RoundManager.sqf at line 800](../../../Src/host/GamemodeManager/Gamemode_RoundManager.sqf#L800)
## gm_sendLateRolesToClient

Type: function

Description: Отсылает клиенту запрос на открытие окна выбора доступных лейт ролей и список
- Param: _owner

File: [host\GamemodeManager\Gamemode_RoundManager.sqf at line 866](../../../Src/host/GamemodeManager/Gamemode_RoundManager.sqf#L866)
## gm_spawnSelectedLateRole

Type: function

Description: спавнит лейтового персонажа на свою роль
- Param: _roleClass
- Param: _owner

File: [host\GamemodeManager\Gamemode_RoundManager.sqf at line 935](../../../Src/host/GamemodeManager/Gamemode_RoundManager.sqf#L935)
## gm_addClientToEmbark

Type: function

Description: 
- Param: _client
- Param: _roleData
- Param: _owner

File: [host\GamemodeManager\Gamemode_RoundManager.sqf at line 977](../../../Src/host/GamemodeManager/Gamemode_RoundManager.sqf#L977)
## gm_removeClientFromEmbark

Type: function

Description: 
- Param: _client
- Param: _syncRPC (optional, default true)

File: [host\GamemodeManager\Gamemode_RoundManager.sqf at line 989](../../../Src/host/GamemodeManager/Gamemode_RoundManager.sqf#L989)
## gm_doEmbark

Type: function

Description: 


File: [host\GamemodeManager\Gamemode_RoundManager.sqf at line 1011](../../../Src/host/GamemodeManager/Gamemode_RoundManager.sqf#L1011)
## gm_validateRolesOnPickGameMode

Type: function

Description: Если таких ролей не указано или клиент не имеет возможности взять роль - сбрасываем её
- Param: this

File: [host\GamemodeManager\Gamemode_RoundManager.sqf at line 1049](../../../Src/host/GamemodeManager/Gamemode_RoundManager.sqf#L1049)
## gm_endRound

Type: function

Description: 
- Param: _endgameState

File: [host\GamemodeManager\Gamemode_RoundManager.sqf at line 1083](../../../Src/host/GamemodeManager/Gamemode_RoundManager.sqf#L1083)
## gm_isAspectAllowedToMode

Type: function

Description: может ли аспект быть установленным в этом режиме
- Param: _aspect
- Param: _curMode

File: [host\GamemodeManager\Gamemode_RoundManager.sqf at line 1152](../../../Src/host/GamemodeManager/Gamemode_RoundManager.sqf#L1152)
## gm_internal_getPossibleAspects

Type: function

Description: 
- Param: _curMode

File: [host\GamemodeManager\Gamemode_RoundManager.sqf at line 1176](../../../Src/host/GamemodeManager/Gamemode_RoundManager.sqf#L1176)
## gm_isAspectSetup

Type: function

Description: 
- Param: _checked

File: [host\GamemodeManager\Gamemode_RoundManager.sqf at line 1188](../../../Src/host/GamemodeManager/Gamemode_RoundManager.sqf#L1188)
## gm_pickRoundAspect

Type: function

Description: 


File: [host\GamemodeManager\Gamemode_RoundManager.sqf at line 1198](../../../Src/host/GamemodeManager/Gamemode_RoundManager.sqf#L1198)
## gm_pickMultiAspects

Type: function

Description: 
- Param: _aspObj

File: [host\GamemodeManager\Gamemode_RoundManager.sqf at line 1246](../../../Src/host/GamemodeManager/Gamemode_RoundManager.sqf#L1246)
## gameEvents_getPossibleEvents

Type: function

Description: получение всех доступных событий


File: [host\GamemodeManager\Gamemode_RoundManager.sqf at line 1292](../../../Src/host/GamemodeManager/Gamemode_RoundManager.sqf#L1292)
## gameEvents_pickEvent

Type: function

Description: запуск события
- Param: _evs
- Param: _wts

File: [host\GamemodeManager\Gamemode_RoundManager.sqf at line 1329](../../../Src/host/GamemodeManager/Gamemode_RoundManager.sqf#L1329)
## gameEvents_internal_isEventAllowedToSession

Type: function

Description: 
- Param: _aspect
- Param: _curMode

File: [host\GamemodeManager\Gamemode_RoundManager.sqf at line 1342](../../../Src/host/GamemodeManager/Gamemode_RoundManager.sqf#L1342)
## gameEvents_process

Type: function

Description: 


File: [host\GamemodeManager\Gamemode_RoundManager.sqf at line 1363](../../../Src/host/GamemodeManager/Gamemode_RoundManager.sqf#L1363)
## gm_createMob

Type: function

Description: создаёт игровую оболочку
- Param: _pos

File: [host\GamemodeManager\Gamemode_RoundManager.sqf at line 1391](../../../Src/host/GamemodeManager/Gamemode_RoundManager.sqf#L1391)
