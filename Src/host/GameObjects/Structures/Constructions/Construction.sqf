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

editor_attribute("EditorGenerated")
class(BetonTrapeciaSmall) extends(FortificationConstruction)
	var(name,"Бетонное сооружение");	
	var(model,"a3\structures_f_enoch\military\training\target_concrete_support_01_f.p3d");
endclass