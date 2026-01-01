// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

regScriptEmit(SLIGHT_DAM_STONE)
	[
		"pt",
		null,
		_emitAlias("Частицы 1")
		["linkToSrc",[0,0,0]],
		["setParticleParams",[["\A3\data_f\ParticleEffects\Universal\StoneSmall.p3d",16,13,2,0],"","SpaceObject",1,0.3,[0,0,0],[0,0,0],0,10.35,0.4,0.17,[0.2,0.2,0.2,0.2,0.2,0.18,0.18,0.18,0.18,0],[[1,0.3,0.3,-6.5],[1,0.3,0.3,-6],[1,0.3,0.3,-5.5],[1,0.3,0.3,-4.5]],[1000],0,0,"","","",0,false,-1,[]]],
		["setParticleRandom",[1.5,[0,0,0],[3.2,3.2,4.4],1.7,0.04,[0,0,0,0],2.2,0.1,209.772,0]],
		["setParticleCircle",[0,[0,0,0]]],
		["setDropInterval",0.018]
	]
	,[
		"pt",
		null,
		_emitAlias("Частицы 2")
		["linkToLight",[0,0,0]],
		["setParticleParams",[["\A3\data_f\ParticleEffects\Universal\Universal_02.p3d",8,0,40,1],"","Billboard",1,2,[0,0,0],[0,0,0],0.594,1.275,1,10,[0.1,0.5,0.8,1.6],[[1,1,1,0.442],[1,1,1,0.319],[1,1,1,0.215],[1,1,1,0.168]],[0.8,0.3,0.25],0,0,"","","",0,false,-1,[]]],
		["setParticleRandom",[2.5,[0,0,0],[1.5,1.5,1.5],0.01,0.2,[0,0,0,0],0,0,0,0]],
		["setParticleCircle",[0,[0,0,0]]],
		["setDropInterval",0.2]
	]
endScriptEmit