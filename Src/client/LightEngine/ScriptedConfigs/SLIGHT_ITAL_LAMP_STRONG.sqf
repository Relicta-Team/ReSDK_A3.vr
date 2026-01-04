// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

regScriptEmit(SLIGHT_ITAL_LAMP_STRONG)
	[
		"ltd",
		null,
		_emitAlias("Направленный свет 1")
		["linkToSrc",[0,0,-0.15]],
		["setOrient",[0,-90,0]],
		["setLightColor",[0.79,0.76,0.73]],
		["setLightAmbient",[0.36,0.31,0.3]],
		["setLightIntensity",5000],
		["setLightUseFlare",true],
		["setLightFlareSize",0.2],
		["setLightFlareMaxDistance",100],
		["setLightAttenuation",[0,0,0,0,0.01,10]],
		["setLightConePars",[230,0,4]]
	]
endScriptEmit