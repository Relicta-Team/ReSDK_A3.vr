// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

regScriptEmit(SLIGHT_LEGACY_LAMP_CEILING_OLD)
	[
		"ltd",
		null,
		_emitAlias("Направленный свет")
		["linkToSrc",[0,0,-0.2]],
		["setOrient",[0,-90,0]],
		["setLightColor",[0.99,0.92,0.49]],
		["setLightAmbient",[0.01,0,0]],
		["setLightIntensity",800],
		["setLightUseFlare",true],
		["setLightFlareSize",0.9],
		["setLightFlareMaxDistance",250],
		["setLightAttenuation",[0,0,2,0.5,50,70]],
		["setLightConePars",[130,60,6]]
	]
endScriptEmit