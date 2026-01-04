// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

regScriptEmit(SLIGHT_LEGACY_LAMP_CEILING_REDLIGHT)
	[
		"lt",
		null,
		_emitAlias("Свет")
		["linkToSrc",[0,0,-0.2]],
		["setLightColor",[0.08,0.035,0.012]],
		["setLightAmbient",[0.169,0.009,0.009]],
		["setLightIntensity",2809],
		["setLightUseFlare",true],
		["setLightFlareSize",0.334],
		["setLightFlareMaxDistance",55.15],
		["setLightAttenuation",[0,0,0,0,6,7]]
	]
endScriptEmit