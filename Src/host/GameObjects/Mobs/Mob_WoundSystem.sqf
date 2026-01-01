// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================


#define usesimplog

#ifdef usesimplog
	#define simpLog(mes) trace("[WOUNDRULES::PROC]: " + mes);
	#define addWoundEvent(eventname) if !(#eventname in _deleg_evNames) then {_deleg_events pushBack woundSystem_##eventname; _deleg_evNames pushBack #eventname }; _deleg_callstack pushBack 'eventname'
#else
	#define simpLog(mes)
	#define addWoundEvent(eventname) if !(#eventname in _deleg_evNames) then {_deleg_events pushBack woundSystem_##eventname; _deleg_evNames pushBack #eventname }
#endif

#define convWoundToText(size) (["scratch","minor","moderate","major","critical","massive","gawdawful","destruction"] select size)
#define canPassWound(size) if (_woundSize < size) exitWith {}; simpLog("In size - " + convWoundToText(size) + " (" +str size + ")")

#define isMaximizedWound(size) (_woundSize <= size)

//константная внешняя ссылка
#define postMessageEffect _postMessageEffect
//список ран для этого стека
#define woundList _woundArrCurPart

#define isWoundType(type) _woundType == type
#define isDamageType(type) (_dmgType == type)

//Внутренние проверки в делегатах
#define hasCountWounds(level,eqVal) ((woundList getOrDefault [level,0]) eqVal)
#define isWoundMoreThan(level) (((keys woundList) findif {_x > level}) != -1)
//	Если есть столько-то ран уровня level ИЛИЛ есть рана больше этого уровня level
#define checkWound(level,eqVal) hasCountWounds(level,eqVal) || isWoundMoreThan(level)



