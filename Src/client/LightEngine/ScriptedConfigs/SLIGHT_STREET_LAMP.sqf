// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

regScriptEmit(SLIGHT_STREET_LAMP)
	[
		"ltd",
		[["scr_volume_shape",["a3\data_f\volumelightflashlight", [4, 3, 4]]]],
		_emitAlias("Направленный свет 1")
		["linkToSrc",[0,0,3.4]],
		["setOrient",[0,-90,0]],
		["setLightColor",[0.7,0.55,0.5]],
		["setLightIntensity",8000],
		["setLightUseFlare",true],
		["setLightFlareSize",0.5],
		["setLightFlareMaxDistance",30],
		["setLightAttenuation",[0,0,0,0,12,14]],
		["setLightConePars",[360,50,5]]
	]
endScriptEmit