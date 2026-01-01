// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\..\engine.hpp>
#include <..\..\..\oop.hpp>
#include <..\..\..\text.hpp>
#include <..\..\GameConstants.hpp>

//::конструкции
editor_attribute("InterfaceClass")
class(Constructions) extends(StructureBasicCategory) 
	var(material,"MatBeton");
	var(dr,3);
endclass


editor_attribute("InterfaceClass")
editor_attribute("TemplatePrefab")
class(FortificationConstruction) extends(Constructions) var(name,"Оборонительное сооружение"); editor_only(var(desc,"Оборонные заграждения");) endclass

editor_attribute("EditorGenerated")
class(ConcreteTreePlanter) extends(FortificationConstruction)
	var(model,"a3\structures_f_enoch\civilian\accessories\concretetreeplanter_01_f.p3d");
endclass

editor_attribute("EditorGenerated")
class(ConcreteSlabsStack) extends(FortificationConstruction)
	var(model,"ca\buildings2\misc_concrete\misc_concrete_high.p3d");
	var(name,"Бетон");
endclass

editor_attribute("EditorGenerated")
class(ConcreteCircleReinforcement) extends(FortificationConstruction)
	var(model,"a3\structures_f_enoch\military\training\target_concrete_01_v1_f.p3d");
endclass

editor_attribute("EditorGenerated")
class(SmallConcreteBlockDestyoed) extends(FortificationConstruction)
	var(model,"ml\ml_object_new\model_24\barikada_1.p3d");
	var(name,"Бетон");
endclass

editor_attribute("EditorGenerated")
class(MediumConcreteBlockDestroyed) extends(FortificationConstruction)
	var(model,"ml_shabut\stalker_props\stalkerblock.p3d");
	var(name,"Бетон");
endclass

editor_attribute("EditorGenerated")
class(BetonTrapeciaSmall) extends(FortificationConstruction)
	var(name,"Бетонное сооружение");	
	var(desc, null);
	var(model,"a3\structures_f_enoch\military\training\target_concrete_support_01_f.p3d");
endclass