woundSystem_onWoundProcess = {
	objParams_5(_woundType,_dmgType,_woundSize,_bodyPart,_hitZone);

	private _ht = callSelf(getHT);

	//Штраф от размера раны к броскам _stunDelegate
	private _shtraf = 0;

	private _shockLevel = 1;
	private _painLevel = 0;

	private _deleg_events = [];
	private _deleg_evNames = [];
	#ifdef usesimplog
		_deleg_callstack = [];
	#endif

	private _bodyPartObj = callSelfParams(getPart,_bodyPart);

	private _isHeadWound = _hitZone in TARGET_ZONE_LIST_HEAD;
	private _isLimbWound = _hitZone in TARGET_ZONE_LIST_LIMBS;
	private _isTorsoWound = _hitZone in TARGET_ZONE_LIST_TORSO;
	private _isHandsWound = _hitZone in [TARGET_ZONE_ARM_R,TARGET_ZONE_ARM_L];
	private _isLegsWound = _hitZone in [TARGET_ZONE_LEG_R,TARGET_ZONE_LEG_L];

	private _isBruise = isWoundType(WOUND_TYPE_BRUISE); //пробивающий
	private _isBleeding = isWoundType(WOUND_TYPE_BLEEDING); //режущий
	private _isBurn = isWoundType(WOUND_TYPE_BURN); //ожоговый

	private _isDTImp = isDamageType(DAMAGE_TYPE_IMPALING); //Колющий
	private _isShoot = isDamageType(DAMAGE_TYPE_PIERCING_SM)
		|| isDamageType(DAMAGE_TYPE_PIERCING_NO)
		|| isDamageType(DAMAGE_TYPE_PIERCING_HU)
		|| isDamageType(DAMAGE_TYPE_PIERCING_LA);

	call {
		canPassWound(WOUND_SIZE_SCRATCH); //0

		//(REPLACED TO RULE IF DMG < 0)if (_woundSize == WOUND_SIZE_SCRATCH) then {MOD(_postMessageEffect,+ " Урон незначителен.");};

		canPassWound(WOUND_SIZE_MINOR); //1
			_shockLevel = 2;
			//Будут выполняться броски на оглушение и нокдаун
			addWoundEvent(stunDelegate);

		canPassWound(WOUND_SIZE_MODERATE); //2
			_shockLevel = 3;
			_painLevel = 1; //за зубы даётся 3
			_shtraf = ifcheck(_isHeadWound,2,0);

			//пробивной урон в зубы вызывает потерю зубов
			if (_hitZone == TARGET_ZONE_MOUTH && _isBruise) then {addWoundEvent(teethLossDelegate);};
			if (
					(
						(checkWound(WOUND_SIZE_MAJOR,>=2) || isMaximizedWound(WOUND_SIZE_CRITICAL)) ||
						(checkWound(WOUND_SIZE_MODERATE,>=3) && _hitZone == TARGET_ZONE_NECK)
					) &&
				//common state
				(_isBleeding || _isDTImp || _isShoot)
				) then {
					addWoundEvent(arteryDelegate);
				};

		canPassWound(WOUND_SIZE_MAJOR); //3
			_shockLevel = 4;
			_painLevel = 2;
			_shtraf = if (_isHeadWound) then {5} else {0};
			if (_isDTImp || _isShoot) then {
				addWoundEvent(eyeLossDelegate);
			};

			//Ломаем кости если ещё не сломаны
			//Но если зона конечность и урон больше критической то добавления не нужно
			if (/*(_woundSize <= WOUND_SIZE_CRITICAL || _isTorsoWound) &&*/ _isBruise || _isShoot) then {
				addWoundEvent(breakDelegate);
			};

			if (_isShoot && (checkWound(WOUND_SIZE_MAJOR,>= 2) || _isHeadWound)) then {
				addWoundEvent(impalingDelegate);
			};

		canPassWound(WOUND_SIZE_CRITICAL); //4
			_painLevel = 3;


			if (
				(
					checkWound(WOUND_SIZE_CRITICAL,>= 1) && _isHeadWound ||
					checkWound(WOUND_SIZE_CRITICAL,>= 2) && _isHandsWound ||
					checkWound(WOUND_SIZE_CRITICAL,>= 3) && _isLegsWound
				) && isMaximizedWound(WOUND_SIZE_CRITICAL)
			) then {
				if (_isBruise) then {addWoundEvent(limbDestroyDelegate)};
				if (_isBleeding) then {addWoundEvent(limbLossDelegate)};
			};

			if (_isDTImp) then {addWoundEvent(impalingDelegate)};

		canPassWound(WOUND_SIZE_MASSIVE); //5
			_painLevel = 4;
			if (_isBruise) then {addWoundEvent(limbDestroyDelegate)};
			if (_isBleeding) then {
				if (_isShoot) exitWith {
					addWoundEvent(limbDestroyDelegate)
				};
				addWoundEvent(limbLossDelegate)
			};

		canPassWound(WOUND_SIZE_GAWDAWFUL); //6
			if (_isTorsoWound) then {callSelfParams(Die,di_vitalPartLoss)};
		canPassWound(WOUND_SIZE_DESTRUCTION); //7

	};

	//Вызываем настаканные события
	#ifdef usesimplog
	    simpLog("Callstack post wound delegates: " + str _deleg_callstack + "; Wound type: " + str _woundType);
	#endif
	{call _x} foreach _deleg_events;

	//Накладываем шок
	if isRuleCritAttack(RULE_CA_DSHOCK) then {
		resetRuleCritAttack;
		MOD(_postMessageEffect,+ " Это должно быть очень больно.");
		_shockLevel = (_shockLevel * 2) min 8;
	};
	callSelfParams(applyShock,_shockLevel);

	if (_painLevel > 0) then {
		callSelfParams(addPainLevel,_bodyPart arg _painLevel arg true);
	};
};

/*******************************************************************************
================================================================================
		REGION: DAMAGE EVENT DELEGATES
================================================================================
*******************************************************************************/

