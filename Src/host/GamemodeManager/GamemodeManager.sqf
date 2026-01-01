// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\oop.hpp>
#include <..\engine.hpp>
#include <..\text.hpp>
#include <..\ServerRpc\serverRpc.hpp>
#include <..\Networking\Network.hpp>
#include <..\MatterSystem\bloodTypes.hpp>
#include <GamemodeManager.hpp>
#include <GamemodeManager.h>
#include <..\ClientManager\Client.hpp>
#include <..\Family\Family.hpp>
#include <..\Gender\Gender.hpp>



#ifndef IS_ENABLE_GAMEMODEMANAGER
    //if (true) exitWith {};
#endif

gprint("Starting gamemode manager");

#include "GamemodeFunctions.sqf"
#include "Gamemode_RoundManager.sqf"
gprint("All functions loaded");

//Выполняет первичную инициализацию гейммода

gm_currentMode = nullPtr; //текущий установленный игровой режим
#include "Gamemode_AllowedModes.sqf"
gm_defaultMode = "GMExtended";// режим по-умолчанию
gm_currentModeId = -1; //айди установленного режима
	gm_internal_ingameClients = []; //сюда записываются все клиенты, зашедшие в игру хотя-бы один раз

gm_handleMainLoop = -1; //основной хандлер игры
gm_handleLobbyLoop = -1; //хандлер лобби
gm_handleEvents = -1; //хандлер событий
	gm_nextEventPlay = 0; //отметка когда следующее событие будет запущено

//кастомный конец раунда
gm_isCustomRoundEnd = false;
	gm_idCustomResult = INFINITY;
	gm_customTextResult = "Конец смены"; //кастомный текст конца раунда

// путь до папки со всеми модами
gm_modesFolder = "src\host\GamemodeManager\GameModes\";
//файл со списокм модов
gm_modesList = ["TestMode"];

//DEPRECATED
gm_defaultRoles = createHashMap; //хэшкарта дефолтных ролей
	gm_isCachedDefaultRoles = false; //закеширован ли резульат дефлотных ролей для клиента
	gm_chachedDefaultRoles = [];

//роли, регистрируемые для лейтгейма.
gm_roles = createHashMap;


gm_inGameRoles = createHashMap; //роли, доступные после начала раунда

/*
	Рассчитывается по приоритетам.
	Берётся роль, сначала выбирается. Рандомно выбирается клиент.

*/
gm_roleContenders = [[],[],[]];// - список клиентов которые претендуют на роли. readonly только для вывода информации.

// new roles functionality
gm_preStartRoles = []; //роли доступные на престарте (объекты)
	gm_preStartMainRoles = []; //приоритетные роли на престарте (ключевые) (объекты)
gm_roundProgressRoles = []; //роли доступные после старта. Оставшиеся после престарта с количеством > 0 и возможность добавления перемещаются в этот лист
gm_embarks = []; //типы эмбарковых ролей. доступны и заполняются только после

//Антаговые определения.
	gm_antagClientsFull = []; //лист фулловых антагов (особые + ВСЕ)
	gm_antagClientsHidden = []; //лист скрытых антагов (скрытые + ВСЕ)
	gm_preparedClients = []; //vec2 лист: ServerClient, RoleObject

gm_noRoleClients = [];

gm_state = GAME_STATE_PRELOAD;
[GAME_STATE_PRELOAD] call gm_onChangeState;
gm_lobbyTimeToStart = DEFAULT_TIME_TO_START;
gm_lobbyTimeLeft = 60*5; //сколько до начала раунда. инициализированное состояние - превыбор режима
gm_lobbyLowOnlineTimeLeft = 60*10; //время до выключения сервера при маленьком онлайне
gm_lobbyCanProcessTime = true; //можно зафризить таймер до начала раунда
gm_gameModeClass = ""; //тип установленного режима.
gm_gameModeName = ""; //Русское название режима
gm_isLastRound = false; //включенный флаг означает что после конца раунда сервер не перезапустится а выключится

gm_supressStartCondition = false; //при true раунд стартует принудительно без проверки GMBase::conditionToStart()

gm_preLobbyHandler = -1;

//текущий игровой аспект
gm_currentAspect = nullPtr;
gm_forcedAspect = "";

#include <Gamemode_internal_auto.sqf>

