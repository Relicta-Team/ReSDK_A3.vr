// ======================================================
// Copyright (c) 2017-2025 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

regScriptEmit(SLIGHT_LEGACY_FLASHLIGHT)
	[
		"ltd",
		null,
		_emitAlias("Направленный свет")
		["linkToSrc",[0,0.07,0]],
		["setLightColor",[180,156,120]],
		["setLightAmbient",[0.9,0.78,0.6]],
		["setLightIntensity",60],
		["setLightUseFlare",true],
		["setLightFlareSize",0.4],
		["setLightFlareMaxDistance",75],
		["setLightAttenuation",[0.5,0,0,1,1,4]],
		["setLightConePars",[120.26,30.48,8]]
	]
endScriptEmit