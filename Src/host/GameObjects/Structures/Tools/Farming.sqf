// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\..\engine.hpp>
#include <..\..\..\oop.hpp>
#include <..\..\..\text.hpp>
#include <..\..\GameConstants.hpp>


class(RatCage) extends(IStruct)
	var(name,"Клеточки для мельтешат");
	var(model,"a3\structures_f\civ\market\cages_f.p3d");
	var(material,"MatMetal");
	var(dr,3);

	var(category,"food");

	getterconst_func(ratsAllowedCategory,["food" arg "milk" arg "combat" arg "random"]);

	editor_attribute("EditorVisible" arg "type:string") 
	//TODO add new editor attribute preinit value
	editor_attribute("Tooltip" arg "(TODO: Attr preinit code)\nТип клетки (по умолчанию food).\nДоступные типы:\nfood\nmilk\ncombat\nrandom")
	editor_attribute("alias" arg "(TODO: Attr preinit code) Rats category")
	var(initialCategory,"");

	var(lastCheckedTime,0);
	func(getTimeToNextCheck)
	{
		objParams();
		#ifdef EDITOR
		5
		#else
		randInt(60*2,60*5)
		#endif
	};

	func(setRatsCategory)
	{
		objParams_1(_cat);
		if !array_exists(callSelf(ratsAllowedCategory),_cat) exitWith {
			errorformat("%1::setRatsCategory() - Wrong category %2",callSelf(getClassName) arg _cat);
		};

		if (_cat == "random") then {
			_cat = pick ["food","milk"];
		};

		setSelf(category,_cat);
		private _catdesc = "";
		call {
			if (_cat == "food") exitWith {_catdesc = "Внутри кормовые мельтешата."};
			if (_cat == "milk") exitWith {_catdesc = "Внутри молочные мельтешата."};
			if (_cat == "combat") exitWith {_catdesc = "Внутри бойцовские мельтешата."};
		};
		setSelf(desc,_catdesc);
	};

	func(postAction)
	{
		objParams_1(_usr);

		callSelfParams(playSound,"UNCATEGORIZED\rat_life"+str randInt(1,2) arg getRandomPitchInRange(0.75,1.4));

		private _roll = callFuncParams(_usr,checkSkill,"farming");
		private _dice = getRollType(_roll);
		if (_dice == DICE_CRITFAIL) exitWith {
			callFuncParams(this,worldSay,"Мельтешонок вырывается из клетки и убегает прочь.");
			setSelf(lastCheckedTime,tickTime + callSelf(getTimeToNextCheck));
		};
		if (_dice == DICE_FAIL) exitWith {
			callFuncParams(_usr,worldSay,"Мельтешонок кусается!" arg "error");
			callFuncParams(_usr,addPainLevel,pick vec2(BP_INDEX_ARM_R,BP_INDEX_ARM_L) arg 1 arg true);

		};

		if callSelfReflectParams("onAction"+getSelf(category),_usr) then {
			setSelf(lastCheckedTime,tickTime + callSelf(getTimeToNextCheck));
		};
	};
	getter_func(getMainActionName,"Ухаживать");
	func(onMainAction)
	{
		objParams_1(_usr);
		if (tickTime >= getSelf(lastCheckedTime)) then {
			callFuncParams(_usr,startProgress,this arg "target.postAction" arg rand(2,5));
		} else {
			private _t = floor((getSelf(lastCheckedTime)-tickTime) / 60);
			if (_t < 1) then {
				callFuncParams(_usr,localSay,"Надо дать ещё чуть времени им отдохнуть." arg "error");
			} else {
				private _numeral = [_t,["минута","минуты","минут"]] call toNumeralString;
				callFuncParams(_usr,localSay,"Надо дать отдохнуть им ещё примерно " + str _t + " " + _numeral arg "error");
			};
		};

	};

	func(constructor)
	{
		objParams();
		setSelf(lastCheckedTime,tickTime + callSelf(getTimeToNextCheck));

		callSelfAfter(__initCageType,2);
	};

	func(__initCageType)
	{
		objParams();
		if equals(getSelf(initialCategory),"") exitwith {};
		callSelfParams(setRatsCategory,getSelf(initialCategory));
	};

	func(destructor)
	{
		objParams();
		delete(getSelf(cachedRat));
	};

	var(cachedRat,new(Melteshonok));

	func(onActionFood)
	{
		objParams_1(_usr);

		if callFuncParams(_usr,addItem,getSelf(cachedRat)) then {
			setSelf(cachedRat,new(Melteshonok));
			private _m = pick ["жирного","вкусного","сочного","аппетитного"];
			callFuncParams(_usr,meSay,"достаёт " + _m +" мельтешонка.");
			true
		} else {
			false
		};
	};

	var(cachedMilk,randInt(35,40));

	func(onActionMilk)
	{
		objParams_1(_usr);

		private _itm = callFunc(_usr,getItemInActiveHand);
		if (isNullObject(_itm) || {!callFunc(_itm,isReagentContainer)}) exitWith {
			callFuncParams(_usr,localSay,"Нужна ёмкость для молочка." arg "error");
			false
		};
		private _addedMilk = getSelf(cachedMilk);
		if (callFunc(_itm,getFilledSpace) + _addedMilk > callFunc(_itm,getCapacity)) exitWith {
			callFuncParams(_usr,localSay,"Нужна ёмкость ПОБОЛЬШЕ!" arg "error");
			false
		};

		callFuncParams(_itm,addReagent,"Milk" arg _addedMilk);
		setSelf(cachedMilk,randInt(35,40));
		callFuncParams(_usr,meSay,"сцеживает молочко.");

		true
	};

	func(onActionCombat)
	{
		objParams_1(_usr);
		//todo

		false
	};

