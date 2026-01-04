// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

//событие клика. если возвращает true то событие сбрасывается
var(__eventClick,[]);
func(resetEventClick) {objParams(); setSelf(__eventClick,[])};
func(addEventClick) {
	objParams_2(_name,_event);
	if isNullVar(_name) then {_name = "generated_" + str randInt(0,999999)};
	getSelf(__eventClick) pushBack [_name,_event];
};
func(removeEventClick)
{
	objParams_1(_name);
	private _list = getSelf(__eventClick);
	private _idx = _list findif {(_x select 0) == _name};
	if (_idx != -1) then {
		_list deleteAt _idx;
		true
	} else {
		false
	};
};
//Срабатывание системного события при клике. Например человек достает запрятанный предмет
func(callEventClick)
{
	objParams_2(_targ,_with);
	private _hasTarget = !isNullVar(_targ);
	private _hasItemInHand = !isNullVar(_with);
	private _events = getSelf(__eventClick);
	if (count _events == 0) exitwith {false};
	private _skipAction = false;
	{
		_x params ["_name","_code"];
		_skipAction = [this,_targ,_with] call _code;
	} foreach array_copy(_events);
	_skipAction
};


//main logic for clicking objects
func(clickTarget)
{
	objParams_1(_targ);
	//Нельзя взаимодейстсовать с пустой целью. TODo убрать когда будет огнестрел
	if isNullReference(_targ) exitWith {trace("NULLREF CLICK TARGET")};

	private _activeHand = getSelf(activeHand);
	private _activeHandIndexPart = if (_activeHand == INV_HAND_L) then {BP_INDEX_ARM_L} else {BP_INDEX_ARM_R};
	private _handcuffed = callSelf(isHandcuffed);
	private _isCombatAction = getSelf(isCombatModeEnable);

	//Не срабатывает и не нужно. на случай атаки какой-то другой частью(зубы, нога)
	//private _isSA = !isNullVar(__GLOBAL_FLAG_SPECACT_BITE__) || !isNullVar(__GLOBAL_FLAG_SPECACT_KICK__);
	if (!callSelfParams(hasPart,_activeHandIndexPart)) exitWith {}; //no acthand part

	private _item = callSelf(getItemInActiveHandRedirect);
	private _hasItemInActHand = not_equals(_item,nullPtr);
	private _itemIsTarget = equals(_item,_targ);
	private _isSelf = equals(_targ,this);
	traceformat("clickTarget logic: %1",vec3(this,_targ,_item))
	traceformat("ptrs: %1",vec3(getVar(this,pointer),getVar(_targ,pointer),getVar(_item,pointer)))
	//private _isInventoryAction =
	
	private _scriptOut = nullPtr;
	private __scriptRedirect = {
		if !isNullVar(__SKIP_CLICK_TARGET_FLAG__) exitWith {false};
		private _script = getVar(_targ,__script);
		if isNullVar(_script) exitWith {false};
		if isNullReference(_script) exitWith {false};
		_scriptOut = _script;
		traceformat("Script redirect success for %1 (%2)",_targ arg _script)
		true
	};
	
	#define callScriptedEvent(action__) if (call __scriptRedirect) exitWith {action__}
	
	//на мобов нельзя вешать скрипты
	if callFunc(_targ,isMob) exitWith {
		if (_handcuffed) exitwith {};
		
		assert_str(!(call __scriptRedirect),"Mob as target - cant have script");

		if (_isCombatAction) then {
			
			callSelfParams(setStealth,false);
			
			private _deleg_melee_attack = {
				
				if equals(_targ,this) then {
					callSelf(attackSelf);
				} else {
					callSelfParams(attackOtherMob,_targ);
				};
			};
			if isNullReference(_item) then _deleg_melee_attack else {
				if (isTypeOf(_item,IRangedWeapon) && {getVar(_item,isShootMode)}) then {
					if equals(_targ,this) then {
						callSelf(shootSelf);
					} else {
						callSelfParams(shootOtherMob,_targ);
					};
				} else _deleg_melee_attack;
			};


		} else {
			if (getSelf(lastActionTime) > tickTime) exitWith {};
			setSelf(lastActionTime,tickTime + 0.3);

			if (_hasItemInActHand) then {
				trace("MOB:onInteractWith() interact")
				callFuncParams(_targ,onInteractWith,_item arg this);
			} else {
				trace("MOB:onClick() INV CLICK")
				callFuncParams(_targ,onClick,this);
			};
		};
	};

	// here is target as item
	assert_str(!isTypeOf(_targ,BasicMob),"BasicMob condition missmatch");

	private _targLoc = getVar(_targ,loc);

	if (_isCombatAction) then {
		
		if (_handcuffed) exitwith {}; //no combat actions on handcuffed

		if (_hasItemInActHand) then {
			if (_itemIsTarget) exitWith {
				trace("onItemSelfClick() INV SELF CLICK (COMBAT)")
				callScriptedEvent(callFuncParams(_scriptOut,onItemSelfClick,this arg _isCombatAction));
				callFuncParams(_item,onItemSelfClick,this);
			};

			if equals(_targLoc,getVar(_item,loc)) exitWith { //inventory interact (combat)
				trace("onInteractWith() interact (COMBAT)")
				callScriptedEvent(callFuncParams(_scriptOut,onInteractWith,_item arg this arg _isCombatAction arg equals(_targLoc,this)));
				callFuncParams(_targ,onInteractWith,_item arg this);
			};

			callSelfParams(setStealth,false);
			if (isTypeOf(_item,IRangedWeapon) && {getVar(_item,isShootMode)}) then {
				if equals(_targ,this) then {
					callSelf(shootSelf);
				} else {
					callSelfParams(shootOtherMob,_targ);
				};
			} else {
				//melee attack other objects
				callScriptedEvent(callFuncParams(_scriptOut,onInteractWith,_item arg this arg _isCombatAction arg equals(_targLoc,this)));
				callSelfParams(attackOtherObj,_targ);
			};
		} else {
			//предмета нет
			
			if equals(_targLoc,this) then {
				trace("onItemClick() INV CLICK (COMBAT)")
				callScriptedEvent(callFuncParams(_scriptOut,onClick,this arg _isCombatAction arg equals(_targLoc,this)));
				callFuncParams(_targ,onItemClick,this);
			} else {
				trace("onAttackObject() hand attack")
				callScriptedEvent(callFuncParams(_scriptOut,onClick,this arg _isCombatAction arg equals(_targLoc,this)));
				callSelfParams(attackOtherObj,_targ);
			};
		};

	} else {
		if (_hasItemInActHand) then {
			if (_itemIsTarget) then {
				trace("onItemSelfClick() INV SELF CLICK")
				if (_handcuffed && {isTypeOf(_targ,IRangedWeapon)}) exitwith {};
				callScriptedEvent(callFuncParams(_scriptOut,onItemSelfClick,this arg _isCombatAction));
				callFuncParams(_item,onItemSelfClick,this);

			} else {
				private _cantInteractByDistance = callSelf(getLastInteractDistance)>INTERACT_ITEM_DISTANCE;
				//hand interact with
				if equals(_targLoc,this) then {_cantInteractByDistance = false;};
				//далеко для интеракции
				if (_cantInteractByDistance)exitWith {};
				if (_handcuffed) exitWith {};
				trace("onInteractWith() interact ")
				
				if callSelfParams(callEventClick,_targ arg _item) exitwith {};

				callScriptedEvent(callFuncParams(_scriptOut,onInteractWith,_item arg this arg _isCombatAction arg equals(_targLoc,this)));
				
				if ([this,[_item,_targ]] call csys_processCraftMain) exitWith {}; //craft interactor redirect

				private _isRedirAct = callFunc(_item,isRedirectedInteractWith);
				if (!isNullVar(_isRedirAct) && {_isRedirAct}) then {
					callFuncParams(_item,onInteractWith,_targ arg this);
				} else {
					callFuncParams(_targ,onInteractWith,_item arg this);
				};
			};
		} else {
			if equals(_targLoc,this) then {
				trace("onItemClick() INV CLICK")
				
				if (_handcuffed && {isTypeOf(_targ,IRangedWeapon)}) exitwith {};
				callScriptedEvent(callFuncParams(_scriptOut,onClick,this arg _isCombatAction arg equals(_targLoc,this)));
				callFuncParams(_targ,onItemClick,this);
			} else {
				//далеко для интеракции
				if (callSelf(getLastInteractDistance)>INTERACT_ITEM_DISTANCE)exitWith {};

				trace("onClick() CLICK")

				if (_handcuffed && {!isTypeOf(_targ,Item)}) exitwith {};
				if callSelfParams(callEventClick,_targ) exitwith {};
				callScriptedEvent(callFuncParams(_scriptOut,onClick,this arg _isCombatAction arg equals(_targLoc,this)));
				callFuncParams(_targ,onClick,this);
			};
		};
	};

	#undef callScriptedEvent
};

