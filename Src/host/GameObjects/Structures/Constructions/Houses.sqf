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