// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================


autoref var(damageInfo,new(DODamageInfo));

"
	name:Мертв
	desc:Возвращает @[bool ИСТИНУ], если моб мертв.
	prop:get
	return:bool
	defval:false
" node_var
var(isDead,false);
//var(isSleep,false);//deprecated

"
	name:Голод
	desc:Текущее значение голода персонажа. Начальное значение 100. Минимум - 0, максимум - 100+
	prop:get
	return:float
	defval:100
" node_var
var(hunger,100); //hud_hunger
var(thirst,100); //hud_thirst
var(oxygen,100); //hud_oxy
var(toxin,0); //TODO hud_tox?!?
var(urine,0); //hud_pee
var(feces,0); //hud_poo
	var(lastFartTime,0);//...


//реагент спейс для усваивания дряни через кровь
var(reagents,new(InternalReagents)); // (176 * 28.35 = 4989.6 мл)
var(vessel,nullPtr);
var(bloodLossValue,0); //число которое будет вычитаться из крови каждую секунду в миллилитрах
var(bloodPoolLastCheck,0); //таймер для создании луж крови

//ссылки на части тела, присоединенные к мобу
var(bodyParts,createHashMap);
//пробитые артерии. Артерии на теле потому что при отрыве нужно сшить артерию
var(bodyArtery,BP_INDEX_ALL createHashMapFromArray [false arg false arg false arg false arg false arg false]);
//боль из частей тела
//var(bodyPain,BP_INDEX_ALL createHashMapFromArray [0 arg 0 arg 0 arg 0 arg 0 arg 0]);
var(painAmount,0);//сколько всего боли. суммирует общий уровень он может быть до 20
var(painNextMoan,0);//триггер времени когда стонать
var(internalPain,0);//внутренняя боль. Ссумируется с общим количеством и нужна как буферная зона

//TODO rewrite wounds var (prob replace to real body parts)
	/****************************************************************
		GROUP:WOUND SYSTEM
	****************************************************************/
	/*
		разделено на 6 сегментов
		[
			[], //head
			[], //tors
			...
			[]
		];
		при добавлении повреждения записывается его уровень и тип повреждения

		if (callSelf(isDamToNextLevel))
			_narr = getSelf(wounds) select <head> apply {if (_x == [_lvl,dmg_cut]) then {objNull} else {_x}};
			_narr = _narr - [objNull];
			getSelf(wounds) set [<head>,_narr];
		else
			getSelf(wounds) select <head> pushback [1,dmg_cut];
			getSelf(counterWounds) select <head> set [DAM_T_CUT,++];

		wounds select <head> =>
		[
			<DAMAGE_TYPE_CRUSHING>[1,1,1,3],<DAMAGE_TYPE_CUTTING>[1,2]
		]

	*/
	//                bruise bleeding burn

var(stunned,0); //время стана
var(unconscious,0); //время бессознанки
var(sleepiness,0); //насколько персонаж хочет спать. если доходит до 100 - вырубится. Использовать в слиптоксине
	var(sleepTimeStart,0); //временная отметка когда персонаж заснул
	var(sleepStrength,0); //положительное число чем больше, тем глубже сон
	var(sleepIsChangeState,false);//чтобы просыпаться постепенно
var(isCloseEyes,false); //закрыты ли глаза (веки) персонажа

var(lastDamageTime,0); //время последнего урона по персонажу

getterconst_func(enabledAtmosReaction,true); //enable living mob atmos react

//системные звуки персонажа
getter_func(getRetchSounds,["mob\male_retch1" arg "mob\male_retch2" arg "mob\male_retch3"]); //подавиться
getter_func(getPainSounds,["mob\male_pain1" arg "mob\male_pain2" arg "mob\male_pain3"]); //боль
getter_func(getMoanSounds,["mob\male_moan1" arg "mob\male_moan2" arg "mob\male_moan3"]); //слабая боль



func(_makeBodyParts)
{
	objParams();
	//hardLink
	private _list = getSelf(bodyParts);
	private _headClass = "Head" + str randInt(1,3);
	
	private _head = instantiate(_headClass);
	callFuncParams(_head,hardLink,this);

	//linking memories
	private _mem = getVar(getVar(_head,brain),memories);
	setVar(_mem,originalOwner,this);
	setVar(_mem,currentOwner,this);

	callFuncParams(new(Body),hardLink,this);
	
	{
		callFuncParams(newParams(Arm,_x),hardLink,this);
		callFuncParams(newParams(Leg,_x),hardLink,this);
	} foreach [SIDE_LEFT,SIDE_RIGHT];
};

func(_onDelete_bodyParts)
{
	objParams();
	{
		delete(_y);
	} foreach getSelf(bodyParts);
};


// Убивает персонажа
func(Die)
{
	objParams_1(_cause);

	if getSelf(isDead) exitWith {};

	if !isNullVar(_cause) then {
		if equalTypes(_cause,"") exitWith {
			errorformat("WRONG CAUSE TYPE FOR MOB::DIE() - %1",_cause);
		};
		if equalTypes(_cause,[]) then {
			callFuncParamsInline(getSelf(damageInfo),updateDamageInfo,_cause);
		} else {
			callFuncParams(getSelf(damageInfo),updateDamageInfo,_cause);
		};
	};

	private _m = format["%1 dead: %2",
		callFuncParams(gm_currentMode,getCreditsInfo,this arg false),
		callFunc(getSelf(damageInfo),getDamagetInfoFull)
	];
	#ifdef EDITOR
	callSelfParams(localSay,_m arg "log");
	#endif
	[_m] call combatLog;

	callSelfParams(setCombatMode,false);

	callSelfParams(setUnconscious,999999);//12 дней... реальных

	setSelf(isDead,true);

	callSelfAfter(__postDieCheckAnim,1.5); //fix bug

	errorformat("%1 умер по причине %2",getVar(getSelf(naming),кто) arg _cause);
	modVar(gm_currentMode,countDead, + 1);

	private _id = owner getSelf(owner);
	private _cli = _id call cm_findClientById;

	setVar(_cli,lastDeadTime,tickTime); //задежржка смерти

	//события смерти
	callFuncParams(getSelf(basicRole),onDeadBasic,this arg _cli);
	callFuncParams(getSelf(role),onDead,this arg _cli);

	if getVar(getSelf(basicRole),returnInLobbyAfterDead) then {
		[this,"Lobby"] call cm_switchToMob;

	} else {

		private _m = pick[
			"грязный","мрачный","темный","жалкий","ужасный","опасный","бездушный",
			"убийственный","беспощадный","обманчивый","гадкий","бессмысленный","глупый",
			"безжизненный","злобный","бесчувственный"
		];
		private _forsakeTxt = "покинул"; if callSelf(isFemale) then {modvar(_forsakeTxt) + "а"};
		callSelfParams(localSay,"<t size='1.4' color='#0256F2'>Ты <t shadow='1' shadowColor='#FF4040' shadowOffset='0.05'>"+_forsakeTxt+"</t> этот "+_m+" мир</t>" arg "");

		callSelfParams(playSoundLocal,"internal\die"+str randInt(1,4) arg getRandomPitchInRange(0.95,1.05));

		callSelfParams(addAction,"Мир" arg "Покинуть тело" arg "wrld_toGhost");
	};
};

func(__postDieCheckAnim) //very bad code... refactoring needed
{
	objParams();
	if !callSelf(isInUnconsciousAnim) then {
		callSelfParams(setUnconsciousAnim,true);
	};
};


region(Checkers and getters)

	func(getPart)
	{
		objParams_1(_bpIdx);
		getSelf(bodyParts) getOrDefault [_bpIdx,nullPtr];
	};

	func(hasBodyOrgan)
	{
		objParams_1(_orgIdx);
		private _torso = callSelfParams(getPart,BP_INDEX_TORSO);
		if isNullObject(_torso) exitWith {false};
		private _org = getVar(_torso,organs) getOrDefault [_orgIdx,nullPtr];
		if isNullObject(_org) exitWith {false};
		true
	};

	func(hasBodyOrganSocket)
	{
		objParams_1(_orgIdx);
		private _torso = callSelfParams(getPart,BP_INDEX_TORSO);
		if isNullObject(_torso) exitWith {false};
		_orgIdx in getVar(_torso,organs);
	};

	//unsafe getter for body organ
	func(getBodyOrgan)
	{
		objParams_1(_orgIdx);
		getVar(callSelfParams(getPart,BP_INDEX_TORSO),organs) getOrDefault [_orgIdx,nullPtr];
	};

	func(getAllInternalOrgans)
	{
		objParams();
		(values getVar(callSelfParams(getPart,BP_INDEX_TORSO),organs)) + [callSelf(getBrain)]
	};

	func(getBrain)
	{
		objParams();
		private _br = getVar(callSelfParams(getPart,BP_INDEX_HEAD),brain);
		if isNullVar(_br) exitWith {nullPtr};
		_br
	};

	getter_func(hasBrain,!isNullReference(callSelf(getBrain)));

	func(isShock)
	{
		objParams();
		not_equals(getSelf(_shockHandle),-1)
	};

region(Update and slow update)
	var(internalTimer,randInt(1,20));
	func(onUpdate)
	{
		updateParams();
		//#define USEPERLOGGER
		#ifdef USEPERLOGGER
		private _t = tickTime;
		#endif
		modSelf(internalTimer, + 1);
		//снимаем временные бонусы
		private _statRef = null;
		private _needRemove = false;
		private _timeBonus = getSelf(timeBonus);
		{
			_x params ["_stat","_amount","_timeToDispose"];
			if (tickTime >= _timeToDispose) then {
					callSelfReflectParams("add" + _stat,+_amount);
				_timeBonus set [_forEachindex,objNull];
				_needRemove = true;
			};
		} forEach _timeBonus;

		if (_needRemove) then {
			_timeBonus = _timeBonus - [objNull];
			setSelf(timeBonus,_timeBonus);
		};

		// переваривание (как усвоение)
		/*_sto = callSelfParams(getBodyOrgan,BO_INDEX_STOMACH);
		if !isNullObject(_sto) then {
			callFunc(_sto,onProcessDigestion);
		};*/

		callSelf(handle_food);

		callSelf(handle_unconscious);
		callSelf(handle_stunned);
		callSelf(handle_blood); //bloodloss and assim blood
		callSelf(handle_organs); //onupdate for all organs
		callSelf(handle_healing);
		callSelf(handle_infections);
		callSelf(handle_smell);

		callSelf(handle_pain);
		callSelf(handle_stamina);
		callSelf(handle_stealth);

		callSelf(handle_toxin);

		callSelf(handle_vomit);

		callSelf(handle_statuseffects);//medical effects and other

		#ifdef USEPERLOGGER
		    traceformat("Perfomance thread for mob %1: %2 sec",callSelf(getName) arg tickTime - _t);
		#endif
	};

region(Time bonuses)
	var(timeBonus,[]); //временные бонусы к скиллам
	//Добавляем временное значение к стате
	func(addTimeBouns)
	{
		objParams_3(_skillStr,_val,_time);

		callSelfReflectParams("add" + _skillStr,+_val);

		private _ref = getSelf(timeBonus);
		_ref pushback [_skillStr,-_val,tickTime + _time];
	};

