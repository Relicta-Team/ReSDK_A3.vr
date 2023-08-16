// ======================================================
// Copyright (c) 2017-2023 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\..\engine.hpp>
#include <..\..\..\oop.hpp>
#include <..\..\..\text.hpp>
#include <..\..\GameConstants.hpp>

//пол
editor_attribute("InterfaceClass")
editor_attribute("TemplatePrefab")
class(RailBase) extends(Constructions) var(name,"Рельсы"); var(desc,"Рельсы"); endclass
editor_attribute("EditorGenerated")
class(LongStraightRails) extends(RailBase)
	var(model,"ml\ml_object\l03_camp_1\l03_camp_rails_03.p3d");
	var(name,"Рельсы");
endclass