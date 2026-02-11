// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

//контекст меню и выделение объектов по клику мыши
function(MouseAreaSetEnable)
{
	MouseArea_sys_isEnabled = _this;
	(getEdenDisplay displayctrl 52) ctrlEnable MouseArea_sys_isEnabled;
}

function(MouseAreaIsEnabled)
{
	//ctrlEnabled (getEdenDisplay displayctrl 52)
	MouseArea_sys_isEnabled
}

function(MouseAreaGetWidget) { (getEdenDisplay displayctrl 52) }

//ну хоть вонючий тултип ваниллы убрал
function(MouseArea_handleDisableTooltip)
{
	//use get3DENMouseOver for get native data
	_c = (getEdenDisplay displayCtrl 52);
	_c ctrlSetTooltip "";
}

function(MouseArea_init)
{
	MouseArea_sys_isEnabled = true;

	MouseArea_internal_lastRMBPressTime = 0;
	MouseArea_internal_lastRMBPressPos = [0,0] call convertScreenCoords;
	MouseArea_internal_lastRMBPressWidget = [widgetNull];
	MouseArea_internal_lastRMBPressHandleEnabled = false;
	
	//Disable RMB native context
	getEdenDisplay displayAddEventHandler ["MouseButtonDown",{
		params ["_control", "_button", "_xPos", "_yPos", "_shift", "_ctrl", "_alt"];

		if (_this select 1 != 1) exitwith {};
		_inMap = get3DENActionState "ToggleMap" == 1;
		if (_inMap && (_shift||_ctrl||_alt)) exitwith {};

		//Назначение на нажатый виджет до выключения
		MouseArea_internal_lastRMBPressWidget = [(getEdenDisplay ctrlAt getMousePosition)];

		MouseArea_internal_lastRMBPressHandleEnabled = MouseArea_sys_isEnabled;
		if (MouseArea_internal_lastRMBPressHandleEnabled) then {
			(getEdenDisplay displayctrl 52) ctrlEnable false;
		};
		(call nativePanels_getLeftPanel) ctrlEnable false;

		MouseArea_internal_lastRMBPressTime = tickTime;
		MouseArea_internal_lastRMBPressPos = [_xPos,_yPos] call convertScreenCoords;
		
		
	}];
	getEdenDisplay displayAddEventHandler ["MouseButtonUp",{
		params ["_control", "_button", "_xPos", "_yPos", "_shift", "_ctrl", "_alt"];

		if (_this select 1 != 1) exitwith {};
		_inMap = get3DENActionState "ToggleMap" == 1;
		if (_inMap && (_shift||_ctrl||_alt)) exitwith {};
		if (MouseArea_internal_lastRMBPressHandleEnabled) then {
			(getEdenDisplay displayctrl 52) ctrlEnable true;
		};
		(call nativePanels_getLeftPanel) ctrlEnable true;

		_dist = MouseArea_internal_lastRMBPressPos distance ([_xPos,_yPos] call convertScreenCoords);
		["mousedata: %1 %2 %3",tickTime,MouseArea_internal_lastRMBPressTime,_dist] call printTrace;
		if (!_inMap && tickTime <= (MouseArea_internal_lastRMBPressTime + 0.2) && _dist <= 1.5) then {
			if !(call MouseAreaIsEnabled) exitwith {};
			if not_equals(MouseArea_internal_lastRMBPressWidget select 0,call MouseAreaGetWidget) exitwith {};
			
			[_button,_shift,_ctrl,_alt] call MouseArea_handleMousePress;
		};
	}];

	//displays: 315(attributes), 321 (newunit)
	["onFrame",{
		{
			_d = finddisplay _x;
			if !isNullReference(_d) then {
				//do not close editor native attributes
				_count = count allControls _d;
				//["Check native display with id %1 and ctrlcount %2",_x,_count] call printTrace;
				if (_x == 315 && 
					(_count == 62 //forget what this is...
					|| _count == 21 //layer edit
					|| _count == 27 //comment edit
					)) exitwith {};
				if (cfg_debug_devMode) exitwith {};
				_d CloseDisplay 0;				
			};
		} foreach [315,321];
	}] call Core_addEventHandler;

	call MouseArea_applyFixLostFocusAtWindow;

}

function(MouseArea_handleMousePress)
{
	params ["_key","_shift","_ctrl","_alt"];
	if (_key == MOUSE_RIGHT) exitwith {
		if (call contextMenu_energy_isDragModeActive) exitWith {};
		if (count call golib_getSelectedObjects > 1) then {
			[call golib_getSelectedObjects] call ContextMenu_loadMouseObjectList;
		} else {
			call ContextMenu_loadMouseObject;
		};
	};
}

/*
	Так как в обычной среде платформа работает в оконном режиме,
	при переключении активного окна на что-то другое и потом обратно на
	платформу - получаем баг с залоченным состоянием ЛКМ, когда объект привязывается к мыши
	и при повторном нажатии объект перемещается в новую позицию (причем в истории данное действие
	не записывается)
*/
function(MouseArea_applyFixLostFocusAtWindow)
{
	//fix on focus lost
	true call MouseAreaSetEnable;
	MouseArea_internal_foc_isLostFocus = false;
	["onFrame",{
		
		if (call isDisplayOpened) exitwith {};

		if (isGameFocused) then {
			if (MouseArea_internal_foc_isLostFocus) then {
				// Решение
				_c = {
					MouseArea_internal_foc_isLostFocus = false;
					if !(call MouseAreaIsEnabled) then {
						true call MouseAreaSetEnable
					};
				};
				nextFrame(_c);
				
			};
		} else {
			if (!MouseArea_internal_foc_isLostFocus) then {
				MouseArea_internal_foc_isLostFocus = true;
				if (call MouseAreaIsEnabled) then {
					false call MouseAreaSetEnable
				};
			};
		};
	}] call Core_addEventHandler;
}

function(MouseArea_isEnabledIcons) { (get3DENIconsVisible select 0) }
function(MouseArea_isEnabledLines) { (get3DENLinesVisible select 0) }

function(MouseArea_toggleIcons)
{
	set3DENIconsVisible [!(get3DENIconsVisible select 0),!(get3DENIconsVisible select 1)];
}

function(MouseArea_toggleLines)
{
	set3DENLinesVisible [!(get3DENLinesVisible select 0),!(get3DENLinesVisible select 1)];
}


