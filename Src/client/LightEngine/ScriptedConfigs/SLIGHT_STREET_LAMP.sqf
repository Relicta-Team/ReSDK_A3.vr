// ======================================================
// Copyright (c) 2017-2025 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

regScriptEmit(SLIGHT_STREET_LAMP)
	[
		"ltd",
		null,
		_emitAlias("Направленный свет 1")
		["linkToSrc",[0,0,3.4]],
		["setOrient",[0,-90,0]],
		["setLightColor",[0.7,0.55,0.5]],
		["setLightIntensity",8000],
		["setLightUseFlare",true],
		["setLightFlareSize",0.5],
		["setLightFlareMaxDistance",30],
		["setLightAttenuation",[0,0,0,0,12,14]],
		["setLightConePars",[360,50,5]]
	]
endScriptEmit