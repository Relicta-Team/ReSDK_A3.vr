// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

regScriptEmit(SLIGHT_DAM_WOOD)
	[
		"pt",
		null,
		_emitAlias("Частицы 1")
		["linkToSrc",[0,0,0]],
		["setParticleParams",[["\ca\buildings\particle_effects\dum_door_piece_b.p3d",16,13,2,0],"","SpaceObject",1,0.3,[0,0,0],[0,0,0],0,10.55,1,8.13,[0.05,0.05,0.05,0.05,0.05,0.01,0.01],[[1,0.3,0.3,-6.5],[1,0.3,0.3,-6],[1,0.3,0.3,-5.5],[1,0.3,0.3,-4.5]],[1000],0,0,"","","",0,false,-1,[]]],
		["setParticleRandom",[1.5,[0,0,0],[5,5,2],1.7,1.2,[0,0,0,0],0,3.1,359.999,0]],
		["setParticleCircle",[0,[0,0,0]]],
		["setDropInterval",0.002]
	]
	,[
		"pt",
		null,
		_emitAlias("Частицы 9")
		["linkToLight",[0,0,0]],
		["setParticleParams",[["\A3\data_f\ParticleEffects\Universal\Universal.p3d",16,7,48,1],"","BillBoard",0.01,1,[0,0,0],[0,0,0.0820007],0,1.4,1.11,0,[0.58,0.3,0.1],[[0.6196,0.5804,0.5451,0.008]],[14,0.5,0.3,0.25,0.25],1,0,"","","",0,false,-1,[]]],
		["setParticleRandom",[2,[0,0,0],[1,1,1],20,0,[0,0,0,0],2,1.5,0,0]],
		["setParticleCircle",[0,[50,50,50]]],
		["setDropInterval",0.01]
	]
endScriptEmit