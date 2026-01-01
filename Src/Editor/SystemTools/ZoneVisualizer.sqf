// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

init_function(zoneVis_initVars)
{
	zoneVis_updateHandle = -1;
}

function(zoneVis_isEnabled) { zoneVis_updateHandle != -1}

function(zoneVis_switchMode)
{
	if !(call zoneVis_isEnabled) then  {
		zoneVis_updateHandle = ["onFrame",zoneVis_internal_onFrame] call Core_addEventHandler;
	} else {
		["onFrame",zoneVis_updateHandle] call Core_removeEventHandler;
		zoneVis_updateHandle = -1;
	};
}

function(zoneVis_internal_onFrame)
{
	if (!isGameFocused) exitWith {};
	_objlist = call golib_getSelectedObjects;
	_convfunc = {
		params ["_memName"];
		[_objProvided,_memName] call golib_getActualDataValue
	};
	_objProvided = objNull;
	{
		_objProvided = _x;
		_cls = [_x] call golib_getClassName;
		if !isNullVar(_cls) then {
			if ([_cls,"__editor_renderbbx"] call oop_reflect_hasMethod) then {
				_method = typeGetVar(typeGetFromString(_cls),__editor_renderbbx);
				_pmap = [_convfunc] call _method;
				[_objProvided,[0,1,0,1],15,_pmap] call zoneVis_drawBBX;
			};
		};
	} foreach _objlist;
}

function(zoneVis_drawBBX)
{
	params ["_obj",["_color",[1,0,1,1]],["_width",3],"_bbdt"];
	private _bbox = ifcheck(isNullVar(_bbdt),boundingBoxReal _obj,_bbdt);

	_bbox params ["_point1","_point2"];
	_point1 params ["_x1","_y1","_z1"];
	_point2 params ["_x2","_y2","_z2"];

	private _p1 = _obj modelToWorld [_x1,_y1,_z1];
	private _p2 = _obj modelToWorld [_x2,_y1,_z1];
	private _p3 = _obj modelToWorld [_x2,_y1,_z2];
	private _p4 = _obj modelToWorld [_x1,_y1,_z2];
	private _p5 = _obj modelToWorld [_x1,_y2,_z1];
	private _p6 = _obj modelToWorld [_x2,_y2,_z1];
	private _p7 = _obj modelToWorld [_x2,_y2,_z2];
	private _p8 = _obj modelToWorld [_x1,_y2,_z2];
	
	drawLine3D [_p1, _p2, _color,_width];
	drawLine3D [_p2, _p3, _color,_width];
	drawLine3D [_p3, _p4, _color,_width];
	drawLine3D [_p4, _p1, _color,_width];
	drawLine3D [_p5, _p6, _color,_width];
	drawLine3D [_p6, _p7, _color,_width];
	drawLine3D [_p7, _p8, _color,_width];
	drawLine3D [_p8, _p5, _color,_width];
	drawLine3D [_p1, _p5, _color,_width];
	drawLine3D [_p2, _p6, _color,_width];
	drawLine3D [_p3, _p7, _color,_width];
	drawLine3D [_p4, _p8, _color,_width];
}