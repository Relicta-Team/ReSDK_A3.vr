// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

regScriptEmit(SLIGHT_STREET_LAMP_ITAL)
	[
		"ltd",
		null,
		_emitAlias("Направленный свет 1")
		["linkToSrc",[0,-0,3.411]],
		["setOrient",[0,-90,0]],
		["setLightColor",[1,0.69,0.53]],
		["setLightAmbient",[0.1,0.1,0.1]],
		["setLightIntensity",7500],
		["setLightUseFlare",true],
		["setLightFlareSize",0.717],
		["setLightFlareMaxDistance",14.94],
		["setLightAttenuation",[5,5,5,5,15,30]],
		["setLightConePars",[45,360,5]]
	]
endScriptEmit