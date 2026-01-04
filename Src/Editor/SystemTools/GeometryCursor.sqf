// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================


init_function(geoCursor_init)
{
	geoCursor_enabled = false;
	geoCursor_internal_onFrameHandle = -1;
	if !isNull(geoCursor_object) then {
		deleteVehicle geoCursor_object;
	};
	geoCursor_object = "Sign_Arrow_F" createVehicle [0,0,0];
}

function(geoCursor_toggle)
{
	if (geoCursor_enabled) then {
		["onFrame",geoCursor_internal_onFrameHandle] call Core_removeEventHandler;
		geoCursor_object setposatl [0,0,0];
		geoCursor_object hideObject true;
	} else {
		geoCursor_object hideObject false;
		["onFrame",geoCursor_handleUpdate] call Core_addEventHandler;
	};

	geoCursor_enabled = !geoCursor_enabled;
}


function(geoCursor_handleUpdate)
{
	([screenToWorld getMousePosition,geoCursor_object] call golib_om_getRayCastData)params["_obj","_pos","_vecup"];

	geoCursor_object setposatl _pos;
	geoCursor_object setvectorup _vecup;
}