// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

regScriptEmit(SLIGHT_TEMPLATE_DIRECTLIGHT)
	[
		"ltd",
		null,
		_emitAlias("Источник света")
		["linkToSrc",[0.05,0,0]],
		["setOrient",[90,0,0]],
		["linkToSrc",[-0.11,0,0]],
		["setOrient",[-90,0,0]],
		["setLightColor",[0.48,0.48,0.45]],
		["setLightAmbient",[0.03,0.03,0.04]],
		["setLightIntensity",1000],
		["setLightUseFlare",true],
		["setLightFlareSize",0.708],
		["setLightFlareMaxDistance",30.01],
		["setLightAttenuation",[1,0,0,0,5,7]],
		["setLightConePars",[122.52,30.46,2]]
	]
endScriptEmit