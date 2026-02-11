// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

regScriptEmit(SLIGHT_DAM_CLOTH)
	[
		"pt",
		null,
		_emitAlias("Частицы 2")
		["linkToSrc",[0,0,0]],
		["setParticleParams",[["\a3\Data_f\ParticleEffects\Universal\Hay.p3d",1,0,1,0],"","SpaceObject",3,0.8,[0,0,0],[0,0,0],0,2,1,3,[0.47],[[1,1,1,1]],[1000],0,0,"","","",0,false,-1,[]]],
		["setParticleRandom",[0.1,[0,0,0],[3.5,3.5,3.5],1,0.58,[0.1,0.1,0.1,0],0,0,1,0]],
		["setParticleCircle",[0,[0,0,0]]],
		["setDropInterval",0.0003]
	]
	,[
		"pt",
		null,
		_emitAlias("Частицы 11")
		["linkToLight",[0,0,0]],
		["setParticleParams",[["\A3\data_f\ParticleEffects\Universal\Universal_02.p3d",8,0,40,1],"","Billboard",1,2,[0,0,0],[0,0,0],1,1.26,1,0,[0.25,0.55],[[1,1,1,0.06],[1,1,1,0.04],[1,1,1,0.02],[1,1,1,0.01],[1,1,1,0.001]],[0.8,0.3,0.25],0.3,0.04,"","","",0,false,-1,[]]],
		["setParticleRandom",[1,[0.08,0.08,0.01],[0.5,0.5,0.5],9,0,[0,0,0,0],0,0,0.5,0]],
		["setParticleCircle",[0,[0,0,0]]],
		["setDropInterval",0.01]
	]
endScriptEmit