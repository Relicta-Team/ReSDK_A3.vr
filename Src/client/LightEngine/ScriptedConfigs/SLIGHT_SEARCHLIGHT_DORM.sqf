// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

regScriptEmit(SLIGHT_SEARCHLIGHT_DORM)
	[
		"ltd",
		null,
		_emitAlias("Направленный свет 1")
		["linkToSrc",[0,-0.299999,-0.0999985]],
		["setOrient",[0,-27.602,0]],
		["setLightColor",[0.6196,0.8745,1]],
		["setLightAmbient",[0.35,0.4,0.4]],
		["setLightIntensity",20000],
		["setLightAttenuation",[0,0,0,0,10,20]],
		["setLightConePars",[50,40,0]]
	]
	,[
		"lt",
		null,
		_emitAlias("Точечный свет 2")
		["linkToLight",[3.8147e-06,-0.399998,-0.0319977]],
		["setLightColor",[1,1,1]],
		["setLightAmbient",[0.05,0.05,0.05]],
		["setLightIntensity",500],
		["setLightAttenuation",[0,0,0,0,0.3,0.5]]
	]
	,[
		"ltd",
		null,
		_emitAlias("Направленный свет 3")
		["linkToLight",[0,-0.299999,-0.0999985]],
		["setOrient",[0,-27.602,0]],
		["setLightColor",[0.6196,0.8745,1]],
		["setLightAmbient",[0.35,0.4,0.4]],
		["setLightIntensity",100],
		["setLightUseFlare",true],
		["setLightFlareSize",10],
		["setLightFlareMaxDistance",30],
		["setLightAttenuation",[0,0,0,0,10,20]],
		["setLightConePars",[100,90,0]]
	]
endScriptEmit