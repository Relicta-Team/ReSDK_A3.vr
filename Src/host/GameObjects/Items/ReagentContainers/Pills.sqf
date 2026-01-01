// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\..\engine.hpp>
#include <..\..\..\oop.hpp>
#include <..\..\..\text.hpp>
#include <..\..\GameConstants.hpp>

class(PillBox) extends(Item)
	var(name,"Коробка таблеток");
	var(model,"a3\structures_f_epa\items\medical\painkillers_f.p3d");
	var(material,"MatPaper");
	var(size,ITEM_SIZE_SMALL);
	var(weight,gramm(30));
	getter_func(objectHealthType,OBJECT_TYPE_COMPLEX);
	var(dr,1);

	getterconst_func(pillName,"Таблетка");
	getterconst_func(pillContent,[vec2("Nutriment",10)]newReagentsFood);
	var(pillCount,10);

	func(makePill)
	{
		objParams_1(_usr);
		if callFunc(_usr,isEmptyActiveHand) then {

			if (getSelf(pillCount) <= 0) exitWith {
				callFuncParams(_usr,localSay,"Пусто." arg "error");
			};

			private _pill = ["Pill",_usr,getVar(_usr,activeHand)] call createItemInInventory;
			if isNullReference(_pill) exitWith {};
			modSelf(pillCount, - 1);
			setVar(_pill,name,callSelf(pillName));
			setVar(_pill,reagents,callSelf(pillContent));
			callSelf(onWeightChanged);
		} else {
			callFuncParams(_usr,localSay,"Руку надо освободить." arg "error");
		};
	};

	func(getDescFor)
	{
		objParams_1(_usr);
		super() + sbr + ifcheck(
			getSelf(pillCount) > 0,
			format
			vec2(
				"Там осталось ещё %1",vec3(
					getSelf(pillCount),
					vec3("таблетка","таблетки","таблеток"),true
				) call toNumeralString),"Внутри пусто.");
	};

	func(getWeight)
	{
		objParams();
		super() + (getSelf(pillCount) * gramm(2));
	};
	getter_func(getMainActionName,"Вытащить");
	func(onMainAction)
	{
		objParams_1(_usr);
		callSelfParams(makePill,_usr);
	};
endclass

class(PillBoxSmall) extends(PillBox)
	var(pillCount,5);
	var(model,"a3\structures_f_epa\items\medical\antibiotic_f.p3d");
endclass

class(PainkillerBox) extends(PillBox)
	var(name,"Коробка обезболивающего");
	var(desc,"Сильное обезболивающее в таблетках.");
	getterconst_func(pillContent,[vec2("Tamidin",10)]newReagentsFood);
endclass

class(CetalinBox) extends(PillBox)
	var(name,"Цеталин");
	var(desc,"Временно приглушает боль.");
	getterconst_func(pillContent,[vec2("Cetalin",10)]newReagentsFood);
endclass

class(KoradizinBox) extends(PillBoxSmall)
	var(name,"Корадизин");
	var(desc,"Останавливает кровотечение.");
	getterconst_func(pillContent,[vec2("Koradizin",15)]newReagentsFood);
endclass
