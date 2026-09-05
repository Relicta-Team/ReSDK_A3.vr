// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

grenadefx_createDebugMarker = {
	params ["_pos","_color",["_scale",1]];
	private _marker = "Sign_Sphere10cm_F" createVehicleLocal [0,0,0];
	_marker enableSimulation false;
	_marker setPhysicsCollisionFlag false;
	_marker setPosATL _pos;
	_marker setObjectTexture [0,format[
		"#(argb,8,8,3)color(%1,%2,%3,%4,co)",
		_color select 0,
		_color select 1,
		_color select 2,
		_color select 3
	]];
	_marker setObjectScale _scale;
	_marker
};

grenadefx_deleteDebugObjects = {
	params ["_objects"];
	{deleteVehicle _x} foreach _objects;
	grenadefx_debugObjects = grenadefx_debugObjects - _objects;
};

grenadefx_addDebugSphere = {
	params ["_objects","_origin","_radius","_color"];
	for "_i" from 0 to 23 do {
		private _angle = _i * 15;
		_objects pushBack ([_origin vectorAdd [_radius * cos _angle,_radius * sin _angle,0],_color,1.8] call grenadefx_createDebugMarker);
		_objects pushBack ([_origin vectorAdd [_radius * cos _angle,0,_radius * sin _angle],_color,1.8] call grenadefx_createDebugMarker);
		_objects pushBack ([_origin vectorAdd [0,_radius * cos _angle,_radius * sin _angle],_color,1.8] call grenadefx_createDebugMarker);
	};
};

grenadefx_addDebugRay = {
	params ["_objects","_start","_end","_color"];
	private _length = _start distance _end;
	if (_length < 0.01) exitWith {};
	private _direction = vectorNormalized (_end vectorDiff _start);
	private _markerSpacing = 1 / 3;
	private _markerScale = 1.25 / 3;
	for "_offset" from 0 to _length step _markerSpacing do {
		_objects pushBack ([_start vectorAdd (_direction vectorMultiply _offset),_color,_markerScale] call grenadefx_createDebugMarker);
	};
	_objects pushBack ([_end,_color,2.5] call grenadefx_createDebugMarker);
};

grenadefx_onDebugExplosion = {
	params ["_origin","_blastRadius","_rays"];
	private _objects = [];
	_objects pushBack ([_origin,[1,1,1,1],4] call grenadefx_createDebugMarker);
	[_objects,_origin,_blastRadius,[1,0.15,0,0.85]] call grenadefx_addDebugSphere;
	{
		_x params ["_start","_end","_color"];
		[_objects,_start,_end,_color] call grenadefx_addDebugRay;
	} foreach _rays;

	grenadefx_debugObjects append _objects;
	invokeAfterDelayParams(grenadefx_deleteDebugObjects,12,[_objects]);
};
