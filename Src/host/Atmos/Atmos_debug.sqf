// ======================================================
// Copyright (c) 2017-2024 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include "..\engine.hpp"
#include "..\ServerRpc\serverRpc.hpp"
#include "..\GameObjects\GameConstants.hpp"
#include "Atmos.hpp"
#include "Atmos.h"

#define ATMOS_DEBUG_CREATE_SPHERE(_r,_g,_b) call {private _s = "Sign_Sphere10cm_F" createVehicleLocal [0,0,0]; \
_s setObjectTexture [0,format(["#(rgb,8,8,3)color(%1,%2,%3,1)",_r,_g,_b])]; _s}

atmos_debug_testAll = {
	private _worldPos = getposatl player;
	private _areaPos = _worldPos call atmos_getAreaIdByPos;
	private _chPos = _worldPos call atmos_chunkPosToId;
	private _local = _chPos call atmos_getLocalChunkIdInArea;
	private _id = _local call atmos_encodeChId;
	#define TEST_CHECK(_v,_need) _pv = _v; if not_equals(_pv,_need) exitWith { \
		errorformat('TEST FAILED: _v -> Expected: %2 but got %1',_pv arg _need); \
		false \
	};
	#define TEST_DIST(_v,_need,distreq) _pv = _v; if ((_pv distance _need)>distreq) exitWith { \
		errorformat('TEST FAILED: _v -> Expected distance: %1 but got %2',distreq arg _pv distance _need); \
		false \
	};

	TEST_DIST(_chPos call atmos_chunkIdToPos,_worldPos,ATMOS_SIZE)
	TEST_CHECK(_worldPos call atmos_getAreaIdByPos,_areaPos)
	TEST_DIST(_areaPos call atmos_getPosByAreaId,_worldPos,ATMOS_AREA_SIZE)
	TEST_DIST(_areaPos call atmos_getPosByAreaId call atmos_getAreaIdByPos,_areaPos,ATMOS_AREA_SIZE)
	TEST_CHECK(vec2(_areaPos,_local) call atmos_localChunkIdToGlobal,_chPos)
	TEST_CHECK(_chPos call atmos_chunkIdToAreaId,_areaId)
	TEST_CHECK(_id call atmos_decodeChId,_local)
	
	true
};

atmos_debug_renderUpdate = {
	if !isNullReference(findDisplay 49) exitWith {};
	call atmos_debug_renderVisual;
};

atmos_debug_renderVisual = {
	_bPos = getposatl player;
	_myPos = _bPos call atmos_chunkPosToId;
	_chZCount = 3; //count render
	_color = [0,1,0,1];
	_colorText = [0,1,1,1];
	_posOffset = null;
	_allAreas = [];
	
	for "_x" from -_chZCount to _chZCount do {
		for "_y" from -_chZCount to _chZCount do {
			for "_z" from -1 to 2 do {
				_posOffset = [_x,_y,_z];
				_mpsChid = (_myPos vectoradd _posOffset);
				_newPosHalf = _mpsChid call atmos_chunkIdToPos;
				_areaId = _mpsChid call atmos_chunkIdToAreaId;
				_allAreas pushBackUnique _areaId;
				_newPosBase = _newPosHalf vectordiff [ATMOS_SIZE_HALF,ATMOS_SIZE_HALF,ATMOS_SIZE_HALF];

				_sp = _newPosBase;
				_size = ATMOS_SIZE;
				drawLine3D [_sp,_sp vectorAdd [_size,0,0],_color];
				drawLine3D [_sp,_sp vectorAdd [0,_size,0],_color];
				drawLine3D [_sp vectorAdd [_size,_size,0],_sp vectorAdd [_size,0,0],_color];
				drawLine3D [_sp vectorAdd [_size,_size,0],_sp vectorAdd [0,_size,0],_color];
				//to up

				drawLine3D [_sp vectorAdd [0,0,0],_sp vectorAdd [0,0,_size],_color];
				drawLine3D [_sp vectorAdd [_size,0,0],_sp vectorAdd [_size,0,_size],_color];
				drawLine3D [_sp vectorAdd [0,_size,0],_sp vectorAdd [0,_size,_size],_color];
				drawLine3D [_sp vectorAdd [_size,_size,0],_sp vectorAdd [_size,_size,_size],_color];

				//render spheres
				_poStr = str _posOffset;
				if !(_poStr in atmos_debug_spheresCenter) then {
					atmos_debug_spheresCenter set [_poStr,ATMOS_DEBUG_CREATE_SPHERE(0,1,0)];
				};
				(atmos_debug_spheresCenter get _poStr) setposatl _newPosHalf;

				//render text
				_local = _mpsChid call atmos_getLocalChunkIdInArea;
				_id = _local call atmos_encodeChId;
				drawIcon3D ["", _colorText, _newPosHalf vectoradd [0,0,0.07], 0, 0, 0, format[
						"CH:{%1,%2,%3} AR:%4; LC:%5(%6)",
						_mpsChid select 0,_mpsChid select 1,_mpsChid select 2,_areaId,_local,_id
					], 1, linearConversion [
						ATMOS_SIZE_HALF,
						ATMOS_SIZE_HALF*(_chZCount*2),
						(asltoatl eyepos player) distance (_newPosHalf),
						0.04,0.02,true], "TahomaB"];
			};
		};
	};

	//render areas
	_color = [1,0,0,1];
	_size = ATMOS_AREA_SIZE;
	{
		_sp = (_x call atmos_getPosByAreaId) vectoradd [0.01,0.01,0];

		drawLine3D [_sp,_sp vectorAdd [_size,0,0],_color];
		drawLine3D [_sp,_sp vectorAdd [0,_size,0],_color];
		drawLine3D [_sp vectorAdd [_size,_size,0],_sp vectorAdd [_size,0,0],_color];
		drawLine3D [_sp vectorAdd [_size,_size,0],_sp vectorAdd [0,_size,0],_color];
		//to up

		drawLine3D [_sp vectorAdd [0,0,0],_sp vectorAdd [0,0,_size],_color];
		drawLine3D [_sp vectorAdd [_size,0,0],_sp vectorAdd [_size,0,_size],_color];
		drawLine3D [_sp vectorAdd [0,_size,0],_sp vectorAdd [0,_size,_size],_color];
		drawLine3D [_sp vectorAdd [_size,_size,0],_sp vectorAdd [_size,_size,_size],_color];
	} foreach _allAreas;
};

atmos_debug_enableRender = {
	showHUD true;
	atmos_debug_handleRender = addMissionEventHandler ["Draw3d", atmos_debug_renderUpdate];
};

//cleanup memory
if !isNull(atmos_debug_handleRender) then {
	removeMissionEventHandler ["Draw3d",atmos_debug_handleRender];
};
if !isNull(atmos_debug_spheresCenter) then {
	{deleteVehicle _x} foreach (values atmos_debug_spheresCenter);
};
atmos_debug_spheresCenter = createHashMap;