//Устаревший метод. Будет удалён в будущем
func(altClickTarget)
{
	objParams_1(_targ);
	OBSOLETE(Mob_Interact::altClickTarget)
	private _activeHand = getSelf(activeHand);
	private _activeHandIndexPart = if (_activeHand == INV_HAND_L) then {BP_INDEX_ARM_L} else {BP_INDEX_ARM_R};
	if !callSelfParams(hasPart,_activeHandIndexPart) exitWith {}; //no acthand part

	private _item = callSelf(getItemInActiveHandRedirect);
	private _hasItemInActHand = not_equals(_item,nullPtr);

	if callFunc(_targ,isMob) exitWith {
		if getSelf(isCombatModeEnable) then {
			//todo harm action
		} else {
			if (_hasItemInActHand) then {
				callFuncParams(_targ,onAltClickWithItem,_item arg this);
			} else {
				callFuncParams(_targ,onAltClick,this);
			};
		};
	};

	if getSelf(isCombatModeEnable) then {
		//callSelfParams(attackOtherMob,_targ);
		//callSelfParams(localSay, "Так пока нельзя" arg "system");
	} else {
		if (getSelf(lastActionTime) > tickTime) exitWith {};
		setSelf(lastActionTime,tickTime + 0.3);
		if (_hasItemInActHand) then {
			callFuncParams(_targ,onAltClickWithItem,_item arg this);
		} else {
			callFuncParams(_targ,onAltClick,this);
		};
	};
};

//usr - кто применил действие. _with - объект интеракции
//Тут достпен флаг __DRAG_EXTERNAL_FLAG__ означающий что это перетаскивание
func(onInteractWith)
{
	objParams_2(_with,_usr);

	private _ctz = getVar(_usr,curTargZone);
	private _isSelf = equals(_usr,this);

	// in noncombat
	call {

		// передача предмета - самому себе не передать предмет
		if (_ctz in [TARGET_ZONE_ARM_L,TARGET_ZONE_ARM_R] && {!_isSelf} && {!isNullVar(__DRAG_EXTERNAL_FLAG__)}) exitWith {
			//system item cannot transfer
			if isTypeOf(_with,SystemItem) exitWith {};
			//попытка передать человека самому себе
			if equals(_with,this) exitWith {};

			private _slotTo = ifcheck(_ctz == TARGET_ZONE_ARM_R,INV_HAND_R,INV_HAND_L);
			if !callSelfParams(isEmptyHand,_slotTo) exitWith {
				private _fmt = format["У %1 в %2 %3",
					tolower getVar(getVar(this,gender),него),
					[_ctz arg TARGET_ZONE_NAME_TO] call gurps_convertTargetZoneToString,
					pick["не пусто","что-то есть","что-то уже есть"]
				];
				callFuncParams(_usr,localSay,_fmt arg "error");
			};
			//передать можно только из рук
			if !array_exists(INV_LIST_HANDS,getVar(_with,slot)) exitWith {
				private _m = pick ["%1 можно вытащить только в руки.","%1 надо сначала взять в руки."];
				callFuncParams(_usr,localSay, format vec2(_m,callFuncParams(_with,getNameFor,this)) arg "error");
			};
			if !callFuncParams(this,canSetItemOnSlot,_with arg _slotTo) exitWith {
				// нет такой части или другая причина
				callFuncParams(_usr,localSay, "Цель не имеет такой части тела." arg "error");
			};

			if callFuncParams(_usr,transferItemToTarget,_with arg this arg _slotTo) then {
				callFuncParams(_usr,meSay,"отдаёт " + callFunc(_with,getName) + " " + callFuncParams(this,getNameEx,"кому"));
			};
		};
		
		if isTypeOf(_with,BodyPart) exitWith {
			callFuncParams(_with,connectBodyPart,this arg _usr);
		};
		if isTypeOf(_with,Bandage) exitWith {
			callFuncParams(_with,bandageProcess,this arg _usr)
		};
		if isTypeOf(_with,Syringe) exitWith {
			callFuncParams(_with,Prick,this arg _usr arg _ctz);
		};
		if isTypeOf(_with,BoneStraightener) exitWith {
			callFuncParams(_usr,startProgress,this arg "item.straightBone" arg getVar(_usr,rta) * 2 arg INTERACT_PROGRESS_TYPE_FULL arg _with);
		};
		if isTypeOf(_with,NeedleWithThreads) exitWith {
			callFuncParams(_usr,meSay,"собирается зашивать "+callSelfParams(getNameEx,"кого"));
			callFuncParams(_usr,startProgress,this arg "item.sewUpArtery" arg getVar(_usr,rta)*3 arg INTERACT_PROGRESS_TYPE_FULL arg _with);
		};
		if ((callFunc(_with,isFood) || callFunc(_with,isDrink)) && _ctz == TARGET_ZONE_MOUTH) exitWith {
			callFuncParams(_usr,feed,this arg _with);
		};
		if callFunc(_with,canUseInteractToMethod) exitWith {
			
			private _ctz = getVar(_usr,curTargZone);
			private _bp = [_ctz] call gurps_convertTargetZoneToBodyPart;
			setVar(_usr,lastInteractToBodyPart,callFuncParams(this,getPart,_bp));
			
			callFuncParams(_with,interactTo,this arg _usr);
		};
		if (isTypeOf(_with,Key) || isTypeOf(_with,Lockpick) || isTypeOf(_with,KeyChain)) exitwith {
			if ( 
				callSelf(isHandcuffed) && 
				getVar(_usr,curTargZone) in [TARGET_ZONE_ARM_L,TARGET_ZONE_ARM_R]
			) then {
				private _hc = getSelf(handcuffObject);
				if isNullReference(_hc) exitwith {};
				if !isImplementFunc(_hc,releaseHandcuff) exitwith {};

				callFuncParams(_hc,releaseHandcuff,_with arg _usr);
			};
		};
		if (not_equals(getVar(_usr,curCombatStyle),COMBAT_STYLE_NO) && !_isSelf && callFuncParams(_usr,getDistanceTo,this) >= 2.5) exitWith {
			private _txt = format["пригрозил %1 %2",callSelfParams(getNameEx,"кому"),callFunc(callFunc(_usr,getAttackerWeapon) select 0,getMissAttackWeaponText)];
			callFuncParams(_usr,meSay,_txt);
		};

	};
};

var(lastInteractToBodyPart,nullPtr);
getter_func(getLastinteractToBodyPart,getSelf(lastInteractToBodyPart));