region(Status effects)
	var(_shockHandle,-1);

	func(applyShock)
	{
		objParams_1(_amount);
		//_amount = svar;
		if callSelf(isShock) then {
			//warningformat("Shock already setted on mob %1",callSelf(getName));
			private _h = getSelf(_shockHandle);
			//errorformat("APPLYSHOCK - amount %1; before %2",_amount arg _h select 1);
			//if (_amount > (_h select 1)) then { //если уровень шока превышает предыдущее значение, игнорируем его
				_h set [2,true];
				//reset value
				private _oldAmount = (_h select 1);
				//log("IGNORED =================================================");
				callSelfParams(addDX,+_oldAmount);
				callSelfParams(addIQ,+_oldAmount);
				//log("IGNORED END =================================================");
			//};

			if (_amount < _oldAmount) then {
				_amount = _oldAmount; //Игнорируем более слабое значение
			};
		};

		callSelfParams(addDX,-_amount);
		callSelfParams(addIQ,-_amount);

		private _code = {
			params ['this',"_amount","_canIgnore"];
			if (_canIgnore) exitWith {};

			callSelfParams(addDX,+_amount);
			callSelfParams(addIQ,+_amount);
			setSelf(_shockHandle,-1);
		};

		private _shockHandle = [this arg _amount arg false];
		setSelf(_shockHandle,_shockHandle);

		invokeAfterDelayParams(_code,DELAY_SHOCK,_shockHandle);
		//svar = (svar + 1) min 3;
	};

	//упал
	"
		name:Упасть
		desc:Заставляет моба упасть. Не действует на мобов, сидящих на стульях или находящихся в положении лёжа. Не наносит урон при падении.
		type:method
		lockoverride:1
	" node_met
	func(KnockDown)
	{
		objParams();

		if callSelf(isConnected) exitWith {};
		if !callSelf(isActive) exitWith {};
		
		callSelfParams(setCustomActionState,CUSTOM_ANIM_ACTION_NONE);

		//Положить моба и заблокировать управление
		if (callSelf(getStance) != STANCE_DOWN) then {
			//error("KNOCK DOWN - switchAction is not MP-func");
			//getSelf(owner) switchAction "DOWN";
			callFuncParams(this,applyGlobalAnim,"switchaction" arg "DOWN");
			callSelfParams(playSound,"mob\bodyfall" + str pick [1 arg 2] arg getRandomPitch arg null arg 3);
		};
		//callSelfParams(Weaken,1);
	};

	"
		name:Стан
		desc:Станит моба. При стане моб не может производить никаких действий, включая движение. Смотрите описание портов для подробной информации.
		type:method
		lockoverride:1
		in:int:Время стана:Время в секундах, на которое моб не сможет выполнять действия.
		in:bool:Выронить предметы:При включении этого флага моб выронит все предметы из рук.
			opt:def=false:require=-1
		in:bool:Применение:При включении этого флага указанное время стана добавляется к существующему времени. Если флаг выключен, то время стана установится только в том случае, если в момент применения оставшееся время меньше установленного времени стана. 
			opt:def=false:require=-1
	" node_met
	// Желательно добавлять только Int32 числа
	func(Stun)
	{
		objParams_3(_amount,_allowDropItems,_isApply);
		if isNullVar(_isApply) then {_isApply = false};
		if (callSelf(isStunned)) then {
			if (_isApply) then {
				setSelf(stunned,getSelf(stunned) + _amount);
			} else {
				if (getSelf(stunned) >= _amount) then {
					setSelf(stunned,_amount);
				};
			};

		} else {
			setSelf(stunned,_amount);
			callSelfParams(syncSmdVar,"isStunned" arg true);
		};

		if isNullVar(_allowDropItems) then {
			_allowDropItems = false;
		};

		if (_allowDropItems) then {
			//выбрасываем предметы из рук
			callSelf(dropAllItemsInHands);
		};


		callSelfParams(stopProgress,true);
		callSelf(closeOpenedNetDisplay);
		callSelf(releaseBuildingPreview);
	};

	"
		name:В стане
		desc:Возвращает статус находится ли моб в стане.
		type:get
		lockoverride:1
		return:bool:Моб в стане
	" node_met
	//Является ли моб оглушённым в данный момент
	func(isStunned)
	{
		objParams();
		getSelf(stunned) > 0
	};

	//Внутренняя функция обработки стана в onUpdate
	func(handle_stunned)
	{
		if (callSelf(isStunned)) then {
			private _newStunVal = getSelf(stunned) - 1;
			setSelf(stunned,_newStunVal max 0);
			if (_newStunVal <= 0) then {
				callSelfParams(syncSmdVar,"isStunned" arg false);
			};
		};
	};

	//активен ли моб. спящий или без сознания не будет активным и не сможет к примеру уклониться
	//Мёртвые, спящие или без сознания. Одним словом - активные
	"
		name:Активен
		desc:Возвращает @[bool ИСТИНУ], если моб находится в активном состоянии. Моб активен, если он в сознании, жив и не спит.
		type:get
		lockoverride:1
		return:bool:Моб активен
	" node_met
	func(isActive)
	{
		objParams();
		!callSelf(isUnconscious) && !callSelf(isSleep) && !getSelf(isDead)
	};

	"
		name:Спит
		desc:Возвращает @[bool ИСТИНУ], если моб спит.
		type:get
		lockoverride:1
		return:bool:Моб спит
	" node_met
	getter_func(isSleep,getSelf(sleepStrength) != 0);

	"
		name:Заснуть
		desc:Заставляет моба лечь спать или проснуться. Попытка усыпления моба, находящегося в состоянии сна не даст результата. То же правило действует попытаться разбудить не спящего моба.
		type:method
		lockoverride:1
		in:bool:Заснуть:При указании значения @[bool ИСТИНА] моб заснёт. В ином случае он проснётся.
	" node_met
	func(setSleep)
	{
		objParams_1(_mode);
		if equals(callSelf(isSleep),_mode) exitWith {}; //already setted on _mode
		if getSelf(sleepIsChangeState) exitWith {};

		if (_mode) then {
			if (getSelf(sleepStrength)==0)then {
				setSelf(sleepStrength,1);
			};
			callSelfParams(changeVisionBlock,+1 arg "slp");
			callSelfParams(localSay,"Вы засыпаете..." arg "mind");
			callSelfParams(setUnconsciousAnim,true);
			callSelfParams(fastSendInfo,"hud_sleep" arg 1);
			
			if getSelf(isHoldedBreath) then {
				callSelfParams(setHoldBreath,false);
			};
		} else {
			if callSelf(__hasGameInfoMessages) exitwith {
				callSelf(__showGameInfo);
			};
			if getSelf(__isFirstUnsleep) exitWith {
				callSelfAfter(getMemoriesUNSLEEP,rand(0,2));
			};
			setSelf(sleepIsChangeState,true);
			callSelfParams(localSay,"Вы пытаетесь проснуться..." arg "mind");
		};
	};

	var(__isFirstUnsleep,true); //первое пробуждение для показа инфо о раунде

	func(onSleepStop)
	{
		objParams();
		setSelf(sleepIsChangeState,false);

		setSelf(sleepStrength,0);
		callSelfParams(fastSendInfo,"hud_sleep" arg 0);
		callSelfParams(changeVisionBlock,-1 arg "wkup");
		callSelfParams(localSay,"Вы просыпаетесь." arg "mind");

		if (!callSelf(isUnconscious)) then {
			callSelfParams(setUnconsciousAnim,false);
		};
	};

	//Добавить силу сна. _supressOnOversize подавляет изменение при увеличении и уменьшении
	func(addSleepStrength)
	{
		params ['this',"_strength",["_supressOnOversize",false]];

		private _curStr = getSelf(sleepStrength);
		private _canChangeState = false;

		if (_strength < 0) then {
			if (_supressOnOversize && (_curStr - _strength) < _strength) exitWith {};
			setSelf(sleepStrength,(_curStr - _strength) max 0);
			_canChangeState = true;
		} else {
			if (_supressOnOversize && (_curStr + _strength) > _strength) exitWith {};
			setSelf(sleepStrength,_curStr + _strength);
			_canChangeState = true;
		};

		if (_canChangeState) then {
			callSelfParams(setSleep,_strength > 0);
		};
	};

	//внутренняя функция. вызывается в обработчике handle_heal при isSleep == true
	func(__onSleepRest)
	{
		if (tickTime > getSelf(_lastcheckunsleep)) then {
			setSelf(_lastcheckunsleep,tickTime + randInt(5,6));

			__nval = (getSelf(sleepStrength) - 1) max 0;
			setSelf(sleepStrength,__nval);
			if (__nval == 0) then {
				callSelfAfter(onSleepStop,rand(1,3));
			};
		};


	};
	var(_lastcheckunsleep,0);

	"
		name:Потерять сознание
		desc:Заставляет моба потерять сознание на указанное время. Если моб уже без сознания то указанное время добавляется к текущему, которое осталось до пробуждения моба.
		type:method
		lockoverride:1
		in:int:Время:Время в секундах, на которое моб упадет в бессознательное состояние, либо время бессознательного состояния, добавленное к текущему времени.
	" node_met
	//Установить мобу бессознанку с применением эффектов, анимаций и синхронизаций
	func(setUnconscious)
	{
		objParams_1(_time);
		if (callSelf(isUnconscious)) then {
			setSelf(unconscious,getSelf(unconscious) + _time);
		} else {
			
			callSelfParams(changeVisionBlock,+1 arg "unc");
			if (callSelf(getStance) != STANCE_DOWN) then {
				callSelfParams(playSound,"mob\bodyfall" + str pick [1 arg 2] arg getRandomPitch arg null arg 3);
			};
			setSelf(unconscious,_time);
			callSelfParams(fastSendInfo,"cd_isUnconscious" arg true);

			//droping all items
			callSelf(dropAllItemsInHands);
			callSelfParams(stopProgress,true);

			callSelf(closeOpenedNetDisplay);
			callSelf(releaseBuildingPreview);

			//disable custom anim
			callSelfParams(setCustomActionState,CUSTOM_ANIM_ACTION_NONE);

			//switch off combat mode
			callSelfParams(setCombatMode,false);

			//callSelfParams(setCloseEyes,true);
			callSelfParams(setUnconsciousAnim,true);
			
			if getSelf(isHoldedBreath) then {
				callSelfParams(setHoldBreath,false);
			};
		};


	};

	
	func(isInUnconsciousAnim)
	{
		objParams();
		if callSelf(isConnected) exitWith {
			private _uInd = getVar(getSelf(connectedTo),seatListOwners) find this;
			if (_uInd==-1) exitWith {};
			private _rplObj = getVar(getSelf(connectedTo),_seatListDummy) select _uInd;
			if isNullReference(_rplObj) exitWith {};
			equals(_rplObj getvariable "__posSeatUnc",_rplObj getvariable "__posSeat")
		};
		callSelf(getAnimation) in (UNC_ANIM_LIST apply {tolower _x})
	};
	func(setUnconsciousAnim)
	{
		objParams_1(_mode);

		if callSelf(isConnected) exitWith {
			callFuncParams(getSelf(connectedTo),seatApplySeatAnim,this arg true);
		};

		if (_mode) then {
			callSelfParams(applyGlobalAnim, "switchmove" arg pick UNC_ANIM_LIST);
		} else {
			//if in combat mode and inhand weapon then need new anim
			callSelfParams(applyGlobalAnim, "switchmove" arg DEUNC_ANIM);
		};
	};

	func(handle_unconscious)
	{
		//Внутренний метод в onUpdate
		if getSelf(isDead) exitWith {};

		if callSelf(isUnconscious) then {
			private _old = getSelf(unconscious);
			DEC(_old);
			setSelf(unconscious,_old max 0); //сначала ставим значение так как ниже в setUnconsciousAnim проверка смены анимации на стуле
			if (_old <= 0) then {
				callSelfParams(setUnconsciousAnim,false);
				callSelfParams(changeVisionBlock,-1 arg "deunc");
				callSelfParams(fastSendInfo,"cd_isUnconscious" arg false);

				callFunc(getSelf(_internalEquipmentND),closeNDisplayForAllMobs);
			};
		};
	};

	"
		name:Без сознания
		desc:Проверяет находится ли моб без сознания. Данная проверка отвечает только за бессознательное состояние, не учитывая смерть и сон.
		type:get
		lockoverride:1
		return:bool:Возвращает @[bool ИСТИНУ], если моб без сознания.
	" node_met
	func(isUnconscious)
	{
		objParams();
		getSelf(unconscious) > 0
	};



	func(changeVisionBlock)
	{
		objParams_2(_modif,_lastType);

		private _newVal = (getSelf(visionBlock) + _modif) max 0;

		setSelf(visionBlock,_newVal);

		if (_lastType != "losseyes") then {
			//todo replace setfaceanim here
		};
		if (_newVal > 0) then {
			callSelfParams(setMobFaceAnim,UNC_MIMIC);
		} else {
			callSelfParams(setMobFaceAnim,DEFAULT_MIMIC);
		};

		callSelfParams(sendInfo,"onChangeEyeState" arg [_newVal arg _lastType]);
	};

	func(setCloseEyes)
	{
		objParams_1(_mode);
		if (_mode) then {
			if (getSelf(isCloseEyes) || !callSelf(isActive)) exitWith {};

			//apply close eyes anim
			//callSelfParams(applyGlobalAnim, "setMimic" arg UNC_MIMIC);

			callSelfParams(changeVisionBlock,+1 arg "clseye");
			setSelf(isCloseEyes,_mode);
		} else {
			// if eyes closed or mob in unconscious state - exit
			if (!getSelf(isCloseEyes) || !callSelf(isActive)) exitWith {};

			//callSelfParams(applyGlobalAnim, "setMimic" arg DEFAULT_MIMIC);

			callSelfParams(changeVisionBlock,-1 arg "opneye");
			setSelf(isCloseEyes,_mode);
		};

	};
	//режим видимости. закрытые глаза или их отсутствие
	func(getViewMode)
	{
		objParams();
		if getSelf(isCloseEyes) exitWith {VIEW_MODE_NONE};
		private _head = callSelfParams(getPart,BP_INDEX_HEAD);
		if isNullReference(_head) exitWith {VIEW_MODE_NONE};
		private _eyes = callFunc(_head,getEyesCount);
		if (_eyes == 1) exitWith {VIEW_MODE_MEDIUM};
		if (_eyes == 0) exitWith {VIEW_MODE_NONE};
		VIEW_MODE_FULL
	};

	//Добавляет глухоту мобу на _time сек
	func(addDeaf)
	{
		objParams_1(_time);
		callSelfParams(addTimeBouns,"per" arg -6 arg _time);
	};
	getter_func(getHearing,callSelf(getPer));
	//Как далеко слышит этот персонаж
	func(getHearingDistance)
	{
		objParams();
		10 //стандартно 10 метров. потом можно понижать значения от всякого разного...
	};

	//И прочие чувства

	//Дистанция видимости любых объектов на расстоянии декораций(самые дальние)
	func(getViewDistance)
	{
		objParams();
		call noe_getChunkSizeDecor;//свойство инкапсулировано для безопасности и избежания лишнего инклуда
	};

	//внутренний метод обработки крови
	func(handle_blood)
	{
		#ifdef SP_MODE
			sp_checkWSim("blood");
		#endif

		_ms = getSelf(reagents);
		_bloodLoss = getSelf(bloodLossValue);
		if (_bloodLoss > 0) then {
			_curblood = callFuncParams(_ms,getReagentVolume, "Blood");
			if (_curblood < BLOOD_LOWPRESSURE_LEVEL_OZ) then {
				if (!getSelf(isDead)) then {
					callSelfParams(Die,di_BloodLoss);
				};
				_newFact = linearConversion[BLOOD_LOWPRESSURE_LEVEL_OZ,0,_curblood,BLOOD_LOWPRESSURE_FACTOR,0];
				MOD(_bloodLoss, * _newFact);
			};

			//добавляем кровь в раунд (статистика)
			modVar(gm_currentMode,bloodLoss, + _bloodLoss);

			if (_bloodLoss >= BLOODPOOL_VOLUME_NEED_TO_CREATE) then {
				if (tickTime >= getSelf(bloodPoolLastCheck) && {callSelf(isTouchingGround)}) then {
					setSelf(bloodPoolLastCheck,tickTime + BLOODPOOL_DELAY_TO_NEXT_CHECK);
					_refBloodPool = nullPtr;
					_pos = callSelf(getPos) vectorAdd [0,0,0.01];
					{
						if isTypeOf(_x,BloodPoolSmall) then {
							if (_pos distance (getPosATL getVar(_x,loc)) <= BLOODPOOL_DISTANCE_TO_CAN_CREATE) then {
								_refBloodPool = callFunc(_x,increasePool);
								break;
							};
						};
					} foreach callSelfParams(getNearItems,BLOODPOOL_DISTANCE_TO_CAN_CREATE * 2);

					if isNullObject(_refBloodPool) then {
						_refBloodPool = ["BloodPoolSmall",_pos,null,false] call createItemInWorld;
					};

					callFuncParams(_ms,transferReagent,_refBloodPool arg "Blood" arg REAGENT_ML2OZ(_bloodLoss));
				} else {
					//не пришло время создать лужу
					callFuncParams(_ms,removeReagent,"Blood" arg REAGENT_ML2OZ(_bloodLoss));
				};
			} else {
				//мало вытекает
				callFuncParams(_ms,removeReagent,"Blood" arg REAGENT_ML2OZ(_bloodLoss));
			};

		};

		//inblood assimilation
		#define checktime_nextcall randInt(3,4)
		if (tickTime >= getSelf(internalReagentTimer)) then {
			setSelf(internalReagentTimer,tickTime + checktime_nextcall);
			_matterObj = null;
			__amount__ = 0;
			{
				if (_x != "Blood") then {
					_matterObj = getMatter(_x);
					__amount__ = callFunc(_ms,getReagents) get _x;
					callFuncParams(_ms,removeReagent,_x arg _matterObj get "metabolism");
					if (__amount__ >= (_matterObj get "overdose")) then {
						call (_matterObj get "onOverdosed");
					};
					call (_matterObj get "onAssimBlood");
				};
			} count (keys callFunc(_ms,getReagents));
		};
	};
	var(internalReagentTimer,0);

	func(healBodyPart)
	{
		objParams();
	};
	
	func(getBodyPartStatusArray)
	{
		objParams();
		private _bpArray = getSelf(bodyParts);
		#define hasBP(idx) !isNullObject(_bpArray getOrDefault [idx arg nullPtr])
		private _list = [hasBP(BP_INDEX_ARM_R),hasBP(BP_INDEX_ARM_L),hasBP(BP_INDEX_LEG_R),hasBP(BP_INDEX_LEG_L)];
		//check can stand
		if (!(_list select 2) && !(_list select 3)) then {
			private _it1 = callSelfParams(getItemInSlot,INV_HAND_L);
			private _it2 = callSelfParams(getItemInSlot,INV_HAND_R);
			if (isNullReference(_it1) || isNullReference(_it2)) exitWith {};
			if (isTypeOf(_it1,Crutch) && isTypeOf(_it2,Crutch)) then {
				_list pushBack true;
			};
		};
		_list
	};

	func(handle_organs)
	{
		_usr = this;
		if getVar(_usr,isDead) exitWith {};
		private _modHT = 5;
		private _canThrowHT = false;
		private _canFindKidney = false; //с одной почкой то проживем
		{
			if isNullReference(_y) then {
				if (!_canFindKidney && _x in [BO_INDEX_KIDNEY_L,BO_INDEX_KIDNEY_R]) exitWith {
					_canFindKidney = true;
					continue;
				};
				modvar(_modHT) - 1;
				_canThrowHT = true;
				continue;
			};
			callFunc(_y,onUpdate);
		} foreach getVar(callSelfParams(getPart,BP_INDEX_TORSO),organs);

		callFunc(callSelf(getBrain),onUpdate);
		
		//без легких не подышится... Логика выветривания воздуха внутри
		if !callSelfParams(hasBodyOrgan,BO_INDEX_LUNGS) then {
			callSelfParams(adjustOxyLoss,-randInt(5,10));
		};
		
		if (_canThrowHT) then {
			if DICE_ISFAIL(getRollType(callFuncParams(_usr,checkSkill,"HT" arg _modHT))) then {
				callFuncParams(_usr,addHP, - 1);
			};
		};
	};

	func(handle_healing)
	{
		_usr = this;
		if callSelf(isSleep) then {
			if ((getSelf(internalTimer)%10)==0) then {
				if prob(50) then {
					callSelfParams(playAction,"emt_snore");
				};
			};

			{
				callFunc(_y,onUpdate);
			} foreach getSelf(bodyParts);

			if getSelf(sleepIsChangeState) then {
				callSelf(__onSleepRest);
			};
		};

	};

	//даже мертвый моб будет гнить
	func(handle_infections)
	{
		_usr = this;
		{
			callFunc(_y,handleInfections);
		} foreach getSelf(bodyParts);
	};

	getter_func(getSmellRange,5);
	var(__smellLastCheck,0);
	func(handle_smell)
	{
		
		if (tickTime > getSelf(__smellLastCheck)) then {
			setSelf(__smellLastCheck,tickTime + randInt(5,15));
			// #ifdef EDITOR
			// setSelf(__smellLastCheck,tickTime + 2);
			// #endif
			private _canRottenMessage = false;
			private _rottenType = "rotten";
			{
				if !isNullReference(_x) then {
					if (getVar(_x,isRotten) || getVar(_x,infectionLevel) >= INFECTION_LEVEL_TOSMELL) then {
						_canRottenMessage = true;
						if getVar(_x,isRotten) then {_rottenType = "sickening"};
						break;
					};
				};
			} foreach (values getSelf(bodyparts));
			if (_canRottenMessage) exitwith {
				callSelfParams(doSmell,_rottenType);
			};

			if callSelfParams(hasStatusEffect,"SEAlcoholHangover") then {
				//work only if alcohol hangover size > 10
				if (getVar(callSelfParams(getStatusEffect,"SEAlcoholHangover"),size) > 10) then {
					callSelfParams(doSmell,"stink");
				};
			};
		};
		
	};

	func(canRottenSmell)
	{
		private _canRottenMessage = false;
		{
			if !isNullReference(_x) then {
				if (getVar(_x,isRotten) || getVar(_x,infectionLevel) >= INFECTION_LEVEL_TOSMELL) then {
					_canRottenMessage = true;
				};
			};
		} foreach (values getSelf(bodyparts));
		_canRottenMessage
	};

	func(getMaxInfectionPart)
	{
		objParams();
		private _maxPart = nullPtr;
		{
			if isNullReference(_x) then {continue};
			if (isNullReference(_maxPart) || {getVar(_x,infectionLevel) > getVar(_maxPart,infectionLevel)}) then {
				_maxPart = _x;
			};
		} foreach (values getSelf(bodyparts));
		_maxPart
	};

	func(handle_stamina)
	{
		// =========== stamina regen =========
		#define AMOUNT_REGEN_STAMINA 3.3
		#define AMOUNT_LESS_STAMINA 0.5

		//moving mob
		if (callSelf(getSpeedMode) > SPEED_MODE_STOP) then {
			_staLoss = AMOUNT_LESS_STAMINA * (getSelf(curEncumbranceLevel) + 1);
			modvar(_staLoss) * ([1,1,3,10] select callSelf(getSpeedMode));
			callSelfParams(addStaminaLoss,_staLoss);

			//handle bones blocking
			callSelf(handle_brokenLegs);

			callSelf(handle_attachedParts);
		} else {
			if (getSelf(stamina) < getSelf(staminaMax)) then {
				callSelfParams(addStaminaRegen,AMOUNT_REGEN_STAMINA);
			};
		};
	};

	func(adjustOxyLoss)
	{
		objParams_1(_amount);

		private _breathOrg = callSelfParams(getBodyOrgan,BO_INDEX_LUNGS);
		if !isNullObject(_breathOrg) then {
			private _curval = getSelf(oxygen);
			setSelf(oxygen,(_curval + _amount) max 0 min 100);
			callSelfParams(fastSendInfo,"hud_oxy" arg getSelf(oxygen));
		} else {
			callSelfParams(fastSendInfo,"hud_oxy" arg 0);
		};
	};

	var(isHoldedBreath,false);
	func(setHoldBreath)
	{
		objParams_1(_mode);
		if equals(_mode,getSelf(isHoldedBreath)) exitWith {};
		if (_mode && (callSelf(isSleep) || callSelf(isUnconscious))) exitWith {};

		setSelf(isHoldedBreath,_mode);
		callSelfParams(fastSendInfo,"hud_holdbreath" arg ifcheck(getSelf(isHoldedBreath),1,0));
		if (_mode) then {
			callSelfParams(mindSay,"Ты задерживаешь дыхание");
		};
	};

	func(canBreath)
	{
		objParams();
		if getSelf(isHoldedBreath) exitWith {false};
		private _breathOrg = callSelfParams(getBodyOrgan,BO_INDEX_LUNGS);
		if (isNullReference(_breathOrg) || {callFunc(_breathOrg,isStatusDestroyed)}) exitwith {false};
		true
	};

	func(adjustToxin)
	{
		objParams_1(_amount);
		private _curval = getSelf(toxin);
		setSelf(toxin,(_curval + _amount) max 0);
		callSelfParams(fastSendInfo,"hud_tox" arg (_curval + _amount) max 0);
	};

	var(__tab_nextcheck,0);
	func(handle_toxin)
	{
		if getSelf(isDead) exitWith {};
		
		if (tickTime > getSelf(__tab_nextcheck)) then {
			setSelf(__tab_nextcheck,tickTime + randInt(1,3));
			_curTox = getSelf(toxin);
			_v = 3;
			
			
			
			if (_curTox > 50) then {
				_mod = 2;
				_v = 4;
				if (_curTox > 100) then {_mod = 0; _v = 8};
				if (_curTox > 150) then {_mod = -2; _v = 10};
				_r = callSelfParams(checkSkill,"HT" arg _mod);
				if DICE_ISFAIL(getRollType(_r)) then {
					callSelfParams(addHP, - 1);
				};
			};
			
			if (_curTox > 0) then {
				//отравление: рвота и головная боль
				modSelf(vomitAmount,+_v);
			};
		};
	};

	//добавить _amount единиц голода
	"
		name:Изменить голод
		desc:Добавляет и отнимает указанное количество единиц голода из текущих. Положительное число для насыщения, а отрицательное для голодания.
		type:method
		lockoverride:1
		in:float:Голод:Положительное число насыщает, отрицательное - добавляет голод
	" node_met
	func(adjustHunger)
	{
		objParams_1(_amount);

		private _curhung = getSelf(hunger);

		if (_curhung <= 0 && _amount < 0) exitWith {
			if (!callSelf(isUnconscious)) then {
				if (prob(60) && tickTime % 40 < 1) then {
					callSelfParams(setUnconscious,HUNGER_UNC_TIME);
					
					//on hunger unconsious check health and slow killing human
					private _rr = getRollType(callSelfParams(checkSkill,"ht" arg -1));//лайт штраф для голодного обморока
					if DICE_ISFAIL(_rr) then {
						private _m = pick["Сил нет...","Голова кружится...","Больше не могу..."];
						callSelfParams(mindSay,setstyle(_m,style_redbig));
					};
					if (_rr == DICE_FAIL) exitWith {
						callSelfParams(addHP, - 1);
					};
					if (_rr == DICE_CRITFAIL) exitWith {
						callSelfParams(addHP, - 2);
					};
				};
			};
		};

		_curhung = (_curhung + _amount) max 0;

		if (_curhung > 100) then {
			//do vomit
		};

		setSelf(hunger,_curhung);
		callSelfParams(fastSendInfo,"hud_hunger" arg _curhung);
	};

	"
		name:Установить голод
		desc:Перезаписывает и устанавливает новое значение голода.
		type:method
		lockoverride:1
		in:float:Голод:Новое значение голода
	" node_met
	func(setHunger)
	{
		objParams_1(_newval);
		setSelf(hunger,_newval);
		callSelfParams(fastSendInfo,"hud_hunger" arg _newval);
	};

	//добавить _amount единиц жажды
	func(adjustThirst)
	{
		objParams_1(_amount);

		private _curhung = getSelf(thirst);

		if (_curhung <= 0 && _amount < 0) exitWith {
			if (!callSelf(isUnconscious)) then {
				if (prob(60) && tickTime % 10 < 1) then {
					callSelfParams(setUnconscious,THIRST_UNC_TIME);
				};
			};
		};
		_curhung = (_curhung + _amount) max 0;

		if (_curhung > 100) then {
			//do vomit
		};

		setSelf(thirst,_curhung);
		callSelfParams(fastSendInfo,"hud_thirst" arg _curhung);
	};
	func(setThirst)
	{
		objParams_1(_newval);
		setSelf(thirst,_newval);
		callSelfParams(fastSendInfo,"hud_thirst" arg _newval);
	};

	var(__hungernextmes,tickTime);
	var(__thirstnextmes,tickTime);

	func(handle_food)
	{
		#ifdef SP_MODE
			sp_checkWSim("hunger");
		#endif

		// только за реген стамины
		callSelfParams(adjustHunger, - HUNGER_PER_TICK_LESS);
		//callSelfParams(adjustThirst, - THIRST_PER_TICK_LESS);

		if (!callSelf(isActive)) exitWith {};

		_curhung = getSelf(hunger);
		if (_curhung < 40) then {
			_lastMessage = getSelf(__hungernextmes);

			if (_curhung >= 30 && _curhung < 40) exitWith {
				if (tickTime > _lastMessage) then {
					private _mes = pick["Поесть бы чего-нибудь...","Пора перекусить."];
					callSelfParams(localSay,_mes arg "mind");
					setSelf(__hungernextmes,tickTime + rand(60*2,60*5));
					callSelfParams(playSound,"mob\hungry" + str randInt(1,4) arg getRandomPitch);
				};
			};
			if (_curhung >= 15 && _curhung < 30) exitWith {
				if (tickTime > _lastMessage) then {
					private _mes = pick["Я хочу есть!","Надо пожевать чего-то.","Мне надо подкрепиться.","Я голодаю."];
					callSelfParams(localSay,_mes arg "mind");
					setSelf(__hungernextmes,tickTime + rand(60*2,60*3.5));
					callSelfParams(playSound,"mob\hungry" + str randInt(1,4) arg getRandomPitch);
				};
			};
			if (_curhung < 15) exitWith {
				if (tickTime > _lastMessage) then {
					private _mes = pick["ЖРАТЬ ХОЧУ!","ДАЙТЕ ЕДЫ!!!!","БУРЧАК УРЧИТ УЖЕ ОТ ГОЛОДА!","ЖРАТЬ!","ЕДЫ... ЛЮБОЕ СЪЕМ."];
					callSelfParams(localSay,_mes arg "mind");
					setSelf(__hungernextmes,tickTime + rand(60,60*1.5));
					callSelfParams(playSound,"mob\hungry" + str randInt(1,4) arg getRandomPitch);
				};
			};
		};

		_curthirst = getSelf(thirst);
		if (_curthirst < 30) then {
			_lastMessage = getSelf(__thirstnextmes);

			if (_curthirst >= 20 && _curthirst < 30) exitWith {
				if (tickTime > _lastMessage) then {
					private _mes = pick["В горле пересохло.","Сейчас бы попить чего-нибудь..."];
					callSelfParams(localSay,_mes arg "mind");
					setSelf(__thirstnextmes,tickTime + rand(60*2,60*5));
				};
			};
			if (_curthirst >= 10 && _curthirst < 20) exitWith {
				if (tickTime > _lastMessage) then {
					private _mes = pick["Водички хочется.","Выпить бы сейчас чего-то, да чтоб в нос шибало.","Попить хочу.","Можно воды?"];
					callSelfParams(localSay,_mes arg "mind");
					setSelf(__thirstnextmes,tickTime + rand(60*2,60*3.5));
				};
			};
			if (_curthirst < 10) exitWith {
				if (tickTime > _lastMessage) then {
					private _mes = pick["ВОДЫЫЫЫ!!!","НАДО...ПИТЬ...","Я УЖЕ НЕ МОГУ БЕЗ ВОДЫ! ХОЧУ ПИТЬ!","Я ХОЧУ ПИТЬ!","ДАЙТЕ МНЕ ПИТЬ!","Я ТАК СДОХНУ БЕЗ ВОДЫ!"];
					callSelfParams(localSay,_mes arg "mind");
					setSelf(__thirstnextmes,tickTime + rand(60,60*1.5));
				};
			};
		};
	};

	func(Weaken)
	{
		objParams_1(_amount);
		/*
		if(status_flags & CANWEAKEN)
			if(zoomed)//Zoom out here.
				do_zoom()
			facing_dir = null
			weakened = max(max(weakened,amount),0)
			update_canmove()	//updates lying, canmove and icons
			resting = 1
			fixeye?.icon_state = "fixeye"
			if(/turf/simulated/open in src.loc)
				var/turf/below = GetBelow(src.loc)
				src.handle_fall(below)
			return
		*/
	};

	#define UNC_TO_STAMINALOSS_MIN 3
	#define UNC_TO_STAMINALOSS_MAX 10


	func(addStaminaLoss)
	{
		objParams_1(_value);
		private _newstamina = (getSelf(stamina) - _value) max 0;
		setSelf(stamina,_newstamina);
		callSelfParams(fastSendInfo,"cd_stamina_cur" arg _newstamina);

		if (_newstamina <= 30) then {
			if (prob(35)) then {
				private _mes = ["Сил моих нет...","Мне надо передохнуть.","Я с ног валюсь..."];
				callSelfParams(localSay,pick(_mes) arg "info");
			};
		};

		if (_newstamina <= 3) then {
			callSelfParams(setUnconscious,randInt(UNC_TO_STAMINALOSS_MIN,UNC_TO_STAMINALOSS_MAX));
		};

	};

	func(addStaminaRegen)
	{
		objParams_1(_value);
		private _newstamina = (getSelf(stamina) + _value) min getSelf(staminaMax);
		setSelf(stamina,_newstamina);
		callSelfParams(fastSendInfo,"cd_stamina_cur" arg _newstamina);

		#ifdef SP_MODE
			sp_checkWSim("hunger");
		#endif
		
		//за реген стамины тратим голод и жажду
		callSelfParams(adjustHunger, - HUNGER_STAMINA_LESS * ((getSelf(curEncumbranceLevel) + 1)));
		callSelfParams(adjustThirst, - THIRST_PER_TICK_LESS);
	};

