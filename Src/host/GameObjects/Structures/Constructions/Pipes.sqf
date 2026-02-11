// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\..\engine.hpp>
#include <..\..\..\oop.hpp>
#include <..\..\..\text.hpp>
#include <..\..\GameConstants.hpp>

//труба
editor_attribute("InterfaceClass")
editor_attribute("TemplatePrefab")
class(BasicPipe) extends(Constructions) 
	var(name,"Труба"); 
	editor_only(var(desc,"Обычная разрушаемая труба");)
	var(material,"MatMetal");
	var(dr,2);
endclass

//Ржавые Индустриальные трубы (Коллекция похожих объектов)
class(IndPipeGround) extends(BasicPipe)
	var(model,"ca\buildings2\ind_pipeline\indpipe1\indpipe1_ground.p3d");
endclass

class(IndPipeGround2) extends(IndPipeGround)
	var(model,"ca\buildings2\ind_pipeline\indpipe1\indpipe1_ground2.p3d");
endclass

class(IndPipe90degR) extends(IndPipeGround)
	var(model,"ca\buildings2\ind_pipeline\indpipe1\indpipe1_90degr.p3d");
endclass

class(IndPipe90DegL) extends(IndPipeGround)
	var(model,"ca\buildings2\ind_pipeline\indpipe1\indpipe1_90degl.p3d");
endclass

class(IndPipe45DegL) extends(IndPipeGround)
	var(model,"ca\buildings2\ind_pipeline\indpipe1\indpipe1_45degl.p3d");
endclass

class(IndPipe45DegR) extends(IndPipeGround)
	var(model,"ca\buildings2\ind_pipeline\indpipe1\indpipe1_45degr.p3d");
endclass

class(IndPipeBroken) extends(IndPipeGround)
	var(model,"ca\buildings2\ind_pipeline\indpipe1\indpipe1_broken.p3d");
endclass

class(IndPipeValve) extends(IndPipeGround)
	var(model,"ca\buildings2\ind_pipeline\indpipe1\indpipe1_valve.p3d");
endclass

class(IndPipeStair) extends(IndPipeGround)
	var(model,"ca\buildings2\ind_pipeline\indpipe1\indpipe1_stair.p3d");
endclass

class(IndPipeUR) extends(IndPipeGround)
	var(model,"ca\buildings2\ind_pipeline\indpipe1\indpipe1_ur.p3d");
endclass

class(IndPipeUUP) extends(IndPipeGround)
	var(model,"ca\buildings2\ind_pipeline\indpipe1\indpipe1_uup.p3d");
endclass

class(IndPipeUL) extends(IndPipeGround)
	var(model,"ca\buildings2\ind_pipeline\indpipe1\indpipe1_ul.p3d");
endclass

class(IndPipe20m) extends(IndPipeGround)
	var(model,"ca\buildings2\ind_pipeline\indpipe1\indpipe1_20m.p3d");
endclass

//Индустриальные трубы (Коллекция похожих объектов)
class(NewIndPipeGround) extends(BasicPipe)
	var(model,"a3\structures_f\ind\pipes\indpipe1_ground_f.p3d");
endclass

class(NewIndPipe90DegL) extends(NewIndPipeGround)
	var(model,"a3\structures_f\ind\pipes\indpipe1_90degl_f.p3d");
endclass

class(NewIndPipe90DegR) extends(NewIndPipeGround)
	var(model,"a3\structures_f\ind\pipes\indpipe1_90degr_f.p3d");
endclass

class(NewIndPipeValve) extends(NewIndPipeGround)
	var(model,"a3\structures_f\ind\pipes\indpipe1_valve_f.p3d");
endclass

class(NewIndPipeUUP) extends(NewIndPipeGround)
	var(model,"a3\structures_f\ind\pipes\indpipe1_uup_f.p3d");
endclass

class(NewIndPipe20m) extends(NewIndPipeGround)
	var(model,"a3\structures_f\ind\pipes\indpipe1_20m_f.p3d");
endclass

