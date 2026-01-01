// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

class(Spirt) extends(ReagentBase)
	var(name,"Спирт");
	getterconst_func(getOverdose,15);
	
	func(onMob)
	{
		objParams_1(_mob);
		super();
		private _p = callFunc(_mob,getMaxInfectionPart);
		if isNullReference(_p) exitWith {};
		if (getVar(_p,infectionLevel) < INFECTION_LEVEL_TOSMELL) then {
			callFuncParams(_p,removeInfection,null);
		};
	};
	
	func(onOverdosed)
	{
		objParams_1(_mob);
		callFuncParams(_mob,addStatusEffect,"SEAlcoholHangover");
	};

endclass

class(Water) extends(ReagentBase)
	var(name,"Вода");
endclass
class(Blood) extends(ReagentBase)
	var(name,"Кровь");
endclass
class(Burda) extends(ReagentBase)
	var(name,"Бурда");
endclass

//foods

class(Nutriment) extends(ReagentBase)
	var(name,"Питательные вещества");
	getterconst_func(getMetabolizeRate,1);

	func(onMob)
	{
		objParams_1(_mob);
		super();
		callFuncParams(_mob,adjustHunger, + 2);
	};
endclass

class(Milk) extends(ReagentBase)
	var(name,"Молоко");
	
	func(onMob)
	{
		objParams_1(_mob);
		super();
		callFuncParams(_mob,adjustToxin, - randInt(1,2));
	};
endclass
class(Salt) extends(ReagentBase)
	var(name,"Соль");
	getterconst_func(getOverdose,10);
	getterconst_func(getMetabolizeRate,0.01);

	func(onMob)
	{
		objParams_1(_mob);
		super();
		callFuncParams(_mob,adjustHunger, + 2);
	};

	func(onOverdosed)
	{
		objParams_1(_mob);
		callFuncParams(_mob,adjustToxin,randInt(5,8));
		if prob(50) then {
			modVar(_mob,vomitAmount, + 5);
		};
	};
endclass


class(Sugar) extends(ReagentBase)
	var(name,"Сахар");
endclass
class(Pepper) extends(ReagentBase)
	var(name,"Перец");
endclass

//basic chemical
#define defchem(__class,txtpropval) class(__class) extends(ReagentBase) var(name,txtpropval); endclass
#define defchem_impl(__class,txtpropval) class(__class) extends(ReagentBase) var(name,txtpropval);

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
defchem_impl(Demitolin,"Демитолин");
	func(onMob)
	{
		objParams_1(_mob);
		super();
		{
			callFuncParams(_x,healOrgan,ORGAN_MEDICAL_REGEN_TIME_PER_SECOND);
		} foreach callFunc(_mob,getAllInternalOrgans);
	};
endclass

defchem(Demidrocin,"Демидроцин");

defchem_impl(Cetalin,"Цеталин");

	func(onMob)
	{
		objParams_1(_mob);
		super();
		callFuncParams(_mob,addPainSupress,10);
		{
			if isNullReference(_y) then {continue};callFuncParams(_y,healPain,2);
		} foreach getVar(_mob,bodyParts);
	};
endclass

//эффект болеутоляющего.
//TODO не смешивать с алкоголем
defchem_impl(Tamidin,"Тамидин");
	func(onMob)
	{
		objParams_1(_mob);
		super();
		{
			//Нет части тела
			if isNullReference(_y) then {continue};
			_healLvl = linearConversion [PAIN_LEVEL_MAX,PAIN_LEVEL_MIN,getVar(_y,pain),400,30,true];
			callFuncParams(_y,healPain,_healLvl);
		} foreach getVar(_mob,bodyParts);
	};
endclass

defchem(Kodizin,"Кодизин");
defchem(Todizin,"Тодизин");

defchem(Ipamitin,"Ипамитин");
defchem(Detoklomin,"Детокломин");

//лечит физические повреждения
defchem_impl(Tovimin,"Товимин");
	getterconst_func(getMetabolizeRate,1.2);//быстрее всасывается в клетки

	func(onMob)
	{
		objParams_1(_mob);
		super();
		{
			if callFuncParams(_y,hasAnyDamageOfType,WOUND_TYPE_BRUISE) then {
				//Модификатор лечения + 2
				callFuncParams(_y,regenProcessWounds,this arg WOUND_TYPE_BRUISE arg +2);
			};
		} forEach getVar(_mob,bodyParts);
	};
endclass

//останавливает кровотечение
defchem_impl(Koradizin,"Корадизин");

	func(onMob)
	{
		objParams_1(_mob);
		super();
		{
			if callFuncParams(_y,hasAnyDamageOfType,WOUND_TYPE_BLEEDING) then {
				//Модификатор лечения + 6
				callFuncParams(_y,regenProcessWounds,this arg WOUND_TYPE_BLEEDING arg +6);
			};
		} forEach getVar(_mob,bodyParts);
	};
endclass

defchem(Procerin,"Процерин");
defchem(Getomizitin,"Гетомизитин");

//others
//слабое снотворное. передоз = токсины. нейтрализуется Demitolin
defchem_impl(Somniy,"Сомний");

	func(onMob)
	{
		objParams_1(_mob);
		super();
		if (getSelf(volume) >= 3) then {
			callFuncParams(_mob,addSleepStrength,2 arg true);
		};
	};
endclass
//сильное снотворное. передоз = остановка сердца. нейтрализуется Ipamitin
defchem_impl(Komatin,"Коматин");
	func(onMob)
	{
		objParams_1(_mob);
		super();
		if (getSelf(volume) >= 1) then {
			callFuncParams(_mob,addSleepStrength,4 arg true);
		};
	};
endclass

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

defchem_impl(VenomDead,"Смертная сыворотка");
	func(onMob)
	{
		objParams_1(_mob);
		super();
		if (getSelf(volume) >= 10) then {
			if isNull(getVar(_mob,venom_dead_flag)) then {
				setVar(_mob,venom_dead_flag,true);
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
	};
endclass