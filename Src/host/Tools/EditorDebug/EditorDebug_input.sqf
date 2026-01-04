// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

inputDebug_list_events = [];

inputDebug_addMouseEvent = {
	params ["_code"];
	inputDebug_list_events pushBack _code
};

inputDebug_handleMouseEvent = {
	params ["_button","_shift","_ctrl","_alt"];
	private _intercepted = false;
	{
		private _itc = [_button,_shift,_ctrl,_alt] call _x;
		if (!isNullVar(_itc) && {_itc}) exitWith {
			_intercepted = true;
		};
	} foreach inputDebug_list_events;
	_intercepted
};