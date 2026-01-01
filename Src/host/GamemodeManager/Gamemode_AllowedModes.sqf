// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

//!this define is deprecated
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

//actual define
call {
	//TODO replace class generator
	
	private _classlist = ["gmbase",true] call oop_getinhlist;
	if (!isMultiplayer) exitwith {
		gm_allowedModes = _classlist;
	};
	private _gmblacklist = ["ScriptedGamemode"] apply {tolower _x};
	private _setter = [];
	{
		private _isplayable = getFieldBaseValueWithMethod(_x,"","isPlayableGamemode");
		if ((tolower _x) in _gmblacklist) then {_isplayable = false}; //check blacklisted gamemodes
		if (!isNullVar(_isplayable) && {_isplayable}) then {
			_setter pushBackUnique _x;
		};
	} foreach _classlist;
	gm_allowedModes = _setter;
};