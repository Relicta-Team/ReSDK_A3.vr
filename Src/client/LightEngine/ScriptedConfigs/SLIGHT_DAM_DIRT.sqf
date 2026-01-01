// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

regScriptEmit(SLIGHT_DAM_DIRT)
	[
		"pt",
		null,
		_emitAlias("Частицы 1")
		["linkToSrc",[0,0,0]],
		["setParticleParams",[["\A3\data_f\ParticleEffects\Universal\Universal.p3d",16,12,13,0],"","Billboard",1,5,[0,0,0],[0,0,0],1,1.677,1,2.5,[0.08,0.5,1.1],[[0.25,0.25,0.2,0.2],[0.25,0.25,0.2,0.4],[0.25,0.25,0.2,0.3]],[1000],0.1,0.12,"","","",0,false,-1,[]]],
		["setParticleRandom",[0.3,[0,0,0],[3.05,3.05,5.05],5,1.5,[0,0,0,0],0,0,0.1,0]],
		["setParticleCircle",[0,[0,0,0]]],
		["setDropInterval",0.006]
	]
	,[
		"pt",
		null,
		_emitAlias("Частицы 2")
		["linkToLight",[0,0,0]],
		["setParticleParams",[["\A3\data_f\ParticleEffects\Universal\Universal.p3d",16,12,9,0],"","BillBoard",1,1,[0,0,0],[0,0,3],0,2,0.01,2.5,[0.1,0.2],[[0.5,0.5,0.5,1],[0.5,0.5,0.5,0]],[1000],0,0,"","","",0,false,-1,[]]],
		["setParticleRandom",[0.5,[0,0,0],[4,4,4],20,0.01,[0.1,0.1,0.1,0.1],0,0,1,0]],
		["setParticleCircle",[0,[1.5,1.5,1]]],
		["setDropInterval",0.008]
	]
endScriptEmit