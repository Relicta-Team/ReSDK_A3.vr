// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\..\engine.hpp>
#include <..\..\..\oop.hpp>
#include <..\..\..\text.hpp>
#include <..\..\GameConstants.hpp>

//пол
editor_attribute("InterfaceClass")
editor_attribute("TemplatePrefab")
class(SmallFloor) extends(Constructions) 
	var(name,"Пол"); 
	editor_only(var(desc,"Обычное напольное покрытие");)
	var(material,"MatWood");
	var(dr,2);
endclass

editor_attribute("EditorGenerated")
class(LongBoardsOnStilts) extends(SmallFloor)
	var(model,"ca\structures\nav_boathouse\nav_boathouse_piert.p3d");
	var(name,"Доски");
endclass

editor_attribute("EditorGenerated")
class(LongRottenBoards) extends(SmallFloor)
	var(model,"a3\structures_f_exp\civilian\accessories\plank_01_8m_f.p3d");
	var(name,"Доски");
endclass

editor_attribute("EditorGenerated")
class(ShortRottenBoards) extends(LongRottenBoards)
	var(model,"a3\structures_f_exp\civilian\accessories\plank_01_4m_f.p3d");
endclass

editor_attribute("EditorGenerated")
class(SmallOldWell) extends(SmallFloor)
	var(model,"a3\structures_f_enoch\civilian\accessories\stonewell_01_f.p3d");
	var(name,"Старый колодец");
	var(material,"MatStone");
	var(dr,3);
endclass

editor_attribute("EditorGenerated")
class(ConcreteGreenSmallFloor) extends(SmallFloor)
	var(model,"ml\ml_object\l08_market\l08_market_09_pol_02.p3d");
	var(material,"MatBeton");
	var(dr,3);
endclass

editor_attribute("EditorGenerated")
class(ConcreteSmallFloor) extends(SmallFloor)
	var(model,"apalon\metro_a3\redgates\concrete_slub3.p3d");
	var(material,"MatBeton");
	var(dr,3);
endclass

editor_attribute("EditorGenerated")
class(SmallTileFloor) extends(ConcreteSmallFloor)
	var(model,"ml_shabut\sbs\polwhitesbs.p3d");
endclass

editor_attribute("EditorGenerated")
class(SmallTileFloor2) extends(SmallTileFloor)
	var(model,"ml_shabut\sbs\polbetonsbs.p3d");
endclass

editor_attribute("EditorGenerated")
class(SmallTileFloor1) extends(SmallTileFloor)
	var(model,"ml_shabut\sbs\polbetonsbs_2.p3d");
endclass

editor_attribute("EditorGenerated")
class(ConcreteSmallFloor2) extends(ConcreteSmallFloor)
	var(model,"ml_shabut\exoduss\concrete_slub.p3d");
endclass

editor_attribute("EditorGenerated")
class(ConcreteSmallFloor1) extends(ConcreteSmallFloor)
	var(model,"apalon\metro_a3\redgates\concrete_slub2.p3d");
endclass

editor_attribute("EditorGenerated")
class(SmallStoneRoad) extends(SmallFloor)
	var(model,"a3\structures_f_exp\infrastructure\pavements\gardenpavement_02_f.p3d");
	var(material,"MatStone");
	var(dr,3);
endclass

editor_attribute("EditorGenerated")
class(MediumStoneRoad) extends(SmallStoneRoad)
	var(model,"a3\structures_f_epc\dominants\ghosthotel\gh_platform_f.p3d");
	var(material,"MatStone");
	var(dr,3);
endclass

editor_attribute("EditorGenerated")
class(BigSteelGrating) extends(SmallFloor)
	var(model,"ml\ml_object_new\ml_object_2\l01_props\grating_01.p3d");
	var(material,"MatMetal");
endclass

editor_attribute("EditorGenerated")
class(WoodenSmallFloor) extends(SmallFloor)
	var(model,"ml_shabut\sbs\poldrevko.p3d");
endclass

class(WoodenPallet) extends(SmallFloor)
	var(model,"ca\misc\paletaa.p3d");
endclass

class(WoodenPallet1) extends(WoodenPallet)
	var(model,"a3\structures_f\civ\constructions\pallet_f.p3d");
endclass

editor_attribute("EditorGenerated")
class(ThickConcreteFloorSmall) extends(SmallFloor)
	var(model,"csa_constr\csa_obj\pod_6x6.p3d");
	var(name,"Бетон");
	var(material,"MatBeton");
	var(dr,3);
endclass

editor_attribute("EditorGenerated")
class(ThickConcreteFloorMedium) extends(ThickConcreteFloorSmall)
	var(model,"csa_constr\csa_obj\pod_18x6.p3d");
endclass

editor_attribute("EditorGenerated")
class(MediumConcreteFloor) extends(SmallFloor)
	var(model,"csa_constr\csa_obj\plita_3x6.p3d");
	var(material,"MatBeton");
	var(dr,3);
endclass

editor_attribute("EditorGenerated")
class(MediumConcreteFloor1) extends(MediumConcreteFloor)
	var(model,"csa_constr\csa_obj\plita_6x6.p3d");
endclass

editor_attribute("EditorGenerated")
class(WhiteConcreteFloorBig) extends(MediumConcreteFloor)
	var(model,"ml_shabut\exoduss\concreteplat.p3d");
endclass

editor_attribute("EditorGenerated")
class(BetonBlockFloor) extends(SmallFloor)
	var(model,"a3\structures_f_exp\infrastructure\pavements\sidewalk_01_8m_f.p3d");
	var(material,"MatBeton");
endclass

editor_attribute("EditorGenerated")
class(SmallSteelPlate) extends(SmallFloor)
	var(model,"ml_shabut\exoduss\metalplate.p3d");
	var(material,"MatMetal");
endclass

editor_attribute("EditorGenerated")
class(MediumSteelFloor) extends(SmallSteelPlate)
	var(model,"ml_exodusnew\zhelezoplatforma.p3d");
endclass

editor_attribute("EditorGenerated")
class(SmallSteelPlate2) extends(SmallSteelPlate)
	var(model,"ml\ml_object_new\ml_object_2\l01_props\gate_bridge.p3d");
endclass

editor_attribute("EditorGenerated")
class(Rail) extends(SmallFloor)
	var(model,"a3\structures_f_exp\industrial\port\cranerail_01_f.p3d");
	var(name, "Монорельс");
	var(desc, "Обветшалые рельсы");
	var(material,"MatBeton");
	var(dr,3);
endclass

class(ConcretePanel) extends(SmallFloor)
	var(name,"Бетонная плита");
	var(model,"a3\structures_f_enoch\infrastructure\roads\concretepanels_02_single_v1_f.p3d");
	var(material,"MatBeton");
endclass

editor_attribute("EditorGenerated")
class(ConcretePanel2) extends(ConcretePanel)
	var(model,"a3\structures_f_enoch\infrastructure\roads\concretepanels_02_single_v2_f.p3d");
endclass

editor_attribute("EditorGenerated")
class(ConcretePanelDamaged) extends(ConcretePanel)
	var(model,"a3\structures_f_enoch\infrastructure\roads\concretepanels_02_single_dmg_f.p3d");
endclass

editor_attribute("EditorGenerated")
class(BigConcretePanel) extends(ConcretePanel)
	var(model,"a3\structures_f_enoch\infrastructure\roads\concretepanels_02_four_f.p3d");
endclass

editor_attribute("EditorGenerated")
class(SmallConcretePanel) extends(ConcretePanel)
	var(model,"a3\structures_f_exp\infrastructure\pavements\gardenpavement_01_f.p3d");
endclass