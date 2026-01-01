// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\..\..\engine.hpp>
#include <..\..\..\..\oop.hpp>
#include <..\..\..\GameConstants.hpp>

class(Mushroom) extends(IFoodItem)

	//getter_func(getDropSound,"dropping\keydrop");
	getter_func(getPickupSound,"updown\itm_ingredient_mushroom_up_0" + str randInt(1,4));
	//getter_func(getPutdownSound,"updown\keyring_up");
endclass

class(Slimehat) extends(Mushroom)
	var(name,"Слизнешляпик");
	var(model,"relicta_models\models\mushroom\kislyak.p3d");
	var(reagents,[vec2("Alvitin",randInt(5,25))]newReagentsFood);
	getterconst_func(getBiteSize,5);
	var(icon,invicon(mush_base));
	var(size,ITEM_SIZE_MEDIUM);
	var(weight,gramm(400));
endclass

class(Meatflower) extends(Slimehat)
	var(name,"Мясной цветок");
	var(model,"relicta_models\models\mushroom\meatgrib.p3d");
	var(reagents,[vec2("Kenazin",randInt(5,17)) arg vec2("Nutriment",randInt(5,8))]newReagentsFood);
	var(size,ITEM_SIZE_HUGE);
	var(weight,1.2);
endclass

class(Blevanton) extends(Slimehat)
	var(name,"Блевантон");
	var(model,"relicta_models\models\mushroom\blevanton1v2.p3d");
	var(reagents,[vec2("Askadiy",randInt(5,20)) arg vec2("Nutriment",randInt(0,5))]newReagentsFood);
	var(size,ITEM_SIZE_MEDIUM);
	var(weight,gramm(800));
endclass

class(Gnilokornik) extends(Slimehat)
	var(name,"Гнилокорник");
	var(model,"relicta_models\models\mushroom\bliznecolor.p3d");
	var(reagents,[vec2("Opirin",randInt(5,25))]newReagentsFood);
	var(size,ITEM_SIZE_BIG);
	var(weight,1.3);
endclass

class(Zhivoglot) extends(Slimehat)
	var(name,"Живоглот");
	var(model,"ml_shabut\mushrooms\grib5.p3d");
	var(reagents,[vec2("Nutriment",randInt(5,25))]newReagentsFood);
	var(size,ITEM_SIZE_MEDIUM);
	var(weight,gramm(800));
endclass

class(Yaichnik) extends(Slimehat)
	var(name,"Яичник");
	var(model,"relicta_models\models\mushroom\blevanton2v2.p3d");
	var(reagents,[vec2("Nutriment",randInt(5,25))]newReagentsFood);
	var(size,ITEM_SIZE_MEDIUM);
	var(weight,gramm(900));
endclass

class(Svetlolik) extends(Slimehat)
	var(name,"Светлолик");
	var(model,"relicta_models\models\mushroom\mushroom1.p3d");
	var(reagents,[vec2("Metaficin",randInt(5,10)) arg vec2("Nutriment",randInt(5,10))]newReagentsFood);
	var(weight,gramm(600));
endclass


class(Tumannik) extends(Slimehat)
	var(name,"Туманник");
	var(model,"relicta_models\models\mushroom\kislyak.p3d");
	var(reagents,[vec2("Ipamitin",randInt(10,25))]newReagentsFood);
	getterconst_func(getBiteSize,5);
	var(icon,invicon(mush_base));
	var(size,ITEM_SIZE_MEDIUM);
	var(weight,gramm(600));
endclass

/// kitchen
/*class(BakedPotato) extends(Slimehat)
	var(name,"""Пичоная картошичка""");
	var(desc,"А что такое ""картошичка""?!...");
	var(model,"relicta_models\models\mushroom\temnolik.p3d");
endclass*/