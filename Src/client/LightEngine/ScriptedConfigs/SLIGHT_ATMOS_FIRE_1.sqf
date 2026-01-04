// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

regScriptEmit(SLIGHT_ATMOS_FIRE_1)
	[
		"pt",
		[["atmos_optimize_chunk"]],
		_emitAlias("Преломление")
		["linkToSrc",[0,0,0]],
		["setParticleParams",[["\A3\data_f\ParticleEffects\Universal\Refract.p3d",1,0,1,0],"","Billboard",1,0.45,[0,0,0],[0,0,0],1,0.8,1,0.1,[0.8,0.5],[[0.3,0.3,0.3,0.01],[0.3,0.3,0.3,0.26],[0.3,0.3,0.3,0.24],[0.3,0.3,0.3,0.22],[0.3,0.3,0.3,0.16],[0.3,0.3,0.3,0.08],[0.3,0.3,0.3,0.02]],[2,1],0.1,0.05,"","","",0,false,-1,[]]],
		["setParticleRandom",[0.06,[0.05,0.05,0.1],[0.1,0.1,3.811],20,0.03,[0,0,0,0],0,0,1,0]],
		["setParticleCircle",[0,[0,0,0]]],
		["setDropInterval",0.02]
	]
	,[
		"pt",
		[["loop_sound",["fire\flame_1",[0.9,1.1],15,2]]],
		_emitAlias("Пламя")
		["linkToLight",[0,0,0]],
		["setParticleParams",[["\A3\data_f\ParticleEffects\Universal\Universal.p3d",16,10,32,1],"","Billboard",3,0.21,[0,0,0],[0,0,0],0,0.05,0.04,0.03,[0.42,0],[[1,0.466,0.239,0.14],[1,0,0.338,-1.7],[1,0.131,0,-2.5],[1,0.452,0.258,-2],[1,0.834,0.32,-1.7],[1,0.655,0.272,0]],[1],0,0,"","","",0,false,-1,[]]],
		["setParticleRandom",[0.2,[0.1,0.1,0.2],[0.05,0.05,2.7],0,0.2,[0.1,0.1,0.1,0],0,0,1,0]],
		["setParticleCircle",[0.3,[0.01,0.1,0]]],
		["setDropInterval",0.008]
	]
	,[
		"lt",
		[["randomize_value_vec3",["setLightAmbient",[ [-.01,0,0],[.01,0,0] ], [.05,.1]]],["randomize_value_float",["setLightIntensity",[-1000,-500],[.05,.1]]]],
		_emitAlias("Свет огня")
		["linkToLight",[0,0,0.3]],
		["setLightColor",[0.17,0.04,0]],
		["setLightAmbient",[0.03,0.01,0]],
		["setLightIntensity",2000],
		["setLightAttenuation",[0.2,0,0,0,1,5]]
	]
endScriptEmit