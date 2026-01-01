// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================



#define SI_DEBUG_TRACELINE

#ifdef SI_DEBUG_TRACELINE
if !isNull(si_debug_tracelineobjs) then {{deleteVehicle _x}foreach si_debug_tracelineobjs};
si_debug_tracelineobjs = [];

#endif



//Алгоритм не подходит
si_makeline = {
	params ["_m","_distance","_precdown","_ld"];
	private _basepos = (ASLToAGL eyepos _m);
	_basepos = ASLToATL cam_debug_prerenderPos;
	private _vd = cam_debug_prerendervec select 0;
	
	private _endpos = _basepos vectorAdd (_vd vectorMultiply _distance);
	//_endpos = _endpos vectoradd[0,0,(getCameraViewDirection _m select 0)];
	//_midpos = positionCameraToWorld[0,_ld,_distance*_precdown/100];
	si_debug_obj setposatl (ASLToATL cam_debug_prerenderPos);
	si_debug_obj setVectorDirAndUp cam_debug_prerenderVec;
	private _midpos = si_debug_obj modelToWorld [0,_distance*_precdown/100,_ld];
	
	_endpos set [2,(_endpos select 2)/_precdown];
	warningformat("MIDPOS WORLD %1",_midpos);
	#ifdef SI_DEBUG_TRACELINE
	private _poses = [_basepos,_midpos,_endpos];
	errorformat("POSES %1",_poses);
	private _createobj = {
		___o = "Sign_Sphere10cm_F" createVehicleLocal[0,0,0];
		___o setObjectTexture [0,"#(rgb,8,8,3)color(1,0,0,1)"];
		___o setPosAtl _this;
		___o
	};
	for "_i" from 1 to _distance do {
		
		_interval = linearConversion [1,_distance, _i, 0, 1];
		si_debug_tracelineobjs pushBack ((_interval bezierInterpolation _poses) call _createobj);
	};
	#endif
};

#ifdef EDITOR

si_debug_throwDebug = {
	
};

//DEPRECATED
si_debug_tester_internal = {
	
	log("---------- firts pass -----------");
	_a = positionCameraToWorld [0,0,1];
	_b = (ASLToATL cam_debug_prerenderPos) vectorAdd (cam_debug_prerenderVec select 0 vectorMultiply 1);
	logformat("%2		A:%1%2		B:%3",_a arg endl arg _b);
	//assert(equals(_a,_b));
	
	_a = positionCameraToWorld [0,0,3.456];
	_b = (ASLToATL cam_debug_prerenderPos) vectorAdd (cam_debug_prerenderVec select 0 vectorMultiply 3.456);
	logformat("%2		A:%1%2		B:%3",_a arg endl arg _b);
	//assert(equals(_a,_b));
	
	_a = positionCameraToWorld [0,1,0] select 0;
	
	_dir = [0,0,0] getdir (getCameraViewDirection player);//[0,0,0] getdir (vectorDirVisual cam_object);
	_offsetVector = [(0* cos _dir)+(1*sin _dir),(1*cos _dir) - (0 * sin _dir),0];
	_b = ((ASLToATL cam_debug_prerenderPos) vectorAdd [
		((_offsetVector select 0) * cos _dir) + ((_offsetVector select 1) * sin _dir),
		(((_offsetVector select 1) * cos _dir) - (_offsetVector select 0) * sin _dir),
		_offsetVector select 2
		]);
	_a = positionCameraToWorld [0,5,0];
	
	
	si_debug_obj setposatl (ASLToATL cam_debug_prerenderPos);
	si_debug_obj setVectorDirAndUp cam_debug_prerenderVec;
	_b = si_debug_obj modelToWorld [0,0,5];
	
	//_b = (ASLToATL cam_debug_prerenderPos) vectorAdd (cam_debug_prerenderVec select 0 vectorMultiply 1);
	logformat("%2		A:%1%2		B:%3",_a arg endl arg _b);
	assert(equals(_a,_b));
	
	log("---------- TESTS ENDED -----------");
};

