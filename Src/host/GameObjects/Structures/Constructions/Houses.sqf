// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\..\engine.hpp>
#include <..\..\..\oop.hpp>
#include <..\..\..\text.hpp>
#include <..\..\GameConstants.hpp>

//небольшое здание
editor_attribute("InterfaceClass")
editor_attribute("TemplatePrefab")
class(SmallHouse) extends(Constructions) 
	var(name,"Небольшое здание"); 
	editor_only(var(desc,"Маленькие дома" pcomma " которые можно разрушить");)
	var(material,"MatBeton");
	var(dr,4);
endclass

editor_attribute("EditorGenerated")
class(SmallBrickHouse) extends(SmallHouse)
	var(model,"ml_shabut\exodusss\domdiridom.p3d");
endclass

editor_attribute("EditorGenerated")
class(HouseWithGarageSmall) extends(SmallHouse)
	var(model,"a3\structures_f_argo\industrial\agriculture\shed_08_brown_f.p3d");
endclass

editor_attribute("EditorGenerated")
class(HouseWithGarageSmall1) extends(HouseWithGarageSmall)
	var(model,"a3\structures_f_argo\industrial\agriculture\shed_08_grey_f.p3d");
endclass

editor_attribute("EditorGenerated")
class(TwoStoreyHouseBalcony) extends(SmallHouse)
	var(model,"a3\structures_f\households\stone_big\i_stone_housebig_v2_dam_f.p3d");
endclass

editor_attribute("EditorGenerated")
class(TwoStoreyHouseBalcony1) extends(TwoStoreyHouseBalcony)
	var(model,"a3\structures_f\households\stone_big\i_stone_housebig_v1_dam_f.p3d");
endclass

editor_attribute("EditorGenerated")
class(Golovinskaya) extends(TwoStoreyHouseBalcony)
	var(model,"a3\structures_f\households\stone_big\d_stone_housebig_v1_f.p3d");
	var(name, "Разрушенная хибара");
endclass

editor_attribute("EditorGenerated")
class(LargeTwoStoreyStoneHouse) extends(TwoStoreyHouseBalcony)
	var(model,"a3\structures_f\households\stone_big\i_stone_housebig_v3_f.p3d");
	var(name,"Кирпичный дом");
endclass

editor_attribute("EditorGenerated")
class(MediumClothCanopy) extends(SmallHouse)
	var(model,"a3\structures_f_exp\commercial\market\clothshelter_02_f.p3d");
	var(name,"Навес");
	var(material,"MatCloth");
endclass

editor_attribute("EditorGenerated")
class(MediumJunkShed) extends(SmallHouse)
	var(model,"a3\structures_f\households\addons\metal_shed_f.p3d");
	var(name,"Сарай");
	var(material,"MatMetal");
endclass

editor_attribute("EditorGenerated")
class(MediumDestroyedCanopy) extends(SmallHouse)
	var(model,"a3\structures_f_exp\commercial\market\metalshelter_01_ruins_f.p3d");
	var(name,"Навес");
	var(material,"MatMetal");
endclass

editor_attribute("EditorGenerated")
class(SmallClothShelter) extends(SmallHouse)
	var(model,"a3\structures_f_exp\commercial\market\clothshelter_01_f.p3d");
	var(material,"MatCloth");
endclass

editor_attribute("EditorGenerated")
class(WoodenToiletSmall) extends(SmallHouse)
	var(model,"metro_ob\model\sartir_kabinka.p3d");
	var(material,"MatWood");
endclass

editor_attribute("EditorGenerated")
class(BetonGarageMedium) extends(SmallHouse)
	var(model,"a3\structures_f\households\addons\i_garage_v2_f.p3d");
	var(name,"Бетон");
endclass

editor_attribute("EditorGenerated")
class(SteelCanopy) extends(SmallHouse)
	var(model,"a3\structures_f_exp\civilian\sheds\shed_06_f.p3d");
	var(material,"MatMetal");
endclass

editor_attribute("EditorGenerated")
class(SteelCanopySmall1) extends(SteelCanopy)
	var(model,"a3\structures_f_exp\commercial\market\woodenshelter_01_f.p3d");
endclass

editor_attribute("EditorGenerated")
class(SteelCanopySmall) extends(SteelCanopy)
	var(model,"a3\structures_f\households\slum\cargo_addon01_v2_f.p3d");
endclass

editor_attribute("EditorGenerated")
class(ChurchSmallHouse) extends(SmallHouse)
	var(model,"a3\structures_f\civ\chapels\chapel_small_v2_f.p3d");
endclass

editor_attribute("EditorGenerated")
class(ChurchPrayHouse) extends(ChurchSmallHouse)
	var(model,"a3\structures_f_enoch\cultural\chapel_02\chapel_02_white_damaged_f.p3d");
endclass

editor_attribute("EditorGenerated")
class(SmallSheetMetalHouse) extends(SmallHouse)
	var(model,"a3\structures_f\households\slum\slum_house03_f.p3d");
	var(name, "Хижина");
	var(desc, "Сделана из дерева");
	var(material,"MatWood");
endclass

editor_attribute("EditorGenerated")
class(SmallSheetMetalHouse3) extends(SmallSheetMetalHouse)
	var(model,"ml_shabut\exodusss\budkapsinaebana.p3d");
endclass

editor_attribute("EditorGenerated")
class(SmallSheetMetalHouse1) extends(SmallSheetMetalHouse)
	var(model,"ml\ml_object_new\model_05\hata_4.p3d");
endclass
editor_attribute("EditorGenerated")
class(SmallSheetMetalHouse2) extends(SmallSheetMetalHouse)
	var(model,"a3\structures_f\households\slum\slum_house01_f.p3d");
endclass

editor_attribute("EditorGenerated")
class(MediumClayHouse) extends(SmallHouse)
	var(model,"ca\structures_e\housel\house_l_9_ep1.p3d");
	var(name,"Глиняный барак");
	var(material,"MatDirt");
endclass