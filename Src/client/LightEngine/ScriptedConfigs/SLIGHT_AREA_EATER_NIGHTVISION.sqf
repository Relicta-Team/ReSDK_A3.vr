// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

regScriptEmit(SLIGHT_AREA_EATER_NIGHTVISION)
	[
		"lt",
		[["virtual_light"]],
		_emitAlias("Свет")
		["linkToSrc",[0,0,0]],
		["setLightColor",[0.043,0.036,0]],
		["setLightAmbient",[0.005,0.006,0]],
		["setLightIntensity",147840],
		["setLightAttenuation",[15,30,80,5,10,40]]
	]
endScriptEmit