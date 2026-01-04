// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

regScriptEmit(SLIGHT_LEGACY_CANDLE)
	[
		"lt",
		[["randomize_value_vec3",["setLightColor",[ [0.7,0.65,0.4],[1,0.65,0.5] ], [.1,.1],true]],["randomize_value_vec3",["setLightAmbient",[ [0.18,0.05,0],[0.2,0.05,0] ], [.1,.1], true]],["randomize_value_float",["setLightIntensity",[40,70],[.1,.1], true]]],
		_emitAlias("Свет")
		["linkToSrc",[0,0,0.07]],
		["setLightColor",[1,0.65,0.4]],
		["setLightAmbient",[0.15,0.05,0]],
		["setLightIntensity",40],
		["setLightAttenuation",[0,0,0,0,2,4]]
	]
	,[
		"pt",
		null,
		_emitAlias("Огонь")
		["linkToLight",[0,0,0.07]],
		["setParticleParams",[["\A3\data_f\ParticleEffects\Universal\Universal.p3d",16,10,32,1],"","Billboard",3,0.25,[0,0,0],[0,0,0.06],0,0.05,0.04,0.05,[0.03,0],[[1,0.93873,0,-18.962],[1,1,0,-100],[0,0,0,0]],[0.01],0,0,"","","",0,false,0,[[0,0,0,0]]]],
		["setParticleRandom",[0.31,[0,0,0],[0,0,0.01],0,0.04,[0.280159,0.179065,0.0358475,0],0,0,1,0]],
		["setParticleCircle",[0,[0,0,0]]],
		["setDropInterval",0.012]
	]
	,[
		"pt",
		null,
		_emitAlias("Преломление")
		["linkToLight",[0,0,0.07]],
		["setParticleParams",[["\A3\data_f\ParticleEffects\Universal\Refract",1,0,1,0],"","Billboard",1,2,[0,0,0],[0,0,0.6],0,0.05,0.04,0.05,[0.2,0.1,2.6],[[0.6,0.6,0.6,0.2],[0.7,0.7,0.7,0.2],[0.8,0.8,0.8,0.1],[1,1,1,0]],[1.5,0.5],0.4,0.09,"","","",0,false,0,[[0,0,0,0]]]],
		["setParticleRandom",[0.3,[0.1,0.1,0.2],[0.05,0.05,0.5],0,0.3,[0,0,0,0.1],0.2,0.05,1,0]],
		["setParticleCircle",[0,[0,0,0]]],
		["setDropInterval",0.6]
	]
endScriptEmit