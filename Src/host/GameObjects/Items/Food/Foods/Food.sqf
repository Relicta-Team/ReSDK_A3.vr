// ======================================================
// Copyright (c) 2017-2024 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\..\..\engine.hpp>
#include <..\..\..\..\oop.hpp>
#include <..\..\..\GameConstants.hpp>

editor_attribute("InterfaceClass")
class(IFoodItem) extends(Item)
	var(material,"MatOrganic");
	#include "..\..\..\Interfaces\IReagentContainer.Interface"
	
	/*
	Вся поглощённая пища отправляется в желудок и переваривается за assimilateAfter сек
	После переваривания она отправляется в холдер реагентов и усвивается

	*/
	attributeParams(hasField,"assimilateTime")
	getterconst_func(isFood,true);

	var(name,"Еда");
	var(icon,invicon(food_base));
	getter_func(getPickupSound,"updown\herb_drop");
	getter_func(getPutdownSound,"updown\herb_drop");
	getter_func(getDropSound,"updown\herb_drop");

	getterconst_func(getBiteSize,5); //сколько отнимается за укус. Если null то весь объект перемещается в желудок

	var(size,ITEM_SIZE_SMALL);

	getter_func(canEat,true); //пользовательское условие можно ли съесть
	//вызовется если нельзя съесть
	func(onCantEatReason)
	{
		objParams_1(_usr);
	};

	//скорость усвоения работает только для предметов без реагентов (таблетки)
	getterconst_func(assimilateAfter,5); //один укус усвоится за столько секунд
	var(assimilateTime,0); //эта переменная автоматически устанавливается в tickTime + callSelf(assimilateAfter)

	//вызывается по таймеру через assimilateAfter сек
	func(onAssimilate)
	{
		objParams_1(_usr);
	};

	var(reagents,[]newReagents); //какие реагенты добавятся при укусе

	getter_func(onBitesRanOut,delete(this)); //событие вызывается когда куски закончились



endclass


class(Pill) extends(IFoodItem)
	var(name,"Таблетка");
	var(model,"relicta_models\models\medical\tablet1.p3d");
	getterconst_func(assimilateAfter,randInt(5,10));
	//probably other model can be: "relicta_models\models\medical\tablet2.p3d"
	getterconst_func(getBiteSize,null);
	var(weight,gramm(2));
	var(size,ITEM_SIZE_TINY);
endclass

class(Testo) extends(IFoodItem)
	var(name,"Тесто");
	var(model,"relicta_models2\food\s_dough\s_dough.p3d");
	var(weight,gramm(200));
	var(size,ITEM_SIZE_SMALL);
endclass

class(Lapsha) extends(Testo)
	var(name,"Лапша");
	var(model,"relicta_models2\food\s_noodle\s_noodle.p3d");
	var(reagents,[vec2("Nutriment",5)]newReagentsFood);
endclass

class(Lepeshka) extends(Testo)
	var(name,"Лепёшка");
	var(model,"relicta_models2\food\s_tortilla\s_tortilla.p3d");
	var(reagents,[vec2("Nutriment",12)]newReagentsFood);
	var(size,ITEM_SIZE_TINY);
endclass

class(GribChopped) extends(IFoodItem)
	var(name,"Нарезанные грибы");
	var(model,"metro_ob\model\shamp.p3d");
	var(reagents,[]newReagentsFood);
	var(weight,gramm(50));
endclass

class(Meat) extends(IFoodItem)
	var(name,"Мясо");
	var(model,"ml\ml_object_new\model_24\okorok.p3d");
	var(size,ITEM_SIZE_MEDIUM);
	var(weight,rand(gramm(800),gramm(850)));
	var(reagents,[vec2("Nutriment",140)]newReagentsFood);
	getterconst_func(getBiteSize,30);

	func(onInteractWith)
	{
		objParams_2(_with,_usr);
		if isTypeOf(_with,Knife) exitWith {
			if callSelf(isInWorld) then {
				private _pos = getPosAtl getSelf(loc);
				private _weight = getSelf(weight);
				private _count = randInt(1,3);
				private _wperitem = _weight / (_count);
				private _itm = null;
				delete(this);
				for "_i" from 1 to _count do {
					_itm = ["MeatChopped",_pos,null,false] call createItemInWorld;
					setVar(_itm,weight,_wperitem);
				};
			} else {
				callFuncParams(_usr,localSay,"В руках резать не удобно..." arg "mind");
			};
		};
	};

