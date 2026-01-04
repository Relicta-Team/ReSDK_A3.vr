// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================



function(nativePanels_getRightPanel)
{
	getEdenDisplay displayctrl 1021
}

function(nativePanels_getLeftPanel)
{
	getEdenDisplay displayctrl 1019
}

//можно и проще через (profileNamespace getVariable 'display3DEN_panelLeft')
function(nativePanels_isHiddenLeft)
{
	(((call nativePanels_getLeftPanel) call widgetGetPosition) select 1) > 101
}

function(nativePanels_isHiddenRight)
{
	(((call nativePanels_getRightPanel) call widgetGetPosition) select 1) > 101
}

function(nativePanels_onToggleLeft)
{
	with uinamespace do {'showPanelLeft' call BIS_fnc_3DENInterface};
	[
		"onToggleLeftPanelState",
		call nativePanels_isHiddenLeft
	] call Core_invokeEvent;
}

function(nativePanels_onToggleRight)
{
	with uinamespace do {'showPanelRight' call BIS_fnc_3DENInterface};
	[
		"onToggleRightPanelState",
		call nativePanels_isHiddenRight
	] call Core_invokeEvent;
}

function(nativeWidgets_getListboxHistory)
{
	((findDisplay 313) displayctrl 74)
}

function(nativeWidgets_getCurrentHistoryText)
{
	private _lb = call nativeWidgets_getListboxHistory;
	private _idx = lbCurSel _lb;
	if (_idx == -1) exitWith {null};
	_lb lbText _idx
}