// ======================================================
// Copyright (c) 2017-2024 the ReSDK_A3 project
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
	private _oldval = prox_anim_legsExists select _idx;
	prox_anim_legsExists set [_idx,!_oldval];
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
	} foreach prox_widgetsHands;
}

function(prox_syncHandAnimations)
{

	private _isCombat = prox_isCombat;
	private _isTH = prox_isTwoHanded;
	private _curState = prox_map_currentAnimListMode;
	if (_curState in ["normal","combat"]) then {
		call prox_animHands_playNormal;
	};
	if (_curState == "attack") then {
		call prox_animHands_playAttack;
	};
}

function(prox_animHands_playNormal)
{
	private _mob = prox_targetObj;
	
	private _isCombatModeEnabled = prox_isCombat;
	private _isTwoHanded = prox_isTwoHanded;
	
	private _categ = [ANIM_INDEX_HANDED,ANIM_INDEX_COMBAT] select _isCombatModeEnabled;

	private _anims = ["na","na","nl","nl"]; //! НЕ МЕНЯТЬ НАЗВАНИЕ ПЕРЕМЕННОЙ
	private _noPartAnims = +_anims;
	private _blender = [0,0,0,0]; //! НЕ МЕНЯТЬ НАЗВАНИЕ ПЕРЕМЕННОЙ
	private _itemsState = +prox_anim_handEnumStates; //[_rhand,_lhand]; 
	private _isSitting = false;
	private _canUseInstant = false;// !isNullVar(_isBodyPartsChanged);
	private _needInstantSet = false;
	
	private _refAnmHelp = ifcheck(_isTwoHanded,ITEM_TWOHANDANIM_LIST_ALLANIMS,ITEM_HANDANIM_LIST_ALLANIMS);
	private _refAnmHarm = ifcheck(_isTwoHanded,ITEM_TWOHANDCOMBATANIM_LIST_ALLANIMS,ITEM_COMBATANIM_LIST_ALLANIMS);
	private _refNonFullBlend = ifcheck(_isTwoHanded,ITEM_2HANDANIM_NOFULLBLEND_LIST,ITEM_HANDANIM_NOFULLBLEND_LIST);
	
	if (_isTwoHanded) then {
		_itemsState set [1,_itemsState select 0];
	};

	{
		//has item
		if (_x > -1) then {
			if (_isCombatModeEnabled) then {
				_anims set [_forEachIndex,_refAnmHarm select _x];
				_blender set [_forEachIndex,1];
			} else {
				//non combat
				_anims set [_forEachIndex,_refAnmHelp select _x];
				if (_x in _refNonFullBlend) then {
					_blender set [_forEachIndex,"05"];
				} else {
					_blender set [_forEachIndex,1];
				};
			};
			
		} else {
			// already setted
			if (_isCombatModeEnabled) then {
				_anims set [_forEachIndex,_refAnmHarm select ITEM_COMBATANIM_HAND];
				_blender set [_forEachIndex,1];
			};
		};
		
		if (_isSitting && !_isCombatModeEnabled && !_isTwoHanded) then {
			_blender set [_forEachIndex,"05"];
			_anims set [_forEachIndex,_refAnmHelp select ITEM_HANDANIM_LOWERONLYHAND];
			//_blender set [_forEachIndex,0];
		};
	} foreach _itemsState;
	
	{
		if (_x) then {
			if (_isCombatModeEnabled) exitWith {}; //only handed 
			if (_forEachIndex <= 1 && {_itemsState select _forEachIndex == -1}) then {
				_blender set [_forEachIndex,0];
			};	
		} else {
			if (!_needInstantSet) then {_needInstantSet = true};
			
			_blender set [_forEachIndex,1];
			_anims set [_forEachIndex,_noPartAnims select _forEachIndex];
		};
	} foreach [true,true,prox_anim_legsExists select 0,prox_anim_legsExists select 1];//(_mob getVariable ["smd_bodyParts",[true,true,true,true]]);
	
	private _prefix = ""; //! НЕ МЕНЯТЬ НАЗВАНИЕ ПЕРЕМЕННОЙ
	if (_isTwoHanded) then {
		_prefix = ifcheck(_isCombatModeEnabled,"com_TW","TW");
	};
	
	//моддим стейт для связки
	// if ([_mob] call smd_isCustomAnimationEnabled) then {
	// 	call smd_internal_generateCustomAnimation;
	// };

	private _stack = [_prefix+"%1R%2L%3R%4L_%5%6%7%8"];
	_stack append _anims;
	_stack append _blender;
	
	private _finalState = format _stack;

	["Gesture normal %1",_finalState] call printTrace;
	
	//После конца активного действия (прим. атака) всё само вернётся на свои места...
	_mob playActionNow _finalState;
}

