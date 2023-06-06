// ======================================================
// Copyright (c) 2017-2023 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================
diag_log "preload melee";
loadFile("src\host\CombatSystem\MeeleWeapon.sqf");
diag_log "postload melee";
loadFile("src\host\CombatSystem\NaturalWeapons.sqf");
diag_log "postload next module";
loadFile("src\host\CombatSystem\AxesWeapons.sqf");
loadFile("src\host\CombatSystem\Swords.sqf");
loadFile("src\host\CombatSystem\NonWeapons.sqf");
loadFile("src\host\CombatSystem\Knifes.sqf");
loadFile("src\host\CombatSystem\ImprovisedItems.sqf");
loadFile("src\host\CombatSystem\Handles.sqf");

diag_log "eof load";