func(onClick)
{
	objParams_1(_usr);

	if (not_equals(getVar(_usr,curCombatStyle),COMBAT_STYLE_NO) && not_equals(this,_usr) && callFuncParams(_usr,getDistanceTo,this) >= 2.5) then {
		private _item = callFunc(_usr,getItemInActiveHand);
		if isNullReference(_item) then {
			if !callFunc(_usr,hasActiveHand) exitWith {};
			private _txt = format["пригрозил %1 %2",callSelfParams(getNameEx,"кому"),callFunc(callFunc(_usr,getAttackerWeapon) select 0,getMissAttackWeaponText)];
			callFuncParams(_usr,meSay,_txt);
		};
	};

	private _tz = getVar(_usr,curTargZone);
	_bp = [_tz] call gurps_convertTargetZoneToBodyPart;
	if !callSelfParams(hasPart,_bp) exitWith {};

	if (_tz == TARGET_ZONE_NECK) exitWith {
		callFuncParams(_usr,meSay,"щупает пульс у " + ifcheck(equals(_usr,this),"себя",callSelfParams(getNameEx,"кого")));
		if getSelf(isDead) then {
			callFuncParams(_usr,localSay,"Пульса нет.");
		} else {
			callFuncParams(_usr,localSay,"Пульс есть!");
		};
	};

	_part = callSelfParams(getPart,_bp);	
	
	//removing bandage
	if callFunc(_part,isBandaged) exitWith {
		callFuncParams(getVar(_part,bandage),bandageProcess,this arg _usr arg false);
	};
	
	if (isTypeOf(_part,Body) && {callFunc(_part,isOpened)}) exitWith {
		callFuncParams(_part,tryRemoveExpander,_usr);
		//callFuncParams(_part,showOrgans,_usr);
	};

	if callSelf(isHandcuffed) exitwith {
		callFuncParams(getSelf(handcuffObject),releaseHandcuff,nullPtr arg _usr);
	};
	
	//attempt disconnect part
	callFuncParams(_part,disconnectBodyPart,_usr);
};

func(mainAction)
{
	objParams_1(_item);
	if isNullReference(_item) exitWith {};
	if (callSelf(getLastInteractDistance)>INTERACT_ITEM_DISTANCE)exitWith {
		//далеко для действия
		//тут можно реализовать onLongMainAction
	};
	if (callSelf(isHandcuffed) && {
		!callFunc(_item,isDoor) && 
		!isTypeOf(_item,Paper) && 
		!callFunc(_item,isSeat)
	}) exitwith {};

	//here main action event scriptedgameobject perform
	if callFunc(_item,isScriptedObject) exitWith {
		callFuncParams(getVar(_item,__script),onMainAction,this)
	};

	callFuncParams(_item,onMainAction,this);
};

func(extraAction)
{
	objParams_1(_targ);

	//полюбому выключаем стелс если не ворушка
	// if (_exact != SPECIAL_ACTION_STEAL) then {
	// 	callFuncParams(this,setStealth,false);
	// };

	private _exact = getSelf(specialAction);

	//Чего нельзя делать со связанными руками
	private _cantHandcuffedAct = callSelf(isHandcuffed) && 
		_exact in [SPECIAL_ACTION_GRAB,SPECIAL_ACTION_STEAL,SPECIAL_ACTION_BITE,SPECIAL_ACTION_THROW]
		;
	if (_cantHandcuffedAct) exitwith {};

	if (_exact == SPECIAL_ACTION_THROW) exitWith {
		callSelfParams(onThrow,callSelf(getItemInActiveHand));
	};
	if isNullReference(_targ) exitWith {};

	private _maxDist = ifcheck(_exact == SPECIAL_ACTION_KICK,INTERACT_ITEM_LEG_DISTANCE,INTERACT_ITEM_DISTANCE);

	if (callSelf(getLastInteractDistance)>_maxDist)exitWith {
		//далеко для интеракции
	};
	
	//выполнение специальных действий

	if (_exact == SPECIAL_ACTION_GRAB) exitWith {
		if equals(_targ,this) exitWith {
			//нельзя себя таскать
		};
		// if !callFunc(_targ,isMob) exitWith {
		// 	callSelfParams(localSay,"Лучше существо какое-нибудь потаскать." arg "error");
		// };
		private _isMob = callFunc(_targ,isMob);
		//связанного можно схватить сразу
		if (_isMob && {callFunc(_targ,isHandcuffed) || getVar(_targ,stunned) >= 2}) then {
			callSelfParams(onGrabImpl,_targ);
		} else {
			callSelfParams(startGrab,_targ);
		};
		//callSelfParams(onGrab,_targ);
	};
	if (_exact == SPECIAL_ACTION_STEAL) exitWith {
		callSelfParams(onSteal,_targ);
	};
	if (_exact == SPECIAL_ACTION_BITE) exitWith {
		if !getSelf(isCombatModeEnable) exitWith {};
		private __GLOBAL_FLAG_SPECACT_BITE__ = true;

		if equals(_targ,this) then {
			callSelf(attackSelf);
		} else {
			if callFunc(_targ,isMob) then {
				callSelfParams(attackOtherMob,_targ);
			} else {
				callSelfParams(attackOtherObj,_targ);
			};
		};
	};
	if (_exact == SPECIAL_ACTION_KICK) exitWith {
		private __GLOBAL_FLAG_SPECACT_KICK__ = true;
		if equals(_targ,this) exitWith {};

		// Если не комбат мод...
		if !getSelf(isCombatModeEnable) exitWith {
			// Пинание итемов без комбат мода
			if isTypeOf(_targ,Item) exitWith {
				if !callFunc(_targ,canPickup) exitWith {callFuncParams(_targ,onCantPickup,this)};
				callSelfParams(onThrow,_targ arg true);
			};
			// Пинание дверей без комбат мода
			if callFunc(_targ,isDoor) exitWith {
				callFuncParams(_targ,onDoorKicked,this arg "knock");
			};
		};

		// Только если комбат мод
		if callFunc(_targ,isMob) then {
			if callSelf(isHandcuffed) exitwith {};
			// Пинаем людей
			callSelfParams(attackOtherMob,_targ);
		} else {
			// Пинаем итемы
			if isTypeOf(_targ,Item) then {
				if !callFunc(_targ,canPickup) exitWith{callFuncParams(_targ,onCantPickup,this)};
				callSelfParams(onThrow,_targ arg true);
			} else {
				// Пинаем другие объекты
				callSelfParams(attackOtherObj,_targ);
			};
		};
	};

};

region(Undress)
	func(startUndress)
	{
		objParams_1(_targ);
		if !callFunc(_targ,isMob) exitWith {};
		if (callFunc(_targ,isActive) && !callFunc(_targ,isHandcuffed)) exitwith {};

		callFuncParams(getVar(_targ,_internalEquipmentND),openNDisplayInternal,this arg getVar(_targ,owner));
	};

