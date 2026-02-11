// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\engine.hpp>
#include <..\..\oop.hpp>


//руины
editor_attribute("InterfaceClass")
editor_attribute("TemplatePrefab")
class(BigRuins) extends(BigConstructions) 
	var(name,"Крупные руины");
	var(material,"MatBeton"); 
	editor_only(var(desc,"Остатки разрушенного здания для декорации. Не разрушаемы");) 
endclass

editor_attribute("EditorGenerated")
class(MediumStoneHouseRuins) extends(BigRuins)
	var(model,"a3\structures_f_argo\civilian\stone_shed_01\stone_shed_01_b_raw_ruins_f.p3d");
	var(name,"Руины");
endclass

editor_attribute("EditorGenerated")
class(BigDestroyedRedConcreteBuilding) extends(BigRuins)
	var(model,"a3\structures_f_argo\civilian\house_small01\house_small_01_b_pink_ruins_f.p3d");
	var(name,"Руины");
endclass

editor_attribute("EditorGenerated")
class(BigPartiallyDestroyedLightBrickBuilding) extends(BigRuins)
	var(model,"a3\structures_f_exp\civilian\house_small_04\house_small_04_ruins_f.p3d");
	var(name,"Руины");
endclass

editor_attribute("EditorGenerated")
class(BigDestroyedLightConcreteBuilding) extends(BigRuins)
	var(model,"a3\structures_f_argo\civilian\house_small02\house_small_02_b_v1_ruins_f.p3d");
	var(name,"Руины");
endclass

editor_attribute("EditorGenerated")
class(MediumRuinedWhiteConcreteBuilding) extends(BigRuins)
	var(model,"a3\structures_f\mil\radar\radar_small_ruins_f.p3d");
	var(name,"Руины");
endclass

editor_attribute("EditorGenerated")
class(SmallRuinedLightBrickBuilding) extends(BigRuins)
	var(model,"a3\structures_f_enoch\cultural\chapel_02\chapel_02_white_ruins_f.p3d");
	var(name,"Руины");
endclass

editor_attribute("EditorGenerated")
class(BigRuinedLightBrickBuilding) extends(BigRuins)
	var(model,"a3\structures_f\households\wip\unfinished_building_02_ruins_f.p3d");
	var(name,"Руины");
endclass

editor_attribute("EditorGenerated")
class(BigGreyRuinedBuilding) extends(BigRuins)
	var(model,"ca\structures_e\housec\house_c_1_ruins_ep1.p3d");
	var(name,"Руины");
endclass

editor_attribute("EditorGenerated")
class(MediumLightRuinedStoneHouse) extends(BigRuins)
	var(model,"a3\structures_f_argo\civilian\stone_shed_01\stone_shed_01_b_white_ruins_f.p3d");
	var(name,"Руины");
endclass

editor_attribute("EditorGenerated")
class(SmallRuinedBellTower) extends(BigRuins)
	var(model,"a3\structures_f\civ\belltowers\belltower_02_v1_ruins_f.p3d");
	var(name,"Руины");
endclass

editor_attribute("EditorGenerated")
class(BigLightRuinedBuilding) extends(BigRuins)
	var(model,"a3\structures_f_argo\commercial\shop_02\shop_02_b_blue_ruins_f.p3d");
	var(name,"Руины");
endclass

editor_attribute("EditorGenerated")
class(BigBrickHouseRuins) extends(BigRuins)
	var(model,"ca\structures_e\housec\house_c_3_ruins_ep1.p3d");
	var(name,"Руины");
endclass

editor_attribute("EditorGenerated")
class(MediumBrickHouseRuins) extends(BigRuins)
	var(model,"a3\structures_f\households\addons\addon_03mid_v1_ruins_f.p3d");
	var(name,"Руины");
endclass

editor_attribute("EditorGenerated")
class(BigSteelRoof) extends(BigRuins)
	var(model,"csa_constr\csa_obj\krysha.p3d");
endclass

editor_attribute("EditorGenerated")
class(OldLongTunnel) extends(BigRuins)
	var(model,"ml\ml_object\l04_catacombs\l04_catacombs_01.p3d");
endclass