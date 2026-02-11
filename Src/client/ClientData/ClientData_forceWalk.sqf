// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include "..\..\host\lang.hpp"

#include <..\LightEngine\LightEngine.hpp>

namespace(clientDataForceWalk,cd_)

decl(void(actor;bool))
cd_onSyncLegsBoneState = {
	params ["_unit","_hasBreak"];
	cd_fw_hasBreakBone = _hasBreak;
	if not_equals(_unit,player) then {
		warning("rpc<onSyncLegsBoneState> - unit is not a player.");
	};
	_unit call cd_fw_syncForceWalk;
}; rpcAdd("onSyncLegsBoneState",cd_onSyncLegsBoneState);

//системный флаг блокировки бега (когда персонаж без ноги)
decl(bool)
cd_fw_forceWalk = false;
//сломанные кости на ногах записываются сюда
decl(bool)
cd_fw_hasBreakBone = false;
decl(bool())
cd_fw_isForceWalk = {cd_fw_forceWalk || cd_fw_hasBreakBone || ([player] call smd_isPulling || craft_isPreviewEnabled)};
decl(void(actor))
cd_fw_syncForceWalk = {
	private _mob = _this;
	if ([_mob,"VST_GHOST_EFFECT"] call vst_containsConfig) exitWith {
		_mob forceWalk false;
	};
	_mob forceWalk (call cd_fw_isForceWalk)
};

//sprint sync
decl(bool)
cd_sp_enabled = true;
decl(bool)
cd_sp_lockedSetting = false;
decl(bool)
cd_sp_grabbingMob = false;
decl(bool())
cd_sp_canSprint = {
	cd_sp_enabled && !cd_sp_lockedSetting && !cd_sp_grabbingMob
};
cd_spr_sync = {
	player allowSprint (call cd_sp_canSprint)
}; rpcAdd("spr_sync",cd_spr_sync);