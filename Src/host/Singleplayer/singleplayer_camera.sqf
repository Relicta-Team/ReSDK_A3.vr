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