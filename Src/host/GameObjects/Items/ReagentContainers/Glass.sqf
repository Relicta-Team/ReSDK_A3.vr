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

//Пустые бутылки
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

class(GlassBottle1) extends(GlassBottle)
	var(model,"relicta_models\models\interier\props\kitchen\buhlo2.p3d");
	var(weight,gramm(350));
	var(reagents,vec2(this,50) call ms_create);
endclass

class(GlassBottle2) extends(GlassBottle)
	var(model,"relicta_models\models\interier\props\kitchen\buhlo3.p3d");
	var(weight,gramm(450));
	var(reagents,vec2(this,75) call ms_create);
endclass

class(GlassBottle3) extends(GlassBottle)
	var(model,"relicta_models\models\interier\props\kitchen\buhlo4.p3d");
	var(weight,gramm(850));
	var(size,ITEM_SIZE_MEDIUM);
	var(reagents,vec2(this,150) call ms_create);
endclass

class(GlassBottle4) extends(GlassBottle)
	var(model,"sterben_top\am_items_2\misc\food\beerbottle\beerbottle.p3d");
	var(weight,gramm(350));
	var(reagents,vec2(this,60) call ms_create);
endclass

class(GlassBottle5) extends(GlassBottle)
	var(model,"sterben_top\am_items\misc\food\scotch\tequila.p3d");
	var(weight,gramm(450));
	var(reagents,vec2(this,70) call ms_create);
endclass

//Пустые бутылки (требуется ретекстур, настройка геометрии и позиции в руках, скрыты в редакторе)
class(GlassBottle6) extends(GlassBottle)
	var(model,"ml\ml_object_new\model_14_10\bottlehz.p3d");
	var(weight,gramm(450));
	var(reagents,vec2(this,75) call ms_create);
endclass

class(GlassBottle7) extends(GlassBottle)
	var(model,"ml\ml_object_new\model_14_10\bottlevine.p3d");
	var(weight,gramm(450));
	var(reagents,vec2(this,75) call ms_create);
endclass

class(GlassBottle8) extends(GlassBottle)
	var(model,"ml\ml_object_new\model_14_10\bottlepoison.p3d");
	var(weight,gramm(500));
	var(reagents,vec2(this,70) call ms_create);
endclass

class(GlassBottle9) extends(GlassBottle)
	var(model,"ml\ml_object_new\model_14_10\ratpoison.p3d");
	var(weight,gramm(350));
	var(reagents,vec2(this,50) call ms_create);
endclass

class(GlassBottle10) extends(GlassBottle)
	var(model,"sterben_top\am_items\misc\food\scotch\scotch.p3d");
	var(weight,gramm(500));
	var(reagents,vec2(this,75) call ms_create);
endclass

class(GlassBottle11) extends(GlassBottle)
	var(model,"sterben_top\am_items\misc\food\whiskeybottle01\whiskeybottle01.p3d");
	var(weight,gramm(350));
	var(reagents,vec2(this,50) call ms_create);
endclass

class(GlassBottle12) extends(GlassBottle)
	var(model,"sterben_top\am_items\misc\food\scotch_new\am_scotch_new.p3d");
	var(weight,gramm(400));
	var(reagents,vec2(this,60) call ms_create);
endclass

class(GlassBottle13) extends(GlassBottle)
	var(model,"sterben_top\am_items\misc\food\scotch_old\am_scotch_old.p3d");
	var(weight,gramm(400));
	var(reagents,vec2(this,60) call ms_create);	
endclass

class(GlassBottle14) extends(GlassBottle)
	var(model,"sterben_top\am_items\misc\food\wine\am_wine.p3d");
	var(weight,gramm(450));
	var(reagents,vec2(this,75) call ms_create);	
endclass

class(GlassBottle15) extends(GlassBottle)
	var(model,"sterben_top\am_items\misc\food\moonshinejug\moonshinejug.p3d");
	var(weight,gramm(2500));
	var(reagents,vec2(this,350) call ms_create);
endclass

//Молоко
class(MilkBottle) extends(GlassBottle)
	var(bottleName,"Молоко");
	getterconst_func(contentReagents,[vec2("Milk",60)]);
endclass

