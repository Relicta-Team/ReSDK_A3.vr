// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include "..\engine.hpp"
#include "..\oop.hpp"
#include "..\struct.hpp"
#include "..\text.hpp"
#include "..\thread.hpp"

// camera control
sp_cam_cinematicCam = objNull;
sp_cam_internal_bufferCamData = [];

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
	params ["_mode",["_recreate",true]];
	if (_mode) then {
		if (call sp_cam_isCreated && _recreate) then {
			deletevehicle sp_cam_cinematicCam;
		};
		if (_recreate) then {
			call sp_cam_createCinematicCam;
		};
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
	private _cpar = _this;
	if (canSuspend) exitWith {
		{
			_cpar call sp_cam_prepCamera;
		} call sp_threadCriticalSection;
	};
	_cpar = array_copy(_cpar);
	private _cam = sp_cam_cinematicCam;
	//["vr",[3932.76,3981.64,10.3934],309.069,0.75,[-12.2237,0],0,0,3.71942,0,0,1,0,1]
	_cpar deleteAt 0;
	private _pos =		_cpar select 0;
	private _dir =		_cpar select 1;
	private _fov =		_cpar select 2;
	private _pitchbank =	_cpar select 3;
	private _focus =	_cpar select 4;


	_pitchbank params ["_pitch","_bank"];

	[_pos] call sp_cam_setCamPos;
	_cam setdir _dir;

	[
		_cam,
		_pitch,
		_bank
	] call bis_fnc_setpitchbank;
	
	[_fov] call sp_cam_setFov;

	sp_cam_internal_bufferCamData = ["vr",_pos,_dir,_fov,_pitchbank];
};

sp_cam_interp_internal_mapCamData = createHashMapFromArray [
	["pos",1],
	["dir",2],
	["fov",3],
	["pitchbank",4]
];
sp_cam_interp_internal_orderCommands = [
	"pos","dir","pitchbank","fov"
];

sp_cam_interpTo = {
	params ["_mode","_to",["_time",1]];

	private _from = array_copy(sp_cam_internal_bufferCamData);
	[_mode,_from,_to,_time] call sp_cam_interpCam;
};

sp_cam_interpCam = {
	params ["_mode","_from","_to",["_time",1]];

	if (_mode != "all") then {
		if (equalTypes(_from,[]) && {equals(_from select 0,"vr")}) then {
			_from = _from select (sp_cam_interp_internal_mapCamData get _mode);
		};
		if (equalTypes(_to,[]) && {equals(_to select 0,"vr")}) then {
			_to = _to select (sp_cam_interp_internal_mapCamData get _mode);
		};
	};

	_interpData = {
		(_this select 0) params ["_ctx","_pars","_cancelToken"];
		_ctx params ["_start","_end"];
		
		//external terminate
		if (refget(_cancelToken)) exitWith {
			stopThisUpdate();
		};

		//normal terminate
		if (tickTime >= _end) exitWith {
			stopThisUpdate();
			refset(_cancelToken,true);
			sp_cam_internal_map_allUpdatesCancelToken deleteAt thisUpdate;
		};

		_pars params ["_mode","_from","_to"];

		_modeHandler = {
			if (_mode == "pos") exitwith {
				_val = vectorLinearConversion [_start,_end,tickTime,_from,_to,true];
				[_val] call sp_cam_setCamPos;
				sp_cam_internal_bufferCamData set [sp_cam_interp_internal_mapCamData get _mode,_val];
				//if equals(_val,_to) then {stopThisUpdate()};
			};
			if (_mode == "fov") exitwith {
				// if (_to < _from) then {
				// 	swap_lvars(_to,_from);
				// };
				_val = linearConversion [_start,_end,tickTime,_from,_to,true];
				//if (_from == _to) then {_val = _from};
				[_val] call sp_cam_setFov;
				sp_cam_internal_bufferCamData set [sp_cam_interp_internal_mapCamData get _mode,_val];
				//if equals(_val,_to) then {stopThisUpdate()};
			};
			if (_mode == "dir") exitwith {
				if (_to < _from) then {
					//swap_lvars(_to,_from);
				};
				
				//_dir = linearConversion [_start,_end,tickTime,_from,_to,true];

				//улучшенное вращение
				_angleDiff = (_to - _from + 540) % 360 - 180; // -180..180
				_progressNormalized = linearConversion [_start, _end, tickTime, 0, 1, true];
				_dir = _from + (_angleDiff * _progressNormalized);

				sp_cam_cinematicCam setdir _dir;
				sp_cam_internal_bufferCamData set [sp_cam_interp_internal_mapCamData get _mode,_dir];
			};
			if (_mode == "pitchbank") exitwith {
				
				_from params ["_pf","_bf"];
				_to params ["_pt","_bt"];

				_pitch = linearConversion [_start,_end,tickTime,_pf,_pt,true];
				_bank = linearConversion [_start,_end,tickTime,_bf,_bt,true];
				[
					sp_cam_cinematicCam,
					_pitch,
					_bank
				] call bis_fnc_setpitchbank;
				sp_cam_internal_bufferCamData set [sp_cam_interp_internal_mapCamData get _mode,[_pitch,_bank]];
			};
		};

		if (_mode == "all") exitWith {
			_fromOrig = _from;
			_toOrig = _to;
			_mapIndex = sp_cam_interp_internal_mapCamData;
			{
				private _mode = _x;
				private _curIndex = _mapIndex get _mode;
				private _from = _fromOrig select _curIndex;
				private _to = _toOrig select _curIndex;
				call _modeHandler;
			} foreach sp_cam_interp_internal_orderCommands;
		};

		call _modeHandler;

		
	};

	private _cancelToken = refcreate(false);
	private _args = [
		[tickTime,tickTime+_time],
		[_mode,_from,_to],
		_cancelToken
	];
	private _updHandle = startUpdateParams(_interpData,0,_args);
	
	sp_cam_internal_map_allUpdatesCancelToken set [_updHandle,_cancelToken];

	_updHandle
};

sp_cam_stopAllInterp = {
	{
		{
			refset(_y,true);
			sp_cam_internal_map_allUpdatesCancelToken deleteat _x;
		} foreach sp_cam_internal_map_allUpdatesCancelToken;
		
	} call sp_threadCriticalSection;
};

sp_cam_internal_map_allUpdatesCancelToken = createHashMap;