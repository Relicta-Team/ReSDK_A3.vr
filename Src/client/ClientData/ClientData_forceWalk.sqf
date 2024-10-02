// ======================================================
// Copyright (c) 2017-2024 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\LightEngine\LightEngine.hpp>

_onSyncLegsBoneState = {
	params ["_unit","_hasBreak"];
	cd_fw_hasBreakBone = _hasBreak;
	if not_equals(_unit,player) then {
		warning("rpc<onSyncLegsBoneState> - unit is not a player.");
	};
	_unit call cd_fw_syncForceWalk;
}; rpcAdd("onSyncLegsBoneState",_onSyncLegsBoneState);

//системный флаг блокировки бега (когда персонаж без ноги)
cd_fw_forceWalk = false;
//сломанные кости на ногах записываются сюда
cd_fw_hasBreakBone = false;
cd_fw_isForceWalk = {cd_fw_forceWalk || cd_fw_hasBreakBone || ([player] call smd_isPulling || craft_isPreviewEnabled)};
cd_fw_syncForceWalk = {
	private _mob = _this;
	if ([_mob,"ghost_flag",VST_GHOST_EFFECT] call le_vst_hasVarExt) exitWith {
		_mob forceWalk false;
	};
	_mob forceWalk (call cd_fw_isForceWalk)
};

//sprint sync
cd_sp_enabled = true;
cd_sp_lockedSetting = false;
cd_sp_grabbingMob = false;
cd_sp_canSprint = {
	cd_sp_enabled && !cd_sp_lockedSetting && !cd_sp_grabbingMob
};
_spr_sync = {
	player allowSprint (call cd_sp_canSprint)
}; rpcAdd("spr_sync",_spr_sync);