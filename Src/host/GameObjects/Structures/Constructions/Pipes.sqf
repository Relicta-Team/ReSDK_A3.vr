// ======================================================
// Copyright (c) 2017-2024 the ReSDK_A3 project
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
class(SmallDestroyedCornerPipe) extends(BasicPipe)
	var(model,"ca\buildings2\ind_pipeline\indpipe1\indpipe1_45degl.p3d");
	var(name,"Разрушенная труба");
endclass

editor_attribute("EditorGenerated")
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
class(MediumSteelUpperPipe) extends(BasicPipe)
	var(model,"a3\structures_f\ind\pipes\indpipe1_uup_f.p3d");
endclass

editor_attribute("EditorGenerated")
class(LongSteelPipe) extends(BasicPipe)
	var(model,"a3\structures_f\ind\pipes\indpipe1_20m_f.p3d");
endclass
editor_attribute("EditorGenerated")
class(BigConcretePipe) extends(BasicPipe)
	var(model,"ca\structures_e\misc\misc_construction\misc_concpipeline_ep1.p3d");
endclass