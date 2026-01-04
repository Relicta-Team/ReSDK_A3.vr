// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include "..\..\host\lang.hpp"

namespace(InteractAim,interaction_aim_)

macro_const(interaction_aim_widgetSize)
#define AIM_SIZE 3

decl(bool)
interact_aim_disableGlobal = false;

decl(int)
interaction_aim_handle = -1;
decl(int)
interaction_aim_alphaUpdHandle = -1;

decl(widget[])
interaction_aim_widgets = [widgetNull];

/*
var posW = Client::Interface.Display.transformSizeByAR(SIZE_AIM);
aim = new Client::ScreenRenderer::Widgets.AimPointer(display,50 - posW / 2,50 - SIZE_AIM / 2,posW,SIZE_AIM
*/
decl(void())
interaction_aim_init = {

	private _aim = [getGUI,PICTURE,call interaction_aim_getStdPos] call createWidget;
	interaction_aim_widgets set [0,_aim];

	_aim ctrlSetTextColor [0,1,0,0.05];

	[_aim,PATH_PICTURE("aim_cursor.paa")] call widgetSetPicture;

	interaction_aim_handle = startUpdate(interaction_aim_onUpdate,0.05);

	//TODO dynamic change opacity
	interaction_aim_alphaUpdHandle = startUpdate(interaction_aim_alphaUpdate,0.05);
};

decl(void())
interaction_aim_getStdPos = {
	private _posW = getWidthByHeightToSquare(AIM_SIZE);
	[50-_posW/2,50-AIM_SIZE/2,_posW,AIM_SIZE]
};

decl(void())
interaction_aim_alphaUpdate = {
	/*(getLightingAt player select 2) params ["_r","_g","_b"];

	_nv = (_r + _g + _b) / 3 ;

	_nv = linearConversion [0, 0.4, _nv, 0, 0.5] ;
	traceformat("color %1",_nv)
	(interaction_aim_widgets select 0) ctrlSetTextColor [0,1,0,_nv];
	*/
	_col = (interaction_aim_widgets select 0) getVariable ["rgb_col",[0,1,0,1]];
	if (call cd_isEyesClosed || interact_aim_disableGlobal) exitWith {
		_col set [3,0];
		(interaction_aim_widgets select 0) ctrlSetTextColor _col;
	};

	_lum = getLightingat cam_object select 3;
	_val = (_lum / 300) max 0 min 1;

	if ([player] call smd_isCombatModeEnabled) then {
		_val = 1;
	};

	_col set [3,_val];
	(interaction_aim_widgets select 0) ctrlSetTextColor _col;
};

decl(void())
interaction_aim_applyColorTheme = {
	(interaction_aim_widgets select 0) setVariable ["rgb_col",["cursor"] call ct_getValue];
};

decl(void())
interaction_aim_onUpdate = {

	_pos = call interaction_aim_getStdPos;
	_shakeByStaminaVal = (1 - stamina_lastVal / 100) / 5;

	_shakeByStaminaVal = _shakeByStaminaVal + ((linearConversion [0, 50, stamina_lastVal, 7, 0]) max 0);

	MODARR(_pos,0,+ rand(-_shakeByStaminaVal,_shakeByStaminaVal));
	MODARR(_pos,1,+ rand(-_shakeByStaminaVal,_shakeByStaminaVal));

	_timing = stamina_lastVal / 50;//300;
	//traceformat("new timing %1",_timing)
	if (stamina_lastVal >= 99) then {
		_timing = 0.01;
		_pos = call interaction_aim_getStdPos;
	};

	[interaction_aim_widgets select 0,_pos,_timing] call widgetSetPositionOnly;

	//changeUpdateTime(interaction_aim_handle,_timing)
};


call interaction_aim_init;
