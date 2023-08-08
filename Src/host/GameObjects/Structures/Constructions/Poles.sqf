// ======================================================
// Copyright (c) 2017-2023 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\..\engine.hpp>
#include <..\..\..\oop.hpp>
#include <..\..\..\text.hpp>
#include <..\..\GameConstants.hpp>

//столб
editor_attribute("InterfaceClass")
editor_attribute("TemplatePrefab")
class(SmallPole) extends(Constructions) var(name,"Столб"); var(desc,"Небольшой столб"); endclass
editor_attribute("EditorGenerated")
class(ConcreteLongPole) extends(SmallPole)
	var(model,"csa_constr\csa_obj\stolb_6m.p3d");
endclass