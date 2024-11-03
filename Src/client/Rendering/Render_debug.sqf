// ======================================================
// Copyright (c) 2017-2024 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

debug_drawBoundingBox = {
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
};

debug_drawBoundingBoxPos = {
	params ["_pos",["_color",[1,0,1,1]],["_width",3],"_bbx"];

	_bbx params ["_min","_max"];

	_min params ["_x1","_y1","_z1"];
	_max params ["_x2","_y2","_z2"];
	private _p1 = _pos vectorAdd [_x1,_y1,_z1];
	private _p2 = _pos vectorAdd [_x2,_y1,_z1];
	private _p3 = _pos vectorAdd [_x2,_y1,_z2];
	private _p4 = _pos vectorAdd [_x1,_y1,_z2];
	private _p5 = _pos vectorAdd [_x1,_y2,_z1];
	private _p6 = _pos vectorAdd [_x2,_y2,_z1];
	private _p7 = _pos vectorAdd [_x2,_y2,_z2];
	private _p8 = _pos vectorAdd [_x1,_y2,_z2];
	
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
};

debug_addRenderPos = {
	params ["_pos","_color","_wdt","_bbx"];

	struct_newp(LoopedFunction,debug_drawBoundingBoxPos arg [_pos arg _color arg _wdt arg _bbx]);
};

debug_addRenderObject = {
	params ["_obj","_color","_wdt","_bbxVec2"];
	if !isNullVar(_bbxVec2) then {
		addMissionEventHandler ["Draw3D", {
			if isNullReference(_thisArgs select 0) exitWith {
				removeMissionEventHandler ["Draw3D",_thisEventHandler];
			};
			_thisArgs call debug_drawBoundingBox;
			
		},[_obj,_color,_wdt,_bbxVec2]];
	} else {
		addMissionEventHandler ["Draw3D", {
			if isNullReference(_thisArgs select 0) exitWith {
				removeMissionEventHandler ["Draw3D",_thisEventHandler];
			};
			_thisArgs call debug_drawBoundingBox;
			
		},[_obj,_color,_wdt]];
	};

};