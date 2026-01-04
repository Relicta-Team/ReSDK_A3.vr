// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================


#define __performace_attacklog

#ifdef __performace_attacklog
	#define _perf_print() logformat("[PERF::ATTACK]: - %1 sec ========================",tickTime - __log_perf);
#else
	#define __perf_print()
#endif

var(isCombatModeEnable,false);
var(curAttackType,ATTACK_TYPE_THRUST); //текущий режим атаки (По умолчанию THRUST (прямые))
var(curDefType,DEF_TYPE_DODGE); //текущий режим защиты
var(curEncumbranceLevel,0); //уровень нагрузки (B17)
var(encumbrance,0); //кг нагрузки на персонажа (снаряженные предметы)
var(curTargZone,TARGET_ZONE_TORSO); // выбранная зона атаки
var(curCombatStyle,COMBAT_STYLE_NO); //текущий боевой режим

var(isReadyAttack,true); //готовность основной атаки

//other hand vars
var(otherAttackType,ATTACK_TYPE_THRUST);
var(otherTargZone,TARGET_ZONE_TORSO);
var(otherCombatStyle,COMBAT_STYLE_NO);
var(otherSpecialAction,SPECIAL_ACTION_NO);
	var(otherLastCombatActionTime,0); //для второй руки

getter_func(isFailCombat,array_exists(getVar(getSelf(client),lockedSettings),"combat"));

func(setCombatMode)
{
	params ['this',"_mode",["_supressAnimApply",false]];
	//TODO - implement _supressAnimApply
	if equals(getSelf(isCombatModeEnable),_mode) exitWith {
		errorformat("Mob::setCombatMode() - combat mode already setted on %1",_mode);
	};
	if callSelf(isCustomAnimState) exitWith {};

	setSelf(isCombatModeEnable,_mode);
	if (_mode) then {
		callSelfParams(syncAttackDelayProcess,"combatmode");
	};

	if callSelf(isPlayer) then {
		callSelfParams(syncSmdVar,"isCombat" arg _mode);
	} else {
		//fix in network
		callSelfParams(syncSmdVar,"isCombat" arg _mode);
		[getSelf(owner),_mode] call cc_setCombatMode;
		[getSelf(owner)] call anim_syncAnim;
	};
};


//Бросок повреждений (378)
func(getDataForApplyDamage)
{
	outRef(_rules_critAttack,0); //распаковка если атака была не критовая

	//Внутренняя реализация с использованием внешних ссылок
	private _dmgArr = callSelfParams(getDmgByAttackType,_attAttackType);
	
	private _basicDamage = 0;
	if isRuleCritAttackInRange(RULE_CA_HEAD_MAXDMG_INGNORSP arg RULE_CA_HEAD_MAXDMG) then {
		//выключение после игнора сп
		_basicDamage = ((_dmgArr select 0) * 6) + (_dmgArr select 1);
		if isRuleCritAttack(RULE_CA_HEAD_MAXDMG) then {
			resetRuleCritAttack;
		};
	} else {
		//при сильной атаке выбирается лучшая сила
		if equals(_attCurCombatStyle,COMBAT_STYLE_STRONG_ATTACK) then {
			_basicDamage = ((_dmgArr select 0) * 6) + (_dmgArr select 1);
		} else {
			_basicDamage = ((_dmgArr select 0) call gurps_throwdices) + (_dmgArr select 1);
		};
	};

	rp_log("Basic damage is %1 (without weapon dmg bonus)",_basicDamage);

	private _dType = callFuncParams(_attWeapon,getDmgType,_attAttackType);

	MOD(_basicDamage,+ callFuncParams(_attWeapon,getDmgBonus,_attAttackType));
	rp_log("Damage bonus was %2 (full dmg now %1)",_basicDamage arg callFuncParams(_attWeapon,getDmgBonus,_attAttackType));

	if (_basicDamage <= 0) then {
		if (_dType == DAMAGE_TYPE_CRUSHING) then {
			_basicDamage = _basicDamage max 0;
		} else {
			_basicDamage = _basicDamage max 1;
		};
	};

	if isRuleCritAttackInRange(RULE_CA_HEAD_DDAM arg RULE_CA_HEAD_TDAM) then {
		if isRuleCritAttack(RULE_CA_HEAD_DDAM) exitWith {
			resetRuleCritAttack;
			MOD(_basicDamage, * 2);
		};
		resetRuleCritAttack;
		MOD(_basicDamage, * 3);
	};

	//twohanded stronger
	if !isNullReference(_attItem) then {
		if callFuncParams(_caller,isHoldedTwoHands,_attItem) then {
			rp_log("Twohanded attack",0);
			modvar(_basicDamage) + 1;
		};
	};

	if equals(_attCurCombatStyle,COMBAT_STYLE_WEAK) then {
		_basicDamage = floor(_basicDamage / 3) max 0;
	};
	//атаки и контраатаки бьют в 2 раза хуже
	if (!isNullVar(_flagTDEF_onAttack) || equals(_attCurCombatStyle,COMBAT_STYLE_T_DEFENSE)) then {
		_basicDamage = ceil(_basicDamage / 2) max 0;
	};

	[_basicDamage,_dType]
};

func(GetDodge)
{
	objParams();

	private _baseVal = floor(callSelf(getBs) + 3 - getSelf(curEncumbranceLevel));
	private _stance = callSelf(getStance);
	_baseVal = callSelfParams(getDefenceBasicModif,_baseVal);

	_baseVal
};

func(getDefenceBasicModif)
{
	objParams_1(_baseVal);
	if (_stance == STANCE_MIDDLE) then {
		modvar(_baseVal) - 2;
	};
	if (_stance == STANCE_DOWN) then {
		modvar(_baseVal) - 3;
	};
	if (callSelf(isStunned)) then {
		modvar(_baseVal) - 4;
	};

	_baseVal
};

func(canAttack)
{
	objParams();
	true
};

func(attackOtherObj)
{
	objParams_1(_targ);
	
	if isNullReference(_targ) exitWith {};

	if (callFunc(_targ,isDoor) && !isNullVar(__GLOBAL_FLAG_SPECACT_KICK__)) exitWith
	{
		callFuncParams(_targ,onDoorKicked,this arg "kick");
	};
	//callSelfParams(localSay, "Так пока нельзя" arg "system");

	if callSelf(isFailCombat) exitWith {
		callSelf(applyFailCombat);
	};

	private _caller = this;
	private _target = _targ;
	private _attCurCombatStyle = getSelf(curCombatStyle);

	if !isNullVar(__GLOB_SET_FLAG_DOUBLE_ATTACK__) then {
		_attCurCombatStyle = COMBAT_STYLE_NO;
	};

	private _stamina_loss_amount = 10;
	private _delay_next_attack = getSelf(rta);

	callSelf(getAttackerWeapon) params ["_attWeapon","_attItem"];
	if isTypeOf(_attWeapon,WeapGrabbedHuman) exitWith {
		callSelfParams(localSay,"Схваченным не ударить." arg "error");
	};
	// Не нашлось подходящего оружия или выбранным нельзя атаковать
	if equals(_attWeapon,nullPtr) exitWith {
		private _mes = pick["А атаковать-то нечем","А чем атаковать?","НЕЧЕМ ПРОВЕСТИ АТАКУ!"];
		callSelfParams(localSay,_mes arg "error");
	};
	if !callSelf(checkReadyWeapon) exitWith {};

	if equals(_attCurCombatStyle,COMBAT_STYLE_STRONG_ATTACK) then {
		modvar(_stamina_loss_amount) * 2;
	};

	private _delegate_success_attack = {

		if equals(_attCurCombatStyle,COMBAT_STYLE_AIMED_ATTACK) then {
			_delay_next_attack = _delay_next_attack * 2;
		};
		// if (_isFailedFint) then {
		// 	_delay_next_attack = _delay_next_attack * 2.5;
		// };
		if equals(_attCurCombatStyle,COMBAT_STYLE_FAST_ATTACK) then {
			_delay_next_attack = _delay_next_attack / 2;
		};

		callSelfParams(addStaminaLoss,_stamina_loss_amount);
		callSelfParams(syncAttackDelayProcess,"melee" arg _attWeapon arg _attItem arg _delay_next_attack);
		callSelfParams(applyAttackVisualEffects,_attWeapon);

		//Двуручная атака
		if equals(_attCurCombatStyle,COMBAT_STYLE_DOUBLE_ATTACK) then {

			//флаг внешнего определения. объявлен в onDoubleAttackProcess()
			if !isNullVar(__GLOB_SET_FLAG_DOUBLE_ATTACK__) exitWith {};

			//если нулл итем выходим - удар рукой. не двуручка
			//если предмет двуручен выходим
			if (!isNullReference(_attItem) && {callSelfParams(isHoldedTwoHands,_attItem)}) exitWith {};

			callSelfAfterParams(onDoubleAttackProcess,rand(0.2,0.6),_target); //todo timeout rand from rta values
		};
	}; // _delegate_success_attack
	
	private _delegate_damage = {
		callFuncParams(_caller,playSoundData,callFuncParams(_attWeapon,getAttackSoundData,_attAttackType));
		callSelf(getDataForApplyDamage) params ["_basicDamage","_dType"];
		
		private _basicDamageTarg = ifcheck(!isNullReference(_attItem),callFuncParams(_attItem,getEfficiencyOnAttack,_basicDamage arg _target),_basicDamage);

		private _targetDr = getVar(_target,dr);//calculate this only before applydam
		callFuncParams(_target,applyDamage,_basicDamageTarg arg _dType arg callSelf(getLastInteractEndPos) arg "attack"); //conv attack to -> _dir arg di_partDamage arg vec2(_attItem,_attWeapon)
		
		callFuncParams(_attItem,onAttackedObject,_target arg _basicDamage arg _targetDr arg callSelf(getLastInteractStartPos) arg "weap_attack");

		//callSelfParams(onDamageMessage,_target arg _attWeapMes arg _attackedZoneText arg _attRealTargetZone arg _postMessageEffect);
	};// _delegate_damage

	private _attAttackType = callSelfParams(getAttackTypeForWeapon,_attWeapon);

	if !callSelfParams(canInteractWithSavedObject,_attWeapon arg _attItem) exitWith {
		//code duplicate
		call _delegate_success_attack;
		//Сегмент внешнего вызова.
		callFunc(_attWeapon,onMiss); //звук промаха

		callFuncParams(_item,onLongDistanceAttack,this arg _target);
	};

	//TODO --------- ROLL ATTACK (B.483) ----------

	call _delegate_success_attack;

	call _delegate_damage;
	// ----------------- process damage ----------------

	//private _amount = 1;
	//private _type = DAMAGE_TYPE_CRUSHING;
	//callFuncParams(_targ,applyDamage,_amount arg _type arg callSelf(getLastInteractEndPos) arg "attack");
};

