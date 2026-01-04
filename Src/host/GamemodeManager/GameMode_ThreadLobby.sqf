// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

FHEADER;

if (!gm_lobbyCanProcessTime) exitWith {};

#ifndef EDITOR
#ifndef TEST_WHITELISTED
if (count (call cm_getAllClientsInLobby) <= 3) exitWith {
	DEC(gm_lobbyLowOnlineTimeLeft);
	if (gm_lobbyLowOnlineTimeLeft < 0) exitWith {
		stopThisUpdate();
		gm_preLobbyHandler = -1;
		["Народа маловато. Расход!","system"] call cm_sendOOSMessage;
		gm_lobbyCanProcessTime = false;
		invokeAfterDelay(server_end,5);
		RETURN(0);
	};
	if (gm_lobbyLowOnlineTimeLeft%60 == 0) then {
		[format["Низкий онлайн. Если не наберется больше 3х игроков, сервер выключится через %1 секунд",gm_lobbyLowOnlineTimeLeft]] call cm_sendOOSMessage;
	};
};
#endif
#endif

DEC(gm_lobbyTimeLeft);

gm_lobbyLowOnlineTimeLeft = PRE_LOBBY_LOW_ONLINE_AWAIT;

if (gm_lobbyTimeLeft < 0) then {

	if (callFunc(gm_currentMode,conditionToStart) || gm_supressStartCondition) then {
		stopThisUpdate();
		call gm_startRound;
		RETURN(0);
	} else {
		[callFunc(gm_currentMode,onFailReasonToStart)] call cm_sendLobbyMessage;
	};

	gm_lobbyTimeLeft = gm_lobbyTimeToStart;
	[format["Время вышло. Раунд стартует через %1 секунд",gm_lobbyTimeToStart]] call cm_sendLobbyMessage;
	
	USEEVERYDAYRUN_doValidation();
	if (gm_isLastRound) then {
		
		["Пожалуй на сегодня хватит игр. Сервер выключится через 10 секунд...","system"] call cm_sendOOSMessage;
		gm_lobbyCanProcessTime = false;
		invokeAfterDelay(server_end,10);
	};
};


//TODO собирать массив айди при изменении статуса клиентов. ИЛИ глобально рассылать переменную
_allClients = call cm_getAllClientsInLobby;

{
	netSendVar("lobby_timeLeft",gm_lobbyTimeLeft,callFunc(_x,getOwner));
} foreach _allClients;
