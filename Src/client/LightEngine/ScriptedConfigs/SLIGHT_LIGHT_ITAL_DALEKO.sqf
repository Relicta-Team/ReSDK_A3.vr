// ======================================================
// Copyright (c) 2017-2024 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

regScriptEmit(SLIGHT_LIGHT_ITAL_DALEKO)
	[
		"ltd",
		null,
		_emitAlias("Направленный свет 2")
		["linkToSrc",[0,0,0]],
		["setOrient",[0,-90,0]],
		["setLightColor",[0.86,0.55,0.28]],
		["setLightAmbient",[0.77,0.13,0]],
		["setLightIntensity",6763.21],
		["setLightAttenuation",[5.1,1,1.1,0.1,30,50]],
		["setLightConePars",[10,9.5,0]]
	]
	,[
		"lt",
		null,
		_emitAlias("Точечный свет 3")
		["linkToLight",[0,0,0]],
		["setLightColor",[0.64,0.64,0.5]],
		["setLightAmbient",[0.11,0.09,0.05]],
		["setLightIntensity",2867.34],
		["setLightAttenuation",[0,0,0.5,0.5,30,40]]
	]
endScriptEmit