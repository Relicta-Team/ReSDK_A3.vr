// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

/*
	Данный поток является общим для всех раундов. Тут какие-либо обособленные события.
*/
INC(gm_roundDuration);

_f = callFunc(gm_currentMode,checkFinish);

if (gm_isCustomRoundEnd) exitwith {stopThisUpdate(); [gm_idCustomResult] call gm_endRound};

if (_f != 0) exitWith {stopThisUpdate(); [_f] call gm_endRound};