region(Throwing)
	//хватает ли силы для броска
	func(canThrow)
	{
		objParams_1(_item);
		private _ft = kgToLb(callFunc(_item,getWeight));///0.5; //в фунтах
		_ft < (8 * callSelf(getBL))
	};
	//хватает ли силы для броска оной рукой
	func(canThrowOneHand)
	{
		objParams_1(_item);
		kgToLb(callFunc(_item,getWeight)) < (2 * callSelf(getBL))
	};

	//Получаем коэффициент дистанции для метания
	func(getItemThrowDistance)
	{
		objParams_1(_item);
		//Редирект. работает для мобов
		if (isTypeOf(_item,SystemHandItem) && {getVar(_item,mode)!="none"}) then {
			_item = getVar(_item,object);
		};

		private _ft = kgToLb(callFunc(_item,getWeight));//0.5;
		private _coefWt = _ft / callSelf(getBL);
		_coefWt = round(_coefWt*100)/100;
		private _coefDist = call {
			private _val = 0.05; private _mod = 0.05;
			#define thcheck(r) if (_coefWt <= _val) exitWith {r};
			#define thadd() modvar(_val)+_mod;
			#define thchange(mod) _mod = mod;
			/*
			0,05 3,5 +
			0,10 2,5 +
			0,15 2,0 +
			0,20 1,5 +
			0,25 1,2 +
			0,30 1,1 +
			0,40 1,0 +
			0,50 0,8 +
			0,75 0,7 +
			1,00 0,6 +
			1,50 0,4 +
			2,0 0,30 +
			2,5 0,25 +
			3,0 0,20 +
			4,0 0,15 +
			5,0 0,12
			6,0 0,10
			7,0 0,09
			8,0 0,08
			9,0 0,07
			10,0 0,06
			12,0 0,05
			*/
			thcheck(3.5) thadd()
			thcheck(2.5) thadd()
			thcheck(2.0) thadd()
			thcheck(1.5) thadd()
			thcheck(1.2) thadd()
			thcheck(1.1) thchange(0.1) thadd()
			thcheck(1.0) thadd()
			thcheck(0.8) thchange(0.25) thadd()
			thcheck(0.7) thadd()
			thcheck(0.6) thchange(0.5) thadd()
			thcheck(0.4) thadd()
			thcheck(0.3) thadd()
			thcheck(0.25) thadd()
			thcheck(0.20) thchange(1) thadd()
			thcheck(0.15) thadd()
			thcheck(0.12) thadd()
			thcheck(0.10) thadd()
			thcheck(0.09) thadd()
			thcheck(0.08) thadd()
			thcheck(0.07) thadd()
			thcheck(0.06)
			0.05

		};
		callSelf(getST) * _coefDist
	};

	//comp error?!?!
/*	#undef thcheck(r)
	#undef thadd()
	#undef thchange(mod)*/

	func(onThrow)
	{
		objParams_2(_item,_isKicking);
		
		if callSelf(isFailCombat) exitWith {
			callSelf(applyFailCombat);
		};

		if isNullVar(_isKicking) then {_isKicking = false};

		if isNullReference(_item) exitWith {}; //нечего метать
		if !callSelf(checkReadyWeapon) exitWith {};
		private _isSystemItem = isTypeOf(_item,SystemHandItem);
		//calc weight by formula
		//throw mob
			//set velocity to local unit
		//throw item
			//replicate throwing model data
		private _isMob = false;
		if (_isSystemItem) then {_isMob = callFunc(getVar(_item,object),isMob)};

		//replicate set non current specact if exists
		private _isTwoHanded = if _isMob then {
			({equals(getVar(_x,object),_item)} count getSelf(specHandAct)) == 2
		} else {
			callSelfParams(isHoldedTwoHands,_item);
		};
		if (!callSelfParams(canThrowOneHand,_item) && {!_isTwoHanded}) exitWith {
			callSelfParams(localSay,"Бросить одной рукой силенок не хватит..." arg "error");
		};

		if !callSelfParams(canThrow,_item) exitWith {
			callSelfParams(localSay,"Слишком тяжело..." arg "error");
		};

		if isTypeOf(_item,SystemHandItem) then {
			if callFunc(_item,isTwoHandedProcess) then {
				//redirect process
				_item = getVar(_item,object);
				callSelfParams(syncAttackDelayProcess,"throwing" arg nullPtr arg _item);
				callSelfParams(onTwoHand,_item);
			} else {
				callSelfParams(syncAttackDelayProcess,"throwing" arg nullPtr arg _item);
			};
		} else {
			callSelfParams(syncAttackDelayProcess,"throwing" arg nullPtr arg _item);
			if (_isTwoHanded) then {
				callSelfParams(onTwoHand,_item);
			};
		};

		private _throwDist = callSelfParams(getItemThrowDistance,_item);

		//replaced to si::addThrowTask()
		/*callSelf(getAttackerWeapon) params ["_attWeapon","_attItem"];
		callSelfParams(applyAttackVisualEffects,_attWeapon);
		callSelfParams(addStaminaLoss,6);

		//unlink item from hand
		callSelfParams(removeItem,_item);*/

		callSelfParams(playSoundData,soundData("attacks\throw",0.8,1.5));

		private _speed = (sqrt(2* 9.81 * callFunc(_item,getWeight)))max rand(10,15);

		//метание системного предмета
		private _throwsMob = false;
		private _mobTarg = nullPtr;
		if (_isSystemItem && callFunc(_item,isGrabProcess)) then {
			
			private _targ = getVar(_item,object);
			
			callFunc(_item,stopGrab);
			
			if callFunc(_targ,isMob) then {_throwsMob = true; _mobTarg = _targ;};

			if callFunc(_targ,isGrabbed) then {
				_item = getSelf(specHandAct) select sideToIndex(ifcheck(getVar(_item,side) == SIDE_LEFT,SIDE_RIGHT,SIDE_LEFT));
				callFunc(_item,stopGrab);
				//callSelfParams(localSay,"Метать нужно одной рукой." arg "error");
			};
			_item = _targ;
			if (!_throwsMob) then {
				callFunc(_item,unloadModel);
			};
		};
		if (_throwsMob) exitWith {			
			traceformat("SPEED WAS %1, THROW DISTANCE %2",_speed arg _throwDist)
			private _dir = getDir getSelf(owner);
			private _vel = [
				sin _dir * (_throwDist),
				cos _dir * (_throwDist),
				rand(4,6)
			];
			_vel = (callSelf(getLastInteractVector) select 0) vectorMultiply (_speed * _throwDist);
			traceformat("VELOCITY THROW: %1",_vel)
			[getVar(_mobTarg,owner),"setVelocity",[getVar(_mobTarg,owner),_vel]] call repl_doLocal;
		};

		private _throwText = pick["метает","кидает","бросает","швыряет"];
		if (_isKicking) then {_throwText = "пинает"};

		private _vectorDirection = callSelf(getLastInteractVector);

		//find maximum skill value
		private _maxSkill = "dx"; private _v__ = 0; private _vprev__ = 0;
		{
			_v__ = callSelfReflect("get"+_x);
			if (_v__ > _vprev__) then {
				_maxSkill = _x;
				_vprev__ = _v__;
			};
			true;
		} count ["dx","throw"];
		private _modThrow = 0;
		if callSelf(hasPainWithSuppress) then {
			modvar(_modThrow) - 1;
		};
		if getSelf(inAgony) then {
			modvar(_modThrow) - 2;
		};
		private _restrictionByModifier = false;

		if !callFuncParams(this,hasPerk,"PerkSeeInDark") then {
			private _callerLight = callFunc(this,getLighting);
			if (_callerLight < LIGHT_MEDIUM) then {
				if (_callerLight == LIGHT_LOW) exitWith {modvar(_modThrow)-2};
				modvar(_modThrow)-4; //стрельба в полной темноте
			};
		};

		//с закрытыми глазами или без них не повоюешь
		private _viewmode = callFunc(this,getViewMode);
		if (_viewmode < VIEW_MODE_FULL) then {
			modvar(_modThrow)+ifcheck(equals(_viewmode,VIEW_MODE_MEDIUM),-5,-10);
			_restrictionByModifier = true;
		};

		if (getVar(this,penaltySupressFire)>0)then{
			modvar(_modThrow) - 3;
		};

		if (_restrictionByModifier) then {_modThrow = _modThrow min 9};

		private _roll = callSelfParams(checkSkill,_maxSkill arg _modThrow);
		call {
			private _diceRez = getRollType(_roll);
			private _vdr = _vectorDirection select 0;

			if (_diceRez == DICE_FAIL) exitWith {
				_throwText = (pick["неудачно","неумело","криво","посредственно"])+" "+_throwText;
				MODARR(_vdr,0,+ rand(-0.5,0.5));
				MODARR(_vdr,1,+ rand(-0.5,0.5));
			};
			if (_diceRez == DICE_CRITFAIL) exitWith {
				_throwText = (pick["отвратительно","ужасно","омерзительно","смехотворно"])+" "+_throwText;
				MODARR(_vdr,0,+ rand(0.4,1.5) * pick vec2(-1,1));
				MODARR(_vdr,1,+ rand(0.4,1.5) * pick vec2(-1,1));
			};
		};

		private _m = format["%1 %2",_throwText,callFuncParams(_item,getNameFor,this)];
		callSelfParams(meSay,_m);

		#ifdef debug_throw_slow
		_speed = 2;
		#endif

		if (_isKicking) then {
			callFunc(_item,unloadModel);
			setVar(_item,loc,nullPtr); //ОЧЕНЬ НЕБЕЗОПАСНЫЙ КОНТЕКСТ
			if !getSelf(isCombatModeEnable) then {
				_throwDist = _throwDist / 2;
			};
			(_vectorDirection select 0) set [2,0.35];
		};
		//replicate on network
		//start throw action
		//si_addThrowTask["_gobj","_vecPos","_vecDir","_distance","_precdown","_leveldown","_speed"];
		[
			_item,
			callSelf(getLastInteractStartPos),
			_vectorDirection,
			_throwDist,
			randInt(70,90),
			rand(0.001,1.2),
			_speed,
			this //user
		] call si_addThrowTask;

		//invokeAfterDelayParams(createItemInInventory,0.6,vec2("BattleAxe",this));
	};

	func(onThrowHit) //вызывается при попадании в цель
	{
		objParams_6(_dam,_type,_sel,_usr,_dist,_item);
		private _newSel = [_sel,2] call gurps_pickThrowingZone;
		_newSel = callSelfParams(redirectZoneInExistingParts,_newSel);

		private _postMessageEffect = ""; //exref
		callSelfParams(applyDamage,_dam arg _type arg _newSel arg DIR_RANDOM);

		private _zoneText = [_newSel arg TARGET_ZONE_NAME_WHAT] call gurps_convertTargetZoneToString;

		private _fmt = format["В %1 %2 попадает %3.<t size='0.8' shadow = '0'>%4</t>",
			_zoneText,
			callSelfParams(getNameEx,"кого"),
			lowerize(callFuncParams(_item,getNameFor,this)),
			_postMessageEffect];
		callSelfParams(worldSay,_fmt arg "combat");
	};

	func(onBulletAct)
	{
		objParams_6(_dam,_type,_sel,_usr,_dist,_item);


		private _accuracy = 2;
		//self shooting
		if equals(_usr,this) then {
			_accuracy = 3;
		};
		private _newSel = [_sel,_accuracy] call gurps_pickThrowingZone;
		_newSel = callSelfParams(redirectZoneInExistingParts,_newSel);

		private _postMessageEffect = ""; //exref
		callSelfParams(playSoundData,soundData("guns\bullethit"+str randInt(1,4),0.85,1.15) arg 10);

		callFuncParams(getVar(this,damageInfo),updateLastAttacker,_usr arg null arg _item);

		//perform internal bullet action
		callFuncParams(_item,onDamageBulletProcess,this arg _dam arg _type arg _newSel arg DIR_RANDOM);

		private _zoneText = [_newSel arg TARGET_ZONE_NAME_WHAT] call gurps_convertTargetZoneToString;
		private _fmt = format["В %1 %2 попадает %3.<t size='0.8' shadow = '0'>%4</t>",
			_zoneText,
			callSelfParams(getNameEx,"кого"),
			lowerize(callFunc(_item,getProjectileName)),
			_postMessageEffect];
		callSelfParams(worldSay,_fmt arg "combat");

		delete(_item);
	};

