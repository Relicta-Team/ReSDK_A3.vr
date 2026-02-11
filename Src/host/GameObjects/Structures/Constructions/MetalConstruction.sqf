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
class(MetalConstruction) extends(Constructions) 
	var(name,"Стальная конструкция"); 
	editor_only(var(desc,"Различные стальные конструкции");)
	var(material,"MatMetal");
	var(dr,3);
endclass

editor_attribute("EditorGenerated")
class(SteamBarrel) extends(MetalConstruction)
	var(model,"ml_shabut\exodus\baloonexo.p3d");
	var(name,"Паровик");
endclass

editor_attribute("EditorGenerated")
class(ElectricalEngineDevice) extends(MetalConstruction)
	var(model,"ml\ml_germogate\l_02_alex_vorota_pult.p3d");
	var(name,"Оборудование");
endclass

editor_attribute("EditorGenerated")
class(ElectricalTransformer) extends(ElectricalEngineDevice)
	var(model,"a3\structures_f_exp\industrial\dieselpowerplant_01\dpp_01_transformer_f.p3d");
	var(name,"Трансформатор");
endclass

editor_attribute("EditorGenerated")
class(SmallRadiator) extends(MetalConstruction)
	var(model,"ml\ml_object_new\model_24\batareya.p3d");
	var(name,"Металлолом");
	var(desc,"Можно бы было сдать"" + pcomma + "" да не утащить..");
endclass

editor_attribute("EditorGenerated")
class(MetalFanSmall) extends(MetalConstruction)
	var(model,"metro_ob\model\vent_02.p3d");
endclass

editor_attribute("EditorGenerated")
class(MetalTruss) extends(MetalConstruction)
	var(model,"a3\structures_f\ind\pipes\indpipe2_big_18_f.p3d");
endclass

editor_attribute("EditorGenerated")
class(RustyTank) extends(MetalConstruction)
	var(model,"ca\buildings\misc\nasypka.p3d");
endclass

editor_attribute("EditorGenerated")
class(MetalTank) extends(RustyTank)
	var(model,"ca\misc_e\fuel_tank_stairs_ep1.p3d");
endclass

editor_attribute("EditorGenerated")
class(LongMetalBeams) extends(MetalConstruction)
	var(model,"ml\ml_object_new\ml_object_2\l01_props\l01_props_elevator_engine.p3d");
	var(name,"Стальная конструкция");
endclass

editor_attribute("EditorGenerated")
class(HighMetalConstruction) extends(MetalConstruction)
	var(model,"a3\structures_f_exp\industrial\sugarcanefactory_01\scf_01_conveyor_end_high_f.p3d");
	var(name,"Стальная конструкция");
endclass

editor_attribute("EditorGenerated")
class(BigVentilationTurbine) extends(MetalConstruction)
	var(model,"ml\ml_object_new\model_14_10\propeller.p3d");
	var(name,"Стальная конструкция");
endclass

editor_attribute("EditorGenerated")
class(BigIndustrialPipesWithLadder) extends(MetalTruss)
	var(model,"ca\structures_e\ind\ind_pipes\indpipe2_bigbuild2_l_ep1.p3d");
	var(name,"Руины");
endclass

editor_attribute("EditorGenerated")
class(IndustrialPipes) extends(MetalTruss)
	var(model,"a3\structures_f_enoch\industrial\pipes\indpipe3_big_18_f.p3d");
endclass