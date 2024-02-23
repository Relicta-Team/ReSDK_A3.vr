// ======================================================
// Copyright (c) 2017-2024 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\..\engine.hpp>
#include <..\..\..\oop.hpp>
#include <..\..\GameConstants.hpp>

// Стеллажи
editor_attribute("InterfaceClass")
editor_attribute("TemplatePrefab")
class(ShelfBase) extends(Furniture) var(name,"Полка"); editor_only(var(desc,"Мебель для складирования предметов на поверхности");) endclass

editor_attribute("EditorGenerated")
class(WoodenSmallShelf) extends(ShelfBase)
	var(model,"ml\ml_object_new\shabbat\bar_stoika.p3d");
endclass

editor_attribute("EditorGenerated")
class(WoodenSmallShelf1) extends(WoodenSmallShelf)
	var(model,"a3\structures_f_epb\furniture\shelveswooden_f.p3d");
endclass

editor_attribute("EditorGenerated")
class(LongShelf) extends(ShelfBase)
	var(model,"ml_shabut\stelazh_ot_seregi\stelazh_ot_seregi.p3d");
endclass

editor_attribute("EditorGenerated")
class(SteelSmallShelf) extends(ShelfBase)
	var(model,"ca\structures\furniture\generalstore\shelf.p3d");
endclass

editor_attribute("EditorGenerated")
class(BigRedEdgesRack) extends(ShelfBase)
	var(model,"a3\structures_f\furniture\metal_wooden_rack_f.p3d");
endclass

class(Shelves) extends(ShelfBase)
	var(model,"a3\structures_f\furniture\metal_rack_f.p3d");
	var(name,null);
	getterconst_func(getName,"Полки");
endclass