// ======================================================
// Copyright (c) 2017-2024 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================



interact_examine = {
	
	if (["examine"] call input_spamProtect) exitWith {};
		
	private _target = call interact_cursorObject;
	
	private _hashData = if (typeof _target == BASIC_MOB_TYPE) then {_target} else {getObjReference(_target)};
	
	rpcSendToServer("examine",[player arg _hashData]);
};	

interact_pointTo = {
	["emt_point"]call interactEmote_doEmoteAction;
};