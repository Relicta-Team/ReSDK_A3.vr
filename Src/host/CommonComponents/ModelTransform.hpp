// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

model_convertPithBankYawToVec = { 
	/*"_object","_rotations",*/
	private ["_aroundX","_aroundY","_aroundZ","_dirX","_dirY","_dirZ","_upX","_upY","_upZ","_dir","_up","_dirXTemp","_upXTemp"];
/*	_object = _this select 0;
	_rotations = _this select 1;*/
	_aroundX = _this select 0;
	_aroundY = _this select 1;
	_aroundZ = (360 - (_this select 2)) - 360;
	_dirX = 0;
	_dirY = 1;
	_dirZ = 0;
	_upX = 0;
	_upY = 0;
	_upZ = 1;
	if (_aroundX != 0) then { 
		_dirY = cos _aroundX;
		_dirZ = sin _aroundX;
		_upY = -sin _aroundX;
		_upZ = cos _aroundX;
	};
	if (_aroundY != 0) then { 
		_dirX = _dirZ * sin _aroundY;
		_dirZ = _dirZ * cos _aroundY;
		_upX = _upZ * sin _aroundY;
		_upZ = _upZ * cos _aroundY;
	};
	if (_aroundZ != 0) then { 
		_dirXTemp = _dirX;
		_dirX = (_dirXTemp* cos _aroundZ) - (_dirY * sin _aroundZ);
		_dirY = (_dirY * cos _aroundZ) + (_dirXTemp * sin _aroundZ);
		_upXTemp = _upX;
		_upX = (_upXTemp * cos _aroundZ) - (_upY * sin _aroundZ);
		_upY = (_upY * cos _aroundZ) + (_upXTemp * sin _aroundZ);
	};
	/*_dir = [_dirX,_dirY,_dirZ];
	_up = [_upX,_upY,_upZ];*/
	[[_dirX,_dirY,_dirZ],[_upX,_upY,_upZ]];
};

//todo replace model_convertPithBankYawToVec with this
//optimized variant;
model_cnvPBYToVec_v2 = {
	params ["_aroundX","_aroundY","_aroundZ"];
	_aroundZ = (360 - _aroundZ) - 360;
	private _dirX = 0;
	private _dirY = 1;
	private _dirZ = 0;
	private _upX = 0;
	private _upY = 0;
	private _upZ = 1;
	if (_aroundX != 0) then { 
		_dirY = cos _aroundX;
		_dirZ = sin _aroundX;
		_upY = -sin _aroundX;
		_upZ = cos _aroundX;
	};
	if (_aroundY != 0) then { 
		_dirX = _dirZ * sin _aroundY;
		_dirZ = _dirZ * cos _aroundY;
		_upX = _upZ * sin _aroundY;
		_upZ = _upZ * cos _aroundY;
	};
	if (_aroundZ != 0) then { 
		private _dirXTemp = _dirX;
		_dirX = (_dirXTemp* cos _aroundZ) - (_dirY * sin _aroundZ);
		_dirY = (_dirY * cos _aroundZ) + (_dirXTemp * sin _aroundZ);
		private _upXTemp = _upX;
		_upX = (_upXTemp * cos _aroundZ) - (_upY * sin _aroundZ);
		_upY = (_upY * cos _aroundZ) + (_upXTemp * sin _aroundZ);
	};
	
	[[_dirX,_dirY,_dirZ],[_upX,_upY,_upZ]];
};

model_SetPitchBankYaw = {
	params ["_object","_data"];
	(_data call model_convertPithBankYawToVec) params ["_dir","_up"];
	_object setVectorDirAndUp [_dir,_up];
};

model_getPitchBankYaw = {
	params ["_vehicle"];
	(_vehicle call BIS_fnc_getPitchBank) + [getDir _vehicle]
};

model_getPitchBankYawAccurate = {
    private _v = _this select 0;

    private _y = vectorDir _v;
    private _z = vectorUp _v;
    private _x1 = _y vectorCrossProduct _z;

    private _ay = -asin(_z select 0);
    private _az = (_y select 0) atan2 (_x1 select 0);
    private _ax = (_z select 1) atan2 (_z select 2);
    [_ax, _ay, _az]
};

//проверяет является ли направление безопасным
model_isSafedirTransform = {
	params ["_vdu_dir",["_fromVUP",false]];
	if equalTypes(_vdu_dir,0) then {
		true
	} else {
		if (_fromVUP) exitWith {
			equals(_vdu_dir apply {((abs _x) toFixed 1)},vec3("0.0","0.0","1.0"))
		};
		//conv to vec-coords
		if (count _vdu_dir == 3) then {
			_vdu_dir = _vdu_dir call model_convertPithBankYawToVec;
		};
		_vdu_dir params ["_vdr","_vup"];
		equals(_vup apply {((abs _x) toFixed 1)},vec3("0.0","0.0","1.0"))
	};
	
};

model_isPosInsideBBX = {
	params ["_pos","_obj"];	
	private _relPos = _obj worldToModel _pos;
	private _boundingBox = boundingBox _obj;

	private _min = _boundingBox select 0;
	private _max = _boundingBox select 1;

	_relPos params ["_myX","_myY","_myZ"];
	private _inside = false;
	if ((_myX > (_min select 0)) and (_myX < (_max select 0))) then {
		if ((_myY > (_min select 1)) and (_myY < (_max select 1))) then {
			if ((_myZ > (_min select 2)) and (_myZ < (_max select 2))) then {
				_inside = true;
			};
		};
	};

	_inside
};