// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================


//болезни
class(SEDiseaseBase) extends(SEMedicalBase)
	var(name,"Болезнь");
	var(desc,null);
	var(spreadClass,callSelf(getClassName)); //класс передачи (добавляет объект на моба при передаче)
	var(spreadType,"none"); //способ передачи через разделитель: none, blood, air, contact,feet,hand
	var(spreadAirRange,2); //расстояние распространения болезни
	var(stage,1); //стадия болезни. Всегда начинается с 1
	var(maxStages,1); //сколько всего стадий
	var(stageProb,4); //вероятность перехода на следующую стадию
	var(contagiousPeriod,0);//стадия болезник когда она может распространяться
	var(cureProb,8); //шанс излечения
	var(isCurable,true); //можно ли излечиться
	var(isRemissive,false); //true если пациент идёт на поправку
	var(stageMinimumAge,0); //сколько должно накопиться для каждой стадии
	var(age,0); //таймер прогресса текущей стадии
	var(longevity,30); //сколько по времени объект болезнь остается в объектах (в жидкостных контейнерах без ограничений)
	var(affectedMobTypes,[]); //на каких мобов может быть наложена болезнь

	func(constructor)
	{
		objParams();
	};

	func(destructor)
	{
		objParams();
		private _loc = getSelf(loc);
		if !isNullReference(_loc) then {
			if isTypeOf(_loc,IDestructible) then {
				callFuncParams(_loc,removeStatusEffect,this);
			};
		};
	};

	
	func(onStage)
	{
		objParams();
		modSelf(age, + 1);

		private _canCure = callSelf(canCure);

		setSelf(isRemissive,_canCure);

		if (getSelf(stage) > getSelf(maxStages)) then {
			setSelf(stage,(getSelf(stage) + 1) min (maxStages));
		};
		if (_canCure) then {
			if (prob(getSelf(cureProb))) then {
				setSelf(stage,(getSelf(stage) - 1) max 1);
			};
			if (getSelf(stage) <= 1 && {(prob(1) && getSelf(isCurable)) || _canCure && prob(getSelf(cureProb))}) then {
				callSelf(Cure);
			};
		} else {
			if (prob(getSelf(stageProb)) && getSelf(age) > getSelf(stageMinimumAge)) then {
				setSelf(age,0);
				setSelf(stage, getSelf(stage) + 1);
			};
		};

	};

	func(doSpread)
	{
		objParams();
		private _types = getSelf(spreadType);
		if ("none" in _types) exitWith {};
		private _range = getSelf(spreadAirRange);
		if ("blood" in _type) exitWith {};
		if (getSelf(stage)<getSelf(contagiousPeriod)) exitWith {};

		if ("contact"in _types) then {_range = 1};

		{
			callFuncParams(_x,contactDisease,this);
		} foreach callFunc(getSelf(loc),getNearMobs);
	};
	
	func(contactDisease)
	{
		objParams_1(_target);
	};

	func(copyTo)
	{
		objParams_1(_targ);
		callFuncParams(_targ,addStatusEffect,callSelf(getClassName));
	};

	func(onUpdate)
	{
		objParams();
		private _loc = getSelf(loc);
		if isNullReference(_loc) exitWith {
			delete(this)
		};

		if prob(65) then {
			callSelf(doSpread);
		};

		if callFunc(_loc,isMob) then {
			callSelf(onStage);
		} else {
			modSelf(longevity, - 1);
			if (getSelf(longevity)<=0) then {
				callSelf(cure);
			};
		};
	};

endclass

#define debug_infection

#ifndef EDITOR
	#undef debug_infection
#endif

//вызывает некроз
class(SEDiseaseInfection) extends(SEDiseaseBase)
	var(name,"Инфекция");
	getterconst_func(isOnetimeStatus,false);
	var(isCurable,false);

	var(cureProb,75);
	getterconst_func(cures,[vec2("Spirt",5) arg vec2("Procerin",1)]);

	var(stage,1);
	var(maxStages,4);
	var(contagiousPeriod,0);
#ifdef debug_infection
	var(stageMinimumAge,5);
	var(stageProb,100);
#else
	var(stageMinimumAge,60 * 2);
	var(stageProb,30);
#endif
	
	func(canCure)
	{
		objParams();
		super() && !(getSelf(stage) >= 3 &&  getSelf(age)>60)
	};
	
	var(bodyPartTarget,nullPtr);
	var(bodyPartIndex,-1);
	
	var(lastMessage,0);
	
	func(onCreate)
	{
		objParams_1(_data);
		if !callFuncParams(getSelf(loc),hasPart,_data) exitWith {
			errorformat("Cant create %1 - part %2 not exists",this arg _data);
			delete(this);
		};
		setSelf(bodyPartIndex,_data);
		setSelf(bodyPartTarget,callFuncParams(getSelf(loc),getPart,_data));
	};

	func(onStage)
	{
		objParams();
		super();
		
		if not_equals(getSelf(loc),getVar(getSelf(bodyPartTarget),loc)) exitWith {
			callSelf(Cure);
		};
		
		private _canprint = tickTime > getSelf(lastMessage);
		if (_canprint) then {
			#ifdef debug_infection
			setSelf(lastMessage,tickTime + 2);
			#else
			setSelf(lastMessage,tickTime + randInt(30,60*2));
			#endif
		};
		
		private _stage = getSelf(stage);
		if (_stage == 2) exitWith {
			//публикует сообщение об инфекции
			if (_canprint) then {
				callFuncParams(getSelf(loc),doSmell,"stink");
			};
		};
		if (_stage == 3) exitWith {
			//ещё чаще публикует сообщение об инфекции.
			setSelf(cureProb,10); //излечиться сложнее
			if (_canprint) then {
				callFuncParams(getSelf(loc),doSmell,"stink");
			};
		};
		if (_stage == 4) exitWith {
			//финальная стадия
			//создаем зону через добавление нового статус эффекта
			callFunc(getSelf(bodyPartTarget),doRotten);
			callFuncParams(getSelf(loc),mindSay,"<t size='1.5' color='#BACC45'>О боже... "+callFunc(getSelf(bodyPartTarget),getName)+" сгнивает.</t>");
			callSelf(transferInfection);
			callSelf(Cure);
		};
	};
	
	func(transferInfection)
	{
		objParams();
		private _curPart = getSelf(bodyPartIndex);
		private _mob = getSelf(loc);
		private _canTransferToPartDelegate = {
			private _part = _this;
			!callFuncParams(getSelf(loc),hasStatusEffect,"SEDiseaseInfection" arg {equals(getVar(_x,bodyPartIndex),_part)})
			&& !getVar(callFuncParams(_mob,getPart,_part),isRotten)
		};
		if (_curPart != BP_INDEX_TORSO) then {
			traceformat("DEINFO %1 %2",callFuncParams(_mob,getPart,BP_INDEX_TORSO) arg !getVar(callFuncParams(_mob,getPart,BP_INDEX_TORSO),isRotten))
			if (BP_INDEX_TORSO call _canTransferToPartDelegate) then {
				callFuncParams(getSelf(loc),addStatusEffect,"SEDiseaseInfection" arg BP_INDEX_TORSO);
			};
		} else {
			{
				if !callFuncParams(_mob,hasPart,_x) exitWith {};
				if (_x call _canTransferToPartDelegate) then {
					callFuncParams(getSelf(loc),addStatusEffect,"SEDiseaseInfection" arg _x);
				};
			} foreach (BP_INDEX_ALL - [BP_INDEX_TORSO]);
		};
	};

endclass
