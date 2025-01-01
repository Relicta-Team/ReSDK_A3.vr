// ======================================================
// Copyright (c) 2017-2025 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================



_onChangeGameState = {
	params ["_oldState","_newState"];
	
	[_oldState,_newState] call lobby_onChangeGameState;
}; rpcAdd("onChangeGameState",_onChangeGameState);