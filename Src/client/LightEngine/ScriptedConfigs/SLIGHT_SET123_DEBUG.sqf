// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

regScriptEmit(SLIGHT_SET123_DEBUG)
	[
		"pt",
		null,
		_emitAlias("test")
		["linkToSrc",[0,0,0.867001]],
		["setParticleParams",[["\A3\data_f\ParticleEffects\Universal\GlassParts_05.p3d",1,0,1,0],"","SpaceObject",3,0.8,[0,0,0],[0,0,0],0,5,1,0,[0.125],[[1,1,1,1]],[1000],0,0,"","","",0,false,-1,[]]],
		["setParticleRandom",[0.1,[0.35,0.35,0.475],[0.4,0.4,0.4],6,0.025,[0.1,0.1,0.1,0],0,0,1,0]],
		["setParticleCircle",[3.32,[5.432,0,0]]],
		["setDropInterval",0.02]
	]
	,[
		"lt",
		null,
		_emitAlias("Точечный свет 3")
		["linkToLight",[0,0,0]],
		["setLightColor",[1,0.5,0.2]],
		["setLightIntensity",300],
		["setLightAttenuation",[0,0,0,5,0,0]]
	]
	,[
		"ltd",
		null,
		_emitAlias("Направленный свет 2")
		["linkToLight",[0,0,0.2]],
		["setOrient",[0,11.645,0]],
		["setLightColor",[0.2,0.2,0.21]],
		["setLightAmbient",[0.18,0.13,0]],
		["setLightIntensity",5000],
		["setLightAttenuation",[0.3,0.9,0.5,0,0.2,5.1]],
		["setLightConePars",[88.42,5.69,2]]
	]
endScriptEmit