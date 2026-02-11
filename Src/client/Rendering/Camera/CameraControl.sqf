// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\..\host\engine.hpp>
#include <..\..\WidgetSystem\widgets.hpp>
#include <CameraControl.hpp>

#include <..\..\..\host\lang.hpp>

namespace(Rendering.Camera,cam_)

macro_const(cam_camTypeDinamic)
#define dynamicCamera "Land_HandyCam_F"
macro_const(cam_camTypeStatic)
#define staticCamera "camera"

decl(mesh(string))
cam_initCamera = {
	params ["_camType"];
	private _c = _camType createVehicleLocal [0,0,0]; 
	_c hideObject true; 
	_c
};

#define initCam(camtype) [camtype] call cam_initCamera

decl(bool)
cam_isEnabled = true;
decl(vector3)
cam_defaultPos = [-0.05,-0.05,0.12];
decl(mesh)
cam_lastPlayerObject = objNUll;
decl(float)
cam_updateDelay = 0;
decl(mesh)
cam_currentCamera = objNUll;

decl(mesh)
cam_object = initCam(dynamicCamera);
decl(mesh)
cam_fixedObject = initCam(staticCamera);
decl(mesh)
cam_currentCamera = cam_fixedObject;

decl(string)
cam_viewMode = "INTERNAL";

decl(void())
cam_setCameraOnPlayer = {
	cam_object attachTo [cam_lastPlayerObject, cam_defaultPos
	//simulate 3rd person
/*	#ifdef DEBUG
	vectorAdd [0,-1.6,-0.15]
	#endif*/
	,"head",true];
	cam_object setVectorUp [0,0,1];
	cam_currentCamera switchCamera cam_viewMode;

	//cam_fixedObject attachTo [cam_lastPlayerObject,[0,0,0],"head",false];

};

decl(bool)
cam_isNewCamera = false;

//Параметры для рендеринга. Нужны при отправке на сервер
decl(vector3)
cam_renderPos = [0,0,0]; //data in ATL coordinates
decl(vector3[])
cam_renderVec = [[0,0,0],[0,0,1]];
decl(vector3[])
cam_renderVecMouse = [[0,0,0],[0,0,1]]; //вектор направления мыши

decl(vector2)
cam_movingOffest = [0,0];

decl(vector2)
cam_camshakeDir = [0,0];//x,y
decl(vector3)
cam_camshakePos = [0,0,0];
decl(any[])
cam_camshake_tasks = []; //here adding tasks for shake
decl(void())
cam_camShake_resetAll = {
	cam_camshakeDir = [0,0];
	cam_camshakePos = [0,0,0];
	cam_camshake_tasks = [];
};
call cam_camShake_resetAll;

decl(void(float;float;float;float))
cam_addCamShake = {
	params ["_power","_powerDir","_freq","_duration"];

	cam_camshake_tasks pushBack [[
		pick[-1,1] * _power,
		pick[-1,1] * _power,
		pick[-1,1] * _power],[pick[_powerDir,-_powerDir],pick[_powerDir,-_powerDir]],tickTime+_duration,tickTime,tickTime,_freq,[0,0,0],[0,0]];
};