//бросок на оглушение и нокдаун
woundSystem_stunDelegate = {

	//На минорной ране бросить стан можно только через голову
	if (_woundSize <= WOUND_SIZE_MODERATE && !_isHeadWound) exitWith {};
	//TODO replace this to checkSkill
	unpackRollResult(throw3d6(_ht - _shtraf),_amount,_diceRez,_3d6Amount);

	logmob(_stunDelegate(),"Результаты броска:" + format vec4("HT:%1; PENALTY:%2; AMNT:%3; d36:%4",_ht,_shtraf,_amount arg _3d6Amount));

	//Первый бросок на оглушение
	if (_diceRez in [DICE_FAIL,DICE_CRITFAIL]) then {
		MOD(_postMessageEffect,+ " Цель оглушена!");

		if (_amount <= -5) then {
			
			//setUnconscious
			callSelfParams(setUnconscious,TIME_UNCONSCIOUS_ONWOUND);

			logmob(_stunDelegate(),"Бросок провален на бессознанку");
		} else {
			callSelfParams(Stun,TIME_STUN_ONWOUND);
			logmob(_stunDelegate(),"Бросок провален на стан");

			unpackRollResult(throw3d6(_ht - _shtraf),_amount,_diceRez,_3d6Amount);
			if(_diceRez in [DICE_FAIL, DICE_CRITFAIL]) then {
				callSelf(KnockDown);
				logmob(_stunDelegate(),"Бросок провален на кнокдаун");
			};			
		};

	};
};

//перелом
woundSystem_breakDelegate = {

	#define canBreakBone() !callFunc(_bodyPartObj,isBoneBroken)

	//simpLog("break delegate start")
	private _hasBreakProcess = false;
	private _zoneBreakMes = "что-то ломается";

	call {

		//если кость ещё не сломана ломаем её
		if (_isLimbWound) exitWith {
			if (canBreakBone() && {checkWound(WOUND_SIZE_MAJOR,>= 2)}) exitWith {
				_hasBreakProcess = true;
				_zoneBreakMes = "ломается кость";
			};
		};
		if (_hitZone in [TARGET_ZONE_TORSO,TARGET_ZONE_ABDOMEN]) exitWith {
			if (canBreakBone() && {checkWound(WOUND_SIZE_MAJOR,>= 3)}) then {
				_hasBreakProcess = true;
				_zoneBreakMes = "ломаются рёбра";
			};
		};
		if (_hitZone in TARGET_ZONE_LIST_HEAD) exitWith {

			if (_hitZone == TARGET_ZONE_HEAD) exitWith {
				if (canBreakBone() && {checkWound(WOUND_SIZE_MAJOR,>= 2)}) then {
					_hasBreakProcess = true;
					_zoneBreakMes = "ломается череп";
				}
			};
			if (_hitZone == TARGET_ZONE_FACE) exitWith {}; //лицо в кашу
			if (_hitZone == TARGET_ZONE_MOUTH) exitWith {}; //минус зубки/челюсть
		};

		errorformat("NO APPLY EFFECT TO PART %1",_hitZone);
	}; //call-switch



	if (_hasBreakProcess) then {
		_painLevel = 4; //агония

		//apply message
		private _howEffect = pick ["Со сладким","С удовлетворительным","С жалобным","С мерзким","С ужасающим","С отвратительным","С вялым"];
		private _soundEffec = pick ["хрустом" arg "треском" arg "скрежетом"];
		private _breakMes = format[" %1 %2 %3.",_howEffect,_soundEffec,_zoneBreakMes];
		MOD(postMessageEffect,+ _breakMes);

		callFuncParams(_bodyPartObj,setBoneStatus,BONE_STATUS_BROKEN);
	};
};

//потеря конечности
woundSystem_limbDestroyDelegate = {
	if (_isLimbWound || _isHeadWound) exitWith {

		private _randLossType = pick ["разлетается","разрывается"];
		private _rand = pick [" %1 %2 в клочья."," %1 %2 на куски."," %1 %2 на кусочки."];

		_rand = format[_rand,capitalize(callFunc(_bodyPartObj,getName)),_randLossType];

		callSelfParams(destroyLimb,_bodyPart);
		MOD(postMessageEffect,+ _rand);
	};
};

