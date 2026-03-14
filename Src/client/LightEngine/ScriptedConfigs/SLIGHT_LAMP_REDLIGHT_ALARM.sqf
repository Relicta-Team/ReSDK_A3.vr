// ======================================================
// Copyright (c) 2017-2024 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

regScriptEmit(SLIGHT_LAMP_REDLIGHT_ALARM)
	[
		"lt",
		null,
		_emitAlias("Точечный свет 2")
		["linkToSrc",[0,0,0]],
		["setLightColor",[1,0,0.025]],
		["setLightIntensity",2000],
		["setLightAttenuation",[0,0,0,5,0,0]]
	]
endScriptEmit