region(twohanded)
	func(onTwoHand)
	{
		objParams_1(_item);

		private _isGrabMobFlag = false;

		if isTypeOf(_item,SystemHandItem) then {
			if equals(getVar(_item,mode),"grab") exitWith {
				_isGrabMobFlag = true;
				private _otherSlot = ifcheck(getVar(_item,side)==SIDE_RIGHT,INV_HAND_L,INV_HAND_R);
				callSelfParams(onGrab,getVar(_item,object) arg _otherSlot);
			};
			_item = getVar(_item,object);
		};

		if (_isGrabMobFlag) exitWith {};
		if isNullReference(_item) exitWith {};

		private _itemSlot = getVar(_item,slot);
		private _otherSlot = ifcheck(_itemSlot==INV_HAND_R,INV_HAND_L,INV_HAND_R);
		private _sideIdx = sideToIndex(ifcheck(_itemSlot==INV_HAND_R,SIDE_LEFT,SIDE_RIGHT));
		private _specItem = getSelf(specHandAct) select _sideIdx;
		private _mode = callSelfParams(isHoldedTwoHands,_item);

		//Локация не локальный моб
		if not_equals(getVar(_item,loc),this) exitWith {};

		if (!_mode) then {
			//Нельзя этой рукой взять в 2 руки
			if !callSelfParams(canSetItemOnSlot,_specItem arg _otherSlot) exitWith {};

			//режим не сброшен
			if not_equals(getVar(_specItem,mode),"none") exitWith {};

			callFuncParams(_specItem,grabWithTwoHands,_otherSlot arg _item);
			private _m = pick["хватает","обхватывает","вцепляется"];
			_m = _m +" "+ (pick["обеими","двумя"]);
			callSelfParams(meSay,_m+" руками " + lowerize(callFuncParams(_item,getNameFor,this)));
		} else {
			callFunc(_specItem,stopGrabWithTwoHands);
		};

	};

	//Проверка держания двумя руками
	func(isHoldedTwoHands)
	{
		objParams_1(_item);
		if isNullReference(_item) exitWith {false};
		if not_equals(getVar(_item,loc),this) exitWith {false};
		({equals(_item,getVar(_x,object))} count getSelf(specHandAct)) > 0
	};

