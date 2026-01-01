// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include "..\..\host\lang.hpp"

namespace(Craft,craft_)

decl(bool)
craft_isPreviewEnabled = false;
decl(any)
craft_previewMesh = null;

decl(float)
craft_previewMeshDistance = 0;
decl(float)
craft_previewMeshDir = 0;
decl(bool)
craft_preview_modifierRotation = false;
decl(bool)
craft_preview_modifierDistance = false;
decl(any[])
craft_internal_handlers = []; //zchanged, mouseup

decl(void())
craft_internal_releaseHandlers = {
	if (count craft_internal_handlers > 0) then {
		{
			private _curHandler = craft_internal_handlers select _foreachindex;
			(findDisplay 46) displayRemoveEventHandler [_x,_curHandler];
		} foreach ["MouseZChanged","MouseButtonUp","KeyDown","KeyUp"];

		craft_internal_handlers = [];
	};

	craft_preview_modifierRotation = false;
	craft_preview_modifierDistance = false;
};

decl(void(mesh;vector3))
craft_startPreview = {
	params ["_model","_pos"];
	if !isNullVar(craft_previewMesh) then {
		craft_previewMesh callv(removeMesh);
		craft_previewMesh = null;
	};
	call craft_internal_releaseHandlers; //safe-release display handlers

	craft_previewMeshDir = random 360;

	craft_isPreviewEnabled = true;

	player call cd_fw_syncForceWalk; //for walk-only mode in craft preview mode

	//must be only one reference
	private _mesh = struct_newp(Model,_model arg _pos); 
	_mesh callp(setCollisionWith,player arg false);

	private _basePos = positionCameraToWorld [0,0,0];
	craft_previewMeshDistance = _basePos distance _pos;
	
	private _zchanged = (findDisplay 46) displayAddEventHandler ["MouseZChanged",{
		_value = _this select 1;

		if (craft_preview_modifierDistance) exitWith {
			if (_value > 0) then {
				_value = _value * 0.3;
				modvar(craft_previewMeshDistance) + (_value);
			} else {
				modvar(craft_previewMeshDistance) + (_value);
			};
			_maxDist = selectMax ((boundingBoxReal(craft_previewMesh callv(getMesh)) select 0)apply {abs _x});
			craft_previewMeshDistance = clamp(craft_previewMeshDistance,0.1,_maxDist * 1.3);
		};

		if (craft_preview_modifierRotation) then {
			_value = _value * 2.5;
		};

		if (_value > 0) then {
			modvar(craft_previewMeshDir) + _value;
		} else {
			modvar(craft_previewMeshDir) + _value;
		};

		//fix object angle
		craft_previewMeshDir = clampangle(craft_previewMeshDir,0,359);
	}];

	private _mouseUp = (findDisplay 46) displayAddEventHandler ["MouseButtonUp",{
		params ["","_button", "", "", "_shift", "_ctrl", "_alt"];
		if (_button == MOUSE_LEFT) exitWith {
			[true] call craft_endPreview;
		};
		if (_button == MOUSE_RIGHT) exitWith {
			[false] call craft_endPreview;
		};
	}];

	private _keyDown = (findDisplay 46) displayAddEventHandler ["KeyDown",{
		params ["","_key","_shift","_ctrl","_alt"];
		if (_shift) then {craft_preview_modifierRotation=true};
		if (_alt) then {craft_preview_modifierDistance=true};
	}];

	private _keyUp = (findDisplay 46) displayAddEventHandler ["KeyUp",{
		params ["","_key","_shift","_ctrl","_alt"];
		if (_shift) then {craft_preview_modifierRotation=false};
		if (_alt) then {craft_preview_modifierDistance=false};
	}];

	//bind display handlers and save mesh
	craft_internal_handlers = [_zchanged,_mouseUp,_keyDown,_keyUp];
	craft_previewMesh = _mesh;

	startAsyncInvoke
	{
		private _mesh = craft_previewMesh;
		_endPos = positionCameraToWorld [0,0,craft_previewMeshDistance];
		private _mdl = _mesh getv(_mesh);
		_localPos = player worldToModelVisual _endPos;
		_mdl attachTo [player,_localPos]; //fix roadway
		_mesh callp(setDir,craft_previewMeshDir);

		!craft_isPreviewEnabled
	},{},[]
	endAsyncInvoke
};

decl(void(bool))
craft_endPreview = {
	params ["_apply"];
	private _args = [_apply] call craft_endPreviewImpl;

	rpcSendToServer("craft_onEndPreview",_args);
};

decl(void(bool))
craft_endPreviewImpl = {
	params ["_apply"];
	private _curPos = craft_previewMesh callv(getPos);
	private _curDir = craft_previewMesh callv(getDir);

	craft_isPreviewEnabled = false;
	player call cd_fw_syncForceWalk;
	call craft_internal_releaseHandlers;
	craft_previewMesh = null;
	private _args = [player,_apply];
	if (_apply) then {
		_args pushBack [_curPos,_curDir];
	};
	
	_args
}; rpcAdd("craft_endPrevFromServer",craft_endPreviewImpl);