// ======================================================
// Copyright (c) 2017-2025 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

FHEADER;

if (!gm_lobbyCanProcessTime) exitWith {};

DEC(gm_lobbyTimeLeft);

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
