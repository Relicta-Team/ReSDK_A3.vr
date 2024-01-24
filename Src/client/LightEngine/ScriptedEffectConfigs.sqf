// ======================================================
// Copyright (c) 2017-2023 the ReSDK_A3 project
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

regScriptEmit(SLIGHT_TEMPLATE_DIRECTLIGHT)
	[
		"ltd",
		null,
		_emitAlias("Источник света")
		["linkToSrc",[0.05,0,0]],
		["setOrient",[90,0,0]],
		["linkToSrc",[-0.11,0,0]],
		["setOrient",[-90,0,0]],
		["setLightColor",[0.48,0.48,0.45]],
		["setLightAmbient",[0.03,0.03,0.04]],
		["setLightIntensity",1000],
		["setLightUseFlare",true],
		["setLightFlareSize",0.708],
		["setLightFlareMaxDistance",30.01],
		["setLightAttenuation",[1,0,0,0,5,7]],
		["setLightConePars",[122.52,30.46,2]]
	]
endScriptEmit

regScriptEmit(SLIGHT_TEMPLATE_POINTLIGHT)
	[
		"lt",
		null,
		_emitAlias("Источник")
		["linkToSrc",[0,0,0]],
		["setLightColor",[0.17,0.82,0.33]],
		["setLightIntensity",1000],
		["setLightAttenuation",[3,0,10,8,5,8]]
	]
endScriptEmit

regScriptEmit(SLIGHT_STREET_LAMP)
	[
		"ltd",
		null,
		_emitAlias("Направленный свет 1")
		["linkToSrc",[0,0,3.4]],
		["setOrient",[0,-90,0]],
		["setLightColor",[0.7,0.55,0.5]],
		["setLightIntensity",8000],
		["setLightUseFlare",true],
		["setLightFlareSize",0.5],
		["setLightFlareMaxDistance",30],
		["setLightAttenuation",[0,0,0,0,12,14]],
		["setLightConePars",[360,50,5]]
	]
endScriptEmit

regScriptEmit(SLIGHT_SHIT_SMELL)
	[
		"pt",
		null,
		_emitAlias("Частицы 1")
		["linkToSrc",[0,0,0.6]],
		["setParticleParams",[["\A3\data_f\ParticleEffects\Universal\Universal.p3d",16,12,13,0],"","Billboard",1,10,[0,0,0],[0,0,0],0,0.0511,0.04,0.1,[0.2,0.5,1,1.5,2,2.5,3],[[0.1,0.1,0.1,0.05],[0.1,0.2,0.1,0.06],[0.2,0.3,0.1,0.07],[0.3,0.4,0.1,0.08],[0.3,0.5,0.1,0.09],[0.4,0.6,0.3,0.1],[0.5,0.7,0.4,0.1]],[1000],0.1,0.01,"","","",0,false,-1,[]]],
		["setParticleRandom",[0.2,[0.2,0.2,0.2],[0.01,0.01,0.01],5,0.2,[0,0,0,0],0,0,0,0]],
		["setParticleCircle",[0.03,[0.1,0.1,0]]],
		["setDropInterval",0.5]
	]
endScriptEmit
