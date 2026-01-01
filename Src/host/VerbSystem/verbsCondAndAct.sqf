// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
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

VERB(description3d)
	cond
		skipCond(!isTypeOf(usr,Mob));
		skipCond(!isTypeOf(src,Item));
	act
		callSelfParams(examine3dItem,usr);
	name
		setName("Осмотреть");
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
		callFuncParams(usr,__setLastInteractDistance,0);//bypass check distance inside pickupitem()
		
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
		skipCond(!callSelf(isTransferize));
	act
		callSelf(pourOutReagents);
ENDVERB

VERB(extinguish)
	cond
		private _it = callFunc(usr,getItemInActiveHandRedirect);
		skipCond(isNullReference(_it));
		skipCond(isTypeOf(src,Mob));
		skipCond(!callFunc(_it,isReagentContainer));
		skipCond(isTypeOf(_it,Syringe));
		skipCond(callFunc(_it,getFilledSpace)==0);
	act
		private _it = callFunc(usr,getItemInActiveHandRedirect);
		if !isNullReference(_it) then {
			callFunc(usr,generateLastInteractOnServer);
			if callFuncParams(_it,doExtinguish,src arg callFunc(usr,getLastInteractEndPos)) then {
				callFuncParams(usr,meSay,"выливает " + callFunc(_it,getName) + " на " + callFunc(src,getName));
			};
		};
	name
		private _it = callFunc(usr,getItemInActiveHandRedirect);
		if !isNullReference(_it) then {
			private _pto = (pick["здесь","тут","сюда"]);
			setName("Вылить " + callFunc(_it,getName) + " " + _pto);
		};
ENDVERB

VERB(pull)
	cond
		skipCond(!isTypeOf(usr,Mob));
		skipCond(isTypeOf(src,BasicMob));
		skipCond(!callFunc(src,isMovable));

		//temporary object cannot be pulled more than 1 mobs
		private _pobj = callFunc(src,getPullMainOwner);
		skipCond(!(_pobj in vec2(usr,nullPtr)));
	act
		callFuncParams(usr,startGrab,src);
ENDVERB

VERB(pulltransform)
	cond
		skipCond(not_equals(usr,callFunc(src,getPullMainOwner)));
	act
		callFuncParams(src,openPullSettings,usr);
ENDVERB

VERB(craft)
	cond
		skipCond(!isTypeOf(usr,Mob));
		skipCond(!callSelf(canUseAsCraftSpace));
	act
		[src,usr] call craft_requestOpenMenu;
ENDVERB

VERB(craft_here)
	cond
		skipCond(!isTypeOf(usr,Mob));
		skipCond(getVar(usr,isCombatModeEnable));
	act
		[src,usr,!isNull(getSelf(craftComponent))] call csys_requestOpenMenu;
	name
		if !isNull(getSelf(craftComponent)) exitWith {setName("Вспомнить рецепты")};
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
		_isScript = callFunc(src,isScriptedObject);
		skipCond("*UNDECL*" in (toString getFunc(src,onMainAction)) && !_isScript);
		skipCond(!callFunc(src,canUseMainAction));
		skipCond(isTypeOf(usr,Mob) && callFunc(usr,isHandcuffed)); //защита от вебрдействий в наручниках
	act
		if callFunc(src,isScriptedObject) exitWith {
			callFuncParams(getVar(src,__script),onMainAction,usr);
		};
		callFuncParams(src,onMainAction,usr);
	name
		_t = "";
		if callFunc(src,isScriptedObject) then {
			_t = callFuncParams(getVar(src,__script),getMainActionName,usr);
		} else {
			_t = callFunc(src,getMainActionName);
		};
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