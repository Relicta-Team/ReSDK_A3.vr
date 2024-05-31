// ======================================================
// Copyright (c) 2017-2024 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

regScriptEmit(SLIGHT_DAM_ORGANIC)
	[
		"pt",
		null,
		_emitAlias("Частицы 2")
		["linkToSrc",[0,0,0]],
		["setParticleParams",[["\A3\data_f\ParticleEffects\Universal\Universal.p3d",16,12,9,0],"","BillBoard",1,2,[0,0,0],[0,0,1.4],0,5,0.01,2.5,[0.1,0.2],[[0.948,0.797,0.381,-1],[0.5,0.5,0.5,0]],[1000],0,0,"","","",0,false,-1,[]]],
		["setParticleRandom",[0.05,[0,0,0],[2,2,2],20,0.01,[0.277,0.022,0,1],0,0,1,0]],
		["setParticleCircle",[0,[0,0,0]]],
		["setDropInterval",0.001]
	]
endScriptEmit