//метод атаки. Широко использует замыкания и внешние переменные.
func(attackOtherMob)
{
	objParams_1(_target);
	#ifdef __performace_attacklog
		private __log_perf = tickTime;
	#endif

	if callSelf(isFailCombat) exitWith {
		callSelf(applyFailCombat);
	};

	private _caller = this; //Должен быть объявлен раньше onMiss() -> exref
	private _attTargetZone = getSelf(curTargZone);
	private _attCurCombatStyle = getSelf(curCombatStyle);
	private _defCurCombatStyle = getVar(_target,curCombatStyle);
	if !getVar(_target,isCombatModeEnable) then {
		_defCurCombatStyle = COMBAT_STYLE_NO; //он не в комбате
	};
	if !isNullVar(__GLOB_SET_FLAG_DOUBLE_ATTACK__) then {
		_attCurCombatStyle = COMBAT_STYLE_NO;
	};
	private _attIsRandomTargetZone = false;

	private _stamina_loss_amount = 10;
	private _delay_next_attack = getSelf(rta);

	//выбор случайной части дамага
	if (_attTargetZone == TARGET_ZONE_RANDOM) then {
		_attIsRandomTargetZone = true;
		_attTargetZone = callSelf(pickRandomTargZone);
		_attTargetZone = callSelfParams(redirectZoneInExistingParts,_attTargetZone);
	};

	callSelf(getAttackerWeapon) params ["_attWeapon","_attItem"];
	if isTypeOf(_attWeapon,WeapGrabbedHuman) exitWith {
		callSelfParams(localSay,"Схваченным не ударить." arg "error");
	};
	// Не нашлось подходящего оружия или выбранным нельзя атаковать
	if equals(_attWeapon,nullPtr) exitWith {
		private _mes = pick["А атаковать-то нечем","А чем атаковать?","НЕЧЕМ ПРОВЕСТИ АТАКУ!"];
		callSelfParams(localSay,_mes arg "error");
	};
	if !callSelf(checkReadyWeapon) exitWith {};


	if equals(_attCurCombatStyle,COMBAT_STYLE_STRONG_ATTACK) then {
		modvar(_stamina_loss_amount) * 2;
	};

	private _isFailedFint = false; //враг не собирается парировать или вне комбата - ты проебался.
	private _delegate_success_attack = {

		if equals(_attCurCombatStyle,COMBAT_STYLE_AIMED_ATTACK) then {
			_delay_next_attack = _delay_next_attack * 2;
		};
		if (_isFailedFint) then {
			_delay_next_attack = _delay_next_attack * 2.5;
		};
		if equals(_attCurCombatStyle,COMBAT_STYLE_FAST_ATTACK) then {
			_delay_next_attack = _delay_next_attack / 2;
		};

		callSelfParams(addStaminaLoss,_stamina_loss_amount);
		callSelfParams(syncAttackDelayProcess,"melee" arg _attWeapon arg _attItem arg _delay_next_attack);
		callSelfParams(applyAttackVisualEffects,_attWeapon);

		//Двуручная атака
		if equals(_attCurCombatStyle,COMBAT_STYLE_DOUBLE_ATTACK) then {

			//флаг внешнего определения. объявлен в onDoubleAttackProcess()
			if !isNullVar(__GLOB_SET_FLAG_DOUBLE_ATTACK__) exitWith {};

			//если нулл итем выходим - удар рукой. не двуручка
			//если предмет двуручен выходим
			if (!isNullReference(_attItem) && {callSelfParams(isHoldedTwoHands,_attItem)}) exitWith {};

			callSelfAfterParams(onDoubleAttackProcess,rand(0.2,0.6),_target); //todo timeout rand from rta values
		};
	};

	//Новый способ проверяет дистанцию
	if !callSelfParams(canInteractWithSavedObject,_attWeapon arg _attItem) exitWith {
		//code duplicate
		call _delegate_success_attack;
		//Сегмент внешнего вызова.
		callFunc(_attWeapon,onMiss); //звук промаха

		callFuncParams(_item,onLongDistanceAttack,this arg _target);
	};

	//Проверим можно ли атаковать в эту часть
	if (!callFuncParams(_target,hasTargetZoneForAttack,_attTargetZone)) exitWith {
		private _mes = format["%1 отсутствует.",capitalize([_attTargetZone] call gurps_convertTargetZoneToString)];
		callSelfParams(localSay,_mes arg "error");
	};

	//текстовое название атакуемой части. ногу, руку и т.д.
	private _attackedZoneText = [_attTargetZone arg TARGET_ZONE_NAME_WHAT] call gurps_convertTargetZoneToString;

	private _attAttackType = callSelfParams(getAttackTypeForWeapon,_attWeapon);
	private _restrictionByModifier = false; //(c.547) - итоговый уровень умения после применения всех модификаторов не может превысить 9.

	private _dir = callSelfParams(getDirTo,_target); //с какой стороны атаковал каллер

	private _postMessageEffect = "";
	//outRef(_postMessageEffect,""); //дополнительный текст который добавляется к сообщению урона

	private _isCloseCombat = false; //Проводится ли бой вплотную

	//Attack process
	callFunc(_attWeapon,rollAttack) params ["_attRollAmount","_attRollType","_attRollResult"];
	rp_log("Attack result -> Величина успеха: %1, тип: %2, на кубиках:%3",_attRollAmount arg _attRollType arg _attRollResult);

	//он не в комбат моде и не защищается
	if (equals(_attCurCombatStyle,COMBAT_STYLE_FINT) && {!getVar(_target,isCombatModeEnable) || not_equals(getVar(_target,curDefType),DEF_TYPE_PARRY)}) then {
		_attRollAmount = -7;
		_attRollType = DICE_FAIL;
		_attRollResult = 5;
		_isFailedFint = true;
		private _rm = pick[" Неудачный финт."," Неудачный развод."," Провальный финт."];
		modvar(_postMessageEffect) + _rm;
	};

	call _delegate_success_attack;

	//При провале на 1 попадает в торс (552)
	if (_attRollAmount == -1 && _attRollType == DICE_FAIL && _attTargetZone in [TARGET_ZONE_GROIN,TARGET_ZONE_EYE_L,TARGET_ZONE_EYE_R,TARGET_ZONE_HEAD,TARGET_ZONE_NECK,TARGET_ZONE_ABDOMEN]) then {
		rp_log("Атака провалена на 1. Попадает в торс",0);
		//TODO добавить больше правил на провал с единицей. Например бил в лицо - попал в голову.
		//пробовать поразить голову, но бьёт палкой в шею
		//метит в голову, но бьёт палкой в шею
		//целит
		_attTargetZone = TARGET_ZONE_TORSO; //TARGET_ZONE_ABDOMEN?
		_attRollType = DICE_SUCCESS;
		_attackedZoneText = _attackedZoneText + ", но попадает в " + ([_attTargetZone] call gurps_convertTargetZoneToString);
	};

	//Получаем текстовое описание атаки оружия (Прим.: бьёт кулаком)
	private _attWeapMes = callFuncParams(_attWeapon,getAttackWeaponText,_attAttackType);

	//Применение эмуляторов атаки
	#ifdef emulate_critAttack
		_attRollType = DICE_CRITSUCCESS;
	#endif
	#ifdef emulate_critFailAttack
		_attRollType = DICE_CRITFAIL;
	#endif

	// generic damage delegate
	private _delegate_damage = {
		callFuncParams(_caller,playSoundData,callFuncParams(_attWeapon,getAttackSoundData,_attAttackType));
		callSelf(getDataForApplyDamage) params ["_basicDamage","_dType"];
		callFuncParams(getVar(_target,damageInfo),updateLastAttacker,_caller arg _attWeapon arg _attItem);
		callFuncParams(_target,applyDamage,_basicDamage arg _dType arg _attTargetZone arg _dir arg di_partDamage arg vec2(_attItem,_attWeapon));

		callSelfParams(onDamageMessage,_target arg _attWeapMes arg _attackedZoneText arg _attRealTargetZone arg _postMessageEffect);
	};

	//_attRollType = DICE_SUCCESS; //for tests
	if (_attRollType == DICE_CRITSUCCESS) exitWith {
		rp_log("Крит успех при атаке на %1 с броском %2",_attRollAmount arg _attRollResult);

		MOD(_postMessageEffect, + " <t size='1.3'>Критическое попадание!</t> ");

		//Сбрасывается после использования
		private _rules_critAttack = 0; //Данная переменная определится внутри onCritiSuccessAttack. Распаковывается в applyDamage

		callFunc(_attWeapon,onCritiSuccessAttack);

		call _delegate_damage;

		if (_rules_critAttack != 0) then {
			warningformat("NO APPLIED RULE FOR CRIT ATTACK - %1",_rules_critAttack);
		};

		_perf_print()
	};
	if (_attRollType == DICE_CRITFAIL) exitWith {
		rp_log("Крит провал при атаке на %1 с броском %2",_attRollAmount arg _attRollResult);

		MOD(_postMessageEffect, + " <t size='1.3'>Критический промах!</t> ");

		callFunc(_attWeapon,onCritFailAttack);
		callFunc(_attWeapon,onMiss);
		callSelfParams(onMissMessage,_target arg _attWeapon arg _attTargetZone arg _postMessageEffect);

		_perf_print()
	};
	if (_attRollType == DICE_FAIL && true) exitWith {
		rp_log("Провал при атаке на %1 с броском %2",_attRollAmount arg _attRollResult);

		callFunc(_attWeapon,onMiss);
		callSelfParams(onMissMessage,_target arg _attWeapon arg _attTargetZone arg _postMessageEffect);

		_perf_print()
	};

	//if (_attRollType == DICE_SUCCESS) exitWith {
	rp_log("Успех при атаке на %1 с броском %2",_attRollAmount arg _attRollResult);

	callFunc(_target,defenceReturn) params ["_defRollAmount","_defRollType","_defRollResult","_defDefenceType","_defWeapon","_defItem"];
	//_defRollType = DICE_SUCCESS; //for tests
	//нет оружия которым можно защититься
	if equals(_defRollAmount,"DEFENCE_NOT_WEAPON") then {
		_defRollType = DICE_FAIL;
	};



	if (equals(_defCurCombatStyle,COMBAT_STYLE_T_DEFENSE) && _defRollType in [DICE_SUCCESS,DICE_CRITSUCCESS] && _defDefenceType == DEF_TYPE_PARRY) exitWith {
		rp_log("<----------------------------- Контратака!! от %1 (%2;%3) ----------------------------->",callFunc(_target,getName) arg _defItem arg _defWeapon);
		//modvar(_postMessageEffect) + "<t size='1.4'>Контратака!</t>";
		private _flagTDEF_onAttack = true;
		//callFuncParams(_target,clickTarget,this);
		//private _defItem = callFunc(_target,getItemInActiveHandRedirect);
		//ТОЛЬКО КОНТРАТАКИ БЛИЖНИМ БОЕМ
		private _isShooting = false;
		/*if !isNullReference(_defItem) then {
			_isShooting = isTypeOf(_defItem,IRangedWeapon) && {getVar(_defItem,isShootMode)};
		};*/
		if (_isShooting) then {
			callFuncParams(_target,shootOtherMob,this);
		} else {
			callFuncParams(_target,attackOtherMob,this);
		};
	};

	if (_defRollType == DICE_CRITSUCCESS) exitWith {
		if (_defDefenceType == DEF_TYPE_DODGE) then {
			callFunc(_attWeapon,onMiss);
			callFuncParams(_target,onDodge,true arg _dir);
			//ваш противник (caller) немедленно делает бросок по Таблице критических промахов (с.556).
		};
		if (_defDefenceType == DEF_TYPE_PARRY) then {
			callFuncParams(_target,onParry,_caller arg _defWeapon arg _defItem);
		};

		_perf_print()
	};

	if (_defRollType == DICE_SUCCESS) exitWith {
		if (_defDefenceType == DEF_TYPE_DODGE) then {
			rp_log("target увернулся",0);
			/*#ifdef DEBUG
			getVar(_target,owner) setVelocityModelSpace [random[-3,0,3], random[-3,0,3], 3];
			#endif*/
			callFunc(_attWeapon,onMiss);
			callFuncParams(_target,onDodge,false arg _dir);
		};
		if (_defDefenceType == DEF_TYPE_PARRY) then {
			callFuncParams(_target,onParry,_caller arg _defWeapon arg _defItem);
		};
		//_target ловко уворачивается от атаки
		_perf_print()
	};

	if equals(_attCurCombatStyle,COMBAT_STYLE_FINT) then {
		if (_defDefenceType == DEF_TYPE_PARRY) then {
			private _attWeapMes = callFunc(_attWeapon,getFeintWeaponText);
			callSelfParams(onDamageMessage,_target arg _attWeapMes arg _attackedZoneText arg _attRealTargetZone arg _postMessageEffect);
			callFuncParams(_target,onParry,_caller arg _defWeapon arg _defItem arg true);
			callFuncParams(_target,Stun,randInt(2,4) arg false);
		} else {
			//Это правило никогда не должно отрабатывать.
			private _m = pick[" пытается провести финт"," собирается финтануть"," пытается провести обманную атаку"]+", ";
			_m = _m + pick["и терпит неудачу.","и дурит себя.","но не получает желаемого эффекта."] + _postMessageEffect;
			callFunc(_attWeapon,onMiss);
			callSelfParams(worldSay,callFuncParams(_caller,getNameEx,"кто") +_m arg "combat");
			callFuncParams(_caller,Stun,randInt(3,6) arg false);
		};
	} else {
		call _delegate_damage;
	};

	//};
	_perf_print()
};

