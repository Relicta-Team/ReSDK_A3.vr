// ======================================================
// Copyright (c) 2017-2024 the ReSDK_A3 project
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
	if (!isMultiplayer) exitwith {
		gm_allowedModes = _classlist;
	};
	private _setter = [];
	{
		private _isplayable = getFieldBaseValueWithMethod(_x,"","isPlayableGamemode");
		if (!isNullVar(_isplayable) && {_isplayable}) then {
			_setter pushBackUnique _x;
		};
	} foreach _classlist;
	gm_allowedModes = _setter;
};