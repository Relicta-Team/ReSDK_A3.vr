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
class(TableBase) extends(Furniture) var(name,"Стол"); var(desc,"Просто стол"); endclass

editor_attribute("EditorGenerated")
class(SmallRoundWoodenTable) extends(TableBase)
	var(model,"ml_shabut\exodus\stolempire.p3d");
endclass

editor_attribute("EditorGenerated")
class(MediumWoodenTable) extends(TableBase)
	var(model,"a3\structures_f_epa\civ\camping\woodentable_large_f.p3d");
endclass