region(Log macros)
	#define __dmgAndHp _dmg arg _hp
	#define log_performance

	#define lifelog(mes,fmt) (["[LOG::LIFE]",(mes),fmt,"#1011"] call stdoutPrint)

	"
		name:Нанести повреждение
		desc:Наносит урон персонажу по выбранной зоне.
		type:method
		lockoverride:1
		in:int:Урон:Количество урона. Должно быть больше 0 для ощутимого эффекта. Обратите внимание, что фактический урон возможно будет меньше от защищающей брони на персонаже.
		in:enum.DamageType:Тип повреждения:Природа повреждения. Отвечает за модификатор повреждения, последствия повреждения и т.д.
		in:enum.TargetZone:Зона:Место, в которое пришёлся урон.
		in:enum.DirectionSide:Направление:С какой стороны нанесено повреждение.
	" node_met
	func(applyDamage)
	{
		// количество урона, тип повреждений, хитзона, причина урона
		objParams_6(_amount,_type,_hitZone,_dir,_cause,_vec2WeaponInfo);

		#ifdef SP_MODE
			sp_checkWSim("damage");
		#endif

		//Обновляем информацию о последнем повреждении
		if isNullVar(_cause) then {
			_cause = di_partDamage;
		};
		if equalTypes(_cause,[]) then {
			callFuncParamsInline(getSelf(damageInfo),updateDamageInfo,_cause);
		} else {
			callFuncParams(getSelf(damageInfo),updateDamageInfo,_cause);
		};

		if isNullVar(_dir) then {_dir = DIR_FRONT};

		callSelfParams(stopProgress,true);
		callSelf(closeOpenedNetDisplay);
		callSelf(releaseBuildingPreview);
		callSelfParams(setStealth,false);

		private _basicDamage = _amount;
		lifelog("INPUT DAMAGE IS %1",_amount);

		//распаковка рефы из верхнего уровня
		outRef(_postMessageEffect,"");

		//распаковка если был крит
		outRef(_rules_critAttack,0);

		private _hp = callSelf(getBaseHP);

		private _bodyPart = [_hitZone] call gurps_convertTargetZoneToBodyPart;

		if !callSelfParams(hasPart,_bodyPart) exitWith {
			warningformat("Mob::applyDamage() - Cant apply damage. Body part (%2) does not exists at %1",getSelf(pointer) arg _bodyPart);
		};

		//pass on DR
		_amount = callSelfParams(onDrProtectProcess,_hitZone arg _amount arg _type);

		if (_amount <= 0) then {
			rp_log("No damage pass on DR. Dmg %1; Part %2",_amount arg _bodyPart);
			MOD(_postMessageEffect, + " Урон был незначителен");
			if isRuleCritAttackInRange(
					RULE_CA_HEAD_SP2_MAJW arg
					RULE_CA_HEAD_DEAF arg
					RULE_CA_MAJW arg
					RULE_CA_DSHOCK arg
					RULE_CA_HEAD_DDAM arg
					RULE_CA_HEAD_TDAM
			) then {
				resetRuleCritAttack;
				trace("Dropdown crit rule - damage is zero");
			};
		} else {

			#ifdef log_performance
				private _t = tickTime;
			#endif

			//apply damage type
			private _dmg = [_amount,_type] call gurps_applyDamageType;
			private _woundType = [_type] call gurps_convertDamageToWound;

			#define std_check_dam(low,up) if (_dmg >= (low) && _dmg < (up)) exitWith

			private _woundSize = call {
				//if (true) exitWith {WOUND_SIZE_SCRATCH};
				if (_dmg > (_hp / 16) && _dmg < (_hp / 8)) exitWith {
					lifelog("Добавлена царапина. Дамаг %1; хп %2",__dmgAndHp);
					WOUND_SIZE_SCRATCH
				};

				std_check_dam(_hp/8,_hp/4) {
					lifelog("Добавлена легкая(минор) рана. Дамаг %1; хп %2",__dmgAndHp);
					WOUND_SIZE_MINOR
				};
				std_check_dam(_hp/4,_hp/2) {
					lifelog("Добавлена средняя рана. Дамаг %1; хп %2",__dmgAndHp);
					WOUND_SIZE_MODERATE
				};
				std_check_dam(_hp/2,_hp) {
					lifelog("Добавлена серьёзная(мажор) рана. Дамаг %1; хп %2",__dmgAndHp);
					WOUND_SIZE_MAJOR
				};
				std_check_dam(_hp,_hp * 2) {
					lifelog("Добавлена критическая рана. Дамаг %1; хп %2",__dmgAndHp);
					WOUND_SIZE_CRITICAL
				};
				std_check_dam(_hp * 2,_hp * 4) {
					lifelog("Добавлена МАССИВНАЯ рана. Дамаг %1; хп %2",__dmgAndHp);
					WOUND_SIZE_MASSIVE
				};
				std_check_dam(_hp * 4,_hp * 8) {
					lifelog("Добавлена ОТВРАТИТЕЛЬНАЯ рана. Дамаг %1; хп %2",__dmgAndHp);
					WOUND_SIZE_GAWDAWFUL
				};
				if (_dmg >= _hp * 8) exitWith {
					lifelog("Добавлена !!!РАЗРУШИТЕЛЬНАЯ!!! рана. Дамаг %1; хп %2",__dmgAndHp);
					WOUND_SIZE_DESTRUCTION
				};
				errorformat("cant find wound size: hp is %2, damage is %1. Return default WOUND_SIZE.SCRATCH",_dmg arg _hp);
				WOUND_SIZE_SCRATCH
			};

			if isRuleCritAttackInRange(RULE_CA_HEAD_SP2_MAJW arg RULE_CA_MAJW) then {
				resetRuleCritAttack;
				_woundSize = WOUND_SIZE_MAJOR;
			};
			if isRuleCritAttack(RULE_CA_HEAD_DEAF) then {
				resetRuleCritAttack;
				MOD(_postMessageEffect, + " Оглушительный удар!");
				if (_type == DAMAGE_TYPE_CRUSHING) then {
					//per bonus
					callSelfParams(addDeaf,10); //оглох на 10 сек
				};
			};

			private _woundArrCurPart = getVar(callSelfParams(getPart,_bodyPart),partDamage) get _woundType;

			private _curWoundsVal = _woundArrCurPart getOrDefault [_woundSize,0];
			if (_curWoundsVal == 5) then {
				_woundArrCurPart set [_woundSize,_curWoundsVal+1];
				lifelog("Накоплено 6 ран уровня %1. Array: %2 Переход на следующий",_woundSize arg _woundArrCurPart);

				/*private _curControlSize = _woundSize;
				private _isFirstPass = true;
				private _maxCountWounds = 5;
				#ifdef log_performance
					private _log_countpasses = 0;
				#endif

				while {({_x == _curControlSize} count _woundArrCurPart) == _maxCountWounds} do {

					#ifdef log_performance
					    INC(_log_countpasses);
					#endif

					lifelog("Контроллер повышения уровня ран запустил итерацию для уровня %1",_curControlSize);

					//remove 5 elements equals _woundSize
					private _cntRemWounds = 0;
					{
						lifelog('========================================================',0);
						lifelog("iter %1. Now array is %2",_forEachindex arg _woundArrCurPart);
						lifelog("equal assert = %1; removed %2",_x == _curControlSize arg _cntRemWounds);
						if (_x == _curControlSize && _cntRemWounds < _maxCountWounds) then {
							lifelog("arr cur %1; index to rem %2",_woundArrCurPart arg _woundArrCurPart find _curControlSize);
							_woundArrCurPart deleteAt (_woundArrCurPart find _curControlSize);
							INC(_cntRemWounds);
						};
					} foreach +_woundArrCurPart; //copy of array

					INC(_curControlSize);

					_woundArrCurPart pushback _curControlSize;

					//Для следующего уровня провека будет по 6 ранам вместо 5
					if (_isFirstPass) then { _isFirstPass = false; INC(_maxCountWounds)};

					lifelog("=============END PASS=============",0);
					lifelog("woundarr now is %1; canNextPass - %2, Amounter: %3",_woundArrCurPart arg ({_x == _woundSize} count _woundArrCurPart) == _maxCountWounds arg _maxCountWounds);
				};*/

				//full recalc alg
				private _amountWounds = 0;
				private _toNextLevel = 0;
				for "_curLvlWound" from WOUND_SIZE_SCRATCH to WOUND_SIZE_DESTRUCTION do {
					_amountWounds = _woundArrCurPart getOrDefault [_curLvlWound,0];
					if (_toNextLevel > 0) then {_amountWounds = _amountWounds + _toNextLevel; _toNextLevel = 0;};
					if (_amountWounds >= 6) then {
						//Если накоплено 6 ран этого уровня то уровень раны увеличивавется
						if (_curLvlWound == _woundSize) then {
							INC(_woundSize);
							lifelog("Накоплено 6 ран уровня %1. Прошедшая рана теперь имеет уровень %2",_curLvlWound arg _woundSize);
						};
						_toNextLevel = floor (_amountWounds/6);
						_amountWounds = _amountWounds%6;
						if (_amountWounds > 0) then {
							_woundArrCurPart set [_curLvlWound,_amountWounds];
						} else {
							_woundArrCurPart deleteAt _curLvlWound;
						};
					} else {
						if (_amountWounds > 0) then {
							_woundArrCurPart set [_curLvlWound,_amountWounds];
						};
					};

				};

				if (_toNextLevel > 0) then {
					errorformat("Mob::applyDamage() - Generic error on recalculate wounds. Next level is not empty:%1 <%2>",_toNextLevel arg _woundArrCurPart);
				};

				#ifdef log_performance
					_t = tickTime - _t;
					warningformat("performance for recalculate wounds: %1 sec; number of passes %2",_t arg _log_countpasses);
				#endif

				//Обязательно предварительно применяем визуал эффект
				//Потому что внутри onWoundProcess может быть отрыв конечности
				callSelfParams(applyDamageVisualEffects,_woundType arg _woundSize arg _hitZone);

				// В случае перерасчёта мы обрабатываем рану от перерасчёта.
				// Если НАДО обработать исходную рану - закоменть правило выше "Если накоплено 6 ран этого уровня то уровень раны увеличивавется"
				[this,_woundType arg _type arg _woundSize arg _bodyPart arg _hitZone] call woundSystem_onWoundProcess
			} else {

				_woundArrCurPart set [_woundSize,_curWoundsVal+1];

				callSelfParams(applyDamageVisualEffects,_woundType arg _woundSize arg _hitZone);

				[this,_woundType arg _type arg _woundSize arg _bodyPart arg _hitZone] call woundSystem_onWoundProcess;
			};

			//Когда по части последний раз нанесли урон
			setVar(callSelfParams(getPart,_bodyPart),lastDamageTime,tickTime);
			setSelf(lastDamageTime,tickTime);

			//do recalc wounds
			callSelf(recalcBloodLoss);

			//handler post attack
			if !isNullVar(_vec2WeaponInfo) then {
				_vec2WeaponInfo params ["_attItem","_attWeap"];
				callSelfParams(onPostDamage,_bodyPart arg _type arg _woundSize arg _attItem arg _attWeap);
			};

		};//<check passed damage on DR>

		if isRuleCritAttackInRange(RULE_CA_HEAD_DROPWEAP arg RULE_CA_DROPALL) then {
			resetRuleCritAttack;
			//TODO при атаке в голову роняется только одно оружие (см RULE_CA_HEAD_DROPWEAP)
			callSelf(dropAllItemsInHands);
		};

		traceformat("onApplyDamage->_postMessageEffect was %1",_postMessageEffect);

	};

	//Пропускает входящий урон через защиту
	func(onDrProtectProcess)
	{
		objParams_3(_hitZone,_damage,_type);

		callSelfParams(getProtectedArmors,_hitZone) params ["_dr","_armorList"];

		//слишком дизбалансно...
		/*if (_hitZone in TARGET_ZONE_LIST_HEAD) then {
			MOD(_dr,+2);//череп даёт доп. защиту +2
		};*/

		if isRuleCritAttackInRange(RULE_CA_HEAD_SP2_MAJW arg RULE_CA_HEAD_SP2) then {
			_dr = floor(_dr / 2);
			if isRuleCritAttack(RULE_CA_HEAD_SP2) then {
				resetRuleCritAttack;
			};
		};
		//TODO armor protect sound play \code\modules\mob\living\armor_new.dm

		//rule for shotguns
		if !isNullVar(_exShotDRMod) then {
			lifelog("shotgun damage: %1, new dr %2",_dr * _exShotDRMod arg _exShotDRMod);
			_dr = _dr * _exShotDRMod;
		};

		private _factDmg = (_damage - _dr);

		//TODO порча брони

		if (_factDmg <= 0) then {
			if (_dr > 0 && not_equals(_armorList,[])) then {
				MOD(_postMessageEffect,+ " Урон был поглощён бронёй.");
			};
		};

		if isRuleCritAttack(RULE_CA_HEAD_MAXDMG_INGNORSP) then {
			resetRuleCritAttack;
			_factDmg = _damage;
		};

		lifelog("Armor dr: %1. Passed damage is: %4 (inputed: %5); DR list for protect zone index %2: %3",_dr arg _hitZone arg _armorList arg _factDmg arg _damage);

		_factDmg max 0
	};

	//Получает брони для защиты, где 0 будет самая опиздюленная
	func(getProtectedArmors)
	{
		objParams_1(_hitZone);
		private _slots = getSelf(slots); //TODO - add function Mob::getAllEquipedArmors()

		private _defZone = [_hitZone] call gurps_convertHitZoneToDefZone;
		private _armorList = [];
		private _drVal = 0;

		{
			if !isNullObject(_y) then {
				if !(_x in INV_LIST_HANDS) then {
					if isTypeOf(_y,Cloth) then {
						//если броня защищает выбранную зону
						if b_check(getVar(_y,bodyPartsCovered),_defZone) then {
							MOD(_drVal,+getVar(_y,dr));
							_armorList pushBack _y;
						};
					};
				};
			};
		} foreach _slots;

		[_drVal,_armorList] //список бронек и общее значение СП для части
	};

	//событие, вызываемое после получения урона
	func(onPostDamage)
	{
		objParams_5(_bodyPart,_damageType,_woundSize,_attItem,_attWeapon);

		callFuncParams(_attItem,onAttackedMob,this arg _bodyPart arg _damageType arg _woundSize);

		if (_damageType in [DAMAGE_TYPE_IMPALING,DAMAGE_TYPE_CUTTING,DAMAGE_TYPE_PIERCING_HU,DAMAGE_TYPE_PIERCING_LA,DAMAGE_TYPE_PIERCING_NO,DAMAGE_TYPE_PIERCING_SM]) then {
			if (getVar(_attItem,germs) >= GERM_COUNT_INFECTION) then {
				_bodyPart = callSelfParams(getPart,_bodyPart);
				callFuncParams(_bodyPart,addInfection,null);
			};
		};
	};

	//отрываем конечность по параметру BP_INDEX_...
	"
		name:Оторвать конечность
		desc:Отрывает конечность персонажа. Если конечности не существует - ничего не произойдёт. Оторванная конечность появится под персонажем.
		type:method
		lockoverride:1
		in:enum.BodyPart:Часть тела:Часть тела, которая будет оторвана.
	" node_met
	func(lossLimb)
	{
		objParams_1(_bpIndex);

		private _item = callSelfParams(getPart,_bpIndex);
		if isNullReference(_item) exitWith {};

		callFuncParams(_item,unlink,getSelf(owner));

		callSelfParams(setDamageArtery,_bpIndex arg true); //break artery
		callSelfParams(addPainLevel,BP_INDEX_TORSO arg PAIN_LEVEL_MAX);

		// shot blood drob big with -100
		callSelfParams(applyDamageVisualEffects,-100 arg WOUND_SIZE_DESTRUCTION arg [_bpIndex] call gurps_convertBodyPartToTargetZone);

		callSelfParams(playSound,"mob\chop" + str randInt(1,3) arg getRandomPitch);

		if (_bpIndex == BP_INDEX_HEAD) then {
			modVar(gm_currentMode,headsLoss, + 1);
		};
	};

	//Событие выбивания зубов (выпадания)
	"
		name:Лишить зубов
		desc:Заставляет выпасть несколько зубов персонажа.
		type:method
		lockoverride:1
		in:int:Количество:Сколько зубов должо выпасть. Значение не может быть меньше 1.
			opt:def=1
	" node_met
	func(lossTeeth)
	{
		objParams_1(_amount);
		if !callSelf(hasTeeth) exitWith {};
		_amount = _amount max 1;
		private _head = callSelfParams(getPart,BP_INDEX_HEAD);
		private _teethCount = getVar(_head,teeth);
		private _lossCount = (_teethCount - _amount) max 0;

		setVar(_head,teeth,_lossCount);

		private _tooth = new(Tooth);
		setVar(_tooth,stackCount,_teethCount - _lossCount);
		callFunc(_tooth,recalculateStackWeight);

		callSelfParams(playSound,"mob\trauma3" arg getRandomPitchInRange(0.5,1.1));
		[_tooth,getSelf(owner)] call noe_loadVisualObject_OnDrop;

		//статистика по зубам
		modVar(gm_currentMode,teethLoss, + _amount);
	};

	"
		name:Наличие зубов
		desc:Проверяет, есть ли хотя бы один зуб у персонажа. Если есть зубы - возвращает @[bool ИСТИНУ], в остальных случаях - @[bool ЛОЖЬ].
		type:get
		lockoverride:1
		return:bool:Есть ли зубы
	" node_met
	func(hasTeeth)
	{
		objParams();
		if !callSelfParams(hasPart,BP_INDEX_HEAD) exitWith {false};
		private _teethCount = getVar(callSelfParams(getPart,BP_INDEX_HEAD),teeth);
		if (isNullVar(_teethCount)) exitWith {false};
		if (_teethCount > 0) exitWith {true};
		false
	};

	//Функция вызывается при уничтожении конечности
	"
		name:Уничтожить конечность
		desc:Уничтожает конечность персонажа. Если конечности не существует - ничего не произойдёт.
		type:method
		lockoverride:1
		in:enum.BodyPart:Часть тела:Часть тела, которая будет уничтожена.
	" node_met
	func(destroyLimb)
	{
		objParams_1(_bpIndex);

		private _item = callSelfParams(getPart,_bpIndex);
		if isNullReference(_item) exitWith {};
		
		callFuncParams(_item,unlink,null arg true);
		
		callSelfParams(setDamageArtery,_bpIndex arg true); //break artery
		callSelfParams(addPainLevel,BP_INDEX_TORSO arg PAIN_LEVEL_MAX);
		
		private _sound = if (_bpIndex == BP_INDEX_HEAD) then {
			"mob\head_explodie_0"+str randInt(1,4)
		} else {
			"mob\destroylimb"
		};

		callSelfParams(playSound,_sound arg getRandomPitch);

		// shot blood drob big with -100
		callSelfParams(applyDamageVisualEffects,-100 arg WOUND_SIZE_DESTRUCTION arg [_bpIndex] call gurps_convertBodyPartToTargetZone);

		if (_bpIndex == BP_INDEX_HEAD) then {
			modVar(gm_currentMode,headsLoss, + 1);
		};
	};

	"
		name:Лишить глаза
		desc:Заставляет выпасть глаз персонажа. Если у персонажа не останется глаз - он не сможет видеть.
		type:method
		lockoverride:1
		in:enum.SideIndex:Сторона:Сторона, с которой выпадет глаз.

	" node_met
	func(lossEye)
	{
		objParams_1(_side);
		if !(_side in [-1,1]) exitWith {
			errorformat("Mob::lossEye - Wrong side %1",_side);
		};

		private _head = callSelfParams(getPart,BP_INDEX_HEAD);
		if isNullObject(_head) exitWith {};
		private _idxSide = sideToIndex(_side);

		private _eyesarr = getVar(_head,eyes);
		if !isNullObject(_eyesarr select _idxSide) then {
			callFuncParams(_eyesarr select _idxSide,onOrganUnlinked,this);
			_eyesarr set [_idxSide,nullPtr];
			if (({isNullObject(_x)}count _eyesarr)==2) then {
				callSelfParams(changeVisionBlock,+1 arg "losseyes");
			};
		};
	};

	"
		name:Повреждение артерии
		desc:Повреждает или залечивает артерию на части тела персонажа.
		type:method
		lockoverride:1
		in:enum.BodyPart:Часть тела:Часть тела, которая будет повреждена.
		in:bool:Повредить:При включении данной опции артерия будет повреждена, при отключении - залечиваться.
			opt:def=true
	" node_met
	func(setDamageArtery)
	{
		objParams_2(_bpIndex,_mode);
		_p = _this;
		breakpoint(_p)
		if !callSelfParams(hasPartSocket,_bpIndex) exitWith {breakpoint("NOACT")};
		private _bartarr = getSelf(bodyArtery);
		breakpoint(_p)
		if not_equals(_bartarr getOrDefault vec2(_bpIndex,false),_mode) then {
			_bartarr set [_bpIndex,_mode];
			breakpoint(_p)
			callFunc(this,recalcBloodLoss);
		};
		breakpoint(_p)
	};

	"
		name:Артерия повреждена
		desc:Проверяет, повреждена ли артерия на части тела персонажа.
		type:get
		lockoverride:1
		in:enum.BodyPart:Часть тела:Проверяемая часть тела.
		return:bool:Повреждена ли артерия на проверяемой части тела.
	" node_met
	func(isArteryDamaged)
	{
		objParams_1(_bpIndex);
		if !callSelfParams(hasPartSocket,_bpIndex) exitWith {false};
		private _bartarr = getSelf(bodyArtery);
		_bartarr getOrDefault vec2(_bpIndex,false)
	};

