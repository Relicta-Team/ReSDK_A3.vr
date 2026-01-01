// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================


//game state dependences in src\host\CommonComponents\Gamemode.sqf
#define GAME_STATE_PRELOAD 0
#define GAME_STATE_LOBBY 1
#define GAME_STATE_PLAY 2
#define GAME_STATE_END 3

#define GAME_STATE_LIST_NODE_BINDING ['Выбор режима:GAME_STATE_PRELOAD:В этот момент режим ещё не выбран.', \
    'Подготовка:GAME_STATE_LOBBY:На этом моменте раунд ещё не запущен, но режим уже выбран.', \
    'Игра:GAME_STATE_PLAY:На этом моменте режим выбран и раунд запущен. Идёт процесс игры.', \
    'Конец раунда:GAME_STATE_END:На этом моменте процесс игры завершен. Условия режима привели к его завершению.']

//регистратор структуры роли
//#define addRole(roleclass,rolename,countSlots) [roleclass,rolename,countSlots,[]]
#define ROLE_NAME 0
#define ROLE_DESC 1
#define ROLE_COUNT 2
#define ROLE_CONDITION_ADD_TO_LATE 3
#define ROLE_CONTENDERS 4
//Используется только в дефолтных ролях
#define ROLE_INDEX 5
	
	#define __addRoleToLateGame(roleName) [roleName,__internal_isDefaultRole] call gm_addRoleToLateGame
	#define __addRoleToLateGameWithArgs(args) args call gm_addRoleToLateGame
	#define __arrayArgs_LateGameCondition [__internal_roleName,__internal_isDefaultRole]

	#define LATERULE_AFTERSTART {__addRoleToLateGame(__internal_roleName)}
	#define LATERULE_BYCONDITION(cond) {if (cond) then {__addRoleToLateGame(__internal_roleName)}}
	#define LATERULE_DISABLE LATERULE_BYCONDITION(false)
	#define LATERULE_AFTERCONDITION(cond) {asyncInvoke({cond},{__addRoleToLateGameWithArgs(_this)},__arrayArgs_LateGameCondition,-1,{})}
	#define LATERULE_AFTERDELAY(delay) {invokeAfterDelayParams({__addRoleToLateGameWithArgs(_this)},delay,__arrayArgs_LateGameCondition)}


#define setGameModeName(name)  gm_gameModeName = name;

//Добавить роль прегейма
#define addPreStartRole(type) __refroletype = missionNamespace getVariable [("role_")+ (type),nullPtr]; if isNullReference(__refroletype) then { \
errorformat("Cant load pre start role <%2> in game mode %1: Null reference",gm_gameModeName arg type); \
} else {gm_preStartRoles pushBackUnique __refroletype; \
if callFunc(__refroletype,isMainRole) then {gm_preStartMainRoles pushBackUnique __refroletype}}

//добавить роль прогресса
#define addLateRole(type) __refroletype = missionNamespace getVariable [("role_")+ (type),nullPtr]; if isNullReference(__refroletype) then { \
errorformat("Cant load late role <%2> in game mode %1: Null reference",gm_gameModeName arg type); \
} else {gm_roundProgressRoles pushBackUnique __refroletype}


//антаги
//antag - 0 none; 1 hide, 2 unical, 3 all
#define ANTAG_NONE 0
#define ANTAG_HIDDEN 1
#define ANTAG_UNICAL 2
#define ANTAG_ALL 3

#define ANTAG_LIST_ALL_ [ANTAG_NONE,ANTAG_HIDDEN,ANTAG_UNICAL,ANTAG_ALL]
#define ANTAG_STR_LIST_ALL_ ["ANTAG_NONE","ANTAG_HIDDEN","ANTAG_UNICAL","ANTAG_ALL"]

#define ANTAG_PARSESTRING(v) (ANTAG_LIST_ALL_ select (ANTAG_STR_LIST_ALL_ find (v)))