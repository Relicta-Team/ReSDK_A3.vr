// ======================================================
// Copyright (c) 2017-2023 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\..\engine.hpp>
#include <..\..\..\oop.hpp>
#include <..\..\..\text.hpp>
#include <..\..\GameConstants.hpp>

//небольшое здание
editor_attribute("InterfaceClass")
editor_attribute("TemplatePrefab")
class(SmallHouse) extends(Constructions) var(name,"Небольшое здание"); var(desc,"Маленькие дома" pcomma " которые можно разрушить"); endclass
editor_attribute("EditorGenerated")
class(LittleHouseBomj) extends(SmallHouse)
	var(model,"a3\structures_f\households\slum\slum_house03_f.p3d");
	var(name, "Хижина");
	var(desc, "Сделана из дерева");
endclass