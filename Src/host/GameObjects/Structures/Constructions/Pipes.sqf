// ======================================================
// Copyright (c) 2017-2023 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\..\engine.hpp>
#include <..\..\..\oop.hpp>
#include <..\..\..\text.hpp>
#include <..\..\GameConstants.hpp>

//труба
editor_attribute("InterfaceClass")
editor_attribute("TemplatePrefab")
class(BasicPipe) extends(Constructions) var(name,"Труба"); var(desc,"Обычная разрушаемая труба"); endclass

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