// ======================================================
// Copyright (c) 2017-2025 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

regScriptEmit(SLIGHT_LEGACY_SIGN_BAR)
	[
		"lt",
		null,
		_emitAlias("Свет-todo-addblink_handler")
		["linkToSrc",[0,0,0]],
		["setLightColor",[0.013,0.001,0]],
		["setLightAmbient",[0.013,0.001,0]],
		["setLightIntensity",562500],
		["setLightAttenuation",[0,50,3,700,4,1]]
	]
endScriptEmit