func(attackSelf)
{
	objParams();
	#ifdef __performace_attacklog
		private __log_perf = tickTime;
	#endif

	private _target = this;

	//метод скопирован из attackOtherMob

	if callSelf(isFailCombat) exitWith {
		callSelf(applyFailCombat);
	};

	private _attTargetZone = getSelf(curTargZone);
	private _attIsRandomTargetZone = false;

	//выбор случайной части дамага
	if (_attTargetZone == TARGET_ZONE_RANDOM) then {
		_attIsRandomTargetZone = true;
		_attTargetZone = callSelf(pickRandomTargZone);
		_attTargetZone = callSelfParams(redirectZoneInExistingParts,_attTargetZone);
	};

	callSelf(getAttackerWeapon) params ["_attWeapon","_attItem"];
	if isTypeOf(_attWeapon,WeapGrabbedHuman) exitWith {
		callSelfParams(localSay,"Схваченным не ударить." arg "error");
	};
	// Не нашлось подходящего оружия или выбранным нельзя атаковать
	if equals(_attWeapon,nullPtr) exitWith {
		private _mes = pick["А атаковать-то нечем","А чем атаковать?","НЕЧЕМ ПРОВЕСТИ АТАКУ!"];
		callSelfParams(localSay,_mes arg "error");
	};
	if !callSelf(checkReadyWeapon) exitWith {};

	private _critExCantHandAttack = false;
	if equals(getSelf(activeHand),INV_HAND_R) then {
		if (_attTargetZone == TARGET_ZONE_ARM_R) exitWith {_critExCantHandAttack = true};
	} else {
		if (_attTargetZone == TARGET_ZONE_ARM_L) exitWith {_critExCantHandAttack = true};
	};
	if (_critExCantHandAttack) exitWith {
		private _mes = pick["Не могу так атаковать.","Не достать."];
		callSelfParams(localSay,_mes arg "error");
	};

	//Проверим можно ли атаковать в эту часть
	if (!callFuncParams(_target,hasTargetZoneForAttack,_attTargetZone)) exitWith {
		private _mes = format["%1 отсутствует.",capitalize([_attTargetZone] call gurps_convertTargetZoneToString)];
		callSelfParams(localSay,_mes arg "error");
	};

	//текстовое название атакуемой части. ногу, руку и т.д.
	private _attackedZoneText = [_attTargetZone arg TARGET_ZONE_NAME_WHAT] call gurps_convertTargetZoneToString;

	private _attCurCombatStyle = getSelf(curCombatStyle);

	private _attAttackType = callSelfParams(getAttackTypeForWeapon,_attWeapon);
	private _caller = this;
	private _restrictionByModifier = false; //(c.547) - итоговый уровень умения после применения всех модификаторов не может превысить 9.

	private _dir = callSelfParams(getDirTo,_target); //с какой стороны атаковал каллер

	private _postMessageEffect = ""; //дополнительный текст который добавляется к сообщению урона

	private _isCloseCombat = false; //Проводится ли бой вплотную

	//Attack process
	//callFunc(_attWeapon,rollAttack) params ["_attRollAmount","_attRollType","_attRollResult"];
	//rp_log("Attack result -> Величина успеха: %1, тип: %2, на кубиках:%3",_attRollAmount arg _attRollType arg _attRollResult);

	callSelfParams(addStaminaLoss,10);
	callSelfParams(syncAttackDelayProcess,"melee" arg _attWeapon arg _attItem);
	callSelfParams(applyAttackVisualEffects,_attWeapon);

	callFuncParams(_caller,playSoundData,callFuncParams(_attWeapon,getAttackSoundData,_attAttackType));
	callSelf(getDataForApplyDamage) params ["_basicDamage","_dType"];
	callFuncParams(getVar(_target,damageInfo),updateLastAttacker,_target arg _attWeapon arg _attItem);
	callFuncParams(_target,applyDamage,_basicDamage arg _dType arg _attTargetZone arg _dir arg di_partDamage arg vec2(_attItem,_attWeapon));
	//callSelfParams(onDamageMessage,_target arg _attWeapMes arg _attackedZoneText arg _attTargetZone arg _postMessageEffect);

	_perf_print()
};


