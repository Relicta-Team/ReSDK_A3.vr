// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\..\engine.hpp>
#include <..\..\..\oop.hpp>
#include <..\..\..\text.hpp>
#include <..\..\GameConstants.hpp>

class(IGlassReagentItem) extends(IReagentNDItem)
	var(name,"Стеклянная емкость");
	getter_func(canBreakOnDrop,prob(50));
	func(onDrop)
	{
		objParams_1(_usr);
		if callSelf(canBreakOnDrop) then {
			callSelfParams(playSound,"UNCATEGORIZED\glass_break" + str randInt(1,3) arg getRandomPitch);
			callSelfParams(worldSay,callSelf(getName) + " разбивается." arg "info");
			delete(this);
		} else {
			callSuper(IReagentNDItem,onDrop);
		};
	};
endclass

class(IGlassReagentCont) extends(IReagentNDItem)
	var(material,"MatGlass");
	var(dr,0);
	getterconst_func(transferAmount,[5 arg 10 arg 15 arg 25 arg 30 arg 60]);
endclass

class(GlassBottle) extends(IGlassReagentItem)
	var(name,"Стеклянная бутылка");
	//var(model,"ml\ml_object_new\model_14_10\bottledef.p3d"); //nogeom
	var(model,"relicta_models\models\interier\props\kitchen\buhlo1.p3d");
	var(material,"MatGlass");
	var(hp,1);
	var(weight,gramm(350));
	var(size,ITEM_SIZE_SMALL);
	var(reagents,vec2(this,60) call ms_create);
	getterconst_func(transferAmount,[5 arg 10 arg 15 arg 25 arg 30 arg 60]);
	editor_attribute("EditorVisible" arg "type:string") editor_attribute("Tooltip" arg "Подписанное имя бутылки")
	editor_attribute("alias" arg "Имя бутылки")
	var_str(bottleName); //подписанное название
	
	getter_func(getDropSound,"dropping\drop_glass");
	getter_func(getPickupSound,"updown\bottle_up");
	getter_func(getPutdownSound,"updown\bottle_up");
	
	func(getName)
	{
		objParams();
		private _txt = callSuper(IGlassReagentItem,getName);
		if (_txt != "" && getSelf(bottleName) != "") then {_txt = format["Бутылка ""%1""",getSelf(bottleName)];};
		_txt
	};
	
	func(getDescFor)
	{
		objParams_1(_usr);
		private _txt = callSuper(IGlassReagentItem,getDescFor);
		if (getSelf(bottleName) != "") then {
			_txt = _txt + sbr + format["Подписана как ""%1""",getSelf(bottleName)];
		};
		_txt
	};
	

	
endclass

class(MilkBottle) extends(GlassBottle)
	var(bottleName,"Молоко");
	getterconst_func(contentReagents,[vec2("Milk",60)]);
	
endclass

class(SpirtBottle) extends(GlassBottle)
	var(bottleName,"Грибная брага");
	getterconst_func(contentReagents,[vec2("Spirt",45) arg vec2("Nutriment",15)]);
endclass

class(PerfumeBottle) extends(GlassBottle)
	var(model,"relicta_models\models\interier\props\treasure\perfume\perfume.p3d");
	var(bottleName,"Духи");
	getterconst_func(contentReagents,[vec2("Spirt",45) arg vec2("Nutriment",15)]);
endclass



// cups
class(GlassGoblet) extends(IGlassReagentItem)
	var(name,"Стеклянный бокал");
	var(model,"relicta_models\models\interier\props\kitchen\vinecup.p3d");
	var(size,ITEM_SIZE_SMALL);
	var(weight,gramm(200));
	var(material,"MatGlass");
	
	var(reagents,vec2(this,30) call ms_create);
	getterconst_func(transferAmount,[2 arg 5 arg 10 arg 20 arg 30]);
endclass

class(Mug) extends(GlassGoblet)
	var(name,"Кружка");
	var(weight,gramm(130));
	var(model,"ml_shabut\exoduss\chashechka.p3d");
endclass