// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include "..\..\host\lang.hpp"

namespace(InteractMenu,interactMenu_)

#include <interactMenu.hpp>

decl(void())
interactMenu_onUpdateSkills = {

	if (!interact_isOpenMousemode) exitWith {};

	{
		_x params ["_base","_bon"];
		_curW = interactMenu_skillWidgets select _forEachindex;
		_skillName = interactMenu_skillNames select _forEachindex;


		_bonText = if (_bon == 0) then {""} else {
			MOD(_base,+_bon max 0);
			if (_bon > 0) exitWith {
				""
			};
			" ("+ str _bon + ")"
		};
		_base = str _base;

		setAttrText(_curW,_skillName + ": " + _base,_bonText);

	} foreach cd_skills;
};

//Запрос на получение воспоминаний
decl(void(int))
interactMenu_getMemories = {
	params ["_mode"];
	if (["im_getmemories",1] call input_spamProtect) exitWith {};

	rpcSendToServer("getmemories",[player arg _mode]);
};

/*
================================================================================
		GROUP: CLIENTSIDE SETTER ALG
================================================================================
*/

decl(void(int;int))
interactMenu_setSelection = {
	params ["_id","_button"];
	//Запрещённое действие при стане
	if (call smd_isStunned) exitWith {};
	if (["pressSelection",0.2] call input_spamProtect) exitWith {};
	if (_button == MOUSE_RIGHT) then {
		_id = TARGET_ZONE_RANDOM;
	};
	if equals(cd_curSelection,_id) exitWith {}; //already setted
	
	rpcSendToServer("onUpdateSelection",[player arg _id]);
};

decl(void())
interactMenu_syncCurSelection = {
	if (!interact_isOpenMousemode) exitWith {};
	private _sel = cd_curSelection;
	if (_sel == TARGET_ZONE_RANDOM) then {
		{
			_x setFade FADE_FOR_SELECTED;
			_x commit TIME_TO_INFADE;
		} foreach interactMenu_selectionWidgets;
	} else {
		private _curWid = interactMenu_activeSelectionWidget select 0;
		{
			if equals(_sel,_x getVariable vec2("id",-10)) then {
				//trace("EQUAL " + ctrlText  _x)
				_x setFade FADE_FOR_SELECTED;
				_x commit TIME_TO_INFADE;
			} else {
				//trace("NON-EQUAL " + ctrlText  _x)
				_x setFade 0;
				_x commit TIME_TO_INFADE;
			};
		} foreach interactMenu_selectionWidgets;
	};
};

decl(void(widget;int))
interactMenu_onPressSpecAct = {
	params ["_ct","_butt"];

	//Запрещённое действие при стане
	if (call smd_isStunned) exitWith {};
	if (["pressSpecAct",0.2] call input_spamProtect) exitWith {};
	private _newAct = _ct getvariable ['action',SPECIAL_ACTION_NO];
	private _isPlayingAction = (_ct getvariable ["actionType",ACTION_SWITCHABLE]) == ACTION_PLAYING;
	if (_ct getvariable ['isActive',false]) then {
		//установить деактив
		_newAct = SPECIAL_ACTION_NO;
	};
	private _args = [player arg _newAct arg _isPlayingAction];
	if (_newAct == SPECIAL_ACTION_STEALTH) then {
		_args pushBack (call os_light_getLighting);
	};
	rpcSendToServer("onUpdateSpecAct",_args);
};
