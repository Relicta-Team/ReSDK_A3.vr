// ======================================================
// Copyright (c) 2017-2025 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

sp_audio_sayPlayer = {
	params ["_pathPost"];
	["singleplayer\sp_guide\" + _pathPost] call soundUI_play;
};