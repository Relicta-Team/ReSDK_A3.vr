// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================


getEdenDisplay displayRemoveAllEventHandlers "keyup";
getEdenDisplay displayRemoveAllEventHandlers "mousebuttonup";
getEdenDisplay displayRemoveAllEventHandlers "mousebuttondown";

getEdenDisplay displayAddEventHandler ["KeyUp",{
	params ["_d","_key","_shift","_ctrl","_alt"];
	
	Core_posInit_perframe_awaitInput = true;

	_cls = ctrlClassName(focusedCtrl getEdenDisplay);
	["pressed on %1",_cls] call printTrace;
	if (_cls == INPUT || _cls == INPUTMULTI) exitWith {};
	
	if (_key == KEY_R && _shift) exitWith {
		call golib_vis_onPressButtonObjLib;
	};
	if (_key == KEY_E && _shift) exitWith {
		call inspector_onPressButton;
	};
	// if (_key == KEY_P) exitWith {	
	// 	if (call golib_isOpenedArraySelector) exitWith {};

	// 	_mode = !(call MouseAreaIsEnabled);
	// 	_mode call MouseAreaSetEnable;
	// 	["Mouse area input " + ifcheck(_mode,"enabled","disabled")] call showInfo;
	// };
	// if (_key == KEY_G) exitWith {
	// 	call ContextMenu_loadMouseObject;
	// };
}];

getEdenDisplay displayAddEventHandler ["MouseButtonUp",{
	params ["_w","_key","_xPressPos","_yPressPos","_shift","_ctrl","_alt"];
	
	Core_posInit_perframe_awaitInput = true;

	if (call MouseAreaIsEnabled) then {
		["onMouseAreaPressed",[_key,_shift,_ctrl,_alt]] call Core_invokeEvent;
	};
}];