if !isNull(si_debug_obj) then {
	deleteVehicle si_debug_obj;
};
si_debug_obj = createSimpleObject ["Sign_Sphere10cm_F",[0,0,0],true];
si_debug_task = -1;

if (!isNull(si_debug_olist)) then {
	{deleteVehicle _x} foreach si_debug_olist;
};
si_debug_olist = [];

si_debug_interptest = {
	params ["_sp","_ep",["_maxheight",10]];
	_createobj = {
		___o = "Sign_Sphere10cm_F" createVehicleLocal[0,0,0];
		___o setPosAtl _this;
		___o
	};
	//bezierInterpolation
	
	_startPos = _sp;//ASLToATL eyepos player;
	_endPos = _ep;
	_distance = _sp distance _ep;
	_direction = [_startPos,_endPos] call BIS_fnc_dirTo;
	_betweenPosition = ([_startPos, (_distance/2),_direction] call BIS_fnc_relPos) vectorAdd [0,0,_maxheight];
	for "_i" from 1 to 50 do {
		_interval = linearConversion [1,50, _i, 0, 1];
		si_debug_olist pushBack ((_interval bezierInterpolation [_startPos,_betweenPosition,_endPos]) call _createobj);
	};
};

si_debug_projectile = {
	params ["_basepos","_vectordrect","_distance","_precdown","_ld"];
	
	//use  _endV = (_beg vectorAdd (getCameraViewDirection bob vectorMultiply 100)); 

	
	_basepos = positionCameraToWorld[0,0,0];
	_vectordrect = positionCameraToWorld[0,0,_distance];
	
	_createobj = {
		___o = "Sign_Sphere10cm_F" createVehicleLocal[0,0,0];
		___o setPosAtl _this;
		___o
	};
	_direction = [_basepos,_vectordrect] call BIS_fnc_dirTo;
	_endpos = _vectordrect;//[_basepos,_distance,_direction] call BIS_fnc_relPos;
	//OBSOLETE DATA _midpos = ([_basepos,_distance*_precdown/100,_direction] call BIS_fnc_relPos) vectorAdd [0,0,_ld];
	_endpos set [2,(_vectordrect select 2)/_precdown];
	_midpos = positionCameraToWorld[0,_ld,_distance*_precdown/100];
	_poses = [_basepos,_midpos,_endpos];
	trace(str _poses + " > " + str _direction)
	warningformat("MIDPOS RENDER %1",_midpos);
	for "_i" from 1 to _distance do {
		_interval = linearConversion [1,_distance, _i, 0, 1];
		si_debug_olist pushBack ((_interval bezierInterpolation _poses) call _createobj);
	};
};

si_debug_testCamerapos = {
	private _pos = ASLToATL (eyePos player);
	_nl = [];
	{deleteVehicle _x} foreach (player getVariable ["sidtc",[]]);
	_fp = _pos vectorDiff (_pos vectorFromTo  (getCameraViewDirection player));
	_sp = positionCameraToWorld [0,0,1];
	
	_createobj = {
		___o = "Sign_Sphere10cm_F" createVehicleLocal[0,0,0];
		___o setPosAtl _this;
		warning(str _this);
		___o setObjectTexture [0,format["#(rgb,8,8,3)color(0,1,%1,1)",_forEachIndex]];
		___o
	};
	
	{
		_nl pushBack (_x call _createobj);
	} foreach [_fp,_sp];
	
	
	player setVariable ["sidtc",_nl];
};

