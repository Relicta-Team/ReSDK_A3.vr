// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

regScriptEmit(SLIGHT_DAM_BETON)
	[
		"pt",
		null,
		_emitAlias("Частицы 1")
		["linkToSrc",[0,0,0]],
		["setParticleParams",[["\A3\data_f\ParticleEffects\WallPart\WallPart2.p3d",1,0,1,0],"","SpaceObject",1,3,[0,0,0],[0,0,0],1.1,20,0.9,0.5,[0.2],[[1,1,1,1]],[1],0,0.4,"","","",0,false,-1,[]]],
		["setParticleRandom",[1.5,[0,0,0],[3.889,3.866,2.166],1,0.6,[0,0,0,0],0,0.1,257.706,0]],
		["setParticleCircle",[0,[0,0,0]]],
		["setDropInterval",0.005]
	]
	,[
		"pt",
		null,
		_emitAlias("Частицы 2")
		["linkToLight",[0,0,0]],
		["setParticleParams",[["\A3\data_f\ParticleEffects\Universal\Universal.p3d",16,12,13,0],"","Billboard",1,7,[0,0,0],[0,0,0],0,1.276,1,0.03,[0.8,1.3,1,2,2,3],[[0.2,0.2,0.2,0.2],[0.2,0.2,0.2,0.16],[0.2,0.2,0.2,0.12],[0.2,0.2,0.2,0.1],[0.2,0.2,0.2,0.8],[0.2,0.2,0.2,0.6]],[1000],0.1,0.02,"","","",0,false,-1,[]]],
		["setParticleRandom",[3,[0,0,0],[1.4,1.4,1.4],30,0.3,[0,0,0,0],0,0,1,0]],
		["setParticleCircle",[0,[0,0,0]]],
		["setDropInterval",0.02]
	]
endScriptEmit