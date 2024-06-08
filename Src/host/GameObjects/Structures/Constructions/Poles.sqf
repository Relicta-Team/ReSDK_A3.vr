// ======================================================
// Copyright (c) 2017-2024 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\..\engine.hpp>
#include <..\..\..\oop.hpp>
#include <..\..\..\text.hpp>
#include <..\..\GameConstants.hpp>

//столб
editor_attribute("InterfaceClass")
editor_attribute("TemplatePrefab")
class(SmallPole) extends(Constructions) 
	var(name,"Столб"); 
	editor_only(var(desc,"Небольшой столб");)
	var(material,"MatBeton");
	var(dr,2);
endclass

editor_attribute("EditorGenerated")
class(ThickConcretePillarDestroyed) extends(SmallPole)
	var(model,"ml\ml_object_new\model_24\balka.p3d");
	var(name,"Бетон");
endclass

editor_attribute("EditorGenerated")
class(ThickLightConcreteColumn) extends(SmallPole)
	var(model,"ca\structures_e\wall\wall_l\wall_l1_pillar_ep1.p3d");
	var(name,"Бетонная колонна");
endclass

editor_attribute("EditorGenerated")
class(SmallWhiteConcretePillar) extends(SmallPole)
	var(model,"a3\structures_f_argo\walls\city\wallcity_01_pillar_yellow_f.p3d");
	var(name,"Белый бетонный столб");
endclass

editor_attribute("EditorGenerated")
class(SmallGrayPillar) extends(SmallPole)
	var(model,"a3\structures_f_exp\walls\wired\wiredfence_01_pole_45_f.p3d");
	var(name,"Маленький столб");
endclass
editor_attribute("EditorGenerated")
class(ConcreteLongPole) extends(SmallPole)
	var(model,"csa_constr\csa_obj\stolb_6m.p3d");
endclass