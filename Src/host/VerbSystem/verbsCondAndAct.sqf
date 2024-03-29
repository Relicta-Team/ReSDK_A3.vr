// ======================================================
// Copyright (c) 2017-2024 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <verbsCondAndAct.h>

/*
VERB(class)
	act
		// code here
	cond
		// code here
ENDVERB
*/

VERB(description)
	act
		private _text = callSelfParams(getDescFor,usr);
		if (_text == "") exitWith {};
		rpcSendToObject(callbackObject,"chatPrint",[_text arg "info"]);

ENDVERB

/*VERB(changeatt)
	act
		callFuncParams(usr,onChangeAttackType,"next");
	cond
		//не в руках
		skipCond(!array_exists(INV_LIST_HANDS,getVar(src,slot)));

		//много режимов атаки
		private _wm = callFunc(src,getItemWeapon);
		skipCond(isNullReference(_wm));
		skipCond(count getVar(_wm,attackType) <= 1);
ENDVERB*/

VERB(standupfromchair)
	cond
		skipCond(not_equals(usr,src));
		skipCond(!callFunc(usr,isMob));
		skipCond(!isTypeOf(usr,Mob));
		skipCond(!callFunc(usr,isConnected));
	act
		if callSelf(isConnected) then {
			callSelf(disconnectFromSeat);
		};
ENDVERB

VERB(undress)
	cond
		skipCond(!callFunc(src,isMob));
		skipCond(!isTypeOf(usr,Mob));
		skipCond(isImplementFunc(src,onEaterSniff)); //жрунов нельзя раздеть/одеть
		skipCond(callFunc(src,isActive) && !callFunc(src,isHandcuffed));
		skipCond(equals(usr,src));
	act
		callFuncParams(usr,startUndress,src);
ENDVERB

VERB(transitem)
	cond
		skipCond(!callFunc(src,isMob));
		skipCond(!isTypeOf(usr,Mob));
		skipCond(isNullReference(callFunc(usr,getItemInActiveHandRedirect)));
		skipCond(!callFunc(src,isActive));
		skipCond(equals(usr,src));
	act
		private _it = callFunc(usr,getItemInActiveHandRedirect);
		if isNullReference(_it) exitwith {
			callFuncParams(usr,localSay,"Что-то не вышло." arg "error");
		};
		private _stackCheck = [getVar(usr,activeHand),callFunc(usr,getNotActiveHand)];
		private _stackSlot = -1;
		{
			_stackSlot = _x;
			if callFuncParams(usr,transferItemToTarget,_it arg src arg _stackSlot) exitWith {
				callFuncParams(usr,meSay,"отдаёт " + callFunc(_it,getName) + " " + callFuncParams(src,getNameEx,"кому"));
			};
		} foreach _stackCheck;
		
	name
		private _it = callFunc(usr,getItemInActiveHandRedirect);
		if !isNullReference(_it) then {
			setName("Передать " + callFunc(_it,getName));
		};

ENDVERB

VERB(pickup)
	act
		callFunc(usr,generateLastInteractOnServer);
		callFuncParams(usr,pickupItem,src);
	cond
		skipCond(!isTypeOf(usr,Mob));
		skipCond(!callFunc(usr,isEmptyActiveHand));
ENDVERB

VERB(smell)

ENDVERB

VERB(clean)

ENDVERB

VERB(doempty)
	cond
		FLAGS(F_INUSR);
		skipCond(!isTypeOf(usr,Mob));
		skipCond(callSelf(getFilledSpace) == 0);
		skipCond(!callSelf(isTrasferize));
	act
		callSelf(pourOutReagents);
ENDVERB

VERB(craft)
	cond
		skipCond(!isTypeOf(usr,Mob));
		skipCond(!callSelf(canUseAsCraftSpace));
	act
		[src,usr] call craft_requestOpenMenu;
ENDVERB

VERB(twohands)
	cond
		skipCond(!isTypeOf(usr,Mob));
		skipCond(!equals(getSelf(loc),usr));
		skipCond(!array_exists(vec2(INV_HAND_R,INV_HAND_L),getSelf(slot)));
		//private _otherSlot = ifcheck(getSelf(slot)==INV_HAND_R,INV_HAND_L,INV_HAND_R);
		//private _hold = callFuncParams(usr,isHoldedTwoHands,src);
		//skipCond(!callFuncParams(usr,isEmptySlot,_otherSlot));
	act
		callFuncParams(usr,onTwoHand,src);
	name
		if callFuncParams(usr,isHoldedTwoHands,src) exitWith {setName("Одной рукой")};
ENDVERB

VERB(mainact)
	cond
		skipCond("*UNDECL*" in (toString getFunc(src,onMainAction)));
		skipCond(!callFunc(src,canUseMainAction));
		skipCond(isTypeOf(usr,Mob) && callFunc(usr,isHandcuffed)); //защита от вебрдействий в наручниках
	act
		callFuncParams(src,onMainAction,usr);
	name
		_t = callFunc(src,getMainActionName);
		if (_t!="")then{setName(_t)};
ENDVERB

VERB(wpnopnmode)
	cond
		skipCond(!isTypeOf(usr,Mob));
		skipCond(!isImplementFunc(src,onWeaponOpenModeChange));
		skipCond(callFunc(usr,isHandcuffed));
	act
		callFuncParams(src,onWeaponOpenModeChange,usr);
	name
		setName(callFunc(src,getWeaponOpenModeChangeText));
ENDVERB

VERB(spinrev)
	cond
		skipCond(!isTypeOf(usr,Mob));
		skipCond(!callFunc(src,hasMagazine));
		skipCond(callFunc(usr,isHandcuffed));
	act
		callFuncParams(src,spinDrum,usr);
ENDVERB

VERB(dropammorev)
	cond
		skipCond(!isTypeOf(usr,Mob));
		skipCond(callFunc(src,isInWorld));
		skipCond(!callFunc(src,hasMagazine));
		skipCond(!getVar(src,isOpened));
	act
		callFuncParams(src,freeDrum,usr);
	name
		if (isImplementFunc(src,dropammorev_name)) then {
			setName(callFunc(src,dropammorev_name));
		};
ENDVERB

VERB(showOrgans)
	cond
		skipCond(callFunc(usr,isHandcuffed));
		private _tz = getVar(usr,curTargZone);
		_bp = [_tz] call gurps_convertTargetZoneToBodyPart;
		skipCond(!callSelfParams(hasPart,_bp));
		_part = callSelfParams(getPart,_bp);	
		skipCond(!isTypeOf(_part,Body) || {!callFunc(_part,isOpened)});
	act
		private _tz = getVar(usr,curTargZone);
		_bp = [_tz] call gurps_convertTargetZoneToBodyPart;
		skipCond(!callSelfParams(hasPart,_bp));
		_part = callSelfParams(getPart,_bp);	
		skipCond(!isTypeOf(_part,Body) || {!callFunc(_part,isOpened)});
		callFuncParams(_part,showOrgans,_usr);
ENDVERB