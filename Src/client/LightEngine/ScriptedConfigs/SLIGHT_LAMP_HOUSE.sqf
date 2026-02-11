// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

regScriptEmit(SLIGHT_LAMP_HOUSE)
	[
		"ltd",
		null,
		_emitAlias("Направленный свет 1")
		["linkToSrc",[0,0,-0.15]],
		["setOrient",[0,-90,0]],
		["setLightColor",[1,0.7,0.3]],
		["setLightAmbient",[1,0.6,0.3]],
		["setLightIntensity",600],
		["setLightUseFlare",true],
		["setLightFlareSize",0.2],
		["setLightFlareMaxDistance",100],
		["setLightAttenuation",[0,0,0,0,0.01,10]],
		["setLightConePars",[230,0,4]]
	]
endScriptEmit