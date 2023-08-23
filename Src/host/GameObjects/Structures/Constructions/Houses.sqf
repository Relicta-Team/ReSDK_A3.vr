// ======================================================
// Copyright (c) 2017-2023 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\..\engine.hpp>
#include <..\..\..\oop.hpp>
#include <..\..\..\text.hpp>
#include <..\..\GameConstants.hpp>

//небольшое здание
editor_attribute("InterfaceClass")
editor_attribute("TemplatePrefab")
class(SmallHouse) extends(Constructions) var(name,"Небольшое здание"); editor_only(var(desc,"Маленькие дома" pcomma " которые можно разрушить");) endclass

editor_attribute("EditorGenerated")
class(MediumClothCanopy) extends(SmallHouse)
	var(model,"a3\structures_f_exp\commercial\market\clothshelter_02_f.p3d");
	var(name,"Навес");
endclass

editor_attribute("EditorGenerated")
class(MediumJunkShed) extends(SmallHouse)
	var(model,"a3\structures_f\households\addons\metal_shed_f.p3d");
	var(name,"Сарай");
endclass

editor_attribute("EditorGenerated")
class(MediumDestroyedCanopy) extends(SmallHouse)
	var(model,"a3\structures_f_exp\commercial\market\metalshelter_01_ruins_f.p3d");
	var(name,"Навес");
endclass

editor_attribute("EditorGenerated")
class(SmallClothShelter) extends(SmallHouse)
	var(model,"a3\structures_f_exp\commercial\market\clothshelter_01_f.p3d");
endclass

editor_attribute("EditorGenerated")
class(WoodenToiletSmall) extends(SmallHouse)
	var(model,"metro_ob\model\sartir_kabinka.p3d");
endclass

editor_attribute("EditorGenerated")
class(BetonGarageMedium) extends(SmallHouse)
	var(model,"a3\structures_f\households\addons\i_garage_v2_f.p3d");
	var(name,"Бетон");
endclass

editor_attribute("EditorGenerated")
class(SteelCanopy) extends(SmallHouse)
	var(model,"a3\structures_f_exp\civilian\sheds\shed_06_f.p3d");
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