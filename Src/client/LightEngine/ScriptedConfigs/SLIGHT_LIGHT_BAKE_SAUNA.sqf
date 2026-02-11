// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

regScriptEmit(SLIGHT_LIGHT_BAKE_SAUNA)
	[
		"lt",
		null,
		_emitAlias("Точечный свет")
		["linkToSrc",[-0.799999,0.600002,-3.3]],
		["setLightColor",[1,0.5,0.2]],
		["setLightAmbient",[0.1,0.05,0.02]],
		["setLightIntensity",2000],
		["setLightAttenuation",[0,0,0,5,0.05,3]]
	]
	,[
		"pt",
		null,
		_emitAlias("Огонь")
		["linkToLight",[-0.8,0.8,-3.6]],
		["setParticleParams",[["\A3\data_f\ParticleEffects\Universal\Universal.p3d",16,10,32,1],"","Billboard",3,0.25,[0,0,0],[0,0,0.7],0,0.07,0.04,0.05,[0.24,0],[[1,1,1,-100],[1,1,1,-100],[0,0,0,0]],[1],0,0,"","","",0,false,-1,[]]],
		["setParticleRandom",[0.15,[0.01,0.01,0.15],[0.04,0.04,0.2],0,0.04,[0.1,0.1,0.1,0],0,0,1,0]],
		["setParticleCircle",[0,[0,0,0]]],
		["setDropInterval",0.022]
	]
	,[
		"pt",
		null,
		_emitAlias("Частицы 4")
		["linkToLight",[-1.5,-0.5,-3]],
		["setParticleParams",[["\A3\data_f\ParticleEffects\Universal\Universal.p3d",16,12,8,0],"","Billboard",1,15,[0,0,0],[0,0,0],0,0.0511,0.04,0.1,[1.5,2.5,3.5,4,4.5],[[0.22,0.22,0.22,0.05],[0.25,0.25,0.25,0.22],[0.25,0.25,0.25,0.1],[0.25,0.25,0.25,0.04],[0.25,0.25,0.25,0.05]],[100,100,100,100,100],0.1,0.01,"","","",0,false,-1,[]]],
		["setParticleRandom",[0,[2.2,1,0.5],[0.01,0.01,0.01],20,0.5,[0,0,0,0],0,0,360,0]],
		["setParticleCircle",[0.03,[0,0,0]]],
		["setDropInterval",0.5]
	]
endScriptEmit