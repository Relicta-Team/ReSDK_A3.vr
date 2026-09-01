// ======================================================
// Copyright (c) 2017-2024 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

regScriptEmit(SLIGHT_LAMP_KINKY_VIBE)
	[
		"lt",
		null,
		_emitAlias("Точечный свет 1")
		["linkToSrc",[0,0,0]],
		["setLightAmbient",[1,0,1]],
		["setLightIntensity",1500],
		["setLightAttenuation",[0,1,0,5,0,0]]
	]
endScriptEmit