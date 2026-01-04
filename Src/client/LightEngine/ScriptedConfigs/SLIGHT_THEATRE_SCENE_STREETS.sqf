// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

regScriptEmit(SLIGHT_THEATRE_SCENE_STREETS)
	[
		"ltd",
		null,
		_emitAlias("Направленный свет 2")
		["linkToSrc",[0,0,0]],
		["setOrient",[0,-90,0]],
		["setLightColor",[0.57,0.8,0.8]],
		["setLightAmbient",[0.19,0.3,0.3]],
		["setLightIntensity",11377.5],
		["setLightAttenuation",[5.1,1,1.1,0.1,30,50]],
		["setLightConePars",[81.61,30.48,0]]
	]
	,[
		"lt",
		null,
		_emitAlias("Точечный свет 3")
		["linkToLight",[0,0,0]],
		["setLightColor",[0.64,0.64,0.5]],
		["setLightAmbient",[0.11,0.09,0.05]],
		["setLightIntensity",6754.07],
		["setLightAttenuation",[0,0,0.5,0.5,30,40]]
	]
endScriptEmit