// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================


matter(Spirt) extends(Matter)
	prop(name,"Спирт");
	prop(overdose,15);
	
	def(onAssimIngest)
		private _p = callSelf(getMaxInfectionPart);
		if isNullReference(_p) exitWith {};
		if (getVar(_p,infectionLevel) < INFECTION_LEVEL_TOSMELL) then {
			callFuncParams(_p,removeInfection,null);
		};
	end
	
	def(onAssimBlood)
		private _p = callSelf(getMaxInfectionPart);	
		if isNullReference(_p) exitWith {};
		if (getVar(_p,infectionLevel) < INFECTION_LEVEL_TOSMELL) then {
			callFuncParams(_p,removeInfection,null);
		};
	end
	
	def(onOverdosed)
		callSelfParams(addStatusEffect,"SEAlcoholHangover");
	end

matter(Water) extends(Matter)
	prop(name,"Вода");
	prop(overdose,30);
	def(onOverdosed)
		//very temp code... fuck this
		callSelfParams(adjustToxin,4*randInt(6,8));
		modSelf(vomitAmount, + 2*4);
		// private _liv = callSelfParams(getBodyOrgan,BO_INDEX_LIVER);
		// traceformat("liver %1 inside %2",_liv arg callSelfParams(getPart,BP_INDEX_TORSO))
		// if !isNullReference(_liv) then {
		// 	callFuncParams(callSelfParams(getPart,BP_INDEX_TORSO),damageOrgan,BO_INDEX_LIVER);
		// };
		// {
		// 	private _kid = callSelfParams(getBodyOrgan,_x);
		// 	if !isNullReference(_kid) then {
		// 		callFuncParams(callSelfParams(getPart,BP_INDEX_TORSO),damageOrgan,_x);
		// 	};
		// } foreach [BO_INDEX_KIDNEY_L,BO_INDEX_KIDNEY_R];
	end


matter(Blood) extends(Matter)
	prop(name,"Кровь");

matter(Burda) extends(Matter)
	prop(name,"Бурда");


//foods

matter(Nutriment) extends(Matter)
	prop(name,"Питательные вещества");
	var(metabolism,1);
	def(onAssimIngest)
		callSelfParams(adjustHunger, + 2);
	end

matter(Meat) extends(Matter)
	prop(name,"Мясо");

matter(Milk) extends(Matter)
	prop(name,"Молоко");
	
	def(onAssimIngest)
		callSelfParams(adjustToxin, - randInt(1,2));
	end

matter(Starch) extends(Matter)
	prop(name,"Крахмал");
	def(onAssimIngest)
		callSelfParams(adjustHunger, + 1);
	end

matter(Salt) extends(Matter)
	prop(name,"Соль");
	prop(overdose,10);
	prop(metabolism,0.01);
	def(onAssimIngest)
		callSelfParams(adjustHunger, + 2);
	end
	
	def(onOverdosed)
		
		callSelfParams(adjustToxin,randInt(5,8));
		if prob(50) then {
			modSelf(vomitAmount, + 5);
		};
	end

matter(Sugar) extends(Matter)
	prop(name,"Сахар");

matter(Pepper) extends(Matter)
	prop(name,"Перец");

//basic chemical
#define defchem(class,txtpropval) matter(class) extends(Matter) prop(name,txtpropval);

defchem(Alvitin,"Альвитин");
defchem(Celicin,"Целицин");
defchem(Bodrin,"Бодрин");
defchem(Imunit,"Имунит");
defchem(Kenazin,"Кеназин");
defchem(Rebuliy,"Ребулий");
defchem(Askadiy,"Аскадий");
defchem(Toniy,"Тоний");
defchem(Ceriy,"Церий");

defchem(Karbidin,"Карбидин");
defchem(Stomacin,"Стомацин");
defchem(Feronin,"Феронин");
defchem(Pariliy,"Парилий");
defchem(Opirin,"Опирин");
defchem(Muteliy,"Мутелий");
defchem(Paradol,"Парадол");
defchem(Radoniy,"Радоний");
defchem(Fadiy,"Фадий");
defchem(Vodiy,"Водий");

//medical
defchem(Neyrizin,"Нейризин");
defchem(Metaficin,"Метафицин");
defchem(Sepivitin,"Сепивитин");
//лечит органы и восстанавливает нервную систему
defchem(Demitolin,"Демитолин");
	def(onAssimIngest)
		{
			callFuncParams(_x,healOrgan,ORGAN_REGEN_TIME_PRE_SECOND);
		} foreach callSelf(getAllInternalOrgans);
	end
	def(onAssimBlood)
		{
			callFuncParams(_x,healOrgan,ORGAN_MEDICAL_REGEN_TIME_PER_SECOND);
		} foreach callSelf(getAllInternalOrgans);
	end
defchem(Demidrocin,"Демидроцин");

defchem(Cetalin,"Цеталин");
	def(onAssimIngest)
		callSelfParams(addPainSupress,20);
		{
			if isNullReference(_y) then {continue};callFuncParams(_y,healPain,6);
		} foreach getSelf(bodyParts);
	end

	def(onAssimBlood)
		callSelfParams(addPainSupress,10);
		{
			if isNullReference(_y) then {continue};callFuncParams(_y,healPain,2);
		} foreach getSelf(bodyParts);
	end