region(Math wounds optimization)

	func(syncDamageVisual)
	{
		objParams();

		private _val = 0;
		private _listSyncHit = [0,0,0,0];
		{
			if isNullObject(_y) then {continue};
			_val = callFunc(_y,getBloodLossValue);

			//хандлим хитпарты
			/*
			* Notes:
				* Head: Blood visuals @ 0.45
				* Body: Blood visuals @ 0.45
				* Arms: Blood visuals @ 0.35, increases weapon sway linerarly
				* Legs: Blood visuals @ 0.35, limping @ 0.5
			*/
			call {
				if (_x == BP_INDEX_HEAD) exitWith {
					if (_val >= BLOOD_GET_BLOODLOSS_BY_WOUND_SIZE(WOUND_SIZE_MODERATE)) then {
						_listSyncHit set [0,0.45];
					};
				};
				if (_x in [BP_INDEX_ARM_R,BP_INDEX_ARM_L]) exitWith {
					if (_val >= BLOOD_GET_BLOODLOSS_BY_WOUND_SIZE(WOUND_SIZE_MODERATE)) then {
						_listSyncHit set [2,0.35];
					};
				};
				if (_x in [BP_INDEX_LEG_R,BP_INDEX_LEG_L]) exitWith {
					if callFunc(_y,isBoneBroken) then {
						_listSyncHit set [3,0.5];
					};
					if (_val >= BLOOD_GET_BLOODLOSS_BY_WOUND_SIZE(WOUND_SIZE_MODERATE)) then {
						_listSyncHit set [3,(_listSyncHit select 3) + 0.35];
					};
				};
				//torso
				if (_val >= BLOOD_GET_BLOODLOSS_BY_WOUND_SIZE(WOUND_SIZE_MODERATE)) then {
					_listSyncHit set [1,0.45];
				};
			};

		} foreach getSelf(bodyParts);

		[getSelf(owner),"syncHitpoints",[getSelf(owner),_listSyncHit]] call repl_doLocal;
	};

	//Перерасчитывает сколько крови будет тратиться каждую секунду
	func(recalcBloodLoss)
	{
		objParams();

		private _loss = 0;
		private _arterys = getSelf(bodyArtery);

		{
			//сначала артерии потому что в слоте части тела её просто может не быть
			//artery damaged
			if (_arterys get _x) then {
				if (_x == BP_INDEX_HEAD) exitWith {MOD(_loss,+ BLOOD_LOSS_ARTERY_HEAD)};
				if (_x == BP_INDEX_TORSO) exitWith {MOD(_loss,+ BLOOD_LOSS_ARTERY_TORSO)};
				MOD(_loss,+ BLOOD_LOSS_ARTERY_LIMB);
			};

			if isNullObject(_y) then {continue};
			MOD(_loss, + callFunc(_y,getBloodLossValue));

		} foreach getSelf(bodyParts);

		private _internalBleed = 0;
		private _externalBleed = _loss;
		{
			if isNullReference(_y) then {continue};
			modvar(_internalBleed) + callFunc(_y,getBloodLossValue);
		} foreach getVar(callSelfParams(getPart,BP_INDEX_TORSO),organs);

		modvar(_loss) + _internalBleed;

		setSelf(bloodLossValue,_loss);
		callSelfParams(fastSendInfo,"hud_bleeding" arg _externalBleed);

		callSelf(syncDamageVisual);
	};

