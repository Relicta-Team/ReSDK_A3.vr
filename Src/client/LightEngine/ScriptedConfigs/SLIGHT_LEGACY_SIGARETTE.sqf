// ======================================================
// Copyright (c) 2017-2025 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

regScriptEmit(SLIGHT_LEGACY_SIGARETTE)
	[
		"lt",
		null,
		_emitAlias("Свет-todo-добавить_мерцание")
		["linkToSrc",[0,0.01,0]],
		["setLightColor",[0.013,0.001,0]],
		["setLightAmbient",[0.013,0.001,0]],
		["setLightIntensity",15625],
		["setLightAttenuation",[0,50,3,700,4,1]]
	]
	,[
		"pt",
		null,
		_emitAlias("Дым-todo-добавить_парилку")
		["linkToLight",[0,0.01,0]],
		["setParticleParams",["\A3\data_f\cl_basic","","Billboard",0.5,2,[0,0,0],[0,0.1,-0.1],1,1.2,1,0.1,[0.1,0.2,0.1],[[0.2,0.2,0.2,0.3],[0,0,0,0.01],[1,1,1,0]],[500],1,0.04,"","",""]],
		["setParticleRandom",[2,[0,0,0],[0.25,0.25,0.25],0,0.5,[0,0,0,0.1],0,0,10]],
		["setParticleCircle",[0,[0,0,0]]],
		["setDropInterval",0.005]
	]
endScriptEmit