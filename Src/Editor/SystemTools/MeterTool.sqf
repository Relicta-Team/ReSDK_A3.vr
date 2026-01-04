// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================


init_function(meterTool_init)
{
	meterTool_internal_startPressedPos = [0,0,0];
	meterTool_internal_isPressed = false;

	meterTool_internal_startObject = objNUll;
	meterTool_internal_endObject = objNUll;

	["onMouseAreaPressed",{
		params ["_key"];
		if (_key!=0) exitwith {};
		meterTool_internal_isPressed = false;
		if !isNullReference(meterTool_internal_startObject) then {
			deleteVehicle meterTool_internal_startObject;
		};
		if !isNullReference(meterTool_internal_endObject) then {
			deleteVehicle meterTool_internal_endObject;
		};
		//reset mouse area
	}] call Core_addEventHandler;

	["onFrame",{
		if (meterTool_internal_isPressed) then {
			_screenToWorldPos = screenToWorld getMousePosition;
			([_screenToWorldPos] call golib_om_getRayCastData) params ["_objR","_atlPos"];
			if equals(_atlPos,vec3(0,0,0)) then {_atlPos = _screenToWorldPos};

			_dist = meterTool_internal_startPressedPos distance _atlPos;
			drawLine3D [meterTool_internal_startPressedPos, _atlPos, [1,0,0,1], linearConversion [0,50,_dist, 3, 50,true]];
			_t = format["Расстояние: %1 м",_dist];
			drawIcon3D ["", [0,1,0,1], _atlPos, 0, 0, 0, _t, 1, 0.09, "PuristaMedium"];
			drawIcon3D ["", [0,0.7,0,1], meterTool_internal_startPressedPos, 0, 0, 0, "Начало", 1, 0.05, "PuristaMedium"];

			meterTool_internal_endObject setPosATL _atlPos;
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
	if isNullReference(meterTool_internal_startObject) then {
		meterTool_internal_startObject = "Sign_Arrow_F" createVehicle [0,0,0];
		meterTool_internal_startObject setObjectTexture [0,"#(argb,8,8,3)color(0.1,0.8,0.1,1)"];
		meterTool_internal_startObject setPosATL _pos;
	};
	if isNullReference(meterTool_internal_endObject) then {
		meterTool_internal_endObject = "Sign_Arrow_F" createVehicle [0,0,0];
		meterTool_internal_endObject setObjectTexture [0,"#(argb,8,8,3)color(0.5,0.8,0.5,1)"];
	};
}