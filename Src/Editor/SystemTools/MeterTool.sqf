// ======================================================
// Copyright (c) 2017-2023 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================


init_function(meterTool_init)
{
	meterTool_internal_startPressedPos = [0,0,0];
	meterTool_internal_isPressed = false;

	["onMouseAreaPressed",{
		params ["_key"];
		if (_key!=0) exitwith {};
		meterTool_internal_isPressed = false;
		//reset mouse area
	}] call Core_addEventHandler;

	["onFrame",{
		if (meterTool_internal_isPressed) then {
			_screenToWorldPos = screenToWorld getMousePosition;
			([_screenToWorldPos] call golib_om_getRayCastData) params ["_objR","_atlPos"];
			if equals(_atlPos,vec3(0,0,0)) then {_atlPos = _screenToWorldPos};

			drawLine3D [meterTool_internal_startPressedPos, _atlPos, [1,0,0,1]];
			_dist = meterTool_internal_startPressedPos distance _atlPos;
			_t = format["Расстояние: %1 м",_dist];
			drawIcon3D ["", [0,1,0,1], _atlPos, 0, 0, 0, _t, 1, 0.09, "PuristaMedium"];
			drawIcon3D ["", [0,0.7,0,1], meterTool_internal_startPressedPos, 0, 0, 0, "Начало", 1, 0.05, "PuristaMedium"];
		};
	}] call Core_addEventHandler;
}

function(meterTool_onActivate)
{
	params ["_pos"];
	if (!meterTool_internal_isPressed) then {
		["Нажмите ЛКМ в любом месте сцены чтобы закончить измерения",null,null,0] call showInfo;
	};
	meterTool_internal_isPressed = true;
	meterTool_internal_startPressedPos = _pos;
}