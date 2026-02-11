// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\engine.hpp>


cc_setCombatMode = {
	params ["_mob","_mode",["_needSyncCameraAnim",false],["_doSkipApplyMove",false]];

	if (!local _mob) exitWith {
		errorformat("cc::setCombatMode() - Generic locality error. Mob is not local - %1",_mob);
	};

	// if sitting or unconscious do not apply anim

	private _nowpnAnims = ["amovppnemstpsnonwnondnon","amovpknlmstpsnonwnondnon","amovpercmstpsnonwnondnon"];
	private _wpnAnims = ["amovppnemstpsraswpstdnon","amovpknlmstpsraswpstdnon","amovpercmstpsraswpstdnon"];
	private _stances = ["PRONE","CROUCH","STAND"];
	private _curAnimlist = null;

	if (_mode) then {
		_curAnimlist = _wpnAnims;
		_mob addWeapon "CombatMode";
		_mob selectWeapon (handgunWeapon _mob);
	} else {
		_curAnimlist = _nowpnAnims;
		_mob removeWeapon "CombatMode";
	};

	if (!_doSkipApplyMove) then {
		private _idxStance = _stances find (stance _mob);
		if (_idxStance == -1) then {_idxStance = 0};
		_mob switchmove (_curAnimlist select _idxStance);
		if !isNullReference(attachedTo _mob) exitWith {};
		_mob setPosAtl getPosATLVisual _mob;
	};

	if (_needSyncCameraAnim) then {
		[_mob] call anim_syncAnim;
		//fixed after 0.6.183
		//nextFrame(cam_updateCameraRotation); //not effect in local (more effective reseting position)
	};

	if !isNull(hud_combatMode_sync) then {
		if equals(_mob,player) then {
			call hud_combatMode_sync;
		};
	};
};