//Вызывается только из attackOtherMob
func(defenceReturn)
{
	objParams();
	FHEADER;
	private _defDefenceType = getSelf(curDefType);

	private _defRoll = null;
	private _defWeaponRef = nullPtr;
	private _defItemRef = nullPtr;
	call {
		//обычный провал если в бессознанке или выключен комбат
		if (!callSelf(isActive) || !getSelf(isCombatModeEnable) || callSelf(isHandcuffed)) exitWith {
			_defRoll = customRollResult(-5,DICE_FAIL,1);
		};

		if (_defDefenceType == DEF_TYPE_DODGE) exitWith {
			_defRoll = callSelf(rollDefenseDodge);
		};
		//other cases parry or blocking
		callSelfParams(getDefenceWeapon,true) params ["_defWeapon","_defItem"];
		_defWeaponRef = _defWeapon;
		_defItemRef = _defItem;

		if isNullReference(_defWeapon) exitWith {
			RETURN(["DEFENCE_NOT_WEAPON"]);
		};

		if (_defDefenceType == DEF_TYPE_PARRY) exitWith {
			_defRoll = callFuncParams(_defWeapon,rollDefenseParry,this);
		};
		if (_defDefenceType == DEF_TYPE_BLOCK) exitWith {
			_defRoll = callFunc(_defWeapon,rollDefenseBlock);
		};
		errorformat("Unknown defDefenseType - %1",_defDefenceType);
	};

	_defRoll params ["_defRollAmount","_defRollType","_defRollResult"];

	switch (_defRollType) do {
	    case (DICE_CRITSUCCESS): {
	        rp_log("Крит успех при защите на %1 с броском %2",_defRollAmount arg _defRollResult);
	    };
		case (DICE_SUCCESS): {
			rp_log("Успех при защите на %1 с броском %2",_defRollAmount arg _defRollResult);
		};
		case (DICE_CRITFAIL): {
			rp_log("Крит провал при защите на %1 с броском %2",_defRollAmount arg _defRollResult);
		};
		case (DICE_FAIL): {
			rp_log("Провал при защите на %1 с броском %2",_defRollAmount arg _defRollResult);
		};
	};

	[_defRollAmount,_defRollType,_defRollResult,_defDefenceType,_defWeaponRef,_defItemRef]
};

func(rollDefenseDodge)
{
	objParams();

	private _skill = callSelf(GetDodge);
	//тотальная защита. по правилам
	if equals(_defCurCombatStyle,COMBAT_STYLE_T_DEFENSE) then {
		modvar(_skill) + 3;
	};
	//вызовется при контратаке - этому персонажу сложнее уберечься
	if !isNullVar(_flagTDEF_onAttack) then {
		modvar(_skill) - 3;
	};

	if (!isNullVar(_attCurCombatStyle) && {equals(_attCurCombatStyle,COMBAT_STYLE_FAST_ATTACK)}) then {
		modvar(_skill) - 2;
	};


	throw3d6(_skill);
};

func(onDodge)
{
	objParams_2(_isCritSuccess,_fromDir); //_fromDir откуда пришла атака

	private _attTxt = "атаки";
	if !isNullVar(_flagTDEF_onAttack) then {
		_attTxt = "контратаки";
	};
	private _post = ifcheck(isNullVar(_postMessageEffect),"",_postMessageEffect);
	_post = "<t size='0.8' shadow = '0'>"+_post+"</t>";
	if (_isCritSuccess) then {
		callSelfParams(worldSay,callSelfParams(getNameEx,"кто") + " ловко уворачивается от "+_attTxt+"!"+_post arg "combat");
	} else {
		callSelfParams(worldSay,callSelfParams(getNameEx,"кто") + " уворачивается от "+_attTxt+"."+_post arg "combat");
	};
	private _list = ["f","b","r","l"];
	private _excludedIdx = call {
		if (_fromDir == DIR_FRONT) exitWith {0};
		if (_fromDir == DIR_RIGHT) exitWith {2};
		if (_fromDir == DIR_LEFT) exitWith {3};
		if (_fromDir == DIR_BACK) exitWith {1};
		0
	};
	_list deleteAt _excludedIdx;
	callSelfParams(applyDodgeVisualEffects,pick _list);
	if (!_isCritSuccess) then {
		callSelfParams(Stun,1 arg false);
	};
};

func(onParry)
{
	objParams_4(_caller,_defWeapon,_defItem,_supressParryMessage);

	if isNullVar(_supressParryMessage) then {
		private _post = ifcheck(isNullVar(_postMessageEffect),"",_postMessageEffect);
		_post = "<t size='0.8' shadow = '0'>"+_post+"</t>";
		private _attTxt = "атаку";
		if !isNullVar(_flagTDEF_onAttack) then {
			_attTxt = "контратаку";
		};
		private _parryType = ifcheck(isTypeOf(_defWeapon,Fists),pick["отражает" arg "блокирует"],"парирует");
		callSelfParams(worldSay,callSelfParams(getNameEx,"кто") + " "+_parryType+" "+_attTxt+" " + callFuncParams(_caller,getNameEx,"кого")+"."+_post arg "combat");
	};

	if isTypeOf(_defWeapon,Fists) then {
		callSelfParams(playSoundData, soundData("attacks\soft_fist"+ str randInt(1,3),0.8,1.25));
	} else {
		if prob(50) then {
			callSelfParams(playSoundData, soundData("attacks\parry",0.8,1.25));
		} else {
			callSelfParams(playSoundData, soundData("attacks\blade_parry"+ str randInt(1,3),0.8,1.25));
		};
	};

	private _handIdx = 0;
	private _enumType = 0;
	if isTypeOf(_defWeapon,Fists) then {
		_handIdx = ifcheck(0==sideToIndex(getVar(_defItem,side)),1,0);
		_enumType = pick[ITEM_PARRY_HAND_1,ITEM_PARRY_HAND_2];
	} else {
		if callSelfParams(isHoldedTwoHands,_defItem) then {
			_handIdx = -1;//special flag for 2handed
			_enumType = callFunc(_defItem,getTwoHandParryAnim);
		} else {
			_handIdx = ifcheck(equals(getVar(_defItem,slot),INV_HAND_L),1,0);
			_enumType = callFunc(_defItem,getParryAnim);
		};
	};

	callSelfParams(applyParryVisualEffects,_handIdx arg _enumType);

	callSelfParams(syncAttackDelayProcess,"parry" arg _defWeapon arg _defItem)
};

//выбирает рандомно одну из зон для действия
func(pickRandomTargZone)
{
	objParams();

	//TODO post check callSelfParams(hasTargetZoneForAttack,_attTargetZone)

	#define SELECT_SIDEPART(p1,p2) _d = D6 <= 3; [p1,p2] select _d
	private _d = _3D6;
	if (_d in [3,4]) exitWith {TARGET_ZONE_HEAD};
	if (_d == 5) exitWith {TARGET_ZONE_FACE};
	if (_d in [6,7]) exitWith {TARGET_ZONE_LEG_R};
	if (_d == 8) exitWith {TARGET_ZONE_ARM_R};
	if (_d in [9,10]) exitWith {
		SELECT_SIDEPART(TARGET_ZONE_TORSO,TARGET_ZONE_ABDOMEN);
	};
	if (_d == 11) exitWith {TARGET_ZONE_GROIN};
	if (_d == 12) exitWith {TARGET_ZONE_ARM_L};
	if (_d in [13,14]) exitWith {TARGET_ZONE_LEG_L};
	if (_d == 15) exitWith {pick([TARGET_ZONE_ARM_R arg TARGET_ZONE_ARM_R arg TARGET_ZONE_LEG_L arg TARGET_ZONE_LEG_R])};
	if (_d == 16) exitWith {pick([TARGET_ZONE_EYE_R arg TARGET_ZONE_EYE_L arg TARGET_ZONE_MOUTH])};
	if (_d in [17,18]) exitWith {TARGET_ZONE_NECK};

	TARGET_ZONE_TORSO
};

func(pickRandomTargZoneTorsoHeadNeck)
{
	objParams();

	private _d = _3D6;
	if (_d in [3,6]) exitWith {TARGET_ZONE_HEAD};
	if (_d in [15,18]) exitWith {TARGET_ZONE_NECK};

	TARGET_ZONE_TORSO
};

go_static_internal_map_redirzones = createHashMapFromArray[
	[TARGET_ZONE_TORSO,[TARGET_ZONE_TORSO]],
	[TARGET_ZONE_ABDOMEN,[TARGET_ZONE_TORSO]],
	[TARGET_ZONE_HEAD,[TARGET_ZONE_TORSO,TARGET_ZONE_ABDOMEN]],
	[TARGET_ZONE_EYE_L,[TARGET_ZONE_EYE_R,TARGET_ZONE_FACE,TARGET_ZONE_MOUTH,TARGET_ZONE_HEAD,TARGET_ZONE_NECK,TARGET_ZONE_TORSO]],
	[TARGET_ZONE_EYE_R,[TARGET_ZONE_EYE_L,TARGET_ZONE_FACE,TARGET_ZONE_MOUTH,TARGET_ZONE_HEAD,TARGET_ZONE_NECK,TARGET_ZONE_TORSO]],
	[TARGET_ZONE_FACE,[TARGET_ZONE_MOUTH,TARGET_ZONE_EYE_R,TARGET_ZONE_EYE_L,TARGET_ZONE_HEAD,TARGET_ZONE_TORSO]],
	[TARGET_ZONE_NECK,[TARGET_ZONE_MOUTH,TARGET_ZONE_FACE,TARGET_ZONE_EYE_R,TARGET_ZONE_EYE_L,TARGET_ZONE_HEAD,TARGET_ZONE_TORSO]],
	[TARGET_ZONE_GROIN,[TARGET_ZONE_ABDOMEN,TARGET_ZONE_TORSO]],
	[TARGET_ZONE_ARM_L,[TARGET_ZONE_ARM_R,TARGET_ZONE_TORSO]],
	[TARGET_ZONE_ARM_R,[TARGET_ZONE_ARM_L,TARGET_ZONE_TORSO]],
	[TARGET_ZONE_LEG_L,[TARGET_ZONE_LEG_R,TARGET_ZONE_GROIN,TARGET_ZONE_ABDOMEN]],
	[TARGET_ZONE_LEG_R,[TARGET_ZONE_LEG_L,TARGET_ZONE_GROIN,TARGET_ZONE_ABDOMEN]],
	[TARGET_ZONE_MOUTH,[TARGET_ZONE_FACE,TARGET_ZONE_EYE_R,TARGET_ZONE_EYE_L,TARGET_ZONE_HEAD,TARGET_ZONE_NECK,TARGET_ZONE_TORSO]]
];

