// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

function(prox_getAnimStateCfg)
{	
	private _comb = prox_isCombat;
	private _state = prox_statePref select prox_currentStance;
	private _mov = prox_movePref select prox_curMoveSpeed;
	private _wpnState = prox_wpnStatePref select prox_wpnState;
	private _wpnPref = prox_wpnPref select _comb;
	private _mvDir = prox_moveDirPref select prox_moveDir;

	if (!_comb) then {
		_wpnState = "Snon";
		_wpnPref = "Wnon";
	};
	if (prox_curMoveSpeed==0) then {
		_mvDir = "Dnon";
	};
	if (!("Df" in _mvDir) && prox_curMoveSpeed==3) then {
		_mov = prox_movePref select 2;
	};
	if (prox_currentStance==2) then {
		// move: AmovPpneMwlkSoptWbinDbr
		// stopcomb: AmovPpneMstpSrasWpstDnon
		// stopnocomb: AmovPpneMstpSnonWnonDnon
		_wpnState
	};

	private _arr = [prox_stateConstFormatter];
	_arr append [_state,_mov,_wpnState,_wpnPref,_mvDir];
	
	["Anim state now %1 (%2)",format _arr,[(str _arr),"%","$"] call stringReplace] call printTrace;

	format _arr;
}

function(prox_syncAnim)
{
	private _unit = prox_targetObj;
	if (prox_isCombat) then {
		_unit addWeapon "CombatMode";
		_unit selectWeapon (handgunWeapon _unit);
	} else {
		_unit removeWeapon "CombatMode";
	};
	_unit switchMove (call prox_getAnimStateCfg);

	call prox_syncHandAnimations;
}

function(prox_anim_switchLegState)
{
	params ["_ct","_bt"];
	private _stateName = _ct getvariable "name";
	if !("switch_leg_" in _stateName) exitWith {};
	private _idx = _ct getvariable "idxSetvar";
	private _oldval = prox_anim_partsExists select _idx;
	prox_anim_partsExists set [_idx,!_oldval];
	call prox_syncAnim;
}

//вызывается при изменении состояния анимации
function(prox_anim_switchState)
{
	params ["_ct","_bt"];

	private _stateName = _ct getvariable "sysname";
	prox_map_currentAnimListMode = _stateName;
	prox_isCombat = _stateName in ["combat","attack","parry"];

	[prox_widgetStateNameRef select 0,
		format["<t align='center'>Текущий сет: %1</t>",_ct getvariable ["name","НЕИЗВЕСТНО"]]
	] call widgetSetText;

	call prox_syncAnim;
	call prox_anim_loadHandWidgets;
}


//перезагруказ слотов инвентаря
function(prox_anim_loadHandWidgets)
{
	/*

	*/
	// private _anims = ["na","na","nl","nl"];
	// private _noPartAnims = +_anims;
	// private _blender = [0,0,0,0];
	
	private _anims = [];
	
	private _isTwoHanded = prox_isTwoHanded;
	private _showLeftHand = !_isTwoHanded;

	if (prox_map_currentAnimListMode=="normal") then {
		_anims = __ITEM_HANDANIM_LIST_NAMESTRUCT;//default animlist
		if (_isTwoHanded) then {
			_anims = __ITEM_TWOHANDANIM_LIST_NAMESTRUCT;
		};
	};
	//prox_map_currentAnimListMode-> normal, combat, attack, parry
	if (prox_map_currentAnimListMode=="combat") then {
		_anims = __ITEM_COMBATANIM_LIST_NAMESTRUCT;
		if (_isTwoHanded) then {
			_anims = __ITEM_2HANIM_COMBAT_LIST_NAMESTRUCT;
		};
	};
	if (prox_map_currentAnimListMode=="attack") then {
		_anims = __ITEM_COMBATANIM_LIST_NAMESTRUCT;
		if (_isTwoHanded) then {
			_anims = __ITEM_2HANIM_COMBAT_LIST_NAMESTRUCT;
		};
	};
	if (prox_map_currentAnimListMode=="parry") then {
		_anims = __ITEM_PARRY_LIST_NAMESTRUCT;
		if (_isTwoHanded) then {
			_anims = __ITEM_TWOHANDANIM_PARRY_LIST_NAMESTRUCT;
		};
	};

	["widgetanims: %1",_anims] call printTrace;

	{
		private _list = _x;
		lbclear _list;

		{
			(_x splitString ":") params ["_name","_strEnum"];
			private _itm = _list lbAdd _name;
			_list lbsetdata [_itm,_strEnum];
		} foreach _anims;

		if (_foreachIndex==0) then {
			_list ctrlShow (!_isTwoHanded);
			_list ctrlEnable (!_isTwoHanded);
		};
		_list lbSetCurSel -1;
	} foreach prox_widgetsHands;

	prox_anim_handEnumStates = prox_anim_handEnumStates apply {-1};
}

function(prox_syncHandAnimations)
{

	private _isCombat = prox_isCombat;
	private _isTH = prox_isTwoHanded;
	private _curState = prox_map_currentAnimListMode;
	if (_curState in ["normal","combat"]) then {
		[prox_targetObj] call anim_syncAnim;
	};

	private _slotIdx = INV_HAND_R;
	private _objInHand = (prox_slotListData select prox_curSelection select PROX_SDATA_INDEX_ID) == _slotIdx;
	private _enumAtt = if (_objInHand) then {
		prox_anim_handEnumStates select ifcheck(_slotIdx==INV_HAND_R,0,1);
	} else {
		ITEM_COMBATANIM_HAND
	};
	if (_curState == "attack") then {
		
		
		[prox_targetObj,_slotIdx,_enumAtt] call anim_doAttack;
	};
	if (_curState == "parry") then {
		private _idxHand = 0;//l,r?
		if (prox_isTwoHanded) then {_idxHand = -1};
		[prox_targetObj,_idxHand,_enumAtt] call anim_doParry;
	};
}