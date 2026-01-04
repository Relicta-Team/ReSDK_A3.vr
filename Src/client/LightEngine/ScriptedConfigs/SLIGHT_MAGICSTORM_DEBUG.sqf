// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

regScriptEmit(SLIGHT_MAGICSTORM_DEBUG)
	[
		"lt",
		null,
		_emitAlias("Точечный свет 1")
		["linkToSrc",[0,0,0.731001]],
		["setLightColor",[0,0.07,0.09]],
		["setLightIntensity",15991.1],
		["setLightUseFlare",true],
		["setLightFlareSize",3.131],
		["setLightAttenuation",[0,0,0,0,134296,0]]
	]
	,[
		"ltd",
		null,
		_emitAlias("Направленный свет 2")
		["linkToLight",[0,1.274,-0.490999]],
		["setOrient",[-81.136,94.659,0]],
		["setLightColor",[0,0.07,0.05]],
		["setLightAmbient",[0,0,0.04]],
		["setLightIntensity",18302.9],
		["setLightUseFlare",true],
		["setLightFlareSize",3.709],
		["setLightFlareMaxDistance",2.55]
	]
	,[
		"pt",
		null,
		_emitAlias("Частицы 3")
		["linkToLight",[0,0,0]],
		["setParticleParams",[["\A3\data_f\ParticleEffects\Universal\Universal.p3d",16,7,48,1],"","Billboard",1,1,[0,0,0],[0,0,1.704],0,0.52,0.4,0.45,[0.5,1],[[0.505,0.25,0.443,0.207],[0.3,0.3,0.3,-0.0889999]],[1.5,0.5],0.1,0.2,"","","",0,false,-1,[]]],
		["setParticleRandom",[2,[0.5,0.5,0.5],[2.5,2.5,2.5],10,0.8,[0,1,0,0],0,0,1,0]],
		["setParticleCircle",[2.21,[3.952,-4.438,2.142]]],
		["setDropInterval",0.0001]
	]
	,[
		"pt",
		null,
		_emitAlias("Частицы 4")
		["linkToLight",[0,0,0]],
		["setParticleParams",[["\A3\data_f\ParticleEffects\Universal\Universal.p3d",16,13,2,0],"","Billboard",1,3.5,[0,0,0],[0,0,1.5],1,1.05,1,0.17,[0.5,0.5,0.5,0.5,0.5,0.28,0.28,0.28,0.28,0],[[1,0.3,0.3,-6.5],[1,0.3,0.3,-6],[1,0.3,0.3,-5.5],[1,0.3,0.3,-4.5]],[1000],0.5,0.55,"","","",0,false,-1,[]]],
		["setParticleRandom",[2.5,[0,0,0.2],[0.2,0.2,0.2],2,0.04,[0,0.15,0.15,0],0.3,0.15,360,0]],
		["setParticleCircle",[2.49,[0,-0.653999,0]]],
		["setDropInterval",0.005]
	]
endScriptEmit