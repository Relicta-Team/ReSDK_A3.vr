// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\engine.hpp>

// Both faces belong to the same item. Descriptor travels with the door chunk.
doorLock_clearVisuals = {
	params ["_door"];
	private _update = _door getVariable ["doorLockUpdate",-1];
	if (_update != -1) then {stopUpdate(_update)};
	_door setVariable ["doorLockUpdate",-1];
	{
		if !isNullReference(_x) then {
			private _geom = _x getVariable ["ngo_geom",objNull];
			if !isNullReference(_geom) then {deleteVehicle _geom};
			_geom = _x getVariable ["srv_ngo_geom",objNull];
			if !isNullReference(_geom) then {deleteVehicle _geom};
			deleteVehicle _x;
		};
	} foreach (_door getVariable ["doorLockMeshes",[]]);
	_door setVariable ["doorLockMeshes",[]];
	_door setVariable ["doorLockVisualData",[]];
};

// Keep replacement faces hidden too if a door is currently interpolating.
doorLock_setVisualsHidden = {
	params ["_door","_hidden"];
	_door setVariable ["doorLockVisualsHidden",_hidden];
	{
		_x hideObject _hidden;
		private _geom = _x getVariable ["ngo_geom",objNull];
		if !isNullReference(_geom) then {_geom hideObject _hidden};
		_geom = _x getVariable ["srv_ngo_geom",objNull];
		if !isNullReference(_geom) then {_geom hideObject _hidden};
	} foreach (_door getVariable ["doorLockMeshes",[]]);
};

doorLock_getFaceTransform = {
	params ["_yaw","_side"];
	private _angle = _yaw + ifcheck(_side == 1,0,180);
	[
		[0,0,1],
		[sin _angle,cos _angle,0]
	]
};

// Converts a vector expressed in a selection's right/forward/up basis.
doorLock_transformVector = {
	params ["_basis","_vector"];
	_basis params ["_dir","_up"];
	private _right = _dir vectorCrossProduct _up;
	((_right vectorMultiply (_vector select 0)) vectorAdd (_dir vectorMultiply (_vector select 1))) vectorAdd (_up vectorMultiply (_vector select 2))
};

doorLock_inverseTransformVector = {
	params ["_basis","_vector"];
	_basis params ["_dir","_up"];
	private _right = _dir vectorCrossProduct _up;
	[_vector vectorDotProduct _right,_vector vectorDotProduct _dir,_vector vectorDotProduct _up]
};

doorLock_getSelectionTransform = {
	params ["_door","_selection"];
	private _lod = "ViewGeometry";
	private _names = (_door selectionNames _lod) apply {tolower _x};
	if !((tolower _selection) in _names) then {_lod = "Geometry"};
	[
		_door selectionPosition [_selection,_lod,"AveragePoint"],
		_door selectionVectorDirAndUp [_selection,_lod]
	]
};

// Explicitly follows either the door root or its animated selection. attachTo
// cannot follow selections that exist only in Geometry/ViewGeometry LODs.
doorLock_syncVisuals = {
	params ["_door"];
	private _data = _door getVariable ["doorLockVisualData",[]];
	private _meshes = _door getVariable ["doorLockMeshes",[]];
	if (count _data == 0 || {count _meshes != 2}) exitWith {};
	_data params ["_pointer","_model","_position","_selection","_depth","_yaw",["_closedCenter",[0,0,0]],["_closedBasis",[[0,1,0],[0,0,1]]]];

	private _selectionCenter = [0,0,0];
	private _selectionBasis = [[0,1,0],[0,0,1]];
	if (_selection != "") then {
		([_door,_selection] call doorLock_getSelectionTransform) params ["_selectionCenter","_selectionBasis"];
	};
	private _relativePosition = _position;
	if (_selection != "") then {
		_relativePosition = [_closedBasis,_position vectorDiff _closedCenter] call doorLock_inverseTransformVector;
	};
	private _doorBasis = [vectorDirVisual _door,vectorUpVisual _door];
	{
		private _faceBasis = [_yaw,_x] call doorLock_getFaceTransform;
		private _normal = [_selectionBasis,_faceBasis select 1] call doorLock_transformVector;
		private _localPosition = ifcheck(
			_selection == "",
			_position vectorAdd ((_faceBasis select 1) vectorMultiply _depth),
			_selectionCenter vectorAdd ([_selectionBasis,_relativePosition] call doorLock_transformVector) vectorAdd (_normal vectorMultiply _depth)
		);
		private _mesh = _meshes select _forEachIndex;
		_mesh setPosAtl (_door modelToWorldVisual _localPosition);
		_mesh setVectorDirAndUp [
			[_doorBasis,[_selectionBasis,_faceBasis select 0] call doorLock_transformVector] call doorLock_transformVector,
			[_doorBasis,_normal] call doorLock_transformVector
		];
	} foreach [1,-1];
};

doorLock_onUpdate = {
	private _door = _this select 0;
	if isNullReference(_door) exitWith {stopThisUpdate()};
	private _meshes = _door getVariable ["doorLockMeshes",[]];
	if (count _meshes != 2 || {_meshes findIf {isNullReference(_x)} != -1}) exitWith {
		[_door] call doorLock_clearVisuals;
	};
	[_door] call doorLock_syncVisuals;
};

doorLock_updateVisuals = {
	params ["_door","_data",["_startUpdater",true]];
	if ((_door getVariable ["doorLockVisualData",[]]) isEqualTo _data) exitWith {
		[_door] call doorLock_syncVisuals;
		if (_startUpdater && {_door getVariable ["doorLockUpdate",-1] == -1}) then {
			_door setVariable ["doorLockUpdate",startUpdateParams(doorLock_onUpdate,0,_door)];
		};
		_door getVariable ["doorLockMeshes",[]]
	};
	[_door] call doorLock_clearVisuals;
	_door setVariable ["doorLockVisualData",_data];
	if (count _data == 0) exitWith {[]};
	_data params ["_pointer","_model"];
	private _meshes = [];
	{
		private _mesh = createMesh([_model arg [0 arg 0 arg 0] arg true]);
		_mesh setVariable ["ref",_pointer];
		_mesh setVariable ["doorLockOwner",_door];
		_mesh disableCollisionWith _door;
		_mesh hideObject (_door getVariable ["doorLockVisualsHidden",false]);
		_meshes pushBack _mesh;
	} foreach [1,-1];
	_door setVariable ["doorLockMeshes",_meshes];
	[_door] call doorLock_syncVisuals;
	if (_startUpdater) then {
		_door setVariable ["doorLockUpdate",startUpdateParams(doorLock_onUpdate,0,_door)];
	};
	_meshes
};
