// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

regScriptEmit(SLIGHT_TEMPLATE_POINTLIGHT)
	[
		"lt",
		null,
		_emitAlias("Источник")
		["linkToSrc",[0,0,0]],
		["setLightColor",[0.17,0.82,0.33]],
		["setLightIntensity",1000],
		["setLightAttenuation",[3,0,10,8,5,8]]
	]
endScriptEmit