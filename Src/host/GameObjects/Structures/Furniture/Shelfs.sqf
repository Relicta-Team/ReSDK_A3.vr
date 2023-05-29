// ======================================================
// Copyright (c) 2017-2023 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\..\engine.hpp>
#include <..\..\..\oop.hpp>
#include <..\..\GameConstants.hpp>

// Стеллажи
editor_attribute("InterfaceClass")
editor_attribute("TemplatePrefab")
class(ShelfBase) extends(Furniture) var(name,"Полка"); var(desc,"Мебель для сладирования предметов на поверхности"); endclass

class(Shelves) extends(ShelfBase)
	var(model,"a3\structures_f\furniture\metal_rack_f.p3d");
	var(name,null);
	getterconst_func(getName,"Полки");
endclass