region(information)
	//Возвращает строковое состояние для юзера
	func(getMedicalExamineInfoFor)
	{
		objParams_1(_usr);

		private _isSelf = equals(this,_usr);
		private _his = if _isSelf then {
			"Моя"
		} else {
			getVar(getSelf(gender),его)
		};
		private _him = if _isSelf then {
			"Меня"
		} else {
			getVar(getSelf(gender),него)
		};
		private _preOutput = "";
		private _output = "";
		private _parts = getSelf(bodyParts);
		private _part = nullPtr;
		private _tz = null;
		private _bpname = null;
		private _his_him_pick = {
			if (_isSelf) then {
				pick["На моей","У меня на"]
			} else {
				pick[("На " + toLower _his),"У " + toLower _him + " на"]
			};
		};
		private _my_pick = {
			if (_isSelf) then {
				"У меня "
			} else {
				"У " + toLower _him + " "
			};
		};
		private _his_him_pick_bandage = {
			if (_isSelf) then {
				pick["На","У меня на"]
			} else {
				pick[("На " + toLower _his),"У " + toLower _him + " на"]
			};
		};

		private _canFeelPain = callSelf(canFeelPain);

		{
			_part = _parts getOrDefault [_x,nullPtr];

			_tz = [_x] call gurps_convertBodyPartToTargetZone;
			_bpname = [_tz,TARGET_ZONE_NAME_TO] call gurps_convertTargetZoneToString;

			if isNullObject(_part) then {

				_output = _output + sbr + "У " + tolower _him + " отсутствует " + (tolower ([_tz] call gurps_convertTargetZoneToString));

			} else {

				//handle head tongue and eyes
				if (_x == BP_INDEX_HEAD) then {
					getVar(_part,eyes) params ["_left","_right"];
					private _nle = isNullObject(_left);
					private _nre = isNullObject(_right);
					if (_nle && _nre) then {
						_preOutput = _preOutput + sbr + "У " + tolower _him + " нет глаз";
					} else {
						if (_nle) then {
							_preOutput = _preOutput + sbr + "У " + tolower _him + " нет левого глаза";
						} else {
							if (_nre) then {
								_preOutput = _preOutput + sbr + "У " + tolower _him + " нет правого глаза";
							};
						};
					};

					if isNullObject(getVar(_part,tongue)) then {
						_preOutput = _preOutput + sbr + "У " + tolower _him + " нет языка";
					};
				};

				// handle bruises
				private _warr = getVar(_part,partDamage);
				private _wounds = _warr get WOUND_TYPE_BRUISE;
				private _countwounds = 0;
				(values _wounds) apply {_countwounds = _countwounds + _x};
				if (_countwounds > 0) then {
					_output = _output + sbr + call _his_him_pick + " " + toLower _bpname + pick([" нанесено "," видно "," виднеется "," есть "]) + ([_countwounds,["синяк","синяка","синяков"],true] call toNumeralString);
				};

				//handle bleedings
				if callFunc(_part,isBandaged) then {
					_output = _output + sbr + call _his_him_pick_bandage + " " + tolower([_tz arg TARGET_ZONE_NAME_WHAT] call gurps_convertTargetZoneToString) + " наложен бинт";
				} else {
					_wounds = _warr get WOUND_TYPE_BLEEDING;
					_countwounds = 0;
					(values _wounds) apply {_countwounds = _countwounds + _x};
					if (_countwounds > 0) then {
						_output = _output + sbr + call _his_him_pick + " " + toLower _bpname + pick([" нанесено "," видно "," виднеется "," есть "]) + ([_countwounds,["кровоточащая рана","кровоточащих раны","кровоточащих ран"],true] call toNumeralString);
					};

					if getVar(_part,isIncised) then {
						_output = _output + sbr +"<t color='#D43F5B'>"+ call _his_him_pick + " " + toLower _bpname + pick([" видно"," виднеется"," есть"]) + " надрез</t>";
					};
				};

				if getVar(_part,isRotten) then {
					_output = _output + sbr +"<t color='#8d04cd' size='1.2'>"+ call _my_pick + toLower ([_tz] call gurps_convertTargetZoneToString) + " полностью сгнил"+ifcheck(_x==BP_INDEX_TORSO,"о","а")+"</t>";
				} else {
					if inRange(getVar(_part,infectionLevel),INFECTION_MIN_LEVEL,INFECTION_MAX_LEVEL) then {
						_tName = ["","","побелел","посинел","почернел"] select getVar(_part,infectionLevel);
						if (_tName != "") then {
							_output = _output + sbr +"<t color='#cfcfb4' size='1.2'>"+ call _my_pick + toLower ([_tz] call gurps_convertTargetZoneToString) +" "+ _tName + ifcheck(_x==BP_INDEX_TORSO,"о","а")+"</t>";
						};
					};
				};

				if (getVar(_part,germs) > 0) then {
					private _germText = GERM_HUMAN_COUNT_TO_NAME(getVar(_part,germs));
					if (_germText != "") then {
						_output = _output + sbr +"<t color='"+GERM_HUMAN_COUNT_TO_COLOR(getVar(_part,germs))+"' size='1.1'>"+ call _my_pick + _germText + " на " + toLower _bpname+"</t>";
					};
				};

				if (_isSelf) then {
					if (_canFeelPain && getVar(_part,pain)>PAIN_LEVEL_NO) then {
						modvar(_output) + sbr + "<t size='0.8' color='#FF4D4D'>У меня " + PAIN_LEVEL_TO_TEXT(getVar(_part,pain)) + " в " + tolower([_tz arg TARGET_ZONE_NAME_TO] call gurps_convertTargetZoneToString)+"</t>";
					};
					_bs = callFunc(_part,getBoneStatusText);
					if (_bs!="") then {
						modvar(_output) + sbr + "<t color='#FF9E4D'>У меня " + _bs + " на " + tolower([_tz arg TARGET_ZONE_NAME_TO] call gurps_convertTargetZoneToString)+"</t>";
					};
				};


			};
		} foreach [BP_INDEX_HEAD,BP_INDEX_TORSO,BP_INDEX_ARM_R,BP_INDEX_ARM_L,BP_INDEX_LEG_R,BP_INDEX_LEG_L];

		"<t size='0.75'>" + _preOutput + _output + "</t>"
	};

	func(hasActiveHand)
	{
		objParams();
		callSelfParams(hasPart,ifcheck(getSelf(activeHand)==INV_HAND_R,BP_INDEX_ARM_R,BP_INDEX_ARM_L));
	};

	func(getActiveHandPart)
	{
		objParams_1(_isLegAction);
		if isNullVar(_isLegAction) then {_isLegAction =false};
		if (_isLegAction) then {
			callSelfParams(getPart,ifcheck(getSelf(activeHand)==INV_HAND_R,BP_INDEX_LEG_R,BP_INDEX_LEG_L));
		} else {
			if !callSelf(hasActiveHand) exitWith {nullPtr};
			callSelfParams(getPart,ifcheck(getSelf(activeHand)==INV_HAND_R,BP_INDEX_ARM_R,BP_INDEX_ARM_L));
		};
	};
	
	func(canUseActivePart)
	{
		objParams_2(_isLeg,_printerror);
		if isNullVar(_isLeg) then {_isLeg = false};
		if isNullVar(_printerror) then {_printerror = true};
		private _actPart = callSelfParams(getActiveHandPart,false);
		if isNullReference(_actPart) exitWith {
			if (_printerror) then {
				callSelfParams(localSay,"Нет части тела"+comma+" которой можно сделать это" arg "error");
			};
			false
		};
		if (!callFunc(_actPart,canUsePart)) exitWith {
			if (_printerror) then {
				callSelfParams(localSay,callFunc(_actPart,getName) + " не может использоваться" arg "error");
			};
			false
		};
		true
	};


