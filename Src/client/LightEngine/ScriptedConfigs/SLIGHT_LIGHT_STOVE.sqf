// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

regScriptEmit(SLIGHT_LIGHT_STOVE)
	[
		"lt",
		null,
		_emitAlias("Точечный свет 1")
		["linkToSrc",[0,0,0]],
		["setLightColor",[1,0.5,0.2]],
		["setLightAmbient",[0.1,0.05,0.02]],
		["setLightIntensity",1000],
		["setLightAttenuation",[0,0,0,5,0.1,2]]
	]
	,[
		"pt",
		null,
		_emitAlias("Огонь")
		["linkToLight",[0,0,-0.1]],
		["setParticleParams",[["\A3\data_f\ParticleEffects\Universal\Universal.p3d",16,10,32,1],"","Billboard",3,0.25,[0,0,0],[0,0,0.7],0,0.05,0.04,0.05,[0.24,0],[[1,1,1,-100],[1,1,1,-100],[0,0,0,0]],[1],0,0,"","","",0,false,-1,[]]],
		["setParticleRandom",[0.15,[0.01,0.01,0.15],[0.04,0.04,0.2],0,0.04,[0.1,0.1,0.1,0],0,0,1,0]],
		["setParticleCircle",[0,[0,0,0]]],
		["setDropInterval",0.022]
	]
	,[
		"pt",
		null,
		_emitAlias("Рефракт")
		["linkToLight",[0,0,0]],
		["setParticleParams",[["\A3\data_f\ParticleEffects\Universal\Refract.p3d",1,0,1,0],"","Billboard",1,2,[0,0,0],[0,0,0.6],0,0.05,0.04,0.05,[0.2,0.8,2.6],[[0.6,0.6,0.6,0.2],[0.7,0.7,0.7,0.2],[0.8,0.8,0.8,0.1],[1,1,1,0]],[1.5,0.5],0.4,0.09,"","","",0,false,-1,[]]],
		["setParticleRandom",[0.3,[0.1,0.1,0.2],[0.05,0.05,0.5],0,0.3,[0,0,0,0.1],0.2,0.05,1,0]],
		["setParticleCircle",[0,[0,0,0]]],
		["setDropInterval",0.1]
	]
	,[
		"pt",
		null,
		_emitAlias("Дым")
		["linkToLight",[0,0,0.3]],
		["setParticleParams",[["\A3\data_f\ParticleEffects\Universal\Universal_02.p3d",8,0,40,1],"","Billboard",1,2,[0,0,0],[0,0,0.08],1,1.26,1,0,[0.2,0.25],[[1,1,1,0.06],[1,1,1,0.04],[1,1,1,0.02],[1,1,1,0.01],[1,1,1,0.001]],[0.8,0.3,0.25],0.3,0.04,"","","",0,false,-1,[]]],
		["setParticleRandom",[1,[0.08,0.08,0.01],[0.05,0.05,0.05],9,0,[0,0,0,0],0,0,0.5,0]],
		["setParticleCircle",[0,[0,0,0]]],
		["setDropInterval",0.01]
	]
	,[
		"pt",
		null,
		_emitAlias("Искры")
		["linkToLight",[0,0,0]],
		["setParticleParams",[["\A3\data_f\ParticleEffects\Universal\Universal.p3d",16,13,2,0],"","Billboard",1,1,[0,0,0],[0,0,0.05],1,1.2,1,0.17,[0.1,0.1,0.1,0.1,0.1,0.08,0.08,0.08,0.08,0],[[1,0.3,0.3,-6.5],[1,0.3,0.3,-6],[1,0.3,0.3,-5.5],[1,0.3,0.3,-4.5]],[100],0.5,0.001,"","","",0,false,-1,[]]],
		["setParticleRandom",[2.5,[0,0,0],[0.2,0.2,1],2,0.04,[0,0.15,0.15,0],0.01,0.01,360,0]],
		["setParticleCircle",[0,[0,0,0]]],
		["setDropInterval",0.1]
	]
endScriptEmit