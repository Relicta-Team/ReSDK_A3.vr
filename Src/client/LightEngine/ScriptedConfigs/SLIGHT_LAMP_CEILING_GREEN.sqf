// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

regScriptEmit(SLIGHT_LAMP_CEILING_GREEN)
	[
		"lt",
		null,
		_emitAlias("Свет")
		["linkToSrc",[0,0,-0.16]],
		["setLightColor",[0.02,0.035,0.03]],
		["setLightAmbient",[0.03,0.04,0.02]],
		["setLightIntensity",3000],
		["setLightUseFlare",true],
		["setLightFlareSize",0.2],
		["setLightFlareMaxDistance",55],
		["setLightAttenuation",[0,0,0,0,10,12]]
	]
endScriptEmit