#include "Gamemode_voting.sqf"

//main init process
call gm_init;

#ifdef EDITOR

_startupMode = "";
_startupMode = ["startupMode",_startupMode] call sdk_getPropertyValue;

_canAutostartGame = "startGame" call sdk_hasSystemFlag;
_canAutoSetupGamemode = "autoGamemode" call sdk_hasSystemFlag;

if (_startupMode!="" && !_canAutoSetupGamemode) then {_canAutoSetupGamemode = true};

_startupMode = ["startGamemodeName",_startupMode] call sdk_getPropertyValue;
_startupRole = ["startRoleName",""] call sdk_getPropertyValue;
_canForceAspect = "forceAspect" call sdk_hasSystemFlag;
_forceAspectName = ["forcedAspectName",""] call sdk_getPropertyValue;

sdk_temp_internal_forcedAspect = null;

if ("startAtNight" call sdk_hasSystemFlag) then {
	invokeAfterDelay({call setNight;call setNight;[]spawn setNight},0.3);
};
if ("disableRayCastSphere" call sdk_hasSystemFlag) then {
	invokeAfterDelay({si_internal_rayObject hideObject true},1);
};

//apply logic
//isImplementClass(_startupMode)

//setup mode if valid
if (_canAutoSetupGamemode) then {
	if !isImplementClass(_startupMode) exitwith {
		["Невозможно запустить режим '%1'. Режима с таким класснеймом не существует.",_startupMode] 
		call MessageBox
	};
	if !isTypeNameOf(_startupMode,GMBase) exitwith {
		["Режим %1 не унаследован от GMBase",_startupMode] call MessageBox;
	};
	invokeAfterDelayParams({rpcCall("processClientCommand",vec2("setmode "+ _this ,player))},0.8,_startupMode);

	//force aspect
	if (_canForceAspect) then {
		if !isImplementClass(_forceAspectName) exitwith {
			["Невозможно установить аспект '%1'. Аспекта с таким класснеймом не существует.",_forceAspectName] 
			call MessageBox
		};
		if !isTypeNameOf(_forceAspectName,BaseGameAspect) exitwith {
			["Указанный аспект '%1' не унаследован от BaseGameAspect и не может быть установлен",_forceAspectName]
			call MessageBox;
		};
		sdk_temp_internal_forcedAspect = _forceAspectName;
	};
	
	if (_startupRole != "") then {
		//check role
		if !isImplementClass(_startupRole) exitwith {
			["Невозможно установить роль '%1'. Роли с таким именем класса не существует",_startupRole]
			call MessageBox;
		};
		if !isTypeNameOf(_startupRole,BasicRole) exitwith {
			["Роль %1 не унаследована от BasicRole",_startupRole] call MessageBox;
		};
		_gmObj = _startupMode call gm_getGameModeObject;
		_allowedRoles = callFunc(_gmObj,getLobbyRoles) apply {tolower _x};
		modvar(_allowedRoles) + (callFunc(_gmObj,getLateRoles) apply {tolower _x});
		
		if (!((tolower _startupRole) in _allowedRoles) && _startupRole != "BasicRole_SimulationReSDK") exitwith {
			["Роль %1 отсутствует в списке лобби ролей для выбранного режима",_startupRole] 
			call MessageBox;
		};

		invokeAfterDelayParams({ ["onClientChangeCharSetting" arg ["role1" arg _this arg 0]] call client_sendToServer },1.01,_startupRole);

		if (_canAutostartGame) then {
			//rpcSendToServer("onClientPrepareToPlay",[true arg 0]);
			invokeAfterDelay({ ["onClientPrepareToPlay" arg [true arg 0]] call client_sendToServer},1.01)
		};
	};


	//autostart
	if (_canAutostartGame) then {
		invokeAfterDelay({rpcCall("processClientCommand",vec2("startgame",player))},1.05);
	};
	
};


#endif


#ifndef RELEASE
gm_internal_forcestart = {
		
	["GMExtended"] call gm_initGameMode;
	
	_dostart = {
		gm_lobbyTimeLeft = 1;
		gm_supressStartCondition = true;
	};
	invokeAfterDelay(_dostart,5);
};
#endif

#ifdef CMD__FORCESTART
	invokeAfterDelay(gm_internal_forcestart,10);
#endif