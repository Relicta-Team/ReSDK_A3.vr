// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
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
		["setLightAmbient",[0.1,0.1,0.05]],
		["setLightIntensity",400],
		["setLightUseFlare",true],
		["setLightFlareSize",0.2],
		["setLightFlareMaxDistance",30.13],
		["setLightAttenuation",[1,0,0,0,0.01,14]],
		["setLightConePars",[230,180,4]]
	]
endScriptEmit