decl(void())
cam_camshake_onUpdate = {
	_xb = 0; _y = 0; _z = 0; _xdir = 0; _ydir = 0;



	_canDel = false;
	{
		_x params ["_pwr","_frq","_left","_addTime","_fDelta","_freq","_fromPwr","_fromORX"];
		_pwr params ["_px","_py","_pz"];
		_fromPwr params ["_fx","_fy","_fz"];
		_frq params ["_orx","_ory"];
		_fromORX params ["_forx","_fory"];

		if (tickTime >= _left) then {
			_canDel = true;
			cam_camshake_tasks set [_forEachIndex,objNull];
			continue;
		};

		if (tickTime >= (_fDelta + _freq)) then {
			_fDelta = tickTime;
			_x set [4,_fDelta];
			_fx = _px; _fy = _py; _fz = _pz;
			_x set [6,[_fx,_fy,_fz]];

			#define probInverse(val) (pick [-1,1]) * (val)
			_px = probInverse(_px);
			_py = probInverse(_py);
			_pz = probInverse(_pz);
			_x set [0,[_px,_py,_pz]];

			//change dir
			_forx = _orx; _fory = _ory;
			_x set [7,[_forx,_fory]];

			_orx = probInverse(_orx);
			_ory = probInverse(_ory);
			if equals(_frq,vec2(_orx,_ory)) then {
				if prob(50) then {_orx = -1*_orx} else {_ory = -1*_ory};
			};
			_x set [1,[_orx,_ory]];

			/*if ((_fDelta+_freq) > (_left)) then {
				error("TRACED");
				_x set [0,[0,0,0]];
				_x set [1,[0,0]];_px = 0;_py = 0;_pz = 0; _orx = 0; _ory = 0;
			};*/
		};

		//linearConversion [minFrom, maxFrom, value, minTo, maxTo]
		inline_macro
		#define convset(var) _conv = if (var > 0) then { \
			linearConversion [_fDelta, _fDelta + _freq, tickTime, var, 0] \
		} else { \
			linearConversion [_fDelta, _fDelta + _freq, tickTime, 0, var] \
			}; var = _conv

		//Процентное соотношение когда движение начнет затухать: меньше знач. раньше начнет -V
		inline_macro
		#define convsetFuller(var) _conv = linearConversion [_addTime, _left, tickTime, var*70/100, 0]; var = _conv

		inline_macro
		#define convset(var,svar) _conv = linearConversion [_fDelta, _fDelta + _freq, tickTime, svar, var]; var = _conv

		//traceformat("DELTA %1 %2",_conv arg [args2( _fx, _px)]);
		convset(_px,_fx);
		convset(_py,_fy);
		convset(_pz,_fz);

			// Добавим плавное затухание на полоску
			convsetFuller(_px);
			convsetFuller(_py);
			convsetFuller(_pz);

		convset(_orx,_forx);
		convset(_ory,_fory);

			convsetFuller(_orx);
			convsetFuller(_ory);

		_xb = _xb + _px;
		_y = _y + _py;
		_z = _z + _pz;

		_xdir = _xdir + _orx;
		_ydir = _ydir + _ory;


	} foreach cam_camshake_tasks;

	if (_canDel) then {
		cam_camshake_tasks = cam_camshake_tasks - [objNull];
	};

	if ([player] call smd_isSitting) then {
		(call mouseGetPosition)params["_precX","_precY"];
		modvar(_xdir) + (cam_movingOffest select 0);
		modvar(_ydir) + (cam_movingOffest select 1);
		if ([player] call smd_isLyingOnBed) then {
			modvar(_xdir) + -180;
			modvar(_ydir) + 0;
		};
	};

	cam_camshakePos = [_xb,_y,_z];
	cam_camshakeDir = [_xdir,_ydir];

};

decl(int)
cam_camShake_internal_handler = -1;

decl(void())
cam_updateCameraRotation = {
	//_vecUp = vectorUpVisual cam_fixedObject;
	//_vecUp = _vecUp vectorMultiply -1; //invert

	if (true) exitWith {
		_isArcadeMode = false;
		_lamp = cam_fixedObject;
		_unit = player;
		_cameraVector = getCameraViewDirection _unit;//(if (!cam_isNewCamera) then {_unit} else {cam_object}); //z offset
		_offsetVector = [0,0.06,0.01];

		_dir = if(_isArcadeMode) then
		{
			[0,0,0] getdir _cameraVector;
		} else {
			if (!cam_isNewCamera) then {
			[0,0,0] getdir (eyeDirection _unit);
			} else {
			[0,0,0] getdir (vectorDirVisual cam_object)
			};
		};


		_pitch = (_cameraVector select 2) * 90;

		cam_camshakeDir params ["_x","_y"];
		MOD(_dir, + _x);
		MOD(_pitch, + _y);

		_vuz = cos _pitch;

		_oldPos = if (!cam_isNewCamera) then {AGLToASL(_unit modelToWorldVisual ((_unit selectionPosition "head")vectoradd[-0.06,0.1,0.0889]))/*eyePos _unit*/} else {getPosASLVisual cam_object};

		_offsetVector = _offsetVector vectorAdd cam_camshakePos;
		
		_rvec = [ [(sin _dir) * _vuz,(cos _dir) * _vuz,sin _pitch], [0,0,_vuz] ];
		_rpos = ((_oldPos) vectorAdd [
			((_offsetVector select 0) * cos _dir) + ((_offsetVector select 1) * sin _dir),
		   	(((_offsetVector select 1) * cos _dir) - (_offsetVector select 0) * sin _dir),
		   	_offsetVector select 2
			]);
		
		//save pos
		cam_renderPos = ASLToATL _rpos;
		cam_renderVec = _rvec;
		//calculate mouse vector
		_mousepos = screenToWorld getMousePosition;
		_i = lineIntersectsSurfaces [_rpos,AGLToASL _mousepos,_unit,_lamp,true,5,"VIEW","NONE"];
		//мы получили вектор направления для мыши. Если луч не прокнул то 
		cam_renderVecMouse = [
			if(count _i > 0)then {
				vectorNormalized ((ASLToATL(_i select 0 select 0)) vectorDiff cam_renderPos)
			}else{
				_rvec select 0
			}
			,
			_rvec select 1
		];
		
		_lamp setVectorDirAndUp _rvec;
		_lamp setPosASL _rpos;
		
		/*_lamp setVectorDirAndUp [ [(sin _dir) * _vuz,(cos _dir) * _vuz,sin _pitch], [0,0,_vuz] ];
		_lamp setPosASL ((_oldPos) vectorAdd [
			((_offsetVector select 0) * cos _dir) + ((_offsetVector select 1) * sin _dir),
		   	(((_offsetVector select 1) * cos _dir) - (_offsetVector select 0) * sin _dir),
		   	_offsetVector select 2
			]);*/
		
	};

	//#define conversion(data) linearConversion [0,1,data,] OR vectorLinearConversion
	inline_macro
	#define invertNum(val) -(val)
	//not invert: value / 2

	//TODO test setVectorUp [0,0,1]
	//cam_object setVectorUp [invertNum(_vecUp select 0),invertNum(_vecUp select 1),_vecUp select 2];

	//taken from a3 headlamps mod (for testing only)
/*	if (false) then {
		_isArcadeMode = false;
		_lamp = cam_object;
		_unit = player;
		_cameraVector = getCameraViewDirection _unit;
		_offsetVector = [0,0.06,0.01];

		_dir = if(_isArcadeMode) then
		{
			[0,0,0] getdir _cameraVector;
		} else {
			[0,0,0] getdir (eyeDirection _unit);
		};

		_pitch = (_cameraVector select 2) * 90;

		_vuz = cos _pitch;
		_lamp setVectorDirAndUp [ [(sin _dir) * _vuz,(cos _dir) * _vuz,sin _pitch], [0,0,_vuz] ];

		private _vdir = [0,0,0] getdir (eyeDirection _unit);
		_lamp setPosASL ((eyePos _unit) vectorAdd [
			((_offsetVector select 0) * cos _vdir) + ((_offsetVector select 1) * sin _vdir),
		   	(((_offsetVector select 1) * cos _vdir) - (_offsetVector select 0) * sin _vdir),
		   	_offsetVector select 2
			]);
	};*/
};

