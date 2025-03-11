// ======================================================
// Copyright (c) 2017-2025 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

sp_gc_playerInputHandlers = [];

//if returns true - input intercept
sp_gc_handlePlayerInput = {
	params ["_target",["_opthanditem",""]];
	private _mob = call sp_getActor;
	private _lst = sp_gc_playerInputHandlers apply {[_mob,_target,_opthanditem] call _x};
	any_of(_lst)
};

sp_gc_addPlayerInputHandler = {
	params ["_code"];
	sp_gc_playerInputHandlers pushBack _code;
};

sp_gc_onPlayerAssigned = {
	params ["_mob"];
};