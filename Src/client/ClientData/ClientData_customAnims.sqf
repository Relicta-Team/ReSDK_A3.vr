// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include "..\..\host\lang.hpp"
#include "..\..\host\GameObjects\ConstantAndDefines\Mobs.h"

namespace(clientDataCustomAnim,cd_)

decl(int)
cd_customAnim = CUSTOM_ANIM_ACTION_NONE;

decl(bool())
cd_isCustomAnimEnabled = {
	cd_customAnim != CUSTOM_ANIM_ACTION_NONE && ([] call interact_isActive)
};

decl(void())
cd_handleRestCustomAnim = {
	if !(call cd_isCustomAnimEnabled) exitWith {};
	private _mob = player;
	private _nowpnAnims = ["amovppnemstpsnonwnondnon","amovpknlmstpsnonwnondnon","amovpercmstpsnonwnondnon"];
	private _wpnAnims = ["amovppnemstpsraswpstdnon","amovpknlmstpsraswpstdnon","amovpercmstpsraswpstdnon"];
	private _stances = ["PRONE","CROUCH","STAND"];
	private _curAnimlist = _nowpnAnims;
	if ([_mob] call smd_isCombatModeEnabled) then {
		_curAnimlist = _wpnAnims;
	};
	private _stance = stance _mob;
	if (cd_customAnim == CUSTOM_ANIM_ACTION_SEAT) then {
		_stance = "CROUCH";
	};
	if (cd_customAnim == CUSTOM_ANIM_ACTION_STAND) then {
		_stance = "STAND";
	};
	private _idxStance = _stances find _stance;
	if (_idxStance == -1) then {_idxStance = 0};
	private _anim_name = (_curAnimlist select _idxStance);

	["switchmove",[_mob,_anim_name]] call CBA_fnc_globalEvent;

	cd_customAnim = CUSTOM_ANIM_ACTION_NONE;
	rpcSendToServer("__resetCustomAnim",[_mob]);
};