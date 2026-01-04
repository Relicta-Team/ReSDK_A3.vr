// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include "..\..\host\lang.hpp"

namespace(InteractGrab,interact_grab_)

macro_const(interact_grab_update_delay)
#define INTERACT_GRAB_UPDATE_DELAY 0
decl(int[])
interact_grab_handleupdate = vec2(-1,-1);
decl(vector3)
interact_grab_bias = vec3(0,0,0);
decl(vector3)
interact_grab_dir = vec3(0,0,0);
decl(mesh)
interact_grab_mobObj = objNUll;

decl(bool)
interact_grab_isGrabbed = false;

decl(void(any;any;any;int))
interact_grab_start = {
	params ["_src","_sidePos","_vDir","_sideIdx"];
	
	interact_grab_handleupdate set [
	 	_sideIdx,
		startUpdateParams(interact_grab_onUpdate,INTERACT_GRAB_UPDATE_DELAY,vec3(_src,_sidePos,_vDir))
	];
	
}; rpcAdd("grab_strt",interact_grab_start);

decl(void(any))
interact_grab_onUpdate = {
	_data = (_this select 0);
	_data params ["_src","_sidePos","_vDir"];
	
	//object, intersect position,vectorUp lod]
	//(objnull call interact_getIntersectData) params ["_obj","_posAtl"];
	
	_ins = lineIntersectsSurfaces [
		AGLToASL getCenterMobPos(player),
  		AGLToASL positionCameraToWorld [_sidePos select 0,_sidePos select 1,0],
  		player,
		objNull,
		true,
		5,
		INTERACT_LODS_CHECK_STANDART
 	];
	if (count _ins == 0) exitWith {
		_src attachTo [player,_sidePos];
		_src setVectorDirAndUp [_vdir,[0,0,1]];
	};
	
	_ins apply {
		traceformat("[%1 :: %3]: %2",tickTime arg _x select 3 arg count _ins)
	};
	
	_last = _ins select (count _ins -1);
	_vpnew = player worldToModelVisual (asltoatl(_last select 0));
	_vpnew set [2,0];
	_src attachto [player,_vpnew,""];
	_src setVectorDirAndUp [_vdir,[0,0,1]];
	
	_ins select 0 select 2
};

decl(void(int))
interact_grab_stop = {
	params ["_idx"];
	stopUpdate(interact_grab_handleupdate select _idx);
	
	interact_grab_handleupdate set [_idx,-1];
}; rpcAdd("grab_stp",interact_grab_stop);