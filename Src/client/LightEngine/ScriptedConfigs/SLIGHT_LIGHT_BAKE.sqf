// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

regScriptEmit(SLIGHT_LIGHT_BAKE)
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
endScriptEmit