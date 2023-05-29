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

class(ConcertePanel) extends(SmallFloor)
	var(name,"Бетонная плита");
	var(model,"a3\structures_f_enoch\infrastructure\roads\concretepanels_02_single_v1_f.p3d");
endclass