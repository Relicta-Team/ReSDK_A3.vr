// ======================================================
// Copyright (c) 2017-2023 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\..\engine.hpp>
#include <..\..\..\oop.hpp>
#include <..\..\GameConstants.hpp>

// Столы
editor_attribute("InterfaceClass")
editor_attribute("TemplatePrefab")
class(TableBase) extends(Furniture) var(name,"Стол"); editor_only(var(desc,"Просто стол");) endclass

editor_attribute("EditorGenerated")
class(WoodenTableHandmade) extends(TableBase)
	var(model,"a3\props_f_exp\commercial\market\woodencounter_01_f.p3d");
endclass

editor_attribute("EditorGenerated")
class(SmallSteelTable) extends(TableBase)
	var(model,"ca\misc2\smalltable\smalltable.p3d");
endclass

editor_attribute("EditorGenerated")
class(SurgeryBlueTable) extends(TableBase)
	var(model,"ml_shabut\autopsy\autopsy.p3d");
endclass

editor_attribute("EditorGenerated")
class(WoodenOfficeTable) extends(TableBase)
	var(model,"ca\misc2\desk\desk.p3d");
endclass

editor_attribute("EditorGenerated")
class(WoodenOfficeTable3) extends(WoodenOfficeTable)
	var(model,"ca\structures\furniture\tables\conference_table_a\conference_table_a.p3d");
endclass

editor_attribute("EditorGenerated")
class(WoodenOfficeTable2) extends(WoodenOfficeTable)
	var(model,"a3\structures_f_heli\furniture\officetable_01_f.p3d");
endclass

editor_attribute("EditorGenerated")
class(TinyWoodenTable) extends(TableBase)
	var(model,"a3\props_f_orange\furniture\tablesmall_01_f.p3d");
endclass

editor_attribute("EditorGenerated")
class(SmallWoodenTableHandmade) extends(TableBase)
	var(model,"metro_ob\model\table_nastil_1.p3d");
endclass

editor_attribute("EditorGenerated")
class(SmallRoundWoodenTable) extends(TableBase)
	var(model,"ml_shabut\exodus\stolempire.p3d");
endclass

editor_attribute("EditorGenerated")
class(MediumWoodenTable) extends(TableBase)
	var(model,"a3\structures_f_epa\civ\camping\woodentable_large_f.p3d");
endclass
editor_attribute("EditorGenerated")
class(SmallWoodenTable) extends(MediumWoodenTable)
	var(model,"a3\structures_f_epa\civ\camping\woodentable_small_f.p3d");
endclass