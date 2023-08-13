// ======================================================
// Copyright (c) 2017-2023 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\..\engine.hpp>
#include <..\..\..\oop.hpp>
#include <..\..\..\text.hpp>
#include <..\..\GameConstants.hpp>

//столб
editor_attribute("InterfaceClass")
editor_attribute("TemplatePrefab")
class(SmallPole) extends(Constructions) var(name,"Столб"); var(desc,"Небольшой столб"); endclass

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