// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

regScriptEmit(SLIGHT_ATMOS_SMOKE_1)
	[
		"pt",
		[["atmos_optimize_chunk"]],
		_emitAlias("Частицы 1")
		["linkToSrc",[0,0,0]],
		["setParticleParams",[["\A3\data_f\ParticleEffects\Universal\Universal_02.p3d",8,0,40,0],"","Billboard",1,3,[0,0,0],[0,0,0],0,0,0.9,1.15,[0.8,0.9],[[0.5,0.5,0.5,0.0450001],[0.6,0.6,0.6,0.036],[0.7,0.7,0.7,0.2],[0.8,0.8,0.8,0.08],[0.9,0.9,0.9,0.01]],[1000],0.2,0.2,"","","",0,false,-1,[]]],
		["setParticleRandom",[0.5,[0.3,0.3,0.3],[0.6,0.6,0.6],0.2,0.4,[0,0,0,0],0,0,1,0]],
		["setParticleCircle",[0.3,[0,0,0]]],
		["setDropInterval",0.15]
	]
endScriptEmit