//переопределение зоны если входная часть не существует
func(redirectZoneInExistingParts)
{
	objParams_1(_part);
	if (_part == TARGET_ZONE_RANDOM) then {
		_part = callSelf(pickRandomTargZone);
	};
	if callSelfParams(hasPart,[_part] call gurps_convertTargetZoneToBodyPart) exitWith {
		_part
	};

	private _tzRedirs = go_static_internal_map_redirzones getOrDefault [_part,[]];
	private _possibles = [];
	{
		if callSelfParams(hasPart,[_x] call gurps_convertTargetZoneToBodyPart) then {
			_possibles pushBack _x;
		};
		true;
	} count _tzRedirs;
	if (count _possibles > 0) then {
		_possibles select 0
	} else {
		TARGET_ZONE_TORSO
	};
};

//Получает повреждения для персонажа
//PROBABLY OBSOLETED
func(getDmg)
{
	objParams();
	callSelf(getST) call gurps_getDamageByStrength
};

//Только для холодного оружия
func(getDmgByAttackType)
{
	objParams_1(_attackType);
	private _st = callSelf(getST);
	if (!isNullVar(_attCurCombatStyle) && {equals(_attCurCombatStyle,COMBAT_STYLE_FAST_ATTACK)}) then {
		_st = (_st - 2) max 1;
	};
	private _damArr = (_st call gurps_getDamageByStrength);
	if (_attackType == ATTACK_TYPE_THRUST) exitWith {_damArr select [0,2]};
	_damArr select [2,2];
};

//получаем оружейный нод в зависимости от условий
func(getAttackerWeapon)
{
	objParams();

	//TODO replace logics
	//private _sa = getSelf(specialAction);

	/*if (_sa == SPECIAL_ACTION_KICK) exitWith {
		if callSelfParams(hasPart,BP_INDEX_LEG_L) exitWith {
			callFunc(callSelfParams(getPart,BP_INDEX_LEG_L),getItemWeaponAsPartDamager)
		};
		if callSelfParams(hasPart,BP_INDEX_LEG_R) exitWith {
			callFunc(callSelfParams(getPart,BP_INDEX_LEG_R),getItemWeaponAsPartDamager)
		};
		nullPtr
	};
	if (_sa == SPECIAL_ACTION_BITE) exitWith {
		if callSelfParams(hasPart,BP_INDEX_HEAD) exitWith {
			callFunc(callSelfParams(getPart,BP_INDEX_HEAD),getItemWeaponAsPartDamager)
		};
		nullPtr
	};*/

	if !isNullVar(__GLOBAL_FLAG_SPECACT_KICK__) exitWith {
		__GLOBAL_FLAG_SPECACT_KICK__ = null;
		private _wm = nullPtr;
		private _item = nullPtr;
		private _bpfrompart = ifcheck(equals(getSelf(activeHand),INV_HAND_R),BP_INDEX_LEG_R,BP_INDEX_LEG_L);
		if callSelfParams(hasPart,_bpfrompart) then {
			_item = callSelfParams(getPart,_bpfrompart);
			_wm = callFunc(_item,getItemWeaponAsPartDamager);
		};
		[_wm,_item]
	};
	if !isNullVar(__GLOBAL_FLAG_SPECACT_BITE__) exitWith {
		__GLOBAL_FLAG_SPECACT_BITE__ = null;
		private _wm = nullPtr;
		private _item = nullPtr;
		if callSelfParams(hasPart,BP_INDEX_HEAD) then {
			_item = callSelfParams(getPart,BP_INDEX_HEAD);
			_wm = callFunc(_item,getItemWeaponAsPartDamager);
		};
		[_wm,_item]
	};

	private _activeHand = getSelf(activeHand);
	private _item = nullPtr;
	private _wm = if callSelfParams(isEmptySlot,_activeHand) then { //в руках пусто
		//определяем оружейный нод руки
		callFunc(callSelfParams(getPart,if(_activeHand == INV_HAND_R)then{BP_INDEX_ARM_R}else{BP_INDEX_ARM_L}),getItemWeaponAsPartDamager)
	} else {
		_item = callSelfParams(getItemInSlot,_activeHand);
		if (isTypeOf(_item,SystemHandItem) && {getVar(_item,mode)=="twohand"}) then {
			_item = getVar(_item,object);
		};
		callFunc(_item,getItemWeapon)
	};

	if isNullVar(_wm) exitWith {[nullPtr,nullPtr]};
	if equals(_wm,nullPtr) exitWith {[nullPtr,nullPtr]};

	//traceformat("ATTACKS %2 cur %1",getSelf(curAttackType) arg getVar(_wm,attackType))

	[_wm,_item]
	//getSelf(weapHands);
};

//returns weapon module and item, if handed weapon then returns body part
func(getDefenceWeapon)
{
	objParams_1(_isActiveHand); //false as second hand

	//защититься можно и второй рукой
	private _item = if (_isActiveHand) then {
		callSelf(getItemInActiveHandRedirect)
	} else {
		callSelf(getItemInNotActiveHandRedirect)
	};

	if isNullReference(_item) then {
		private _bp = [ifcheck(_isActiveHand,getSelf(activeHand),callSelf(getNotActiveHand))] call gurps_convertSlotToBodyPart;
		//определяем оружейный нод руки
		//callFunc(callSelfParams(getPart,if(_activeHand == INV_HAND_R)then{BP_INDEX_ARM_R}else{BP_INDEX_ARM_L}),getItemWeaponAsPartDamager)

		//check has hand
		if callSelfParams(hasPart,_bp) then {
			[callFunc(callSelfParams(getPart,_bp),getItemWeaponAsPartDamager),callSelfParams(getPart,_bp)]
		} else {
			[nullPtr,nullPtr]
		};

	} else {
		[callFunc(_item,getItemWeapon),_item]
	};
};

//Проверяет можно ли атаковать в эту зону
func(hasTargetZoneForAttack)
{
	objParams_1(_TARGET_ZONE);
	if (_TARGET_ZONE in [TARGET_ZONE_EYE_L,TARGET_ZONE_EYE_R]) exitWith {
		if !callSelfParams(hasPart,BP_INDEX_HEAD) exitWith {false};

		private _eyeInd = if (_TARGET_ZONE == TARGET_ZONE_EYE_L) then {0} else {1};
		if equals(getVar(callSelfParams(getPart,BP_INDEX_HEAD),eyes) select _eyeInd,nullPtr) exitWith {false};
		true
	};
	callSelfParams(hasPart,[_TARGET_ZONE] call gurps_convertTargetZoneToBodyPart)
};


func(onDamageMessage)
{
	objParams_5(_target,_typeAttack,_zoneText,_selection,_postMessageEffect);

	if equals(_attCurCombatStyle,COMBAT_STYLE_WEAK) then {
		_typeAttack = pick[
			"легонечко","слабенько","слегонца","слабо","несильно",
			"в пол силы","слегка","аккуратно","аккуратненько","щадяще","безопасно"]+" " + _typeAttack;
	};
	if equals(_attCurCombatStyle,COMBAT_STYLE_STRONG_ATTACK) then {
		_typeAttack = pick["со всей дури","что есть сил","в полную силу","сильно"]+" " + _typeAttack;
	};

	//caller бьёт мечом ЗОНУ target. additional
	private _fmt = format["%1 %3 %4 %2.<t size='0.8' shadow = '0'>%5</t>",
		callSelfParams(getNameEx,"кто"),
		callFuncParams(_target,getNameEx,"кого"),
		_typeAttack,
		_zoneText,
		_postMessageEffect];
	if !isNullVar(_flagTDEF_onAttack) then {
		_fmt = "<t size='1.4' shadow = '0'>Контратака!</t> " + _fmt;
	};
	if equals(_attCurCombatStyle,COMBAT_STYLE_FINT) then {
		_fmt = "<t size='1.4' shadow = '0'>Обманная атака!</t> " + _fmt;
	};
	/*if equals(_attCurCombatStyle,COMBAT_STYLE_STRONG_ATTACK) then {
		_fmt = "<t size='1.4' shadow = '0'>Сильная атака!</t> " + _fmt;
	};*/

	callSelfParams(worldSay,_fmt arg "combat");
};

func(onMissMessage)
{
	objParams_4(_target,_attWeap,_zoneIndex,_postMessageEffect);

	//1 промахивается, пытаясь атаковать ЧАСТЬ кого ЧЕМ
	//TODO добавить текстовое описание оружия атакуюещго
	private _fmt = format["%1 промахивается, пытаясь %3 %4 %2 %5.<t size='0.8' shadow = '0'>%6</t>",
		callSelfParams(getNameEx,"кто"),
		callFuncParams(_target,getNameEx,"кого"),
		pick(["поразить" arg "атаковать" arg "повредить"]),
		[_zoneIndex arg TARGET_ZONE_NAME_WHAT] call gurps_convertTargetZoneToString,
		callFunc(_attWeap,getMissAttackWeaponText),
		_postMessageEffect
	];
	callSelfParams(worldSay,_fmt arg "combat");
};

func(setAttackType)
{
	objParams_1(_newMode);
	callSelfParams(onChangeAttackType,"set" arg _newMode);
};

