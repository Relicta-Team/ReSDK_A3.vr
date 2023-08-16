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
class(PartiallyBlockedTunnelIntersection) extends(BigHouse)
	var(model,"ml\ml_object\l03_camp_1\l03_camp_02.p3d");
	var(name,"Туннель");
endclass

editor_attribute("EditorGenerated")
class(TunnelIntersection) extends(BigHouse)
	var(model,"ml\ml_object\l03_camp_1\l03_camp_02_06.p3d");
	var(name,"Туннель");
endclass

editor_attribute("EditorGenerated")
class(StraightTunnelWithSideExit) extends(BigHouse)
	var(model,"ml\ml_object\l02_escape\l02_escape_1_13.p3d");
	var(name,"Туннель");
endclass

editor_attribute("EditorGenerated")
class(LongTurningTunnelWithRails) extends(BigHouse)
	var(model,"ml\ml_object\l03_camp_1\l03_camp_03_02.p3d");
	var(name,"Туннель");
endclass

editor_attribute("EditorGenerated")
class(BigBlockedTunnel) extends(BigHouse)
	var(model,"ml\ml_object\l04_catacombs\l04_catacombs_02.p3d");
	var(name,"Заваленный туннель");
endclass

editor_attribute("EditorGenerated")
class(BigRuinedBrickBuilding1) extends(BigHouse)
	var(model,"a3\structures_f_enoch\ruins\houseruin_big_02_f.p3d");
	var(name,"Разрушенное здание");
endclass

editor_attribute("EditorGenerated")
class(BigRuinedBrickBuilding) extends(BigHouse)
	var(model,"a3\structures_f_enoch\ruins\houseruin_small_02_f.p3d");
	var(name,"Разрушенное здание");
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
endclass

editor_attribute("EditorGenerated")
class(Golovinskaya) extends(BigHouse)
	var(model,"a3\structures_f\households\stone_big\d_stone_housebig_v1_f.p3d");
	var(desc, null);
endclass