si_debug_mousepostest = {
	_createobj = {
		___o = "Sign_Sphere10cm_F" createVehicleLocal[0,0,0];
		___o setPosAtl _this;
		___o
	};
	_pos = cam_renderPos;
	_model = "relicta_models\models\weapons\melee\axehandmade1\axehandmade1.p3d";
	_mousepos = screenToWorld getMousePosition;
	private _itsc = lineIntersectsSurfaces [ATLToASL _pos,AGLToASL _mousepos,player,objNull,true,5,"VIEW","NONE"];
	if (count _itsc == 0) exitWith {};
	_posto = ASLToATL(_itsc select 0 select 0);
	si_debug_obj setposatl _posto;
	//мы получили вектор для мыши
	si_debug_vec = vectorNormalized (_posto vectorDiff _pos);
};

//de_params = [ "relicta_models\models\weapons\melee\axehandmade1\axehandmade1.p3d", cam_renderPos,cam_renderVec, 20,50,2, 1.3 ];

//ACTUAL
si_debug_createthrowtask = {
	params ["_model","_vecPos","_vecDir","_distance","_precdown","_leveldown","_duration"];
	
	private _o = createSimpleObject [_model,[0,0,0],true];
	_o setPosAtl _vecPos;
	_o setVectorDirAndUp _vecDir;
	
	//_o setVariable ["vec_1",+5];
	_o setVariable ["_startPoint",_o modelToWorld [0,0,0]];
	_o setVariable ["_midPoint",_o modelToWorld [0,_distance*_precdown/100,_leveldown]];
	private _ep = _o modelToWorld [0,_distance,0];
	MODARR(_ep,2,/_precdown); //lowerize. Prob use in modeltoworld
	_o setVariable ["_endPoint",_ep];
	_o setVariable ["_startTime",tickTime];
	
	private _task = {
		_ctx = (_this select 0);
		
		if (tickTime > (_ctx select 0)) exitWith {
			stopThisUpdate();
			deleteVehicle (_ctx select 1);
		};
		_o = _ctx select 1;
		_vc = _ctx select 2;
		MODARR(_vc,0, + 0);
		MODARR(_vc,1, - 20);
		MODARR(_vc,2, + 0);
		
		//MODARR(_vc,1,+ (_o getVariable "vec_1"));
		//if (abs(_vc select 1)>=79) then {
			//_o setVariable ["vec_1",-1*(_o getVariable "vec_1")];
		//};
		
		//[_o,_vc] call BIS_fnc_setObjectRotation;
		//_o setVectorDirAndUp ([_vc select 0,_vc select 1,_vc select 2] call si_debug_setpby);
		
		_list = [_o getVariable "_startPoint",_o getVariable "_midPoint",_o getVariable "_endPoint"];
		//_list = [_o getVariable "_startPoint"];
		_int = linearConversion [_o getVariable "_startTime",_ctx select 0,tickTime,0,1];
		
		_o setPosAtl (_int bezierInterpolation _list);
		[_o,[_vc select 1,_vc select 0,_vc select 2]] call fnc_SetPitchBankYaw;
		
	}; startUpdateParams(_task,0,[tickTime + _duration arg _o arg _vecDir select 0 arg vec3(random 360,random 360,random 360) ]);
	
};


	//common funcs
	si_debug_setpby = {
		private["_yaw","_pitch","_roll","_sinYaw","_cosYaw","_sinPitch","_cosPitch","_sinRoll","_cosRoll","_direction","_up"];
		_yaw = _this select 0;
		_pitch = _this select 1;
		_roll = _this select 2;
		_sinYaw = sin(_yaw);
		_cosYaw = cos(_yaw);
		_sinPitch = sin(_pitch);
		_cosPitch = cos(_pitch);
		_sinRoll = sin(_roll);
		_cosRoll = cos(_roll);
		_direction = 
		[
			_sinYaw * _cosRoll,
			_cosYaw * _cosRoll,
			_sinRoll
		];
		_up = 
		[
			_cosYaw * _sinRoll * _sinPitch,
			_sinYaw * _sinRoll * _sinPitch,
			_cosRoll * _cosPitch
		];
		[_direction, _up]
	};

#endif