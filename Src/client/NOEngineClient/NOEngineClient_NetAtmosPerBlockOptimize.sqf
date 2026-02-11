// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\host\lang.hpp>

namespace(NOEngine.Client.NetAtmos.Optimizer,nat_pbo_)

#include "NOEngineClient_NetAtmos.hpp"
decl(thread_handle)
nat_pbo_threadHandle = threadNull;

decl(float)
nat_pbo_lastUpd = 0;
decl(float)
nat_pbo_prevCallTime = 0;

decl(vector3)
nat_pbo_boundingOffsetMin = vec3(-ATMOS_SIZE_HALF,-ATMOS_SIZE_HALF,-ATMOS_SIZE_HALF);
decl(vector3)
nat_pbo_boundingOffsetMax = vec3(ATMOS_SIZE_HALF,ATMOS_SIZE_HALF,ATMOS_SIZE_HALF);

decl(void())
nat_pbo_renderThread = {
	_dt = tickTime-nat_pbo_lastUpd;
	if (_dt > 0) then {
		nat_pbo_prevCallTime = _dt;
	};
	nat_pbo_lastUpd = tickTime;

	_arCenter = (getposatl player) call atmos_getAreaIdByPos;
	_areas = [_arCenter] call atmos_getAroundAreas;
	_buff = [];
	_campos = positionCameraToWorld[0,0,0];
	
	_bmin = nat_pbo_boundingOffsetMin;
	_bmax = nat_pbo_boundingOffsetMax;

	{
		if isNullVar(_x) then {continue};

		{
			_vlt = _y select NAT_CHUNKDAT_OBJECT;
			//if !(_vlt getv(cfg) in ["SLIGHT_ATMOS_FIRE_3" call lightSys_getConfigIdByName,"SLIGHT_ATMOS_SMOKE_3" call lightSys_getConfigIdByName]) then {continue};

			_p = _vlt getv(centerPos);
			_buff pushBack [
				_p distance _campos,
				[_p,_bmin,_bmax] call render_zpass_getBBXInfoVirtual,
				_vlt
			];
		} foreach (_x getv(chunks));
	} foreach (_areas apply {[_x] call noe_client_nat_getAreaUnsafe});

	criticalSectionStart
	[_campos,_buff,nat_pbo_cullProc] call render_processZPass;
	criticalSectionEnd
};

decl(void(struct_t.AtmosVirtualLight;bool))
nat_pbo_cullProc = {
	params ["_vlight","_isVisible"];
	_vlight callp(setHidden,!_isVisible);
};

#ifdef ENABLE_PERBLOCK_ZPASS_CULLING

private _looped = { while {true} do {call nat_pbo_renderThread} };
nat_pbo_threadHandle = threadStart(threadNew(_looped));

#endif