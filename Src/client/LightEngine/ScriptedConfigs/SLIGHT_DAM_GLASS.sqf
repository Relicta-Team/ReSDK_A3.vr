// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

regScriptEmit(SLIGHT_DAM_GLASS)
	[
		"pt",
		null,
		_emitAlias("Частицы 1")
		["linkToSrc",[0,0,0]],
		["setParticleParams",[["\A3\data_f\ParticleEffects\Universal\GlassParts_01.p3d",1,0,1,0],"","SpaceObject",3,0.8,[0,0,0],[0,0,0],0,5,1,0,[0.05],[[1,1,1,1]],[1000],0,0,"","","",0,false,-1,[]]],
		["setParticleRandom",[0.1,[0,0,0],[3.4,3.4,3.4],1,0.255,[0.1,0.1,0.1,0],0,0,1,0]],
		["setParticleCircle",[0,[0,0,0]]],
		["setDropInterval",0.006]
	]
endScriptEmit