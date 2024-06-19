// ======================================================
// Copyright (c) 2017-2024 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================


["loop_sound",{
	params ["_emit","_src","_inPar"];
	_inPar params ["_sndPath","_pitORpitv2","_dist","_preend","_vol"];
	// _dist = 8;
	// _preend = 1.5;
	[_sndPath,_emit,_pitORpitv2,_dist,null,_preend,_vol] call sound3d_playLocalOnObjectLooped;
}] call le_se_registerConfigHandler;