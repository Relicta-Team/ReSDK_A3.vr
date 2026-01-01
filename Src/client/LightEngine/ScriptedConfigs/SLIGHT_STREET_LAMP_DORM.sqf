// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

regScriptEmit(SLIGHT_STREET_LAMP_DORM)
	[
		"ltd",
		null,
		_emitAlias("Направленный свет 1")
		["linkToSrc",[0,0,3.298]],
		["setOrient",[0,-90,0]],
		["setLightColor",[1,0.5,0.2]],
		["setLightAmbient",[0.1,0.05,0.02]],
		["setLightIntensity",7000],
		["setLightUseFlare",true],
		["setLightFlareSize",0.2],
		["setLightFlareMaxDistance",30],
		["setLightAttenuation",[0,0,0,0,0.1,20]],
		["setLightConePars",[360,90,0]]
	]
endScriptEmit