endclass

class(MeatChopped) extends(IFoodItem)
	var(name,"Кусок мяса");
	var(model,"relicta_models2\food\s_meat_peice\s_meat_peice.p3d"); //or "ml_exodusnew\becondry.p3d"
	var(weight,gramm(300));
	var(size,ITEM_SIZE_SMALL);
	var(reagents,[vec2("Nutriment",45)]newReagentsFood);
	getterconst_func(getBiteSize,10);
endclass

class(MeatMinced) extends(MeatChopped)
	var(name,"Фарш");
	var(model,"relicta_models2\food\s_minced_meat\s_minced_meat.p3d");
	var(reagents,[vec2("Nutriment",10)]newReagentsFood);
endclass

class(Cutlet) extends(MeatMinced)
	var(name,"Котлетка");
	var(model,"relicta_models2\food\s_cutlet\s_cutlet.p3d");
	var(weight,gramm(150));
	var(reagents,[vec2("Nutriment",15)]newReagentsFood);
endclass

class(Bun) extends(IFoodItem)
	var(name,"Пирожок");
	var(desc,"Это маленький пирожок. В простонародье их называют ""Бибки"" видимо из-за их причудливой формы и схожести с каким-то органом.");
	var(model,"relicta_models\models\anatomy\xyu.p3d");
	var(size,ITEM_SIZE_SMALL);
	var(weight,gramm(80));
	var(reagents,[vec2("Nutriment",10)]newReagentsFood);
endclass

class(Pancakes) extends(IFoodItem)
	var(name,"Блинцы");
	var(model,"relicta_models2\food\s_pancakes\s_pancakes.p3d");
	var(size,ITEM_SIZE_SMALL);
	var(weight,gramm(130));
	var(reagents,[vec2("Nutriment",30)]newReagentsFood);
endclass

class(Omlet) extends(IFoodItem)
	var(name,"Омлетик");
	var(model,"relicta_models2\food\s_omlette\s_omlette.p3d");
	var(size,ITEM_SIZE_SMALL);
	var(weight,gramm(randInt(60,90)));
	getterconst_func(getBiteSize,10);
	var(reagents,[vec2("Nutriment",40)]newReagentsFood);
endclass

class(Butter) extends(IFoodItem)
	var(name,"Брикет масла");
	var(desc,"На масло слабо похоже...");
	//var(model,"a3\props_f_enoch\military\decontamination\sponge_01_f.p3d");
	var(model,"Sponge_01_Wet_F");
	var(size,ITEM_SIZE_SMALL);
	var(weight,gramm(200));
	var(reagents,[vec2("Nutriment",10)]newReagentsFood);
	var(count,5);

	func(onInteractWith)
	{
		objParams_2(_with,_usr);
		if isTypeOf(_with,Knife) exitWith {
			if (!callFunc(this,isInWorld)) exitWith {};

			private _perPieceWeight = gramm(200) / 5;
			callSelfParams(removeReagents,2);
			setSelf(weight,getSelf(count) * _perPieceWeight);
			private _itm = ["ButterPiece",getPosATL getSelf(loc),null,false] call createItemInWorld;

			modSelf(count, - 1);

			if (getSelf(count) == 0) exitWith {
				delete(this);
			};
		};
		callSuper(IFoodItem,onInteractWith);
	};
endclass

class(ButterPiece) extends(IFoodItem)
	var(name,"Кусочек масла");
	var(model,"relicta_models2\food\s_butter_piece\s_butter_piece.p3d");
	var(weight,gramm(40));
	var(size,ITEM_SIZE_TINY);
	var(reagents,[vec2("Nutriment",2)]newReagentsFood);
endclass

