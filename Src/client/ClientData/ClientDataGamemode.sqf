// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include "..\..\host\lang.hpp"
namespace(clientData,cd_)

decl(void(int;int))
cd_onChangeGameState = {
	params ["_oldState","_newState"];
	
	[_oldState,_newState] call lobby_onChangeGameState;
}; rpcAdd("onChangeGameState",cd_onChangeGameState);