// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

regScriptEmit(SLIGHT_LEGACY_BAKESTOVE)
	[
		"lt",
		[["randomize_value_vec3",["setLightColor",[ [0.9,0.65,0.4],[1,0.65,0.5] ], [.1,.1],true]],["randomize_value_vec3",["setLightAmbient",[ [0.15,0.05,0],[0.17,0.05,0] ], [.1,.1], true]],["randomize_value_float",["setLightIntensity",[612.5625,625.0],[.1,.1], true]]],
		_emitAlias("Свет")
		["linkToSrc",[0,0,-0.2]],
		["setLightColor",[1,0.65,0.4]],
		["setLightAmbient",[0.15,0.05,0]],
		["setLightIntensity",612.56],
		["setLightAttenuation",[0,0,0,0,2,6]]
	]
	,[
		"pt",
		[["loop_sound",["fire\campfire",null,10]]],
		_emitAlias("Огонь")
		["linkToLight",[0,0,0]],
		["setParticleParams",[["\A3\data_f\ParticleEffects\Universal\Universal",16,10,32,1],"","Billboard",3,0.25,[0,0,0],[0,0,0.7],0,0.05,0.04,0.05,[0.24,0],[[1,1,1,-100],[1,1,1,-100],[0,0,0,0]],[1],0,0,"","","",0,false,0,[[0,0,0,0]]]],
		["setParticleRandom",[0.15,[0.01,0.01,0.15],[0.04,0.04,0.2],0,0.04,[0.1,0.1,0.1,0],0,0,1,0]],
		["setParticleCircle",[0,[0,0,0]]],
		["setDropInterval",0.022]
	]
	,[
		"pt",
		null,
		_emitAlias("Искры")
		["linkToLight",[0,0,-0.02]],
		["setParticleParams",[["\A3\data_f\ParticleEffects\Universal\Universal.p3d",16,13,2,0],"","Billboard",1,0.5,[0,0,0],[0,0,0.01],1,1.05,0.88,0.02,[0.03,0.03,0.03,0.03,0.03,0.02,0.02,0.02,0.02,0],[[0.662477,0.553565,0.3,-6.5],[0.84679,0.587077,0.3,-6],[0.637344,0.448842,0.3,-5.5],[1,0.499109,0.3,-4.5],[0.930569,0.553565,0.3,-6.5],[0.779767,0,0,1]],[400,100],0.05,0.2,"","","",0,false,0,[[0,0,0,0]]]],
		["setParticleRandom",[1.9,[0,0,0],[0.1,0.1,0.1],1,0.004,[0,0.15,0.15,0],1.07,0.0005,360,0]],
		["setParticleCircle",[0,[0,0,0]]],
		["setDropInterval",0.011]
	]
	,[
		"pt",
		null,
		_emitAlias("Преломление")
		["linkToLight",[0,0,0]],
		["setParticleParams",[["\A3\data_f\ParticleEffects\Universal\Refract",1,0,1,0],"","Billboard",1,2,[0,0,0],[0,0,0.6],0,0.05,0.04,0.05,[0.2,1.3,2.6],[[0.6,0.6,0.6,0.2],[0.7,0.7,0.7,0.2],[0.8,0.8,0.8,0.1],[1,1,1,0]],[1.5,0.5],0.4,0.09,"","","",0,false,0,[[0,0,0,0]]]],
		["setParticleRandom",[0.3,[0.1,0.1,0.2],[0.05,0.05,0.5],0,0.3,[0,0,0,0.1],0.2,0.05,1,0]],
		["setParticleCircle",[0,[0,0,0]]],
		["setDropInterval",0.1]
	]
endScriptEmit