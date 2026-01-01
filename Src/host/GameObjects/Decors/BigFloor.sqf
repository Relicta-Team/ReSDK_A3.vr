// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\engine.hpp>
#include <..\..\oop.hpp>
#include <..\..\text.hpp>

editor_attribute("InterfaceClass")
editor_attribute("TemplatePrefab")
class(BigFloor) extends(BigConstructions) 
	var(name,"Пол"); 
	var(desc,"Напольное покрытие");
	var(material,"MatBeton");
endclass

editor_attribute("EditorGenerated")
class(BigConcreteFloor) extends(BigFloor)
	var(model,"ca\structures\rail\rail_misc\rail_najazdovarampa.p3d");
endclass