//Остальное
editor_attribute("EditorGenerated")
class(DestroyedPipeMedium) extends(BasicPipe)
	var(model,"ca\buildings2\ind_cementworks\ind_malykomin\ind_malykomin_ruins.p3d");
endclass

editor_attribute("EditorGenerated")
class(ShortPipeBlueMetal) extends(BasicPipe)
	var(model,"ml_shabut\exodusss\trubaduba1.p3d");
	var(name,"Труба");
endclass

editor_attribute("EditorGenerated")
class(MediumPieceSuspendedPipe) extends(BasicPipe)
	var(model,"ml\ml_object_new\shabbat\trooobaba2.p3d");
	var(name,"Труба");
endclass

editor_attribute("EditorGenerated")
class(BigPilePipes) extends(BasicPipe)
	var(model,"a3\structures_f\civ\constructions\ironpipes_f.p3d");
	var(name,"Трубы");
endclass

editor_attribute("EditorGenerated")
class(PipeCutOnSupportingStructure) extends(BasicPipe)
	var(model,"a3\structures_f_exp\industrial\sugarcanefactory_01\scf_01_pipe_8m_high_f.p3d");
	var(name,"Труба");
endclass

editor_attribute("EditorGenerated")
editor_attribute("Deprecated" arg "Заменить на IndPipe45DegL.")
class(SmallDestroyedCornerPipe) extends(BasicPipe)
	var(model,"ca\buildings2\ind_pipeline\indpipe1\indpipe1_45degl.p3d");
	var(name,"Разрушенная труба");
endclass

editor_attribute("EditorGenerated")
editor_attribute("Deprecated" arg "Заменить на NewIndPipe90DegR.")
class(SmallDestoyedCornerPipe1) extends(SmallDestroyedCornerPipe)
	var(model,"a3\structures_f\ind\pipes\indpipe1_90degr_f.p3d");
endclass

editor_attribute("EditorGenerated")
editor_attribute("Deprecated" arg "Заменить на IndPipeValve.")
class(MediumRuinedPipe) extends(BasicPipe)
	var(model,"ca\buildings2\ind_pipeline\indpipe1\indpipe1_valve.p3d");
	var(name,"Разрушенная труба");
endclass

editor_attribute("EditorGenerated")
class(LongDestroyedPipeWithSupportingStructure) extends(BasicPipe)
	var(model,"a3\structures_f_exp\industrial\sugarcanefactory_01\scf_01_pipe_24m_f.p3d");
	var(name,"Разрушенная труба");
endclass

editor_attribute("EditorGenerated")
class(LargeDestroyedVerticalPipe) extends(BasicPipe)
	var(model,"a3\structures_f_exp\industrial\sugarcanefactory_01\scf_01_pipe_up_f.p3d");
	var(name,"Разрушенная труба");
endclass

editor_attribute("EditorGenerated")
class(DestroyedPipeWithValve) extends(BasicPipe)
	var(model,"a3\structures_f_exp\industrial\sugarcanefactory_01\scf_01_pipe_end_f.p3d");
	var(name,"Разрушенная труба с вентилем");
endclass

editor_attribute("EditorGenerated")
class(SmallConcretePipe) extends(BasicPipe)
	var(model,"ca\structures_e\misc\misc_construction\misc_concoutlet_ep1.p3d");
endclass

editor_attribute("EditorGenerated")
editor_attribute("Deprecated" arg "Заменить на NewIndPipeUUP.")
class(MediumSteelUpperPipe) extends(BasicPipe)
	var(model,"a3\structures_f\ind\pipes\indpipe1_uup_f.p3d");
endclass

editor_attribute("EditorGenerated")
editor_attribute("Deprecated" arg "Заменить на NewIndPipe20m.")
class(LongSteelPipe) extends(BasicPipe)
	var(model,"a3\structures_f\ind\pipes\indpipe1_20m_f.p3d");
endclass
editor_attribute("EditorGenerated")
class(BigConcretePipe) extends(BasicPipe)
	var(model,"ca\structures_e\misc\misc_construction\misc_concpipeline_ep1.p3d");
endclass