region(Captives)
	//Захвачен ли кем-то
	getter_func(isGrabbed,!isNullReference(getSelf(grabber)));
	var(grabber,nullPtr); //кто держит его

	var(specHandAct,vec2(newParams(SystemHandItem,vec2(this,SIDE_LEFT)),newParams(SystemHandItem,vec2(this,SIDE_RIGHT))));
	//Что-то тащит
	getter_func(isGrabAny,({callFunc(_x,isGrabProcess)}count getSelf(specHandAct))>0);
	//что-то тащит в активной руке
	getter_func(isGrabbedInActiveHand,	callFunc(getSelf(specHandAct) select sideToIndex(ifcheck(getSelf(activeHand)==INV_HAND_L,SIDE_LEFT,SIDE_RIGHT)) ,isGrabProcess) );

	//Получает объект который грабает в активной руке
	func(getGrabbedInActiveHand)
	{
		objParams();
		if !callSelf(isGrabbedInActiveHand) exitWith {nullPtr};
		private _itm = getSelf(specHandAct) select sideToIndex(ifcheck(getSelf(activeHand)==INV_HAND_L,SIDE_LEFT,SIDE_RIGHT));
		getVar(_itm,object)
	};

	//Умный алгоритм остановки всех грабов
	func(stopAllGrab)
	{
		objParams();
		if !callSelf(isGrabAny) exitWith {};
		{
			if callFunc(_x,isGrabProcess) then {
				callFunc(_x,stopGrab);
			};
		} foreach getSelf(specHandAct);
	};

	func(stopGrabIf)
	{
		objParams_2(_fcond,_ctxtpl);
		{
			if callFunc(_x,isGrabProcess) then {
				if ([_x,_ctxtpl] call _fcond)	then {
					callFunc(_x,stopGrab);
				};
			};
		} foreach getSelf(specHandAct)
	};

	func(startGrab)
	{
		objParams_1(_targ);
		private _isMob = callFunc(_targ,isMob);
		private _namegrab = if (_isMob) then {
			callFuncParams(_targ,getNameEx,"вин");
		} else {
			callFunc(_targ,getName);
		};
		if (!_isMob && {!callFunc(_targ,isMovable)}) exitWith {};//nonmob with movable-off
		if (!_isMob && {!callFuncParams(_targ,_checkCanPullingConditions,this)}) exitWith {
			callSelfParams(localSay,"Нельзя тащить это в таком положении." arg "error");
		};
		callSelfParams(meSay,"собирается схватить " + _namegrab);
		callSelfParams(startProgress,_targ arg "caller.onGrabImpl" arg getSelf(rta)*1.2 arg INTERACT_PROGRESS_TYPE_FULL);
	};

	func(onGrabImpl)
	{
		objParams_1(_targ);
		if isNullReference(_targ) exitWith {};
		private _canAct = true;
		if callFunc(_targ,isMob) then {
			if (callSelfParams(getDistanceTo,_targ) >= 1.7) then {
				//исправление, когда лежащих на втором ярусе кровати нельзя было достать
				if !callFunc(_targ,isConnected) then {
					callSelfParams(localSay,"Далеко слишком." arg "error");
					_canAct = false;
				};
			};
		};
		if (_canAct) then {
			callSelfParams(onGrab,_targ);
		};
	};

	func(onGrab)
	{
		objParams_2(_grabSrc,_slotTo);
		
		if isNullVar(_slotTo) then {_slotTo = getSelf(activeHand)};

		// if !callFunc(_grabSrc,isMob) exitWith {
		// 	callSelfParams(localSay,"Не могу это тащить." arg "error");
		// };

		//self grab disabled
		if equals(_grabSrc,this) exitWith {
			callSelfParams(localSay,"Не хочется этого." arg "error");
		};

		//схваченный не может грабать других
		if callSelf(isGrabbed) exitWith {
			callSelfParams(localSay,"Меня держат." arg "error");
		};

		private _sideIdx = sideToIndex(ifcheck(_slotTo==INV_HAND_L,SIDE_LEFT,SIDE_RIGHT));
		private _itm = getSelf(specHandAct) select _sideIdx;
		
		
		if !callFunc(_itm,isGrabProcess) then {
			//Нельзя этой рукой грабнуть
			if !callSelfParams(canSetItemOnSlot,_itm arg _slotTo) exitWith {};

			callFuncParams(_itm,startGrab,_grabSrc arg _slotTo);
		} else {
			callFunc(_itm,stopGrab);
		};
	};

	var(grabResistTimeout,0);
	//Попытаться освободиться от граба
	func(tryReleaseFromGrab)
	{
		objParams();
		if !callSelf(isGrabbed) exitWith {};
		//отметка пока больше нашего
		if (tickTime < getSelf(grabResistTimeout)) exitWith {
			//callSelfParams(localSay,"Никак" arg "error")
		};

		//находим в какой руке
		private _handsArr = getVar(getSelf(grabber),specHandAct);
		private _idx = _handsArr findIf {equals(getVar(_x,object),this)};
		if (_idx == -1) exitWith {};

		//первый и второй кидает против силы
		//Величина успеха смотрится
		//у кого больше тот прав.
		//если оба провалились
		//вычитать из того кто резиститься
		//если больше 0 то победил освобождающийся ИНАЧЕ хуй
		//число а - число б. если больше

		unpackRollResult(throw3d6(callSelf(getST)),_stMe,_diceRez_1,_3d6Amount_1);
		unpackRollResult(throw3d6(callFunc(getSelf(grabber),getST)),_stHim,_diceRez_2,_3d6Amount_2);

		private _result = _stMe - _stHim;

		if (_result > 0) then {
			callFunc(_handsArr select _idx,stopGrab);
			callSelfParams(meSay,"высвобождается из захвата.");
		} else {
			callSelfParams(meSay,"не может высвободиться из захвата.");
			callSelfParams(addStaminaLoss,randInt(10,12));
		};
		//таймера
		setSelf(grabResistTimeout,tickTime + randInt(1,3));

	};

region(Voice type)
	var(voiceTypeTembre,pick["cultist" arg "revisor" arg "tiamat" arg "harris" arg "cynical" arg "sketchy" arg "noble" arg "hobo" arg "midget"]);

