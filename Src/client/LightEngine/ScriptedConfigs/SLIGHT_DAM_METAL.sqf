// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

regScriptEmit(SLIGHT_DAM_METAL)
	[
		"pt",
		null,
		_emitAlias("Частицы 1")
		["linkToSrc",[0,0,0]],
		["setParticleParams",[["\A3\data_f\ParticleEffects\Universal\Universal.p3d",16,13,2,0],"","Billboard",0.07,1.3,[0,0,0],[0,0,0],0,45,1.9,0.3,[0.06,0.09],[[1,0.268,0.017,1],[1,1,0.721,0.196]],[100,100],0,0,"","","",0,false,-1,[]]],
		["setParticleRandom",[1,[0,0,0],[4.5,4.5,4.3],0,0.3,[0,0,0,0],100,100,0,0]],
		["setParticleCircle",[0,[14.809,13.986,0]]],
		["setDropInterval",0.001]
	]
	,[
		"pt",
		null,
		_emitAlias("Частицы 7")
		["linkToLight",[0,0,0]],
		["setParticleParams",[["\A3\data_f\ParticleEffects\Universal\Universal_02.p3d",8,0,40,1],"","Billboard",1,3,[0,0,0],[0,0,0],1,1.275,1,0.5,[0.4,2.6],[[1,1,1,0.064],[1,1,1,0.111]],[0.8,0.3],0.3,0.1,"","","",0,false,-1,[]]],
		["setParticleRandom",[0.5,[0,0,0],[3.2,3.2,3.2],2,0.2,[0,0,0,0],0,0,0.3,0]],
		["setParticleCircle",[0,[0,0,0]]],
		["setDropInterval",0.06]
	]
	,[
		"pt",
		null,
		_emitAlias("Частицы 3")
		["linkToLight",[0,0,0]],
		["setParticleParams",[["\A3\data_f\ParticleEffects\Universal\SparksBall.p3d",16,2,8,0],"","SpaceObject",1,0.1,[0,0,0],[0,0,0],0,15,10,0,[0.4,0.9],[[1,1,0.6,-50]],[1000,10],0,0,"","","",0,false,-1,[]]],
		["setParticleRandom",[0,[0,0,0],[-0.1,-0.1,0],0,0.1,[0,0,0,0],0,0,0,0]],
		["setParticleCircle",[0,[0,0,0]]],
		["setDropInterval",0.07]
	]
endScriptEmit