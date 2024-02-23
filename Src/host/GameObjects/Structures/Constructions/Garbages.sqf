// ======================================================
// Copyright (c) 2017-2024 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\..\engine.hpp>
#include <..\..\..\oop.hpp>
#include <..\..\..\text.hpp>
#include <..\..\GameConstants.hpp>

//мусор
editor_attribute("InterfaceClass")
editor_attribute("TemplatePrefab")
class(SmallGarbage) extends(Constructions) var(name,"Куча мусора"); editor_only(var(desc,"Небольшая куча мусора");) endclass

editor_attribute("EditorGenerated")
class(MetalAndConcreteRuins) extends(SmallGarbage)
	var(model,"ml_shabut\nvprops\nv_gryaz2.p3d");
	var(name,"Куча мусора");
endclass

editor_attribute("EditorGenerated")
class(SmallBrickHouseRuins) extends(SmallGarbage)
	var(model,"ca\structures_e\ind\ind_fuelstation\ind_fuelstation_build_ruins_ep1.p3d");
	var(name,"Куча мусора");
endclass

editor_attribute("EditorGenerated")
class(SmallPileOfConcreteFragments) extends(SmallGarbage)
	var(model,"a3\structures_f_argo\walls\military\mil_wallbig_debris_f.p3d");
	var(name,"Обломки бетона");
endclass

editor_attribute("EditorGenerated")
class(SmallPileOfGarbageAndBoards) extends(SmallGarbage)
	var(model,"ca\structures\ruins\rubble_wood_01.p3d");
	var(name,"Куча мусора");
endclass

editor_attribute("EditorGenerated")
class(SmallPileOfBricks) extends(SmallGarbage)
	var(model,"ca\structures\ruins\rubble_bricks_03.p3d");
	var(name,"Куча мусора");
endclass

editor_attribute("EditorGenerated")
class(SmallPileOfBricksAndPlanks) extends(SmallGarbage)
	var(model,"ca\structures_e\misc\shed_w03_ruins_ep1.p3d");
	var(name,"Куча мусора");
endclass
editor_attribute("EditorGenerated")
class(BigPileBurntGarbage) extends(SmallGarbage)
	var(model,"a3\props_f_enoch\military\garbage\burntgarbage_01_f.p3d");
	var(name,"Куча мусора");
endclass

editor_attribute("EditorGenerated")
class(SmallRuinedWoodenBuilding) extends(SmallGarbage)
	var(model,"a3\structures_f\households\slum\slum_house02_ruins_f.p3d");
	var(name,"Руины");
endclass