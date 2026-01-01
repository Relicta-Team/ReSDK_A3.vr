// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\..\engine.hpp>
#include <..\..\..\oop.hpp>
#include <..\..\..\text.hpp>
#include <..\..\GameConstants.hpp>

editor_attribute("InterfaceClass")
class(Debris) extends(Item)
	var(name,"Обломки"); 
	var(desc,"Из этого можно что-нибудь смастерить.");

	//мусор... не дает мусор
	func(getOnDestroyTypes)
	{
		objParams();
		[];
	};

endclass

class(SmallStone) extends(Debris)
	var(name,"Камушек");
	var(desc,"Им можно высечь искру или в кого-то кинуть");
	var(model,"relicta_models2\debris\s_stone_debris4\s_stone_debris4.p3d");
	var(weight,gramm(156));
	var(size,ITEM_SIZE_SMALL);
endclass

class(Coal) extends(Debris)
	var(name,"Уголь");
	var(model,"relicta_models2\debris\s_stone_debris5\s_stone_debris5.p3d");
	var(weight,gramm(1241));
	var(size,ITEM_SIZE_MEDIUM);
endclass

//Деревянные обломки
class(WoodenDebris1) extends(Debris)
	var(name,"Доска");
	var(model,"relicta_models2\debris\s_wooden_debris\s_wooden_debris.p3d");
	var(material,"MatWood");
	var(weight,gramm(2142));
	var(size,ITEM_SIZE_LARGE);
endclass

class(WoodenDebris2) extends(WoodenDebris1)
	var(name,"Деревяшка");
	var(model,"relicta_models2\debris\s_wooden_debris1\s_wooden_debris1.p3d");
	var(weight,gramm(1641));
endclass

class(WoodenDebris3) extends(WoodenDebris1)
	var(model,"relicta_models2\debris\s_wooden_debris2\s_wooden_debris2.p3d");
	var(weight,gramm(1556));
endclass

class(WoodenDebris4) extends(WoodenDebris1)
	var(model,"relicta_models2\debris\s_wooden_debris3\s_wooden_debris3.p3d");
	var(weight,gramm(1823));
endclass

class(WoodenDebris5) extends(WoodenDebris1)
	var(model,"relicta_models2\debris\s_wooden_debris4\s_wooden_debris4.p3d");
	var(weight,gramm(2267));
endclass

class(WoodenDebris6) extends(WoodenDebris1)
	var(name,"Короткая палка");
	var(model,"relicta_models2\debris\s_wooden_debris5\s_wooden_debris5.p3d");
	var(weight,gramm(319));
	var(size,ITEM_SIZE_SMALL);
endclass

class(WoodenDebris7) extends(WoodenDebris1)
	var(name,"Длинная палка");
	var(model,"relicta_models2\debris\s_wooden_debris6\s_wooden_debris6.p3d");
	var(weight,gramm(643));
	var(size,ITEM_SIZE_MEDIUM);
endclass

//Грибные брёвна
class(LogDebris1) extends(Debris)
	var(name,"Грибное бревно");
	var(model,"relicta_models2\debris\s_wooden_debris7\s_wooden_debris7.p3d");
	var(weight,gramm(16524));
	var(size,ITEM_SIZE_HUGE);
	var(material,"MatWood");
endclass

class(LogDebris2) extends(LogDebris1)
	var(model,"relicta_models2\debris\s_wooden_debris8\s_wooden_debris8.p3d");
	var(weight,gramm(14357));
	var(size,ITEM_SIZE_HUGE);
endclass

//Бетонные обломки
class(ConcreteDebris1) extends(Debris)
	var(name,"Кусок бетона");
	var(model,"relicta_models2\debris\s_concrete_debris\s_concrete_debris.p3d");
	var(material,"MatBeton");
	var(weight,gramm(22372));
	var(size,ITEM_SIZE_BIG);
endclass

class(ConcreteDebris2) extends(ConcreteDebris1)
	var(model,"relicta_models2\debris\s_concrete_debris1\s_concrete_debris1.p3d");
	var(weight,gramm(23744));
endclass

