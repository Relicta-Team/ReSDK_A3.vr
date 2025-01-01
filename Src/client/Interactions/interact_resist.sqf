// ======================================================
// Copyright (c) 2017-2025 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================


interact_processResist = {
	
	if (["resist",0.7] call input_spamProtect) exitWith {};
	
	rpcSendToServer("onResist",[player arg 1]);
};	