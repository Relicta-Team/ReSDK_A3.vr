// ======================================================
// Copyright (c) 2017-2024 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

regScriptEmit(SLIGHT_DAM_CLOTH)
	[
		"pt",
		null,
		_emitAlias("Частицы 2")
		["linkToSrc",[0,0,0]],
		["setParticleParams",[["\a3\Data_f\ParticleEffects\Universal\Hay.p3d",1,0,1,0],"","SpaceObject",3,0.8,[0,0,0],[0,0,0],0,2,1,3,[0.47],[[1,1,1,1]],[1000],0,0,"","","",0,false,-1,[]]],
		["setParticleRandom",[0.1,[0,0,0],[3.5,3.5,3.5],1,0.18,[0.1,0.1,0.1,0],0,0,1,0]],
		["setParticleCircle",[0,[0,0,0]]],
		["setDropInterval",0.0008]
	]
endScriptEmit