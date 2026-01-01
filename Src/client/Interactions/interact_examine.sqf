// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include "..\..\host\lang.hpp"

namespace(Interact,interact_)

decl(void())
interact_examine = {
	
	if (["examine"] call input_spamProtect) exitWith {};
		
	private _target = call interact_cursorObject;
	private _probOnScr = [true,false] call interact_getOnSceenCapturedObject;
	if !isNullVar(_probOnScr) then {
		_target = _probOnScr;
	};
	
	//skip NGO objects
	_target = _target call noe_client_getObjectNGOSkip;

	private _hashData = if (typeof _target == BASIC_MOB_TYPE) then {_target} else {getObjReference(_target)};
	#ifdef SP_MODE
		sp_checkInput("examine",[_hashData]);
	#endif
	rpcSendToServer("examine",[player arg _hashData]);
};

decl(void())
interact_pointTo = {
	["emt_point"]call interactEmote_doEmoteAction;
};