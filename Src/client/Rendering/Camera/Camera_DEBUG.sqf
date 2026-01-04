// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\..\host\engine.hpp>
#include <CameraControl.hpp>

/*
	!FOR DEBUG ONLY
	!DO NOT INCLUDE THIS FILE IN CLIENTSIDE

*/

cam_camShake_resetAll = {
	cam_camshakeDir = [0,0];
	cam_camshakePos = [0,0,0];
	cam_camshake_tasks = [];
};	
call cam_camShake_resetAll;

cam_addCamShake = {
	params ["_power","_powerDir","_freq","_duration"];
	
	cam_camshake_tasks pushBack [[
		pick[-1,1] * _power,
		pick[-1,1] * _power,
		pick[-1,1] * _power],[_powerDir,_powerDir],tickTime+_duration,tickTime,tickTime,_freq,[0,0,0],[0,0]];
};

stopUpdate(cam_camShake_internal_handler);
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
		#define convset(var) _conv = if (var > 0) then { \
			linearConversion [_fDelta, _fDelta + _freq, tickTime, var, 0] \
		} else { \
			linearConversion [_fDelta, _fDelta + _freq, tickTime, 0, var] \
			}; var = _conv
			
		#define convsetFuller(var) _conv = linearConversion [_addTime, _left, tickTime, var*70/100, 0]; var = _conv
		
		#define convset(var,svar) _conv = linearConversion [_fDelta, _fDelta + _freq, tickTime, svar, var]; var = _conv
		
		traceformat("DELTA %1 %2",_conv arg [args2( _fx, _px)]);
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
	
	cam_camshakePos = [_xb,_y,_z];
	cam_camshakeDir = [_xdir,_ydir];	
	
};
cam_camShake_internal_handler = startUpdate(cam_camshake_onUpdate,0);