class(MilkBottle2) extends(MilkBottle)
	var(model,"sterben_top\am_items_2\misc\food\milkbottle.p3d");
	var(icon,"gen\relicta_models+models+interier+props+kitchen+buhlo1+p3d");
endclass

//Бутылки с алкоголем
class(SpirtBottle) extends(GlassBottle)
	var(bottleName,"Грибная брага");
	getterconst_func(contentReagents,[vec2("Spirt",45) arg vec2("Nutriment",15)]);
endclass

class(SpirtBottle1) extends(GlassBottle1)
	var(bottleName,"Грибная брага");
	getterconst_func(contentReagents,[vec2("Spirt",35) arg vec2("Nutriment",15)]);
endclass

class(SpirtBottle2) extends(GlassBottle2)
	var(bottleName,"Грибная брага");
	getterconst_func(contentReagents,[vec2("Spirt",60) arg vec2("Nutriment",15)]);
endclass

class(SpirtBottle3) extends(GlassBottle3)
	var(bottleName,"Грибная брага");
	getterconst_func(contentReagents,[vec2("Spirt",135) arg vec2("Nutriment",15)]);
endclass

class(SpirtBottle4) extends(GlassBottle4)
	var(bottleName,"Грибная брага");
	getterconst_func(contentReagents,[vec2("Spirt",45) arg vec2("Nutriment",15)]);
endclass

class(SpirtBottle5) extends(GlassBottle5)
	var(bottleName,"Грибная брага");
	getterconst_func(contentReagents,[vec2("Spirt",55) arg vec2("Nutriment",15)]);
endclass

//Бутылки с алкоголем (требуется ретекстур, настройка геометрии и позиции в руках, скрыты в редакторе)
class(SpirtBottle6) extends(GlassBottle6)
	var(bottleName,"Грибная брага");
	getterconst_func(contentReagents,[vec2("Spirt",60) arg vec2("Nutriment",15)]);
endclass

class(SpirtBottle7) extends(GlassBottle7)
	var(bottleName,"Грибная брага");
	getterconst_func(contentReagents,[vec2("Spirt",60) arg vec2("Nutriment",15)]);
endclass

class(SpirtBottle8) extends(GlassBottle8)
	var(bottleName,"Грибная брага");
	getterconst_func(contentReagents,[vec2("Spirt",55) arg vec2("Nutriment",15)]);
endclass

class(SpirtBottle9) extends(GlassBottle9)
	var(bottleName,"Грибная брага");
	getterconst_func(contentReagents,[vec2("Spirt",35) arg vec2("Nutriment",15)]);
endclass

class(SpirtBottle10) extends(GlassBottle10)
	var(bottleName,"Грибная брага");
	getterconst_func(contentReagents,[vec2("Spirt",60) arg vec2("Nutriment",15)]);
endclass

class(SpirtBottle11) extends(GlassBottle11)
	var(bottleName,"Грибная брага");
	getterconst_func(contentReagents,[vec2("Spirt",35) arg vec2("Nutriment",15)]);
endclass

class(SpirtBottle12) extends(GlassBottle12)
	var(bottleName,"Грибная брага");
	getterconst_func(contentReagents,[vec2("Spirt",45) arg vec2("Nutriment",15)]);
endclass

class(SpirtBottle13) extends(GlassBottle13)
	var(bottleName,"Грибная брага");
	getterconst_func(contentReagents,[vec2("Spirt",45) arg vec2("Nutriment",15)]);
endclass

class(SpirtBottle14) extends(GlassBottle14)
	var(bottleName,"Грибная брага");
	getterconst_func(contentReagents,[vec2("Spirt",60) arg vec2("Nutriment",15)]);
endclass

class(SpirtBottle15) extends(GlassBottle15)
	var(bottleName,"Грибная брага");
	getterconst_func(contentReagents,[vec2("Spirt",335) arg vec2("Nutriment",15)]);
endclass

//Флакон с духами
class(PerfumeBottle) extends(GlassBottle)
	var(model,"relicta_models\models\interier\props\treasure\perfume\perfume.p3d");
	var(bottleName,"Духи");
	getterconst_func(contentReagents,[vec2("Spirt",45) arg vec2("Nutriment",15)]);
endclass

//Кружки и бокалы
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