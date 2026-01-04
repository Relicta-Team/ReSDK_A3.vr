// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

regScriptEmit(SLIGHT_LEGACY_LAMP_KEROSENE)
	[
		"lt",
		[["randomize_value_vec3",["setLightColor",[ [0.65,0.65,0.35],[0.68,0.65,0.4] ], [.1,.1],true]],["randomize_value_vec3",["setLightAmbient",[ [0.09,0.05,0],[0.12,0.05,0] ], [.1,.1], true]],["randomize_value_float",["setLightIntensity",[210.25,225.0],[.1,.1], true]]],
		_emitAlias("Свет")
		["linkToSrc",[0,0,0.05]],
		["setLightColor",[1,0.65,0.4]],
		["setLightAmbient",[0.15,0.05,0]],
		["setLightIntensity",210.25],
		["setLightAttenuation",[5.8,0.1,0.1,2,0.5,4.3]]
	]
endScriptEmit