decl(bool)
cam_internal_isEnabledBisCam = false;

decl(int)
cam_internal_handleOnFrame = -1;

decl(void())
cam_onFrame = {

	//sync cma view
	if (cameraView != cam_viewMode) then {
		cam_currentCamera switchCamera cam_viewMode;
	};


	//debuger camera
	if !isNull(BIS_fnc_camera_cam) then {
		if (!cam_internal_isEnabledBisCam) then {
			cam_internal_isEnabledBisCam = true;
			//set settings (init render)
			call render_hdr_init;
			[false] call setVisibleHUD;

			private __onChangeHud = true;
			[player,"onChangeFace",true] call smd_syncVar;
		}
	} else {
		if (cam_internal_isEnabledBisCam) then {
			call render_hdr_init;
			[true] call setVisibleHUD;

			[player,"onChangeFace",true] call smd_syncVar;
			cam_internal_isEnabledBisCam = false;
		}
	};

	if not_equals(player,cam_lastPlayerObject) then {
		cam_lastPlayerObject = player;
		call cam_setCameraOnPlayer;
	};

	call cam_updateCameraRotation;
};

decl(void(int;bool))
cam_setCameraSetting = {
	params ["_camSetting",["_applyToVar",true]];

	if (_applyToVar) then {
		cd_cameraSetting = _camSetting;
	};

	if (_camSetting != CAMERA_MODE_ARCADE && _camSetting != CAMERA_MODE_REALISTIC) exitWith {

	};

	if (_camSetting == CAMERA_MODE_ARCADE) exitWith {
		cam_fixedObject switchCamera "Internal";
		cam_currentCamera = cam_fixedObject;
	};
	if (_camSetting == CAMERA_MODE_REALISTIC) exitWith {
		cam_object switchCamera "Internal";
		cam_currentCamera = cam_object;
	};

};

if (cam_isEnabled) then {
	cam_internal_handleOnFrame = startUpdate(cam_onFrame,cam_updateDelay);

	cam_camShake_internal_handler = startUpdate(cam_camshake_onUpdate,0);
	(findDisplay 46) displayAddEventHandler ["MouseMoving",{
		params ["_d","_x","_y"];
		if ([player] call smd_isSitting) then {
			if isDisplayOpen exitWith {};
			_oldv = cam_movingOffest;
			cam_movingOffest =[clamp((_oldv select 0)+_x,-90,90),clamp((_oldv select 1)+-_y,-90,90)];
		} else {
			cam_movingOffest = [0,0];
		};
	}];
};
