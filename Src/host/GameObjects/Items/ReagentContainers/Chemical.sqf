// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\..\engine.hpp>
#include <..\..\..\oop.hpp>
#include <..\..\GameConstants.hpp>

class(GlassLargeBreaker) extends(IGlassReagentCont)
	var(name,"Большой стакан");
	var(weight,gramm(350));
	var(size,ITEM_SIZE_SMALL);
	var(model,"relicta_models\models\interier\props\cup2.p3d");
	getterconst_func(transferAmount,[5 arg 10 arg 15 arg 25 arg 30 arg 60 arg 120]);
	var(reagents,vec2(this,120) call ms_create);
endclass

class(GlassLargeBowl) extends(IGlassReagentCont)
	var(name,"Миска для смешивания");
	var(desc,"Большая миска для смешивания");
	var(weight,gramm(400));
	var(size,ITEM_SIZE_SMALL);
	var(model,"relicta_models\models\interier\props\kitchen\bowl.p3d");
	var(reagents,vec2(this,180) call ms_create);
	getterconst_func(transferAmount,[5 arg 10 arg 15 arg 25 arg 30 arg 60 arg 180]);
endclass
	
	
class(ChemBowl) extends(IReagentNDItem)
	var(name,"Ступа");
	var(desc,"Древнейшее ручное приспособление для измельчения твердых мелких продуктов или их частиц.");
	var(model,"relicta_models\models\interier\props\kitchen\bowl.p3d");
	var(material,"MatWood");
	var(size,ITEM_SIZE_SMALL);
	var(weight,gramm(250));
	getterconst_func(transferAmount,[1 arg 2 arg 5]);
	var(reagents,vec2(this,15) call ms_create);
	
	func(onInteractWith)
	{
		objParams_2(_with,_usr);
		
		//base call
		callSuper(IReagentNDItem,onInteractWith);
		
		if !isTypeOf(_with,Pestik) exitWith {};
		if (callSelf(getFilledSpace) <= 0) exitWith {};
		
		// TODO stats check and dice check
		if prob(50) then {
			private _succ = " перемалывает содержимое";
			private _canReact = callSelfParams(processReaction,REACTION_GRIND);
			if (!_canReact) then {
				_succ = _succ + (pick[", но из этого не выходит ничего путного",", но ничего не происходит",", но безрезультатно"]);

			};	
			
			callFuncParams(_usr,worldSay,callFuncParams(_usr,getNameEx,"кто") + _succ arg "info");
		} else {
			private _fail = (pick[" безуспешно"," безрезультатно"," тщетно"]) + 
				pick[" пытается помолоть содержимое"," толочет содержимое"];
				
			callFuncParams(_usr,worldSay,callFuncParams(_usr,getNameEx,"кто") + _fail arg "info");
		};	
	};
	
endclass

class(Pestik) extends(Item)
	var(name,"Пестик");
	var(desc,"Вместе со ступой - одно целое!");
	var(weight,gramm(80));
	var(size,ITEM_SIZE_SMALL);
	var(model,"ml_shabut\akm\gasblock.p3d");
	var(material,"MatWood");
	
endclass