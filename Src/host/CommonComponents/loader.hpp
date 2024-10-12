// ======================================================
// Copyright (c) 2017-2024 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\engine.hpp>
#include <..\client_compiled.hpp>

#ifdef __VM_BUILD
	#define importCommon(path) if (isNil {allClientContents}) then {allClientContents = [];}; \
	__vm_log("[LOAD] " + ("src\host\CommonComponents\" + path)); \
	_path = "src\host\CommonComponents\" + path; \
	private _ctx = compile ((__pragma_prep_cli _path)); \
	allClientContents pushback _ctx;
#endif

#ifdef __VM_VALIDATE
	#define importCommon(path) diag_log format["Start validate common module %1",path]; \
	private _ctx = compile preprocessFileLineNumberS ("src\host\CommonComponents\" + path); \
	diag_log format["   - Module %1 loaded",path];
#endif

importCommon("!PreInit.sqf");
importCommon("Assert.sqf");
importCommon("Algorithm.sqf");
importCommon("bitflags.sqf");
importCommon("Animator.sqf");
importCommon("Color.sqf");
importCommon("Gamemode.sqf");
importCommon("ModelsPath.sqf");
importCommon("Voice.sqf");
importCommon("CombatMode.sqf");
importCommon("SMD_shared.sqf");
importCommon("SoundEngine.sqf");
importCommon("Craft.sqf");
importCommon("DateTime.sqf");
importCommon("Replicator.sqf");
importCommon("AttackTypesAssoc.sqf");
importCommon("Pencfg.sqf");
importCommon("StructLib.sqf");