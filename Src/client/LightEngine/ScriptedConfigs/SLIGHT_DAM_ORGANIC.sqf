// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

regScriptEmit(SLIGHT_DAM_ORGANIC)
	[
		"pt",
		null,
		_emitAlias("Частицы 2")
		["linkToSrc",[0,0,0]],
		["setParticleParams",[["\A3\data_f\ParticleEffects\Universal\Universal.p3d",16,12,9,0],"","Billboard",1,2,[0,0,0],[0,0,1.4],0,5,0.01,2.5,[0.1,0.2],[[0.948,0.797,0.381,0.064],[0.5,0.5,0.5,1]],[1000,100],0,0,"","","",0,false,-1,[]]],
		["setParticleRandom",[0.05,[0,0,0],[2,2,2],20,0.21,[0.277,0.022,0,0.687],0,0,1,0]],
		["setParticleCircle",[0,[0,0,0]]],
		["setDropInterval",0.003]
	]
	,[
		"pt",
		null,
		_emitAlias("Частицы 15")
		["linkToLight",[0,0,0]],
		["setParticleParams",[["\A3\data_f\ParticleEffects\Universal\UnderWaterSmoke.p3d",4,0,16,1],"","Billboard",1,15,[0,0,0],[0,0,0],1,6.15,1,0.05,[0.09],[[0.905,0.395,0.126,1]],[1],0.1,0.01,"","","",0,false,-1,[]]],
		["setParticleRandom",[8,[0,0,0],[0.932003,0.932003,2.989],0,0.004,[0,0,0,1],0,0,0.1,0]],
		["setParticleCircle",[0,[0,0,0]]],
		["setDropInterval",0.01]
	]
endScriptEmit