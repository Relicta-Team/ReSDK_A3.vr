// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================


rc_list = [vec2(-1,1),vec2(1,1), //upper left, upper right
vec2(-1,-1),vec2(1,-1)]; //lower left, lower right

rc_modelPath = "a3\structures_f_epa\items\food\canteen_f.p3d";

rc_listObject = [];

rc_forwardDistance = 5;

rc_multiplyBias = 0.005;

rc_updateVec4PosPerFrame = 0;

rc_3dCursor = "Sign_Arrow_F" createVehicle [0,0,0];

rc_init = {
	{
		_obj = createSimpleObject [rc_modelPath,[0,0,0]];
		_camObject = cameraOn;
		_obj attachTo [_camObject,[0,rc_forwardDistance,0]];

		_obj setvariable ["direction",_x];
		_obj setvariable ["curVal",vec2(0,0)];

		rc_listObject pushBack _obj;
	} foreach rc_list;

	//eachframe checking
	_onUpdate = {
		(_this select 0) params ["_idx"];
		_object = rc_listObject select _idx;

		(_object getvariable "direction")params ["_x","_y"];

		_curValue = _object getvariable "curVal";
		_prevRelativePos = +_curValue;
		MODARR(_curValue,0,+ _x * rc_multiplyBias);
		MODARR(_curValue,1,+ _y * rc_multiplyBias);

		_camObject = player;
		_attpos = [_curValue select 0,rc_forwardDistance,_curValue select 1];
		traceformat("trying attach %1 to %2",_object arg _attpos)
		_object attachTo [_camObject,_attpos,"head",true];
		
		_pos = getPosATL _object;
		((worldToScreen _pos) call convertScreenCoords) params ["_unprojX","_unprojY"];

		traceformat("wpos %1 -> %2",_object arg vec2(_unprojX,_unprojY));

		if (_unprojX < 0 || _unprojX > 100 || _unprojY < 0 || _unprojY > 100) exitWith {
			_object setVariable ["curVal",_prevRelativePos];
			_object attachTo [_camObject,[_prevRelativePos select 0,rc_forwardDistance,_prevRelativePos select 1],"head",true];
			warningformat("Calculating for %1 item done",_idx);

			if (_idx == 3) then {warning("ALL CALCLUATE DONE")};

			stopThisUpdate();
		};

		_object setVariable ["curVal",_curValue];
		traceformat("update value for object %1 -> %2",_object arg _curValue);
	};

	{startUpdateParams(_onUpdate,rc_updateVec4PosPerFrame,[_forEachIndex])} foreach rc_listObject;

};


rc_getConvertedPos = {
	(call mouseGetPosition) params ["_xPos","_yPos"];

	// ret vec2 relative pos from camera
	#define getPosObjFromList(idx) ((rc_listObject select idx) getVariable "curVal")
	_upLeft = getPosObjFromList(0); //[-1,1]
	_upRight = getPosObjFromList(1);//[1,1]
	_downLeft = getPosObjFromList(2);//[-1,-1]
	_downRight = getPosObjFromList(3);//[1,-1]


	//left: 3871ul - 0
	//mid: x(ul) - ~53
	//right: 3879ul - 100

	_newX = (_downRight select 0) * _xPos / 100;
	_newZ = (_downRight select 1) * _yPos / 100;

	_camObject = cameraOn;
	rc_3dCursor attachTo [_camObject,[_newX,rc_forwardDistance,_newZ]];
};

needchange = false;
newvalue = 1;
vecbias = [0,0,0];
_uc = {
	if (needchange) exitWith {
		changeThisUpdateTime(newvalue)
	};
	if !isNullReference(obj) then {
		player attachto [obj,vecbias];
	};
	detach player;
	

}; startUpdate(_uc,0.1);