func(onChangeAttackType)
{
	objParams_2(_mode,_newType);//next, sync
	#ifdef DEBUG
		#define debuginfo(mes) breakpoint("("+getSelf(name)+")::EVENT::("+_mode+") " + mes)
	#else
		#define debuginfo(mes)
	#endif

	private _syncDataOnChangeHand = {
		__csmodes = 0;
		_assocEnum = ATTACK_TYPE_ASSOC_HAND;
		if !isNullReference(_itm) then {
			if (isTypeOf(_itm,IRangedWeapon) && {getVar(_itm,isShootMode)}) then {
				__csmodes = 1;
			};
			_assocEnum = callFunc(_itm,getAttacksTypeAssoc);
		};

		//"onChngHndSync" old
		//new byte transfer alg
		// if shoot mode negative buffer(вообще то если у нас доступные режимы как стрелковые то и флаг не нужен...)
		//[hand(1 byte)][cur combat style(1 byte)][attacktype(2 byte)][attack typelist enum(2 byte)].[targetzone(2 byte)][spec act(2 byte)]
		//2 1 99 99.99 99
		private _buffer = [getSelf(activeHand),"activeHand",true] call ata_buf_process;
		modvar(_buffer) + ([getSelf(curCombatStyle),"combatStyle",true] call ata_buf_process);
		modvar(_buffer) + ([getSelf(curAttackType),"attackType",true] call ata_buf_process);
		modvar(_buffer) + ([_assocEnum,"attackTypesList",true] call ata_buf_process);
		modvar(_buffer) + "." + ([getSelf(curTargZone),"targetZone",true] call ata_buf_process);
		modvar(_buffer) + ([getSelf(specialAction),"specialAction",true] call ata_buf_process);
		traceformat("last buffer %1 %2",_buffer arg _itm);

		//_buffer = parseNumber _buffer;
		callSelfParams(sendInfo,"onSBH" arg _buffer);
		//callSelfParams(sendInfo,"onChngHndSync" arg [getSelf(activeHand) arg getSelf(curAttackType) arg __csmodes arg getSelf(curTargZone) arg getSelf(specialAction) arg getSelf(curCombatStyle)]);
	};

	if (_mode == "change_hand") exitWith {
		debuginfo("Started")
		private _itm = callSelf(getItemInActiveHandRedirect);//callSelfParams(getItemInSlot,getSelf(activeHand));
		if isNullReference(_itm) exitWith {
			debuginfo("validate style empty hand - " + str not_equals(getSelf(curAttackType),ATTACK_TYPE_THRUST))
			if not_equals(getSelf(curAttackType),ATTACK_TYPE_THRUST) then {
				setSelf(curAttackType,ATTACK_TYPE_THRUST);
			};
			//для синхры названий огнестрельных боевых стилей
			call _syncDataOnChangeHand;
		};
		private _att = getVar(_itm,lastAttLoc) select 1;
		debuginfo("validate style item " + str not_equals(_att,getSelf(curAttackType)))
		if not_equals(_att,getSelf(curAttackType)) then {
			setSelf(curAttackType,_att);
		};
		//для синхры названий огнестрельных боевых стилей
		call _syncDataOnChangeHand;
	};
	if (_mode == "set") exitWith {
		debuginfo("Started")
		private _itm = callSelf(getItemInActiveHandRedirect);//callSelfParams(getItemInSlot,getSelf(activeHand));
		if !isNullReference(_itm) then {
			debuginfo("not null - can set:" + str callFuncParams(_itm,canSetAttackType,_newType))
			if callFuncParams(_itm,canSetAttackType,_newType) then {
				callFuncParams(_itm,onSetAttackType,_newType arg this);
				call _syncDataOnChangeHand;
			} else {
				callFuncParams(_itm,onCantSetAttackType,this);
			};
		};
	};
	//синхронизация активной руки
	if (_mode == "sync") exitWith {
		debuginfo("Started")
		private _itm = callSelf(getItemInActiveHandRedirect);//callSelfParams(getItemInSlot,getSelf(activeHand));
		if isNullReference(_itm) exitWith {
			debuginfo("null item")
			if not_equals(getSelf(curAttackType),ATTACK_TYPE_THRUST) then {
				debuginfo("do sync final")
				setSelf(curAttackType,ATTACK_TYPE_THRUST);
			};
			//для синхры названий огнестрельных боевых стилей
			call _syncDataOnChangeHand;
		};
		getVar(_itm,lastAttLoc) params ["_mob","_att"];
		if not_equals(_mob,this) then {
			debuginfo("non equal location")
			private _hashList = hashSet_toArray(getVar(callFunc(_itm,getItemWeapon),attackType));
			//check if weap module contains cur att type (first init check)
			if !array_exists(_hashList,_att) then {
				debuginfo("override first attack type: " + str _hashList + " > " + str _att)
				_att = _hashList select 0;
				getVar(_itm,lastAttLoc) set [1,_att];
			};

			debuginfo("validate cur attack " + str not_equals(_att,getSelf(curAttackType)))
			//текущий режим атаки был другой
			if not_equals(_att,getSelf(curAttackType)) then {
				//проверяем есть ли такой режим
				debuginfo("check type exists " + str array_exists(_hashList,getSelf(curAttackType)))
				if array_exists(_hashList,getSelf(curAttackType)) then {
					//setSelf(curAttackType,_hashList select 0);
				} else {
					setSelf(curAttackType,_hashList select 0);
				};

				getVar(_itm,lastAttLoc) set [0,this];
			} else {
				getVar(_itm,lastAttLoc) set [0,this];
			};
			//для синхры названий огнестрельных боевых стилей
			call _syncDataOnChangeHand;
		} else {
			debuginfo("equal location")
			debuginfo("check update attack type " + str not_equals(_att,getSelf(curAttackType)))
			if not_equals(_att,getSelf(curAttackType)) then {
				setSelf(curAttackType,_att);
			};
			//для синхры названий огнестрельных боевых стилей
			call _syncDataOnChangeHand;
		};
	};
	errorformat("Mob::onChangeAttackType() - unknown mode %1",_mode);
};

//Обрабатывает логику определения типа атаки для оружия
func(getAttackTypeForWeapon)
{
	objParams_1(_weapNode);
	private _hashset = getVar(_weapNode,attackType);
	private _hsArr = hashSet_toArray(_hashset);

	if !array_exists(_hsArr,getSelf(curAttackType)) then {
		callSelfParams(onChangeAttackType,"sync");
		getSelf(curAttackType)
	} else {
		getSelf(curAttackType)
	};
	/*if (count _hashset > 1) then {
		warningformat("Mob::getAttackTypeForWeapon() - Great than 1 attack types for weapon node %1 -> %2",_weapNode arg hashSet_toArray(_hashset));
		pick hashSet_toArray(_hashset)
	} else {
		hashSet_toArray(_hashset) select 0
	};	*/
};


//применяет визуальный эффект повреждений при атаке
func(applyDamageVisualEffects)
{
	objParams_3(_woundType,_woundSize,_TARGET_ZONE);
	private _data = [COMBAT_ATTDAM_DAMAGE,netTickTime,_woundSize,_woundType,[_TARGET_ZONE] call gurps_convertTargetZoneToArmaSelection];

#ifdef DEBUG
	if (_woundType < 0) exitWith {
		invokeAfterDelayParams({objParams_1(_data); callSelfParams(syncSmdVar,"attdam" arg _data)},0.01,vec2(this,_data));
	};
#endif

	callSelfParams(syncSmdVar,"attdam" arg _data);
};

func(applyDodgeVisualEffects)
{
	objParams_1(_sideAttacker);
	private _data = [COMBAT_ATTDAM_DODGE,netTickTime,_sideAttacker];
	callSelfParams(syncSmdVar,"attdam" arg _data);

	if callSelf(isAIAgent) then {
		[getSelf(owner),_sideAttacker] call anim_doDodge;
	};
};

func(applyParryVisualEffects)
{
	objParams_2(_idxHand,_enum);
	private _data = [COMBAT_ATTDAM_PARRY,netTickTime,_idxHand,_enum];
	callSelfParams(syncSmdVar,"attdam" arg _data);

	if callSelf(isAIAgent) then {
		[getSelf(owner),_idxHand,_enum] call anim_doParry;
	};
};

func(applyPointVisualEffects)
{
	objParams_3(_targ,_pos,_vec);
	private _obj = if callFunc(_targ,isMob) then {getVar(_targ,owner)} else {getVar(_targ,pointer)};
	private _data = [COMBAT_ATTDAM_POINT,netTickTime,_obj,_pos,_vec];
	callSelfParams(syncSmdVar,"attdam" arg _data);
};

//Применяет визуальный эффект атакующего при атаке
//вызывается только из метода атаки и броска
// TODO: для эффектов лязга метала например нам надо знать как прошла атака: блок, парирование
func(applyAttackVisualEffects)
{
	objParams_3(_attWeapon,_cat,_ctx);
	private _enum = if isTypeOf(_attWeapon,Item) then {
		callFuncReflect(_attWeapon,ifcheck(callSelfParams(isHoldedTwoHands,_attWeapon),"getTwoHandAnim","getCombAnim"));
	} else {
		
		if isTypeOf(_attWeapon,Fists) then {
				ITEM_COMBATANIM_HAND
		} else {
			private _itm = getSelf(slots) getOrDefault vec2(getSelf(activeHand),nullPtr);
			callFuncReflect(_itm,ifcheck(callSelfParams(isHoldedTwoHands,_itm),"getTwoHandAnim","getCombAnim"));
		};
	};

	if isTypeOf(_attWeapon,Bite) exitwith {
		callSelfParams(applyDodgeVisualEffects,"f");
	};

	private _data = [COMBAT_ATTDAM_ATTACK,netTickTime,getSelf(activeHand),_enum,0];

	// 				["","","_slotHandAtt","_enumAtt","_probEff"]
	//interact_th_addTask["_mdlOrEnum","_vp","_vd","_dist","_pd","_lvl","_spd","_LE_eff"];
	if !isNullVar(_cat) then {
		if equals(_cat,"throw") exitWith {
			private _nctx = ["th"];
			_nctx append _ctx;
			_data set [4,_nctx];
		};
		if equals(_cat,"shot") exitWith {
			private _nctx = ["sh"];
			_nctx append _ctx;
			_data set [4,_nctx];
		};
	};

	callSelfParams(syncSmdVar,"attdam" arg _data);

	if callSelf(isAIAgent) then {
		[getSelf(owner),getSelf(activeHand),_enum] call anim_doAttack;
	};
};