//эффект болеутоляющего.
//TODO не смешивать с алкоголем
defchem(Tamidin,"Тамидин");
	def(onAssimIngest)
		{
			//Нет части тела
			if isNullReference(_y) then {continue};
			_healLvl = linearConversion [PAIN_LEVEL_MAX,PAIN_LEVEL_MIN,getVar(_y,pain),300,20,true];
			callFuncParams(_y,healPain,_healLvl);
		} foreach getSelf(bodyParts);
	end

	def(onAssimBlood)
		{
			//Нет части тела
			if isNullReference(_y) then {continue};
			_healLvl = linearConversion [PAIN_LEVEL_MAX,PAIN_LEVEL_MIN,getVar(_y,pain),400,30,true];
			callFuncParams(_y,healPain,_healLvl);
		} foreach getSelf(bodyParts);
	end

defchem(Kodizin,"Кодизин");
defchem(Todizin,"Тодизин");

defchem(Ipamitin,"Ипамитин");
defchem(Detoklomin,"Детокломин");

//лечит физические повреждения
defchem(Tovimin,"Товимин");
	var(metabolism,1.2);//быстрее всасывается в клетки

	def(onAssimIngest)
	{
		if callFuncParams(_y,hasAnyDamageOfType,WOUND_TYPE_BRUISE) then {
			//Модификатор лечения + 2
			callFuncParams(_y,regenProcessWounds,this arg WOUND_TYPE_BRUISE arg +2);
		};
	} forEach getSelf(bodyParts);
	end
	def(onAssimBlood)
		{
			if callFuncParams(_y,hasAnyDamageOfType,WOUND_TYPE_BRUISE) then {
				//Модификатор лечения + 6
				callFuncParams(_y,regenProcessWounds,this arg WOUND_TYPE_BRUISE arg +6);
			};
		} forEach getSelf(bodyParts);
	end

//останавливает кровотечение
defchem(Koradizin,"Корадизин");
	def(onAssimIngest)
	{
		if callFuncParams(_y,hasAnyDamageOfType,WOUND_TYPE_BLEEDING) then {
			//Модификатор лечения + 2
			callFuncParams(_y,regenProcessWounds,this arg WOUND_TYPE_BLEEDING arg +2);
		};
	} forEach getSelf(bodyParts);
	end
	def(onAssimBlood)
		{
			if callFuncParams(_y,hasAnyDamageOfType,WOUND_TYPE_BLEEDING) then {
				//Модификатор лечения + 6
				callFuncParams(_y,regenProcessWounds,this arg WOUND_TYPE_BLEEDING arg +6);
			};
		} forEach getSelf(bodyParts);
	end

defchem(Procerin,"Процерин");
defchem(Getomizitin,"Гетомизитин");

//others
//слабое снотворное. передоз = токсины. нейтрализуется Demitolin
defchem(Somniy,"Сомний");
	def(onAssimIngest)
		if (amount >= 3) then {
			callSelfParams(addSleepStrength,2 arg true);
		};
	end

	def(onAssimBlood)
		if (amount >= 2) then {
			callSelfParams(addSleepStrength,2 arg true);
		};
	end
//сильное снотворное. передоз = остановка сердца. нейтрализуется Ipamitin
defchem(Komatin,"Коматин");
	def(onAssimIngest)
		if (amount >= 0.8) then {
			callSelfParams(addSleepStrength,4 arg true);
		};
	end

	def(onAssimBlood)
		if (amount >= 1) then {
			callSelfParams(addSleepStrength,4 arg true);
		};
	end

defchem(Sulfanid,"Сульфанид");
defchem(Pemidil,"Пемидил");

defchem(Onicid,"Оницид");
defchem(Hloritin,"Хлоритин");
defchem(Paraneyrin,"Паранейрин");
defchem(Mertvin,"Мертвин");

//narko and etc
defchem(Gribicin,"Грибицин");
defchem(Zhivognilin,"Живогнилин");
defchem(Psihodin,"Психодин");
defchem(Verbin,"Вербин");
defchem(Psihobadin,"Психобадин");

defchem(Chistin,"Чистин");
defchem(Bumilin,"Бумилин");

defchem(Mutacin,"Мутацин");


/// РЕЖИМНЫЕ ШТУКИ

defchem(VenomDead,"Смертная сыворотка");
	def(onAssimIngest)
		if (amount >= 10) then {
			if isNull(getSelf(venom_dead_flag)) then {
				setSelf(venom_dead_flag,true);
				private _code = {
					callFuncParams(_this,meSay," падает на землю и бьется в конвульсиях.");
					callFuncParams(_this,Die,"VenomDead");
				};
				private _preCode = {
					callFuncParams(_this,localSay,"Ты задыхаешься..." arg "mind");
				};
				private _venTime = randInt(60*1,60*3);
				#ifdef EDITOR
				_venTime = 10;
				#endif
				invokeAfterDelayParams(_preCode,_venTime/2,this);
				invokeAfterDelayParams(_code,_venTime,this);
			};
		};
	end

	def(onAssimBlood)
		if (amount >= 1) then {
			if isNull(getSelf(venom_dead_flag)) then {
				setSelf(venom_dead_flag,true);
				private _code = {
					callFuncParams(_this,meSay," падает на землю и бьется в конвульсиях.");
					callFuncParams(_this,Die,"VenomDead");
				};
				private _preCode = {
					callFuncParams(_this,localSay,"Ты задыхаешься..." arg "mind");
				};
				private _venTime = randInt(60*1,60*3);
				#ifdef EDITOR
				_venTime = 10;
				#endif
				invokeAfterDelayParams(_preCode,_venTime/2,this);
				invokeAfterDelayParams(_code,_venTime,this);
			};
		};
	end