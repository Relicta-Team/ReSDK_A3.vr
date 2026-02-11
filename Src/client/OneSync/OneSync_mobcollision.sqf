// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\host\lang.hpp>

namespace(OneSync;NULL)

#include <..\Interactions\interact.hpp>

macro_const(os_mobcollision_distanceCheck)
#define OS_MOBCOLLISION_DISTANCE_CHECK 2

macro_const(os_mobcollision_blockMove)
#define OS_MOBCOLLISION_BLOCKMOVE 0.7

macro_const(os_mobcollision_scale_attacher)
#define OS_MOBCOLLISION_SCALE_ATTACHER 0.03

decl(int)
os_mobcollision_handleupdate = -1;

//os_mobcollision_canMove = true;
decl(mesh)
os_mobcollision_lastTarg = objnull;
decl(mesh)
os_mobcollision_bbObj = objnull;

decl(void(bool))
os_mobcollision_setEnable = {
	params ["_mode"];
	if (!isMultiplayer) exitWith{}; //do not create bb in editor
	if (_mode) then {
		os_mobcollision_handleupdate = startUpdate(os_mobcollision_onUpdate,0);
		if isNullReference(os_mobcollision_bbObj) then {
			call os_mobcollision_createBB;
		};
	} else {
		stopUpdate(os_mobcollision_handleupdate);
		os_mobcollision_handleupdate = -1;
	};
};

/*os_mobcollision_isVisible = {
	[getPosATL player,getdir player,50,_this] call bis_fnc_inAngleSector
};
*/

decl(void())
os_mobcollision_createBB = {
	private _bnd = "block_dirt" createVehicleLocal [0,0,0];
	_bnd setObjectTexture [0,""]; 
	_bnd setObjectMaterial [0,""];
	_bnd setVariable ["__ngoext_itt",true];
	os_mobcollision_bbObj = _bnd;
	//_bnd hideObject true;
	//_obj setVariable ["ngo_geom",_bnd];
	//_bnd setVariable ["ngo_src",_obj];
	//_bnd setVariable ["ref",_obj getVariable "ref"];
	
};

decl(void(mesh))
os_mobcollision_linkTo = {
	_obj = _this;
	_bnd = os_mobcollision_bbObj;
	
	_bnd setVariable ["ngo_src",_obj];
	_bnd setVariable ["ref",_obj getVariable "ref"];
	_bnd attachTo [_obj,[0,0,0],"spine3",true];
	os_mobcollision_bbObj setObjectScale OS_MOBCOLLISION_SCALE_ATTACHER;
};

decl(void())
os_mobcollision_onUpdate = {
	_centerPlayer = getCenterMobPos(player);
	_entList = (_centerPlayer nearEntities OS_MOBCOLLISION_DISTANCE_CHECK)-[player];
	_entList = _entList - [cam_object];
	//traceformat("ENTLIST %1",_entList)
	if (count _entList == 0) exitWith {
		os_mobcollision_lastTarg = objnull;
	};
	_targ = _entList select 0;
	if not_equals(_targ,os_mobcollision_lastTarg) then {
		os_mobcollision_lastTarg = _targ;
		_targ call os_mobcollision_linkTo;
	};
	
	/*_canMoveByDist = (_centerPlayer distance getCenterMobPos(_targ)) >= OS_MOBCOLLISION_BLOCKMOVE;
	traceformat("CANT MOVE BY DIST %1",_canMoveByDist)

	//_curobj = call interact_cursorObject;

	_canSee = getCenterMobPos(_targ) call os_mobcollision_isVisible;
	
	//os_mobcollision_canMove = _canMoveByDist && !_canSee;

	traceformat("CANMOVE %1",os_mobcollision_canMove)*/
};