region(shooting)
	func(shootSelf)
	{
		objParams();

		if callSelf(isFailCombat) exitWith {
			callSelf(applyFailCombat);
		};

		private _item = callSelfParams(getItemInSlot,getSelf(activeHand));
		if isTypeOf(_item,SystemHandItem) then {_item = getVar(_item,object)};

		if !callFunc(_item,canShoot) exitWith {
			callFuncParams(_item,onCantShoot,this);
		};
		private _newSel = getSelf(curTargZone);
		if (_newSel == TARGET_ZONE_RANDOM) then {
			_newSel = callSelf(pickRandomTargZone);
			_newSel = callSelfParams(redirectZoneInExistingParts,_newSel);
		};

		if (!callFuncParams(this,hasTargetZoneForAttack,_newSel)) exitWith {
			private _mes = format["%1 отсутствует.",capitalize([_newSel] call gurps_convertTargetZoneToString)];
			callSelfParams(localSay,_mes arg "error");
		};

		private _fmt = format[
			"%1 стреляет себе в %2 из %3",
			callSelfParams(getNameEx,"кто"),
			[_newSel arg TARGET_ZONE_NAME_WHAT] call gurps_convertTargetZoneToString,
			callFuncParams(_item,getNameFor,this)
		];
		callSelfParams(worldSay,_fmt arg "combat");

		private _delegate = {
			params ['this',"_item"];
			if isNullReference(_item) exitWith {};
			if not_equals(getVar(_item,loc),this) exitwith {}; //оружие не в руках человека а значит
			if !callFunc(_item,canShoot) exitWith {};

			private _bullet = callFuncParams(_item,prepareProjectile,this);
			callFuncParams(_item,getShootDamageData,_bullet arg this) params [
				"_dam","_type","_selection","_usr","_weapon"
			];
			callFuncParams(_item,playShootSound,this);

			private _distance = 0.3;
			private _exShotDRMod = null; //exref (used in applyDamage)
			//shotgun functionality
			if isImplementFunc(_bullet,getFractionModifier) then {
				private _modLowDist = floor(callFunc(_bullet,getFractionModifier) / 2);
				callFuncParams(_weapon,getBasicDamage,_usr) params [["_dices",1],["_mod",1]];

				_dam = ((_dices call gurps_throwdices) * _modLowDist) + (_mod * _modLowDist);
				_exShotDRMod = _modLowDist;
			};
			callFuncParams(this,onBulletAct,_dam arg _type arg _selection arg _usr arg _distance arg _bullet);

			callFuncParams(_weapon,onPostShoot,this);
		};
		if (getVar(_item,shootCount)==1) then {
			[this,_item] call _delegate;
		} else {
			private _rofCoef = callFunc(_item,getRofCoef);
			for "_i" from 1 to getVar(_item,shootCount) do {
				invokeAfterDelayParams(_delegate,_i * _rofCoef,vec2(this,_item));
			};
		};
	};

	func(shootOtherMob)
	{
		objParams_1(_target);

		if callSelf(isFailCombat) exitWith {
			callSelf(applyFailCombat);
		};

		/*
			Попадание:
			берем базовое умение оружием
			добавляем точность если активен маневр точная атака
			применяем модификатор размера цели по таблице (с 19)
			применяем модификатор за расстояние до цели и скорость из с 550
			применить обстоятельства из 548
				стрельба очередью
				движение
				укрытие
			результатом будет эффективное умение

			стрельба очередью

			параметры оружия
				повр: просто берем кубики и добавляем бонус
					Жертва теряет число ЕЖ, рав-
					ное количеству прошедших сквозь
					СП повреждений. уменьшите их
					вдвое для малой пробивающей ата-
					ки, увеличьте на 50% для режущей
					и большой пробивающей; удвойте
					для проникающей и гигантской
					пробивающей атак.
				точн: добавить значение к умению
				дальн: одно число - максимальная дистация в ярдах
					если 2 числа то первое это расстояние половинных повреждений (1/2Д)
					а второе макс дальность. удачная атака на расстоянии равнвом или
					превышающем 1/2Д
				сс - скорострельность. сколько выстрелов можно сделать за ход.
				чем меньше значение, тем больше раз можно выстрелить. макимальное значение 1
					возможно захочется переделать скорострельность под свои реалии
				сила - мин сила для использования оружия. если она больше силы атакующего
				то каждое очко разницы является очками штарафа атаки
				размер - это штраф к умению при атаке в движении
				отдача - влияет на контроль оружием при стрельбе очередями
					чем выше значение, тем тяжелее контролировать подробнее на с 373

		*/

		if !callSelf(checkReadyWeapon) exitWith {};

		private _item = callSelfParams(getItemInSlot,getSelf(activeHand));
		if isTypeOf(_item,SystemHandItem) then {_item = getVar(_item,object)};

		if !callFunc(_item,canShoot) exitWith {
			callFuncParams(_item,onCantShoot,this);
		};

		private _attCurCombatStyle = getSelf(curCombatStyle);

		//стрельба второй рукой - выключаем стиль
		if !isNullVar(__GLOB_SET_FLAG_DOUBLE_ATTACK__) then {
			_attCurCombatStyle = COMBAT_STYLE_NO;
		};

		if (isNullVar(__GLOB_SET_FLAG_AIMED_ATTACK__) && equals(_attCurCombatStyle,COMBAT_STYLE_AIMED_ATTACK)) exitWith {
			callSelfParams(startProgress,_target arg "caller.onAimedAttackProcess" arg rand(0.4,0.8) arg INTERACT_PROGRESS_TYPE_FULL);
		};

		private _baseSkill = callSelfReflect("get"+callFunc(_item,getUsingSkill));

		private _mod = 0;

		if equals(_attCurCombatStyle,COMBAT_STYLE_AIMED_ATTACK) then {
			modvar(_baseSkill) + callFunc(_item,getBasicAccuracy);
			modvar(_mod) + 1; //маневр
		};

		private _isMob = callFunc(_target,isMob);

		//высчитываем модификатор дистанции
		private _distMod = [callSelfParams(getDistanceTo,_target),ifcheck(_isMob,callFunc(_target,getRealSpeed),0)] call gurps_getDistanceModificator;

		modvar(_mod) + _distMod;

		private _st = callSelf(getST);
		if (callFunc(_item,getReqST) > _st) then {
			modvar(_mod) - (callFunc(_item,getReqST) - _st);
		};

		if getSelf(inAgony) then {
			modvar(_mod) - 2;
		};
		//атака неосновной рукой
		if (!callSelfParams(isHoldedTwoHands,_item) && {getSelf(mainHand)!=getVar(_item,slot)}) then {
			modvar(_mod) - 2;
		};

		private _mePos = ((getPosATL callSelf(getBasicLoc)) select 2);
		private _targPos = ((getPosATL callFunc(_target,getBasicLoc)) select 2);
		//TODO прверка выше/ниже цели

		//куда атакуем
		private _attTargetZone = getSelf(curTargZone);
		private _attIsRandomTargetZone = false;
		//выбор случайной части дамага
		if (_attTargetZone == TARGET_ZONE_RANDOM) then {
			_attIsRandomTargetZone = true;
			_attTargetZone = callSelf(pickRandomTargZone);
			_attTargetZone = callSelfParams(redirectZoneInExistingParts,_attTargetZone);
		};

		private _restrictionByModifier =false;

		//за зону попадания
		#define __isZoneIn(zones,modif) if (_attTargetZone in [zones]) exitWith {MOD(_mod,modif)}
		if (!_attIsRandomTargetZone) then {
			__isZoneIn(TARGET_ZONE_TORSO arg TARGET_ZONE_ABDOMEN,+0);
			__isZoneIn(TARGET_ZONE_ARM_R arg TARGET_ZONE_ARM_L arg TARGET_ZONE_LEG_L arg TARGET_ZONE_LEG_R,-2);
			__isZoneIn(TARGET_ZONE_GROIN,-3);
			__isZoneIn(TARGET_ZONE_FACE arg TARGET_ZONE_NECK arg TARGET_ZONE_MOUTH,-5);
			__isZoneIn(TARGET_ZONE_HEAD,-7);
			__isZoneIn(TARGET_ZONE_EYE_R arg TARGET_ZONE_EYE_L,-9);
		} else {
			//if (isAimed) then {_mod += 4}
		};

		if !callFuncParams(this,hasPerk,"PerkSeeInDark") then {
			private _callerLight = callFunc(this,getLighting);
			if (_callerLight < LIGHT_MEDIUM) then {
				if (_callerLight == LIGHT_LOW) exitWith {modvar(_mod)-2};
				modvar(_mod)-4; //стрельба в полной темноте
			};
		};

		//с закрытыми глазами или без них не повоюешь
		private _viewmode = callFunc(this,getViewMode);
		if (_viewmode < VIEW_MODE_FULL) then {
			modvar(_mod)+ifcheck(equals(_viewmode,VIEW_MODE_MEDIUM),-5,-10);
			_restrictionByModifier = true;
		};

		if (getVar(this,penaltySupressFire)>0)then{
			modvar(_mod) - 3;
		};

		if equals(_attCurCombatStyle,COMBAT_STYLE_AIMED_ATTACK) then {
			modvar(_mod) + 4;
		};

		if equals(_attCurCombatStyle,COMBAT_STYLE_FAST_ATTACK) then {
			modvar(_mod) - 4;
		};

		if (_restrictionByModifier) then {_mod = _mod min 9};

		private _factSkill = _baseSkill + _mod;
		throw3d6(_factSkill) params ["_attRollAmount","_attRollType","_attRollResult"];

		private _vectorDirection = callSelf(getLastInteractVector);

		//TODO on fail or cirt fail doJamWeapon
		if (_attRollType == DICE_CRITFAIL) exitWith {
			if (_attRollAmount in [3,4,17,18]) exitWith {
				//оружие ломается
			};
			if (_attRollAmount in [5,6]) exitWith {
				//ухитрился попасть по себе...
				//при 6 тоже самое но половина повреждений
			};
			if (_attRollAmount in [7,13]) exitWith {
				//потеря равновесия (стан)
			};
			if (_attRollAmount in [8,12]) exitWith {
				//рука соскальзывает с оружия
			};
			if (_attRollAmount in [9,10,11,14]) exitWith {
				//роняем оружие
			};
			if (_attRollAmount in [15]) exitWith {
				//растянул плечо
			};
			if (_attRollAmount in [16]) exitWith {
				//падаем
			};

		};

		if (_attRollType == DICE_FAIL) then {
			private _vdr = _vectorDirection select 0;
			private _valBias = abs(_attRollAmount)*0.1;
			MODARR(_vdr,0,+ rand(-_valBias,_valBias));
			MODARR(_vdr,1,+ rand(-_valBias,_valBias));
		};
		private _addPenaltySupressFire = 0;
		if (_attRollType in [DICE_SUCCESS,DICE_CRITSUCCESS]) then {
			if equals(_attCurCombatStyle,COMBAT_STYLE_FINT) then {
				//пока не переработан огонь на подавление не менять с единицы, так как штрафы к per и dx
				_addPenaltySupressFire = 1;
				MODARR(_vdr,0,+ rand(-0.01,0.01));
				MODARR(_vdr,1,+ rand(-0.01,0.01));
			};
		};
		
		private _usr = this; //не вижу выше определения usr поэтому переназначим

		//params ["_gobj","_vecPos","_vecDir","_distance","_precdown","_leveldown","_speed","_refThis",["_throwMode",SI_TM_THROW]];
		if (getVar(_item,shootCount)==1) then {
			[
				_item,
				callSelf(getLastInteractStartPos),
				_vectorDirection,
				callFuncParams(_item,getBasicDistance,_usr),
				callFuncParams(_item,getPrecDown,_usr),
				callFuncParams(_item,getLevelDown,_usr),
				callFuncParams(_item,getShootSpeed,_usr),
				this, //user
				SI_TM_SHOOT,
				_addPenaltySupressFire
			] call si_addThrowTask;
			callFuncParams(_item,onPostShoot,this);
		} else {
			//стрельба очередью
			private _rofCoef = callFunc(_item,getRofCoef);
			private _c = null;
			private _args = [
				_item,
				callSelf(getLastInteractStartPos),
				_vectorDirection,
				callFuncParams(_item,getBasicDistance,_usr),
				callFuncParams(_item,getPrecDown,_usr),
				callFuncParams(_item,getLevelDown,_usr),
				callFuncParams(_item,getShootSpeed,_usr),
				this, //user
				SI_TM_SHOOT,
				_addPenaltySupressFire
			];

			for "_i" from 1 to getVar(_item,shootCount) do {
				_c = {
					params ["_args","_item",'this'];
					if isNullReference(_item) exitWith {};
					if not_equals(getVar(_item,loc),this) exitwith {}; //оружие не в руках человека а значит
					if callFunc(_item,canShoot) then {
						_args call si_addThrowTask;
						callFuncParams(_item,onPostShoot,this);
					};
				}; invokeAfterDelayParams(_c,_i * _rofCoef,vec3(_args,_item,this));
				/*if callFunc(_item,isCocked) then {
					private _args = [
						_item,
						callSelf(getLastInteractStartPos),
						_vectorDirection,
						callFuncParams(_item,getBasicDistance,_usr),
						callFuncParams(_item,getPrecDown,_usr),
						callFuncParams(_item,getLevelDown,_usr),
						callFuncParams(_item,getShootSpeed,_usr),
						this, //user
						SI_TM_SHOOT,
						_addPenaltySupressFire
					];
					invokeAfterDelayParams(si_addThrowTask,_i * _rofCoef,_args);//debug_rof = 0.093

				};*/
			};
		};
		private _rta = getSelf(rta);
		if equals(_attCurCombatStyle,COMBAT_STYLE_FAST_ATTACK) then {
			_rta = _rta/2;
		};
		callSelfParams(syncAttackDelayProcess,"ranged" arg nullPtr arg _item arg _rta);

		if equals(_attCurCombatStyle,COMBAT_STYLE_DOUBLE_ATTACK) then {

			//флаг внешнего определения. объявлен в onDoubleAttackProcess()
			if !isNullVar(__GLOB_SET_FLAG_DOUBLE_ATTACK__) exitWith {};

			//если нулл итем выходим - удар рукой. не двуручка
			//если предмет двуручен выходим
			if (!isNullReference(_item) && {callSelfParams(isHoldedTwoHands,_item)}) exitWith {};

			callSelfAfterParams(onDoubleAttackProcess,rand(0.2,0.6),_target); //todo timeout rand from rta values
		};

	};

	//setting combat style
	func(setCombatStyle)
	{
		objParams_1(_stl);
		if equals(_stl,getSelf(curCombatStyle)) exitWith {};
		setSelf(curCombatStyle,_stl);
		callSelfParams(onChangeAttackType,"sync");
	};

	//штраф за попадание. до 3х максиммум. накладывается при огне на подавление
	var(penaltySupressFire,0);
	func(handlePenaltySupressFireAdd)
	{
		objParams_1(_p);
		if (getSelf(penaltySupressFire)+_p>3) exitWith {};
		rp_log("Огонь на подавление для %1 на %2",callSelf(getName) arg _p);
		modSelf(penaltySupressFire, + _p);
		callSelfAfterParams(penaltySupressFireRemove,5,_p);
		//custom
		callSelfParams(addTimeBouns,"per" arg -1 arg 5);
		callSelfParams(addTimeBouns,"dx" arg -1 arg 5);
	};

	func(penaltySupressFireRemove)
	{
		objParams_1(_val);
		modSelf(penaltySupressFire,-_val);
	};

	//double attack functionality
	func(onDoubleAttackProcess)
	{
		objParams_1(_targ);

		//Ты не активен алло
		if !callSelf(isActive) exitWith {};

		//здесь подразумевается что мы атакуем при наличии части
		callSelfParams(setActiveHand,callSelf(getNotActiveHand));
		private __GLOB_SET_FLAG_DOUBLE_ATTACK__ = true; //защита от цикла двуручной атаки
		callSelfParams(clickTarget,_targ);
		callSelfParams(setActiveHand,callSelf(getNotActiveHand));
	};

	func(onAimedAttackProcess)
	{
		objParams_1(_targ);

		//Ты не активен алло
		if !callSelf(isActive) exitWith {};

		private __GLOB_SET_FLAG_AIMED_ATTACK__ = true;
		callSelfParams(shootOtherMob,_targ);
	};

	//sync delay for attack
	func(syncAttackDelayProcess)
	{
		objParams_4(_type,_attWeapon,_attItem,_overrideRTA);

		if isNullVar(_overrideRTA) then {
			_overrideRTA = getSelf(rta);
		};
		private _isTwoHanded = false;
		if (!isNullReference(_attItem) && {callSelfParams(isHoldedTwoHands,_attItem)}) then {
			_isTwoHanded = true;
		};

		//decl some local delegates
		private __replicateData = {
			_postfix = ifcheck(equals(_this,INV_HAND_L),"l","r");
			callSelfParams(fastSendInfo,"cd_lca_"+_postfix arg _overrideRTA);
		};
		private _replFull = {
			//replicate
			getSelf(activeHand) call __replicateData;
			callSelf(getNotActiveHand) call __replicateData;

			setSelf(lastCombatActionTime,(tickTime + _overrideRTA));
			setSelf(otherLastCombatActionTime,tickTime + _overrideRTA);
		};
		private _replActive = {
			getSelf(activeHand) call __replicateData;
			setSelf(lastCombatActionTime,tickTime + _overrideRTA);
		};

		if (_type == "melee") exitWith {
			_overrideRTA = _overrideRTA * TIME_RTA_MODIF_ATTACK_MELEE;
			if (_isTwoHanded) then _replFull else _replActive;
		};
		if (_type == "combatmode") exitWith {
			//TODO если провести атаку и перезайти в комбат то сбросится задержка.
			_overrideRTA = _overrideRTA * TIME_RTA_MODIF_READY_FOR_FIGHT;
			call _replFull;
		};
		if (_type == "ranged") exitWith {
			_overrideRTA = _overrideRTA * TIME_RTA_MODIF_ATTACK_RANGED;
			if (_isTwoHanded) then _replFull else _replActive;
		};
		if (_type == "throwing") exitWith {
			_overrideRTA = _overrideRTA * TIME_RTA_MODIF_THROWING;
			if (_isTwoHanded) then _replFull else _replActive;
		};
		if (_type == "parry") exitWith {
			call {
				private _parry = getVar(_attWeapon,parryCapability);
				if (_parry == WEAPON_PARRY_UNBALANCED) exitWith {
					_overrideRTA = _overrideRTA * TIME_RTA_MODIF_PARRY_UNBALANCED;
				};
				if (_parry == WEAPON_PARRY_ENABLE) exitWith {
					_overrideRTA = _overrideRTA * TIME_RTA_MODIF_PARRY;
				};
				if (_parry == WEAPON_PARRY_FENCING) exitWith {
					_overrideRTA = _overrideRTA * TIME_RTA_MODIF_PARRY_FENCING;
				};
				errorformat("%1::syncAttackDelayProcess<%2> - cant find parry type (%3)",
					callSelf(getClassName) arg _type arg _parry);
			};

			if (_isTwoHanded) then _replFull else _replActive;
		};
	};
	var(__lasttime_message_unreadyweap__,0);//внутренняя приватная переменная от спама сообщений неготового оружия
	//true если атака пройдёт. false если нет
	func(checkReadyWeapon)
	{
		objParams();
		if (getSelf(lastCombatActionTime) > tickTime) exitWith {
			if (tickTime >= getSelf(__lasttime_message_unreadyweap__)) then {
				setSelf(__lasttime_message_unreadyweap__,tickTime + 1); //антиспам
				callSelfParams(localSay,"Оружие не готово к следующей атаке" arg "error");
			};
			false
		};
		if (callSelf(isHandcuffed) && {!isNullVar(__GLOBAL_FLAG_SPECACT_KICK__)}) exitwith {
			callSelfParams(localSay,"Мои руки связаны." arg "error");
			false
		};
		true
	};
