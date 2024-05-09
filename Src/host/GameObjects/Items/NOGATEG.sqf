// ======================================================
// Copyright (c) 2017-2024 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include "..\..\engine.hpp"
#include "..\..\oop.hpp"
#include <..\GameConstants.hpp>

	
	
	//reagent container.sqf
	
	
	
	
	
	//medical
	

	
	class(IReagentItemBag) extends(IReagentNDItem)
		var(reagents,vec2(this,120) call ms_create);
		getterconst_func(transferAmount,[0.2 arg 1 arg 2]);
		var(model,"a3\structures_f_epa\items\medical\bloodbag_f.p3d");
	endclass
	
	class(BloodPack) extends(IReagentItemBag)
		var(name,"Пакет крови");
	endclass
	
	class(IVBag) extends(IReagentItemBag)
		//for empty: "a3\props_f_orange\humanitarian\camps\intravenbag_01_empty_f.p3d"
		var(model,"a3\props_f_orange\humanitarian\camps\intravenbag_01_full_f.p3d");
		var(name,"Пакет для внутреннего переливания");
	endclass
	
	// instruments
	
	class(ChemBowl) extends(IReagentNDItem)
		var(name,"Ступа");
		var(desc,"Древнейшее ручное приспособление для измельчения твердых мелких продуктов или их частиц.");
		var(model,"relicta_models\models\interier\props\kitchen\bowl.p3d");
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
		
	endclass
	
	
	
	//kastuls:
	//"relicta_models\models\interier\props\kitchen\kastryla.p3d"
	//"relicta_models\models\interier\props\kitchen\kastrula.p3d"
	//"ml\ml_object_new\model_05\kostrulya.p3d"
	
	//glass
	
	
	

	
	
	//chemical
	
	
	// chem
	
	
	class(IGlassReagentCont) extends(IReagentNDItem)
		getterconst_func(transferAmount,[5 arg 10 arg 15 arg 25 arg 30 arg 60]);
	endclass
	
	class(GlassLargeBreaker) extends(IGlassReagentCont)
		var(name,"Большой стакан");
		var(weight,gramm(350));
		var(size,ITEM_SIZE_MEDIUM);
		var(model,"relicta_models\models\interier\props\cup2.p3d");
		getterconst_func(transferAmount,[5 arg 10 arg 15 arg 25 arg 30 arg 60 arg 120]);
		var(reagents,vec2(this,120) call ms_create);
	endclass
	
	class(GlassLargeBowl) extends(IGlassReagentCont)
		var(name,"Миска для смешивания");
		var(desc,"Большая миска для смешивания");
		var(weight,gramm(400));
		var(size,ITEM_SIZE_MEDIUM);
		var(model,"relicta_models\models\interier\props\kitchen\bowl.p3d");
		var(reagents,vec2(this,180) call ms_create);
		getterconst_func(transferAmount,[5 arg 10 arg 15 arg 25 arg 30 arg 60 arg 180]);
	endclass
	
	

	
	class(Bucket) extends(IGlassReagentCont)
		var(name,"Ведро");
		var(allowedSlots,[INV_HEAD]);
		var(model,"ca\structures\furniture\decoration\bucket\bucket.p3d");
		var(reagents,vec2(this,180) call ms_create);
		var(size,ITEM_SIZE_LARGE);
		getter_func(getHandAnim,ITEM_HANDANIM_LOWER);
		getterconst_func(transferAmount,[10 arg 20 arg 30 arg 60 arg 120 arg 150 arg 180]);
	
		func(onEquip) {
			objParams_1(_usr);
			callSuper(IGlassReagentCont,onEquip);
			callFuncParams(_usr,changeVisionBlock,+1 arg "itmeq");
		};
		func(onUnequip) {
			objParams_1(_usr);
			callSuper(IGlassReagentCont,onUnequip);
			callFuncParams(_usr,changeVisionBlock,-1 arg "itmuneq");
		};
	endclass
	
	class(WoodenBucket) extends(Bucket)
		var(desc,"Деревянное ведро");
		var(model,"ca\structures_e\misc\misc_interier\bucket_ep1.p3d");
		var(reagents,vec2(this,200) call ms_create);
	endclass

	class(Canister) extends(IGlassReagentCont)
		var(name,"Канистра");
		var(weight,gramm(5000));
		var(model,"ml\ml_object_new\model_14_10\benzin.p3d");
		var(reagents,vec2(this,1000) call ms_create);
	endclass