region(handle hp damage)

	func(onHPUpdate)
	{
		objParams();
		private _newHP = callSelf(getHP);
		if (_newHP <= 0) exitWith {
			callSelfParams(Die,di_lossHP);
		};
	};

region(Food and drinking)

	//накормить или напоить кого-то
	func(feed)
	{
		objParams_2(_targ,_item);

		private _active = callFunc(_targ,isActive);
		private _time = 0;
		if (_active) then {
			_time = getSelf(rta) * 3;
		};
		if (_time == 0 || equals(_targ,this)) then {
			callFuncParams(_targ,consume,this arg _item);
		} else {
			private _canConsume = callFuncParams(_targ,consume,this arg _item arg true);
			if (!isNullVar(_canConsume) && {equals(_canConsume,"canconsume")}) then {
				private _m = "напоить";
				if callFunc(_item,isFood) then {
					_m = pick ["угостить","побаловать","накормить"];
				};
				modvar(_m) + " ";
				callSelfParams(meSay,"собирается "+_m+callFuncParams(_targ,getNameEx,"вин"));
				callSelfParams(startProgress,_targ arg "target.consume" arg _time arg INTERACT_PROGRESS_TYPE_FULL arg _item);
			};
		};
	};

	//функция употребления. _usr это тот, кто кормит а this - кого кормят (кто потребляет); _isValidateOnly просто проверка возможности данного действия
	func(consume)
	{
		objParams_3(_usr,_foodObj,_isValidateOnly);

		if isNullVar(_usr) then {_usr = this};
		if isNullVar(_isValidateOnly) then {_isValidateOnly = false};

		private _isSelf = equals(_usr,this);
		private _isFood = false; _isDrink = false;
		private _preValidateEvent = {true};
		if callFunc(_foodObj,isFood) then {
			_isFood = true;

			_preValidateEvent = {
				if (!callFunc(_foodObj,canEat)) exitWith {
					callFuncParams(_foodObj,onCantEatReason,_usr);
					false
				};
				true
			};
		};
		if callFunc(_foodObj,isReagentContainer) then {
			_isDrink = true;

			_preValidateEvent = {
				private _filled = callFunc(_foodObj,getFilledSpace);
				if (_filled == 0) exitWith {false};
				if !callFuncParams(_usr,hasBodyOrgan,BO_INDEX_STOMACH) exitWith {false};
				true
			};
		};

		//if getVar(this,isDead) exitWith {};

		if (!callFuncParams(this,isEmptySlot,INV_FACE) && {!callFunc(callFuncParams(this,getItemInSlot,INV_FACE),canAccessToMouth)}) exitWith {
			private _itemName = callFunc(callFuncParams(_usr,getItemInSlot,INV_FACE),getName);
			callFuncParams(_usr,localSay,"Нужно сначала снять " +  _itemName arg "error");
		};

		if (!_isSelf && getVar(this,isCombatModeEnable)) exitWith {
			callFuncParams(_usr,localSay,"Этот человек настороже! Нельзя "+ifcheck(_isDrink,"поить","кормить")+"." arg "error");
		};

		if !callFuncParams(this,hasPart,BP_INDEX_HEAD) exitWith {
			callFuncParams(_usr,localSay,"Нет головы."arg "error");
		};

		if (!call _preValidateEvent) exitWith {};

		if (_isValidateOnly) exitWith {
			"canconsume"
		};

		if (_isFood) exitWith {

			private _isFullEat = false;
			private _itemEating = false; //проглатывание предметов
			private _callRanOut = false;
			private _stomach = callFuncParams(this,getBodyOrgan,BO_INDEX_STOMACH);

			private _biteSize = getConst(_foodObj,getBiteSize);
			if isNullVar(_biteSize) then {
				callFuncParams(_foodObj,transferReagents,_stomach arg callFunc(_foodObj,getFilledSpace));

				//Одноукусные выполняют метод когда не осталось кусков (например создать мусор)
				_callRanOut = true;
				_isFullEat = true;
				_itemEating = true;
			} else {
				callFuncParams(_foodObj,transferReagents,_stomach arg _biteSize);
				if (callFunc(_foodObj,getFilledSpace) == 0) then {_isFullEat = true; _callRanOut = true;};
			};



			private _mes = "";
			if (_isSelf) then {
				if (_isFullEat) then {
					if (_itemEating) exitWith {
						_mes = pick ["глотает","проглатывает"];
					};
					_mes = pick ["дожёвывает","доедает"];

				} else {
					_mes = pick ["хрумкает","смакует","хавает","кушает","ест"];
				};

				_mes = format["%1 %2 %3",callFuncParams(this,getNameEx,"кто"),_mes,callFunc(_foodObj,getName)];
			} else {
				_mes = pick ["кормит","угощает","балует"];
				_mes = format["%1 %2 %3" arg callFuncParams(_usr,getNameEx,"кто") arg _mes arg callFuncParams(this,getNameEx,"вин")];
			};

			callFuncParams(_usr,worldSay,_mes arg "act");
			callFuncParams(_usr,playSound,"mob\eat" + str randInt(1,5) arg getRandomPitch);

			callFuncParams(this,onConsumingFood,true);

			if (_callRanOut) then {
				callFunc(_foodObj,onBitesRanOut);
			};
		};
		if (_isDrink) exitWith {
			private _size = getVar(_foodObj,curTransferSize);
			if (isNullVar(_size) || {_size == 0}) exitWith {};

			/*#ifdef EDITOR
			["УСВОЕНИЕ ЖИДКОСТЕЙ ИДЁТ СРАЗУ В КРОВЬ????"] call chatprint;
			#endif*/
			private _internal = getSelf(reagents);
			private _size = getVar(_foodObj,curTransferSize);
			if (isNullVar(_size) || {_size == 0}) exitWith {};

			if callFuncParams(_foodObj,transferReagents,_internal arg _size) then {
				private _mes = "пьёт";
				if (_isSelf) then {
					if (_size < 10) then {
						_mes = "отхлёбывает из";
					};
					if (callFunc(_foodObj,getFilledSpace) == 0) then {_mes = "допивает"};
					_mes = format["%1 %2 %3",callFuncParams(this,getNameEx,"кто"),_mes,callFunc(_foodObj,getName)];
				} else {
					_mes = pick ["поит"];
					_mes = format["%1 %2 %3" arg callFuncParams(_usr,getNameEx,"кто") arg _mes arg callFuncParams(this,getNameEx,"вин")];
				};

				callFuncParams(this,worldSay,_mes arg "act");
				callFuncParams(this,playSound,"mob\drink" arg getRandomPitch);

				callFuncParams(this,onConsumingFood,false);
			};
		};

	};

	func(onConsumingFood)
	{
		objParams_1(_isFood);

		private _cap = callFunc(_stomach,getCapacity);
		private _filled = callFunc(_stomach,getFilledSpace);

		if (_filled >= _cap) exitWith {
			callSelf(vomit);
		};

		if (_filled >= (80*_cap/100)) then {
			private _mes = "Наелся";
			if (_isFood) then {
				_mes = pick["Я " + (if equals(getSelf(gender),gender_female) then {"наелась"}else{"наелся"}),"Мой животик полон","Больше не хочу есть"];
			} else {
				_mes = pick["Я " + (if equals(getSelf(gender),gender_female) then {"напилась"}else{"напился"}),"Мой животик полон","Больше не хочу пить"];
			};
			callFuncParams(_usr,localSay,_mes + "." arg "mind");
		};
	};

	var(vomitAmount,0);
	func(adjustVomit)
	{
		objParams_1(_val);
		setSelf(vomitAmount,(getSelf(vomitAmount) + _val) max 0);
	};
	func(handle_vomit)
	{
		_cur = getSelf(vomitAmount);
		if (_cur>=70) then {
			if (getRollType(callSelfParams(checkSkill,"HT" arg -2)) in [DICE_FAIL,DICE_CRITFAIL]) then {
				callSelf(vomit);
				modvar(_cur) - 20;
			};
		};
		setSelf(vomitAmount,(_cur - 1) max 0);
	};

	func(vomit)
	{
		objParams();
		if getSelf(isDead) exitWith {};
		private _stunTime = randInt(2,5);
		callSelfParams(stun,_stunTime);

		if !callFuncParams(this,hasBodyOrgan,BO_INDEX_STOMACH) exitWith {
			callSelfParams(playSound,pick callSelf(getRetchSounds) arg getRandomPitch);
			private _mes = ["корчится в рвотных позывах.","корчится.","пытается вытошнить."];
			callSelfParams(meSay,pick _mes);
			callSelfParams(playSound, pick callSelf(getRetchSounds) arg getRandomPitchInRange(0.8,1.4));
		};
		private _stomach = callFuncParams(this,getBodyOrgan,BO_INDEX_STOMACH);

		callFuncParams(_stomach,removeReagents, randInt(30,60));
		private _mes = ["блюёт.","рыгает.","вырвало."];
		if prob(30) then {
			_mes = ["показывает всем свой богатый внутренний мир.","дарит этому миру содержимое своего кишечника.","тошнится и дрыгается."];
		};
		callSelfParams(playEmoteSound,"vomit");
		callSelfParams(meSay,pick _mes);

		private _vomitDuration = precentage(_stunTime,60);
		private _vparams = [getSelf(owner),"SLIGHT_MOB_VOMIT" call lightSys_getConfigIdByName,
			["bubbleseffect","Memory"] //"head"
			,_vomitDuration];
		{
			callFuncParams(_x,sendInfo,"do_fe_mob" arg _vparams);
		} foreach callSelfParams(getNearMobs,20 arg false);

		callSelfParams(setMobFaceAnim,DEAD_MIMIC);
		callSelfAfter(syncMobFaceAnim,_vomitDuration);
		
		callSelfParams(adjustToxin, - randInt(1,5));
	};

	func(vomitBlood)
	{
		objParams();
		if getSelf(isDead) exitWith {};

		private _reagents = getSelf(reagents);
		if callFuncParams(_reagents,hasReagent,"Blood") then {
			callFuncParams(_reagents,removeReagent, "Blood" arg randInt(1,5));
			private _mes = ["блюёт.","рыгает.","вырвало."];
			if prob(30) then {
				_mes = ["показывает всем свой богатый внутренний мир.","тошнится и дрыгается."];
			};
			callSelfParams(playEmoteSound,"vomit");
			callSelfParams(meSay,pick _mes);
			callSelfParams(stun,randInt(2,5));
		};
	};

