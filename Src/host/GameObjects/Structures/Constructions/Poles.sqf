// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
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
class(StonePole) extends(SmallPole)
	var(model,"a3\structures_f_exp\cultural\basaltruins\basaltkerb_01_2m_f.p3d");
endclass

editor_attribute("EditorGenerated")
class(WoodPole) extends(SmallPole)
	var(name,"Позорник");
	var(desc,"Чтобы на нём оказаться - много ума не надо!");
	var(model,"ca\structures\ruins\rubble_wood_girder.p3d");
	var(material,"MatWood");
endclass

editor_attribute("EditorGenerated")
class(WoodPole1) extends(WoodPole)
	var(model,"a3\structures_f_exp\walls\polewalls\polewall_01_pole_f.p3d");
endclass

class(TimberLog) extends(WoodPole)
	var(model,"a3\structures_f_enoch\industrial\materials\timberlog_04_f.p3d");
endclass

editor_attribute("EditorGenerated")
class(WoodCross) extends(SmallPole)
	var(name,"Крест");
	var(desc,"Здесь людей вешают! И очень даже неплохо!");
	var(model,"a3\structures_f_enoch\cultural\cemeteries\tombstone_13_f.p3d");
	var(material,"MatWood");
endclass

editor_attribute("EditorGenerated")
class(Gallows) extends(SmallPole)
	var(name,"Вешалка");
	var(desc,"С неё начинается театр");
	var(model,"relicta_models2\small_constructions\s_gallows\s_gallows.p3d");
	var(material,"MatWood");
endclass

editor_attribute("EditorGenerated")
class(ElectricPole) extends(SmallPole)
	var(model,"a3\structures_f_exp\infrastructure\powerlines\powerline_01_pole_small_f.p3d");
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

editor_attribute("EditorGenerated")
class(ConcretePole) extends(ConcreteLongPole)
	var(model,"ca\structures\wall\wall_indcnc_pole.p3d");
endclass

editor_attribute("EditorGenerated")
class(MediumLightConcretePole) extends(ConcreteLongPole)
	var(model,"a3\structures_f_argo\walls\city\wallcity_01_pillar_grey_f.p3d");
endclass

class(BrickPole) extends(SmallPole)
	var(model,"a3\structures_f_enoch\walls\brick\brickwall_03_l_pole_f.p3d");
endclass

class(BrickPole1) extends(BrickPole)
	var(model,"a3\structures_f_enoch\walls\brick\brickwall_04_l_pole_f.p3d");
endclass

class(BrickPole2) extends(BrickPole)
	var(model,"a3\structures_f_enoch\walls\brick\brickwall_01_l_pole_f.p3d");
endclass

