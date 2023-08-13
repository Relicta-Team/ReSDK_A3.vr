// ======================================================
// Copyright (c) 2017-2023 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\..\engine.hpp>
#include <..\..\..\oop.hpp>
#include <..\..\..\text.hpp>
#include <..\..\GameConstants.hpp>

//мусор
editor_attribute("InterfaceClass")
editor_attribute("TemplatePrefab")
class(SmallGarbage) extends(Constructions) var(name,"Куча мусора"); var(desc,"Небольшая куча мусора"); endclass
editor_attribute("EditorGenerated")
class(BigPileBurntGarbage) extends(SmallGarbage)
	var(model,"a3\props_f_enoch\military\garbage\burntgarbage_01_f.p3d");
	var(name,"Куча мусора");
endclass