region(Handle falling)
	var_bool(isOnGround);
	var(fallingStartPos,vec3(0,0,0));
	var(__isfallsound,false); //просто флаг звука падения
	func(handle_falling)
	{
		updateParams();
		_mob = getSelf(owner);
		if (isNullReference(_mob) || (abs speed _mob)==0) exitWith {};

		#ifdef SP_MODE
		if equals(attachedto _mob,player) exitWith {}; //do not fall on attached
		if not_equals(_mob,player) exitwith {
			//errorformat("Unexpected falling error: mob %1",_mob);
		};
		//пакеты на падение отправляются с клиента. не самое лучшее решение, но в данный момент пойдёт...
		if equals(_mob,player) exitWith {};
		#endif

		if (isTouchingGround _mob) then {
			//упал
			if !getSelf(isOnGround) then {
				setSelf(isOnGround,true);
				setSelf(__isfallsound,false);
				_startFallPos = getSelf(fallingStartPos);
				if equals(_startFallPos,vec3(0,0,0)) exitWith {};

				_distFall = getSelf(fallingStartPos) distance (getPosATL _mob);
				//traceformat("falling distance %1",_distFall);
				if (_distFall < 1.2) exitWith {};

				//TODO more logic
				callSelfParams(onFalling,_distFall);
			};
		} else {
			//начал падать
			if getSelf(isOnGround) then {
				setSelf(isOnGround,false);
				setSelf(fallingStartPos,getPosATL _mob);
			} else {
				if callSelf(isActive) then {
					if (getPosATL _mob distance getSelf(fallingStartPos) >= 6) then {
						if !getSelf(__isfallsound) then {
							callSelfParams(playAction,"emt_fallscream");
							setSelf(__isfallsound,true);
						};
					};
				};
			};
		};
	};

	func(onFalling)
	{
		objParams_1(_distFalling);

		//grabbed objects falling
		if callSelf(isGrabAny) then {
			private _obj = nullPtr;
			private _falledMobs = [];
			{
				_obj = getVar(_x,object);
				if (!isNullReference(_obj) && {callFunc(_obj,isMob)}) then {
					if !array_exists(_falledMobs,_obj) then {
						callFuncParams(_obj,onFalling,_distFalling);
						_falledMobs pushBack _obj;
					};
				};
			} foreach getSelf(specHandAct);
		};


		/*
		Если результат меньше 1к, считайте доли до 0,25 как
		1к-3, до 0,5 – как 1к-2, а больше – как 1к-1.
		Иначе можно округлить доли 0,5 и выше до полного кубика.

		Домножение на 2 нужно потому что падаем на твёрдую поверхность (в реликте мягких поверхностей нет)
		*/
		private _speed = [_distFalling] call gurps_getFallingSpeedByDistance;
		private _dices = 2 * callSelf(getBaseHP) * _speed / 100;
		private _dam = if (_dices < 1) then {
			call {
				if (_dices <= 0.25) exitWith {(1 call gurps_throwdices)-3};
				if (_dices <= 0.5) exitWith {(1 call gurps_throwdices)-2};
				(1 call gurps_throwdices)-1
			}
		} else {
			_dices = round _dices;
			_dices call gurps_throwdices;
		};

		private _postMessageEffect = "";

		private _stance = callSelf(getStance);
		private _zone = TARGET_ZONE_TORSO;
		private _checked = [TARGET_ZONE_LEG_L,TARGET_ZONE_LEG_R];
		//Если сущность не лежит то урон прохоит только по ногам
		if (_stance != STANCE_DOWN) then {
			private _listRet = [];
			{
				if (callSelfParams(hasTargetZoneForAttack,_x)) then {_listRet pushBack _x};
				true;
			} count _checked;
			ifcheck(count _listRet == 0,callSelf(pickRandomTargZone),pick _checked);
		} else {
			_zone = callSelf(pickRandomTargZone)
		};

		callFuncParams(this,applyDamage,_dam arg DAMAGE_TYPE_CRUSHING arg _zone arg DIR_RANDOM arg di_falling);

		private _fmt = format["%1 %3.<t size='0.8' shadow = '0'>%2</t>",callSelfParams(getNameEx,"кто"),_postMessageEffect,
		pick["падает","роняется","ударяется об пол"]];
		callSelfParams(worldSay,_fmt arg "combat");
		callSelfParams(playSound,"mob\fallsmash" arg getRandomPitchInRange(0.8,1.3) arg null arg 2.2);
		//callSelfParams(meSay,"упал.");
	};