function(prox_animHands_playAttack)
{
	private _slotIdx = INV_HAND_R;
	
	// private _enum = if isTypeOf(_attWeapon,Item) then {
	// 	callFuncReflect(_attWeapon,ifcheck(callSelfParams(isHoldedTwoHands,_attWeapon),"getTwoHandAnim","getCombAnim"));
	// } else {
		
	// 	if isTypeOf(_attWeapon,Fists) then {
	// 			ITEM_COMBATANIM_HAND
	// 	} else {
	// 		private _itm = getSelf(slots) getOrDefault vec2(getSelf(activeHand),nullPtr);
	// 		callFuncReflect(_itm,ifcheck(callSelfParams(isHoldedTwoHands,_itm),"getTwoHandAnim","getCombAnim"));
	// 	};
	// };
	private _objInHand = (prox_slotListData select prox_curSelection select PROX_SDATA_INDEX_ID) == _slotIdx;
	private _enumAtt = if (_objInHand) then {
		prox_anim_handEnumStates select ifcheck(_slotIdx==INV_HAND_R,0,1);
	} else {
		ITEM_COMBATANIM_HAND
	};
	
	private _mob = prox_targetObj;
	
	private _laststate = _mob getVariable ["__laststate","naRnaLnlRnlL_1111"];

	private _isTwoHanded = prox_isTwoHanded;
	if (_isTwoHanded) then {_laststate = "com_TW" + _laststate};
	
	private _blend = (_laststate splitString "_") select ifcheck(_isTwoHanded,2,1);
	
	// _blend = (_blend splitString "")apply{parseNumber _x};
	// if (_isTwoHanded) then {
	// 	_blend set [0,1];_blend set [1,1];
	// };
	// _blend set [2,ifcheck(prox_anim_legsExists select 0,  1,0)];
	// _blend set [3,(prox_anim_legsExists select 1,		1,0)];
	// _blend = _blend joinString "";
		
	
	private _attState = [ifcheck(_isTwoHanded,"att_TW","att_")+"%1R%2LnlRnlL_"+_blend];
	
	((_mob getVariable ["__laststatehnds","bck|bck"]) splitString "|")params ["_leftdef","_rightdef"];
	
	private _leftAnm = null;
	private _rightAnm = null;
	private _hasLA = true; 
	private _hasRA = true;

	private _refStates = ifcheck(_isTwoHanded,ITEM_TWOHANDATTACKANIM_LIST_ALLANIMS,ITEM_ATTACKANIM_LIST_ALLANIMS);
	if (_slotIdx == INV_HAND_R) then {
		_rightAnm = _refStates select _enumAtt;
		_leftAnm = ["na",ITEM_GET_OTHERHAND_ANIM(_rightAnm,_leftdef,_isTwoHanded)] select _hasLA;
	} else {
		_leftAnm = _refStates select _enumAtt;
		_rightAnm = ["na",ITEM_GET_OTHERHAND_ANIM(_leftAnm,_rightdef,_isTwoHanded)] select _hasRA;
	};

	if(_slotIdx==INV_HAND_R) then {
		_leftAnm = "bck";
	};

	_attState append [_rightAnm,_leftAnm];

	["Gesture attack %1 [%2,%3]",format _attState,_rightAnm,_leftAnm] call printTrace;

	_mob playActionNow (format _attState);
}

