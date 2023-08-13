// ======================================================
// Copyright (c) 2017-2023 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\engine.hpp>
#include <..\..\oop.hpp>

//большое здание
editor_attribute("InterfaceClass")
editor_attribute("TemplatePrefab")
class(BigHouse) extends(BigConstructions) var(name,"Большое здание"); var(desc,"Крупное здание выполняющее роль декорации и являющееся нерушимой конструкцией"); endclass

editor_attribute("EditorGenerated")
class(DestroyedMetalHangar) extends(BigHouse)
	var(name,"Руины");
	var(model,"a3\structures_f_enoch\industrial\farms\barn_04_ruins_f.p3d");
endclass

editor_attribute("EditorGenerated")
class(BigConcreteUnfinishedBuilding) extends(BigHouse)
	var(model,"a3\structures_f\households\wip\unfinished_building_01_f.p3d");
	var(name,"Бетонное здание");
endclass

editor_attribute("EditorGenerated")
class(MediumClayHouse) extends(BigHouse)
	var(model,"ca\structures_e\housel\house_l_9_ep1.p3d");
	var(name,"Глиняный барак");
endclass

editor_attribute("EditorGenerated")
class(LargeTwoStoreyStoneHouse) extends(BigHouse)
	var(model,"a3\structures_f\households\stone_big\i_stone_housebig_v3_f.p3d");
	var(name,"Кирпичный дом");
endclass

editor_attribute("EditorGenerated")
class(Golovinskaya) extends(BigHouse)
	var(model,"a3\structures_f\households\stone_big\d_stone_housebig_v1_f.p3d");
	var(name, "Разрушенная хибара");
endclass

