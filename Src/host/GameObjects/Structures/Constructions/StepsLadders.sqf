// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\..\engine.hpp>
#include <..\..\..\oop.hpp>
#include <..\..\..\text.hpp>
#include <..\..\GameConstants.hpp>

//лестница
editor_attribute("InterfaceClass")
editor_attribute("TemplatePrefab")
class(StepsLadder) extends(Constructions) 
	var(name,"Лестница"); 
	editor_only(var(desc,"Ступенчатые лестницы");)
	var(material,"MatMetal");
	var(dr,3);
endclass

editor_attribute("EditorGenerated")
class(LongWoodenLadder) extends(StepsLadder)
	var(model,"ca\structures\nav_boathouse\nav_boathouse_pierl.p3d");
	var(material,"MatWood");
endclass

editor_attribute("EditorGenerated")
class(SmallSteelRustyStairs) extends(StepsLadder)
	var(model,"ml\ml_object_new\ml_object_2\l01_props\stair01.p3d");
endclass

editor_attribute("EditorGenerated")
class(StoneSmallPandus) extends(StepsLadder)
	var(model,"csa_constr\csa_obj\pand_3x6.p3d");
	var(material,"MatBeton");
endclass

editor_attribute("EditorGenerated")
class(ScaffoldingLadder) extends(StepsLadder)
	var(model,"ca\structures\misc\misc_scaffolding\misc_scaffolding.p3d");
	var(material,"MatWood");
endclass

editor_attribute("EditorGenerated")
class(BigWoodenLadder) extends(ScaffoldingLadder)
	var(model,"ca\structures\castle\a_castle_stairs_a.p3d");
	var(material,"MatWood");
endclass

editor_attribute("EditorGenerated")
class(SteelSmallLadder) extends(StepsLadder)
	var(model,"metro_ob\model\vag_wash4_p1.p3d");
endclass

editor_attribute("EditorGenerated")
class(SteelSmallDoubleLadder) extends(StepsLadder)
	var(model,"ml\ml_object_new\model_24\most.p3d");
endclass

editor_attribute("EditorGenerated")
class(StoneBigPandus) extends(StepsLadder)
	var(model,"csa_constr\csa_obj\pand_6x6.p3d");
	var(material,"MatBeton");
endclass

editor_attribute("EditorGenerated")
class(StoneBigLadderDouble) extends(StepsLadder)
	var(model,"csa_constr\csa_obj\lest_kletka.p3d");
	var(material,"MatBeton");
endclass

editor_attribute("EditorGenerated")
class(SteelRustyStairs) extends(StepsLadder)
	var(model,"ml\ml_object_new\ml_object_2\l01_props\stair.p3d");
	var(name,"Стальная лестница");
endclass

editor_attribute("EditorGenerated")
class(StoneSmallLadder) extends(StepsLadder)
	var(model,"csa_constr\csa_obj\lest_pod_2x4.p3d");
	var(name,"Ступеньки");
	var(material,"MatBeton");
endclass