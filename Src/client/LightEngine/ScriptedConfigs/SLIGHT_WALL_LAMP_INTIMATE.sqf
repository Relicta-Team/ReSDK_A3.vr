// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

regScriptEmit(SLIGHT_WALL_LAMP_INTIMATE)
	[
		"ltd",
		null,
		_emitAlias("Направленный свет 1")
		["linkToSrc",[-0.08,0,0]],
		["setOrient",[-90,0,0]],
		["setLightColor",[0.5,0.15,1]],
		["setLightAmbient",[0.5,0.1,1]],
		["setLightIntensity",900],
		["setLightUseFlare",true],
		["setLightFlareSize",0.3],
		["setLightFlareMaxDistance",30],
		["setLightAttenuation",[0,0,5,0,0.1,4]],
		["setLightConePars",[145,100,0]]
	]
	,[
		"lt",
		null,
		_emitAlias("Точечный свет 2")
		["linkToLight",[-0.08,0,0]],
		["setLightAmbient",[0.5,0.1,1]],
		["setLightIntensity",100],
		["setLightAttenuation",[0,0,8,0,0.1,0.65]]
	]
endScriptEmit