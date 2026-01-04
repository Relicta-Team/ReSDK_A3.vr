// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

regScriptEmit(SLIGHT_WEAK_FIRE)
	[
		"lt",
		null,
		_emitAlias("Точечный свет 2")
		["linkToSrc",[0,0,0]],
		["setLightColor",[1,0.5,0.2]],
		["setLightAmbient",[0.1,0.05,0.02]],
		["setLightIntensity",255],
		["setLightAttenuation",[0,0,0,5,0,0]]
	]
	,[
		"pt",
		null,
		_emitAlias("Искры")
		["linkToLight",[0,0,0]],
		["setParticleParams",[["\A3\data_f\ParticleEffects\Universal\Universal.p3d",16,13,2,0],"","Billboard",1,0.7,[0,0,0],[0,0,0.005],0.4,1.2,1,0.17,[0.1,0.1],[[1,0.3,0.3,-6.5]],[1000,100],0.5,0.05,"","","",0,false,-1,[]]],
		["setParticleRandom",[2.5,[0,0,0.2],[0.2,0.2,1],2,0.04,[0,0.15,0.15,0],0.3,0.15,360,0]],
		["setParticleCircle",[0,[0,0,0]]],
		["setDropInterval",0.06]
	]
	,[
		"pt",
		null,
		_emitAlias("Дым")
		["linkToLight",[0,0,0]],
		["setParticleParams",[["\A3\data_f\ParticleEffects\Universal\Universal.p3d",16,7,48,1],"","Billboard",1,1.2,[0,0,0],[0,0,0.6],0,0.05,0.04,0.22,[0.14,0.4],[[0.1,0.1,0.1,0.03],[0.2,0.2,0.2,0.05],[0.2,0.2,0.2,0.025],[0.3,0.3,0.3,0.01],[0.4,0.4,0.4,0.005]],[1.5,0.5],0.4,0.02,"","","",0,false,-1,[]]],
		["setParticleRandom",[0.5,[0.03,0.03,0.03],[0.25,0.25,0.5],0,0.1,[0,0,0,0],0.1,0.01,1,0]],
		["setParticleCircle",[0,[0,0,0]]],
		["setDropInterval",0.01]
	]
	,[
		"pt",
		null,
		_emitAlias("Огонь")
		["linkToLight",[-0.0499992,3.8147e-06,0.0840034]],
		["setParticleParams",[["\A3\data_f\ParticleEffects\Universal\Universal.p3d",16,10,32,1],"","Billboard",3,0.4,[0,0,0],[0,0,0.5],0,0.05,0.04,0.16,[0.2],[[1,1,0.6,-80]],[0.2],0,0,"","","",0,false,-1,[]]],
		["setParticleRandom",[0.15,[0.15,0.15,0.15],[0.03,0.03,0.09],0,0.02,[0.1,0.1,0.1,0],0,0,1,0]],
		["setParticleCircle",[0,[0,0,0]]],
		["setDropInterval",0.01]
	]
	,[
		"pt",
		null,
		_emitAlias("Рефракт")
		["linkToLight",[0,0,0]],
		["setParticleParams",[["\A3\data_f\ParticleEffects\Universal\Refract.p3d",1,0,1,0],"","Billboard",1,2,[0,0,0],[0,0,0.6],0,0.05,0.04,0.05,[0.5,0.8,2.6],[[0.6,0.6,0.6,0.2],[0.7,0.7,0.7,0.2],[0.8,0.8,0.8,0.1],[1,1,1,0]],[1.5,0.5],0.4,0.09,"","","",0,false,-1,[]]],
		["setParticleRandom",[0.3,[0.1,0.1,0.2],[0.05,0.05,0.5],0,0.3,[0,0,0,0.1],0.2,0.05,1,0]],
		["setParticleCircle",[0,[0,0,0]]],
		["setDropInterval",0.1]
	]
endScriptEmit