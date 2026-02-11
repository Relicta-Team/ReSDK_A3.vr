// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

regScriptEmit(SLIGHT_DAM_FLESH)
	[
		"pt",
		null,
		_emitAlias("Частицы 1")
		["linkToSrc",[0,0,0]],
		["setParticleParams",[["\A3\data_f\ParticleEffects\Universal\Meat_ca.p3d",1,0,1,0],"","SpaceObject",1,0.7,[0,0,0],[0,0,0],1,54,1,10,[2],[[1,1,1,-50]],[1000],0,0,"","","",0,false,-1,[]]],
		["setParticleRandom",[0.6,[0,0,0],[5,5,5],2,0.6,[0,0,0,0],200,0,187.802,0]],
		["setParticleCircle",[0,[0,0,0]]],
		["setDropInterval",0.005]
	]
endScriptEmit