endclass

class(FarmGarden) extends(IStruct)
	var(name,null);
	var(desc,null);
	getterconst_func(getName,"Грядка");
	//getterconst_func(getDesc,"")
	var(model,"a3\structures_f_enoch\military\training\shellcrater_01_f.p3d");
	var(material,"MatDirt");
	var(dr,3);

	//ссылки на созданные грибы (объекты)
	var_array(createdMushroomsWorldObjects);

	//вызывается при вырастании культуры
	func(onSpawn)
	{
		objParams();

		private _pos = getPosATL getSelf(loc);

		for "_i" from 1 to randInt(2,5) do {
			private _m = ["Zhivoglot",_pos vectorAdd [rand(-1,1),rand(-1,1),rand(-0.001,0.09)],null,false] call createItemInWorld;
			getSelf(createdMushroomsWorldObjects) pushBack getVar(_m,loc);
		};
	};

	autoref var(handleUpdate,-1);
	var(timeLeft,0);
	func(onUpdate)
	{
		updateParams();
		modSelf(timeLeft, - 1);

		//каждые 30 секунд проверяем включен ли свет
		//Если света нет то и роста нет.
		if (getSelf(timeLeft)%
		#ifdef EDITOR
		2
		#else
		30
		#endif
		 == 0) then {
			private _nearLamps = (["StreetLampEnabled",getPosATL getSelf(loc),20,true] call getGameObjectOnPosition) +
				(["StreetLamp",getPosATL getSelf(loc),20,true] call getGameObjectOnPosition);
			//traceformat("GARGEN CHECK %1",_nearLamps)

			if (count _nearLamps == 0) exitWith {
				#ifdef EDITOR
				modSelf(timeLeft, + 2);
				#else
				modSelf(timeLeft, + 30);
				#endif
			};

			{
				if (!getVar(_x,edIsEnabled) || !getVar(_x,edIsUsePower)) exitWith {
					//trace("MODTIME GARDEN")
					#ifdef EDITOR
					modSelf(timeLeft, + 2);
					#else
					modSelf(timeLeft, + 30);
					#endif

				};
			} foreach (_nearLamps);
		};

		if (getSelf(timeLeft) <= 0) exitWith {
			callSelfParams(stopUpdateMethod,"handleUpdate");
			callSelf(onSpawn);
		};
	};

	getter_func(isGrowthStarted,getSelf(handleUpdate)!=-1);

	func(onClick)
	{
		objParams_1(_usr);
		callSelfParams(startGrowth,_usr);
	};

	func(getDescFor)
	{
		objParams_1(_usr);
		callSuper(IStruct,getDescFor) + (
			if (callSelf(isGrowthStarted)) then {
				sbr +
				pick["Расти ещё где-то ","Вырастет примерно через ","Можно грибланить вроде ещё "] +
				([getSelf(timeLeft)+randInt(1,20),["секундочку","секундочки","секундочек"],true] call toNumeralString);
			} else {""}
			)
	};

	//Запускает рост культуры
	func(startGrowth)
	{
		objParams_1(_usr);

		if callSelf(isGrowthStarted) exitWith {
			private _m = pick["Можно грибланить...","Пошёл процесс.","Растёт уже.","Дело сделано!"];
			callFuncParams(_usr,mindSay,_m);
		};

		if ({!isNullReference(_x)} count getSelf(createdMushroomsWorldObjects) > 0) exitWith {
			private _m = pick["Надо сначала собрать выросшее.","То что выросло требуется убрать.","Там где выросло - расти не будет. Нужно собрать."];
			callFuncParams(_usr,mindSay,_m);
		};

		//TODO if farming skill low or not farmer - set more time

		//clear array
		setSelf(createdMushroomsWorldObjects,[]);

		#ifndef EDITOR
		setSelf(timeLeft,t_asMin(randInt(10,20)) + randInt(1,60));
		#else
		setSelf(timeLeft,5);
		#endif

		callFuncParams(_usr,meSay,"подготавливает грядочку.");

		callSelfParams(startUpdateMethod,"onUpdate" arg "handleUpdate");
	};

endclass
