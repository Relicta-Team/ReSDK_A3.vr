// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\engine.hpp>
#include <..\GamemodeManager\GamemodeManager.hpp>

_provider_isRoundPreLoad = {
	gm_state == GAME_STATE_PRELOAD
};

_provider_isRoundLobby = {
	gm_state == GAME_STATE_LOBBY
};

_provider_isRoundPlaying = {
	gm_state == GAME_STATE_PLAY
};

_provider_isRoundEnding = {
	gm_state == GAME_STATE_END
};

_provider_getState = {
	private _ind = [GAME_STATE_PRELOAD,GAME_STATE_LOBBY,GAME_STATE_PLAY,GAME_STATE_END] find _this;
	if (_ind == -1) exitWith {
		errorformat("Cant find game state enum %1. Returns unknown state",_this);
		format["GAME_STATE_UNKNOWN_%1",_this]
	};
	
	["GAME_STATE_PRELOAD","GAME_STATE_LOBBY","GAME_STATE_PLAY","GAME_STATE_END"] select _ind
};

// [">","GAME_STATE_PLAY"] call gmc_checkState
_provider_checkState = {
	params ["_comparer","_stateStr"];
	
	private _idx = ["GAME_STATE_PRELOAD","GAME_STATE_LOBBY","GAME_STATE_PLAY","GAME_STATE_END"] find _stateStr;
	
	if (_idx == -1) exitWith {
		errorformat("[GAMEMODE:COMMON]: Unknown game state str <%1>",_stateStr);
		false
	};
	if equals(_comparer,"==") exitWith {gm_state == _idx};
	if equals(_comparer,"!=") exitWith {gm_state != _idx};
	if equals(_comparer,">") exitWith {gm_state > _idx};
	if equals(_comparer,">=") exitWith {gm_state >= _idx};
	if equals(_comparer,"<") exitWith {gm_state < _idx};
	if equals(_comparer,"<=") exitWith {gm_state <= _idx};
	errorformat("[GAMEMODE:COMMON]: Compare error - unknown token %1",_comparer);
	false
	
};

//gm_checkState(">=","GAME_STATE_PLAY")

if (isMultiplayer) then {
	if (isServer) then {
		gm_isRoundPreload = _provider_isRoundPreLoad;
		gm_isRoundLobby = _provider_isRoundLobby;
		gm_isRoundPlaying = _provider_isRoundPlaying;
		gm_isRoundEnding = _provider_isRoundEnding;
		gm_getState = _provider_getState;
		gm_checkState = _provider_checkState;
	} else {
		gmc_isRoundPreload = _provider_isRoundPreLoad;
		gmc_isRoundLobby = _provider_isRoundLobby;
		gmc_isRoundPlaying = _provider_isRoundPlaying;
		gmc_isRoundEnding = _provider_isRoundEnding;
		gmc_getState = _provider_getState;
		gmc_checkState = _provider_checkState;
	};
} else {
	
	gm_isRoundPreload = _provider_isRoundPreLoad;
	gm_isRoundLobby = _provider_isRoundLobby;
	gm_isRoundPlaying = _provider_isRoundPlaying;
	gm_isRoundEnding = _provider_isRoundEnding;
	gm_getState = _provider_getState;
	gm_checkState = _provider_checkState;
	
	gmc_isRoundPreload = _provider_isRoundPreLoad;
	gmc_isRoundLobby = _provider_isRoundLobby;
	gmc_isRoundPlaying = _provider_isRoundPlaying;
	gmc_isRoundEnding = _provider_isRoundEnding;
	gmc_getState = _provider_getState;
	gmc_checkState = _provider_checkState;
};