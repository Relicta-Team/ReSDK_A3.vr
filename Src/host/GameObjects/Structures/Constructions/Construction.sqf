// ======================================================
// Copyright (c) 2017-2023 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\..\engine.hpp>
#include <..\..\..\oop.hpp>
#include <..\..\..\text.hpp>
#include <..\..\GameConstants.hpp>

//::конструкции
editor_attribute("InterfaceClass")
class(Constructions) extends(StructureBasicCategory) endclass


editor_attribute("InterfaceClass")
editor_attribute("TemplatePrefab")
class(FortificationConstruction) extends(Constructions) var(name,"Оборонительное сооружение"); var(desc,"Оборонные заграждения"); endclass