region(Handle pain)
	var(inAgony,false);
	var(agonyLastTime,0);
	getter_func(hasPain,getSelf(painAmount) > 0);
	//с подавлением боли не будет срабатывать
	getter_func(hasPainWithSuppress,if callSelf(canFeelPain) then {callSelf(hasPain)} else {false});
	getter_func(canRegenPain,callSelf(isSleep));
	func(handle_pain)
	{
		#ifdef SP_MODE
			sp_checkWSim("pain");
		#endif

		_pp = 0;
		_painTimeDec = PAIN_DEFAULT_RESTORE;
		_tPain = tickTime;
		if (getSelf(painAmount) > 0) then {
			_canRegen = callSelf(canRegenPain);

			//сброс подавления боли
			_ps = getSelf(painSupress);
			if (_tPain > _ps && _ps!=0) then {
				setSelf(painSupress,0);
				callSelf(onSyncPain);
			};

			//регенерация боли
			{
				if !isNullReference(_y) then {
					_curLvl = getVar(_y,pain);
					if (_curLvl <= PAIN_LEVEL_NO) exitWith {};
					_pp = getVar(_y,painTime);
					//_havePain = _pp>0;

					//От сна реген боли PAIN_SLEEP_RESTORE
					if (_canRegen /*&& _havePain*/ && (_curLvl < PAIN_LEVEL_MAX)) then {
						modvar(_painTimeDec) + PAIN_SLEEP_RESTORE;
					};

					modvar(_pp) - _painTimeDec;
					setVar(_y,painTime, _pp);

					//если была боль и стало меньше нулика
					//if (_havePain && {_pp <= 0}) then {
					if (_pp <= 0) then {
						callSelfParams(removePainLevel,_x arg 1);
					};
				};
			} foreach getSelf(bodyParts);

			_speed = callSelf(getSpeedMode);
			if getSelf(inAgony) then {
				if (_speed > 0) then {
					modSelf(agonyLastTime, - 1.5 * _speed);
				};
				if (_tPain >= getSelf(agonyLastTime)) then {
					callSelf(doAgony);

				};
			} else {
				if (_speed > 0) then {
					modSelf(painNextMoan, - 0.5 * _speed);
				};
				if (_tPain > getSelf(painNextMoan)) then {
					callSelf(doMoan);
				};
			};
		};

	};

	//стон от боли
	func(doMoan)
	{
		objParams();
		callSelf(updateMoanTime);

		if !callSelf(isActive) exitWith {};
		if !callSelf(canFeelPain) exitWith {};

		callSelfParams(playSound, pick callSelf(getMoanSounds) arg getRandomPitchInRange(0.85,1.2));

		callSelfParams(meSay,"стонет.");
		callSelfParams(Stun,randInt(2,3));
	};

	func(updateMoanTime)
	{
		objParams();
		private _nextcall = round linearConversion [0,20,getSelf(painAmount),120,60];
		setSelf(painNextMoan,tickTime + randInt(_nextcall,_nextcall+10));
	};

	func(doAgony)
	{
		objParams();
		//setSelf(agonyLastTime,tickTime + 10);
		callSelf(updateAgonyTime);

		if !callSelf(canFeelPain) exitWith {};

		private _stunTime = randInt(4,8);
		callSelfParams(stun,_stunTime);
		callSelfParams(fastSendInfo,"pp_agony_data" arg vec2(true,_stunTime));

		if !callSelf(isActive) exitWith {};

		callSelfParams(stopProgress,true);
		callSelf(closeOpenedNetDisplay);
		callSelf(releaseBuildingPreview);
		callSelfParams(playSound, pick callSelf(getPainSounds) arg getRandomPitchInRange(0.85,1.2));
		private _m = ["извивается в агонии.","перестаёт сопротивляться боли."];
		callSelfParams(meSay,pick _m);


		callSelf(KnockDown);
	};

	func(updateAgonyTime)
	{
		objParams();
		private _nextcall = linearConversion[20,0,getSelf(painAmount),30,120,true];
		setSelf(agonyLastTime,tickTime + randInt(30,_nextcall));
	};

	//Сюда копится сопротивление боли
	var(painSupress,0);

	//Может ли персонаж чувствовать боль
	func(canFeelPain)
	{
		objParams();
		tickTime > getSelf(painSupress)
	};

	func(addPainSupress)
	{
		objParams_1(_amount);
		if (callSelf(canFeelPain) /*&& getSelf(painSupress)==0*/) then {
			setSelf(painSupress,tickTime + _amount);
			callSelf(onSyncPain);
		} else {
			modSelf(painSupress,+ _amount);
		};
	};

	//добавить немного боли. _amount временное значение
	"
		name:Изменить боль
		desc:Добавляет или устанавливает значение боли для указанной части тела персонажа, если такова существует.
		type:method
		lockoverride:1
		in:enum.BodyPart:Часть тела:Часть тела, для которой будет добавлена боль
		in:int:Количество:Количество единиц боли, добавляемое к части тела персонажа
		in:bool:Установить:При включении данной опции будет выполнена установка нового указанного количества вместо добавления к текущему значению боли.
			opt:def=false:require=-1
		in:bool:Подавить приступ:При включении данной опции не будет производиться приступ при получении боли или агонии.
			opt:def=false:require=-1
	" node_met
	func(adjustPain)
	{
		params ['this',["_bpIdx",BP_INDEX_TORSO],"_amount",["_isSet",false],["_suppressMessage",false]]; //_isSet установит боль в текущее значение. нужно например для обнуления

		//redirect if part not exists
		if !callSelfParams(hasPart,_bpIdx) then {
			_bpIdx = BP_INDEX_TORSO;
		};
		private _part = callSelfParams(getPart,_bpIdx);

		if (_isSet) exitWith {
			private _newLevel = clamp(PAIN_LIST_RESTORE_TIME findif {_x>=_amount},PAIN_LEVEL_NO,PAIN_LEVEL_MAX);
			callSelfParams(setPainLevel,_bpIdx arg _newLevel arg _suppressMessage);
			setVar(_part,painTime,_amount);
		};

		private _curLvl = getVar(_part,pain);
		private _curpain = getVar(_part,painTime);
		private _allPain = _curpain;
		// конвертируем уровень в абсолютное значение
		{
			if (_forEachIndex>=_curLvl) exitWith {};
			modvar(_allPain) + _x;
		} foreach PAIN_LIST_RESTORE_TIME;
		//добавляем текущую боль
		modvar(_allPain) + _amount;
		//ограничиваем диапазон
		_allPain = clamp(_allPain,0,PAIN_MAX_AMOUNT);
		//breakpoint("all pain calculated: "+str _allPain)
		//возвращаем уровень и остаточную боль
		private _newLvlCalc = 0;
		private _lastAllPain = 0;
		{
			//breakpoint("	[ITERstart] cur: "+str _x + "; now pain:"+str(_allPain)+" - at level "+str (_newLvlCalc))
			if (_allPain<=0) exitWith {
				_newLvlCalc = clamp(_newLvlCalc-1,PAIN_LEVEL_NO,PAIN_LEVEL_MAX);
				_allPain = _lastAllPain+_allPain;

			};

			INC(_newLvlCalc);
			modvar(_allPain) - _x;
			_lastAllPain = _x;

		} foreach PAIN_LIST_RESTORE_TIME;

		if (_allPain<=0) then {
			_newLvlCalc = clamp(_newLvlCalc-1,PAIN_LEVEL_NO,PAIN_LEVEL_MAX);
			_allPain = _lastAllPain+_allPain;
		};

		//breakpoint(format vec3("pain compare: lvl %1; time left %2",_newLvlCalc,_allPain));

		//если уровень отличается от предыдущего - синхронизируем
		if (_newLvlCalc!=_curLvl) then {
			callSelfParams(setPainLevel,_bpIdx arg _newLvlCalc arg _suppressMessage);
		};
		setVar(_part,painTime,_allPain);
	};

	//увеличение уровня боли на 1 или более
	func(addPainLevel)
	{
		params ['this',"_bpIdx",["_lvl",1],["_isApplyficator",false],["_suppressMessage",false]];

		//redirect if part not exists
		if !callSelfParams(hasPart,_bpIdx) then {
			_bpIdx = BP_INDEX_TORSO;
		};

		private _part = callSelfParams(getPart,_bpIdx);
		if (_isApplyficator) then {
			if (getVar(_part,pain) < _lvl) then {
				setVar(_part,pain,_lvl);
			};
		} else {
			private _curPain = clamp(getVar(_part,pain) + _lvl,PAIN_LEVEL_MIN,PAIN_LEVEL_MAX);
			setVar(_part,pain,_curPain);
		};

		private _newPain = getVar(_part,pain);
		setVar(_part,painTime,PAIN_LEVEL_GET_RESTORE_TIME(_newPain));

		callSelf(onSyncPain);

		if (!_suppressMessage) then {
			if (_newPain == PAIN_LEVEL_MAX) then {
				callSelf(doAgony);
			} else {
				callSelf(doMoan);
			};
		};
	};

	func(setPainLevel)
	{
		params ['this',"_bpIdx","_lvl",["_suppressMessage",false]];

		//redirect if part not exists
		if !callSelfParams(hasPart,_bpIdx) then {
			_bpIdx = BP_INDEX_TORSO;
		};

		private _part = callSelfParams(getPart,_bpIdx);
		setVar(_part,pain,clamp(_lvl,PAIN_LEVEL_NO,PAIN_LEVEL_MAX));

		private _newPain = getVar(_part,pain);

		setVar(_part,painTime,PAIN_LEVEL_GET_RESTORE_TIME(_newPain));

		callSelf(onSyncPain);

		if (_newPain>PAIN_LEVEL_NO && !_suppressMessage) then {
			if (_newPain == PAIN_LEVEL_MAX) then {
				callSelf(doAgony);
			} else {
				callSelf(doMoan);
			};
		};
	};

	//уменьшение уровня боли на 1
	func(removePainLevel)
	{
		params ['this',"_bpIdx",["_lvl",1],["_lowerValue",PAIN_LEVEL_NO]];

		//redirect if part not exists
		if !callSelfParams(hasPart,_bpIdx) then {
			_bpIdx = BP_INDEX_TORSO;
		};

		private _part = callSelfParams(getPart,_bpIdx);

		private _curPain = clamp(getVar(_part,pain) - _lvl,_lowerValue,PAIN_LEVEL_MAX);
		setVar(_part,pain,_curPain);

		setVar(_part,painTime,ifcheck(equals(_curPain,PAIN_LEVEL_NO),0,PAIN_LEVEL_GET_RESTORE_TIME(_curPain)));

		callSelf(onSyncPain);
		callSelf(updateMoanTime);
	};

	//Вызывает синхронизацию боли
	func(onSyncPain)
	{
		objParams();
		//отсылаем клиенту самую большую боль
		private _maxPain = 0;
		private _part = nullPtr;
		private _curPain = 0;
		private _painAmount = 0;
		{
			_part = _y;
			if !isNullReference(_part) then {
				_curPain = getVar(_part,pain);
				_maxPain = _maxPain max _curPain;
				modvar(_painAmount) + _curPain;
			};
		} foreach getSelf(bodyParts);

		//calculate organs pain and adjust to body
		private _org = nullPtr;
		private _orgPain = 0;
		{
			_org = callSelfParams(getBodyOrgan,_x);
			if isNullReference(_org) then {continue};
			_curPain = callFunc(_org,getOrganPain);
			modvar(_orgPain) + _curPain;
			modvar(_maxPain) max _curPain;
		} foreach BO_INDEX_ALL;

		_org = callSelf(getBrain);
		if !isNullReference(_org) then {
			_curPain = callFunc(_org,getOrganPain);
			modvar(_orgPain) + _curPain;
			modvar(_maxPain) max _curPain;
		};

		setSelf(internalPain,_orgPain);

		setSelf(painAmount,_painAmount);
		setSelf(inAgony,equals(_maxPain,PAIN_LEVEL_MAX));
		
		if !callSelf(canFeelPain) then {
			callSelfParams(fastSendInfo,"hud_pain" arg 0);
			callSelfParams(fastSendInfo,"pp_pain_lvl" arg 0);
		} else {
			callSelfParams(fastSendInfo,"hud_pain" arg _maxPain);
			callSelfParams(fastSendInfo,"pp_pain_lvl" arg clamp(_painAmount + _orgPain,0,20));//максимально боли 20 ед.
		};
	};

region(Bones sub-system)

	"
		name:Установить состояние костей
		desc:Устанавливает состояние костей в части тела персонажа. Если части тела не существует - ничего не произойдёт.
		type:method
		lockoverride:1
		in:enum.BodyPart:Часть тела:Часть тела, для которой будет установлено состояние костей.
		in:enum.BoneStatus:Состояние костей:Новое состояние костей для части тела.
	" node_met
	func(setBoneStatus)
	{
		objParams_2(_bpIdx,_status);
		private _pt = callSelfParams(getPart,_bpIdx);
		if isNullReference(_pt) exitWith {};

		callFuncParams(_pt,setBoneStatus,_status);
	};

	//отдаёт клиенту инфу может ли он двигаться от сломанных ног
	func(onSyncBones)
	{
		objParams();
		//onSyncLegsBoneState
		private _isBrokenLeg = false;
		private _part = null;
		private _brokenBones = 0;
		{
			_part = callSelfParams(getPart,_x);
			if (!isNullReference(_part) && {callFunc(_part,isBoneBroken)}) then {
				if (_x in [BP_INDEX_LEG_L,BP_INDEX_LEG_R]) then {
					_isBrokenLeg = true;
				};
				INC(_brokenBones);
			};
		} foreach getSelf(bodyParts);

		callSelfParams(sendInfo,"onSyncLegsBoneState" arg [getSelf(owner) arg _isBrokenLeg]);

		callSelfParams(fastSendInfo,"hud_bone" arg _brokenBones);

		callSelf(syncDamageVisual);
	};

	var(__brokenlegtimeout,0);
	func(handle_brokenLegs)
	{
		_isBrokenLeg = false;
		_canfalling = false;
		_indexArm = [INV_HAND_L,INV_HAND_R];
		{
			_part = callSelfParams(getPart,_x);
			_noleg = isNullReference(_part);
			if (_noleg) then {
				_item = callSelfParams(getItemInSlot,_indexArm select _forEachIndex);
				if isNullReference(_item) exitWith {_canfalling = true};
				if isTypeOf(_item,Crutch) exitWith {
					if getSelf(isCombatModeEnable) exitWith {_canfalling = true};
				};
				_canfalling = true;
			};
			if (!_noleg && {callFunc(_part,isBoneBroken)}) exitWith {
				_isBrokenLeg = true;
			};
		} foreach [BP_INDEX_LEG_L,BP_INDEX_LEG_R];

		if (_isBrokenLeg) then {
			if (tickTime>=getSelf(__brokenlegtimeout)) then {
				callSelf(doMoan);
				callSelfParams(Stun,randInt(3,5) arg null arg true);

				//просто ебём
				setSelf(__brokenlegtimeout,tickTime + randInt(10,40));

				//Уже захардкожено что бегать со сломанной ногой нельзя
				/*if callSelf(isSprinting) then {
					setSelf(__brokenlegtimeout,tickTime + randInt(2,8));
				} else {
					if callSelf(isRunning) exitWith {
						setSelf(__brokenlegtimeout,tickTime + randInt(5,15));
					};
					setSelf(__brokenlegtimeout,tickTime + randInt(10,60));
				};*/
			};
		};
		
		
		if callSelf(isGrabbed) exitWith {};
		
		_stance = callSelf(getStance);
		
		if (callSelf(getSpeedMode)>SPEED_MODE_STOP) then {
			if (_stance > STANCE_DOWN) then {
				if (_canfalling) then {
					_bon = -6;
					if (_stance<=STANCE_MIDDLE) then {
						modvar(_bon) + 4;
					};
					if (getRollType(callSelfParams(checkSkill,"DX" arg _bon))in[DICE_FAIL,DICE_CRITFAIL]) then {
						callSelf(KnockDown);
					};
				};
			};
		};

	};
	
	func(handle_attachedParts)
	{
		{
			if !isNullReference(_y) then {
				if !callFunc(_y,isAttached) then {
					callFuncParams(_y,disconnectBodyPart,getSelf(owner));
					if isTypeOf(_y,Leg) then {
						callSelf(KnockDown);
					};
				};
			};
		} foreach getSelf(bodyparts);
	};
	
region(smelling)
	
	func(getSmellInfo)
	{
		objParams_1(_distToTaget);
		//TODO переработать систему. запахи должны быть классами
		private _smells = [];
		private _rot = call {
			if !callSelf(canRottenSmell) exitWith {""};
			private _maxPart = callSelf(getMaxInfectionPart);
			if isNullReference(_maxPart) exitWith {""};
			private _stage = getVar(_maxPart,infectionLevel);
			if (_stage == 2) exitWith {"Легкий запах гнили"};
			if (_stage >= 3) exitWith {pick["Гниль","Гниение"]};
		};
		if (_rot!="") then {_smells pushBack _rot};

		if callSelfParams(hasStatusEffect,"SEAlcoholHangover") then {
			private _alco = callSelfParams(getStatusEffect,"SEAlcoholHangover");
			if isNullReference(_alco) exitWith {};
			private _size = getVar(_alco,size);
			if (_size > 10 && _size < 20) exitwith {
				_smells pushBack (pick["Легкий перегар","Слабый перегар"]);
			};
			if (_size >= 20) exitwith {
				_smells pushBack (pick["Сильный перегар","Лютый перегарище"]);
			};
			"Алкоголь"
		};

		if (count _smells > 0) exitwith {
			_smells = array_shuffle(_smells) apply {lowerize(_x)};
			_smells joinString " и ";
		};

		""
	};