class(Muka) extends(Item)
	var(name,"Мука");
	var(material,"MatOrganic");
	var(desc,"Обозначения на пачке вряд-ли скажут о её содержимом.");
	var(model,"ml_shabut\sovokgoods\risochek.p3d");
	var(size,ITEM_SIZE_MEDIUM);
	var(weight,gramm(80));
	var(count,5);

	func(onInteractWith)
	{
		objParams_2(_with,_usr);
		if (callFunc(_with,isReagentContainer)) then {
			if !callSelf(isInWorld) exitWith {
				callFuncParams(_usr,localSay,"Неудобно. Надо муку положить." arg "error");
			};
			callFunc(_with,getMasterReagent) params ["_reag","_amount"];
			if (_reag == "Milk" && _amount >= 10) then {
				private _listReagTransf = callFuncParams(_with,removeReagentsAndReturn,10);
				private _item = ["Testo",getPosATL getSelf(loc),null,false] call createItemInWorld;
				{
					if (_x select 0 == "Milk") then {
						callFuncParams(_item,addReagent,"Nutriment" arg _x select 1);
					} else {
						callFuncParams(_item,addReagent,_x select 0 arg _x select 1);
					};
				} forEach _listReagTransf;

				modSelf(count, - 1);
				if (getSelf(count) == 0) then {
					delete(this);
				};
			} else {
				callFuncParams(_usr,localSay,"Маловато молочка будет." arg "error");
			};
		};
	};

endclass

class(Bread) extends(IFoodItem)
	var(name,"Хлеб");
	var(desc,"Хлеб - наша еда!");
	var(model,"ml\ml_object_new\model_05\hleb.p3d");
	var(size,ITEM_SIZE_MEDIUM);
	var(weight,gramm(300));
	var(reagents,[vec2("Nutriment",25)]newReagentsFood);

	func(onInteractWith)
	{
		objParams_2(_with,_usr);
		if isTypeOf(_with,Knife) exitWith {
			if callSelf(isInWorld) then {
				private _pos = getPosAtl getSelf(loc);
				private _weight = getSelf(weight);
				private _count = randInt(6,10);
				private _wperitem = _weight / (_count);
				private _itm = null;
				delete(this);
				for "_i" from 1 to _count do {
					_itm = ["BreadChopped",_pos vectoradd [rand(-0.01,0.01),rand(-0.01,0.01),rand(-0.001,0.001)],null,false] call createItemInWorld;
					setVar(_itm,weight,_wperitem);
				};
			} else {
				callFuncParams(_usr,localSay,"В руках резать не удобно..." arg "mind");
			};
		};
	};

endclass

class(BreadChopped) extends(IFoodItem)
	var(name,"Кусок хлеба");
	var(model,"relicta_models2\food\s_bread\s_bread.p3d");
	var(weight,gramm(300));
	var(size,ITEM_SIZE_SMALL);
	var(reagents,[vec2("Nutriment",4)]newReagentsFood);
	func(getBiteSize)
	{
		objParams();
		if getSelf(isCrafted) exitWith {5};
	};
	var(isCrafted,false);

	func(onInteractWith)
	{
		objParams_2(_with,_usr);
		private _anonSetCrafted = {
			setSelf(isCrafted,true);
			setSelf(weight,getVar(_with,weight));
			delete(_with);
		};
		private _cls = callFunc(_with,getClassName);
		if (equals(_cls,"ButterPiece") && !getSelf(isCrafted)) exitWith {
			call _anonSetCrafted;
			setSelf(name,"Бутер с маслом");
			callSelfParams(setModel,"relicta_models2\food\s_sandwich\s_sandwich.p3d");
			callSelfParams(addReagent,"Nutriment" arg 30);
		};
		if (equals(_cls,"Cutlet") && !getSelf(isCrafted)) exitWith {
			call _anonSetCrafted;
			setSelf(name,"Бутер ""по-калековски""");
			callSelfParams(addReagent,"Nutriment" arg 45);
		};
	};

endclass

class(Tea) extends(IFoodItem)
	var(name,"Чай");
	var(model,"ml_exodusnew\becondry.p3d");
	var(weight,gramm(10));
endclass

class(TeaPacket) extends(Item)
	var(name,"Коробка чая");
	var(model,"ml_shabut\tzai\tzai.p3d");
	var(weight,gramm(400));
	var(size,ITEM_SIZE_MEDIUM);
endclass

class(Egg) extends(IFoodItem)
	var(name,"Яичко");
	var(weight,gramm(730));
	var(model,"relicta_models\models\mushroom\egg.p3d");
	var(reagents,[vec2("Nutriment",15)]newReagentsFood);
endclass

