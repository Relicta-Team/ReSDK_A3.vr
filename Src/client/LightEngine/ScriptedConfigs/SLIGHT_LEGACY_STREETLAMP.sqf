// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

regScriptEmit(SLIGHT_LEGACY_STREETLAMP)
	[
		"ltd",
		null,
		_emitAlias("Направленный свет")
		["linkToSrc",[0,0,3.298]],
		["setOrient",[0,-80,0]],
		["setLightColor",[1100,700,500]],
		["setLightAmbient",[11,7,5]],
		["setLightIntensity",5],
		["setLightUseFlare",true],
		["setLightFlareSize",0.9],
		["setLightFlareMaxDistance",100],
		["setLightAttenuation",[0,0,0,0.8,40,30]],
		["setLightConePars",[130,80,3]]
	]
endScriptEmit