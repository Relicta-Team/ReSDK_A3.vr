// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

regScriptEmit(SLIGHT_LEGACY_SIGARETTE)
	[
		"lt",
		[["sigarette_visual",["light",[15625,67089]]]],
		_emitAlias("Свет")
		["linkToSrc",[0,0.01,0]],
		["setLightColor",[0.013,0.001,0]],
		["setLightAmbient",[0.013,0.001,0]],
		["setLightIntensity",15625],
		["setLightAttenuation",[0,50,3,700,4,1]]
	]
	,[
		"pt",
		[["sigarette_visual",["smoke"]]],
		_emitAlias("Дым")
		["linkToLight",[0,0.04,0]],
		["setParticleParams",[["\A3\data_f\ParticleEffects\Universal\Universal.p3d",16,7,48,1],"","Billboard",1,3,[0,0,0],[0,0,0.11],0,0.051,0.04,0.1,[0.04,0.16],[[0.1,0.1,0.1,0.0450001],[0.2,0.2,0.2,0.13],[0.2,0.2,0.2,0.02],[0.3,0.3,0.3,0.01]],[1.5,0.5],0.4,0.02,"","","",0,false,-1,[]]],
		["setParticleRandom",[3,[0,0,0],[0.1,0.1,0],0,1.3,[0,0,0,0.1],0,0,10]],
		["setParticleCircle",[0,[0,0,0]]],
		["setDropInterval",0.015]
	]
	,[
		"pt",
		null,
		_emitAlias("Мелкий дым")
		["linkToLight",[0,0.04,0]],
		["setParticleParams",[["\A3\data_f\ParticleEffects\Universal\Universal.p3d",16,7,48,1],"","Billboard",1,4,[0,0,0],[0,0,0.0001],0,0.05,0.04,10,[0.01,0.06],[[0.1,0.1,0.1,-0.07],[0.2,0.2,0.2,-0.06],[0.2,0.2,0.2,0.02],[0.3,0.3,0.3,0.01]],[1.2,0.5],0.4,0.02,"","","",0,false,-1,[]]],
		["setParticleRandom",[3,[0,0,0],[0.001,0.001,0],0,0.7,[0,0,0,0.1],0,0,9.8]],
		["setParticleCircle",[0,[0,0,0]]],
		["setDropInterval",0.007]
	]
endScriptEmit