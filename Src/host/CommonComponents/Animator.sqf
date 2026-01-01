// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\engine.hpp>
#include <..\ServerRpc\serverRpc.hpp>

#ifndef ANIMATOR_EDITOR

#define addAnim(name) INC(__animIndex); anim_assocList_keyString set [name,__animIndex]; anim_assocList_keyInt set [__animIndex,name]
anim_assocList_keyString = createHashMap; 
anim_assocList_keyInt = createHashMap;
__animIndex = 0;

addAnim("xlamdoor");
addAnim("traindoor");
addAnim("door_solar");
addAnim("plomba5");
addAnim("reshotks");
addAnim("doorvlk1");
addAnim("doorvlk2");
addAnim("door_1_rot");
addAnim("door_2_rot");
addAnim("door_3_rot");

//конвертор ассоциаций 
anim_getAssoc = {
	params ["_value"];
	
	private _hashmap = if equalTypes(_value,"") then {anim_assocList_keyString} else {anim_assocList_keyInt};
	
	private _dat = _hashmap get _value;
	if isNullVar(_dat) exitWith {
		warningformat("anim::getAssoc() - cant find assoc %1 by type %2",_value arg toLower typeName _value);
		_value;
	};
	
	_dat
};	


/*

	Обобщённые события ниже синхронизируются по сети и поддерживают JIP

*/

//резкая смена анимации
// СОХРАНЕНО ПО ОБРАТНОЙ СОВМЕСТИМОСТИ
_anim = {
	(_this select 0) switchmove (_this select 1)
}; rpcAddGlobal("switchMove",_anim);

//Плавная смена анимации
_anim = {
	(_this select 0) playMove (_this select 1)
}; rpcAddGlobal("playMove",_anim);

//установить мимику
_anim = {
	(_this select 0) setMimic (_this select 1)
}; rpcAddGlobal("setMimic",_anim);

#endif

// =============================================================================
// anim state sync
// =============================================================================
#include <..\GameObjects\Items\Item_HandAnim.hpp>
#include <..\..\client\Inventory\inventory.hpp>
#include <..\..\client\LightEngine\LightEngine.hpp>


anim_getUnitAnim = {animationState _this};

anim_isSprinting = { private _anm = _this call anim_getUnitAnim; "evas" in _anm || "sprs" in _anm };
anim_isRunning = { private _anm = _this call anim_getUnitAnim; "tacs" in _anm || "runs" in _anm};
anim_isWalking = { "wlks" in (_this call anim_getUnitAnim)};

