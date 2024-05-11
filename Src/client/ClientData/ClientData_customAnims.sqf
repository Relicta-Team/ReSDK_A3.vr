#include "..\..\host\GameObjects\ConstantAndDefines\Mobs.h"

cd_customAnim = CUSTOM_ANIM_NONE;

cd_isCustomAnimEnabled = {
	cd_customAnim != CUSTOM_ANIM_NONE && ([] call interact_isActive)
};

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
	if (cd_customAnim == CUSTOM_ANIM_SEAT) then {
		_stance = "CROUCH";
	};
	if (cd_customAnim == CUSTOM_ANIM_STAND) then {
		_stance = "STAND";
	};
	private _idxStance = _stances find _stance;
	if (_idxStance == -1) then {_idxStance = 0};
	_mob switchmove (_curAnimlist select _idxStance);

	cd_customAnim = CUSTOM_ANIM_NONE;
	rpcSendToServer("__resetCustomAnim",[_mob]);
};