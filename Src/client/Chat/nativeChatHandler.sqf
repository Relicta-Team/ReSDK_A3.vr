// ======================================================
// Copyright (c) 2017-2025 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

/*
********************************************************************************
********************************************************************************
********************************************************************************
********************************************************************************
********************************************************************************
********************************************************************************
*					THIS FILE IS NON-USABLE									   *
********************************************************************************
********************************************************************************
********************************************************************************
********************************************************************************
********************************************************************************
********************************************************************************
*/


//need initialization after client connect

#define chat_native_checktimeDelay 60

private _handle_nativeChat = addMissionEventHandler ["HandleChatMessage", {
	params ["_channel", "_owner", "_from", "_text", "_person", "_name", "_strID", "_forcedDisplay", "_isPlayerMessage", "_sentenceType", "_chatMessageType"];

	//regular update tickStamp (for disable launcher)
	chat_native_lastTimestamp = tickTime + chat_native_checktimeDelay;

	//process debug
}];


if (!isMultiplayer) then {
	if isNull(chat_native_debug_handler) exitWith {chat_native_debug_handler = _handle_nativeChat};
	removeMissionEventHandler ["HandleChatMessage", chat_native_debug_handler];
	chat_native_debug_handler = _handle_nativeChat;
};

chat_native_lastTimestamp = tickTime + chat_native_checktimeDelay;

//Запуск потока проверки связи с лаунчером
private ___regularCheck = {
	//one minute after
	if (tickTime > chat_native_lastTimestamp) exitWith {
		error("Launcher process not responding");
		stopThisUpdate();
		//compile and call crash file
	};
};
startUpdate(___regularCheck,chat_native_checktimeDelay);


chat_native_handleDebug = {
	//params ["_text"]
};