region(stealth system)
	var(isStealthEnabled,false); //включен ли стелс
	var(stealthLastCheck,0);
	func(setPreStealth)
	{
		objParams_1(_mode);
		if equals(_mode,getSelf(isStealthEnabled)) exitWith {};
		if (_mode) then {
			//только неактивный может юзать стелс
			if !callSelf(isActive) exitWith {};

			//флаг для возможности войти в стелс жруну в режиме редактора
			#ifdef EDITOR
			private __MOB_SETPRESTEALTH_FLAG_EDITOR__ = true;
			#endif
			if (callSelf(getLighting) >= LIGHT_FULL) exitWith {
				callSelfParams(localSay,"Свет меня не скроет..." arg "error");
			};

			private _ref_vismode = refcreate(VISIBILITY_MODE_LOW);
			private _visibleAny = false;
			{
				if (
					callSelfParams(canSeeObject,_x arg _ref_vismode)
					&& callFuncParams(_x,getDirectionTo,this)==DIR_FRONT
				) exitwith {
					_visibleAny = true;
				};
			} foreach callSelfParams(getNearMobs,20 arg true arg true arg "Mob");
			

			if (_visibleAny) exitwith {
				callSelfParams(localSay,"Меня видят..." arg "error");
			};

			callSelfParams(startSelfProgress,"changeStealth" arg rand(2.5,3) arg INTERACT_PROGRESS_TYPE_MEDIUM);
		} else {
			callSelfParams(setStealth,false);
		};
	};

	func(setStealth)
	{
		objParams_1(_mode);
		if equals(_mode,getSelf(isStealthEnabled)) exitWith {};

		if (_mode) then {
			callSelfParams(addVisualState,"VST_HUMAN_STEALTH");
		} else {
			callSelfParams(fastSendInfo,"hud_light" arg 0); //drop lighting mode
			callSelfParams(removeVisualState,"VST_HUMAN_STEALTH");
		};
		setSelf(isStealthEnabled,_mode);
	};

	func(changeStealth)
	{
		objParams();
		if getSelf(isStealthEnabled) exitWith {};
		private _m = pick ["Я тень...","Меня никто не найдёт!","Я невидимка!","Тьма окутывает меня.","Я прячусь.","Меня не найдут..."];
		callSelfParams(localSay,_m arg "mind");
		callSelfParams(setStealth,true);
	};

	func(handle_stealth)
	{
		if !getSelf(isStealthEnabled) exitWith {};

		_lighting = callSelf(getLighting);
		//сверка освещения должна быть реже чем броски
		if (_lighting >= LIGHT_FULL) exitWith {
			callSelfParams(setStealth,false);
			callSelfParams(localSay,"Свет настиг меня..." arg "mind");
		};

		if (callSelf(getSpeedMode) > SPEED_MODE_WALK) exitWith {
			callSelfParams(setStealth,false);
			callSelfParams(localSay,"Я слишком быстро двигаюсь для скрытности..." arg "mind");
		};

		//now lighting synced on clientside
		//synced variable each tick
		//callSelfParams(fastSendInfo,"hud_light" arg _lighting);

		_near = callSelfParams(getNearMob,3 arg true arg "Mob");
		if !isNullReference(_near) then {
			if (callSelfParams(getDistanceTo,_near) <= 1.5 
				// && callSelf(getStealth)<14
				) then {
				if (callFuncParams(_near,getDirectionTo,this)==DIR_FRONT) then {
					callFuncParams(_near,playSoundLocal,"effects\tension"+str randInt(1,8) arg getRandomPitchInRange(0.8,1.3));
					callSelfParams(setStealth,false);
					private _m = pick["АГА!!!","ВИЖУ!","ОЙ!","НАШЁЛ!"];
					callFuncParams(_near,mindSay,setstyle(_m,style_redbig));
				} else {
					if (callSelfParams(getDistanceTo,_near) <= 0.85) then {
						callFuncParams(_near,playSoundLocal,"effects\tension"+str randInt(1,8) arg getRandomPitchInRange(0.8,1.3));
						callSelfParams(setStealth,false);
						private _m = pick["СЗАДИ!!!","ЗА СПИНОЙ!","ОБЕРНИСЬ!","РАЗВЕРНИСЬ!","ОГЛЯНИСЬ НАЗАД!"];
						callFuncParams(_near,mindSay,setstyle(_m,style_redbig));
					};
				};
			};
		};

		if (tickTime >= getSelf(stealthLastCheck)) then {

			setSelf(stealthLastCheck,tickTime + randInt(3,10));
			_near = callSelfParams(getNearMobs,10);
			if (count _near > 0) then {
				_mod = 0;
				_stance = callSelf(getStance);
				if (_stance == STANCE_MIDDLE) then {
					modvar(_mod) + 1;
				} else {
					if (_stance == STANCE_DOWN) then {
						modvar(_mod) + 2;
					};
				};
				_speedMode = callSelf(getSpeedMode);
				if (_speedMode == SPEED_MODE_WALK) then {modvar(_mod) - 4};
				if (_speedMode == SPEED_MODE_RUN) then {modvar(_mod) - 15};
				if (_speedMode == SPEED_MODE_SPRINT) then {modvar(_mod) - 20};

				modvar(_mod) - getSelf(curEncumbranceLevel);

				modvar(_mod) + LIGHT_GET_MODIF_STEALTH(_lighting);

				_roll = callSelfParams(checkSkill,"stealth" arg _mod);
				traceformat("check stealth. Result %1; Mod %2; FACT SKILL %3",_roll arg _mod arg callSelf(getStealth)+_mod)
				if (getRollType(_roll) in [DICE_FAIL,DICE_CRITFAIL]) exitWith {
					callSelfParams(localSay,"Ты выдаёшь своё присутствие..." arg "info");
					//провалы на -5 и выше автоматически рассекретят дебила
					//if (getRollAmount(_roll)<=-5) then {
					//крит провал всегда рассекрет
					if (getRollType(_roll) == DICE_CRITFAIL) then {
						callSelfParams(setStealth,false);
					};
					{
						//чтобы призраки не могли палить инвизиров
						if isTypeOf(_x,Mob) then {
							if callFuncParams(_x,canSeeObject,this) then {
								private _m = pick["Я что-то вижу...","Кажется... что-то видно.","Что это там?!","Что-то не так..."];
								callFuncParams(_x,mindSay,_m);
							} else {
								private _m = pick["Что это?! Послышалось?","Кажется слышу что-то...","Что это за звук?","Я что-то слышу!"];
								callFuncParams(_x,mindSay,_m);
							};
						};

					} count _near;
				};

				/*
					Для рассекрета используем прислушаться
				*/

				/*_rr = -1;
				{
					_roll = callFuncParams(_x,checkSkill,"Per" arg - _mod); //инверсим модификатор для восприятия
					_rr = getRollType(_roll);
					if (_rr in [DICE_SUCCESS,DICE_CRITSUCCESS]) exitWith {
						callSelfParams(localSay,"Тебя обнаружили!" arg "info");
						callSelfParams(setStealth,false);
						if (_rr == DICE_SUCCESS) then {
							callFuncParams(_x,localSay,"Я слышу кого-то..." arg "info");
						} else {
							_dir = callSelfParams(getDirTo,_x);
							_d = "спереди";
							call {
								if (_dir == DIR_FRONT) exitWith {};
								if (_dir == DIR_RIGHT) exitWith {_d = "справа от меня";};
								if (_dir == DIR_LEFT) exitWith {_d = "слева от меня";};
								if (_dir == DIR_BACK) exitWith {_d = "сзади";};
							};
							callFuncParams(_x,localSay,"Кто-то "+_d+"?!" arg "info");
						};

						true;
					};
					true
				} count _near;*/
			};
		};

	};

region(stealing handler)
	func(onSteal)
	{
		objParams_1(_targ);
		if equals(_targ,this) exitWith {
			callSelfParams(localSay,"У себя не украсть." arg "error");
		};
		if !callFunc(_targ,isMob) exitwith {};
		if !callSelf(isEmptyActiveHand) exitWith {
			callSelfParams(localSay,"Руку надо освободить." arg "error");
		};
		private _slot = [getSelf(curTargZone),callSelfParams(getDirTo,_targ)] call gurps_convertTargetZoneToSlot;
		if callFuncParams(_targ,isEmptySlot,_slot) exitWith {
			callSelfParams(localSay,"Нечего спереть." arg "error");
		};
		callSelfParams(startProgress,_targ arg "caller.onStealProcess" arg rand(1,2));


	};

	func(onStealProcess)
	{
		objParams_1(_targ);
		if !callSelf(isEmptyActiveHand) exitWith {
			callSelfParams(localSay,"Руку надо освободить." arg "error");
		};
		private _mod = 0;
		if getSelf(isStealthEnabled) then {
			modvar(_mod) + 2;
		};
		private _roll = callSelfParams(checkSkill,"theft" arg _mod);
		private _res = getRollType(_roll);
		private _tz = getSelf(curTargZone);
		private _returned = false;

		if (_res in [DICE_SUCCESS,DICE_CRITSUCCESS]) exitWith {
			private _dir = callSelfParams(getDirTo,_targ);
			private _slot = [_tz,_dir] call gurps_convertTargetZoneToSlot;
			private _isEmpty = callFuncParams(_targ,isEmptySlot,_slot);
			if (_isEmpty && _slot in [INV_BACK,INV_BACKPACK,INV_ARMOR]) then {
				//redirect to cloth
				_slot = INV_CLOTH;
				_isEmpty = callFuncParams(_targ,isEmptySlot,_slot);
			};
			if _isEmpty exitWith {
				callSelfParams(localSay,"Нечего спереть." arg "error");
			};


			if (_slot in INV_LIST_HANDS) then {
				private _item = callFuncParams(_targ,getItemInSlot,_slot);
				if callFuncParams(_targ,isHoldedTwoHands,_item) exitWith {
					callSelfParams(localSay,"Невозможно..." arg "error");
					_returned = true;
				};

				private _stolen = new(StolenItem);
				private __EXTERNAL_STOLEN__ = true;
				private __SUPPRESS_PLAYEVENTSOUND__ = true;
				callFuncParams(_stolen,copyDataFrom,_item);
				if callFuncParams(_targ,transferItemToTarget,_item arg this arg getSelf(activeHand)) then {
					callFuncParams(_targ,setItemOnSlot,_stolen arg _slot);
					setVar(_stolen,suppressDelete,false);
				} else {
					delete(_stolen);
				};

			} else {
				private _probItem = callFuncParams(_targ,getItemInSlot,_slot);
				if callFunc(_probItem,isContainer) then {
					private _items = getVar(_probItem,content);
					if (count _items == 0) exitWith {
						callSelfParams(localSay,"Ничего нет..." arg "error");
						_returned = true;
					};
					private _item = pick _items;
					private __SUPPRESS_PLAYEVENTSOUND__ = true;
					callFuncParams(_probItem,removeItem,_item arg this arg getSelf(activeHand));
					private _stolen = new(StolenItem);
					private __EXTERNAL_STOLEN__ = true;
					callFuncParams(_stolen,copyDataFrom,_item);
					callFuncParams(_probItem,addItem,_stolen);
					setVar(_stolen,suppressDelete,false);
				} else {
					if (_slot == INV_BELT) then {
						private _stolen = new(StolenItem);
						private __EXTERNAL_STOLEN__ = true;
						private __SUPPRESS_PLAYEVENTSOUND__ = true;
						callFuncParams(_stolen,copyDataFrom,_probItem);
						if callFuncParams(_targ,transferItemToTarget,_probItem arg this arg getSelf(activeHand)) then {
							callFuncParams(_targ,setItemOnSlot,_stolen arg _slot);
							setVar(_stolen,suppressDelete,false);
						} else {
							delete(_stolen);
						};
					} else {
						callSelfParams(localSay,"Такое не провернуть..." arg "error");
						_returned = true;
					};

				};
			};

			if (_returned) exitWith {};

		};

		callSelfParams(meSay,"пытается стянуть что-то у " + callFuncParams(_targ,getNameEx,"кого"));
		if (_res == DICE_CRITFAIL) exitWith {
			callFuncParams(_targ,localSay,"<t size='1.5' color='#ff0000'>ВОРУЮТ!</t>" arg "info");
			callSelfParams(Stun,randInt(2,4));
		};
	};

