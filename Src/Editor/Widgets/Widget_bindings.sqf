// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================



function(widget_bind) {
	params ["_var","_name"];
	
	[_var] call widget_bindClear;
	
	getEdenDisplay setVariable [_var,_name];
}

function(widget_getBind)
{
	getEdenDisplay getVariable [_this,widgetNull]
}

function(widget_bindClear)  {
	params ["_var"];
	private _w = getEdenDisplay getVariable [_var,widgetNull];
	if !isNullReference(_w) then {
		ctrlDelete _w;
	};
}