//salt sugar etc
class(SaltShaker) extends(IFoodItem)
	var(name,"Соль");
	var(desc,"Маленькая баночка.");
	var(model,"relicta_models2\food\s_salt\s_salt.p3d");

	var(size,ITEM_SIZE_TINY);
	var(weight,gramm(70));

	var(reagents,[vec2("Salt",30)]newReagentsFood);
	getterconst_func(getBiteSize,2);
	getter_func(canEat,callSelf(getFilledSpace) > 0);
	func(onCantEatReason)
	{
		objParams_1(_usr);
		callFuncParams(_usr,mindSay,"Там пусто");
	};
	func(onBitesRanOut)
	{
		objParams();
	};

	func(getDesc)
	{
		objParams();
		private _mes = " Заполнена.";
		private _space = callSelf(getFilledSpace);
		if (_space <= 15) then {_mes = " В ней ещё есть половина чего-то!"};
		if (_space > 0 && _space < 5) then {_mes = " Она почти пустая."};
		if (_space == 0) then {_mes = ".. и к тому-же абсолютно пустая."};

		callSuper(IFoodItem,getDesc) + _mes;
	};

endclass

class(SugarShaker) extends(SaltShaker)
	var(name,"Сахар");
	var(reagents,[vec2("Sugar",30)]newReagentsFood);
endclass

class(PepperShaker) extends(SaltShaker)
	var(name,"Перец");
	var(model,"relicta_models2\food\s_pepper\s_pepper.p3d");
	var(reagents,[vec2("Pepper",30)]newReagentsFood);
endclass

//печка
class(Melteshonok) extends(IFoodItem)
	var(name,"Мельтешонок");
	var(model,"relicta_models\models\mutants\rat\rat1.p3d");
	getterconst_func(getBiteSize,8);
	var(reagents,[vec2("Nutriment",24)]newReagentsFood);

	var(size,ITEM_SIZE_MEDIUM);
	var(weight,2.7);
endclass

class(Shavirma) extends(IFoodItem)
	var(name,"Шавирма");
	var(model,"ml_exodusnew\beconfried.p3d");
	var(reagents,[[vec2("Nutriment",40)] arg 100]newReagents);

	var(weight,1.1);
endclass

class(Pie) extends(IFoodItem)
	var(name,"Пирог");
	var(model,"relicta_models2\food\s_pie\s_pie.p3d");
	var(size,ITEM_SIZE_MEDIUM);
	var(weight,gramm(randInt(600,700)));
	var(reagents,[[vec2("Nutriment",50)] arg 100]newReagents);

	var_bool(__isLockedByPiecing);
	func(canPickup)
	{
		objParams();
		callSuper(IFoodItem,canPickup) && !getSelf(__isLockedByPiecing);
	};

	func(onInteractWith)
	{
		objParams_2(_with,_usr);
		if isTypeOf(_with,Knife) exitWith {
			if callSelf(isInWorld) then {

				//safe cant pickup
				setSelf(__isLockedByPiecing,true);

				private _pos = getPosAtl getSelf(loc);
				private _weight = getSelf(weight);
				private _count = randInt(7,10);
				private _wperitem = _weight / (_count);
				private _itm = null;

				//transfering reagents
				private _reagentsPerItem = callSelf(getFilledSpace) / _count;
				assert(!isNullVar(_reagentsPerItem));
				for "_i" from 1 to _count do {
					_itm = ["PiePiece",_pos vectorAdd [rand(-0.01,0.01),rand(-0.01,0.01),rand(-0.001,0.001)],null,false] call createItemInWorld;
					setVar(_itm,weight,_wperitem);
					private _reagents = vec2(_itm,_reagentsPerItem) call ms_create;
					setVar(_itm,reagents,_reagents);
					callSelfParams(transferReagents,_itm arg _reagentsPerItem);
				};


				delete(this);
			} else {
				callFuncParams(_usr,localSay,"В руках резать не удобно..." arg "mind");
			};
		};
	};
endclass

editor_attribute("InterfaceClass")
class(PiePiece) extends(IFoodItem)
	var(name,"Кусок пирога");
	var(model,"relicta_models2\food\s_pie_piece\s_pie_piece.p3d");
	var(size,ITEM_SIZE_SMALL);
	var(weight,gramm(150));
	var(reagents,null); //created only from pie

endclass


/// NON EATABLE
class(Poo) extends(IFoodItem)
	var(name,pick["Шоколадка" arg "Сладенькое" arg "Шмат говна" arg "Говнище" arg "Коричневая пуля" arg "Г.О.В.Н.О" arg "Тёплый поезд"]);
	var(model,"relicta_models\models\anatomy\gavno.p3d");
	var(size,ITEM_SIZE_SMALL);
	var(weight,gramm(randInt(6,20)));
	var(reagents,[vec2("Nutriment",5)]newReagentsFood);
endclass