class(ConcreteDebris3) extends(ConcreteDebris1)
	var(model,"relicta_models2\debris\s_concrete_debris2\s_concrete_debris2.p3d");
	var(weight,gramm(20221));
endclass

class(ConcreteDebris4) extends(ConcreteDebris1)
	var(model,"relicta_models2\debris\s_concrete_debris3\s_concrete_debris3.p3d");
	var(weight,gramm(17936));
endclass

//Каменные обломки
class(StoneDebris1) extends(Debris)
	var(name,"Камень");
	var(model,"relicta_models2\debris\s_stone_debris\s_stone_debris.p3d");
	var(material,"MatStone");
	var(weight,gramm(22319));
	var(size,ITEM_SIZE_BIG);
endclass

class(StoneDebris2) extends(StoneDebris1)
	var(model,"relicta_models2\debris\s_stone_debris1\s_stone_debris1.p3d");
	var(weight,gramm(18724));
endclass

class(StoneDebris3) extends(StoneDebris1)
	var(model,"relicta_models2\debris\s_stone_debris2\s_stone_debris2.p3d");
	var(weight,gramm(26638));
endclass

class(StoneDebris4) extends(StoneDebris1)
	var(model,"relicta_models2\debris\s_stone_debris3\s_stone_debris3.p3d");
	var(weight,gramm(29284));
endclass

class(StoneDebris5) extends(StoneDebris1)
	var(model,"a3\rocks_f_exp\cliff\cliff_stone_small_f.p3d");
	var(weight,gramm(20472));
endclass

//Кучки земли
class(DirtDebris1) extends(Debris)
	var(name,"Земля");
	var(model,"relicta_models2\debris\s_dirt_debris\s_dirt_debris.p3d");
	var(material,"MatDirt");
	var(weight,gramm(9568));
	var(size,ITEM_SIZE_BIG);
endclass

class(DirtDebris2) extends(DirtDebris1)
	var(model,"relicta_models2\debris\s_dirt_debris1\s_dirt_debris1.p3d");
	var(weight,gramm(8965));
endclass

//Обрывки ткани
class(ClothDebris1) extends(Debris)
	var(name,"Обрывки ткани");
	var(model,"relicta_models2\debris\s_cloth_debris\s_cloth_debris.p3d");
	var(material,"MatCloth");
	var(weight,gramm(568));
	var(size,ITEM_SIZE_MEDIUM);
endclass

class(ClothDebris2) extends(ClothDebris1)
	var(model,"relicta_models2\debris\s_cloth_debris1\s_cloth_debris1.p3d");
	var(weight,gramm(621));
endclass

//Органика
class(OrganicDebris1) extends(Debris)
	var(name,"Ошмётки");
	var(model,"relicta_models2\debris\s_organicdebris\s_organic_debris.p3d");
	var(material,"MatOrganic");
	var(weight,gramm(733));
	var(size,ITEM_SIZE_MEDIUM);
endclass

//Металл
class(MetalDebris1) extends(Debris)
	var(name,"Кусочки железяк");
	var(model,"relicta_models2\debris\s_metal_debris\s_metal_debris.p3d");
	var(material,"MatMetal");
	var(weight,gramm(15736));
	var(size,ITEM_SIZE_BIG);
endclass

class(MetalDebris2) extends(MetalDebris1)
	var(name,"Кусочки железяк");
	var(model,"relicta_models2\debris\s_metal_debris1\s_metal_debris1.p3d");
	var(material,"MatMetal");
	var(weight,gramm(7736));
	var(size,ITEM_SIZE_LARGE);
endclass

//Синтетика
class(SyntDebris1) extends(Debris)
	var(name,"Хлам");
	var(model,"relicta_models2\debris\s_synt_debris\s_synt_debris.p3d");
	var(material,"MatSynt");
	var(weight,gramm(3879));
	var(size,ITEM_SIZE_LARGE);
endclass

//Плоть
class(FleshDebris1) extends(Debris)
	var(name,"Кусок плоти");
	var(desc,"Кровавые кусочки");
	var(model,"relicta_models2\debris\s_meat_debris\s_meat_debris.p3d");
	var(material,"MatFlesh");
	var(weight,gramm(1979));
	var(size,ITEM_SIZE_MEDIUM);
endclass




