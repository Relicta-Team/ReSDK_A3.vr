// ======================================================
// Copyright (c) 2017-2024 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\engine.hpp>
#include <..\..\oop.hpp>
#include <..\..\text.hpp>

//большие стены
editor_attribute("InterfaceClass")
editor_attribute("TemplatePrefab")
class(BigWall) extends(BigConstructions) 
	var(name,"Большая стена"); 
	var(material,"MatStone");
	editor_only(var(desc,"Огромная стена выполняющая роль ограничения доступной зоны. Не разрушаема");)
endclass

editor_attribute("EditorGenerated")
class(StoneArch) extends(BigWall)
	var(model,"ca\structures\castle\a_castle_gate.p3d");
	var(name,"Большая стена");
endclass

editor_attribute("EditorGenerated")
class(ConcreteArch) extends(BigWall)
	var(model,"ml\ml_object\l04_catacombs\l04_catacombs_00.p3d");
endclass


editor_attribute("EditorGenerated")
class(BigStoneWall) extends(BigWall)
	var(model,"ca\structures\castle\a_castle_wall1_20.p3d");
	var(desc, "Огромная каменная стена" pcomma " покрытая мхом");
endclass
editor_attribute("EditorGenerated")
class(BigStoneWall1) extends(BigStoneWall)
	var(model,"ca\structures\castle\a_castle_wall1_end_2.p3d");
endclass