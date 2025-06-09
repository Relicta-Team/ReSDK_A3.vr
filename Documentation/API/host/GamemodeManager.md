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
File: [host\GamemodeManager\GamemodeFunctions.sqf at line 561](../../../Src/host/GamemodeManager/GamemodeFunctions.sqf#L561)
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

File: [host\GamemodeManager\GamemodeFunctions.sqf at line 382](../../../Src/host/GamemodeManager/GamemodeFunctions.sqf#L382)
## gm_pickMode

Type: function

Description: 
- Param: _name (optional, default "")

File: [host\GamemodeManager\GamemodeFunctions.sqf at line 425](../../../Src/host/GamemodeManager/GamemodeFunctions.sqf#L425)
## gm_syncRolelistToAllClients

Type: function

Description: синхронизирует со всеми клиентами ролелист


File: [host\GamemodeManager\GamemodeFunctions.sqf at line 506](../../../Src/host/GamemodeManager/GamemodeFunctions.sqf#L506)
## gm_syncRolelistToClient

Type: function

Description: отсылает клиенту все доступные роли для лобби или игры
- Param: _cli

File: [host\GamemodeManager\GamemodeFunctions.sqf at line 514](../../../Src/host/GamemodeManager/GamemodeFunctions.sqf#L514)
## gm_addContenderToRole

Type: function

Description: Добавляет претендента в лист претендентов на выбранную роль (не забыв удалить при этом предыдущий приоритет)
- Param: _client
- Param: _roleClass
- Param: _priority
- Param: _oldRoleName (optional, default "none")
- Param: _doNeedSyncAfterSet (optional, default false)

File: [host\GamemodeManager\GamemodeFunctions.sqf at line 556](../../../Src/host/GamemodeManager/GamemodeFunctions.sqf#L556)
## gm_syncRoleContenders

Type: function

Description: синхронизирует со всеми клиентами информацию о занятых ролях
- Param: _idxContenders

File: [host\GamemodeManager\GamemodeFunctions.sqf at line 617](../../../Src/host/GamemodeManager/GamemodeFunctions.sqf#L617)
## gm_isPreStartRoleExist

Type: function

Description: Проверяет наличие роли в списке дефолтных ролей. Принимает ссылку на объект роли или строковое название
- Param: _roleClass

File: [host\GamemodeManager\GamemodeFunctions.sqf at line 675](../../../Src/host/GamemodeManager/GamemodeFunctions.sqf#L675)
## gm_isRoleExists

Type: function

Description: ! not used anywhere...
- Param: _roleClass

File: [host\GamemodeManager\GamemodeFunctions.sqf at line 686](../../../Src/host/GamemodeManager/GamemodeFunctions.sqf#L686)
## gm_getRoleObject

Type: function

Description: 


File: [host\GamemodeManager\GamemodeFunctions.sqf at line 695](../../../Src/host/GamemodeManager/GamemodeFunctions.sqf#L695)
## gm_getGameModeObject

Type: function

Description: Получаем объект игрового режима


File: [host\GamemodeManager\GamemodeFunctions.sqf at line 698](../../../Src/host/GamemodeManager/GamemodeFunctions.sqf#L698)
## gm_prepDesc

Type: function

Description: Подготавливает описание роли, заменяя куски текста на \n
- Param: _sourceText

File: [host\GamemodeManager\GamemodeFunctions.sqf at line 701](../../../Src/host/GamemodeManager/GamemodeFunctions.sqf#L701)
## gm_printRoleNamesEx

Type: function

Description: 
- Param: _name

File: [host\GamemodeManager\GamemodeFunctions.sqf at line 715](../../../Src/host/GamemodeManager/GamemodeFunctions.sqf#L715)
# GamemodeManager.h

## IS_ENABLE_GAMEMODEMANAGER

Type: constant

> Exists if **EMULATE_CLIENT_INSP** defined

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
## gprint(mes)

Type: constant

Description: Печатники сообщений
- Param: mes

Replaced value:
```sqf
conDllCall format["[GMM]:	%1 #0101",mes]
```
File: [host\GamemodeManager\GamemodeManager.h at line 20](../../../Src/host/GamemodeManager/GamemodeManager.h#L20)
## gprintformat(mes,fmt)

Type: constant

Description: 
- Param: mes
- Param: fmt

Replaced value:
```sqf
gprint(format[mes arg fmt]) 
```
File: [host\GamemodeManager\GamemodeManager.h at line 22](../../../Src/host/GamemodeManager/GamemodeManager.h#L22)
## DEFAULT_TIME_TO_START

Type: constant

Description: время в секундах до начала раунда


Replaced value:
```sqf
60
```
File: [host\GamemodeManager\GamemodeManager.h at line 25](../../../Src/host/GamemodeManager/GamemodeManager.h#L25)
## DEFAULT_TIME_TO_START

Type: constant

> Exists if **EDITOR** defined

Description: время в секундах до начала раунда


Replaced value:
```sqf
5
```
File: [host\GamemodeManager\GamemodeManager.h at line 27](../../../Src/host/GamemodeManager/GamemodeManager.h#L27)
## PRE_LOBBY_AWAIT_TIME

Type: constant

Description: прелобби ожидание после которого пикнется режим


Replaced value:
```sqf
60*3
```
File: [host\GamemodeManager\GamemodeManager.h at line 31](../../../Src/host/GamemodeManager/GamemodeManager.h#L31)
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
## GAME_STATE_LIST_NODE_BINDING

Type: constant

Description: 


Replaced value:
```sqf
['Выбор режима:GAME_STATE_PRELOAD:В этот момент режим ещё не выбран.', \
    'Подготовка:GAME_STATE_LOBBY:На этом моменте раунд ещё не запущен, но режим уже выбран.', \
    'Игра:GAME_STATE_PLAY:На этом моменте режим выбран и раунд запущен. Идёт процесс игры.', \
    'Конец раунда:GAME_STATE_END:На этом моменте процесс игры завершен. Условия режима привели к его завершению.']
```
File: [host\GamemodeManager\GamemodeManager.hpp at line 13](../../../Src/host/GamemodeManager/GamemodeManager.hpp#L13)
## ROLE_NAME

Type: constant

Description: #define addRole(roleclass,rolename,countSlots) [roleclass,rolename,countSlots,[]]


Replaced value:
```sqf
0
```
File: [host\GamemodeManager\GamemodeManager.hpp at line 20](../../../Src/host/GamemodeManager/GamemodeManager.hpp#L20)
## ROLE_DESC

Type: constant

Description: 


Replaced value:
```sqf
1
```
File: [host\GamemodeManager\GamemodeManager.hpp at line 21](../../../Src/host/GamemodeManager/GamemodeManager.hpp#L21)
## ROLE_COUNT

Type: constant

Description: 


Replaced value:
```sqf
2
```
File: [host\GamemodeManager\GamemodeManager.hpp at line 22](../../../Src/host/GamemodeManager/GamemodeManager.hpp#L22)
## ROLE_CONDITION_ADD_TO_LATE

Type: constant

Description: 


Replaced value:
```sqf
3
```
File: [host\GamemodeManager\GamemodeManager.hpp at line 23](../../../Src/host/GamemodeManager/GamemodeManager.hpp#L23)
## ROLE_CONTENDERS

Type: constant

Description: 


Replaced value:
```sqf
4
```
File: [host\GamemodeManager\GamemodeManager.hpp at line 24](../../../Src/host/GamemodeManager/GamemodeManager.hpp#L24)
## ROLE_INDEX

Type: constant

Description: Используется только в дефолтных ролях


Replaced value:
```sqf
5
```
File: [host\GamemodeManager\GamemodeManager.hpp at line 26](../../../Src/host/GamemodeManager/GamemodeManager.hpp#L26)
## __addRoleToLateGame(roleName)

Type: constant

Description: 
- Param: roleName

Replaced value:
```sqf
[roleName,__internal_isDefaultRole] call gm_addRoleToLateGame
```
File: [host\GamemodeManager\GamemodeManager.hpp at line 28](../../../Src/host/GamemodeManager/GamemodeManager.hpp#L28)
## __addRoleToLateGameWithArgs(args)

Type: constant

Description: 
- Param: args

Replaced value:
```sqf
args call gm_addRoleToLateGame
```
File: [host\GamemodeManager\GamemodeManager.hpp at line 29](../../../Src/host/GamemodeManager/GamemodeManager.hpp#L29)
## __arrayArgs_LateGameCondition

Type: constant

Description: 


Replaced value:
```sqf
[__internal_roleName,__internal_isDefaultRole]
```
File: [host\GamemodeManager\GamemodeManager.hpp at line 30](../../../Src/host/GamemodeManager/GamemodeManager.hpp#L30)
## LATERULE_AFTERSTART

Type: constant

Description: 


Replaced value:
```sqf
{__addRoleToLateGame(__internal_roleName)}
```
File: [host\GamemodeManager\GamemodeManager.hpp at line 32](../../../Src/host/GamemodeManager/GamemodeManager.hpp#L32)
## LATERULE_BYCONDITION(cond)

Type: constant

Description: 
- Param: cond

Replaced value:
```sqf
{if (cond) then {__addRoleToLateGame(__internal_roleName)}}
```
File: [host\GamemodeManager\GamemodeManager.hpp at line 33](../../../Src/host/GamemodeManager/GamemodeManager.hpp#L33)
## LATERULE_DISABLE

Type: constant

Description: 


Replaced value:
```sqf
LATERULE_BYCONDITION(false)
```
File: [host\GamemodeManager\GamemodeManager.hpp at line 34](../../../Src/host/GamemodeManager/GamemodeManager.hpp#L34)
## LATERULE_AFTERCONDITION(cond)

Type: constant

Description: 
- Param: cond

Replaced value:
```sqf
{asyncInvoke({cond},{__addRoleToLateGameWithArgs(_this)},__arrayArgs_LateGameCondition,-1,{})}
```
File: [host\GamemodeManager\GamemodeManager.hpp at line 35](../../../Src/host/GamemodeManager/GamemodeManager.hpp#L35)
## LATERULE_AFTERDELAY(delay)

Type: constant

Description: 
- Param: delay

Replaced value:
```sqf
{invokeAfterDelayParams({__addRoleToLateGameWithArgs(_this)},delay,__arrayArgs_LateGameCondition)}
```
File: [host\GamemodeManager\GamemodeManager.hpp at line 36](../../../Src/host/GamemodeManager/GamemodeManager.hpp#L36)
## setGameModeName(name)

Type: constant

Description: 
- Param: name

Replaced value:
```sqf
gm_gameModeName = name;
```
File: [host\GamemodeManager\GamemodeManager.hpp at line 39](../../../Src/host/GamemodeManager/GamemodeManager.hpp#L39)
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
File: [host\GamemodeManager\GamemodeManager.hpp at line 42](../../../Src/host/GamemodeManager/GamemodeManager.hpp#L42)
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
File: [host\GamemodeManager\GamemodeManager.hpp at line 48](../../../Src/host/GamemodeManager/GamemodeManager.hpp#L48)
## ANTAG_NONE

Type: constant

Description: antag - 0 none; 1 hide, 2 unical, 3 all


Replaced value:
```sqf
0
```
File: [host\GamemodeManager\GamemodeManager.hpp at line 55](../../../Src/host/GamemodeManager/GamemodeManager.hpp#L55)
## ANTAG_HIDDEN

Type: constant

Description: 


Replaced value:
```sqf
1
```
File: [host\GamemodeManager\GamemodeManager.hpp at line 56](../../../Src/host/GamemodeManager/GamemodeManager.hpp#L56)
## ANTAG_UNICAL

Type: constant

Description: 


Replaced value:
```sqf
2
```
File: [host\GamemodeManager\GamemodeManager.hpp at line 57](../../../Src/host/GamemodeManager/GamemodeManager.hpp#L57)
## ANTAG_ALL

Type: constant

Description: 


Replaced value:
```sqf
3
```
File: [host\GamemodeManager\GamemodeManager.hpp at line 58](../../../Src/host/GamemodeManager/GamemodeManager.hpp#L58)
## ANTAG_LIST_ALL_

Type: constant

Description: 


Replaced value:
```sqf
[ANTAG_NONE,ANTAG_HIDDEN,ANTAG_UNICAL,ANTAG_ALL]
```
File: [host\GamemodeManager\GamemodeManager.hpp at line 60](../../../Src/host/GamemodeManager/GamemodeManager.hpp#L60)
## ANTAG_STR_LIST_ALL_

Type: constant

Description: 


Replaced value:
```sqf
["ANTAG_NONE","ANTAG_HIDDEN","ANTAG_UNICAL","ANTAG_ALL"]
```
File: [host\GamemodeManager\GamemodeManager.hpp at line 61](../../../Src/host/GamemodeManager/GamemodeManager.hpp#L61)
## ANTAG_PARSESTRING(v)

Type: constant

Description: 
- Param: v

Replaced value:
```sqf
(ANTAG_LIST_ALL_ select (ANTAG_STR_LIST_ALL_ find (v)))
```
File: [host\GamemodeManager\GamemodeManager.hpp at line 63](../../../Src/host/GamemodeManager/GamemodeManager.hpp#L63)
# GamemodeManager.sqf

## gm_currentMode

Type: Variable

Description: Выполняет первичную инициализацию гейммода


Initial value:
```sqf
nullPtr //текущий установленный игровой режим
```
File: [host\GamemodeManager\GamemodeManager.sqf at line 32](../../../Src/host/GamemodeManager/GamemodeManager.sqf#L32)
## gm_defaultMode

Type: Variable

Description: 


Initial value:
```sqf
"GMTVTGame"// режим по-умолчанию
```
File: [host\GamemodeManager\GamemodeManager.sqf at line 34](../../../Src/host/GamemodeManager/GamemodeManager.sqf#L34)
## gm_currentModeId

Type: Variable

Description: режим по-умолчанию


Initial value:
```sqf
-1 //айди установленного режима
```
File: [host\GamemodeManager\GamemodeManager.sqf at line 35](../../../Src/host/GamemodeManager/GamemodeManager.sqf#L35)
## gm_internal_ingameClients

Type: Variable

Description: айди установленного режима


Initial value:
```sqf
[] //сюда записываются все клиенты, зашедшие в игру хотя-бы один раз
```
File: [host\GamemodeManager\GamemodeManager.sqf at line 36](../../../Src/host/GamemodeManager/GamemodeManager.sqf#L36)
## gm_handleMainLoop

Type: Variable

Description: сюда записываются все клиенты, зашедшие в игру хотя-бы один раз


Initial value:
```sqf
-1 //основной хандлер игры
```
File: [host\GamemodeManager\GamemodeManager.sqf at line 38](../../../Src/host/GamemodeManager/GamemodeManager.sqf#L38)
## gm_handleLobbyLoop

Type: Variable

Description: основной хандлер игры


Initial value:
```sqf
-1 //хандлер лобби
```
File: [host\GamemodeManager\GamemodeManager.sqf at line 39](../../../Src/host/GamemodeManager/GamemodeManager.sqf#L39)
## gm_handleEvents

Type: Variable

Description: хандлер лобби


Initial value:
```sqf
-1 //хандлер событий
```
File: [host\GamemodeManager\GamemodeManager.sqf at line 40](../../../Src/host/GamemodeManager/GamemodeManager.sqf#L40)
## gm_nextEventPlay

Type: Variable

Description: хандлер событий


Initial value:
```sqf
0 //отметка когда следующее событие будет запущено
```
File: [host\GamemodeManager\GamemodeManager.sqf at line 41](../../../Src/host/GamemodeManager/GamemodeManager.sqf#L41)
## gm_isCustomRoundEnd

Type: Variable

Description: кастомный конец раунда


Initial value:
```sqf
false
```
File: [host\GamemodeManager\GamemodeManager.sqf at line 44](../../../Src/host/GamemodeManager/GamemodeManager.sqf#L44)
## gm_idCustomResult

Type: Variable

Description: 


Initial value:
```sqf
INFINITY
```
File: [host\GamemodeManager\GamemodeManager.sqf at line 45](../../../Src/host/GamemodeManager/GamemodeManager.sqf#L45)
## gm_customTextResult

Type: Variable

Description: 


Initial value:
```sqf
"Конец смены" //кастомный текст конца раунда
```
File: [host\GamemodeManager\GamemodeManager.sqf at line 46](../../../Src/host/GamemodeManager/GamemodeManager.sqf#L46)
## gm_modesFolder

Type: Variable

Description: путь до папки со всеми модами


Initial value:
```sqf
"src\host\GamemodeManager\GameModes\"
```
File: [host\GamemodeManager\GamemodeManager.sqf at line 49](../../../Src/host/GamemodeManager/GamemodeManager.sqf#L49)
## gm_modesList

Type: Variable

Description: файл со списокм модов


Initial value:
```sqf
["TestMode"]
```
File: [host\GamemodeManager\GamemodeManager.sqf at line 51](../../../Src/host/GamemodeManager/GamemodeManager.sqf#L51)
## gm_defaultRoles

Type: Variable

Description: DEPRECATED


Initial value:
```sqf
createHashMap //хэшкарта дефолтных ролей
```
File: [host\GamemodeManager\GamemodeManager.sqf at line 54](../../../Src/host/GamemodeManager/GamemodeManager.sqf#L54)
## gm_isCachedDefaultRoles

Type: Variable

Description: хэшкарта дефолтных ролей


Initial value:
```sqf
false //закеширован ли резульат дефлотных ролей для клиента
```
File: [host\GamemodeManager\GamemodeManager.sqf at line 55](../../../Src/host/GamemodeManager/GamemodeManager.sqf#L55)
## gm_chachedDefaultRoles

Type: Variable

Description: закеширован ли резульат дефлотных ролей для клиента


Initial value:
```sqf
[]
```
File: [host\GamemodeManager\GamemodeManager.sqf at line 56](../../../Src/host/GamemodeManager/GamemodeManager.sqf#L56)
## gm_roles

Type: Variable

Description: роли, регистрируемые для лейтгейма.


Initial value:
```sqf
createHashMap
```
File: [host\GamemodeManager\GamemodeManager.sqf at line 59](../../../Src/host/GamemodeManager/GamemodeManager.sqf#L59)
## gm_inGameRoles

Type: Variable

Description: 


Initial value:
```sqf
createHashMap //роли, доступные после начала раунда
```
File: [host\GamemodeManager\GamemodeManager.sqf at line 62](../../../Src/host/GamemodeManager/GamemodeManager.sqf#L62)
## gm_roleContenders

Type: Variable

Description: 


Initial value:
```sqf
[[],[],[]]// - список клиентов которые претендуют на роли. readonly только для вывода информации.
```
File: [host\GamemodeManager\GamemodeManager.sqf at line 69](../../../Src/host/GamemodeManager/GamemodeManager.sqf#L69)
## gm_preStartRoles

Type: Variable

Description: new roles functionality


Initial value:
```sqf
[] //роли доступные на престарте (объекты)
```
File: [host\GamemodeManager\GamemodeManager.sqf at line 72](../../../Src/host/GamemodeManager/GamemodeManager.sqf#L72)
## gm_preStartMainRoles

Type: Variable

Description: роли доступные на престарте (объекты)


Initial value:
```sqf
[] //приоритетные роли на престарте (ключевые) (объекты)
```
File: [host\GamemodeManager\GamemodeManager.sqf at line 73](../../../Src/host/GamemodeManager/GamemodeManager.sqf#L73)
## gm_roundProgressRoles

Type: Variable

Description: приоритетные роли на престарте (ключевые) (объекты)


Initial value:
```sqf
[] //роли доступные после старта. Оставшиеся после престарта с количеством > 0 и возможность добавления перемещаются в этот лист
```
File: [host\GamemodeManager\GamemodeManager.sqf at line 74](../../../Src/host/GamemodeManager/GamemodeManager.sqf#L74)
## gm_embarks

Type: Variable

Description: роли доступные после старта. Оставшиеся после престарта с количеством > 0 и возможность добавления перемещаются в этот лист


Initial value:
```sqf
[] //типы эмбарковых ролей. доступны и заполняются только после
```
File: [host\GamemodeManager\GamemodeManager.sqf at line 75](../../../Src/host/GamemodeManager/GamemodeManager.sqf#L75)
## gm_antagClientsFull

Type: Variable

Description: Антаговые определения.


Initial value:
```sqf
[] //лист фулловых антагов (особые + ВСЕ)
```
File: [host\GamemodeManager\GamemodeManager.sqf at line 78](../../../Src/host/GamemodeManager/GamemodeManager.sqf#L78)
## gm_antagClientsHidden

Type: Variable

Description: лист фулловых антагов (особые + ВСЕ)


Initial value:
```sqf
[] //лист скрытых антагов (скрытые + ВСЕ)
```
File: [host\GamemodeManager\GamemodeManager.sqf at line 79](../../../Src/host/GamemodeManager/GamemodeManager.sqf#L79)
## gm_preparedClients

Type: Variable

Description: лист скрытых антагов (скрытые + ВСЕ)


Initial value:
```sqf
[] //vec2 лист: ServerClient, RoleObject
```
File: [host\GamemodeManager\GamemodeManager.sqf at line 80](../../../Src/host/GamemodeManager/GamemodeManager.sqf#L80)
## gm_noRoleClients

Type: Variable

Description: vec2 лист: ServerClient, RoleObject


Initial value:
```sqf
[]
```
File: [host\GamemodeManager\GamemodeManager.sqf at line 82](../../../Src/host/GamemodeManager/GamemodeManager.sqf#L82)
## gm_state

Type: Variable

Description: 


Initial value:
```sqf
GAME_STATE_PRELOAD
```
File: [host\GamemodeManager\GamemodeManager.sqf at line 84](../../../Src/host/GamemodeManager/GamemodeManager.sqf#L84)
## gm_lobbyTimeToStart

Type: Variable

Description: 


Initial value:
```sqf
DEFAULT_TIME_TO_START
```
File: [host\GamemodeManager\GamemodeManager.sqf at line 86](../../../Src/host/GamemodeManager/GamemodeManager.sqf#L86)
## gm_lobbyTimeLeft

Type: Variable

Description: 


Initial value:
```sqf
60*5 //сколько до начала раунда. инициализированное состояние - превыбор режима
```
File: [host\GamemodeManager\GamemodeManager.sqf at line 87](../../../Src/host/GamemodeManager/GamemodeManager.sqf#L87)
## gm_lobbyCanProcessTime

Type: Variable

Description: сколько до начала раунда. инициализированное состояние - превыбор режима


Initial value:
```sqf
true //можно зафризить таймер до начала раунда
```
File: [host\GamemodeManager\GamemodeManager.sqf at line 88](../../../Src/host/GamemodeManager/GamemodeManager.sqf#L88)
## gm_gameModeClass

Type: Variable

Description: можно зафризить таймер до начала раунда


Initial value:
```sqf
"" //тип установленного режима.
```
File: [host\GamemodeManager\GamemodeManager.sqf at line 89](../../../Src/host/GamemodeManager/GamemodeManager.sqf#L89)
## gm_gameModeName

Type: Variable

Description: тип установленного режима.


Initial value:
```sqf
"" //Русское название режима
```
File: [host\GamemodeManager\GamemodeManager.sqf at line 90](../../../Src/host/GamemodeManager/GamemodeManager.sqf#L90)
## gm_isLastRound

Type: Variable

Description: Русское название режима


Initial value:
```sqf
false //включенный флаг означает что после конца раунда сервер не перезапустится а выключится
```
File: [host\GamemodeManager\GamemodeManager.sqf at line 91](../../../Src/host/GamemodeManager/GamemodeManager.sqf#L91)
## gm_supressStartCondition

Type: Variable

Description: включенный флаг означает что после конца раунда сервер не перезапустится а выключится


Initial value:
```sqf
false //при true раунд стартует принудительно без проверки GMBase::conditionToStart()
```
File: [host\GamemodeManager\GamemodeManager.sqf at line 93](../../../Src/host/GamemodeManager/GamemodeManager.sqf#L93)
## gm_preLobbyHandler

Type: Variable

Description: при true раунд стартует принудительно без проверки GMBase::conditionToStart()


Initial value:
```sqf
-1
```
File: [host\GamemodeManager\GamemodeManager.sqf at line 95](../../../Src/host/GamemodeManager/GamemodeManager.sqf#L95)
## gm_currentAspect

Type: Variable

Description: текущий игровой аспект


Initial value:
```sqf
nullPtr
```
File: [host\GamemodeManager\GamemodeManager.sqf at line 98](../../../Src/host/GamemodeManager/GamemodeManager.sqf#L98)
## gm_forcedAspect

Type: Variable

Description: 


Initial value:
```sqf
""
```
File: [host\GamemodeManager\GamemodeManager.sqf at line 99](../../../Src/host/GamemodeManager/GamemodeManager.sqf#L99)
## gm_canVote

Type: Variable

Description: votable component


Initial value:
```sqf
true
```
File: [host\GamemodeManager\GamemodeManager.sqf at line 103](../../../Src/host/GamemodeManager/GamemodeManager.sqf#L103)
## gm_votedMode

Type: Variable

Description: 


Initial value:
```sqf
""
```
File: [host\GamemodeManager\GamemodeManager.sqf at line 104](../../../Src/host/GamemodeManager/GamemodeManager.sqf#L104)
## gm_votedClients

Type: Variable

Description: 


Initial value:
```sqf
[]
```
File: [host\GamemodeManager\GamemodeManager.sqf at line 105](../../../Src/host/GamemodeManager/GamemodeManager.sqf#L105)
## gm_voteMap

Type: Variable

Description: 


Initial value:
```sqf
createHashMap
```
File: [host\GamemodeManager\GamemodeManager.sqf at line 106](../../../Src/host/GamemodeManager/GamemodeManager.sqf#L106)
## sdk_temp_internal_forcedAspect

Type: Variable

> Exists if **EDITOR** defined

Description: 


Initial value:
```sqf
null
```
File: [host\GamemodeManager\GamemodeManager.sqf at line 131](../../../Src/host/GamemodeManager/GamemodeManager.sqf#L131)
## gm_internal_forcestart

Type: function

> Exists if **RELEASE** not defined

Description: 


File: [host\GamemodeManager\GamemodeManager.sqf at line 206](../../../Src/host/GamemodeManager/GamemodeManager.sqf#L206)
# Gamemode_AllowedModes.sqf

## gm_allowedModes

Type: Variable

Description: !this define is deprecated


Initial value:
```sqf
[...
```
File: [host\GamemodeManager\Gamemode_AllowedModes.sqf at line 7](../../../Src/host/GamemodeManager/Gamemode_AllowedModes.sqf#L7)
# Gamemode_internal_auto.sqf

## gm_internal_auto_timeLoad

Type: Variable

Description: 


Initial value:
```sqf
[__DATE_ARR__]
```
File: [host\GamemodeManager\Gamemode_internal_auto.sqf at line 70](../../../Src/host/GamemodeManager/Gamemode_internal_auto.sqf#L70)
## gm_getTimeOffset

Type: function

Description: Получение смещения времени
- Param: _utcOffset (optional, default 0, expected types: ['0', []])
- Param: _utcTime (optional, default systemTime, expected types: [[]])

File: [host\GamemodeManager\Gamemode_internal_auto.sqf at line 7](../../../Src/host/GamemodeManager/Gamemode_internal_auto.sqf#L7)
# Gamemode_RoundManager.sqf

## additionalData

Type: constant

Description: Эти данные управляют типом структуры. Сюда можно впихнуть выпавшее значение


Replaced value:
```sqf
[_x,_prior]
```
File: [host\GamemodeManager\Gamemode_RoundManager.sqf at line 614](../../../Src/host/GamemodeManager/Gamemode_RoundManager.sqf#L614)
## hashPair(key,val)

Type: constant

Description: 
- Param: key
- Param: val

Replaced value:
```sqf
[#key,val]
```
File: [host\GamemodeManager\Gamemode_RoundManager.sqf at line 660](../../../Src/host/GamemodeManager/Gamemode_RoundManager.sqf#L660)
## getClientSetting(var)

Type: constant

Description: 
- Param: var

Replaced value:
```sqf
(_cliSettings get #var)
```
File: [host\GamemodeManager\Gamemode_RoundManager.sqf at line 718](../../../Src/host/GamemodeManager/Gamemode_RoundManager.sqf#L718)
## gameEvents_internal_list_allObjects

Type: Variable

Description: 


Initial value:
```sqf
[]
```
File: [host\GamemodeManager\Gamemode_RoundManager.sqf at line 1479](../../../Src/host/GamemodeManager/Gamemode_RoundManager.sqf#L1479)
## gm_startRound

Type: function

Description: событие, запускаемое при старте раунда


File: [host\GamemodeManager\Gamemode_RoundManager.sqf at line 225](../../../Src/host/GamemodeManager/Gamemode_RoundManager.sqf#L225)
## gm_prepareToRole

Type: function

Description: 
- Param: _client

File: [host\GamemodeManager\Gamemode_RoundManager.sqf at line 349](../../../Src/host/GamemodeManager/Gamemode_RoundManager.sqf#L349)
## gm_prepareNoRoleClients

Type: function

Description: 


File: [host\GamemodeManager\Gamemode_RoundManager.sqf at line 392](../../../Src/host/GamemodeManager/Gamemode_RoundManager.sqf#L392)
## gm_internal_resetContenders

Type: function

Description: 


File: [host\GamemodeManager\Gamemode_RoundManager.sqf at line 417](../../../Src/host/GamemodeManager/Gamemode_RoundManager.sqf#L417)
## gm_handlePreListAntags

Type: function

Description: 
- Param: _client
- Param: _rObj

File: [host\GamemodeManager\Gamemode_RoundManager.sqf at line 431](../../../Src/host/GamemodeManager/Gamemode_RoundManager.sqf#L431)
## gm_handleDefineFullAntags

Type: function

Description: 
- Param: _cli

File: [host\GamemodeManager\Gamemode_RoundManager.sqf at line 525](../../../Src/host/GamemodeManager/Gamemode_RoundManager.sqf#L525)
## gm_spawnPreparedClients

Type: function

Description: 
- Param: _client
- Param: _rObj
- Param: _isFullAntag (optional, default false)

File: [host\GamemodeManager\Gamemode_RoundManager.sqf at line 562](../../../Src/host/GamemodeManager/Gamemode_RoundManager.sqf#L562)
## gm_handleDefineHiddenAntags

Type: function

Description: 


File: [host\GamemodeManager\Gamemode_RoundManager.sqf at line 573](../../../Src/host/GamemodeManager/Gamemode_RoundManager.sqf#L573)
## gm_prepareReadyClients

Type: function

Description: Готовит структуру с приоритетами на роли


File: [host\GamemodeManager\Gamemode_RoundManager.sqf at line 594](../../../Src/host/GamemodeManager/Gamemode_RoundManager.sqf#L594)
## gm_initHashMapCharSettings

Type: function

Description: Установка настроек персонажа для рега в роль
- Param: _name
- Param: _val

File: [host\GamemodeManager\Gamemode_RoundManager.sqf at line 659](../../../Src/host/GamemodeManager/Gamemode_RoundManager.sqf#L659)
## gm_spawnClientToRole

Type: function

Description: Создать клиента в игре
- Param: _client (optional, default nullPtr)
- Param: _roleName (optional, default "")
- Param: _decrementRoleCount (optional, default true)
- Param: _mobsetup_map

File: [host\GamemodeManager\Gamemode_RoundManager.sqf at line 687](../../../Src/host/GamemodeManager/Gamemode_RoundManager.sqf#L687)
## gm_internal_assignToImpl

Type: function

Description: 
- Param: this
- Param: _mob
- Param: _usr

File: [host\GamemodeManager\Gamemode_RoundManager.sqf at line 839](../../../Src/host/GamemodeManager/Gamemode_RoundManager.sqf#L839)
## gm_sendLateRolesToClient

Type: function

Description: Отсылает клиенту запрос на открытие окна выбора доступных лейт ролей и список
- Param: _owner

File: [host\GamemodeManager\Gamemode_RoundManager.sqf at line 987](../../../Src/host/GamemodeManager/Gamemode_RoundManager.sqf#L987)
## gm_spawnSelectedLateRole

Type: function

Description: спавнит лейтового персонажа на свою роль
- Param: _roleClass
- Param: _owner

File: [host\GamemodeManager\Gamemode_RoundManager.sqf at line 1063](../../../Src/host/GamemodeManager/Gamemode_RoundManager.sqf#L1063)
## gm_addClientToEmbark

Type: function

Description: 
- Param: _client
- Param: _roleData
- Param: _owner

File: [host\GamemodeManager\Gamemode_RoundManager.sqf at line 1105](../../../Src/host/GamemodeManager/Gamemode_RoundManager.sqf#L1105)
## gm_removeClientFromEmbark

Type: function

Description: 
- Param: _client
- Param: _syncRPC (optional, default true)

File: [host\GamemodeManager\Gamemode_RoundManager.sqf at line 1117](../../../Src/host/GamemodeManager/Gamemode_RoundManager.sqf#L1117)
## gm_doEmbark

Type: function

Description: 


File: [host\GamemodeManager\Gamemode_RoundManager.sqf at line 1139](../../../Src/host/GamemodeManager/Gamemode_RoundManager.sqf#L1139)
## gm_validateAvailableRoles

Type: function

Description: Если таких ролей не указано или клиент не имеет возможности взять роль - сбрасываем её
- Param: this
- Param: _canPrintMessage (optional, default true)

File: [host\GamemodeManager\Gamemode_RoundManager.sqf at line 1177](../../../Src/host/GamemodeManager/Gamemode_RoundManager.sqf#L1177)
## gm_endRound

Type: function

Description: 
- Param: _endgameState

File: [host\GamemodeManager\Gamemode_RoundManager.sqf at line 1211](../../../Src/host/GamemodeManager/Gamemode_RoundManager.sqf#L1211)
## gm_isAspectAllowedToMode

Type: function

Description: может ли аспект быть установленным в этом режиме
- Param: _aspect
- Param: _curMode

File: [host\GamemodeManager\Gamemode_RoundManager.sqf at line 1305](../../../Src/host/GamemodeManager/Gamemode_RoundManager.sqf#L1305)
## gm_internal_getPossibleAspects

Type: function

Description: 
- Param: _curMode

File: [host\GamemodeManager\Gamemode_RoundManager.sqf at line 1329](../../../Src/host/GamemodeManager/Gamemode_RoundManager.sqf#L1329)
## gm_isAspectSetup

Type: function

Description: 
- Param: _checked

File: [host\GamemodeManager\Gamemode_RoundManager.sqf at line 1341](../../../Src/host/GamemodeManager/Gamemode_RoundManager.sqf#L1341)
## gm_pickRoundAspect

Type: function

Description: 


File: [host\GamemodeManager\Gamemode_RoundManager.sqf at line 1351](../../../Src/host/GamemodeManager/Gamemode_RoundManager.sqf#L1351)
## gm_pickMultiAspects

Type: function

Description: 
- Param: _aspObj

File: [host\GamemodeManager\Gamemode_RoundManager.sqf at line 1399](../../../Src/host/GamemodeManager/Gamemode_RoundManager.sqf#L1399)
## gameEvents_getPossibleEvents

Type: function

Description: получение всех доступных событий


File: [host\GamemodeManager\Gamemode_RoundManager.sqf at line 1445](../../../Src/host/GamemodeManager/Gamemode_RoundManager.sqf#L1445)
## gameEvents_pickEvent

Type: function

Description: запуск события
- Param: _evs
- Param: _wts

File: [host\GamemodeManager\Gamemode_RoundManager.sqf at line 1482](../../../Src/host/GamemodeManager/Gamemode_RoundManager.sqf#L1482)
## gameEvents_internal_isEventAllowedToSession

Type: function

Description: 
- Param: _aspect
- Param: _curMode

File: [host\GamemodeManager\Gamemode_RoundManager.sqf at line 1495](../../../Src/host/GamemodeManager/Gamemode_RoundManager.sqf#L1495)
## gameEvents_process

Type: function

Description: 


File: [host\GamemodeManager\Gamemode_RoundManager.sqf at line 1516](../../../Src/host/GamemodeManager/Gamemode_RoundManager.sqf#L1516)
## gm_createMob

Type: function

Description: создаёт игровую оболочку
- Param: _pos

File: [host\GamemodeManager\Gamemode_RoundManager.sqf at line 1544](../../../Src/host/GamemodeManager/Gamemode_RoundManager.sqf#L1544)
## lobby_createDummy

Type: function

Description: 
- Param: _pos
- Param: _isWoman (optional, default false)
- Param: _canSim (optional, default false)

File: [host\GamemodeManager\Gamemode_RoundManager.sqf at line 1577](../../../Src/host/GamemodeManager/Gamemode_RoundManager.sqf#L1577)
