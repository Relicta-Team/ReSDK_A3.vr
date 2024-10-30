// ======================================================
// Copyright (c) 2017-2024 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================
/*
	! THIS FILE NOT USABLE
	! Created just for experiments
*/
#include "..\..\host\Atmos\Atmos.hpp"
#include "NOEngineClient_NetAtmos.hpp"
#include "..\LightEngine\ScriptedEffects.hpp"

#define NET_ATMOS_OPTIMIZATION_RENDER

aopt_cli_enableSystem = false;

aopt_cli_nearZoneSize = 10;// всё что дальше этого расстояния будет процессится

aopt_cli_processedAreas = []; //массив процессируемых зон

aopt_cli_handler = -1;

aopt_cli_process = {
	private _obj = null;
	private _pos = null;
	private _usrPos = asltoatl eyepos player;
	private _usrDir = getCameraViewDirection player;
	private _nearPos = aopt_cli_nearZoneSize;
	private _dist = null;
	{
		{
			_block = _y select NAT_CHUNKDAT_OBJECT;
			//traceformat("pbase %1",_block callv(getEmitterRealPos) )
			if ((_block callv(getEmitterRealPos) distance _usrPos) <= _nearPos) then {
				_block callp(setHidden,false);
				continue;
			};
			_block callp(setHidden,true);
		} foreach (_x getv(chunks));

	} foreach aopt_cli_processedAreas;
};

aopt_cli_isBlocked = {
	params ["_camP","_camD","_bPos","_oPos"];
	private _tB = _bPos vectorDiff _camP;
	private _tO = _oPos vectorDiff _camP;

	private _tBNorm = vectorNormalized _tB;
	private _tONorm = vectorNormalized _tO;

	private _dot = _tBNorm vectorDotProduct _tONorm;
	private _angle = acos _dot;
	_angle < (3.14 / 2)
};

// aopt_cli_getNearFar = {
// 	private _usrPos = positionCameraToWorld [0, 0, 0];//asltoatl eyepos player;
// 	private _fov = call aopt_cli_getFOV;
// 	private _scrW = getResolution select 0;
// 	private _scrH = getResolution select 1;
// 	#define radians(x) (x * pi /180)
// 	private _near = (_usrPos select 2) - (_scrH/2)/ (tan(radians(_fov/2)));
// 	_near = _near max 0.1;
// 	private _far = (_usrPos select 2) + (_scrH/2)/ (tan(radians(_fov/2)));
// 	_far = _far max 1000;

// 	[_near,_far]
// };

// aopt_cli_getFOV = {
// 	([0.5, 0.5] distance2D worldToScreen positionCameraToWorld [0, 3, 4]) * (getResolution select 5) / 2
// };


if (aopt_cli_enableSystem) then {
	aopt_cli_handler = startUpdate(aopt_cli_process,0.1);
};