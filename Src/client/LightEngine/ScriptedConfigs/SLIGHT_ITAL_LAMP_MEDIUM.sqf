// ======================================================
// Copyright (c) 2017-2024 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

regScriptEmit(SLIGHT_ITAL_LAMP_MEDIUM)
	[
		"ltd",
		null,
		_emitAlias("Направленный свет 1")
		["linkToSrc",[0,0,-0.15]],
		["setOrient",[0,-90,0]],
		["setLightColor",[0.74,0.71,0.68]],
		["setLightAmbient",[0.81,0.79,0.7]],
		["setLightIntensity",3500],
		["setLightUseFlare",true],
		["setLightFlareSize",0.2],
		["setLightFlareMaxDistance",100],
		["setLightAttenuation",[0,0,0,0,0.01,10]],
		["setLightConePars",[230,0,4]]
	]
endScriptEmit