//отрубание конечности
woundSystem_limbLossDelegate = {
	if (_isLimbWound || _isHeadWound) exitWith {

		private _rand = pick ["отлетает %1 %2.","%1 отделяется от тела %2."];
		_rand = (pick[" Фонтанируя кровью, "," Стремительно закрутившись, "]) + _rand;

		_rand = format[_rand,tolower callFunc(_bodyPartObj,getName),callSelfParams(getNameEx,"кого")];

		callSelfParams(lossLimb,_bodyPart);
		MOD(postMessageEffect,+ _rand);
	};
};

//потеря зуба
woundSystem_teethLossDelegate = {

	//Вызывается только если зубы
	unpackRollResult(throw3d6(_ht - _shtraf),_amount,_diceRez,_3d6Amount);

	if (_diceRez in [DICE_FAIL,DICE_CRITFAIL]) then {
		callSelfParams(addPainLevel,_bodyPart arg 3 arg true);
		callSelfParams(lossTeeth,randInt(1,6));
	};
};

woundSystem_eyeLossDelegate = {
	if (_hitZone in [TARGET_ZONE_EYE_R,TARGET_ZONE_EYE_L]) exitWith {
		callSelfParams(addPainLevel,_bodyPart arg 3 arg true);
		//pop eye if exists
		private _side = [SIDE_RIGHT,SIDE_LEFT]select([TARGET_ZONE_EYE_R,TARGET_ZONE_EYE_L] find _hitZone);
		callSelfParams(lossEye,_side);
		private _rand = pick [" C влажным"," С мягким"," С противным"," С омерзительным"];
		callSelfParams(playSoundData, soundData("mob\claws",0.8,1.6));
		MOD(postMessageEffect,+ _rand + " щелчком лопается " + ([_hitZone] call gurps_convertTargetZoneToString) + ".");
	};
};

woundSystem_impalingDelegate = {
	if (_isTorsoWound) exitWith {
		private _organIndexes = [];
		//pick random organ
		call {

			if (_hitZone == TARGET_ZONE_TORSO) exitWith {
				_organIndexes = [BO_INDEX_HEART,BO_INDEX_LUNGS,BO_INDEX_LIVER];
			};
			if (_hitZone == TARGET_ZONE_ABDOMEN) exitWith {
				_organIndexes = [BO_INDEX_STOMACH,BO_INDEX_GUTS,BO_INDEX_KIDNEY_L,BO_INDEX_KIDNEY_R];
			};
		};
		private _probOrgansDam = [];
		{
			if callSelfParams(hasBodyOrgan,_x) then {
				_probOrgansDam pushBack callSelfParams(getBodyOrgan,_x);
			};
		} foreach _organIndexes;

		if (count _probOrgansDam > 0) then {
			private _org = pick _probOrgansDam;
			if callFunc(_org,isStatusOk) then {
				MOD(postMessageEffect,+ " Повреждён один из внутренних органов.");
			};
			callFunc(_org,addDamage);
		};
	};
	if (_isHeadWound) exitWith {
		if (_hitZone != TARGET_ZONE_NECK) then {
			if !callSelf(hasBrain) exitWith {};
			private _org = callSelf(getBrain);
			if callFunc(_org,isStatusOk) then {
				MOD(postMessageEffect,+ " Повреждён один из внутренних органов.");
			};
			callFunc(_org,addDamage);
		};
	};
};

//Открытие артерии
woundSystem_arteryDelegate = {
	private _bp = [_hitZone] call gurps_convertTargetZoneToBodyPart;
	if !callSelfParams(isArteryDamaged,_bp) then {
		callSelfParams(setDamageArtery,_bp arg true);
		MOD(postMessageEffect,+ " Повреждена артерия.");
	};
};
