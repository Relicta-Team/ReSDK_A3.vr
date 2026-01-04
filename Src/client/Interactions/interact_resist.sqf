// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include "..\..\host\lang.hpp"

namespace(Interact,interact_)

decl(void())
interact_processResist = {
	
	if (["resist",0.7] call input_spamProtect) exitWith {};

	#ifdef SP_MODE
		sp_checkInput("resist",[]);
	#endif
	
	rpcSendToServer("onResist",[player arg 1]);
};	