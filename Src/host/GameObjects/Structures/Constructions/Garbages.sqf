// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\..\engine.hpp>
#include <..\..\..\oop.hpp>
#include <..\..\..\text.hpp>
#include <..\..\GameConstants.hpp>

//мусор
editor_attribute("InterfaceClass")
editor_attribute("TemplatePrefab")
class(SmallGarbage) extends(Constructions) 
	var(name,"Куча мусора"); 
	editor_only(var(desc,"Небольшая куча мусора");) 
	var(material,"MatDirt");
	var(dr,1);
endclass

editor_attribute("EditorGenerated")
class(ConcreteGarbage) extends(SmallGarbage)
	var(model,"ca\structures\ruins\rubble_concrete_03.p3d");
	var(material,"MatBeton");
endclass

editor_attribute("EditorGenerated")
class(SheetMetalGarbage) extends(SmallGarbage)
	var(model,"ca\structures\ruins\rubble_metal_plates_04.p3d");
	var(material,"MatMetal");
endclass

editor_attribute("EditorGenerated")
class(SheetMetalGarbage1) extends(SheetMetalGarbage)
	var(model,"ca\structures\ruins\rubble_metal_plates_03.p3d");
endclass

editor_attribute("EditorGenerated")
class(WoodenPlanksGarbage) extends(SmallGarbage)
	var(model,"ca\structures\ruins\rubble_wood_02.p3d");
	var(material,"MatWood");
endclass

editor_attribute("EditorGenerated")
class(MediumBarrelGarbage) extends(SmallGarbage)
	var(model,"ml_exodusnew\gryazooka_bochki.p3d");
endclass

editor_attribute("EditorGenerated")
class(SmallStoneFragments) extends(SmallGarbage)
	var(model,"a3\rocks_f_argo\limestone\limestone_01_erosion_f.p3d");
	var(name,"Камни"); 
	var(desc,"Просто камни");
	var(material,"MatStone");
endclass

editor_attribute("EditorGenerated")
class(MediumFireGarbagePile) extends(SmallGarbage)
	var(model,"ml_shabut\exodus\pozharishe.p3d");
endclass

editor_attribute("EditorGenerated")
class(MetalAndConcreteRuins) extends(SmallGarbage)
	var(model,"ml_shabut\nvprops\nv_gryaz2.p3d");
	var(name,"Куча мусора");
	var(material,"MatBeton");
endclass

editor_attribute("EditorGenerated")
class(SmallBrickHouseRuins) extends(SmallGarbage)
	var(model,"ca\structures_e\ind\ind_fuelstation\ind_fuelstation_build_ruins_ep1.p3d");
	var(name,"Куча мусора");
	var(material,"MatBeton");
endclass

editor_attribute("EditorGenerated")
class(SmallPileOfConcreteFragments) extends(SmallGarbage)
	var(model,"a3\structures_f_argo\walls\military\mil_wallbig_debris_f.p3d");
	var(name,"Обломки бетона");
	var(material,"MatBeton");
endclass

editor_attribute("EditorGenerated")
class(SmallPileOfGarbageAndBoards) extends(SmallGarbage)
	var(model,"ca\structures\ruins\rubble_wood_01.p3d");
	var(name,"Куча мусора");
	var(material,"MatWood");
endclass

editor_attribute("EditorGenerated")
class(MediumPileGarbageAndBoards) extends(SmallPileOfGarbageAndBoards)
	var(model,"ca\structures\ruins\rubble_wood_03.p3d");
endclass

editor_attribute("EditorGenerated")
class(SmallPileOfBricks) extends(SmallGarbage)
	var(model,"ca\structures\ruins\rubble_bricks_03.p3d");
	var(name,"Куча мусора");
	var(material,"MatBeton");
endclass

editor_attribute("EditorGenerated")
class(SmallPileBricks) extends(SmallPileOfBricks)
	var(model,"ca\structures\ruins\rubble_bricks_01.p3d");
endclass

editor_attribute("EditorGenerated")
class(SmallPileOfBricksAndPlanks) extends(SmallGarbage)
	var(model,"ca\structures_e\misc\shed_w03_ruins_ep1.p3d");
	var(name,"Куча мусора");
	var(material,"MatBeton");
endclass

editor_attribute("EditorGenerated")
class(SmallPileBricksAndPlanks) extends(SmallPileOfBricksAndPlanks)
	var(model,"ca\structures\ruins\ruin_rubble.p3d");
endclass
editor_attribute("EditorGenerated")
class(BigPileBurntGarbage) extends(SmallGarbage)
	var(model,"a3\props_f_enoch\military\garbage\burntgarbage_01_f.p3d");
	var(name,"Куча мусора");
	var(material,"MatBeton");
endclass

editor_attribute("EditorGenerated")
class(SmallRuinedWoodenBuilding) extends(SmallGarbage)
	var(model,"a3\structures_f\households\slum\slum_house02_ruins_f.p3d");
	var(name,"Руины");
	var(material,"MatWood");
endclass