// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

regScriptEmit(SLIGHT_MOB_VOMIT)
	[
		"pt",
		null,
		_emitAlias("Частицы 1")
		["linkToSrc",[0,0,0]],
		["setParticleParams",[["\A3\data_f\ParticleEffects\Universal\UnderWaterSmoke.p3d",4,0,12,1],"","Billboard",1,2,[0,0,0],[0,0,0.1],1,1.35,0.5,0.05,[0.03,0.1],[[0.693,0.617,0.4144,0.064]],[1],0.1,0.01,"","","",0,false,-1,[]]],
		["setParticleRandom",[8,[0,0,0],[0.01,0.01,0.01],0,0.004,[0,0,0,1],0,0,0.1,0]],
		["setParticleCircle",[0,[0,0,0]]],
		["setDropInterval",0.01]
	]
	,[
		"pt",
		null,
		_emitAlias("Частицы 2")
		["linkToLight",[0,0,0]],
		["setParticleParams",[["\A3\data_f\ParticleEffects\Universal\Universal_02.p3d",8,0,40,1],"","Billboard",1,0.1,[0,0,0],[0,0,0.1],1,1.475,0.4,0,[0.05,0.2],[[0.801,0.943,0.608,-0.153],[0.872,0.83,0.575,-0.181]],[0.3,0.1],0.3,0.02,"","","",0,false,-1,[]]],
		["setParticleRandom",[2,[0,0,0],[0.01,0.01,0.01],9,0,[0,0,0,0],0,0,0.5,0]],
		["setParticleCircle",[0,[0,0,0]]],
		["setDropInterval",0.007]
	]
endScriptEmit