region(viewing object)
	//может ли моб видеть этот объект.
	//_ref_viewmode - возвращает информацию насколько хорошо видно объект. Принимает значения от VISIBILITY_MODE_NONE до VISIBILITY_MODE_FULL

	"
		name:Цель видно
		desc:Возвращает @[bool ИСТИНУ], если цель видно. Даже маленький кусочек модели цели в поле зрения вызывающего моба считается как истина. Видимость проверяется на стороне сервера.
		type:get
		lockoverride:1
		in:GameObject:Объект:Цель, для которой проверяется видимость.
		return:bool:Видно ли цель
	" node_met
	func(canSeeObject)
	{
		objParams_2(_gobj,_ref_viewmode);

		//отладка в консоль
		//#define _mob_internal__log_canseeobject__

		if equals(_gobj,this) exitWith {
			if !isNullVar(_ref_viewmode) then {
				refset(_ref_viewmode,VISIBILITY_MODE_FULL);
			};
			true
		};

		private _unit = getSelf(owner);
		private _startPos = _unit modelToWorld (_unit selectionPosition "head");
		private _obj = callFunc(_gobj,getBasicLoc);
		private _checked = objNUll;
		private _needFullSearch = !isNullVar(_ref_viewmode);
		private _visMode = VISIBILITY_MODE_NONE;
		private _retval = false;
		FHEADER;

		//Алгоритм пересечений. Учитывая NGO на стороне сервера
		private _alg_canSeePoint = {
			_checked = (([_startPos,_this,_unit,_obj] call si_getIntersectData) select 0);
			if isNullReference(_checked) exitWith {true};
			if (_checked call noe_server_isNGO) then {
				equals(_obj,_checked call noe_server_getNGOSource)
			} else {
				false
			};
		};

		private _retset = ifcheck(_needFullSearch,{_retval = true},{RETURN(true)});

		if (_obj getVariable ["mob_flag",false]) then {
			private _countView = 0;
			#define mlp(v) 'v'
			private _selectionsNames = [
				mlp(neck),
				mlp(head),
				mlp(spine3),
				mlp(spine2),
				mlp(pelvis),
				//right side
				mlp(rightshoulder),
				mlp(rightforearmroll),
				mlp(rightforearm),
				mlp(rightupleg),
				mlp(rightleg),
				mlp(rightfoot),
				//left side
				mlp(leftshoulder),
				mlp(leftforearmroll),
				mlp(leftforearm),
				mlp(leftupleg),
				mlp(leftleg),
				mlp(leftfoot)
			];
			{
				//TODO возможно понадобится дополнительная проверка isActive и visionBlock
				if ((_obj modelToWorldVisual (_obj selectionPosition _x)) call _alg_canSeePoint) then {
					INC(_countView);
					if (_countView >= 2) exitWith {
						call _retset;
					};
				};
				true
			} count _selectionsNames;
			_visMode = linearConversion[0,count _selectionsNames,_countView,VISIBILITY_MODE_NONE,VISIBILITY_MODE_FULL];
			#ifdef _mob_internal__log_canseeobject__
			traceformat("COUNT %1 from %2; viewmode: %3",_countView arg count _selectionsNames arg vec4("NO","LOW","MED","FULL") select _visMode);
			#endif

		} else {
			(0 boundingBoxReal _obj) params ["_min","_max"];
			/*
				[-1,-1,-2] [1,1,2]
				8 points
				[-1,-1,-2]
				[-1,-1,2]
				[-1,1,2]
				[1,1,2]
				[-1,1,-2]
				[1,1,-2]
			*/
			private ["_y","_z","_bZ","_bY","_bX"];
			_bX = [_min select 0,_max select 0];
			_bY = [_min select 1,_max select 1];
			_bZ = [_min select 2,_max select 2];
			private _countView = 0;
			{
				_y = _x;
				{
					_z = _x;
					{
						if ((_obj modelToWorldVisual vec3(_x,_y,_z)) call _alg_canSeePoint) then {
							INC(_countView);
							if (_countView >= 2) exitWith {
								call _retset;
							}
						};
					} count _bX;
					true
				} count _bZ;
				reverse _bZ;
				true
			} count _bY;

			_visMode = linearConversion[0,7,_countView,VISIBILITY_MODE_NONE,VISIBILITY_MODE_FULL];
			#ifdef _mob_internal__log_canseeobject__
			traceformat("COUNT %1 from %2; viewmode: %3",_countView arg 8 arg vec4("NO","LOW","MED","FULL") select _visMode);
			#endif
		};
		if _needFullSearch then {
			refset(_ref_viewmode,_visMode);
		};
		_retval
	};
	
	"
		name:Получить результат видимости
		desc:Получает структуру результата видимости цели (видно ли её и насколько хорошо). Видимость проверяется на стороне сервера.
		type:method
		lockoverride:1
		in:GameObject:Объект:Цель, для которой проверяется видимость.
		return:struct.VisibilityResult:Результат видимости цели.
	" node_met
	func(canSeeObject_WrapStruct)
	{
		objParams_1(_targ);
		private _rdat = refcreate(VISIBILITY_MODE_NONE);
		private _rsee = callSelfParams(canSeeObject,_targ arg _rdat);
		[_rsee,refget(_rdat)]
	};

	"
		name:Видимость объекта
		desc:Получает уровень видимости игрового объекта. Видимость проверяется на стороне сервера.
		type:get
		lockoverride:1
		in:GameObject:Объект:Цель, для которой проверяется видимость.
		return:enum.VisibilityMode:Уровень видимости
	" node_met
	func(getObjectVisibility)
	{
		objParams_1(_targ);
		callSelfParams(canSeeObject_WrapStruct,_targ) select 1
	};