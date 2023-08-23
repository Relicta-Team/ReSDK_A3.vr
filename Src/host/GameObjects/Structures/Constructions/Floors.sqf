// ======================================================
// Copyright (c) 2017-2023 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\..\engine.hpp>
#include <..\..\..\oop.hpp>
#include <..\..\..\text.hpp>
#include <..\..\GameConstants.hpp>

//пол
editor_attribute("InterfaceClass")
editor_attribute("TemplatePrefab")
class(SmallFloor) extends(Constructions) var(name,"Пол"); editor_only(var(desc,"Обычное напольное покрытие");) endclass

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
class(SmallOldWell) extends(SmallFloor)
	var(model,"a3\structures_f_enoch\civilian\accessories\stonewell_01_f.p3d");
	var(name,"Старый колодец");
endclass

editor_attribute("EditorGenerated")
class(ConcreteGreenSmallFloor) extends(SmallFloor)
	var(model,"ml\ml_object\l08_market\l08_market_09_pol_02.p3d");
endclass

editor_attribute("EditorGenerated")
class(ConcreteSmallFloor) extends(SmallFloor)
	var(model,"apalon\metro_a3\redgates\concrete_slub3.p3d");
endclass

editor_attribute("EditorGenerated")
class(SmallStoneRoad) extends(SmallFloor)
	var(model,"a3\structures_f_exp\infrastructure\pavements\gardenpavement_02_f.p3d");
endclass

editor_attribute("EditorGenerated")
class(BigSteelGrating) extends(SmallFloor)
	var(model,"ml\ml_object_new\ml_object_2\l01_props\grating_01.p3d");
endclass

editor_attribute("EditorGenerated")
class(WoodenSmallFloor) extends(SmallFloor)
	var(model,"ml_shabut\sbs\poldrevko.p3d");
endclass

editor_attribute("EditorGenerated")
class(ThickConcreteFloorSmall) extends(SmallFloor)
	var(model,"csa_constr\csa_obj\pod_6x6.p3d");
	var(name,"Бетон");
endclass

editor_attribute("EditorGenerated")
class(MediumConcreteFloor) extends(SmallFloor)
	var(model,"csa_constr\csa_obj\plita_3x6.p3d");
endclass

editor_attribute("EditorGenerated")
class(ThickConcreteFloorMedium) extends(ThickConcreteFloorSmall)
	var(model,"csa_constr\csa_obj\pod_18x6.p3d");
endclass

editor_attribute("EditorGenerated")
class(BetonBlockFloor) extends(SmallFloor)
	var(model,"a3\structures_f_exp\infrastructure\pavements\sidewalk_01_8m_f.p3d");
endclass

editor_attribute("EditorGenerated")
class(SmallSteelPlate) extends(SmallFloor)
	var(model,"ml_shabut\exoduss\metalplate.p3d");
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
endclass

class(ConcretePanel) extends(SmallFloor)
	var(name,"Бетонная плита");
	var(model,"a3\structures_f_enoch\infrastructure\roads\concretepanels_02_single_v1_f.p3d");
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