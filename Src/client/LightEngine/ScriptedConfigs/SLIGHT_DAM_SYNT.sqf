// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

regScriptEmit(SLIGHT_DAM_SYNT)
	[
		"pt",
		null,
		_emitAlias("Частицы 3")
		["linkToSrc",[0,0,0]],
		["setParticleParams",[["\A3\data_f\ParticleEffects\Universal\AmmoBelt_Links.p3d",1,0,1,0],"","SpaceObject",1,0.7,[0,0,0],[0,0,0],46.897,5,1,5,[0.5],[[1,1,1,-50]],[1000],0,0,"","","",0,false,-1,[]]],
		["setParticleRandom",[0.6,[0,0,0],[5,5,5],2,0,[0,0,0,0],200,0,187.802,0]],
		["setParticleCircle",[0,[0,0,0]]],
		["setDropInterval",0.0004]
	]
	,[
		"pt",
		null,
		_emitAlias("Частицы 4")
		["linkToLight",[0,0,0]],
		["setParticleParams",[["\A3\data_f\ParticleEffects\Universal\Universal.p3d",16,7,48,1],"","Billboard",1,4.2,[0,0,0],[0,0,0],0,0.05,0.04,0.22,[0.5,0.4],[[0.1,0.1,0.1,0.074],[0.2,0.2,0.2,0.05],[0.2,0.2,0.2,0.025],[0.3,0.3,0.3,0.01],[0.4,0.4,0.4,0.005]],[1.5,0.5],0.4,0.02,"","","",0,false,-1,[]]],
		["setParticleRandom",[0.5,[0.03,0.03,0.03],[1.25,1.25,1.5],0,0.8,[0,0,0,0],0.1,0.01,1,0]],
		["setParticleCircle",[0,[0,0,0]]],
		["setDropInterval",0.015]
	]
endScriptEmit