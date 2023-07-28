// ======================================================
// Copyright (c) 2017-2023 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

gm_allowedModes = [
	//тестовый режим существует только в редакторе
	#ifdef EDITOR
	"GMTemplate",
	#endif
	"GMExtended",
	"GMOldNewOrder",
	"GMTVTGame",
	"GMDetective",
	"GMSaloon",
	"GMPrey",
	"GMOkopovo"
	
];

call {
	//TODO replace class generator
	
	private _classlist = ["gmbase",true] call oop_getinhlist;
	private _setter = [];
	
	gm_allowedModes = _setter;
};