// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <GameMode.h>
load("ScriptedDefines.sqf");
load("BasicDefines.sqf");
load("BasicRole.sqf");
load("BasicTask.sqf");
load("BasicInfluenceEvent.sqf");
load("CommonGameAspects.sqf");

//all modes

load("GMTemplate\GM_Template.sqf");
	load("GMTemplate\GM_Template_Roles.sqf");

load("Detective\GM_Detective.sqf");
	load("Detective\DetectiveModeRoles.sqf");
load("Dirtpit\GM_Extended.sqf");
	load("Dirtpit\BaseGamemode.sqf");
	load("Dirtpit\StationRoles.sqf");
	load("Dirtpit\GM_OldNewOrder.sqf");
	load("Dirtpit\GM_Revolution.sqf");
	load("Dirtpit\GM_StealDoc.sqf");
	load("Dirtpit\GM_TVT.sqf");
		load("Dirtpit\TVTRoles.sqf");
load("Prey\GM_Prey.sqf");
	load("Prey\PreyRoles.sqf");
load("Saloon\GM_Saloon.sqf");
	load("Saloon\SaloonRoles.sqf");
load("Hunt\GM_Hunt.sqf");
	load("Hunt\HuntRoles.sqf");
load("Okopovo\GM_Okopovo.sqf");
	load("Okopovo\System.sqf");
	load("Okopovo\Tasks.sqf");
	load("Okopovo\Templates.sqf");
	load("Okopovo\Mob.sqf");
	load("Okopovo\OkopovoRoles.sqf");

#include "scripted_loader.hpp"
