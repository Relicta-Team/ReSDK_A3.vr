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
class(SmallFloor) extends(Constructions) var(name,"Пол"); var(desc,"Обычное напольное покрытие"); endclass

editor_attribute("EditorGenerated")
class(Rail) extends(SmallFloor)
	var(model,"a3\structures_f_exp\industrial\port\cranerail_01_f.p3d");
	var(name, "Монорельс");
	var(desc, "Обветшалые рельсы");
endclass

class(ConcertePanel) extends(SmallFloor)
	var(name,"Бетонная плита");
	var(model,"a3\structures_f_enoch\infrastructure\roads\concretepanels_02_single_v1_f.p3d");
endclass