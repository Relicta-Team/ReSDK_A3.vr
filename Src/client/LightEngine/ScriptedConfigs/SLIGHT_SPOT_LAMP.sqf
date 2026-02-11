// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

regScriptEmit(SLIGHT_SPOT_LAMP)
	[
		"ltd",
		null,
		_emitAlias("Направленный свет 3")
		["linkToSrc",[0,0,0.100002]],
		["setOrient",[0,-90,0]],
		["setLightColor",[1000,1000,1000]],
		["setLightAmbient",[10,10,10]],
		["setLightIntensity",5],
		["setLightFlareSize",0.1],
		["setLightFlareMaxDistance",250],
		["setLightAttenuation",[0,20,0,0.1,0.005,3]],
		["setLightConePars",[90,0,0]]
	]
endScriptEmit