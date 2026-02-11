// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\engine.hpp>
#include <..\..\oop.hpp>

//большое здание
editor_attribute("InterfaceClass")
editor_attribute("TemplatePrefab")
class(BigHouse) extends(BigConstructions) 
	var(name,"Большое здание"); 
	var(material,"MatBeton");
	editor_only(var(desc,"Крупное здание выполняющее роль декорации и являющееся нерушимой конструкцией");) 
endclass

editor_attribute("EditorGenerated")
class(BigTwoStoreyHouse) extends(BigHouse)
	var(model,"a3\structures_f\households\house_big01\u_house_big_01_v1_dam_f.p3d");
endclass

editor_attribute("EditorGenerated")
class(BigClayHouse) extends(BigHouse)
	var(model,"ca\structures_e\housek\house_k_6_ep1.p3d");
endclass

editor_attribute("EditorGenerated")
class(BigClayHouse4) extends(BigClayHouse)
	var(model,"ca\structures_e\housec\house_c_5_v3_dam_ep1.p3d");
endclass

editor_attribute("EditorGenerated")
class(BigClayHouse3) extends(BigClayHouse)
	var(model,"ca\structures_e\housec\house_c_3_dam_ep1.p3d");
endclass

editor_attribute("EditorGenerated")
class(BigClayHouse2) extends(BigClayHouse)
	var(model,"ca\structures_e\housec\house_c_5_v1_ep1.p3d");
endclass

editor_attribute("EditorGenerated")
class(BigClayHouse1) extends(BigClayHouse)
	var(model,"ca\structures_e\housec\house_c_2_ep1.p3d");
endclass

editor_attribute("EditorGenerated")
class(FactoryWithTanks) extends(BigHouse)
	var(model,"ca\buildings2\ind_cementworks\ind_mlyn\ind_mlyn_03.p3d");
endclass

editor_attribute("EditorGenerated")
class(Tunnel) extends(BigHouse)
	var(model,"apalon\metro_a3\menu\menu_tunnel.p3d");
endclass

editor_attribute("EditorGenerated")
class(RustyTunnel) extends(Tunnel)
	var(model,"apalon\metro_a3\menu\tunnel_vurez.p3d");
endclass

editor_attribute("EditorGenerated")
class(ConcreteFloorHangarLong) extends(BigHouse)
	var(model,"ca\buildings2\houseruins\r_barn_w_01.p3d");
endclass

editor_attribute("EditorGenerated")
class(FactoryBigBrick) extends(BigHouse)
	var(model,"ml_exodusnew\stalker_tun\radarkitchen.p3d");
	var(name,"Большое здание");
endclass

editor_attribute("EditorGenerated")
class(BigConcreteUnfinishedBuilding) extends(BigHouse)
	var(model,"a3\structures_f\households\wip\unfinished_building_01_f.p3d");
	var(name,"Бетонное здание");
endclass

editor_attribute("EditorGenerated")
class(BigBrickUnfinishedTwoStoreyHouse) extends(BigConcreteUnfinishedBuilding)
	var(model,"a3\structures_f\households\wip\unfinished_building_02_f.p3d");
	var(name,"Постройка");
endclass

editor_attribute("EditorGenerated")
class(PartiallyBlockedTunnelIntersection) extends(Tunnel)
	var(model,"ml\ml_object\l03_camp_1\l03_camp_02.p3d");
	var(name,"Туннель");
endclass

editor_attribute("EditorGenerated")
class(TunnelIntersection) extends(Tunnel)
	var(model,"ml\ml_object\l03_camp_1\l03_camp_02_06.p3d");
	var(name,"Туннель");
endclass

editor_attribute("EditorGenerated")
class(StraightTunnelWithSideExit) extends(Tunnel)
	var(model,"ml\ml_object\l02_escape\l02_escape_1_13.p3d");
	var(name,"Туннель");
endclass

editor_attribute("EditorGenerated")
class(LongTurningTunnelWithRails) extends(Tunnel)
	var(model,"ml\ml_object\l03_camp_1\l03_camp_03_02.p3d");
	var(name,"Туннель");
endclass

editor_attribute("EditorGenerated")
class(BigBlockedTunnel) extends(Tunnel)
	var(model,"ml\ml_object\l04_catacombs\l04_catacombs_02.p3d");
	var(name,"Заваленный туннель");
endclass

editor_attribute("EditorGenerated")
class(BigRuinedBrickBuilding) extends(BigHouse)
	var(model,"a3\structures_f_enoch\ruins\houseruin_small_02_f.p3d");
	var(name,"Разрушенное здание");
endclass

editor_attribute("EditorGenerated")
class(BigRuinedBrickBuilding1) extends(BigRuinedBrickBuilding)
	var(model,"a3\structures_f_enoch\ruins\houseruin_big_02_f.p3d");
	var(name,"Разрушенное здание");
endclass

editor_attribute("EditorGenerated")
class(DestroyedMetalHangar) extends(BigHouse)
	var(name,"Руины");
	var(model,"a3\structures_f_enoch\industrial\farms\barn_04_ruins_f.p3d");
endclass