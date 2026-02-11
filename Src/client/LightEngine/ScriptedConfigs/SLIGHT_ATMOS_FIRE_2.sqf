// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

regScriptEmit(SLIGHT_ATMOS_FIRE_2)
	[
		"pt",
		[["atmos_optimize_chunk"]],
		_emitAlias("Искры")
		["linkToSrc",[0,0,0]],
		["setParticleParams",[["\A3\data_f\ParticleEffects\Universal\Universal.p3d",16,13,2,0],"","Billboard",1,1.5,[0,0,0],[0,0,1.5],1,1.25,1,0.17,[0.1,0.1,0.1,0.1,0.1,0.08,0.08,0.08,0.08,0],[[1,0.3,0.3,-6.5],[1,0.3,0.3,-6],[1,0.3,0.3,-5.5],[1,0.3,0.3,-4.5]],[1000],0.5,0.55,"","","",0,false,-1,[]]],
		["setParticleRandom",[2.5,[0,0,0.2],[0.2,0.2,1],2,0.04,[0,0.15,0.15,0],0.3,0.15,360,0]],
		["setParticleCircle",[0.1,[0,0,0]]],
		["setDropInterval",0.15]
	]
	,[
		"pt",
		null,
		_emitAlias("Преломление")
		["linkToLight",[0,0,0]],
		["setParticleParams",[["\A3\data_f\ParticleEffects\Universal\Refract.p3d",1,0,1,0],"","Billboard",1,0.45,[0,0,0],[0,0,0],1,0.8,1,0.1,[1.4,1.2],[[0.3,0.3,0.3,0.01],[0.3,0.3,0.3,0.26],[0.3,0.3,0.3,0.24],[0.3,0.3,0.3,0.22],[0.3,0.3,0.3,0.16],[0.3,0.3,0.3,0.08],[0.3,0.3,0.3,0.02]],[2,1],0.1,0.05,"","","",0,false,-1,[]]],
		["setParticleRandom",[0.06,[0.05,0.05,0.1],[0.1,0.1,3.811],20,0.03,[0,0,0,0],0,0,1,0]],
		["setParticleCircle",[0,[0,0,0]]],
		["setDropInterval",0.02]
	]
	,[
		"pt",
		[["loop_sound",["fire\flame_2",[0.9,1.1],15,2]]],
		_emitAlias("Пламя")
		["linkToLight",[0,0,0]],
		["setParticleParams",[["\A3\data_f\ParticleEffects\Universal\Universal.p3d",16,10,32,1],"","Billboard",3,0.25,[0,0,0],[0,0,0],0,0.05,0.06,0.03,[0.42,0],[[1,0.466,0.239,0.14],[1,0,0.338,-1.7],[1,0.131,0,-2.5],[1,0.452,0.258,-2],[1,0.834,0.32,-1.7],[1,0.655,0.272,0]],[1],0,0,"","","",0,false,-1,[]]],
		["setParticleRandom",[0.2,[0.1,0.1,0.2],[0.05,0.05,2.7],0,0.2,[0.1,0.1,0.1,0],0,0,1,0]],
		["setParticleCircle",[0.3,[0.01,0.1,0]]],
		["setDropInterval",0.005]
	]
	,[
		"lt",
		[["randomize_value_vec3",["setLightAmbient",[ [-.01,0,0],[.01,0,0] ], [.05,.1]]],["randomize_value_float",["setLightIntensity",[-1000,-500],[.05,.1]]]],
		_emitAlias("Свет огня")
		["linkToLight",[0,0,0.3]],
		["setLightColor",[0.07,0.04,0]],
		["setLightAmbient",[0.03,0.01,0]],
		["setLightIntensity",5200],
		["setLightAttenuation",[0.4,0,0,0,1,5]]
	]
endScriptEmit