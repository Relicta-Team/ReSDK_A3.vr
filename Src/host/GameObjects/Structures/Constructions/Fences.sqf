// ======================================================
// Copyright (c) 2017-2023 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\..\engine.hpp>
#include <..\..\..\oop.hpp>
#include <..\..\..\text.hpp>
#include <..\..\GameConstants.hpp>

//забор
editor_attribute("InterfaceClass")
editor_attribute("TemplatePrefab")
class(SmallFence) extends(Constructions) var(name,"Ограда"); var(desc,"Небольшие заборы и ограды" pcomma " которые можно разрушить"); endclass

editor_attribute("EditorGenerated")
class(SmallCornerFenceMadeOfJunk) extends(SmallFence)
	var(model,"ml_shabut\ferrum\xlamfence2.p3d");
	var(name,"Забор");
endclass

editor_attribute("EditorGenerated")
class(MediumFenceOfSheetsAndBoards) extends(SmallFence)
	var(model,"ml_shabut\stalker_props\woodbyatch.p3d");
	var(name,"Ограда из мусора");
endclass

editor_attribute("EditorGenerated")
class(SmallFenceMadeOfSticks) extends(SmallFence)
	var(model,"a3\structures_f_enoch\walls\polewalls\polewall_02_3m_v2_f.p3d");
	var(name,"Ограда");
endclass

editor_attribute("EditorGenerated")
class(SmallGridWithWoodenFrame) extends(SmallFence)
	var(model,"a3\structures_f_enoch\walls\net\gameprooffence_01_l_gate_f.p3d");
	var(name,"Решётка с деревянной рамой");
endclass

editor_attribute("EditorGenerated")
class(RustyCell) extends(SmallFence)
	var(model,"ml_shabut\exodus\kaleetka.p3d");
endclass

editor_attribute("EditorGenerated")
class(WoodenSmallFence) extends(SmallFence)
	var(model,"ml\ml_object_new\model_05\zabori.p3d");
endclass

editor_attribute("EditorGenerated")
class(LuxuryRedCurtain) extends(SmallFence)
	var(model,"ml\ml_object_new\shabbat\shtora_pravo.p3d");
endclass

editor_attribute("EditorGenerated")
class(OldGraveFence4) extends(SmallFence)
	var(model,"a3\structures_f_enoch\cultural\cemeteries\gravefence_04_f.p3d");
endclass

editor_attribute("EditorGenerated")
class(OldGraveFence3) extends(SmallFence)
	var(model,"a3\structures_f_enoch\cultural\cemeteries\gravefence_01_f.p3d");
endclass

editor_attribute("EditorGenerated")
class(OldGraveFence2) extends(SmallFence)
	var(model,"a3\structures_f_enoch\cultural\cemeteries\gravefence_02_f.p3d");
endclass

editor_attribute("EditorGenerated")
class(OldGraveFence) extends(SmallFence)
	var(model,"a3\structures_f_enoch\cultural\cemeteries\gravefence_03_f.p3d");
endclass

editor_attribute("EditorGenerated")
class(SmallSteelRustyFence) extends(SmallFence)
	var(model,"metro_ob\model\fence01.p3d");
endclass

editor_attribute("EditorGenerated")
class(TinFence) extends(SmallFence)
	var(model,"a3\structures_f_exp\walls\tin\tinwall_01_m_4m_v1_f.p3d");
endclass

editor_attribute("EditorGenerated")
class(TinBigFence) extends(TinFence)
	var(model,"a3\structures_f_exp\walls\tin\tinwall_01_m_4m_v2_f.p3d");
endclass
editor_attribute("EditorGenerated")
class(MedicalCurtainSmall) extends(SmallFence)
	var(model,"ml_shabut\exoduss\medzanaves2.p3d");
	var(name,"Ширма");
endclass