anim_syncAnim = {
	params ["_mob"];
	
	#ifndef ANIMATOR_EDITOR
	if (!local _mob) exitWith {
		errorformat("anim::syncAnim() - Generic locality error. Mob is not local - %1",_mob);
	};
	#endif
	/*if (_mob getVariable ["__SMDINT_isSupressedAnimSync",false]) exitWith {
		invokeAfterDelayParams(anim_syncAnim,_mob getVariable "__SMDINT_animSyncCallAfter",_this);
	};*/
	
/*	private _handleAnim = _mob getVariable ["__local_animHandler",-1];
	if (_handleAnim == -1) then {
		//add Animator
		private _handle = _mob ADDEVENTHANDLER ["AnimStateChanged",anim_onChangeAnimState];
		_mob setVariable ["__local_animHandler",_handle];
	};*/
	
	//(_mob getVariable ["smd_bodyParts",[true,true,true,true]]) params ["_hasRA","_hasLA","_hasRL","_hasLL"];
	
	/*
		Global conditions:
		item in hand ?? 
			anim to item
			
			item is only handed anim ?? 
				blend to "05"
			:
				blend to 1
		:
			combat mode ??
				anim set combat anim
				blend to 0
		

		
		is sitting ??
			blend to 0
		:
			no action
		
		has body part ??
			if no items in hand
				blend to 0
		:
			blend to 1
			anim to NPART
	*/
	
	private _isCombatModeEnabled = [_mob] call smd_isCombatModeEnabled;
	private _isTwoHanded = [_mob] call smd_isTwoHandedModeEnabled;
	
	private _categ = [ANIM_INDEX_HANDED,ANIM_INDEX_COMBAT] select _isCombatModeEnabled;
	private _lhand = [_mob,INV_HAND_L,_categ] call smd_getAnimValue;
	private _rhand = [_mob,INV_HAND_R,_categ] call smd_getAnimValue;

	private _anims = ["na","na","nl","nl"]; //! НЕ МЕНЯТЬ НАЗВАНИЕ ПЕРЕМЕННОЙ
	private _noPartAnims = +_anims;
	private _blender = [0,0,0,0]; //! НЕ МЕНЯТЬ НАЗВАНИЕ ПЕРЕМЕННОЙ
	private _itemsState = [_rhand,_lhand]; 
	private _isSitting = [_mob] call smd_isSitting;
	private _canUseInstant = !isNullVar(_isBodyPartsChanged);
	private _needInstantSet = false;
	
	private _refAnmHelp = ifcheck(_isTwoHanded,ITEM_TWOHANDANIM_LIST_ALLANIMS,ITEM_HANDANIM_LIST_ALLANIMS);
	private _refAnmHarm = ifcheck(_isTwoHanded,ITEM_TWOHANDCOMBATANIM_LIST_ALLANIMS,ITEM_COMBATANIM_LIST_ALLANIMS);
	private _refNonFullBlend = ifcheck(_isTwoHanded,ITEM_2HANDANIM_NOFULLBLEND_LIST,ITEM_HANDANIM_NOFULLBLEND_LIST);
	
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
	} foreach (_mob getVariable ["smd_bodyParts",[true,true,true,true]]);
	
	private _prefix = ""; //! НЕ МЕНЯТЬ НАЗВАНИЕ ПЕРЕМЕННОЙ
	if (_isTwoHanded) then {
		_prefix = ifcheck(_isCombatModeEnabled,"com_TW","TW");
	};
	
	//моддим стейт для связки
	if ([_mob] call smd_isCustomAnimationEnabled) then {
		call smd_internal_generateCustomAnimation;
	};

	private _stack = [_prefix+"%1R%2L%3R%4L_%5%6%7%8"];
	_stack append _anims;
	_stack append _blender;
	
	private _finalState = format _stack;
	
	//После конца активного действия (прим. атака) всё само вернётся на свои места...
	if !(_mob getVariable ["__SMDINT_isSupressedAnimSync",false]) then {
		if (_needInstantSet && _canUseInstant) then {
			_mob playActionNow "gibs"; //good save us
		};	
		_mob playActionNow _finalState;
	};

	_mob setvariable ["__laststate",_finalState,true];
	_mob setVariable ["__laststatehnds",format["%1|%2",_anims select 1,_anims select 0],true]; //left|right
	
	//Клиентский флаг для проверки форсвалка
	if !isNullVar(_flag_check_canwalk_local_player) then {
		#define __compareanims(idx) ((_anims select idx) == "nl" && ((_blender select idx) == 1))
		cd_fw_forceWalk = (__compareanims(2) || __compareanims(3));
		if ([_mob,"VST_GHOST_EFFECT"] call vst_containsConfig) then {
			cd_fw_forceWalk = false;
		};
		_mob call cd_fw_syncForceWalk;
	};	
	
	#ifdef DEBUG
	warningformat("Applied %1 to %2 (is sitting %3)",_finalState arg _mob arg [_mob] call smd_isSitting);
	#endif
	_finalState
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
	#ifndef ANIMATOR_EDITOR
	invokeAfterDelayParams(_onEndAnim,0.4,[_mob]);
	#endif
	
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
	#ifndef ANIMATOR_EDITOR
	invokeAfterDelayParams(_onEndAnim,0.4,[_mob]);
	#endif
};


//! todo implement new attaching logics

//с помощью этого метода можно контролирвать анимированные атачи
anim_addAttach = {
	params ["_dest","_ctxAtt"];
	_dest attachTo _ctxAtt;
	private _mob = _ctxAtt select 0;
	private _fd = _mob getvariable "__anim_internal_att_frdt";
	if isNullVar(_fd) then {
		_fd = createhashMap;
		_mob setvariable ["__anim_internal_att_frdt",_fd];
	};
	_fd set [hashValue _dest,[_dest,_ctxAtt]];
};

anim_removeAttach = {
	params ["_dest","_src"];
	private _fd = _src getvariable "__anim_internal_att_frdt";
	if isNullVar(_fd) exitWith {};
	_fd deleteAt (hashValue _src);
};

anim_syncOnFrameAttaches = {
	params ["_mob"];
	//{_x setposatl (getposatl _x); _x attachto [_obj,[0,0,0],"head",true]} foreach (attachedobjects _obj);
	{
		_y params ["_dt","_ca"];
		_dt setposatl (getposatl _dt);
		_dt attachto _ca;
	} foreach (_mob getvariable "__anim_internal_att_frdt");
};