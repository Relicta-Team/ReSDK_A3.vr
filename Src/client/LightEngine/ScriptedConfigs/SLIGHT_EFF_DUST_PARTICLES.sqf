// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

regScriptEmit(SLIGHT_EFF_DUST_PARTICLES)
	[
		"pt",
		null,
		_emitAlias("Пыль")
		["linkToSrc",[0,0,0]],
		["setParticleParams",[["\A3\data_f\ParticleEffects\Universal\Universal.p3d",16,13,2,0],"","Billboard",0.01,5,[0,0,0],[0,0,0],0,1.275,1,0,[0.006,0.01,0.005,0.001],[[0.4,0.4,0.4,5.02],[0.4,0.4,0.4,5.6],[0.4,0.4,0.4,7],[0.4,0.4,0.4,7]],[1000,0],0.7,0.006,"","","",0,false,0,[[0,0,0,0],[0,0,0,0]]]],
		["setParticleRandom",[2,[5.5,5.5,2.8],[0.05,0.05,0.01],0,0,[0.06,0.06,0.06,0],0.3,0.0019,1,0]],
		["setParticleCircle",[0,[0,0,0]]],
		["setDropInterval",0.001]
	]
endScriptEmit