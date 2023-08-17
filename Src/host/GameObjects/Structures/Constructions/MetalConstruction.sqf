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
class(MetalConstruction) extends(Constructions) var(name,"Стальная конструкция"); editor_only(var(desc,"Различные стальные конструкции");) endclass

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