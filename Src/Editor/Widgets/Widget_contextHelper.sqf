// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

/*
	Context helper: 
	нужен для выключения активности всех виджетов
*/

init_function(widget_contextHelper_init)
{
	wch_postEnableList = [];
	wch_widgets = [];
	wch_isEnabled = false;
}


function(wch_enable)
{
	if (wch_isEnabled) exitwith {
		setLastError(__FUNC__ + "widget context helper alread enabled");
	};
	private _d = call getOpenedDisplay;
	wch_postEnableList = [];
	wch_widgets = [];
	{
		if (ctrlEnabled _x) then {
			_x ctrlEnable false;
			wch_postEnableList pushBack _x;
		};
	} foreach (allControls _d);

	wch_isEnabled = true;
}

function(wch_getControlStorage)
{
	wch_widgets
}

function(wch_disable)
{
	if (!wch_isEnabled) exitwith {
		setLastError(__FUNC__ + "widget context helper already disabled");
	};

	{
		if (!isNullVar(_x) && {!isNullReference(_x)}) then {
			[_x,true] call deleteWidget;
		};
	} foreach wch_widgets;

	//restove visible widgets
	{
		if !isNullReference(_x) then {
			_x ctrlEnable true;
		};
	} foreach wch_postEnableList;

	wch_postEnableList = [];
	wch_isEnabled = false;
}