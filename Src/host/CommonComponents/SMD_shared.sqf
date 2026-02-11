// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\engine.hpp>
#include <..\..\client\Inventory\inventory.hpp>
#include <..\GameObjects\Items\Item_HandAnim.hpp>


smd_getAnimValue = {
	params ["_mob","_slot",["_animType",ANIM_INDEX_HANDED]];
	if !(_slot in INV_LIST_HANDS) exitWith {-1};
	private _slotDat = _mob getVariable ["smd_s"+str _slot,0];
	if equals(_slotDat,0) exitWith {-1};
	(_slotDat) select 1 select _animType
};

smd_isCombatModeEnabled = {params ["_mob"]; _mob getVariable ["smd_isCombat",false]};

smd_isTwoHandedModeEnabled = {
	params ["_mob"];
	private _count = 0; private _hasFindTHFlag = false;
	private _slotDat = 0;
	{
		//"#TH#"
		_slotDat = _mob getVariable ["smd_s"+str _x,0];
		if equals(_slotDat,0) exitWith {};
		INC(_count);
		if (equals(_slotDat select 0,"#TH#") && !_hasFindTHFlag) then {_hasFindTHFlag = true};
	} foreach [INV_HAND_R,INV_HAND_L];
	_count == 2 && _hasFindTHFlag
};

smd_isCustomAnimationEnabled = { params ["_mob"]; not_equals(_mob getvariable vec2("smd_custAnm",0),0)};

smd_internal_generateCustomAnimation = {
	params ["_mob"];
	//! WARNING ! - В этой функции используются локальные переменные, определенные в функции anim_syncAnim()
	/*
		Внешние определения:
		vec4<string> _anims - название анимаций
		vec4<float> _blender - режимы подмешивания
		string _prefix - опциональный префикс
	*/
	(_mob getvariable "smd_custAnm") params [["_ani",_anims],["_blen",_blender],["_prfx",_prefix]];
	{
		if isNullVar(_x) then {continue};
		_anims set [_forEachIndex,_x];
	} foreach _ani;
	{
		if isNullVar(_x) then {continue};
		_blender set [_forEachIndex,_x];
	} foreach _blen;
	_prefix = _prfx;
};

smd_isSitting = {
	params ["_mob"];
	equals(TYPEOF(attachedto _mob),"C_Quadbike_01_F")
};

smd_isLyingOnBed = {
	params ["_mob"];
	[_mob] call smd_isSitting && {equals((attachedto _mob) getVariable vec2("sitmode",""),"bed")}
};