function(___prox_loader)
{
	
anim_syncAnim = {
	
};

anim_doAttack = {
	params ["_mob","_slotIdx","_enumAtt"];
	
	if (!local _mob) exitWith {
		errorformat("anim::doAttack() - Generic locality error. Mob is not local - %1",_mob);
	};
	
	if !(_slotIdx in INV_LIST_HANDS) exitWith {
		warningformat("anim::doAttack() - Argument error: %1",_slotIdx);
	};
	
	private _laststate = _mob getVariable ["__laststate","naRnaLnlRnlL_0000"];
	
	private _isTwoHanded = [_mob] call smd_isTwoHandedModeEnabled;
	
	private _blend = (_laststate splitString "_") select ifcheck(_isTwoHanded,2,1);
	
	(_mob getVariable ["smd_bodyParts",[true,true]]) params ["_hasRA","_hasLA"];	
	
	private _attState = [ifcheck(_isTwoHanded,"att_TW","att_")+"%1R%2LnlRnlL_"+_blend];
	
	((_mob getVariable ["__laststatehnds","bck|bck"]) splitString "|")params ["_leftdef","_rightdef"];
	
	private _leftAnm = null;
	private _rightAnm = null;
	
	private _refStates = ifcheck(_isTwoHanded,ITEM_TWOHANDATTACKANIM_LIST_ALLANIMS,ITEM_ATTACKANIM_LIST_ALLANIMS);
	if (_slotIdx == INV_HAND_R) then {
		_rightAnm = _refStates select _enumAtt;
		_leftAnm = ["na",ITEM_GET_OTHERHAND_ANIM(_rightAnm,_leftdef,_isTwoHanded)] select _hasLA;
	} else {
		_leftAnm = _refStates select _enumAtt;
		_rightAnm = ["na",ITEM_GET_OTHERHAND_ANIM(_leftAnm,_rightdef,_isTwoHanded)] select _hasRA;
	};
	
	_attState append [_rightAnm,_leftAnm];
	_mob playActionNow (format _attState);
	traceformat("[ANM_ATTACK]: Played: %1",format _attState)
	//reset anim
	private _onEndAnim = {
		params ["_mob"];
		
		_mob playActionNow (_mob getVariable ["__laststate","naRnaLnlRnlL_0000"])
	};	
	invokeAfterDelayParams(_onEndAnim,0.4,[_mob]);
	
}; 

anim_doDodge = {
	params ["_mob","_side"];
	//playing as bdy_dodbddghRddghLnlRnlL
	//bdy_dodbddghRddghLnlRnlL
	(_mob getVariable ["smd_bodyParts",[true,true,true,true]]) params ["_hasHndR","_hasHndL","_hasLR","_hasRR"];
	private _state = "";
	if (_hasHndR) then {modvar(_state)+"ddghR"} else {modvar(_state)+"naR"};
	if (_hasHndL) then {modvar(_state)+"ddghL"} else {modvar(_state)+"naL"};
	modvar(_state) + "nlRnlL_";
	private _fmt = "bdy_dod"+_side+_state+format["11%1%2",boolToInt(!_hasLR),boolToInt(!_hasRR)];
	_mob playActionNow _fmt;
	traceformat("[ANM_DODGE]: Played: %1",_fmt)
	//reset
	private _onEndAnim = {
		params ["_mob"];
		_mob playActionNow (_mob getVariable ["__laststate","naRnaLnlRnlL_0000"]);
	};
	invokeAfterDelayParams(_onEndAnim,0.4,[_mob]);
};

anim_doParry = {
	params ["_mob","_idxHand","_enumParry"];
	
	private _stateDat = ["naR","naL","nlR","nlL"];
	private _refparts = (_mob getVariable ["smd_bodyParts",[true,true,true,true]]);
	private _prefixAct = "par_";
	
	if equals(_idxHand,-1) then {
		//is twohanded action
		_prefixAct = "att_TW";
		private _reflist = ITEM_TWOHANDANIM_LIST_ALLANIMS;
		_stateDat set [0,(_reflist select _enumParry)+"R"];
		_stateDat set [1,(_reflist select _enumParry)+"L"];
	} else {
		private _addEnumPostfix = {ifcheck(_this==0,"R","L")};
		
		//если рука есть...
		if (_refparts select _idxHand) then {
			_stateDat set [_idxHand,ITEM_PARRY_ENUM_TO_ANIM(_enumParry) + (_idxHand call _addEnumPostfix)];
		};
		//проверка второй руки
		private _otheridx = ifcheck(_idxHand==0,1,0);
		if (_refparts select _otheridx) then {
			_stateDat set [_otheridx,"ddgh" + (_otheridx call _addEnumPostfix)];
		};
	};

	//чек ног
	private _fmt = _prefixAct+(_stateDat joinString "")+"_"+format["11%1%2",boolToInt(!(_refparts select 2)),boolToInt(!(_refparts select 3))];
	_mob playActionNow _fmt;
	traceformat("[ANM_PARRY]: Played: %1",_fmt)
	private _onEndAnim = {
		params ["_mob"];
		_mob playActionNow (_mob getVariable ["__laststate","naRnaLnlRnlL_0000"]);
	};
	invokeAfterDelayParams(_onEndAnim,0.4,[_mob]);
};
}