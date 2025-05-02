// ======================================================
// Copyright (c) 2017-2025 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

// camera control
sp_cam_cinematicCam = objNull;

sp_cam_createCinematicCam = {
	private _cam = "camera" createVehicleLocal [0,0,0];//camcreate [0,0,0];
	_cam cameraeffect ["internal","back"];
	_cam campreparefov 0.7;
	_cam campreparefocus [-1,-1];
	_cam camcommitprepared 0;
	_cam enablesimulation true;
	showcinemaborder false;
	sp_cam_cinematicCam = _cam;
};

sp_cam_isCreated = {
	!isNullReference(sp_cam_cinematicCam);
};

sp_cam_setCamPos = {
	params ["_pos"];
	sp_cam_cinematicCam setposatl _pos;

	player setposatl [_pos select 0,_pos select 1,0];
};

sp_cam_setCinematicCam = {
	params ["_mode"];
	if (_mode) then {
		sp_cam_cinematicCam switchCamera "Internal";
	} else {
		cam_currentCamera cameraEffect ["terminate","back"];
		cam_currentCamera switchCamera cam_viewMode;
	};
};

sp_cam_setTargetPos = {
	params ["_pos"];
	sp_cam_cinematicCam campreparetarget (_pos);
	sp_cam_cinematicCam camcommitprepared 0;
};

sp_cam_resetTargetPos = {
	[objNull] call sp_cam_setTargetPos;
};

sp_cam_setFov = {
	params ["_fov"];
	sp_cam_cinematicCam campreparefov _fov;
	sp_cam_cinematicCam camcommitprepared 0;
};

sp_cam_prepCamera = {
	_cpar = _this;

	private _cam = sp_cam_cinematicCam;
	//["vr",[3932.76,3981.64,10.3934],309.069,0.75,[-12.2237,0],0,0,3.71942,0,0,1,0,1]
	_cpar deleteAt 0;
	private _pos =		_cpar select 0;
	private _dir =		_cpar select 1;
	private _fov =		_cpar select 2;
	private _pitchbank =	_cpar select 3;
	private _focus =	_cpar select 4;

	[_fov] call sp_cam_setFov;

	_pitchbank params ["_pitch","_bank"];

	[_pos] call sp_cam_setCamPos;
	_cam setdir _dir;

	[
		_cam,
		_pitch,
		_bank
	] call bis_fnc_setpitchbank;
};

sp_cam_interpCam = {
	params ["_mode","_from","_to",["_time",1]];
	_interpData = {
		(_this select 0) params ["_ctx","_pars"];
		_ctx params ["_start","_end"];
		_pars params ["_mode","_from","_to"];
		if (_mode == "pos") exitwith {
			_val = vectorLinearConversion [_start,_end,tickTime,_from,_to,true];
			[_val] call sp_cam_setCamPos;
			if equals(_val,_to) then {stopThisUpdate()};
		};
		if (_mode == "fov") exitwith {
			_val = linearConversion [_start,_end,tickTime,_from,_to,true];
			[_val] call sp_cam_setFov;
			if equals(_val,_to) then {stopThisUpdate()};
		};
	};
	private _args = [
		[tickTime,tickTime+_time],
		[_mode,_from,_to]
	];
	startUpdateParams(_interpData,0,_args);
};